Return-Path: <robert.thorhuus@ericsson.com>
Received: from mailgw10.se.ericsson.net (mailgw10.se.ericsson.net
	[193.180.251.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9EC2CB70D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Feb 2011 18:29:22 +1100 (EST)
From: Robert Thorhuus <robert.thorhuus@ericsson.com>
To: "avorontsov@mvista.com" <avorontsov@mvista.com>
Date: Fri, 25 Feb 2011 08:29:01 +0100
Subject: RE: Open Firmware and interrupt trigger
Message-ID: <9081694521850B4D91387C8C2E612B591062A0DD26@ESESSCMS0361.eemea.ericsson.se>
References: <20110223043015.20795.37090.stgit@localhost6.localdomain6>
	<20110223043345.20795.2936.stgit@localhost6.localdomain6>
	<4D6551EF.70207@gmail.com>
	<9081694521850B4D91387C8C2E612B591062A0D5CA@ESESSCMS0361.eemea.ericsson.se>
	<1298580418.8833.428.camel@pasglop>
In-Reply-To: <1298580418.8833.428.camel@pasglop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thank you Benjamin!

Sorry for not using your qouting schema :(

Benjamin, you are right about the IRQ flags. Those interrupt.h flags seems =
to differ from my processor reference manual.

None the less. Antov, I saw that the code snippet I refer to below:

> 	ret =3D of_irq_to_resource(dn, 0, &irq_res);
> 	if (ret =3D=3D NO_IRQ)
> 		irq_res.start =3D irq_res.end =3D 0;
> 	else
> 		irq_res.flags =3D 0;

, originates from the first version of the file pata_of_platform.c and you =
are the creator :)
Could you explain the hardcoded ".flags =3D 0" part?=20
Looking amatuer-vise in the code it seems that the only thing one is able t=
o control (through Device Tree) regarding interrupts and pata, is the actua=
l IRQ number. Is this a correct assumption?

Thanks
BR
Robert


-----Original Message-----
From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=20
Sent: den 24 februari 2011 21:47
To: Robert Thorhuus
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: Open Firmware and interrupt trigger

On Wed, 2011-02-23 at 22:18 +0100, Robert Thorhuus wrote:
> Hello!
>=20
> I'm quite new to linux and Open Firmware.
>=20
> I have a PPC processor. To this I have a Compact Flash connected. The Com=
pact Flash is using external interrupt 0 of the processor.
> In my DTS file I have specified a Compact Flash node and within it I have=
 an interrupt element:
> interrupt =3D <0 2 0 0>;
>=20
> Here I thought the first number was the ID of the interrupt and the secon=
d one should be a number indicating how the interrupt is triggered (high, l=
ow, raising, falling).
>=20
> The interrupt is active low.
>=20
> But I could not get it to work which ever value I chose.
>=20
> Looking in the code I found this in function __devinit pata_of_platform_p=
robe in file pata_of_platform.c:
>=20
> 	ret =3D of_irq_to_resource(dn, 0, &irq_res);
> 	if (ret =3D=3D NO_IRQ)
> 		irq_res.start =3D irq_res.end =3D 0;
> 	else
> 		irq_res.flags =3D 0;
>=20
> Here "flags" will be zero whatever I do in the DTS. As far as I can under=
stand the flags are defined in interrupts.h:
> #define IRQF_TRIGGER_NONE       0x00000000
> #define IRQF_TRIGGER_RISING     0x00000001
> #define IRQF_TRIGGER_FALLING    0x00000002
> #define IRQF_TRIGGER_HIGH       0x00000004
> #define IRQF_TRIGGER_LOW        0x00000008

Actually, the .dts flags depend on the specific interrupt controller you ar=
e using. For example, MPIC uses a different mapping scheme (for historical =
reasons). Check booting-without-of.txt.

> So modifying the code to:
> 	else
> 		irq_res.flags =3D 2;
>=20
> I get it to work.
>=20
> Could someone please explain to me why the "flags" parameter is hardcoded=
 zero or just point in a good direction.

That does indeed look odd. Might be worth trying to figure out with the git=
 history who came up with that code in the first place and ask that person.=
 Without answer, I think it's valid to patch that out.

Cheers,
Ben.

> Thank you
>=20
> BR
> Robert
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
