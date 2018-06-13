Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415MfP232bzF0Pd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 19:59:09 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id y5-v6so1141400pfn.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 02:59:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/64s/radix: Fix MADV_[FREE|DONTNEED] TLB flush miss
 problem with THP
Date: Wed, 13 Jun 2018 19:58:58 +1000
Message-Id: <20180613095858.31078-1-npiggin@gmail.com>
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

Hash does not have a problem because it invalidates TLBs inside the
page table locks.

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Since RFC:
- Account for hugetlb pages that can be mixed with the tlb_flush
  range.

 arch/powerpc/mm/tlb-radix.c | 85 ++++++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 67a6e86d3e7e..9dbccda651d7 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -689,22 +689,17 @@ EXPORT_SYMBOL(radix__flush_tlb_kernel_range);
 static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
 static unsigned long tlb_local_single_page_flush_ceiling __read_mostly = POWER9_TLB_SETS_RADIX * 2;
 
-void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-		     unsigned long end)
+static inline void __radix__flush_tlb_range(struct mm_struct *mm,
+					unsigned long start, unsigned long end,
+					bool flush_all_sizes)
 
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
@@ -738,18 +733,27 @@ void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 				_tlbie_pid(pid, RIC_FLUSH_TLB);
 		}
 	} else {
-		bool hflush = false;
+		bool hflush = flush_all_sizes;
+		bool gflush = flush_all_sizes;
 		unsigned long hstart, hend;
+		unsigned long gstart, gend;
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		hstart = (start + HPAGE_PMD_SIZE - 1) >> HPAGE_PMD_SHIFT;
-		hend = end >> HPAGE_PMD_SHIFT;
-		if (hstart < hend) {
-			hstart <<= HPAGE_PMD_SHIFT;
-			hend <<= HPAGE_PMD_SHIFT;
+		if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 			hflush = true;
+
+		if (hflush) {
+			hstart = (start + HPAGE_PMD_SIZE - 1) & HPAGE_PMD_MASK;
+			hend = end & HPAGE_PMD_MASK;
+			if (hstart == hend)
+				hflush = false;
+		}
+
+		if (gflush) {
+			gstart = (start + HPAGE_PUD_SIZE - 1) & HPAGE_PUD_MASK;
+			gend = end & HPAGE_PUD_MASK;
+			if (gstart == gend)
+				gflush = false;
 		}
-#endif
 
 		asm volatile("ptesync": : :"memory");
 		if (local) {
@@ -757,18 +761,36 @@ void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			if (hflush)
 				__tlbiel_va_range(hstart, hend, pid,
 						HPAGE_PMD_SIZE, MMU_PAGE_2M);
+			if (gflush)
+				__tlbiel_va_range(gstart, gend, pid,
+						HPAGE_PUD_SIZE, MMU_PAGE_1G);
 			asm volatile("ptesync": : :"memory");
 		} else {
 			__tlbie_va_range(start, end, pid, page_size, mmu_virtual_psize);
 			if (hflush)
 				__tlbie_va_range(hstart, hend, pid,
 						HPAGE_PMD_SIZE, MMU_PAGE_2M);
+			if (gflush)
+				__tlbie_va_range(gstart, gend, pid,
+						HPAGE_PUD_SIZE, MMU_PAGE_1G);
 			fixup_tlbie();
 			asm volatile("eieio; tlbsync; ptesync": : :"memory");
 		}
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
+	__radix__flush_tlb_range(vma->vm_mm, start, end, false);
+}
 EXPORT_SYMBOL(radix__flush_tlb_range);
 
 static int radix_get_mmu_psize(int page_size)
@@ -837,6 +859,8 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 	int psize = 0;
 	struct mm_struct *mm = tlb->mm;
 	int page_size = tlb->page_size;
+	unsigned long start = tlb->start;
+	unsigned long end = tlb->end;
 
 	/*
 	 * if page size is not something we understand, do a full mm flush
@@ -847,15 +871,38 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 	 */
 	if (tlb->fullmm) {
 		__flush_all_mm(mm, true);
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLB_PAGE)
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
+		__radix__flush_tlb_range(mm, start, end, true);
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
