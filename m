Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkNtg1C9pzDqnQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Sep 2017 01:48:10 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v81Fi90J081861
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Sep 2017 11:48:08 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cq9gavcx2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Sep 2017 11:48:07 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 1 Sep 2017 09:48:07 -0600
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 John Allen <jallen@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V13 1/4] powerpc/vphn: Update CPU topology when VPHN enabled
In-Reply-To: <fc21bb6f-9df8-ab7d-5987-6bdce5d39842@linux.vnet.ibm.com>
Date: Fri, 1 Sep 2017 10:48:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <9d924c2f-9ad7-f544-519c-5ae967105069@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/vphn: On Power systems with shared configurations of CPUs
and memory, there are some issues with the association of additional
CPUs and memory to nodes when hot-adding resources.  This patch
corrects the currently broken capability to set the topology for
shared CPUs in LPARs.  At boot time for shared CPU lpars, the
topology for each CPU was being set to node zero.  Now when
numa_update_cpu_topology() is called appropriately, the Virtual
Processor Home Node (VPHN) capabilities information provided by the
pHyp allows the appropriate node in the shared configuration to be
selected for the CPU.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in V13:
  -- Split patch for improved review
---
 arch/powerpc/mm/numa.c |   31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index b95c584..312f6ee 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1153,6 +1153,8 @@ struct topology_update_data {
 static int vphn_enabled;
 static int prrn_enabled;
 static void reset_topology_timer(void);
+static int topology_inited;
+static int topology_update_needed;
 
 /*
  * Store the current values of the associativity change counters in the
@@ -1246,6 +1248,11 @@ static long vphn_get_associativity(unsigned long cpu,
 			"hcall_vphn() experienced a hardware fault "
 			"preventing VPHN. Disabling polling...\n");
 		stop_topology_update();
+		break;
+	case H_SUCCESS:
+		dbg("VPHN hcall succeeded. Reset polling...\n");
+		timed_topology_update(0);
+		break;
 	}
 
 	return rc;
@@ -1323,8 +1330,11 @@ int numa_update_cpu_topology(bool cpus_locked)
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
@@ -1363,6 +1373,8 @@ int numa_update_cpu_topology(bool cpus_locked)
 			cpumask_andnot(&cpu_associativity_changes_mask,
 					&cpu_associativity_changes_mask,
 					cpu_sibling_mask(cpu));
+			pr_info("Assoc chg gives same node %d for cpu%d\n",
+					new_nid, cpu);
 			cpu = cpu_last_thread_sibling(cpu);
 			continue;
 		}
@@ -1433,6 +1445,7 @@ int numa_update_cpu_topology(bool cpus_locked)
 
 out:
 	kfree(updates);
+	topology_update_needed = 0;
 	return changed;
 }
 
@@ -1453,6 +1466,13 @@ static void topology_schedule_update(void)
 	schedule_work(&topology_work);
 }
 
+void shared_topology_update(void)
+{
+	if (firmware_has_feature(FW_FEATURE_VPHN) &&
+		   lppaca_shared_proc(get_lppaca()))
+		topology_schedule_update();
+}
+
 static void topology_timer_fn(unsigned long ignored)
 {
 	if (prrn_enabled && cpumask_weight(&cpu_associativity_changes_mask))
@@ -1519,7 +1539,6 @@ int start_topology_update(void)
 	if (firmware_has_feature(FW_FEATURE_PRRN)) {
 		if (!prrn_enabled) {
 			prrn_enabled = 1;
-			vphn_enabled = 0;
 #ifdef CONFIG_SMP
 			rc = of_reconfig_notifier_register(&dt_update_nb);
 #endif
@@ -1527,7 +1546,6 @@ int start_topology_update(void)
 	} else if (firmware_has_feature(FW_FEATURE_VPHN) &&
 		   lppaca_shared_proc(get_lppaca())) {
 		if (!vphn_enabled) {
-			prrn_enabled = 0;
 			vphn_enabled = 1;
 			setup_cpu_associativity_change_counters();
 			init_timer_deferrable(&topology_timer);
@@ -1613,9 +1631,16 @@ static int topology_update_init(void)
 	if (topology_updates_enabled)
 		start_topology_update();
 
+	shared_topology_update();
+
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
