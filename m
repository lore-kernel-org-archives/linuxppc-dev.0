Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E42DDDE032
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 08:51:52 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How do external irq's get mapped?
Date: Fri, 27 Apr 2007 15:51:50 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F4@MERCURY.inside.istor.com>
In-Reply-To: <A500BD9D-500C-485A-A806-77B8C430F333@freescale.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Andy Fleming" <afleming@freescale.com>
Cc: Randy Brown <rbrown@istor.com>, Chris Carlson <ccarlson@istor.com>,
	Kevin Smith <ksmith@istor.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 3. The offset between TSEC1_tx of 13-->93 is a constant of 80 decimal.
> Is this a clue to what the irq should be set to for external IRQ0 in
> this design?


Yeah.  112.  However, you really should switch to using arch/powerpc, =20
and device trees.  In that instance, you set the irq to the pin =20
number (1-4), and the kernel will map that based on the interrupt-map =20
property of the pci node.  It was for precisely this type of problem =20
that the irq numbers were virtualized.  The IRQ numbers in arch/ppc =20
actually change depending on whether you've *configured* the CPM or not.

Andy

Dear Andy:

I appreciate your kind advice, it does help converge understanding
somewhat. I can see how we get the 80 decimal offset with 64 + 32.

I have commented out the call i8259_init(0,0) in
arch/ppc/platforms/85xx/mpc85xx_cds_common.c, but retained the call to
cpm2_init_IRQ(); shortly after that. We are constrained to finish the
current project with the kernel we started with, so changing from ppc to
powerpc is really difficult right now.

When the pci_dev->irq member is set to 112, there is a difference in
behavior. Now open_pic.c:720 is complaining that 112 is "invalid irq
112", so some additional understanding is needed on my part.

If you get a chance to help me continue to understand how the 8541
interrupts are sutured into Linux, it would be greatly appreciated.

Charles Krinke
