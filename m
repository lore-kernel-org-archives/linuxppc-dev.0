Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 65CDAB7B6D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Sep 2009 17:16:06 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4B143DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Sep 2009 17:16:06 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [3/3] Allow more flexible layouts for hugepage pagetables
In-Reply-To: <20090904071445.GD20631@yookeroo.seuss>
Message-Id: <20090904071543.20DCBB7B68@bilbo.ozlabs.org>
Date: Fri,  4 Sep 2009 17:15:43 +1000 (EST)
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
 arch/powerpc/include/asm/hugetlb.h |    9 
 arch/powerpc/mm/hugetlbpage.c      |  396 +++++++++++++++----------------------
 arch/powerpc/mm/init_64.c          |   11 -
 3 files changed, 181 insertions(+), 235 deletions(-)

Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2009-09-04 14:38:20.000000000 +1000
+++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2009-09-04 16:21:49.000000000 +1000
@@ -42,23 +42,9 @@ static unsigned nr_gpages;
  */
 unsigned int mmu_huge_psizes[MMU_PAGE_COUNT] = { }; /* initialize all to 0 */
 
-#define hugepte_shift			mmu_huge_psizes
-#define HUGEPTE_INDEX_SIZE(psize)	(mmu_huge_psizes[(psize)])
-#define PTRS_PER_HUGEPTE(psize)		(1 << mmu_huge_psizes[psize])
-
-#define HUGEPD_SHIFT(psize)		(mmu_psize_to_shift(psize) \
-					 + HUGEPTE_INDEX_SIZE(psize))
-#define HUGEPD_SIZE(psize)		(1UL << HUGEPD_SHIFT(psize))
-#define HUGEPD_MASK(psize)		(~(HUGEPD_SIZE(psize)-1))
-
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
@@ -82,71 +68,127 @@ static inline unsigned int mmu_psize_to_
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
+}
+
+static inline unsigned int hugepd_shift(hugepd_t hpd)
+{
+	return hpd.pd & HUGEPD_SHIFT_MASK;
 }
 
-static inline pte_t *hugepte_offset(hugepd_t *hpdp, unsigned long addr,
-				    struct hstate *hstate)
+static inline pte_t *hugepte_offset(hugepd_t *hpdp, unsigned long addr, unsigned pdshift)
 {
-	unsigned int shift = huge_page_shift(hstate);
-	int psize = shift_to_mmu_psize(shift);
-	unsigned long idx = ((addr >> shift) & (PTRS_PER_HUGEPTE(psize)-1));
+	unsigned long idx = (addr & ((1UL << pdshift) - 1)) >> hugepd_shift(*hpdp);
 	pte_t *dir = hugepd_page(*hpdp);
 
 	return dir + idx;
 }
 
+static pte_t *huge_pte_offset_and_shift(struct mm_struct *mm,
+					unsigned long addr, unsigned *shift)
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
+	pg = pgd_offset(mm, addr);
+	if (is_hugepd(pg)) {
+		hpdp = (hugepd_t *)pg;
+	} else if (!pgd_none(*pg)) {
+		pdshift = PUD_SHIFT;
+		pu = pud_offset(pg, addr);
+		if (is_hugepd(pu))
+			hpdp = (hugepd_t *)pu;
+		else if (!pud_none(*pu)) {
+			pdshift = PMD_SHIFT;
+			pm = pmd_offset(pu, addr);
+			if (is_hugepd(pm))
+				hpdp = (hugepd_t *)pm;
+			else if (!pmd_none(*pm)) {
+				return pte_offset_map(pm, addr);
+			}
+		}
+	}
+
+	if (!hpdp)
+		return NULL;
+
+	if (shift)
+		*shift = hugepd_shift(*hpdp);
+	return hugepte_offset(hpdp, addr, pdshift);
+}
+
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+{
+	return huge_pte_offset_and_shift(mm, addr, NULL);
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
-{
-	if (huge_page_shift(hstate) < PUD_SHIFT)
-		return pud_offset(pgd, addr);
-	else
-		return (pud_t *) pgd;
-}
-static pud_t *hpud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long addr,
-			 struct hstate *hstate)
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
 {
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
@@ -180,92 +222,38 @@ int alloc_bootmem_huge_page(struct hstat
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
@@ -277,7 +265,8 @@ static void hugetlb_free_pmd_range(struc
 		next = pmd_addr_end(addr, end);
 		if (pmd_none(*pmd))
 			continue;
-		free_hugepte_range(tlb, (hugepd_t *)pmd, psize);
+		free_hugepd_range(tlb, (hugepd_t *)pmd, PMD_SHIFT,
+				  addr, next, floor, ceiling);
 	} while (pmd++, addr = next, addr != end);
 
 	start &= PUD_MASK;
@@ -303,23 +292,19 @@ static void hugetlb_free_pud_range(struc
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
 
@@ -350,74 +335,34 @@ void hugetlb_free_pgd_range(struct mmu_g
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
-	 *
-	 * The next few lines have given us lots of grief...
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
-
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
@@ -448,19 +393,19 @@ follow_huge_addr(struct mm_struct *mm, u
 {
 	pte_t *ptep;
 	struct page *page;
-	unsigned int mmu_psize = get_slice_psize(mm, address);
+	unsigned shift;
+	unsigned long mask;
+
+	ptep = huge_pte_offset_and_shift(mm, address, &shift);
 
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
@@ -541,21 +486,18 @@ int hash_huge_page(struct mm_struct *mm,
 	int err = 1;
 	int ssize = user_segment_size(ea);
 	unsigned int mmu_psize;
-	int shift;
+	unsigned shift;
 	mmu_psize = get_slice_psize(mm, ea);
 
-	if (!mmu_huge_psizes[mmu_psize])
-		goto out;
-	ptep = huge_pte_offset(mm, ea);
-
+	ptep = huge_pte_offset_and_shift(mm, ea, &shift);
 	/* Search the Linux page table for a match with va */
 	va = hpt_va(ea, vsid, ssize);
 
 	/*
-	 * If no pte found or not present, send the problem up to
-	 * do_page_fault
+	 * If no pte found or not present, or it's not a hugepage pte,
+	 * send the problem up to do_page_fault
 	 */
-	if (unlikely(!ptep || pte_none(*ptep)))
+	if (unlikely(!ptep || pte_none(*ptep) || !shift))
 		goto out;
 
 	/* 
@@ -588,7 +530,6 @@ int hash_huge_page(struct mm_struct *mm,
 	rflags = 0x2 | (!(new_pte & _PAGE_RW));
  	/* _PAGE_EXEC -> HW_NO_EXEC since it's inverted */
 	rflags |= ((new_pte & _PAGE_EXEC) ? 0 : HPTE_R_N);
-	shift = mmu_psize_to_shift(mmu_psize);
 	sz = ((1UL) << shift);
 	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
 		/* No CPU has hugepages but lacks no execute, so we
@@ -672,6 +613,8 @@ repeat:
 
 static void __init set_huge_psize(int psize)
 {
+	unsigned pdshift;
+
 	/* Check that it is a page size supported by the hardware and
 	 * that it fits within pagetable limits. */
 	if (mmu_psize_defs[psize].shift &&
@@ -686,29 +629,14 @@ static void __init set_huge_psize(int ps
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
@@ -732,7 +660,7 @@ __setup("hugepagesz=", hugepage_setup_sz
 
 static int __init hugetlbpage_init(void)
 {
-	unsigned int psize;
+	int psize;
 
 	if (!cpu_has_feature(CPU_FTR_16M_PAGE))
 		return -ENODEV;
@@ -753,8 +681,8 @@ static int __init hugetlbpage_init(void)
 
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
--- working-2.6.orig/arch/powerpc/include/asm/hugetlb.h	2009-09-04 16:09:06.000000000 +1000
+++ working-2.6/arch/powerpc/include/asm/hugetlb.h	2009-09-04 16:20:55.000000000 +1000
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
Index: working-2.6/arch/powerpc/mm/init_64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/init_64.c	2009-09-04 16:12:43.000000000 +1000
+++ working-2.6/arch/powerpc/mm/init_64.c	2009-09-04 16:23:14.000000000 +1000
@@ -41,6 +41,7 @@
 #include <linux/module.h>
 #include <linux/poison.h>
 #include <linux/lmb.h>
+#include <linux/hugetlb.h>
 
 #include <asm/pgalloc.h>
 #include <asm/page.h>
@@ -154,13 +155,21 @@ void pgtable_cache_add(unsigned shift, v
 {
 	char *name;
 	unsigned long table_size = sizeof(void *) << shift;
+	unsigned long align = table_size;
 	struct kmem_cache *new;
 
 	BUG_ON((shift < 1) || (shift > PGF_SHIFT_MASK));
+#ifdef CONFIG_HUGETLB_PAGE
+	/* We use low bits in hugepage dir pointers to store index
+	 * size information.  Table alignment must be big enough to
+	 * fit it. */
+	align = max_t(unsigned long, align, HUGEPD_SHIFT_MASK + 1);
+#endif
+
 	if (PGT_CACHE(shift))
 		return; /* Already have a cache of this size */
 	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
-	new = kmem_cache_create(name, table_size, table_size, 0, ctor);
+	new = kmem_cache_create(name, table_size, align, 0, ctor);
 	PGT_CACHE(shift) = new;
 }
 
