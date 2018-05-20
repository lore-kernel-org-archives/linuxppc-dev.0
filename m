Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40pNT71T8RzDrWN
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 10:44:11 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id c10-v6so5392936pfi.12
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 17:44:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 5/7] powerpc/64s/radix: optimise pte_update
Date: Sun, 20 May 2018 10:43:45 +1000
Message-Id: <20180520004347.19508-6-npiggin@gmail.com>
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

Implementing pte_update with pte_xchg (which uses cmpxchg) is
inefficient. A single larx/stcx. works fine, no need for the less
efficient cmpxchg sequence.

Then remove the memory barriers from the operation. There is a
requirement for TLB flushing to load mm_cpumask after the store
that reduces pte permissions, which is moved into the TLB flush
code.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h | 25 +++++++++++-----------
 arch/powerpc/mm/mmu_context.c              |  6 ++++--
 arch/powerpc/mm/tlb-radix.c                | 11 +++++++++-
 3 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index fcd92f9b6ec0..ab4ed61a74fa 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -127,20 +127,21 @@ extern void radix__mark_initmem_nx(void);
 static inline unsigned long __radix_pte_update(pte_t *ptep, unsigned long clr,
 					       unsigned long set)
 {
-	pte_t pte;
-	unsigned long old_pte, new_pte;
-
-	do {
-		pte = READ_ONCE(*ptep);
-		old_pte = pte_val(pte);
-		new_pte = (old_pte | set) & ~clr;
-
-	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
-
-	return old_pte;
+	__be64 old_be, tmp_be;
+
+	__asm__ __volatile__(
+	"1:	ldarx	%0,0,%3		# pte_update\n"
+	"	andc	%1,%0,%5	\n"
+	"	or	%1,%1,%4	\n"
+	"	stdcx.	%1,0,%3		\n"
+	"	bne-	1b"
+	: "=&r" (old_be), "=&r" (tmp_be), "=m" (*ptep)
+	: "r" (ptep), "r" (cpu_to_be64(set)), "r" (cpu_to_be64(clr))
+	: "cc" );
+
+	return be64_to_cpu(old_be);
 }
 
-
 static inline unsigned long radix__pte_update(struct mm_struct *mm,
 					unsigned long addr,
 					pte_t *ptep, unsigned long clr,
diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
index 0ab297c4cfad..f84e14f23e50 100644
--- a/arch/powerpc/mm/mmu_context.c
+++ b/arch/powerpc/mm/mmu_context.c
@@ -57,8 +57,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 * in switch_slb(), and/or the store of paca->mm_ctx_id in
 		 * copy_mm_to_paca().
 		 *
-		 * On the read side the barrier is in pte_xchg(), which orders
-		 * the store to the PTE vs the load of mm_cpumask.
+		 * On the other side, the barrier is in mm/tlb-radix.c for
+		 * radix which orders earlier stores to clear the PTEs vs
+		 * the load of mm_cpumask. And pte_xchg which does the same
+		 * thing for hash.
 		 *
 		 * This full barrier is needed by membarrier when switching
 		 * between processes after store to rq->curr, before user-space
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 55f93d66c8d2..b419702b1ba6 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -535,6 +535,11 @@ void radix__flush_tlb_mm(struct mm_struct *mm)
 		return;
 
 	preempt_disable();
+	/*
+	 * Order loads of mm_cpumask vs previous stores to clear ptes before
+	 * the invalidate. See barrier in switch_mm_irqs_off
+	 */
+	smp_mb();
 	if (!mm_is_thread_local(mm)) {
 		if (mm_is_singlethreaded(mm)) {
 			_tlbie_pid(pid, RIC_FLUSH_ALL);
@@ -560,6 +565,7 @@ void radix__flush_all_mm(struct mm_struct *mm)
 		return;
 
 	preempt_disable();
+	smp_mb(); /* see radix__flush_tlb_mm */
 	if (!mm_is_thread_local(mm)) {
 		_tlbie_pid(pid, RIC_FLUSH_ALL);
 		if (mm_is_singlethreaded(mm))
@@ -587,6 +593,7 @@ void radix__flush_tlb_page_psize(struct mm_struct *mm, unsigned long vmaddr,
 		return;
 
 	preempt_disable();
+	smp_mb(); /* see radix__flush_tlb_mm */
 	if (mm_is_thread_local(mm)) {
 		_tlbiel_va(vmaddr, pid, psize, RIC_FLUSH_TLB);
 	} else {
@@ -655,6 +662,7 @@ void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		return;
 
 	preempt_disable();
+	smp_mb(); /* see radix__flush_tlb_mm */
 	if (mm_is_thread_local(mm)) {
 		local = true;
 		full = (end == TLB_FLUSH_ALL ||
@@ -820,6 +828,7 @@ static inline void __radix__flush_tlb_range_psize(struct mm_struct *mm,
 		return;
 
 	preempt_disable();
+	smp_mb(); /* see radix__flush_tlb_mm */
 	if (mm_is_thread_local(mm)) {
 		local = true;
 		full = (end == TLB_FLUSH_ALL ||
@@ -882,7 +891,7 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 
 	/* Otherwise first do the PWC, then iterate the pages. */
 	preempt_disable();
-
+	smp_mb(); /* see radix__flush_tlb_mm */
 	if (mm_is_thread_local(mm)) {
 		_tlbiel_va_range(addr, end, pid, PAGE_SIZE, mmu_virtual_psize, true);
 	} else {
-- 
2.17.0
