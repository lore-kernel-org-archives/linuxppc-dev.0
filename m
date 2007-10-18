Return-Path: <dgibson@ozlabs.org>
Date: Thu, 18 Oct 2007 17:22:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Disable semantic checks by default
Message-ID: <20071018072230.GA10392@localhost.localdomain>
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

At present, dtc makes a lot of semantic checks on the device tree by
default, and will refuse to produce output if they fail.  This means
people tend to need -f to force output despite failing semantic checks
rather a lot.

This patch splits the device tree checks into structural checks (no
bad or duplicate names or phandles) and semantic checks (everything
else).  By default, only the structural checks are performed, and are
fatal.  -f will force output even with structural errors (using this
in -Idts mode would essentially always be a bad idea, but it might be
useful in -Idtb mode for examining a malformed dtb).

Semantic checks are only performed if the new -c command line option
is supplied, and are always warnings only.  Semantic checks will never
be performed on a tree with structural errors.

This patch is only a stopgap before implementing proper fine-grained
error/warning handling, but it should at least get rid of the
far-too-frequent need for -f for the time being.

This patch removes the -f from the dtc testcases now that it's no
longer necessary.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c	2007-10-18 16:09:18.000000000 +1000
+++ dtc/dtc.c	2007-10-18 17:06:27.000000000 +1000
@@ -112,19 +112,20 @@
 	char *inform = "dts";
 	char *outform = "dts";
 	char *outname = "-";
-	int force = 0;
+	int force = 0, check = 0;
 	char *arg;
 	int opt;
 	FILE *inf = NULL;
 	FILE *outf = NULL;
 	int outversion = DEFAULT_FDT_VERSION;
 	int boot_cpuid_phys = 0xfeedbeef;
+	int structure_ok;
 
 	quiet      = 0;
 	reservenum = 0;
 	minsize    = 0;
 
-	while ((opt = getopt(argc, argv, "hI:O:o:V:R:S:fqb:v")) != EOF) {
+	while ((opt = getopt(argc, argv, "hI:O:o:V:R:S:fcqb:v")) != EOF) {
 		switch (opt) {
 		case 'I':
 			inform = optarg;
@@ -147,6 +148,9 @@
 		case 'f':
 			force = 1;
 			break;
+		case 'c':
+			check = 1;
+			break;
 		case 'q':
 			quiet++;
 			break;
@@ -189,12 +193,25 @@
 	if (! bi || ! bi->dt)
 		die("Couldn't read input tree\n");
 
-	if (! check_device_tree(bi->dt, outversion, boot_cpuid_phys)) {
-		if ((force) && (quiet < 3))
-			fprintf(stderr, "Input tree has errors, output forced\n");
-		if (! force) {
-			fprintf(stderr, "Input tree has errors, not writing output (use -f to force output)\n");
+	structure_ok = check_structure(bi->dt);
+	if (!structure_ok) {
+		if (!force) {
+			fprintf(stderr, "ERROR: Input tree has structural errors, aborting (use -f to force output)\n");
 			exit(1);
+		} else if (quiet < 3) {
+			fprintf(stderr, "Warning: Input tree has structural errors, output forced\n");
+		}
+	}
+
+	fixup_references(bi->dt);
+
+	if (check) {
+		if (!structure_ok) {
+			fprintf(stderr, "Warning: Skipping semantic checks due to structural errors\n");
+		} else {
+			if (!check_semantics(bi->dt, outversion,
+					     boot_cpuid_phys))
+				fprintf(stderr, "Warning: Input tree has semantic errors\n");
 		}
 	}
 
Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2007-10-18 16:08:50.000000000 +1000
+++ dtc/dtc.h	2007-10-18 16:33:37.000000000 +1000
@@ -188,6 +188,10 @@
 void add_property(struct node *node, struct property *prop);
 void add_child(struct node *parent, struct node *child);
 
+int check_structure(struct node *dt);
+void fixup_references(struct node *dt);
+int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys);
+
 int check_device_tree(struct node *dt, int outversion, int boot_cpuid_phys);
 
 /* Boot info (tree plus memreserve information */
Index: dtc/livetree.c
===================================================================
--- dtc.orig/livetree.c	2007-10-18 16:06:05.000000000 +1000
+++ dtc/livetree.c	2007-10-18 16:33:41.000000000 +1000
@@ -149,6 +149,18 @@
 	return list;
 }
 
+struct boot_info *build_boot_info(struct reserve_info *reservelist,
+				  struct node *tree)
+{
+	struct boot_info *bi;
+
+	bi = xmalloc(sizeof(*bi));
+	bi->reservelist = reservelist;
+	bi->dt = tree;
+
+	return bi;
+}
+
 /*
  * Tree accessor functions
  */
@@ -248,13 +260,178 @@
 	return NULL;
 }
 
+static cell_t get_node_phandle(struct node *root, struct node *node)
+{
+	static cell_t phandle = 1; /* FIXME: ick, static local */
+
+	if ((node->phandle != 0) && (node->phandle != -1))
+		return node->phandle;
+
+	assert(! get_property(node, "linux,phandle"));
+
+	while (get_node_by_phandle(root, phandle))
+		phandle++;
+
+	node->phandle = phandle;
+	add_property(node,
+		     build_property("linux,phandle",
+				    data_append_cell(empty_data, phandle),
+				    NULL));
+
+	return node->phandle;
+}
+
 /*
- * Tree checking functions
+ * Structural check functions
  */
 
 #define ERRMSG(...) if (quiet < 2) fprintf(stderr, "ERROR: " __VA_ARGS__)
 #define WARNMSG(...) if (quiet < 1) fprintf(stderr, "Warning: " __VA_ARGS__)
 
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
+ * Reference fixup functions
+ */
+
+static void apply_fixup(struct node *root, struct property *prop,
+			struct fixup *f)
+{
+	struct node *refnode;
+	cell_t phandle;
+
+	if (f->ref[0] == '/') {
+		/* Reference to full path */
+		refnode = get_node_by_path(root, f->ref);
+		if (! refnode)
+			die("Reference to non-existent node \"%s\"\n", f->ref);
+	} else {
+		refnode = get_node_by_label(root, f->ref);
+		if (! refnode)
+			die("Reference to non-existent node label \"%s\"\n", f->ref);
+	}
+
+	phandle = get_node_phandle(root, refnode);
+
+	assert(f->offset + sizeof(cell_t) <= prop->val.len);
+
+	*((cell_t *)(prop->val.val + f->offset)) = cpu_to_be32(phandle);
+}
+
+static void fixup_phandles(struct node *root, struct node *node)
+{
+	struct property *prop;
+	struct node *child;
+
+	for_each_property(node, prop) {
+		struct fixup *f = prop->val.refs;
+
+		while (f) {
+			apply_fixup(root, prop, f);
+			prop->val.refs = f->next;
+			fixup_free(f);
+			f = prop->val.refs;
+		}
+	}
+
+	for_each_child(node, child)
+		fixup_phandles(root, child);
+}
+
+void fixup_references(struct node *dt)
+{
+	fixup_phandles(dt, dt);
+}
+
+/*
+ * Semantic check functions
+ */
+
 static int must_be_one_cell(struct property *prop, struct node *node)
 {
 	if (prop->val.len != sizeof(cell_t)) {
@@ -315,82 +492,24 @@
 	{"device_type", must_be_string},
 };
 
-#define DO_ERR(...) do {ERRMSG(__VA_ARGS__); ok = 0; } while (0)
-
 static int check_properties(struct node *node)
 {
-	struct property *prop, *prop2;
+	struct property *prop;
+	struct node *child;
+	int i;
 	int ok = 1;
 
-	for_each_property(node, prop) {
-		int i;
-
-		/* check for duplicates */
-		/* FIXME: do this more efficiently */
-		for (prop2 = prop->next; prop2; prop2 = prop2->next) {
-			if (streq(prop->name, prop2->name)) {
-				DO_ERR("Duplicate propertyname %s in node %s\n",
-					prop->name, node->fullpath);
-			}
-		}
-
-		/* check name length */
-		if (strlen(prop->name) > MAX_PROPNAME_LEN)
-			WARNMSG("Property name %s is too long in %s\n",
-				prop->name, node->fullpath);
-
-		/* check this property */
-		for (i = 0; i < ARRAY_SIZE(prop_checker_table); i++) {
+	for_each_property(node, prop)
+		for (i = 0; i < ARRAY_SIZE(prop_checker_table); i++)
 			if (streq(prop->name, prop_checker_table[i].propname))
 				if (! prop_checker_table[i].check_fn(prop, node)) {
 					ok = 0;
 					break;
 				}
-		}
-	}
-
-	return ok;
-}
-
-static int check_node_name(struct node *node)
-{
-	int ok = 1;
-	int len = strlen(node->name);
-
-	if (len == 0 && node->parent)
-		DO_ERR("Empty, non-root nodename at %s\n", node->fullpath);
-
-	if (len > MAX_NODENAME_LEN)
-		DO_ERR("Overlength nodename at %s\n", node->fullpath);
-
-
-	return ok;
-}
 
-static int check_structure(struct node *tree)
-{
-	struct node *child, *child2;
-	int ok = 1;
-
-	if (! check_node_name(tree))
-		ok = 0;
-
-	if (! check_properties(tree))
-		ok = 0;
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
-		if (! check_structure(child))
+	for_each_child(node, child)
+		if (! check_properties(child))
 			ok = 0;
-	}
 
 	return ok;
 }
@@ -638,115 +757,12 @@
 	return ok;
 }
 
-static int check_phandles(struct node *root, struct node *node)
+int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys)
 {
-	struct property *prop;
-	struct node *child, *other;
-	cell_t phandle;
 	int ok = 1;
 
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
-static cell_t get_node_phandle(struct node *root, struct node *node)
-{
-	static cell_t phandle = 1; /* FIXME: ick, static local */
-
-	if ((node->phandle != 0) && (node->phandle != -1))
-		return node->phandle;
-
-	assert(! get_property(node, "linux,phandle"));
-
-	while (get_node_by_phandle(root, phandle))
-		phandle++;
-
-	node->phandle = phandle;
-	add_property(node,
-		     build_property("linux,phandle",
-				    data_append_cell(empty_data, phandle),
-				    NULL));
-
-	return node->phandle;
-}
-
-static void apply_fixup(struct node *root, struct property *prop,
-			struct fixup *f)
-{
-	struct node *refnode;
-	cell_t phandle;
-
-	if (f->ref[0] == '/') {
-		/* Reference to full path */
-		refnode = get_node_by_path(root, f->ref);
-		if (! refnode)
-			die("Reference to non-existent node \"%s\"\n", f->ref);
-	} else {
-		refnode = get_node_by_label(root, f->ref);
-		if (! refnode)
-			die("Reference to non-existent node label \"%s\"\n", f->ref);
-	}
-
-	phandle = get_node_phandle(root, refnode);
-
-	assert(f->offset + sizeof(cell_t) <= prop->val.len);
-
-	*((cell_t *)(prop->val.val + f->offset)) = cpu_to_be32(phandle);
-}
-
-static void fixup_phandles(struct node *root, struct node *node)
-{
-	struct property *prop;
-	struct node *child;
-
-	for_each_property(node, prop) {
-		struct fixup *f = prop->val.refs;
-
-		while (f) {
-			apply_fixup(root, prop, f);
-			prop->val.refs = f->next;
-			fixup_free(f);
-			f = prop->val.refs;
-		}
-	}
-
-	for_each_child(node, child)
-		fixup_phandles(root, child);
-}
-
-int check_device_tree(struct node *dt, int outversion, int boot_cpuid_phys)
-{
-	int ok = 1;
-
-	if (! check_structure(dt))
-		return 0;
-
+	ok = ok && check_properties(dt);
 	ok = ok && check_addr_size_reg(dt, -1, -1);
-	ok = ok && check_phandles(dt, dt);
-
-	fixup_phandles(dt, dt);
-
-	if (! ok)
-		return 0;
-
 	ok = ok && check_root(dt);
 	ok = ok && check_cpus(dt, outversion, boot_cpuid_phys);
 	ok = ok && check_memory(dt);
@@ -756,15 +772,3 @@
 
 	return 1;
 }
-
-struct boot_info *build_boot_info(struct reserve_info *reservelist,
-				  struct node *tree)
-{
-	struct boot_info *bi;
-
-	bi = xmalloc(sizeof(*bi));
-	bi->reservelist = reservelist;
-	bi->dt = tree;
-
-	return bi;
-}
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-10-18 16:30:21.000000000 +1000
+++ dtc/tests/run_tests.sh	2007-10-18 16:30:30.000000000 +1000
@@ -101,11 +101,11 @@
 }
 
 dtc_tests () {
-    run_test dtc.sh -f -I dts -O dtb -o dtc_tree1.test.dtb test_tree1.dts
+    run_test dtc.sh -I dts -O dtb -o dtc_tree1.test.dtb test_tree1.dts
     tree1_tests dtc_tree1.test.dtb
     tree1_tests_rw dtc_tree1.test.dtb
 
-    run_test dtc.sh -f -I dts -O dtb -o dtc_escapes.test.dtb escapes.dts
+    run_test dtc.sh -I dts -O dtb -o dtc_escapes.test.dtb escapes.dts
     run_test string_escapes dtc_escapes.test.dtb
 }
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
