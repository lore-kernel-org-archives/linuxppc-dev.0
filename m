Return-Path: <dgibson@ozlabs.org>
Date: Thu, 6 Dec 2007 16:59:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Migrate "one cell" checks to new framework
Message-ID: <20071206055945.GD19927@localhost.localdomain>
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

This patch converts to the new tree checking framework those checks
which verify that certain properties (#address-cells and #size-cells)
are exactly one cell in size, when present.

We also drop the old-style check for "linux,phandle" being one cell,
since that is already implied in the the existing new-style checks on
the linux,phandle property.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/checks.c
===================================================================
--- dtc.orig/checks.c	2007-12-06 16:52:00.000000000 +1100
+++ dtc/checks.c	2007-12-06 16:57:02.000000000 +1100
@@ -190,6 +190,23 @@
 #define CHECK_IS_STRING(nm, propname, lvl) \
 	CHECK(nm, NULL, check_is_string, NULL, (propname), (lvl))
 
+static void check_is_cell(struct check *c, struct node *root,
+			  struct node *node)
+{
+	struct property *prop;
+	char *propname = c->data;
+
+	prop = get_property(node, propname);
+	if (!prop)
+		return; /* Not present, assumed ok */
+
+	if (prop->val.len != sizeof(cell_t))
+		FAIL(c, "\"%s\" property in %s is not a single cell",
+		     propname, node->fullpath);
+}
+#define CHECK_IS_CELL(nm, propname, lvl) \
+	CHECK(nm, NULL, check_is_cell, NULL, (propname), (lvl))
+
 /*
  * Structural check functions
  */
@@ -327,11 +344,20 @@
 CHECK(path_references, NULL, NULL, fixup_path_references, NULL, ERROR,
       &duplicate_node_names);
 
+/*
+ * Semantic checks
+ */
+CHECK_IS_CELL(address_cells_is_cell, "#address-cells", WARN);
+CHECK_IS_CELL(size_cells_is_cell, "#size-cells", WARN);
+CHECK_IS_CELL(interrupt_cells_is_cell, "#interrupt-cells", WARN);
+
 static struct check *check_table[] = {
 	&duplicate_node_names, &duplicate_property_names,
 	&name_is_string, &name_properties,
 	&explicit_phandles,
 	&phandle_references, &path_references,
+
+	&address_cells_is_cell, &size_cells_is_cell, &interrupt_cells_is_cell,
 };
 
 int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys);
@@ -381,17 +407,6 @@
 
 #define DO_ERR(...) do {ERRMSG(__VA_ARGS__); ok = 0; } while (0)
 
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
 static int must_be_cells(struct property *prop, struct node *node)
 {
 	if ((prop->val.len % sizeof(cell_t)) != 0) {
@@ -418,9 +433,6 @@
 	char *propname;
 	int (*check_fn)(struct property *prop, struct node *node);
 } prop_checker_table[] = {
-	{"linux,phandle", must_be_one_cell},
-	{"#address-cells", must_be_one_cell},
-	{"#size-cells", must_be_one_cell},
 	{"reg", must_be_cells},
 	{"model", must_be_string},
 	{"device_type", must_be_string},
Index: dtc/tests/bad-ncells.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/bad-ncells.dts	2007-12-06 16:57:02.000000000 +1100
@@ -0,0 +1,7 @@
+/dts-v1/;
+
+/ {
+	#address-cells = "badthing";
+	#size-cells = "badthing";
+	#interrupt-cells = "badthing";
+};
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-12-06 16:57:01.000000000 +1100
+++ dtc/tests/run_tests.sh	2007-12-06 16:57:02.000000000 +1100
@@ -167,6 +167,8 @@
     run_test dtc-checkfails.sh phandle_references -- -I dts -O dtb nonexist-node-ref.dts
     run_test dtc-checkfails.sh phandle_references -- -I dts -O dtb nonexist-label-ref.dts
     run_test dtc-checkfails.sh name_properties -- -I dts -O dtb bad-name-property.dts
+
+    run_test dtc-checkfails.sh address_cells_is_cell size_cells_is_cell interrupt_cells_is_cell -- -I dts -O dtb bad-ncells.dts
 }
 
 while getopts "vt:m" ARG ; do

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
