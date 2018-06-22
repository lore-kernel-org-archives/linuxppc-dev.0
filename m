Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ot0-f194.google.com (mail-ot0-f194.google.com
 [74.125.82.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Btzg687rzF0Vt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 19:48:15 +1000 (AEST)
Received: by mail-ot0-f194.google.com with SMTP id 101-v6so6859329oth.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 02:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180328193307.978-1-malat@debian.org>
 <20180404200836.27446-1-malat@debian.org>
In-Reply-To: <20180404200836.27446-1-malat@debian.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 22 Jun 2018 11:48:02 +0200
Message-ID: <CA+7wUswQGhQS6FTdRkGhhJKFbfoVpmzwWdT_9GoOicEF0OXFPQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/19] powerpc: Move `path` variable inside DEBUG_PROM
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This one should be ok.

On Wed, Apr 4, 2018 at 10:08 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> Add gcc attribute unused for two variables. Fix warnings treated as error=
s
> with W=3D1:
>
>   arch/powerpc/kernel/prom_init.c:1388:8: error: variable =E2=80=98path=
=E2=80=99 set but not used [-Werror=3Dunused-but-set-variable]
>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v3: really move path within ifdef DEBUG_PROM
> v2: move path within ifdef DEBUG_PROM
>
>  arch/powerpc/kernel/prom_init.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_i=
nit.c
> index acf4b2e0530c..223b35acbbdd 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -603,7 +603,7 @@ static void __init early_cmdline_parse(void)
>         const char *opt;
>
>         char *p;
> -       int l =3D 0;
> +       int l __maybe_unused =3D 0;
>
>         prom_cmd_line[0] =3D 0;
>         p =3D prom_cmd_line;
> @@ -1385,7 +1385,10 @@ static void __init reserve_mem(u64 base, u64 size)
>  static void __init prom_init_mem(void)
>  {
>         phandle node;
> -       char *path, type[64];
> +#ifdef DEBUG_PROM
> +       char *path;
> +#endif
> +       char type[64];
>         unsigned int plen;
>         cell_t *p, *endp;
>         __be32 val;
> @@ -1406,7 +1409,9 @@ static void __init prom_init_mem(void)
>         prom_debug("root_size_cells: %x\n", rsc);
>
>         prom_debug("scanning memory:\n");
> +#ifdef DEBUG_PROM
>         path =3D prom_scratch;
> +#endif
>
>         for (node =3D 0; prom_next_node(&node); ) {
>                 type[0] =3D 0;
> --
> 2.11.0
>
