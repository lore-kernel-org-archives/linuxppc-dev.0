Return-Path: <mbringm@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xh8jY52J5zDqTc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 10:32:33 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7T0TDYE112390
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 20:32:31 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cmurnde8c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 20:32:31 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mbringm@us.ibm.com>;
 Mon, 28 Aug 2017 18:32:30 -0600
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 John Allen <jallen@linux.vnet.ibm.com>
From: Michael Bringmann <mbringm@us.ibm.com>
Subject: [PATCH V11 1/3] powerpc/numa: Update CPU topology when VPHN enabled
In-Reply-To: <27ed5a3a-e2d5-fc6d-9a3b-735430faa9da@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:32:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <a639581c-1a7b-ba52-cdab-091015f270f6@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


powerpc/numa: Correct the currently broken capability to set the
topology for shared CPUs in LPARs.  At boot time for shared CPU
lpars, the topology for each shared CPU is set to node zero, however,
this is now updated correctly using the Virtual Processor Home Node
(VPHN) capabilities information provided by the pHyp.

Also, update initialization checks for device-tree attributes to
independently recognize PRRN or VPHN usage.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in V11:
  -- Cleanup presentation of patch changes
---
 arch/powerpc/include/asm/topology.h          |   14 ++++++
 arch/powerpc/mm/numa.c                       |   61 +++++++++++++++++++++++---
 arch/powerpc/platforms/pseries/dlpar.c       |    2 +
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    2 +
 4 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index dc4e159..85d6428 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -98,6 +98,20 @@ static inline int prrn_is_enabled(void)
 }
 #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
 
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_NEED_MULTIPLE_NODES)
+#if defined(CONFIG_PPC_SPLPAR)
+extern int timed_topology_update(int nsecs);
+#else
+#define	timed_topology_update(nsecs)	0
+#endif /* CONFIG_PPC_SPLPAR */
+#endif /* CONFIG_HOTPLUG_CPU || CONFIG_NEED_MULTIPLE_NODES */
+
+#if defined(CONFIG_PPC_SPLPAR)
+extern void shared_topology_update(void);
+#else
+#define	shared_topology_update()	0
+#endif /* CONFIG_PPC_SPLPAR */
+
 #include <asm-generic/topology.h>
 
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index b95c584..cf8cd42 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -29,6 +29,7 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
+#include <linux/sched.h>
 #include <asm/cputhreads.h>
 #include <asm/sparsemem.h>
 #include <asm/prom.h>
@@ -1148,11 +1149,32 @@ struct topology_update_data {
 	int new_nid;
 };
 
+#define	TOPOLOGY_DEF_TIMER_SECS		60
+
 static u8 vphn_cpu_change_counts[NR_CPUS][MAX_DISTANCE_REF_POINTS];
 static cpumask_t cpu_associativity_changes_mask;
 static int vphn_enabled;
 static int prrn_enabled;
 static void reset_topology_timer(void);
+static int topology_timer_secs = TOPOLOGY_DEF_TIMER_SECS;
+static int topology_inited;
+static int topology_update_needed;
+
+/*
+ * Change polling interval for associativity changes.
+ */
+int timed_topology_update(int nsecs)
+{
+	if (nsecs > 0)
+		topology_timer_secs = nsecs;
+	else
+		topology_timer_secs = TOPOLOGY_DEF_TIMER_SECS;
+
+	if (vphn_enabled)
+		reset_topology_timer();
+
+	return 0;
+}
 
 /*
  * Store the current values of the associativity change counters in the
@@ -1246,6 +1268,12 @@ static long vphn_get_associativity(unsigned long cpu,
 			"hcall_vphn() experienced a hardware fault "
 			"preventing VPHN. Disabling polling...\n");
 		stop_topology_update();
+		break;
+	case H_SUCCESS:
+		printk(KERN_INFO
+			"VPHN hcall succeeded. Reset polling...\n");
+		timed_topology_update(0);
+		break;
 	}
 
 	return rc;
@@ -1323,8 +1351,11 @@ int numa_update_cpu_topology(bool cpus_locked)
 	struct device *dev;
 	int weight, new_nid, i = 0;
 
-	if (!prrn_enabled && !vphn_enabled)
+	if (!prrn_enabled && !vphn_enabled) {
+		if (!topology_inited)
+			topology_update_needed = 1;
 		return 0;
+	}
 
 	weight = cpumask_weight(&cpu_associativity_changes_mask);
 	if (!weight)
@@ -1363,6 +1394,8 @@ int numa_update_cpu_topology(bool cpus_locked)
 			cpumask_andnot(&cpu_associativity_changes_mask,
 					&cpu_associativity_changes_mask,
 					cpu_sibling_mask(cpu));
+			pr_info("Assoc chg gives same node %d for cpu%d\n",
+					new_nid, cpu);
 			cpu = cpu_last_thread_sibling(cpu);
 			continue;
 		}
@@ -1375,6 +1408,8 @@ int numa_update_cpu_topology(bool cpus_locked)
 			cpumask_set_cpu(sibling, &updated_cpus);
 			if (i < weight)
 				ud->next = &updates[i];
+			else
+				ud->next = NULL;
 		}
 		cpu = cpu_last_thread_sibling(cpu);
 	}
@@ -1433,6 +1468,7 @@ int numa_update_cpu_topology(bool cpus_locked)
 
 out:
 	kfree(updates);
+	topology_update_needed = 0;
 	return changed;
 }
 
@@ -1453,6 +1489,14 @@ static void topology_schedule_update(void)
 	schedule_work(&topology_work);
 }
 
+void shared_topology_update(void)
+{
+	if (firmware_has_feature(FW_FEATURE_VPHN) &&
+		   lppaca_shared_proc(get_lppaca()))
+		topology_schedule_update();
+}
+EXPORT_SYMBOL(shared_topology_update);
+
 static void topology_timer_fn(unsigned long ignored)
 {
 	if (prrn_enabled && cpumask_weight(&cpu_associativity_changes_mask))
@@ -1469,7 +1513,7 @@ static void topology_timer_fn(unsigned long ignored)
 static void reset_topology_timer(void)
 {
 	topology_timer.data = 0;
-	topology_timer.expires = jiffies + 60 * HZ;
+	topology_timer.expires = jiffies + topology_timer_secs * HZ;
 	mod_timer(&topology_timer, topology_timer.expires);
 }
 
@@ -1519,15 +1563,14 @@ int start_topology_update(void)
 	if (firmware_has_feature(FW_FEATURE_PRRN)) {
 		if (!prrn_enabled) {
 			prrn_enabled = 1;
-			vphn_enabled = 0;
 #ifdef CONFIG_SMP
 			rc = of_reconfig_notifier_register(&dt_update_nb);
 #endif
 		}
-	} else if (firmware_has_feature(FW_FEATURE_VPHN) &&
+	}
+	if (firmware_has_feature(FW_FEATURE_VPHN) &&
 		   lppaca_shared_proc(get_lppaca())) {
 		if (!vphn_enabled) {
-			prrn_enabled = 0;
 			vphn_enabled = 1;
 			setup_cpu_associativity_change_counters();
 			init_timer_deferrable(&topology_timer);
@@ -1550,7 +1593,8 @@ int stop_topology_update(void)
 #ifdef CONFIG_SMP
 		rc = of_reconfig_notifier_unregister(&dt_update_nb);
 #endif
-	} else if (vphn_enabled) {
+	}
+	if (vphn_enabled) {
 		vphn_enabled = 0;
 		rc = del_timer_sync(&topology_timer);
 	}
@@ -1616,6 +1660,11 @@ static int topology_update_init(void)
 	if (!proc_create("powerpc/topology_updates", 0644, NULL, &topology_ops))
 		return -ENOMEM;
 
+	topology_inited = 1;
+	if (topology_update_needed)
+		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
+					nr_cpumask_bits);
+
 	return 0;
 }
 device_initcall(topology_update_init);
diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 3918769..ba9a4a0 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -592,6 +592,8 @@ static ssize_t dlpar_show(struct class *class, struct class_attribute *attr,
 
 static int __init pseries_dlpar_init(void)
 {
+	shared_topology_update();
+
 	pseries_hp_wq = alloc_workqueue("pseries hotplug workqueue",
 					WQ_UNBOUND, 1);
 	return sysfs_create_file(kernel_kobj, &class_attr_dlpar.attr);
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 6afd1ef..5a7fb1e 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -356,6 +356,7 @@ static int dlpar_online_cpu(struct device_node *dn)
 			BUG_ON(get_cpu_current_state(cpu)
 					!= CPU_STATE_OFFLINE);
 			cpu_maps_update_done();
+			timed_topology_update(1);
 			rc = device_online(get_cpu_device(cpu));
 			if (rc)
 				goto out;
@@ -522,6 +523,7 @@ static int dlpar_offline_cpu(struct device_node *dn)
 				set_preferred_offline_state(cpu,
 							    CPU_STATE_OFFLINE);
 				cpu_maps_update_done();
+				timed_topology_update(1);
 				rc = device_offline(get_cpu_device(cpu));
 				if (rc)
 					goto out;

-- 
----------
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mbringm@us.ibm.com
