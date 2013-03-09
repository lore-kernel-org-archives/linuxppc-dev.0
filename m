Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A18412C0328
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Mar 2013 15:06:16 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 8 Mar 2013 21:06:14 -0700
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 4635D19D8036
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Mar 2013 21:05:42 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2945iD5141098
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:05:44 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2948J3Q011322
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:08:19 -0700
Received: from [9.76.31.13] (sig-9-76-31-13.mts.ibm.com [9.76.31.13])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r2948HWT011311
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Mar 2013 21:08:18 -0700
Message-ID: <513AB516.1070904@linux.vnet.ibm.com>
Date: Fri, 08 Mar 2013 22:05:42 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 7/11] Use stop machine to update cpu maps
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

The new PRRN firmware feature allows CPU and memory resources to be
transparently reassigned across NUMA boundaries. When this happens, the
kernel must update the node maps to reflect the new affinity
information.

Although the NUMA maps can be protected by locking primitives during the
update itself, this is insufficient to prevent concurrent accesses to these
structures. Since cpumask_of_node() hands out a pointer to these
structures, they can still be modified outside of the lock. Furthermore,
tracking down each usage of these pointers and adding locks would be quite
invasive and difficult to maintain.

Situations like these are best handled using stop_machine(). Since the NUMA
affinity updates are exceptionally rare events, this approach has the
benefit of not adding any overhead while accessing the NUMA maps during
normal operation.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |   51 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 16 deletions(-)

Index: powerpc/arch/powerpc/mm/numa.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/numa.c	2013-03-08 19:57:38.000000000 -0600
+++ powerpc/arch/powerpc/mm/numa.c	2013-03-08 19:57:47.000000000 -0600
@@ -22,6 +22,7 @@
 #include <linux/pfn.h>
 #include <linux/cpuset.h>
 #include <linux/node.h>
+#include <linux/stop_machine.h>
 #include <asm/sparsemem.h>
 #include <asm/prom.h>
 #include <asm/smp.h>
@@ -1254,6 +1255,12 @@
 
 /* Virtual Processor Home Node (VPHN) support */
 #ifdef CONFIG_PPC_SPLPAR
+struct topology_update_data {
+	int cpu;
+	int old_nid;
+	int new_nid;
+};
+
 static u8 vphn_cpu_change_counts[NR_CPUS][MAX_DISTANCE_REF_POINTS];
 static cpumask_t cpu_associativity_changes_mask;
 static int vphn_enabled;
@@ -1405,34 +1412,46 @@
 }
 
 /*
+ * Update the CPU maps and sysfs entries for a single CPU when its NUMA
+ * characteristics change. This function doesn't perform any locking and is
+ * only safe to call from stop_machine().
+ */
+static int update_cpu_topology(void *data)
+{
+	struct topology_update_data *update = data;
+
+	if (!update)
+		return -EINVAL;
+
+	unregister_cpu_under_node(update->cpu, update->old_nid);
+	unmap_cpu_from_node(update->cpu);
+	map_cpu_to_node(update->cpu, update->new_nid);
+	register_cpu_under_node(update->cpu, update->new_nid);
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
+	int cpu, changed = 0;
+	struct topology_update_data update;
 	unsigned int associativity[VPHN_ASSOC_BUFSIZE] = {0};
 	struct device *dev;
 
 	for_each_cpu(cpu, &cpu_associativity_changes_mask) {
+		update.cpu = cpu;
 		vphn_get_associativity(cpu, associativity);
-		nid = associativity_to_nid(associativity);
-
-		if (nid < 0 || !node_online(nid))
-			nid = first_online_node;
+		update.new_nid = associativity_to_nid(associativity);
 
-		old_nid = numa_cpu_lookup_table[cpu];
-
-		/* Disable hotplug while we update the cpu
-		 * masks and sysfs.
-		 */
-		get_online_cpus();
-		unregister_cpu_under_node(cpu, old_nid);
-		unmap_cpu_from_node(cpu);
-		map_cpu_to_node(cpu, nid);
-		register_cpu_under_node(cpu, nid);
-		put_online_cpus();
+		if (update.new_nid < 0 || !node_online(update.new_nid))
+			update.new_nid = first_online_node;
 
+		update.old_nid = numa_cpu_lookup_table[cpu];
+		stop_machine(update_cpu_topology, &update, cpu_online_mask);
 		dev = get_cpu_device(cpu);
 		if (dev)
 			kobject_uevent(&dev->kobj, KOBJ_CHANGE);
