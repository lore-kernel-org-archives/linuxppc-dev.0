Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryWYR4ZSvzDqPb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 16:28:59 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id y134so11326202pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 23:28:59 -0700 (PDT)
Date: Mon, 25 Jul 2016 16:28:49 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, Kevin
 Hao <haokexin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH for-4.8 V2 08/10] powerpc: use the jump label for
 cpu_has_feature
Message-ID: <20160725162849.57d9d495@roar.ozlabs.ibm.com>
In-Reply-To: <1469265163-1491-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1469265163-1491-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1469265163-1491-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 23 Jul 2016 14:42:41 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> From: Kevin Hao <haokexin@gmail.com>
> 
> The cpu features are fixed once the probe of cpu features are done.
> And the function cpu_has_feature() does be used in some hot path.
> The checking of the cpu features for each time of invoking of
> cpu_has_feature() seems suboptimal. This tries to reduce this
> overhead of this check by using jump label.
> 
> The generated assemble code of the following c program:
> 	if (cpu_has_feature(CPU_FTR_XXX))
> 		xxx()
> 
> Before:
> 	lis     r9,-16230
> 	lwz     r9,12324(r9)
> 	lwz     r9,12(r9)
> 	andi.   r10,r9,512
> 	beqlr-
> 
> After:
> 	nop	if CPU_FTR_XXX is enabled
> 	b xxx	if CPU_FTR_XXX is not enabled
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/cpufeatures.h | 21 +++++++++++++++++++++
>  arch/powerpc/include/asm/cputable.h    |  8 ++++++++
>  arch/powerpc/kernel/cputable.c         | 20 ++++++++++++++++++++
>  arch/powerpc/lib/feature-fixups.c      |  1 +
>  4 files changed, 50 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/cpufeatures.h
> b/arch/powerpc/include/asm/cpufeatures.h index
> bfa6cb8f5629..4a4a0b898463 100644 ---
> a/arch/powerpc/include/asm/cpufeatures.h +++
> b/arch/powerpc/include/asm/cpufeatures.h @@ -13,10 +13,31 @@ static
> inline bool __cpu_has_feature(unsigned long feature)
> return !!(CPU_FTRS_POSSIBLE & cur_cpu_spec->cpu_features & feature); }
>  
> +#ifdef CONFIG_JUMP_LABEL
> +#include <linux/jump_label.h>
> +
> +extern struct static_key_true cpu_feat_keys[MAX_CPU_FEATURES];
> +
> +static __always_inline bool cpu_has_feature(unsigned long feature)
> +{
> +	int i;
> +
> +	if (CPU_FTRS_ALWAYS & feature)
> +		return true;
> +
> +	if (!(CPU_FTRS_POSSIBLE & feature))
> +		return false;
> +
> +	i = __builtin_ctzl(feature);
> +	return static_branch_likely(&cpu_feat_keys[i]);
> +}

Is feature ever not-constant, or could it ever be, I wonder? We could
do a build time check to ensure it is always constant?

Or alternatively, make non-constant cases skip the first two tests?

Thanks,
Nick
