Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xp3MT298KzDrXg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 00:52:21 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id h4so1228396pfk.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Sep 2017 07:52:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>
Subject: [RFC PATCH 2/8] powerpc/64s/radix: tlbie improve preempt handling
Date: Fri,  8 Sep 2017 00:51:42 +1000
Message-Id: <20170907145148.24398-3-npiggin@gmail.com>
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

Preempt should be consistently disabled for mm_is_thread_local tests,
so bring the rest of these under preempt_disable().

Preempt does not need to be disabled for the mm->context.id tests, which
allows simplification and removal of gotos.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/tlb-radix.c | 47 +++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index b3e849c4886e..1ed61baf58da 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -186,16 +186,15 @@ void radix__flush_tlb_mm(struct mm_struct *mm)
 {
 	unsigned long pid;
 
-	preempt_disable();
 	pid = mm->context.id;
 	if (unlikely(pid == MMU_NO_CONTEXT))
-		goto no_context;
+		return;
 
+	preempt_disable();
 	if (!mm_is_thread_local(mm))
 		_tlbie_pid(pid, RIC_FLUSH_TLB);
 	else
 		_tlbiel_pid(pid, RIC_FLUSH_TLB);
-no_context:
 	preempt_enable();
 }
 EXPORT_SYMBOL(radix__flush_tlb_mm);
@@ -204,16 +203,15 @@ static void radix__flush_all_mm(struct mm_struct *mm)
 {
 	unsigned long pid;
 
-	preempt_disable();
 	pid = mm->context.id;
 	if (unlikely(pid == MMU_NO_CONTEXT))
-		goto no_context;
+		return;
 
+	preempt_disable();
 	if (!mm_is_thread_local(mm))
 		_tlbie_pid(pid, RIC_FLUSH_ALL);
 	else
 		_tlbiel_pid(pid, RIC_FLUSH_ALL);
-no_context:
 	preempt_enable();
 }
 
@@ -229,15 +227,14 @@ void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
 	unsigned long pid;
 	unsigned long ap = mmu_get_ap(psize);
 
-	preempt_disable();
 	pid = mm ? mm->context.id : 0;
 	if (unlikely(pid == MMU_NO_CONTEXT))
-		goto bail;
+		return;
+	preempt_disable();
 	if (!mm_is_thread_local(mm))
 		_tlbie_va(vmaddr, pid, ap, RIC_FLUSH_TLB);
 	else
 		_tlbiel_va(vmaddr, pid, ap, RIC_FLUSH_TLB);
-bail:
 	preempt_enable();
 }
 
@@ -322,46 +319,44 @@ void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 {
 	unsigned long pid;
 	unsigned long addr;
-	int local = mm_is_thread_local(mm);
+	bool local;
 	unsigned long ap = mmu_get_ap(psize);
 	unsigned long page_size = 1UL << mmu_psize_defs[psize].shift;
 
-
-	preempt_disable();
 	pid = mm ? mm->context.id : 0;
 	if (unlikely(pid == MMU_NO_CONTEXT))
-		goto err_out;
+		return;
 
+	preempt_disable();
+	local = mm_is_thread_local(mm);
 	if (end == TLB_FLUSH_ALL ||
 	    (end - start) > tlb_single_page_flush_ceiling * page_size) {
 		if (local)
 			_tlbiel_pid(pid, RIC_FLUSH_TLB);
 		else
 			_tlbie_pid(pid, RIC_FLUSH_TLB);
-		goto err_out;
-	}
-	for (addr = start; addr < end; addr += page_size) {
+	} else {
+		for (addr = start; addr < end; addr += page_size) {
 
-		if (local)
-			_tlbiel_va(addr, pid, ap, RIC_FLUSH_TLB);
-		else
-			_tlbie_va(addr, pid, ap, RIC_FLUSH_TLB);
+			if (local)
+				_tlbiel_va(addr, pid, ap, RIC_FLUSH_TLB);
+			else
+				_tlbie_va(addr, pid, ap, RIC_FLUSH_TLB);
+		}
 	}
-err_out:
 	preempt_enable();
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 {
-	int local = mm_is_thread_local(mm);
 	unsigned long ap = mmu_get_ap(mmu_virtual_psize);
 	unsigned long pid, end;
-
+	bool local;
 
 	pid = mm ? mm->context.id : 0;
 	if (unlikely(pid == MMU_NO_CONTEXT))
-		goto no_context;
+		return;
 
 	/* 4k page size, just blow the world */
 	if (PAGE_SIZE == 0x1000) {
@@ -369,6 +364,8 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 		return;
 	}
 
+	preempt_disable();
+	local = mm_is_thread_local(mm);
 	/* Otherwise first do the PWC */
 	if (local)
 		_tlbiel_pid(pid, RIC_FLUSH_PWC);
@@ -383,7 +380,7 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 		else
 			_tlbie_va(addr, pid, ap, RIC_FLUSH_TLB);
 	}
-no_context:
+
 	preempt_enable();
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-- 
2.13.3
