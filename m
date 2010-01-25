Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 52A1E1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 02:15:16 +1100 (EST)
Date: Mon, 25 Jan 2010 16:15:09 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/3] i2c-mpc: add support for the MPC512x processors
	from Freescale
Message-ID: <20100125151509.GD5257@pengutronix.de>
References: <1264408029-5290-1-git-send-email-wg@grandegger.com>
	<1264408029-5290-2-git-send-email-wg@grandegger.com>
	<1264408029-5290-3-git-send-email-wg@grandegger.com>
	<20100125115211.GA5257@pengutronix.de>
	<4B5D894C.4090001@grandegger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
In-Reply-To: <4B5D894C.4090001@grandegger.com>
Cc: Devicetree-discuss@lists.ozlabs.org, Linuxppc-dev@lists.ozlabs.org,
	Linux-i2c@vger.kernel.org, Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >> =20
> >> -static void __devinit mpc_i2c_setclock_52xx(struct device_node *node,
> >> -					    struct mpc_i2c *i2c,
> >> -					    u32 clock, u32 prescaler)
> >> +static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
> >> +					 struct mpc_i2c *i2c,
> >> +					 u32 clock, u32 prescaler)
> >>  {
> >>  	int ret, fdr;
> >> =20
> >> +	if (clock =3D=3D -1) {
> >=20
> > Could we use 0 for 'no_clock'? This would make the above statement simp=
ly
>=20
> "0" is already used to maintain backward compatibility setting a safe
> divider.

Ah, now I see:

'clock =3D=3D -1' means 'preserve clocks' (and is checked here in mpc_i2c_s=
etup_52xx())
'clock =3D=3D  0' means 'safe divider' (and is checked in mpc_i2c_get_fdr_5=
2xx())

This is not a beauty ;)

What about adding a flags variable to the setup-functions?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktdtX0ACgkQD27XaX1/VRto9gCeKr5dnO1hh2xD6qxiHdgrbBH6
8m4AnjUtyflmabrnXgxFpiVy/SXsnYon
=M41T
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--
