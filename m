Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id C8EFE679F0
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Jul 2006 17:54:36 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k637sXDT013789
	for <linuxppc-embedded@ozlabs.org>; Mon, 3 Jul 2006 00:54:33 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k637sVY2005104
	for <linuxppc-embedded@ozlabs.org>; Mon, 3 Jul 2006 02:54:32 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306F13A4B@zch01exm40.ap.freescale.net>
From: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
To: Florian Boelstler <euphoria@arcor.de>, linuxppc-embedded@ozlabs.org
Subject: RE: MPC8548 PCIe / PCI support with BSP MPC8548CDS 02/24/2006
Date: Mon, 3 Jul 2006 15:54:30 +0800 
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, 

> -----Original Message-----
> From: 
> linuxppc-embedded-bounces+wei.zhang=freescale.com@ozlabs.org 
> [mailto:linuxppc-embedded-bounces+wei.zhang=freescale.com@ozla
> bs.org] On Behalf Of Florian Boelstler
> Sent: Monday, July 03, 2006 2:38 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: Re: MPC8548 PCIe / PCI support with BSP MPC8548CDS 02/24/2006
> 
> Hi,
> 
> Zhang Wei-r63237 schrieb:
> > Yes, I think so. You can plug a PCIe ethernet card to test it. 
> 
> A single device always works.
> 
> > :-), Maybe it's need more study. Could you enable the DEBUG 
> and post the kernel verbose message?
> 
> We added lots of debug output and made some modifications 
> (mostly delays between calls to early_read_config_dword() and
> early_write_config_dword() in pci_auto.c) and came to the 
> conclusion that generic bridge devices (PCIe-to-PCI), even in 
> a cascaded setup of three bridges, work fine.

Yea, that's a good news.

> 
> However a PCIe switch (PLX8516/8532) doesn't work. The 
> MPC8548 only detects a single device (i.e. primary side of 
> the switch).
> We are going to analyze the problem more deeply soon. It 
> seems that the configuration space of that devices isn't 
> properly set up.

Just a suggestion.
Do you see below codes in mpc85xx_pex_errata.c(in read and write functions)?
	if (devfn != 0x0) 
		return PCIBIOS_DEVICE_NOT_FOUND;
Change them to:
	if (devfn != 0x0 && bus->number ==0) 
		return PCIBIOS_DEVICE_NOT_FOUND;
And try again. :-)
(If you apply my patch, please use "if (devfn != 0x0 && bus->number ==0xff)" )

> 
> The provided patch doesn't make any difference, besides that 
> it is moved to a location where the PPC itself is not detected.
> 
This patch fix an issue of MPC8641 PCI-Ex controller. It seems MPC8548 has no that issue. Well then fotget it.

Thanks!
Zhang Wei

> Please keep us informed if there is any progress besides 
> Freescale, as I will do.
> 
> Cheers,
> 
>    Florian
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
