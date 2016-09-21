Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfC6v29HtzDt0l
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 18:13:11 +1000 (AEST)
Message-Id: <b59c1fce3f5e5f95fd7e70874278ce3602d571aa.1474441302.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1474441301.git.christophe.leroy@c-s.fr>
References: <cover.1474441301.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 3/3] powerpc/8xx: Implement support of hugepages
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 21 Sep 2016 10:11:56 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

8xx uses a two level page table with two different linux page size
support (4k and 16k). 8xx also support two different hugepage sizes
512k and 8M. In order to support them on linux we define two different
page table layout.

The size of pages is in the PGD entry, using PS field (bits 28-29):
00 : Small pages (4k or 16k)
01 : 512k pages
10 : reserved
11 : 8M pages

For 512K hugepage size a pgd entry have the below format
[<hugepte address >0101] . The hugepte table allocated will contain 8
entries pointing to 512K huge pte in 4k pages mode and 64 entries in
16k pages mode.

For 8M in 16k mode, a pgd entry have the below format
[<hugepte address >1101] . The hugepte table allocated will contain 8
entries pointing to 8M huge pte.

For 8M in 4k mode, multiple pgd entries point to the same hugepte
address and pgd entry will have the below format
[<hugepte address>1101]. The hugepte table allocated will only have one
entry.

For the time being, we do not support CPU15 ERRATA when HUGETLB is
selected

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: This v1 was split in two parts. This part focuses on adding the
support on 8xx. It also fixes an error in TLBmiss handlers in the
case of 8M hugepages in 16k pages mode.

v3: No change

 arch/powerpc/include/asm/hugetlb.h           |  19 ++++-
 arch/powerpc/include/asm/mmu-8xx.h           |  35 ++++++++
 arch/powerpc/include/asm/mmu.h               |  23 +++---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |   1 +
 arch/powerpc/include/asm/nohash/pgtable.h    |   4 +
 arch/powerpc/include/asm/reg_8xx.h           |   2 +-
 arch/powerpc/kernel/head_8xx.S               | 119 +++++++++++++++++++++++++--
 arch/powerpc/mm/hugetlbpage.c                |  27 ++++--
 arch/powerpc/mm/tlb_nohash.c                 |  21 ++++-
 arch/powerpc/platforms/8xx/Kconfig           |   1 +
 arch/powerpc/platforms/Kconfig.cputype       |   1 +
 11 files changed, 224 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index c5517f4..3facdd4 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -51,12 +51,20 @@ static inline void __local_flush_hugetlb_page(struct vm_area_struct *vma,
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
@@ -99,7 +107,15 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
 
 void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
 			    pte_t pte);
+#ifdef CONFIG_PPC_8xx
+static inline void flush_hugetlb_page(struct vm_area_struct *vma,
+				      unsigned long vmaddr)
+{
+	flush_tlb_page(vma, vmaddr);
+}
+#else
 void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
+#endif
 
 void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 			    unsigned long end, unsigned long floor,
@@ -205,7 +221,8 @@ static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
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
index 3e0e492..798b5bf 100644
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
+struct mmu_psize_def {
+	unsigned int	shift;	/* number of bits */
+	unsigned int	enc;	/* PTE encoding */
+	unsigned int    ind;    /* Corresponding indirect page size shift */
+	unsigned int	flags;
+#define MMU_PAGE_SIZE_DIRECT	0x1	/* Supported as a direct size */
+#define MMU_PAGE_SIZE_INDIRECT	0x2	/* Supported as an indirect size */
+};
+
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
index b78e8d3..c81aafc 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -260,19 +260,20 @@ static inline bool early_radix_enabled(void)
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
 
 /* N.B. we need to change the type of hpte_page_sizes if this gets to be > 16 */
-#define MMU_PAGE_COUNT	15
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
index bfe4907..82d43dd 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -73,6 +73,9 @@
 #define RPN_PATTERN	0x00f0
 #endif
 
+#define PAGE_SHIFT_512K		19
+#define PAGE_SHIFT_8M		23
+
 	__HEAD
 _ENTRY(_stext);
 _ENTRY(_start);
@@ -323,7 +326,7 @@ SystemCall:
 #endif
 
 InstructionTLBMiss:
-#if defined(CONFIG_8xx_CPU6) || defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC)
+#if defined(CONFIG_8xx_CPU6) || defined(CONFIG_MODULES) || defined (CONFIG_DEBUG_PAGEALLOC) || defined (CONFIG_HUGETLB_PAGE)
 	mtspr	SPRN_SPRG_SCRATCH2, r3
 #endif
 	EXCEPTION_PROLOG_0
@@ -333,10 +336,12 @@ InstructionTLBMiss:
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
@@ -344,7 +349,6 @@ InstructionTLBMiss:
 	BRANCH_UNLESS_KERNEL(3f)
 	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@ha
 3:
-	mtcr	r3
 #endif
 	/* Insert level 1 index */
 	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
@@ -352,14 +356,25 @@ InstructionTLBMiss:
 
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
@@ -372,16 +387,45 @@ InstructionTLBMiss:
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
+	rlwinm	r10, r11, 0, ~HUGEPD_SHIFT_MASK
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
@@ -408,7 +452,6 @@ _ENTRY(DTLBMiss_jmp)
 #endif
 	blt	cr7, DTLBMissLinear
 3:
-	mtcr	r3
 	mfspr	r10, SPRN_MD_EPN
 
 	/* Insert level 1 index */
@@ -419,8 +462,15 @@ _ENTRY(DTLBMiss_jmp)
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
@@ -435,6 +485,11 @@ _ENTRY(DTLBMiss_jmp)
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
@@ -456,7 +511,11 @@ _ENTRY(DTLBMiss_jmp)
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
 
@@ -466,6 +525,30 @@ _ENTRY(DTLBMiss_jmp)
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
+	rlwinm	r10, r11, 0, ~HUGEPD_SHIFT_MASK
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
@@ -587,6 +670,9 @@ _ENTRY(FixupDAR_cmp)
 	/* Insert level 1 index */
 3:	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
+	mtcr	r11
+	bt	28,200f		/* bit 28 = Large page (8M) */
+	bt	29,202f		/* bit 29 = Large page (8M or 512K) */
 	rlwinm	r11, r11,0,0,19	/* Extract page descriptor page address */
 	/* Insert level 2 index */
 	rlwimi	r11, r10, 32 - (PAGE_SHIFT - 2), 32 - PAGE_SHIFT, 29
@@ -612,6 +698,27 @@ _ENTRY(FixupDAR_cmp)
 141:	mfspr	r10,SPRN_SPRG_SCRATCH2
 	b	DARFixed	/* Nope, go back to normal TLB processing */
 
+	/* concat physical page address(r11) and page offset(r10) */
+200:
+#ifdef CONFIG_PPC_16K_PAGES
+	rlwinm	r11, r11, 0, 0, 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1) - 1
+	rlwimi	r11, r10, 32 - (PAGE_SHIFT_8M - 2), 32 + PAGE_SHIFT_8M - (PAGE_SHIFT << 1), 29
+#else
+	rlwinm	r11, r10, 0, ~HUGEPD_SHIFT_MASK
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
index a0d049a..4399189 100644
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
@@ -105,6 +107,11 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 #ifdef CONFIG_PPC_BOOK3S_64
 			hpdp->pd = __pa(new) |
 				   (shift_to_mmu_psize(pshift) << 2);
+#elif defined(CONFIG_PPC_8xx)
+			hpdp->pd = __pa(new) |
+				   (pshift == PAGE_SHIFT_8M ? _PMD_PAGE_8M :
+							      _PMD_PAGE_512K) |
+				   _PMD_PRESENT;
 #else
 			/* We use the old format for PPC_FSL_BOOK3E */
 			hpdp->pd = ((unsigned long)new & ~PD_HUGE) | pshift;
@@ -124,7 +131,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
  * These macros define how to determine which level of the page table holds
  * the hpdp.
  */
-#ifdef CONFIG_PPC_FSL_BOOK3E
+#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 #define HUGEPD_PGD_SHIFT PGDIR_SHIFT
 #define HUGEPD_PUD_SHIFT PUD_SHIFT
 #else
@@ -200,7 +207,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 	return hugepte_offset(*hpdp, addr, pdshift);
 }
 
-#ifdef CONFIG_PPC_FSL_BOOK3E
+#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 /* Build list of addresses of gigantic pages.  This function is used in early
  * boot before the buddy allocator is setup.
  */
@@ -366,7 +373,7 @@ int alloc_bootmem_huge_page(struct hstate *hstate)
 }
 #endif
 
-#ifdef CONFIG_PPC_FSL_BOOK3E
+#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 #define HUGEPD_FREELIST_SIZE \
 	((PAGE_SIZE - sizeof(struct hugepd_freelist)) / sizeof(pte_t))
 
@@ -735,10 +742,10 @@ static int __init add_huge_page_size(unsigned long long size)
 	 * that it fits within pagetable and slice limits. */
 	if (size <= PAGE_SIZE)
 		return -EINVAL;
-#ifdef CONFIG_PPC_FSL_BOOK3E
+#if defined(CONFIG_PPC_FSL_BOOK3E)
 	if (!is_power_of_4(size))
 		return -EINVAL;
-#else
+#elif !defined(CONFIG_PPC_8xx)
 	if (!is_power_of_2(size) || (shift > SLICE_HIGH_SHIFT))
 		return -EINVAL;
 #endif
@@ -777,7 +784,7 @@ static int __init hugetlbpage_init(void)
 {
 	int psize;
 
-#if !defined(CONFIG_PPC_FSL_BOOK3E)
+#if !defined(CONFIG_PPC_FSL_BOOK3E) && !defined(CONFIG_PPC_8xx)
 	if (!radix_enabled() && !mmu_has_feature(MMU_FTR_16M_PAGE))
 		return -ENODEV;
 #endif
@@ -809,7 +816,7 @@ static int __init hugetlbpage_init(void)
 				panic("hugetlbpage_init(): could not create "
 				      "pgtable cache for %d bit pagesize\n", shift);
 		}
-#ifdef CONFIG_PPC_FSL_BOOK3E
+#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 		else if (!hugepte_cache) {
 			/*
 			 * Create a kmem cache for hugeptes.  The bottom bits in
@@ -829,7 +836,7 @@ static int __init hugetlbpage_init(void)
 	}
 
 	/* Set default large page size. Currently, we pick 16M or 1M
-	 * depending on what is available
+	 * depending on what is available. On PPC_8xx we select 512K.
 	 * We select 4M on other ones.
 	 */
 	if (mmu_psize_defs[MMU_PAGE_16M].shift)
@@ -840,6 +847,8 @@ static int __init hugetlbpage_init(void)
 		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_2M].shift;
 	else if (mmu_psize_defs[MMU_PAGE_4M].shift)
 		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_4M].shift;
+	else if (mmu_psize_defs[MMU_PAGE_512K].shift)
+		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_512K].shift;
 	else
 		panic("%s: Unable to set default huge page size\n", __func__);
 
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 050badc..ba28fcb 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -53,7 +53,7 @@
  * other sizes not listed here.   The .ind field is only used on MMUs that have
  * indirect page table entries.
  */
-#ifdef CONFIG_PPC_BOOK3E_MMU
+#if defined(CONFIG_PPC_BOOK3E_MMU) || defined(CONFIG_PPC_8xx)
 #ifdef CONFIG_PPC_FSL_BOOK3E
 struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 	[MMU_PAGE_4K] = {
@@ -85,6 +85,25 @@ struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 		.enc	= BOOK3E_PAGESZ_1GB,
 	},
 };
+#elif defined(CONFIG_PPC_8xx)
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
