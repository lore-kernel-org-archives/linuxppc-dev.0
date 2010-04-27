Return-Path: <anton@ozlabs.org>
Message-Id: <20100427013432.752277007@samba.org>
Date: Tue, 27 Apr 2010 11:32:44 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 rusty@rustcorp.com.au
Subject: [patch 13/15] powerpc: cpumask: Update some comments
References: <20100427013231.510168034@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since the *_map cpumask variants are deprecated, change the comments to
instead refer to *_mask.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/kernel/setup-common.c	2010-04-22 13:19:24.536696551 +1000
+++ linux-cpumask/arch/powerpc/kernel/setup-common.c	2010-04-22 13:25:56.655446062 +1000
@@ -394,14 +394,14 @@ static void __init cpu_init_thread_core_
 
 /**
  * setup_cpu_maps - initialize the following cpu maps:
- *                  cpu_possible_map
- *                  cpu_present_map
+ *                  cpu_possible_mask
+ *                  cpu_present_mask
  *
  * Having the possible map set up early allows us to restrict allocations
  * of things like irqstacks to num_possible_cpus() rather than NR_CPUS.
  *
  * We do not initialize the online map here; cpus set their own bits in
- * cpu_online_map as they come up.
+ * cpu_online_mask as they come up.
  *
  * This function is valid only for Open Firmware systems.  finish_device_tree
  * must be called before using this.
Index: linux-cpumask/arch/powerpc/kernel/smp.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/kernel/smp.c	2010-04-22 13:03:22.545446024 +1000
+++ linux-cpumask/arch/powerpc/kernel/smp.c	2010-04-22 13:25:56.655446062 +1000
@@ -468,7 +468,7 @@ out:
 	return id;
 }
 
-/* Must be called when no change can occur to cpu_present_map,
+/* Must be called when no change can occur to cpu_present_mask,
  * i.e. during cpu online or offline.
  */
 static struct device_node *cpu_to_l2cache(int cpu)
Index: linux-cpumask/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/powermac/setup.c	2010-04-07 09:18:12.016695779 +1000
+++ linux-cpumask/arch/powerpc/platforms/powermac/setup.c	2010-04-22 13:25:56.665445906 +1000
@@ -480,7 +480,7 @@ static void __init pmac_init_early(void)
 #endif
 
 	/* SMP Init has to be done early as we need to patch up
-	 * cpu_possible_map before interrupt stacks are allocated
+	 * cpu_possible_mask before interrupt stacks are allocated
 	 * or kaboom...
 	 */
 #ifdef CONFIG_SMP
Index: linux-cpumask/arch/powerpc/platforms/powermac/smp.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/powermac/smp.c	2010-02-27 09:45:02.816822011 +1100
+++ linux-cpumask/arch/powerpc/platforms/powermac/smp.c	2010-04-22 13:26:27.485445638 +1000
@@ -315,7 +315,7 @@ static int __init smp_psurge_probe(void)
 	/* This is necessary because OF doesn't know about the
 	 * secondary cpu(s), and thus there aren't nodes in the
 	 * device tree for them, and smp_setup_cpu_maps hasn't
-	 * set their bits in cpu_present_map.
+	 * set their bits in cpu_present_mask.
 	 */
 	if (ncpus > NR_CPUS)
 		ncpus = NR_CPUS;
@@ -944,7 +944,7 @@ void __init pmac_setup_smp(void)
 	}
 #ifdef CONFIG_PPC32
 	else {
-		/* We have to set bits in cpu_possible_map here since the
+		/* We have to set bits in cpu_possible_mask here since the
 		 * secondary CPU(s) aren't in the device tree. Various
 		 * things won't be initialized for CPUs not in the possible
 		 * map, so we really need to fix it up here.
Index: linux-cpumask/arch/powerpc/platforms/pseries/hotplug-cpu.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/pseries/hotplug-cpu.c	2010-04-22 13:27:02.755445663 +1000
+++ linux-cpumask/arch/powerpc/platforms/pseries/hotplug-cpu.c	2010-04-22 13:27:13.025733412 +1000
@@ -245,7 +245,7 @@ static void pseries_cpu_die(unsigned int
 }
 
 /*
- * Update cpu_present_map and paca(s) for a new cpu node.  The wrinkle
+ * Update cpu_present_mask and paca(s) for a new cpu node.  The wrinkle
  * here is that a cpu device node may represent up to two logical cpus
  * in the SMT case.  We must honor the assumption in other code that
  * the logical ids for sibling SMT threads x and y are adjacent, such
@@ -293,7 +293,7 @@ static int pseries_add_processor(struct 
 			cpumask_shift_left(tmp, tmp, nthreads);
 
 	if (cpumask_empty(tmp)) {
-		printk(KERN_ERR "Unable to find space in cpu_present_map for"
+		printk(KERN_ERR "Unable to find space in cpu_present_mask for"
 		       " processor %s with %d thread(s)\n", np->name,
 		       nthreads);
 		goto out_unlock;
