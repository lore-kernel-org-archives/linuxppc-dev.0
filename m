Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09F7C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 09:29:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255E32184A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 09:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255E32184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 442z8q0P8MzDqJB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 20:29:31 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 442z6r2K1qzDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 20:27:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 442z6q1sf4z9s7h;
 Mon, 18 Feb 2019 20:27:47 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v5 3/3] powerpc/32: Add KASAN support
In-Reply-To: <3429fe33b68206ecc2a725a740937bbaef2d1ac8.1549935251.git.christophe.leroy@c-s.fr>
References: <cover.1549935247.git.christophe.leroy@c-s.fr>
 <3429fe33b68206ecc2a725a740937bbaef2d1ac8.1549935251.git.christophe.leroy@c-s.fr>
Date: Mon, 18 Feb 2019 20:27:47 +1100
Message-ID: <87a7itqwdo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
> index e0637730a8e7..dba2c1038363 100644
> --- a/arch/powerpc/include/asm/ppc_asm.h
> +++ b/arch/powerpc/include/asm/ppc_asm.h
> @@ -251,6 +251,10 @@ GLUE(.,name):
>  
>  #define _GLOBAL_TOC(name) _GLOBAL(name)
>  
> +#define KASAN_OVERRIDE(x, y) \
> +	.weak x;	     \
> +	.set x, y
> +

Can you add a comment describing what that does and why?

> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 879b36602748..fc4c42262694 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -16,8 +16,9 @@ CFLAGS_prom_init.o      += -fPIC
>  CFLAGS_btext.o		+= -fPIC
>  endif
>  
> -CFLAGS_cputable.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
> -CFLAGS_prom_init.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
> +CFLAGS_early_32.o += -DDISABLE_BRANCH_PROFILING
> +CFLAGS_cputable.o += $(DISABLE_LATENT_ENTROPY_PLUGIN) -DDISABLE_BRANCH_PROFILING
> +CFLAGS_prom_init.o += $(DISABLE_LATENT_ENTROPY_PLUGIN) -DDISABLE_BRANCH_PROFILING

Why do we need to disable branch profiling now?

I'd probably be happier if all the CFLAGS changes were done in a leadup
patch to make them more obvious.

> diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
> index 667df97d2595..da6bb16e0876 100644
> --- a/arch/powerpc/kernel/prom_init_check.sh
> +++ b/arch/powerpc/kernel/prom_init_check.sh
> @@ -16,8 +16,16 @@
>  # If you really need to reference something from prom_init.o add
>  # it to the list below:
>  
> +grep CONFIG_KASAN=y .config >/dev/null

Just to be safe "^CONFIG_KASAN=y$" ?

> +if [ $? -eq 0 ]
> +then
> +	MEMFCT="__memcpy __memset"
> +else
> +	MEMFCT="memcpy memset"
> +fi

MEM_FUNCS ?

> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index 3bf9fc6fd36c..ce8d4a9f810a 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -8,6 +8,14 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
>  CFLAGS_REMOVE_code-patching.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_feature-fixups.o = $(CC_FLAGS_FTRACE)
>  
> +KASAN_SANITIZE_code-patching.o := n
> +KASAN_SANITIZE_feature-fixups.o := n
> +
> +ifdef CONFIG_KASAN
> +CFLAGS_code-patching.o += -DDISABLE_BRANCH_PROFILING
> +CFLAGS_feature-fixups.o += -DDISABLE_BRANCH_PROFILING
> +endif

There's that branch profiling again, though here it's only if KASAN is enabled.

> diff --git a/arch/powerpc/mm/kasan_init.c b/arch/powerpc/mm/kasan_init.c
> new file mode 100644
> index 000000000000..bd8e0a263e12
> --- /dev/null
> +++ b/arch/powerpc/mm/kasan_init.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define DISABLE_BRANCH_PROFILING
> +
> +#include <linux/kasan.h>
> +#include <linux/printk.h>
> +#include <linux/memblock.h>
> +#include <linux/sched/task.h>
> +#include <asm/pgalloc.h>
> +
> +void __init kasan_early_init(void)
> +{
> +	unsigned long addr = KASAN_SHADOW_START;
> +	unsigned long end = KASAN_SHADOW_END;
> +	unsigned long next;
> +	pmd_t *pmd = pmd_offset(pud_offset(pgd_offset_k(addr), addr), addr);

Can none of those fail?


cheers
