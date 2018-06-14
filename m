Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415pq00vWmzDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 13:23:07 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id r11-v6so2474457pfl.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 20:23:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2] powerpc/64s/radix: Fix MADV_[FREE|DONTNEED] TLB flush miss
 problem with THP
Date: Thu, 14 Jun 2018 13:22:56 +1000
Message-Id: <20180614032256.5440-1-npiggin@gmail.com>
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
the range if it encounters this concurrency condition.

Patch 4647706ebe ("mm: always flush VMA ranges affected by
zap_page_range") does add a TLB flush for all page sizes on powerpc for
the zap_page_range case, but that is to be removed and replaced with
the mmu_gather flush to avoid redundant flushing. It is also thought to
not cover other obscure race conditions:

https://lkml.kernel.org/r/BD3A0EBE-ECF4-41D4-87FA-C755EA9AB6BD@gmail.com

Hash does not have a problem because it invalidates TLBs inside the
page table locks.

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Since v1:
- Compile fix or !THP
- Fixed missing PWC flush case
- Fixed concurrent TLB flush test
- Expanded changelog

I think this is a required fix for existing kernels, at least to be
safe and bring the flushig in to line with other architctures I
think we should add this as a fix. For the next kernel release I will
remove the duplicate flush in zap_page_range so this would definitely
be needed.

 arch/powerpc/mm/tlb-radix.c | 92 +++++++++++++++++++++++++++++--------
 include/linux/huge_mm.h     | 10 +---
 2 files changed, 76 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 67a6e86d3e7e..919232a59ea1 100644
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
@@ -738,16 +733,27 @@ void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
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
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLB_PAGE)
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
 #endif
 
@@ -757,18 +763,36 @@ void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
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
@@ -837,6 +861,8 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 	int psize = 0;
 	struct mm_struct *mm = tlb->mm;
 	int page_size = tlb->page_size;
+	unsigned long start = tlb->start;
+	unsigned long end = tlb->end;
 
 	/*
 	 * if page size is not something we understand, do a full mm flush
@@ -847,15 +873,45 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 	 */
 	if (tlb->fullmm) {
 		__flush_all_mm(mm, true);
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLB_PAGE)
+	} else if (mm_tlb_flush_nested(mm)) {
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
+		 *
+		 * need_flush_all is an uncommon case because page table
+		 * teardown should be done with exclusive locks held (but
+		 * after locks are dropped another invalidate could come
+		 * in), it could be optimized further if necessary.
+		 */
+		if (!tlb->need_flush_all)
+			__radix__flush_tlb_range(mm, start, end, true);
+		else
+			radix__flush_all_mm(mm);
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
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index a8a126259bc4..f7fe2b20efb3 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -79,7 +79,6 @@ extern struct kobj_attribute shmem_enabled_attr;
 #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
 #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define HPAGE_PMD_SHIFT PMD_SHIFT
 #define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
 #define HPAGE_PMD_MASK	(~(HPAGE_PMD_SIZE - 1))
@@ -88,6 +87,8 @@ extern struct kobj_attribute shmem_enabled_attr;
 #define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
 #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+
 extern bool is_vma_temporary_stack(struct vm_area_struct *vma);
 
 extern unsigned long transparent_hugepage_flags;
@@ -246,13 +247,6 @@ static inline bool thp_migration_supported(void)
 }
 
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
-#define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
-#define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })
-#define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
-
-#define HPAGE_PUD_SHIFT ({ BUILD_BUG(); 0; })
-#define HPAGE_PUD_MASK ({ BUILD_BUG(); 0; })
-#define HPAGE_PUD_SIZE ({ BUILD_BUG(); 0; })
 
 #define hpage_nr_pages(x) 1
 
-- 
2.17.0
