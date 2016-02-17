Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D468A1A02BF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:56 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 13:45:56 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 40A952CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:53 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1H3jjlu1901036
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:53 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1H3jIVV018196
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:20 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v8 40/45] drivers/of: Split unflatten_dt_node()
Date: Wed, 17 Feb 2016 14:44:23 +1100
Message-Id: <1455680668-23298-41-git-send-email-gwshan@linux.vnet.ibm.com>
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

The function unflatten_dt_node() is called recursively to unflatten
device nodes and properties in the FDT blob. It looks complicated
and hard to be understood.

This splits the function into 3 functions: populate_properties(),
populate_node() and unflatten_dt_node(). populate_properties(),
which is called by populate_node(), creates properties for the
indicated device node. The later one creates the device nodes
from FDT blob. populate_node() gets the offset in FDT blob for
next device nodes and then calls populate_node(). No logical
changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/of/fdt.c | 249 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 147 insertions(+), 102 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 655f79d..3c69002 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -161,39 +161,127 @@ static void *unflatten_dt_alloc(void **mem, unsigned long size,
 	return res;
 }
 
-/**
- * unflatten_dt_node - Alloc and populate a device_node from the flat tree
- * @blob: The parent device tree blob
- * @mem: Memory chunk to use for allocating device nodes and properties
- * @poffset: pointer to node in flat tree
- * @dad: Parent struct device_node
- * @nodepp: The device_node tree created by the call
- * @fpsize: Size of the node path up at the current depth.
- * @dryrun: If true, do not allocate device nodes but still calculate needed
- * memory size
- */
-static void * unflatten_dt_node(const void *blob,
-				void *mem,
-				int *poffset,
-				struct device_node *dad,
-				struct device_node **nodepp,
-				unsigned long fpsize,
+static void populate_properties(const void *blob,
+				int offset,
+				void **mem,
+				struct device_node *np,
+				const char *nodename,
 				bool dryrun)
 {
-	const __be32 *p;
+	struct property *pp, **pprev = NULL;
+	int cur;
+	bool has_name = false;
+
+	pprev = &np->properties;
+	for (cur = fdt_first_property_offset(blob, offset);
+	     cur >= 0;
+	     cur = fdt_next_property_offset(blob, cur)) {
+		const __be32 *val;
+		const char *pname;
+		u32 sz;
+
+		val = fdt_getprop_by_offset(blob, cur, &pname, &sz);
+		if (!val) {
+			pr_warn("%s: Cannot locate property at 0x%x\n",
+				__func__, cur);
+			continue;
+		}
+
+		if (!pname) {
+			pr_warn("%s: Cannot find property name at 0x%x\n",
+				__func__, cur);
+			continue;
+		}
+
+		if (!strcmp(pname, "name"))
+			has_name = true;
+
+		pp = unflatten_dt_alloc(mem, sizeof(struct property),
+					__alignof__(struct property));
+		if (dryrun)
+			continue;
+
+		/* We accept flattened tree phandles either in
+		 * ePAPR-style "phandle" properties, or the
+		 * legacy "linux,phandle" properties.  If both
+		 * appear and have different values, things
+		 * will get weird. Don't do that.
+		 */
+		if (!strcmp(pname, "phandle") ||
+		    !strcmp(pname, "linux,phandle")) {
+			if (!np->phandle)
+				np->phandle = be32_to_cpup(val);
+		}
+
+		/* And we process the "ibm,phandle" property
+		 * used in pSeries dynamic device tree
+		 * stuff
+		 */
+		if (!strcmp(pname, "ibm,phandle"))
+			np->phandle = be32_to_cpup(val);
+
+		pp->name   = (char *)pname;
+		pp->length = sz;
+		pp->value  = (__be32 *)val;
+		*pprev     = pp;
+		pprev      = &pp->next;
+	}
+
+	/* With version 0x10 we may not have the name property,
+	 * recreate it here from the unit name if absent
+	 */
+	if (!has_name) {
+		const char *p = nodename, *ps = p, *pa = NULL;
+		int len;
+
+		while (*p) {
+			if ((*p) == '@')
+				pa = p;
+			else if ((*p) == '/')
+				ps = p + 1;
+			p++;
+		}
+
+		if (pa < ps)
+			pa = p;
+		len = (pa - ps) + 1;
+		pp = unflatten_dt_alloc(mem, sizeof(struct property) + len,
+					__alignof__(struct property));
+		if (!dryrun) {
+			pp->name   = "name";
+			pp->length = len;
+			pp->value  = pp + 1;
+			*pprev     = pp;
+			pprev      = &pp->next;
+			memcpy(pp->value, ps, len - 1);
+			((char *)pp->value)[len - 1] = 0;
+			pr_debug("fixed up name for %s -> %s\n",
+				 nodename, (char *)pp->value);
+		}
+	}
+
+	if (!dryrun)
+		*pprev = NULL;
+}
+
+static unsigned long populate_node(const void *blob,
+				   int offset,
+				   void **mem,
+				   struct device_node *dad,
+				   unsigned long fpsize,
+				   struct device_node **pnp,
+				   bool dryrun)
+{
 	struct device_node *np;
-	struct property *pp, **prev_pp = NULL;
 	const char *pathp;
 	unsigned int l, allocl;
-	static int depth;
-	int old_depth;
-	int offset;
-	int has_name = 0;
 	int new_format = 0;
 
-	pathp = fdt_get_name(blob, *poffset, &l);
-	if (!pathp)
-		return mem;
+	pathp = fdt_get_name(blob, offset, &l);
+	if (!pathp) {
+		*pnp = NULL;
+		return 0;
+	}
 
 	allocl = ++l;
 
@@ -223,7 +311,7 @@ static void * unflatten_dt_node(const void *blob,
 		}
 	}
 
-	np = unflatten_dt_alloc(&mem, sizeof(struct device_node) + allocl,
+	np = unflatten_dt_alloc(mem, sizeof(struct device_node) + allocl,
 				__alignof__(struct device_node));
 	if (!dryrun) {
 		char *fn;
@@ -246,89 +334,15 @@ static void * unflatten_dt_node(const void *blob,
 		}
 		memcpy(fn, pathp, l);
 
-		prev_pp = &np->properties;
 		if (dad != NULL) {
 			np->parent = dad;
 			np->sibling = dad->child;
 			dad->child = np;
 		}
 	}
-	/* process properties */
-	for (offset = fdt_first_property_offset(blob, *poffset);
-	     (offset >= 0);
-	     (offset = fdt_next_property_offset(blob, offset))) {
-		const char *pname;
-		u32 sz;
 
-		if (!(p = fdt_getprop_by_offset(blob, offset, &pname, &sz))) {
-			offset = -FDT_ERR_INTERNAL;
-			break;
-		}
-
-		if (pname == NULL) {
-			pr_info("Can't find property name in list !\n");
-			break;
-		}
-		if (strcmp(pname, "name") == 0)
-			has_name = 1;
-		pp = unflatten_dt_alloc(&mem, sizeof(struct property),
-					__alignof__(struct property));
-		if (!dryrun) {
-			/* We accept flattened tree phandles either in
-			 * ePAPR-style "phandle" properties, or the
-			 * legacy "linux,phandle" properties.  If both
-			 * appear and have different values, things
-			 * will get weird.  Don't do that. */
-			if ((strcmp(pname, "phandle") == 0) ||
-			    (strcmp(pname, "linux,phandle") == 0)) {
-				if (np->phandle == 0)
-					np->phandle = be32_to_cpup(p);
-			}
-			/* And we process the "ibm,phandle" property
-			 * used in pSeries dynamic device tree
-			 * stuff */
-			if (strcmp(pname, "ibm,phandle") == 0)
-				np->phandle = be32_to_cpup(p);
-			pp->name = (char *)pname;
-			pp->length = sz;
-			pp->value = (__be32 *)p;
-			*prev_pp = pp;
-			prev_pp = &pp->next;
-		}
-	}
-	/* with version 0x10 we may not have the name property, recreate
-	 * it here from the unit name if absent
-	 */
-	if (!has_name) {
-		const char *p1 = pathp, *ps = pathp, *pa = NULL;
-		int sz;
-
-		while (*p1) {
-			if ((*p1) == '@')
-				pa = p1;
-			if ((*p1) == '/')
-				ps = p1 + 1;
-			p1++;
-		}
-		if (pa < ps)
-			pa = p1;
-		sz = (pa - ps) + 1;
-		pp = unflatten_dt_alloc(&mem, sizeof(struct property) + sz,
-					__alignof__(struct property));
-		if (!dryrun) {
-			pp->name = "name";
-			pp->length = sz;
-			pp->value = pp + 1;
-			*prev_pp = pp;
-			prev_pp = &pp->next;
-			memcpy(pp->value, ps, sz - 1);
-			((char *)pp->value)[sz - 1] = 0;
-			pr_debug("fixed up name for %s -> %s\n", pathp,
-				(char *)pp->value);
-		}
-	}
+	populate_properties(blob, offset, mem, np, pathp, dryrun);
 	if (!dryrun) {
-		*prev_pp = NULL;
 		np->name = of_get_property(np, "name", NULL);
 		np->type = of_get_property(np, "device_type", NULL);
 
@@ -338,6 +352,37 @@ static void * unflatten_dt_node(const void *blob,
 			np->type = "<NULL>";
 	}
 
+	*pnp = np;
+	return fpsize;
+}
+
+/**
+ * unflatten_dt_node - Alloc and populate a device_node from the flat tree
+ * @blob: The parent device tree blob
+ * @mem: Memory chunk to use for allocating device nodes and properties
+ * @poffset: pointer to node in flat tree
+ * @dad: Parent struct device_node
+ * @nodepp: The device_node tree created by the call
+ * @fpsize: Size of the node path up at the current depth.
+ * @dryrun: If true, do not allocate device nodes but still calculate needed
+ * memory size
+ */
+static void *unflatten_dt_node(const void *blob,
+			       void *mem,
+			       int *poffset,
+			       struct device_node *dad,
+			       struct device_node **nodepp,
+			       unsigned long fpsize,
+			       bool dryrun)
+{
+	struct device_node *np;
+	static int depth;
+	int old_depth;
+
+	fpsize = populate_node(blob, *poffset, &mem, dad, fpsize, &np, dryrun);
+	if (!fpsize)
+		return mem;
+
 	old_depth = depth;
 	*poffset = fdt_next_node(blob, *poffset, &depth);
 	if (depth < 0)
-- 
2.1.0
