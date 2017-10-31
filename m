Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yR20p1TH7zDqwt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 17:45:30 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id j3so13862463pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 23:45:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 4/7] powerpc/64s/radix: Introduce local single page
 ceiling for TLB range flush
Date: Tue, 31 Oct 2017 16:45:01 +1000
Message-Id: <20171031064504.25245-5-npiggin@gmail.com>
In-Reply-To: <20171031064504.25245-1-npiggin@gmail.com>
References: <20171031064504.25245-1-npiggin@gmail.com>
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
instructions required to invalidate the entire PID (i.e., 256 pages).

     Time to mprotect N pages of memory (after mmap, touch), local invalidate:
     N           32     34      64     128     256     512
     vanilla  7.4us  9.0us  14.6us  26.4us  50.2us  98.3us
     patched  7.4us  7.8us  13.8us  26.4us  51.9us  98.3us

The behaviour of both is identical at N=32 and N=512. Between there,
the vanilla kernel does a PID invalidate and the patched kernel does
a va range invalidate.

At N=128, these require the same number of tlbiel instructions, so
the patched version can be sen to be cheaper when < 128, and more
expensive when > 128. However this does not well capture the cost
of invalidated TLB.

The additional cost at 256 pages does not seem prohibitive. It may
be the case that increasing the limit further would continue to be
beneficial to avoid invalidating all of the process's TLB entries.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/tlb-radix.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 8cd933560c28..4c6b9046e925 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -325,6 +325,7 @@ EXPORT_SYMBOL(radix__flush_tlb_kernel_range);
  * individual page flushes to full-pid flushes.
  */
 static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
+static unsigned long tlb_local_single_page_flush_ceiling __read_mostly = POWER9_TLB_SETS_RADIX * 2;
 
 void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
@@ -347,8 +348,15 @@ void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		return;
 
 	preempt_disable();
-	local = mm_is_thread_local(mm);
-	full = (end == TLB_FLUSH_ALL || nr_pages > tlb_single_page_flush_ceiling);
+	if (mm_is_thread_local(mm)) {
+		local = true;
+		full = (end == TLB_FLUSH_ALL ||
+				nr_pages > tlb_local_single_page_flush_ceiling);
+	} else {
+		local = false;
+		full = (end == TLB_FLUSH_ALL ||
+				nr_pages > tlb_single_page_flush_ceiling);
+	}
 
 	if (full) {
 		if (local)
@@ -440,8 +448,15 @@ void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 		return;
 
 	preempt_disable();
-	local = mm_is_thread_local(mm);
-	full = (end == TLB_FLUSH_ALL || nr_pages > tlb_single_page_flush_ceiling);
+	if (mm_is_thread_local(mm)) {
+		local = true;
+		full = (end == TLB_FLUSH_ALL ||
+				nr_pages > tlb_local_single_page_flush_ceiling);
+	} else {
+		local = false;
+		full = (end == TLB_FLUSH_ALL ||
+				nr_pages > tlb_single_page_flush_ceiling);
+	}
 
 	if (full) {
 		if (local)
-- 
2.15.0.rc2
