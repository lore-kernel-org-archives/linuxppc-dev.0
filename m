Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] of/flattree: use callback to setup initrd from /chosen
From: Michael Ellerman <michael@ellerman.id.au>
To: Jeremy Kerr <jeremy.kerr@canonical.com>
In-Reply-To: <1261474791.289871.854376051633.1.gpush@pororo>
References: <1261474791.289871.854376051633.1.gpush@pororo>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-KrmK5jScTDR/5IkVIssI"
Date: Tue, 22 Dec 2009 21:47:48 +1100
Message-ID: <1261478868.10767.2.camel@concordia>
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


--=-KrmK5jScTDR/5IkVIssI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-12-22 at 17:39 +0800, Jeremy Kerr wrote:
> At present, the fdt code sets the kernel-wide initrd_start and
> initrd_end variables when parsing /chosen. On ARM, we only set these
> once the bootmem has been reserved.
>=20
> This change adds an arch callback to setup the initrd from the device
> tree:
>=20
>  void early_init_dt_setup_initrd_arch(unsigned long start,
> 				      unsigned long end);

arch_early_init_dt_setup_initrd() makes more sense to me, but ..

> +#ifdef CONFIG_BLK_DEV_INITRD
> +void __init early_init_dt_setup_initrd_arch(unsigned long start,
> +		unsigned long end)
> +{
> +	initrd_start =3D (unsigned long)__va(start);
> +	initrd_end =3D (unsigned long)__va(end);
> +	initrd_below_start_ok =3D 1;
> +}
> +#endif

Given you have two identical implementations why not make that the
default and make it weak, and let ARM override it.

cheers



--=-KrmK5jScTDR/5IkVIssI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkswo9AACgkQdSjSd0sB4dIdMgCgvF4W8MGiNrOwiZ5YJXzyqNiP
vskAn39avWrLiMN1s8MJ9G4ey9Lg+Mlq
=l4Gm
-----END PGP SIGNATURE-----

--=-KrmK5jScTDR/5IkVIssI--
