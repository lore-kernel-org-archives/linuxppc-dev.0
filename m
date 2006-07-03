Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 50088679FB
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Jul 2006 16:38:32 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FxI4c-00023K-3t
	for linuxppc-embedded@ozlabs.org; Mon, 03 Jul 2006 08:38:22 +0200
Received: from rusfw02.rohde-schwarz.com ([80.246.32.40])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 03 Jul 2006 08:38:22 +0200
Received: from euphoria by rusfw02.rohde-schwarz.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 03 Jul 2006 08:38:22 +0200
To: linuxppc-embedded@ozlabs.org
From: Florian Boelstler <euphoria@arcor.de>
Subject: Re: MPC8548 PCIe / PCI support with BSP MPC8548CDS 02/24/2006
Date: Mon, 03 Jul 2006 08:38:04 +0200
Message-ID: <e8ae0b$35e$1@sea.gmane.org>
References: <9FCDBA58F226D911B202000BDBAD467306DD12EC@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306DD12EC@zch01exm40.ap.freescale.net>
Sender: news <news@sea.gmane.org>
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

Zhang Wei-r63237 schrieb:
> Yes, I think so. You can plug a PCIe ethernet card to test it. 

A single device always works.

> :-), Maybe it's need more study. Could you enable the DEBUG and post the kernel verbose message?

We added lots of debug output and made some modifications (mostly delays 
between calls to early_read_config_dword() and 
early_write_config_dword() in pci_auto.c) and came to the conclusion 
that generic bridge devices (PCIe-to-PCI), even in a cascaded setup of 
three bridges, work fine.

However a PCIe switch (PLX8516/8532) doesn't work. The MPC8548 only 
detects a single device (i.e. primary side of the switch).
We are going to analyze the problem more deeply soon. It seems that the 
configuration space of that devices isn't properly set up.

The provided patch doesn't make any difference, besides that it is moved 
to a location where the PPC itself is not detected.

Please keep us informed if there is any progress besides Freescale, as I 
will do.

Cheers,

   Florian
