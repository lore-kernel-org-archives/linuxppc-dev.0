Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xp3MP6hDFzDrWb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 00:52:17 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id a2so4609843pfj.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Sep 2017 07:52:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>
Subject: [RFC PATCH 1/8] powerpc/64s/radix: Fix theoretical process table
 entry cache invalidation
Date: Fri,  8 Sep 2017 00:51:41 +1000
Message-Id: <20170907145148.24398-2-npiggin@gmail.com>
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

According to the architecture, the process table entry cache must be
flushed with RIC=2 tlbies. This problem doesn't hit in existing
implementations that do not cache process table entries over mtpid. The
PID is only destroyed and re-used after all CPUs have switched away from
the mm, guaranteeing its entry is not cached anywhere. But this is not
generally safe according to the ISA.

Fix this by clearing the process table entry before the final flush
(which is always a RIC=2 flush that invalidates the process table entry
cache).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/mmu_context.h |  4 ++++
 arch/powerpc/mm/mmu_context_book3s64.c | 23 ++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 309592589e30..0a70221adcf7 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -118,9 +118,13 @@ static inline void arch_dup_mmap(struct mm_struct *oldmm,
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
index 05e15386d4cb..feb3f43195c2 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -216,19 +216,32 @@ void destroy_context(struct mm_struct *mm)
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
+		 * which does a RIC_FLUSH_ALL to clear the process table
+		 * entry. No barrier required here after the store because
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
-- 
2.13.3
