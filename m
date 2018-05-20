Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40pNT20mlVzDrTn
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 10:44:06 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id c41-v6so6671531plj.10
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 17:44:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 3/7] powerpc/64s/radix: make single threaded mms always
 flush all translations from non-local CPUs
Date: Sun, 20 May 2018 10:43:43 +1000
Message-Id: <20180520004347.19508-4-npiggin@gmail.com>
In-Reply-To: <20180520004347.19508-1-npiggin@gmail.com>
References: <20180520004347.19508-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Go one step further, if we're going to put a tlbie on the bus at all,
make it count. Make any global invalidation from a single threaded mm
do a full PID flush so the mm_cpumask can be reset.

The tradeoff is that it will over-flush one time the local CPU's TLB
if there was a small number of pages to flush that could be done with
specific address tlbies.

If the workload is invalidate-heavy enough for this to be a concern,
this should be outweighed by the benefit that it can subsequently
avoid the global flush.

This reduces tlbies for a kernel compile workload from 0.40M to 0.18M,
tlbiels are increased from 22.5M to 23.8M because local pid flushes
take 128 tlbiels vs 1 for global pid flush.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/tlb-radix.c | 45 ++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index d5593a78702a..55f93d66c8d2 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -587,10 +587,16 @@ void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
 		return;
 
 	preempt_disable();
-	if (!mm_is_thread_local(mm))
-		_tlbie_va(vmaddr, pid, psize, RIC_FLUSH_TLB);
-	else
+	if (mm_is_thread_local(mm)) {
 		_tlbiel_va(vmaddr, pid, psize, RIC_FLUSH_TLB);
+	} else {
+		if (mm_is_singlethreaded(mm)) {
+			_tlbie_pid(pid, RIC_FLUSH_ALL);
+			mm_reset_thread_local(mm);
+		} else {
+			_tlbie_va(vmaddr, pid, psize, RIC_FLUSH_TLB);
+		}
+	}
 	preempt_enable();
 }
 
@@ -659,14 +665,14 @@ void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 				nr_pages > tlb_single_page_flush_ceiling);
 	}
 
-	if (full) {
+	if (!local && mm_is_singlethreaded(mm)) {
+		_tlbie_pid(pid, RIC_FLUSH_ALL);
+		mm_reset_thread_local(mm);
+	} else if (full) {
 		if (local) {
 			_tlbiel_pid(pid, RIC_FLUSH_TLB);
 		} else {
-			if (mm_is_singlethreaded(mm)) {
-				_tlbie_pid(pid, RIC_FLUSH_ALL);
-				mm_reset_thread_local(mm);
-			} else if (mm_needs_flush_escalation(mm)) {
+			if (mm_needs_flush_escalation(mm)) {
 				_tlbie_pid(pid, RIC_FLUSH_ALL);
 			} else {
 				_tlbie_pid(pid, RIC_FLUSH_TLB);
@@ -824,19 +830,17 @@ static inline void __radix__flush_tlb_range_psize(struct mm_struct *mm,
 				nr_pages > tlb_single_page_flush_ceiling);
 	}
 
-	if (full) {
+	if (!local && mm_is_singlethreaded(mm)) {
+		_tlbie_pid(pid, RIC_FLUSH_ALL);
+		mm_reset_thread_local(mm);
+	} else if (full) {
 		if (local) {
 			_tlbiel_pid(pid, also_pwc ? RIC_FLUSH_ALL : RIC_FLUSH_TLB);
 		} else {
-			if (mm_is_singlethreaded(mm)) {
-				_tlbie_pid(pid, RIC_FLUSH_ALL);
-				mm_reset_thread_local(mm);
-			} else {
-				if (mm_needs_flush_escalation(mm))
-					also_pwc = true;
+			if (mm_needs_flush_escalation(mm))
+				also_pwc = true;
 
-				_tlbie_pid(pid, also_pwc ? RIC_FLUSH_ALL : RIC_FLUSH_TLB);
-			}
+			_tlbie_pid(pid, also_pwc ? RIC_FLUSH_ALL : RIC_FLUSH_TLB);
 		}
 	} else {
 		if (local)
@@ -882,7 +886,12 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 	if (mm_is_thread_local(mm)) {
 		_tlbiel_va_range(addr, end, pid, PAGE_SIZE, mmu_virtual_psize, true);
 	} else {
-		_tlbie_va_range(addr, end, pid, PAGE_SIZE, mmu_virtual_psize, true);
+		if (mm_is_singlethreaded(mm)) {
+			_tlbie_pid(pid, RIC_FLUSH_ALL);
+			mm_reset_thread_local(mm);
+		} else {
+			_tlbie_va_range(addr, end, pid, PAGE_SIZE, mmu_virtual_psize, true);
+		}
 	}
 
 	preempt_enable();
-- 
2.17.0
