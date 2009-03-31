Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 777C8DDEDA
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 00:56:34 +1100 (EST)
Date: Tue, 31 Mar 2009 15:56:29 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 1/2] powerpc: i2c-mpc: preserve I2C clocking
Message-ID: <20090331135629.GC3044@pengutronix.de>
References: <20090331125028.066613801@denx.de>
	<20090331125451.600446749@denx.de>
	<20090331133953.GB3044@pengutronix.de>
	<49D21EF1.9050200@grandegger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
In-Reply-To: <49D21EF1.9050200@grandegger.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> -=09
> >> -	mpc_i2c_setclock(i2c);
> >> +
> >> +	if (set_clock)
> >> +		mpc_i2c_setclock(i2c);
> >=20
> > Can't we drop 'set_clock' with something like this here?
> >=20
> > +	if (!of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
> > +
> > +		if (of_get_property(op->node, "dfsrr", NULL))
> > +			i2c->flags |=3D FSL_I2C_DEV_SEPARATE_DFSRR;
> > +
> > +		if (of_device_is_compatible(op->node, "fsl,mpc5200-i2c") ||
> > +		    of_device_is_compatible(op->node, "mpc5200-i2c"))
> > +			i2c->flags |=3D FSL_I2C_DEV_CLOCK_5200;
> > +
> > +		mpc_i2c_setclock(i2c);
> > +	}
>=20
> No, because the I2C registers are not yet mapped.

Sorry, I used misleading words :) With 'here' I meant 'at this
position', i.e. insert my above block where mpc_i2c_setclock was used
anyway.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknSIQ0ACgkQD27XaX1/VRtgGgCaA8NXZCaycG9m10echwEbflPH
0h4An1f+rODAfKMA7sQBtcMauawjHmc4
=mWLk
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
