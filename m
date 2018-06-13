Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415GSt1RnqzDrp0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 16:05:32 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id q4-v6so740130pgr.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 23:05:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH] powerpc/64s/radix: Fix MADV_[FREE|DONTNEED] TLB flush
 miss problem with THP
Date: Wed, 13 Jun 2018 16:05:13 +1000
Message-Id: <20180613060513.7087-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch 99baac21e4 ("mm: fix MADV_[FREE|DONTNEED] TLB flush miss
problem") added a force flush mode to the mmu_gather flush, which
unconditionally flushes the entire address range being invalidated
(even if actual ptes only covered a smaller range), to solve a problem
with concurrent threads invalidating the same PTEs causing them to
miss TLBs that need flushing.

This does not work with powerpc that invalidates mmu_gather batches
according to page size. Have powerpc flush all possible page sizes in
the range if it encounters the concurrency condition.

[ Do we need to do anything for hash? ]

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/tlb-radix.c | 53 ++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 67a6e86d3e7e..a09df0318324 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -689,22 +689,16 @@ EXPORT_SYMBOL(radix__flush_tlb_kernel_range);
 static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
 static unsigned long tlb_local_single_page_flush_ceiling __read_mostly = POWER9_TLB_SETS_RADIX * 2;
 
-void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
+static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 		     unsigned long end)
 
 {
-	struct mm_struct *mm = vma->vm_mm;
 	unsigned long pid;
 	unsigned int page_shift = mmu_psize_defs[mmu_virtual_psize].shift;
 	unsigned long page_size = 1UL << page_shift;
 	unsigned long nr_pages = (end - start) >> page_shift;
 	bool local, full;
 
-#ifdef CONFIG_HUGETLB_PAGE
-	if (is_vm_hugetlb_page(vma))
-		return radix__flush_hugetlb_tlb_range(vma, start, end);
-#endif
-
 	pid = mm->context.id;
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		return;
@@ -769,6 +763,18 @@ void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 	}
 	preempt_enable();
 }
+
+void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
+		     unsigned long end)
+
+{
+#ifdef CONFIG_HUGETLB_PAGE
+	if (is_vm_hugetlb_page(vma))
+		return radix__flush_hugetlb_tlb_range(vma, start, end);
+#endif
+
+	__flush_tlb_range(vma->vm_mm, start, end);
+}
 EXPORT_SYMBOL(radix__flush_tlb_range);
 
 static int radix_get_mmu_psize(int page_size)
@@ -837,6 +843,8 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 	int psize = 0;
 	struct mm_struct *mm = tlb->mm;
 	int page_size = tlb->page_size;
+	unsigned long start = tlb->start;
+	unsigned long end = tlb->end;
 
 	/*
 	 * if page size is not something we understand, do a full mm flush
@@ -844,18 +852,43 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 	 * A "fullmm" flush must always do a flush_all_mm (RIC=2) flush
 	 * that flushes the process table entry cache upon process teardown.
 	 * See the comment for radix in arch_exit_mmap().
+	 *
+	 * If there is a concurrent TLB invalidation operation
 	 */
 	if (tlb->fullmm) {
 		__flush_all_mm(mm, true);
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	} else if (mm_tlb_flush_pending(mm)) {
+		/*
+		 * If there is a concurrent invalidation that is clearing ptes,
+		 * then it's possible this invalidation will miss one of those
+		 * cleared ptes and miss flushing the TLB. If this invalidate
+		 * returns before the other one flushes TLBs, that can result
+		 * in it returning while there are still valid TLBs inside the
+		 * range to be invalidated.
+		 *
+		 * See mm/memory.c:tlb_finish_mmu() for more details.
+		 *
+		 * The solution to this is ensure the entire range is always
+		 * flushed here. The problem for powerpc is that the flushes
+		 * are page size specific, so this "forced flush" would not
+		 * do the right thing if there are a mix of page sizes in
+		 * the range to be invalidated. So use __flush_tlb_range
+		 * which invalidates all possible page sizes in the range.
+		 *
+		 * PWC flush probably is not be required because the core code
+		 * shouldn't free page tables in this path, but accounting
+		 * for the possibility makes us a bit more robust.
+		 */
+		WARN_ON_ONCE(tlb->need_flush_all);
+		__flush_tlb_range(mm, start, end);
+#endif
 	} else if ( (psize = radix_get_mmu_psize(page_size)) == -1) {
 		if (!tlb->need_flush_all)
 			radix__flush_tlb_mm(mm);
 		else
 			radix__flush_all_mm(mm);
 	} else {
-		unsigned long start = tlb->start;
-		unsigned long end = tlb->end;
-
 		if (!tlb->need_flush_all)
 			radix__flush_tlb_range_psize(mm, start, end, psize);
 		else
-- 
2.17.0
