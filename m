Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 388ADDE360
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 13:40:19 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n062dxfq002107
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 19:40:10 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n062dvfR018528
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 20:39:58 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc/8313erdb: fix kernel crash
Date: Tue, 6 Jan 2009 10:39:55 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED0B3873@zch01exm26.fsl.freescale.net>
In-Reply-To: <1C3FA775-7C2A-4218-BE14-95FF2DD9F6D2@kernel.crashing.org>
References: <1231152455-8296-1-git-send-email-leoli@freescale.com>
	<1C3FA775-7C2A-4218-BE14-95FF2DD9F6D2@kernel.crashing.org>
From: "Li Yang" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Tuesday, January 06, 2009 12:25 AM
> To: Li Yang-R58472
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] powerpc/8313erdb: fix kernel crash
>=20
>=20
> On Jan 5, 2009, at 4:47 AM, Li Yang wrote:
>=20
> > Probe the new mdio node added by b31a1d8b.  Fix kernel=20
> panic problem=20
> > when gianfar driver wants to get the of_platform_device of=20
> that mdio.
> >
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > arch/powerpc/boot/dts/mpc8313erdb.dts |    2 +-
> > 1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/=20
> > boot/dts/mpc8313erdb.dts index d4df8b6..917d466 100644
> > --- a/arch/powerpc/boot/dts/mpc8313erdb.dts
> > +++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
> > @@ -222,7 +222,7 @@
> > 			cell-index =3D <1>;
> > 			device_type =3D "network";
> > 			model =3D "eTSEC";
> > -			compatible =3D "gianfar";
> > +			compatible =3D "gianfar", "simple-bus";
> > 			reg =3D <0x25000 0x1000>;
> > 			local-mac-address =3D [ 00 00 00 00 00 00 ];
> > 			interrupts =3D <34 0x8 33 0x8 32 0x8>;
>=20
> This isn't correct at all.  Not sure what the panic is but=20
> adding "simple-bus" isn't correct.

The panic is caused because mdio node associated with this TSEC is not
probed.  It may be better to have more exception check in the gianfar
driver rather than panic directly.  Anyway, mdio need to be probed as
of_platform_device for it to work correctly with phy driver.

I'm not sure if adding "simple-bus" is the preferred solution.  It is
being discussed in a separate mail thread.

- Leo
