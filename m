Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BqT51Tg0zF1WD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 03:09:44 +1100 (AEDT)
Date: Thu, 29 Mar 2018 18:09:22 +0200
Message-ID: <20180329180922.Horde.Mtq3N9paq5gkMn9QcIUlGQ1@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Paul
 Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 02/19] powerpc/powermac: Mark variable x as unused
References: <20180322202007.23088-3-malat@debian.org>
 <20180328193028.823-1-malat@debian.org>
In-Reply-To: <20180328193028.823-1-malat@debian.org>
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

> Since the value of x is never intended to be read, remove it. Fix warning
> treated as error with W=3D1:
>
>   arch/powerpc/platforms/powermac/udbg_scc.c:76:9: error: variable=20=20
>=20=E2=80=98x=E2=80=99 set but not used [-Werror=3Dunused-but-set-variable=
]
>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
> v2: remove x completely
>
>  arch/powerpc/platforms/powermac/udbg_scc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powermac/udbg_scc.c=20=20
>=20b/arch/powerpc/platforms/powermac/udbg_scc.c
> index d83135a9830e..8901973ed683 100644
> --- a/arch/powerpc/platforms/powermac/udbg_scc.c
> +++ b/arch/powerpc/platforms/powermac/udbg_scc.c
> @@ -73,7 +73,7 @@ void udbg_scc_init(int force_scc)
>  	struct device_node *stdout =3D NULL, *escc =3D NULL, *macio =3D NULL;
>  	struct device_node *ch, *ch_def =3D NULL, *ch_a =3D NULL;
>  	const char *path;
> -	int i, x;
> +	int i;
>
>  	escc =3D of_find_node_by_name(NULL, "escc");
>  	if (escc =3D=3D NULL)
> @@ -120,7 +120,7 @@ void udbg_scc_init(int force_scc)
>  	mb();
>
>  	for (i =3D 20000; i !=3D 0; --i)
> -		x =3D in_8(sccc);
> +		in_8(sccc);
>  	out_8(sccc, 0x09);		/* reset A or B side */
>  	out_8(sccc, 0xc0);
>
> --
> 2.11.0
