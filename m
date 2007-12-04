Return-Path: <dgibson@ozlabs.org>
Date: Wed, 5 Dec 2007 09:40:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Convert "name" property checking to new infrastructure
Message-ID: <20071204224023.GA9487@localhost.localdomain>
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

This patch removes the old-style checking code for the "name" property
- i.e. verifying that the "name" property, if present, matches the
node name.  It replaces it with a pair of more-or-less equivalent
checks in the new checking framework.

This also promotes this check to a "structural" check, or at least an
error-rather-than-warning test, since the structural/semantic
distinction doesn't really apply in the new framework.

A testcase for the check is also added.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/checks.c
===================================================================
--- dtc.orig/checks.c	2007-12-04 14:14:41.000000000 +1100
+++ dtc/checks.c	2007-12-04 14:41:46.000000000 +1100
@@ -170,6 +170,27 @@ out:
 }
 
 /*
+ * Utility check functions
+ */
+
+static void check_is_string(struct check *c, struct node *root,
+			    struct node *node)
+{
+	struct property *prop;
+	char *propname = c->data;
+
+	prop = get_property(node, propname);
+	if (!prop)
+		return; /* Not present, assumed ok */
+
+	if (!data_is_one_string(prop->val))
+		FAIL(c, "\"%s\" property in %s is not a string",
+		     propname, node->fullpath);
+}
+#define CHECK_IS_STRING(nm, propname, lvl) \
+	CHECK(nm, NULL, check_is_string, NULL, (propname), (lvl))
+
+/*
  * Structural check functions
  */
 
@@ -236,6 +257,23 @@ static void check_explicit_phandles(stru
 }
 NODE_CHECK(explicit_phandles, NULL, ERROR);
 
+static void check_name_properties(struct check *c, struct node *root,
+				  struct node *node)
+{
+	struct property *prop;
+
+	prop = get_property(node, "name");
+	if (!prop)
+		return; /* No name property, that's fine */
+
+	if ((prop->val.len != node->basenamelen+1)
+	    || (memcmp(prop->val.val, node->name, node->basenamelen) != 0))
+		FAIL(c, "\"name\" property in %s is incorrect (\"%s\" instead"
+		     " of base node name)", node->fullpath, prop->val.val);
+}
+CHECK_IS_STRING(name_is_string, "name", ERROR);
+NODE_CHECK(name_properties, NULL, ERROR, &name_is_string);
+
 /*
  * Reference fixup functions
  */
@@ -266,6 +304,7 @@ CHECK(phandle_references, NULL, NULL, fi
 
 static struct check *check_table[] = {
 	&duplicate_node_names, &duplicate_property_names,
+	&name_is_string, &name_properties,
 	&explicit_phandles,
 	&phandle_references,
 };
@@ -350,25 +389,10 @@ static int must_be_string(struct propert
 	return 1;
 }
 
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
 static struct {
 	char *propname;
 	int (*check_fn)(struct property *prop, struct node *node);
 } prop_checker_table[] = {
-	{"name", must_be_string},
-	{"name", name_prop_check},
 	{"linux,phandle", must_be_one_cell},
 	{"#address-cells", must_be_one_cell},
 	{"#size-cells", must_be_one_cell},
Index: dtc/tests/bad-name-property.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/bad-name-property.dts	2007-12-04 14:28:54.000000000 +1100
@@ -0,0 +1,7 @@
+/dts-v1/;
+
+/ {
+	node@0 {
+		name = "badthing";
+	};
+};
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-12-04 14:29:14.000000000 +1100
+++ dtc/tests/run_tests.sh	2007-12-04 14:29:27.000000000 +1100
@@ -163,6 +163,7 @@ dtc_tests () {
     run_test dtc-checkfails.sh -I dts -O dtb minusone-phandle.dts
     run_test dtc-checkfails.sh -I dts -O dtb nonexist-node-ref.dts
     run_test dtc-checkfails.sh -I dts -O dtb nonexist-label-ref.dts
+    run_test dtc-checkfails.sh -I dts -O dtb bad-name-property.dts
 }
 
 while getopts "vt:m" ARG ; do

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
