Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9rcc1pVgzDr2S
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Aug 2016 02:56:00 +1000 (AEST)
Message-Id: <15e0fa7a312245e681cb9ca18ffb875c7820e5fc.1471020647.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1471020646.git.christophe.leroy@c-s.fr>
References: <cover.1471020646.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 6/6] powerpc/8xx: implementation of huge pages
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 12 Aug 2016 18:55:56 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 8xx has 512k and 8M pages. This patch implements hugepages using
those sizes.

On the 8xx, the size of pages is in the PGD entry,
using PS field (bits 28-29):
00 : Small pages (4k or 16k)
01 : 512k pages
10 : reserved
11 : 8M pages

The implementation uses a mix of what is used on BOOKS and BOOKE,
as 512k pages are in HUGEPTE tables while for 8M pages we have
several PGD entries pointing on a leaf HUGEPTE entry

For the time being, we do not support CPU15 ERRATA if HUGETLB is
selected

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/hugetlb.h           |  18 ++-
 arch/powerpc/include/asm/mmu-8xx.h           |  35 ++++++
 arch/powerpc/include/asm/mmu.h               |  25 ++--
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |   1 +
 arch/powerpc/include/asm/nohash/pgtable.h    |   4 +
 arch/powerpc/include/asm/reg_8xx.h           |   2 +-
 arch/powerpc/kernel/head_8xx.S               | 119 +++++++++++++++++-
 arch/powerpc/mm/hugetlbpage.c                | 176 ++++++++++-----------------
 arch/powerpc/mm/tlb_nohash.c                 |  21 +++-
 arch/powerpc/platforms/8xx/Kconfig           |   1 +
 arch/powerpc/platforms/Kconfig.cputype       |   1 +
 11 files changed, 267 insertions(+), 136 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index c201cd6..96b3219 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -49,12 +49,20 @@ static inline void __local_flush_hugetlb_page(struct vm_area_struct *vma,
 static inline pte_t *hugepd_page(hugepd_t hpd)
 {
 	BUG_ON(!hugepd_ok(hpd));
+#ifdef CONFIG_PPC_8xx
+	return (pte_t *)__va(hpd.pd & ~(_PMD_PAGE_MASK | _PMD_PRESENT_MASK));
+#else
 	return (pte_t *)((hpd.pd & ~HUGEPD_SHIFT_MASK) | PD_HUGE);
+#endif
 }
 
 static inline unsigned int hugepd_shift(hugepd_t hpd)
 {
+#ifdef CONFIG_PPC_8xx
+	return ((hpd.pd & _PMD_PAGE_MASK) >> 1) + 17;
+#else
 	return hpd.pd & HUGEPD_SHIFT_MASK;
+#endif
 }
 
 #endif /* CONFIG_PPC_BOOK3S_64 */
@@ -97,7 +105,14 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
 
 void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
 			    pte_t pte);
+#ifdef CONFIG_PPC_8xx
+static inline void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
+{
+	flush_tlb_page(vma, vmaddr);
+}
+#else
 void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
+#endif
 
 void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 			    unsigned long end, unsigned long floor,
@@ -203,7 +218,8 @@ static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
  * are reserved early in the boot process by memblock instead of via
  * the .dts as on IBM platforms.
  */
-#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_PPC_FSL_BOOK3E)
+#if defined(CONFIG_HUGETLB_PAGE) && (defined(CONFIG_PPC_FSL_BOOK3E) || \
+    defined(CONFIG_PPC_8xx))
 extern void __init reserve_hugetlb_gpages(void);
 #else
 static inline void reserve_hugetlb_gpages(void)
diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
index 3e0e492..3179688 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -172,6 +172,41 @@ typedef struct {
 
 #define PHYS_IMMR_BASE (mfspr(SPRN_IMMR) & 0xfff80000)
 #define VIRT_IMMR_BASE (__fix_to_virt(FIX_IMMR_BASE))
+
+/* Page size definitions, common between 32 and 64-bit
+ *
+ *    shift : is the "PAGE_SHIFT" value for that page size
+ *    penc  : is the pte encoding mask
+ *
+ */
+struct mmu_psize_def
+{
+	unsigned int	shift;	/* number of bits */
+	unsigned int	enc;	/* PTE encoding */
+	unsigned int    ind;    /* Corresponding indirect page size shift */
+	unsigned int	flags;
+#define MMU_PAGE_SIZE_DIRECT	0x1	/* Supported as a direct size */
+#define MMU_PAGE_SIZE_INDIRECT	0x2	/* Supported as an indirect size */
+};
+extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
+
+static inline int shift_to_mmu_psize(unsigned int shift)
+{
+	int psize;
+
+	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize)
+		if (mmu_psize_defs[psize].shift == shift)
+			return psize;
+	return -1;
+}
+
+static inline unsigned int mmu_psize_to_shift(unsigned int mmu_psize)
+{
+	if (mmu_psize_defs[mmu_psize].shift)
+		return mmu_psize_defs[mmu_psize].shift;
+	BUG();
+}
+
 #endif /* !__ASSEMBLY__ */
 
 #if defined(CONFIG_PPC_4K_PAGES)
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index e2fb408..beccfbe 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -260,18 +260,19 @@ static inline bool early_radix_enabled(void)
 #define MMU_PAGE_64K	2
 #define MMU_PAGE_64K_AP	3	/* "Admixed pages" (hash64 only) */
 #define MMU_PAGE_256K	4
-#define MMU_PAGE_1M	5
-#define MMU_PAGE_2M	6
-#define MMU_PAGE_4M	7
-#define MMU_PAGE_8M	8
-#define MMU_PAGE_16M	9
-#define MMU_PAGE_64M	10
-#define MMU_PAGE_256M	11
-#define MMU_PAGE_1G	12
-#define MMU_PAGE_16G	13
-#define MMU_PAGE_64G	14
-
-#define MMU_PAGE_COUNT	15
+#define MMU_PAGE_512K	5
+#define MMU_PAGE_1M	6
+#define MMU_PAGE_2M	7
+#define MMU_PAGE_4M	8
+#define MMU_PAGE_8M	9
+#define MMU_PAGE_16M	10
+#define MMU_PAGE_64M	11
+#define MMU_PAGE_256M	12
+#define MMU_PAGE_1G	13
+#define MMU_PAGE_16G	14
+#define MMU_PAGE_64G	15
+
+#define MMU_PAGE_COUNT	16
 
 #ifdef CONFIG_PPC_BOOK3S_64
 #include <asm/book3s/64/mmu.h>
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 3742b19..b4df273 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -49,6 +49,7 @@
 #define _PMD_BAD	0x0ff0
 #define _PMD_PAGE_MASK	0x000c
 #define _PMD_PAGE_8M	0x000c
+#define _PMD_PAGE_512K	0x0004
 
 /* Until my rework is finished, 8xx still needs atomic PTE updates */
 #define PTE_ATOMIC_UPDATES	1
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 1263c22..1728497 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -226,7 +226,11 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 #ifdef CONFIG_HUGETLB_PAGE
 static inline int hugepd_ok(hugepd_t hpd)
 {
+#ifdef CONFIG_PPC_8xx
+	return ((hpd.pd & 0x4) != 0);
+#else
 	return (hpd.pd > 0);
+#endif
 }
 
 static inline int pmd_huge(pmd_t pmd)
diff --git a/arch/powerpc/include/asm/reg_8xx.h b/arch/powerpc/include/asm/reg_8xx.h
index 94d01f8..feaf641 100644
--- a/arch/powerpc/include/asm/reg_8xx.h
+++ b/arch/powerpc/include/asm/reg_8xx.h
@@ -4,7 +4,7 @@
 #ifndef _ASM_POWERPC_REG_8xx_H
 #define _ASM_POWERPC_REG_8xx_H
 
-#include <asm/mmu-8xx.h>
+#include <asm/mmu.h>
 
 /* Cache control on the MPC8xx is provided through some additional
  * special purpose registers.
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 5ce67f2..c77e0c6 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -72,6 +72,9 @@
 #define RPN_PATTERN	0x00f0
 #endif
 
+#define PAGE_SHIFT_512K		19
+#define PAGE_SHIFT_8M		23
+
 	__HEAD
 _ENTRY(_stext);
 _ENTRY(_start);
@@ -322,7 +325,7 @@ SystemCall:
 #endif
 
 InstructionTLBMiss:
-#if defined(CONFIG_8xx_CPU6) || defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC)
+#if defined(CONFIG_8xx_CPU6) || defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC) || defined (CONFIG_HUGETLB_PAGE)
 	mtspr	SPRN_SPRG_SCRATCH2, r3
 #endif
 	EXCEPTION_PROLOG_0
@@ -332,10 +335,12 @@ InstructionTLBMiss:
 	 */
 	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
 	INVALIDATE_ADJACENT_PAGES_CPU15(r11, r10)
-#if defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC)
 	/* Only modules will cause ITLB Misses as we always
 	 * pin the first 8MB of kernel memory */
+#if defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC) || defined (CONFIG_HUGETLB_PAGE)
 	mfcr	r3
+#endif
+#if defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC)
 	IS_KERNEL(r11, r10)
 #endif
 	mfspr	r11, SPRN_M_TW	/* Get level 1 table */
@@ -343,7 +348,6 @@ InstructionTLBMiss:
 	BRANCH_UNLESS_KERNEL(3f)
 	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
 3:
-	mtcr	r3
 #endif
 	/* Insert level 1 index */
 	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
@@ -351,14 +355,25 @@ InstructionTLBMiss:
 
 	/* Extract level 2 index */
 	rlwinm	r10, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
+#ifdef CONFIG_HUGETLB_PAGE
+	mtcr	r11
+	bt-	28, 10f		/* bit 28 = Large page (8M) */
+	bt-	29, 20f		/* bit 29 = Large page (8M or 512k) */
+#endif
 	rlwimi	r10, r11, 0, 0, 32 - PAGE_SHIFT - 1	/* Add level 2 base */
 	lwz	r10, 0(r10)	/* Get the pte */
-
+4:
+#if defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC) || defined (CONFIG_HUGETLB_PAGE)
+	mtcr	r3
+#endif
 	/* Insert the APG into the TWC from the Linux PTE. */
 	rlwimi	r11, r10, 0, 25, 26
 	/* Load the MI_TWC with the attributes for this "segment." */
 	MTSPR_CPU6(SPRN_MI_TWC, r11, r3)	/* Set segment attributes */
 
+#if defined (CONFIG_HUGETLB_PAGE) && defined (CONFIG_PPC_4K_PAGES)
+	rlwimi	r10, r11, 1, MI_SPS16K
+#endif
 #ifdef CONFIG_SWAP
 	rlwinm	r11, r10, 32-5, _PAGE_PRESENT
 	and	r11, r11, r10
@@ -371,16 +386,45 @@ InstructionTLBMiss:
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
 	 */
+#if defined (CONFIG_HUGETLB_PAGE) && defined (CONFIG_PPC_4K_PAGES)
+	rlwimi	r10, r11, 0, 0x0ff0	/* Set 24-27, clear 20-23 */
+#else
 	rlwimi	r10, r11, 0, 0x0ff8	/* Set 24-27, clear 20-23,28 */
+#endif
 	MTSPR_CPU6(SPRN_MI_RPN, r10, r3)	/* Update TLB entry */
 
 	/* Restore registers */
-#if defined(CONFIG_8xx_CPU6) || defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC)
+#if defined(CONFIG_8xx_CPU6) || defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC) || defined (CONFIG_HUGETLB_PAGE)
 	mfspr	r3, SPRN_SPRG_SCRATCH2
 #endif
 	EXCEPTION_EPILOG_0
 	rfi
 
+#ifdef CONFIG_HUGETLB_PAGE
+10:	/* 8M pages */
+#ifdef CONFIG_PPC_16K_PAGES
+	/* Extract level 2 index */
+	rlwinm	r10, r10, 32 - (PAGE_SHIFT_8M - PAGE_SHIFT), 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1), 29
+	/* Add level 2 base */
+	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1) - 1
+#else
+	/* Level 2 base */
+	rlwinm	r10, r11, 0, 0, 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1) - 1 - 1
+#endif
+	lwz	r10, 0(r10)	/* Get the pte */
+	rlwinm	r11, r11, 0, 0xf
+	b	4b
+
+20:	/* 512k pages */
+	/* Extract level 2 index */
+	rlwinm	r10, r10, 32 - (PAGE_SHIFT_512K - PAGE_SHIFT), 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1), 29
+	/* Add level 2 base */
+	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1) - 1
+	lwz	r10, 0(r10)	/* Get the pte */
+	rlwinm	r11, r11, 0, 0xf
+	b	4b
+#endif
+
 	. = 0x1200
 DataStoreTLBMiss:
 	mtspr	SPRN_SPRG_SCRATCH2, r3
@@ -407,7 +451,6 @@ _ENTRY(DTLBMiss_jmp)
 #endif
 	blt	cr7, DTLBMissLinear
 3:
-	mtcr	r3
 	mfspr	r10, SPRN_MD_EPN
 
 	/* Insert level 1 index */
@@ -418,8 +461,15 @@ _ENTRY(DTLBMiss_jmp)
 	 */
 	/* Extract level 2 index */
 	rlwinm	r10, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
+#ifdef CONFIG_HUGETLB_PAGE
+	mtcr	r11
+	bt-	28, 10f		/* bit 28 = Large page (8M) */
+	bt-	29, 20f		/* bit 29 = Large page (8M or 512k) */
+#endif
 	rlwimi	r10, r11, 0, 0, 32 - PAGE_SHIFT - 1	/* Add level 2 base */
 	lwz	r10, 0(r10)	/* Get the pte */
+4:
+	mtcr	r3
 
 	/* Insert the Guarded flag and APG into the TWC from the Linux PTE.
 	 * It is bit 26-27 of both the Linux PTE and the TWC (at least
@@ -434,6 +484,11 @@ _ENTRY(DTLBMiss_jmp)
 	rlwimi	r11, r10, 32-5, 30, 30
 	MTSPR_CPU6(SPRN_MD_TWC, r11, r3)
 
+	/* In 4k pages mode, SPS (bit 28) in RPN must match PS[1] (bit 29)
+	 * In 16k pages mode, SPS is always 1 */
+#if defined (CONFIG_HUGETLB_PAGE) && defined (CONFIG_PPC_4K_PAGES)
+	rlwimi	r10, r11, 1, MD_SPS16K
+#endif
 	/* Both _PAGE_ACCESSED and _PAGE_PRESENT has to be set.
 	 * We also need to know if the insn is a load/store, so:
 	 * Clear _PAGE_PRESENT and load that which will
@@ -455,7 +510,11 @@ _ENTRY(DTLBMiss_jmp)
 	 * of the MMU.
 	 */
 	li	r11, RPN_PATTERN
+#if defined (CONFIG_HUGETLB_PAGE) && defined (CONFIG_PPC_4K_PAGES)
+	rlwimi	r10, r11, 0, 24, 27	/* Set 24-27 */
+#else
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
+#endif
 	rlwimi	r10, r11, 0, 20, 20	/* clear 20 */
 	MTSPR_CPU6(SPRN_MD_RPN, r10, r3)	/* Update TLB entry */
 
@@ -465,6 +524,30 @@ _ENTRY(DTLBMiss_jmp)
 	EXCEPTION_EPILOG_0
 	rfi
 
+#ifdef CONFIG_HUGETLB_PAGE
+10:	/* 8M pages */
+	/* Extract level 2 index */
+#ifdef CONFIG_PPC_16K_PAGES
+	rlwinm	r10, r10, 32 - (PAGE_SHIFT_8M - PAGE_SHIFT), 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1), 29
+	/* Add level 2 base */
+	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1) - 1
+#else
+	/* Level 2 base */
+	rlwinm	r10, r11, 0, 0, 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1) - 1 - 1
+#endif
+	lwz	r10, 0(r10)	/* Get the pte */
+	rlwinm	r11, r11, 0, 0xf
+	b	4b
+
+20:	/* 512k pages */
+	/* Extract level 2 index */
+	rlwinm	r10, r10, 32 - (PAGE_SHIFT_512K - PAGE_SHIFT), 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1), 29
+	/* Add level 2 base */
+	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1) - 1
+	lwz	r10, 0(r10)	/* Get the pte */
+	rlwinm	r11, r11, 0, 0xf
+	b	4b
+#endif
 
 /* This is an instruction TLB error on the MPC8xx.  This could be due
  * to many reasons, such as executing guarded memory or illegal instruction
@@ -586,6 +669,9 @@ _ENTRY(FixupDAR_cmp)
 	/* Insert level 1 index */
 3:	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
+	mtcr	r11
+	bt	28,200f		/* bit 28 = Large page (8M) */
+	bt	29,202f		/* bit 29 = Large page (8M or 512K) */
 	rlwinm	r11, r11,0,0,19	/* Extract page descriptor page address */
 	/* Insert level 2 index */
 	rlwimi	r11, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
@@ -611,6 +697,27 @@ _ENTRY(FixupDAR_cmp)
 141:	mfspr	r10,SPRN_SPRG_SCRATCH2
 	b	DARFixed	/* Nope, go back to normal TLB processing */
 
+	/* concat physical page address(r11) and page offset(r10) */
+200:
+#ifdef CONFIG_PPC_16K_PAGES
+	rlwinm	r11, r11, 0, 0, 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1) - 1
+	rlwimi	r11, r10, 32 - (PAGE_SHIFT_8M - 2), 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1), 29
+#else
+	rlwinm	r11, r10, 0, 0, 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1) - 1 - 1
+#endif
+	lwz	r11, 0(r11)	/* Get the pte */
+	/* concat physical page address(r11) and page offset(r10) */
+	rlwimi	r11, r10, 0, 32 - PAGE_SHIFT_8M, 31
+	b	201b
+
+202:
+	rlwinm	r11, r11, 0, 0, 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1) - 1
+	rlwimi	r11, r10, 32 - (PAGE_SHIFT_512K - 2), 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1), 29
+	lwz	r11, 0(r11)	/* Get the pte */
+	/* concat physical page address(r11) and page offset(r10) */
+	rlwimi	r11, r10, 0, 32 - PAGE_SHIFT_512K, 31
+	b	201b
+
 144:	mfspr	r10, SPRN_DSISR
 	rlwinm	r10, r10,0,7,5	/* Clear store bit for buggy dcbst insn */
 	mtspr	SPRN_DSISR, r10
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 03fcb7e..20934db 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -26,6 +26,8 @@
 #ifdef CONFIG_HUGETLB_PAGE
 
 #define PAGE_SHIFT_64K	16
+#define PAGE_SHIFT_512K	19
+#define PAGE_SHIFT_8M	23
 #define PAGE_SHIFT_16M	24
 #define PAGE_SHIFT_16G	34
 
@@ -38,7 +40,7 @@ unsigned int HPAGE_SHIFT;
  * implementations may have more than one gpage size, so we need multiple
  * arrays
  */
-#ifdef CONFIG_PPC_FSL_BOOK3E
+#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 #define MAX_NUMBER_GPAGES	128
 struct psize_gpages {
 	u64 gpage_list[MAX_NUMBER_GPAGES];
@@ -64,14 +66,10 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 {
 	struct kmem_cache *cachep;
 	pte_t *new;
-
-#ifdef CONFIG_PPC_FSL_BOOK3E
 	int i;
-	int num_hugepd = 1 << (pshift - pdshift);
-	cachep = PGT_CACHE(1);
-#else
-	cachep = PGT_CACHE(pdshift - pshift);
-#endif
+	int num_hugepd = 1 << (pshift - pdshift) ? : 1;
+
+	cachep = PGT_CACHE(pdshift > pshift ? pdshift - pshift : 1);
 
 	new = kmem_cache_zalloc(cachep, GFP_KERNEL);
 
@@ -89,7 +87,6 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	smp_wmb();
 
 	spin_lock(&mm->page_table_lock);
-#ifdef CONFIG_PPC_FSL_BOOK3E
 	/*
 	 * We have multiple higher-level entries that point to the same
 	 * actual pte location.  Fill in each as we go and backtrack on error.
@@ -100,8 +97,18 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 		if (unlikely(!hugepd_none(*hpdp)))
 			break;
 		else
+#ifdef CONFIG_PPC_BOOK3S_64
+			hpdp->pd = __pa(new) |
+				   (shift_to_mmu_psize(pshift) << 2);
+#elif defined(CONFIG_PPC_8xx)
+			hpdp->pd = ((unsigned long)__pa(new)) |
+				   (pshift == PAGE_SHIFT_8M ? _PMD_PAGE_8M :
+							      _PMD_PAGE_512K) |
+				   _PMD_PRESENT;
+#else
 			/* We use the old format for PPC_FSL_BOOK3E */
 			hpdp->pd = ((unsigned long)new & ~PD_HUGE) | pshift;
+#endif
 	}
 	/* If we bailed from the for loop early, an error occurred, clean up */
 	if (i < num_hugepd) {
@@ -109,17 +116,6 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 			hpdp->pd = 0;
 		kmem_cache_free(cachep, new);
 	}
-#else
-	if (!hugepd_none(*hpdp))
-		kmem_cache_free(cachep, new);
-	else {
-#ifdef CONFIG_PPC_BOOK3S_64
-		hpdp->pd = __pa(new) | (shift_to_mmu_psize(pshift) << 2);
-#else
-		hpdp->pd = ((unsigned long)new & ~PD_HUGE) | pshift;
-#endif
-	}
-#endif
 	spin_unlock(&mm->page_table_lock);
 	return 0;
 }
@@ -128,7 +124,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
  * These macros define how to determine which level of the page table holds
  * the hpdp.
  */
-#ifdef CONFIG_PPC_FSL_BOOK3E
+#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 #define HUGEPD_PGD_SHIFT PGDIR_SHIFT
 #define HUGEPD_PUD_SHIFT PUD_SHIFT
 #else
@@ -136,7 +132,6 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 #define HUGEPD_PUD_SHIFT PMD_SHIFT
 #endif
 
-#ifdef CONFIG_PPC_BOOK3S_64
 /*
  * At this point we do the placement change only for BOOK3S 64. This would
  * possibly work on other subarchs.
@@ -153,6 +148,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 	addr &= ~(sz-1);
 	pg = pgd_offset(mm, addr);
 
+#ifdef CONFIG_PPC_BOOK3S_64
 	if (pshift == PGDIR_SHIFT)
 		/* 16GB huge page */
 		return (pte_t *) pg;
@@ -178,32 +174,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 				hpdp = (hugepd_t *)pm;
 		}
 	}
-	if (!hpdp)
-		return NULL;
-
-	BUG_ON(!hugepd_none(*hpdp) && !hugepd_ok(*hpdp));
-
-	if (hugepd_none(*hpdp) && __hugepte_alloc(mm, hpdp, addr, pdshift, pshift))
-		return NULL;
-
-	return hugepte_offset(*hpdp, addr, pdshift);
-}
-
 #else
-
-pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
-{
-	pgd_t *pg;
-	pud_t *pu;
-	pmd_t *pm;
-	hugepd_t *hpdp = NULL;
-	unsigned pshift = __ffs(sz);
-	unsigned pdshift = PGDIR_SHIFT;
-
-	addr &= ~(sz-1);
-
-	pg = pgd_offset(mm, addr);
-
 	if (pshift >= HUGEPD_PGD_SHIFT) {
 		hpdp = (hugepd_t *)pg;
 	} else {
@@ -217,7 +188,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 			hpdp = (hugepd_t *)pm;
 		}
 	}
-
+#endif
 	if (!hpdp)
 		return NULL;
 
@@ -228,9 +199,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 
 	return hugepte_offset(*hpdp, addr, pdshift);
 }
-#endif
 
-#ifdef CONFIG_PPC_FSL_BOOK3E
+#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 /* Build list of addresses of gigantic pages.  This function is used in early
  * boot before the buddy allocator is setup.
  */
@@ -310,7 +280,11 @@ static int __init do_gpage_early_setup(char *param, char *val,
 				npages = 0;
 			if (npages > MAX_NUMBER_GPAGES) {
 				pr_warn("MMU: %lu pages requested for page "
+#ifdef CONFIG_PPC64
 					"size %llu KB, limiting to "
+#else
+					"size %u KB, limiting to "
+#endif
 					__stringify(MAX_NUMBER_GPAGES) "\n",
 					npages, size / 1024);
 				npages = MAX_NUMBER_GPAGES;
@@ -392,7 +366,7 @@ int alloc_bootmem_huge_page(struct hstate *hstate)
 }
 #endif
 
-#ifdef CONFIG_PPC_FSL_BOOK3E
+#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 #define HUGEPD_FREELIST_SIZE \
 	((PAGE_SIZE - sizeof(struct hugepd_freelist)) / sizeof(pte_t))
 
@@ -442,6 +416,12 @@ static void hugepd_free(struct mmu_gather *tlb, void *hugepte)
 	}
 	put_cpu_var(hugepd_freelist_cur);
 }
+#else
+static void hugepd_free(struct mmu_gather *tlb, void *hugepte)
+{
+	BUG();
+}
+
 #endif
 
 static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshift,
@@ -452,14 +432,9 @@ static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshif
 	int i;
 
 	unsigned long pdmask = ~((1UL << pdshift) - 1);
-	unsigned int num_hugepd = 1;
-
-#ifdef CONFIG_PPC_FSL_BOOK3E
-	/* Note: On fsl the hpdp may be the first of several */
-	num_hugepd = (1 << (hugepd_shift(*hpdp) - pdshift));
-#else
 	unsigned int shift = hugepd_shift(*hpdp);
-#endif
+	/* Note: On fsl the hpdp may be the first of several */
+	unsigned int num_hugepd = (1 << (shift - pdshift)) ? : 1;
 
 	start &= pdmask;
 	if (start < floor)
@@ -475,11 +450,10 @@ static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshif
 	for (i = 0; i < num_hugepd; i++, hpdp++)
 		hpdp->pd = 0;
 
-#ifdef CONFIG_PPC_FSL_BOOK3E
-	hugepd_free(tlb, hugepte);
-#else
-	pgtable_free_tlb(tlb, hugepte, pdshift - shift);
-#endif
+	if (pdshift <= shift)
+		hugepd_free(tlb, hugepte);
+	else
+		pgtable_free_tlb(tlb, hugepte, pdshift - shift);
 }
 
 static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
@@ -502,7 +476,7 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 			WARN_ON(!pmd_none_or_clear_bad(pmd));
 			continue;
 		}
-#ifdef CONFIG_PPC_FSL_BOOK3E
+#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 		/*
 		 * Increment next by the size of the huge mapping since
 		 * there may be more than one entry at this level for a
@@ -550,7 +524,7 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
 			hugetlb_free_pmd_range(tlb, pud, addr, next, floor,
 					       ceiling);
 		} else {
-#ifdef CONFIG_PPC_FSL_BOOK3E
+#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 			/*
 			 * Increment next by the size of the huge mapping since
 			 * there may be more than one entry at this level for a
@@ -615,7 +589,7 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 				continue;
 			hugetlb_free_pud_range(tlb, pgd, addr, next, floor, ceiling);
 		} else {
-#ifdef CONFIG_PPC_FSL_BOOK3E
+#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 			/*
 			 * Increment next by the size of the huge mapping since
 			 * there may be more than one entry at the pgd level
@@ -753,12 +727,13 @@ static int __init add_huge_page_size(unsigned long long size)
 
 	/* Check that it is a page size supported by the hardware and
 	 * that it fits within pagetable and slice limits. */
-#ifdef CONFIG_PPC_FSL_BOOK3E
-	if ((size < PAGE_SIZE) || !is_power_of_4(size))
+	if ((size <= PAGE_SIZE))
 		return -EINVAL;
-#else
-	if (!is_power_of_2(size)
-	    || (shift > SLICE_HIGH_SHIFT) || (shift <= PAGE_SHIFT))
+#if defined(CONFIG_PPC_FSL_BOOK3E)
+	if (!is_power_of_4(size))
+		return -EINVAL;
+#elif !defined(CONFIG_PPC_8xx)
+	if (!is_power_of_2(size) || (shift > SLICE_HIGH_SHIFT))
 		return -EINVAL;
 #endif
 
@@ -791,51 +766,14 @@ static int __init hugepage_setup_sz(char *str)
 }
 __setup("hugepagesz=", hugepage_setup_sz);
 
-#ifdef CONFIG_PPC_FSL_BOOK3E
-static int __init hugetlbpage_init(void)
-{
-	int psize;
-
-	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
-		unsigned shift;
-
-		if (!mmu_psize_defs[psize].shift)
-			continue;
-
-		shift = mmu_psize_to_shift(psize);
-
-		/* Don't treat normal page sizes as huge... */
-		if (shift != PAGE_SHIFT)
-			if (add_huge_page_size(1ULL << shift) < 0)
-				continue;
-	}
-
-	/*
-	 * Create a kmem cache for hugeptes.  The bottom bits in the pte have
-	 * size information encoded in them, so align them to allow this
-	 */
-	pgtable_cache_add(1, NULL);
-	if (!PGT_CACHE(1))
-		panic("%s: Unable to create kmem cache for hugeptes\n",
-		      __func__);
-
-	/* Default hpage size = 4M */
-	if (mmu_psize_defs[MMU_PAGE_4M].shift)
-		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_4M].shift;
-	else
-		panic("%s: Unable to set default huge page size\n", __func__);
-
-
-	return 0;
-}
-#else
 static int __init hugetlbpage_init(void)
 {
 	int psize;
 
+#if !defined(CONFIG_PPC_FSL_BOOK3E) && !defined(CONFIG_PPC_8xx)
 	if (!radix_enabled() && !mmu_has_feature(MMU_FTR_16M_PAGE))
 		return -ENODEV;
-
+#endif
 	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
 		unsigned shift;
 		unsigned pdshift;
@@ -859,15 +797,18 @@ static int __init hugetlbpage_init(void)
 		 * use pgt cache for hugepd.
 		 */
 		if (pdshift != shift) {
-			pgtable_cache_add(pdshift - shift, NULL);
-			if (!PGT_CACHE(pdshift - shift))
+			int size_hugepd = pdshift > shift ? pdshift - shift : 1;
+
+			pgtable_cache_add(size_hugepd, NULL);
+			if (!PGT_CACHE(size_hugepd))
 				panic("hugetlbpage_init(): could not create "
 				      "pgtable cache for %d bit pagesize\n", shift);
 		}
 	}
 
 	/* Set default large page size. Currently, we pick 16M or 1M
-	 * depending on what is available
+	 * depending on what is available. On PPC_8xx we select 512K.
+	 * We select 4M on other ones.
 	 */
 	if (mmu_psize_defs[MMU_PAGE_16M].shift)
 		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_16M].shift;
@@ -875,11 +816,16 @@ static int __init hugetlbpage_init(void)
 		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_1M].shift;
 	else if (mmu_psize_defs[MMU_PAGE_2M].shift)
 		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_2M].shift;
-
+	else if (mmu_psize_defs[MMU_PAGE_4M].shift)
+		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_4M].shift;
+	else if (mmu_psize_defs[MMU_PAGE_512K].shift)
+		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_512K].shift;
+	else
+		panic("%s: Unable to set default huge page size\n", __func__);
 
 	return 0;
 }
-#endif
+
 arch_initcall(hugetlbpage_init);
 
 void flush_dcache_icache_hugepage(struct page *page)
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 050badc..a33522b 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -53,7 +53,7 @@
  * other sizes not listed here.   The .ind field is only used on MMUs that have
  * indirect page table entries.
  */
-#ifdef CONFIG_PPC_BOOK3E_MMU
+#if defined(CONFIG_PPC_BOOK3E_MMU) || defined (CONFIG_PPC_8xx)
 #ifdef CONFIG_PPC_FSL_BOOK3E
 struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 	[MMU_PAGE_4K] = {
@@ -85,6 +85,25 @@ struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 		.enc	= BOOK3E_PAGESZ_1GB,
 	},
 };
+#elif defined (CONFIG_PPC_8xx)
+struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
+	/* we only manage 4k and 16k pages as normal pages */
+#ifdef CONFIG_PPC_4K_PAGES
+	[MMU_PAGE_4K] = {
+		.shift	= 12,
+	},
+#else
+	[MMU_PAGE_16K] = {
+		.shift	= 14,
+	},
+#endif
+	[MMU_PAGE_512K] = {
+		.shift	= 19,
+	},
+	[MMU_PAGE_8M] = {
+		.shift	= 23,
+	},
+};
 #else
 struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 	[MMU_PAGE_4K] = {
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index 564d99b..80cbcb0 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -130,6 +130,7 @@ config 8xx_CPU6
 
 config 8xx_CPU15
 	bool "CPU15 Silicon Errata"
+	depends on !HUGETLB_PAGE
 	default y
 	help
 	  This enables a workaround for erratum CPU15 on MPC8xx chips.
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f32edec..59887ad 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -34,6 +34,7 @@ config PPC_8xx
 	select FSL_SOC
 	select 8xx
 	select PPC_LIB_RHEAP
+	select SYS_SUPPORTS_HUGETLBFS
 
 config 40x
 	bool "AMCC 40x"
-- 
2.1.0
