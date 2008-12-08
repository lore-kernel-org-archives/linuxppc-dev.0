Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Fix build of 4xx simple platforms without
	CONFIG_PCI
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20081208045411.0CE03DDE0E@ozlabs.org>
References: <20081208045411.0CE03DDE0E@ozlabs.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-HsckF6/UBVrnt8TWidJ1"
Date: Mon, 08 Dec 2008 16:32:09 +1100
Message-Id: <1228714329.23242.52.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-HsckF6/UBVrnt8TWidJ1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-12-08 at 15:53 +1100, Benjamin Herrenschmidt wrote:
> The global ppc_pci_flags is not defined when CONFIG_PCI is not
> set, causing a link error
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>=20
>  arch/powerpc/platforms/40x/ppc40x_simple.c |    2 ++
>  arch/powerpc/platforms/44x/ppc44x_simple.c |    2 ++
>  2 files changed, 4 insertions(+)
>=20
> --- linux-work.orig/arch/powerpc/platforms/40x/ppc40x_simple.c	2008-12-08=
 15:51:49.000000000 +1100
> +++ linux-work/arch/powerpc/platforms/40x/ppc40x_simple.c	2008-12-08 15:5=
1:52.000000000 +1100
> @@ -61,7 +61,9 @@ static int __init ppc40x_probe(void)
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(board); i++) {
>  		if (of_flat_dt_is_compatible(root, board[i])) {
> +#ifdef CONFIG_PCI
>  			ppc_pci_flags =3D PPC_PCI_REASSIGN_ALL_RSRC;
> +#endif

No! #ifdefs! in C code!

To the tune of you-know-what.

Looks like we need an accessor we can replace with an empty version in
the !PCI case.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-HsckF6/UBVrnt8TWidJ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkk8sVkACgkQdSjSd0sB4dIDlwCgkPnjoZ1T/j9gAKsO2rtKpmwP
P8YAn06427BrI7EimT7IMib3ie9QpJsy
=EYxn
-----END PGP SIGNATURE-----

--=-HsckF6/UBVrnt8TWidJ1--
