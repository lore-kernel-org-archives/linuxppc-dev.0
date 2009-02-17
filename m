Return-Path: <nfont@austin.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6D511DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 05:29:00 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n1HIR7sx030921
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 11:27:07 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n1HISRTj210654
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 11:28:57 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1HI8Wkj032229
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 11:08:32 -0700
Message-ID: <499AFD1E.9010207@austin.ibm.com>
Date: Tue, 17 Feb 2009 12:08:30 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Cleanup hot_add_scn_to_nid
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: dave Hansen <dave@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch reworks the hot_add_scn_to_nid and its supporting functions
to make them easier to understand.  There are no functional changes in
this patch and has been tested on machine with memory represented in the
device tree as memory nodes and in the ibm,dynamic-memory property.

My previous patch that introduced support for hotplug memory add on 
systems whose memory was represented by the ibm,dynamic-memory property
of the device tree only left the code more unintelligible.  This
will hopefully makes things easier to understand.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

 arch/powerpc/mm/numa.c |  131 +++++++++++++++++++++++++------------------------
 1 file changed, 69 insertions(+), 62 deletions(-)

Index: linux-2.6/arch/powerpc/mm/numa.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/numa.c	2009-02-11 10:58:20.000000000 -0600
+++ linux-2.6/arch/powerpc/mm/numa.c	2009-02-17 10:52:16.000000000 -0600
@@ -1040,57 +1040,32 @@
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 /*
- * Validate the node associated with the memory section we are
- * trying to add.
- */
-int valid_hot_add_scn(int *nid, unsigned long start, u32 lmb_size,
-		      unsigned long scn_addr)
-{
-	nodemask_t nodes;
-
-	if (*nid < 0 || !node_online(*nid))
-		*nid = any_online_node(NODE_MASK_ALL);
-
-	if ((scn_addr >= start) && (scn_addr < (start + lmb_size))) {
-		nodes_setall(nodes);
-		while (NODE_DATA(*nid)->node_spanned_pages == 0) {
-			node_clear(*nid, nodes);
-			*nid = any_online_node(nodes);
-		}
-
-		return 1;
-	}
-
-	return 0;
-}
-
-/*
- * Find the node associated with a hot added memory section represented
- * by the ibm,dynamic-reconfiguration-memory node.
+ * Find the node associated with a hot added memory section for
+ * memory represented in the device tree by the property
+ * ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory.
  */
 static int hot_add_drconf_scn_to_nid(struct device_node *memory,
 				     unsigned long scn_addr)
 {
 	const u32 *dm;
-	unsigned int n, rc;
+	unsigned int drconf_cell_cnt, rc;
 	unsigned long lmb_size;
-	int default_nid = any_online_node(NODE_MASK_ALL);
-	int nid;
 	struct assoc_arrays aa;
+	int nid = -1;
 
-	n = of_get_drconf_memory(memory, &dm);
-	if (!n)
-		return default_nid;;
+	drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
+	if (!drconf_cell_cnt)
+		return -1;
 
 	lmb_size = of_get_lmb_size(memory);
 	if (!lmb_size)
-		return default_nid;
+		return -1;
 
 	rc = of_get_assoc_arrays(memory, &aa);
 	if (rc)
-		return default_nid;
+		return -1;
 
-	for (; n != 0; --n) {
+	for (; drconf_cell_cnt != 0; --drconf_cell_cnt) {
 		struct of_drconf_cell drmem;
 
 		read_drconf_cell(&drmem, &dm);
@@ -1101,15 +1076,57 @@
 		    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
 			continue;
 
+		if ((scn_addr < drmem.base_addr)
+		    || (scn_addr >= (drmem.base_addr + lmb_size)))
+			continue;
+
 		nid = of_drconf_to_nid_single(&drmem, &aa);
+		break;
+	}
+
+	return nid;
+}
+
+/*
+ * Find the node associated with a hot added memory section for memory
+ * represented in the device tree as a node (i.e. memory@XXXX) for
+ * each lmb.
+ */
+int hot_add_node_scn_to_nid(unsigned long scn_addr)
+{
+	struct device_node *memory = NULL;
+	int nid = -1;
+
+	while ((memory = of_find_node_by_type(memory, "memory")) != NULL) {
+		unsigned long start, size;
+		int ranges;
+		const unsigned int *memcell_buf;
+		unsigned int len;
 
-		if (valid_hot_add_scn(&nid, drmem.base_addr, lmb_size,
-				      scn_addr))
-			return nid;
+		memcell_buf = of_get_property(memory, "reg", &len);
+		if (!memcell_buf || len <= 0)
+			continue;
+
+		/* ranges in cell */
+		ranges = (len >> 2) / (n_mem_addr_cells + n_mem_size_cells);
+
+		while (ranges--) {
+			start = read_n_cells(n_mem_addr_cells, &memcell_buf);
+			size = read_n_cells(n_mem_size_cells, &memcell_buf);
+
+			if ((scn_addr < start) || (scn_addr >= (start + size)))
+				continue;
+
+			nid = of_node_to_nid_single(memory);
+			break;
+		}
+
+		of_node_put(memory);
+		if (nid >= 0)
+			break;
 	}
 
-	BUG();	/* section address should be found above */
-	return 0;
+	return nid;
 }
 
 /*
@@ -1120,7 +1137,7 @@
 int hot_add_scn_to_nid(unsigned long scn_addr)
 {
 	struct device_node *memory = NULL;
-	int nid;
+	int nid, found = 0;
 
 	if (!numa_enabled || (min_common_depth < 0))
 		return any_online_node(NODE_MASK_ALL);
@@ -1129,35 +1146,25 @@
 	if (memory) {
 		nid = hot_add_drconf_scn_to_nid(memory, scn_addr);
 		of_node_put(memory);
-		return nid;
+	} else {
+		nid = hot_add_node_scn_to_nid(scn_addr);
 	}
 
-	while ((memory = of_find_node_by_type(memory, "memory")) != NULL) {
-		unsigned long start, size;
-		int ranges;
-		const unsigned int *memcell_buf;
-		unsigned int len;
+	if (nid < 0 || !node_online(nid))
+		nid = any_online_node(NODE_MASK_ALL);
 
-		memcell_buf = of_get_property(memory, "reg", &len);
-		if (!memcell_buf || len <= 0)
-			continue;
+	if (NODE_DATA(nid)->node_spanned_pages)
+		return nid;
 
-		/* ranges in cell */
-		ranges = (len >> 2) / (n_mem_addr_cells + n_mem_size_cells);
-ha_new_range:
-		start = read_n_cells(n_mem_addr_cells, &memcell_buf);
-		size = read_n_cells(n_mem_size_cells, &memcell_buf);
-		nid = of_node_to_nid_single(memory);
-
-		if (valid_hot_add_scn(&nid, start, size, scn_addr)) {
-			of_node_put(memory);
-			return nid;
+	for_each_online_node(nid) {
+		if (NODE_DATA(nid)->node_spanned_pages) {
+			found = 1;
+			break;
 		}
-
-		if (--ranges)		/* process all ranges in cell */
-			goto ha_new_range;
 	}
-	BUG();	/* section address should be found above */
-	return 0;
+
+	BUG_ON(!found);
+	return nid;
 }
+
 #endif /* CONFIG_MEMORY_HOTPLUG */
