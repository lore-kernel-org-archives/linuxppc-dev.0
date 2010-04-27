Return-Path: <anton@ozlabs.org>
Message-Id: <20100427013432.565344579@samba.org>
Date: Tue, 27 Apr 2010 11:32:42 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 rusty@rustcorp.com.au
Subject: [patch 11/15] powerpc: cpumask: Convert hotplug-cpu code to new
	cpumask API
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

Convert hotplug-cpu code to new cpumask API.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/platforms/pseries/hotplug-cpu.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/pseries/hotplug-cpu.c	2010-04-08 19:46:03.437946780 +1000
+++ linux-cpumask/arch/powerpc/platforms/pseries/hotplug-cpu.c	2010-04-22 13:03:25.075445756 +1000
@@ -187,7 +187,7 @@ static int pseries_cpu_disable(void)
 
 	/*fix boot_cpuid here*/
 	if (cpu == boot_cpuid)
-		boot_cpuid = any_online_cpu(cpu_online_map);
+		boot_cpuid = cpumask_any(cpu_online_mask);
 
 	/* FIXME: abstract this to not be platform specific later on */
 	xics_migrate_irqs_away();
@@ -254,7 +254,7 @@ static void pseries_cpu_die(unsigned int
 static int pseries_add_processor(struct device_node *np)
 {
 	unsigned int cpu;
-	cpumask_t candidate_map, tmp = CPU_MASK_NONE;
+	cpumask_var_t candidate_mask, tmp;
 	int err = -ENOSPC, len, nthreads, i;
 	const u32 *intserv;
 
@@ -262,48 +262,53 @@ static int pseries_add_processor(struct 
 	if (!intserv)
 		return 0;
 
+	zalloc_cpumask_var(&candidate_mask, GFP_KERNEL);
+	zalloc_cpumask_var(&tmp, GFP_KERNEL);
+
 	nthreads = len / sizeof(u32);
 	for (i = 0; i < nthreads; i++)
-		cpu_set(i, tmp);
+		cpumask_set_cpu(i, tmp);
 
 	cpu_maps_update_begin();
 
-	BUG_ON(!cpus_subset(cpu_present_map, cpu_possible_map));
+	BUG_ON(!cpumask_subset(cpu_present_mask, cpu_possible_mask));
 
 	/* Get a bitmap of unoccupied slots. */
-	cpus_xor(candidate_map, cpu_possible_map, cpu_present_map);
-	if (cpus_empty(candidate_map)) {
+	cpumask_xor(candidate_mask, cpu_possible_mask, cpu_present_mask);
+	if (cpumask_empty(candidate_mask)) {
 		/* If we get here, it most likely means that NR_CPUS is
 		 * less than the partition's max processors setting.
 		 */
 		printk(KERN_ERR "Cannot add cpu %s; this system configuration"
 		       " supports %d logical cpus.\n", np->full_name,
-		       cpus_weight(cpu_possible_map));
+		       cpumask_weight(cpu_possible_mask));
 		goto out_unlock;
 	}
 
-	while (!cpus_empty(tmp))
-		if (cpus_subset(tmp, candidate_map))
+	while (!cpumask_empty(tmp))
+		if (cpumask_subset(tmp, candidate_mask))
 			/* Found a range where we can insert the new cpu(s) */
 			break;
 		else
-			cpus_shift_left(tmp, tmp, nthreads);
+			cpumask_shift_left(tmp, tmp, nthreads);
 
-	if (cpus_empty(tmp)) {
+	if (cpumask_empty(tmp)) {
 		printk(KERN_ERR "Unable to find space in cpu_present_map for"
 		       " processor %s with %d thread(s)\n", np->name,
 		       nthreads);
 		goto out_unlock;
 	}
 
-	for_each_cpu_mask(cpu, tmp) {
-		BUG_ON(cpu_isset(cpu, cpu_present_map));
+	for_each_cpu(cpu, tmp) {
+		BUG_ON(cpumask_test_cpu(cpu, cpu_present_mask));
 		set_cpu_present(cpu, true);
 		set_hard_smp_processor_id(cpu, *intserv++);
 	}
 	err = 0;
 out_unlock:
 	cpu_maps_update_done();
+	free_cpumask_var(candidate_mask);
+	free_cpumask_var(tmp);
 	return err;
 }
 
@@ -334,7 +339,7 @@ static void pseries_remove_processor(str
 			set_hard_smp_processor_id(cpu, -1);
 			break;
 		}
-		if (cpu == NR_CPUS)
+		if (cpu >= nr_cpu_ids)
 			printk(KERN_WARNING "Could not find cpu to remove "
 			       "with physical id 0x%x\n", intserv[i]);
 	}
