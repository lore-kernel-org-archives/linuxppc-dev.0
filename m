Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xG7fm0pRTzDrKB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 14:28:47 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 5/6] powerpc/mm: Optimize detection of thread local mm's
Date: Mon, 24 Jul 2017 14:28:02 +1000
Message-Id: <20170724042803.25848-5-benh@kernel.crashing.org>
In-Reply-To: <20170724042803.25848-1-benh@kernel.crashing.org>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of comparing the whole CPU mask every time, let's
keep a counter of how many bits are set in the mask. Thus
testing for a local mm only requires testing if that counter
is 1 and the current CPU bit is set in the mask.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/book3s/64/mmu.h |  3 +++
 arch/powerpc/include/asm/mmu_context.h   |  9 +++++++++
 arch/powerpc/include/asm/tlb.h           | 11 ++++++++++-
 arch/powerpc/mm/mmu_context_book3s64.c   |  2 ++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 1a220cdff923..c3b00e8ff791 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -83,6 +83,9 @@ typedef struct {
 	mm_context_id_t id;
 	u16 user_psize;		/* page size index */
 
+	/* Number of bits in the mm_cpumask */
+	atomic_t active_cpus;
+
 	/* NPU NMMU context */
 	struct npu_context *npu_context;
 
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index ff1aeb2cd19f..cf8f50cd4030 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -96,6 +96,14 @@ static inline void switch_mm_pgdir(struct task_struct *tsk,
 				   struct mm_struct *mm) { }
 #endif
 
+#ifdef CONFIG_PPC_BOOK3S_64
+static inline void inc_mm_active_cpus(struct mm_struct *mm)
+{
+	atomic_inc(&mm->context.active_cpus);
+}
+#else
+static inline void inc_mm_active_cpus(struct mm_struct *mm) { }
+#endif
 
 /*
  * switch_mm is the entry point called from the architecture independent
@@ -110,6 +118,7 @@ static inline void switch_mm_irqs_off(struct mm_struct *prev,
 	/* Mark this context has been used on the new CPU */
 	if (!cpumask_test_cpu(smp_processor_id(), mm_cpumask(next))) {
 		cpumask_set_cpu(smp_processor_id(), mm_cpumask(next));
+		inc_mm_active_cpus(next);
 		smp_mb();
 		new_on_cpu = true;
 	}
diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index 609557569f65..a7eabff27a0f 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -69,13 +69,22 @@ static inline int mm_is_core_local(struct mm_struct *mm)
 			      topology_sibling_cpumask(smp_processor_id()));
 }
 
+#ifdef CONFIG_PPC_BOOK3S_64
+static inline int mm_is_thread_local(struct mm_struct *mm)
+{
+	if (atomic_read(&mm->context.active_cpus) > 1)
+		return false;
+	return cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm));
+}
+#else /* CONFIG_PPC_BOOK3S_64 */
 static inline int mm_is_thread_local(struct mm_struct *mm)
 {
 	return cpumask_equal(mm_cpumask(mm),
 			      cpumask_of(smp_processor_id()));
 }
+#endif /* !CONFIG_PPC_BOOK3S_64 */
 
-#else
+#else /* CONFIG_SMP */
 static inline int mm_is_core_local(struct mm_struct *mm)
 {
 	return 1;
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 8159f5219137..de17d3e714aa 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -174,6 +174,8 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 	mm_iommu_init(mm);
 #endif
+	atomic_set(&mm->context.active_cpus, 0);
+
 	return 0;
 }
 
-- 
2.13.3
