Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B21FDE388
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 12:30:48 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l3S2Ua6n000264 for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 19:30:36 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l3S2UZdE008066
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 21:30:35 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: How do external irq's get mapped?
Date: Sat, 28 Apr 2007 10:30:33 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C1D7274@zch01exm26.fsl.freescale.net>
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F4@MERCURY.inside.istor.com>
References: <A500BD9D-500C-485A-A806-77B8C430F333@freescale.com>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F4@MERCURY.inside.istor.com>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Charles Krinke" <ckrinke@istor.com>,
	"Fleming Andy-afleming" <afleming@freescale.com>
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

Hi, Charles,

Maybe you can try my patches about showing irq-mapping relationship.

http://patchwork.ozlabs.org/linuxppc/patch?id=3D9999
http://patchwork.ozlabs.org/linuxppc/patch?id=3D9997
http://patchwork.ozlabs.org/linuxppc/patch?id=3D9998
http://patchwork.ozlabs.org/linuxppc/patch?id=3D9996

Hope it could help you.

Best Regards,
Zhang Wei

> Subject: RE: How do external irq's get mapped?
>=20
> > 3. The offset between TSEC1_tx of 13-->93 is a constant of=20
> 80 decimal.
> > Is this a clue to what the irq should be set to for external IRQ0 in
> > this design?
>=20
>=20
> Yeah.  112.  However, you really should switch to using=20
> arch/powerpc, =20
> and device trees.  In that instance, you set the irq to the pin =20
> number (1-4), and the kernel will map that based on the=20
> interrupt-map =20
> property of the pci node.  It was for precisely this type of problem =20
> that the irq numbers were virtualized.  The IRQ numbers in arch/ppc =20
> actually change depending on whether you've *configured* the=20
> CPM or not.
>=20
> Andy
>=20
> Dear Andy:
>=20
> I appreciate your kind advice, it does help converge understanding
> somewhat. I can see how we get the 80 decimal offset with 64 + 32.
>=20
> I have commented out the call i8259_init(0,0) in
> arch/ppc/platforms/85xx/mpc85xx_cds_common.c, but retained the call to
> cpm2_init_IRQ(); shortly after that. We are constrained to finish the
> current project with the kernel we started with, so changing=20
> from ppc to
> powerpc is really difficult right now.
>=20
> When the pci_dev->irq member is set to 112, there is a difference in
> behavior. Now open_pic.c:720 is complaining that 112 is "invalid irq
> 112", so some additional understanding is needed on my part.
>=20
> If you get a chance to help me continue to understand how the 8541
> interrupts are sutured into Linux, it would be greatly appreciated.
>=20
> Charles Krinke
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
