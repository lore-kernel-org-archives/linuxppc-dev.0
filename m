Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C54CC1A0C0C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:35 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 18:43:33 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 369A3E0056
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 18:43:47 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDTvD52101138
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:29 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDNwo000396
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:24 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 45/50] drivers/of: Avoid recursively calling
 unflatten_dt_node()
Date: Thu,  5 Nov 2015 00:12:45 +1100
Message-Id: <1446642770-4681-46-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In current implementation, unflatten_dt_node() is called recursively
to unflatten device nodes in FDT blob. It's stress to limited stack
capacity.

This avoids calling the function recursively, meaning the device
nodes are unflattened in one call on unflatten_dt_node(): two arrays
are introduced to track the parent path size and the device node of
current level of depth, which will be used by the device node on next
level of depth to be unflattened. Also, the parameter "poffset" and
"fpsize" are unused and dropped.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/of/fdt.c | 94 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 56 insertions(+), 38 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 173b036..f4793d0 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -355,61 +355,82 @@ static unsigned long populate_node(const void *blob,
 	return fpsize;
 }
 
+static void reverse_nodes(struct device_node *parent)
+{
+	struct device_node *child, *next;
+
+	/* In-depth first */
+	child = parent->child;
+	while (child) {
+		reverse_nodes(child);
+
+		child = child->sibling;
+	}
+
+	/* Reverse the nodes in the child list */
+	child = parent->child;
+	parent->child = NULL;
+	while (child) {
+		next = child->sibling;
+
+		child->sibling = parent->child;
+		parent->child = child;
+		child = next;
+	}
+}
+
 /**
  * unflatten_dt_node - Alloc and populate a device_node from the flat tree
  * @blob: The parent device tree blob
  * @mem: Memory chunk to use for allocating device nodes and properties
- * @poffset: pointer to node in flat tree
  * @dad: Parent struct device_node
  * @nodepp: The device_node tree created by the call
- * @fpsize: Size of the node path up at the current depth.
  * @dryrun: If true, do not allocate device nodes but still calculate needed
  * memory size
  */
 static void *unflatten_dt_node(const void *blob,
 			       void *mem,
-			       int *poffset,
 			       struct device_node *dad,
 			       struct device_node **nodepp,
-			       unsigned long fpsize,
 			       bool dryrun)
 {
-	struct device_node *np;
-	static int depth;
-	int old_depth;
-
-	fpsize = populate_node(blob, *poffset, &mem, dad, fpsize, &np, dryrun);
-	if (!fpsize)
-		return mem;
+	struct device_node *root;
+	int offset = 0, depth = 0;
+	unsigned long fpsizes[64];
+	struct device_node *nps[64];
 
-	old_depth = depth;
-	*poffset = fdt_next_node(blob, *poffset, &depth);
-	if (depth < 0)
-		depth = 0;
-	while (*poffset > 0 && depth > old_depth)
-		mem = unflatten_dt_node(blob, mem, poffset, np, NULL,
-					fpsize, dryrun);
+	if (nodepp)
+		*nodepp = NULL;
+
+	root = dad;
+	fpsizes[depth] = dad ? strlen(of_node_full_name(dad)) : 0;
+	nps[depth++] = dad;
+	while (offset >= 0 && depth < 64) {
+		fpsizes[depth] = populate_node(blob, offset, &mem,
+					       nps[depth - 1],
+					       fpsizes[depth - 1],
+					       &nps[depth], dryrun);
+		if (!fpsizes[depth])
+			return mem;
+
+		if (!dryrun && nodepp && !*nodepp)
+			*nodepp = nps[depth];
+		if (!dryrun && !root)
+			root = nps[depth];
+
+		offset = fdt_next_node(blob, offset, &depth);
+	}
 
-	if (*poffset < 0 && *poffset != -FDT_ERR_NOTFOUND)
-		pr_err("unflatten: error %d processing FDT\n", *poffset);
+	if (offset < 0 && offset != -FDT_ERR_NOTFOUND)
+		pr_err("%s: Error %d processing FDT\n",
+		       __func__, offset);
 
 	/*
 	 * Reverse the child list. Some drivers assumes node order matches .dts
 	 * node order
 	 */
-	if (!dryrun && np->child) {
-		struct device_node *child = np->child;
-		np->child = NULL;
-		while (child) {
-			struct device_node *next = child->sibling;
-			child->sibling = np->child;
-			np->child = child;
-			child = next;
-		}
-	}
-
-	if (nodepp)
-		*nodepp = np;
+	if (!dryrun)
+		reverse_nodes(root);
 
 	return mem;
 }
@@ -431,7 +452,6 @@ static void __unflatten_device_tree(const void *blob,
 			     void * (*dt_alloc)(u64 size, u64 align))
 {
 	unsigned long size;
-	int start;
 	void *mem;
 
 	pr_debug(" -> unflatten_device_tree()\n");
@@ -452,8 +472,7 @@ static void __unflatten_device_tree(const void *blob,
 	}
 
 	/* First pass, scan for size */
-	start = 0;
-	size = (unsigned long)unflatten_dt_node(blob, NULL, &start, NULL, NULL, 0, true);
+	size = (unsigned long)unflatten_dt_node(blob, NULL, NULL, NULL, true);
 	size = ALIGN(size, 4);
 
 	pr_debug("  size is %lx, allocating...\n", size);
@@ -467,8 +486,7 @@ static void __unflatten_device_tree(const void *blob,
 	pr_debug("  unflattening %p...\n", mem);
 
 	/* Second pass, do actual unflattening */
-	start = 0;
-	unflatten_dt_node(blob, mem, &start, NULL, mynodes, 0, false);
+	unflatten_dt_node(blob, mem, NULL, mynodes, false);
 	if (be32_to_cpup(mem + size) != 0xdeadbeef)
 		pr_warning("End of tree marker overwritten: %08x\n",
 			   be32_to_cpup(mem + size));
-- 
2.1.0
