Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xp3Mh6KRzzDrX5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 00:52:32 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id g13so4277569pfm.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Sep 2017 07:52:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>
Subject: [RFC PATCH 5/8] powerpc/64s/radix: Introduce local single page
 ceiling for TLB range flush
Date: Fri,  8 Sep 2017 00:51:45 +1000
Message-Id: <20170907145148.24398-6-npiggin@gmail.com>
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

The single page flush ceiling is the cut-off point at which we switch
from invalidating individual pages, to invalidating the entire process
address space in response to a range flush.

Introduce a local variant of this heuristic because local and global
tlbie have significantly different properties:
- Local tlbiel requires 128 instructions to invalidate a PID, global
  tlbie only 1 instruction.
- Global tlbie instructions are expensive broadcast operations.

The local ceiling has been made much higher, 2x the number of
instructions required to invalidate the entire PID (this has not
yet been benchmarked in detail).
---
 arch/powerpc/mm/tlb-radix.c | 49 +++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 1d3cbc01596d..8ec59b57d46c 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -348,35 +348,41 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 }
 
 #define TLB_FLUSH_ALL -1UL
+
 /*
- * Number of pages above which we will do a bcast tlbie. Just a
- * number at this point copied from x86
+ * Number of pages above which we invalidate the entire PID rather than
+ * flush individual pages, for local and global flushes respectively.
+ *
+ * tlbie goes out to the interconnect and individual ops are more costly.
+ * It also does not iterate over sets like the local tlbiel variant when
+ * invalidating a full PID, so it has a far lower threshold to change from
+ * individual page flushes to full-pid flushes.
  */
 static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
+static unsigned long tlb_local_single_page_flush_ceiling __read_mostly = POWER9_TLB_SETS_RADIX * 2;
 
 void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 				  unsigned long end, int psize)
 {
 	unsigned long pid;
-	bool local;
-	unsigned long page_size = 1UL << mmu_psize_defs[psize].shift;
+	unsigned int page_shift = mmu_psize_defs[psize].shift;
+	unsigned long page_size = 1UL << page_shift;
 
 	pid = mm ? mm->context.id : 0;
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		return;
 
 	preempt_disable();
-	local = mm_is_thread_local(mm);
-	if (end == TLB_FLUSH_ALL ||
-	    (end - start) > tlb_single_page_flush_ceiling * page_size) {
-		if (local)
+	if (mm_is_thread_local(mm)) {
+		if (end == TLB_FLUSH_ALL || ((end - start) >> page_shift) >
+					tlb_local_single_page_flush_ceiling)
 			_tlbiel_pid(pid, RIC_FLUSH_TLB);
 		else
-			_tlbie_pid(pid, RIC_FLUSH_TLB);
-
-	} else {
-		if (local)
 			_tlbiel_va_range(start, end, pid, page_size, psize);
+	} else {
+		if (end == TLB_FLUSH_ALL || ((end - start) >> page_shift) >
+					tlb_single_page_flush_ceiling)
+			_tlbie_pid(pid, RIC_FLUSH_TLB);
 		else
 			_tlbie_va_range(start, end, pid, page_size, psize);
 	}
@@ -387,7 +393,6 @@ void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long pid, end;
-	bool local;
 
 	pid = mm ? mm->context.id : 0;
 	if (unlikely(pid == MMU_NO_CONTEXT))
@@ -399,21 +404,17 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 		return;
 	}
 
-	preempt_disable();
-	local = mm_is_thread_local(mm);
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
2.13.3
