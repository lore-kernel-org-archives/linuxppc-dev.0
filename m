Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 18FDE1A104E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 16:05:00 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 1 May 2015 16:04:59 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9AA9D2CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 16:04:56 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4164mTv49217742
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 16:04:56 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4164MLU006598
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 16:04:23 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 19/21] drivers/of: Support adding sub-tree
Date: Fri,  1 May 2015 16:03:06 +1000
Message-Id: <1430460188-31343-20-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 bhelgaas@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The requirement is raised when developing the PCI hotplug feature
for PowerPC PowerNV platform, which runs on top of skiboot firmware.
When plugging PCI adapter to one PCI slot, the firmware rescans the
slot and build FDT (Flat Device Tree) blob, which is sent to the
PowerNV PCI hotplug driver for processing. The new constructed device
nodes from the FDT blob are expected to be attached to the device
node of the PCI slot. Unfortunately, it seems we don't have a API
to support the scenario. The patch intends to support it by newly
introduced function of_fdt_add_subtree(), the design behind it is
shown as below:

   * When the sub-tree FDT blob, which is owned by firmware, is
     received by kernel. It's copied over to the blob, which is
     dynamically allocated. Since then, the FDT blob owned by
     firmware isn't touched.
   * Rework unflatten_dt_node() so that the device nodes in current
     and deeper depth have been constructed from the FDT blob. All
     device nodes are marked with flag OF_DYNAMIC_HYBIRD, which is
     similar to OF_DYNAMIC. However, device node with the flag set
     can be free'd, but in the way other than that for OF_DYNAMIC
     device nodes.
   * of_fdt_add_subtree() is the introduced API to do the work.

Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/of/dynamic.c   |  19 +++++--
 drivers/of/fdt.c       | 133 ++++++++++++++++++++++++++++++++++++++++---------
 include/linux/of.h     |   2 +
 include/linux/of_fdt.h |   1 +
 4 files changed, 127 insertions(+), 28 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 3351ef4..f562080 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -330,13 +330,22 @@ void of_node_release(struct kobject *kobj)
 		return;
 	}
 
-	if (!of_node_check_flag(node, OF_DYNAMIC))
+	/* Release the subtree */
+	if (node->subtree) {
+		kfree(node->subtree);
+		node->subtree = NULL;
+	}
+
+	if (!of_node_check_flag(node, OF_DYNAMIC) &&
+	    !of_node_check_flag(node, OF_DYNAMIC_HYBIRD))
 		return;
 
 	while (prop) {
 		struct property *next = prop->next;
-		kfree(prop->name);
-		kfree(prop->value);
+		if (of_node_check_flag(node, OF_DYNAMIC)) {
+			kfree(prop->name);
+			kfree(prop->value);
+		}
 		kfree(prop);
 		prop = next;
 
@@ -345,7 +354,9 @@ void of_node_release(struct kobject *kobj)
 			node->deadprops = NULL;
 		}
 	}
-	kfree(node->full_name);
+
+	if (of_node_check_flag(node, OF_DYNAMIC))
+		kfree(node->full_name);
 	kfree(node->data);
 	kfree(node);
 }
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index cde35c5d01..7659560 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -28,6 +28,10 @@
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
 
+#include "of_private.h"
+
+static int cur_node_depth;
+
 /*
  * of_fdt_limit_memory - limit the number of regions in the /memory node
  * @limit: maximum entries
@@ -168,20 +172,20 @@ static void *unflatten_dt_alloc(void **mem, unsigned long size,
  * @dad: Parent struct device_node
  * @fpsize: Size of the node path up at the current depth.
  */
-static void * unflatten_dt_node(void *blob,
-				void *mem,
-				int *poffset,
-				struct device_node *dad,
-				struct device_node **nodepp,
-				unsigned long fpsize,
-				bool dryrun)
+static void *unflatten_dt_node(void *blob,
+			       void *mem,
+			       int *poffset,
+			       struct device_node *dad,
+			       struct device_node **nodepp,
+			       unsigned long fpsize,
+			       bool dryrun,
+			       bool dynamic)
 {
 	const __be32 *p;
 	struct device_node *np;
 	struct property *pp, **prev_pp = NULL;
 	const char *pathp;
 	unsigned int l, allocl;
-	static int depth = 0;
 	int old_depth;
 	int offset;
 	int has_name = 0;
@@ -219,12 +223,18 @@ static void * unflatten_dt_node(void *blob,
 		}
 	}
 
-	np = unflatten_dt_alloc(&mem, sizeof(struct device_node) + allocl,
+	if (dynamic)
+		np = kzalloc(sizeof(struct device_node) + allocl, GFP_KERNEL);
+	else
+		np = unflatten_dt_alloc(&mem,
+				sizeof(struct device_node) + allocl,
 				__alignof__(struct device_node));
 	if (!dryrun) {
 		char *fn;
 		of_node_init(np);
 		np->full_name = fn = ((char *)np) + sizeof(*np);
+		if (dynamic)
+			of_node_set_flag(np, OF_DYNAMIC_HYBIRD);
 		if (new_format) {
 			/* rebuild full path for new format */
 			if (dad && dad->parent) {
@@ -267,8 +277,12 @@ static void * unflatten_dt_node(void *blob,
 		}
 		if (strcmp(pname, "name") == 0)
 			has_name = 1;
-		pp = unflatten_dt_alloc(&mem, sizeof(struct property),
-					__alignof__(struct property));
+
+		if (dynamic)
+			pp = kzalloc(sizeof(struct property), GFP_KERNEL);
+		else
+			pp = unflatten_dt_alloc(&mem, sizeof(struct property),
+						__alignof__(struct property));
 		if (!dryrun) {
 			/* We accept flattened tree phandles either in
 			 * ePAPR-style "phandle" properties, or the
@@ -309,8 +323,13 @@ static void * unflatten_dt_node(void *blob,
 		if (pa < ps)
 			pa = p1;
 		sz = (pa - ps) + 1;
-		pp = unflatten_dt_alloc(&mem, sizeof(struct property) + sz,
-					__alignof__(struct property));
+
+		if (dynamic)
+			pp = kzalloc(sizeof(struct property) + sz, GFP_KERNEL);
+		else
+			pp = unflatten_dt_alloc(&mem,
+						sizeof(struct property) + sz,
+						__alignof__(struct property));
 		if (!dryrun) {
 			pp->name = "name";
 			pp->length = sz;
@@ -334,13 +353,21 @@ static void * unflatten_dt_node(void *blob,
 			np->type = "<NULL>";
 	}
 
-	old_depth = depth;
-	*poffset = fdt_next_node(blob, *poffset, &depth);
-	if (depth < 0)
-		depth = 0;
-	while (*poffset > 0 && depth > old_depth)
-		mem = unflatten_dt_node(blob, mem, poffset, np, NULL,
-					fpsize, dryrun);
+	old_depth = cur_node_depth;
+	*poffset = fdt_next_node(blob, *poffset, &cur_node_depth);
+	while (*poffset > 0) {
+		if (cur_node_depth < old_depth)
+			break;
+
+		if (cur_node_depth == old_depth)
+			mem = unflatten_dt_node(blob, mem, poffset,
+						dad, NULL, fpsize,
+						dryrun, dynamic);
+		else if (cur_node_depth > old_depth)
+			mem = unflatten_dt_node(blob, mem, poffset,
+						np, NULL, fpsize,
+						dryrun, dynamic);
+	}
 
 	if (*poffset < 0 && *poffset != -FDT_ERR_NOTFOUND)
 		pr_err("unflatten: error %d processing FDT\n", *poffset);
@@ -379,8 +406,8 @@ static void * unflatten_dt_node(void *blob,
  * for the resulting tree
  */
 static void __unflatten_device_tree(void *blob,
-			     struct device_node **mynodes,
-			     void * (*dt_alloc)(u64 size, u64 align))
+				struct device_node **mynodes,
+				void * (*dt_alloc)(u64 size, u64 align))
 {
 	unsigned long size;
 	int start;
@@ -405,7 +432,9 @@ static void __unflatten_device_tree(void *blob,
 
 	/* First pass, scan for size */
 	start = 0;
-	size = (unsigned long)unflatten_dt_node(blob, NULL, &start, NULL, NULL, 0, true);
+	cur_node_depth = 1;
+	size = (unsigned long)unflatten_dt_node(blob, NULL, &start, NULL,
+						NULL, 0, true, false);
 	size = ALIGN(size, 4);
 
 	pr_debug("  size is %lx, allocating...\n", size);
@@ -420,7 +449,8 @@ static void __unflatten_device_tree(void *blob,
 
 	/* Second pass, do actual unflattening */
 	start = 0;
-	unflatten_dt_node(blob, mem, &start, NULL, mynodes, 0, false);
+	cur_node_depth = 1;
+	unflatten_dt_node(blob, mem, &start, NULL, mynodes, 0, false, false);
 	if (be32_to_cpup(mem + size) != 0xdeadbeef)
 		pr_warning("End of tree marker overwritten: %08x\n",
 			   be32_to_cpup(mem + size));
@@ -448,6 +478,61 @@ void of_fdt_unflatten_tree(unsigned long *blob,
 }
 EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
 
+static void populate_sysfs_for_child_nodes(struct device_node *parent)
+{
+	struct device_node *child;
+
+	for_each_child_of_node(parent, child) {
+		__of_attach_node_sysfs(child);
+		populate_sysfs_for_child_nodes(child);
+	}
+}
+
+/**
+ * of_fdt_add_substree - Create sub-tree of device nodes
+ * @parent: parent device node to which the sub-tree will attach
+ * @blob: flat device tree blob representing the sub-tree
+ *
+ * Copy over the FDT blob, which passed from firmware, and then
+ * unflatten the sub-tree.
+ */
+void of_fdt_add_subtree(struct device_node *parent, void *blob)
+{
+	int start = 0;
+
+	/* Validate the header */
+	if (!blob || fdt_check_header(blob)) {
+		pr_err("%s: Invalid device-tree blob header at 0x%p\n",
+		       __func__, blob);
+		return;
+	}
+
+	/* Free the flat blob for last time lazily */
+	if (parent->subtree) {
+		kfree(parent->subtree);
+		parent->subtree = NULL;
+	}
+
+	/* Copy over the flat blob */
+	parent->subtree = kzalloc(fdt_totalsize(blob), GFP_KERNEL);
+	if (!parent->subtree) {
+		pr_err("%s: Cannot copy over device-tree blob\n",
+		       __func__);
+		return;
+	}
+
+	memcpy(parent->subtree, blob, fdt_totalsize(blob));
+
+	/* Unflatten it */
+	mutex_lock(&of_mutex);
+	cur_node_depth = 1;
+	unflatten_dt_node(parent->subtree, NULL, &start, parent, NULL,
+			  strlen(parent->full_name), false, true);
+	populate_sysfs_for_child_nodes(parent);
+	mutex_unlock(&of_mutex);
+}
+EXPORT_SYMBOL(of_fdt_add_subtree);
+
 /* Everything below here references initial_boot_params directly. */
 int __initdata dt_root_addr_cells;
 int __initdata dt_root_size_cells;
diff --git a/include/linux/of.h b/include/linux/of.h
index ddeaae6..ac50b02 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -60,6 +60,7 @@ struct device_node {
 	struct	device_node *sibling;
 	struct	kobject kobj;
 	unsigned long _flags;
+	void	*subtree;
 	void	*data;
 #if defined(CONFIG_SPARC)
 	const char *path_component_name;
@@ -222,6 +223,7 @@ static inline unsigned long of_read_ulong(const __be32 *cell, int size)
 #define OF_DETACHED	2 /* node has been detached from the device tree */
 #define OF_POPULATED	3 /* device already created for the node */
 #define OF_POPULATED_BUS	4 /* of_platform_populate recursed to children of this node */
+#define OF_DYNAMIC_HYBIRD	5 /* similar to OF_DYNAMIC, but partially */
 
 #define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
 #define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 587ee50..1fb47d7 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -39,6 +39,7 @@ extern int of_fdt_match(const void *blob, unsigned long node,
 			const char *const *compat);
 extern void of_fdt_unflatten_tree(unsigned long *blob,
 			       struct device_node **mynodes);
+extern void of_fdt_add_subtree(struct device_node *parent, void *blob);
 
 /* TBD: Temporary export of fdt globals - remove when code fully merged */
 extern int __initdata dt_root_addr_cells;
-- 
2.1.0
