Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EACE4DDD08
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 17:16:22 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l6B7GDQE007036
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 00:16:13 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6B7GCS9014612
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 02:16:12 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 2/4] Add dma sector to mpc8641hpcn board dts
Date: Wed, 11 Jul 2007 15:16:10 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C6F3CE1@zch01exm26.fsl.freescale.net>
In-Reply-To: <55F09B00-F81A-4B70-B0F7-2FEBDBB2B48A@kernel.crashing.org>
References: <1184060662530-git-send-email-wei.zhang@freescale.com>
	<11840606624025-git-send-email-wei.zhang@freescale.com>
	<11840606621515-git-send-email-wei.zhang@freescale.com>
	<55F09B00-F81A-4B70-B0F7-2FEBDBB2B48A@kernel.crashing.org>
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

Hi, Segher,=20

> -----Original Message-----
> From: Segher Boessenkool [mailto:segher@kernel.crashing.org]=20
>=20
> > +		dma@21000{
> > +			compatible =3D "fsl,mpc8xxx-dma";
>=20
> Please use a real name, not this "xxx" stuff.

Does the "xxx" seems to be an evil name? :-)

>=20
> > +			reg =3D <21000 100>;
> > +			ranges =3D <0 21000 1000>;
>=20
> These overlap, that can't be right; it is just begging for
> trouble.

There is no overlap. The 'reg' is used for the register of DMA
controller. And the ranges is used for belows channel registers.

Such as ch0@100, reg=3D<100 80>, in fact, the ch0 register address is
0x21100.

>=20
> > +			ch0@100{
> > +				reg =3D <100 80>;
> > +				extended;
>=20
> I think you want a little more detailed property name
> than "extended" here?

I've explained it in [PATCH 1/4] Add DMA sector to
Documentation/powerpc/booting-without-of.txt file.
As below:
+    - extended : Set the DMA channel to work at extended chain mode.
+                 If not set, the DMA channel will work at basic
+                 chain mode.

Thanks!
Wei.
