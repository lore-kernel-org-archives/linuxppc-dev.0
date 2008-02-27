Return-Path: <dgibson@ozlabs.org>
Date: Wed, 27 Feb 2008 13:45:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Implement checks for the format of node and property names
Message-ID: <20080227024513.GA15835@localhost.localdomain>
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

This patch adds checks to the checking framework to verify that node
and property names contain only legal characters, and in the case of
node names there is at most one '@'.

At present when coming from dts input, this is mostly already ensured
by the grammer, however putting the check later means its easier to
generate helpful error messages rather than just "syntax error".  For
dtb input, these checks replace the older similar check built into
flattree.c.

Testcases for the checks are also implemented.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 checks.c           |   37 +++++++++++++++++++++++++++++++++++++
 flattree.c         |   28 +++++-----------------------
 tests/dumptrees.c  |    1 +
 tests/run_tests.sh |    3 +++
 tests/testdata.h   |    3 +++
 tests/trees.S      |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 97 insertions(+), 23 deletions(-)

Index: dtc/checks.c
===================================================================
--- dtc.orig/checks.c	2008-02-27 13:25:08.000000000 +1100
+++ dtc/checks.c	2008-02-27 13:29:05.000000000 +1100
@@ -242,6 +242,42 @@
 }
 NODE_CHECK(duplicate_property_names, NULL, ERROR);
 
+#define LOWERCASE	"abcdefghijklmnopqrstuvwxyz"
+#define UPPERCASE	"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+#define DIGITS		"0123456789"
+#define PROPNODECHARS	LOWERCASE UPPERCASE DIGITS ",._+*#?-"
+
+static void check_node_name_chars(struct check *c, struct node *dt,
+				  struct node *node)
+{
+	int n = strspn(node->name, c->data);
+
+	if (n < strlen(node->name))
+		FAIL(c, "Bad character '%c' in node %s",
+		     node->name[n], node->fullpath);
+}
+NODE_CHECK(node_name_chars, PROPNODECHARS "@", ERROR);
+
+static void check_node_name_format(struct check *c, struct node *dt,
+				   struct node *node)
+{
+	if (strchr(get_unitname(node), '@'))
+		FAIL(c, "Node %s has multiple '@' characters in name",
+		     node->fullpath);
+}
+NODE_CHECK(node_name_format, NULL, ERROR, &node_name_chars);
+
+static void check_property_name_chars(struct check *c, struct node *dt,
+				      struct node *node, struct property *prop)
+{
+	int n = strspn(prop->name, c->data);
+
+	if (n < strlen(prop->name))
+		FAIL(c, "Bad character '%c' in property name \"%s\", node %s",
+		     prop->name[n], prop->name, node->fullpath);
+}
+PROP_CHECK(property_name_chars, PROPNODECHARS, ERROR);
+
 static void check_explicit_phandles(struct check *c, struct node *root,
 					  struct node *node)
 {
@@ -498,6 +534,7 @@
 
 static struct check *check_table[] = {
 	&duplicate_node_names, &duplicate_property_names,
+	&node_name_chars, &node_name_format, &property_name_chars,
 	&name_is_string, &name_properties,
 	&explicit_phandles,
 	&phandle_references, &path_references,
Index: dtc/tests/trees.S
===================================================================
--- dtc.orig/tests/trees.S	2008-02-27 13:25:08.000000000 +1100
+++ dtc/tests/trees.S	2008-02-27 13:28:33.000000000 +1100
@@ -136,3 +136,51 @@
 truncated_property_strings_end:
 
 truncated_property_end:
+
+
+	TREE_HDR(bad_node_char)
+	EMPTY_RSVMAP(bad_node_char)
+
+bad_node_char_struct:
+	BEGIN_NODE("")
+	BEGIN_NODE("sub$node")
+	END_NODE
+	END_NODE
+	FDTLONG(FDT_END)
+bad_node_char_struct_end:
+
+bad_node_char_strings:
+bad_node_char_strings_end:
+bad_node_char_end:
+
+
+	TREE_HDR(bad_node_format)
+	EMPTY_RSVMAP(bad_node_format)
+
+bad_node_format_struct:
+	BEGIN_NODE("")
+	BEGIN_NODE("subnode@1@2")
+	END_NODE
+	END_NODE
+	FDTLONG(FDT_END)
+bad_node_format_struct_end:
+
+bad_node_format_strings:
+bad_node_format_strings_end:
+bad_node_format_end:
+
+
+	TREE_HDR(bad_prop_char)
+	EMPTY_RSVMAP(bad_prop_char)
+
+bad_prop_char_struct:
+	BEGIN_NODE("")
+	PROP_INT(bad_prop_char, prop, TEST_VALUE_1)
+	END_NODE
+	FDTLONG(FDT_END)
+bad_prop_char_struct_end:
+
+bad_prop_char_strings:
+	STRING(bad_prop_char, prop, "prop$erty")
+bad_prop_char_strings_end:
+bad_prop_char_end:
Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2008-02-27 13:25:08.000000000 +1100
+++ dtc/flattree.c	2008-02-27 13:41:06.000000000 +1100
@@ -729,29 +729,14 @@
 	return strdup(lslash+1);
 }
 
-static const char PROPCHAR[] = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,._+*#?-";
-static const char UNITCHAR[] = "0123456789abcdef,";
-
-static int check_node_name(const char *name)
+static int find_basenamelen(const char *name)
 {
-	const char *atpos;
-	int basenamelen;
-
-	atpos = strrchr(name, '@');
+	const char *atpos = strchr(name, '@');
 
 	if (atpos)
-		basenamelen = atpos - name;
+		return atpos - name;
 	else
-		basenamelen = strlen(name);
-
-	if (strspn(name, PROPCHAR) < basenamelen)
-		return -1;
-
-	if (atpos
-	    && ((basenamelen + 1 + strspn(atpos+1, UNITCHAR)) < strlen(name)))
-		return -1;
-
-	return basenamelen;
+		return strlen(name);
 }
 
 static struct node *unflatten_tree(struct inbuf *dtbuf,
@@ -775,10 +760,7 @@
 		node->fullpath = join_path(parent_path, node->name);
 	}
 
-	node->basenamelen = check_node_name(node->name);
-	if (node->basenamelen < 0) {
-		fprintf(stderr, "Warning \"%s\" has incorrect format\n", node->name);
-	}
+	node->basenamelen = find_basenamelen(node->name);
 
 	do {
 		struct property *prop;
Index: dtc/tests/dumptrees.c
===================================================================
--- dtc.orig/tests/dumptrees.c	2008-02-27 13:25:08.000000000 +1100
+++ dtc/tests/dumptrees.c	2008-02-27 13:25:09.000000000 +1100
@@ -37,6 +37,7 @@
 } trees[] = {
 #define TREE(name)	{ &_##name, #name ".dtb" }
 	TREE(test_tree1),
+	TREE(bad_node_char), TREE(bad_node_format), TREE(bad_prop_char),
 };
 
 #define NUM_TREES	(sizeof(trees) / sizeof(trees[0]))
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2008-02-27 13:25:08.000000000 +1100
+++ dtc/tests/run_tests.sh	2008-02-27 13:25:09.000000000 +1100
@@ -189,6 +189,9 @@
     run_test dtc-checkfails.sh ranges_format -- -I dts -O dtb bad-empty-ranges.dts
     run_test dtc-checkfails.sh avoid_default_addr_size -- -I dts -O dtb default-addr-size.dts
     run_test dtc-checkfails.sh obsolete_chosen_interrupt_controller -- -I dts -O dtb obsolete-chosen-interrupt-controller.dts
+    run_test dtc-checkfails.sh node_name_chars -- -I dtb -O dtb bad_node_char.dtb
+    run_test dtc-checkfails.sh node_name_format -- -I dtb -O dtb bad_node_format.dtb
+    run_test dtc-checkfails.sh prop_name_chars -- -I dtb -O dtb bad_prop_char.dtb
 }
 
 while getopts "vt:m" ARG ; do
Index: dtc/tests/testdata.h
===================================================================
--- dtc.orig/tests/testdata.h	2008-02-27 13:25:08.000000000 +1100
+++ dtc/tests/testdata.h	2008-02-27 13:25:09.000000000 +1100
@@ -33,4 +33,7 @@
 #ifndef __ASSEMBLY__
 extern struct fdt_header _test_tree1;
 extern struct fdt_header _truncated_property;
+extern struct fdt_header _bad_node_char;
+extern struct fdt_header _bad_node_format;
+extern struct fdt_header _bad_prop_char;
 #endif /* ! __ASSEMBLY */

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
