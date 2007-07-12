Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] fix showing xmon help
From: Michael Ellerman <michael@ellerman.id.au>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <20070712.165915.-1300535948.kouish@swc.toshiba.co.jp>
References: <20070712.165915.-1300535948.kouish@swc.toshiba.co.jp>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-M6MxDqU8+o7B0BkM2x3I"
Date: Fri, 13 Jul 2007 09:53:50 +1000
Message-Id: <1184284430.25007.5.camel@concordia.ozlabs.ibm.com>
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


--=-M6MxDqU8+o7B0BkM2x3I
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-07-12 at 16:59 +0900, Ishizaki Kou wrote:
> In some configuration, xmon help string is larger than xmon output
> buffer.  To show whole help string, this patch splits it into 2 parts.
>=20
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

Nice catch! I've seen that a few times, but thought it was a flow
control problem on the console.


> Index: linux-powerpc-git/arch/powerpc/xmon/xmon.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /home/public/cvs/linux-powerpc-git/arch/powerpc/xmon/xmon.c,v
> retrieving revision 1.1.1.7
> diff -u -p -r1.1.1.7 xmon.c
> --- linux-powerpc-git/arch/powerpc/xmon/xmon.c	11 Jul 2007 02:15:32 -0000=
	1.1.1.7
> +++ linux-powerpc-git/arch/powerpc/xmon/xmon.c	11 Jul 2007 10:08:41 -0000
> @@ -182,7 +182,7 @@ extern void xmon_save_regs(struct pt_reg
>  			 || ('A' <=3D (c) && (c) <=3D 'Z'))
>  #define isspace(c)	(c =3D=3D ' ' || c =3D=3D '\t' || c =3D=3D 10 || c =
=3D=3D 13 || c =3D=3D 0)
> =20
> -static char *help_string =3D "\
> +static char *help_string1 =3D "\
>  Commands:\n\
>    b	show breakpoints\n\
>    bd	set data breakpoint\n\
> @@ -210,7 +210,9 @@ Commands:\n\
>    md	compare two blocks of memory\n\
>    ml	locate a block of memory\n\
>    mz	zero a block of memory\n\
> -  mi	show information about memory allocation\n\
> +  mi	show information about memory allocation\n"
> +;
> +static char *help_string2 =3D "\
>    p 	call a procedure\n\
>    r	print registers\n\
>    s	single step\n"
> @@ -833,7 +835,8 @@ cmds(struct pt_regs *excp)
>  			mdelay(2000);
>  			return cmd;
>  		case '?':
> -			printf(help_string);
> +			printf(help_string1);
> +			printf(help_string2);
>  			break;
>  		case 'b':
>  			bpt_cmds();


I'm not sure I like the fix though, it's a bit of a kludge :)

We don't actually need to printf() the help string, so what'd be nicer
is to add an xmon_puts() to arch/powerpc/xmon/nonstdio.c which just
calls xmon_write(s, strlen(s)) and use that for printing the help
string.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-M6MxDqU8+o7B0BkM2x3I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGlr8OdSjSd0sB4dIRAms3AJ9DXa8cj3VtIqnB9rfjX+mF50HFVACfXciw
34ShKm4sbkK3QwG3KLfltEc=
=SI2Y
-----END PGP SIGNATURE-----

--=-M6MxDqU8+o7B0BkM2x3I--
