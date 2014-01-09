Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0153.outbound.protection.outlook.com [207.46.163.153])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1A5682C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 12:33:01 +1100 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v4 2/3] powerpc/e6500: TLB miss handler with hardware
 tablewalk support
Date: Wed, 8 Jan 2014 19:32:42 -0600
Message-ID: <1389231163-11175-2-git-send-email-scottwood@freescale.com>
In-Reply-To: <1389231163-11175-1-git-send-email-scottwood@freescale.com>
References: <1389231163-11175-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Mihai Caraman <mihai.caraman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are a few things that make the existing hw tablewalk handlers
unsuitable for e6500:

 - Indirect entries go in TLB1 (though the resulting direct entries go in
   TLB0).

 - It has threads, but no "tlbsrx." -- so we need a spinlock and
   a normal "tlbsx".  Because we need this lock, hardware tablewalk
   is mandatory on e6500 unless we want to add spinlock+tlbsx to
   the normal bolted TLB miss handler.

 - TLB1 has no HES (nor next-victim hint) so we need software round robin
   (TODO: integrate this round robin data with hugetlb/KVM)

 - The existing tablewalk handlers map half of a page table at a time,
   because IBM hardware has a fixed 1MiB indirect page size.  e6500
   has variable size indirect entries, with a minimum of 2MiB.
   So we can't do the half-page indirect mapping, and even if we
   could it would be less efficient than mapping the full page.

 - Like on e5500, the linear mapping is bolted, so we don't need the
   overhead of supporting nested tlb misses.

Note that hardware tablewalk does not work in rev1 of e6500.
We do not expect to support e6500 rev1 in mainline Linux.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Mihai Caraman <mihai.caraman@freescale.com>
---
v4: Ensure that MAS2 is 2M-aligned when writing an indirect entry.
It doesn't matter on real e6500 hardware, but it was noticed when
running under KVM, and the architecture does say that those bits
"software should set these bits to zero".

 arch/powerpc/include/asm/mmu-book3e.h |  13 +++
 arch/powerpc/include/asm/mmu.h        |  21 +++--
 arch/powerpc/include/asm/paca.h       |   6 ++
 arch/powerpc/kernel/asm-offsets.c     |   9 ++
 arch/powerpc/kernel/paca.c            |   5 +
 arch/powerpc/kernel/setup_64.c        |  31 ++++++
 arch/powerpc/mm/fsl_booke_mmu.c       |   7 ++
 arch/powerpc/mm/mem.c                 |   6 ++
 arch/powerpc/mm/tlb_low_64e.S         | 171 ++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/tlb_nohash.c          |  93 ++++++++++++------
 10 files changed, 326 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index 936db36..89b785d 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -286,8 +286,21 @@ static inline unsigned int mmu_psize_to_shift(unsigned int mmu_psize)
 extern int mmu_linear_psize;
 extern int mmu_vmemmap_psize;
 
+struct tlb_core_data {
+	/* For software way selection, as on Freescale TLB1 */
+	u8 esel_next, esel_max, esel_first;
+
+	/* Per-core spinlock for e6500 TLB handlers (no tlbsrx.) */
+	u8 lock;
+};
+
 #ifdef CONFIG_PPC64
 extern unsigned long linear_map_top;
+extern int book3e_htw_mode;
+
+#define PPC_HTW_NONE	0
+#define PPC_HTW_IBM	1
+#define PPC_HTW_E6500	2
 
 /*
  * 64-bit booke platforms don't load the tlb in the tlb miss handler code.
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 691fd8a..f8d1d6d 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -180,16 +180,17 @@ static inline void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 #define MMU_PAGE_64K_AP	3	/* "Admixed pages" (hash64 only) */
 #define MMU_PAGE_256K	4
 #define MMU_PAGE_1M	5
-#define MMU_PAGE_4M	6
-#define MMU_PAGE_8M	7
-#define MMU_PAGE_16M	8
-#define MMU_PAGE_64M	9
-#define MMU_PAGE_256M	10
-#define MMU_PAGE_1G	11
-#define MMU_PAGE_16G	12
-#define MMU_PAGE_64G	13
-
-#define MMU_PAGE_COUNT	14
+#define MMU_PAGE_2M	6
+#define MMU_PAGE_4M	7
+#define MMU_PAGE_8M	8
+#define MMU_PAGE_16M	9
+#define MMU_PAGE_64M	10
+#define MMU_PAGE_256M	11
+#define MMU_PAGE_1G	12
+#define MMU_PAGE_16G	13
+#define MMU_PAGE_64G	14
+
+#define MMU_PAGE_COUNT	15
 
 #if defined(CONFIG_PPC_STD_MMU_64)
 /* 64-bit classic hash table MMU */
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index c3523d1..e81731c 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -113,6 +113,10 @@ struct paca_struct {
 	/* Keep pgd in the same cacheline as the start of extlb */
 	pgd_t *pgd __attribute__((aligned(0x80))); /* Current PGD */
 	pgd_t *kernel_pgd;		/* Kernel PGD */
+
+	/* Shared by all threads of a core -- points to tcd of first thread */
+	struct tlb_core_data *tcd_ptr;
+
 	/* We can have up to 3 levels of reentrancy in the TLB miss handler */
 	u64 extlb[3][EX_TLB_SIZE / sizeof(u64)];
 	u64 exmc[8];		/* used for machine checks */
@@ -123,6 +127,8 @@ struct paca_struct {
 	void *mc_kstack;
 	void *crit_kstack;
 	void *dbg_kstack;
+
+	struct tlb_core_data tcd;
 #endif /* CONFIG_PPC_BOOK3E */
 
 	mm_context_t context;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 41a2839..ed8d68c 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -203,6 +203,15 @@ int main(void)
 	DEFINE(PACA_MC_STACK, offsetof(struct paca_struct, mc_kstack));
 	DEFINE(PACA_CRIT_STACK, offsetof(struct paca_struct, crit_kstack));
 	DEFINE(PACA_DBG_STACK, offsetof(struct paca_struct, dbg_kstack));
+	DEFINE(PACA_TCD_PTR, offsetof(struct paca_struct, tcd_ptr));
+
+	DEFINE(TCD_ESEL_NEXT,
+		offsetof(struct tlb_core_data, esel_next));
+	DEFINE(TCD_ESEL_MAX,
+		offsetof(struct tlb_core_data, esel_max));
+	DEFINE(TCD_ESEL_FIRST,
+		offsetof(struct tlb_core_data, esel_first));
+	DEFINE(TCD_LOCK, offsetof(struct tlb_core_data, lock));
 #endif /* CONFIG_PPC_BOOK3E */
 
 #ifdef CONFIG_PPC_STD_MMU_64
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 623c356..bf0aada 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -160,6 +160,11 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 #ifdef CONFIG_PPC_STD_MMU_64
 	new_paca->slb_shadow_ptr = init_slb_shadow(cpu);
 #endif /* CONFIG_PPC_STD_MMU_64 */
+
+#ifdef CONFIG_PPC_BOOK3E
+	/* For now -- if we have threads this will be adjusted later */
+	new_paca->tcd_ptr = &new_paca->tcd;
+#endif
 }
 
 /* Put the paca pointer into r13 and SPRG_PACA */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 2232aff..1ce9b87 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -97,6 +97,36 @@ int dcache_bsize;
 int icache_bsize;
 int ucache_bsize;
 
+#if defined(CONFIG_PPC_BOOK3E) && defined(CONFIG_SMP)
+static void setup_tlb_core_data(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		int first = cpu_first_thread_sibling(cpu);
+
+		paca[cpu].tcd_ptr = &paca[first].tcd;
+
+		/*
+		 * If we have threads, we need either tlbsrx.
+		 * or e6500 tablewalk mode, or else TLB handlers
+		 * will be racy and could produce duplicate entries.
+		 */
+		if (smt_enabled_at_boot >= 2 &&
+		    !mmu_has_feature(MMU_FTR_USE_TLBRSRV) &&
+		    book3e_htw_mode != PPC_HTW_E6500) {
+			/* Should we panic instead? */
+			WARN_ONCE("%s: unsupported MMU configuration -- expect problems\n",
+				  __func__);
+		}
+	}
+}
+#else
+static void setup_tlb_core_data(void)
+{
+}
+#endif
+
 #ifdef CONFIG_SMP
 
 static char *smt_enabled_cmdline;
@@ -445,6 +475,7 @@ void __init setup_system(void)
 
 	smp_setup_cpu_maps();
 	check_smt_enabled();
+	setup_tlb_core_data();
 
 #ifdef CONFIG_SMP
 	/* Release secondary cpus out of their spinloops at 0x60 now that
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index a68671c..94cd728 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -52,6 +52,7 @@
 #include <asm/smp.h>
 #include <asm/machdep.h>
 #include <asm/setup.h>
+#include <asm/paca.h>
 
 #include "mmu_decl.h"
 
@@ -191,6 +192,12 @@ static unsigned long map_mem_in_cams_addr(phys_addr_t phys, unsigned long virt,
 	}
 	tlbcam_index = i;
 
+#ifdef CONFIG_PPC64
+	get_paca()->tcd.esel_next = i;
+	get_paca()->tcd.esel_max = mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY;
+	get_paca()->tcd.esel_first = i;
+#endif
+
 	return amount_mapped;
 }
 
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 3fa93dc..94448cd 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -307,6 +307,12 @@ static void __init register_page_bootmem_info(void)
 
 void __init mem_init(void)
 {
+	/*
+	 * book3s is limited to 16 page sizes due to encoding this in
+	 * a 4-bit field for slices.
+	 */
+	BUILD_BUG_ON(MMU_PAGE_COUNT > 16);
+
 #ifdef CONFIG_SWIOTLB
 	swiotlb_init(0);
 #endif
diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index b4113bf..75f5d27 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -239,6 +239,177 @@ itlb_miss_fault_bolted:
 	beq	tlb_miss_common_bolted
 	b	itlb_miss_kernel_bolted
 
+/*
+ * TLB miss handling for e6500 and derivatives, using hardware tablewalk.
+ *
+ * Linear mapping is bolted: no virtual page table or nested TLB misses
+ * Indirect entries in TLB1, hardware loads resulting direct entries
+ *    into TLB0
+ * No HES or NV hint on TLB1, so we need to do software round-robin
+ * No tlbsrx. so we need a spinlock, and we have to deal
+ *    with MAS-damage caused by tlbsx
+ * 4K pages only
+ */
+
+	START_EXCEPTION(instruction_tlb_miss_e6500)
+	tlb_prolog_bolted BOOKE_INTERRUPT_ITLB_MISS SPRN_SRR0
+
+	ld	r11,PACA_TCD_PTR(r13)
+	srdi.	r15,r16,60		/* get region */
+	ori	r16,r16,1
+
+	TLB_MISS_STATS_SAVE_INFO_BOLTED
+	bne	tlb_miss_kernel_e6500	/* user/kernel test */
+
+	b	tlb_miss_common_e6500
+
+	START_EXCEPTION(data_tlb_miss_e6500)
+	tlb_prolog_bolted BOOKE_INTERRUPT_DTLB_MISS SPRN_DEAR
+
+	ld	r11,PACA_TCD_PTR(r13)
+	srdi.	r15,r16,60		/* get region */
+	rldicr	r16,r16,0,62
+
+	TLB_MISS_STATS_SAVE_INFO_BOLTED
+	bne	tlb_miss_kernel_e6500	/* user vs kernel check */
+
+/*
+ * This is the guts of the TLB miss handler for e6500 and derivatives.
+ * We are entered with:
+ *
+ * r16 = page of faulting address (low bit 0 if data, 1 if instruction)
+ * r15 = crap (free to use)
+ * r14 = page table base
+ * r13 = PACA
+ * r11 = tlb_per_core ptr
+ * r10 = crap (free to use)
+ */
+tlb_miss_common_e6500:
+	/*
+	 * Search if we already have an indirect entry for that virtual
+	 * address, and if we do, bail out.
+	 *
+	 * MAS6:IND should be already set based on MAS4
+	 */
+	addi	r10,r11,TCD_LOCK
+1:	lbarx	r15,0,r10
+	cmpdi	r15,0
+	bne	2f
+	li	r15,1
+	stbcx.	r15,0,r10
+	bne	1b
+	.subsection 1
+2:	lbz	r15,0(r10)
+	cmpdi	r15,0
+	bne	2b
+	b	1b
+	.previous
+
+	mfspr	r15,SPRN_MAS2
+
+	tlbsx	0,r16
+	mfspr	r10,SPRN_MAS1
+	andis.	r10,r10,MAS1_VALID@h
+	bne	tlb_miss_done_e6500
+
+	/* Undo MAS-damage from the tlbsx */
+	mfspr	r10,SPRN_MAS1
+	oris	r10,r10,MAS1_VALID@h
+	mtspr	SPRN_MAS1,r10
+	mtspr	SPRN_MAS2,r15
+
+	/* Now, we need to walk the page tables. First check if we are in
+	 * range.
+	 */
+	rldicl.	r10,r16,64-PGTABLE_EADDR_SIZE,PGTABLE_EADDR_SIZE+4
+	bne-	tlb_miss_fault_e6500
+
+	rldicl	r15,r16,64-PGDIR_SHIFT+3,64-PGD_INDEX_SIZE-3
+	cmpldi	cr0,r14,0
+	clrrdi	r15,r15,3
+	beq-	tlb_miss_fault_e6500 /* No PGDIR, bail */
+	ldx	r14,r14,r15		/* grab pgd entry */
+
+	rldicl	r15,r16,64-PUD_SHIFT+3,64-PUD_INDEX_SIZE-3
+	clrrdi	r15,r15,3
+	cmpdi	cr0,r14,0
+	bge	tlb_miss_fault_e6500	/* Bad pgd entry or hugepage; bail */
+	ldx	r14,r14,r15		/* grab pud entry */
+
+	rldicl	r15,r16,64-PMD_SHIFT+3,64-PMD_INDEX_SIZE-3
+	clrrdi	r15,r15,3
+	cmpdi	cr0,r14,0
+	bge	tlb_miss_fault_e6500
+	ldx	r14,r14,r15		/* Grab pmd entry */
+
+	mfspr	r10,SPRN_MAS0
+	cmpdi	cr0,r14,0
+	bge	tlb_miss_fault_e6500
+
+	/* Now we build the MAS for a 2M indirect page:
+	 *
+	 * MAS 0   :	ESEL needs to be filled by software round-robin
+	 * MAS 1   :	Fully set up
+	 *               - PID already updated by caller if necessary
+	 *               - TSIZE for now is base ind page size always
+	 *               - TID already cleared if necessary
+	 * MAS 2   :	Default not 2M-aligned, need to be redone
+	 * MAS 3+7 :	Needs to be done
+	 */
+
+	ori	r14,r14,(BOOK3E_PAGESZ_4K << MAS3_SPSIZE_SHIFT)
+	mtspr	SPRN_MAS7_MAS3,r14
+
+	clrrdi	r15,r16,21		/* make EA 2M-aligned */
+	mtspr	SPRN_MAS2,r15
+
+	lbz	r15,TCD_ESEL_NEXT(r11)
+	lbz	r16,TCD_ESEL_MAX(r11)
+	lbz	r14,TCD_ESEL_FIRST(r11)
+	rlwimi	r10,r15,16,0x00ff0000	/* insert esel_next into MAS0 */
+	addi	r15,r15,1		/* increment esel_next */
+	mtspr	SPRN_MAS0,r10
+	cmpw	r15,r16
+	iseleq	r15,r14,r15		/* if next == last use first */
+	stb	r15,TCD_ESEL_NEXT(r11)
+
+	tlbwe
+
+tlb_miss_done_e6500:
+	.macro	tlb_unlock_e6500
+	li	r15,0
+	isync
+	stb	r15,TCD_LOCK(r11)
+	.endm
+
+	tlb_unlock_e6500
+	TLB_MISS_STATS_X(MMSTAT_TLB_MISS_NORM_OK)
+	tlb_epilog_bolted
+	rfi
+
+tlb_miss_kernel_e6500:
+	mfspr	r10,SPRN_MAS1
+	ld	r14,PACA_KERNELPGD(r13)
+	cmpldi	cr0,r15,8		/* Check for vmalloc region */
+	rlwinm	r10,r10,0,16,1		/* Clear TID */
+	mtspr	SPRN_MAS1,r10
+	beq+	tlb_miss_common_e6500
+
+tlb_miss_fault_e6500:
+	tlb_unlock_e6500
+	/* We need to check if it was an instruction miss */
+	andi.	r16,r16,1
+	bne	itlb_miss_fault_e6500
+dtlb_miss_fault_e6500:
+	TLB_MISS_STATS_D(MMSTAT_TLB_MISS_NORM_FAULT)
+	tlb_epilog_bolted
+	b	exc_data_storage_book3e
+itlb_miss_fault_e6500:
+	TLB_MISS_STATS_I(MMSTAT_TLB_MISS_NORM_FAULT)
+	tlb_epilog_bolted
+	b	exc_instruction_storage_book3e
+
+
 /**********************************************************************
  *                                                                    *
  * TLB miss handling for Book3E with TLB reservation and HES support  *
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 8805b7b..735839b 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -43,6 +43,7 @@
 #include <asm/tlb.h>
 #include <asm/code-patching.h>
 #include <asm/hugetlb.h>
+#include <asm/paca.h>
 
 #include "mmu_decl.h"
 
@@ -58,6 +59,10 @@ struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 		.shift	= 12,
 		.enc	= BOOK3E_PAGESZ_4K,
 	},
+	[MMU_PAGE_2M] = {
+		.shift	= 21,
+		.enc	= BOOK3E_PAGESZ_2M,
+	},
 	[MMU_PAGE_4M] = {
 		.shift	= 22,
 		.enc	= BOOK3E_PAGESZ_4M,
@@ -136,7 +141,7 @@ static inline int mmu_get_tsize(int psize)
 int mmu_linear_psize;		/* Page size used for the linear mapping */
 int mmu_pte_psize;		/* Page size used for PTE pages */
 int mmu_vmemmap_psize;		/* Page size used for the virtual mem map */
-int book3e_htw_enabled;		/* Is HW tablewalk enabled ? */
+int book3e_htw_mode;		/* HW tablewalk?  Value is PPC_HTW_* */
 unsigned long linear_map_top;	/* Top of linear mapping */
 
 #endif /* CONFIG_PPC64 */
@@ -377,7 +382,7 @@ void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long address)
 {
 	int tsize = mmu_psize_defs[mmu_pte_psize].enc;
 
-	if (book3e_htw_enabled) {
+	if (book3e_htw_mode != PPC_HTW_NONE) {
 		unsigned long start = address & PMD_MASK;
 		unsigned long end = address + PMD_SIZE;
 		unsigned long size = 1UL << mmu_psize_defs[mmu_pte_psize].shift;
@@ -430,7 +435,7 @@ static void setup_page_sizes(void)
 			def = &mmu_psize_defs[psize];
 			shift = def->shift;
 
-			if (shift == 0)
+			if (shift == 0 || shift & 1)
 				continue;
 
 			/* adjust to be in terms of 4^shift Kb */
@@ -440,21 +445,40 @@ static void setup_page_sizes(void)
 				def->flags |= MMU_PAGE_SIZE_DIRECT;
 		}
 
-		goto no_indirect;
+		goto out;
 	}
 
 	if (fsl_mmu && (mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V2) {
-		u32 tlb1ps = mfspr(SPRN_TLB1PS);
+		u32 tlb1cfg, tlb1ps;
+
+		tlb0cfg = mfspr(SPRN_TLB0CFG);
+		tlb1cfg = mfspr(SPRN_TLB1CFG);
+		tlb1ps = mfspr(SPRN_TLB1PS);
+		eptcfg = mfspr(SPRN_EPTCFG);
+
+		if ((tlb1cfg & TLBnCFG_IND) && (tlb0cfg & TLBnCFG_PT))
+			book3e_htw_mode = PPC_HTW_E6500;
+
+		/*
+		 * We expect 4K subpage size and unrestricted indirect size.
+		 * The lack of a restriction on indirect size is a Freescale
+		 * extension, indicated by PSn = 0 but SPSn != 0.
+		 */
+		if (eptcfg != 2)
+			book3e_htw_mode = PPC_HTW_NONE;
 
 		for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
 			struct mmu_psize_def *def = &mmu_psize_defs[psize];
 
 			if (tlb1ps & (1U << (def->shift - 10))) {
 				def->flags |= MMU_PAGE_SIZE_DIRECT;
+
+				if (book3e_htw_mode && psize == MMU_PAGE_2M)
+					def->flags |= MMU_PAGE_SIZE_INDIRECT;
 			}
 		}
 
-		goto no_indirect;
+		goto out;
 	}
 #endif
 
@@ -471,8 +495,11 @@ static void setup_page_sizes(void)
 	}
 
 	/* Indirect page sizes supported ? */
-	if ((tlb0cfg & TLBnCFG_IND) == 0)
-		goto no_indirect;
+	if ((tlb0cfg & TLBnCFG_IND) == 0 ||
+	    (tlb0cfg & TLBnCFG_PT) == 0)
+		goto out;
+
+	book3e_htw_mode = PPC_HTW_IBM;
 
 	/* Now, we only deal with one IND page size for each
 	 * direct size. Hopefully all implementations today are
@@ -497,8 +524,8 @@ static void setup_page_sizes(void)
 				def->ind = ps + 10;
 		}
 	}
- no_indirect:
 
+out:
 	/* Cleanup array and print summary */
 	pr_info("MMU: Supported page sizes\n");
 	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
@@ -520,23 +547,23 @@ static void setup_page_sizes(void)
 
 static void setup_mmu_htw(void)
 {
-	/* Check if HW tablewalk is present, and if yes, enable it by:
-	 *
-	 * - patching the TLB miss handlers to branch to the
-	 *   one dedicates to it
-	 *
-	 * - setting the global book3e_htw_enabled
-       	 */
-	unsigned int tlb0cfg = mfspr(SPRN_TLB0CFG);
+	/*
+	 * If we want to use HW tablewalk, enable it by patching the TLB miss
+	 * handlers to branch to the one dedicated to it.
+	 */
 
-	if ((tlb0cfg & TLBnCFG_IND) &&
-	    (tlb0cfg & TLBnCFG_PT)) {
+	switch (book3e_htw_mode) {
+	case PPC_HTW_IBM:
 		patch_exception(0x1c0, exc_data_tlb_miss_htw_book3e);
 		patch_exception(0x1e0, exc_instruction_tlb_miss_htw_book3e);
-		book3e_htw_enabled = 1;
+		break;
+	case PPC_HTW_E6500:
+		patch_exception(0x1c0, exc_data_tlb_miss_e6500_book3e);
+		patch_exception(0x1e0, exc_instruction_tlb_miss_e6500_book3e);
+		break;
 	}
 	pr_info("MMU: Book3E HW tablewalk %s\n",
-		book3e_htw_enabled ? "enabled" : "not supported");
+		book3e_htw_mode != PPC_HTW_NONE ? "enabled" : "not supported");
 }
 
 /*
@@ -576,8 +603,16 @@ static void __early_init_mmu(int boot_cpu)
 	/* Set MAS4 based on page table setting */
 
 	mas4 = 0x4 << MAS4_WIMGED_SHIFT;
-	if (book3e_htw_enabled) {
-		mas4 |= mas4 | MAS4_INDD;
+	switch (book3e_htw_mode) {
+	case PPC_HTW_E6500:
+		mas4 |= MAS4_INDD;
+		mas4 |= BOOK3E_PAGESZ_2M << MAS4_TSIZED_SHIFT;
+		mas4 |= MAS4_TLBSELD(1);
+		mmu_pte_psize = MMU_PAGE_2M;
+		break;
+
+	case PPC_HTW_IBM:
+		mas4 |= MAS4_INDD;
 #ifdef CONFIG_PPC_64K_PAGES
 		mas4 |=	BOOK3E_PAGESZ_256M << MAS4_TSIZED_SHIFT;
 		mmu_pte_psize = MMU_PAGE_256M;
@@ -585,13 +620,16 @@ static void __early_init_mmu(int boot_cpu)
 		mas4 |=	BOOK3E_PAGESZ_1M << MAS4_TSIZED_SHIFT;
 		mmu_pte_psize = MMU_PAGE_1M;
 #endif
-	} else {
+		break;
+
+	case PPC_HTW_NONE:
 #ifdef CONFIG_PPC_64K_PAGES
 		mas4 |=	BOOK3E_PAGESZ_64K << MAS4_TSIZED_SHIFT;
 #else
 		mas4 |=	BOOK3E_PAGESZ_4K << MAS4_TSIZED_SHIFT;
 #endif
 		mmu_pte_psize = mmu_virtual_psize;
+		break;
 	}
 	mtspr(SPRN_MAS4, mas4);
 
@@ -611,8 +649,11 @@ static void __early_init_mmu(int boot_cpu)
 		/* limit memory so we dont have linear faults */
 		memblock_enforce_memory_limit(linear_map_top);
 
-		patch_exception(0x1c0, exc_data_tlb_miss_bolted_book3e);
-		patch_exception(0x1e0, exc_instruction_tlb_miss_bolted_book3e);
+		if (book3e_htw_mode == PPC_HTW_NONE) {
+			patch_exception(0x1c0, exc_data_tlb_miss_bolted_book3e);
+			patch_exception(0x1e0,
+				exc_instruction_tlb_miss_bolted_book3e);
+		}
 	}
 #endif
 
-- 
1.8.3.2
