Return-Path: <dgibson@ozlabs.org>
Date: Thu, 6 Dec 2007 17:01:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Migrate "string property" checks to new framework
Message-ID: <20071206060107.GE19927@localhost.localdomain>
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
which verify that certain properties (device_type, model) have a
string value, when present.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/checks.c
===================================================================
--- dtc.orig/checks.c	2007-12-06 16:57:02.000000000 +1100
+++ dtc/checks.c	2007-12-06 16:59:54.000000000 +1100
@@ -351,6 +351,10 @@
 CHECK_IS_CELL(size_cells_is_cell, "#size-cells", WARN);
 CHECK_IS_CELL(interrupt_cells_is_cell, "#interrupt-cells", WARN);
 
+CHECK_IS_STRING(device_type_is_string, "device_type", WARN);
+CHECK_IS_STRING(model_is_string, "model", WARN);
+CHECK_IS_STRING(status_is_string, "status", WARN);
+
 static struct check *check_table[] = {
 	&duplicate_node_names, &duplicate_property_names,
 	&name_is_string, &name_properties,
@@ -358,6 +362,7 @@
 	&phandle_references, &path_references,
 
 	&address_cells_is_cell, &size_cells_is_cell, &interrupt_cells_is_cell,
+	&device_type_is_string, &model_is_string, &status_is_string,
 };
 
 int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys);
@@ -418,24 +423,11 @@
 	return 1;
 }
 
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
 static struct {
 	char *propname;
 	int (*check_fn)(struct property *prop, struct node *node);
 } prop_checker_table[] = {
 	{"reg", must_be_cells},
-	{"model", must_be_string},
-	{"device_type", must_be_string},
 };
 
 static int check_properties(struct node *node)
Index: dtc/tests/bad-string-props.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/bad-string-props.dts	2007-12-06 16:59:54.000000000 +1100
@@ -0,0 +1,7 @@
+/dts-v1/;
+
+/ {
+	device_type = <0xdeadbeef>;
+	model = <0xdeadbeef>;
+	status = <0xdeadbeef>;
+};
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-12-06 16:57:02.000000000 +1100
+++ dtc/tests/run_tests.sh	2007-12-06 16:59:54.000000000 +1100
@@ -169,6 +169,8 @@
     run_test dtc-checkfails.sh name_properties -- -I dts -O dtb bad-name-property.dts
 
     run_test dtc-checkfails.sh address_cells_is_cell size_cells_is_cell interrupt_cells_is_cell -- -I dts -O dtb bad-ncells.dts
+    run_test dtc-checkfails.sh device_type_is_string model_is_string status_is_string -- -I dts -O dtb bad-string-props.dts
+
 }
 
 while getopts "vt:m" ARG ; do

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
