Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Dec 2007 14:06:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Convert check for obsolete /chosen property
Message-ID: <20071207030611.GC26412@localhost.localdomain>
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

This converts the test for the obsolete "interrupt-controller"
property in /chosen to the new framework.  That was the only thing
left in the old-style check_chosen() function, so that function is
removed, too.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/checks.c
===================================================================
--- dtc.orig/checks.c	2007-12-07 13:46:11.000000000 +1100
+++ dtc/checks.c	2007-12-07 13:53:24.000000000 +1100
@@ -476,6 +476,23 @@ static void check_avoid_default_addr_siz
 }
 NODE_CHECK(avoid_default_addr_size, NULL, WARN, &addr_size_cells);
 
+static void check_obsolete_chosen_interrupt_controller(struct check *c,
+						       struct node *dt)
+{
+	struct node *chosen;
+	struct property *prop;
+
+	chosen = get_node_by_path(dt, "/chosen");
+	if (!chosen)
+		return;
+
+	prop = get_property(chosen, "interrupt-controller");
+	if (prop)
+		FAIL(c, "/chosen has obsolete \"interrupt-controller\" "
+		     "property");
+}
+TREE_CHECK(obsolete_chosen_interrupt_controller, NULL, WARN);
+
 static struct check *check_table[] = {
 	&duplicate_node_names, &duplicate_property_names,
 	&name_is_string, &name_properties,
@@ -488,6 +505,7 @@ static struct check *check_table[] = {
 	&addr_size_cells, &reg_format, &ranges_format,
 
 	&avoid_default_addr_size,
+	&obsolete_chosen_interrupt_controller,
 };
 
 int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys);
@@ -715,27 +733,6 @@ static int check_memory(struct node *roo
 	return ok;
 }
 
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
 int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys)
 {
 	int ok = 1;
@@ -743,7 +740,6 @@ int check_semantics(struct node *dt, int
 	ok = ok && check_root(dt);
 	ok = ok && check_cpus(dt, outversion, boot_cpuid_phys);
 	ok = ok && check_memory(dt);
-	ok = ok && check_chosen(dt);
 	if (! ok)
 		return 0;
 
Index: dtc/tests/obsolete-chosen-interrupt-controller.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/obsolete-chosen-interrupt-controller.dts	2007-12-07 13:51:34.000000000 +1100
@@ -0,0 +1,13 @@
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	PIC: pic@0 {
+		reg = <0x0 0x10>;
+		interrupt-controller;
+	};
+	chosen {
+		interrupt-controller = <&PIC>;
+	};
+};
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-12-07 13:51:44.000000000 +1100
+++ dtc/tests/run_tests.sh	2007-12-07 13:52:06.000000000 +1100
@@ -173,6 +173,7 @@ dtc_tests () {
     run_test dtc-checkfails.sh reg_format ranges_format -- -I dts -O dtb bad-reg-ranges.dts
     run_test dtc-checkfails.sh ranges_format -- -I dts -O dtb bad-empty-ranges.dts
     run_test dtc-checkfails.sh avoid_default_addr_size -- -I dts -O dtb default-addr-size.dts
+    run_test dtc-checkfails.sh obsolete_chosen_interrupt_controller -- -I dts -O dtb obsolete-chosen-interrupt-controller.dts
 }
 
 while getopts "vt:m" ARG ; do

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
