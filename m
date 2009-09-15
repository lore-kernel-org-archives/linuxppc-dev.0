Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1C800B7B7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 16:43:11 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0148CDDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 16:43:11 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [2/5] Cleanup management of kmem_caches for pagetables
In-Reply-To: <20090915064133.GA11621@yookeroo.seuss>
Message-Id: <20090915064310.E3BF9B6F20@bilbo.ozlabs.org>
Date: Tue, 15 Sep 2009 16:43:10 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we have a fair bit of rather fiddly code to manage the
various kmem_caches used to store page tables of various levels.  We
generally have two caches holding some combination of PGD, PUD and PMD
tables, plus several more for the special hugepage pagetables.

This patch cleans this all up by taking a different approach.  Rather
than the caches being designated as for PUDs or for hugeptes for 16M
pages, the caches are simply allocated to be a specific size.  Thus
sharing of caches between different types/levels of pagetables happens
naturally.  The pagetable size, where needed, is passed around encoded
in the same way as {PGD,PUD,PMD}_INDEX_SIZE; that is n where the
pagetable contains 2^n pointers.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

---
 arch/powerpc/include/asm/pgalloc-64.h    |   51 +++++++++++++++----------------
 arch/powerpc/include/asm/pgalloc.h       |   30 ++----------------
 arch/powerpc/include/asm/pgtable-ppc64.h |    1 
 arch/powerpc/mm/hugetlbpage.c            |   45 +++++++--------------------
 arch/powerpc/mm/init_64.c                |   51 ++++++++++++++++++-------------
 arch/powerpc/mm/pgtable.c                |   25 +++++++++------
 6 files changed, 89 insertions(+), 114 deletions(-)

Index: working-2.6/arch/powerpc/mm/init_64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/init_64.c	2009-08-14 16:07:54.000000000 +1000
+++ working-2.6/arch/powerpc/mm/init_64.c	2009-09-15 16:03:27.000000000 +1000
@@ -148,30 +148,39 @@ static void pmd_ctor(void *addr)
 	memset(addr, 0, PMD_TABLE_SIZE);
 }
 
-static const unsigned int pgtable_cache_size[2] = {
-	PGD_TABLE_SIZE, PMD_TABLE_SIZE
-};
-static const char *pgtable_cache_name[ARRAY_SIZE(pgtable_cache_size)] = {
-#ifdef CONFIG_PPC_64K_PAGES
-	"pgd_cache", "pmd_cache",
-#else
-	"pgd_cache", "pud_pmd_cache",
-#endif /* CONFIG_PPC_64K_PAGES */
-};
-
-#ifdef CONFIG_HUGETLB_PAGE
-/* Hugepages need an extra cache per hugepagesize, initialized in
- * hugetlbpage.c.  We can't put into the tables above, because HPAGE_SHIFT
- * is not compile time constant. */
-struct kmem_cache *pgtable_cache[ARRAY_SIZE(pgtable_cache_size)+MMU_PAGE_COUNT];
-#else
-struct kmem_cache *pgtable_cache[ARRAY_SIZE(pgtable_cache_size)];
-#endif
+struct kmem_cache *pgtable_cache[MAX_PGTABLE_INDEX_SIZE];
+
+void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
+{
+	char *name;
+	unsigned long table_size = sizeof(void *) << shift;
+	unsigned long align = table_size;
+	/* When batching pgtable pointers for RCU freeing, we store
+	 * the index size in the low bits.  Table alignment must be
+	 * big enough to fit it */
+	unsigned long minalign = MAX_PGTABLE_INDEX_SIZE + 1;
+	struct kmem_cache *new;
+
+	BUILD_BUG_ON(!is_power_of_2(minalign));
+	BUG_ON((shift < 1) || (shift > MAX_PGTABLE_INDEX_SIZE));
+
+	if (PGT_CACHE(shift))
+		return; /* Already have a cache of this size */
+	align = max_t(unsigned long, align, minalign);
+	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
+	new = kmem_cache_create(name, table_size, table_size, 0, ctor);
+	PGT_CACHE(shift) = new;
+	pr_debug("Allocated pgtable cache for order %d\n", shift);
+}
+
 
 void pgtable_cache_init(void)
 {
-	pgtable_cache[0] = kmem_cache_create(pgtable_cache_name[0], PGD_TABLE_SIZE, PGD_TABLE_SIZE, SLAB_PANIC, pgd_ctor);
-	pgtable_cache[1] = kmem_cache_create(pgtable_cache_name[1], PMD_TABLE_SIZE, PMD_TABLE_SIZE, SLAB_PANIC, pmd_ctor);
+	pgtable_cache_add(PGD_INDEX_SIZE, pgd_ctor);
+	pgtable_cache_add(PMD_INDEX_SIZE, pmd_ctor);
+	if (!PGT_CACHE(PGD_INDEX_SIZE) || !PGT_CACHE(PMD_INDEX_SIZE))
+		panic("Couldn't allocate pgtable caches");
+	BUG_ON(PUD_INDEX_SIZE && !PGT_CACHE(PUD_INDEX_SIZE));
 }
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
Index: working-2.6/arch/powerpc/include/asm/pgalloc-64.h
===================================================================
--- working-2.6.orig/arch/powerpc/include/asm/pgalloc-64.h	2009-08-03 16:00:45.000000000 +1000
+++ working-2.6/arch/powerpc/include/asm/pgalloc-64.h	2009-09-15 15:45:49.000000000 +1000
@@ -11,27 +11,30 @@
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
 
+/*
+ * This needs to be big enough to allow any pagetable sizes we need,
+ * but small enough to fit in the low bits of any page table pointer.
+ * In other words all pagetables, even tiny ones, must be aligned to
+ * allow at least enough low 0 bits to contain this value.
+ */
+#define MAX_PGTABLE_INDEX_SIZE	0xf
+
 #ifndef CONFIG_PPC_SUBPAGE_PROT
 static inline void subpage_prot_free(pgd_t *pgd) {}
 #endif
 
 extern struct kmem_cache *pgtable_cache[];
-
-#define PGD_CACHE_NUM		0
-#define PUD_CACHE_NUM		1
-#define PMD_CACHE_NUM		1
-#define HUGEPTE_CACHE_NUM	2
-#define PTE_NONCACHE_NUM	7  /* from GFP rather than kmem_cache */
+#define PGT_CACHE(shift) (pgtable_cache[(shift)-1])
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return kmem_cache_alloc(pgtable_cache[PGD_CACHE_NUM], GFP_KERNEL);
+	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE), GFP_KERNEL);
 }
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
 	subpage_prot_free(pgd);
-	kmem_cache_free(pgtable_cache[PGD_CACHE_NUM], pgd);
+	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
 }
 
 #ifndef CONFIG_PPC_64K_PAGES
@@ -40,13 +43,13 @@ static inline void pgd_free(struct mm_st
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(pgtable_cache[PUD_CACHE_NUM],
+	return kmem_cache_alloc(PGT_CACHE(PUD_INDEX_SIZE),
 				GFP_KERNEL|__GFP_REPEAT);
 }
 
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 {
-	kmem_cache_free(pgtable_cache[PUD_CACHE_NUM], pud);
+	kmem_cache_free(PGT_CACHE(PUD_INDEX_SIZE), pud);
 }
 
 static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
@@ -78,13 +81,13 @@ static inline void pmd_populate_kernel(s
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(pgtable_cache[PMD_CACHE_NUM],
+	return kmem_cache_alloc(PGT_CACHE(PMD_INDEX_SIZE),
 				GFP_KERNEL|__GFP_REPEAT);
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
-	kmem_cache_free(pgtable_cache[PMD_CACHE_NUM], pmd);
+	kmem_cache_free(PGT_CACHE(PMD_INDEX_SIZE), pmd);
 }
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
@@ -107,24 +110,22 @@ static inline pgtable_t pte_alloc_one(st
 	return page;
 }
 
-static inline void pgtable_free(pgtable_free_t pgf)
+static inline void pgtable_free(void *table, unsigned index_size)
 {
-	void *p = (void *)(pgf.val & ~PGF_CACHENUM_MASK);
-	int cachenum = pgf.val & PGF_CACHENUM_MASK;
-
-	if (cachenum == PTE_NONCACHE_NUM)
-		free_page((unsigned long)p);
-	else
-		kmem_cache_free(pgtable_cache[cachenum], p);
+	if (!index_size)
+		free_page((unsigned long)table);
+	else {
+		BUG_ON(index_size > MAX_PGTABLE_INDEX_SIZE);
+		kmem_cache_free(PGT_CACHE(index_size), table);
+	}
 }
 
-#define __pmd_free_tlb(tlb, pmd,addr)		      \
-	pgtable_free_tlb(tlb, pgtable_free_cache(pmd, \
-		PMD_CACHE_NUM, PMD_TABLE_SIZE-1))
+#define __pmd_free_tlb(tlb, pmd, addr)		      \
+	pgtable_free_tlb(tlb, pmd, PMD_INDEX_SIZE)
 #ifndef CONFIG_PPC_64K_PAGES
 #define __pud_free_tlb(tlb, pud, addr)		      \
-	pgtable_free_tlb(tlb, pgtable_free_cache(pud, \
-		PUD_CACHE_NUM, PUD_TABLE_SIZE-1))
+	pgtable_free_tlb(tlb, pud, PUD_INDEX_SIZE)
+
 #endif /* CONFIG_PPC_64K_PAGES */
 
 #define check_pgt_cache()	do { } while (0)
Index: working-2.6/arch/powerpc/include/asm/pgalloc.h
===================================================================
--- working-2.6.orig/arch/powerpc/include/asm/pgalloc.h	2009-08-14 16:07:54.000000000 +1000
+++ working-2.6/arch/powerpc/include/asm/pgalloc.h	2009-09-15 15:44:24.000000000 +1000
@@ -24,25 +24,6 @@ static inline void pte_free(struct mm_st
 	__free_page(ptepage);
 }
 
-typedef struct pgtable_free {
-	unsigned long val;
-} pgtable_free_t;
-
-/* This needs to be big enough to allow for MMU_PAGE_COUNT + 2 to be stored
- * and small enough to fit in the low bits of any naturally aligned page
- * table cache entry. Arbitrarily set to 0x1f, that should give us some
- * room to grow
- */
-#define PGF_CACHENUM_MASK	0x1f
-
-static inline pgtable_free_t pgtable_free_cache(void *p, int cachenum,
-						unsigned long mask)
-{
-	BUG_ON(cachenum > PGF_CACHENUM_MASK);
-
-	return (pgtable_free_t){.val = ((unsigned long) p & ~mask) | cachenum};
-}
-
 #ifdef CONFIG_PPC64
 #include <asm/pgalloc-64.h>
 #else
@@ -50,12 +31,12 @@ static inline pgtable_free_t pgtable_fre
 #endif
 
 #ifdef CONFIG_SMP
-extern void pgtable_free_tlb(struct mmu_gather *tlb, pgtable_free_t pgf);
+extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, unsigned shift);
 extern void pte_free_finish(void);
 #else /* CONFIG_SMP */
-static inline void pgtable_free_tlb(struct mmu_gather *tlb, pgtable_free_t pgf)
+static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table, unsigned shift)
 {
-	pgtable_free(pgf);
+	pgtable_free(table, shift);
 }
 static inline void pte_free_finish(void) { }
 #endif /* !CONFIG_SMP */
@@ -63,12 +44,9 @@ static inline void pte_free_finish(void)
 static inline void __pte_free_tlb(struct mmu_gather *tlb, struct page *ptepage,
 				  unsigned long address)
 {
-	pgtable_free_t pgf = pgtable_free_cache(page_address(ptepage),
-						PTE_NONCACHE_NUM,
-						PTE_TABLE_SIZE-1);
 	tlb_flush_pgtable(tlb, address);
 	pgtable_page_dtor(ptepage);
-	pgtable_free_tlb(tlb, pgf);
+	pgtable_free_tlb(tlb, page_address(ptepage), 0);
 }
 
 #endif /* __KERNEL__ */
Index: working-2.6/arch/powerpc/mm/pgtable.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/pgtable.c	2009-08-28 13:46:31.000000000 +1000
+++ working-2.6/arch/powerpc/mm/pgtable.c	2009-09-15 15:52:32.000000000 +1000
@@ -47,12 +47,12 @@ struct pte_freelist_batch
 {
 	struct rcu_head	rcu;
 	unsigned int	index;
-	pgtable_free_t	tables[0];
+	unsigned long	tables[0];
 };
 
 #define PTE_FREELIST_SIZE \
 	((PAGE_SIZE - sizeof(struct pte_freelist_batch)) \
-	  / sizeof(pgtable_free_t))
+	  / sizeof(unsigned long))
 
 static void pte_free_smp_sync(void *arg)
 {
@@ -62,13 +62,13 @@ static void pte_free_smp_sync(void *arg)
 /* This is only called when we are critically out of memory
  * (and fail to get a page in pte_free_tlb).
  */
-static void pgtable_free_now(pgtable_free_t pgf)
+static void pgtable_free_now(void *table, unsigned shift)
 {
 	pte_freelist_forced_free++;
 
 	smp_call_function(pte_free_smp_sync, NULL, 1);
 
-	pgtable_free(pgf);
+	pgtable_free(table, shift);
 }
 
 static void pte_free_rcu_callback(struct rcu_head *head)
@@ -77,8 +77,12 @@ static void pte_free_rcu_callback(struct
 		container_of(head, struct pte_freelist_batch, rcu);
 	unsigned int i;
 
-	for (i = 0; i < batch->index; i++)
-		pgtable_free(batch->tables[i]);
+	for (i = 0; i < batch->index; i++) {
+		void *table = (void *)(batch->tables[i] & ~MAX_PGTABLE_INDEX_SIZE);
+		unsigned shift = batch->tables[i] & MAX_PGTABLE_INDEX_SIZE;
+
+		pgtable_free(table, shift);
+	}
 
 	free_page((unsigned long)batch);
 }
@@ -89,25 +93,28 @@ static void pte_free_submit(struct pte_f
 	call_rcu(&batch->rcu, pte_free_rcu_callback);
 }
 
-void pgtable_free_tlb(struct mmu_gather *tlb, pgtable_free_t pgf)
+void pgtable_free_tlb(struct mmu_gather *tlb, void *table, unsigned shift)
 {
 	/* This is safe since tlb_gather_mmu has disabled preemption */
 	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
+	unsigned long pgf;
 
 	if (atomic_read(&tlb->mm->mm_users) < 2 ||
 	    cpumask_equal(mm_cpumask(tlb->mm), cpumask_of(smp_processor_id()))){
-		pgtable_free(pgf);
+		pgtable_free(table, shift);
 		return;
 	}
 
 	if (*batchp == NULL) {
 		*batchp = (struct pte_freelist_batch *)__get_free_page(GFP_ATOMIC);
 		if (*batchp == NULL) {
-			pgtable_free_now(pgf);
+			pgtable_free_now(table, shift);
 			return;
 		}
 		(*batchp)->index = 0;
 	}
+	BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
+	pgf = (unsigned long)table | (shift - 1);
 	(*batchp)->tables[(*batchp)->index++] = pgf;
 	if ((*batchp)->index == PTE_FREELIST_SIZE) {
 		pte_free_submit(*batchp);
Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2009-09-15 15:44:24.000000000 +1000
+++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2009-09-15 16:03:08.000000000 +1000
@@ -43,26 +43,14 @@ static unsigned nr_gpages;
 unsigned int mmu_huge_psizes[MMU_PAGE_COUNT] = { }; /* initialize all to 0 */
 
 #define hugepte_shift			mmu_huge_psizes
-#define PTRS_PER_HUGEPTE(psize)		(1 << hugepte_shift[psize])
-#define HUGEPTE_TABLE_SIZE(psize)	(sizeof(pte_t) << hugepte_shift[psize])
+#define HUGEPTE_INDEX_SIZE(psize)	(mmu_huge_psizes[(psize)])
+#define PTRS_PER_HUGEPTE(psize)		(1 << mmu_huge_psizes[psize])
 
 #define HUGEPD_SHIFT(psize)		(mmu_psize_to_shift(psize) \
-						+ hugepte_shift[psize])
+					 + HUGEPTE_INDEX_SIZE(psize))
 #define HUGEPD_SIZE(psize)		(1UL << HUGEPD_SHIFT(psize))
 #define HUGEPD_MASK(psize)		(~(HUGEPD_SIZE(psize)-1))
 
-/* Subtract one from array size because we don't need a cache for 4K since
- * is not a huge page size */
-#define HUGE_PGTABLE_INDEX(psize)	(HUGEPTE_CACHE_NUM + psize - 1)
-#define HUGEPTE_CACHE_NAME(psize)	(huge_pgtable_cache_name[psize])
-
-static const char *huge_pgtable_cache_name[MMU_PAGE_COUNT] = {
-	[MMU_PAGE_64K]	= "hugepte_cache_64K",
-	[MMU_PAGE_1M]	= "hugepte_cache_1M",
-	[MMU_PAGE_16M]	= "hugepte_cache_16M",
-	[MMU_PAGE_16G]	= "hugepte_cache_16G",
-};
-
 /* Flag to mark huge PD pointers.  This means pmd_bad() and pud_bad()
  * will choke on pointers to hugepte tables, which is handy for
  * catching screwups early. */
@@ -114,15 +102,15 @@ static inline pte_t *hugepte_offset(huge
 static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 			   unsigned long address, unsigned int psize)
 {
-	pte_t *new = kmem_cache_zalloc(pgtable_cache[HUGE_PGTABLE_INDEX(psize)],
-				      GFP_KERNEL|__GFP_REPEAT);
+	pte_t *new = kmem_cache_zalloc(PGT_CACHE(hugepte_shift[psize]),
+				       GFP_KERNEL|__GFP_REPEAT);
 
 	if (! new)
 		return -ENOMEM;
 
 	spin_lock(&mm->page_table_lock);
 	if (!hugepd_none(*hpdp))
-		kmem_cache_free(pgtable_cache[HUGE_PGTABLE_INDEX(psize)], new);
+		kmem_cache_free(PGT_CACHE(hugepte_shift[psize]), new);
 	else
 		hpdp->pd = (unsigned long)new | HUGEPD_OK;
 	spin_unlock(&mm->page_table_lock);
@@ -271,9 +259,7 @@ static void free_hugepte_range(struct mm
 
 	hpdp->pd = 0;
 	tlb->need_flush = 1;
-	pgtable_free_tlb(tlb, pgtable_free_cache(hugepte,
-						 HUGEPTE_CACHE_NUM+psize-1,
-						 PGF_CACHENUM_MASK));
+	pgtable_free_tlb(tlb, hugepte, hugepte_shift[psize]);
 }
 
 static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
@@ -698,8 +684,6 @@ static void __init set_huge_psize(int ps
 		if (mmu_huge_psizes[psize] ||
 		   mmu_psize_defs[psize].shift == PAGE_SHIFT)
 			return;
-		if (WARN_ON(HUGEPTE_CACHE_NAME(psize) == NULL))
-			return;
 		hugetlb_add_hstate(mmu_psize_defs[psize].shift - PAGE_SHIFT);
 
 		switch (mmu_psize_defs[psize].shift) {
@@ -769,16 +753,11 @@ static int __init hugetlbpage_init(void)
 
 	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
 		if (mmu_huge_psizes[psize]) {
-			pgtable_cache[HUGE_PGTABLE_INDEX(psize)] =
-				kmem_cache_create(
-					HUGEPTE_CACHE_NAME(psize),
-					HUGEPTE_TABLE_SIZE(psize),
-					HUGEPTE_TABLE_SIZE(psize),
-					0,
-					NULL);
-			if (!pgtable_cache[HUGE_PGTABLE_INDEX(psize)])
-				panic("hugetlbpage_init(): could not create %s"\
-				      "\n", HUGEPTE_CACHE_NAME(psize));
+			pgtable_cache_add(hugepte_shift[psize], NULL);
+			if (!PGT_CACHE(hugepte_shift[psize]))
+				panic("hugetlbpage_init(): could not create "
+				      "pgtable cache for %d bit pagesize\n",
+				      mmu_psize_to_shift(psize));
 		}
 	}
 
Index: working-2.6/arch/powerpc/include/asm/pgtable-ppc64.h
===================================================================
--- working-2.6.orig/arch/powerpc/include/asm/pgtable-ppc64.h	2009-08-28 13:46:31.000000000 +1000
+++ working-2.6/arch/powerpc/include/asm/pgtable-ppc64.h	2009-09-15 16:03:07.000000000 +1000
@@ -354,6 +354,7 @@ static inline void __ptep_set_access_fla
 #define pgoff_to_pte(off)	((pte_t) {((off) << PTE_RPN_SHIFT)|_PAGE_FILE})
 #define PTE_FILE_MAX_BITS	(BITS_PER_LONG - PTE_RPN_SHIFT)
 
+void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
 
 /*
