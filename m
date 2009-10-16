Return-Path: <dgibson@ozlabs.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [1/6] Make hpte_need_flush() correctly mask for multiple page sizes
In-Reply-To: <20091016052100.GD21417@yookeroo.seuss>
Message-Id: <20091016052212.DAD95B7BB3@ozlabs.org>
Date: Fri, 16 Oct 2009 16:22:12 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, hpte_need_flush() only correctly flushes the given address
for normal pages.  Callers for hugepages are required to mask the
address themselves.

But hpte_need_flush() already looks up the page sizes for its own
reasons, so this is a rather silly imposition on the callers.  This
patch alters it to mask based on the pagesize it has looked up itself,
and removes the awkward masking code in the hugepage caller.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

---
 arch/powerpc/mm/hugetlbpage.c |    6 +-----
 arch/powerpc/mm/tlb_hash64.c  |    8 +++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

Index: working-2.6/arch/powerpc/mm/tlb_hash64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/tlb_hash64.c	2009-09-04 14:35:30.000000000 +1000
+++ working-2.6/arch/powerpc/mm/tlb_hash64.c	2009-09-04 14:36:12.000000000 +1000
@@ -53,11 +53,6 @@ void hpte_need_flush(struct mm_struct *m
 
 	i = batch->index;
 
-	/* We mask the address for the base page size. Huge pages will
-	 * have applied their own masking already
-	 */
-	addr &= PAGE_MASK;
-
 	/* Get page size (maybe move back to caller).
 	 *
 	 * NOTE: when using special 64K mappings in 4K environment like
@@ -75,6 +70,9 @@ void hpte_need_flush(struct mm_struct *m
 	} else
 		psize = pte_pagesize_index(mm, addr, pte);
 
+	/* Mask the address for the correct page size */
+	addr &= ~((1UL << mmu_psize_defs[psize].shift) - 1);
+
 	/* Build full vaddr */
 	if (!is_kernel_addr(addr)) {
 		ssize = user_segment_size(addr);
Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2009-09-04 14:35:30.000000000 +1000
+++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2009-09-04 14:36:12.000000000 +1000
@@ -445,11 +445,7 @@ void set_huge_pte_at(struct mm_struct *m
 		 * necessary anymore if we make hpte_need_flush() get the
 		 * page size from the slices
 		 */
-		unsigned int psize = get_slice_psize(mm, addr);
-		unsigned int shift = mmu_psize_to_shift(psize);
-		unsigned long sz = ((1UL) << shift);
-		struct hstate *hstate = size_to_hstate(sz);
-		pte_update(mm, addr & hstate->mask, ptep, ~0UL, 1);
+		pte_update(mm, addr, ptep, ~0UL, 1);
 	}
 	*ptep = __pte(pte_val(pte) & ~_PAGE_HPTEFLAGS);
 }
