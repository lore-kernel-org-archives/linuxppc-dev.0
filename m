Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wshnZ65fVzDql0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 08:08:50 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5KM8j5A066618
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 18:08:48 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b6rv1tmrq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 18:08:47 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 20 Jun 2017 19:08:46 -0300
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5KM8hRm8061408
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 19:08:43 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5KJ8hjF032476
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 16:08:44 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Only obtain cpu_hotplug_lock if called by rtasd
Date: Tue, 20 Jun 2017 19:08:30 -0300
Message-Id: <1497996510-4032-1-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Calling arch_update_cpu_topology from a CPU hotplug state machine callback
hits a deadlock because the function tries to get a read lock on
cpu_hotplug_lock while the state machine still holds a write lock on it.

Since all callers of arch_update_cpu_topology except rtasd already hold
cpu_hotplug_lock, this patch changes the function to use
stop_machine_cpuslocked and creates a separate function for rtasd which
still tries to obtain the lock.

Michael Bringmann investigated the bug and provided a detailed analysis
of the deadlock on this previous RFC for an alternate solution:

https://patchwork.ozlabs.org/patch/771293/

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---

Notes:
    This patch applies on tip/smp/hotplug, it should probably be carried there.

 arch/powerpc/include/asm/topology.h |  6 ++++++
 arch/powerpc/kernel/rtasd.c         |  2 +-
 arch/powerpc/mm/numa.c              | 22 +++++++++++++++++++---
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 8b3b46b7b0f2..a2d36b7703ae 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -43,6 +43,7 @@ extern void __init dump_numa_cpu_topology(void);
 
 extern int sysfs_add_device_to_node(struct device *dev, int nid);
 extern void sysfs_remove_device_from_node(struct device *dev, int nid);
+extern int numa_update_cpu_topology(bool cpus_locked);
 
 #else
 
@@ -57,6 +58,11 @@ static inline void sysfs_remove_device_from_node(struct device *dev,
 						int nid)
 {
 }
+
+static inline int numa_update_cpu_topology(bool cpus_locked)
+{
+	return 0;
+}
 #endif /* CONFIG_NUMA */
 
 #if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index 3650732639ed..0f0b1b2f3b60 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -283,7 +283,7 @@ static void prrn_work_fn(struct work_struct *work)
 	 * the RTAS event.
 	 */
 	pseries_devicetree_update(-prrn_update_scope);
-	arch_update_cpu_topology();
+	numa_update_cpu_topology(false);
 }
 
 static DECLARE_WORK(prrn_work, prrn_work_fn);
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 371792e4418f..b95c584ce19d 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1311,8 +1311,10 @@ static int update_lookup_table(void *data)
 /*
  * Update the node maps and sysfs entries for each cpu whose home node
  * has changed. Returns 1 when the topology has changed, and 0 otherwise.
+ *
+ * cpus_locked says whether we already hold cpu_hotplug_lock.
  */
-int arch_update_cpu_topology(void)
+int numa_update_cpu_topology(bool cpus_locked)
 {
 	unsigned int cpu, sibling, changed = 0;
 	struct topology_update_data *updates, *ud;
@@ -1400,15 +1402,23 @@ int arch_update_cpu_topology(void)
 	if (!cpumask_weight(&updated_cpus))
 		goto out;
 
-	stop_machine(update_cpu_topology, &updates[0], &updated_cpus);
+	if (cpus_locked)
+		stop_machine_cpuslocked(update_cpu_topology, &updates[0],
+					&updated_cpus);
+	else
+		stop_machine(update_cpu_topology, &updates[0], &updated_cpus);
 
 	/*
 	 * Update the numa-cpu lookup table with the new mappings, even for
 	 * offline CPUs. It is best to perform this update from the stop-
 	 * machine context.
 	 */
-	stop_machine(update_lookup_table, &updates[0],
+	if (cpus_locked)
+		stop_machine_cpuslocked(update_lookup_table, &updates[0],
 					cpumask_of(raw_smp_processor_id()));
+	else
+		stop_machine(update_lookup_table, &updates[0],
+			     cpumask_of(raw_smp_processor_id()));
 
 	for (ud = &updates[0]; ud; ud = ud->next) {
 		unregister_cpu_under_node(ud->cpu, ud->old_nid);
@@ -1426,6 +1436,12 @@ int arch_update_cpu_topology(void)
 	return changed;
 }
 
+int arch_update_cpu_topology(void)
+{
+	lockdep_assert_cpus_held();
+	return numa_update_cpu_topology(true);
+}
+
 static void topology_work_fn(struct work_struct *work)
 {
 	rebuild_sched_domains();
-- 
2.7.4
