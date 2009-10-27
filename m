Return-Path: <dgibson@ozlabs.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [6/6] Bring hugepage PTE accessor functions back into sync with
	normal accessors
In-Reply-To: <20091027052258.GD20694@yookeroo.seuss>
Message-Id: <20091027052431.DA1C5B7C0D@ozlabs.org>
Date: Tue, 27 Oct 2009 16:24:31 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hugepage arch code provides a number of hook functions/macros
which mirror the functionality of various normal page pte access
functions.  Various changes in the normal page accessors (in
particular BenH's recent changes to the handling of lazy icache
flushing and PAGE_EXEC) have caused the hugepage versions to get out
of sync with the originals.  In some cases, this is a bug, at least on
some MMU types.

One of the reasons that some hooks were not identical to the normal
page versions, is that the fact we're dealing with a hugepage needed
to be passed down do use the correct dcache-icache flush function.
This patch makes the main flush_dcache_icache_page() function hugepage
aware (by checking for the PageCompound flag).  That in turn means we
can make set_huge_pte_at() just a call to set_pte_at() bringing it
back into sync.  As a bonus, this lets us remove the
hash_huge_page_do_lazy_icache() function, replacing it with a call to
the hash_page_do_lazy_icache() function it was based on.

Some other hugepage pte access hooks - huge_ptep_get_and_clear() and
huge_ptep_clear_flush() - are not so easily unified, but this patch at
least brings them back into sync with the current versions of the
corresponding normal page functions.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

---
 arch/powerpc/include/asm/hugetlb.h    |   25 +++++++++++++++++++------
 arch/powerpc/include/asm/mmu-hash64.h |    1 +
 arch/powerpc/mm/hash_utils_64.c       |    2 +-
 arch/powerpc/mm/hugetlbpage-hash64.c  |   30 +-----------------------------
 arch/powerpc/mm/hugetlbpage.c         |   31 ++++++++++---------------------
 arch/powerpc/mm/mem.c                 |   17 +++++++++++++----
 6 files changed, 45 insertions(+), 61 deletions(-)

Index: working-2.6/arch/powerpc/include/asm/hugetlb.h
===================================================================
--- working-2.6.orig/arch/powerpc/include/asm/hugetlb.h	2009-10-27 14:50:34.000000000 +1100
+++ working-2.6/arch/powerpc/include/asm/hugetlb.h	2009-10-27 14:56:31.000000000 +1100
@@ -6,6 +6,8 @@
 pte_t *huge_pte_offset_and_shift(struct mm_struct *mm,
 				 unsigned long addr, unsigned *shift);
 
+void flush_dcache_icache_hugepage(struct page *page);
+
 int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 			   unsigned long len);
 
@@ -13,12 +15,6 @@ void hugetlb_free_pgd_range(struct mmu_g
 			    unsigned long end, unsigned long floor,
 			    unsigned long ceiling);
 
-void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-		     pte_t *ptep, pte_t pte);
-
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep);
-
 /*
  * The version of vma_mmu_pagesize() in arch/powerpc/mm/hugetlbpage.c needs
  * to override the version in mm/hugetlb.c
@@ -44,9 +40,26 @@ static inline void hugetlb_prefault_arch
 {
 }
 
+
+static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+				   pte_t *ptep, pte_t pte)
+{
+	set_pte_at(mm, addr, ptep, pte);
+}
+
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep)
+{
+	unsigned long old = pte_update(mm, addr, ptep, ~0UL, 1);
+	return __pte(old);
+}
+
 static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 					 unsigned long addr, pte_t *ptep)
 {
+	pte_t pte;
+	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	flush_tlb_page(vma, addr);
 }
 
 static inline int huge_pte_none(pte_t pte)
Index: working-2.6/arch/powerpc/include/asm/mmu-hash64.h
===================================================================
--- working-2.6.orig/arch/powerpc/include/asm/mmu-hash64.h	2009-10-27 14:36:36.000000000 +1100
+++ working-2.6/arch/powerpc/include/asm/mmu-hash64.h	2009-10-27 14:55:22.000000000 +1100
@@ -245,6 +245,7 @@ extern int __hash_page_64K(unsigned long
 			   unsigned long vsid, pte_t *ptep, unsigned long trap,
 			   unsigned int local, int ssize);
 struct mm_struct;
+unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap);
 extern int hash_page(unsigned long ea, unsigned long access, unsigned long trap);
 int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		     pte_t *ptep, unsigned long trap, int local, int ssize,
Index: working-2.6/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hash_utils_64.c	2009-10-27 14:42:47.000000000 +1100
+++ working-2.6/arch/powerpc/mm/hash_utils_64.c	2009-10-27 14:55:22.000000000 +1100
@@ -775,7 +775,7 @@ unsigned int hash_page_do_lazy_icache(un
 	/* page is dirty */
 	if (!test_bit(PG_arch_1, &page->flags) && !PageReserved(page)) {
 		if (trap == 0x400) {
-			__flush_dcache_icache(page_address(page));
+			flush_dcache_icache_page(page);
 			set_bit(PG_arch_1, &page->flags);
 		} else
 			pp |= HPTE_R_N;
Index: working-2.6/arch/powerpc/mm/hugetlbpage-hash64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage-hash64.c	2009-10-27 14:50:34.000000000 +1100
+++ working-2.6/arch/powerpc/mm/hugetlbpage-hash64.c	2009-10-27 14:55:22.000000000 +1100
@@ -14,33 +14,6 @@
 #include <asm/cacheflush.h>
 #include <asm/machdep.h>
 
-/*
- * Called by asm hashtable.S for doing lazy icache flush
- */
-static unsigned int hash_huge_page_do_lazy_icache(unsigned long rflags,
-					pte_t pte, int trap, unsigned long sz)
-{
-	struct page *page;
-	int i;
-
-	if (!pfn_valid(pte_pfn(pte)))
-		return rflags;
-
-	page = pte_page(pte);
-
-	/* page is dirty */
-	if (!test_bit(PG_arch_1, &page->flags) && !PageReserved(page)) {
-		if (trap == 0x400) {
-			for (i = 0; i < (sz / PAGE_SIZE); i++)
-				__flush_dcache_icache(page_address(page+i));
-			set_bit(PG_arch_1, &page->flags);
-		} else {
-			rflags |= HPTE_R_N;
-		}
-	}
-	return rflags;
-}
-
 int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		     pte_t *ptep, unsigned long trap, int local, int ssize,
 		     unsigned int shift, unsigned int mmu_psize)
@@ -89,8 +62,7 @@ int __hash_page_huge(unsigned long ea, u
 	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
 		/* No CPU has hugepages but lacks no execute, so we
 		 * don't need to worry about that case */
-		rflags = hash_huge_page_do_lazy_icache(rflags, __pte(old_pte),
-						       trap, sz);
+		rflags = hash_page_do_lazy_icache(rflags, __pte(old_pte), trap);
 
 	/* Check if pte already has an hpte (case 2) */
 	if (unlikely(old_pte & _PAGE_HASHPTE)) {
Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2009-10-27 14:50:34.000000000 +1100
+++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2009-10-27 14:55:22.000000000 +1100
@@ -344,27 +344,6 @@ void hugetlb_free_pgd_range(struct mmu_g
 	} while (pgd++, addr = next, addr != end);
 }
 
-void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-		     pte_t *ptep, pte_t pte)
-{
-	if (pte_present(*ptep)) {
-		/* We open-code pte_clear because we need to pass the right
-		 * argument to hpte_need_flush (huge / !huge). Might not be
-		 * necessary anymore if we make hpte_need_flush() get the
-		 * page size from the slices
-		 */
-		pte_update(mm, addr, ptep, ~0UL, 1);
-	}
-	*ptep = __pte(pte_val(pte) & ~_PAGE_HPTEFLAGS);
-}
-
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep)
-{
-	unsigned long old = pte_update(mm, addr, ptep, ~0UL, 1);
-	return __pte(old);
-}
-
 struct page *
 follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
 {
@@ -580,3 +559,13 @@ static int __init hugetlbpage_init(void)
 	return 0;
 }
 module_init(hugetlbpage_init);
+
+void flush_dcache_icache_hugepage(struct page *page)
+{
+	int i;
+
+	BUG_ON(!PageCompound(page));
+
+	for (i = 0; i < (1UL << compound_order(page)); i++)
+		__flush_dcache_icache(page_address(page+i));
+}
Index: working-2.6/arch/powerpc/mm/mem.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/mem.c	2009-10-27 12:52:00.000000000 +1100
+++ working-2.6/arch/powerpc/mm/mem.c	2009-10-27 14:55:22.000000000 +1100
@@ -32,6 +32,7 @@
 #include <linux/pagemap.h>
 #include <linux/suspend.h>
 #include <linux/lmb.h>
+#include <linux/hugetlb.h>
 
 #include <asm/pgalloc.h>
 #include <asm/prom.h>
@@ -417,18 +418,26 @@ EXPORT_SYMBOL(flush_dcache_page);
 
 void flush_dcache_icache_page(struct page *page)
 {
+#ifdef CONFIG_HUGETLB_PAGE
+	if (PageCompound(page)) {
+		flush_dcache_icache_hugepage(page);
+		return;
+	}
+#endif
 #ifdef CONFIG_BOOKE
-	void *start = kmap_atomic(page, KM_PPC_SYNC_ICACHE);
-	__flush_dcache_icache(start);
-	kunmap_atomic(start, KM_PPC_SYNC_ICACHE);
+	{
+		void *start = kmap_atomic(page, KM_PPC_SYNC_ICACHE);
+		__flush_dcache_icache(start);
+		kunmap_atomic(start, KM_PPC_SYNC_ICACHE);
+	}
 #elif defined(CONFIG_8xx) || defined(CONFIG_PPC64)
 	/* On 8xx there is no need to kmap since highmem is not supported */
 	__flush_dcache_icache(page_address(page)); 
 #else
 	__flush_dcache_icache_phys(page_to_pfn(page) << PAGE_SHIFT);
 #endif
-
 }
+
 void clear_user_page(void *page, unsigned long vaddr, struct page *pg)
 {
 	clear_page(page);
