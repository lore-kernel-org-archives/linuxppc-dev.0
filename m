Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLtpY5S9wzDqlC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 00:07:17 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id r25so14476995pgn.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 06:07:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 2/3] powerpc/64s/radix: tlbie improve preempt handling
Date: Tue, 24 Oct 2017 23:06:53 +1000
Message-Id: <20171024130654.1223-3-npiggin@gmail.com>
In-Reply-To: <20171024130654.1223-1-npiggin@gmail.com>
References: <20171024130654.1223-1-npiggin@gmail.com>
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

Preempt does not need to be disabled for the mm->context.id tests,
which allows simplification and removal of gotos.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/tlb-radix.c | 48 +++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 892544ebc2d2..18170dc264aa 100644
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
@@ -204,16 +203,15 @@ void radix__flush_all_mm(struct mm_struct *mm)
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
 EXPORT_SYMBOL(radix__flush_all_mm);
@@ -230,15 +228,14 @@ void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
 	unsigned long pid;
 	unsigned long ap = mmu_get_ap(psize);
 
-	preempt_disable();
 	pid = mm->context.id;
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
 
@@ -322,54 +319,53 @@ void radix__flush_tlb_range_psize(struct mm_struct *mm, unsigned long start,
 {
 	unsigned long pid;
 	unsigned long addr;
-	int local = mm_is_thread_local(mm);
+	bool local;
 	unsigned long ap = mmu_get_ap(psize);
 	unsigned long page_size = 1UL << mmu_psize_defs[psize].shift;
 
-
-	preempt_disable();
 	pid = mm->context.id;
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
+	bool local;
 
-	preempt_disable();
 	pid = mm->context.id;
 	if (unlikely(pid == MMU_NO_CONTEXT))
-		goto no_context;
+		return;
 
 	/* 4k page size, just blow the world */
 	if (PAGE_SIZE == 0x1000) {
 		radix__flush_all_mm(mm);
-		preempt_enable();
 		return;
 	}
 
+	preempt_disable();
+	local = mm_is_thread_local(mm);
 	/* Otherwise first do the PWC */
 	if (local)
 		_tlbiel_pid(pid, RIC_FLUSH_PWC);
@@ -384,7 +380,7 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
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
