Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 268B7B7E63
	for <linuxppc-dev@ozlabs.org>; Sat, 15 May 2010 01:19:04 +1000 (EST)
Message-Id: <2E5B2E22-54A2-43E7-97F5-063EA4DD0A37@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1273811137-30169-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH] powerpc/fsl-booke: Move loadcam_entry back to asm code to
	fix SMP ftrace
Date: Fri, 14 May 2010 10:18:47 -0500
References: <1273811137-30169-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 13, 2010, at 11:25 PM, Kumar Gala wrote:

> When we build with ftrace enabled its possible that loadcam_entry  
> would
> have used the stack pointer (even though the code doesn't need it).   
> We
> call loadcam_entry in __secondary_start before the stack is setup.  To
> ensure that loadcam_entry doesn't use the stack pointer the easiest
> solution is to just have it in asm code.
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Looks good on 8572 SMP - both cpus come up properly now with ftrace  
enabled, and I am able to run the tracers.

Tested-by: Becky Bruce <beckyb@kernel.crashing.org>

> ---
> arch/powerpc/kernel/asm-offsets.c |    8 ++++++++
> arch/powerpc/mm/fsl_booke_mmu.c   |   25 +++----------------------
> arch/powerpc/mm/mmu_decl.h        |   10 +++++++++-
> arch/powerpc/mm/tlb_nohash_low.S  |   28 ++++++++++++++++++++++++++++
> 4 files changed, 48 insertions(+), 23 deletions(-)
>
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/ 
> asm-offsets.c
> index c09138d..b894721 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -447,6 +447,14 @@ int main(void)
> 	DEFINE(PGD_T_LOG2, PGD_T_LOG2);
> 	DEFINE(PTE_T_LOG2, PTE_T_LOG2);
> #endif
> +#ifdef CONFIG_FSL_BOOKE
> +	DEFINE(TLBCAM_SIZE, sizeof(struct tlbcam));
> +	DEFINE(TLBCAM_MAS0, offsetof(struct tlbcam, MAS0));
> +	DEFINE(TLBCAM_MAS1, offsetof(struct tlbcam, MAS1));
> +	DEFINE(TLBCAM_MAS2, offsetof(struct tlbcam, MAS2));
> +	DEFINE(TLBCAM_MAS3, offsetof(struct tlbcam, MAS3));
> +	DEFINE(TLBCAM_MAS7, offsetof(struct tlbcam, MAS7));
> +#endif
>
> #ifdef CONFIG_KVM_EXIT_TIMING
> 	DEFINE(VCPU_TIMING_EXIT_TBU, offsetof(struct kvm_vcpu,
> diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/ 
> fsl_booke_mmu.c
> index 1ed6b52..cdc7526 100644
> --- a/arch/powerpc/mm/fsl_booke_mmu.c
> +++ b/arch/powerpc/mm/fsl_booke_mmu.c
> @@ -2,7 +2,7 @@
>  * Modifications by Kumar Gala (galak@kernel.crashing.org) to support
>  * E500 Book E processors.
>  *
> - * Copyright 2004 Freescale Semiconductor, Inc
> + * Copyright 2004,2010 Freescale Semiconductor, Inc.
>  *
>  * This file contains the routines for initializing the MMU
>  * on the 4xx series of chips.
> @@ -56,19 +56,13 @@
>
> unsigned int tlbcam_index;
>
> -#define NUM_TLBCAMS	(64)
>
> #if defined(CONFIG_LOWMEM_CAM_NUM_BOOL) && (CONFIG_LOWMEM_CAM_NUM >=  
> NUM_TLBCAMS)
> #error "LOWMEM_CAM_NUM must be less than NUM_TLBCAMS"
> #endif
>
> -struct tlbcam {
> -	u32	MAS0;
> -	u32	MAS1;
> -	unsigned long	MAS2;
> -	u32	MAS3;
> -	u32	MAS7;
> -} TLBCAM[NUM_TLBCAMS];
> +#define NUM_TLBCAMS	(64)
> +struct tlbcam TLBCAM[NUM_TLBCAMS];
>
> struct tlbcamrange {
> 	unsigned long start;
> @@ -109,19 +103,6 @@ unsigned long p_mapped_by_tlbcam(phys_addr_t pa)
> 	return 0;
> }
>
> -void loadcam_entry(int idx)
> -{
> -	mtspr(SPRN_MAS0, TLBCAM[idx].MAS0);
> -	mtspr(SPRN_MAS1, TLBCAM[idx].MAS1);
> -	mtspr(SPRN_MAS2, TLBCAM[idx].MAS2);
> -	mtspr(SPRN_MAS3, TLBCAM[idx].MAS3);
> -
> -	if (mmu_has_feature(MMU_FTR_BIG_PHYS))
> -		mtspr(SPRN_MAS7, TLBCAM[idx].MAS7);
> -
> -	asm volatile("isync;tlbwe;isync" : : : "memory");
> -}
> -
> /*
>  * Set up one of the I/D BAT (block address translation) register  
> pairs.
>  * The parameters are not checked; in particular size must be a power
> diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
> index d49a775..0591f25 100644
> --- a/arch/powerpc/mm/mmu_decl.h
> +++ b/arch/powerpc/mm/mmu_decl.h
> @@ -149,7 +149,15 @@ extern unsigned long mmu_mapin_ram(unsigned  
> long top);
> extern void MMU_init_hw(void);
> extern unsigned long mmu_mapin_ram(unsigned long top);
> extern void adjust_total_lowmem(void);
> -
> +extern void loadcam_entry(unsigned int index);
> +
> +struct tlbcam {
> +	u32	MAS0;
> +	u32	MAS1;
> +	unsigned long	MAS2;
> +	u32	MAS3;
> +	u32	MAS7;
> +};
> #elif defined(CONFIG_PPC32)
> /* anything 32-bit except 4xx or 8xx */
> extern void MMU_init_hw(void);
> diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/ 
> tlb_nohash_low.S
> index bbdc5b5..8656ecf 100644
> --- a/arch/powerpc/mm/tlb_nohash_low.S
> +++ b/arch/powerpc/mm/tlb_nohash_low.S
> @@ -271,3 +271,31 @@ _GLOBAL(set_context)
> #else
> #error Unsupported processor type !
> #endif
> +
> +#if defined(CONFIG_FSL_BOOKE)
> +/*
> + * extern void loadcam_entry(unsigned int index)
> + *
> + * Load TLBCAM[index] entry in to the L2 CAM MMU
> + */
> +_GLOBAL(loadcam_entry)
> +	LOAD_REG_ADDR(r4, TLBCAM)
> +	mulli	r5,r3,TLBCAM_SIZE
> +	add	r3,r5,r4
> +	lwz	r4,TLBCAM_MAS0(r3)
> +	mtspr	SPRN_MAS0,r4
> +	lwz	r4,TLBCAM_MAS1(r3)
> +	mtspr	SPRN_MAS1,r4
> +	PPC_LL	r4,TLBCAM_MAS2(r3)
> +	mtspr	SPRN_MAS2,r4
> +	lwz	r4,TLBCAM_MAS3(r3)
> +	mtspr	SPRN_MAS3,r4
> +BEGIN_MMU_FTR_SECTION
> +	lwz	r4,TLBCAM_MAS7(r3)
> +	mtspr	SPRN_MAS7,r4
> +END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
> +	isync
> +	tlbwe
> +	isync
> +	blr
> +#endif
> -- 
> 1.6.0.6
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
