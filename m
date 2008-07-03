Return-Path: <nfont@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DEA2CDDEDD
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 13:25:07 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m633P3mP006041
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 23:25:03 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m633P3EJ171538
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 21:25:03 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m633P3Nn014077
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 21:25:03 -0600
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m633P3fD014072
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 21:25:03 -0600
Received: from [9.65.174.195] (sig-9-65-174-195.mts.ibm.com [9.65.174.195])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m633P2ZP049546
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 22:25:02 -0500
Message-ID: <486C4694.3040504@austin.ibm.com>
Date: Wed, 02 Jul 2008 22:25:08 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5 v2] Update numa association of hotplug memory add for
	drconf memory
References: <486C4462.4010004@austin.ibm.com>
In-Reply-To: <486C4462.4010004@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update the association of a memory section with a numa node that occurs during
hotplug add of a memory section.  This adds a check in the
hot_add_scn_to_nid() routine for the ibm,dyamic-reconfiguration-memory node 
in the device tree.  If present the new hot_add_drconf_scn_to_nid() routine 
is invoked, which can properly parse the ibm,dynamic-reconfiguration-memory
node of the device tree and make the proper numa node associations.

This also introduces the valid_hot_add_scn() routine as a helper
function for code that is common to the hot_add_scn_to_nid() and
hot_add_drconf_scn_to_nid() routines.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---
 arch/powerpc/mm/numa.c |  101 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 83 insertions(+), 18 deletions(-)

Index: linux-2.6.git/arch/powerpc/mm/numa.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/mm/numa.c	2008-07-01 18:43:44.000000000 -0500
+++ linux-2.6.git/arch/powerpc/mm/numa.c	2008-07-01 18:43:50.000000000 -0500
@@ -901,6 +901,79 @@
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 /*
+ * Validate the node associated with the memory section we are
+ * trying to add.
+ */
+int valid_hot_add_scn(int *nid, unsigned long start, u32 lmb_size,
+		      unsigned long scn_addr)
+{
+	nodemask_t nodes;
+
+	if (*nid < 0 || !node_online(*nid))
+		*nid = any_online_node(NODE_MASK_ALL);
+
+	if ((scn_addr >= start) && (scn_addr < (start + lmb_size))) {
+		nodes_setall(nodes);
+		while (NODE_DATA(*nid)->node_spanned_pages == 0) {
+			node_clear(*nid, nodes);
+			*nid = any_online_node(nodes);
+		}
+
+		return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * Find the node associated with a hot added memory section represented
+ * by the ibm,dynamic-reconfiguration-memory node.
+ */
+static int hot_add_drconf_scn_to_nid(struct device_node *memory,
+				     unsigned long scn_addr)
+{
+	const u32 *dm;
+	unsigned int n, rc;
+	unsigned long lmb_size;
+	int default_nid = any_online_node(NODE_MASK_ALL);
+	int nid;
+	struct assoc_arrays aa;
+
+	n = of_get_drconf_memory(memory, &dm);
+	if (!n)
+		return default_nid;;
+
+	lmb_size = of_get_lmb_size(memory);
+	if (!lmb_size)
+		return default_nid;
+
+	rc = of_get_assoc_arrays(memory, &aa);
+	if (rc)
+		return default_nid;
+
+	for (; n != 0; --n) {
+		struct of_drconf_cell drmem;
+
+		read_drconf_cell(&drmem, &dm);
+
+		/* skip this block if it is reserved or not assigned to
+		 * this partition */
+		if ((drmem.flags & DRCONF_MEM_RESERVED)
+		    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
+			continue;
+
+		nid = of_drconf_to_nid_single(&drmem, &aa);
+
+		if (valid_hot_add_scn(&nid, drmem.base_addr, lmb_size,
+				      scn_addr))
+			return nid;
+	}
+
+	BUG();	/* section address should be found above */
+	return 0;
+}
+
+/*
  * Find the node associated with a hot added memory section.  Section
  * corresponds to a SPARSEMEM section, not an LMB.  It is assumed that
  * sections are fully contained within a single LMB.
@@ -908,12 +981,17 @@
 int hot_add_scn_to_nid(unsigned long scn_addr)
 {
 	struct device_node *memory = NULL;
-	nodemask_t nodes;
-	int default_nid = any_online_node(NODE_MASK_ALL);
 	int nid;
 
 	if (!numa_enabled || (min_common_depth < 0))
-		return default_nid;
+		return any_online_node(NODE_MASK_ALL);
+
+	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (memory) {
+		nid = hot_add_drconf_scn_to_nid(memory, scn_addr);
+		of_node_put(memory);
+		return nid;
+	}
 
 	while ((memory = of_find_node_by_type(memory, "memory")) != NULL) {
 		unsigned long start, size;
@@ -932,13 +1010,9 @@
 		size = read_n_cells(n_mem_size_cells, &memcell_buf);
 		nid = of_node_to_nid_single(memory);
 
-		/* Domains not present at boot default to 0 */
-		if (nid < 0 || !node_online(nid))
-			nid = default_nid;
-
-		if ((scn_addr >= start) && (scn_addr < (start + size))) {
+		if (valid_hot_add_scn(&nid, start, size, scn_addr)) {
 			of_node_put(memory);
-			goto got_nid;
+			return nid;
 		}
 
 		if (--ranges)		/* process all ranges in cell */
@@ -946,14 +1020,5 @@
 	}
 	BUG();	/* section address should be found above */
 	return 0;
-
-	/* Temporary code to ensure that returned node is not empty */
-got_nid:
-	nodes_setall(nodes);
-	while (NODE_DATA(nid)->node_spanned_pages == 0) {
-		node_clear(nid, nodes);
-		nid = any_online_node(nodes);
-	}
-	return nid;
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
