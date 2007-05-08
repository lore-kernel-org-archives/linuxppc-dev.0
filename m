Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 08 May 2007 16:27:27 +1000
Subject: [PATCH 1/5] powerpc: Small fixes & cleanups in segment page size
	demotion
In-Reply-To: <1178605646.637780.625211974455.qpush@grosgo>
Message-Id: <20070508062747.F2A86DDE38@ozlabs.org>
Cc: Hugh Dickins <hugh@veritas.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The code for demoting segments to 4K had some issues, like for example,
when using _PAGE_4K_PFN flag, the first CPU to hit it would do the
demotion, but other CPUs hitting the same page wouldn't properly flush
their SLBs if mmu_ci_restriction isn't set. There are also potential
issues with hash_preload not handling _PAGE_4K_PFN. All of these are
non issues on current hardware but might bite us in the future.

This patch thus fixes it by:

 - Taking the test comparing the mm and current CPU context page
sizes to decide to flush SLBs out of the mmu_ci_restrictions test
since that can also be triggered by _PAGE_4K_PFN pages

 - Due to the above being done all the time, demote_segment_4k
doesn't need update the context and flush the SLB

 - demote_segment_4k can be static and doesn't need an EXPORT_SYMBOL

 - Making hash_preload ignore anything that has either _PAGE_4K_PFN
or _PAGE_NO_CACHE set, thus avoiding duplication of the complicated
logic in hash_page() (and possibly making hash_preload a little bit
faster for the normal case).


Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/mm/hash_utils_64.c |   87 +++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 41 deletions(-)

Index: linux-cell/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/mm/hash_utils_64.c	2007-05-08 14:22:06.000000000 +1000
+++ linux-cell/arch/powerpc/mm/hash_utils_64.c	2007-05-08 15:27:29.000000000 +1000
@@ -596,22 +596,18 @@ unsigned int hash_page_do_lazy_icache(un
  * Demote a segment to using 4k pages.
  * For now this makes the whole process use 4k pages.
  */
-void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
-{
 #ifdef CONFIG_PPC_64K_PAGES
+static void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
+{
 	if (mm->context.user_psize == MMU_PAGE_4K)
 		return;
 	mm->context.user_psize = MMU_PAGE_4K;
 	mm->context.sllp = SLB_VSID_USER | mmu_psize_defs[MMU_PAGE_4K].sllp;
-	get_paca()->context = mm->context;
-	slb_flush_and_rebolt();
 #ifdef CONFIG_SPE_BASE
 	spu_flush_all_slbs(mm);
 #endif
-#endif
 }
-
-EXPORT_SYMBOL_GPL(demote_segment_4k);
+#endif /* CONFIG_PPC_64K_PAGES */
 
 /* Result code is:
  *  0 - handled
@@ -711,40 +707,42 @@ int hash_page(unsigned long ea, unsigned
 		psize = MMU_PAGE_4K;
 	}
 
-	if (mmu_ci_restrictions) {
-		/* If this PTE is non-cacheable, switch to 4k */
-		if (psize == MMU_PAGE_64K &&
-		    (pte_val(*ptep) & _PAGE_NO_CACHE)) {
-			if (user_region) {
-				demote_segment_4k(mm, ea);
-				psize = MMU_PAGE_4K;
-			} else if (ea < VMALLOC_END) {
-				/*
-				 * some driver did a non-cacheable mapping
-				 * in vmalloc space, so switch vmalloc
-				 * to 4k pages
-				 */
-				printk(KERN_ALERT "Reducing vmalloc segment "
-				       "to 4kB pages because of "
-				       "non-cacheable mapping\n");
-				psize = mmu_vmalloc_psize = MMU_PAGE_4K;
-			}
+	/* If this PTE is non-cacheable and we have restrictions on
+	 * using non cacheable large pages, then we switch to 4k
+	 */
+	if (mmu_ci_restrictions && psize == MMU_PAGE_64K &&
+	    (pte_val(*ptep) & _PAGE_NO_CACHE)) {
+		if (user_region) {
+			demote_segment_4k(mm, ea);
+			psize = MMU_PAGE_4K;
+		} else if (ea < VMALLOC_END) {
+			/*
+			 * some driver did a non-cacheable mapping
+			 * in vmalloc space, so switch vmalloc
+			 * to 4k pages
+			 */
+			printk(KERN_ALERT "Reducing vmalloc segment "
+			       "to 4kB pages because of "
+			       "non-cacheable mapping\n");
+			psize = mmu_vmalloc_psize = MMU_PAGE_4K;
 #ifdef CONFIG_SPE_BASE
 			spu_flush_all_slbs(mm);
 #endif
 		}
-		if (user_region) {
-			if (psize != get_paca()->context.user_psize) {
-				get_paca()->context = mm->context;
-				slb_flush_and_rebolt();
-			}
-		} else if (get_paca()->vmalloc_sllp !=
-			   mmu_psize_defs[mmu_vmalloc_psize].sllp) {
-			get_paca()->vmalloc_sllp =
-				mmu_psize_defs[mmu_vmalloc_psize].sllp;
+	}
+	if (user_region) {
+		if (psize != get_paca()->context.user_psize) {
+			get_paca()->context.user_psize =
+				mm->context.user_psize;
 			slb_flush_and_rebolt();
 		}
+	} else if (get_paca()->vmalloc_sllp !=
+		   mmu_psize_defs[mmu_vmalloc_psize].sllp) {
+		get_paca()->vmalloc_sllp =
+			mmu_psize_defs[mmu_vmalloc_psize].sllp;
+		slb_flush_and_rebolt();
 	}
+
 	if (psize == MMU_PAGE_64K)
 		rc = __hash_page_64K(ea, access, vsid, ptep, trap, local);
 	else
@@ -780,13 +778,26 @@ void hash_preload(struct mm_struct *mm, 
 	DBG_LOW("hash_preload(mm=%p, mm->pgdir=%p, ea=%016lx, access=%lx,"
 		" trap=%lx\n", mm, mm->pgd, ea, access, trap);
 
-	/* Get PTE, VSID, access mask */
+	/* Get Linux PTE if available */
 	pgdir = mm->pgd;
 	if (pgdir == NULL)
 		return;
 	ptep = find_linux_pte(pgdir, ea);
 	if (!ptep)
 		return;
+
+#ifdef CONFIG_PPC_64K_PAGES
+	/* If either _PAGE_4K_PFN or _PAGE_NO_CACHE is set (and we are on
+	 * a 64K kernel), then we don't preload, hash_page() will take
+	 * care of it once we actually try to access the page.
+	 * That way we don't have to duplicate all of the logic for segment
+	 * page size demotion here
+	 */
+	if (pte_val(*ptep) & (_PAGE_4K_PFN | _PAGE_NO_CACHE))
+		return;
+#endif /* CONFIG_PPC_64K_PAGES */
+
+	/* Get VSID */
 	vsid = get_vsid(mm->context.id, ea);
 
 	/* Hash it in */
@@ -797,12 +808,6 @@ void hash_preload(struct mm_struct *mm, 
 #ifndef CONFIG_PPC_64K_PAGES
 	__hash_page_4K(ea, access, vsid, ptep, trap, local);
 #else
-	if (mmu_ci_restrictions) {
-		/* If this PTE is non-cacheable, switch to 4k */
-		if (mm->context.user_psize == MMU_PAGE_64K &&
-		    (pte_val(*ptep) & _PAGE_NO_CACHE))
-			demote_segment_4k(mm, ea);
-	}
 	if (mm->context.user_psize == MMU_PAGE_64K)
 		__hash_page_64K(ea, access, vsid, ptep, trap, local);
 	else
