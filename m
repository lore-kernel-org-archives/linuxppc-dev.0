Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FBD41A0352
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:56 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 13:45:56 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5C4092CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:53 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1H3jjLD61341724
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:53 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1H3jIoi018199
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:20 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v8 41/45] drivers/of: Avoid recursively calling
 unflatten_dt_node()
Date: Wed, 17 Feb 2016 14:44:24 +1100
Message-Id: <1455680668-23298-42-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
capacity, especially to adopt the function to unflatten device sub-tree
that possibly has multiple root nodes. In that case, we runs out of
stack and the system can't boot up successfully.

In order to reuse the function to unflatten device sub-tree, this avoids
calling the function recursively, meaning the device nodes are unflattened
in one call on unflatten_dt_node(): two arrays are introduced to track the
parent path size and the device node of current level of depth, which will
be used by the device node on next level of depth to be unflattened. All
device nodes in more than 64 level of depth are dropped and hopefully,
the system can boot up successfully with the partial device-tree.

Also, the parameter "poffset" and "fpsize" are unused and dropped and the
parameter "dryrun" is figured out from "mem == NULL". Besides, the return
value of the function is changed to indicate the size of memory consumed by
the unflatten device tree or error code.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/of/fdt.c | 122 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 74 insertions(+), 48 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 3c69002..667a5b2 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -356,63 +356,90 @@ static unsigned long populate_node(const void *blob,
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
- * @dryrun: If true, do not allocate device nodes but still calculate needed
- * memory size
+ *
+ * It returns the size of unflattened device tree or error code
  */
-static void *unflatten_dt_node(const void *blob,
-			       void *mem,
-			       int *poffset,
-			       struct device_node *dad,
-			       struct device_node **nodepp,
-			       unsigned long fpsize,
-			       bool dryrun)
+static int unflatten_dt_node(const void *blob,
+			     void *mem,
+			     struct device_node *dad,
+			     struct device_node **nodepp)
 {
-	struct device_node *np;
-	static int depth;
-	int old_depth;
+	struct device_node *root;
+	int offset = 0, depth = 0;
+#define FDT_MAX_DEPTH	64
+	unsigned long fpsizes[FDT_MAX_DEPTH];
+	struct device_node *nps[FDT_MAX_DEPTH];
+	void *base = mem;
+	bool dryrun = !base;
 
-	fpsize = populate_node(blob, *poffset, &mem, dad, fpsize, &np, dryrun);
-	if (!fpsize)
-		return mem;
+	if (nodepp)
+		*nodepp = NULL;
+
+	root = dad;
+	fpsizes[depth] = dad ? strlen(of_node_full_name(dad)) : 0;
+	nps[depth++] = dad;
+	for (offset = 0;
+	     offset >= 0;
+	     offset = fdt_next_node(blob, offset, &depth)) {
+		if (WARN_ON_ONCE(depth >= FDT_MAX_DEPTH))
+			continue;
 
-	old_depth = depth;
-	*poffset = fdt_next_node(blob, *poffset, &depth);
-	if (depth < 0)
-		depth = 0;
-	while (*poffset > 0 && depth > old_depth)
-		mem = unflatten_dt_node(blob, mem, poffset, np, NULL,
-					fpsize, dryrun);
+		fpsizes[depth] = populate_node(blob, offset, &mem,
+					       nps[depth - 1],
+					       fpsizes[depth - 1],
+					       &nps[depth], dryrun);
+		if (!fpsizes[depth])
+			return mem - base;
+
+		if (!dryrun && nodepp && !*nodepp)
+			*nodepp = nps[depth];
+		if (!dryrun && !root)
+			root = nps[depth];
+	}
 
-	if (*poffset < 0 && *poffset != -FDT_ERR_NOTFOUND)
-		pr_err("unflatten: error %d processing FDT\n", *poffset);
+	if (offset < 0 && offset != -FDT_ERR_NOTFOUND) {
+		pr_err("%s: Error %d processing FDT\n", __func__, offset);
+		return -EINVAL;
+	}
 
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
 
-	return mem;
+	return mem - base;
 }
 
 /**
@@ -431,8 +458,7 @@ static void __unflatten_device_tree(const void *blob,
 			     struct device_node **mynodes,
 			     void * (*dt_alloc)(u64 size, u64 align))
 {
-	unsigned long size;
-	int start;
+	int size;
 	void *mem;
 
 	pr_debug(" -> unflatten_device_tree()\n");
@@ -453,11 +479,12 @@ static void __unflatten_device_tree(const void *blob,
 	}
 
 	/* First pass, scan for size */
-	start = 0;
-	size = (unsigned long)unflatten_dt_node(blob, NULL, &start, NULL, NULL, 0, true);
-	size = ALIGN(size, 4);
+	size = unflatten_dt_node(blob, NULL, NULL, NULL);
+	if (size < 0)
+		return;
 
-	pr_debug("  size is %lx, allocating...\n", size);
+	size = ALIGN(size, 4);
+	pr_debug("  size is %d, allocating...\n", size);
 
 	/* Allocate memory for the expanded device tree */
 	mem = dt_alloc(size + 4, __alignof__(struct device_node));
@@ -468,8 +495,7 @@ static void __unflatten_device_tree(const void *blob,
 	pr_debug("  unflattening %p...\n", mem);
 
 	/* Second pass, do actual unflattening */
-	start = 0;
-	unflatten_dt_node(blob, mem, &start, NULL, mynodes, 0, false);
+	unflatten_dt_node(blob, mem, NULL, mynodes);
 	if (be32_to_cpup(mem + size) != 0xdeadbeef)
 		pr_warning("End of tree marker overwritten: %08x\n",
 			   be32_to_cpup(mem + size));
-- 
2.1.0
