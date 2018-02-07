Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zcG7x5lJLzF0sH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Feb 2018 09:23:57 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w17MNfsE103209
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Feb 2018 17:23:55 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g0605jgt4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Feb 2018 17:23:54 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 7 Feb 2018 15:23:54 -0700
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, John Allen
 <jallen@linux.vnet.ibm.com>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [RFC] powerpc/kernel: Add 'ibm,thread-groups' property for CPU
 allocation
Date: Wed, 7 Feb 2018 16:23:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <33223d06-d6c6-4043-fc14-d65d48a80556@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Withdraw/replace previous version submission.  Awaiting hardware
for further migration tests.  Request comments about current state.]

Add code to parse the new property 'ibm,thread-groups" when it is
present.  The content of this property explicitly defines the number
of threads per core as well as the PowerPC 'threads_core_mask'.
The design provides a common device-tree for both P9 normal core and
P9 fused core systems.  The new property has been observed to be
available on P9 pHyp systems, but it may not be present on OpenPower
BMC systems.

The property updates the kernel to know which CPUs/threads of each
core are actually present, and then use the map when adding cores
to the system at boot, or during hotplug operations.

* Previously, the information about the number of threads per core
  was inferred solely from the "ibm,ppc-interrupt-server#s" property
  in the system device tree.
* Also previous to this property, The mask of threads per CPU was
  inferred to be a strict linear series from 0..(nthreads-1).
* There may be a different thread group mask for each core in the
  system.
* Also after reading the property, we can determine which of the
  possible threads we are allowed to online for each CPU.  It is no
  longer a simple linear sequence, but may be discontinuous e.g.
  activate threads 1,2,3,5,6,7 on a core instead of 0-5 sequentially.

In the event of LPAR migration, we also provide a hook to re-process
the property in the event that it is changed.  Rules about fused-core
and split-core migration are outside the scope of this change, however.
We update the 'ppc_thread_group_mask' for subsequent use by DLPAR
operations.  It is the responsibility of the user to put the source
system into SMT4 mode when moving from a fused-core to split-core
target.

Implementation of the "ibm,thread-groups" property is spread across
a few files in the powerpc specific code:

* prom.c: Parse the property and create 'ppc_thread_group_mask'.
          Use the mask in operation of early_init_dt_scan_cpus().
* setup-common.c: Parse the property, create 'ppc_thread_group_mask',
          and use the value in cpu_init_thread_core_maps(), and
          smp_setup_cpu_maps.
* hotplug-cpu.c: Use 'ppc_thread_group_mask' in several locations
          where the code previously expected to iterate over a
          linear series of active threads (0..nthreads-1).
* mobility.c: Look for and process changes to the thread group mask
          in the context of post migration topology changes

Note that the "ibm,thread-groups" property also includes semantics
of 'thread-group' i.e. define one or more subgroups of the available
threads, each group of threads to be used for a specific class of
task.  Translating thread group semantics into Linux kernel features
is TBD.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in V3:
  -- Update patch description regarding latest changes.
  -- Move parsing of new property to 'setup-common.c' in new function
     'process_thread_group_masks'.
  -- Ensure that code is able to handle unique thread group masks
     for different cpus.
  -- Add post migration topology check for 'ibm,thread-groups' using
     new function process_thread_group_mask when appropriate.
  -- Tune use of ppc_thread_group_mask during DLPAR operations.
     Use new function process_thread_group_mask when appropriate.
  -- Add some more description of property semantics/operation in
     the case of LPAR migration.
---
 arch/powerpc/include/asm/cputhreads.h        |    6 +
 arch/powerpc/kernel/setup-common.c           |  136 ++++++++++++++++++++++++--
 arch/powerpc/platforms/pseries/hotplug-cpu.c |   14 ++-
 arch/powerpc/platforms/pseries/mobility.c    |    6 +
 4 files changed, 150 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index d71a909..df6ade9 100644
--- a/arch/powerpc/include/asm/cputhreads.h
+++ b/arch/powerpc/include/asm/cputhreads.h
@@ -31,6 +31,12 @@
 #define threads_core_mask	(*get_cpu_mask(0))
 #endif
 
+extern cpumask_t ppc_thread_group_mask;
+
+extern int process_thread_group_mask(struct device_node *dn,
+					const __be32 *prop, int prop_len);
+
+
 /* cpu_thread_mask_to_cores - Return a cpumask of one per cores
  *                            hit by the argument
  *
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 8fd3a70..1102d12 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -416,13 +416,18 @@ void __init check_for_initrd(void)
 EXPORT_SYMBOL_GPL(threads_shift);
 EXPORT_SYMBOL_GPL(threads_core_mask);
 
-static void __init cpu_init_thread_core_maps(int tpc)
+cpumask_t ppc_thread_group_mask;
+EXPORT_SYMBOL_GPL(ppc_thread_group_mask);
+
+static void __init cpu_init_thread_core_maps(int tpc,
+				cpumask_t *thread_group_mask)
 {
 	int i;
 
 	threads_per_core = tpc;
 	threads_per_subcore = tpc;
 	cpumask_clear(&threads_core_mask);
+	DBG("INFO: Entry %s (%d)\n", __FUNCTION__, tpc);
 
 	/* This implementation only supports power of 2 number of threads
 	 * for simplicity and performance
@@ -432,12 +437,112 @@ static void __init cpu_init_thread_core_maps(int tpc)
 
 	for (i = 0; i < tpc; i++)
 		cpumask_set_cpu(i, &threads_core_mask);
+	cpumask_and(&threads_core_mask, &threads_core_mask, thread_group_mask);
 
 	printk(KERN_INFO "CPU maps initialized for %d thread%s per core\n",
 	       tpc, tpc > 1 ? "s" : "");
 	printk(KERN_DEBUG " (thread shift is %d)\n", threads_shift);
 }
 
+int process_thread_group_mask(struct device_node *dn,
+				const __be32 *prop, int prop_len)
+{
+	const __be32 *thrgrp;
+	const __be32 *intserv;
+	int lentg, len, cpu, nthreads = 1;
+	int j, k, rc = 0;
+	u32 cc_type = 0, no_split = 0, thr_per_split = 0;
+	DBG("INFO: Entry %s\n", __FUNCTION__);
+
+	/* First CPU/thread */
+	intserv = of_get_property(dn, "reg", &len);
+	if (intserv)
+		cpu = of_read_number(intserv, 1);
+	else
+		cpu = 0;
+
+	/* Num of threads in core */
+	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s",
+				&len);
+	if (intserv) {
+		DBG("    ibm,ppc-interrupt-server#s -> %d threads\n",
+		    nthreads);
+	} else {
+		DBG("    no ibm,ppc-interrupt-server#s -> 1 thread\n");
+		len = 4;
+	}
+
+	nthreads = len / sizeof(int);
+	DBG("    cpu %d nthreads %d\n", cpu, nthreads);
+
+	if (prop) {
+		thrgrp = prop;
+	} else {
+		thrgrp = of_get_property(dn, "ibm,thread-groups",
+					&lentg);
+		if (!thrgrp) {
+			rc = -ENOENT;
+			DBG("    error, %d\n", __LINE__);
+			goto endit;
+		}
+	}
+
+	/* Process the thread groups for the Core thread mask */
+	/* Characteristic type per table */
+	cc_type = of_read_number(thrgrp++, 1);
+
+	/*
+	 * 1 : Group shares common L1, translation cache, and
+	 *     instruction data flow
+	 * >1 : Reserved
+	 */
+	if (cc_type != 1) {
+		rc = -EINVAL;
+		DBG("    error, %d\n", __LINE__);
+		goto endit;
+	}
+
+	/* No. splits */
+	no_split = of_read_number(thrgrp++, 1);
+	if (no_split == 0) {
+		rc = -EINVAL;
+		DBG("    error, %d\n", __LINE__);
+		goto endit;
+	}
+
+	/* Threads per split */
+	thr_per_split = of_read_number(thrgrp++, 1);
+	if (thr_per_split == 0) {
+		rc = -EINVAL;
+		DBG("    error, %d\n", __LINE__);
+		goto endit;
+	}
+
+	DBG("    Property ibm,thread-group "
+		"(cc_t=%d, no_spl=%d, thr_p_spl=%d)\n",
+		(int)cc_type, (int)no_split, (int)thr_per_split);
+
+	for (j = 0; j < no_split; j++) {
+		for (k = 0; k < thr_per_split; k++) {
+			u32 t = of_read_number(thrgrp++, 1);
+
+			cpumask_set_cpu(t, &ppc_thread_group_mask);
+			DBG("      !!enable thread %d\n", (int)t);
+		}
+	}
+
+endit:
+	if (rc) {
+		DBG("    WARNING: error processing (%d)"
+		    "ibm,thread-group property\n", rc);
+		for (j = 0; j < nthreads; j++)
+			cpumask_set_cpu(cpu+j,
+					&ppc_thread_group_mask);
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL(process_thread_group_mask);
 
 /**
  * setup_cpu_maps - initialize the following cpu maps:
@@ -489,20 +594,35 @@ void __init smp_setup_cpu_maps(void)
 
 		nthreads = len / sizeof(int);
 
+		process_thread_group_mask(dn, NULL, 0);
+
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
+			DBG("    thread %d -> cpu %d (hard id %d) %d\n",
+			    j, cpu, be32_to_cpu(intserv[j]),
+			    cpumask_test_cpu(cpu, &ppc_thread_group_mask));
+
+			if (cpumask_test_cpu(cpu,
+					&ppc_thread_group_mask)) {
+				DBG("        !!thread %d present"
+					"/possible\n", (int)cpu);
+				set_cpu_present(cpu, avail);
+				set_hard_smp_processor_id(cpu,
+					be32_to_cpu(intserv[j]));
+				set_cpu_possible(cpu, true);
+			} else {
+				DBG("        !!NOT thread %d "
+					"present/possible\n", (int)cpu);
+				set_cpu_present(cpu, false);
+				set_cpu_possible(cpu, false);
+			}
+
 			cpu++;
 		}
 	}
@@ -561,7 +681,7 @@ void __init smp_setup_cpu_maps(void)
 	 * every CPU in the system. If that is not the case, then some code
 	 * here will have to be reworked
 	 */
-	cpu_init_thread_core_maps(nthreads);
+	cpu_init_thread_core_maps(nthreads, &ppc_thread_group_mask);
 
 	/* Now that possible cpus are set, set nr_cpu_ids for later use */
 	setup_nr_cpu_ids();
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index a7d14aa7..106d0fe 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -36,6 +36,7 @@
 #include <asm/xics.h>
 #include <asm/xive.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/cputhreads.h>
 
 #include "pseries.h"
 #include "offline_states.h"
@@ -254,6 +255,8 @@ static int pseries_add_processor(struct device_node *np)
 	if (!intserv)
 		return 0;
 
+	process_thread_group_mask(np, NULL, 0);
+
 	zalloc_cpumask_var(&candidate_mask, GFP_KERNEL);
 	zalloc_cpumask_var(&tmp, GFP_KERNEL);
 
@@ -325,6 +328,7 @@ static void pseries_remove_processor(struct device_node *np)
 	cpu_maps_update_begin();
 	for (i = 0; i < nthreads; i++) {
 		thread = be32_to_cpu(intserv[i]);
+		cpumask_clear_cpu(thread, &ppc_thread_group_mask);
 		for_each_present_cpu(cpu) {
 			if (get_hard_smp_processor_id(cpu) != thread)
 				continue;
@@ -363,10 +367,12 @@ static int dlpar_online_cpu(struct device_node *dn)
 			BUG_ON(get_cpu_current_state(cpu)
 					!= CPU_STATE_OFFLINE);
 			cpu_maps_update_done();
-			timed_topology_update(1);
-			rc = device_online(get_cpu_device(cpu));
-			if (rc)
-				goto out;
+			if (cpumask_test_cpu(thread, &ppc_thread_group_mask)) {
+				timed_topology_update(1);
+				rc = device_online(get_cpu_device(cpu));
+				if (rc)
+					goto out;
+			}
 			cpu_maps_update_begin();
 
 			break;
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index f7042ad..0816ccf 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -20,6 +20,7 @@
 
 #include <asm/machdep.h>
 #include <asm/rtas.h>
+#include <asm/cputhreads.h>
 #include "pseries.h"
 
 static struct kobject *mobility_kobj;
@@ -121,6 +122,11 @@ static int update_dt_property(struct device_node *dn, struct property **prop,
 	}
 
 	if (!more) {
+		printk(KERN_INFO "INFO: Processing %s %s\n", __FUNCTION__, name);
+		if (strcmp(name, "ibm,thread-groups") == 0)
+			process_thread_group_mask(dn,
+				new_prop->value, new_prop->length);
+
 		of_update_property(dn, new_prop);
 		*prop = NULL;
 	}
