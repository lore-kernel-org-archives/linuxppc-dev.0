Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5C80EDDEDF
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 13:28:09 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l5I3S3TJ023006
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Jun 2007 20:28:03 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5I3S1mZ017937
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Jun 2007 22:28:02 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/5] Add the explanation and sample of RapidIO DTS sector
	to the document of booting-without-of.txt file.
Date: Mon, 18 Jun 2007 11:27:59 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C527171@zch01exm26.fsl.freescale.net>
In-Reply-To: <2e7b08497aae9219233aed72628e46c6@kernel.crashing.org>
References: <11816389393593-git-send-email-wei.zhang@freescale.com>
	<1181638939310-git-send-email-wei.zhang@freescale.com>
	<39c7d60cebf03badd106d7f75a08f449@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C526DD9@zch01exm26.fsl.freescale.net>
	<59453d80f2f111b72e8f24e7b489c23e@kernel.crashing.org>
	<CF39A363-25C6-4780-96EC-6750D77C287F@kernel.crashing.org>
	<2e7b08497aae9219233aed72628e46c6@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Kumar and Segher,=20

>
> > "..8641.." "..8641d.." "..8548.." "..8548e.." "..8543.."=20
> "..8543e.."=20
> > "..8572.." "..8572e.." "..8567.." "..8567e.." "..8568.." "..8568e.."
>=20
> You don't need to mention _all_ compatible devices in
> the "compatible" property, only the few that matter;
> typically the oldest one, and sometimes some intermediate
> device that has extra features over the original one.
>=20

The oldest one is difficult to find out sometime. Can we only set the
self name in dts, such as "fsl, rapidio-8641", and add this 'compatible'
property to the driver ids arrays? Such as:

static struct of_device_id of_rio_rpn_ids[] =3D {
	{ .compatible =3D "fsl, rapidio-8540",},
	{ .compatible =3D "fsl, rapidio-8560",},
	{ .compatible =3D "fsl, rapidio-8641",},
	{ .compatible =3D "fsl, rapidio-8548",},
	{},
};

How about that?

> It isn't useful to add "compatible" entries that no OS
> probes for.
>=20
> >> Concrete names are good.
> >
> > While I agree concrete names are good, we put these 'blocks' in so=20
> > many devices that using the device to match on is pointless.
>=20
> You *definitely* should put the device name for _this_
> device in there, in case it needs some special workaround.
>=20
> > I'm all for making up a name like 'Grande', 'Del',=20
> 'Janeiro'.  This is=20
> > effective what we did with gianfar.  The name gets picked up pretty=20
> > quickly by people.
>=20
> That can be used as the "base" name, yes.
>=20

Do you have the name list? I can change my codes according them.

How about 'Mercurary', 'Venus', 'Earth', 'Mars', 'Saturn', 'Jupiter',
'Uranus', 'Neptune',
Or 'Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo', 'Libra',
'Scorpius', 'Sagittarius', 'Capricornus', 'Aquarius', 'Pisces' ?

Thanks!
Wei.
