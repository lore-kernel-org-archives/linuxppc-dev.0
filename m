Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [v2] powerpc: MPIC: support more than 256 sources
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070129053318.GA7561@lixom.net>
References: <20070125213834.GA22121@lixom.net>
	<20070129053318.GA7561@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-8g9hhhD3g/QhPOcC1bBb"
Date: Mon, 29 Jan 2007 18:23:48 +1100
Message-Id: <1170055428.19887.62.camel@concordia.ozlabs.ibm.com>
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


--=-8g9hhhD3g/QhPOcC1bBb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-01-28 at 23:33 -0600, Olof Johansson wrote:
> Allow more than the default 256 MPIC sources. Allocates a new flag
> (MPIC_LARGE_VECTORS) to be used by platform code when instantiating
> the mpic.
>=20
> I picked 11 bits worth right now since it would cover the number of
> sources on any hardware I have seen. It can always be increased later
> if needed.
>=20
>=20
> Signed-off-by: Olof Johansson <olof@lixom.net>
>=20
> Index: merge/arch/powerpc/sysdev/mpic.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- merge.orig/arch/powerpc/sysdev/mpic.c
> +++ merge/arch/powerpc/sysdev/mpic.c
> @@ -944,6 +954,21 @@ struct mpic * __init mpic_alloc(struct d
>  	mpic->irq_count =3D irq_count;
>  	mpic->num_sources =3D 0; /* so far */
> =20
> +	if (flags & MPIC_LARGE_VECTORS)
> +		intvec_top =3D 2047;
> +	else
> +		intvec_top =3D 255;
> +
> +	mpic->timer_vecs[0] =3D intvec_top - 8;
> +	mpic->timer_vecs[1] =3D intvec_top - 7;
> +	mpic->timer_vecs[2] =3D intvec_top - 6;
> +	mpic->timer_vecs[3] =3D intvec_top - 5;
> +	mpic->ipi_vecs[0]   =3D intvec_top - 4;
> +	mpic->ipi_vecs[1]   =3D intvec_top - 3;
> +	mpic->ipi_vecs[2]   =3D intvec_top - 2;
> +	mpic->ipi_vecs[3]   =3D intvec_top - 1;
> +	mpic->spurious_vec  =3D intvec_top;

I like it :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-8g9hhhD3g/QhPOcC1bBb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFvaEEdSjSd0sB4dIRAjAGAJwP2kA/8kbQMgDVsvT8C2naSF+dAACeIfJz
DuSz+1ZXBbOpYwZW08A/shk=
=2eEw
-----END PGP SIGNATURE-----

--=-8g9hhhD3g/QhPOcC1bBb--
