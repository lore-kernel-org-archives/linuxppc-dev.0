Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] xmon consistency clean up
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1185344499.5439.307.camel@localhost.localdomain>
References: <200707250257.l6P2va65006958@toshiba.co.jp>
	<1185344499.5439.307.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Je4XqPVY/h3H1If3QiUx"
Date: Wed, 25 Jul 2007 22:13:50 +1000
Message-Id: <1185365630.21877.4.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Je4XqPVY/h3H1If3QiUx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-07-25 at 16:21 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2007-07-25 at 11:57 +0900, Ishizaki Kou wrote:
> > This patch cleans up xmon to keep consistency.
> >=20
> > In xmon, we should use console I/O functions that are named the same
> > as user space stdio functions. But commit
> > 4d404edce30f911004850d472e05a31efd751662 broke this consistency.
> >=20
> > Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> > ---
> >=20
> > Index: linux-powerpc-git/arch/powerpc/xmon/nonstdio.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-powerpc-git.orig/arch/powerpc/xmon/nonstdio.c
> > +++ linux-powerpc-git/arch/powerpc/xmon/nonstdio.c
> > @@ -133,7 +133,7 @@ void xmon_printf(const char *format, ...
> >         xmon_write(xmon_outbuf, n);
> >  }
> > =20
> > -void xmon_puts(const char *str)
> > +void xmon_fputs(const char *str)
> >  {
> >         xmon_write(str, strlen(str));=20
>=20
> Nah, keep it xmon_puts, since it doesn't take a stream argument and
> define a "puts" for use by xmon core.

But then it needs to add a newline .. and we've gone around in a circle
again. Funny how the trivialest of patches gets the most review.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Je4XqPVY/h3H1If3QiUx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGpz5+dSjSd0sB4dIRAqQGAKCXbOB6Vxez++9gdFuoajJXp6yOKACgiJ7m
n2DRO3WbbFRfKpNQB0ZbDow=
=pi/t
-----END PGP SIGNATURE-----

--=-Je4XqPVY/h3H1If3QiUx--
