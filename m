Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2A934DDEF3
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 10:52:14 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc: Enable MMU feature sections for inline asm
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20090429002620.13027125C1@localhost.localdomain>
References: <20090429002620.13027125C1@localhost.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-HXnnMUQgsYQ9a5RNvZQ/"
Date: Wed, 29 Apr 2009 10:52:13 +1000
Message-Id: <1240966333.7592.4.camel@localhost>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-HXnnMUQgsYQ9a5RNvZQ/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-04-29 at 10:26 +1000, Michael Neuling wrote:
> From: Milton Miller <miltonm@bga.com>
>=20
> powerpc: Enable MMU feature sections for inline asm
>=20
> This adds the ability to do MMU feature sections for inline asm.
>=20
> Signed-off-by: Milton Miller <miltonm@bga.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>=20
>  arch/powerpc/include/asm/feature-fixups.h |   25 ++++++++++++++++++++---=
--
>  1 file changed, 20 insertions(+), 5 deletions(-)
>=20
> Index: linux-2.6-ozlabs/arch/powerpc/include/asm/feature-fixups.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/feature-fixups.h
> +++ linux-2.6-ozlabs/arch/powerpc/include/asm/feature-fixups.h
> @@ -8,8 +8,6 @@
>   * 2 of the License, or (at your option) any later version.
>   */
> =20
> -#ifdef __ASSEMBLY__
> -
>  /*
>   * Feature section common macros
>   *
> @@ -23,10 +21,12 @@
>  /* 64 bits kernel, 32 bits code (ie. vdso32) */
>  #define FTR_ENTRY_LONG		.llong
>  #define FTR_ENTRY_OFFSET	.long 0xffffffff; .long
> +#elif defined(CONFIG_PPC64)
> +#define FTR_ENTRY_LONG		.llong
> +#define FTR_ENTRY_OFFSET	.llong
>  #else
> -/* 64 bit kernel 64 bit code, or 32 bit kernel 32 bit code */
> -#define FTR_ENTRY_LONG		PPC_LONG
> -#define FTR_ENTRY_OFFSET	PPC_LONG
> +#define FTR_ENTRY_LONG		.long
> +#define FTR_ENTRY_OFFSET	.long
>  #endif

This is a bit of a pity, I take it you can't nest stringify_in_c(). It
is probably worth a comment here about why you're not using PPC_LONG,
otherwise someone will try and "clean it up".

> @@ -141,6 +141,21 @@ label##5:					       	\
>  #define ALT_FW_FTR_SECTION_END_IFCLR(msk)	\
>  	ALT_FW_FTR_SECTION_END_NESTED_IFCLR(msk, 97)
> =20
> +#ifndef __ASSEMBLY__
> +
> +#define ASM_MMU_FTR_IF_X(string, estring, msk, val)		\
> +	stringify_in_c(BEGIN_MMU_FTR_SECTION)			\
> +	string "; "						\
> +	stringify_in_c(MMU_FTR_SECTION_ELSE)			\
> +	estring "; "						\
> +	stringify_in_c(ALT_MMU_FTR_SECTION_END((msk), (val)))

Just call it ASM_MMU_FTR_IF() ?  And "string" and "estring" don't mean
much to me.

cheers

--=-HXnnMUQgsYQ9a5RNvZQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkn3pL0ACgkQdSjSd0sB4dKRMwCfSiih962TRuIg5CC2nCqS3cm8
RDQAnAxsvgb240FpAKWrs/uLYtun3QJQ
=ybHS
-----END PGP SIGNATURE-----

--=-HXnnMUQgsYQ9a5RNvZQ/--
