Return-Path: <dgaur@cdotd.ernet.in>
Received: from sandesh.cdotd.ernet.in (sandesh.cdotd.ernet.in [196.1.105.47])
	by ozlabs.org (Postfix) with ESMTP id B9CADDDFF4
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 17:11:54 +1000 (EST)
From: "Deepak Gaur" <dgaur@cdotd.ernet.in>
To: linuxppc-dev@ozlabs.org,
	u-boot@lists.denx.de
Subject: Does U-BOOT (MPC8560) support Micron MT18VDD12872DG
Date: Thu, 14 May 2009 12:53:14 +0530
Message-Id: <20090514070132.M24973@cdotd.ernet.in>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

I have a custom board similar to MPC8560ADS board with 1GB DDR SDRAM. The DDR SDRAM Make
is MT18VDDF12872DG-335D3. In U-BOOT (2009.01) config file I have enabled CONFIG_SPD_EEPROM
so U-boot configures MPC8560ADS DDR controller with the values read from SPD_EEPROM (i2c
address 0x51) 

After card reset U-BOOT runs from BOOT Flash and debug prints start coming on SCC1 port
But after configuring the MPC8560 DDR controller the U-BOOT HANGS when it tries to run
from RAM locations after relocation from BOOT Flash. 

Somewhere I read that it is due to failure of Burst Mode access of RAM. But DDR SDRAM 
inherently work in Burst Mode only. Moreover U-BBOT  initialized the DDR SDRAM Mode
config register using SPD EEPROM values . The value indicate that SDRAM is in Burst Mode

MPC8560 CPU Version is 2.0.2

Please help in understanding the issue here

The U-BOOT Details are
-----------------------------------------------------------------------------------------
U-Boot 2009.01 (Apr 27 2009 - 14:17:09)


CPU:   8560, Version: 2.0, (0x80700020)
Core:  E500, Version: 2.0, (0x80200020)
Clock Configuration:
       CPU:660  MHz, CCB:264  MHz,
       DDR:132  MHz (264 MT/s data rate), LBC:66   MHz
CPM:   264 MHz
L1:    D-cache 32 kB enabled
       I-cache 32 kB enabled
Board: ADS
    PCI1: 32 bit, 33 MHz (compiled)
I2C:   ready
DRAM:  Initializing
SDRAM SPD EEPROM
starting at step 1 (STEP_GET_SPD)

 MEM TYPE 0x7DDR: DDR I rank density = 0x20000000
mclk_ps = 7580
i=0, x = 0, lowest_tCKmin_found = 0
i=1, x = 7500, lowest_tCKmin_found = 0
i=2, x = 6000, lowest_tCKmin_found = 7500
i=3, x = 5000, lowest_tCKmin_found = 7500
lowest_tCKmin_CL = 2
Computing lowest common DIMM parameters for memctl=0
using mclk_ps = 7580
checking common caslat = 3
CL = 3 ok on DIMM 0 at tCK=7580 ps with its tCKmin_X_ps of 6000
checking common caslat = 2
CL = 2 ok on DIMM 0 at tCK=7580 ps with its tCKmin_X_minus_1_ps of 7500
lowest common SPD-defined CAS latency = 2
highest common dereated CAS latency = 2
all DIMMs ECC capable
Reloading memory controller configuration options for memctl=0
mclk_ps = 7580 ps
FSL Memory ctrl cg register computation
FSLDDR: cs[0]_bnds = 0x0000001f
FSLDDR: cs[0]_config = 0x80010103
FSLDDR: cs[0]_config_2 = 0x00000000
FSLDDR: cs[1]_bnds = 0x0020003f
FSLDDR: cs[1]_config = 0x80010103
FSLDDR: cs[1]_config_2 = 0x00000000
FSLDDR: timing_cfg_3 = 0x00000000
FSLDDR: timing_cfg_1 = 0x36332422
FSLDDR: timing_cfg_2 = 0x00006482
FSLDDR: ddr_sdram_cfg = 0xe2000000
FSLDDR: ddr_sdram_cfg_2 = 0x20401000
FSLDDR: ddr_sdram_mode = 0x00000022
FSLDDR: ddr_sdram_mode_2 = 0x00000000
FSLDDR: ddr_sdram_interval = 0x04060100
FSLDDR: timing_cfg_4 = 0x00000000
FSLDDR: timing_cfg_5 = 0x00000000

...
...
Some stack location related prints 
...
<hangs> here   <---- checked with emulator its somewhere in RAM but no prints coming

---------------------------------------------------------------------------------------
The SPD EEROM Data for this Module is given on Micron's website

http://www.micron.com/products/spddetail?part=MT18VDDF12872DG-335D3
---------------------------------------------------------------------------------------

with warm regards,

Deepak Gaur
