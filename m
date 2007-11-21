Return-Path: <dgibson@ozlabs.org>
Date: Wed, 21 Nov 2007 16:38:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Flexible tree checking infrastructure
Message-ID: <20071121053851.GA17801@localhost.localdomain>
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

Here, at last, is a substantial start on revising dtc's infrastructure
for checking the tree; this is the rework I've been saying was
necessary practically since dtc was first release.

In the new model, we have a table of "check" structures, each with a
name, references to checking functions, and status variables.  Each
check can (in principle) be individually switched off or on (as either
a warning or error).  Checks have a list of prerequisites, so if
checks need to rely on results from earlier checks to make sense (or
even to avoid crashing) they just need to list the relevant other
checks there.

For now, only the "structural" checks and the fixups for phandle
references are converted to the new mechanism.  The rather more
involved semantic checks (which is where this new mechanism will
really be useful) will have to be converted in future patches.

At present, there's no user interface for turning on/off the checks -
the -f option now forces output even if "error" level checks fail.
Again, future patches will be needed to add the fine-grained control,
but that should be quite straightforward with the infrastructure
implemented here.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/checks.c
===================================================================
--- dtc.orig/checks.c	2007-11-21 12:27:13.000000000 +1100
+++ dtc/checks.c	2007-11-21 16:28:08.000000000 +1100
@@ -20,104 +20,281 @@
 
 #include "dtc.h"
 
-/*
- * Structural check functions
- */
+enum checklevel {
+	IGNORE = 0,
+	WARN = 1,
+	ERROR = 2,
+};
 
-#define ERRMSG(...) if (quiet < 2) fprintf(stderr, "ERROR: " __VA_ARGS__)
-#define WARNMSG(...) if (quiet < 1) fprintf(stderr, "Warning: " __VA_ARGS__)
+enum checkstatus {
+	UNCHECKED = 0,
+	PREREQ,
+	PASSED,
+	FAILED,
+};
 
-#define DO_ERR(...) do {ERRMSG(__VA_ARGS__); ok = 0; } while (0)
+struct check;
+
+typedef void (*tree_check_fn)(struct check *c, struct node *dt);
+typedef void (*node_check_fn)(struct check *c, struct node *dt, struct node *node);
+typedef void (*prop_check_fn)(struct check *c, struct node *dt,
+			      struct node *node, struct property *prop);
+
+struct check {
+	const char *name;
+	tree_check_fn tree_fn;
+	node_check_fn node_fn;
+	prop_check_fn prop_fn;
+	void *data;
+	enum checklevel level;
+	enum checkstatus status;
+	int inprogress;
+	int num_prereqs;
+	struct check **prereq;
+};
 
-static int check_names(struct node *tree)
+#define CHECK(nm, tfn, nfn, pfn, d, lvl, ...) \
+	static struct check *nm##_prereqs[] = { __VA_ARGS__ }; \
+	static struct check nm = { \
+		.name = #nm, \
+		.tree_fn = (tfn), \
+		.node_fn = (nfn), \
+		.prop_fn = (pfn), \
+		.data = (d), \
+		.level = (lvl), \
+		.status = UNCHECKED, \
+		.num_prereqs = ARRAY_SIZE(nm##_prereqs), \
+		.prereq = nm##_prereqs, \
+	};
+
+#define TREE_CHECK(nm, d, lvl, ...) \
+	CHECK(nm, check_##nm, NULL, NULL, d, lvl, __VA_ARGS__)
+#define NODE_CHECK(nm, d, lvl, ...) \
+	CHECK(nm, NULL, check_##nm, NULL, d, lvl, __VA_ARGS__)
+#define PROP_CHECK(nm, d, lvl, ...) \
+	CHECK(nm, NULL, NULL, check_##nm, d, lvl, __VA_ARGS__)
+#define BATCH_CHECK(nm, lvl, ...) \
+	CHECK(nm, NULL, NULL, NULL, NULL, lvl, __VA_ARGS__)
+
+#define CHECKMSG(c, fmt, ...) \
+	do { \
+		if (quiet < (c)->level) \
+			; /* Suppress message */ \
+		else if ((c)->level == ERROR) \
+			fprintf(stderr, "ERROR (%s): " fmt "\n", \
+				(c)->name, __VA_ARGS__); \
+		else if ((c)->level == WARN) \
+			fprintf(stderr, "Warning (%s): " fmt "\n", \
+				(c)->name, __VA_ARGS__); \
+	} while (0)
+
+#define FAIL(c, fmt, ...) \
+	do { \
+		(c)->status = FAILED; \
+		CHECKMSG((c), fmt, __VA_ARGS__); \
+	} while (0)
+
+static void check_nodes_props(struct check *c, struct node *dt, struct node *node)
 {
-	struct node *child, *child2;
-	struct property *prop, *prop2;
-	int len = strlen(tree->name);
-	int ok = 1;
+	struct node *child;
+	struct property *prop;
 
-	if (len == 0 && tree->parent)
-		DO_ERR("Empty, non-root nodename at %s\n", tree->fullpath);
+	if (c->node_fn)
+		c->node_fn(c, dt, node);
 
-	if (len > MAX_NODENAME_LEN)
-		WARNMSG("Overlength nodename at %s\n", tree->fullpath);
+	if (c->prop_fn)
+		for_each_property(node, prop)
+			c->prop_fn(c, dt, node, prop);
 
-	for_each_property(tree, prop) {
-		/* check for duplicates */
-		/* FIXME: do this more efficiently */
-		for (prop2 = prop->next; prop2; prop2 = prop2->next) {
-			if (streq(prop->name, prop2->name)) {
-				DO_ERR("Duplicate propertyname %s in node %s\n",
-					prop->name, tree->fullpath);
-			}
-		}
+	for_each_child(node, child)
+		check_nodes_props(c, dt, child);
+}
+
+static int run_check(struct check *c, struct node *dt)
+{
+	int error = 0;
+	int i;
+
+	assert(!c->inprogress);
 
-		/* check name length */
-		if (strlen(prop->name) > MAX_PROPNAME_LEN)
-			WARNMSG("Property name %s is too long in %s\n",
-				prop->name, tree->fullpath);
+	if (c->status != UNCHECKED)
+		goto out;
+
+	c->inprogress = 1;
+
+	for (i = 0; i < c->num_prereqs; i++) {
+		struct check *prq = c->prereq[i];
+		error |= run_check(prq, dt);
+		if (prq->status != PASSED) {
+			c->status = PREREQ;
+			CHECKMSG(c, "Failed prerequisite '%s'",
+				 c->prereq[i]->name);
+		}
 	}
 
-	for_each_child(tree, child) {
-		/* Check for duplicates */
+	if (c->status != UNCHECKED)
+		goto out;
+
+	if (c->node_fn || c->prop_fn)
+		check_nodes_props(c, dt, dt);
+
+	if (c->tree_fn)
+		c->tree_fn(c, dt);
+	if (c->status == UNCHECKED)
+		c->status = PASSED;
+
+out:
+	c->inprogress = 0;
+	if ((c->status != PASSED) && (c->level == ERROR))
+		error = 1;
+	return error;
+}
+
+/*
+ * Structural check functions
+ */
+
+static void check_duplicate_node_names(struct check *c, struct node *dt,
+				       struct node *node)
+{
+	struct node *child, *child2;
 
+	for_each_child(node, child)
 		for (child2 = child->next_sibling;
 		     child2;
-		     child2 = child2->next_sibling) {
+		     child2 = child2->next_sibling)
 			if (streq(child->name, child2->name))
-				DO_ERR("Duplicate node name %s\n",
-					child->fullpath);
-		}
-		if (! check_names(child))
-			ok = 0;
-	}
+				FAIL(c, "Duplicate node name %s",
+				     child->fullpath);
+}
+NODE_CHECK(duplicate_node_names, NULL, ERROR);
 
-	return ok;
+static void check_duplicate_property_names(struct check *c, struct node *dt,
+					   struct node *node)
+{
+	struct property *prop, *prop2;
+
+	for_each_property(node, prop)
+		for (prop2 = prop->next; prop2; prop2 = prop2->next)
+			if (streq(prop->name, prop2->name))
+				FAIL(c, "Duplicate property name %s in %s",
+				     prop->name, node->fullpath);
 }
+NODE_CHECK(duplicate_property_names, NULL, ERROR);
 
-static int check_phandles(struct node *root, struct node *node)
+static void check_explicit_phandles(struct check *c, struct node *root,
+					  struct node *node)
 {
 	struct property *prop;
-	struct node *child, *other;
+	struct node *other;
 	cell_t phandle;
-	int ok = 1;
 
 	prop = get_property(node, "linux,phandle");
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
+	if (! prop)
+		return; /* No phandle, that's fine */
 
-			node->phandle = phandle;
-		}
+	if (prop->val.len != sizeof(cell_t)) {
+		FAIL(c, "%s has bad length (%d) linux,phandle property",
+		     node->fullpath, prop->val.len);
+		return;
 	}
 
-	for_each_child(node, child)
-		ok = ok && check_phandles(root, child);
+	phandle = propval_cell(prop);
+	if ((phandle == 0) || (phandle == -1)) {
+		FAIL(c, "%s has invalid linux,phandle value 0x%x",
+		     node->fullpath, phandle);
+		return;
+	}
 
-	return ok;
+	other = get_node_by_phandle(root, phandle);
+	if (other) {
+		FAIL(c, "%s has duplicated phandle 0x%x (seen before at %s)",
+		     node->fullpath, phandle, other->fullpath);
+		return;
+	}
+
+	node->phandle = phandle;
 }
+NODE_CHECK(explicit_phandles, NULL, ERROR);
+
+/*
+ * Reference fixup functions
+ */
 
-int check_structure(struct node *dt)
+static void fixup_references(struct check *c, struct node *dt,
+			     struct node *node, struct property *prop)
 {
-	int ok = 1;
+      struct fixup *f = prop->val.refs;
+      struct node *refnode;
+      cell_t phandle;
+
+      while (f) {
+	      if (f->ref[0] == '/') {
+		      /* Reference to full path */
+		      refnode = get_node_by_path(dt, f->ref);
+		      if (! refnode)
+			      FAIL(c, "Reference to non-existent node \"%s\"\n",
+				   f->ref);
+	      } else {
+		      refnode = get_node_by_label(dt, f->ref);
+		      if (! refnode)
+			      FAIL(c, "Reference to non-existent node label \"%s\"\n",
+				   f->ref);
+	      }
+
+	      phandle = get_node_phandle(dt, refnode);
+
+	      assert(f->offset + sizeof(cell_t) <= prop->val.len);
+
+	      *((cell_t *)(prop->val.val + f->offset)) = cpu_to_be32(phandle);
+
+              prop->val.refs = f->next;
+              fixup_free(f);
+              f = prop->val.refs;
+      }
+}
+CHECK(references, NULL, NULL, fixup_references, NULL, ERROR,
+      &duplicate_node_names, &explicit_phandles);
+
+static struct check *check_table[] = {
+	&duplicate_node_names, &duplicate_property_names,
+	&explicit_phandles,
+	&references,
+};
 
-	ok = ok && check_names(dt);
-	ok = ok && check_phandles(dt, dt);
+void process_checks(int force, struct node *dt)
+{
+	int i;
+	int error = 0;
 
-	return ok;
+	for (i = 0; i < ARRAY_SIZE(check_table); i++) {
+		struct check *c = check_table[i];
+
+		if (c->level != IGNORE)
+			error = error || run_check(c, dt);
+	}
+
+	if (error) {
+		if (!force) {
+			fprintf(stderr, "ERROR: Input tree has errors, aborting "
+				"(use -f to force output)\n");
+			exit(2);
+		} else if (quiet < 3) {
+			fprintf(stderr, "Warning: Input tree has errors, "
+				"output forced\n");
+		}
+	}
 }
 
 /*
  * Semantic check functions
  */
 
+#define ERRMSG(...) if (quiet < 2) fprintf(stderr, "ERROR: " __VA_ARGS__)
+#define WARNMSG(...) if (quiet < 1) fprintf(stderr, "Warning: " __VA_ARGS__)
+
+#define DO_ERR(...) do {ERRMSG(__VA_ARGS__); ok = 0; } while (0)
+
 static int must_be_one_cell(struct property *prop, struct node *node)
 {
 	if (prop->val.len != sizeof(cell_t)) {
Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c	2007-11-21 12:27:13.000000000 +1100
+++ dtc/dtc.c	2007-11-21 16:27:16.000000000 +1100
@@ -193,17 +193,7 @@ int main(int argc, char *argv[])
 	if (! bi || ! bi->dt)
 		die("Couldn't read input tree\n");
 
-	structure_ok = check_structure(bi->dt);
-	if (!structure_ok) {
-		if (!force) {
-			fprintf(stderr, "ERROR: Input tree has structural errors, aborting (use -f to force output)\n");
-			exit(2);
-		} else if (quiet < 3) {
-			fprintf(stderr, "Warning: Input tree has structural errors, output forced\n");
-		}
-	}
-
-	fixup_references(bi->dt);
+	process_checks(force, bi->dt);
 
 	if (check) {
 		if (!structure_ok) {
Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2007-11-21 12:27:13.000000000 +1100
+++ dtc/dtc.h	2007-11-21 16:27:16.000000000 +1100
@@ -193,9 +193,10 @@ char *get_unitname(struct node *node);
 struct property *get_property(struct node *node, char *propname);
 cell_t propval_cell(struct property *prop);
 struct node *get_subnode(struct node *node, char *nodename);
+struct node *get_node_by_path(struct node *tree, char *path);
+struct node *get_node_by_label(struct node *tree, const char *label);
 struct node *get_node_by_phandle(struct node *tree, cell_t phandle);
-
-void fixup_references(struct node *dt);
+cell_t get_node_phandle(struct node *root, struct node *node);
 
 /* Boot info (tree plus memreserve information */
 
@@ -224,7 +225,7 @@ struct boot_info *build_boot_info(struct
 
 /* Checks */
 
-int check_structure(struct node *dt);
+void process_checks(int force, struct node *dt);
 int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys);
 
 /* Flattened trees */
Index: dtc/livetree.c
===================================================================
--- dtc.orig/livetree.c	2007-11-21 16:27:09.000000000 +1100
+++ dtc/livetree.c	2007-11-21 16:27:16.000000000 +1100
@@ -216,7 +216,7 @@ struct node *get_subnode(struct node *no
 	return NULL;
 }
 
-static struct node *get_node_by_path(struct node *tree, char *path)
+struct node *get_node_by_path(struct node *tree, char *path)
 {
 	char *p;
 	struct node *child;
@@ -239,7 +239,7 @@ static struct node *get_node_by_path(str
 	return NULL;
 }
 
-static struct node *get_node_by_label(struct node *tree, const char *label)
+struct node *get_node_by_label(struct node *tree, const char *label)
 {
 	struct node *child, *node;
 
@@ -275,7 +275,7 @@ struct node *get_node_by_phandle(struct 
 	return NULL;
 }
 
-static cell_t get_node_phandle(struct node *root, struct node *node)
+cell_t get_node_phandle(struct node *root, struct node *node)
 {
 	static cell_t phandle = 1; /* FIXME: ick, static local */
 
@@ -295,56 +295,3 @@ static cell_t get_node_phandle(struct no
 
 	return node->phandle;
 }
-
-/*
- * Reference fixup functions
- */
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
-void fixup_references(struct node *dt)
-{
-	fixup_phandles(dt, dt);
-}

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
