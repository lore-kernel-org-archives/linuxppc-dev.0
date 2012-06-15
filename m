Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D80F3B704F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2012 11:05:20 +1000 (EST)
Message-ID: <1339722302.9220.175.camel@pasglop>
Subject: Re: [PATCH 2/2] powerpc/e6500: TLB miss handler with hardware
 tablewalk support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Fri, 15 Jun 2012 11:05:02 +1000
In-Reply-To: <20120614234101.GB17147@tyr.buserror.net>
References: <20120614234101.GB17147@tyr.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-06-14 at 18:41 -0500, Scott Wood wrote:
> There are a few things that make the existing hw tablewalk handlers
> unsuitable for e6500:
> 
>  - Indirect entries go in TLB1 (though the resulting direct entries go in
>    TLB0).

That per-se doesn't justify a whole new handler... patching instructions
would do or storing the default target in the PACA... The rest
however...

>  - It has threads, but no "tlbsrx." -- so we need a spinlock and
>    a normal "tlbsx".  Because we need this lock, hardware tablewalk
>    is mandatory on e6500 unless we want to add spinlock+tlbsx to
>    the normal bolted TLB miss handler.

Isn't this a violation of the architecture ? (Isn't tlbsrx. mandatory ?
in 2.06 MAV2 ?). 

>  - TLB1 has no HES (nor next-victim hint) so we need software round robin
>    (TODO: integrate this round robin data with hugetlb/KVM)

Yuck :-)

>  - The existing tablewalk handlers map half of a page table at a time,
>    because IBM hardware has a fixed 1MiB indirect page size.  e6500
>    has variable size indirect entries, with a minimum of 2MiB.
>    So we can't do the half-page indirect mapping, and even if we
>    could it would be less efficient than mapping the full page.

Ok.

>  - Like on e5500, the linear mapping is bolted, so we don't need the
>    overhead of supporting nested tlb misses.
> 
> Note that hardware tablewalk does not work in rev1 of e6500.
> We do not expect to support e6500 rev1 in mainline Linux.

I'll try to review that in more details next week.... 

Ben.
 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/include/asm/mmu-book3e.h |   13 +++
>  arch/powerpc/include/asm/mmu.h        |   21 ++--
>  arch/powerpc/include/asm/paca.h       |    6 +
>  arch/powerpc/kernel/asm-offsets.c     |   10 ++
>  arch/powerpc/kernel/paca.c            |    5 +
>  arch/powerpc/kernel/setup_64.c        |   33 +++++++
>  arch/powerpc/mm/fsl_booke_mmu.c       |    8 ++
>  arch/powerpc/mm/tlb_low_64e.S         |  167 +++++++++++++++++++++++++++++++++
>  arch/powerpc/mm/tlb_nohash.c          |  109 ++++++++++++++++------
>  9 files changed, 335 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
> index eeabcdb..3072aa0 100644
> --- a/arch/powerpc/include/asm/mmu-book3e.h
> +++ b/arch/powerpc/include/asm/mmu-book3e.h
> @@ -264,8 +264,21 @@ extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
>  extern int mmu_linear_psize;
>  extern int mmu_vmemmap_psize;
>  
> +struct book3e_tlb_per_core {
> +	/* For software way selection, as on Freescale TLB1 */
> +	u8 esel_next, esel_max, esel_first;
> +
> +	/* Per-core spinlock for e6500 TLB handlers (no tlbsrx.) */
> +	u8 lock;
> +};
> +
>  #ifdef CONFIG_PPC64
>  extern unsigned long linear_map_top;
> +extern int book3e_htw_mode;
> +
> +#define PPC_HTW_NONE	0
> +#define PPC_HTW_IBM	1
> +#define PPC_HTW_E6500	2
>  
>  /*
>   * 64-bit booke platforms don't load the tlb in the tlb miss handler code.
> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
> index a9e9ec6..63d97eb 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -170,16 +170,17 @@ extern u64 ppc64_rma_size;
>  #define MMU_PAGE_64K_AP	3	/* "Admixed pages" (hash64 only) */
>  #define MMU_PAGE_256K	4
>  #define MMU_PAGE_1M	5
> -#define MMU_PAGE_4M	6
> -#define MMU_PAGE_8M	7
> -#define MMU_PAGE_16M	8
> -#define MMU_PAGE_64M	9
> -#define MMU_PAGE_256M	10
> -#define MMU_PAGE_1G	11
> -#define MMU_PAGE_16G	12
> -#define MMU_PAGE_64G	13
> -
> -#define MMU_PAGE_COUNT	14
> +#define MMU_PAGE_2M	6
> +#define MMU_PAGE_4M	7
> +#define MMU_PAGE_8M	8
> +#define MMU_PAGE_16M	9
> +#define MMU_PAGE_64M	10
> +#define MMU_PAGE_256M	11
> +#define MMU_PAGE_1G	12
> +#define MMU_PAGE_16G	13
> +#define MMU_PAGE_64G	14
> +
> +#define MMU_PAGE_COUNT	15
>  
>  #if defined(CONFIG_PPC_STD_MMU_64)
>  /* 64-bit classic hash table MMU */
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> index daf813f..4e18bb5 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -108,6 +108,12 @@ struct paca_struct {
>  	/* Keep pgd in the same cacheline as the start of extlb */
>  	pgd_t *pgd __attribute__((aligned(0x80))); /* Current PGD */
>  	pgd_t *kernel_pgd;		/* Kernel PGD */
> +
> +	struct book3e_tlb_per_core tlb_per_core;
> +
> +	/* Points to the tlb_per_core of the first thread on this core. */
> +	struct book3e_tlb_per_core *tlb_per_core_ptr;
> +
>  	/* We can have up to 3 levels of reentrancy in the TLB miss handler */
>  	u64 extlb[3][EX_TLB_SIZE / sizeof(u64)];
>  	u64 exmc[8];		/* used for machine checks */
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 52c7ad7..61f4634 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -168,6 +168,16 @@ int main(void)
>  	DEFINE(PACA_MC_STACK, offsetof(struct paca_struct, mc_kstack));
>  	DEFINE(PACA_CRIT_STACK, offsetof(struct paca_struct, crit_kstack));
>  	DEFINE(PACA_DBG_STACK, offsetof(struct paca_struct, dbg_kstack));
> +	DEFINE(PACA_TLB_PER_CORE_PTR,
> +		offsetof(struct paca_struct, tlb_per_core_ptr));
> +
> +	DEFINE(PERCORE_TLB_ESEL_NEXT,
> +		offsetof(struct book3e_tlb_per_core, esel_next));
> +	DEFINE(PERCORE_TLB_ESEL_MAX,
> +		offsetof(struct book3e_tlb_per_core, esel_max));
> +	DEFINE(PERCORE_TLB_ESEL_FIRST,
> +		offsetof(struct book3e_tlb_per_core, esel_first));
> +	DEFINE(PERCORE_TLB_LOCK, offsetof(struct book3e_tlb_per_core, lock));
>  #endif /* CONFIG_PPC_BOOK3E */
>  
>  #ifdef CONFIG_PPC_STD_MMU_64
> diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
> index fbe1a12..65abfc0 100644
> --- a/arch/powerpc/kernel/paca.c
> +++ b/arch/powerpc/kernel/paca.c
> @@ -145,6 +145,11 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
>  #ifdef CONFIG_PPC_STD_MMU_64
>  	new_paca->slb_shadow_ptr = &slb_shadow[cpu];
>  #endif /* CONFIG_PPC_STD_MMU_64 */
> +
> +#ifdef CONFIG_PPC_BOOK3E
> +	/* For now -- if we have threads this will be adjusted later */
> +	new_paca->tlb_per_core_ptr = &new_paca->tlb_per_core;
> +#endif
>  }
>  
>  /* Put the paca pointer into r13 and SPRG_PACA */
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 389bd4f..271b85d 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -102,6 +102,37 @@ int ucache_bsize;
>  
>  static char *smt_enabled_cmdline;
>  
> +#ifdef CONFIG_PPC_BOOK3E
> +static void setup_tlb_per_core(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		int first = cpu_first_thread_sibling(cpu);
> +
> +		paca[cpu].tlb_per_core_ptr = &paca[first].tlb_per_core;
> +
> +		/*
> +		 * If we have threads, we need either tlbsrx.
> +		 * or e6500 tablewalk mode, or else TLB handlers
> +		 * will be racy and could produce duplicate entries.
> +		 */
> +		if (smt_enabled_at_boot >= 2 &&
> +		    !mmu_has_feature(MMU_FTR_USE_TLBRSRV) &&
> +		    book3e_htw_mode != PPC_HTW_E6500) {
> +			/* Should we panic instead? */
> +			WARN_ONCE("%s: unsupported MMU configuration -- expect problems\n",
> +				  __func__);
> +		}
> +	}
> +}
> +#else
> +static void setup_tlb_per_core(void)
> +{
> +}
> +#endif
> +
> +
>  /* Look for ibm,smt-enabled OF option */
>  static void check_smt_enabled(void)
>  {
> @@ -142,6 +173,8 @@ static void check_smt_enabled(void)
>  			of_node_put(dn);
>  		}
>  	}
> +
> +	setup_tlb_per_core();
>  }
>  
>  /* Look for smt-enabled= cmdline option */
> diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
> index 07ba45b..bf06d36b 100644
> --- a/arch/powerpc/mm/fsl_booke_mmu.c
> +++ b/arch/powerpc/mm/fsl_booke_mmu.c
> @@ -52,6 +52,7 @@
>  #include <asm/smp.h>
>  #include <asm/machdep.h>
>  #include <asm/setup.h>
> +#include <asm/paca.h>
>  
>  #include "mmu_decl.h"
>  
> @@ -192,6 +193,13 @@ unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx)
>  	}
>  	tlbcam_index = i;
>  
> +#ifdef CONFIG_PPC64
> +	get_paca()->tlb_per_core.esel_next = i;
> +	get_paca()->tlb_per_core.esel_max =
> +		mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY;
> +	get_paca()->tlb_per_core.esel_first = i;
> +#endif
> +
>  	return amount_mapped;
>  }
>  
> diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
> index efe0f33..8e82772 100644
> --- a/arch/powerpc/mm/tlb_low_64e.S
> +++ b/arch/powerpc/mm/tlb_low_64e.S
> @@ -232,6 +232,173 @@ itlb_miss_fault_bolted:
>  	beq	tlb_miss_common_bolted
>  	b	itlb_miss_kernel_bolted
>  
> +/*
> + * TLB miss handling for e6500 and derivatives, using hardware tablewalk.
> + *
> + * Linear mapping is bolted: no virtual page table or nested TLB misses
> + * Indirect entries in TLB1, hardware loads resulting direct entries
> + *    into TLB0
> + * No HES or NV hint on TLB1, so we need to do software round-robin
> + * No tlbsrx. so we need a spinlock, and we have to deal
> + *    with MAS-damage caused by tlbsx
> + * 4K pages only
> + */
> +
> +	START_EXCEPTION(instruction_tlb_miss_e6500)
> +	tlb_prolog_bolted SPRN_SRR0
> +
> +	ld	r11,PACA_TLB_PER_CORE_PTR(r13)
> +	srdi.	r15,r16,60		/* get region */
> +	ori	r16,r16,1
> +
> +	TLB_MISS_STATS_SAVE_INFO_BOLTED
> +	bne	tlb_miss_kernel_e6500	/* user/kernel test */
> +
> +	b	tlb_miss_common_e6500
> +
> +	START_EXCEPTION(data_tlb_miss_e6500)
> +	tlb_prolog_bolted SPRN_DEAR
> +
> +	ld	r11,PACA_TLB_PER_CORE_PTR(r13)
> +	srdi.	r15,r16,60		/* get region */
> +	rldicr	r16,r16,0,62
> +
> +	TLB_MISS_STATS_SAVE_INFO_BOLTED
> +	bne	tlb_miss_kernel_e6500	/* user vs kernel check */
> +
> +/*
> + * This is the guts of the TLB miss handler for e6500 and derivatives.
> + * We are entered with:
> + *
> + * r16 = page of faulting address (low bit 0 if data, 1 if instruction)
> + * r15 = crap (free to use)
> + * r14 = page table base
> + * r13 = PACA
> + * r11 = tlb_per_core ptr
> + * r10 = crap (free to use)
> + */
> +tlb_miss_common_e6500:
> +	/*
> +	 * Search if we already have an indirect entry for that virtual
> +	 * address, and if we do, bail out.
> +	 *
> +	 * MAS6:IND should be already set based on MAS4
> +	 */
> +	addi	r10,r11,PERCORE_TLB_LOCK
> +1:	lbarx	r15,0,r10
> +	cmpdi	r15,0
> +	bne	2f
> +	li	r15,1
> +	stbcx.	r15,0,r10
> +	bne	1b
> +	.subsection 1
> +2:	lbz	r15,0(r10)
> +	cmpdi	r15,0
> +	bne	2b
> +	b	1b
> +	.previous
> +
> +	mfspr	r15,SPRN_MAS2
> +
> +	tlbsx	0,r16
> +	mfspr	r10,SPRN_MAS1
> +	andis.	r10,r10,MAS1_VALID@h
> +	bne	tlb_miss_done_e6500
> +
> +	/* Undo MAS-damage from the tlbsx */
> +	mfspr	r10,SPRN_MAS1
> +	oris	r10,r10,MAS1_VALID@h
> +	mtspr	SPRN_MAS1,r10
> +	mtspr	SPRN_MAS2,r15
> +
> +	/* Now, we need to walk the page tables. First check if we are in
> +	 * range.
> +	 */
> +	rldicl.	r10,r16,64-PGTABLE_EADDR_SIZE,PGTABLE_EADDR_SIZE+4
> +	bne-	tlb_miss_fault_e6500
> +
> +	rldicl	r15,r16,64-PGDIR_SHIFT+3,64-PGD_INDEX_SIZE-3
> +	cmpldi	cr0,r14,0
> +	clrrdi	r15,r15,3
> +	beq-	tlb_miss_fault_e6500 /* No PGDIR, bail */
> +	ldx	r14,r14,r15		/* grab pgd entry */
> +
> +	rldicl	r15,r16,64-PUD_SHIFT+3,64-PUD_INDEX_SIZE-3
> +	clrrdi	r15,r15,3
> +	cmpdi	cr0,r14,0
> +	bge	tlb_miss_fault_e6500	/* Bad pgd entry or hugepage; bail */
> +	ldx	r14,r14,r15		/* grab pud entry */
> +
> +	rldicl	r15,r16,64-PMD_SHIFT+3,64-PMD_INDEX_SIZE-3
> +	clrrdi	r15,r15,3
> +	cmpdi	cr0,r14,0
> +	bge	tlb_miss_fault_e6500
> +	ldx	r14,r14,r15		/* Grab pmd entry */
> +
> +	mfspr	r10,SPRN_MAS0
> +	cmpdi	cr0,r14,0
> +	bge	tlb_miss_fault_e6500
> +
> +	/* Now we build the MAS for a 2M indirect page:
> +	 *
> +	 * MAS 0   :	ESEL needs to be filled by software round-robin
> +	 * MAS 1   :	Almost fully setup
> +	 *               - PID already updated by caller if necessary
> +	 *               - TSIZE for now is base ind page size always
> +	 * MAS 2   :	Use defaults
> +	 * MAS 3+7 :	Needs to be done
> +	 */
> +
> +	ori	r14,r14,(BOOK3E_PAGESZ_4K << MAS3_SPSIZE_SHIFT)
> +	mtspr	SPRN_MAS7_MAS3,r14
> +
> +	lbz	r15,PERCORE_TLB_ESEL_NEXT(r11)
> +	lbz	r16,PERCORE_TLB_ESEL_MAX(r11)
> +	lbz	r14,PERCORE_TLB_ESEL_FIRST(r11)
> +	rlwimi	r10,r15,16,0x00ff0000	/* insert esel_next into MAS0 */
> +	addi	r15,r15,1		/* increment esel_next */
> +	mtspr	SPRN_MAS0,r10
> +	cmpw	r15,r16
> +	iseleq	r15,r14,r15		/* if next == last use first */
> +	stb	r15,PERCORE_TLB_ESEL_NEXT(r11)
> +
> +	tlbwe
> +
> +tlb_miss_done_e6500:
> +	.macro	tlb_unlock_e6500
> +	li	r15,0
> +	isync
> +	stb	r15,PERCORE_TLB_LOCK(r11)
> +	.endm
> +
> +	tlb_unlock_e6500
> +	TLB_MISS_STATS_X(MMSTAT_TLB_MISS_NORM_OK)
> +	tlb_epilog_bolted
> +	rfi
> +
> +tlb_miss_kernel_e6500:
> +	mfspr	r10,SPRN_MAS1
> +	ld	r14,PACA_KERNELPGD(r13)
> +	cmpldi	cr0,r15,8		/* Check for vmalloc region */
> +	rlwinm	r10,r10,0,16,1		/* Clear TID */
> +	mtspr	SPRN_MAS1,r10
> +	beq+	tlb_miss_common_e6500
> +
> +tlb_miss_fault_e6500:
> +	tlb_unlock_e6500
> +	/* We need to check if it was an instruction miss */
> +	andi.	r16,r16,1
> +	bne	itlb_miss_fault_e6500
> +dtlb_miss_fault_e6500:
> +	TLB_MISS_STATS_D(MMSTAT_TLB_MISS_NORM_FAULT)
> +	tlb_epilog_bolted
> +	b	exc_data_storage_book3e
> +itlb_miss_fault_e6500:
> +	TLB_MISS_STATS_I(MMSTAT_TLB_MISS_NORM_FAULT)
> +	tlb_epilog_bolted
> +	b	exc_instruction_storage_book3e
> +
> +
>  /**********************************************************************
>   *                                                                    *
>   * TLB miss handling for Book3E with TLB reservation and HES support  *
> diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
> index df32a83..2f09ddf 100644
> --- a/arch/powerpc/mm/tlb_nohash.c
> +++ b/arch/powerpc/mm/tlb_nohash.c
> @@ -43,6 +43,7 @@
>  #include <asm/tlb.h>
>  #include <asm/code-patching.h>
>  #include <asm/hugetlb.h>
> +#include <asm/paca.h>
>  
>  #include "mmu_decl.h"
>  
> @@ -58,6 +59,10 @@ struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
>  		.shift	= 12,
>  		.enc	= BOOK3E_PAGESZ_4K,
>  	},
> +	[MMU_PAGE_2M] = {
> +		.shift	= 21,
> +		.enc	= BOOK3E_PAGESZ_2M,
> +	},
>  	[MMU_PAGE_4M] = {
>  		.shift	= 22,
>  		.enc	= BOOK3E_PAGESZ_4M,
> @@ -136,7 +141,7 @@ static inline int mmu_get_tsize(int psize)
>  int mmu_linear_psize;		/* Page size used for the linear mapping */
>  int mmu_pte_psize;		/* Page size used for PTE pages */
>  int mmu_vmemmap_psize;		/* Page size used for the virtual mem map */
> -int book3e_htw_enabled;		/* Is HW tablewalk enabled ? */
> +int book3e_htw_mode;		/* HW tablewalk?  Value is PPC_HTW_* */
>  unsigned long linear_map_top;	/* Top of linear mapping */
>  
>  #endif /* CONFIG_PPC64 */
> @@ -377,7 +382,7 @@ void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long address)
>  {
>  	int tsize = mmu_psize_defs[mmu_pte_psize].enc;
>  
> -	if (book3e_htw_enabled) {
> +	if (book3e_htw_mode) {
>  		unsigned long start = address & PMD_MASK;
>  		unsigned long end = address + PMD_SIZE;
>  		unsigned long size = 1UL << mmu_psize_defs[mmu_pte_psize].shift;
> @@ -413,10 +418,10 @@ static void setup_page_sizes(void)
>  	int i, psize;
>  
>  #ifdef CONFIG_PPC_FSL_BOOK3E
> +	int fsl_mmu = mmu_has_feature(MMU_FTR_TYPE_FSL_E);
>  	unsigned int mmucfg = mfspr(SPRN_MMUCFG);
>  
> -	if (((mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V1) &&
> -		(mmu_has_feature(MMU_FTR_TYPE_FSL_E))) {
> +	if (fsl_mmu && (mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V1) {
>  		unsigned int tlb1cfg = mfspr(SPRN_TLB1CFG);
>  		unsigned int min_pg, max_pg;
>  
> @@ -430,7 +435,7 @@ static void setup_page_sizes(void)
>  			def = &mmu_psize_defs[psize];
>  			shift = def->shift;
>  
> -			if (shift == 0)
> +			if (shift == 0 || shift & 1)
>  				continue;
>  
>  			/* adjust to be in terms of 4^shift Kb */
> @@ -440,7 +445,40 @@ static void setup_page_sizes(void)
>  				def->flags |= MMU_PAGE_SIZE_DIRECT;
>  		}
>  
> -		goto no_indirect;
> +		goto out;
> +	}
> +
> +	if (fsl_mmu && (mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V2) {
> +		u32 tlb1cfg, tlb1ps;
> +
> +		tlb0cfg = mfspr(SPRN_TLB0CFG);
> +		tlb1cfg = mfspr(SPRN_TLB1CFG);
> +		tlb1ps = mfspr(SPRN_TLB1PS);
> +		eptcfg = mfspr(SPRN_EPTCFG);
> +
> +		if ((tlb1cfg & TLBnCFG_IND) && (tlb0cfg & TLBnCFG_PT))
> +			book3e_htw_mode = PPC_HTW_E6500;
> +
> +		/*
> +		 * We expect 4K subpage size and unrestricted indirect size.
> +		 * The lack of a restriction on indirect size is a Freescale
> +		 * extension, indicated by PSn = 0 but SPSn != 0.
> +		 */
> +		if (eptcfg != 2)
> +			book3e_htw_mode = PPC_HTW_NONE;
> +
> +		for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
> +			struct mmu_psize_def *def = &mmu_psize_defs[psize];
> +
> +			if (tlb1ps & (1U << (def->shift - 10))) {
> +				def->flags |= MMU_PAGE_SIZE_DIRECT;
> +
> +				if (book3e_htw_mode && psize == MMU_PAGE_2M)
> +					def->flags |= MMU_PAGE_SIZE_INDIRECT;
> +			}
> +		}
> +
> +		goto out;
>  	}
>  #endif
>  
> @@ -457,8 +495,11 @@ static void setup_page_sizes(void)
>  	}
>  
>  	/* Indirect page sizes supported ? */
> -	if ((tlb0cfg & TLBnCFG_IND) == 0)
> -		goto no_indirect;
> +	if ((tlb0cfg & TLBnCFG_IND) == 0 ||
> +	    (tlb0cfg & TLBnCFG_PT) == 0)
> +		goto out;
> +
> +	book3e_htw_mode = PPC_HTW_IBM;
>  
>  	/* Now, we only deal with one IND page size for each
>  	 * direct size. Hopefully all implementations today are
> @@ -483,8 +524,8 @@ static void setup_page_sizes(void)
>  				def->ind = ps + 10;
>  		}
>  	}
> - no_indirect:
>  
> +out:
>  	/* Cleanup array and print summary */
>  	pr_info("MMU: Supported page sizes\n");
>  	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
> @@ -525,23 +566,23 @@ static void __patch_exception(int exc, unsigned long addr)
>  
>  static void setup_mmu_htw(void)
>  {
> -	/* Check if HW tablewalk is present, and if yes, enable it by:
> -	 *
> -	 * - patching the TLB miss handlers to branch to the
> -	 *   one dedicates to it
> -	 *
> -	 * - setting the global book3e_htw_enabled
> -       	 */
> -	unsigned int tlb0cfg = mfspr(SPRN_TLB0CFG);
> +	/*
> +	 * If we want to use HW tablewalk, enable it by patching the TLB miss
> +	 * handlers to branch to the one dedicated to it.
> +	 */
>  
> -	if ((tlb0cfg & TLBnCFG_IND) &&
> -	    (tlb0cfg & TLBnCFG_PT)) {
> +	switch (book3e_htw_mode) {
> +	case PPC_HTW_IBM:
>  		patch_exception(0x1c0, exc_data_tlb_miss_htw_book3e);
>  		patch_exception(0x1e0, exc_instruction_tlb_miss_htw_book3e);
> -		book3e_htw_enabled = 1;
> +		break;
> +	case PPC_HTW_E6500:
> +		patch_exception(0x1c0, exc_data_tlb_miss_e6500_book3e);
> +		patch_exception(0x1e0, exc_instruction_tlb_miss_e6500_book3e);
> +		break;
>  	}
>  	pr_info("MMU: Book3E HW tablewalk %s\n",
> -		book3e_htw_enabled ? "enabled" : "not supported");
> +		book3e_htw_mode ? "enabled" : "not supported");
>  }
>  
>  /*
> @@ -581,8 +622,16 @@ static void __early_init_mmu(int boot_cpu)
>  	/* Set MAS4 based on page table setting */
>  
>  	mas4 = 0x4 << MAS4_WIMGED_SHIFT;
> -	if (book3e_htw_enabled) {
> -		mas4 |= mas4 | MAS4_INDD;
> +	switch (book3e_htw_mode) {
> +	case PPC_HTW_E6500:
> +		mas4 |= MAS4_INDD;
> +		mas4 |= BOOK3E_PAGESZ_2M << MAS4_TSIZED_SHIFT;
> +		mas4 |= MAS4_TLBSELD(1);
> +		mmu_pte_psize = MMU_PAGE_2M;
> +		break;
> +
> +	case PPC_HTW_IBM:
> +		mas4 |= MAS4_INDD;
>  #ifdef CONFIG_PPC_64K_PAGES
>  		mas4 |=	BOOK3E_PAGESZ_256M << MAS4_TSIZED_SHIFT;
>  		mmu_pte_psize = MMU_PAGE_256M;
> @@ -590,13 +639,16 @@ static void __early_init_mmu(int boot_cpu)
>  		mas4 |=	BOOK3E_PAGESZ_1M << MAS4_TSIZED_SHIFT;
>  		mmu_pte_psize = MMU_PAGE_1M;
>  #endif
> -	} else {
> +		break;
> +
> +	case PPC_HTW_NONE:
>  #ifdef CONFIG_PPC_64K_PAGES
>  		mas4 |=	BOOK3E_PAGESZ_64K << MAS4_TSIZED_SHIFT;
>  #else
>  		mas4 |=	BOOK3E_PAGESZ_4K << MAS4_TSIZED_SHIFT;
>  #endif
>  		mmu_pte_psize = mmu_virtual_psize;
> +		break;
>  	}
>  	mtspr(SPRN_MAS4, mas4);
>  
> @@ -616,8 +668,11 @@ static void __early_init_mmu(int boot_cpu)
>  		/* limit memory so we dont have linear faults */
>  		memblock_enforce_memory_limit(linear_map_top);
>  
> -		patch_exception(0x1c0, exc_data_tlb_miss_bolted_book3e);
> -		patch_exception(0x1e0, exc_instruction_tlb_miss_bolted_book3e);
> +		if (book3e_htw_mode == PPC_HTW_NONE) {
> +			patch_exception(0x1c0, exc_data_tlb_miss_bolted_book3e);
> +			patch_exception(0x1e0,
> +				exc_instruction_tlb_miss_bolted_book3e);
> +		}
>  	}
>  #endif
>  
