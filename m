Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4DBABB727E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 07:51:17 +1100 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/13] powerpc: Update hugetlb huge_pte_alloc and tablewalk
 code for FSL BOOKE
Date: Mon, 10 Oct 2011 15:50:39 -0500
Message-Id: <1318279870278-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <13182798681100-git-send-email-beckyb@kernel.crashing.org>
References: <1318279848494-git-send-email-beckyb@kernel.crashing.org>
 <13182798624083-git-send-email-beckyb@kernel.crashing.org>
 <13182798643553-git-send-email-beckyb@kernel.crashing.org>
 <13182798681100-git-send-email-beckyb@kernel.crashing.org>
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

This updates the hugetlb page table code to handle 64-bit FSL_BOOKE.
The previous 32-bit work counted on the inner levels of the page table
collapsing.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/mm/hugetlbpage.c |   48 +++++++++++++++++++++++++++++++++++-----
 1 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 71c6533..b4a4884 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -155,11 +155,28 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 			hpdp->pd = 0;
 		kmem_cache_free(cachep, new);
 	}
+#else
+	if (!hugepd_none(*hpdp))
+		kmem_cache_free(cachep, new);
+	else
+		hpdp->pd = ((unsigned long)new & ~PD_HUGE) | pshift;
 #endif
 	spin_unlock(&mm->page_table_lock);
 	return 0;
 }
 
+/*
+ * These macros define how to determine which level of the page table holds
+ * the hpdp.
+ */
+#ifdef CONFIG_PPC_FSL_BOOK3E
+#define HUGEPD_PGD_SHIFT PGDIR_SHIFT
+#define HUGEPD_PUD_SHIFT PUD_SHIFT
+#else
+#define HUGEPD_PGD_SHIFT PUD_SHIFT
+#define HUGEPD_PUD_SHIFT PMD_SHIFT
+#endif
+
 pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
 {
 	pgd_t *pg;
@@ -172,12 +189,13 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 	addr &= ~(sz-1);
 
 	pg = pgd_offset(mm, addr);
-	if (pshift >= PUD_SHIFT) {
+
+	if (pshift >= HUGEPD_PGD_SHIFT) {
 		hpdp = (hugepd_t *)pg;
 	} else {
 		pdshift = PUD_SHIFT;
 		pu = pud_alloc(mm, pg, addr);
-		if (pshift >= PMD_SHIFT) {
+		if (pshift >= HUGEPD_PUD_SHIFT) {
 			hpdp = (hugepd_t *)pu;
 		} else {
 			pdshift = PMD_SHIFT;
@@ -453,14 +471,23 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 	unsigned long start;
 
 	start = addr;
-	pmd = pmd_offset(pud, addr);
 	do {
+		pmd = pmd_offset(pud, addr);
 		next = pmd_addr_end(addr, end);
 		if (pmd_none(*pmd))
 			continue;
+#ifdef CONFIG_PPC_FSL_BOOK3E
+		/*
+		 * Increment next by the size of the huge mapping since
+		 * there may be more than one entry at this level for a
+		 * single hugepage, but all of them point to
+		 * the same kmem cache that holds the hugepte.
+		 */
+		next = addr + (1 << hugepd_shift(*(hugepd_t *)pmd));
+#endif
 		free_hugepd_range(tlb, (hugepd_t *)pmd, PMD_SHIFT,
 				  addr, next, floor, ceiling);
-	} while (pmd++, addr = next, addr != end);
+	} while (addr = next, addr != end);
 
 	start &= PUD_MASK;
 	if (start < floor)
@@ -487,8 +514,8 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
 	unsigned long start;
 
 	start = addr;
-	pud = pud_offset(pgd, addr);
 	do {
+		pud = pud_offset(pgd, addr);
 		next = pud_addr_end(addr, end);
 		if (!is_hugepd(pud)) {
 			if (pud_none_or_clear_bad(pud))
@@ -496,10 +523,19 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
 			hugetlb_free_pmd_range(tlb, pud, addr, next, floor,
 					       ceiling);
 		} else {
+#ifdef CONFIG_PPC_FSL_BOOK3E
+			/*
+			 * Increment next by the size of the huge mapping since
+			 * there may be more than one entry at this level for a
+			 * single hugepage, but all of them point to
+			 * the same kmem cache that holds the hugepte.
+			 */
+			next = addr + (1 << hugepd_shift(*(hugepd_t *)pud));
+#endif
 			free_hugepd_range(tlb, (hugepd_t *)pud, PUD_SHIFT,
 					  addr, next, floor, ceiling);
 		}
-	} while (pud++, addr = next, addr != end);
+	} while (addr = next, addr != end);
 
 	start &= PGDIR_MASK;
 	if (start < floor)
-- 
1.5.6.5
