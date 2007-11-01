Return-Path: <dgibson@ozlabs.org>
Date: Thu, 1 Nov 2007 16:49:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Move tree checking code to checks.c
Message-ID: <20071101054926.GC18744@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch moves the dtc code for checking the device tree its
processing into a new checks.c.  The tree accessor functions from
livetree.c which the checks use are exported and added to dtc.h.

Another small step towards a flexible checking architecture.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/checks.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/checks.c	2007-11-01 16:45:01.000000000 +1100
@@ -0,0 +1,460 @@
+/*
+ * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2007.
+ *
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
+ */
+
+#include "dtc.h"
+
+/*
+ * Structural check functions
+ */
+
+#define ERRMSG(...) if (quiet < 2) fprintf(stderr, "ERROR: " __VA_ARGS__)
+#define WARNMSG(...) if (quiet < 1) fprintf(stderr, "Warning: " __VA_ARGS__)
+
+#define DO_ERR(...) do {ERRMSG(__VA_ARGS__); ok = 0; } while (0)
+
+static int check_names(struct node *tree)
+{
+	struct node *child, *child2;
+	struct property *prop, *prop2;
+	int len = strlen(tree->name);
+	int ok = 1;
+
+	if (len == 0 && tree->parent)
+		DO_ERR("Empty, non-root nodename at %s\n", tree->fullpath);
+
+	if (len > MAX_NODENAME_LEN)
+		WARNMSG("Overlength nodename at %s\n", tree->fullpath);
+
+	for_each_property(tree, prop) {
+		/* check for duplicates */
+		/* FIXME: do this more efficiently */
+		for (prop2 = prop->next; prop2; prop2 = prop2->next) {
+			if (streq(prop->name, prop2->name)) {
+				DO_ERR("Duplicate propertyname %s in node %s\n",
+					prop->name, tree->fullpath);
+			}
+		}
+
+		/* check name length */
+		if (strlen(prop->name) > MAX_PROPNAME_LEN)
+			WARNMSG("Property name %s is too long in %s\n",
+				prop->name, tree->fullpath);
+	}
+
+	for_each_child(tree, child) {
+		/* Check for duplicates */
+
+		for (child2 = child->next_sibling;
+		     child2;
+		     child2 = child2->next_sibling) {
+			if (streq(child->name, child2->name))
+				DO_ERR("Duplicate node name %s\n",
+					child->fullpath);
+		}
+		if (! check_names(child))
+			ok = 0;
+	}
+
+	return ok;
+}
+
+static int check_phandles(struct node *root, struct node *node)
+{
+	struct property *prop;
+	struct node *child, *other;
+	cell_t phandle;
+	int ok = 1;
+
+	prop = get_property(node, "linux,phandle");
+	if (prop) {
+		phandle = propval_cell(prop);
+		if ((phandle == 0) || (phandle == -1)) {
+			DO_ERR("%s has invalid linux,phandle %x\n",
+			       node->fullpath, phandle);
+		} else {
+			other = get_node_by_phandle(root, phandle);
+			if (other)
+				DO_ERR("%s has duplicated phandle %x (seen before at %s)\n",
+				       node->fullpath, phandle, other->fullpath);
+
+			node->phandle = phandle;
+		}
+	}
+
+	for_each_child(node, child)
+		ok = ok && check_phandles(root, child);
+
+	return 1;
+}
+
+int check_structure(struct node *dt)
+{
+	int ok = 1;
+
+	ok = ok && check_names(dt);
+	ok = ok && check_phandles(dt, dt);
+
+	return ok;
+}
+
+/*
+ * Semantic check functions
+ */
+
+static int must_be_one_cell(struct property *prop, struct node *node)
+{
+	if (prop->val.len != sizeof(cell_t)) {
+		ERRMSG("\"%s\" property in %s has the wrong length (should be 1 cell)\n",
+		       prop->name, node->fullpath);
+		return 0;
+	}
+
+	return 1;
+}
+
+static int must_be_cells(struct property *prop, struct node *node)
+{
+	if ((prop->val.len % sizeof(cell_t)) != 0) {
+		ERRMSG("\"%s\" property in %s is not a multiple of cell size\n",
+		       prop->name, node->fullpath);
+		return 0;
+	}
+
+	return 1;
+}
+
+static int must_be_string(struct property *prop, struct node *node)
+{
+	if (! data_is_one_string(prop->val)) {
+		ERRMSG("\"%s\" property in %s is not a string\n",
+		       prop->name, node->fullpath);
+		return 0;
+	}
+
+	return 1;
+}
+
+static int name_prop_check(struct property *prop, struct node *node)
+{
+	if ((prop->val.len != node->basenamelen+1)
+	    || !strneq(prop->val.val, node->name, node->basenamelen)) {
+		ERRMSG("name property \"%s\" does not match node basename in %s\n",
+		       prop->val.val,
+		       node->fullpath);
+		return 0;
+	}
+
+	return 1;
+}
+
+static struct {
+	char *propname;
+	int (*check_fn)(struct property *prop, struct node *node);
+} prop_checker_table[] = {
+	{"name", must_be_string},
+	{"name", name_prop_check},
+	{"linux,phandle", must_be_one_cell},
+	{"#address-cells", must_be_one_cell},
+	{"#size-cells", must_be_one_cell},
+	{"reg", must_be_cells},
+	{"model", must_be_string},
+	{"device_type", must_be_string},
+};
+
+static int check_properties(struct node *node)
+{
+	struct property *prop;
+	struct node *child;
+	int i;
+	int ok = 1;
+
+	for_each_property(node, prop)
+		for (i = 0; i < ARRAY_SIZE(prop_checker_table); i++)
+			if (streq(prop->name, prop_checker_table[i].propname))
+				if (! prop_checker_table[i].check_fn(prop, node)) {
+					ok = 0;
+					break;
+				}
+
+	for_each_child(node, child)
+		if (! check_properties(child))
+			ok = 0;
+
+	return ok;
+}
+
+#define CHECK_HAVE(node, propname) \
+	do { \
+		if (! (prop = get_property((node), (propname)))) \
+			DO_ERR("Missing \"%s\" property in %s\n", (propname), \
+				(node)->fullpath); \
+	} while (0);
+
+#define CHECK_HAVE_WARN(node, propname) \
+	do { \
+		if (! (prop  = get_property((node), (propname)))) \
+			WARNMSG("%s has no \"%s\" property\n", \
+				(node)->fullpath, (propname)); \
+	} while (0)
+
+#define CHECK_HAVE_STRING(node, propname) \
+	do { \
+		CHECK_HAVE((node), (propname)); \
+		if (prop && !data_is_one_string(prop->val)) \
+			DO_ERR("\"%s\" property in %s is not a string\n", \
+				(propname), (node)->fullpath); \
+	} while (0)
+
+#define CHECK_HAVE_STREQ(node, propname, value) \
+	do { \
+		CHECK_HAVE_STRING((node), (propname)); \
+		if (prop && !streq(prop->val.val, (value))) \
+			DO_ERR("%s has wrong %s, %s (should be %s\n", \
+				(node)->fullpath, (propname), \
+				prop->val.val, (value)); \
+	} while (0)
+
+#define CHECK_HAVE_ONECELL(node, propname) \
+	do { \
+		CHECK_HAVE((node), (propname)); \
+		if (prop && (prop->val.len != sizeof(cell_t))) \
+			DO_ERR("\"%s\" property in %s has wrong size %d (should be 1 cell)\n", (propname), (node)->fullpath, prop->val.len); \
+	} while (0)
+
+#define CHECK_HAVE_WARN_ONECELL(node, propname) \
+	do { \
+		CHECK_HAVE_WARN((node), (propname)); \
+		if (prop && (prop->val.len != sizeof(cell_t))) \
+			DO_ERR("\"%s\" property in %s has wrong size %d (should be 1 cell)\n", (propname), (node)->fullpath, prop->val.len); \
+	} while (0)
+
+#define CHECK_HAVE_WARN_PHANDLE(xnode, propname, root) \
+	do { \
+		struct node *ref; \
+		CHECK_HAVE_WARN_ONECELL((xnode), (propname)); \
+		if (prop) {\
+			cell_t phandle = propval_cell(prop); \
+			if ((phandle == 0) || (phandle == -1)) { \
+				DO_ERR("\"%s\" property in %s contains an invalid phandle %x\n", (propname), (xnode)->fullpath, phandle); \
+			} else { \
+				ref = get_node_by_phandle((root), propval_cell(prop)); \
+				if (! ref) \
+					DO_ERR("\"%s\" property in %s refers to non-existant phandle %x\n", (propname), (xnode)->fullpath, propval_cell(prop)); \
+			} \
+		} \
+	} while (0)
+
+#define CHECK_HAVE_WARN_STRING(node, propname) \
+	do { \
+		CHECK_HAVE_WARN((node), (propname)); \
+		if (prop && !data_is_one_string(prop->val)) \
+			DO_ERR("\"%s\" property in %s is not a string\n", \
+				(propname), (node)->fullpath); \
+	} while (0)
+
+static int check_root(struct node *root)
+{
+	struct property *prop;
+	int ok = 1;
+
+	CHECK_HAVE_STRING(root, "model");
+
+	CHECK_HAVE(root, "#address-cells");
+	CHECK_HAVE(root, "#size-cells");
+
+	CHECK_HAVE_WARN(root, "compatible");
+
+	return ok;
+}
+
+static int check_cpus(struct node *root, int outversion, int boot_cpuid_phys)
+{
+	struct node *cpus, *cpu;
+	struct property *prop;
+	struct node *bootcpu = NULL;
+	int ok = 1;
+
+	cpus = get_subnode(root, "cpus");
+	if (! cpus) {
+		ERRMSG("Missing /cpus node\n");
+		return 0;
+	}
+
+	CHECK_HAVE_WARN(cpus, "#address-cells");
+	CHECK_HAVE_WARN(cpus, "#size-cells");
+
+	for_each_child(cpus, cpu) {
+		CHECK_HAVE_STREQ(cpu, "device_type", "cpu");
+
+		if (cpu->addr_cells != 1)
+			DO_ERR("%s has bad #address-cells value %d (should be 1)\n",
+			       cpu->fullpath, cpu->addr_cells);
+		if (cpu->size_cells != 0)
+			DO_ERR("%s has bad #size-cells value %d (should be 0)\n",
+			       cpu->fullpath, cpu->size_cells);
+
+		CHECK_HAVE_ONECELL(cpu, "reg");
+		if (prop) {
+			cell_t unitnum;
+			char *eptr;
+
+			unitnum = strtol(get_unitname(cpu), &eptr, 16);
+			if (*eptr) {
+				WARNMSG("%s has bad format unit name %s (should be CPU number\n",
+					cpu->fullpath, get_unitname(cpu));
+			} else if (unitnum != propval_cell(prop)) {
+				WARNMSG("%s unit name \"%s\" does not match \"reg\" property <%x>\n",
+				       cpu->fullpath, get_unitname(cpu),
+				       propval_cell(prop));
+			}
+		}
+
+/* 		CHECK_HAVE_ONECELL(cpu, "d-cache-line-size"); */
+/* 		CHECK_HAVE_ONECELL(cpu, "i-cache-line-size"); */
+		CHECK_HAVE_ONECELL(cpu, "d-cache-size");
+		CHECK_HAVE_ONECELL(cpu, "i-cache-size");
+
+		CHECK_HAVE_WARN_ONECELL(cpu, "clock-frequency");
+		CHECK_HAVE_WARN_ONECELL(cpu, "timebase-frequency");
+
+		prop = get_property(cpu, "linux,boot-cpu");
+		if (prop) {
+			if (prop->val.len)
+				WARNMSG("\"linux,boot-cpu\" property in %s is non-empty\n",
+					cpu->fullpath);
+			if (bootcpu)
+				DO_ERR("Multiple boot cpus (%s and %s)\n",
+				       bootcpu->fullpath, cpu->fullpath);
+			else
+				bootcpu = cpu;
+		}
+	}
+
+	if (outversion < 2) {
+		if (! bootcpu)
+			WARNMSG("No cpu has \"linux,boot-cpu\" property\n");
+	} else {
+		if (bootcpu)
+			WARNMSG("\"linux,boot-cpu\" property is deprecated in blob version 2 or higher\n");
+		if (boot_cpuid_phys == 0xfeedbeef)
+			WARNMSG("physical boot CPU not set.  Use -b option to set\n");
+	}
+
+	return ok;
+}
+
+static int check_memory(struct node *root)
+{
+	struct node *mem;
+	struct property *prop;
+	int nnodes = 0;
+	int ok = 1;
+
+	for_each_child(root, mem) {
+		if (! strneq(mem->name, "memory", mem->basenamelen))
+			continue;
+
+		nnodes++;
+
+		CHECK_HAVE_STREQ(mem, "device_type", "memory");
+		CHECK_HAVE(mem, "reg");
+	}
+
+	if (nnodes == 0) {
+		ERRMSG("No memory nodes\n");
+		return 0;
+	}
+
+	return ok;
+}
+
+static int check_chosen(struct node *root)
+{
+	struct node *chosen;
+	struct property *prop;
+	int ok = 1;
+
+	chosen = get_subnode(root, "chosen");
+	if (!chosen)
+		return ok;
+
+        /* give warning for obsolete interrupt-controller property */
+	do {
+		if ((prop = get_property(chosen, "interrupt-controller")) != NULL) {
+			WARNMSG("%s has obsolete \"%s\" property\n",
+                                 chosen->fullpath, "interrupt-controller");
+                }
+	} while (0);
+
+	return ok;
+}
+
+static int check_addr_size_reg(struct node *node,
+			       int p_addr_cells, int p_size_cells)
+{
+	int addr_cells = p_addr_cells;
+	int size_cells = p_size_cells;
+	struct property *prop;
+	struct node *child;
+	int ok = 1;
+
+	node->addr_cells = addr_cells;
+	node->size_cells = size_cells;
+
+	prop = get_property(node, "reg");
+	if (prop) {
+		int len = prop->val.len / 4;
+
+		if ((len % (addr_cells+size_cells)) != 0)
+			DO_ERR("\"reg\" property in %s has invalid length (%d) for given #address-cells (%d) and #size-cells (%d)\n",
+			       node->fullpath, prop->val.len,
+			       addr_cells, size_cells);
+	}
+
+	prop = get_property(node, "#address-cells");
+	if (prop)
+		addr_cells = propval_cell(prop);
+
+	prop = get_property(node, "#size-cells");
+	if (prop)
+		size_cells = propval_cell(prop);
+
+	for_each_child(node, child) {
+		ok = ok && check_addr_size_reg(child, addr_cells, size_cells);
+	}
+
+	return ok;
+}
+
+int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys)
+{
+	int ok = 1;
+
+	ok = ok && check_properties(dt);
+	ok = ok && check_addr_size_reg(dt, -1, -1);
+	ok = ok && check_root(dt);
+	ok = ok && check_cpus(dt, outversion, boot_cpuid_phys);
+	ok = ok && check_memory(dt);
+	ok = ok && check_chosen(dt);
+	if (! ok)
+		return 0;
+
+	return 1;
+}
Index: dtc/livetree.c
===================================================================
--- dtc.orig/livetree.c	2007-11-01 14:53:17.000000000 +1100
+++ dtc/livetree.c	2007-11-01 14:56:55.000000000 +1100
@@ -180,7 +180,7 @@
  * Tree accessor functions
  */
 
-static char *get_unitname(struct node *node)
+char *get_unitname(struct node *node)
 {
 	if (node->name[node->basenamelen] == '\0')
 		return "";
@@ -188,7 +188,7 @@
 		return node->name + node->basenamelen + 1;
 }
 
-static struct property *get_property(struct node *node, char *propname)
+struct property *get_property(struct node *node, char *propname)
 {
 	struct property *prop;
 
@@ -199,13 +199,13 @@
 	return NULL;
 }
 
-static cell_t propval_cell(struct property *prop)
+cell_t propval_cell(struct property *prop)
 {
 	assert(prop->val.len == sizeof(cell_t));
 	return be32_to_cpu(*((cell_t *)prop->val.val));
 }
 
-static struct node *get_subnode(struct node *node, char *nodename)
+struct node *get_subnode(struct node *node, char *nodename)
 {
 	struct node *child;
 
@@ -257,7 +257,7 @@
 	return NULL;
 }
 
-static struct node *get_node_by_phandle(struct node *tree, cell_t phandle)
+struct node *get_node_by_phandle(struct node *tree, cell_t phandle)
 {
 	struct node *child, *node;
 
@@ -297,100 +297,6 @@
 }
 
 /*
- * Structural check functions
- */
-
-#define ERRMSG(...) if (quiet < 2) fprintf(stderr, "ERROR: " __VA_ARGS__)
-#define WARNMSG(...) if (quiet < 1) fprintf(stderr, "Warning: " __VA_ARGS__)
-
-#define DO_ERR(...) do {ERRMSG(__VA_ARGS__); ok = 0; } while (0)
-
-static int check_names(struct node *tree)
-{
-	struct node *child, *child2;
-	struct property *prop, *prop2;
-	int len = strlen(tree->name);
-	int ok = 1;
-
-	if (len == 0 && tree->parent)
-		DO_ERR("Empty, non-root nodename at %s\n", tree->fullpath);
-
-	if (len > MAX_NODENAME_LEN)
-		WARNMSG("Overlength nodename at %s\n", tree->fullpath);
-
-	for_each_property(tree, prop) {
-		/* check for duplicates */
-		/* FIXME: do this more efficiently */
-		for (prop2 = prop->next; prop2; prop2 = prop2->next) {
-			if (streq(prop->name, prop2->name)) {
-				DO_ERR("Duplicate propertyname %s in node %s\n",
-					prop->name, tree->fullpath);
-			}
-		}
-
-		/* check name length */
-		if (strlen(prop->name) > MAX_PROPNAME_LEN)
-			WARNMSG("Property name %s is too long in %s\n",
-				prop->name, tree->fullpath);
-	}
-
-	for_each_child(tree, child) {
-		/* Check for duplicates */
-
-		for (child2 = child->next_sibling;
-		     child2;
-		     child2 = child2->next_sibling) {
-			if (streq(child->name, child2->name))
-				DO_ERR("Duplicate node name %s\n",
-					child->fullpath);
-		}
-		if (! check_names(child))
-			ok = 0;
-	}
-
-	return ok;
-}
-
-static int check_phandles(struct node *root, struct node *node)
-{
-	struct property *prop;
-	struct node *child, *other;
-	cell_t phandle;
-	int ok = 1;
-
-	prop = get_property(node, "linux,phandle");
-	if (prop) {
-		phandle = propval_cell(prop);
-		if ((phandle == 0) || (phandle == -1)) {
-			DO_ERR("%s has invalid linux,phandle %x\n",
-			       node->fullpath, phandle);
-		} else {
-			other = get_node_by_phandle(root, phandle);
-			if (other)
-				DO_ERR("%s has duplicated phandle %x (seen before at %s)\n",
-				       node->fullpath, phandle, other->fullpath);
-
-			node->phandle = phandle;
-		}
-	}
-
-	for_each_child(node, child)
-		ok = ok && check_phandles(root, child);
-
-	return 1;
-}
-
-int check_structure(struct node *dt)
-{
-	int ok = 1;
-
-	ok = ok && check_names(dt);
-	ok = ok && check_phandles(dt, dt);
-
-	return ok;
-}
-
-/*
  * Reference fixup functions
  */
 
@@ -442,348 +348,3 @@
 {
 	fixup_phandles(dt, dt);
 }
-
-/*
- * Semantic check functions
- */
-
-static int must_be_one_cell(struct property *prop, struct node *node)
-{
-	if (prop->val.len != sizeof(cell_t)) {
-		ERRMSG("\"%s\" property in %s has the wrong length (should be 1 cell)\n",
-		       prop->name, node->fullpath);
-		return 0;
-	}
-
-	return 1;
-}
-
-static int must_be_cells(struct property *prop, struct node *node)
-{
-	if ((prop->val.len % sizeof(cell_t)) != 0) {
-		ERRMSG("\"%s\" property in %s is not a multiple of cell size\n",
-		       prop->name, node->fullpath);
-		return 0;
-	}
-
-	return 1;
-}
-
-static int must_be_string(struct property *prop, struct node *node)
-{
-	if (! data_is_one_string(prop->val)) {
-		ERRMSG("\"%s\" property in %s is not a string\n",
-		       prop->name, node->fullpath);
-		return 0;
-	}
-
-	return 1;
-}
-
-static int name_prop_check(struct property *prop, struct node *node)
-{
-	if ((prop->val.len != node->basenamelen+1)
-	    || !strneq(prop->val.val, node->name, node->basenamelen)) {
-		ERRMSG("name property \"%s\" does not match node basename in %s\n",
-		       prop->val.val,
-		       node->fullpath);
-		return 0;
-	}
-
-	return 1;
-}
-
-static struct {
-	char *propname;
-	int (*check_fn)(struct property *prop, struct node *node);
-} prop_checker_table[] = {
-	{"name", must_be_string},
-	{"name", name_prop_check},
-	{"linux,phandle", must_be_one_cell},
-	{"#address-cells", must_be_one_cell},
-	{"#size-cells", must_be_one_cell},
-	{"reg", must_be_cells},
-	{"model", must_be_string},
-	{"device_type", must_be_string},
-};
-
-static int check_properties(struct node *node)
-{
-	struct property *prop;
-	struct node *child;
-	int i;
-	int ok = 1;
-
-	for_each_property(node, prop)
-		for (i = 0; i < ARRAY_SIZE(prop_checker_table); i++)
-			if (streq(prop->name, prop_checker_table[i].propname))
-				if (! prop_checker_table[i].check_fn(prop, node)) {
-					ok = 0;
-					break;
-				}
-
-	for_each_child(node, child)
-		if (! check_properties(child))
-			ok = 0;
-
-	return ok;
-}
-
-#define CHECK_HAVE(node, propname) \
-	do { \
-		if (! (prop = get_property((node), (propname)))) \
-			DO_ERR("Missing \"%s\" property in %s\n", (propname), \
-				(node)->fullpath); \
-	} while (0);
-
-#define CHECK_HAVE_WARN(node, propname) \
-	do { \
-		if (! (prop  = get_property((node), (propname)))) \
-			WARNMSG("%s has no \"%s\" property\n", \
-				(node)->fullpath, (propname)); \
-	} while (0)
-
-#define CHECK_HAVE_STRING(node, propname) \
-	do { \
-		CHECK_HAVE((node), (propname)); \
-		if (prop && !data_is_one_string(prop->val)) \
-			DO_ERR("\"%s\" property in %s is not a string\n", \
-				(propname), (node)->fullpath); \
-	} while (0)
-
-#define CHECK_HAVE_STREQ(node, propname, value) \
-	do { \
-		CHECK_HAVE_STRING((node), (propname)); \
-		if (prop && !streq(prop->val.val, (value))) \
-			DO_ERR("%s has wrong %s, %s (should be %s\n", \
-				(node)->fullpath, (propname), \
-				prop->val.val, (value)); \
-	} while (0)
-
-#define CHECK_HAVE_ONECELL(node, propname) \
-	do { \
-		CHECK_HAVE((node), (propname)); \
-		if (prop && (prop->val.len != sizeof(cell_t))) \
-			DO_ERR("\"%s\" property in %s has wrong size %d (should be 1 cell)\n", (propname), (node)->fullpath, prop->val.len); \
-	} while (0)
-
-#define CHECK_HAVE_WARN_ONECELL(node, propname) \
-	do { \
-		CHECK_HAVE_WARN((node), (propname)); \
-		if (prop && (prop->val.len != sizeof(cell_t))) \
-			DO_ERR("\"%s\" property in %s has wrong size %d (should be 1 cell)\n", (propname), (node)->fullpath, prop->val.len); \
-	} while (0)
-
-#define CHECK_HAVE_WARN_PHANDLE(xnode, propname, root) \
-	do { \
-		struct node *ref; \
-		CHECK_HAVE_WARN_ONECELL((xnode), (propname)); \
-		if (prop) {\
-			cell_t phandle = propval_cell(prop); \
-			if ((phandle == 0) || (phandle == -1)) { \
-				DO_ERR("\"%s\" property in %s contains an invalid phandle %x\n", (propname), (xnode)->fullpath, phandle); \
-			} else { \
-				ref = get_node_by_phandle((root), propval_cell(prop)); \
-				if (! ref) \
-					DO_ERR("\"%s\" property in %s refers to non-existant phandle %x\n", (propname), (xnode)->fullpath, propval_cell(prop)); \
-			} \
-		} \
-	} while (0)
-
-#define CHECK_HAVE_WARN_STRING(node, propname) \
-	do { \
-		CHECK_HAVE_WARN((node), (propname)); \
-		if (prop && !data_is_one_string(prop->val)) \
-			DO_ERR("\"%s\" property in %s is not a string\n", \
-				(propname), (node)->fullpath); \
-	} while (0)
-
-static int check_root(struct node *root)
-{
-	struct property *prop;
-	int ok = 1;
-
-	CHECK_HAVE_STRING(root, "model");
-
-	CHECK_HAVE(root, "#address-cells");
-	CHECK_HAVE(root, "#size-cells");
-
-	CHECK_HAVE_WARN(root, "compatible");
-
-	return ok;
-}
-
-static int check_cpus(struct node *root, int outversion, int boot_cpuid_phys)
-{
-	struct node *cpus, *cpu;
-	struct property *prop;
-	struct node *bootcpu = NULL;
-	int ok = 1;
-
-	cpus = get_subnode(root, "cpus");
-	if (! cpus) {
-		ERRMSG("Missing /cpus node\n");
-		return 0;
-	}
-
-	CHECK_HAVE_WARN(cpus, "#address-cells");
-	CHECK_HAVE_WARN(cpus, "#size-cells");
-
-	for_each_child(cpus, cpu) {
-		CHECK_HAVE_STREQ(cpu, "device_type", "cpu");
-
-		if (cpu->addr_cells != 1)
-			DO_ERR("%s has bad #address-cells value %d (should be 1)\n",
-			       cpu->fullpath, cpu->addr_cells);
-		if (cpu->size_cells != 0)
-			DO_ERR("%s has bad #size-cells value %d (should be 0)\n",
-			       cpu->fullpath, cpu->size_cells);
-
-		CHECK_HAVE_ONECELL(cpu, "reg");
-		if (prop) {
-			cell_t unitnum;
-			char *eptr;
-
-			unitnum = strtol(get_unitname(cpu), &eptr, 16);
-			if (*eptr) {
-				WARNMSG("%s has bad format unit name %s (should be CPU number\n",
-					cpu->fullpath, get_unitname(cpu));
-			} else if (unitnum != propval_cell(prop)) {
-				WARNMSG("%s unit name \"%s\" does not match \"reg\" property <%x>\n",
-				       cpu->fullpath, get_unitname(cpu),
-				       propval_cell(prop));
-			}
-		}
-
-/* 		CHECK_HAVE_ONECELL(cpu, "d-cache-line-size"); */
-/* 		CHECK_HAVE_ONECELL(cpu, "i-cache-line-size"); */
-		CHECK_HAVE_ONECELL(cpu, "d-cache-size");
-		CHECK_HAVE_ONECELL(cpu, "i-cache-size");
-
-		CHECK_HAVE_WARN_ONECELL(cpu, "clock-frequency");
-		CHECK_HAVE_WARN_ONECELL(cpu, "timebase-frequency");
-
-		prop = get_property(cpu, "linux,boot-cpu");
-		if (prop) {
-			if (prop->val.len)
-				WARNMSG("\"linux,boot-cpu\" property in %s is non-empty\n",
-					cpu->fullpath);
-			if (bootcpu)
-				DO_ERR("Multiple boot cpus (%s and %s)\n",
-				       bootcpu->fullpath, cpu->fullpath);
-			else
-				bootcpu = cpu;
-		}
-	}
-
-	if (outversion < 2) {
-		if (! bootcpu)
-			WARNMSG("No cpu has \"linux,boot-cpu\" property\n");
-	} else {
-		if (bootcpu)
-			WARNMSG("\"linux,boot-cpu\" property is deprecated in blob version 2 or higher\n");
-		if (boot_cpuid_phys == 0xfeedbeef)
-			WARNMSG("physical boot CPU not set.  Use -b option to set\n");
-	}
-
-	return ok;
-}
-
-static int check_memory(struct node *root)
-{
-	struct node *mem;
-	struct property *prop;
-	int nnodes = 0;
-	int ok = 1;
-
-	for_each_child(root, mem) {
-		if (! strneq(mem->name, "memory", mem->basenamelen))
-			continue;
-
-		nnodes++;
-
-		CHECK_HAVE_STREQ(mem, "device_type", "memory");
-		CHECK_HAVE(mem, "reg");
-	}
-
-	if (nnodes == 0) {
-		ERRMSG("No memory nodes\n");
-		return 0;
-	}
-
-	return ok;
-}
-
-static int check_chosen(struct node *root)
-{
-	struct node *chosen;
-	struct property *prop;
-	int ok = 1;
-
-	chosen = get_subnode(root, "chosen");
-	if (!chosen)
-		return ok;
-
-        /* give warning for obsolete interrupt-controller property */
-	do {
-		if ((prop = get_property(chosen, "interrupt-controller")) != NULL) {
-			WARNMSG("%s has obsolete \"%s\" property\n",
-                                 chosen->fullpath, "interrupt-controller");
-                }
-	} while (0);
-
-	return ok;
-}
-
-static int check_addr_size_reg(struct node *node,
-			       int p_addr_cells, int p_size_cells)
-{
-	int addr_cells = p_addr_cells;
-	int size_cells = p_size_cells;
-	struct property *prop;
-	struct node *child;
-	int ok = 1;
-
-	node->addr_cells = addr_cells;
-	node->size_cells = size_cells;
-
-	prop = get_property(node, "reg");
-	if (prop) {
-		int len = prop->val.len / 4;
-
-		if ((len % (addr_cells+size_cells)) != 0)
-			DO_ERR("\"reg\" property in %s has invalid length (%d) for given #address-cells (%d) and #size-cells (%d)\n",
-			       node->fullpath, prop->val.len,
-			       addr_cells, size_cells);
-	}
-
-	prop = get_property(node, "#address-cells");
-	if (prop)
-		addr_cells = propval_cell(prop);
-
-	prop = get_property(node, "#size-cells");
-	if (prop)
-		size_cells = propval_cell(prop);
-
-	for_each_child(node, child) {
-		ok = ok && check_addr_size_reg(child, addr_cells, size_cells);
-	}
-
-	return ok;
-}
-
-int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys)
-{
-	int ok = 1;
-
-	ok = ok && check_properties(dt);
-	ok = ok && check_addr_size_reg(dt, -1, -1);
-	ok = ok && check_root(dt);
-	ok = ok && check_cpus(dt, outversion, boot_cpuid_phys);
-	ok = ok && check_memory(dt);
-	ok = ok && check_chosen(dt);
-	if (! ok)
-		return 0;
-
-	return 1;
-}
Index: dtc/Makefile.dtc
===================================================================
--- dtc.orig/Makefile.dtc	2007-11-01 14:53:42.000000000 +1100
+++ dtc/Makefile.dtc	2007-11-01 14:53:57.000000000 +1100
@@ -3,7 +3,8 @@
 # This is not a complete Makefile of itself.  Instead, it is designed to
 # be easily embeddable into other systems of Makefiles.
 #
-DTC_SRCS = dtc.c flattree.c fstree.c data.c livetree.c treesource.c srcpos.c
+DTC_SRCS = dtc.c flattree.c fstree.c data.c livetree.c treesource.c srcpos.c \
+	checks.c
 DTC_EXTRA = dtc.h srcpos.h
 DTC_LEXFILES = dtc-lexer.l
 DTC_BISONFILES = dtc-parser.y
Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2007-11-01 14:54:26.000000000 +1100
+++ dtc/dtc.h	2007-11-01 14:57:06.000000000 +1100
@@ -189,11 +189,13 @@
 void add_property(struct node *node, struct property *prop);
 void add_child(struct node *parent, struct node *child);
 
-int check_structure(struct node *dt);
-void fixup_references(struct node *dt);
-int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys);
+char *get_unitname(struct node *node);
+struct property *get_property(struct node *node, char *propname);
+cell_t propval_cell(struct property *prop);
+struct node *get_subnode(struct node *node, char *nodename);
+struct node *get_node_by_phandle(struct node *tree, cell_t phandle);
 
-int check_device_tree(struct node *dt, int outversion, int boot_cpuid_phys);
+void fixup_references(struct node *dt);
 
 /* Boot info (tree plus memreserve information */
 
@@ -220,6 +222,11 @@
 struct boot_info *build_boot_info(struct reserve_info *reservelist,
 				  struct node *tree);
 
+/* Checks */
+
+int check_structure(struct node *dt);
+int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys);
+
 /* Flattened trees */
 
 void dt_to_blob(FILE *f, struct boot_info *bi, int version,

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
