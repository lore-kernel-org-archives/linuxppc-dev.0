Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWMB41qYPzDrL3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 18:53:32 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id o7so1560925pgc.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 23:53:32 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v2 2/7] powerpc/64s/radix: Fix process table entry cache
 invalidation
Date: Tue,  7 Nov 2017 18:53:04 +1100
Message-Id: <20171107075309.20500-3-npiggin@gmail.com>
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

According to the architecture, the process table entry cache must be
flushed with tlbie RIC=2.

Currently the process table entry is set to invalid right before the
PID is returned to the allocator, with no invalidation. This works on
existing implementations that are known to not cache the process table
entry for any except the current PIDR.

It is architecturally correct and cleaner to invalidate with RIC=2
after clearing the process table entry and before the PID is returned
to the allocator. This can be done in arch_exit_mmap that runs before
the final flush, and to ensure the final flush (fullmm) is always a
RIC=2 variant.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/mmu_context.h |  4 ++++
 arch/powerpc/mm/mmu_context_book3s64.c | 25 ++++++++++++++++++++-----
 arch/powerpc/mm/tlb-radix.c            |  6 +++++-
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index b4cdf574cf61..6177d43f0ce8 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -165,9 +165,13 @@ static inline void arch_dup_mmap(struct mm_struct *oldmm,
 {
 }
 
+#ifndef CONFIG_PPC_BOOK3S_64
 static inline void arch_exit_mmap(struct mm_struct *mm)
 {
 }
+#else
+extern void arch_exit_mmap(struct mm_struct *mm);
+#endif
 
 static inline void arch_unmap(struct mm_struct *mm,
 			      struct vm_area_struct *vma,
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 05e15386d4cb..6d724dab27c2 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -216,19 +216,34 @@ void destroy_context(struct mm_struct *mm)
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 	WARN_ON_ONCE(!list_empty(&mm->context.iommu_group_mem_list));
 #endif
+	if (radix_enabled())
+		WARN_ON(process_tb[mm->context.id].prtb0 != 0);
+	else
+		subpage_prot_free(mm);
+	destroy_pagetable_page(mm);
+	__destroy_context(mm->context.id);
+	mm->context.id = MMU_NO_CONTEXT;
+}
+
+void arch_exit_mmap(struct mm_struct *mm)
+{
 	if (radix_enabled()) {
 		/*
 		 * Radix doesn't have a valid bit in the process table
 		 * entries. However we know that at least P9 implementation
 		 * will avoid caching an entry with an invalid RTS field,
 		 * and 0 is invalid. So this will do.
+		 *
+		 * This runs before the "fullmm" tlb flush in exit_mmap,
+		 * which does a RIC=2 tlbie to clear the process table
+		 * entry. See the "fullmm" comments in tlb-radix.c.
+		 *
+		 * No barrier required here after the store because
+		 * this process will do the invalidate, which starts with
+		 * ptesync.
 		 */
 		process_tb[mm->context.id].prtb0 = 0;
-	} else
-		subpage_prot_free(mm);
-	destroy_pagetable_page(mm);
-	__destroy_context(mm->context.id);
-	mm->context.id = MMU_NO_CONTEXT;
+	}
 }
 
 #ifdef CONFIG_PPC_RADIX_MMU
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index feeb96693aeb..6e77ed2d7c6c 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -297,10 +297,14 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 	psize = radix_get_mmu_psize(page_size);
 	/*
 	 * if page size is not something we understand, do a full mm flush
+	 *
+	 * A "fullmm" flush must always do a flush_all_mm (RIC=2) flush
+	 * that flushes the process table entry cache upon process teardown.
+	 * See the comment for radix in arch_exit_mmap().
 	 */
 	if (psize != -1 && !tlb->fullmm && !tlb->need_flush_all)
 		radix__flush_tlb_range_psize(mm, tlb->start, tlb->end, psize);
-	else if (tlb->need_flush_all) {
+	else if (tlb->fullmm || tlb->need_flush_all) {
 		tlb->need_flush_all = 0;
 		radix__flush_all_mm(mm);
 	} else
-- 
2.15.0
