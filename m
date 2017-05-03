Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHlvS055rzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 14:45:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
	npiggin@gmail.com,
	anton@samba.org
Subject: [PATCH] powerpc/mm/radix: Drop support for CPUs without lockless tlbie
Date: Wed,  3 May 2017 14:44:59 +1000
Message-Id: <1493786699-14850-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the radix TLB code includes support for CPUs that do *not*
have MMU_FTR_LOCKLESS_TLBIE. On those CPUs we are required to take a
global spinlock before issuing a tlbie.

Radix can only be built for 64-bit Book3s CPUs, and of those, only
POWER4, 970, Cell and PA6T do not have MMU_FTR_LOCKLESS_TLBIE. Although
it's possible to build a kernel with Radix support that can also boot on
those CPUs, we happen to know that in reality none of those CPUs support
the Radix MMU, so the code can never actually run on those CPUs.

So remove the native_tlbie_lock in the Radix TLB code.

Note that there is another lock of the same name in the hash code, which
is unaffected by this patch.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/tlb-radix.c | 45 +++++++--------------------------------------
 1 file changed, 7 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 5e17c4e873a5..02e71402fdd3 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -17,7 +17,6 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-static DEFINE_RAW_SPINLOCK(native_tlbie_lock);
 
 #define RIC_FLUSH_TLB 0
 #define RIC_FLUSH_PWC 1
@@ -203,15 +202,9 @@ void radix__flush_tlb_mm(struct mm_struct *mm)
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		goto no_context;
 
-	if (!mm_is_thread_local(mm)) {
-		int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
-
-		if (lock_tlbie)
-			raw_spin_lock(&native_tlbie_lock);
+	if (!mm_is_thread_local(mm))
 		_tlbie_pid(pid, RIC_FLUSH_ALL);
-		if (lock_tlbie)
-			raw_spin_unlock(&native_tlbie_lock);
-	} else
+	else
 		_tlbiel_pid(pid, RIC_FLUSH_ALL);
 no_context:
 	preempt_enable();
@@ -235,15 +228,9 @@ void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr)
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		goto no_context;
 
-	if (!mm_is_thread_local(mm)) {
-		int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
-
-		if (lock_tlbie)
-			raw_spin_lock(&native_tlbie_lock);
+	if (!mm_is_thread_local(mm))
 		_tlbie_pid(pid, RIC_FLUSH_PWC);
-		if (lock_tlbie)
-			raw_spin_unlock(&native_tlbie_lock);
-	} else
+	else
 		tlbiel_pwc(pid);
 no_context:
 	preempt_enable();
@@ -260,15 +247,9 @@ void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
 	pid = mm ? mm->context.id : 0;
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		goto bail;
-	if (!mm_is_thread_local(mm)) {
-		int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
-
-		if (lock_tlbie)
-			raw_spin_lock(&native_tlbie_lock);
+	if (!mm_is_thread_local(mm))
 		_tlbie_va(vmaddr, pid, ap, RIC_FLUSH_TLB);
-		if (lock_tlbie)
-			raw_spin_unlock(&native_tlbie_lock);
-	} else
+	else
 		_tlbiel_va(vmaddr, pid, ap, RIC_FLUSH_TLB);
 bail:
 	preempt_enable();
@@ -289,13 +270,7 @@ EXPORT_SYMBOL(radix__flush_tlb_page);
 
 void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
-
-	if (lock_tlbie)
-		raw_spin_lock(&native_tlbie_lock);
 	_tlbie_pid(0, RIC_FLUSH_ALL);
-	if (lock_tlbie)
-		raw_spin_unlock(&native_tlbie_lock);
 }
 EXPORT_SYMBOL(radix__flush_tlb_kernel_range);
 
@@ -357,7 +332,6 @@ void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 	unsigned long addr;
 	int local = mm_is_thread_local(mm);
 	unsigned long ap = mmu_get_ap(psize);
-	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 	unsigned long page_size = 1UL << mmu_psize_defs[psize].shift;
 
 
@@ -378,13 +352,8 @@ void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 
 		if (local)
 			_tlbiel_va(addr, pid, ap, RIC_FLUSH_TLB);
-		else {
-			if (lock_tlbie)
-				raw_spin_lock(&native_tlbie_lock);
+		else
 			_tlbie_va(addr, pid, ap, RIC_FLUSH_TLB);
-			if (lock_tlbie)
-				raw_spin_unlock(&native_tlbie_lock);
-		}
 	}
 err_out:
 	preempt_enable();
-- 
2.7.4
