Return-Path: <robert.thorhuus@ericsson.com>
Received: from mailgw9.se.ericsson.net (mailgw9.se.ericsson.net
	[193.180.251.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4C071B7400
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Feb 2011 08:34:21 +1100 (EST)
From: Robert Thorhuus <robert.thorhuus@ericsson.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 23 Feb 2011 22:18:50 +0100
Subject: Open Firmware and interrupt trigger
Message-ID: <9081694521850B4D91387C8C2E612B591062A0D5CA@ESESSCMS0361.eemea.ericsson.se>
References: <20110223043015.20795.37090.stgit@localhost6.localdomain6>
	<20110223043345.20795.2936.stgit@localhost6.localdomain6>
	<4D6551EF.70207@gmail.com>
In-Reply-To: <4D6551EF.70207@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello!

I'm quite new to linux and Open Firmware.

I have a PPC processor. To this I have a Compact Flash connected. The Compa=
ct Flash is using external interrupt 0 of the processor.
In my DTS file I have specified a Compact Flash node and within it I have a=
n interrupt element:
interrupt =3D <0 2 0 0>;

Here I thought the first number was the ID of the interrupt and the second =
one should be a number indicating how the interrupt is triggered (high, low=
, raising, falling).

The interrupt is active low.

But I could not get it to work which ever value I chose.

Looking in the code I found this in function __devinit pata_of_platform_pro=
be in file pata_of_platform.c:

	ret =3D of_irq_to_resource(dn, 0, &irq_res);
	if (ret =3D=3D NO_IRQ)
		irq_res.start =3D irq_res.end =3D 0;
	else
		irq_res.flags =3D 0;

Here "flags" will be zero whatever I do in the DTS. As far as I can underst=
and the flags are defined in interrupts.h:
#define IRQF_TRIGGER_NONE       0x00000000
#define IRQF_TRIGGER_RISING     0x00000001
#define IRQF_TRIGGER_FALLING    0x00000002
#define IRQF_TRIGGER_HIGH       0x00000004
#define IRQF_TRIGGER_LOW        0x00000008

So modifying the code to:
	else
		irq_res.flags =3D 2;

I get it to work.

Could someone please explain to me why the "flags" parameter is hardcoded z=
ero or just point in a good direction.

Thank you

BR
Robert=
