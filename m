Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m96x4MsFzF1Nf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 20:05:45 +1000 (AEST)
Message-Id: <7b9613081c86de0bb369186454fd5ee6fbc2148c.1526464250.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1526464250.git.christophe.leroy@c-s.fr>
References: <cover.1526464250.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 09/14] powerpc/mm: Use hardware assistance in TLB handlers
 on the 8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 16 May 2018 12:05:41 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Today, on the 8xx the TLB handlers do SW tablewalk by doing all
the calculation in ASM, in order to match with the Linux page
table structure.

The 8xx offers hardware assistance which allows significant size
reduction of the TLB handlers, hence also reduces the time spent
in the handlers.

However, using this HW assistance implies some constraints on the
page table structure:
- Regardless of the main page size used (4k or 16k), the
level 1 table (PGD) contains 1024 entries and each PGD entry covers
a 4Mbytes area which is managed by a level 2 table (PTE) containing
also 1024 entries each describing a 4k page.
- 16k pages require 4 identifical entries in the L2 table
- 512k pages PTE have to be spread every 128 bytes in the L2 table
- 8M pages PTE are at the address pointed by the L1 entry and each
8M page require 2 identical entries in the PGD.

In order to use hardware assistance, this patch does the following
modifications:
- Make PGD size independant of the main page size
- In 16k pages mode, redefine pte_t as a struct with 4 elements,
and populate those 4 elements in __set_pte_at() and pte_update()
- Modify the TLB handlers to use HW assistance
- Adapt the size of the hugepage tables.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/hugetlb.h           |   4 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h |  16 +-
 arch/powerpc/include/asm/nohash/pgtable.h    |   4 +
 arch/powerpc/include/asm/pgtable-types.h     |   4 +
 arch/powerpc/kernel/head_8xx.S               | 225 +++++++++------------------
 arch/powerpc/mm/8xx_mmu.c                    |  10 +-
 arch/powerpc/mm/hugetlbpage.c                |  12 ++
 7 files changed, 111 insertions(+), 164 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 78540c074d70..6d29be6bac74 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -77,7 +77,9 @@ static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
 	unsigned long idx = 0;
 
 	pte_t *dir = hugepd_page(hpd);
-#ifndef CONFIG_PPC_FSL_BOOK3E
+#ifdef CONFIG_PPC_8xx
+	idx = (addr & ((1UL << pdshift) - 1)) >> PAGE_SHIFT;
+#elif !defined(CONFIG_PPC_FSL_BOOK3E)
 	idx = (addr & ((1UL << pdshift) - 1)) >> hugepd_shift(hpd);
 #endif
 
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 7873722198e1..5872d79360a9 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -18,7 +18,11 @@ extern int icache_44x_need_flush;
 
 #endif /* __ASSEMBLY__ */
 
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
+#define PTE_INDEX_SIZE  (PTE_SHIFT - 2)
+#else
 #define PTE_INDEX_SIZE	PTE_SHIFT
+#endif
 #define PMD_INDEX_SIZE	0
 #define PUD_INDEX_SIZE	0
 #define PGD_INDEX_SIZE	(32 - PGDIR_SHIFT)
@@ -47,7 +51,11 @@ extern int icache_44x_need_flush;
  * -Matt
  */
 /* PGDIR_SHIFT determines what a top-level page table entry can map */
+#ifdef CONFIG_PPC_8xx
+#define PGDIR_SHIFT	22
+#else
 #define PGDIR_SHIFT	(PAGE_SHIFT + PTE_INDEX_SIZE)
+#endif
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
@@ -201,7 +209,13 @@ static inline unsigned long pte_update(pte_t *p,
 	: "cc" );
 #else /* PTE_ATOMIC_UPDATES */
 	unsigned long old = pte_val(*p);
-	*p = __pte((old & ~clr) | set);
+	unsigned long new = (old & ~clr) | set;
+
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
+	p->pte = p->pte1 = p->pte2 = p->pte3 = new;
+#else
+	*p = __pte(new);
+#endif
 #endif /* !PTE_ATOMIC_UPDATES */
 
 #ifdef CONFIG_44x
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 2160be2e4339..bb5b65971b37 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -164,7 +164,11 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	/* Anything else just stores the PTE normally. That covers all 64-bit
 	 * cases, and 32-bit non-hash with 32-bit PTEs.
 	 */
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
+	ptep->pte = ptep->pte1 = ptep->pte2 = ptep->pte3 = pte_val(pte);
+#else
 	*ptep = pte;
+#endif
 
 	/*
 	 * With hardware tablewalk, a sync is needed to ensure that
diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
index eccb30b38b47..3b0edf041b2e 100644
--- a/arch/powerpc/include/asm/pgtable-types.h
+++ b/arch/powerpc/include/asm/pgtable-types.h
@@ -3,7 +3,11 @@
 #define _ASM_POWERPC_PGTABLE_TYPES_H
 
 /* PTE level */
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
+typedef struct { pte_basic_t pte, pte1, pte2, pte3; } pte_t;
+#else
 typedef struct { pte_basic_t pte; } pte_t;
+#endif
 #define __pte(x)	((pte_t) { (x) })
 static inline pte_basic_t pte_val(pte_t x)
 {
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 85b017c67e11..66a27044d105 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -275,7 +275,7 @@ SystemCall:
 	. = 0x1100
 /*
  * For the MPC8xx, this is a software tablewalk to load the instruction
- * TLB.  The task switch loads the M_TW register with the pointer to the first
+ * TLB.  The task switch loads the M_TWB register with the pointer to the first
  * level table.
  * If we discover there is no second level table (value is zero) or if there
  * is an invalid pte, we load that into the TLB, which causes another fault
@@ -285,106 +285,100 @@ SystemCall:
  */
 
 #ifdef CONFIG_8xx_CPU15
-#define INVALIDATE_ADJACENT_PAGES_CPU15(tmp, addr)	\
-	addi	tmp, addr, PAGE_SIZE;	\
-	tlbie	tmp;			\
-	addi	tmp, addr, -PAGE_SIZE;	\
-	tlbie	tmp
+#define INVALIDATE_ADJACENT_PAGES_CPU15(addr)	\
+	addi	addr, addr, PAGE_SIZE;	\
+	tlbie	addr;			\
+	addi	addr, addr, -(PAGE_SIZE << 1);	\
+	tlbie	addr;			\
+	addi	addr, addr, PAGE_SIZE
 #else
-#define INVALIDATE_ADJACENT_PAGES_CPU15(tmp, addr)
+#define INVALIDATE_ADJACENT_PAGES_CPU15(addr)
 #endif
 
 InstructionTLBMiss:
 	mtspr	SPRN_SPRG_SCRATCH0, r10
+#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_SWAP)
 	mtspr	SPRN_SPRG_SCRATCH1, r11
-#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
-	mtspr	SPRN_SPRG_SCRATCH2, r12
+#ifdef ITLB_MISS_KERNEL
+	mfcr	r11
+#endif
 #endif
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
 	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
-	INVALIDATE_ADJACENT_PAGES_CPU15(r11, r10)
+	INVALIDATE_ADJACENT_PAGES_CPU15(r10)
 	/* Only modules will cause ITLB Misses as we always
 	 * pin the first 8MB of kernel memory */
-#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
-	mfcr	r12
-#endif
+	mtspr	SPRN_MD_EPN, r10
 #ifdef ITLB_MISS_KERNEL
 #if defined(SIMPLE_KERNEL_ADDRESS) && defined(CONFIG_PIN_TLB_TEXT)
-	andis.	r11, r10, 0x8000	/* Address >= 0x80000000 */
+	cmpi	cr0, r10, 0	/* Address >= 0x80000000 */
 #else
-	rlwinm	r11, r10, 16, 0xfff8
-	cmpli	cr0, r11, PAGE_OFFSET@h
+	rlwinm	r10, r10, 16, 0xfff8
+	cmpli	cr0, r10, PAGE_OFFSET@h
 #ifndef CONFIG_PIN_TLB_TEXT
 	/* It is assumed that kernel code fits into the first 8M page */
 _ENTRY(ITLBMiss_cmp)
-	cmpli	cr7, r11, (PAGE_OFFSET + 0x0800000)@h
+	cmpli	cr7, r10, (PAGE_OFFSET + 0x0800000)@h
 #endif
 #endif
 #endif
-	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
+	mfspr	r10, SPRN_M_TWB	/* Get level 1 table */
 #ifdef ITLB_MISS_KERNEL
 #if defined(SIMPLE_KERNEL_ADDRESS) && defined(CONFIG_PIN_TLB_TEXT)
-	beq+	3f
+	bge+	3f
 #else
 	blt+	3f
 #endif
 #ifndef CONFIG_PIN_TLB_TEXT
 	blt	cr7, ITLBMissLinear
 #endif
-	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
+	rlwinm	r10, r10, 0, 20, 31
+	oris	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@h
+	ori	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@l
 3:
 #endif
+#ifdef ITLB_MISS_KERNEL
+	mfcr	r11
+#endif
 	/* Insert level 1 index */
-	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
-	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
+	lwz	r10, 0(r10)	/* Get the level 1 entry */
+	mtspr	SPRN_MI_TWC, r10	/* Set segment attributes */
+	mtspr	SPRN_MD_TWC, r10
 
-	/* Extract level 2 index */
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
-#ifdef CONFIG_HUGETLB_PAGE
-	mtcr	r11
-#endif
-	/* Load the MI_TWC with the attributes for this "segment." */
-	mtspr	SPRN_MI_TWC, r11	/* Set segment attributes */
-#ifdef CONFIG_HUGETLB_PAGE
-	bt-	28, 10f		/* bit 28 = Large page (8M) */
-	bt-	29, 20f		/* bit 29 = Large page (8M or 512k) */
-#endif
-	rlwimi	r10, r11, 0, 0, 32 - PAGE_SHIFT - 1	/* Add level 2 base */
+	mfspr	r10, SPRN_MD_TWC
 	lwz	r10, 0(r10)	/* Get the pte */
-4:
-#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
-	mtcr	r12
-#endif
 
 #ifdef CONFIG_SWAP
 	rlwinm	r11, r10, 32-5, _PAGE_PRESENT
 	and	r11, r11, r10
 	rlwimi	r10, r11, 0, _PAGE_PRESENT
 #endif
-	li	r11, RPN_PATTERN | 0x200
 	/* The Linux PTE won't go exactly into the MMU TLB.
 	 * Software indicator bits 20 and 23 must be clear.
 	 * Software indicator bits 22, 24, 25, 26, and 27 must be
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
 	 */
-	rlwimi	r11, r10, 4, 0x0400	/* Copy _PAGE_EXEC into bit 21 */
-	rlwimi	r10, r11, 0, 0x0ff0	/* Set 22, 24-27, clear 20,23 */
+	rlwimi	r10, r10, 0, 0x0f00	/* Clear bits 20-23 */
+	rlwimi	r10, r10, 4, 0x0400	/* Copy _PAGE_EXEC into bit 21 */
+	ori	r10, r10, RPN_PATTERN | 0x200 /* Set 22 and 24-27 */
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
 	/* Restore registers */
 _ENTRY(itlb_miss_exit_1)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
+#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_SWAP)
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
-	mfspr	r12, SPRN_SPRG_SCRATCH2
 #endif
 	rfi
 #ifdef CONFIG_PERF_EVENTS
 _ENTRY(itlb_miss_perf)
+#if !defined(ITLB_MISS_KERNEL) && !defined(CONFIG_SWAP)
+	mtspr	SPRN_SPRG_SCRATCH1, r11
+#endif
 	lis	r10, (itlb_miss_counter - PAGE_OFFSET)@ha
 	lwz	r11, (itlb_miss_counter - PAGE_OFFSET)@l(r10)
 	addi	r11, r11, 1
@@ -392,83 +386,42 @@ _ENTRY(itlb_miss_perf)
 #endif
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-#if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
-	mfspr	r12, SPRN_SPRG_SCRATCH2
-#endif
 	rfi
 
-#ifdef CONFIG_HUGETLB_PAGE
-10:	/* 8M pages */
-#ifdef CONFIG_PPC_16K_PAGES
-	/* Extract level 2 index */
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT_8M - PAGE_SHIFT), 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1), 29
-	/* Add level 2 base */
-	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1) - 1
-#else
-	/* Level 2 base */
-	rlwinm	r10, r11, 0, ~HUGEPD_SHIFT_MASK
-#endif
-	lwz	r10, 0(r10)	/* Get the pte */
-	b	4b
-
-20:	/* 512k pages */
-	/* Extract level 2 index */
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT_512K - PAGE_SHIFT), 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1), 29
-	/* Add level 2 base */
-	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1) - 1
-	lwz	r10, 0(r10)	/* Get the pte */
-	b	4b
-#endif
-
 	. = 0x1200
 DataStoreTLBMiss:
 	mtspr	SPRN_SPRG_SCRATCH0, r10
 	mtspr	SPRN_SPRG_SCRATCH1, r11
-	mtspr	SPRN_SPRG_SCRATCH2, r12
-	mfcr	r12
+	mfcr	r11
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
 	mfspr	r10, SPRN_MD_EPN
-	rlwinm	r11, r10, 16, 0xfff8
-	cmpli	cr0, r11, PAGE_OFFSET@h
-	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
-	blt+	3f
-	rlwinm	r11, r10, 16, 0xfff8
+	rlwinm	r10, r10, 16, 0xfff8
+	cmpli	cr0, r10, PAGE_OFFSET@h
 #ifndef CONFIG_PIN_TLB_IMMR
-	cmpli	cr0, r11, VIRT_IMMR_BASE@h
+	cmpli	cr6, r10, VIRT_IMMR_BASE@h
 #endif
 _ENTRY(DTLBMiss_cmp)
-	cmpli	cr7, r11, (PAGE_OFFSET + 0x1800000)@h
+	cmpli	cr7, r10, (PAGE_OFFSET + 0x1800000)@h
+	mfspr	r10, SPRN_M_TWB	/* Get level 1 table */
+	blt+	3f
 #ifndef CONFIG_PIN_TLB_IMMR
 _ENTRY(DTLBMiss_jmp)
-	beq-	DTLBMissIMMR
+	beq-	cr6, DTLBMissIMMR
 #endif
 	blt	cr7, DTLBMissLinear
-	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
+	rlwinm	r10, r10, 0, 20, 31
+	oris	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@h
+	ori	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@l
 3:
-
-	/* Insert level 1 index */
-	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
-	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
-
-	/* We have a pte table, so load fetch the pte from the table.
-	 */
-	/* Extract level 2 index */
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
-#ifdef CONFIG_HUGETLB_PAGE
+	lwz	r10, 0(r10)	/* Get the level 1 entry */
 	mtcr	r11
-#endif
-	mtspr	SPRN_MD_TWC, r11
-#ifdef CONFIG_HUGETLB_PAGE
-	bt-	28, 10f		/* bit 28 = Large page (8M) */
-	bt-	29, 20f		/* bit 29 = Large page (8M or 512k) */
-#endif
-	rlwimi	r10, r11, 0, 0, 32 - PAGE_SHIFT - 1	/* Add level 2 base */
+
+	mtspr	SPRN_MD_TWC, r10
+	mfspr	r10, SPRN_MD_TWC
 	lwz	r10, 0(r10)	/* Get the pte */
-4:
-	mtcr	r12
 
 	/* Both _PAGE_ACCESSED and _PAGE_PRESENT has to be set.
 	 * We also need to know if the insn is a load/store, so:
@@ -498,7 +451,6 @@ _ENTRY(DTLBMiss_jmp)
 _ENTRY(dtlb_miss_exit_1)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
 #ifdef CONFIG_PERF_EVENTS
 _ENTRY(dtlb_miss_perf)
@@ -509,32 +461,8 @@ _ENTRY(dtlb_miss_perf)
 #endif
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
 
-#ifdef CONFIG_HUGETLB_PAGE
-10:	/* 8M pages */
-	/* Extract level 2 index */
-#ifdef CONFIG_PPC_16K_PAGES
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT_8M - PAGE_SHIFT), 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1), 29
-	/* Add level 2 base */
-	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1) - 1
-#else
-	/* Level 2 base */
-	rlwinm	r10, r11, 0, ~HUGEPD_SHIFT_MASK
-#endif
-	lwz	r10, 0(r10)	/* Get the pte */
-	b	4b
-
-20:	/* 512k pages */
-	/* Extract level 2 index */
-	rlwinm	r10, r10, 32 - (PAGE_SHIFT_512K - PAGE_SHIFT), 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1), 29
-	/* Add level 2 base */
-	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1) - 1
-	lwz	r10, 0(r10)	/* Get the pte */
-	b	4b
-#endif
-
 /* This is an instruction TLB error on the MPC8xx.  This could be due
  * to many reasons, such as executing guarded memory or illegal instruction
  * addresses.  There is nothing to do but handle a big time error fault.
@@ -642,7 +570,7 @@ InstructionBreakpoint:
  * not enough space in the DataStoreTLBMiss area.
  */
 DTLBMissIMMR:
-	mtcr	r12
+	mtcr	r11
 	/* Set 512k byte guarded page and mark it valid */
 	li	r10, MD_PS512K | MD_GUARDED | MD_SVALID
 	mtspr	SPRN_MD_TWC, r10
@@ -657,15 +585,14 @@ DTLBMissIMMR:
 _ENTRY(dtlb_miss_exit_2)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
 
 DTLBMissLinear:
-	mtcr	r12
+	mtcr	r11
 	/* Set 8M byte page and mark it valid */
 	li	r11, MD_PS8MEG | MD_SVALID
 	mtspr	SPRN_MD_TWC, r11
-	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
+	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
 	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
 			  _PAGE_PRESENT
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
@@ -675,16 +602,15 @@ DTLBMissLinear:
 _ENTRY(dtlb_miss_exit_3)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
 
 #ifndef CONFIG_PIN_TLB_TEXT
 ITLBMissLinear:
-	mtcr	r12
+	mtcr	r11
 	/* Set 8M byte page and mark it valid */
 	li	r11, MI_PS8MEG | MI_SVALID
 	mtspr	SPRN_MI_TWC, r11
-	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
+	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
 	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
 			  _PAGE_PRESENT
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
@@ -692,7 +618,6 @@ ITLBMissLinear:
 _ENTRY(itlb_miss_exit_2)
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	mfspr	r11, SPRN_SPRG_SCRATCH1
-	mfspr	r12, SPRN_SPRG_SCRATCH2
 	rfi
 #endif
 
@@ -706,9 +631,10 @@ FixupDAR:/* Entry point for dcbx workaround. */
 	mtspr	SPRN_SPRG_SCRATCH2, r10
 	/* fetch instruction from memory. */
 	mfspr	r10, SPRN_SRR0
+	mtspr	SPRN_MD_EPN, r10
 	rlwinm	r11, r10, 16, 0xfff8
 	cmpli	cr0, r11, PAGE_OFFSET@h
-	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
+	mfspr	r11, SPRN_M_TWB	/* Get level 1 table */
 	blt+	3f
 	rlwinm	r11, r10, 16, 0xfff8
 _ENTRY(FixupDAR_cmp)
@@ -716,17 +642,18 @@ _ENTRY(FixupDAR_cmp)
 	/* create physical page address from effective address */
 	tophys(r11, r10)
 	blt-	cr7, 201f
-	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
-	/* Insert level 1 index */
-3:	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
-	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
+	mfspr	r11, SPRN_M_TWB	/* Get level 1 table */
+	rlwinm	r11, r11, 0, 20, 31
+	oris	r11, r11, (swapper_pg_dir - PAGE_OFFSET)@h
+	ori	r11, r11, (swapper_pg_dir - PAGE_OFFSET)@l
+3:
+	lwz	r11, 0(r11)	/* Get the level 1 entry */
+	mtspr	SPRN_MD_TWC, r11
 	mtcr	r11
+	mfspr	r11, SPRN_MD_TWC
+	lwz	r11, 0(r11)	/* Get the pte */
 	bt	28,200f		/* bit 28 = Large page (8M) */
 	bt	29,202f		/* bit 29 = Large page (8M or 512K) */
-	rlwinm	r11, r11,0,0,19	/* Extract page descriptor page address */
-	/* Insert level 2 index */
-	rlwimi	r11, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
-	lwz	r11, 0(r11)	/* Get the pte */
 	/* concat physical page address(r11) and page offset(r10) */
 	rlwimi	r11, r10, 0, 32 - PAGE_SHIFT, 31
 201:	lwz	r11,0(r11)
@@ -748,23 +675,12 @@ _ENTRY(FixupDAR_cmp)
 141:	mfspr	r10,SPRN_SPRG_SCRATCH2
 	b	DARFixed	/* Nope, go back to normal TLB processing */
 
-	/* concat physical page address(r11) and page offset(r10) */
 200:
-#ifdef CONFIG_PPC_16K_PAGES
-	rlwinm	r11, r11, 0, 0, 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1) - 1
-	rlwimi	r11, r10, 32 - (PAGE_SHIFT_8M - 2), 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1), 29
-#else
-	rlwinm	r11, r10, 0, ~HUGEPD_SHIFT_MASK
-#endif
-	lwz	r11, 0(r11)	/* Get the pte */
 	/* concat physical page address(r11) and page offset(r10) */
 	rlwimi	r11, r10, 0, 32 - PAGE_SHIFT_8M, 31
 	b	201b
 
 202:
-	rlwinm	r11, r11, 0, 0, 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1) - 1
-	rlwimi	r11, r10, 32 - (PAGE_SHIFT_512K - 2), 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1), 29
-	lwz	r11, 0(r11)	/* Get the pte */
 	/* concat physical page address(r11) and page offset(r10) */
 	rlwimi	r11, r10, 0, 32 - PAGE_SHIFT_512K, 31
 	b	201b
@@ -898,9 +814,10 @@ start_here:
 	 * init's THREAD like the context switch code does, but this is
 	 * easier......until someone changes init's static structures.
 	 */
-	lis	r6, swapper_pg_dir@ha
+	lis	r6, swapper_pg_dir@h
+	ori	r6, r6, swapper_pg_dir@l
 	tophys(r6,r6)
-	mtspr	SPRN_M_TW, r6
+	mtspr	SPRN_M_TWB, r6
 	lis	r4,2f@h
 	ori	r4,r4,2f@l
 	tophys(r4,r4)
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 5d53684c2ebd..54a02b8e21ec 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -173,8 +173,6 @@ void __init setup_initial_memory_limit(phys_addr_t first_memblock_base,
  */
 void set_context(unsigned long id, pgd_t *pgd)
 {
-	s16 offset = (s16)(__pa(swapper_pg_dir));
-
 #ifdef CONFIG_BDI_SWITCH
 	pgd_t	**ptr = *(pgd_t ***)(KERNELBASE + 0xf0);
 
@@ -184,12 +182,8 @@ void set_context(unsigned long id, pgd_t *pgd)
 	*(ptr + 1) = pgd;
 #endif
 
-	/* Register M_TW will contain base address of level 1 table minus the
-	 * lower part of the kernel PGDIR base address, so that all accesses to
-	 * level 1 table are done relative to lower part of kernel PGDIR base
-	 * address.
-	 */
-	mtspr(SPRN_M_TW, __pa(pgd) - offset);
+	/* Register M_TWB will contain base address of level 1 table */
+	mtspr(SPRN_M_TWB, __pa(pgd));
 
 	/* Update context */
 	mtspr(SPRN_M_CASID, id - 1);
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 2a4b1bf8bde6..d889196bbaf6 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -63,7 +63,11 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 		cachep = hugepte_cache;
 		num_hugepd = 1 << (pshift - pdshift);
 	} else {
+#ifdef CONFIG_PPC_8xx
+		cachep = PGT_CACHE(PTE_SHIFT);
+#else
 		cachep = PGT_CACHE(pdshift - pshift);
+#endif
 		num_hugepd = 1;
 	}
 
@@ -328,7 +332,11 @@ static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshif
 	if (shift >= pdshift)
 		hugepd_free(tlb, hugepte);
 	else
+#ifdef CONFIG_PPC_8xx
+		pgtable_free_tlb(tlb, hugepte, PTE_SHIFT);
+#else
 		pgtable_free_tlb(tlb, hugepte, pdshift - shift);
+#endif
 }
 
 static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
@@ -696,7 +704,11 @@ static int __init hugetlbpage_init(void)
 		 * use pgt cache for hugepd.
 		 */
 		if (pdshift > shift)
+#ifdef CONFIG_PPC_8xx
+			pgtable_cache_add(PTE_SHIFT, NULL);
+#else
 			pgtable_cache_add(pdshift - shift, NULL);
+#endif
 #if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 		else if (!hugepte_cache) {
 			/*
-- 
2.13.3
