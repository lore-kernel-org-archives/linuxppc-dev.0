Return-Path: <dgibson@ozlabs.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [3/5] Allow more flexible layouts for hugepage pagetables
In-Reply-To: <20090928043902.GA6302@yookeroo.seuss>
Message-Id: <20090928044114.CF7BDB7BDA@ozlabs.org>
Date: Mon, 28 Sep 2009 14:41:14 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently each available hugepage size uses a slightly different
pagetable layout: that is, the bottem level table of pointers to
hugepages is a different size, and may branch off from the normal page
tables at a different level.  Every hugepage aware path that needs to
walk the pagetables must therefore look up the hugepage size from the
slice info first, and work out the correct way to walk the pagetables
accordingly.  Future hardware is likely to add more possible hugepage
sizes, more layout options and more mess.

This patch, therefore reworks the handling of hugepage pagetables to
reduce this complexity.  In the new scheme, instead of having to
consult the slice mask, pagetable walking code can check a flag in the
PGD/PUD/PMD entries to see where to branch off to hugepage pagetables,
and the entry also contains the information (eseentially hugepage
shift) necessary to then interpret that table without recourse to the
slice mask.  This scheme can be extended neatly to handle multiple
levels of self-describing "special" hugepage pagetables, although for
now we assume only one level exists.

This approach means that only the pagetable allocation path needs to
know how the pagetables should be set out.  All other (hugepage)
pagetable walking paths can just interpret the structure as they go.

There already was a flag bit in PGD/PUD/PMD entries for hugepage
directory pointers, but it was only used for debug.  We alter that
flag bit to instead be a 0 in the MSB to indicate a hugepage pagetable
pointer (normally it would be 1 since the pointer lies in the linear
mapping).  This means that asm pagetable walking can test for (and
punt on) hugepage pointers with the same test that checks for
unpopulated page directory entries (beq becomes bge), since hugepage
pointers will always be positive, and normal pointers always negative.

While we're at it, we get rid of the confusing (and grep defeating)
#defining of hugepte_shift to be the same thing as mmu_huge_psizes.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

---
 arch/powerpc/include/asm/hugetlb.h       |   12 
 arch/powerpc/include/asm/mmu-hash64.h    |   14 
 arch/powerpc/include/asm/pgtable-ppc64.h |   13 
 arch/powerpc/kernel/perf_callchain.c     |   20 -
 arch/powerpc/mm/gup.c                    |  149 +--------
 arch/powerpc/mm/hash_utils_64.c          |   17 -
 arch/powerpc/mm/hugetlbpage.c            |  473 ++++++++++++++-----------------
 arch/powerpc/mm/init_64.c                |   10 
 8 files changed, 302 insertions(+), 406 deletions(-)

Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2009-09-28 14:17:38.000000000 +1000
+++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2009-09-28 14:19:08.000000000 +1000
@@ -40,25 +40,11 @@ static unsigned nr_gpages;
 /* Array of valid huge page sizes - non-zero value(hugepte_shift) is
  * stored for the huge page sizes that are valid.
  */
-unsigned int mmu_huge_psizes[MMU_PAGE_COUNT] = { }; /* initialize all to 0 */
-
-#define hugepte_shift			mmu_huge_psizes
-#define HUGEPTE_INDEX_SIZE(psize)	(mmu_huge_psizes[(psize)])
-#define PTRS_PER_HUGEPTE(psize)		(1 << mmu_huge_psizes[psize])
-
-#define HUGEPD_SHIFT(psize)		(mmu_psize_to_shift(psize) \
-					 + HUGEPTE_INDEX_SIZE(psize))
-#define HUGEPD_SIZE(psize)		(1UL << HUGEPD_SHIFT(psize))
-#define HUGEPD_MASK(psize)		(~(HUGEPD_SIZE(psize)-1))
+static unsigned int mmu_huge_psizes[MMU_PAGE_COUNT] = { }; /* initialize all to 0 */
 
 /* Flag to mark huge PD pointers.  This means pmd_bad() and pud_bad()
  * will choke on pointers to hugepte tables, which is handy for
  * catching screwups early. */
-#define HUGEPD_OK	0x1
-
-typedef struct { unsigned long pd; } hugepd_t;
-
-#define hugepd_none(hpd)	((hpd).pd == 0)
 
 static inline int shift_to_mmu_psize(unsigned int shift)
 {
@@ -82,71 +68,126 @@ static inline unsigned int mmu_psize_to_
 	BUG();
 }
 
+#define hugepd_none(hpd)	((hpd).pd == 0)
+
 static inline pte_t *hugepd_page(hugepd_t hpd)
 {
-	BUG_ON(!(hpd.pd & HUGEPD_OK));
-	return (pte_t *)(hpd.pd & ~HUGEPD_OK);
+	BUG_ON(!hugepd_ok(hpd));
+	return (pte_t *)((hpd.pd & ~HUGEPD_SHIFT_MASK) | 0xc000000000000000);
 }
 
-static inline pte_t *hugepte_offset(hugepd_t *hpdp, unsigned long addr,
-				    struct hstate *hstate)
+static inline unsigned int hugepd_shift(hugepd_t hpd)
 {
-	unsigned int shift = huge_page_shift(hstate);
-	int psize = shift_to_mmu_psize(shift);
-	unsigned long idx = ((addr >> shift) & (PTRS_PER_HUGEPTE(psize)-1));
+	return hpd.pd & HUGEPD_SHIFT_MASK;
+}
+
+static inline pte_t *hugepte_offset(hugepd_t *hpdp, unsigned long addr, unsigned pdshift)
+{
+	unsigned long idx = (addr & ((1UL << pdshift) - 1)) >> hugepd_shift(*hpdp);
 	pte_t *dir = hugepd_page(*hpdp);
 
 	return dir + idx;
 }
 
+pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea, unsigned *shift)
+{
+	pgd_t *pg;
+	pud_t *pu;
+	pmd_t *pm;
+	hugepd_t *hpdp = NULL;
+	unsigned pdshift = PGDIR_SHIFT;
+
+	if (shift)
+		*shift = 0;
+
+	pg = pgdir + pgd_index(ea);
+	if (is_hugepd(pg)) {
+		hpdp = (hugepd_t *)pg;
+	} else if (!pgd_none(*pg)) {
+		pdshift = PUD_SHIFT;
+		pu = pud_offset(pg, ea);
+		if (is_hugepd(pu))
+			hpdp = (hugepd_t *)pu;
+		else if (!pud_none(*pu)) {
+			pdshift = PMD_SHIFT;
+			pm = pmd_offset(pu, ea);
+			if (is_hugepd(pm))
+				hpdp = (hugepd_t *)pm;
+			else if (!pmd_none(*pm)) {
+				return pte_offset_map(pm, ea);
+			}
+		}
+	}
+
+	if (!hpdp)
+		return NULL;
+
+	if (shift)
+		*shift = hugepd_shift(*hpdp);
+	return hugepte_offset(hpdp, ea, pdshift);
+}
+
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+{
+	return find_linux_pte_or_hugepte(mm->pgd, addr, NULL);
+}
+
 static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
-			   unsigned long address, unsigned int psize)
+			   unsigned long address, unsigned pdshift, unsigned pshift)
 {
-	pte_t *new = kmem_cache_zalloc(PGT_CACHE(hugepte_shift[psize]),
+	pte_t *new = kmem_cache_zalloc(PGT_CACHE(pdshift - pshift),
 				       GFP_KERNEL|__GFP_REPEAT);
 
+	BUG_ON(pshift > HUGEPD_SHIFT_MASK);
+	BUG_ON((unsigned long)new & HUGEPD_SHIFT_MASK);
+
 	if (! new)
 		return -ENOMEM;
 
 	spin_lock(&mm->page_table_lock);
 	if (!hugepd_none(*hpdp))
-		kmem_cache_free(PGT_CACHE(hugepte_shift[psize]), new);
+		kmem_cache_free(PGT_CACHE(pdshift - pshift), new);
 	else
-		hpdp->pd = (unsigned long)new | HUGEPD_OK;
+		hpdp->pd = ((unsigned long)new & ~0x8000000000000000) | pshift;
 	spin_unlock(&mm->page_table_lock);
 	return 0;
 }
 
-
-static pud_t *hpud_offset(pgd_t *pgd, unsigned long addr, struct hstate *hstate)
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
 {
-	if (huge_page_shift(hstate) < PUD_SHIFT)
-		return pud_offset(pgd, addr);
-	else
-		return (pud_t *) pgd;
-}
-static pud_t *hpud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long addr,
-			 struct hstate *hstate)
-{
-	if (huge_page_shift(hstate) < PUD_SHIFT)
-		return pud_alloc(mm, pgd, addr);
-	else
-		return (pud_t *) pgd;
-}
-static pmd_t *hpmd_offset(pud_t *pud, unsigned long addr, struct hstate *hstate)
-{
-	if (huge_page_shift(hstate) < PMD_SHIFT)
-		return pmd_offset(pud, addr);
-	else
-		return (pmd_t *) pud;
-}
-static pmd_t *hpmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long addr,
-			 struct hstate *hstate)
-{
-	if (huge_page_shift(hstate) < PMD_SHIFT)
-		return pmd_alloc(mm, pud, addr);
-	else
-		return (pmd_t *) pud;
+	pgd_t *pg;
+	pud_t *pu;
+	pmd_t *pm;
+	hugepd_t *hpdp = NULL;
+	unsigned pshift = __ffs(sz);
+	unsigned pdshift = PGDIR_SHIFT;
+
+	addr &= ~(sz-1);
+
+	pg = pgd_offset(mm, addr);
+	if (pshift >= PUD_SHIFT) {
+		hpdp = (hugepd_t *)pg;
+	} else {
+		pdshift = PUD_SHIFT;
+		pu = pud_alloc(mm, pg, addr);
+		if (pshift >= PMD_SHIFT) {
+			hpdp = (hugepd_t *)pu;
+		} else {
+			pdshift = PMD_SHIFT;
+			pm = pmd_alloc(mm, pu, addr);
+			hpdp = (hugepd_t *)pm;
+		}
+	}
+
+	if (!hpdp)
+		return NULL;
+
+	BUG_ON(!hugepd_none(*hpdp) && !hugepd_ok(*hpdp));
+
+	if (hugepd_none(*hpdp) && __hugepte_alloc(mm, hpdp, addr, pdshift, pshift))
+		return NULL;
+
+	return hugepte_offset(hpdp, addr, pdshift);
 }
 
 /* Build list of addresses of gigantic pages.  This function is used in early
@@ -180,92 +221,38 @@ int alloc_bootmem_huge_page(struct hstat
 	return 1;
 }
 
-
-/* Modelled after find_linux_pte() */
-pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
-{
-	pgd_t *pg;
-	pud_t *pu;
-	pmd_t *pm;
-
-	unsigned int psize;
-	unsigned int shift;
-	unsigned long sz;
-	struct hstate *hstate;
-	psize = get_slice_psize(mm, addr);
-	shift = mmu_psize_to_shift(psize);
-	sz = ((1UL) << shift);
-	hstate = size_to_hstate(sz);
-
-	addr &= hstate->mask;
-
-	pg = pgd_offset(mm, addr);
-	if (!pgd_none(*pg)) {
-		pu = hpud_offset(pg, addr, hstate);
-		if (!pud_none(*pu)) {
-			pm = hpmd_offset(pu, addr, hstate);
-			if (!pmd_none(*pm))
-				return hugepte_offset((hugepd_t *)pm, addr,
-						      hstate);
-		}
-	}
-
-	return NULL;
-}
-
-pte_t *huge_pte_alloc(struct mm_struct *mm,
-			unsigned long addr, unsigned long sz)
-{
-	pgd_t *pg;
-	pud_t *pu;
-	pmd_t *pm;
-	hugepd_t *hpdp = NULL;
-	struct hstate *hstate;
-	unsigned int psize;
-	hstate = size_to_hstate(sz);
-
-	psize = get_slice_psize(mm, addr);
-	BUG_ON(!mmu_huge_psizes[psize]);
-
-	addr &= hstate->mask;
-
-	pg = pgd_offset(mm, addr);
-	pu = hpud_alloc(mm, pg, addr, hstate);
-
-	if (pu) {
-		pm = hpmd_alloc(mm, pu, addr, hstate);
-		if (pm)
-			hpdp = (hugepd_t *)pm;
-	}
-
-	if (! hpdp)
-		return NULL;
-
-	if (hugepd_none(*hpdp) && __hugepte_alloc(mm, hpdp, addr, psize))
-		return NULL;
-
-	return hugepte_offset(hpdp, addr, hstate);
-}
-
 int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
 {
 	return 0;
 }
 
-static void free_hugepte_range(struct mmu_gather *tlb, hugepd_t *hpdp,
-			       unsigned int psize)
+static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshift,
+			      unsigned long start, unsigned long end,
+			      unsigned long floor, unsigned long ceiling)
 {
 	pte_t *hugepte = hugepd_page(*hpdp);
+	unsigned shift = hugepd_shift(*hpdp);
+	unsigned long pdmask = ~((1UL << pdshift) - 1);
+
+	start &= pdmask;
+	if (start < floor)
+		return;
+	if (ceiling) {
+		ceiling &= pdmask;
+		if (! ceiling)
+			return;
+	}
+	if (end - 1 > ceiling - 1)
+		return;
 
 	hpdp->pd = 0;
 	tlb->need_flush = 1;
-	pgtable_free_tlb(tlb, hugepte, hugepte_shift[psize]);
+	pgtable_free_tlb(tlb, hugepte, pdshift - shift);
 }
 
 static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 				   unsigned long addr, unsigned long end,
-				   unsigned long floor, unsigned long ceiling,
-				   unsigned int psize)
+				   unsigned long floor, unsigned long ceiling)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -277,7 +264,8 @@ static void hugetlb_free_pmd_range(struc
 		next = pmd_addr_end(addr, end);
 		if (pmd_none(*pmd))
 			continue;
-		free_hugepte_range(tlb, (hugepd_t *)pmd, psize);
+		free_hugepd_range(tlb, (hugepd_t *)pmd, PMD_SHIFT,
+				  addr, next, floor, ceiling);
 	} while (pmd++, addr = next, addr != end);
 
 	start &= PUD_MASK;
@@ -303,23 +291,19 @@ static void hugetlb_free_pud_range(struc
 	pud_t *pud;
 	unsigned long next;
 	unsigned long start;
-	unsigned int shift;
-	unsigned int psize = get_slice_psize(tlb->mm, addr);
-	shift = mmu_psize_to_shift(psize);
 
 	start = addr;
 	pud = pud_offset(pgd, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (shift < PMD_SHIFT) {
+		if (!is_hugepd(pud)) {
 			if (pud_none_or_clear_bad(pud))
 				continue;
 			hugetlb_free_pmd_range(tlb, pud, addr, next, floor,
-					       ceiling, psize);
+					       ceiling);
 		} else {
-			if (pud_none(*pud))
-				continue;
-			free_hugepte_range(tlb, (hugepd_t *)pud, psize);
+			free_hugepd_range(tlb, (hugepd_t *)pud, PUD_SHIFT,
+					  addr, next, floor, ceiling);
 		}
 	} while (pud++, addr = next, addr != end);
 
@@ -350,74 +334,34 @@ void hugetlb_free_pgd_range(struct mmu_g
 {
 	pgd_t *pgd;
 	unsigned long next;
-	unsigned long start;
 
 	/*
-	 * Comments below take from the normal free_pgd_range().  They
-	 * apply here too.  The tests against HUGEPD_MASK below are
-	 * essential, because we *don't* test for this at the bottom
-	 * level.  Without them we'll attempt to free a hugepte table
-	 * when we unmap just part of it, even if there are other
-	 * active mappings using it.
+	 * Because there are a number of different possible pagetable
+	 * layouts for hugepage ranges, we limit knowledge of how
+	 * things should be laid out to the allocation path
+	 * (huge_pte_alloc(), above).  Everything else works out the
+	 * structure as it goes from information in the hugepd
+	 * pointers.  That means that we can't here use the
+	 * optimization used in the normal page free_pgd_range(), of
+	 * checking whether we're actually covering a large enough
+	 * range to have to do anything at the top level of the walk
+	 * instead of at the bottom.
 	 *
-	 * The next few lines have given us lots of grief...
-	 *
-	 * Why are we testing HUGEPD* at this top level?  Because
-	 * often there will be no work to do at all, and we'd prefer
-	 * not to go all the way down to the bottom just to discover
-	 * that.
-	 *
-	 * Why all these "- 1"s?  Because 0 represents both the bottom
-	 * of the address space and the top of it (using -1 for the
-	 * top wouldn't help much: the masks would do the wrong thing).
-	 * The rule is that addr 0 and floor 0 refer to the bottom of
-	 * the address space, but end 0 and ceiling 0 refer to the top
-	 * Comparisons need to use "end - 1" and "ceiling - 1" (though
-	 * that end 0 case should be mythical).
-	 *
-	 * Wherever addr is brought up or ceiling brought down, we
-	 * must be careful to reject "the opposite 0" before it
-	 * confuses the subsequent tests.  But what about where end is
-	 * brought down by HUGEPD_SIZE below? no, end can't go down to
-	 * 0 there.
-	 *
-	 * Whereas we round start (addr) and ceiling down, by different
-	 * masks at different levels, in order to test whether a table
-	 * now has no other vmas using it, so can be freed, we don't
-	 * bother to round floor or end up - the tests don't need that.
+	 * To make sense of this, you should probably go read the big
+	 * block comment at the top of the normal free_pgd_range(),
+	 * too.
 	 */
-	unsigned int psize = get_slice_psize(tlb->mm, addr);
 
-	addr &= HUGEPD_MASK(psize);
-	if (addr < floor) {
-		addr += HUGEPD_SIZE(psize);
-		if (!addr)
-			return;
-	}
-	if (ceiling) {
-		ceiling &= HUGEPD_MASK(psize);
-		if (!ceiling)
-			return;
-	}
-	if (end - 1 > ceiling - 1)
-		end -= HUGEPD_SIZE(psize);
-	if (addr > end - 1)
-		return;
-
-	start = addr;
 	pgd = pgd_offset(tlb->mm, addr);
 	do {
-		psize = get_slice_psize(tlb->mm, addr);
-		BUG_ON(!mmu_huge_psizes[psize]);
 		next = pgd_addr_end(addr, end);
-		if (mmu_psize_to_shift(psize) < PUD_SHIFT) {
+		if (!is_hugepd(pgd)) {
 			if (pgd_none_or_clear_bad(pgd))
 				continue;
 			hugetlb_free_pud_range(tlb, pgd, addr, next, floor, ceiling);
 		} else {
-			if (pgd_none(*pgd))
-				continue;
-			free_hugepte_range(tlb, (hugepd_t *)pgd, psize);
+			free_hugepd_range(tlb, (hugepd_t *)pgd, PGDIR_SHIFT,
+					  addr, next, floor, ceiling);
 		}
 	} while (pgd++, addr = next, addr != end);
 }
@@ -448,19 +392,19 @@ follow_huge_addr(struct mm_struct *mm, u
 {
 	pte_t *ptep;
 	struct page *page;
-	unsigned int mmu_psize = get_slice_psize(mm, address);
+	unsigned shift;
+	unsigned long mask;
+
+	ptep = find_linux_pte_or_hugepte(mm->pgd, address, &shift);
 
 	/* Verify it is a huge page else bail. */
-	if (!mmu_huge_psizes[mmu_psize])
+	if (!ptep || !shift)
 		return ERR_PTR(-EINVAL);
 
-	ptep = huge_pte_offset(mm, address);
+	mask = (1UL << shift) - 1;
 	page = pte_page(*ptep);
-	if (page) {
-		unsigned int shift = mmu_psize_to_shift(mmu_psize);
-		unsigned long sz = ((1UL) << shift);
-		page += (address % sz) / PAGE_SIZE;
-	}
+	if (page)
+		page += (address & mask) / PAGE_SIZE;
 
 	return page;
 }
@@ -483,6 +427,73 @@ follow_huge_pmd(struct mm_struct *mm, un
 	return NULL;
 }
 
+static noinline int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
+		       unsigned long end, int write, struct page **pages, int *nr)
+{
+	unsigned long mask;
+	unsigned long pte_end;
+	struct page *head, *page;
+	pte_t pte;
+	int refs;
+
+	pte_end = (addr + sz) & ~(sz-1);
+	if (pte_end < end)
+		end = pte_end;
+
+	pte = *ptep;
+	mask = _PAGE_PRESENT | _PAGE_USER;
+	if (write)
+		mask |= _PAGE_RW;
+
+	if ((pte_val(pte) & mask) != mask)
+		return 0;
+
+	/* hugepages are never "special" */
+	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
+
+	refs = 0;
+	head = pte_page(pte);
+
+	page = head + ((addr & (sz-1)) >> PAGE_SHIFT);
+	do {
+		VM_BUG_ON(compound_head(page) != head);
+		pages[*nr] = page;
+		(*nr)++;
+		page++;
+		refs++;
+	} while (addr += PAGE_SIZE, addr != end);
+
+	if (!page_cache_add_speculative(head, refs)) {
+		*nr -= refs;
+		return 0;
+	}
+
+	if (unlikely(pte_val(pte) != pte_val(*ptep))) {
+		/* Could be optimized better */
+		while (*nr) {
+			put_page(page);
+			(*nr)--;
+		}
+	}
+
+	return 1;
+}
+
+int gup_hugepd(hugepd_t *hugepd, unsigned pdshift,
+	       unsigned long addr, unsigned long end,
+	       int write, struct page **pages, int *nr)
+{
+	pte_t *ptep;
+	unsigned long sz = 1UL << hugepd_shift(*hugepd);
+
+	ptep = hugepte_offset(hugepd, addr, pdshift);
+	do {
+		if (!gup_hugepte(ptep, sz, addr, end, write, pages, nr))
+			return 0;
+	} while (ptep++, addr += sz, addr != end);
+
+	return 1;
+}
 
 unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 					unsigned long len, unsigned long pgoff,
@@ -530,34 +541,20 @@ static unsigned int hash_huge_page_do_la
 	return rflags;
 }
 
-int hash_huge_page(struct mm_struct *mm, unsigned long access,
-		   unsigned long ea, unsigned long vsid, int local,
-		   unsigned long trap)
+int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
+		     pte_t *ptep, unsigned long trap, int local, int ssize,
+		     unsigned int shift, unsigned int mmu_psize)
 {
-	pte_t *ptep;
 	unsigned long old_pte, new_pte;
 	unsigned long va, rflags, pa, sz;
 	long slot;
 	int err = 1;
-	int ssize = user_segment_size(ea);
-	unsigned int mmu_psize;
-	int shift;
-	mmu_psize = get_slice_psize(mm, ea);
 
-	if (!mmu_huge_psizes[mmu_psize])
-		goto out;
-	ptep = huge_pte_offset(mm, ea);
+	BUG_ON(shift != mmu_psize_defs[mmu_psize].shift);
 
 	/* Search the Linux page table for a match with va */
 	va = hpt_va(ea, vsid, ssize);
 
-	/*
-	 * If no pte found or not present, send the problem up to
-	 * do_page_fault
-	 */
-	if (unlikely(!ptep || pte_none(*ptep)))
-		goto out;
-
 	/* 
 	 * Check the user's access rights to the page.  If access should be
 	 * prevented then send the problem up to do_page_fault.
@@ -588,7 +585,6 @@ int hash_huge_page(struct mm_struct *mm,
 	rflags = 0x2 | (!(new_pte & _PAGE_RW));
  	/* _PAGE_EXEC -> HW_NO_EXEC since it's inverted */
 	rflags |= ((new_pte & _PAGE_EXEC) ? 0 : HPTE_R_N);
-	shift = mmu_psize_to_shift(mmu_psize);
 	sz = ((1UL) << shift);
 	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
 		/* No CPU has hugepages but lacks no execute, so we
@@ -672,6 +668,8 @@ repeat:
 
 static void __init set_huge_psize(int psize)
 {
+	unsigned pdshift;
+
 	/* Check that it is a page size supported by the hardware and
 	 * that it fits within pagetable limits. */
 	if (mmu_psize_defs[psize].shift &&
@@ -686,29 +684,14 @@ static void __init set_huge_psize(int ps
 			return;
 		hugetlb_add_hstate(mmu_psize_defs[psize].shift - PAGE_SHIFT);
 
-		switch (mmu_psize_defs[psize].shift) {
-		case PAGE_SHIFT_64K:
-		    /* We only allow 64k hpages with 4k base page,
-		     * which was checked above, and always put them
-		     * at the PMD */
-		    hugepte_shift[psize] = PMD_SHIFT;
-		    break;
-		case PAGE_SHIFT_16M:
-		    /* 16M pages can be at two different levels
-		     * of pagestables based on base page size */
-		    if (PAGE_SHIFT == PAGE_SHIFT_64K)
-			    hugepte_shift[psize] = PMD_SHIFT;
-		    else /* 4k base page */
-			    hugepte_shift[psize] = PUD_SHIFT;
-		    break;
-		case PAGE_SHIFT_16G:
-		    /* 16G pages are always at PGD level */
-		    hugepte_shift[psize] = PGDIR_SHIFT;
-		    break;
-		}
-		hugepte_shift[psize] -= mmu_psize_defs[psize].shift;
-	} else
-		hugepte_shift[psize] = 0;
+		if (mmu_psize_defs[psize].shift < PMD_SHIFT)
+			pdshift = PMD_SHIFT;
+		else if (mmu_psize_defs[psize].shift < PUD_SHIFT)
+			pdshift = PUD_SHIFT;
+		else
+			pdshift = PGDIR_SHIFT;
+		mmu_huge_psizes[psize] = pdshift - mmu_psize_defs[psize].shift;
+	}
 }
 
 static int __init hugepage_setup_sz(char *str)
@@ -732,7 +715,7 @@ __setup("hugepagesz=", hugepage_setup_sz
 
 static int __init hugetlbpage_init(void)
 {
-	unsigned int psize;
+	int psize;
 
 	if (!cpu_has_feature(CPU_FTR_16M_PAGE))
 		return -ENODEV;
@@ -753,8 +736,8 @@ static int __init hugetlbpage_init(void)
 
 	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
 		if (mmu_huge_psizes[psize]) {
-			pgtable_cache_add(hugepte_shift[psize], NULL);
-			if (!PGT_CACHE(hugepte_shift[psize]))
+			pgtable_cache_add(mmu_huge_psizes[psize], NULL);
+			if (!PGT_CACHE(mmu_huge_psizes[psize]))
 				panic("hugetlbpage_init(): could not create "
 				      "pgtable cache for %d bit pagesize\n",
 				      mmu_psize_to_shift(psize));
Index: working-2.6/arch/powerpc/include/asm/hugetlb.h
===================================================================
--- working-2.6.orig/arch/powerpc/include/asm/hugetlb.h	2009-09-28 14:17:38.000000000 +1000
+++ working-2.6/arch/powerpc/include/asm/hugetlb.h	2009-09-28 14:19:08.000000000 +1000
@@ -3,6 +3,15 @@
 
 #include <asm/page.h>
 
+typedef struct { signed long pd; } hugepd_t;
+
+static inline int hugepd_ok(hugepd_t hpd)
+{
+	return (hpd.pd > 0);
+}
+
+#define is_hugepd(pdep)               (hugepd_ok(*((hugepd_t *)(pdep))))
+#define HUGEPD_SHIFT_MASK     0x3f
 
 int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 			   unsigned long len);
@@ -17,6 +26,9 @@ void set_huge_pte_at(struct mm_struct *m
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep);
 
+int gup_hugepd(hugepd_t *hugepd, unsigned pdshift, unsigned long addr,
+	       unsigned long end, int write, struct page **pages, int *nr);
+
 /*
  * The version of vma_mmu_pagesize() in arch/powerpc/mm/hugetlbpage.c needs
  * to override the version in mm/hugetlb.c
Index: working-2.6/arch/powerpc/mm/init_64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/init_64.c	2009-09-28 14:19:03.000000000 +1000
+++ working-2.6/arch/powerpc/mm/init_64.c	2009-09-28 14:19:08.000000000 +1000
@@ -41,6 +41,7 @@
 #include <linux/module.h>
 #include <linux/poison.h>
 #include <linux/lmb.h>
+#include <linux/hugetlb.h>
 
 #include <asm/pgalloc.h>
 #include <asm/page.h>
@@ -128,8 +129,13 @@ void pgtable_cache_add(unsigned shift, v
 	unsigned long align = table_size;
 	/* When batching pgtable pointers for RCU freeing, we store
 	 * the index size in the low bits.  Table alignment must be
-	 * big enough to fit it */
-	unsigned long minalign = MAX_PGTABLE_INDEX_SIZE + 1;
+	 * big enough to fit it.
+	 *
+	 * Likewise, hugeapge pagetable pointers contain a (different)
+	 * shift value in the low bits.  All tables must be aligned so
+	 * as to leave enough 0 bits in the address to contain it. */
+	unsigned long minalign = max(MAX_PGTABLE_INDEX_SIZE + 1,
+				     HUGEPD_SHIFT_MASK + 1);
 	struct kmem_cache *new;
 
 	/* It would be nice if this was a BUILD_BUG_ON(), but at the
Index: working-2.6/arch/powerpc/include/asm/pgtable-ppc64.h
===================================================================
--- working-2.6.orig/arch/powerpc/include/asm/pgtable-ppc64.h	2009-09-28 14:17:38.000000000 +1000
+++ working-2.6/arch/powerpc/include/asm/pgtable-ppc64.h	2009-09-28 14:19:08.000000000 +1000
@@ -379,7 +379,18 @@ void pgtable_cache_init(void);
 	return pt;
 }
 
-pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long address);
+#ifdef CONFIG_HUGETLB_PAGE
+pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
+				 unsigned *shift);
+#else
+static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
+					       unsigned *shift)
+{
+	if (shift)
+		*shift = 0;
+	return find_linux_pte(pgdir, ea);
+}
+#endif /* !CONFIG_HUGETLB_PAGE */
 
 #endif /* __ASSEMBLY__ */
 
Index: working-2.6/arch/powerpc/mm/gup.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/gup.c	2009-09-28 14:17:38.000000000 +1000
+++ working-2.6/arch/powerpc/mm/gup.c	2009-09-28 14:19:08.000000000 +1000
@@ -55,57 +55,6 @@ static noinline int gup_pte_range(pmd_t 
 	return 1;
 }
 
-#ifdef CONFIG_HUGETLB_PAGE
-static noinline int gup_huge_pte(pte_t *ptep, struct hstate *hstate,
-				 unsigned long *addr, unsigned long end,
-				 int write, struct page **pages, int *nr)
-{
-	unsigned long mask;
-	unsigned long pte_end;
-	struct page *head, *page;
-	pte_t pte;
-	int refs;
-
-	pte_end = (*addr + huge_page_size(hstate)) & huge_page_mask(hstate);
-	if (pte_end < end)
-		end = pte_end;
-
-	pte = *ptep;
-	mask = _PAGE_PRESENT|_PAGE_USER;
-	if (write)
-		mask |= _PAGE_RW;
-	if ((pte_val(pte) & mask) != mask)
-		return 0;
-	/* hugepages are never "special" */
-	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
-
-	refs = 0;
-	head = pte_page(pte);
-	page = head + ((*addr & ~huge_page_mask(hstate)) >> PAGE_SHIFT);
-	do {
-		VM_BUG_ON(compound_head(page) != head);
-		pages[*nr] = page;
-		(*nr)++;
-		page++;
-		refs++;
-	} while (*addr += PAGE_SIZE, *addr != end);
-
-	if (!page_cache_add_speculative(head, refs)) {
-		*nr -= refs;
-		return 0;
-	}
-	if (unlikely(pte_val(pte) != pte_val(*ptep))) {
-		/* Could be optimized better */
-		while (*nr) {
-			put_page(page);
-			(*nr)--;
-		}
-	}
-
-	return 1;
-}
-#endif /* CONFIG_HUGETLB_PAGE */
-
 static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 		int write, struct page **pages, int *nr)
 {
@@ -119,7 +68,11 @@ static int gup_pmd_range(pud_t pud, unsi
 		next = pmd_addr_end(addr, end);
 		if (pmd_none(pmd))
 			return 0;
-		if (!gup_pte_range(pmd, addr, next, write, pages, nr))
+		if (is_hugepd(pmdp)) {
+			if (!gup_hugepd((hugepd_t *)pmdp, PMD_SHIFT,
+					addr, next, write, pages, nr))
+				return 0;
+		} else if (!gup_pte_range(pmd, addr, next, write, pages, nr))
 			return 0;
 	} while (pmdp++, addr = next, addr != end);
 
@@ -139,7 +92,11 @@ static int gup_pud_range(pgd_t pgd, unsi
 		next = pud_addr_end(addr, end);
 		if (pud_none(pud))
 			return 0;
-		if (!gup_pmd_range(pud, addr, next, write, pages, nr))
+		if (is_hugepd(pudp)) {
+			if (!gup_hugepd((hugepd_t *)pudp, PUD_SHIFT,
+					addr, next, write, pages, nr))
+				return 0;
+		} else if (!gup_pmd_range(pud, addr, next, write, pages, nr))
 			return 0;
 	} while (pudp++, addr = next, addr != end);
 
@@ -154,10 +111,6 @@ int get_user_pages_fast(unsigned long st
 	unsigned long next;
 	pgd_t *pgdp;
 	int nr = 0;
-#ifdef CONFIG_PPC64
-	unsigned int shift;
-	int psize;
-#endif
 
 	pr_devel("%s(%lx,%x,%s)\n", __func__, start, nr_pages, write ? "write" : "read");
 
@@ -172,25 +125,6 @@ int get_user_pages_fast(unsigned long st
 
 	pr_devel("  aligned: %lx .. %lx\n", start, end);
 
-#ifdef CONFIG_HUGETLB_PAGE
-	/* We bail out on slice boundary crossing when hugetlb is
-	 * enabled in order to not have to deal with two different
-	 * page table formats
-	 */
-	if (addr < SLICE_LOW_TOP) {
-		if (end > SLICE_LOW_TOP)
-			goto slow_irqon;
-
-		if (unlikely(GET_LOW_SLICE_INDEX(addr) !=
-			     GET_LOW_SLICE_INDEX(end - 1)))
-			goto slow_irqon;
-	} else {
-		if (unlikely(GET_HIGH_SLICE_INDEX(addr) !=
-			     GET_HIGH_SLICE_INDEX(end - 1)))
-			goto slow_irqon;
-	}
-#endif /* CONFIG_HUGETLB_PAGE */
-
 	/*
 	 * XXX: batch / limit 'nr', to avoid large irq off latency
 	 * needs some instrumenting to determine the common sizes used by
@@ -210,54 +144,23 @@ int get_user_pages_fast(unsigned long st
 	 */
 	local_irq_disable();
 
-#ifdef CONFIG_PPC64
-	/* Those bits are related to hugetlbfs implementation and only exist
-	 * on 64-bit for now
-	 */
-	psize = get_slice_psize(mm, addr);
-	shift = mmu_psize_defs[psize].shift;
-#endif /* CONFIG_PPC64 */
-
-#ifdef CONFIG_HUGETLB_PAGE
-	if (unlikely(mmu_huge_psizes[psize])) {
-		pte_t *ptep;
-		unsigned long a = addr;
-		unsigned long sz = ((1UL) << shift);
-		struct hstate *hstate = size_to_hstate(sz);
-
-		BUG_ON(!hstate);
-		/*
-		 * XXX: could be optimized to avoid hstate
-		 * lookup entirely (just use shift)
-		 */
-
-		do {
-			VM_BUG_ON(shift != mmu_psize_defs[get_slice_psize(mm, a)].shift);
-			ptep = huge_pte_offset(mm, a);
-			pr_devel(" %016lx: huge ptep %p\n", a, ptep);
-			if (!ptep || !gup_huge_pte(ptep, hstate, &a, end, write, pages,
-						   &nr))
-				goto slow;
-		} while (a != end);
-	} else
-#endif /* CONFIG_HUGETLB_PAGE */
-	{
-		pgdp = pgd_offset(mm, addr);
-		do {
-			pgd_t pgd = *pgdp;
-
-#ifdef CONFIG_PPC64
-			VM_BUG_ON(shift != mmu_psize_defs[get_slice_psize(mm, addr)].shift);
-#endif
-			pr_devel("  %016lx: normal pgd %p\n", addr,
-				 (void *)pgd_val(pgd));
-			next = pgd_addr_end(addr, end);
-			if (pgd_none(pgd))
-				goto slow;
-			if (!gup_pud_range(pgd, addr, next, write, pages, &nr))
+	pgdp = pgd_offset(mm, addr);
+	do {
+		pgd_t pgd = *pgdp;
+
+		pr_devel("  %016lx: normal pgd %p\n", addr,
+			 (void *)pgd_val(pgd));
+		next = pgd_addr_end(addr, end);
+		if (pgd_none(pgd))
+			goto slow;
+		if (is_hugepd(pgdp)) {
+			if (!gup_hugepd((hugepd_t *)pgdp, PGDIR_SHIFT,
+					addr, next, write, pages, &nr))
 				goto slow;
-		} while (pgdp++, addr = next, addr != end);
-	}
+		} else if (!gup_pud_range(pgd, addr, next, write, pages, &nr))
+			goto slow;
+	} while (pgdp++, addr = next, addr != end);
+
 	local_irq_enable();
 
 	VM_BUG_ON(nr != (end - start) >> PAGE_SHIFT);
Index: working-2.6/arch/powerpc/kernel/perf_callchain.c
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/perf_callchain.c	2009-09-28 14:17:38.000000000 +1000
+++ working-2.6/arch/powerpc/kernel/perf_callchain.c	2009-09-28 14:19:08.000000000 +1000
@@ -119,13 +119,6 @@ static void perf_callchain_kernel(struct
 }
 
 #ifdef CONFIG_PPC64
-
-#ifdef CONFIG_HUGETLB_PAGE
-#define is_huge_psize(pagesize)	(HPAGE_SHIFT && mmu_huge_psizes[pagesize])
-#else
-#define is_huge_psize(pagesize)	0
-#endif
-
 /*
  * On 64-bit we don't want to invoke hash_page on user addresses from
  * interrupt context, so if the access faults, we read the page tables
@@ -135,7 +128,7 @@ static int read_user_stack_slow(void __u
 {
 	pgd_t *pgdir;
 	pte_t *ptep, pte;
-	int pagesize;
+	unsigned shift;
 	unsigned long addr = (unsigned long) ptr;
 	unsigned long offset;
 	unsigned long pfn;
@@ -145,17 +138,14 @@ static int read_user_stack_slow(void __u
 	if (!pgdir)
 		return -EFAULT;
 
-	pagesize = get_slice_psize(current->mm, addr);
+	ptep = find_linux_pte_or_hugepte(pgdir, addr, &shift);
+	if (!shift)
+		shift = PAGE_SHIFT;
 
 	/* align address to page boundary */
-	offset = addr & ((1ul << mmu_psize_defs[pagesize].shift) - 1);
+	offset = addr & ((1UL << shift) - 1);
 	addr -= offset;
 
-	if (is_huge_psize(pagesize))
-		ptep = huge_pte_offset(current->mm, addr);
-	else
-		ptep = find_linux_pte(pgdir, addr);
-
 	if (ptep == NULL)
 		return -EFAULT;
 	pte = *ptep;
Index: working-2.6/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hash_utils_64.c	2009-09-28 14:17:38.000000000 +1000
+++ working-2.6/arch/powerpc/mm/hash_utils_64.c	2009-09-28 14:19:08.000000000 +1000
@@ -891,6 +891,7 @@ int hash_page(unsigned long ea, unsigned
 	unsigned long vsid;
 	struct mm_struct *mm;
 	pte_t *ptep;
+	unsigned hugeshift;
 	const struct cpumask *tmp;
 	int rc, user_region = 0, local = 0;
 	int psize, ssize;
@@ -943,14 +944,6 @@ int hash_page(unsigned long ea, unsigned
 	if (user_region && cpumask_equal(mm_cpumask(mm), tmp))
 		local = 1;
 
-#ifdef CONFIG_HUGETLB_PAGE
-	/* Handle hugepage regions */
-	if (HPAGE_SHIFT && mmu_huge_psizes[psize]) {
-		DBG_LOW(" -> huge page !\n");
-		return hash_huge_page(mm, access, ea, vsid, local, trap);
-	}
-#endif /* CONFIG_HUGETLB_PAGE */
-
 #ifndef CONFIG_PPC_64K_PAGES
 	/* If we use 4K pages and our psize is not 4K, then we are hitting
 	 * a special driver mapping, we need to align the address before
@@ -961,12 +954,18 @@ int hash_page(unsigned long ea, unsigned
 #endif /* CONFIG_PPC_64K_PAGES */
 
 	/* Get PTE and page size from page tables */
-	ptep = find_linux_pte(pgdir, ea);
+	ptep = find_linux_pte_or_hugepte(pgdir, ea, &hugeshift);
 	if (ptep == NULL || !pte_present(*ptep)) {
 		DBG_LOW(" no PTE !\n");
 		return 1;
 	}
 
+#ifdef CONFIG_HUGETLB_PAGE
+	if (hugeshift)
+		return __hash_page_huge(ea, access, vsid, ptep, trap, local,
+					ssize, hugeshift, psize);
+#endif /* CONFIG_HUGETLB_PAGE */
+
 #ifndef CONFIG_PPC_64K_PAGES
 	DBG_LOW(" i-pte: %016lx\n", pte_val(*ptep));
 #else
Index: working-2.6/arch/powerpc/include/asm/mmu-hash64.h
===================================================================
--- working-2.6.orig/arch/powerpc/include/asm/mmu-hash64.h	2009-09-28 14:17:38.000000000 +1000
+++ working-2.6/arch/powerpc/include/asm/mmu-hash64.h	2009-09-28 14:19:08.000000000 +1000
@@ -173,14 +173,6 @@ extern unsigned long tce_alloc_start, tc
  */
 extern int mmu_ci_restrictions;
 
-#ifdef CONFIG_HUGETLB_PAGE
-/*
- * The page size indexes of the huge pages for use by hugetlbfs
- */
-extern unsigned int mmu_huge_psizes[MMU_PAGE_COUNT];
-
-#endif /* CONFIG_HUGETLB_PAGE */
-
 /*
  * This function sets the AVPN and L fields of the HPTE  appropriately
  * for the page size
@@ -254,9 +246,9 @@ extern int __hash_page_64K(unsigned long
 			   unsigned int local, int ssize);
 struct mm_struct;
 extern int hash_page(unsigned long ea, unsigned long access, unsigned long trap);
-extern int hash_huge_page(struct mm_struct *mm, unsigned long access,
-			  unsigned long ea, unsigned long vsid, int local,
-			  unsigned long trap);
+int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
+		     pte_t *ptep, unsigned long trap, int local, int ssize,
+		     unsigned int shift, unsigned int mmu_psize);
 
 extern int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 			     unsigned long pstart, unsigned long prot,
