Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DA5FBDDE0D
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 19:51:49 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l6C9piRl001491
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 02:51:45 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6C9phAd026420
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 04:51:44 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 2/4] Add dma sector to mpc8641hpcn board dts
Date: Thu, 12 Jul 2007 17:51:42 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C6F3E43@zch01exm26.fsl.freescale.net>
In-Reply-To: <1460BC39-B1B7-4025-9D4C-368FB473A260@kernel.crashing.org>
References: <1184060662530-git-send-email-wei.zhang@freescale.com>
	<11840606624025-git-send-email-wei.zhang@freescale.com>
	<11840606621515-git-send-email-wei.zhang@freescale.com>
	<55F09B00-F81A-4B70-B0F7-2FEBDBB2B48A@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C6F3CE1@zch01exm26.fsl.freescale.net>
	<1460BC39-B1B7-4025-9D4C-368FB473A260@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Segher Boessenkool [mailto:segher@kernel.crashing.org]=20
>=20
> >>> +		dma@21000{
> >>> +			compatible =3D "fsl,mpc8xxx-dma";
> >>
> >> Please use a real name, not this "xxx" stuff.
> >
> > Does the "xxx" seems to be an evil name? :-)
>=20
> You are stating this particular device is compatible to
> the "mpc8xxx-dma" device, which doesn't exist.  If it is
> supposed to mean it is compatible to the DMA controller
> on any 8000-series device, that is incorrect; in the future,
> there might be many such devices with an incompatible DMA
> controller.
>=20
> Just put in some real device model name.

Ok, I'll use the first (or almost) real device model name.=20

>=20
> >>> +			reg =3D <21000 100>;
> >>> +			ranges =3D <0 21000 1000>;
> >>
> >> These overlap, that can't be right; it is just begging for
> >> trouble.
> >
> > There is no overlap. The 'reg' is used for the register of DMA
> > controller. And the ranges is used for belows channel registers.
>=20
> And 21000..210ff is a subset of 21000..21fff.  So there _is_
> overlap.
>=20

All right. Avoid this.

> > Such as ch0@100, reg=3D<100 80>, in fact, the ch0 register address =
is
> > 0x21100.
>=20
> Sure, none of the "reg"s in any of the children overlap the
> parent "reg", but the parent "reg" overlaps the "ranges".
>=20
> >>> +			ch0@100{
> >>> +				reg =3D <100 80>;
> >>> +				extended;
> >>
> >> I think you want a little more detailed property name
> >> than "extended" here?
> >
> > I've explained it in [PATCH 1/4] Add DMA sector to
> > Documentation/powerpc/booting-without-of.txt file.
> > As below:
> > +    - extended : Set the DMA channel to work at extended=20
> chain mode.
> > +                 If not set, the DMA channel will work at basic
> > +                 chain mode.
>=20
> Sure it's documented, but it would be good if the property
> name itself would say a bit more than just "extended".  Property
> names can be 31 characters, there's no need to make short names
> (terse is good, content-free isn't).
>=20

Ok.

Thanks!
Wei.
