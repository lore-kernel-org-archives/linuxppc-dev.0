Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 12/15] powerpc: Do not use op_model_cell under LPAR
From: Michael Ellerman <michael@ellerman.id.au>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200612120402.kBC42USg007674@toshiba.co.jp>
References: <200612120402.kBC42USg007674@toshiba.co.jp>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-21Yy7xyQj/UZXPStQq7i"
Date: Tue, 12 Dec 2006 15:13:11 +1100
Message-Id: <1165896791.14839.7.camel@concordia.ozlabs.ibm.com>
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


--=-21Yy7xyQj/UZXPStQq7i
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-12-12 at 13:02 +0900, Ishizaki Kou wrote:
> op_model_cell supports native Cell processor. Under LPAR environment,
> it cannot work.
>=20
> Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>
> ---
>=20
> Index: linux-powerpc-git/arch/powerpc/oprofile/common.c
> diff -u linux-powerpc-git/arch/powerpc/oprofile/common.c:1.1.1.1 linux-po=
werpc-git/arch/powerpc/oprofile/common.c:1.2
> --- linux-powerpc-git/arch/powerpc/oprofile/common.c:1.1.1.1	Wed Dec  6 0=
8:25:43 2006
> +++ linux-powerpc-git/arch/powerpc/oprofile/common.c	Wed Dec  6 08:43:15 =
2006
> @@ -149,6 +149,8 @@
>  #ifdef CONFIG_PPC64
>  #ifdef CONFIG_PPC_CELL_NATIVE
>  		case PPC_OPROFILE_CELL:
> +			if (firmware_has_feature(FW_FEATURE_LPAR))
> +				return -ENODEV;
>  			model =3D &op_model_cell;
>  			break;
>  #endif

Is FW_FEATURE_LPAR is the right switch to use here, I'm not sure.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-21Yy7xyQj/UZXPStQq7i
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFfixXdSjSd0sB4dIRAp2XAJ9z2V/TIcgkavDSGD5fbxEOCTUk4ACeONTg
5EBn7OrLQN7ewOLx4zkzV7M=
=MLjK
-----END PGP SIGNATURE-----

--=-21Yy7xyQj/UZXPStQq7i--
