Return-Path: <nathanl@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CF25E679F9
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 12:29:19 +1100 (EST)
Received: from e5.ny.us.ibm.com ([192.168.1.105])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id k2L0fBsw003662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:41:11 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2L0evcV015137
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:40:57 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2L0elOM256076
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:40:47 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2L0ekww013678
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:40:46 -0500
Subject: [PATCH 6/7] powerpc numa: Support sparse online node map
In-Reply-To: <1142901225978-git-send-email-nathanl@austin.ibm.com>
Date: Mon, 20 Mar 2006 18:36:45 -0600
Message-Id: <11429014053652-git-send-email-nathanl@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linuxppc-dev@ozlabs.org
From: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Nathan Lynch <nathanl@austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The powerpc numa code unconditionally onlines all nodes from 0 to the
highest node id found, regardless of whether cpus or memory are
present in the nodes.  This wastes 8K per node and complicates some
cpu and memory hotplug situations, such as adding a resource that
doesn't map to one of the nodes discovered at boot.

Set nodes online as resources are scanned.  Fall back to node 0 only
when we're sure this isn't a NUMA machine.

Instead of defaulting to node 0 for cases of hot-adding a resource
which doesn't belong to any initialized node, assign it to the first
online node.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>

---

 arch/powerpc/mm/numa.c |   95 ++++++++++++++++++++++--------------------------
 1 files changed, 43 insertions(+), 52 deletions(-)

d49f5d199a1939ebf55c9554caf78fbe7e32c598
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 4a6cbb0..fe0ee6d 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -191,27 +191,28 @@ static int *of_get_associativity(struct 
 	return (unsigned int *)get_property(dev, "ibm,associativity", NULL);
 }
 
+/* Returns nid in the range [0..MAX_NUMNODES-1], or -1 if no useful numa
+ * info is found.
+ */
 static int of_node_to_nid(struct device_node *device)
 {
-	int nid;
+	int nid = -1;
 	unsigned int *tmp;
 
 	if (min_common_depth == -1)
-		return 0;
+		goto out;
 
 	tmp = of_get_associativity(device);
-	if (tmp && (tmp[0] >= min_common_depth)) {
+	if (!tmp)
+		goto out;
+
+	if (tmp[0] >= min_common_depth)
 		nid = tmp[min_common_depth];
-	} else {
-		dbg("WARNING: no NUMA information for %s\n",
-		    device->full_name);
-		nid = 0;
-	}
 
 	/* POWER4 LPAR uses 0xffff as invalid node */
-	if (nid == 0xffff)
-		nid = 0;
-
+	if (nid == 0xffff || nid >= MAX_NUMNODES)
+		nid = -1;
+out:
 	return nid;
 }
 
@@ -301,15 +302,9 @@ static int __cpuinit numa_setup_cpu(unsi
 
 	nid = of_node_to_nid(cpu);
 
-	if (nid >= num_online_nodes()) {
-		printk(KERN_ERR "WARNING: cpu %ld "
-		       "maps to invalid NUMA node %d\n",
-		       lcpu, nid);
-		nid = 0;
-	}
+	if (nid < 0 || !node_online(nid))
+		nid = any_online_node(NODE_MASK_ALL);
 out:
-	node_set_online(nid);
-
 	map_cpu_to_node(lcpu, nid);
 
 	of_node_put(cpu);
@@ -376,7 +371,7 @@ static int __init parse_numa_properties(
 {
 	struct device_node *cpu = NULL;
 	struct device_node *memory = NULL;
-	int max_domain = 0;
+	int default_nid = 0;
 	unsigned long i;
 
 	if (numa_enabled == 0) {
@@ -392,25 +387,26 @@ static int __init parse_numa_properties(
 	dbg("NUMA associativity depth for CPU/Memory: %d\n", min_common_depth);
 
 	/*
-	 * Even though we connect cpus to numa domains later in SMP init,
-	 * we need to know the maximum node id now. This is because each
-	 * node id must have NODE_DATA etc backing it.
-	 * As a result of hotplug we could still have cpus appear later on
-	 * with larger node ids. In that case we force the cpu into node 0.
+	 * Even though we connect cpus to numa domains later in SMP
+	 * init, we need to know the node ids now. This is because
+	 * each node to be onlined must have NODE_DATA etc backing it.
 	 */
-	for_each_cpu(i) {
+	for_each_present_cpu(i) {
 		int nid;
 
 		cpu = find_cpu_node(i);
+		BUG_ON(!cpu);
+		nid = of_node_to_nid(cpu);
+		of_node_put(cpu);
 
-		if (cpu) {
-			nid = of_node_to_nid(cpu);
-			of_node_put(cpu);
-
-			if (nid < MAX_NUMNODES &&
-			    max_domain < nid)
-				max_domain = nid;
-		}
+		/*
+		 * Don't fall back to default_nid yet -- we will plug
+		 * cpus into nodes once the memory scan has discovered
+		 * the topology.
+		 */
+		if (nid < 0)
+			continue;
+		node_set_online(nid);
 	}
 
 	get_n_mem_cells(&n_mem_addr_cells, &n_mem_size_cells);
@@ -439,17 +435,15 @@ new_range:
 		start = read_n_cells(n_mem_addr_cells, &memcell_buf);
 		size = read_n_cells(n_mem_size_cells, &memcell_buf);
 
+		/*
+		 * Assumption: either all memory nodes or none will
+		 * have associativity properties.  If none, then
+		 * everything goes to default_nid.
+		 */
 		nid = of_node_to_nid(memory);
-
-		if (nid >= MAX_NUMNODES) {
-			printk(KERN_ERR "WARNING: memory at %lx maps "
-			       "to invalid NUMA node %d\n", start,
-			       nid);
-			nid = 0;
-		}
-
-		if (max_domain < nid)
-			max_domain = nid;
+		if (nid < 0)
+			nid = default_nid;
+		node_set_online(nid);
 
 		if (!(size = numa_enforce_memory_limit(start, size))) {
 			if (--ranges)
@@ -465,10 +459,7 @@ new_range:
 			goto new_range;
 	}
 
-	for (i = 0; i <= max_domain; i++)
-		node_set_online(i);
-
-	max_domain = numa_setup_cpu(boot_cpuid);
+	numa_setup_cpu(boot_cpuid);
 
 	return 0;
 }
@@ -768,10 +759,10 @@ int hot_add_scn_to_nid(unsigned long scn
 {
 	struct device_node *memory = NULL;
 	nodemask_t nodes;
-	int nid = 0;
+	int default_nid = any_online_node(NODE_MASK_ALL);
 
 	if (!numa_enabled || (min_common_depth < 0))
-		return nid;
+		return default_nid;
 
 	while ((memory = of_find_node_by_type(memory, "memory")) != NULL) {
 		unsigned long start, size;
@@ -791,8 +782,8 @@ ha_new_range:
 		nid = of_node_to_nid(memory);
 
 		/* Domains not present at boot default to 0 */
-		if (!node_online(nid))
-			nid = any_online_node(NODE_MASK_ALL);
+		if (nid < 0 || !node_online(nid))
+			nid = default_nid;
 
 		if ((scn_addr >= start) && (scn_addr < (start + size))) {
 			of_node_put(memory);
-- 
1.2.4
