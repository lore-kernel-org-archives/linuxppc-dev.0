Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH][resend] udbg_printf() formatting attribute
From: Michael Ellerman <michael@ellerman.id.au>
To: jimix@watson.ibm.com
In-Reply-To: <E1FgORv-0001dS-Hu@heater.watson.ibm.com>
References: <E1FgORv-0001dS-Hu@heater.watson.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-SzcKw9VYBr1Hfw8yA0XD"
Date: Thu, 18 May 2006 09:36:03 +1000
Message-Id: <1147908963.7360.1.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-SzcKw9VYBr1Hfw8yA0XD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-17 at 12:00 -0400, jimix@watson.ibm.com wrote:
> Sorry, Previous patch was munged by MTA.
>=20
> This patch allows the compiler to catch any printf-like mismatches for
> udbg_printf().  After some brute force building I've only found issues
> with my own code and lparcfg.c It could break some developers, but
> IMHO that would be goodness.
>=20
> Signed-off-by: Jimi Xenidis <jimix@watson.ibm.com>
>=20
> ---
>=20
> diff -r 0163968f7fce arch/powerpc/kernel/lparcfg.c
> --- a/arch/powerpc/kernel/lparcfg.c	Tue May 16 15:55:19 2006 -0400
> +++ b/arch/powerpc/kernel/lparcfg.c	Wed May 17 11:55:21 2006 -0400
> @@ -521,10 +521,10 @@ static ssize_t lparcfg_write(struct file
> =20
>  	current_weight =3D (resource >> 5 * 8) & 0xFF;
> =20
> -	pr_debug("%s: current_entitled =3D %lu, current_weight =3D %lu\n",
> +	pr_debug("%s: current_entitled =3D %lu, current_weight =3D %u\n",
>  		 __FUNCTION__, current_entitled, current_weight);
> =20
> -	pr_debug("%s: new_entitled =3D %lu, new_weight =3D %lu\n",
> +	pr_debug("%s: new_entitled =3D %lu, new_weight =3D %u\n",
>  		 __FUNCTION__, *new_entitled_ptr, *new_weight_ptr);

But pr_debug() calls printk, not udbg_printf() ?

cheers

> =20
>  	retval =3D plpar_hcall_norets(H_SET_PPP, *new_entitled_ptr,
> diff -r 0163968f7fce include/asm-powerpc/udbg.h
> --- a/include/asm-powerpc/udbg.h	Tue May 16 15:55:19 2006 -0400
> +++ b/include/asm-powerpc/udbg.h	Wed May 17 11:55:21 2006 -0400
> @@ -23,7 +23,8 @@ extern int udbg_read(char *buf, int bufl
>  extern int udbg_read(char *buf, int buflen);
> =20
>  extern void register_early_udbg_console(void);
> -extern void udbg_printf(const char *fmt, ...);
> +extern void udbg_printf(const char *fmt, ...)
> +	__attribute__ ((format (printf, 1, 2)));
>  extern void udbg_progress(char *s, unsigned short hex);
> =20
>  extern void udbg_init_uart(void __iomem *comport, unsigned int speed,

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-SzcKw9VYBr1Hfw8yA0XD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEa7NjdSjSd0sB4dIRArGgAKCtAU7sdmwPOmlz//W27ORlRy+mwwCfetiT
vpDyMkqu1MQjwFDTB8i+BGI=
=2xAS
-----END PGP SIGNATURE-----

--=-SzcKw9VYBr1Hfw8yA0XD--
