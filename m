Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (E23SMTP01.au.ibm.com [202.81.18.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CA1D1DDED4
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 11:50:01 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id m851oHkq014130
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Sep 2008 11:50:17 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m851o0qv4407376
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Sep 2008 11:50:00 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m851o0Af031102
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Sep 2008 11:50:00 +1000
Date: Fri, 5 Sep 2008 11:49:54 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Cleanup hugepage pagetable allocation for powerpc with 16G pages
Message-ID: <20080905014954.GC7845@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Tollefson <kniht@linux.vnet.ibm.com>,
	libhugetlbfs-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There is a small bug in the handling of 16G hugepages recently added
to the kernel.  This doesn't cause a crash or other user-visible
problems, but it does mean that more levels of pagetable are allocated
than makes sense for 16G pages.  The hugepage pagetables for the 16G
pages are allocated much lower in the pagetable tree than they should
be, with the intervening levels allocated with full pmd and pud pages
which will only ever have one entry filled in.

This patch corrects this problem, at the same time cleaning up the
handling of which level 64k versus 16M hugepage pagetables are
allocated at.  The new way of formatting the tests should be more
robust against changes in pagetable structure, or any newly added
hugepage sizes.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
--- 

Paul, please apply for 2.6.28

Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2008-09-02 11:50:12.000000000 +1000
+++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2008-09-04 15:36:01.000000000 +1000
@@ -128,29 +128,37 @@ static int __hugepte_alloc(struct mm_str
 	return 0;
 }
 
-/* Base page size affects how we walk hugetlb page tables */
-#ifdef CONFIG_PPC_64K_PAGES
-#define hpmd_offset(pud, addr, h)	pmd_offset(pud, addr)
-#define hpmd_alloc(mm, pud, addr, h)	pmd_alloc(mm, pud, addr)
-#else
-static inline
-pmd_t *hpmd_offset(pud_t *pud, unsigned long addr, struct hstate *hstate)
+
+static pud_t *hpud_offset(pgd_t *pgd, unsigned long addr, struct hstate *hstate)
+{
+	if (huge_page_shift(hstate) < PUD_SHIFT)
+		return pud_offset(pgd, addr);
+	else
+		return (pud_t *) pgd;
+}
+static pud_t *hpud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long addr,
+			 struct hstate *hstate)
 {
-	if (huge_page_shift(hstate) == PAGE_SHIFT_64K)
+	if (huge_page_shift(hstate) < PUD_SHIFT)
+		return pud_alloc(mm, pgd, addr);
+	else
+		return (pud_t *) pgd;
+}
+static pmd_t *hpmd_offset(pud_t *pud, unsigned long addr, struct hstate *hstate)
+{
+	if (huge_page_shift(hstate) < PMD_SHIFT)
 		return pmd_offset(pud, addr);
 	else
 		return (pmd_t *) pud;
 }
-static inline
-pmd_t *hpmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long addr,
-		  struct hstate *hstate)
+static pmd_t *hpmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long addr,
+			 struct hstate *hstate)
 {
-	if (huge_page_shift(hstate) == PAGE_SHIFT_64K)
+	if (huge_page_shift(hstate) < PMD_SHIFT)
 		return pmd_alloc(mm, pud, addr);
 	else
 		return (pmd_t *) pud;
 }
-#endif
 
 /* Build list of addresses of gigantic pages.  This function is used in early
  * boot before the buddy or bootmem allocator is setup.
@@ -204,7 +212,7 @@ pte_t *huge_pte_offset(struct mm_struct 
 
 	pg = pgd_offset(mm, addr);
 	if (!pgd_none(*pg)) {
-		pu = pud_offset(pg, addr);
+		pu = hpud_offset(pg, addr, hstate);
 		if (!pud_none(*pu)) {
 			pm = hpmd_offset(pu, addr, hstate);
 			if (!pmd_none(*pm))
@@ -233,7 +241,7 @@ pte_t *huge_pte_alloc(struct mm_struct *
 	addr &= hstate->mask;
 
 	pg = pgd_offset(mm, addr);
-	pu = pud_alloc(mm, pg, addr);
+	pu = hpud_alloc(mm, pg, addr, hstate);
 
 	if (pu) {
 		pm = hpmd_alloc(mm, pu, addr, hstate);
@@ -316,13 +324,7 @@ static void hugetlb_free_pud_range(struc
 	pud = pud_offset(pgd, addr);
 	do {
 		next = pud_addr_end(addr, end);
-#ifdef CONFIG_PPC_64K_PAGES
-		if (pud_none_or_clear_bad(pud))
-			continue;
-		hugetlb_free_pmd_range(tlb, pud, addr, next, floor, ceiling,
-				       psize);
-#else
-		if (shift == PAGE_SHIFT_64K) {
+		if (shift < PMD_SHIFT) {
 			if (pud_none_or_clear_bad(pud))
 				continue;
 			hugetlb_free_pmd_range(tlb, pud, addr, next, floor,
@@ -332,7 +334,6 @@ static void hugetlb_free_pud_range(struc
 				continue;
 			free_hugepte_range(tlb, (hugepd_t *)pud, psize);
 		}
-#endif
 	} while (pud++, addr = next, addr != end);
 
 	start &= PGDIR_MASK;
@@ -422,9 +423,15 @@ void hugetlb_free_pgd_range(struct mmu_g
 		psize = get_slice_psize(tlb->mm, addr);
 		BUG_ON(!mmu_huge_psizes[psize]);
 		next = pgd_addr_end(addr, end);
-		if (pgd_none_or_clear_bad(pgd))
-			continue;
-		hugetlb_free_pud_range(tlb, pgd, addr, next, floor, ceiling);
+		if (mmu_psize_to_shift(psize) < PUD_SHIFT) {
+			if (pgd_none_or_clear_bad(pgd))
+				continue;
+			hugetlb_free_pud_range(tlb, pgd, addr, next, floor, ceiling);
+		} else {
+			if (pgd_none(*pgd))
+				continue;
+			free_hugepte_range(tlb, (hugepd_t *)pgd, psize);
+		}
 	} while (pgd++, addr = next, addr != end);
 }
 


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
