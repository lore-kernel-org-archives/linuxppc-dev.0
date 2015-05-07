Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD1A11A0276
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 17:23:38 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 7 May 2015 12:53:36 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 69E12394005A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 12:53:34 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t477NXsS000268
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 12:53:33 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t476nOGP003640
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 12:19:25 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com
Subject: [PATCH V2 1/2] mm/thp: Split out pmd collpase flush into a seperate
 functions
Date: Thu,  7 May 2015 12:53:27 +0530
Message-Id: <1430983408-24924-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After this patch pmdp_* functions operate only on hugepage pte,
and not on regular pmd_t values pointing to page table.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable-ppc64.h |  4 ++
 arch/powerpc/mm/pgtable_64.c             | 76 +++++++++++++++++---------------
 include/asm-generic/pgtable.h            | 19 ++++++++
 mm/huge_memory.c                         |  2 +-
 4 files changed, 65 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 43e6ad424c7f..50830c9a2116 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -576,6 +576,10 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 extern void pmdp_splitting_flush(struct vm_area_struct *vma,
 				 unsigned long address, pmd_t *pmdp);
 
+#define __HAVE_ARCH_PMDP_COLLAPSE_FLUSH
+extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
+				 unsigned long address, pmd_t *pmdp);
+
 #define __HAVE_ARCH_PGTABLE_DEPOSIT
 extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 				       pgtable_t pgtable);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 59daa5eeec25..9171c1a37290 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -560,41 +560,47 @@ pmd_t pmdp_clear_flush(struct vm_area_struct *vma, unsigned long address,
 	pmd_t pmd;
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
-	if (pmd_trans_huge(*pmdp)) {
-		pmd = pmdp_get_and_clear(vma->vm_mm, address, pmdp);
-	} else {
-		/*
-		 * khugepaged calls this for normal pmd
-		 */
-		pmd = *pmdp;
-		pmd_clear(pmdp);
-		/*
-		 * Wait for all pending hash_page to finish. This is needed
-		 * in case of subpage collapse. When we collapse normal pages
-		 * to hugepage, we first clear the pmd, then invalidate all
-		 * the PTE entries. The assumption here is that any low level
-		 * page fault will see a none pmd and take the slow path that
-		 * will wait on mmap_sem. But we could very well be in a
-		 * hash_page with local ptep pointer value. Such a hash page
-		 * can result in adding new HPTE entries for normal subpages.
-		 * That means we could be modifying the page content as we
-		 * copy them to a huge page. So wait for parallel hash_page
-		 * to finish before invalidating HPTE entries. We can do this
-		 * by sending an IPI to all the cpus and executing a dummy
-		 * function there.
-		 */
-		kick_all_cpus_sync();
-		/*
-		 * Now invalidate the hpte entries in the range
-		 * covered by pmd. This make sure we take a
-		 * fault and will find the pmd as none, which will
-		 * result in a major fault which takes mmap_sem and
-		 * hence wait for collapse to complete. Without this
-		 * the __collapse_huge_page_copy can result in copying
-		 * the old content.
-		 */
-		flush_tlb_pmd_range(vma->vm_mm, &pmd, address);
-	}
+	VM_BUG_ON(!pmd_trans_huge(*pmdp));
+	pmd = pmdp_get_and_clear(vma->vm_mm, address, pmdp);
+	return pmd;
+}
+
+pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
+			  pmd_t *pmdp)
+{
+	pmd_t pmd;
+
+	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
+	VM_BUG_ON(pmd_trans_huge(*pmdp));
+
+	pmd = *pmdp;
+	pmd_clear(pmdp);
+	/*
+	 * Wait for all pending hash_page to finish. This is needed
+	 * in case of subpage collapse. When we collapse normal pages
+	 * to hugepage, we first clear the pmd, then invalidate all
+	 * the PTE entries. The assumption here is that any low level
+	 * page fault will see a none pmd and take the slow path that
+	 * will wait on mmap_sem. But we could very well be in a
+	 * hash_page with local ptep pointer value. Such a hash page
+	 * can result in adding new HPTE entries for normal subpages.
+	 * That means we could be modifying the page content as we
+	 * copy them to a huge page. So wait for parallel hash_page
+	 * to finish before invalidating HPTE entries. We can do this
+	 * by sending an IPI to all the cpus and executing a dummy
+	 * function there.
+	 */
+	kick_all_cpus_sync();
+	/*
+	 * Now invalidate the hpte entries in the range
+	 * covered by pmd. This make sure we take a
+	 * fault and will find the pmd as none, which will
+	 * result in a major fault which takes mmap_sem and
+	 * hence wait for collapse to complete. Without this
+	 * the __collapse_huge_page_copy can result in copying
+	 * the old content.
+	 */
+	flush_tlb_pmd_range(vma->vm_mm, &pmd, address);
 	return pmd;
 }
 
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 39f1d6a2b04d..80e6d415cd57 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -189,6 +189,25 @@ extern void pmdp_splitting_flush(struct vm_area_struct *vma,
 				 unsigned long address, pmd_t *pmdp);
 #endif
 
+#ifndef __HAVE_ARCH_PMDP_COLLAPSE_FLUSH
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
+				       unsigned long address,
+				       pmd_t *pmdp)
+{
+	return pmdp_clear_flush(vma, address, pmdp);
+}
+#else
+static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
+				       unsigned long address,
+				       pmd_t *pmdp)
+{
+	BUILD_BUG();
+	return __pmd(0);
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif
+
 #ifndef __HAVE_ARCH_PGTABLE_DEPOSIT
 extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 				       pgtable_t pgtable);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 078832cf3636..88f695a4e38b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2499,7 +2499,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	 * huge and small TLB entries for the same virtual address
 	 * to avoid the risk of CPU bugs in that area.
 	 */
-	_pmd = pmdp_clear_flush(vma, address, pmd);
+	_pmd = pmdp_collapse_flush(vma, address, pmd);
 	spin_unlock(pmd_ptl);
 	mmu_notifier_invalidate_range_end(mm, mmun_start, mmun_end);
 
-- 
2.1.4
