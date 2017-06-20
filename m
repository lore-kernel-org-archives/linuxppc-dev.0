Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsWcH0CBdzDqhn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 01:15:10 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5KFEhbs020740
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 11:15:09 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b729jcxt7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 11:15:08 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 20 Jun 2017 11:15:07 -0400
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Reza Arbab <arbab@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Sahil Mehta <sahilmehta17@gmail.com>,
 Rashmica Gupta <rashmicy@gmail.com>, Ingo Molnar <mingo@kernel.org>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V6 2/2] powerpc/numa: Update CPU topology when VPHN enabled
In-Reply-To: <b0e02344-965b-5298-4ef6-3ec67d1200c4@linux.vnet.ibm.com>
Date: Tue, 20 Jun 2017 10:15:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <763c7e09-b5e3-d336-75a9-d138aac481b9@linux.vnet.ibm.com>
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
Changes in V6:
  -- Place extern of timed_topology_update() proto under additional #ifdef
     for hotplug-cpu.
---
 arch/powerpc/include/asm/topology.h          |   16 +++++++
 arch/powerpc/mm/numa.c                       |   64 +++++++++++++++++++++++---
 arch/powerpc/platforms/pseries/dlpar.c       |    2 +
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    2 +
 4 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 9cc6ec9..ae3cdd0 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -79,6 +79,22 @@ static inline int prrn_is_enabled(void)
 }
 #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
 
+#if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR) && \
+	defined(CONFIG_HOTPLUG_CPU)
+extern int timed_topology_update(int nsecs);
+#else
+static int timed_topology_update(int nsecs)
+{
+	return 0;
+}
+#endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR && CONFIG_HOTPLUG_CPU */
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
index 0746d93..cf5992d 100644
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
@@ -935,7 +936,7 @@ void __init initmem_init(void)
 
 	/*
 	 * Reduce the possible NUMA nodes to the online NUMA nodes,
-	 * since we do not support node hotplug. This ensures that  we
+	 * since we do not support node hotplug. This ensures that we
 	 * lower the maximum NUMA node ID to what is actually present.
 	 */
 	nodes_and(node_possible_map, node_possible_map, node_online_map);
@@ -1179,11 +1180,32 @@ struct topology_update_data {
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
@@ -1277,6 +1299,12 @@ static long vphn_get_associativity(unsigned long cpu,
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
@@ -1354,8 +1382,11 @@ int numa_update_cpu_topology(bool cpus_locked)
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
@@ -1394,6 +1425,8 @@ int numa_update_cpu_topology(bool cpus_locked)
 			cpumask_andnot(&cpu_associativity_changes_mask,
 					&cpu_associativity_changes_mask,
 					cpu_sibling_mask(cpu));
+			pr_info("Assoc chg gives same node %d for cpu%d\n",
+					new_nid, cpu);
 			cpu = cpu_last_thread_sibling(cpu);
 			continue;
 		}
@@ -1410,6 +1443,9 @@ int numa_update_cpu_topology(bool cpus_locked)
 		cpu = cpu_last_thread_sibling(cpu);
 	}
 
+	if (i)
+		updates[i-1].next = NULL;
+
 	pr_debug("Topology update for the following CPUs:\n");
 	if (cpumask_weight(&updated_cpus)) {
 		for (ud = &updates[0]; ud; ud = ud->next) {
@@ -1464,6 +1500,7 @@ int numa_update_cpu_topology(bool cpus_locked)
 
 out:
 	kfree(updates);
+	topology_update_needed = 0;
 	return changed;
 }
 
@@ -1483,6 +1520,14 @@ static void topology_schedule_update(void)
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
@@ -1499,7 +1544,7 @@ static void topology_timer_fn(unsigned long ignored)
 static void reset_topology_timer(void)
 {
 	topology_timer.data = 0;
-	topology_timer.expires = jiffies + 60 * HZ;
+	topology_timer.expires = jiffies + topology_timer_secs * HZ;
 	mod_timer(&topology_timer, topology_timer.expires);
 }
 
@@ -1549,15 +1594,14 @@ int start_topology_update(void)
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
@@ -1580,7 +1624,8 @@ int stop_topology_update(void)
 #ifdef CONFIG_SMP
 		rc = of_reconfig_notifier_unregister(&dt_update_nb);
 #endif
-	} else if (vphn_enabled) {
+	}
+	if (vphn_enabled) {
 		vphn_enabled = 0;
 		rc = del_timer_sync(&topology_timer);
 	}
@@ -1646,6 +1691,11 @@ static int topology_update_init(void)
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
index bda18d8..0219cd3 100644
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
index 7bc0e91..96c02d0 100644
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
