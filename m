Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EF891A00EF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 12:29:31 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/9] powerpc: Remove STAB code
Date: Thu, 10 Jul 2014 12:29:19 +1000
Message-Id: <1404959366-17664-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1404959366-17664-1-git-send-email-mpe@ellerman.id.au>
References: <1404959366-17664-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Old cpus didn't have a Segment Lookaside Buffer (SLB), instead they had
a Segment Table (STAB). Now that we've dropped support for those cpus,
we can remove the STAB support entirely.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/mmu-hash64.h  |  22 ---
 arch/powerpc/include/asm/mmu_context.h |   3 -
 arch/powerpc/include/asm/paca.h        |   4 -
 arch/powerpc/include/asm/reg.h         |   2 +-
 arch/powerpc/kernel/asm-offsets.c      |   2 -
 arch/powerpc/kernel/exceptions-64s.S   | 155 ------------------
 arch/powerpc/kernel/head_64.S          |   8 +-
 arch/powerpc/kernel/setup_64.c         |   3 -
 arch/powerpc/mm/Makefile               |   4 +-
 arch/powerpc/mm/hash_utils_64.c        |  18 +--
 arch/powerpc/mm/stab.c                 | 286 ---------------------------------
 arch/powerpc/xmon/xmon.c               |  26 ---
 12 files changed, 11 insertions(+), 522 deletions(-)
 delete mode 100644 arch/powerpc/mm/stab.c

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 807014dde821..78fc19496e54 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -24,26 +24,6 @@
 #include <asm/bug.h>
 
 /*
- * Segment table
- */
-
-#define STE_ESID_V	0x80
-#define STE_ESID_KS	0x20
-#define STE_ESID_KP	0x10
-#define STE_ESID_N	0x08
-
-#define STE_VSID_SHIFT	12
-
-/* Location of cpu0's segment table */
-#define STAB0_PAGE	0x8
-#define STAB0_OFFSET	(STAB0_PAGE << 12)
-#define STAB0_PHYS_ADDR	(STAB0_OFFSET + PHYSICAL_START)
-
-#ifndef __ASSEMBLY__
-extern char initial_stab[];
-#endif /* ! __ASSEMBLY */
-
-/*
  * SLB
  */
 
@@ -369,10 +349,8 @@ extern void hpte_init_lpar(void);
 extern void hpte_init_beat(void);
 extern void hpte_init_beat_v3(void);
 
-extern void stabs_alloc(void);
 extern void slb_initialize(void);
 extern void slb_flush_and_rebolt(void);
-extern void stab_initialize(unsigned long stab);
 
 extern void slb_vmalloc_update(void);
 extern void slb_set_size(u16 size);
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index b467530e2485..f5690e2689c7 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -18,7 +18,6 @@ extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
 extern void destroy_context(struct mm_struct *mm);
 
 extern void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next);
-extern void switch_stab(struct task_struct *tsk, struct mm_struct *mm);
 extern void switch_slb(struct task_struct *tsk, struct mm_struct *mm);
 extern void set_context(unsigned long id, pgd_t *pgd);
 
@@ -79,8 +78,6 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 #ifdef CONFIG_PPC_STD_MMU_64
 	if (mmu_has_feature(MMU_FTR_SLB))
 		switch_slb(tsk, next);
-	else
-		switch_stab(tsk, next);
 #else
 	/* Out of line for now */
 	switch_mmu_context(prev, next);
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index bb0bd25f20d0..5abde4e223bb 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -78,10 +78,6 @@ struct paca_struct {
 	u64 kernel_toc;			/* Kernel TOC address */
 	u64 kernelbase;			/* Base address of kernel */
 	u64 kernel_msr;			/* MSR while running in kernel */
-#ifdef CONFIG_PPC_STD_MMU_64
-	u64 stab_real;			/* Absolute address of segment table */
-	u64 stab_addr;			/* Virtual address of segment table */
-#endif /* CONFIG_PPC_STD_MMU_64 */
 	void *emergency_sp;		/* pointer to emergency stack */
 	u64 data_offset;		/* per cpu data offset */
 	s16 hw_cpu_id;			/* Physical processor number */
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index bffd89d27301..f7b97b895708 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -254,7 +254,7 @@
 #define   DSISR_PROTFAULT	0x08000000	/* protection fault */
 #define   DSISR_ISSTORE		0x02000000	/* access was a store */
 #define   DSISR_DABRMATCH	0x00400000	/* hit data breakpoint */
-#define   DSISR_NOSEGMENT	0x00200000	/* STAB/SLB miss */
+#define   DSISR_NOSEGMENT	0x00200000	/* SLB miss */
 #define   DSISR_KEYFAULT	0x00200000	/* Key fault */
 #define SPRN_TBRL	0x10C	/* Time Base Read Lower Register (user, R/O) */
 #define SPRN_TBRU	0x10D	/* Time Base Read Upper Register (user, R/O) */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index f5995a912213..e35054054c32 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -216,8 +216,6 @@ int main(void)
 #endif /* CONFIG_PPC_BOOK3E */
 
 #ifdef CONFIG_PPC_STD_MMU_64
-	DEFINE(PACASTABREAL, offsetof(struct paca_struct, stab_real));
-	DEFINE(PACASTABVIRT, offsetof(struct paca_struct, stab_addr));
 	DEFINE(PACASLBCACHE, offsetof(struct paca_struct, slb_cache));
 	DEFINE(PACASLBCACHEPTR, offsetof(struct paca_struct, slb_cache_ptr));
 	DEFINE(PACAVMALLOCSLLP, offsetof(struct paca_struct, vmalloc_sllp));
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a7d36b19221d..b859b3665be6 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -188,10 +188,6 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 data_access_pSeries:
 	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)
-BEGIN_FTR_SECTION
-	b	data_access_check_stab
-data_access_not_stab:
-END_MMU_FTR_SECTION_IFCLR(MMU_FTR_SLB)
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, data_access_common, EXC_STD,
 				 KVMTEST, 0x300)
 
@@ -514,34 +510,6 @@ machine_check_pSeries_0:
 	EXCEPTION_PROLOG_1(PACA_EXMC, KVMTEST, 0x200)
 	EXCEPTION_PROLOG_PSERIES_1(machine_check_common, EXC_STD)
 	KVM_HANDLER_SKIP(PACA_EXMC, EXC_STD, 0x200)
-
-	/* moved from 0x300 */
-data_access_check_stab:
-	GET_PACA(r13)
-	std	r9,PACA_EXSLB+EX_R9(r13)
-	std	r10,PACA_EXSLB+EX_R10(r13)
-	mfspr	r10,SPRN_DAR
-	mfspr	r9,SPRN_DSISR
-	srdi	r10,r10,60
-	rlwimi	r10,r9,16,0x20
-#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
-	lbz	r9,HSTATE_IN_GUEST(r13)
-	rlwimi	r10,r9,8,0x300
-#endif
-	mfcr	r9
-	cmpwi	r10,0x2c
-	beq	do_stab_bolted_pSeries
-	mtcrf	0x80,r9
-	ld	r9,PACA_EXSLB+EX_R9(r13)
-	ld	r10,PACA_EXSLB+EX_R10(r13)
-	b	data_access_not_stab
-do_stab_bolted_pSeries:
-	std	r11,PACA_EXSLB+EX_R11(r13)
-	std	r12,PACA_EXSLB+EX_R12(r13)
-	GET_SCRATCH0(r10)
-	std	r10,PACA_EXSLB+EX_R13(r13)
-	EXCEPTION_PROLOG_PSERIES_1(do_stab_bolted, EXC_STD)
-
 	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_STD, 0x300)
 	KVM_HANDLER_SKIP(PACA_EXSLB, EXC_STD, 0x380)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x400)
@@ -1338,12 +1306,6 @@ fwnmi_data_area:
 	. = 0x8000
 #endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
 
-/* Space for CPU0's segment table */
-	.balign 4096
-	.globl initial_stab
-initial_stab:
-	.space	4096
-
 #ifdef CONFIG_PPC_POWERNV
 _GLOBAL(opal_mc_secondary_handler)
 	HMT_MEDIUM_PPR_DISCARD
@@ -1594,12 +1556,6 @@ do_hash_page:
 	bne-	handle_page_fault	/* if not, try to insert a HPTE */
 	andis.  r0,r4,DSISR_DABRMATCH@h
 	bne-    handle_dabr_fault
-
-BEGIN_FTR_SECTION
-	andis.	r0,r4,0x0020		/* Is it a segment table fault? */
-	bne-	do_ste_alloc		/* If so handle it */
-END_MMU_FTR_SECTION_IFCLR(MMU_FTR_SLB)
-
 	CURRENT_THREAD_INFO(r11, r1)
 	lwz	r0,TI_PREEMPT(r11)	/* If we're in an "NMI" */
 	andis.	r0,r0,NMI_MASK@h	/* (i.e. an irq when soft-disabled) */
@@ -1680,114 +1636,3 @@ handle_dabr_fault:
 	li	r5,SIGSEGV
 	bl	bad_page_fault
 	b	ret_from_except
-
-	/* here we have a segment miss */
-do_ste_alloc:
-	bl	ste_allocate		/* try to insert stab entry */
-	cmpdi	r3,0
-	bne-	handle_page_fault
-	b	fast_exception_return
-
-/*
- * r13 points to the PACA, r9 contains the saved CR,
- * r11 and r12 contain the saved SRR0 and SRR1.
- * r9 - r13 are saved in paca->exslb.
- * We assume we aren't going to take any exceptions during this procedure.
- * We assume (DAR >> 60) == 0xc.
- */
-	.align	7
-do_stab_bolted:
-	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
-	std	r11,PACA_EXSLB+EX_SRR0(r13)	/* save SRR0 in exc. frame */
-	mfspr	r11,SPRN_DAR			/* ea */
-
-	/*
-	 * check for bad kernel/user address
-	 * (ea & ~REGION_MASK) >= PGTABLE_RANGE
-	 */
-	rldicr. r9,r11,4,(63 - 46 - 4)
-	li	r9,0	/* VSID = 0 for bad address */
-	bne-	0f
-
-	/*
-	 * Calculate VSID:
-	 * This is the kernel vsid, we take the top for context from
-	 * the range. context = (MAX_USER_CONTEXT) + ((ea >> 60) - 0xc) + 1
-	 * Here we know that (ea >> 60) == 0xc
-	 */
-	lis	r9,(MAX_USER_CONTEXT + 1)@ha
-	addi	r9,r9,(MAX_USER_CONTEXT + 1)@l
-
-	srdi	r10,r11,SID_SHIFT
-	rldimi  r10,r9,ESID_BITS,0 /* proto vsid */
-	ASM_VSID_SCRAMBLE(r10, r9, 256M)
-	rldic	r9,r10,12,16	/* r9 = vsid << 12 */
-
-0:
-	/* Hash to the primary group */
-	ld	r10,PACASTABVIRT(r13)
-	srdi	r11,r11,SID_SHIFT
-	rldimi	r10,r11,7,52	/* r10 = first ste of the group */
-
-	/* Search the primary group for a free entry */
-1:	ld	r11,0(r10)	/* Test valid bit of the current ste	*/
-	andi.	r11,r11,0x80
-	beq	2f
-	addi	r10,r10,16
-	andi.	r11,r10,0x70
-	bne	1b
-
-	/* Stick for only searching the primary group for now.		*/
-	/* At least for now, we use a very simple random castout scheme */
-	/* Use the TB as a random number ;  OR in 1 to avoid entry 0	*/
-	mftb	r11
-	rldic	r11,r11,4,57	/* r11 = (r11 << 4) & 0x70 */
-	ori	r11,r11,0x10
-
-	/* r10 currently points to an ste one past the group of interest */
-	/* make it point to the randomly selected entry			*/
-	subi	r10,r10,128
-	or 	r10,r10,r11	/* r10 is the entry to invalidate	*/
-
-	isync			/* mark the entry invalid		*/
-	ld	r11,0(r10)
-	rldicl	r11,r11,56,1	/* clear the valid bit */
-	rotldi	r11,r11,8
-	std	r11,0(r10)
-	sync
-
-	clrrdi	r11,r11,28	/* Get the esid part of the ste		*/
-	slbie	r11
-
-2:	std	r9,8(r10)	/* Store the vsid part of the ste	*/
-	eieio
-
-	mfspr	r11,SPRN_DAR		/* Get the new esid			*/
-	clrrdi	r11,r11,28	/* Permits a full 32b of ESID		*/
-	ori	r11,r11,0x90	/* Turn on valid and kp			*/
-	std	r11,0(r10)	/* Put new entry back into the stab	*/
-
-	sync
-
-	/* All done -- return from exception. */
-	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
-	ld	r11,PACA_EXSLB+EX_SRR0(r13)	/* get saved SRR0 */
-
-	andi.	r10,r12,MSR_RI
-	beq-	unrecov_slb
-
-	mtcrf	0x80,r9			/* restore CR */
-
-	mfmsr	r10
-	clrrdi	r10,r10,2
-	mtmsrd	r10,1
-
-	mtspr	SPRN_SRR0,r11
-	mtspr	SPRN_SRR1,r12
-	ld	r9,PACA_EXSLB+EX_R9(r13)
-	ld	r10,PACA_EXSLB+EX_R10(r13)
-	ld	r11,PACA_EXSLB+EX_R11(r13)
-	ld	r12,PACA_EXSLB+EX_R12(r13)
-	ld	r13,PACA_EXSLB+EX_R13(r13)
-	rfid
-	b	.	/* prevent speculative execution */
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index a95145d7f61b..41ab76c3a94a 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -618,7 +618,7 @@ __secondary_start:
 	addi	r14,r14,THREAD_SIZE-STACK_FRAME_OVERHEAD
 	std	r14,PACAKSAVE(r13)
 
-	/* Do early setup for that CPU (stab, slb, hash table pointer) */
+	/* Do early setup for that CPU (SLB and hash table pointer) */
 	bl	early_setup_secondary
 
 	/*
@@ -771,8 +771,10 @@ start_here_multiplatform:
 	li	r0,0
 	stdu	r0,-STACK_FRAME_OVERHEAD(r1)
 
-	/* Do very early kernel initializations, including initial hash table,
-	 * stab and slb setup before we turn on relocation.	*/
+	/*
+	 * Do very early kernel initializations, including initial hash table
+	 * and SLB setup before we turn on relocation.
+	 */
 
 	/* Restore parameters passed from prom_init/kexec */
 	mr	r3,r31
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index ee082d771178..694339043b56 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -673,9 +673,6 @@ void __init setup_arch(char **cmdline_p)
 	exc_lvl_early_init();
 	emergency_stack_init();
 
-#ifdef CONFIG_PPC_STD_MMU_64
-	stabs_alloc();
-#endif
 	/* set up the bootmem stuff with available memory */
 	do_init_bootmem();
 	sparse_init();
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 51230ee6a407..d0130fff20e5 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -13,9 +13,7 @@ obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
 				   tlb_nohash_low.o
 obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(CONFIG_WORD_SIZE)e.o
 hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
-obj-$(CONFIG_PPC_STD_MMU_64)	+= hash_utils_64.o \
-				   slb_low.o slb.o stab.o \
-				   $(hash64-y)
+obj-$(CONFIG_PPC_STD_MMU_64)	+= hash_utils_64.o slb_low.o slb.o $(hash64-y)
 obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o
 obj-$(CONFIG_PPC_STD_MMU)	+= hash_low_$(CONFIG_WORD_SIZE).o \
 				   tlb_hash$(CONFIG_WORD_SIZE).o \
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 88fdd9d25077..fb8bea71327d 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -821,21 +821,15 @@ static void __init htab_initialize(void)
 
 void __init early_init_mmu(void)
 {
-	/* Setup initial STAB address in the PACA */
-	get_paca()->stab_real = __pa((u64)&initial_stab);
-	get_paca()->stab_addr = (u64)&initial_stab;
-
 	/* Initialize the MMU Hash table and create the linear mapping
-	 * of memory. Has to be done before stab/slb initialization as
-	 * this is currently where the page size encoding is obtained
+	 * of memory. Has to be done before SLB initialization as this is
+	 * currently where the page size encoding is obtained.
 	 */
 	htab_initialize();
 
-	/* Initialize stab / SLB management */
+	/* Initialize SLB management */
 	if (mmu_has_feature(MMU_FTR_SLB))
 		slb_initialize();
-	else
-		stab_initialize(get_paca()->stab_real);
 }
 
 #ifdef CONFIG_SMP
@@ -845,13 +839,9 @@ void early_init_mmu_secondary(void)
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
 		mtspr(SPRN_SDR1, _SDR1);
 
-	/* Initialize STAB/SLB. We use a virtual address as it works
-	 * in real mode on pSeries.
-	 */
+	/* Initialize SLB */
 	if (mmu_has_feature(MMU_FTR_SLB))
 		slb_initialize();
-	else
-		stab_initialize(get_paca()->stab_addr);
 }
 #endif /* CONFIG_SMP */
 
diff --git a/arch/powerpc/mm/stab.c b/arch/powerpc/mm/stab.c
deleted file mode 100644
index 3f8efa6f2997..000000000000
--- a/arch/powerpc/mm/stab.c
+++ /dev/null
@@ -1,286 +0,0 @@
-/*
- * PowerPC64 Segment Translation Support.
- *
- * Dave Engebretsen and Mike Corrigan {engebret|mikejc}@us.ibm.com
- *    Copyright (c) 2001 Dave Engebretsen
- *
- * Copyright (C) 2002 Anton Blanchard <anton@au.ibm.com>, IBM
- *
- *      This program is free software; you can redistribute it and/or
- *      modify it under the terms of the GNU General Public License
- *      as published by the Free Software Foundation; either version
- *      2 of the License, or (at your option) any later version.
- */
-
-#include <linux/memblock.h>
-
-#include <asm/pgtable.h>
-#include <asm/mmu.h>
-#include <asm/mmu_context.h>
-#include <asm/paca.h>
-#include <asm/cputable.h>
-#include <asm/prom.h>
-
-struct stab_entry {
-	unsigned long esid_data;
-	unsigned long vsid_data;
-};
-
-#define NR_STAB_CACHE_ENTRIES 8
-static DEFINE_PER_CPU(long, stab_cache_ptr);
-static DEFINE_PER_CPU(long [NR_STAB_CACHE_ENTRIES], stab_cache);
-
-/*
- * Create a segment table entry for the given esid/vsid pair.
- */
-static int make_ste(unsigned long stab, unsigned long esid, unsigned long vsid)
-{
-	unsigned long esid_data, vsid_data;
-	unsigned long entry, group, old_esid, castout_entry, i;
-	unsigned int global_entry;
-	struct stab_entry *ste, *castout_ste;
-	unsigned long kernel_segment = (esid << SID_SHIFT) >= PAGE_OFFSET;
-
-	vsid_data = vsid << STE_VSID_SHIFT;
-	esid_data = esid << SID_SHIFT | STE_ESID_KP | STE_ESID_V;
-	if (! kernel_segment)
-		esid_data |= STE_ESID_KS;
-
-	/* Search the primary group first. */
-	global_entry = (esid & 0x1f) << 3;
-	ste = (struct stab_entry *)(stab | ((esid & 0x1f) << 7));
-
-	/* Find an empty entry, if one exists. */
-	for (group = 0; group < 2; group++) {
-		for (entry = 0; entry < 8; entry++, ste++) {
-			if (!(ste->esid_data & STE_ESID_V)) {
-				ste->vsid_data = vsid_data;
-				eieio();
-				ste->esid_data = esid_data;
-				return (global_entry | entry);
-			}
-		}
-		/* Now search the secondary group. */
-		global_entry = ((~esid) & 0x1f) << 3;
-		ste = (struct stab_entry *)(stab | (((~esid) & 0x1f) << 7));
-	}
-
-	/*
-	 * Could not find empty entry, pick one with a round robin selection.
-	 * Search all entries in the two groups.
-	 */
-	castout_entry = get_paca()->stab_rr;
-	for (i = 0; i < 16; i++) {
-		if (castout_entry < 8) {
-			global_entry = (esid & 0x1f) << 3;
-			ste = (struct stab_entry *)(stab | ((esid & 0x1f) << 7));
-			castout_ste = ste + castout_entry;
-		} else {
-			global_entry = ((~esid) & 0x1f) << 3;
-			ste = (struct stab_entry *)(stab | (((~esid) & 0x1f) << 7));
-			castout_ste = ste + (castout_entry - 8);
-		}
-
-		/* Dont cast out the first kernel segment */
-		if ((castout_ste->esid_data & ESID_MASK) != PAGE_OFFSET)
-			break;
-
-		castout_entry = (castout_entry + 1) & 0xf;
-	}
-
-	get_paca()->stab_rr = (castout_entry + 1) & 0xf;
-
-	/* Modify the old entry to the new value. */
-
-	/* Force previous translations to complete. DRENG */
-	asm volatile("isync" : : : "memory");
-
-	old_esid = castout_ste->esid_data >> SID_SHIFT;
-	castout_ste->esid_data = 0;		/* Invalidate old entry */
-
-	asm volatile("sync" : : : "memory");    /* Order update */
-
-	castout_ste->vsid_data = vsid_data;
-	eieio();				/* Order update */
-	castout_ste->esid_data = esid_data;
-
-	asm volatile("slbie  %0" : : "r" (old_esid << SID_SHIFT));
-	/* Ensure completion of slbie */
-	asm volatile("sync" : : : "memory");
-
-	return (global_entry | (castout_entry & 0x7));
-}
-
-/*
- * Allocate a segment table entry for the given ea and mm
- */
-static int __ste_allocate(unsigned long ea, struct mm_struct *mm)
-{
-	unsigned long vsid;
-	unsigned char stab_entry;
-	unsigned long offset;
-
-	/* Kernel or user address? */
-	if (is_kernel_addr(ea)) {
-		vsid = get_kernel_vsid(ea, MMU_SEGSIZE_256M);
-	} else {
-		if ((ea >= TASK_SIZE_USER64) || (! mm))
-			return 1;
-
-		vsid = get_vsid(mm->context.id, ea, MMU_SEGSIZE_256M);
-	}
-
-	stab_entry = make_ste(get_paca()->stab_addr, GET_ESID(ea), vsid);
-
-	if (!is_kernel_addr(ea)) {
-		offset = __get_cpu_var(stab_cache_ptr);
-		if (offset < NR_STAB_CACHE_ENTRIES)
-			__get_cpu_var(stab_cache[offset++]) = stab_entry;
-		else
-			offset = NR_STAB_CACHE_ENTRIES+1;
-		__get_cpu_var(stab_cache_ptr) = offset;
-
-		/* Order update */
-		asm volatile("sync":::"memory");
-	}
-
-	return 0;
-}
-
-int ste_allocate(unsigned long ea)
-{
-	return __ste_allocate(ea, current->mm);
-}
-
-/*
- * Do the segment table work for a context switch: flush all user
- * entries from the table, then preload some probably useful entries
- * for the new task
- */
-void switch_stab(struct task_struct *tsk, struct mm_struct *mm)
-{
-	struct stab_entry *stab = (struct stab_entry *) get_paca()->stab_addr;
-	struct stab_entry *ste;
-	unsigned long offset;
-	unsigned long pc = KSTK_EIP(tsk);
-	unsigned long stack = KSTK_ESP(tsk);
-	unsigned long unmapped_base;
-
-	/* Force previous translations to complete. DRENG */
-	asm volatile("isync" : : : "memory");
-
-	/*
-	 * We need interrupts hard-disabled here, not just soft-disabled,
-	 * so that a PMU interrupt can't occur, which might try to access
-	 * user memory (to get a stack trace) and possible cause an STAB miss
-	 * which would update the stab_cache/stab_cache_ptr per-cpu variables.
-	 */
-	hard_irq_disable();
-
-	offset = __get_cpu_var(stab_cache_ptr);
-	if (offset <= NR_STAB_CACHE_ENTRIES) {
-		int i;
-
-		for (i = 0; i < offset; i++) {
-			ste = stab + __get_cpu_var(stab_cache[i]);
-			ste->esid_data = 0; /* invalidate entry */
-		}
-	} else {
-		unsigned long entry;
-
-		/* Invalidate all entries. */
-		ste = stab;
-
-		/* Never flush the first entry. */
-		ste += 1;
-		for (entry = 1;
-		     entry < (HW_PAGE_SIZE / sizeof(struct stab_entry));
-		     entry++, ste++) {
-			unsigned long ea;
-			ea = ste->esid_data & ESID_MASK;
-			if (!is_kernel_addr(ea)) {
-				ste->esid_data = 0;
-			}
-		}
-	}
-
-	asm volatile("sync; slbia; sync":::"memory");
-
-	__get_cpu_var(stab_cache_ptr) = 0;
-
-	/* Now preload some entries for the new task */
-	if (test_tsk_thread_flag(tsk, TIF_32BIT))
-		unmapped_base = TASK_UNMAPPED_BASE_USER32;
-	else
-		unmapped_base = TASK_UNMAPPED_BASE_USER64;
-
-	__ste_allocate(pc, mm);
-
-	if (GET_ESID(pc) == GET_ESID(stack))
-		return;
-
-	__ste_allocate(stack, mm);
-
-	if ((GET_ESID(pc) == GET_ESID(unmapped_base))
-	    || (GET_ESID(stack) == GET_ESID(unmapped_base)))
-		return;
-
-	__ste_allocate(unmapped_base, mm);
-
-	/* Order update */
-	asm volatile("sync" : : : "memory");
-}
-
-/*
- * Allocate segment tables for secondary CPUs.  These must all go in
- * the first (bolted) segment, so that do_stab_bolted won't get a
- * recursive segment miss on the segment table itself.
- */
-void __init stabs_alloc(void)
-{
-	int cpu;
-
-	if (mmu_has_feature(MMU_FTR_SLB))
-		return;
-
-	for_each_possible_cpu(cpu) {
-		unsigned long newstab;
-
-		if (cpu == 0)
-			continue; /* stab for CPU 0 is statically allocated */
-
-		newstab = memblock_alloc_base(HW_PAGE_SIZE, HW_PAGE_SIZE,
-					 1<<SID_SHIFT);
-		newstab = (unsigned long)__va(newstab);
-
-		memset((void *)newstab, 0, HW_PAGE_SIZE);
-
-		paca[cpu].stab_addr = newstab;
-		paca[cpu].stab_real = __pa(newstab);
-		printk(KERN_INFO "Segment table for CPU %d at 0x%llx "
-		       "virtual, 0x%llx absolute\n",
-		       cpu, paca[cpu].stab_addr, paca[cpu].stab_real);
-	}
-}
-
-/*
- * Build an entry for the base kernel segment and put it into
- * the segment table or SLB.  All other segment table or SLB
- * entries are faulted in.
- */
-void stab_initialize(unsigned long stab)
-{
-	unsigned long vsid = get_kernel_vsid(PAGE_OFFSET, MMU_SEGSIZE_256M);
-	unsigned long stabreal;
-
-	asm volatile("isync; slbia; isync":::"memory");
-	make_ste(stab, GET_ESID(PAGE_OFFSET), vsid);
-
-	/* Order update */
-	asm volatile("sync":::"memory");
-
-	/* Set ASR */
-	stabreal = get_paca()->stab_real | 0x1ul;
-
-	mtspr(SPRN_ASR, stabreal);
-}
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index d199bfa2f1fa..dc8cf285c3ff 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2058,10 +2058,6 @@ static void dump_one_paca(int cpu)
 	DUMP(p, kernel_toc, "lx");
 	DUMP(p, kernelbase, "lx");
 	DUMP(p, kernel_msr, "lx");
-#ifdef CONFIG_PPC_STD_MMU_64
-	DUMP(p, stab_real, "lx");
-	DUMP(p, stab_addr, "lx");
-#endif
 	DUMP(p, emergency_sp, "p");
 #ifdef CONFIG_PPC_BOOK3S_64
 	DUMP(p, mc_emergency_sp, "p");
@@ -2727,32 +2723,10 @@ static void dump_slb(void)
 	}
 }
 
-static void dump_stab(void)
-{
-	int i;
-	unsigned long *tmp = (unsigned long *)local_paca->stab_addr;
-
-	printf("Segment table contents of cpu 0x%x\n", smp_processor_id());
-
-	for (i = 0; i < PAGE_SIZE/16; i++) {
-		unsigned long a, b;
-
-		a = *tmp++;
-		b = *tmp++;
-
-		if (a || b) {
-			printf("%03d %016lx ", i, a);
-			printf("%016lx\n", b);
-		}
-	}
-}
-
 void dump_segments(void)
 {
 	if (mmu_has_feature(MMU_FTR_SLB))
 		dump_slb();
-	else
-		dump_stab();
 }
 #endif
 
-- 
1.9.1
