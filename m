Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Dec 2007 14:05:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Convert #address-cells and #size-cells related checks
Message-ID: <20071207030555.GB26412@localhost.localdomain>
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

This patch converts checks related to #address-cells and #size-cells
to the new framework.  Specifically, it reimplements the check that
"reg" properties have a valid size based on the relevant
#address-cells and #size-cells values.  The new implementation uses
the correct default value, unlike the old-style check which assumed
the values were inherited by default.

It also implements a new, similar test for "ranges" properties.

Finally, since relying on the default values of these variables is
considered not-good-practice these days, it implements a "style" check
which will give a warning if the tree ever relies on the default
values (that is if any node with either "reg" or "ranges" appears
under a parent which has no #address-cells or #size-cells property).

Index: dtc/checks.c
===================================================================
--- dtc.orig/checks.c	2007-12-07 12:54:59.000000000 +1100
+++ dtc/checks.c	2007-12-07 13:16:38.000000000 +1100
@@ -355,6 +355,127 @@ CHECK_IS_STRING(device_type_is_string, "
 CHECK_IS_STRING(model_is_string, "model", WARN);
 CHECK_IS_STRING(status_is_string, "status", WARN);
 
+static void fixup_addr_size_cells(struct check *c, struct node *dt,
+				  struct node *node)
+{
+	struct property *prop;
+
+	node->addr_cells = -1;
+	node->size_cells = -1;
+
+	prop = get_property(node, "#address-cells");
+	if (prop)
+		node->addr_cells = propval_cell(prop);
+
+	prop = get_property(node, "#size-cells");
+	if (prop)
+		node->size_cells = propval_cell(prop);
+}
+CHECK(addr_size_cells, NULL, fixup_addr_size_cells, NULL, NULL, WARN,
+      &address_cells_is_cell, &size_cells_is_cell);
+
+#define node_addr_cells(n) \
+	(((n)->addr_cells == -1) ? 2 : (n)->addr_cells)
+#define node_size_cells(n) \
+	(((n)->size_cells == -1) ? 1 : (n)->size_cells)
+
+static void check_reg_format(struct check *c, struct node *dt,
+			     struct node *node)
+{
+	struct property *prop;
+	int addr_cells, size_cells, entrylen;
+
+	prop = get_property(node, "reg");
+	if (!prop)
+		return; /* No "reg", that's fine */
+
+	if (!node->parent) {
+		FAIL(c, "Root node has a \"reg\" property");
+		return;
+	}
+
+	if (prop->val.len == 0)
+		FAIL(c, "\"reg\" property in %s is empty", node->fullpath);
+
+	addr_cells = node_addr_cells(node->parent);
+	size_cells = node_size_cells(node->parent);
+	entrylen = (addr_cells + size_cells) * sizeof(cell_t);
+
+	if ((prop->val.len % entrylen) != 0)
+		FAIL(c, "\"reg\" property in %s has invalid length (%d bytes) "
+		     "(#address-cells == %d, #size-cells == %d)",
+		     node->fullpath, prop->val.len, addr_cells, size_cells);
+}
+NODE_CHECK(reg_format, NULL, WARN, &addr_size_cells);
+
+static void check_ranges_format(struct check *c, struct node *dt,
+				struct node *node)
+{
+	struct property *prop;
+	int c_addr_cells, p_addr_cells, c_size_cells, p_size_cells, entrylen;
+
+	prop = get_property(node, "ranges");
+	if (!prop)
+		return;
+
+	if (!node->parent) {
+		FAIL(c, "Root node has a \"ranges\" property");
+		return;
+	}
+
+	p_addr_cells = node_addr_cells(node->parent);
+	p_size_cells = node_size_cells(node->parent);
+	c_addr_cells = node_addr_cells(node);
+	c_size_cells = node_size_cells(node);
+	entrylen = (p_addr_cells + c_addr_cells + c_size_cells) * sizeof(cell_t);
+
+	if (prop->val.len == 0) {
+		if (p_addr_cells != c_addr_cells)
+			FAIL(c, "%s has empty \"ranges\" property but its "
+			     "#address-cells (%d) differs from %s (%d)",
+			     node->fullpath, c_addr_cells, node->parent->fullpath,
+			     p_addr_cells);
+		if (p_size_cells != c_size_cells)
+			FAIL(c, "%s has empty \"ranges\" property but its "
+			     "#size-cells (%d) differs from %s (%d)",
+			     node->fullpath, c_size_cells, node->parent->fullpath,
+			     p_size_cells);
+	} else if ((prop->val.len % entrylen) != 0) {
+		FAIL(c, "\"ranges\" property in %s has invalid length (%d bytes) "
+		     "(parent #address-cells == %d, child #address-cells == %d, "
+		     "#size-cells == %d)", node->fullpath, prop->val.len,
+		     p_addr_cells, c_addr_cells, c_size_cells);
+	}
+}
+NODE_CHECK(ranges_format, NULL, WARN, &addr_size_cells);
+
+/*
+ * Style checks
+ */
+static void check_avoid_default_addr_size(struct check *c, struct node *dt,
+					  struct node *node)
+{
+	struct property *reg, *ranges;
+
+	if (!node->parent)
+		return; /* Ignore root node */
+
+	reg = get_property(node, "reg");
+	ranges = get_property(node, "ranges");
+
+	if (!reg && !ranges)
+		return;
+
+	if ((node->parent->addr_cells == -1))
+		FAIL(c, "Relying on default #address-cells value for %s",
+		     node->fullpath);
+
+	if ((node->parent->size_cells == -1))
+		FAIL(c, "Relying on default #size-cells value for %s",
+		     node->fullpath);
+}
+NODE_CHECK(avoid_default_addr_size, NULL, WARN, &addr_size_cells);
+
 static struct check *check_table[] = {
 	&duplicate_node_names, &duplicate_property_names,
 	&name_is_string, &name_properties,
@@ -363,6 +484,10 @@ static struct check *check_table[] = {
 
 	&address_cells_is_cell, &size_cells_is_cell, &interrupt_cells_is_cell,
 	&device_type_is_string, &model_is_string, &status_is_string,
+
+	&addr_size_cells, &reg_format, &ranges_format,
+
+	&avoid_default_addr_size,
 };
 
 int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys);
@@ -487,10 +612,6 @@ static int check_root(struct node *root)
 	int ok = 1;
 
 	CHECK_HAVE_STRING(root, "model");
-
-	CHECK_HAVE(root, "#address-cells");
-	CHECK_HAVE(root, "#size-cells");
-
 	CHECK_HAVE_WARN(root, "compatible");
 
 	return ok;
@@ -509,19 +630,16 @@ static int check_cpus(struct node *root,
 		return 0;
 	}
 
-	CHECK_HAVE_WARN(cpus, "#address-cells");
-	CHECK_HAVE_WARN(cpus, "#size-cells");
+	if (cpus->addr_cells != 1)
+		DO_ERR("%s has bad #address-cells value %d (should be 1)\n",
+		       cpus->fullpath, cpus->addr_cells);
+	if (cpus->size_cells != 0)
+		DO_ERR("%s has bad #size-cells value %d (should be 0)\n",
+		       cpus->fullpath, cpus->size_cells);
 
 	for_each_child(cpus, cpu) {
 		CHECK_HAVE_STREQ(cpu, "device_type", "cpu");
 
-		if (cpu->addr_cells != 1)
-			DO_ERR("%s has bad #address-cells value %d (should be 1)\n",
-			       cpu->fullpath, cpu->addr_cells);
-		if (cpu->size_cells != 0)
-			DO_ERR("%s has bad #size-cells value %d (should be 0)\n",
-			       cpu->fullpath, cpu->size_cells);
-
 		CHECK_HAVE_ONECELL(cpu, "reg");
 		if (prop) {
 			cell_t unitnum;
@@ -618,47 +736,10 @@ static int check_chosen(struct node *roo
 	return ok;
 }
 
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
-		int reg_entry_len = (addr_cells + size_cells) * sizeof(cell_t);
-		if ((prop->val.len % reg_entry_len) != 0)
-			DO_ERR("\"reg\" property in %s has invalid length (%d bytes) for given #address-cells (%d) and #size-cells (%d)\n",
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
 int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys)
 {
 	int ok = 1;
 
-	ok = ok && check_addr_size_reg(dt, -1, -1);
 	ok = ok && check_root(dt);
 	ok = ok && check_cpus(dt, outversion, boot_cpuid_phys);
 	ok = ok && check_memory(dt);
Index: dtc/tests/bad-empty-ranges.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/bad-empty-ranges.dts	2007-12-07 12:56:18.000000000 +1100
@@ -0,0 +1,11 @@
+/dts-v1/;
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	node {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+	};
+};
Index: dtc/tests/bad-reg-ranges.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/bad-reg-ranges.dts	2007-12-07 12:56:18.000000000 +1100
@@ -0,0 +1,12 @@
+/dts-v1/;
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	node {
+		reg = <0 0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0>;
+	};
+};
Index: dtc/tests/default-addr-size.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/default-addr-size.dts	2007-12-07 13:20:25.000000000 +1100
@@ -0,0 +1,7 @@
+/dts-v1/;
+
+/ {
+	node {
+		reg = <0 0 0>;
+	};
+};
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-12-07 13:19:14.000000000 +1100
+++ dtc/tests/run_tests.sh	2007-12-07 13:21:22.000000000 +1100
@@ -170,7 +170,9 @@ dtc_tests () {
 
     run_test dtc-checkfails.sh address_cells_is_cell size_cells_is_cell interrupt_cells_is_cell -- -I dts -O dtb bad-ncells.dts
     run_test dtc-checkfails.sh device_type_is_string model_is_string status_is_string -- -I dts -O dtb bad-string-props.dts
-
+    run_test dtc-checkfails.sh reg_format ranges_format -- -I dts -O dtb bad-reg-ranges.dts
+    run_test dtc-checkfails.sh ranges_format -- -I dts -O dtb bad-empty-ranges.dts
+    run_test dtc-checkfails.sh avoid_default_addr_size -- -I dts -O dtb default-addr-size.dts
 }
 
 while getopts "vt:m" ARG ; do

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
