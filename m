Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWMBJ5b3yzDrL9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 18:53:44 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id 17so9727693pfn.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 23:53:44 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v2 5/7] powerpc/64s/radix: Optimize flush_tlb_range
Date: Tue,  7 Nov 2017 18:53:07 +1100
Message-Id: <20171107075309.20500-6-npiggin@gmail.com>
In-Reply-To: <20171107075309.20500-1-npiggin@gmail.com>
References: <20171107075309.20500-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently for radix, flush_tlb_range flushes the entire PID, because
the Linux mm code does not tell us about page size here for THP vs
regular pages. This is quite sub-optimal for small mremap / mprotect
/ change_protection.

So implement va range flushes with two flush passes, one for each
page size (regular and THP). The second flush has an order of matnitude
fewer tlbie instructions than the first, so it is a relatively small
additional cost.

There is still room for improvement here with some changes to generic
APIs, particularly if there are mostly THP pages to be invalidated,
the small page flushes could be reduced.

Time to mprotect 1 page of memory (after mmap, touch):
vanilla 2.9us   1.8us
patched 1.2us   1.6us

Time to mprotect 30 pages of memory (after mmap, touch):
vanilla 8.2us   7.2us
patched 6.9us   17.9us

Time to mprotect 34 pages of memory (after mmap, touch):
vanilla 9.1us   8.0us
patched 9.0us   8.0us

34 pages is the point at which the invalidation switches from va
to entire PID, which tlbie can do in a single instruction. This is
why in the case of 30 pages, the new code runs slower for this test.
This is a deliberate tradeoff already present in the unmap and THP
promotion code, the idea is that the benefit from avoiding flushing
entire TLB for this PID on all threads in the system.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/tlb-radix.c | 139 ++++++++++++++++++++++++++++++++------------
 1 file changed, 101 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 645a35b7bc9d..277497be7aaf 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -100,6 +100,17 @@ static inline void __tlbiel_va(unsigned long va, unsigned long pid,
 	trace_tlbie(0, 1, rb, rs, ric, prs, r);
 }
 
+static inline void __tlbiel_va_range(unsigned long start, unsigned long end,
+				    unsigned long pid, unsigned long page_size,
+				    unsigned long psize)
+{
+	unsigned long addr;
+	unsigned long ap = mmu_get_ap(psize);
+
+	for (addr = start; addr < end; addr += page_size)
+		__tlbiel_va(addr, pid, ap, RIC_FLUSH_TLB);
+}
+
 static inline void _tlbiel_va(unsigned long va, unsigned long pid,
 			      unsigned long psize, unsigned long ric)
 {
@@ -114,12 +125,8 @@ static inline void _tlbiel_va_range(unsigned long start, unsigned long end,
 				    unsigned long pid, unsigned long page_size,
 				    unsigned long psize)
 {
-	unsigned long addr;
-	unsigned long ap = mmu_get_ap(psize);
-
 	asm volatile("ptesync": : :"memory");
-	for (addr = start; addr < end; addr += page_size)
-		__tlbiel_va(addr, pid, ap, RIC_FLUSH_TLB);
+	__tlbiel_va_range(start, end, pid, page_size, psize);
 	asm volatile("ptesync": : :"memory");
 }
 
@@ -139,6 +146,17 @@ static inline void __tlbie_va(unsigned long va, unsigned long pid,
 	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }
 
+static inline void __tlbie_va_range(unsigned long start, unsigned long end,
+				    unsigned long pid, unsigned long page_size,
+				    unsigned long psize)
+{
+	unsigned long addr;
+	unsigned long ap = mmu_get_ap(psize);
+
+	for (addr = start; addr < end; addr += page_size)
+		__tlbie_va(addr, pid, ap, RIC_FLUSH_TLB);
+}
+
 static inline void _tlbie_va(unsigned long va, unsigned long pid,
 			      unsigned long psize, unsigned long ric)
 {
@@ -153,12 +171,8 @@ static inline void _tlbie_va_range(unsigned long start, unsigned long end,
 				    unsigned long pid, unsigned long page_size,
 				    unsigned long psize)
 {
-	unsigned long addr;
-	unsigned long ap = mmu_get_ap(psize);
-
 	asm volatile("ptesync": : :"memory");
-	for (addr = start; addr < end; addr += page_size)
-		__tlbie_va(addr, pid, ap, RIC_FLUSH_TLB);
+	__tlbie_va_range(start, end, pid, page_size, psize);
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
 
@@ -299,17 +313,78 @@ void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end)
 }
 EXPORT_SYMBOL(radix__flush_tlb_kernel_range);
 
+#define TLB_FLUSH_ALL -1UL
+
 /*
- * Currently, for range flushing, we just do a full mm flush. Because
- * we use this in code path where we don' track the page size.
+ * Number of pages above which we invalidate the entire PID rather than
+ * flush individual pages, for local and global flushes respectively.
+ *
+ * tlbie goes out to the interconnect and individual ops are more costly.
+ * It also does not iterate over sets like the local tlbiel variant when
+ * invalidating a full PID, so it has a far lower threshold to change from
+ * individual page flushes to full-pid flushes.
  */
+static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
+
 void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long pid;
+	unsigned int page_shift = mmu_psize_defs[mmu_virtual_psize].shift;
+	unsigned long page_size = 1UL << page_shift;
+	unsigned long nr_pages = (end - start) >> page_shift;
+	bool local, full;
+
+#ifdef CONFIG_HUGETLB_PAGE
+	if (is_vm_hugetlb_page(vma))
+		return radix__flush_hugetlb_tlb_range(vma, start, end);
+#endif
 
-	radix__flush_tlb_mm(mm);
+	pid = mm->context.id;
+	if (unlikely(pid == MMU_NO_CONTEXT))
+		return;
+
+	preempt_disable();
+	local = mm_is_thread_local(mm);
+	full = (end == TLB_FLUSH_ALL || nr_pages > tlb_single_page_flush_ceiling);
+
+	if (full) {
+		if (local)
+			_tlbiel_pid(pid, RIC_FLUSH_TLB);
+		else
+			_tlbie_pid(pid, RIC_FLUSH_TLB);
+	} else {
+		bool hflush = false;
+		unsigned long hstart, hend;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		hstart = (start + HPAGE_PMD_SIZE - 1) >> HPAGE_PMD_SHIFT;
+		hend = end >> HPAGE_PMD_SHIFT;
+		if (hstart < hend) {
+			hstart <<= HPAGE_PMD_SHIFT;
+			hend <<= HPAGE_PMD_SHIFT;
+			hflush = true;
+		}
+#endif
+
+		asm volatile("ptesync": : :"memory");
+		if (local) {
+			__tlbiel_va_range(start, end, pid, page_size, mmu_virtual_psize);
+			if (hflush)
+				__tlbiel_va_range(hstart, hend, pid,
+						HPAGE_PMD_SIZE, MMU_PAGE_2M);
+			asm volatile("ptesync": : :"memory");
+		} else {
+			__tlbie_va_range(start, end, pid, page_size, mmu_virtual_psize);
+			if (hflush)
+				__tlbie_va_range(hstart, hend, pid,
+						HPAGE_PMD_SIZE, MMU_PAGE_2M);
+			asm volatile("eieio; tlbsync; ptesync": : :"memory");
+		}
+	}
+	preempt_enable();
 }
 EXPORT_SYMBOL(radix__flush_tlb_range);
 
@@ -351,19 +426,14 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 		radix__flush_tlb_mm(mm);
 }
 
-#define TLB_FLUSH_ALL -1UL
-/*
- * Number of pages above which we will do a bcast tlbie. Just a
- * number at this point copied from x86
- */
-static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
-
 void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 				  unsigned long end, int psize)
 {
 	unsigned long pid;
-	bool local;
-	unsigned long page_size = 1UL << mmu_psize_defs[psize].shift;
+	unsigned int page_shift = mmu_psize_defs[psize].shift;
+	unsigned long page_size = 1UL << page_shift;
+	unsigned long nr_pages = (end - start) >> page_shift;
+	bool local, full;
 
 
 	pid = mm->context.id;
@@ -372,14 +442,13 @@ void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 
 	preempt_disable();
 	local = mm_is_thread_local(mm);
+	full = (end == TLB_FLUSH_ALL || nr_pages > tlb_single_page_flush_ceiling);
 
-	if (end == TLB_FLUSH_ALL ||
-	    (end - start) > tlb_single_page_flush_ceiling * page_size) {
+	if (full) {
 		if (local)
 			_tlbiel_pid(pid, RIC_FLUSH_TLB);
 		else
 			_tlbie_pid(pid, RIC_FLUSH_TLB);
-
 	} else {
 		if (local)
 			_tlbiel_va_range(start, end, pid, page_size, psize);
@@ -394,7 +463,6 @@ void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long pid, end;
-	bool local;
 
 	pid = mm->context.id;
 	if (unlikely(pid == MMU_NO_CONTEXT))
@@ -406,22 +474,17 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 		return;
 	}
 
-	preempt_disable();
-	local = mm_is_thread_local(mm);
-
-	/* Otherwise first do the PWC */
-	if (local)
-		_tlbiel_pid(pid, RIC_FLUSH_PWC);
-	else
-		_tlbie_pid(pid, RIC_FLUSH_PWC);
-
-	/* Then iterate the pages */
 	end = addr + HPAGE_PMD_SIZE;
 
-	if (local)
+	/* Otherwise first do the PWC, then iterate the pages. */
+	preempt_disable();
+	if (mm_is_thread_local(mm)) {
+		_tlbiel_pid(pid, RIC_FLUSH_PWC);
 		_tlbiel_va_range(addr, end, pid, PAGE_SIZE, mmu_virtual_psize);
-	else
+	} else {
+		_tlbie_pid(pid, RIC_FLUSH_PWC);
 		_tlbie_va_range(addr, end, pid, PAGE_SIZE, mmu_virtual_psize);
+	}
 	preempt_enable();
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-- 
2.15.0
