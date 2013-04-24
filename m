Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F2BA2C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 02:03:33 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 12:03:30 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id DC20D38C8047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 12:03:25 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3OG3OVg086686
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 12:03:25 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3OG2FxN019891
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 10:02:15 -0600
Received: from [9.41.105.123] ([9.41.105.123])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r3OG2EJH019775
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 10:02:15 -0600
Message-ID: <51780205.703@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 11:02:13 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 9/13] Use stop machine to update cpu maps
References: <5177FB74.2050709@linux.vnet.ibm.com>
In-Reply-To: <5177FB74.2050709@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The new PRRN firmware feature allows CPU and memory resources to be
transparently reassigned across NUMA boundaries. When this happens, the
kernel must update the node maps to reflect the new affinity information.

Although the NUMA maps can be protected by locking primitives during the
update itself, this is insufficient to prevent concurrent accesses to these
structures. Since cpumask_of_node() hands out a pointer to these
structures, they can still be modified outside of the lock. Furthermore,
tracking down each usage of these pointers and adding locks would be quite
invasive and difficult to maintain.

The approach used is to make a list of affected cpus and call stop_machine
to have the update routine run on each of the affected cpus allowing them
to update themselves. Each cpu finds itself in the list of cpus and makes
the appropriate updates. We need to have each cpu do this for themselves to
handle calls to vdso_getcpu_init() added in a subsequent patch.

Situations like these are best handled using stop_machine(). Since the NUMA
affinity updates are exceptionally rare events, this approach has the
benefit of not adding any overhead while accessing the NUMA maps during
normal operation.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |   82 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 64 insertions(+), 18 deletions(-)

Index: powerpc/arch/powerpc/mm/numa.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/numa.c	2013-04-23 15:20:18.000000000 -0500
+++ powerpc/arch/powerpc/mm/numa.c	2013-04-23 15:26:54.000000000 -0500
@@ -22,6 +22,7 @@
 #include <linux/pfn.h>
 #include <linux/cpuset.h>
 #include <linux/node.h>
+#include <linux/stop_machine.h>
 #include <asm/sparsemem.h>
 #include <asm/prom.h>
 #include <asm/smp.h>
@@ -1254,6 +1255,13 @@
 
 /* Virtual Processor Home Node (VPHN) support */
 #ifdef CONFIG_PPC_SPLPAR
+struct topology_update_data {
+	struct topology_update_data *next;
+	unsigned int cpu;
+	int old_nid;
+	int new_nid;
+};
+
 static u8 vphn_cpu_change_counts[NR_CPUS][MAX_DISTANCE_REF_POINTS];
 static cpumask_t cpu_associativity_changes_mask;
 static int vphn_enabled;
@@ -1405,41 +1413,79 @@
 }
 
 /*
+ * Update the CPU maps and sysfs entries for a single CPU when its NUMA
+ * characteristics change. This function doesn't perform any locking and is
+ * only safe to call from stop_machine().
+ */
+static int update_cpu_topology(void *data)
+{
+	struct topology_update_data *update;
+	unsigned long cpu;
+
+	if (!data)
+		return -EINVAL;
+
+	cpu = get_cpu();
+
+	for (update = data; update; update = update->next) {
+		if (cpu != update->cpu)
+			continue;
+
+		unregister_cpu_under_node(update->cpu, update->old_nid);
+		unmap_cpu_from_node(update->cpu);
+		map_cpu_to_node(update->cpu, update->new_nid);
+		register_cpu_under_node(update->cpu, update->new_nid);
+	}
+
+	return 0;
+}
+
+/*
  * Update the node maps and sysfs entries for each cpu whose home node
  * has changed. Returns 1 when the topology has changed, and 0 otherwise.
  */
 int arch_update_cpu_topology(void)
 {
-	int cpu, nid, old_nid, changed = 0;
+	unsigned int cpu, changed = 0;
+	struct topology_update_data *updates, *ud;
 	unsigned int associativity[VPHN_ASSOC_BUFSIZE] = {0};
 	struct device *dev;
+	int weight, i = 0;
+
+	weight = cpumask_weight(&cpu_associativity_changes_mask);
+	if (!weight)
+		return 0;
+
+	updates = kzalloc(weight * (sizeof(*updates)), GFP_KERNEL);
+	if (!updates)
+		return 0;
 
 	for_each_cpu(cpu, &cpu_associativity_changes_mask) {
+		ud = &updates[i++];
+		ud->cpu = cpu;
 		vphn_get_associativity(cpu, associativity);
-		nid = associativity_to_nid(associativity);
+		ud->new_nid = associativity_to_nid(associativity);
 
-		if (nid < 0 || !node_online(nid))
-			nid = first_online_node;
+		if (ud->new_nid < 0 || !node_online(ud->new_nid))
+			ud->new_nid = first_online_node;
 
-		old_nid = numa_cpu_lookup_table[cpu];
+		ud->old_nid = numa_cpu_lookup_table[cpu];
 
-		/* Disable hotplug while we update the cpu
-		 * masks and sysfs.
-		 */
-		get_online_cpus();
-		unregister_cpu_under_node(cpu, old_nid);
-		unmap_cpu_from_node(cpu);
-		map_cpu_to_node(cpu, nid);
-		register_cpu_under_node(cpu, nid);
-		put_online_cpus();
+		if (i < weight)
+			ud->next = &updates[i];
+	}
+
+	stop_machine(update_cpu_topology, &updates[0], cpu_online_mask);
 
-		dev = get_cpu_device(cpu);
+	for (ud = &updates[0]; ud; ud = ud->next) {
+		dev = get_cpu_device(ud->cpu);
 		if (dev)
 			kobject_uevent(&dev->kobj, KOBJ_CHANGE);
-		cpumask_clear_cpu(cpu, &cpu_associativity_changes_mask);
+		cpumask_clear_cpu(ud->cpu, &cpu_associativity_changes_mask);
 		changed = 1;
 	}
 
+	kfree(updates);
 	return changed;
 }
 
@@ -1488,10 +1534,10 @@
 	int rc = NOTIFY_DONE;
 
 	switch (action) {
-	case OF_RECONFIG_ADD_PROPERTY:
 	case OF_RECONFIG_UPDATE_PROPERTY:
 		update = (struct of_prop_reconfig *)data;
-		if (!of_prop_cmp(update->dn->type, "cpu")) {
+		if (!of_prop_cmp(update->dn->type, "cpu") &&
+		    !of_prop_cmp(update->prop->name, "ibm,associativity")) {
 			u32 core_id;
 			of_property_read_u32(update->dn, "reg", &core_id);
 			stage_topology_update(core_id);
