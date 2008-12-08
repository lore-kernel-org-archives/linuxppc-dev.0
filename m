Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 08 Dec 2008 16:40:43 +1100
Subject: [PATCH 6/9] powerpc: Rework context management for CPUs with no hash
	table
In-Reply-To: <1228714789.103940.266501677728.qpush@grosgo>
Message-Id: <20081208054130.13A16DDE19@ozlabs.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This reworks the context management code used by 4xx,8xx and
freescale BookE. It adds support for SMP by implementing a
concept of stale context map to lazily flush the TLB on
processors where a context may have been invalidated. This
also contains the ground work for generalizing such lazy TLB
flushing by just picking up a new PID and marking the old one
stale. This will be implemented later.

This is a first implementation that uses a global spinlock.

Ideally, we should try to get at least the fast path (context ID
already assigned) lockless or limited to a per context lock,
but for now this will do.

I tried to keep the UP case reasonably simple to avoid adding
too much overhead to 8xx which does a lot of context stealing
since it effectively has only 16 PIDs available.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/mmu-40x.h       |    5 
 arch/powerpc/include/asm/mmu-44x.h       |    5 
 arch/powerpc/include/asm/mmu-8xx.h       |    3 
 arch/powerpc/include/asm/mmu-fsl-booke.h |    5 
 arch/powerpc/include/asm/tlbflush.h      |    2 
 arch/powerpc/mm/mmu_context_nohash.c     |  246 +++++++++++++++++++++++++------
 6 files changed, 216 insertions(+), 50 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/mmu-40x.h	2008-09-29 14:21:37.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu-40x.h	2008-12-08 15:43:46.000000000 +1100
@@ -54,8 +54,9 @@
 #ifndef __ASSEMBLY__
 
 typedef struct {
-	unsigned long id;
-	unsigned long vdso_base;
+	unsigned int	id;
+	unsigned int	active;
+	unsigned long	vdso_base;
 } mm_context_t;
 
 #endif /* !__ASSEMBLY__ */
Index: linux-work/arch/powerpc/include/asm/mmu-44x.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu-44x.h	2008-09-29 14:21:37.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu-44x.h	2008-12-08 15:43:46.000000000 +1100
@@ -56,8 +56,9 @@
 extern unsigned int tlb_44x_hwater;
 
 typedef struct {
-	unsigned long id;
-	unsigned long vdso_base;
+	unsigned int	id;
+	unsigned int	active;
+	unsigned long	vdso_base;
 } mm_context_t;
 
 #endif /* !__ASSEMBLY__ */
Index: linux-work/arch/powerpc/include/asm/mmu-fsl-booke.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu-fsl-booke.h	2008-12-08 15:40:33.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/mmu-fsl-booke.h	2008-12-08 15:43:46.000000000 +1100
@@ -76,8 +76,9 @@
 #ifndef __ASSEMBLY__
 
 typedef struct {
-	unsigned long id;
-	unsigned long vdso_base;
+	unsigned int	id;
+	unsigned int	active;
+	unsigned long	vdso_base;
 } mm_context_t;
 #endif /* !__ASSEMBLY__ */
 
Index: linux-work/arch/powerpc/mm/mmu_context_nohash.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/mmu_context_nohash.c	2008-12-08 15:43:45.000000000 +1100
+++ linux-work/arch/powerpc/mm/mmu_context_nohash.c	2008-12-08 15:43:46.000000000 +1100
@@ -14,13 +14,29 @@
  *  as published by the Free Software Foundation; either version
  *  2 of the License, or (at your option) any later version.
  *
+ * TODO:
+ *
+ *   - The global context lock will not scale very well
+ *   - The maps should be dynamically allocated to allow for processors
+ *     that support more PID bits at runtime
+ *   - Implement flush_tlb_mm() by making the context stale and picking
+ *     a new one
+ *   - More aggressively clear stale map bits and maybe find some way to
+ *     also clear mm->cpu_vm_mask bits when processes are migrated
  */
 
+#undef DEBUG
+#define DEBUG_STEAL_ONLY
+
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/init.h>
 
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
+#include <linux/spinlock.h>
+
+#undef DEBUG_MAP_CONSISTENCY
 
 /*
  *   The MPC8xx has only 16 contexts.  We rotate through them on each
@@ -40,17 +56,14 @@
  */
 
 #ifdef CONFIG_8xx
-#define NO_CONTEXT      	16
 #define LAST_CONTEXT    	15
 #define FIRST_CONTEXT    	0
 
 #elif defined(CONFIG_4xx)
-#define NO_CONTEXT      	256
 #define LAST_CONTEXT    	255
 #define FIRST_CONTEXT    	1
 
 #elif defined(CONFIG_E200) || defined(CONFIG_E500)
-#define NO_CONTEXT      	256
 #define LAST_CONTEXT    	255
 #define FIRST_CONTEXT    	1
 
@@ -58,11 +71,11 @@
 #error Unsupported processor type
 #endif
 
-static unsigned long next_mmu_context;
+static unsigned int next_context, nr_free_contexts;
 static unsigned long context_map[LAST_CONTEXT / BITS_PER_LONG + 1];
-static atomic_t nr_free_contexts;
+static unsigned long stale_map[NR_CPUS][LAST_CONTEXT / BITS_PER_LONG + 1];
 static struct mm_struct *context_mm[LAST_CONTEXT+1];
-static void steal_context(void);
+static spinlock_t context_lock = SPIN_LOCK_UNLOCKED;
 
 /* Steal a context from a task that has one at the moment.
  * This is only used on 8xx and 4xx and we presently assume that
@@ -75,49 +88,187 @@ static void steal_context(void);
  * place to implement an LRU scheme if anyone was motivated to do it.
  *  -- paulus
  */
-static void steal_context(void)
+#include <asm/udbg.h>
+
+/*
+ * For context stealing, we use a slightly different approach for
+ * SMP and UP. Basically, the UP one is simpler and doesn't use
+ * the stale map as we can just flush the local CPU
+ */
+#ifdef CONFIG_SMP
+static unsigned int steal_context_smp(unsigned int id)
 {
 	struct mm_struct *mm;
+	unsigned int cpu, max;
 
-	/* free up context `next_mmu_context' */
-	/* if we shouldn't free context 0, don't... */
-	if (next_mmu_context < FIRST_CONTEXT)
-		next_mmu_context = FIRST_CONTEXT;
-	mm = context_mm[next_mmu_context];
-	flush_tlb_mm(mm);
-	destroy_context(mm);
-}
+ again:
+	max = LAST_CONTEXT - FIRST_CONTEXT;
 
+	/* Attempt to free next_context first and then loop until we manage */
+	while (max--) {
+		/* Pick up the victim mm */
+		mm = context_mm[id];
+
+		/* We have a candidate victim, check if it's active, on SMP
+		 * we cannot steal active contexts
+		 */
+		if (mm->context.active) {
+			id ++;
+			if (id > LAST_CONTEXT)
+				id = FIRST_CONTEXT;
+			continue;
+		}
+		pr_debug("[%d] steal context %d from mm @%p\n",
+			 smp_processor_id(), id, mm);
+
+		/* Mark this mm has having no context anymore */
+		mm->context.id = MMU_NO_CONTEXT;
+
+		/* Mark it stale on all CPUs that used this mm */
+		for_each_cpu_mask_nr(cpu, mm->cpu_vm_mask)
+			__set_bit(id, stale_map[cpu]);
+		return id;
+	}
 
-/*
- * Get a new mmu context for the address space described by `mm'.
+	/* This will happen if you have more CPUs than available contexts,
+	 * all we can do here is wait a bit and try again
+	 */
+	spin_unlock(&context_lock);
+	cpu_relax();
+	spin_lock(&context_lock);
+	goto again;
+}
+#endif  /* CONFIG_SMP */
+
+/* Note that this will also be called on SMP if all other CPUs are
+ * offlined, which means that it may be called for cpu != 0. For
+ * this to work, we somewhat assume that CPUs that are onlined
+ * come up with a fully clean TLB (or are cleaned when offlined)
  */
-static inline void get_mmu_context(struct mm_struct *mm)
+static unsigned int steal_context_up(unsigned int id)
 {
-	unsigned long ctx;
+	struct mm_struct *mm;
+	int cpu = smp_processor_id();
 
-	if (mm->context.id != NO_CONTEXT)
-		return;
+	/* Pick up the victim mm */
+	mm = context_mm[id];
+
+	pr_debug("[%d] steal context %d from mm @%p\n", cpu, id, mm);
+
+	/* Mark this mm has having no context anymore */
+	mm->context.id = MMU_NO_CONTEXT;
 
-	while (atomic_dec_if_positive(&nr_free_contexts) < 0)
-		steal_context();
+	/* Flush the TLB for that context */
+	local_flush_tlb_mm(mm);
+
+	/* XXX This clear should ultimately be part of local_flush_tlb_mm */
+	__clear_bit(id, stale_map[cpu]);
+
+	return id;
+}
+
+#ifdef DEBUG_MAP_CONSISTENCY
+static void context_check_map(void)
+{
+	unsigned int id, nrf;
 
-	ctx = next_mmu_context;
-	while (test_and_set_bit(ctx, context_map)) {
-		ctx = find_next_zero_bit(context_map, LAST_CONTEXT+1, ctx);
-		if (ctx > LAST_CONTEXT)
-			ctx = 0;
-	}
-	next_mmu_context = (ctx + 1) & LAST_CONTEXT;
-	mm->context.id = ctx;
-	context_mm[ctx] = mm;
+	nrf = 0;
+	for (id = FIRST_CONTEXT; id <= LAST_CONTEXT; id++) {
+		int used = test_bit(id, context_map);
+		if (!used)
+			nrf++;
+		if (used != (context_mm[id] != NULL))
+			pr_err("MMU: Context %d is %s and MM is %p !\n",
+			       id, used ? "used" : "free", context_mm[id]);
+	}
+	if (nrf != nr_free_contexts) {
+		pr_err("MMU: Free context count out of sync ! (%d vs %d)\n",
+		       nr_free_contexts, nrf);
+		nr_free_contexts = nrf;
+	}
 }
+#else
+static void context_check_map(void) { }
+#endif
 
 void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
 {
-	get_mmu_context(next);
+	unsigned int id, cpu = smp_processor_id();
+	unsigned long *map;
+
+	/* No lockless fast path .. yet */
+	spin_lock(&context_lock);
 
-	set_context(next->context.id, next->pgd);
+#ifndef DEBUG_STEAL_ONLY
+	pr_debug("[%d] activating context for mm @%p, active=%d, id=%d\n",
+		 cpu, next, next->context.active, next->context.id);
+#endif
+
+#ifdef CONFIG_SMP
+	/* Mark us active and the previous one not anymore */
+	next->context.active++;
+	if (prev)
+		prev->context.active--;
+#endif /* CONFIG_SMP */
+
+	/* If we already have a valid assigned context, skip all that */
+	id = next->context.id;
+	if (likely(id != MMU_NO_CONTEXT))
+		goto ctxt_ok;
+
+	/* We really don't have a context, let's try to acquire one */
+	id = next_context;
+	if (id > LAST_CONTEXT)
+		id = FIRST_CONTEXT;
+	map = context_map;
+
+	/* No more free contexts, let's try to steal one */
+	if (nr_free_contexts == 0) {
+#ifdef CONFIG_SMP
+		if (num_online_cpus() > 1) {
+			id = steal_context_smp(id);
+			goto stolen;
+		}
+#endif /* CONFIG_SMP */
+		id = steal_context_up(id);
+		goto stolen;
+	}
+	nr_free_contexts--;
+
+	/* We know there's at least one free context, try to find it */
+	while (__test_and_set_bit(id, map)) {
+		id = find_next_zero_bit(map, LAST_CONTEXT+1, id);
+		if (id > LAST_CONTEXT)
+			id = FIRST_CONTEXT;
+	}
+ stolen:
+	next_context = id + 1;
+	context_mm[id] = next;
+	next->context.id = id;
+
+#ifndef DEBUG_STEAL_ONLY
+	pr_debug("[%d] picked up new id %d, nrf is now %d\n",
+		 cpu, id, nr_free_contexts);
+#endif
+
+	context_check_map();
+ ctxt_ok:
+
+	/* If that context got marked stale on this CPU, then flush the
+	 * local TLB for it and unmark it before we use it
+	 */
+	if (test_bit(id, stale_map[cpu])) {
+		pr_debug("[%d] flushing stale context %d for mm @%p !\n",
+			 cpu, id, next);
+		local_flush_tlb_mm(next);
+
+		/* XXX This clear should ultimately be part of local_flush_tlb_mm */
+		__clear_bit(id, stale_map[cpu]);
+	}
+
+	/* Flick the MMU and release lock */
+	set_context(id, next->pgd);
+	spin_unlock(&context_lock);
 }
 
 /*
@@ -125,7 +276,7 @@ void switch_mmu_context(struct mm_struct
  */
 int init_new_context(struct task_struct *t, struct mm_struct *mm)
 {
-	mm->context.id = NO_CONTEXT;
+	mm->context.id = MMU_NO_CONTEXT;
 	return 0;
 }
 
@@ -134,13 +285,22 @@ int init_new_context(struct task_struct 
  */
 void destroy_context(struct mm_struct *mm)
 {
-	preempt_disable();
-	if (mm->context.id != NO_CONTEXT) {
-		clear_bit(mm->context.id, context_map);
-		mm->context.id = NO_CONTEXT;
-		atomic_inc(&nr_free_contexts);
+	unsigned int id;
+
+	if (mm->context.id == MMU_NO_CONTEXT)
+		return;
+
+	spin_lock(&context_lock);
+	id = mm->context.id;
+	if (id != MMU_NO_CONTEXT) {
+		__clear_bit(id, context_map);
+		mm->context.id = MMU_NO_CONTEXT;
+#ifdef DEBUG_MAP_CONSISTENCY
+		context_mm[id] = NULL;
+#endif
+		nr_free_contexts++;
 	}
-	preempt_enable();
+	spin_unlock(&context_lock);
 }
 
 
@@ -156,7 +316,7 @@ void __init mmu_context_init(void)
 	 * This code assumes FIRST_CONTEXT < 32.
 	 */
 	context_map[0] = (1 << FIRST_CONTEXT) - 1;
-	next_mmu_context = FIRST_CONTEXT;
-	atomic_set(&nr_free_contexts, LAST_CONTEXT - FIRST_CONTEXT + 1);
+	next_context = FIRST_CONTEXT;
+	nr_free_contexts = LAST_CONTEXT - FIRST_CONTEXT + 1;
 }
 
Index: linux-work/arch/powerpc/include/asm/tlbflush.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/tlbflush.h	2008-12-08 15:43:45.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/tlbflush.h	2008-12-08 15:43:46.000000000 +1100
@@ -29,6 +29,8 @@
 
 #include <linux/mm.h>
 
+#define MMU_NO_CONTEXT      	((unsigned int)-1)
+
 extern void _tlbie(unsigned long address, unsigned int pid);
 extern void _tlbil_all(void);
 extern void _tlbil_pid(unsigned int pid);
Index: linux-work/arch/powerpc/include/asm/mmu-8xx.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu-8xx.h	2008-09-29 14:21:37.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu-8xx.h	2008-12-08 15:43:46.000000000 +1100
@@ -137,7 +137,8 @@
 
 #ifndef __ASSEMBLY__
 typedef struct {
-	unsigned long id;
+	unsigned int id;
+	unsigned int active;
 	unsigned long vdso_base;
 } mm_context_t;
 #endif /* !__ASSEMBLY__ */
