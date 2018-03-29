Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BqZr5lVSzF0my
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 03:14:44 +1100 (AEDT)
Date: Thu, 29 Mar 2018 18:14:22 +0200
Message-ID: <20180329181422.Horde.4gvIQbpSZkuyC4Yzg06PKw2@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Paul
 Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 03/19] powerpc: Mark variables as unused
References: <20180322202007.23088-4-malat@debian.org>
 <20180328193307.978-1-malat@debian.org>
In-Reply-To: <20180328193307.978-1-malat@debian.org>
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

> Add gcc attribute unused for two variables. Fix warnings treated as error=
s
> with W=3D1:
>
>   arch/powerpc/kernel/prom_init.c:1388:8: error: variable =E2=80=98path=
=E2=80=99 set=20=20
>=20but not used [-Werror=3Dunused-but-set-variable]
>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v2: move path within ifdef DEBUG_PROM
>
>  arch/powerpc/kernel/prom_init.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom_init.c=20=20
>=20b/arch/powerpc/kernel/prom_init.c
> index acf4b2e0530c..4163b11abb6c 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -603,7 +603,7 @@ static void __init early_cmdline_parse(void)
>  	const char *opt;
>
>  	char *p;
> -	int l =3D 0;
> +	int l __maybe_unused =3D 0;
>
>  	prom_cmd_line[0] =3D 0;
>  	p =3D prom_cmd_line;
> @@ -1385,7 +1385,7 @@ static void __init reserve_mem(u64 base, u64 size)
>  static void __init prom_init_mem(void)
>  {
>  	phandle node;
> -	char *path, type[64];
> +	char *path __maybe_unused, type[64];

You should enclose that in an ifdef DEBUG_PROM instead of hiding the warnin=
g

Christophe

>  	unsigned int plen;
>  	cell_t *p, *endp;
>  	__be32 val;
> @@ -1406,7 +1406,6 @@ static void __init prom_init_mem(void)
>  	prom_debug("root_size_cells: %x\n", rsc);
>
>  	prom_debug("scanning memory:\n");
> -	path =3D prom_scratch;
>
>  	for (node =3D 0; prom_next_node(&node); ) {
>  		type[0] =3D 0;
> @@ -1431,6 +1430,7 @@ static void __init prom_init_mem(void)
>  		endp =3D p + (plen / sizeof(cell_t));
>
>  #ifdef DEBUG_PROM
> +		path =3D prom_scratch;
>  		memset(path, 0, PROM_SCRATCH_SIZE);
>  		call_prom("package-to-path", 3, 1, node, path, PROM_SCRATCH_SIZE-1);
>  		prom_debug("  node %s :\n", path);
> --
> 2.11.0
