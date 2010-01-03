Return-Path: <lonsn2005@gmail.com>
Received: from mail-px0-f198.google.com (mail-px0-f198.google.com
	[209.85.216.198]) by ozlabs.org (Postfix) with ESMTP id 2D185B6EEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  3 Jan 2010 14:23:45 +1100 (EST)
Received: by pxi36 with SMTP id 36so9608045pxi.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 02 Jan 2010 19:23:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AC5E1C3367E37D44970B81A6ADD1DA2C08882EAA@SDCEXCHANGE01.ad.amcc.com>
References: <6caf4b5a0912310055h54a6efa6ka1825f19a7f0c691@mail.gmail.com>
	<AC5E1C3367E37D44970B81A6ADD1DA2C08882EAA@SDCEXCHANGE01.ad.amcc.com>
Date: Sun, 3 Jan 2010 11:23:43 +0800
Message-ID: <6caf4b5a1001021923m48d913d8g7da1fb8043dcebca@mail.gmail.com>
Subject: Re: How to access PPC460EX SDRAM space from PCI/PCIe.
From: Lonsn <lonsn2005@gmail.com>
To: Tirumala Reddy Marri <tmarri@amcc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sr@denx.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi:
Thank you for your reply and Happy New Year!

According to the canyonlands.dts and arch/powerpc/sysdev/ppc4xx_pci.c
files in the linux kernel, 2GB has been mappend to inbound PCI memory
region,
The followings are PIM init codes related in the kernel:
/******************************************/
sa = (0xffffffffffffffffull << ilog2(size));
 if (res->flags & IORESOURCE_PREFETCH)
         sa |= 0x8;

 out_le32(mbase + PECFG_BAR0HMPA, RES_TO_U32_HIGH(sa));
 out_le32(mbase + PECFG_BAR0LMPA, RES_TO_U32_LOW(sa));

 /* The setup of the split looks weird to me ... let's see
  * if it works
  */
 out_le32(mbase + PECFG_PIM0LAL, 0x00000000);
 out_le32(mbase + PECFG_PIM0LAH, 0x00000000);
 out_le32(mbase + PECFG_PIM1LAL, 0x00000000);
 out_le32(mbase + PECFG_PIM1LAH, 0x00000000);
 out_le32(mbase + PECFG_PIM01SAH, 0xffff0000);
 out_le32(mbase + PECFG_PIM01SAL, 0x00000000);

 out_le32(mbase + PCI_BASE_ADDRESS_0, RES_TO_U32_LOW(res->start));
 out_le32(mbase + PCI_BASE_ADDRESS_1, RES_TO_U32_HIGH(res->start));
/*****************************************/

I have debugged these codes and found that the value of register
PECFGn_BAR0LMPA is
0x80000008 which means the LT field is 00.
But according to the PPC460EX usermanual P618:
LT bit: Type Field:
              Programming access for PECFGn_BAR0L[LT]:
              00 32-bit address memory space (not supported)
             10 64-bit address memory space
              All other values are reserved.
It shows that 32 bit address momory space is not supported for PIM.
The same question happened in the PCI controller (LT field of
PCI0_BAR0L register).

So my question is:
1: For PIM, How to access the SDRAM space using 32bit PCI master?
Using just one address(0x1F800000) or using pci dual address cycle
command.
2: Are current linux kernel PIM settings correct and verified by anybody?

Thanks a lot.

Lonsn

2010/1/1 Tirumala Reddy Marri <tmarri@amcc.com>:
> It should be able to access any region in 32bit mode as long as it is
> smaller than 4GB size. Usually whole SDRAM is mapped to inbound PCI
> memory region.
>
> -----Original Message-----
> From: linuxppc-dev-bounces+tmarri=amcc.com@lists.ozlabs.org
> [mailto:linuxppc-dev-bounces+tmarri=amcc.com@lists.ozlabs.org] On Behalf
> Of Lonsn
> Sent: Thursday, December 31, 2009 12:55 AM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: sr@denx.de
> Subject: How to access PPC460EX SDRAM space from PCI/PCIe.
>
> Hi:
> I'm now using canyonlands board with latest u-boot and linux kernel
> from DENX git.
> A PCIe card is plugged in the PCIeX4 slot. The PCIe card is a PCIe-pci
> bridge(PI7C9X130) plus an Altera fpga.
> The PCIe card act as a PCI master and send data to SDRAM of 460EX
> space (total sdram 512MB, reserve 8M for PCI write data(0x1F800000)).
> Now linux can identify this card, but CPU cann't receive any data from
> PCIe and no PCIe interrupt.
> I know about the PCI card works in 32bit mode and doesn't support
> 64bit address(No pci dual address cycle support).
> Does the PCI card can access PPC460EX sdram space using just 32bit
> physical address(0x1F800000)?
>
> Best regards,
> Lonsn
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
