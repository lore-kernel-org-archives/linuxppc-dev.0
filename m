Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 7/8] powerpc: implement crash_setup_regs for ppc32
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080801141427.GG1161@polina.dev.rtsoft.ru>
References: <20080801141306.GA29127@polina.dev.rtsoft.ru>
	<20080801141427.GG1161@polina.dev.rtsoft.ru>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-klSIho5wt4p3r23t4nqV"
Date: Thu, 07 Aug 2008 20:32:56 +1000
Message-Id: <1218105176.7914.4.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-klSIho5wt4p3r23t4nqV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-08-01 at 18:14 +0400, Anton Vorontsov wrote:
> From: Dale Farnsworth <dale@farnsworth.org>
>=20
> Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

> @@ -51,6 +50,7 @@ static inline void crash_setup_regs(struct pt_regs *new=
regs,
>  	else {
>  		/* FIXME Merge this with xmon_save_regs ?? */
>  		unsigned long tmp1, tmp2;
> +#ifdef __powerpc64__
>  		__asm__ __volatile__ (
>  			"std    0,0(%2)\n"
>  			"std    1,8(%2)\n"
> @@ -99,16 +99,58 @@ static inline void crash_setup_regs(struct pt_regs *n=
ewregs,
>  			: "=3D&r" (tmp1), "=3D&r" (tmp2)
>  			: "b" (newregs)
>  			: "memory");
> +#else /* __powerpc64__ */
> +		__asm__ __volatile__ (
> +			"stw    0,0(%2)\n"
> +			"stw    1,4(%2)\n"
> +			"stw    2,8(%2)\n"
> +			"stw    3,12(%2)\n"
> +			"stw    4,16(%2)\n"
> +			"stw    5,20(%2)\n"
> +			"stw    6,24(%2)\n"
> +			"stw    7,28(%2)\n"
> +			"stw    8,32(%2)\n"

..

Hi Anton,

You should be able to avoid any use of #ifdefs in this routine. Look at
SAVE_GPR() and friends in asm/ppc_asm.h.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-klSIho5wt4p3r23t4nqV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIms9YdSjSd0sB4dIRApBjAJ45LeuSwYC09vghrJsNQFbMXW9PHgCbBk4F
cnxkdBOVPrZY6Ae/vUWq0tY=
=Jwp1
-----END PGP SIGNATURE-----

--=-klSIho5wt4p3r23t4nqV--
