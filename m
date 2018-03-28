Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BBf06Tc6zF2NG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 02:30:16 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id m68so1101871pfm.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 08:30:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC PATCH 3/3] powerpc/64s: always flush non-local CPUs from single
 threaded mms
Date: Thu, 29 Mar 2018 01:29:51 +1000
Message-Id: <20180328152951.6422-4-npiggin@gmail.com>
In-Reply-To: <20180328152951.6422-1-npiggin@gmail.com>
References: <20180328152951.6422-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Go one step further, if we're going to put a tlbie on the bus
at all, make it count. Always flush all others and restore our
mm to a local one.
---
 arch/powerpc/mm/tlb-radix.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index f00acacf48f1..ba48539e799e 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -424,10 +424,16 @@ void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
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
 
@@ -496,14 +502,14 @@ void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
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
@@ -618,19 +624,17 @@ static inline void __radix__flush_tlb_range_psize(struct mm_struct *mm,
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
@@ -676,7 +680,12 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
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
2.16.1
