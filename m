Return-Path: <dgibson@ozlabs.org>
Date: Tue, 9 Feb 2010 17:09:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Fix address masking bug in hpte_need_flush()
Message-ID: <20100209060903.GC13335@yookeroo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Miichael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit f71dc176aa06359681c30ba6877ffccab6fba3a6 'Make
hpte_need_flush() correctly mask for multiple page sizes' introduced
bug, which is triggered when a kernel with a 64k base page size is run
on a system whose hardware does not 64k hash PTEs.  In this case, we
emulate 64k pages with multiple 4k hash PTEs, however in
hpte_need_flush() we incorrectly only mask the hardware page size from
the address, instead of the logical page size.  This causes things to
go wrong when we later attempt to iterate through the hardware
subpages of the logical page.

This patch corrects the error.  It has been tested on pSeries bare
metal by Michael Neuling.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/arch/powerpc/mm/tlb_hash64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/tlb_hash64.c	2010-02-09 16:44:58.810336741 +1100
+++ working-2.6/arch/powerpc/mm/tlb_hash64.c	2010-02-09 16:45:58.920721138 +1100
@@ -63,15 +63,21 @@ void hpte_need_flush(struct mm_struct *m
 	if (huge) {
 #ifdef CONFIG_HUGETLB_PAGE
 		psize = get_slice_psize(mm, addr);
+		/* Mask the address for the correct page size */
+		addr &= ~((1UL << mmu_psize_defs[psize].shift) - 1);
 #else
 		BUG();
 		psize = pte_pagesize_index(mm, addr, pte); /* shutup gcc */
 #endif
-	} else
+	} else {
 		psize = pte_pagesize_index(mm, addr, pte);
+		/* Mask the address for the standard page size.  If we
+		 * have a 64k page kernel, but the hardware does not
+		 * support 64k pages, this might be different from the
+		 * hardware page size encoded in the slice table. */
+		addr &= PAGE_MASK;
+	}
 
-	/* Mask the address for the correct page size */
-	addr &= ~((1UL << mmu_psize_defs[psize].shift) - 1);
 
 	/* Build full vaddr */
 	if (!is_kernel_addr(addr)) {

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
