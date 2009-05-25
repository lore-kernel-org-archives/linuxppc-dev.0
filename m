Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 19947DE0F6
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 07:47:25 +1000 (EST)
Date: Mon, 25 May 2009 23:47:18 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Albrecht =?iso-8859-1?Q?Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: Weird 5200/mtd-ram problem
Message-ID: <20090525214718.GA8152@pengutronix.de>
References: <20090520200135.GB13287@pengutronix.de> <1243273283.3328.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
In-Reply-To: <1243273283.3328.0@antares>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> A word or long copy of 0x0055aaff with U-Boot works fine, but a byte =20
> copy filled the whole ram with 0x0000aaaa.  The reason is apparently =20
> that the chip is attached to the local bus in 16-bit mode, which is =20
> incompatible with byte accesses.  However, the Local Bus doesn't provide=
=20
> "low byte" or "high byte" indicators in non-muxed mode.  How is this=20
> supposed to work then?

Hmm, as I feared... we were bitten by this, too:

http://thread.gmane.org/gmane.linux.drivers.mtd/21521

There is no generic solution yet :(

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkobEeYACgkQD27XaX1/VRuz6ACgs076O6PA4epfGDqmhuYgPAex
v/MAn3SBxXUTRYuIbTceW+KUEvTcXEPW
=sn6v
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
