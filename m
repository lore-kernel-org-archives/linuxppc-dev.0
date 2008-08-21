Return-Path: <bgill@blarg.am.freescale.net>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0741FDE260
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 07:10:05 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m7LL9vHQ029157
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 14:09:58 -0700 (MST)
Received: from blarg.am.freescale.net (blarg.am.freescale.net [10.82.19.176])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	m7LL9ur8003140
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 16:09:57 -0500 (CDT)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] POWERPC: Allow 32-bit pgtable code to support 36-bit physical
Date: Thu, 21 Aug 2008 16:09:56 -0500
Message-Id: <1219352996-22243-1-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This rearranges a bit of code, and adds support for
36-bit physical addressing for configs that use a
hashed page table.  The 36b physical support is not
enabled by default on any config - it must be
explicitly enabled via the config system.

This patch *only* expands the page table code to accomodate
large physical addresses on 32-bit systems and enables the
PHYS_64BIT config option for 6xx.  It does *not*
allow you to boot a board with more than about 3.5GB of
RAM - for that, SWIOTLB support is also required (and
coming soon).

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
 arch/powerpc/include/asm/io.h            |    2 +-
 arch/powerpc/include/asm/page_32.h       |   10 ++++-
 arch/powerpc/include/asm/pgtable-ppc32.h |   35 +++++++++++++-
 arch/powerpc/include/asm/types.h         |    2 +-
 arch/powerpc/kernel/head_32.S            |    4 +-
 arch/powerpc/kernel/head_fsl_booke.S     |    2 -
 arch/powerpc/mm/hash_low_32.S            |   78 +++++++++++++++++++++++------
 arch/powerpc/mm/pgtable_32.c             |    4 +-
 arch/powerpc/platforms/Kconfig.cputype   |   14 ++++--
 9 files changed, 120 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 77c7fa0..08266d2 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -711,7 +711,7 @@ static inline void * phys_to_virt(unsigned long address)
 /*
  * Change "struct page" to physical address.
  */
-#define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
+#define page_to_phys(page)	((phys_addr_t)page_to_pfn(page) << PAGE_SHIFT)
 
 /* We do NOT want virtual merging, it would put too much pressure on
  * our iommu allocator. Instead, we want drivers to be smart enough
diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
index ebfae53..0b253f6 100644
--- a/arch/powerpc/include/asm/page_32.h
+++ b/arch/powerpc/include/asm/page_32.h
@@ -13,10 +13,18 @@
 #define ARCH_KMALLOC_MINALIGN	L1_CACHE_BYTES
 #endif
 
+#ifdef CONFIG_PTE_64BIT
+#define PTE_FLAGS_OFFSET	4	/* offset of PTE flags, in bytes */
+#define LNX_PTE_SIZE		8	/* size of a linux PTE, in bytes */
+#else
+#define PTE_FLAGS_OFFSET	0
+#define LNX_PTE_SIZE		4
+#endif
+
 #ifndef __ASSEMBLY__
 /*
  * The basic type of a PTE - 64 bits for those CPUs with > 32 bit
- * physical addressing.  For now this just the IBM PPC440.
+ * physical addressing.
  */
 #ifdef CONFIG_PTE_64BIT
 typedef unsigned long long pte_basic_t;
diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index 6fe39e3..bf21a05 100644
--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -363,7 +363,12 @@ extern int icache_44x_need_flush;
 #define _PAGE_EXEC	0x200	/* software: i-cache coherency required */
 #define _PAGE_RW	0x400	/* software: user write access allowed */
 
+#ifdef CONFIG_PTE_64BIT
+/* We never clear the high word of the pte, mask those off */
+#define _PTE_NONE_MASK	(0xffffffff00000000ULL | _PAGE_HASHPTE)
+#else
 #define _PTE_NONE_MASK	_PAGE_HASHPTE
+#endif
 
 #define _PMD_PRESENT	0
 #define _PMD_PRESENT_MASK (PAGE_MASK)
@@ -517,7 +522,13 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
 
 #define pte_none(pte)		((pte_val(pte) & ~_PTE_NONE_MASK) == 0)
 #define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
+
+#if (defined(CONFIG_PTE_64BIT) && (_PAGE_HASHPTE != 0))
+#define pte_clear(mm, addr, ptep) \
+	do { pte_update((ptep), (~_PAGE_HASHPTE), __pte(0)); } while (0)
+#else
 #define pte_clear(mm,addr,ptep)	do { set_pte_at((mm), (addr), (ptep), __pte(0)); } while (0)
+#endif
 
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
@@ -656,10 +667,32 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
 #if _PAGE_HASHPTE != 0
+#ifndef CONFIG_PTE_64BIT
 	pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte) & ~_PAGE_HASHPTE);
 #else
+	/*
+	 * We have to do the write of the 64b pte as 2 stores.  This
+	 * code assumes that the entry we're storing to is currently
+	 * not valid and that all callers have the page table lock.
+	 * Having the entry be not valid protects readers who might read
+	 * between the first and second stores.
+	 */
+	unsigned int tmp;
+
+	__asm__ __volatile__("\
+1:	lwarx	%0,0,%4\n\
+	rlwimi	%L2,%0,0,30,30\n\
+	stw	%2,0(%3)\n\
+	eieio\n\
+	stwcx.  %L2,0,%4\n\
+	bne-	1b"
+	: "=&r" (tmp), "=m" (*ptep)
+	: "r" (pte), "r" (ptep), "r" ((unsigned long)(ptep) + 4), "m" (*ptep)
+	: "cc");
+#endif	/* CONFIG_PTE_64BIT */
+#else
 	*ptep = pte;
-#endif
+#endif /* _PAGE_HASHPTE */
 }
 
 /*
diff --git a/arch/powerpc/include/asm/types.h b/arch/powerpc/include/asm/types.h
index d3374bc..a9a9262 100644
--- a/arch/powerpc/include/asm/types.h
+++ b/arch/powerpc/include/asm/types.h
@@ -55,7 +55,7 @@ typedef u64 phys_addr_t;
 typedef u32 phys_addr_t;
 #endif
 
-#ifdef __powerpc64__
+#if defined(__powerpc64__) || defined(CONFIG_PHYS_64BIT)
 typedef u64 dma_addr_t;
 #else
 typedef u32 dma_addr_t;
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 99ee2f0..6e2889d 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -369,13 +369,13 @@ i##n:								\
 DataAccess:
 	EXCEPTION_PROLOG
 	mfspr	r10,SPRN_DSISR
+	stw	r10,_DSISR(r11)
 	andis.	r0,r10,0xa470		/* weird error? */
 	bne	1f			/* if not, try to put a PTE */
 	mfspr	r4,SPRN_DAR		/* into the hash table */
 	rlwinm	r3,r10,32-15,21,21	/* DSISR_STORE -> _PAGE_RW */
 	bl	hash_page
-1:	stw	r10,_DSISR(r11)
-	mr	r5,r10
+1:	lwz	r5,_DSISR(r11)		/* get DSISR value */
 	mfspr	r4,SPRN_DAR
 	EXC_XFER_EE_LITE(0x300, handle_page_fault)
 
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 3cb52fa..4ccceab 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -422,7 +422,6 @@ skpinv:	addi	r6,r6,1				/* Increment */
  *   r12 is pointer to the pte
  */
 #ifdef CONFIG_PTE_64BIT
-#define PTE_FLAGS_OFFSET	4
 #define FIND_PTE	\
 	rlwinm	r12, r10, 13, 19, 29;	/* Compute pgdir/pmd offset */	\
 	lwzx	r11, r12, r11;		/* Get pgd/pmd entry */		\
@@ -431,7 +430,6 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	rlwimi	r12, r10, 23, 20, 28;	/* Compute pte address */	\
 	lwz	r11, 4(r12);		/* Get pte entry */
 #else
-#define PTE_FLAGS_OFFSET	0
 #define FIND_PTE	\
 	rlwimi	r11, r10, 12, 20, 29;	/* Create L1 (pgdir/pmd) address */	\
 	lwz	r11, 0(r11);		/* Get L1 entry */			\
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index b9ba7d9..d63e20a 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -75,7 +75,7 @@ _GLOBAL(hash_page_sync)
  * Returns to the caller if the access is illegal or there is no
  * mapping for the address.  Otherwise it places an appropriate PTE
  * in the hash table and returns from the exception.
- * Uses r0, r3 - r8, ctr, lr.
+ * Uses r0, r3 - r8, r10, ctr, lr.
  */
 	.text
 _GLOBAL(hash_page)
@@ -106,9 +106,15 @@ _GLOBAL(hash_page)
 	addi	r5,r5,swapper_pg_dir@l	/* kernel page table */
 	rlwimi	r3,r9,32-12,29,29	/* MSR_PR -> _PAGE_USER */
 112:	add	r5,r5,r7		/* convert to phys addr */
+#ifndef CONFIG_PTE_64BIT
 	rlwimi	r5,r4,12,20,29		/* insert top 10 bits of address */
 	lwz	r8,0(r5)		/* get pmd entry */
 	rlwinm.	r8,r8,0,0,19		/* extract address of pte page */
+#else
+	rlwinm	r8,r4,13,19,29		/* Compute pgdir/pmd offset */
+	lwzx	r8,r8,r5		/* Get L1 entry */
+	rlwinm. r8,r8,0,0,20		/* extract pt base address */
+#endif
 #ifdef CONFIG_SMP
 	beq-	hash_page_out		/* return if no mapping */
 #else
@@ -118,7 +124,11 @@ _GLOBAL(hash_page)
 	   to the address following the rfi. */
 	beqlr-
 #endif
+#ifndef CONFIG_PTE_64BIT
 	rlwimi	r8,r4,22,20,29		/* insert next 10 bits of address */
+#else
+	rlwimi	r8,r4,23,20,28		/* compute pte address */
+#endif
 	rlwinm	r0,r3,32-3,24,24	/* _PAGE_RW access -> _PAGE_DIRTY */
 	ori	r0,r0,_PAGE_ACCESSED|_PAGE_HASHPTE
 
@@ -127,9 +137,15 @@ _GLOBAL(hash_page)
 	 * because almost always, there won't be a permission violation
 	 * and there won't already be an HPTE, and thus we will have
 	 * to update the PTE to set _PAGE_HASHPTE.  -- paulus.
+	 *
+	 * If PTE_64BIT is set, the low word is the flags word; use that
+	 * word for locking since it contains all the interesting bits.
 	 */
+#if (PTE_FLAGS_OFFSET != 0)
+	addi	r8,r8,PTE_FLAGS_OFFSET
+#endif
 retry:
-	lwarx	r6,0,r8			/* get linux-style pte */
+	lwarx	r6,0,r8			/* get linux-style pte, flag word */
 	andc.	r5,r3,r6		/* check access & ~permission */
 #ifdef CONFIG_SMP
 	bne-	hash_page_out		/* return if access not permitted */
@@ -137,6 +153,11 @@ retry:
 	bnelr-
 #endif
 	or	r5,r0,r6		/* set accessed/dirty bits */
+#ifdef CONFIG_PTE_64BIT
+	subf	r10,r6,r8		/* create false data dependency */
+	subi	r10,r10,PTE_FLAGS_OFFSET
+	lwzx	r10,r6,r10		/* Get upper PTE word */
+#endif
 	stwcx.	r5,0,r8			/* attempt to update PTE */
 	bne-	retry			/* retry if someone got there first */
 
@@ -203,9 +224,9 @@ _GLOBAL(add_hash_page)
 	 * we can't take a hash table miss (assuming the code is
 	 * covered by a BAT).  -- paulus
 	 */
-	mfmsr	r10
+	mfmsr	r9
 	SYNC
-	rlwinm	r0,r10,0,17,15		/* clear bit 16 (MSR_EE) */
+	rlwinm	r0,r9,0,17,15		/* clear bit 16 (MSR_EE) */
 	rlwinm	r0,r0,0,28,26		/* clear MSR_DR */
 	mtmsr	r0
 	SYNC_601
@@ -214,14 +235,14 @@ _GLOBAL(add_hash_page)
 	tophys(r7,0)
 
 #ifdef CONFIG_SMP
-	addis	r9,r7,mmu_hash_lock@ha
-	addi	r9,r9,mmu_hash_lock@l
-10:	lwarx	r0,0,r9			/* take the mmu_hash_lock */
+	addis	r6,r7,mmu_hash_lock@ha
+	addi	r6,r6,mmu_hash_lock@l
+10:	lwarx	r0,0,r6			/* take the mmu_hash_lock */
 	cmpi	0,r0,0
 	bne-	11f
-	stwcx.	r8,0,r9
+	stwcx.	r8,0,r6
 	beq+	12f
-11:	lwz	r0,0(r9)
+11:	lwz	r0,0(r6)
 	cmpi	0,r0,0
 	beq	10b
 	b	11b
@@ -234,10 +255,20 @@ _GLOBAL(add_hash_page)
 	 * HPTE, so we just unlock and return.
 	 */
 	mr	r8,r5
+#ifndef CONFIG_PTE_64BIT
 	rlwimi	r8,r4,22,20,29
+#else
+	rlwimi	r8,r4,23,20,28
+	addi	r8,r8,PTE_FLAGS_OFFSET
+#endif
 1:	lwarx	r6,0,r8
 	andi.	r0,r6,_PAGE_HASHPTE
 	bne	9f			/* if HASHPTE already set, done */
+#ifdef CONFIG_PTE_64BIT
+	subf	r10,r6,r8		/* create false data dependency */
+	subi	r10,r10,PTE_FLAGS_OFFSET
+	lwzx	r10,r6,r10		/* Get upper PTE word */
+#endif
 	ori	r5,r6,_PAGE_HASHPTE
 	stwcx.	r5,0,r8
 	bne-	1b
@@ -246,13 +277,15 @@ _GLOBAL(add_hash_page)
 
 9:
 #ifdef CONFIG_SMP
+	addis	r6,r7,mmu_hash_lock@ha
+	addi	r6,r6,mmu_hash_lock@l
 	eieio
 	li	r0,0
-	stw	r0,0(r9)		/* clear mmu_hash_lock */
+	stw	r0,0(r6)		/* clear mmu_hash_lock */
 #endif
 
 	/* reenable interrupts and DR */
-	mtmsr	r10
+	mtmsr	r9
 	SYNC_601
 	isync
 
@@ -267,7 +300,8 @@ _GLOBAL(add_hash_page)
  * r5 contains the linux PTE, r6 contains the old value of the
  * linux PTE (before setting _PAGE_HASHPTE) and r7 contains the
  * offset to be added to addresses (0 if the MMU is on,
- * -KERNELBASE if it is off).
+ * -KERNELBASE if it is off).  r10 contains the upper half of
+ * the PTE if CONFIG_PTE_64BIT.
  * On SMP, the caller should have the mmu_hash_lock held.
  * We assume that the caller has (or will) set the _PAGE_HASHPTE
  * bit in the linux PTE in memory.  The value passed in r6 should
@@ -313,6 +347,11 @@ _GLOBAL(create_hpte)
 BEGIN_FTR_SECTION
 	ori	r8,r8,_PAGE_COHERENT	/* set M (coherence required) */
 END_FTR_SECTION_IFSET(CPU_FTR_NEED_COHERENT)
+#ifdef CONFIG_PTE_64BIT
+	/* Put the XPN bits into the PTE */
+	rlwimi	r8,r10,8,20,22
+	rlwimi	r8,r10,2,29,29
+#endif
 
 	/* Construct the high word of the PPC-style PTE (r5) */
 	rlwinm	r5,r3,7,1,24		/* put VSID in 0x7fffff80 bits */
@@ -499,14 +538,18 @@ _GLOBAL(flush_hash_pages)
 	isync
 
 	/* First find a PTE in the range that has _PAGE_HASHPTE set */
+#ifndef CONFIG_PTE_64BIT
 	rlwimi	r5,r4,22,20,29
-1:	lwz	r0,0(r5)
+#else
+	rlwimi	r5,r4,23,20,28
+#endif
+1:	lwz	r0,PTE_FLAGS_OFFSET(r5)
 	cmpwi	cr1,r6,1
 	andi.	r0,r0,_PAGE_HASHPTE
 	bne	2f
 	ble	cr1,19f
 	addi	r4,r4,0x1000
-	addi	r5,r5,4
+	addi	r5,r5,LNX_PTE_SIZE
 	addi	r6,r6,-1
 	b	1b
 
@@ -545,7 +588,10 @@ _GLOBAL(flush_hash_pages)
 	 * already clear, we're done (for this pte).  If not,
 	 * clear it (atomically) and proceed.  -- paulus.
 	 */
-33:	lwarx	r8,0,r5			/* fetch the pte */
+#if (PTE_FLAGS_OFFSET != 0)
+	addi	r5,r5,PTE_FLAGS_OFFSET
+#endif
+33:	lwarx	r8,0,r5			/* fetch the pte flags word */
 	andi.	r0,r8,_PAGE_HASHPTE
 	beq	8f			/* done if HASHPTE is already clear */
 	rlwinm	r8,r8,0,31,29		/* clear HASHPTE bit */
@@ -590,7 +636,7 @@ _GLOBAL(flush_hash_patch_B)
 
 8:	ble	cr1,9f			/* if all ptes checked */
 81:	addi	r6,r6,-1
-	addi	r5,r5,4			/* advance to next pte */
+	addi	r5,r5,LNX_PTE_SIZE	/* go to next linux pte flag word */
 	addi	r4,r4,0x1000
 	lwz	r0,0(r5)		/* check next pte */
 	cmpwi	cr1,r6,1
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 2001abd..c31d6d2 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -73,7 +73,7 @@ extern unsigned long p_mapped_by_tlbcam(unsigned long pa);
 #endif /* HAVE_TLBCAM */
 
 #ifdef CONFIG_PTE_64BIT
-/* 44x uses an 8kB pgdir because it has 8-byte Linux PTEs. */
+/* Some processors use an 8kB pgdir because they have 8-byte Linux PTEs. */
 #define PGDIR_ORDER	1
 #else
 #define PGDIR_ORDER	0
@@ -288,7 +288,7 @@ int map_page(unsigned long va, phys_addr_t pa, int flags)
 }
 
 /*
- * Map in all of physical memory starting at KERNELBASE.
+ * Map in a big chunk of physical memory starting at KERNELBASE.
  */
 void __init mapin_ram(void)
 {
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 7f65127..ca5b58b 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -128,18 +128,22 @@ config FSL_EMB_PERFMON
 
 config PTE_64BIT
 	bool
-	depends on 44x || E500
+	depends on 44x || E500 || 6xx
 	default y if 44x
-	default y if E500 && PHYS_64BIT
+	default y if PHYS_64BIT
 
 config PHYS_64BIT
-	bool 'Large physical address support' if E500
-	depends on 44x || E500
+	bool 'Large physical address support' if E500 || 6xx
+	depends on 44x || E500 || 6xx
 	select RESOURCES_64BIT
 	default y if 44x
 	---help---
 	  This option enables kernel support for larger than 32-bit physical
-	  addresses.  This features is not be available on all e500 cores.
+	  addresses.  This features is not be available on all cores.
+
+	  If you have more than 3.5GB of RAM or so, you also need to enable
+	  SWIOTLB under Kernel Options for this to work.  The actual number
+	  is platform-dependent.
 
 	  If in doubt, say N here.
 
-- 
1.5.5.1
