Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsJNx5zFjzDrNC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 07:49:53 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8CLmaCw082466
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 17:49:51 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cxpge3ah0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 17:49:51 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 12 Sep 2017 15:49:50 -0600
To: linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com,
 Michael Bringmann from Kernel Team <mbringm@us.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/kernel: Add 'ibm,thread-groups' property for CPU
 allocation
Date: Tue, 12 Sep 2017 16:49:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <25045c72-e951-cc32-38d6-84ab36e8a117@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/kernel: Add logic to parse the new property 'ibm,thread-groups"
when it is present.  The content of this property explicitly defines the
number of threads per core as well as the PowerPC 'threads_core_mask'.
The design provides a common device-tree for both P9 normal core and
P9 fused core systems.  The property updates the kernel to know CPUs
of each core are actually present, and then use the map when adding
cores to the system at boot, or during hotplug operations.  Previously,
this information was inferred solely from embedded code and the
"ibm,ppc-interrupt-server#s" in the system device tree.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cputhreads.h        |    2 +
 arch/powerpc/kernel/prom.c                   |   76 ++++++++++++++++++++++++++
 arch/powerpc/kernel/setup-common.c           |   30 +++++++---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   13 ++++
 4 files changed, 109 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index 9377bdf..e57f679 100644
--- a/arch/powerpc/include/asm/cputhreads.h
+++ b/arch/powerpc/include/asm/cputhreads.h
@@ -30,6 +30,8 @@
 #define threads_core_mask	(*get_cpu_mask(0))
 #endif
 
+extern cpumask_t pseries_thread_group_mask;
+
 /* cpu_thread_mask_to_cores - Return a cpumask of one per cores
  *                            hit by the argument
  *
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f830562..eead1e3 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -67,6 +67,9 @@
 #define DBG(fmt...)
 #endif
 
+cpumask_t pseries_thread_group_mask;
+EXPORT_SYMBOL(pseries_thread_group_mask);
+
 #ifdef CONFIG_PPC64
 int __initdata iommu_is_off;
 int __initdata iommu_force_on;
@@ -302,6 +305,73 @@ static void __init check_cpu_feature_properties(unsigned long node)
 	}
 }
 
+static void __init early_init_setup_thread_group_mask(unsigned long node,
+						cpumask_t *thread_group_mask)
+{
+	const __be32 *thrgrp;
+	int len, rc = 0;
+
+	cpumask_clear(thread_group_mask);
+
+	thrgrp = of_get_flat_dt_prop(node, "ibm,thread-groups", &len);
+	if (thrgrp) {
+		u32 cc_type = 0, no_split = 0, thr_per_split = 0;
+		int j, k;
+
+		/* Characteristic type per table */
+		cc_type = of_read_number(thrgrp++, 1);
+
+		/*
+		 * 1 : Group shares common L1, translation cache, and
+		 *     instruction data flow
+		 * >1 : Reserved
+		  */
+		if (cc_type != 1) {
+			rc = -EINVAL;
+			goto endit;
+		}
+
+		/* No. splits */
+		no_split = of_read_number(thrgrp++, 1);
+		if (no_split == 0) {
+			rc = -EINVAL;
+			goto endit;
+		}
+
+		/* Threads per split */
+		thr_per_split = of_read_number(thrgrp++, 1);
+		if (thr_per_split == 0) {
+			rc = -EINVAL;
+			goto endit;
+		}
+
+		DBG("INFO: Node %d; ibm,thread-group "
+			"(cc_t=%d, no_spl=%d, thr_p_spl=%d)\n",
+			(int)node, (int)cc_type, (int)no_split,
+			(int)thr_per_split);
+
+		for (j = 0; j < no_split; j++) {
+			for (k = 0; k < thr_per_split; k++) {
+				u32 t = of_read_number(thrgrp++, 1);
+
+				cpumask_set_cpu(t, thread_group_mask);
+				DBG("INFO: Node %d; enable thread %d\n", (int)node, (int)t);
+			}
+		}
+	} else {
+		DBG("WARNING: Node %d; ibm,thread-group property not found\n",
+			(int)node);
+		cpumask_setall(thread_group_mask);
+	}
+
+endit:
+	if (rc) {
+		DBG("WARNING: Node %d; error processing ibm,thread-group property\n",
+			(int)node);
+		cpumask_setall(thread_group_mask);
+	}
+}
+
 static int __init early_init_dt_scan_cpus(unsigned long node,
 					  const char *uname, int depth,
 					  void *data)
@@ -325,11 +395,17 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 
 	nthreads = len / sizeof(int);
 
+	/* Figure out the thread subset */
+	early_init_setup_thread_group_mask(node, &pseries_thread_group_mask);
+
 	/*
 	 * Now see if any of these threads match our boot cpu.
 	 * NOTE: This must match the parsing done in smp_setup_cpu_maps.
 	 */
 	for (i = 0; i < nthreads; i++) {
+		if (!cpumask_test_cpu(i % nthreads, &pseries_thread_group_mask))
+			continue;
+
 		/*
 		 * version 2 of the kexec param format adds the phys cpuid of
 		 * booted proc.
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 94a9482..430fe4a 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -427,13 +427,16 @@ void __init check_for_initrd(void)
 EXPORT_SYMBOL_GPL(threads_shift);
 EXPORT_SYMBOL_GPL(threads_core_mask);
 
-static void __init cpu_init_thread_core_maps(int tpc)
+static void __init cpu_init_thread_core_maps(int tpc,
+				cpumask_t *thread_group_mask)
 {
+	cpumask_t work_mask;
 	int i;
 
 	threads_per_core = tpc;
 	threads_per_subcore = tpc;
 	cpumask_clear(&threads_core_mask);
+	cpumask_clear(&work_mask);
 
 	/* This implementation only supports power of 2 number of threads
 	 * for simplicity and performance
@@ -442,14 +445,14 @@ static void __init cpu_init_thread_core_maps(int tpc)
 	BUG_ON(tpc != (1 << threads_shift));
 
 	for (i = 0; i < tpc; i++)
-		cpumask_set_cpu(i, &threads_core_mask);
+		cpumask_set_cpu(i, &work_mask);
+	cpumask_and(&threads_core_mask, &work_mask, thread_group_mask);
 
 	printk(KERN_INFO "CPU maps initialized for %d thread%s per core\n",
 	       tpc, tpc > 1 ? "s" : "");
 	printk(KERN_DEBUG " (thread shift is %d)\n", threads_shift);
 }
 
-
 /**
  * setup_cpu_maps - initialize the following cpu maps:
  *                  cpu_possible_mask
@@ -503,17 +506,24 @@ void __init smp_setup_cpu_maps(void)
 		for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
 			bool avail;
 
-			DBG("    thread %d -> cpu %d (hard id %d)\n",
-			    j, cpu, be32_to_cpu(intserv[j]));
-
 			avail = of_device_is_available(dn);
 			if (!avail)
 				avail = !of_property_match_string(dn,
 						"enable-method", "spin-table");
 
-			set_cpu_present(cpu, avail);
-			set_hard_smp_processor_id(cpu, be32_to_cpu(intserv[j]));
-			set_cpu_possible(cpu, true);
+			DBG("    thread %d -> cpu %d (hard id %d)\n",
+			    j, cpu, be32_to_cpu(intserv[j]));
+
+			if (cpumask_test_cpu(cpu % nthreads,
+						&pseries_thread_group_mask)) {
+				set_cpu_present(cpu, avail);
+				set_hard_smp_processor_id(cpu,
+						be32_to_cpu(intserv[j]));
+				set_cpu_possible(cpu, true);
+			} else {
+				set_cpu_present(cpu, false);
+				set_cpu_possible(cpu, false);
+			}
 			cpu++;
 		}
 	}
@@ -572,7 +582,7 @@ void __init smp_setup_cpu_maps(void)
 	 * every CPU in the system. If that is not the case, then some code
 	 * here will have to be reworked
 	 */
-	cpu_init_thread_core_maps(nthreads);
+	cpu_init_thread_core_maps(nthreads, &pseries_thread_group_mask);
 
 	/* Now that possible cpus are set, set nr_cpu_ids for later use */
 	setup_nr_cpu_ids();
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 6afd1ef..a714fe2 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -35,6 +35,7 @@
 #include <asm/vdso_datapage.h>
 #include <asm/xics.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/cputhreads.h>
 
 #include "pseries.h"
 #include "offline_states.h"
@@ -251,8 +252,10 @@ static int pseries_add_processor(struct device_node *np)
 	zalloc_cpumask_var(&tmp, GFP_KERNEL);
 
 	nthreads = len / sizeof(u32);
-	for (i = 0; i < nthreads; i++)
-		cpumask_set_cpu(i, tmp);
+	for (i = 0; i < nthreads; i++) {
+		if (cpumask_test_cpu(i % nthreads, &pseries_thread_group_mask))
+			cpumask_set_cpu(i, tmp);
+	}
 
 	cpu_maps_update_begin();
 
@@ -317,6 +320,8 @@ static void pseries_remove_processor(struct device_node *np)
 
 	cpu_maps_update_begin();
 	for (i = 0; i < nthreads; i++) {
+		if (!cpumask_test_cpu(i % nthreads, &pseries_thread_group_mask))
+			continue;
 		thread = be32_to_cpu(intserv[i]);
 		for_each_present_cpu(cpu) {
 			if (get_hard_smp_processor_id(cpu) != thread)
@@ -349,6 +354,8 @@ static int dlpar_online_cpu(struct device_node *dn)
 
 	cpu_maps_update_begin();
 	for (i = 0; i < nthreads; i++) {
+		if (!cpumask_test_cpu(i % nthreads, &pseries_thread_group_mask))
+			continue;
 		thread = be32_to_cpu(intserv[i]);
 		for_each_present_cpu(cpu) {
 			if (get_hard_smp_processor_id(cpu) != thread)
@@ -510,6 +517,8 @@ static int dlpar_offline_cpu(struct device_node *dn)
 
 	cpu_maps_update_begin();
 	for (i = 0; i < nthreads; i++) {
+		if (!cpumask_test_cpu(i % nthreads, &pseries_thread_group_mask))
+			continue;
 		thread = be32_to_cpu(intserv[i]);
 		for_each_present_cpu(cpu) {
 			if (get_hard_smp_processor_id(cpu) != thread)
