Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C66F0B7B66
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 15:59:50 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 23 Jul 2009 15:59:39 +1000
Subject: [PATCH 3/20] powerpc/mm: Add HW threads support to no_hash TLB
	management
Message-Id: <20090723055950.B6233DDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current "no hash" MMU context management code is written with
the assumption that one CPU == one TLB. This is not the case on
implementations that support HW multithreading, where several
linux CPUs can share the same TLB.

This adds some basic support for this to our context management
and our TLB flushing code.

It also cleans up the optional debugging output a bit

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/cputhreads.h |   16 +++++
 arch/powerpc/mm/mmu_context_nohash.c  |   93 ++++++++++++++++++++++------------
 arch/powerpc/mm/tlb_nohash.c          |   10 ++-
 3 files changed, 86 insertions(+), 33 deletions(-)

--- linux-work.orig/arch/powerpc/mm/mmu_context_nohash.c	2009-07-21 12:43:27.000000000 +1000
+++ linux-work/arch/powerpc/mm/mmu_context_nohash.c	2009-07-21 12:56:16.000000000 +1000
@@ -25,10 +25,20 @@
  *     also clear mm->cpu_vm_mask bits when processes are migrated
  */
 
-#undef DEBUG
-#define DEBUG_STEAL_ONLY
-#undef DEBUG_MAP_CONSISTENCY
-/*#define DEBUG_CLAMP_LAST_CONTEXT   15 */
+#define DEBUG_MAP_CONSISTENCY
+#define DEBUG_CLAMP_LAST_CONTEXT   31
+//#define DEBUG_HARDER
+
+/* We don't use DEBUG because it tends to be compiled in always nowadays
+ * and this would generate way too much output
+ */
+#ifdef DEBUG_HARDER
+#define pr_hard(args...)	printk(KERN_DEBUG args)
+#define pr_hardcont(args...)	printk(KERN_CONT args)
+#else
+#define pr_hard(args...)	do { } while(0)
+#define pr_hardcont(args...)	do { } while(0)
+#endif
 
 #include <linux/kernel.h>
 #include <linux/mm.h>
@@ -71,7 +81,7 @@ static DEFINE_SPINLOCK(context_lock);
 static unsigned int steal_context_smp(unsigned int id)
 {
 	struct mm_struct *mm;
-	unsigned int cpu, max;
+	unsigned int cpu, max, i;
 
 	max = last_context - first_context;
 
@@ -89,15 +99,22 @@ static unsigned int steal_context_smp(un
 				id = first_context;
 			continue;
 		}
-		pr_devel("[%d] steal context %d from mm @%p\n",
-			 smp_processor_id(), id, mm);
+		pr_hardcont(" | steal %d from 0x%p", id, mm);
 
 		/* Mark this mm has having no context anymore */
 		mm->context.id = MMU_NO_CONTEXT;
 
-		/* Mark it stale on all CPUs that used this mm */
-		for_each_cpu(cpu, mm_cpumask(mm))
-			__set_bit(id, stale_map[cpu]);
+		/* Mark it stale on all CPUs that used this mm. For threaded
+		 * implementations, we set it on all threads on each core
+		 * represented in the mask. A future implementation will use
+		 * a core map instead but this will do for now.
+		 */
+		for_each_cpu(cpu, mm_cpumask(mm)) {
+			for (i = cpu_first_thread_in_core(cpu);
+			     i <= cpu_last_thread_in_core(cpu); i++)
+				__set_bit(id, stale_map[i]);
+			cpu = i - 1;
+		}
 		return id;
 	}
 
@@ -126,7 +143,7 @@ static unsigned int steal_context_up(uns
 	/* Pick up the victim mm */
 	mm = context_mm[id];
 
-	pr_devel("[%d] steal context %d from mm @%p\n", cpu, id, mm);
+	pr_hardcont(" | steal %d from 0x%p", id, mm);
 
 	/* Flush the TLB for that context */
 	local_flush_tlb_mm(mm);
@@ -179,19 +196,14 @@ void switch_mmu_context(struct mm_struct
 	/* No lockless fast path .. yet */
 	spin_lock(&context_lock);
 
-#ifndef DEBUG_STEAL_ONLY
-	pr_devel("[%d] activating context for mm @%p, active=%d, id=%d\n",
-		 cpu, next, next->context.active, next->context.id);
-#endif
+	pr_hard("[%d] activating context for mm @%p, active=%d, id=%d",
+		cpu, next, next->context.active, next->context.id);
 
 #ifdef CONFIG_SMP
 	/* Mark us active and the previous one not anymore */
 	next->context.active++;
 	if (prev) {
-#ifndef DEBUG_STEAL_ONLY
-		pr_devel(" old context %p active was: %d\n",
-			 prev, prev->context.active);
-#endif
+		pr_hardcont(" (old=0x%p a=%d)", prev, prev->context.active);
 		WARN_ON(prev->context.active < 1);
 		prev->context.active--;
 	}
@@ -201,8 +213,14 @@ void switch_mmu_context(struct mm_struct
 
 	/* If we already have a valid assigned context, skip all that */
 	id = next->context.id;
-	if (likely(id != MMU_NO_CONTEXT))
+	if (likely(id != MMU_NO_CONTEXT)) {
+#ifdef DEBUG_MAP_CONSISTENCY
+		if (context_mm[id] != next)
+			pr_err("MMU: mm 0x%p has id %d but context_mm[%d] says 0x%p\n",
+			       next, id, id, context_mm[id]);
+#endif
 		goto ctxt_ok;
+	}
 
 	/* We really don't have a context, let's try to acquire one */
 	id = next_context;
@@ -234,11 +252,7 @@ void switch_mmu_context(struct mm_struct
 	next_context = id + 1;
 	context_mm[id] = next;
 	next->context.id = id;
-
-#ifndef DEBUG_STEAL_ONLY
-	pr_devel("[%d] picked up new id %d, nrf is now %d\n",
-		 cpu, id, nr_free_contexts);
-#endif
+	pr_hardcont(" | new id=%d,nrf=%d", id, nr_free_contexts);
 
 	context_check_map();
  ctxt_ok:
@@ -247,15 +261,20 @@ void switch_mmu_context(struct mm_struct
 	 * local TLB for it and unmark it before we use it
 	 */
 	if (test_bit(id, stale_map[cpu])) {
-		pr_devel("[%d] flushing stale context %d for mm @%p !\n",
-			 cpu, id, next);
+		pr_hardcont(" | stale flush %d [%d..%d]",
+			    id, cpu_first_thread_in_core(cpu),
+			    cpu_last_thread_in_core(cpu));
+
 		local_flush_tlb_mm(next);
 
 		/* XXX This clear should ultimately be part of local_flush_tlb_mm */
-		__clear_bit(id, stale_map[cpu]);
+		for (cpu = cpu_first_thread_in_core(cpu);
+		     cpu <= cpu_last_thread_in_core(cpu); cpu++)
+			__clear_bit(id, stale_map[cpu]);
 	}
 
 	/* Flick the MMU and release lock */
+	pr_hardcont(" -> %d\n", id);
 	set_context(id, next->pgd);
 	spin_unlock(&context_lock);
 }
@@ -265,6 +284,8 @@ void switch_mmu_context(struct mm_struct
  */
 int init_new_context(struct task_struct *t, struct mm_struct *mm)
 {
+	pr_hard("initing context for mm @%p\n", mm);
+
 	mm->context.id = MMU_NO_CONTEXT;
 	mm->context.active = 0;
 
@@ -304,7 +325,9 @@ static int __cpuinit mmu_context_cpu_not
 					    unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned int)(long)hcpu;
-
+#ifdef CONFIG_HOTPLUG_CPU
+	struct task_struct *p;
+#endif
 	/* We don't touch CPU 0 map, it's allocated at aboot and kept
 	 * around forever
 	 */
@@ -323,8 +346,16 @@ static int __cpuinit mmu_context_cpu_not
 		pr_devel("MMU: Freeing stale context map for CPU %d\n", cpu);
 		kfree(stale_map[cpu]);
 		stale_map[cpu] = NULL;
-		break;
-#endif
+
+		/* We also clear the cpu_vm_mask bits of CPUs going away */
+		read_lock(&tasklist_lock);
+		for_each_process(p) {
+			if (p->mm)
+				cpu_mask_clear_cpu(cpu, mm_cpumask(p->mm));
+		}
+		read_unlock(&tasklist_lock);
+	break;
+#endif /* CONFIG_HOTPLUG_CPU */
 	}
 	return NOTIFY_OK;
 }
Index: linux-work/arch/powerpc/include/asm/cputhreads.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/cputhreads.h	2009-07-21 12:43:27.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/cputhreads.h	2009-07-21 12:56:16.000000000 +1000
@@ -5,6 +5,15 @@
 
 /*
  * Mapping of threads to cores
+ *
+ * Note: This implementation is limited to a power of 2 number of
+ * threads per core and the same number for each core in the system
+ * (though it would work if some processors had less threads as long
+ * as the CPU numbers are still allocated, just not brought offline).
+ *
+ * However, the API allows for a different implementation in the future
+ * if needed, as long as you only use the functions and not the variables
+ * directly.
  */
 
 #ifdef CONFIG_SMP
@@ -67,5 +76,12 @@ static inline int cpu_first_thread_in_co
 	return cpu & ~(threads_per_core - 1);
 }
 
+static inline int cpu_last_thread_in_core(int cpu)
+{
+	return cpu | (threads_per_core - 1);
+}
+
+
+
 #endif /* _ASM_POWERPC_CPUTHREADS_H */
 
Index: linux-work/arch/powerpc/mm/tlb_nohash.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/tlb_nohash.c	2009-07-21 12:43:31.000000000 +1000
+++ linux-work/arch/powerpc/mm/tlb_nohash.c	2009-07-21 12:57:21.000000000 +1000
@@ -87,6 +87,12 @@ EXPORT_SYMBOL(local_flush_tlb_page);
 
 static DEFINE_SPINLOCK(tlbivax_lock);
 
+static int mm_is_core_local(struct mm_struct *mm)
+{
+	return cpumask_subset(mm_cpumask(mm),
+			      topology_thread_cpumask(smp_processor_id()));
+}
+
 struct tlb_flush_param {
 	unsigned long addr;
 	unsigned int pid;
@@ -131,7 +137,7 @@ void flush_tlb_mm(struct mm_struct *mm)
 	pid = mm->context.id;
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		goto no_context;
-	if (!cpumask_equal(mm_cpumask(mm), cpumask_of(smp_processor_id()))) {
+	if (!mm_is_core_local(mm)) {
 		struct tlb_flush_param p = { .pid = pid };
 		/* Ignores smp_processor_id() even if set. */
 		smp_call_function_many(mm_cpumask(mm),
@@ -153,7 +159,7 @@ void flush_tlb_page(struct vm_area_struc
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		goto bail;
 	cpu_mask = mm_cpumask(vma->vm_mm);
-	if (!cpumask_equal(cpu_mask, cpumask_of(smp_processor_id()))) {
+	if (!mm_is_core_local(mm)) {
 		/* If broadcast tlbivax is supported, use it */
 		if (mmu_has_feature(MMU_FTR_USE_TLBIVAX_BCAST)) {
 			int lock = mmu_has_feature(MMU_FTR_LOCK_BCAST_INVAL);
