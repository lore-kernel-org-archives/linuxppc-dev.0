Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 21916DDED8
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Aug 2008 17:49:53 +1000 (EST)
Date: Wed, 27 Aug 2008 09:49:44 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: checkpatch nits ...
Message-ID: <20080827074944.GA4259@pengutronix.de>
References: <48AF5818.7010802@hypersurf.com> <200808231057.22399.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
In-Reply-To: <200808231057.22399.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Kevin Diggs <kevdig@hypersurf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2008 at 10:57:21AM +0200, Arnd Bergmann wrote:

> On Saturday 23 August 2008, Kevin Diggs wrote:
> > WARNING: externs should be avoided in .c files
> > #1137: FILE: powerpc/kernel/cpu/pll_if.c:369:
> > + =A0 =A0 =A0 __asm__ __volatile__ (
> >=20
> > ??? I don't know what this is?
> >=20
> > The entire block is:
> >=20
> > =A0=A0=A0=A0=A0=A0=A0=A0__asm__ __volatile__ (
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"addi %0,%3,-1\n"
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"andc %1,%3,%0\n"
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"cntlzw %1,%1\n"
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"subfic %1,%1,31\n"
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"cntlzw %0,%2\n":
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"=3Dr"(cntlz), "=3Dr"(c=
nttz):
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"r"(tmp), "b"(cnttz)
> > =A0=A0=A0=A0=A0=A0=A0=A0);
> >=20
>=20
> It's a bug in checkpatch, your code is correct (although I would write
> asm volatile, not __asm__ __volatile__, and add \t after each \n).
> Can you explain why you need that inline assembly? All you do in there
> are arithmetic operations, so you should be able to express that using
> C, or at least using the helpers we already have.
>=20
> Checkpatch thinks that what you wrote is a declaration for a function
> named __volatile__ returning a variable of type __asm__, and complains
> that this declaration belongs into a header file.

I wonder if checkpatch-maintainers read this list, so I put Andy
Whitcroft to CC.

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFItQcYD27XaX1/VRsRAtcsAJ97tv0Ur1Bn29IJnZ6QSHWnPCb5/wCeNdEr
87M6qqLUhOwa4GLAfI0+gqE=
=vgQM
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
