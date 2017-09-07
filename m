Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xp3Mm4CdWzDrXN
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 00:52:36 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id m9so5058194pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Sep 2017 07:52:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>
Subject: [RFC PATCH 6/8] powerpc/64s/radix: Optimize flush_tlb_range
Date: Fri,  8 Sep 2017 00:51:46 +1000
Message-Id: <20170907145148.24398-7-npiggin@gmail.com>
In-Reply-To: <20170907145148.24398-1-npiggin@gmail.com>
References: <20170907145148.24398-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently for radix, flush_tlb_range flushes the entire PID, because
we don't know about THP vs regular pages. This is quite sub-optimal
for small mremap/mprotect/change_protection.

Instead, implement this with two range flush passes, one for each
page size. If the small page range flush ended up doing the full PID
invalidation, then avoid the second flush. If not, the second flush
is an order of magnitude or two fewer operations than the first, so
it's relatively insignificant.

There is still room for improvement here with some changes to generic
APIs, particularly if there are a lot of huge pages in place.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  2 +-
 arch/powerpc/mm/tlb-radix.c                        | 52 +++++++++++++++++-----
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index 9b433a624bf3..b12460b306a7 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -12,7 +12,7 @@ static inline int mmu_get_ap(int psize)
 
 extern void radix__flush_hugetlb_tlb_range(struct vm_area_struct *vma,
 					   unsigned long start, unsigned long end);
-extern void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
+extern bool radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 					 unsigned long end, int psize);
 extern void radix__flush_pmd_tlb_range(struct vm_area_struct *vma,
 				       unsigned long start, unsigned long end);
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 8ec59b57d46c..1b0cac656680 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -299,17 +299,40 @@ void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end)
 }
 EXPORT_SYMBOL(radix__flush_tlb_kernel_range);
 
-/*
- * Currently, for range flushing, we just do a full mm flush. Because
- * we use this in code path where we don' track the page size.
- */
 void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 
 {
 	struct mm_struct *mm = vma->vm_mm;
+	bool full;
 
-	radix__flush_tlb_mm(mm);
+#ifdef CONFIG_HUGETLB_PAGE
+	if (is_vm_hugetlb_page(vma))
+		return radix__flush_hugetlb_tlb_range(vma, start, end);
+#endif
+	full = radix__flush_tlb_range_psize(mm, start, end, mmu_virtual_psize);
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (!full) {
+		/*
+		 * If the small page flush was not a full PID flush, we have
+		 * to do a second pass to flush transparent huge pages. This
+		 * will be a far smaller number of invalidates, so it's not
+		 * worth calculating.
+		 *
+		 * Range flushes are still sub-optimal for cases of all or
+		 * no hugepages (moreso the former), which should be improved
+		 * by changing the flush API.
+		 */
+		unsigned long hstart, hend;
+		hstart = (start + HPAGE_PMD_SIZE - 1) >> HPAGE_PMD_SHIFT;
+		hend = end >> HPAGE_PMD_SHIFT;
+		if (hstart != hend) {
+			hstart <<= HPAGE_PMD_SHIFT;
+			hend <<= HPAGE_PMD_SHIFT;
+			radix__flush_tlb_range_psize(mm, hstart, hend, MMU_PAGE_2M);
+		}
+	}
+#endif
 }
 EXPORT_SYMBOL(radix__flush_tlb_range);
 
@@ -361,32 +384,39 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
 static unsigned long tlb_local_single_page_flush_ceiling __read_mostly = POWER9_TLB_SETS_RADIX * 2;
 
-void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
+bool radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 				  unsigned long end, int psize)
 {
 	unsigned long pid;
 	unsigned int page_shift = mmu_psize_defs[psize].shift;
 	unsigned long page_size = 1UL << page_shift;
+	bool full = false;
 
 	pid = mm ? mm->context.id : 0;
 	if (unlikely(pid == MMU_NO_CONTEXT))
-		return;
+		return full;
 
 	preempt_disable();
 	if (mm_is_thread_local(mm)) {
 		if (end == TLB_FLUSH_ALL || ((end - start) >> page_shift) >
-					tlb_local_single_page_flush_ceiling)
+					tlb_local_single_page_flush_ceiling) {
+			full = true;
 			_tlbiel_pid(pid, RIC_FLUSH_TLB);
-		else
+		} else {
 			_tlbiel_va_range(start, end, pid, page_size, psize);
+		}
 	} else {
 		if (end == TLB_FLUSH_ALL || ((end - start) >> page_shift) >
-					tlb_single_page_flush_ceiling)
+					tlb_single_page_flush_ceiling) {
+			full = true;
 			_tlbie_pid(pid, RIC_FLUSH_TLB);
-		else
+		} else {
 			_tlbie_va_range(start, end, pid, page_size, psize);
+		}
 	}
 	preempt_enable();
+
+	return full;
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-- 
2.13.3
