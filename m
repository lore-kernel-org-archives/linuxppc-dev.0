Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 853962C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 16:17:47 +1000 (EST)
Message-ID: <51947A00.9010504@windriver.com>
Date: Thu, 16 May 2013 14:17:36 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: SATA FSL and upstreaming
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38.camel@pasglop>
In-Reply-To: <1368684547.9603.38.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
 Liu Qiang-B32616 <B32616@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>,
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

On 05/16/2013 02:09 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-05-16 at 06:05 +0000, Zang Roy-R61911 wrote:
>> I do not suggest changing the RCW. If the RCW is broken on Ben's side,
>> it is not easy to recover for him.
>> Let's check the U-boot output first.
>
> U-Boot 2013.01-00009-g7bcd7f4 (Mar 14 2013 - 14:23:16)
>
> CPU0:  P5020E, Version: 1.0, (0x82280010)
> Core:  E5500, Version: 1.0, (0x80240010)
> Clock Configuration:
>         CPU0:2000 MHz, CPU1:2000 MHz,
>         CCB:800  MHz,
>         DDR:666.667 MHz (1333.333 MT/s data rate) (Asynchronous), LBC:100  MHz
>         FMAN1: 600 MHz
>         QMAN:  400 MHz
>         PME:   400 MHz
> L1:    D-cache 32 kB enabled
>         I-cache 32 kB enabled
> Board: P5020DS, Sys ID: 0x1c, Sys Ver: 0x12, FPGA Ver: 0x05, vBank: 0
> Reset Configuration Word (RCW):
>         00000000: 0c540000 00000000 1e120000 00000000
>         00000010: d8984a01 03002000 de800000 41000000
>         00000020: 00000000 00000000 00000000 10070000
>         00000030: 00000000 00000000 00000000 00000000

I think you can use Bharat's RCW, which seems RR_HXAPNSP_0x36, then please take 
a look at this:

The RCW directories names for the p5020ds board conform to the following naming
convention:

ab_bcdefghi_j:

a = 'R' if RGMII@DTSEC4 is supported / 'N' if not available/not used
b = 'R' if RGMII@DTSEC5 is supported / 'N" if not available/not used

c = What is available in Slot 1 or SATA
d = What is available in Slot 2
e = What is available in Slot 3
f = What is available in Slot 4
g = What is available in Slot 5
h = What is available in Slot 6
i = What is available in Slot 7

For the Slots (c..i):
  'N' if not available/not used
  'P' if PCIe
  'X' if XAUI
  'R' if SRIO
  'S' if SGMII
  'H' if SATA
  'A' is AURORA

j = 'hex value of serdes protocol value'

So NR_HXAPNSP_0x36 means:
  - no RGMII@DTSEC4
  - RGMII@DTSEC5
  - SATA [Slot 1 not used]
  - XAUI on Slot 2
  - AURORA on Slot 3
  - PCIE on Slot 4
  - SGMII on Slot 6
  - PCIE on Slot 7

Slot 5 is not used, and the SERDES Protocol is 0x36.

So slot 7 and slot 4 can be as PCIe slot.

Tiejun

> SERDES Reference Clocks: Bank1=100Mhz Bank2=125Mhz Bank3=125Mhz
> I2C:   ready
> SPI:   ready
> DRAM:  Initializing....using SPD
> Detected UDIMM i-DIMM
> Detected UDIMM i-DIMM
> 2 GiB left unmapped
> 4 GiB (DDR3, 64-bit, CL=9, ECC on)
>         DDR Controller Interleaving Mode: cache line
>         DDR Chip-Select Interleaving Mode: CS0+CS1
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
> EEPROM: NXID v1
> PCIe1: Root Complex, no link, regs @ 0xfe200000
> PCIe1: Bus 00 - 00
> PCIe2: disabled
> PCIe3: Root Complex, no link, regs @ 0xfe202000
> PCIe3: Bus 01 - 01
> PCIe4: disabled
> In:    serial
> Out:   serial
> Err:   serial
> Net:   Initializing Fman
> Fman1: Uploading microcode version 106.1.7
> PHY reset timed out
> PHY reset timed out
> PHY reset timed out
> PHY reset timed out
> FM1@DTSEC1, FM1@DTSEC2, FM1@DTSEC3, FM1@DTSEC4, FM1@DTSEC5, FM1@TGEC1
> Hit any key to stop autoboot:  0
> =>
>
> Cheers,
> Ben.
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
