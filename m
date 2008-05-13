Return-Path: <Sellsa@ZIN-TECH.COM>
Received: from zinexc.ZIN.NET (ramp034-158.rampant.com [64.28.34.158])
	by ozlabs.org (Postfix) with ESMTP id AB7DCDDF50
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 May 2008 01:13:23 +1000 (EST)
Message-ID: <4829AFD9.30809@zin-tech.com>
Date: Tue, 13 May 2008 11:12:25 -0400
From: Aaron Sells <aaron.sells@zin-tech.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Xilinx ML403 I2C Problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I am having troubles accessing the eeprom on our Xilinx ML403 board.  It 
is running an up to date kernel pulled from the git.xilinx.com tree.  I 
am running an OpenEmbedded file system.  I am using I2C Tools 
[http://www.lm-sensors.org/wiki/I2CTools] to probe the I2C bus.  I am 
using Xilinx EDK 10.1 and the base system builder wizard to generate my 
bitstream.  The following are I2C related messages during bootup:

> root@xilinx-ml403:~# dmesg | grep i[i2]c
> [    0.126379] Registering device xilinx_iic:0
> [    0.186921] i2c-core: driver [dummy] registered
> [   11.729656] i2c /dev entries driver
> [   11.770185] i2c-core: driver [dev_driver] registered
> [   11.772527] i2c-core: driver [eeprom] registered
> [   11.772951] I2C adapter driver [xilinx_iic.0] forgot to specify physical device
> [   11.774135] i2c-adapter i2c-0: adapter [xilinx_iic.0] registered
> [   11.775475] i2c-dev: adapter [xilinx_iic.0] registered as minor 0
> [   11.775569] i2c-adapter i2c-0: found normal entry for adapter 0, addr 0x50
> [   11.775640] i2c-adapter i2c-0: master_xfer[0] W, addr=0x50, len=0
> [   11.775710] i2c-adapter i2c-0: master_xfer[0] W, addr=0x50, len=0
> [   11.776245] i2c-adapter i2c-0: client [eeprom] registered with bus id 0-0050
> [   11.776364] i2c-adapter i2c-0: found normal entry for adapter 0, addr 0x51
> [   11.776441] i2c-adapter i2c-0: master_xfer[0] W, addr=0x51, len=0
> [   11.776510] i2c-adapter i2c-0: master_xfer[0] W, addr=0x51, len=0
> [   11.776847] i2c-adapter i2c-0: client [eeprom] registered with bus id 0-0051
> [   11.776957] i2c-adapter i2c-0: found normal entry for adapter 0, addr 0x52
> [   11.777034] i2c-adapter i2c-0: master_xfer[0] W, addr=0x52, len=0
> [   11.777102] i2c-adapter i2c-0: master_xfer[0] W, addr=0x52, len=0
> [   11.777414] i2c-adapter i2c-0: client [eeprom] registered with bus id 0-0052
> [   11.777526] i2c-adapter i2c-0: found normal entry for adapter 0, addr 0x53
> [   11.777603] i2c-adapter i2c-0: master_xfer[0] W, addr=0x53, len=0
> [   11.777671] i2c-adapter i2c-0: master_xfer[0] W, addr=0x53, len=0
> [   11.778053] i2c-adapter i2c-0: client [eeprom] registered with bus id 0-0053
> [   11.778169] i2c-adapter i2c-0: found normal entry for adapter 0, addr 0x54
> [   11.778249] i2c-adapter i2c-0: master_xfer[0] W, addr=0x54, len=0
> [   11.778317] i2c-adapter i2c-0: master_xfer[0] W, addr=0x54, len=0
> [   11.778708] i2c-adapter i2c-0: client [eeprom] registered with bus id 0-0054
> [   11.778821] i2c-adapter i2c-0: found normal entry for adapter 0, addr 0x55
> [   11.778905] i2c-adapter i2c-0: master_xfer[0] W, addr=0x55, len=0
> [   11.778974] i2c-adapter i2c-0: master_xfer[0] W, addr=0x55, len=0
> [   11.779296] i2c-adapter i2c-0: client [eeprom] registered with bus id 0-0055
> [   11.779406] i2c-adapter i2c-0: found normal entry for adapter 0, addr 0x56
> [   11.779487] i2c-adapter i2c-0: master_xfer[0] W, addr=0x56, len=0
> [   11.779556] i2c-adapter i2c-0: master_xfer[0] W, addr=0x56, len=0
> [   11.779881] i2c-adapter i2c-0: client [eeprom] registered with bus id 0-0056
> [   11.780180] i2c-adapter i2c-0: found normal entry for adapter 0, addr 0x57
> [   11.780275] i2c-adapter i2c-0: master_xfer[0] W, addr=0x57, len=0
> [   11.780346] i2c-adapter i2c-0: master_xfer[0] W, addr=0x57, len=0
> [   11.780695] i2c-adapter i2c-0: client [eeprom] registered with bus id 0-0057
> [   11.780779] i2c-adapter i2c-0: master_xfer[0] W, addr=0x57, len=1
> [   11.780828] i2c-adapter i2c-0: master_xfer[1] R, addr=0x57, len=1
> [   11.796088] xilinx_iic.0 #0: Could not talk to device 0x57 (0), bus always busy, trying to reset
> [   11.884076] i2c-adapter i2c-0: master_xfer[0] R, addr=0x57, len=1
> [   11.900084] xilinx_iic.0 #0: Could not talk to device 0x57 (0), bus always busy, trying to reset
> [   11.988074] i2c-adapter i2c-0: master_xfer[0] R, addr=0x57, len=1
> [   12.004086] xilinx_iic.0 #0: Could not talk to device 0x57 (0), bus always busy, trying to reset
> [   12.096076] i2c-adapter i2c-0: master_xfer[0] R, addr=0x57, len=1
> [   12.112084] xilinx_iic.0 #0: Could not talk to device 0x57 (0), bus always busy, trying to reset
> [   12.200151] xilinx_iic.0 #0 at 0x81600000 mapped to 0xC5060000, irq=4

Also, occasionally the board will hang during bootup during the I2C 
device initialization.  This is what I get when I try to read from the 
eeprom memory locations:

> root@xilinx-ml403:~/i2c-tools-3.0.1/tools# ./i2cget 0 0x50
> Error: Could not set address to 0x50: Device or resource busy
> root@xilinx-ml403:~/i2c-tools-3.0.1/tools# ./i2cget 0 0x51
> Error: Could not set address to 0x51: Device or resource busy
> root@xilinx-ml403:~/i2c-tools-3.0.1/tools# ./i2cget 0 0x52
> Error: Could not set address to 0x52: Device or resource busy
> root@xilinx-ml403:~/i2c-tools-3.0.1/tools# ./i2cget 0 0x53
> Error: Could not set address to 0x53: Device or resource busy
> root@xilinx-ml403:~/i2c-tools-3.0.1/tools# ./i2cget 0 0x54
> Error: Could not set address to 0x54: Device or resource busy
> root@xilinx-ml403:~/i2c-tools-3.0.1/tools# ./i2cget 0 0x55
> Error: Could not set address to 0x55: Device or resource busy
> root@xilinx-ml403:~/i2c-tools-3.0.1/tools# ./i2cget 0 0x56
> Error: Could not set address to 0x56: Device or resource busy
> root@xilinx-ml403:~/i2c-tools-3.0.1/tools# ./i2cget 0 0x57
> Error: Could not set address to 0x57: Device or resource busy

The following are the I2C defines in my xparameters_ml403.h file:

> sellsa@SS-SBIR-Ubuntu:~/linux-2.6-xlnx/arch/ppc/platforms/4xx/xparameters$ cat xparameters_ml403.h | grep IIC
> /* Definitions for driver IIC */
> #define XPAR_XIIC_NUM_INSTANCES 1
> /* Definitions for peripheral IIC_EEPROM */
> #define XPAR_IIC_EEPROM_DEVICE_ID 0
> #define XPAR_IIC_EEPROM_BASEADDR 0x81600000
> #define XPAR_IIC_EEPROM_HIGHADDR 0x8160FFFF
> #define XPAR_IIC_EEPROM_TEN_BIT_ADR 0
> #define XPAR_IIC_EEPROM_GPO_WIDTH 1
> /* Canonical definitions for peripheral IIC_EEPROM */
> #define XPAR_IIC_0_DEVICE_ID XPAR_IIC_EEPROM_DEVICE_ID
> #define XPAR_IIC_0_BASEADDR 0x81600000
> #define XPAR_IIC_0_HIGHADDR 0x8160FFFF
> #define XPAR_IIC_0_TEN_BIT_ADR 0
> #define XPAR_IIC_0_GPO_WIDTH 1
> #define XPAR_IIC_EEPROM_IIC2INTC_IRPT_MASK 0X000010
> #define XPAR_XPS_INTC_0_IIC_EEPROM_IIC2INTC_IRPT_INTR 4
> #define XPAR_INTC_0_IIC_0_VEC_ID XPAR_XPS_INTC_0_IIC_EEPROM_IIC2INTC_IRPT_INTR
> #define XPAR_PERSISTENT_0_IIC_0_BASEADDR 0
> #define XPAR_PERSISTENT_0_IIC_0_HIGHADDR 128
> #define XPAR_PERSISTENT_0_IIC_0_EEPROMADDR 0x50

Any ideas on what could be going wrong?  Any ideas on how to 
troubleshoot this?

Regards,
Aaron
