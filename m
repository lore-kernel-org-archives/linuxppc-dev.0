Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7D9C7B7526
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 07:51:20 +1100 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/13] powerpc: hugetlb: modify include usage for FSL BookE
 code
Date: Mon, 10 Oct 2011 15:50:40 -0500
Message-Id: <13182798731357-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <1318279870278-git-send-email-beckyb@kernel.crashing.org>
References: <1318279848494-git-send-email-beckyb@kernel.crashing.org>
 <13182798624083-git-send-email-beckyb@kernel.crashing.org>
 <13182798643553-git-send-email-beckyb@kernel.crashing.org>
 <13182798681100-git-send-email-beckyb@kernel.crashing.org>
 <1318279870278-git-send-email-beckyb@kernel.crashing.org>
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Becky Bruce <beckyb@kernel.crashing.org>

The original 32-bit hugetlb implementation used PPC64 vs PPC32 to
determine which code path to take.  However, the final hugetlb
implementation for 64-bit FSL ended up shared with the FSL
32-bit code so the actual check needs to be FSL_BOOK3E vs
everything else.  This patch changes the include protections to
reflect this.

There are also a couple of related comment fixes.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/include/asm/hugetlb.h |    6 ++--
 arch/powerpc/mm/hugetlbpage.c      |   54 ++++++++++++++++-------------------
 arch/powerpc/mm/tlb_nohash.c       |    2 +-
 3 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 70f9885..273acfa 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -22,14 +22,14 @@ static inline pte_t *hugepte_offset(hugepd_t *hpdp, unsigned long addr,
 				    unsigned pdshift)
 {
 	/*
-	 * On 32-bit, we have multiple higher-level table entries that point to
-	 * the same hugepte.  Just use the first one since they're all
+	 * On FSL BookE, we have multiple higher-level table entries that
+	 * point to the same hugepte.  Just use the first one since they're all
 	 * identical.  So for that case, idx=0.
 	 */
 	unsigned long idx = 0;
 
 	pte_t *dir = hugepd_page(*hpdp);
-#ifdef CONFIG_PPC64
+#ifndef CONFIG_PPC_FSL_BOOK3E
 	idx = (addr & ((1UL << pdshift) - 1)) >> hugepd_shift(*hpdp);
 #endif
 
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index b4a4884..9a34606 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -33,17 +33,17 @@ unsigned int HPAGE_SHIFT;
  * implementations may have more than one gpage size due to limitations
  * of the memory allocators, so we need multiple arrays
  */
-#ifdef CONFIG_PPC64
-#define MAX_NUMBER_GPAGES	1024
-static u64 gpage_freearray[MAX_NUMBER_GPAGES];
-static unsigned nr_gpages;
-#else
+#ifdef CONFIG_PPC_FSL_BOOK3E
 #define MAX_NUMBER_GPAGES	128
 struct psize_gpages {
 	u64 gpage_list[MAX_NUMBER_GPAGES];
 	unsigned int nr_gpages;
 };
 static struct psize_gpages gpage_freearray[MMU_PAGE_COUNT];
+#else
+#define MAX_NUMBER_GPAGES	1024
+static u64 gpage_freearray[MAX_NUMBER_GPAGES];
+static unsigned nr_gpages;
 #endif
 
 static inline int shift_to_mmu_psize(unsigned int shift)
@@ -114,12 +114,12 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	struct kmem_cache *cachep;
 	pte_t *new;
 
-#ifdef CONFIG_PPC64
-	cachep = PGT_CACHE(pdshift - pshift);
-#else
+#ifdef CONFIG_PPC_FSL_BOOK3E
 	int i;
 	int num_hugepd = 1 << (pshift - pdshift);
 	cachep = hugepte_cache;
+#else
+	cachep = PGT_CACHE(pdshift - pshift);
 #endif
 
 	new = kmem_cache_zalloc(cachep, GFP_KERNEL|__GFP_REPEAT);
@@ -131,12 +131,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 		return -ENOMEM;
 
 	spin_lock(&mm->page_table_lock);
-#ifdef CONFIG_PPC64
-	if (!hugepd_none(*hpdp))
-		kmem_cache_free(cachep, new);
-	else
-		hpdp->pd = ((unsigned long)new & ~PD_HUGE) | pshift;
-#else
+#ifdef CONFIG_PPC_FSL_BOOK3E
 	/*
 	 * We have multiple higher-level entries that point to the same
 	 * actual pte location.  Fill in each as we go and backtrack on error.
@@ -215,7 +210,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 	return hugepte_offset(hpdp, addr, pdshift);
 }
 
-#ifdef CONFIG_PPC32
+#ifdef CONFIG_PPC_FSL_BOOK3E
 /* Build list of addresses of gigantic pages.  This function is used in early
  * boot before the buddy or bootmem allocator is setup.
  */
@@ -335,7 +330,7 @@ void __init reserve_hugetlb_gpages(void)
 	}
 }
 
-#else /* PPC64 */
+#else /* !PPC_FSL_BOOK3E */
 
 /* Build list of addresses of gigantic pages.  This function is used in early
  * boot before the buddy or bootmem allocator is setup.
@@ -373,7 +368,7 @@ int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
 	return 0;
 }
 
-#ifdef CONFIG_PPC32
+#ifdef CONFIG_PPC_FSL_BOOK3E
 #define HUGEPD_FREELIST_SIZE \
 	((PAGE_SIZE - sizeof(struct hugepd_freelist)) / sizeof(pte_t))
 
@@ -433,11 +428,11 @@ static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshif
 	unsigned long pdmask = ~((1UL << pdshift) - 1);
 	unsigned int num_hugepd = 1;
 
-#ifdef CONFIG_PPC64
-	unsigned int shift = hugepd_shift(*hpdp);
-#else
-	/* Note: On 32-bit the hpdp may be the first of several */
+#ifdef CONFIG_PPC_FSL_BOOK3E
+	/* Note: On fsl the hpdp may be the first of several */
 	num_hugepd = (1 << (hugepd_shift(*hpdp) - pdshift));
+#else
+	unsigned int shift = hugepd_shift(*hpdp);
 #endif
 
 	start &= pdmask;
@@ -455,10 +450,11 @@ static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshif
 		hpdp->pd = 0;
 
 	tlb->need_flush = 1;
-#ifdef CONFIG_PPC64
-	pgtable_free_tlb(tlb, hugepte, pdshift - shift);
-#else
+
+#ifdef CONFIG_PPC_FSL_BOOK3E
 	hugepd_free(tlb, hugepte);
+#else
+	pgtable_free_tlb(tlb, hugepte, pdshift - shift);
 #endif
 }
 
@@ -590,12 +586,12 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 				continue;
 			hugetlb_free_pud_range(tlb, pgd, addr, next, floor, ceiling);
 		} else {
-#ifdef CONFIG_PPC32
+#ifdef CONFIG_PPC_FSL_BOOK3E
 			/*
 			 * Increment next by the size of the huge mapping since
-			 * on 32-bit there may be more than one entry at the pgd
-			 * level for a single hugepage, but all of them point to
-			 * the same kmem cache that holds the hugepte.
+			 * there may be more than one entry at the pgd level
+			 * for a single hugepage, but all of them point to the
+			 * same kmem cache that holds the hugepte.
 			 */
 			next = addr + (1 << hugepd_shift(*(hugepd_t *)pgd));
 #endif
@@ -806,7 +802,7 @@ static int __init hugepage_setup_sz(char *str)
 }
 __setup("hugepagesz=", hugepage_setup_sz);
 
-#ifdef CONFIG_FSL_BOOKE
+#ifdef CONFIG_PPC_FSL_BOOK3E
 struct kmem_cache *hugepte_cache;
 static int __init hugetlbpage_init(void)
 {
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index afc95c7..c02901f 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -51,7 +51,7 @@
  * indirect page table entries.
  */
 #ifdef CONFIG_PPC_BOOK3E_MMU
-#ifdef CONFIG_FSL_BOOKE
+#ifdef CONFIG_PPC_FSL_BOOK3E
 struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 	[MMU_PAGE_4K] = {
 		.shift	= 12,
-- 
1.5.6.5
