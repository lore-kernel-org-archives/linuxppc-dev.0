Return-Path: <nathanl@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 89755679E1
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 11:50:49 +1100 (EST)
Received: from e4.ny.us.ibm.com ([192.168.1.104])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id k2L0eAC9002991
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:40:10 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2L0dumt003442
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:39:56 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2L0dkOM222468
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:39:46 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2L0dkMB007168
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2006 19:39:46 -0500
Subject: [PATCH 4/7] powerpc numa: Get rid of "numa domain" terminology
In-Reply-To: <1142901225978-git-send-email-nathanl@austin.ibm.com>
Date: Mon, 20 Mar 2006 18:35:45 -0600
Message-Id: <11429013451865-git-send-email-nathanl@austin.ibm.com>
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

Since we effectively treat the domain ids given to us by firmare as
logical node ids, make this explicit (basically s/numa_domain/nid/).

No functional changes, only variable and function names are modified.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>

---

 arch/powerpc/mm/numa.c |   78 ++++++++++++++++++++++++------------------------
 1 files changed, 39 insertions(+), 39 deletions(-)

9bdff379544896ca96bad4881fa614a19ddf9d21
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 1c3df1d..e511ca1 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -191,9 +191,9 @@ static int *of_get_associativity(struct 
 	return (unsigned int *)get_property(dev, "ibm,associativity", NULL);
 }
 
-static int of_node_numa_domain(struct device_node *device)
+static int of_node_to_nid(struct device_node *device)
 {
-	int numa_domain;
+	int nid;
 	unsigned int *tmp;
 
 	if (min_common_depth == -1)
@@ -201,13 +201,13 @@ static int of_node_numa_domain(struct de
 
 	tmp = of_get_associativity(device);
 	if (tmp && (tmp[0] >= min_common_depth)) {
-		numa_domain = tmp[min_common_depth];
+		nid = tmp[min_common_depth];
 	} else {
 		dbg("WARNING: no NUMA information for %s\n",
 		    device->full_name);
-		numa_domain = 0;
+		nid = 0;
 	}
-	return numa_domain;
+	return nid;
 }
 
 /*
@@ -286,7 +286,7 @@ static unsigned long __devinit read_n_ce
  */
 static int __cpuinit numa_setup_cpu(unsigned long lcpu)
 {
-	int numa_domain = 0;
+	int nid = 0;
 	struct device_node *cpu = find_cpu_node(lcpu);
 
 	if (!cpu) {
@@ -294,27 +294,27 @@ static int __cpuinit numa_setup_cpu(unsi
 		goto out;
 	}
 
-	numa_domain = of_node_numa_domain(cpu);
+	nid = of_node_to_nid(cpu);
 
-	if (numa_domain >= num_online_nodes()) {
+	if (nid >= num_online_nodes()) {
 		/*
 		 * POWER4 LPAR uses 0xffff as invalid node,
 		 * dont warn in this case.
 		 */
-		if (numa_domain != 0xffff)
+		if (nid != 0xffff)
 			printk(KERN_ERR "WARNING: cpu %ld "
 			       "maps to invalid NUMA node %d\n",
-			       lcpu, numa_domain);
-		numa_domain = 0;
+			       lcpu, nid);
+		nid = 0;
 	}
 out:
-	node_set_online(numa_domain);
+	node_set_online(nid);
 
-	map_cpu_to_node(lcpu, numa_domain);
+	map_cpu_to_node(lcpu, nid);
 
 	of_node_put(cpu);
 
-	return numa_domain;
+	return nid;
 }
 
 static int cpu_numa_callback(struct notifier_block *nfb,
@@ -399,17 +399,17 @@ static int __init parse_numa_properties(
 	 * with larger node ids. In that case we force the cpu into node 0.
 	 */
 	for_each_cpu(i) {
-		int numa_domain;
+		int nid;
 
 		cpu = find_cpu_node(i);
 
 		if (cpu) {
-			numa_domain = of_node_numa_domain(cpu);
+			nid = of_node_to_nid(cpu);
 			of_node_put(cpu);
 
-			if (numa_domain < MAX_NUMNODES &&
-			    max_domain < numa_domain)
-				max_domain = numa_domain;
+			if (nid < MAX_NUMNODES &&
+			    max_domain < nid)
+				max_domain = nid;
 		}
 	}
 
@@ -418,7 +418,7 @@ static int __init parse_numa_properties(
 	while ((memory = of_find_node_by_type(memory, "memory")) != NULL) {
 		unsigned long start;
 		unsigned long size;
-		int numa_domain;
+		int nid;
 		int ranges;
 		unsigned int *memcell_buf;
 		unsigned int len;
@@ -439,18 +439,18 @@ new_range:
 		start = read_n_cells(n_mem_addr_cells, &memcell_buf);
 		size = read_n_cells(n_mem_size_cells, &memcell_buf);
 
-		numa_domain = of_node_numa_domain(memory);
+		nid = of_node_to_nid(memory);
 
-		if (numa_domain >= MAX_NUMNODES) {
-			if (numa_domain != 0xffff)
+		if (nid >= MAX_NUMNODES) {
+			if (nid != 0xffff)
 				printk(KERN_ERR "WARNING: memory at %lx maps "
 				       "to invalid NUMA node %d\n", start,
-				       numa_domain);
-			numa_domain = 0;
+				       nid);
+			nid = 0;
 		}
 
-		if (max_domain < numa_domain)
-			max_domain = numa_domain;
+		if (max_domain < nid)
+			max_domain = nid;
 
 		if (!(size = numa_enforce_memory_limit(start, size))) {
 			if (--ranges)
@@ -459,7 +459,7 @@ new_range:
 				continue;
 		}
 
-		add_region(numa_domain, start >> PAGE_SHIFT,
+		add_region(nid, start >> PAGE_SHIFT,
 			   size >> PAGE_SHIFT);
 
 		if (--ranges)
@@ -769,10 +769,10 @@ int hot_add_scn_to_nid(unsigned long scn
 {
 	struct device_node *memory = NULL;
 	nodemask_t nodes;
-	int numa_domain = 0;
+	int nid = 0;
 
 	if (!numa_enabled || (min_common_depth < 0))
-		return numa_domain;
+		return nid;
 
 	while ((memory = of_find_node_by_type(memory, "memory")) != NULL) {
 		unsigned long start, size;
@@ -789,15 +789,15 @@ int hot_add_scn_to_nid(unsigned long scn
 ha_new_range:
 		start = read_n_cells(n_mem_addr_cells, &memcell_buf);
 		size = read_n_cells(n_mem_size_cells, &memcell_buf);
-		numa_domain = of_node_numa_domain(memory);
+		nid = of_node_to_nid(memory);
 
 		/* Domains not present at boot default to 0 */
-		if (!node_online(numa_domain))
-			numa_domain = any_online_node(NODE_MASK_ALL);
+		if (!node_online(nid))
+			nid = any_online_node(NODE_MASK_ALL);
 
 		if ((scn_addr >= start) && (scn_addr < (start + size))) {
 			of_node_put(memory);
-			goto got_numa_domain;
+			goto got_nid;
 		}
 
 		if (--ranges)		/* process all ranges in cell */
@@ -806,12 +806,12 @@ ha_new_range:
 	BUG();	/* section address should be found above */
 
 	/* Temporary code to ensure that returned node is not empty */
-got_numa_domain:
+got_nid:
 	nodes_setall(nodes);
-	while (NODE_DATA(numa_domain)->node_spanned_pages == 0) {
-		node_clear(numa_domain, nodes);
-		numa_domain = any_online_node(nodes);
+	while (NODE_DATA(nid)->node_spanned_pages == 0) {
+		node_clear(nid, nodes);
+		nid = any_online_node(nodes);
 	}
-	return numa_domain;
+	return nid;
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
-- 
1.2.4
