Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 19 Dec 2008 16:13:48 +1100
Subject: [PATCH 8/10] powerpc/mm: Runtime allocation of mmu context maps for
	nohash CPUs v2
In-Reply-To: <1229663599.904385.502157196243.qpush@grosgo>
Message-Id: <20081219051452.E3FE2DDFDC@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This makes the MMU context code used for CPUs with no hash table
(except 603) dynamically allocate the various maps used to track
the state of contexts.

Only the main free map and CPU 0 stale map are allocated at boot
time. Other CPU maps are allocated when those CPUs are brought up
and freed if they are unplugged.

This also moves the initialization of the MMU context management
slightly later during the boot process, which should be fine as
it's really only needed when userland if first started anyways.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2. rebased and add some more debug

 arch/powerpc/kernel/setup_32.c       |    5 +
 arch/powerpc/mm/init_32.c            |    4 
 arch/powerpc/mm/mmu_context_nohash.c |  161 ++++++++++++++++++++++++-----------
 3 files changed, 116 insertions(+), 54 deletions(-)

--- linux-work.orig/arch/powerpc/mm/mmu_context_nohash.c	2008-12-19 16:06:46.000000000 +1100
+++ linux-work/arch/powerpc/mm/mmu_context_nohash.c	2008-12-19 16:07:05.000000000 +1100
@@ -28,54 +28,30 @@
 #undef DEBUG
 #define DEBUG_STEAL_ONLY
 #undef DEBUG_MAP_CONSISTENCY
+/*#define DEBUG_CLAMP_LAST_CONTEXT   15 */
 
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/bootmem.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
 
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
-#include <linux/spinlock.h>
-
-/*
- *   The MPC8xx has only 16 contexts.  We rotate through them on each
- * task switch.  A better way would be to keep track of tasks that
- * own contexts, and implement an LRU usage.  That way very active
- * tasks don't always have to pay the TLB reload overhead.  The
- * kernel pages are mapped shared, so the kernel can run on behalf
- * of any task that makes a kernel entry.  Shared does not mean they
- * are not protected, just that the ASID comparison is not performed.
- *      -- Dan
- *
- * The IBM4xx has 256 contexts, so we can just rotate through these
- * as a way of "switching" contexts.  If the TID of the TLB is zero,
- * the PID/TID comparison is disabled, so we can use a TID of zero
- * to represent all kernel pages as shared among all contexts.
- * 	-- Dan
- */
-
-#ifdef CONFIG_8xx
-#define LAST_CONTEXT    	15
-#define FIRST_CONTEXT    	0
-
-#elif defined(CONFIG_4xx)
-#define LAST_CONTEXT    	255
-#define FIRST_CONTEXT    	1
-
-#elif defined(CONFIG_E200) || defined(CONFIG_E500)
-#define LAST_CONTEXT    	255
-#define FIRST_CONTEXT    	1
-
-#else
-#error Unsupported processor type
-#endif
 
+static unsigned int first_context, last_context;
 static unsigned int next_context, nr_free_contexts;
-static unsigned long context_map[LAST_CONTEXT / BITS_PER_LONG + 1];
-static unsigned long stale_map[NR_CPUS][LAST_CONTEXT / BITS_PER_LONG + 1];
-static struct mm_struct *context_mm[LAST_CONTEXT+1];
+static unsigned long *context_map;
+static unsigned long *stale_map[NR_CPUS];
+static struct mm_struct **context_mm;
 static spinlock_t context_lock = SPIN_LOCK_UNLOCKED;
 
+#define CTX_MAP_SIZE	\
+	(sizeof(unsigned long) * (last_context / BITS_PER_LONG + 1))
+
+
 /* Steal a context from a task that has one at the moment.
  *
  * This is used when we are running out of available PID numbers
@@ -98,7 +74,7 @@ static unsigned int steal_context_smp(un
 	unsigned int cpu, max;
 
  again:
-	max = LAST_CONTEXT - FIRST_CONTEXT;
+	max = last_context - first_context;
 
 	/* Attempt to free next_context first and then loop until we manage */
 	while (max--) {
@@ -110,8 +86,8 @@ static unsigned int steal_context_smp(un
 		 */
 		if (mm->context.active) {
 			id ++;
-			if (id > LAST_CONTEXT)
-				id = FIRST_CONTEXT;
+			if (id > last_context)
+				id = first_context;
 			continue;
 		}
 		pr_debug("[%d] steal context %d from mm @%p\n",
@@ -169,7 +145,7 @@ static void context_check_map(void)
 	unsigned int id, nrf, nact;
 
 	nrf = nact = 0;
-	for (id = FIRST_CONTEXT; id <= LAST_CONTEXT; id++) {
+	for (id = first_context; id <= last_context; id++) {
 		int used = test_bit(id, context_map);
 		if (!used)
 			nrf++;
@@ -187,6 +163,8 @@ static void context_check_map(void)
 	if (nact > num_online_cpus())
 		pr_err("MMU: More active contexts than CPUs ! (%d vs %d)\n",
 		       nact, num_online_cpus());
+	if (first_context > 0 && !test_bit(0, context_map))
+		pr_err("MMU: Context 0 has been freed !!!\n");
 }
 #else
 static void context_check_map(void) { }
@@ -209,6 +187,10 @@ void switch_mmu_context(struct mm_struct
 	/* Mark us active and the previous one not anymore */
 	next->context.active++;
 	if (prev) {
+#ifndef DEBUG_STEAL_ONLY
+		pr_debug(" old context %p active was: %d\n",
+			 prev, prev->context.active);
+#endif
 		WARN_ON(prev->context.active < 1);
 		prev->context.active--;
 	}
@@ -221,8 +203,8 @@ void switch_mmu_context(struct mm_struct
 
 	/* We really don't have a context, let's try to acquire one */
 	id = next_context;
-	if (id > LAST_CONTEXT)
-		id = FIRST_CONTEXT;
+	if (id > last_context)
+		id = first_context;
 	map = context_map;
 
 	/* No more free contexts, let's try to steal one */
@@ -240,9 +222,9 @@ void switch_mmu_context(struct mm_struct
 
 	/* We know there's at least one free context, try to find it */
 	while (__test_and_set_bit(id, map)) {
-		id = find_next_zero_bit(map, LAST_CONTEXT+1, id);
-		if (id > LAST_CONTEXT)
-			id = FIRST_CONTEXT;
+		id = find_next_zero_bit(map, last_context+1, id);
+		if (id > last_context)
+			id = first_context;
 	}
  stolen:
 	next_context = id + 1;
@@ -311,6 +293,42 @@ void destroy_context(struct mm_struct *m
 	spin_unlock(&context_lock);
 }
 
+#ifdef CONFIG_SMP
+
+static int __cpuinit mmu_context_cpu_notify(struct notifier_block *self,
+					    unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned int)(long)hcpu;
+
+	/* We don't touch CPU 0 map, it's allocated at aboot and kept
+	 * around forever
+	 */
+	if (cpu == 0)
+		return NOTIFY_OK;
+
+	switch (action) {
+	case CPU_ONLINE:
+	case CPU_ONLINE_FROZEN:
+		pr_debug("MMU: Allocating stale context map for CPU %d\n", cpu);
+		stale_map[cpu] = kzalloc(CTX_MAP_SIZE, GFP_KERNEL);
+		break;
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_DEAD:
+	case CPU_DEAD_FROZEN:
+		pr_debug("MMU: Freeing stale context map for CPU %d\n", cpu);
+		kfree(stale_map[cpu]);
+		stale_map[cpu] = NULL;
+		break;
+#endif
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __cpuinitdata mmu_context_cpu_nb = {
+	.notifier_call	= mmu_context_cpu_notify,
+};
+
+#endif /* CONFIG_SMP */
 
 /*
  * Initialize the context management stuff.
@@ -324,13 +342,56 @@ void __init mmu_context_init(void)
 	init_mm.context.active = NR_CPUS;
 
 	/*
+	 *   The MPC8xx has only 16 contexts.  We rotate through them on each
+	 * task switch.  A better way would be to keep track of tasks that
+	 * own contexts, and implement an LRU usage.  That way very active
+	 * tasks don't always have to pay the TLB reload overhead.  The
+	 * kernel pages are mapped shared, so the kernel can run on behalf
+	 * of any task that makes a kernel entry.  Shared does not mean they
+	 * are not protected, just that the ASID comparison is not performed.
+	 *      -- Dan
+	 *
+	 * The IBM4xx has 256 contexts, so we can just rotate through these
+	 * as a way of "switching" contexts.  If the TID of the TLB is zero,
+	 * the PID/TID comparison is disabled, so we can use a TID of zero
+	 * to represent all kernel pages as shared among all contexts.
+	 * 	-- Dan
+	 */
+	if (mmu_has_feature(MMU_FTR_TYPE_8xx)) {
+		first_context = 0;
+		last_context = 15;
+	} else {
+		first_context = 1;
+		last_context = 255;
+	}
+
+#ifdef DEBUG_CLAMP_LAST_CONTEXT
+	last_context = DEBUG_CLAMP_LAST_CONTEXT;
+#endif
+	/*
+	 * Allocate the maps used by context management
+	 */
+	context_map = alloc_bootmem(CTX_MAP_SIZE);
+	context_mm = alloc_bootmem(sizeof(void *) * (last_context + 1));
+	stale_map[0] = alloc_bootmem(CTX_MAP_SIZE);
+
+#ifdef CONFIG_SMP
+	register_cpu_notifier(&mmu_context_cpu_nb);
+#endif
+
+	printk(KERN_INFO
+	       "MMU: Allocated %d bytes of context maps for %d contexts\n",
+	       2 * CTX_MAP_SIZE + (sizeof(void *) * (last_context + 1)),
+	       last_context - first_context + 1);
+
+	/*
 	 * Some processors have too few contexts to reserve one for
 	 * init_mm, and require using context 0 for a normal task.
 	 * Other processors reserve the use of context zero for the kernel.
-	 * This code assumes FIRST_CONTEXT < 32.
+	 * This code assumes first_context < 32.
 	 */
-	context_map[0] = (1 << FIRST_CONTEXT) - 1;
-	next_context = FIRST_CONTEXT;
-	nr_free_contexts = LAST_CONTEXT - FIRST_CONTEXT + 1;
+	context_map[0] = (1 << first_context) - 1;
+	next_context = first_context;
+	nr_free_contexts = last_context - first_context + 1;
 }
 
Index: linux-work/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_32.c	2008-12-19 16:07:01.000000000 +1100
+++ linux-work/arch/powerpc/kernel/setup_32.c	2008-12-19 16:07:05.000000000 +1100
@@ -38,6 +38,7 @@
 #include <asm/time.h>
 #include <asm/serial.h>
 #include <asm/udbg.h>
+#include <asm/mmu_context.h>
 
 #include "setup.h"
 
@@ -330,4 +331,8 @@ void __init setup_arch(char **cmdline_p)
 	if ( ppc_md.progress ) ppc_md.progress("arch: exit", 0x3eab);
 
 	paging_init();
+
+	/* Initialize the MMU context management stuff */
+	mmu_context_init();
+
 }
Index: linux-work/arch/powerpc/mm/init_32.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/init_32.c	2008-12-19 15:42:28.000000000 +1100
+++ linux-work/arch/powerpc/mm/init_32.c	2008-12-19 16:07:05.000000000 +1100
@@ -35,7 +35,6 @@
 #include <asm/pgalloc.h>
 #include <asm/prom.h>
 #include <asm/io.h>
-#include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/mmu.h>
 #include <asm/smp.h>
@@ -180,9 +179,6 @@ void __init MMU_init(void)
 	if (ppc_md.progress)
 		ppc_md.progress("MMU:setio", 0x302);
 
-	/* Initialize the context management stuff */
-	mmu_context_init();
-
 	if (ppc_md.progress)
 		ppc_md.progress("MMU:exit", 0x211);
 
