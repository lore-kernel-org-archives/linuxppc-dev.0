Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40HkJ01mbkzF1yb
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Apr 2018 01:33:51 +1000 (AEST)
Date: Fri, 06 Apr 2018 17:33:35 +0200
Message-ID: <20180406173335.Horde.Qgml03BtHOxSl6SzIPgQLA9@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Paul
 Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 03/19] powerpc: Mark variable `l` as unused, remove
 `path`
References: <20180322202007.23088-4-malat@debian.org>
 <20180405202648.2836-1-malat@debian.org>
In-Reply-To: <20180405202648.2836-1-malat@debian.org>
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

> Add gcc attribute unused for `l` variable, replace `path` variable direct=
ly
> with prom_scratch. Fix warnings treated as errors with W=3D1:
>
>   arch/powerpc/kernel/prom_init.c:607:6: error: variable =E2=80=98l=E2=80=
=99 set but=20=20
>=20not used [-Werror=3Dunused-but-set-variable]
>   arch/powerpc/kernel/prom_init.c:1388:8: error: variable =E2=80=98path=
=E2=80=99 set=20=20
>=20but not used [-Werror=3Dunused-but-set-variable]
>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v4: redo v3 since path variable can be avoided
> v3: really move path within ifdef DEBUG_PROM
> v2: move path within ifdef DEBUG_PROM
>
>  arch/powerpc/kernel/prom_init.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom_init.c=20=20
>=20b/arch/powerpc/kernel/prom_init.c
> index f8a9a50ff9b5..4b223a9470be 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -604,7 +604,7 @@ static void __init early_cmdline_parse(void)
>  	const char *opt;
>
>  	char *p;
> -	int l =3D 0;
> +	int l __maybe_unused =3D 0;

Instead of hiding the problem with __maybe_unused, I think we could=20=20
replace=20the
#ifdef CONFIG_CMDLINE
by a
if (IS_ENABLED(CONFIG_CMDLINE_BOOL))

This is recommanded by Linux codying style

Christophe

>
>  	prom_cmd_line[0] =3D 0;
>  	p =3D prom_cmd_line;
> @@ -1386,7 +1386,7 @@ static void __init reserve_mem(u64 base, u64 size)
>  static void __init prom_init_mem(void)
>  {
>  	phandle node;
> -	char *path, type[64];
> +	char type[64];
>  	unsigned int plen;
>  	cell_t *p, *endp;
>  	__be32 val;
> @@ -1407,7 +1407,6 @@ static void __init prom_init_mem(void)
>  	prom_debug("root_size_cells: %x\n", rsc);
>
>  	prom_debug("scanning memory:\n");
> -	path =3D prom_scratch;
>
>  	for (node =3D 0; prom_next_node(&node); ) {
>  		type[0] =3D 0;
> @@ -1432,9 +1431,9 @@ static void __init prom_init_mem(void)
>  		endp =3D p + (plen / sizeof(cell_t));
>
>  #ifdef DEBUG_PROM
> -		memset(path, 0, PROM_SCRATCH_SIZE);
> -		call_prom("package-to-path", 3, 1, node, path, PROM_SCRATCH_SIZE-1);
> -		prom_debug("  node %s :\n", path);
> +		memset(prom_scratch, 0, PROM_SCRATCH_SIZE);
> +		call_prom("package-to-path", 3, 1, node, prom_scratch,=20=20
>=20PROM_SCRATCH_SIZE - 1);
> +		prom_debug("  node %s :\n", prom_scratch);
>  #endif /* DEBUG_PROM */
>
>  		while ((endp - p) >=3D (rac + rsc)) {
> --
> 2.11.0
