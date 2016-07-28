Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0PH44wmnzDrRd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 17:53:04 +1000 (AEST)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s0PH40yFrz9srY
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jul 2016 17:53:04 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id g202so3261745pfb.1
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jul 2016 00:53:04 -0700 (PDT)
Date: Thu, 28 Jul 2016 17:52:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@ozlabs.org>, haokexin@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v3 19/21] powerpc: Add option to use jump label for
 mmu_has_feature()
Message-ID: <20160728175256.21fcae65@roar.ozlabs.ibm.com>
In-Reply-To: <1469629097-30859-19-git-send-email-mpe@ellerman.id.au>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
 <1469629097-30859-19-git-send-email-mpe@ellerman.id.au>
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

On Thu, 28 Jul 2016 00:18:15 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> From: Kevin Hao <haokexin@gmail.com>
> 
> As we just did for CPU features.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/mmu.h    | 36
> ++++++++++++++++++++++++++++++++++++
> arch/powerpc/kernel/cputable.c    | 17 +++++++++++++++++
> arch/powerpc/lib/feature-fixups.c |  1 + 3 files changed, 54
> insertions(+)
> 
> v3: Rename to mmu_feature_keys, and NUM_MMU_FTR_KEYS.
>     Use the kconfig.
> 
> diff --git a/arch/powerpc/include/asm/mmu.h
> b/arch/powerpc/include/asm/mmu.h index e3eff365e55d..3900cb7fe7cf
> 100644 --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -140,6 +140,41 @@ static inline bool __mmu_has_feature(unsigned
> long feature) return !!(MMU_FTRS_POSSIBLE &
> cur_cpu_spec->mmu_features & feature); }
>  
> +#ifdef CONFIG_JUMP_LABEL_FEATURE_CHECKS
> +#include <linux/jump_label.h>
> +
> +#define NUM_MMU_FTR_KEYS	32
> +
> +extern struct static_key_true mmu_feature_keys[NUM_MMU_FTR_KEYS];
> +
> +extern void mmu_feature_keys_init(void);
> +
> +static __always_inline bool mmu_has_feature(unsigned long feature)
> +{
> +	int i;
> +
> +	if (!(MMU_FTRS_POSSIBLE & feature))
> +		return false;
> +
> +	i = __builtin_ctzl(feature);
> +	return static_branch_likely(&mmu_feature_keys[i]);
> +}

And here.
