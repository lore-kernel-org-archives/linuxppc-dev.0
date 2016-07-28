Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0PFv4WzlzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 17:52:03 +1000 (AEST)
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s0PFt4K9cz9svs
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jul 2016 17:52:02 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id i6so3252583pfe.0
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jul 2016 00:52:02 -0700 (PDT)
Date: Thu, 28 Jul 2016 17:51:54 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@ozlabs.org>, haokexin@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v3 18/21] powerpc: Add option to use jump label for
 cpu_has_feature()
Message-ID: <20160728175154.6967091c@roar.ozlabs.ibm.com>
In-Reply-To: <1469629097-30859-18-git-send-email-mpe@ellerman.id.au>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
 <1469629097-30859-18-git-send-email-mpe@ellerman.id.au>
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

On Thu, 28 Jul 2016 00:18:14 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> From: Kevin Hao <haokexin@gmail.com>
> 
> We do binary patching of asm code using CPU features, which is a
> one-time operation, done during early boot. However checks of CPU
> features in C code are currently done at run time, even though the set
> of CPU features can never change after boot.
> 
> We can optimise this by using jump labels to implement
> cpu_has_feature(), meaning checks in C code are binary patched into a
> single nop or branch.
> 
> For a C sequence along the lines of:
> 
>     if (cpu_has_feature(FOO))
>          return 2;
> 
> The generated code before is roughly:
> 
>     ld      r9,-27640(r2)
>     ld      r9,0(r9)
>     lwz     r9,32(r9)
>     cmpwi   cr7,r9,0
>     bge     cr7, 1f
>     li      r3,2
>     blr
> 1:  ...
> 
> After (true):
>     nop
>     li      r3,2
>     blr
> 
> After (false):
>     b	1f
>     li      r3,2
>     blr
> 1:  ...
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/cpu_has_feature.h | 22
> ++++++++++++++++++++++ arch/powerpc/include/asm/cputable.h        |
> 6 ++++++ arch/powerpc/kernel/cputable.c             | 20
> ++++++++++++++++++++ arch/powerpc/lib/feature-fixups.c          |  1 +
>  4 files changed, 49 insertions(+)
> 
> v3: Rename MAX_CPU_FEATURES as we already have a #define with that
> name. Define NUM_CPU_FTR_KEYS as a constant.
>     Rename the array to cpu_feature_keys.
>     Use the kconfig we added to guard it.
>     Rewrite the change log.
> 
> diff --git a/arch/powerpc/include/asm/cpu_has_feature.h
> b/arch/powerpc/include/asm/cpu_has_feature.h index
> ad296b2f1d84..18e60e61bea9 100644 ---
> a/arch/powerpc/include/asm/cpu_has_feature.h +++
> b/arch/powerpc/include/asm/cpu_has_feature.h @@ -11,10 +11,32 @@
> static inline bool __cpu_has_feature(unsigned long feature)
> (CPU_FTRS_POSSIBLE & cur_cpu_spec->cpu_features & feature)); }
>  
> +#ifdef CONFIG_JUMP_LABEL_FEATURE_CHECKS
> +#include <linux/jump_label.h>
> +
> +#define NUM_CPU_FTR_KEYS	64
> +
> +extern struct static_key_true cpu_feature_keys[NUM_CPU_FTR_KEYS];
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
> +	return static_branch_likely(&cpu_feature_keys[i]);

Just a reminder to add a BUILD_BUG_ON(!__builtin_constant_p(feature));
for this.
