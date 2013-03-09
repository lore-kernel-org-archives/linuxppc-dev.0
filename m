Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D146F2C02B4
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Mar 2013 15:04:47 +1100 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 8 Mar 2013 21:04:45 -0700
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 01A913E4003E
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Mar 2013 21:04:33 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2944gSR355812
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:04:42 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2947Hwm009339
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:07:17 -0700
Received: from [9.76.31.13] (sig-9-76-31-13.mts.ibm.com [9.76.31.13])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r2947G5U009299
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:07:16 -0700
Message-ID: <513AB4D8.5090207@linux.vnet.ibm.com>
Date: Fri, 08 Mar 2013 22:04:40 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/11] Update CPU maps
References: <513AB2E3.6090209@linux.vnet.ibm.com>
In-Reply-To: <513AB2E3.6090209@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>

Platform events such as partition migration or the new PRRN firmware
feature can cause the NUMA characteristics of a CPU to change, and these
changes will be reflected in the device tree nodes for the affected
CPUs.

This patch registers a handler for Open Firmware device tree updates
and reconfigures the CPU and node maps whenever the associativity
changes. Currently, this is accomplished by marking the affected CPUs in
the cpu_associativity_changes_mask and allowing
arch_update_cpu_topology() to retrieve the new associativity information
using hcall_vphn().

Protecting the NUMA cpu maps from concurrent access during an update
operation will be addressed in a subsequent patch in this series.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/prom.h |    1 
 arch/powerpc/mm/numa.c          |   99 ++++++++++++++++++++++++++++++----------
 2 files changed, 76 insertions(+), 24 deletions(-)

Index: powerpc/arch/powerpc/include/asm/prom.h
===================================================================
--- powerpc.orig/arch/powerpc/include/asm/prom.h	2013-03-08 19:57:14.000000000 -0600
+++ powerpc/arch/powerpc/include/asm/prom.h	2013-03-08 19:57:38.000000000 -0600
@@ -138,6 +138,7 @@
 #define OV5_XCMO		0x0400
 #endif
 #define OV5_TYPE1_AFFINITY	0x0580	/* Type 1 NUMA affinity */
+#define OV5_PRRN		0x0540	/* Platform Resource Reassignment */
 #define OV5_PFO_HW_RNG		0x0E80	/* PFO Random Number Generator */
 #define OV5_PFO_HW_842		0x0E40	/* PFO Compression Accelerator */
 #define OV5_PFO_HW_ENCR		0x0E20	/* PFO Encryption Accelerator */
Index: powerpc/arch/powerpc/mm/numa.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/numa.c	2013-03-08 19:57:27.000000000 -0600
+++ powerpc/arch/powerpc/mm/numa.c	2013-03-08 19:57:38.000000000 -0600
@@ -1257,7 +1257,8 @@
 static u8 vphn_cpu_change_counts[NR_CPUS][MAX_DISTANCE_REF_POINTS];
 static cpumask_t cpu_associativity_changes_mask;
 static int vphn_enabled;
-static void set_topology_timer(void);
+static int prrn_enabled;
+static void reset_topology_timer(void);
 
 /*
  * Store the current values of the associativity change counters in the
@@ -1293,11 +1294,9 @@
  */
 static int update_cpu_associativity_changes_mask(void)
 {
-	int cpu, nr_cpus = 0;
+	int cpu;
 	cpumask_t *changes = &cpu_associativity_changes_mask;
 
-	cpumask_clear(changes);
-
 	for_each_possible_cpu(cpu) {
 		int i, changed = 0;
 		u8 *counts = vphn_cpu_change_counts[cpu];
@@ -1311,11 +1310,10 @@
 		}
 		if (changed) {
 			cpumask_set_cpu(cpu, changes);
-			nr_cpus++;
 		}
 	}
 
-	return nr_cpus;
+	return cpumask_weight(changes);
 }
 
 /*
@@ -1416,7 +1414,7 @@
 	unsigned int associativity[VPHN_ASSOC_BUFSIZE] = {0};
 	struct device *dev;
 
-	for_each_cpu(cpu,&cpu_associativity_changes_mask) {
+	for_each_cpu(cpu, &cpu_associativity_changes_mask) {
 		vphn_get_associativity(cpu, associativity);
 		nid = associativity_to_nid(associativity);
 
@@ -1438,6 +1436,7 @@
 		dev = get_cpu_device(cpu);
 		if (dev)
 			kobject_uevent(&dev->kobj, KOBJ_CHANGE);
+		cpumask_clear_cpu(cpu, &cpu_associativity_changes_mask);
 		changed = 1;
 	}
 
@@ -1457,37 +1456,80 @@
 
 static void topology_timer_fn(unsigned long ignored)
 {
-	if (!vphn_enabled)
-		return;
-	if (update_cpu_associativity_changes_mask() > 0)
+	if (prrn_enabled && cpumask_weight(&cpu_associativity_changes_mask))
 		topology_schedule_update();
-	set_topology_timer();
+	else if (vphn_enabled) {
+		if (update_cpu_associativity_changes_mask() > 0)
+			topology_schedule_update();
+		reset_topology_timer();
+	}
 }
 static struct timer_list topology_timer =
 	TIMER_INITIALIZER(topology_timer_fn, 0, 0);
 
-static void set_topology_timer(void)
+static void reset_topology_timer(void)
 {
 	topology_timer.data = 0;
 	topology_timer.expires = jiffies + 60 * HZ;
-	add_timer(&topology_timer);
+	mod_timer(&topology_timer, topology_timer.expires);
+}
+
+static void stage_topology_update(int core_id)
+{
+	cpumask_or(&cpu_associativity_changes_mask,
+		&cpu_associativity_changes_mask, cpu_sibling_mask(core_id));
+	reset_topology_timer();
 }
 
+static int dt_update_callback(struct notifier_block *nb,
+				unsigned long action, void *data)
+{
+	struct of_prop_reconfig *update;
+	int rc = NOTIFY_DONE;
+
+	switch (action) {
+	case OF_RECONFIG_ADD_PROPERTY:
+	case OF_RECONFIG_UPDATE_PROPERTY:
+		update = (struct of_prop_reconfig *)data;
+		if (!of_prop_cmp(update->dn->type, "cpu")) {
+			u32 core_id;
+			of_property_read_u32(update->dn, "reg", &core_id);
+			stage_topology_update(core_id);
+			rc = NOTIFY_OK;
+		}
+		break;
+	}
+
+	return rc;
+}
+
+static struct notifier_block dt_update_nb = {
+	.notifier_call = dt_update_callback,
+};
+
 /*
- * Start polling for VPHN associativity changes.
+ * Start polling for associativity changes.
  */
 int start_topology_update(void)
 {
 	int rc = 0;
 
-	/* Disabled until races with load balancing are fixed */
-	if (0 && firmware_has_feature(FW_FEATURE_VPHN) &&
-	    get_lppaca()->shared_proc) {
-		vphn_enabled = 1;
-		setup_cpu_associativity_change_counters();
-		init_timer_deferrable(&topology_timer);
-		set_topology_timer();
-		rc = 1;
+	if (platform_has_feature(OV5_PRRN)) {
+		if (!prrn_enabled) {
+			prrn_enabled = 1;
+			vphn_enabled = 0;
+			rc = of_reconfig_notifier_register(&dt_update_nb);
+		}
+	} else if (0 && firmware_has_feature(FW_FEATURE_VPHN) &&
+		   get_lppaca()->shared_proc) {
+		/* Disabled until races with load balancing are fixed */
+		if (!vphn_enabled) {
+			prrn_enabled = 0;
+			vphn_enabled = 1;
+			setup_cpu_associativity_change_counters();
+			init_timer_deferrable(&topology_timer);
+			reset_topology_timer();
+		}
 	}
 
 	return rc;
@@ -1499,7 +1541,16 @@
  */
 int stop_topology_update(void)
 {
-	vphn_enabled = 0;
-	return del_timer_sync(&topology_timer);
+	int rc = 0;
+
+	if (prrn_enabled) {
+		prrn_enabled = 0;
+		rc = of_reconfig_notifier_unregister(&dt_update_nb);
+	} else if (vphn_enabled) {
+		vphn_enabled = 0;
+		rc = del_timer_sync(&topology_timer);
+	}
+
+	return rc;
 }
 #endif /* CONFIG_PPC_SPLPAR */
