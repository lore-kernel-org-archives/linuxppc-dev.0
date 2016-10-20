Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sztvS6x2PzDvbr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 14:04:36 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 kvm@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH kernel v3 1/4] powerpc/iommu: Pass mm_struct to init/cleanup
 helpers
Date: Thu, 20 Oct 2016 14:03:47 +1100
Message-Id: <1476932630-45323-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1476932630-45323-1-git-send-email-aik@ozlabs.ru>
References: <1476932630-45323-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are going to get rid of @current references in mmu_context_boos3s64.c
and cache mm_struct in the VFIO container. Since mm_context_t does not
have reference counting, we will be using mm_struct which does have
the reference counter.

This changes mm_iommu_init/mm_iommu_cleanup to receive mm_struct rather
than mm_context_t (which is embedded into mm).

This should not cause any behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/mmu_context.h | 4 ++--
 arch/powerpc/kernel/setup-common.c     | 2 +-
 arch/powerpc/mm/mmu_context_book3s64.c | 4 ++--
 arch/powerpc/mm/mmu_context_iommu.c    | 9 +++++----
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 5c45114..424844b 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -23,8 +23,8 @@ extern bool mm_iommu_preregistered(void);
 extern long mm_iommu_get(unsigned long ua, unsigned long entries,
 		struct mm_iommu_table_group_mem_t **pmem);
 extern long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem);
-extern void mm_iommu_init(mm_context_t *ctx);
-extern void mm_iommu_cleanup(mm_context_t *ctx);
+extern void mm_iommu_init(struct mm_struct *mm);
+extern void mm_iommu_cleanup(struct mm_struct *mm);
 extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long ua,
 		unsigned long size);
 extern struct mm_iommu_table_group_mem_t *mm_iommu_find(unsigned long ua,
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 270ee30..f516ac5 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -915,7 +915,7 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.context.pte_frag = NULL;
 #endif
 #ifdef CONFIG_SPAPR_TCE_IOMMU
-	mm_iommu_init(&init_mm.context);
+	mm_iommu_init(&init_mm);
 #endif
 	irqstack_early_init();
 	exc_lvl_early_init();
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index b114f8b..ad82735 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -115,7 +115,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	mm->context.pte_frag = NULL;
 #endif
 #ifdef CONFIG_SPAPR_TCE_IOMMU
-	mm_iommu_init(&mm->context);
+	mm_iommu_init(mm);
 #endif
 	return 0;
 }
@@ -160,7 +160,7 @@ static inline void destroy_pagetable_page(struct mm_struct *mm)
 void destroy_context(struct mm_struct *mm)
 {
 #ifdef CONFIG_SPAPR_TCE_IOMMU
-	mm_iommu_cleanup(&mm->context);
+	mm_iommu_cleanup(mm);
 #endif
 
 #ifdef CONFIG_PPC_ICSWX
diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index e0f1c33..ad2e575 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -373,16 +373,17 @@ void mm_iommu_mapped_dec(struct mm_iommu_table_group_mem_t *mem)
 }
 EXPORT_SYMBOL_GPL(mm_iommu_mapped_dec);
 
-void mm_iommu_init(mm_context_t *ctx)
+void mm_iommu_init(struct mm_struct *mm)
 {
-	INIT_LIST_HEAD_RCU(&ctx->iommu_group_mem_list);
+	INIT_LIST_HEAD_RCU(&mm->context.iommu_group_mem_list);
 }
 
-void mm_iommu_cleanup(mm_context_t *ctx)
+void mm_iommu_cleanup(struct mm_struct *mm)
 {
 	struct mm_iommu_table_group_mem_t *mem, *tmp;
 
-	list_for_each_entry_safe(mem, tmp, &ctx->iommu_group_mem_list, next) {
+	list_for_each_entry_safe(mem, tmp, &mm->context.iommu_group_mem_list,
+			next) {
 		list_del_rcu(&mem->next);
 		mm_iommu_do_free(mem);
 	}
-- 
2.5.0.rc3
