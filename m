Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s6zbX1s4tzDqYj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 11:00:08 +1000 (AEST)
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s6zbW2Y9Sz9sf9
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Aug 2016 11:00:07 +1000 (AEST)
Date: Mon, 8 Aug 2016 10:59:53 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@ozlabs.org>, haokexin@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v3 19/21] powerpc: Add option to use jump label for
 mmu_has_feature()
Message-ID: <20160808105953.718262f8@kryten>
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

Hi,

> From: Kevin Hao <haokexin@gmail.com>
> 
> As we just did for CPU features.

This patch causes an oops when building with the gold linker:

Unable to handle kernel paging request for data at address 0xf000000000000000
Faulting instruction address: 0xc000000000971544
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=2048 NUMA pSeries
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.7.0-07470-gc12e6f2 #15
task: c000000000db7500 task.stack: c000000000e04000
NIP: c000000000971544 LR: c00000000097144c CTR: 0000000000000000
REGS: c000000000e078f0 TRAP: 0300   Not tainted  (4.7.0-07470-gc12e6f2)
MSR: 8000000000001033 <SF,ME,IR,DR,RI,LE>  CR: 44002422  XER: 00000000
CFAR: c000000000008768 DAR: f000000000000000 DSISR: 40000000 SOFTE: 0 
GPR00: c000000000971e8c c000000000e07b70 c000000000dfc700 0000000000000000 
GPR04: c000000000da5bc0 0000000000000000 0000000000000100 c000000000e3c700 
GPR08: c0000000fffd2300 0000000000000000 f000000000000000 0000000000000000 
GPR12: 0000000000000000 c00000000fe00000 c0000000009ab1c0 c000000000b52868 
GPR16: c000000000b52840 c000000000b52898 c000000000b528a0 0000000000000000 
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000001 
GPR24: 00000000003fffff 0000000000010000 0000000000000001 ffffffffffffffff 
GPR28: c000000000da5bc0 c000000000da5bc0 0000000000000000 0000000000000000 
NIP [c000000000971544] memmap_init_zone+0x204/0x2cc
LR [c00000000097144c] memmap_init_zone+0x10c/0x2cc
Call Trace:
[c000000000e07b70] [c000000000971648] init_currently_empty_zone+0x3c/0x11c (unreliable)
[c000000000e07c00] [c000000000971e8c] free_area_init_node+0x54c/0x694
[c000000000e07d10] [c000000000c6b108] free_area_init_nodes+0x788/0x838
[c000000000e07e20] [c000000000c4fc14] paging_init+0x88/0xa4
[c000000000e07e90] [c000000000c4ac44] setup_arch+0x2d0/0x30c
[c000000000e07f00] [c000000000c43b04] start_kernel+0x90/0x514
[c000000000e07f90] [c000000000008f5c] start_here_common+0x1c/0x9c

Haven't had a chance to determine if this is a Linux or gold issue yet.

Anton
--

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
> +
> +static inline void mmu_clear_feature(unsigned long feature)
> +{
> +	int i;
> +
> +	i = __builtin_ctzl(feature);
> +	cur_cpu_spec->mmu_features &= ~feature;
> +	static_branch_disable(&mmu_feature_keys[i]);
> +}
> +#else
> +
> +static inline void mmu_feature_keys_init(void)
> +{
> +
> +}
> +
>  static inline bool mmu_has_feature(unsigned long feature)
>  {
>  	return __mmu_has_feature(feature);
> @@ -149,6 +184,7 @@ static inline void mmu_clear_feature(unsigned
> long feature) {
>  	cur_cpu_spec->mmu_features &= ~feature;
>  }
> +#endif /* CONFIG_JUMP_LABEL */
>  
>  extern unsigned int __start___mmu_ftr_fixup, __stop___mmu_ftr_fixup;
>  
> diff --git a/arch/powerpc/kernel/cputable.c
> b/arch/powerpc/kernel/cputable.c index f268850f8fda..db14efc7d3e0
> 100644 --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -2243,4 +2243,21 @@ void __init cpu_feature_keys_init(void)
>  			static_branch_disable(&cpu_feature_keys[i]);
>  	}
>  }
> +
> +struct static_key_true mmu_feature_keys[NUM_MMU_FTR_KEYS] = {
> +			[0 ... NUM_MMU_FTR_KEYS - 1] =
> STATIC_KEY_TRUE_INIT +};
> +EXPORT_SYMBOL_GPL(mmu_feature_keys);
> +
> +void __init mmu_feature_keys_init(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < NUM_MMU_FTR_KEYS; i++) {
> +		unsigned long f = 1ul << i;
> +
> +		if (!(cur_cpu_spec->mmu_features & f))
> +			static_branch_disable(&mmu_feature_keys[i]);
> +	}
> +}
>  #endif
> diff --git a/arch/powerpc/lib/feature-fixups.c
> b/arch/powerpc/lib/feature-fixups.c index f90423faade0..8db370cec547
> 100644 --- a/arch/powerpc/lib/feature-fixups.c
> +++ b/arch/powerpc/lib/feature-fixups.c
> @@ -196,6 +196,7 @@ void __init apply_feature_fixups(void)
>  	 */
>  	jump_label_init();
>  	cpu_feature_keys_init();
> +	mmu_feature_keys_init();
>  }
>  
>  static int __init check_features(void)
