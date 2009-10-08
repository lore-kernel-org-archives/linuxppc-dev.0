Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 61CF4B7B7E
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 07:48:12 +1100 (EST)
Date: Thu, 8 Oct 2009 22:48:08 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
Message-ID: <20091008204808.GB8116@pengutronix.de>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40910080737l5b21654cw9c8f7426f9faf7c3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
In-Reply-To: <fa686aa40910080737l5b21654cw9c8f7426f9faf7c3@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I think in general, this is the right direction; but I'm not convinced
> that the right pattern or form has been found yet.  What I don't like
> on this particular patch is that it still hooks of-specific stuff into
> an arbitrary point in the probe routine.
>=20
> I'd like to see some pattern for retrieving or populating a
> platform_data structure when one isn't already provided, and
> regardless of the data source.

I thought about this, too. I just wondered how many drivers would actually =
need
a 'pdata'-preparation routine before probe, and if this would not cause too
much overhead for those who don't. But as you say OF might not the only case
where this is needed, then it might be a reasonable choice to have an extra
call fot setting up pdata. Then again, if we have preparation routines for
OF,UEFI,... for each and every driver, uh, the bloat :(

> will take a bit of experimentation to come up with the best form for
> the pdata fetching function, but it will be better contained if it is
> all at a single place.

I might have a try :)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrOUAgACgkQD27XaX1/VRug2QCfbCkq7dvWlwpUzTgNQc4emV9y
GWYAmwcK5V1ujwnqQeL4JtZgzAGXi8qj
=CsZx
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
