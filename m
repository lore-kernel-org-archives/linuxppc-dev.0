Return-Path: <SRS0=+eM0=PK=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 5CCADDDECE
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 15:28:11 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: boards in arch/ppc -> arch/powerpc for 85xx
Date: Tue, 16 Oct 2007 07:28:38 +0200
References: <7DBC0977-0367-40F5-8A30-ACA02FD4E9FA@kernel.crashing.org>
	<200710160640.47010.sr@denx.de>
	<B9E8682B-5455-48EA-B078-CB0EDCB2060A@kernel.crashing.org>
In-Reply-To: <B9E8682B-5455-48EA-B078-CB0EDCB2060A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710160728.38897.sr@denx.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 16 October 2007, Kumar Gala wrote:
> >> I'm willing to look into doing the port over, but would need some
> >> help testing.
> >
> > Yes, it would be greatly appreciated if you could start this
> > TQM85xx port. I
> > will of course do the testing.
>
> Ok, for the TQM85xx code in arch/ppc can I get a few things from you:
>
> 1. what processors does this actually support/run on.  I'm guessing
> MPC8541, MPC8555?  But not really sure

IIRC there are 4 different versions of the board:
- 8540, 8541, 8555 & 8560

> 2. can you send the results of a bd_info from u-boot on the board

I have two version available right now

8540:

U-Boot 1.3.0-rc2-g527c80f0-dirty (Oct  5 2007 - 15:57:38)

CPU:   8540, Version: 2.0, (0x80300020)
Core:  E500, Version: 2.0, (0x80200020)
Clock Configuration:
       CPU: 833 MHz, CCB: 333 MHz,
       DDR: 166 MHz, LBC:  41 MHz
L1:    D-cache 32 kB enabled
       I-cache 32 kB enabled
Board: TQM8540, serial# TQM8540DCBAD7-APFBC.0204 11341240 4
PCI1:  32 bit, 33 MHz (compiled)
I2C:   ready
DTT:   1 is 31 C
DRAM:  256 MB (CL=2.5)
FLASH: 32 MB
L2 cache 256KB: enabled
In:    serial
Out:   serial
Err:   serial
Net:   TSEC0, TSEC1, FEC
PS/2:  No device found
Kbd:   reset failed, no ACK

Type run flash_nfs to mount root filesystem over NFS

=> bdinfo
memstart    = 0x00000000
memsize     = 0x10000000
flashstart  = 0xFE000000
flashsize   = 0x02000000
flashoffset = 0x00000000
sramstart   = 0x00000000
sramsize    = 0x00000000
immr_base   = 0xE0000000
bootflags   = 0xE4013F80
intfreq     = 833.333 MHz
busfreq     = 333.333 MHz
ethaddr     = 00:D0:93:08:12:E2
eth1addr    = 00:D0:93:08:12:E3
eth2addr    = 00:D0:93:08:12:E4
IP addr     = 192.168.210.1
baudrate    = 115200 bps


8560:

U-Boot 1.2.0-ge9792fc6 (Aug  7 2007 - 08:43:55)

CPU:   8560, Version: 2.0, (0x80700020)
Core:  E500, Version: 2.0, (0x80200020)
Clock Configuration:
       CPU: 833 MHz, CCB: 333 MHz,
       DDR: 166 MHz, LBC:  41 MHz
L1:    D-cache 32 kB enabled
       I-cache 32 kB enabled
Board: TQM8560, serial# TQM8560DCBAD7-APFBC.0204 11301266 4
PCI1:  32 bit, 33 MHz (compiled)
I2C:   ready
DTT:   1 is 22 C
DRAM:  256 MB (CL=2.5)
FLASH: 32 MB
L2 cache 256KB: enabled
In:    serial
Out:   serial
Err:   serial
Net:   TSEC0, TSEC1, FCC3 ETHERNET

Type run flash_nfs to mount root filesystem over NFS

Hit any key to stop autoboot:  0
=> bdinfo
memstart    = 0x00000000
memsize     = 0x10000000
flashstart  = 0xFE000000
flashsize   = 0x02000000
flashoffset = 0x00000000
sramstart   = 0x00000000
sramsize    = 0x00000000
immr_base   = 0xE0000000
bootflags   = 0x00000036
vco         = 666.666 MHz
sccfreq     = 166.666 MHz
brgfreq     = 166.666 MHz
intfreq     = 833.333 MHz
cpmfreq     = 333.333 MHz
busfreq     = 333.333 MHz
ethaddr     = 16:CC:31:E8:8C:12
eth1addr    = 16:CC:31:E8:8C:13
eth2addr    = 16:CC:31:E8:8C:14
IP addr     = 192.168.210.2
baudrate    = 115200 bps


> 3. can you send me the results of cat /proc/iomem & /proc/ioports
> from a linux boot.

8540:

bash-3.00# cat /proc/iomem
80000000-9fffffff : PCI1 host bridge
  9fff8000-9fff9fff : 0000:00:1c.1
  9fffbc00-9fffbfff : 0000:00:1c.1
  9fffc000-9fffdfff : 0000:00:1c.0
  9ffffc00-9fffffff : 0000:00:1c.0
e0003000-e00030ff : fsl-i2c.1
e0004500-e0004507 : serial
e0004600-e0004607 : serial
e0021100-e002117f : fsl-dma.0
e0021180-e00211ff : fsl-dma.1
e0021200-e002127f : fsl-dma.2
e0021280-e00212ff : fsl-dma.3
e0024000-e0024fff : fsl-gianfar.1
  e0024520-e002453f : fsl-gianfar_mdio.0
e0025000-e0025fff : fsl-gianfar.2
e0026000-e0026fff : fsl-gianfar.3
e00e1000-e00e1fff : fsl-perfmon.1
bash-3.00# cat /proc/ioports
00000000-00ffffff : PCI1 host bridge
  00fffe00-00fffeff : 0000:00:1c.1
  00ffff00-00ffffff : 0000:00:1c.0


8560:

-bash-3.2# cat /proc/iomem
80000000-9fffffff : PCI1 host bridge
  9f7fdf00-9f7fdfff : 0000:00:1c.0
  9fbfe000-9fbfefff : 0000:00:0b.1
  9ffff000-9fffffff : 0000:00:0b.0
e0003000-e00030ff : fsl-i2c.1
e0021100-e002117f : fsl-dma.0
e0021180-e00211ff : fsl-dma.1
e0021200-e002127f : fsl-dma.2
e0021280-e00212ff : fsl-dma.3
e0024000-e0024fff : fsl-gianfar.1
  e0024520-e002453f : fsl-gianfar_mdio.0
e0025000-e0025fff : fsl-gianfar.2
e0088400-e00884ff : fcc_pram
e0088500-e00885ff : fcc_pram
e0088600-e00886ff : fcc_pram
e0091300-e009131f : fcc_regs
e0091320-e009133f : fcc_regs
e0091340-e009135f : fcc_regs
e0091380-e009139f : fcc_regs_c
e00913a0-e00913cf : fcc_regs_c
e00913d0-e00913ff : fcc_regs_c
e0091860-e00918bf : fsl-cpm-i2c.1
e0091a00-e0091a1f : fsl-cpm-scc.1
e0091a20-e0091a3f : fsl-cpm-scc.2
e0091a40-e0091a5f : fsl-cpm-scc.3
e0091a60-e0091a7f : fsl-cpm-scc.4
e0091aa0-e0091aff : fsl-cpm-spi.1
e0091b30-e0091b3f : fsl-cpm-mcc.1
e0091b50-e0091b5f : fsl-cpm-mcc.2
e00e1000-e00e1fff : fsl-perfmon.1
-bash-3.2# cat /proc/ioports
00000000-00ffffff : PCI1 host bridge
  00ff7f00-00ff7fff : 0000:00:1c.0



Thanks.

Best regards,
Stefan
