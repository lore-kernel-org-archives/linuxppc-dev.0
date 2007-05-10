Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Split initrd logic out of early_init_dt_scan_chosen()
	to fix warning
From: Michael Ellerman <michael@ellerman.id.au>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0705100947460.32241@pademelon.sonytel.be>
References: <20070510070645.15973DDEFE@ozlabs.org>
	<Pine.LNX.4.62.0705100947460.32241@pademelon.sonytel.be>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-cexy7YqsL7G3PpzJkkJd"
Date: Thu, 10 May 2007 17:57:48 +1000
Message-Id: <1178783868.3696.22.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-cexy7YqsL7G3PpzJkkJd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-05-10 at 09:48 +0200, Geert Uytterhoeven wrote:
> On Thu, 10 May 2007, Michael Ellerman wrote:
> > If CONFIG_BLK_DEV_INITRD is not defined the prop variable in
> > early_init_dt_scan_chosen() is unused, causing a compiler warning.
> >=20
> > So split the initrd logic into a separate function, allowing us to
> > declare prop only when we need it.
> >=20
> > Built for both cases and booted with an initrd.
> >=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > ---
> >=20
> >  arch/powerpc/kernel/prom.c |   48 ++++++++++++++++++++++++++++++------=
---------
> >  1 file changed, 32 insertions(+), 16 deletions(-)
> >=20
> > Index: powerpc/arch/powerpc/kernel/prom.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- powerpc.orig/arch/powerpc/kernel/prom.c
> > +++ powerpc/arch/powerpc/kernel/prom.c
> > @@ -716,11 +716,41 @@ static int __init early_init_dt_scan_cpu
> >  	return 0;
> >  }
> > =20
> > +#ifdef CONFIG_BLK_DEV_INITRD
>=20
> > +#else
> > +static inline void early_init_dt_check_for_initrd(unsigned long node)
> > +{
> > +	return;
> > +}
> > +#endif /* CONFIG_BLK_DEV_INITRD */
>=20
> There's no need to use `return' in functions returning void.

I think it looks nicer :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-cexy7YqsL7G3PpzJkkJd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGQtB8dSjSd0sB4dIRAmZTAJ9P7kHEz1Y8nmtgEmzRwGDtiwgNQgCgsgmR
uBODSKLyf2Rec122nzLwyvw=
=+7SD
-----END PGP SIGNATURE-----

--=-cexy7YqsL7G3PpzJkkJd--
