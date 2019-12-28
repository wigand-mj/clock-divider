library IEEE;
use IEEE.STD_LOGIC_1164.All;
use IEEE.NUMERIC_STD.All;
--use IEEE.STD_LOGIC_ARITH.All;
--use IEEE.STD_LOGIC_UNSIGNED.All;

entity clock_divider is

    port (
            CLK_IN 				: in std_logic; -- 50MHz
	    DVD_FACTOR, HZ, MAGNITUDE		: in integer; -- Magnitude: 1 for e0, 1000 for e-6 etc...
            CLK_OUT 				: out std_logic; -- 1 Hz - 0.5s ON and 0.5s OFF
	    nRST 				: in std_logic := '0'
        );

end clock_divider;

architecture rtl of clock_divider is

    signal Counter 	: integer range 0 to (50000000) := 0; -- 50000000 maximum HZ
  --signal Counter 	: integer := 0; -- when MAX HZ unknown in compilation time
    signal DVD_CLK 	: std_logic := '0';

begin


        Prescaler : process(CLK_IN) 
		  begin
			if nRST = '0' then
				if counter /= 0 then
					counter <= 0;
				end if;
			else
					if rising_edge(CLK_IN) then
					
						 if Counter < (HZ) then
						 
							  Counter <= Counter + (DVD_FACTOR*MAGNITUDE);
							  
						 else
						 
							  DVD_CLK <= not DVD_CLK;
							  Counter <= 0;
							  
						 end if;

					end if;
			end if;
        end process Prescaler;  

        CLK_OUT <= DVD_CLK;

end rtl;



-- Instance in top-level entity as:

 --i_CLOCK : entity work.clock_divider(rtl) port map (
 -- 
 --       CLK_IN  => CLK,
 --       CLK_OUT => CLK_1MHz
 --		 ...
 --		  
 --   );
