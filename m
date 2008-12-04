Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 04 Dec 2008 16:41:53 +1100
Subject: [PATCH 3/3] powerpc: Rework context management for CPUs with no hash
	table
Message-Id: <20081204054232.2554CDDE2A@ozlabs.org>
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
 arch/powerpc/include/asm/mmu-fsl-booke.h |    5 
 arch/powerpc/mm/mmu_context_nohash.c     |  258 ++++++++++++++++++++++++-------
 4 files changed, 217 insertions(+), 56 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/mmu-40x.h	2008-12-04 15:02:19.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/mmu-40x.h	2008-12-04 15:04:03.000000000 +1100
@@ -54,8 +54,9 @@
 #ifndef __ASSEMBLY__
 
 typedef struct {
-	unsigned long id;
-	unsigned long vdso_base;
+	unsigned short	id;
+	unsigned short	active;
+	unsigned long	vdso_base;
 } mm_context_t;
 
 #endif /* !__ASSEMBLY__ */
Index: linux-work/arch/powerpc/include/asm/mmu-44x.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu-44x.h	2008-12-04 15:02:19.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/mmu-44x.h	2008-12-04 15:04:03.000000000 +1100
@@ -56,8 +56,9 @@
 extern unsigned int tlb_44x_hwater;
 
 typedef struct {
-	unsigned long id;
-	unsigned long vdso_base;
+	unsigned short	id;
+	unsigned short	active;
+	unsigned long	vdso_base;
 } mm_context_t;
 
 #endif /* !__ASSEMBLY__ */
Index: linux-work/arch/powerpc/include/asm/mmu-fsl-booke.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu-fsl-booke.h	2008-12-04 15:02:19.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/mmu-fsl-booke.h	2008-12-04 15:04:03.000000000 +1100
@@ -74,8 +74,9 @@
 #ifndef __ASSEMBLY__
 
 typedef struct {
-	unsigned long id;
-	unsigned long vdso_base;
+	unsigned short	id;
+	unsigned short	active;
+	unsigned long	vdso_base;
 } mm_context_t;
 #endif /* !__ASSEMBLY__ */
 
Index: linux-work/arch/powerpc/mm/mmu_context_nohash.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/mmu_context_nohash.c	2008-12-04 15:04:03.000000000 +1100
+++ linux-work/arch/powerpc/mm/mmu_context_nohash.c	2008-12-04 15:18:46.000000000 +1100
@@ -1,32 +1,43 @@
 /*
  * This file contains the routines for handling the MMU on those
- * PowerPC implementations where the MMU substantially follows the
- * architecture specification.  This includes the 6xx, 7xx, 7xxx,
- * 8260, and POWER3 implementations but excludes the 8xx and 4xx.
- *  -- paulus
- *
- *  Derived from arch/ppc/mm/init.c:
- *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
+ * PowerPC implementations where the MMU is not using the hash
+ * table, such as 8xx, 4xx, BookE's etc...
  *
- *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
- *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
- *    Copyright (C) 1996 Paul Mackerras
+ * Copyright 2008 Ben Herrenschmidt <benh@kernel.crashing.org>
+ *                IBM Corp.
  *
- *  Derived from "arch/i386/mm/init.c"
- *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
+ *  Derived from previous arch/powerpc/mm/mmu_context.c
+ *  and arch/powerpc/include/asm/mmu_context.h
  *
  *  This program is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU General Public License
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
+ *
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
@@ -64,11 +75,11 @@
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
@@ -81,49 +92,187 @@ static void steal_context(void);
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
 
-/*
- * Get a new mmu context for the address space described by `mm'.
+		/* Mark this mm has having no context anymore */
+		mm->context.id = NO_CONTEXT;
+
+		/* Mark it stale on all CPUs that used this mm */
+		for_each_cpu_mask_nr(cpu, mm->cpu_vm_mask)
+			__set_bit(id, stale_map[cpu]);
+		return id;
+	}
+
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
+	mm->context.id = NO_CONTEXT;
+
+	/* Flush the TLB for that context */
+	local_flush_tlb_mm(mm);
 
-	while (atomic_dec_if_positive(&nr_free_contexts) < 0)
-		steal_context();
+	/* XXX This clear should ultimately be part of local_flush_tlb_mm */
+	__clear_bit(id, stale_map[cpu]);
 
-	ctx = next_mmu_context;
-	while (test_and_set_bit(ctx, context_map)) {
-		ctx = find_next_zero_bit(context_map, LAST_CONTEXT+1, ctx);
-		if (ctx > LAST_CONTEXT)
-			ctx = 0;
-	}
-	next_mmu_context = (ctx + 1) & LAST_CONTEXT;
-	mm->context.id = ctx;
-	context_mm[ctx] = mm;
+	return id;
 }
 
+#ifdef DEBUG_MAP_CONSISTENCY
+static void context_check_map(void)
+{
+	unsigned int id, nrf;
+
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
+}
+#else
+static void context_check_map(void) { }
+#endif
+
 void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
 {
-	get_mmu_context(next);
+	unsigned int id, cpu = smp_processor_id();
+	unsigned long *map;
+
+	/* No lockless fast path .. yet */
+	spin_lock(&context_lock);
+
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
+	if (likely(id != NO_CONTEXT))
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
+#ifdef CONFIF_SMP
+		if (num_online_cpus() > 1) {
+			id = steal_context_smp(id);
+			goto stolen;
+		}
+#endif /* CONFIG_SMP */
+		id = steal_context_up(id);
+		goto stolen;
+	}
+	nr_free_contexts--;
 
-	set_context(next->context.id, next->pgd);
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
@@ -140,13 +289,22 @@ int init_new_context(struct task_struct 
  */
 void destroy_context(struct mm_struct *mm)
 {
-	preempt_disable();
-	if (mm->context.id != NO_CONTEXT) {
-		clear_bit(mm->context.id, context_map);
+	unsigned int id;
+
+	if (mm->context.id == NO_CONTEXT)
+		return;
+
+	spin_lock(&context_lock);
+	id = mm->context.id;
+	if (id != NO_CONTEXT) {
+		__clear_bit(id, context_map);
 		mm->context.id = NO_CONTEXT;
-		atomic_inc(&nr_free_contexts);
+#ifdef DEBUG_MAP_CONSISTENCY
+		context_mm[id] = NULL;
+#endif
+		nr_free_contexts++;
 	}
-	preempt_enable();
+	spin_unlock(&context_lock);
 }
 
 
@@ -162,7 +320,7 @@ void __init mmu_context_init(void)
 	 * This code assumes FIRST_CONTEXT < 32.
 	 */
 	context_map[0] = (1 << FIRST_CONTEXT) - 1;
-	next_mmu_context = FIRST_CONTEXT;
-	atomic_set(&nr_free_contexts, LAST_CONTEXT - FIRST_CONTEXT + 1);
+	next_context = FIRST_CONTEXT;
+	nr_free_contexts = LAST_CONTEXT - FIRST_CONTEXT + 1;
 }
 
