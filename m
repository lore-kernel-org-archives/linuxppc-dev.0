Return-Path: <frowand.list@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wshgS6bH7zDqhp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 08:03:32 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id s66so26120880pfs.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 15:03:32 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 1/4] of: remove *phandle properties from expanded device
 tree
Date: Tue, 20 Jun 2017 15:02:49 -0700
Message-Id: <1497996172-821-2-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1497996172-821-1-git-send-email-frowand.list@gmail.com>
References: <1497996172-821-1-git-send-email-frowand.list@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Frank Rowand <frank.rowand@sony.com>

Remove "phandle", "linux,phandle", and "ibm,phandle" properties from
the internal device tree.  The phandle will still be in the struct
device_node phandle field and will still be displayed as if it is
a property in /proc/device_tree.

This is to resolve the issue found by Stephen Boyd [1] when he changed
the type of struct property.value from void * to const void *.  As
a result of the type change, the overlay code had compile errors
where the resolver updates phandle values.

  [1] http://lkml.iu.edu/hypermail/linux/kernel/1702.1/04160.html

- Add sysfs infrastructure to report np->phandle, as if it was a property.
- Do not create "phandle" "ibm,phandle", and "linux,phandle" properties
  in the expanded device tree.
- Remove phandle properties in of_attach_node(), for nodes dynamically
  attached to the live tree.  Add the phandle sysfs entry for these nodes.
- When creating an overlay changeset, duplicate the node phandle in
  __of_node_dup().
- Remove no longer needed checks to exclude "phandle" and "linux,phandle"
  properties in several locations.
- A side effect of these changes is that the obsolete "linux,phandle" and
  "ibm,phandle" properties will no longer appear in /proc/device-tree (they
  will appear as "phandle").
- A side effect is that the value of property "ibm,phandle" will no longer
  override the value of properties "phandle" and "linux,phandle".

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/base.c       | 48 +++++++++++++++++++++++++++++++++++++++---
 drivers/of/dynamic.c    | 55 +++++++++++++++++++++++++++++++++++++------------
 drivers/of/fdt.c        | 43 +++++++++++++++++++-------------------
 drivers/of/of_private.h |  1 +
 drivers/of/overlay.c    |  4 +---
 drivers/of/resolver.c   | 23 +--------------------
 include/linux/of.h      |  1 +
 7 files changed, 112 insertions(+), 63 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 28d5f53bc631..941c9a03471d 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -116,6 +116,19 @@ static ssize_t of_node_property_read(struct file *filp, struct kobject *kobj,
 	return memory_read_from_buffer(buf, count, &offset, pp->value, pp->length);
 }
 
+static ssize_t of_node_phandle_read(struct file *filp, struct kobject *kobj,
+				struct bin_attribute *bin_attr, char *buf,
+				loff_t offset, size_t count)
+{
+	phandle phandle;
+	struct device_node *np;
+
+	np = container_of(bin_attr, struct device_node, attr_phandle);
+	phandle = cpu_to_be32(np->phandle);
+	return memory_read_from_buffer(buf, count, &offset, &phandle,
+				       sizeof(phandle));
+}
+
 /* always return newly allocated name, caller must free after use */
 static const char *safe_name(struct kobject *kobj, const char *orig_name)
 {
@@ -164,6 +177,35 @@ int __of_add_property_sysfs(struct device_node *np, struct property *pp)
 	return rc;
 }
 
+/*
+ * In the imported device tree (fdt), phandle is a property.  In the
+ * internal data structure it is instead stored in the struct device_node.
+ * Make phandle visible in sysfs as if it was a property.
+ */
+int __of_add_phandle_sysfs(struct device_node *np)
+{
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_SYSFS))
+		return 0;
+
+	if (!of_kset || !of_node_is_attached(np))
+		return 0;
+
+	if (!np->phandle || np->phandle == 0xffffffff)
+		return 0;
+
+	sysfs_bin_attr_init(&np->attr_phandle);
+	np->attr_phandle.attr.name = "phandle";
+	np->attr_phandle.attr.mode = 0444;
+	np->attr_phandle.size = sizeof(np->phandle);
+	np->attr_phandle.read = of_node_phandle_read;
+
+	rc = sysfs_create_bin_file(&np->kobj, &np->attr_phandle);
+	WARN(rc, "error adding attribute phandle to node %s\n", np->full_name);
+	return rc;
+}
+
 int __of_attach_node_sysfs(struct device_node *np)
 {
 	const char *name;
@@ -193,6 +235,8 @@ int __of_attach_node_sysfs(struct device_node *np)
 	if (rc)
 		return rc;
 
+	__of_add_phandle_sysfs(np);
+
 	for_each_property_of_node(np, pp)
 		__of_add_property_sysfs(np, pp);
 
@@ -2128,9 +2172,7 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 		int id, len;
 
 		/* Skip those we do not want to proceed */
-		if (!strcmp(pp->name, "name") ||
-		    !strcmp(pp->name, "phandle") ||
-		    !strcmp(pp->name, "linux,phandle"))
+		if (!strcmp(pp->name, "name"))
 			continue;
 
 		np = of_find_node_by_path(pp->value);
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 888fdbc09992..be320082178f 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -218,19 +218,6 @@ int of_property_notify(int action, struct device_node *np,
 
 void __of_attach_node(struct device_node *np)
 {
-	const __be32 *phandle;
-	int sz;
-
-	np->name = __of_get_property(np, "name", NULL) ? : "<NULL>";
-	np->type = __of_get_property(np, "device_type", NULL) ? : "<NULL>";
-
-	phandle = __of_get_property(np, "phandle", &sz);
-	if (!phandle)
-		phandle = __of_get_property(np, "linux,phandle", &sz);
-	if (IS_ENABLED(CONFIG_PPC_PSERIES) && !phandle)
-		phandle = __of_get_property(np, "ibm,phandle", &sz);
-	np->phandle = (phandle && (sz >= 4)) ? be32_to_cpup(phandle) : 0;
-
 	np->child = NULL;
 	np->sibling = np->parent->child;
 	np->parent->child = np;
@@ -243,11 +230,48 @@ void __of_attach_node(struct device_node *np)
 int of_attach_node(struct device_node *np)
 {
 	struct of_reconfig_data rd;
+	struct property *prev;
+	struct property *prop;
+	struct property *save_next;
 	unsigned long flags;
+	const __be32 *phandle;
+	int sz;
 
 	memset(&rd, 0, sizeof(rd));
 	rd.dn = np;
 
+	/* use "<NULL>" to be consistent with populate_node() */
+	np->name = __of_get_property(np, "name", NULL) ? : "<NULL>";
+	np->type = __of_get_property(np, "device_type", NULL) ? : "<NULL>";
+
+	phandle = __of_get_property(np, "phandle", &sz);
+	if (!phandle)
+		phandle = __of_get_property(np, "linux,phandle", &sz);
+	if (IS_ENABLED(CONFIG_PPC_PSERIES) && !phandle)
+		phandle = __of_get_property(np, "ibm,phandle", &sz);
+	np->phandle = (phandle && (sz >= 4)) ? be32_to_cpup(phandle) : 0;
+
+	/* remove phandle properties from node */
+	prev = NULL;
+	for (prop = np->properties; prop != NULL; ) {
+		save_next = prop->next;
+		if (!strcmp(prop->name, "phandle") ||
+		    !strcmp(prop->name, "ibm,phandle") ||
+		    !strcmp(prop->name, "linux,phandle")) {
+			if (prev)
+				prev->next = prop->next;
+			else
+				np->properties = prop->next;
+			prop->next = np->deadprops;
+			np->deadprops = prop;
+		} else {
+			prev = prop;
+		}
+		prop = save_next;
+	}
+
+	__of_add_phandle_sysfs(np);
+
 	mutex_lock(&of_mutex);
 	raw_spin_lock_irqsave(&devtree_lock, flags);
 	__of_attach_node(np);
@@ -429,6 +453,7 @@ struct device_node *__of_node_dup(const struct device_node *np, const char *fmt,
 	/* Iterate over and duplicate all properties */
 	if (np) {
 		struct property *pp, *new_pp;
+		node->phandle = np->phandle;
 		for_each_property_of_node(np, pp) {
 			new_pp = __of_prop_dup(pp, GFP_KERNEL);
 			if (!new_pp)
@@ -441,6 +466,10 @@ struct device_node *__of_node_dup(const struct device_node *np, const char *fmt,
 			}
 		}
 	}
+
+	node->name = __of_get_property(node, "name", NULL) ? : "<NULL>";
+	node->type = __of_get_property(node, "device_type", NULL) ? : "<NULL>";
+
 	return node;
 
  err_prop:
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 3080d9dd031d..f4c75a781c80 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -183,6 +183,7 @@ static void populate_properties(const void *blob,
 		const __be32 *val;
 		const char *pname;
 		u32 sz;
+		bool prop_is_phandle = false;
 
 		val = fdt_getprop_by_offset(blob, cur, &pname, &sz);
 		if (!val) {
@@ -198,35 +199,33 @@ static void populate_properties(const void *blob,
 		if (!strcmp(pname, "name"))
 			has_name = true;
 
-		pp = unflatten_dt_alloc(mem, sizeof(struct property),
-					__alignof__(struct property));
+		if (strcmp(pname, "phandle") &&
+		    strcmp(pname, "linux,phandle") &&
+		    strcmp(pname, "ibm,phandle"))
+			pp = unflatten_dt_alloc(mem, sizeof(struct property),
+						__alignof__(struct property));
+		else
+			prop_is_phandle = true;
+
 		if (dryrun)
 			continue;
 
-		/* We accept flattened tree phandles either in
-		 * ePAPR-style "phandle" properties, or the
-		 * legacy "linux,phandle" properties.  If both
-		 * appear and have different values, things
-		 * will get weird. Don't do that.
+		/* We accept flattened tree phandles in ePAPR-style "phandle"
+		 * property, the legacy "linux,phandle" property, or the
+		 * "ibm,phandle" property used in pSeries dynamic device tree.
+		 * If more than one of them appear and have different values,
+		 * things will get weird. Don't do that.
 		 */
-		if (!strcmp(pname, "phandle") ||
-		    !strcmp(pname, "linux,phandle")) {
+		if (prop_is_phandle) {
 			if (!np->phandle)
 				np->phandle = be32_to_cpup(val);
+		} else {
+			pp->name   = (char *)pname;
+			pp->length = sz;
+			pp->value  = (__be32 *)val;
+			*pprev     = pp;
+			pprev      = &pp->next;
 		}
-
-		/* And we process the "ibm,phandle" property
-		 * used in pSeries dynamic device tree
-		 * stuff
-		 */
-		if (!strcmp(pname, "ibm,phandle"))
-			np->phandle = be32_to_cpup(val);
-
-		pp->name   = (char *)pname;
-		pp->length = sz;
-		pp->value  = (__be32 *)val;
-		*pprev     = pp;
-		pprev      = &pp->next;
 	}
 
 	/* With version 0x10 we may not have the name property,
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 4ebb0149d118..1a041411b219 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -47,6 +47,7 @@ extern int of_property_notify(int action, struct device_node *np,
 extern void of_node_release(struct kobject *kobj);
 extern int __of_changeset_apply(struct of_changeset *ocs);
 extern int __of_changeset_revert(struct of_changeset *ocs);
+extern int __of_add_phandle_sysfs(struct device_node *np);
 #else /* CONFIG_OF_DYNAMIC */
 static inline int of_property_notify(int action, struct device_node *np,
 				     struct property *prop, struct property *old_prop)
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 7827786718d8..ca0b85f5deb1 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -101,9 +101,7 @@ static int of_overlay_apply_single_property(struct of_overlay *ov,
 	tprop = of_find_property(target, prop->name, NULL);
 
 	/* special properties are not meant to be updated (silent NOP) */
-	if (of_prop_cmp(prop->name, "name") == 0 ||
-	    of_prop_cmp(prop->name, "phandle") == 0 ||
-	    of_prop_cmp(prop->name, "linux,phandle") == 0)
+	if (!of_prop_cmp(prop->name, "name"))
 		return 0;
 
 	propn = __of_prop_dup(prop, GFP_KERNEL);
diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index 771f4844c781..624cbaeae0a4 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -71,30 +71,11 @@ static void adjust_overlay_phandles(struct device_node *overlay,
 		int phandle_delta)
 {
 	struct device_node *child;
-	struct property *prop;
-	phandle phandle;
 
 	/* adjust node's phandle in node */
 	if (overlay->phandle != 0 && overlay->phandle != OF_PHANDLE_ILLEGAL)
 		overlay->phandle += phandle_delta;
 
-	/* copy adjusted phandle into *phandle properties */
-	for_each_property_of_node(overlay, prop) {
-
-		if (of_prop_cmp(prop->name, "phandle") &&
-		    of_prop_cmp(prop->name, "linux,phandle"))
-			continue;
-
-		if (prop->length < 4)
-			continue;
-
-		phandle = be32_to_cpup(prop->value);
-		if (phandle == OF_PHANDLE_ILLEGAL)
-			continue;
-
-		*(__be32 *)prop->value = cpu_to_be32(overlay->phandle);
-	}
-
 	for_each_child_of_node(overlay, child)
 		adjust_overlay_phandles(child, phandle_delta);
 }
@@ -197,9 +178,7 @@ static int adjust_local_phandle_references(struct device_node *local_fixups,
 	for_each_property_of_node(local_fixups, prop_fix) {
 
 		/* skip properties added automatically */
-		if (!of_prop_cmp(prop_fix->name, "name") ||
-		    !of_prop_cmp(prop_fix->name, "phandle") ||
-		    !of_prop_cmp(prop_fix->name, "linux,phandle"))
+		if (!of_prop_cmp(prop_fix->name, "name"))
 			continue;
 
 		if ((prop_fix->length % 4) != 0 || prop_fix->length == 0)
diff --git a/include/linux/of.h b/include/linux/of.h
index 50fcdb54087f..4e483782d124 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -61,6 +61,7 @@ struct device_node {
 	struct	kobject kobj;
 	unsigned long _flags;
 	void	*data;
+	struct bin_attribute attr_phandle;
 #if defined(CONFIG_SPARC)
 	const char *path_component_name;
 	unsigned int unique_id;
-- 
Frank Rowand <frank.rowand@sony.com>
