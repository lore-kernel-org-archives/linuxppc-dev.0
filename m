Return-Path: <nfont@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C4086DDFC9
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 07:36:39 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5KLaaom026771
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:36:36 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5KLaaaM238848
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:36:36 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5KLaahp018024
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:36:36 -0400
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m5KLaZgN018012
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:36:36 -0400
Received: from [9.53.40.161] (mudbug-009053040161.austin.ibm.com [9.53.40.161])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m5KLaZ6d067806
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 16:36:35 -0500
Message-ID: <485C22E3.3010000@austin.ibm.com>
Date: Fri, 20 Jun 2008 16:36:35 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] Add ability to associate drconf memory sections in hotplug
	memory add
References: <485C2033.20101@austin.ibm.com>
In-Reply-To: <485C2033.20101@austin.ibm.com>
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
hotplug add of a memory section.  This adds a check for the
ibm,dyamic-reconfiguration-memory node in the device tree and calls the new
hot_add_drconf_scn_to_nid that can properly parse the device tree and make
the proper associations.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

Index: linux-2.6.git/arch/powerpc/mm/numa.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/mm/numa.c	2008-06-20 13:58:09.000000000 -0500
+++ linux-2.6.git/arch/powerpc/mm/numa.c	2008-06-20 13:59:07.000000000 -0500
@@ -900,6 +900,79 @@

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
@@ -907,12 +980,17 @@
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
@@ -931,13 +1009,9 @@
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
@@ -945,14 +1019,5 @@
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
