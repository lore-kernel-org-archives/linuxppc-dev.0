Return-Path: <anton@ozlabs.org>
Message-Id: <20100427013431.787617147@samba.org>
Date: Tue, 27 Apr 2010 11:32:34 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 rusty@rustcorp.com.au
Subject: [patch 03/15] powerpc: cpumask: Convert smp_cpus_done to new cpumask
	API
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

Use the new cpumask_* functions and dynamically allocate the cpumask in
smp_cpus_done.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/kernel/smp.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/kernel/smp.c	2010-04-08 19:46:04.379196361 +1000
+++ linux-cpumask/arch/powerpc/kernel/smp.c	2010-04-22 13:03:13.025446124 +1000
@@ -554,19 +554,22 @@ int setup_profiling_timer(unsigned int m
 
 void __init smp_cpus_done(unsigned int max_cpus)
 {
-	cpumask_t old_mask;
+	cpumask_var_t old_mask;
 
 	/* We want the setup_cpu() here to be called from CPU 0, but our
 	 * init thread may have been "borrowed" by another CPU in the meantime
 	 * se we pin us down to CPU 0 for a short while
 	 */
-	old_mask = current->cpus_allowed;
-	set_cpus_allowed(current, cpumask_of_cpu(boot_cpuid));
-	
+	alloc_cpumask_var(&old_mask, GFP_NOWAIT);
+	cpumask_copy(old_mask, &current->cpus_allowed);
+	set_cpus_allowed_ptr(current, cpumask_of(boot_cpuid));
+
 	if (smp_ops && smp_ops->setup_cpu)
 		smp_ops->setup_cpu(boot_cpuid);
 
-	set_cpus_allowed(current, old_mask);
+	set_cpus_allowed_ptr(current, old_mask);
+
+	free_cpumask_var(old_mask);
 
 	snapshot_timebases();
 
