Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6B63367B4C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Jun 2006 02:06:55 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FvG5I-0003fu-T6
	for linuxppc-embedded@ozlabs.org; Tue, 27 Jun 2006 18:06:41 +0200
Received: from rusfw02.rohde-schwarz.com ([80.246.32.40])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 27 Jun 2006 18:06:40 +0200
Received: from euphoria by rusfw02.rohde-schwarz.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 27 Jun 2006 18:06:40 +0200
To: linuxppc-embedded@ozlabs.org
From: Florian Boelstler <euphoria@arcor.de>
Subject: Re: MPC8548 PCIe / PCI support with BSP MPC8548CDS 02/24/2006
Date: Tue, 27 Jun 2006 18:06:05 +0200
Message-ID: <e7rl1v$gul$1@sea.gmane.org>
References: <9FCDBA58F226D911B202000BDBAD467306D93192@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306D93192@zch01exm40.ap.freescale.net>
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
> It's an add-on PCIe patch. We have tested it on MPC8641, but we have no PCIe-PCI bridge on MPC8548 platform to do more test. So if you verify it, I'll commit it. :)

We did the hardware fix described in the BSP user's manual to make PCIe 
work (according to the manual section 2.1, step 3).
I.e.
  1) removed R193 and R194 on the carrier card (rev 1.2)
  2) removed RN1 on the CPU daughter card
  2a) connected pad3 of RN1 to pin3 of U12 (IRQ0)
  2b) connected pad2 of RN1 to pin4 of U12 (IRQ1)

Does this fix the interrupt polarity problem (as well)?

We applied the provided kernel patch as well.
IMHO that patch just moves the local PCIe root-complex "out-of-space" so 
no detection of that one occurs any more.
This is what actually happens when "lspci" is run.

However we still don't see any devices behind the PCIe switch (e.g. a 
transparent PLX8516). It seems that the enumeration process (traversing 
through the bus hierarchy) in the kernel is somehow disabled.
Bottom line: Only one device accessible at all on the PCIe port.

Any further ideas?

Thanks,

   Florian
