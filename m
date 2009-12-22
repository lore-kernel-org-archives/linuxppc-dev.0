Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] of/flattree: use callback to setup initrd from /chosen
From: Michael Ellerman <michael@ellerman.id.au>
To: Jeremy Kerr <jeremy.kerr@canonical.com>
In-Reply-To: <200912221854.37572.jeremy.kerr@canonical.com>
References: <1261474791.289871.854376051633.1.gpush@pororo>
	<1261478868.10767.2.camel@concordia>
	<200912221854.37572.jeremy.kerr@canonical.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-Fb0vQwplt2gfctQX9vPJ"
Date: Wed, 23 Dec 2009 00:17:36 +1100
Message-ID: <1261487856.10767.128.camel@concordia>
Mime-Version: 1.0
Cc: microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-Fb0vQwplt2gfctQX9vPJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-12-22 at 18:54 +0800, Jeremy Kerr wrote:
> Hi Michael,
>=20
> > >  void early_init_dt_setup_initrd_arch(unsigned long start,
> > > 				      unsigned long end);
> >=20
> > arch_early_init_dt_setup_initrd() makes more sense to me, but ..
>=20
> <foo>_arch has been the general convention for arch-specific hooks in=20
> drivers/of/.

Yuck, doh, guess I should have read those patches before they went in :)

> > > +#ifdef CONFIG_BLK_DEV_INITRD
> > > +void __init early_init_dt_setup_initrd_arch(unsigned long start,
> > > +		unsigned long end)
> > > +{
> > > +	initrd_start =3D (unsigned long)__va(start);
> > > +	initrd_end =3D (unsigned long)__va(end);
> > > +	initrd_below_start_ok =3D 1;
> > > +}
> > > +#endif
> >=20
> > Given you have two identical implementations why not make that the
> > default and make it weak, and let ARM override it.
>=20
> Yeah, that would be good too; just been avoiding weak as a potential sour=
ce of=20
> magic voodoo complexity. Grant - up to you on this one.

Yeah, depends on what toolchains you're supporting, modern ones should
be OK but it can be troublesome.

cheers



--=-Fb0vQwplt2gfctQX9vPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkswxvAACgkQdSjSd0sB4dKOOwCfdkTWwS3PZrrvukngLue5mCaY
5V8AnjvglCFpvlmjWVedQkqzEGF3lQ+o
=Ik6W
-----END PGP SIGNATURE-----

--=-Fb0vQwplt2gfctQX9vPJ--
