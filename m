Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 05EC267A65
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Jun 2006 15:27:50 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k5S5RnXL021959 for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Jun 2006 22:27:49 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k5S5RljL006947
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Jun 2006 00:27:48 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306DD12EC@zch01exm40.ap.freescale.net>
From: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
To: Florian Boelstler <euphoria@arcor.de>, linuxppc-embedded@ozlabs.org
Subject: RE: MPC8548 PCIe / PCI support with BSP MPC8548CDS 02/24/2006
Date: Wed, 28 Jun 2006 13:27:46 +0800
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

> We did the hardware fix described in the BSP user's manual to 
> make PCIe work (according to the manual section 2.1, step 3).
> I.e.
>   1) removed R193 and R194 on the carrier card (rev 1.2)
>   2) removed RN1 on the CPU daughter card
>   2a) connected pad3 of RN1 to pin3 of U12 (IRQ0)
>   2b) connected pad2 of RN1 to pin4 of U12 (IRQ1)
> 
> Does this fix the interrupt polarity problem (as well)?

Yes, I think so. You can plug a PCIe ethernet card to test it. 

> 
> We applied the provided kernel patch as well.
> IMHO that patch just moves the local PCIe root-complex 
> "out-of-space" so no detection of that one occurs any more.
> This is what actually happens when "lspci" is run.
> 
> However we still don't see any devices behind the PCIe switch 
> (e.g. a transparent PLX8516). It seems that the enumeration 
> process (traversing through the bus hierarchy) in the kernel 
> is somehow disabled.

:-), Maybe it's need more study. Could you enable the DEBUG and post the kernel verbose message?

> Bottom line: Only one device accessible at all on the PCIe port.
> 
> Any further ideas?
> 
> Thanks,
> 
>    Florian
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
