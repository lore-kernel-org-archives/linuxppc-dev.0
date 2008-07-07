Return-Path: <dgibson@ozlabs.org>
Date: Mon, 7 Jul 2008 11:19:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Run relevant checks on dtb input as well as dts
Message-ID: <20080707011913.GE6267@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adjusts the testsuite to run most of the tests for the tree
checking code on input in dtb form as well as dts form.  Some checks
which only make sense for dts input (like reference handling) are
excluded, as are those which currently take dtb input because they
rely on things which cannot be lexically constructed in a dts file.

This shows up two small bugs in dtc, which are also corrected.

First, the name_properties test which was is supposed to remove
correctly formed 'name' properties (because they can be reconstructed
from tne node name) was instead removing 'name' properties even if
they weren't correct.

Secondly, when using dtb or fs input, the runtime tree in dtc did not
have the parent pointer initialized propertly because.built
internally.  The appropriate initialization is added to the
add_child() function.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2008-07-07 11:09:43.000000000 +1000
+++ dtc/tests/run_tests.sh	2008-07-07 11:09:44.000000000 +1000
@@ -115,6 +115,14 @@
     run_test del_node $TREE
 }
 
+check_tests () {
+    tree="$1"
+    shift
+    run_sh_test dtc-checkfails.sh "$@" -- -I dts -O dtb $tree
+    run_dtc_test -I dts -O dtb -o $tree.test.dtb -f $tree
+    run_sh_test dtc-checkfails.sh "$@" -- -I dtb -O dtb $tree.test.dtb
+}
+
 ALL_LAYOUTS="mts mst tms tsm smt stm"
 
 libfdt_tests () {
@@ -243,22 +251,22 @@
     done
 
     # Check some checks
-    run_sh_test dtc-checkfails.sh duplicate_node_names -- -I dts -O dtb dup-nodename.dts
-    run_sh_test dtc-checkfails.sh duplicate_property_names -- -I dts -O dtb dup-propname.dts
-    run_sh_test dtc-checkfails.sh explicit_phandles -- -I dts -O dtb dup-phandle.dts
-    run_sh_test dtc-checkfails.sh explicit_phandles -- -I dts -O dtb zero-phandle.dts
-    run_sh_test dtc-checkfails.sh explicit_phandles -- -I dts -O dtb minusone-phandle.dts
+    check_tests dup-nodename.dts duplicate_node_names
+    check_tests dup-propname.dts duplicate_property_names
+    check_tests dup-phandle.dts explicit_phandles
+    check_tests zero-phandle.dts explicit_phandles
+    check_tests minusone-phandle.dts explicit_phandles
     run_sh_test dtc-checkfails.sh phandle_references -- -I dts -O dtb nonexist-node-ref.dts
     run_sh_test dtc-checkfails.sh phandle_references -- -I dts -O dtb nonexist-label-ref.dts
-    run_sh_test dtc-checkfails.sh name_properties -- -I dts -O dtb bad-name-property.dts
+    check_tests bad-name-property.dts name_properties
 
-    run_sh_test dtc-checkfails.sh address_cells_is_cell size_cells_is_cell interrupt_cells_is_cell -- -I dts -O dtb bad-ncells.dts
-    run_sh_test dtc-checkfails.sh device_type_is_string model_is_string status_is_string -- -I dts -O dtb bad-string-props.dts
-    run_sh_test dtc-checkfails.sh reg_format ranges_format -- -I dts -O dtb bad-reg-ranges.dts
-    run_sh_test dtc-checkfails.sh ranges_format -- -I dts -O dtb bad-empty-ranges.dts
-    run_sh_test dtc-checkfails.sh reg_format ranges_format -- -I dts -O dtb reg-ranges-root.dts
-    run_sh_test dtc-checkfails.sh avoid_default_addr_size -- -I dts -O dtb default-addr-size.dts
-    run_sh_test dtc-checkfails.sh obsolete_chosen_interrupt_controller -- -I dts -O dtb obsolete-chosen-interrupt-controller.dts
+    check_tests bad-ncells.dts address_cells_is_cell size_cells_is_cell interrupt_cells_is_cell
+    check_tests bad-string-props.dts device_type_is_string model_is_string status_is_string
+    check_tests bad-reg-ranges.dts reg_format ranges_format
+    check_tests bad-empty-ranges.dts ranges_format
+    check_tests reg-ranges-root.dts reg_format ranges_format
+    check_tests default-addr-size.dts avoid_default_addr_size
+    check_tests obsolete-chosen-interrupt-controller.dts obsolete_chosen_interrupt_controller
     run_sh_test dtc-checkfails.sh node_name_chars -- -I dtb -O dtb bad_node_char.dtb
     run_sh_test dtc-checkfails.sh node_name_format -- -I dtb -O dtb bad_node_format.dtb
     run_sh_test dtc-checkfails.sh prop_name_chars -- -I dtb -O dtb bad_prop_char.dtb
Index: dtc/checks.c
===================================================================
--- dtc.orig/checks.c	2008-07-07 11:11:27.000000000 +1000
+++ dtc/checks.c	2008-07-07 11:11:46.000000000 +1000
@@ -328,15 +328,17 @@
 		return; /* No name property, that's fine */
 
 	if ((prop->val.len != node->basenamelen+1)
-	    || (memcmp(prop->val.val, node->name, node->basenamelen) != 0))
+	    || (memcmp(prop->val.val, node->name, node->basenamelen) != 0)) {
 		FAIL(c, "\"name\" property in %s is incorrect (\"%s\" instead"
 		     " of base node name)", node->fullpath, prop->val.val);
-
-	/* The name property is correct, and therefore redundant.  Delete it */
-	*pp = prop->next;
-	free(prop->name);
-	data_free(prop->val);
-	free(prop);
+	} else {
+		/* The name property is correct, and therefore redundant.
+		 * Delete it */
+		*pp = prop->next;
+		free(prop->name);
+		data_free(prop->val);
+		free(prop);
+	}
 }
 CHECK_IS_STRING(name_is_string, "name", ERROR);
 NODE_CHECK(name_properties, NULL, ERROR, &name_is_string);
Index: dtc/livetree.c
===================================================================
--- dtc.orig/livetree.c	2008-07-07 11:12:12.000000000 +1000
+++ dtc/livetree.c	2008-07-07 11:12:19.000000000 +1000
@@ -115,6 +115,7 @@
 	struct node **p;
 
 	child->next_sibling = NULL;
+	child->parent = parent;
 
 	p = &parent->children;
 	while (*p)

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
