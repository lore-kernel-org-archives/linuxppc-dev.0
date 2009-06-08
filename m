Return-Path: <albrecht.dress@arcor.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 22E53B70C0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 03:31:02 +1000 (EST)
Date: Mon, 08 Jun 2009 19:30:45 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH V2 2/2] mtd/maps/mtd-ram: add an of-platform driver
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <20090608163540.GA16384@pengutronix.de> (from
	w.sang@pengutronix.de on Mon Jun  8 18:35:40 2009)
Message-Id: <1244482256.3278.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-97gFfBnOr0Mpi+yYBi41"
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-97gFfBnOr0Mpi+yYBi41
Content-Type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 08.06.09 18:35 schrieb(en) Wolfram Sang:
>> Question: why is bank-width even relevant for a RAM device?
>=20
> The underlying map_ram-driver uses it once while erasing. The =20
> question remains if this is really needed?

Am 06.06.09 18:16 schrieb(en) Albrecht Dre=DF:
> At least if the RAM is attached to the 5200's Local Plus Bus in =20
> 16-bit mode, no byte write accesses are allowed (byte /reads/ work, =20
> though).  I have a tweak (which I will post next week) to address =20
> this case, which depends upon this setting.

To put this clearer: on '5200 based systems, the driver (more specific: =20
the function inline_map_copy_to()) *must* know whether the hardware is =20
connected in 8-bit or 16-bit mode to the Local Plus Bus, as byte writes =20
(issued by memcpy_toio()) will fail for the latter setup (probably the =20
same applies for byte and word writes in 32-bit mode).

IMHO, this information should be passed using the device tree.  The =20
"bank-width" seems to be an obvious choice for that.

Best, Albrecht.

--=-97gFfBnOr0Mpi+yYBi41
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKLUrQn/9unNAn/9ERAlojAKCQcNeACQ0s+hriPt5oMQphSBrv2QCgquGu
2U7wswApUdESMZiYG64xdfk=
=ODlX
-----END PGP SIGNATURE-----

--=-97gFfBnOr0Mpi+yYBi41--
