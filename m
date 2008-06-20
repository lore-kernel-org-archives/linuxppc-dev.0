Return-Path: <nfont@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 12EACDDEED
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 07:34:38 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5KLYaxG025340
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:34:36 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5KLYaTj183674
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:34:36 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5KLYZhj013601
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:34:35 -0400
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m5KLYZu5013590
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:34:35 -0400
Received: from [9.53.40.161] (mudbug-009053040161.austin.ibm.com [9.53.40.161])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m5KLYZqW063266
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 16:34:35 -0500
Message-ID: <485C226B.6050807@austin.ibm.com>
Date: Fri, 20 Jun 2008 16:34:35 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/5] Helper routines for parsing drconf memory
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

This patch pulls several pieces of exisitng code for parsing memory under
the ibm,dynamic-reconfiguration-memory node of the device tree into helper
routines.  This is in preparation for the next patch that will also use these
same helper routines.  There are no functional changes in this patch.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

Index: linux-2.6.git/arch/powerpc/mm/numa.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/mm/numa.c	2008-06-03 16:29:04.000000000 -0500
+++ linux-2.6.git/arch/powerpc/mm/numa.c	2008-06-19 23:11:47.000000000 -0500
@@ -268,6 +268,144 @@
  	return result;
  }

+struct of_drconf_cell {
+	u64	base_addr;
+	u32	drc_index;
+	u32	reserved;
+	u32	aa_index;
+	u32	flags;
+};
+
+#define DRCONF_MEM_ASSIGNED	0x00000008
+#define DRCONF_MEM_AI_INVALID	0x00000040
+#define DRCONF_MEM_RESERVED	0x00000080
+
+/*
+ * Read the next lmb list entry from the ibm,dynamic-memory property
+ * and return the information in the provided of_drconf_cell structure.
+ */
+static void read_drconf_cell(struct of_drconf_cell *drmem, const u32 **cellp)
+{
+	const u32 *cp;
+
+	drmem->base_addr = read_n_cells(n_mem_addr_cells, cellp);
+
+	cp = *cellp;
+	drmem->drc_index = cp[0];
+	drmem->reserved = cp[1];
+	drmem->aa_index = cp[2];
+	drmem->flags = cp[3];
+
+	*cellp = cp + 4;
+}
+
+/*
+ * Retreive and validate the ibm,dynamic-memory property of the device tree.
+ *
+ * The layout of the ibm,dynamic-memory property is a number N of lmb
+ * list entries followed by N lmb list entries.  Each lmb list entry
+ * contains information as layed out in the of_drconf_cell struct above.
+ */
+static int of_get_drconf_memory(struct device_node *memory, const u32 **dm)
+{
+	const u32 *prop;
+	u32 len, entries;
+
+	prop = of_get_property(memory, "ibm,dynamic-memory", &len);
+	if (!prop || len < sizeof(unsigned int))
+		return 0;
+
+	entries = *prop++;
+
+	/* Now that we know the number of entries, revalidate the size
+	 * of the property read in to ensure we have everything
+	 */
+	if (len < (entries * (n_mem_addr_cells + 4) + 1) * sizeof(unsigned int))
+		return 0;
+
+	*dm = prop;
+	return entries;
+}
+
+/*
+ * Retreive and validate the ibm,lmb-size property for drconf memory
+ * from the device tree.
+ */
+static u64 of_get_lmb_size(struct device_node *memory)
+{
+	const u32 *prop;
+	u32 len;
+
+	prop = of_get_property(memory, "ibm,lmb-size", &len);
+	if (!prop || len < sizeof(unsigned int))
+		return 0;
+
+	return read_n_cells(n_mem_size_cells, &prop);
+}
+
+struct assoc_arrays {
+	u32	n_arrays;
+	u32	array_sz;
+	const u32 *arrays;
+};
+
+/*
+ * Retreive and validate the list of associativity arrays for drconf
+ * memory from the ibm,associativity-lookup-arrays property of the
+ * device tree..
+ *
+ * The layout of the ibm,associativity-lookup-arrays property is a number N
+ * indicating the number of associativity arrays, followed by a number M
+ * indicating the size of each associativity array, followed by a list
+ * of N associativity arrays.
+ */
+static int of_get_assoc_arrays(struct device_node *memory,
+			       struct assoc_arrays *aa)
+{
+	const u32 *prop;
+	u32 len;
+
+	prop = of_get_property(memory, "ibm,associativity-lookup-arrays", &len);
+	if (!prop || len < 2 * sizeof(unsigned int))
+		return -1;
+
+	aa->n_arrays = *prop++;
+	aa->array_sz = *prop++;
+
+	/* Now that we know the number of arrrays and size of each array,
+	 * revalidate the size of the property read in.
+	 */
+	if (len < (aa->n_arrays * aa->array_sz + 2) * sizeof(unsigned int))
+		return -1;
+
+	aa->arrays = prop;
+	return 0;
+}
+
+/*
+ * This is like of_node_to_nid_single() for memory represented in the
+ * ibm,dynamic-reconfiguration-memory node.
+ */
+static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
+				   struct assoc_arrays *aa)
+{
+	int default_nid = 0;
+	int nid = default_nid;
+	int index;
+
+	if (min_common_depth > 0 && min_common_depth <= aa->array_sz &&
+	    !(drmem->flags & DRCONF_MEM_AI_INVALID) &&
+	    drmem->aa_index < aa->n_arrays) {
+		index = drmem->aa_index * aa->array_sz + min_common_depth - 1;
+		nid = aa->arrays[index];
+
+		if (nid == 0xffff || nid >= MAX_NUMNODES)
+			nid = default_nid;
+	}
+
+	return nid;
+}
+
  /*
   * Figure out to which domain a cpu belongs and stick it there.
   * Return the id of the domain used.
@@ -355,57 +493,49 @@
   */
  static void __init parse_drconf_memory(struct device_node *memory)
  {
-	const unsigned int *lm, *dm, *aa;
-	unsigned int ls, ld, la;
-	unsigned int n, aam, aalen;
-	unsigned long lmb_size, size, start;
-	int nid, default_nid = 0;
-	unsigned int ai, flags;
-
-	lm = of_get_property(memory, "ibm,lmb-size", &ls);
-	dm = of_get_property(memory, "ibm,dynamic-memory", &ld);
-	aa = of_get_property(memory, "ibm,associativity-lookup-arrays", &la);
-	if (!lm || !dm || !aa ||
-	    ls < sizeof(unsigned int) || ld < sizeof(unsigned int) ||
-	    la < 2 * sizeof(unsigned int))
+	const u32 *dm;
+	unsigned int n, rc;
+	unsigned long lmb_size, size;
+	int nid;
+	struct assoc_arrays aa;
+
+	n = of_get_drconf_memory(memory, &dm);
+	if (!n)
  		return;

-	lmb_size = read_n_cells(n_mem_size_cells, &lm);
-	n = *dm++;		/* number of LMBs */
-	aam = *aa++;		/* number of associativity lists */
-	aalen = *aa++;		/* length of each associativity list */
-	if (ld < (n * (n_mem_addr_cells + 4) + 1) * sizeof(unsigned int) ||
-	    la < (aam * aalen + 2) * sizeof(unsigned int))
+	lmb_size = of_get_lmb_size(memory);
+	if (!lmb_size)
+		return;
+
+	rc = of_get_assoc_arrays(memory, &aa);
+	if (rc)
  		return;

  	for (; n != 0; --n) {
-		start = read_n_cells(n_mem_addr_cells, &dm);
-		ai = dm[2];
-		flags = dm[3];
-		dm += 4;
-		/* 0x80 == reserved, 0x8 = assigned to us */
-		if ((flags & 0x80) || !(flags & 0x8))
-			continue;
-		nid = default_nid;
-		/* flags & 0x40 means associativity index is invalid */
-		if (min_common_depth > 0 && min_common_depth <= aalen &&
-		    (flags & 0x40) == 0 && ai < aam) {
-			/* this is like of_node_to_nid_single */
-			nid = aa[ai * aalen + min_common_depth - 1];
-			if (nid == 0xffff || nid >= MAX_NUMNODES)
-				nid = default_nid;
-		}
+		struct of_drconf_cell drmem;

-		fake_numa_create_new_node(((start + lmb_size) >> PAGE_SHIFT),
-						&nid);
+		read_drconf_cell(&drmem, &dm);
+
+		/* skip this block if the reserved bit is set in flags (0x80)
+		   or if the block is not assigned to this partition (0x8) */
+		if ((drmem.flags & DRCONF_MEM_RESERVED)
+		    || !(drmem.flags & DRCONF_MEM_ASSIGNED))
+ 			continue;
+
+		nid = of_drconf_to_nid_single(&drmem, &aa);
+
+		fake_numa_create_new_node(
+				((drmem.base_addr + lmb_size) >> PAGE_SHIFT),
+					   &nid);
  		node_set_online(nid);

-		size = numa_enforce_memory_limit(start, lmb_size);
+		size = numa_enforce_memory_limit(drmem.base_addr, lmb_size);
  		if (!size)
  			continue;

-		add_active_range(nid, start >> PAGE_SHIFT,
-				 (start >> PAGE_SHIFT) + (size >> PAGE_SHIFT));
+		add_active_range(nid, drmem.base_addr >> PAGE_SHIFT,
+				 (drmem.base_addr >> PAGE_SHIFT)
+				 + (size >> PAGE_SHIFT));
  	}
  }
