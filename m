Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0CA012C0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 17:05:51 +1000 (EST)
Message-ID: <1368687941.9603.56.camel@pasglop>
Subject: Re: SATA FSL and upstreaming
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-R61911 <r61911@freescale.com>
Date: Thu, 16 May 2013 17:05:41 +1000
In-Reply-To: <3E027F8168735B46AC006B1D0C7BB0020B1E05BC@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38.camel@pasglop> <51947A00.9010504@windriver.com>
 <1368685307.9603.39.camel@pasglop> <51947E35.30808@windriver.com>
 <1368686426.9603.49.camel@pasglop> <5194800D.3010606@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C498@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E056D@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368687218.9603.52.camel@pasglop>
 <3E027F8168735B46AC006B1D0C7BB0020B1E05BC@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
 Liu Qiang-B32616 <B32616@freescale.com>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-16 at 07:01 +0000, Zang Roy-R61911 wrote:

> I just tried your RCW. one e1000 card works in slot7.
> we may need to check others ...

Tried 4 and 7 ...

Note that this *used* to work. Last year I had this machine up with 2
cards doing things. Not sure what changed, it's possible that the DIP
got inadvertently changed. Or somebody stole a jumper from it in the
lab :-)

> U-Boot 2013.01-00078-g2741c99 (May 03 2013 - 00:20:41)
> 
> CPU0:  P5020E, Version: 2.0, (0x82280020)
> Core:  E5500, Version: 1.2, (0x80240012)
> Clock Configuration:
>        CPU0:2000 MHz, CPU1:2000 MHz, 
>        CCB:800  MHz,
>        DDR:666.667 MHz (1333.333 MT/s data rate) (Asynchronous), LBC:100  MHz
>        FMAN1: 600 MHz
>        QMAN:  400 MHz
>        PME:   400 MHz
> L1:    D-cache 32 kB enabled
>        I-cache 32 kB enabled
> Reset Configuration Word (RCW):
>        00000000: 0c540000 00000000 1e120000 00000000
>        00000010: d8984a01 03002000 de800000 41000000
>        00000020: 00000000 00000000 00000000 10070000
>        00000030: 00000000 00000000 00000000 00000000

My RCW is identical

> Board: P5020DS, Sys ID: 0x1c, Sys Ver: 0x02, FPGA Ver: 0x04, vBank: 4

Mine is:
Board: P5020DS, Sys ID: 0x1c, Sys Ver: 0x12, FPGA Ver: 0x05, vBank: 4                                                        

> SERDES Reference Clocks: Bank1=100Mhz Bank2=125Mhz Bank3=125Mhz 

Same.

> I2C:   ready
> SPI:   ready
> DRAM:  Initializing....using SPD
> Detected UDIMM i-DIMM
> Detected UDIMM i-DIMM
> 2 GiB left unmapped
> 4 GiB (DDR3, 64-bit, CL=9, ECC on)
>        DDR Controller Interleaving Mode: cache line
>        DDR Chip-Select Interleaving Mode: CS0+CS1
> Testing 0x00000000 - 0x7fffffff
> Testing 0x80000000 - 0xffffffff
> Remap DDR 2 GiB left unmapped
> 
> POST memory PASSED
> Flash: 128 MiB
> L2:    512 KB enabled
> Corenet Platform Cache: 2048 KB enabled
> SRIO1: disabled
> SRIO2: disabled
> NAND:  1024 MiB
> MMC:  FSL_SDHC: 0
> EEPROM: Invalid ID (ff ff ff ff)
> PCIe1: Root Complex, x2, regs @ 0xfe200000
>   01:00.0     - 8086:105e - Network controller
>   01:00.1     - 8086:105e - Network controller
> PCIe1: Bus 00 - 01
> PCIe2: disabled
> PCIe3: Root Complex, no link, regs @ 0xfe202000
> PCIe3: Bus 02 - 02
> PCIe4: disabled

And I never see anything here anymore...

> In:    serial
> Out:   serial
> Err:   serial
> Net:   Initializing Fman
> Fman1: Uploading microcode version 106.1.6
> PHY reset timed out
> PHY reset timed out
> PHY reset timed out
> PHY reset timed out
> e1000: 00:15:17:16:ce:b8
>        e1000: 00:15:17:16:ce:b9
>        FM1@DTSEC1, FM1@DTSEC2, FM1@DTSEC3, FM1@DTSEC4 [PRIME], FM1@DTSEC5, FM1@TGEC1, e1000#0
> Warning: e1000#0 MAC addresses don't match:
> Address in SROM is         00:15:17:16:ce:b8
> Address in environment is  00:1b:21:68:5e:d4
> , e1000#1
> Warning: e1000#1 using MAC address from net device
> 
> =>
