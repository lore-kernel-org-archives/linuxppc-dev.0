Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xG7fc5HKQzDrCg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 14:28:40 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 6/6] powerpc/mm: Make switch_mm_irqs_off() out of line
Date: Mon, 24 Jul 2017 14:28:03 +1000
Message-Id: <20170724042803.25848-6-benh@kernel.crashing.org>
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

It's too big to be inline, there is no reason to keep it
that way.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

# Conflicts:
#	arch/powerpc/include/asm/mmu_context.h
---
 arch/powerpc/include/asm/mmu_context.h | 73 ++----------------------------
 arch/powerpc/mm/Makefile               |  2 +-
 arch/powerpc/mm/mmu_context.c          | 81 ++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 71 deletions(-)
 create mode 100644 arch/powerpc/mm/mmu_context.c

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index cf8f50cd4030..ed949b2675cb 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -77,76 +77,9 @@ extern void switch_cop(struct mm_struct *next);
 extern int use_cop(unsigned long acop, struct mm_struct *mm);
 extern void drop_cop(unsigned long acop, struct mm_struct *mm);
 
-#if defined(CONFIG_PPC32)
-static inline void switch_mm_pgdir(struct task_struct *tsk,
-				   struct mm_struct *mm)
-{
-	/* 32-bit keeps track of the current PGDIR in the thread struct */
-	tsk->thread.pgdir = mm->pgd;
-}
-#elif defined(CONFIG_PPC_BOOK3E_64)
-static inline void switch_mm_pgdir(struct task_struct *tsk,
-				   struct mm_struct *mm)
-{
-	/* 64-bit Book3E keeps track of current PGD in the PACA */
-	get_paca()->pgd = mm->pgd;
-}
-#else
-static inline void switch_mm_pgdir(struct task_struct *tsk,
-				   struct mm_struct *mm) { }
-#endif
-
-#ifdef CONFIG_PPC_BOOK3S_64
-static inline void inc_mm_active_cpus(struct mm_struct *mm)
-{
-	atomic_inc(&mm->context.active_cpus);
-}
-#else
-static inline void inc_mm_active_cpus(struct mm_struct *mm) { }
-#endif
-
-/*
- * switch_mm is the entry point called from the architecture independent
- * code in kernel/sched/core.c
- */
-static inline void switch_mm_irqs_off(struct mm_struct *prev,
-				      struct mm_struct *next,
-				      struct task_struct *tsk)
-{
-	bool new_on_cpu = false;
-
-	/* Mark this context has been used on the new CPU */
-	if (!cpumask_test_cpu(smp_processor_id(), mm_cpumask(next))) {
-		cpumask_set_cpu(smp_processor_id(), mm_cpumask(next));
-		inc_mm_active_cpus(next);
-		smp_mb();
-		new_on_cpu = true;
-	}
-
-	/* Some subarchs need to track the PGD elsewhere */
-	switch_mm_pgdir(tsk, next);
-
-	/* Nothing else to do if we aren't actually switching */
-	if (prev == next)
-		return;
-
-	/* We must stop all altivec streams before changing the HW
-	 * context
-	 */
-#ifdef CONFIG_ALTIVEC
-	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-		asm volatile ("dssall");
-#endif /* CONFIG_ALTIVEC */
-
-	if (new_on_cpu)
-		radix_kvm_prefetch_workaround(next);
-
-	/*
-	 * The actual HW switching method differs between the various
-	 * sub architectures. Out of line for now
-	 */
-	switch_mmu_context(prev, next, tsk);
-}
+extern void switch_mm_irqs_off(struct mm_struct *prev,
+			       struct mm_struct *next,
+			       struct task_struct *tsk);
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 			     struct task_struct *tsk)
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index fa6a6ba34355..fb844d2f266e 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -8,7 +8,7 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
 obj-y				:= fault.o mem.o pgtable.o mmap.o \
 				   init_$(BITS).o pgtable_$(BITS).o \
-				   init-common.o
+				   init-common.o mmu_context.o
 obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
 				   tlb_nohash_low.o
 obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(BITS)e.o
diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
new file mode 100644
index 000000000000..5f7b59c7ace5
--- /dev/null
+++ b/arch/powerpc/mm/mmu_context.c
@@ -0,0 +1,81 @@
+/*
+ *  Common implementation of switch_mm_irqs_off
+ *
+ *  Copyright IBM Corp. 2017
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/mm.h>
+#include <linux/cpu.h>
+
+#include <asm/mmu_context.h>
+
+#if defined(CONFIG_PPC32)
+static inline void switch_mm_pgdir(struct task_struct *tsk,
+				   struct mm_struct *mm)
+{
+	/* 32-bit keeps track of the current PGDIR in the thread struct */
+	tsk->thread.pgdir = mm->pgd;
+}
+#elif defined(CONFIG_PPC_BOOK3E_64)
+static inline void switch_mm_pgdir(struct task_struct *tsk,
+				   struct mm_struct *mm)
+{
+	/* 64-bit Book3E keeps track of current PGD in the PACA */
+	get_paca()->pgd = mm->pgd;
+}
+#else
+static inline void switch_mm_pgdir(struct task_struct *tsk,
+				   struct mm_struct *mm) { }
+#endif
+
+#ifdef CONFIG_PPC_BOOK3S_64
+static inline void inc_mm_active_cpus(struct mm_struct *mm)
+{
+	atomic_inc(&mm->context.active_cpus);
+}
+#else
+static inline void inc_mm_active_cpus(struct mm_struct *mm) { }
+#endif
+
+void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
+			struct task_struct *tsk)
+{
+	bool new_on_cpu = false;
+
+	/* Mark this context has been used on the new CPU */
+	if (!cpumask_test_cpu(smp_processor_id(), mm_cpumask(next))) {
+		cpumask_set_cpu(smp_processor_id(), mm_cpumask(next));
+		inc_mm_active_cpus(next);
+		smp_mb();
+		new_on_cpu = true;
+	}
+
+	/* Some subarchs need to track the PGD elsewhere */
+	switch_mm_pgdir(tsk, next);
+
+	/* Nothing else to do if we aren't actually switching */
+	if (prev == next)
+		return;
+
+	/* We must stop all altivec streams before changing the HW
+	 * context
+	 */
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+		asm volatile ("dssall");
+
+	if (new_on_cpu)
+		radix_kvm_prefetch_workaround(next);
+
+	/*
+	 * The actual HW switching method differs between the various
+	 * sub architectures. Out of line for now
+	 */
+	switch_mmu_context(prev, next, tsk);
+}
+
-- 
2.13.3
