Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DA4AC2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 02:58:27 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 22 May 2013 22:22:10 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D64A1E0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 22:30:55 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4MGwERp27721886
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 22:28:14 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4MGwKx7020666
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 02:58:21 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, dwg@au1.ibm.com
Subject: [PATCH -V9 14/20] powerpc: Make linux pagetable walk safe with THP
 enabled
Date: Wed, 22 May 2013 22:27:46 +0530
Message-Id: <1369241872-15700-15-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1369241872-15700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1369241872-15700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We need to have irqs disabled to handle all the possible parallel update for
linux page table without holding locks.

Events that we are intersted in while walking page tables are
1) Page fault
2) umap
3) THP split
4) THP collapse

A) local_irq_disabled:
------------------------
1) page fault:
A none to valid transition via page fault is not an issue because we
would either see a none or valid. If it is none, we would error out
the page table walk. We may need to use on stack values when checking for
type of page table elements, because if we do

if (!is_hugepd()) {
    if (!pmd_none() {
       if (pmd_bad() {

We could take that bad condition because the pmd got converted to a hugepd
after the !is_hugepd check via a hugetlb fault.

The right way would be to check for pmd_none higher up or use on stack value.

2) A valid to none conversion via unmap:
We can safely walk the upper level table, because we don't remove the the
page table entries until rcu grace period. So even if we followed a
wrong pointer we still have the pointer valid till the grace period.

A PTE pointer returned need to be atomically checked for _PAGE_PRESENT and
 _PAGE_BUSY. A valid pointer returned could becoming none later. To prevent
pte_clear we take _PAGE_BUSY.

3) THP split:
A valid transparent hugepage is converted to nomal page. Before we split we
do pmd_splitting_flush, which sets the hugepage PTE to _PAGE_SPLITTING
So when walking page table we need to check for pmd_trans_splitting and
handle that. The pte returned should also need to be checked for
_PAGE_SPLITTING before setting _PAGE_BUSY similar to _PAGE_PRESENT. We save
the value of PTE on stack and check for the flag in the local pte value.
If we don't have the value set we can safely operate on the local pte value
and we atomicaly set _PAGE_BUSY.

4) THP collapse:
A normal page gets converted to hugepage. In the collapse path, we
mark the pmd none early (pmdp_clear_flush). With irq disabled, if we
are aleady walking page table we would see the pmd_none and won't continue.
If we see a valid PMD, we should still check for _PAGE_PRESENT before
setting _PAGE_BUSY, to make sure we didn't collapse the PTE to a Huge PTE.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c   | 27 ++++++++-------
 arch/powerpc/mm/hugepage-hash64.c |  3 ++
 arch/powerpc/mm/hugetlbpage.c     | 72 +++++++++++++++++++++++++--------------
 arch/powerpc/mm/mem.c             |  4 +++
 4 files changed, 68 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index aad140b..67b2dbd 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1180,13 +1180,25 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	pgdir = mm->pgd;
 	if (pgdir == NULL)
 		return;
+
+	/* Get VSID */
+	ssize = user_segment_size(ea);
+	vsid = get_vsid(mm->context.id, ea, ssize);
+	if (!vsid)
+		return;
+	/*
+	 * Hash doesn't like irqs. Walking linux page table with irq disabled
+	 * saves us from holding multiple locks.
+	 */
+	local_irq_save(flags);
+
 	/*
 	 * THP pages use update_mmu_cache_pmd. We don't do
 	 * hash preload there. Hence can ignore THP here
 	 */
 	ptep = find_linux_pte_or_hugepte(pgdir, ea, &shift);
 	if (!ptep)
-		return;
+		goto out_exit;
 
 	BUG_ON(shift);
 #ifdef CONFIG_PPC_64K_PAGES
@@ -1197,18 +1209,9 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	 * page size demotion here
 	 */
 	if (pte_val(*ptep) & (_PAGE_4K_PFN | _PAGE_NO_CACHE))
-		return;
+		goto out_exit;
 #endif /* CONFIG_PPC_64K_PAGES */
 
-	/* Get VSID */
-	ssize = user_segment_size(ea);
-	vsid = get_vsid(mm->context.id, ea, ssize);
-	if (!vsid)
-		return;
-
-	/* Hash doesn't like irqs */
-	local_irq_save(flags);
-
 	/* Is that local to this CPU ? */
 	if (cpumask_equal(mm_cpumask(mm), cpumask_of(smp_processor_id())))
 		local = 1;
@@ -1230,7 +1233,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 				   mm->context.user_psize,
 				   mm->context.user_psize,
 				   pte_val(*ptep));
-
+out_exit:
 	local_irq_restore(flags);
 }
 
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 3712e80..e430766 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -37,6 +37,9 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		/* If PMD busy, retry the access */
 		if (unlikely(old_pmd & _PAGE_BUSY))
 			return 0;
+		/* If PMD is trans splitting retry the access */
+		if (unlikely(old_pmd & _PAGE_SPLITTING))
+			return 0;
 		/* If PMD permissions don't match, take page fault */
 		if (unlikely(access & ~old_pmd))
 			return 1;
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 8add580..e9e6882 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -925,12 +925,16 @@ void flush_dcache_icache_hugepage(struct page *page)
  * (2) pointer to next table, as normal; bottom 6 bits == 0
  * (3) leaf pte for huge page, bottom two bits != 00
  * (4) hugepd pointer, bottom two bits == 00, next 4 bits indicate size of table
+ *
+ * So long as we atomically load page table pointers we are safe against teardown,
+ * we can follow the address down to the the page and take a ref on it.
  */
+
 pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea, unsigned *shift)
 {
-	pgd_t *pg;
-	pud_t *pu;
-	pmd_t *pm;
+	pgd_t pgd, *pgdp;
+	pud_t pud, *pudp;
+	pmd_t pmd, *pmdp;
 	pte_t *ret_pte;
 	hugepd_t *hpdp = NULL;
 	unsigned pdshift = PGDIR_SHIFT;
@@ -938,34 +942,42 @@ pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea, unsigned *shift
 	if (shift)
 		*shift = 0;
 
-	pg = pgdir + pgd_index(ea);
-
+	pgdp = pgdir + pgd_index(ea);
+	pgd  = ACCESS_ONCE(*pgdp);
 	/*
-	 * we should first check for none. That takes care of a
-	 * a parallel hugetlb or THP pagefault moving none entries
-	 * to respective types.
+	 * Always operate on the local stack value. This make sure the
+	 * value don't get updated by a parallel THP split/collapse,
+	 * page fault or a page unmap. The return pte_t * is still not
+	 * stable. So should be checked there for above conditions.
 	 */
-	if (pgd_none(*pg))
+	if (pgd_none(pgd))
 		return NULL;
-	else if (pgd_huge(*pg)) {
-		ret_pte = (pte_t *) pg;
+	else if (pgd_huge(pgd)) {
+		ret_pte = (pte_t *) pgdp;
 		goto out;
-	} else if (is_hugepd(pg))
-		hpdp = (hugepd_t *)pg;
+	} else if (is_hugepd(&pgd))
+		hpdp = (hugepd_t *)&pgd;
 	else {
+		/*
+		 * Even if we end up with an unmap, the pgtable will not
+		 * be freed, because we do an rcu free and here we are
+		 * irq disabled
+		 */
 		pdshift = PUD_SHIFT;
-		pu = pud_offset(pg, ea);
+		pudp = pud_offset(&pgd, ea);
+		pud  = ACCESS_ONCE(*pudp);
 
-		if (pud_none(*pu))
+		if (pud_none(pud))
 			return NULL;
-		else if (pud_huge(*pu)) {
-			ret_pte = (pte_t *) pu;
+		else if (pud_huge(pud)) {
+			ret_pte = (pte_t *) pudp;
 			goto out;
-		} else if (is_hugepd(pu))
-			hpdp = (hugepd_t *)pu;
+		} else if (is_hugepd(&pud))
+			hpdp = (hugepd_t *)&pud;
 		else {
 			pdshift = PMD_SHIFT;
-			pm = pmd_offset(pu, ea);
+			pmdp = pmd_offset(&pud, ea);
+			pmd  = ACCESS_ONCE(*pmdp);
 			/*
 			 * A hugepage collapse is captured by pmd_none, because
 			 * it mark the pmd none and do a hpte invalidate.
@@ -975,16 +987,16 @@ pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea, unsigned *shift
 			 * hpte invalidate
 			 *
 			 */
-			if (pmd_none(*pm) || pmd_trans_splitting(*pm))
+			if (pmd_none(pmd) || pmd_trans_splitting(pmd))
 				return NULL;
 
-			if (pmd_huge(*pm) || pmd_large(*pm)) {
-				ret_pte = (pte_t *) pm;
+			if (pmd_huge(pmd) || pmd_large(pmd)) {
+				ret_pte = (pte_t *) pmdp;
 				goto out;
-			} else if (is_hugepd(pm))
-				hpdp = (hugepd_t *)pm;
+			} else if (is_hugepd(&pmd))
+				hpdp = (hugepd_t *)&pmd;
 			else
-				return pte_offset_kernel(pm, ea);
+				return pte_offset_kernel(&pmd, ea);
 		}
 	}
 	if (!hpdp)
@@ -1020,6 +1032,14 @@ int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	if ((pte_val(pte) & mask) != mask)
 		return 0;
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	/*
+	 * check for splitting here
+	 */
+	if (pmd_trans_splitting(pte_pmd(pte)))
+		return 0;
+#endif
+
 	/* hugepages are never "special" */
 	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 0988a26..ccd49f9 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -508,6 +508,10 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 		      pte_t *ptep)
 {
 #ifdef CONFIG_PPC_STD_MMU
+	/*
+	 * We don't need to worry about _PAGE_PRESENT here because we are
+	 * called with either mm->page_table_lock held or ptl lock held
+	 */
 	unsigned long access = 0, trap;
 
 	/* We only want HPTEs for linux PTEs that have _PAGE_ACCESSED set */
-- 
1.8.1.2
