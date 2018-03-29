Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BqRB0mtqzF0wQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 03:08:06 +1100 (AEDT)
Date: Thu, 29 Mar 2018 18:07:43 +0200
Message-ID: <20180329180743.Horde.0e_zt3S4Pqcv7Z0dJwOgOg9@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Paul
 Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 01/19] powerpc/powermac: Mark variable x as unused
References: <20180322202007.23088-2-malat@debian.org>
 <20180328192717.656-1-malat@debian.org>
In-Reply-To: <20180328192717.656-1-malat@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mathieu Malaterre <malat@debian.org> a =C3=A9crit=C2=A0:

> Since the value of x is never intended to be read, declare it with gcc
> attribute as unused. Fix warning treated as error with W=3D1:
>
>   arch/powerpc/platforms/powermac/bootx_init.c:471:21: error:=20=20
>=20variable =E2=80=98x=E2=80=99 set but not used [-Werror=3Dunused-but-set=
-variable]
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v2: move x variable within its local scope
>
>  arch/powerpc/platforms/powermac/bootx_init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powermac/bootx_init.c=20=20
>=20b/arch/powerpc/platforms/powermac/bootx_init.c
> index c3c9bbb3573a..d44e8571c1ec 100644
> --- a/arch/powerpc/platforms/powermac/bootx_init.c
> +++ b/arch/powerpc/platforms/powermac/bootx_init.c
> @@ -468,7 +468,7 @@ void __init bootx_init(unsigned long r3,=20=20
>=20unsigned long r4)
>  	boot_infos_t *bi =3D (boot_infos_t *) r4;
>  	unsigned long hdr;
>  	unsigned long space;
> -	unsigned long ptr, x;
> +	unsigned long ptr;
>  	char *model;
>  	unsigned long offset =3D reloc_offset();
>
> @@ -562,6 +562,7 @@ void __init bootx_init(unsigned long r3,=20=20
>=20unsigned long r4)
>  	 * MMU switched OFF, so this should not be useful anymore.
>  	 */
>  	if (bi->version < 4) {
> +		unsigned long x __maybe_unused;
>  		bootx_printf("Touching pages...\n");

Stylewise, there should be an empty line after your declaration.

But I believe you should remove that ugly loop and replace it by a=20=20
call=20to fault_in_pages_readable()

Christophe
>
>  		/*
> --
> 2.11.0
