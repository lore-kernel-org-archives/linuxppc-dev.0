Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rqkhd3s7yzDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 15:26:40 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Balbir Singh <bsingharora@gmail.com>, Nick Piggin <npiggin@kernel.dk>
Subject: [PATCH kernel] powerpc/mm/iommu: Put pages on process exit
Date: Thu, 14 Jul 2016 15:16:19 +1000
Message-Id: <1468473379-36602-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment VFIO IOMMU SPAPR v2 driver pins all guest RAM pages when
the userspace starts using VFIO. When the userspace process finishes,
all the pinned pages need to be put; this is done as a part of
the userspace memory context (MM) destruction which happens on
the very last mmdrop().

This approach has a problem that a MM of the userspace process
may live longer than the userspace process itself as kernel threads
usually execute on a MM of a userspace process which was runnning
on a CPU where the kernel thread was scheduled to. If this happened,
the MM remains referenced until this exact kernel thread wakes up again
and releases the very last reference to the MM, on an idle system this
can take even hours.

This fixes the issue by moving mm_iommu_cleanup() (the helper which puts
pages) from destroy_context() (called on the last mmdrop()) to
the arch-specific arch_exit_mmap() hook (called on the last mmput()).
mmdrop() decrements the mm->mm_count which is a total reference number;
mmput() decrements the mm->mm_users which is a number of user spaces and
this is actually the counter we want to watch for here.

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Nick Piggin <npiggin@kernel.dk>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/mmu_context.h | 3 +++
 arch/powerpc/mm/mmu_context_book3s64.c | 4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 9d2cd0c..24b590d 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -138,6 +138,9 @@ static inline void arch_dup_mmap(struct mm_struct *oldmm,
 
 static inline void arch_exit_mmap(struct mm_struct *mm)
 {
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+	mm_iommu_cleanup(&mm->context);
+#endif
 }
 
 static inline void arch_unmap(struct mm_struct *mm,
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 19622222..aaeba74 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -159,10 +159,6 @@ static inline void destroy_pagetable_page(struct mm_struct *mm)
 
 void destroy_context(struct mm_struct *mm)
 {
-#ifdef CONFIG_SPAPR_TCE_IOMMU
-	mm_iommu_cleanup(&mm->context);
-#endif
-
 #ifdef CONFIG_PPC_ICSWX
 	drop_cop(mm->context.acop, mm);
 	kfree(mm->context.cop_lockp);
-- 
2.5.0.rc3
