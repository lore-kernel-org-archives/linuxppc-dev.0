Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Fix CHRP platforms with only 8259
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1161744878.22582.5.camel@localhost.localdomain>
References: <1161744878.22582.5.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xah3w+IQTYnuqGJS5g8k"
Date: Wed, 25 Oct 2006 13:11:57 +1000
Message-Id: <1161745918.3800.16.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-xah3w+IQTYnuqGJS5g8k
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-10-25 at 12:54 +1000, Benjamin Herrenschmidt wrote:
> On CHRP platforms with only a 8259 controller, we should set the
> default IRQ host to the 8259 driver's one for the IRQ probing
> fallbacks to work in case the IRQ tree is incorrect (like on
> Pegasos for example). Without this fix, we get a bunch of WARN_ON's
> during boot.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
>=20
> Index: linux-cell/arch/powerpc/platforms/chrp/setup.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-cell.orig/arch/powerpc/platforms/chrp/setup.c	2006-10-09 12:03:=
33.000000000 +1000
> +++ linux-cell/arch/powerpc/platforms/chrp/setup.c	2006-10-25 12:51:18.00=
0000000 +1000
> @@ -477,8 +477,10 @@ static void __init chrp_find_8259(void)
>  		       " address, polling\n");
> =20
>  	i8259_init(pic, chrp_int_ack);
> -	if (ppc_md.get_irq =3D=3D NULL)
> +	if (ppc_md.get_irq =3D=3D NULL) {
>  		ppc_md.get_irq =3D i8259_irq;
> +		irq_set_default_host(i8259_get_host());
> +	}
>  	if (chrp_mpic !=3D NULL) {
>  		cascade_irq =3D irq_of_parse_and_map(pic, 0);
>  		if (cascade_irq =3D=3D NO_IRQ)
> Index: linux-cell/arch/powerpc/sysdev/i8259.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-cell.orig/arch/powerpc/sysdev/i8259.c	2006-10-09 12:03:33.00000=
0000 +1000
> +++ linux-cell/arch/powerpc/sysdev/i8259.c	2006-10-25 12:51:58.000000000 =
+1000
> @@ -13,6 +13,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
> +#include <linux/module.h>
>  #include <asm/io.h>
>  #include <asm/i8259.h>
>  #include <asm/prom.h>

You don't need module.h anymore do you ? :D

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-xah3w+IQTYnuqGJS5g8k
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFPtX9dSjSd0sB4dIRAuNhAJ9orPcFOm8rChxGhdi+LSD5vnmp8wCgxnUB
PVkzqweuRvm1LG2d1nvRXOA=
=cjTX
-----END PGP SIGNATURE-----

--=-xah3w+IQTYnuqGJS5g8k--
