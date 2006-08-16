Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Make RTAS console init generic
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20060816040040.1E20967B55@ozlabs.org>
References: <20060816040040.1E20967B55@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-PNKyW5KJv4630LcmkXVt"
Date: Wed, 16 Aug 2006 15:21:35 +1000
Message-Id: <1155705695.12715.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-PNKyW5KJv4630LcmkXVt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-08-15 at 23:00 -0500, Michael Neuling wrote:
> The RTAS console doesn't have to be Cell specific.  If we have both
> the put and get char RTAS functions, init the rtas console.
>=20
> Index: linux-2.6-ozlabs/arch/powerpc/kernel/rtas.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-ozlabs.orig/arch/powerpc/kernel/rtas.c
> +++ linux-2.6-ozlabs/arch/powerpc/kernel/rtas.c
> @@ -910,6 +910,11 @@ int __init early_init_dt_scan_rtas(unsig
>  	basep =3D of_get_flat_dt_prop(node, "get-term-char", NULL);
>  	if (basep)
>  		rtas_getchar_token =3D *basep;
> +
> +	if (rtas_putchar_token !=3D RTAS_UNKNOWN_SERVICE &&
> +	    rtas_getchar_token !=3D RTAS_UNKNOWN_SERVICE)
> +		udbg_init_rtas_console();
> +
>  #endif
> =20
>  	/* break now */
> Index: linux-2.6-ozlabs/arch/powerpc/platforms/cell/setup.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-ozlabs.orig/arch/powerpc/platforms/cell/setup.c
> +++ linux-2.6-ozlabs/arch/powerpc/platforms/cell/setup.c
> @@ -150,10 +150,6 @@ static int __init cell_probe(void)
>  	    !of_flat_dt_is_compatible(root, "IBM,CPBW-1.0"))
>  		return 0;
> =20
> -#ifdef CONFIG_UDBG_RTAS_CONSOLE
> -	udbg_init_rtas_console();
> -#endif
> -

I'd like to see it still guarded by UDBG_RTAS_CONSOLE, otherwise there's
no way to select a different type of early console on a machine which
has those tokens in the device tree.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-PNKyW5KJv4630LcmkXVt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE4qtfdSjSd0sB4dIRArSLAKCG0d7fCkECAoztFURTE+cldV9XgQCgvTgP
HMa41pOLpGazOULLvni2WUg=
=BMuz
-----END PGP SIGNATURE-----

--=-PNKyW5KJv4630LcmkXVt--
