Return-Path: <srs0=7tpv=iq=gmail.com=mathieu.malaterre@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wC150h7KzDrBx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 21:58:33 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40wC1501dsz8tDD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 21:58:33 +1000 (AEST)
Received: from mail-ot0-x243.google.com (mail-ot0-x243.google.com
 [IPv6:2607:f8b0:4003:c0f::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40wC143vzjz9s0y
 for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2018 21:58:32 +1000 (AEST)
Received: by mail-ot0-x243.google.com with SMTP id l12-v6so16605294oth.6
 for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2018 04:58:32 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <20180529101529.2583-1-mpe@ellerman.id.au>
References: <20180529101529.2583-1-mpe@ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 29 May 2018 13:58:09 +0200
Message-ID: <CA+7wUswyEVhR_BqmpbJGbQk-VxntX03R1FDZbKYZLxy9=FMJUg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/prom: Fix %llx usage since prom_printf() change
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 29, 2018 at 12:15 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> We recently added the __printf attribute to prom_printf(), which means
> GCC started warning about type/format mismatches. As part of that
> commit we changed some "%lx" formats to "%llx" where the type is
> actually unsigned long long.
>
> Unfortunately prom_printf() doesn't know how to print "%llx", it just
> prints a literal "lx", eg:
>
>   reserved memory map:
>     lx - lx
>     lx - lx

Sorry about that. Patch looks good, will try to work on handling llx/llu.

Reviewed-by: Mathieu Malaterre <malat@debian.org>

> We should fix that at some point, but for now just cast the relevant
> values to unsigned long to get things printing again. On 64-bit that
> has no effect on the output, because both types are 64-bit wide. On
> 32-bit it means we're potentially not printing the high 32-bits of
> some values, but most of them are pointers anyway, and we've lived
> with that behaviour up until now.
>
> Fixes: eae5f709a4d7 ("powerpc: Add __printf verification to prom_printf")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/prom_init.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 425992e393bc..662dd68c3fb8 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -1580,7 +1580,7 @@ static void __init prom_instantiate_opal(void)
>                 return;
>         }
>
> -       prom_printf("instantiating opal at 0x%llx...", base);
> +       prom_printf("instantiating opal at 0x%lx...", (unsigned long)base);
>
>         if (call_prom_ret("call-method", 4, 3, rets,
>                           ADDR("load-opal-runtime"),
> @@ -1596,10 +1596,10 @@ static void __init prom_instantiate_opal(void)
>
>         reserve_mem(base, size);
>
> -       prom_debug("opal base     = 0x%llx\n", base);
> -       prom_debug("opal align    = 0x%llx\n", align);
> -       prom_debug("opal entry    = 0x%llx\n", entry);
> -       prom_debug("opal size     = 0x%llx\n", size);
> +       prom_debug("opal base     = 0x%lx\n", (unsigned long)base);
> +       prom_debug("opal align    = 0x%lx\n", (unsigned long)align);
> +       prom_debug("opal entry    = 0x%lx\n", (unsigned long)entry);
> +       prom_debug("opal size     = 0x%lx\n", (unsigned long)size);
>
>         prom_setprop(opal_node, "/ibm,opal", "opal-base-address",
>                      &base, sizeof(base));
> @@ -1734,7 +1734,7 @@ static void __init prom_instantiate_sml(void)
>         if (base == 0)
>                 prom_panic("Could not allocate memory for sml\n");
>
> -       prom_printf("instantiating sml at 0x%llx...", base);
> +       prom_printf("instantiating sml at 0x%lx...", (unsigned long)base);
>
>         memset((void *)base, 0, size);
>
> @@ -1753,7 +1753,7 @@ static void __init prom_instantiate_sml(void)
>         prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-size",
>                      &size, sizeof(size));
>
> -       prom_debug("sml base     = 0x%llx\n", base);
> +       prom_debug("sml base     = 0x%lx\n", (unsigned long)base);
>         prom_debug("sml size     = 0x%x\n", size);
>
>         prom_debug("prom_instantiate_sml: end...\n");
> @@ -1847,7 +1847,7 @@ static void __init prom_initialize_tce_table(void)
>
>                 prom_debug("TCE table: %s\n", path);
>                 prom_debug("\tnode = 0x%x\n", node);
> -               prom_debug("\tbase = 0x%llx\n", base);
> +               prom_debug("\tbase = 0x%lx\n", (unsigned long)base);
>                 prom_debug("\tsize = 0x%x\n", minsize);
>
>                 /* Initialize the table to have a one-to-one mapping
> @@ -2559,9 +2559,9 @@ static void __init flatten_device_tree(void)
>                 int i;
>                 prom_printf("reserved memory map:\n");
>                 for (i = 0; i < mem_reserve_cnt; i++)
> -                       prom_printf("  %llx - %llx\n",
> -                                   be64_to_cpu(mem_reserve_map[i].base),
> -                                   be64_to_cpu(mem_reserve_map[i].size));
> +                       prom_printf("  %lx - %lx\n",
> +                                   (unsigned long)be64_to_cpu(mem_reserve_map[i].base),
> +                                   (unsigned long)be64_to_cpu(mem_reserve_map[i].size));
>         }
>  #endif
>         /* Bump mem_reserve_cnt to cause further reservations to fail
> --
> 2.14.1
>
