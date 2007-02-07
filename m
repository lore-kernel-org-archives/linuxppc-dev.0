Return-Path: <dgibson@ozlabs.org>
Date: Wed, 7 Feb 2007 14:29:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: [dtc] Allow references to labels
Message-ID: <20070207032907.GE23870@localhost.localdomain>
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

dtc allows nodes to have labels, which at present are just re-emitted
as symbols at the appropriate places when using asm-mode output.  It
also allows "references" where the notation &/path/to/node in a cell
list will be replaced with the phandle of the referenced node.

This patch extends the reference syntax to allow references to labels
instead of just full device paths.  This allows nodes deep within the
tree to be referenced with a shorter more convenient name.  References
to labels are distinguished from reference to paths by the fact that
paths must start with a /, but labels can never start with a /.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: dtc/livetree.c
===================================================================
--- dtc.orig/livetree.c	2007-01-31 16:05:59.000000000 +1100
+++ dtc/livetree.c	2007-01-31 16:13:00.000000000 +1100
@@ -212,6 +212,24 @@ static struct node *get_node_by_path(str
 	return NULL;
 }
 
+static struct node *get_node_by_label(struct node *tree, const char *label)
+{
+	struct node *child, *node;
+
+	assert(label && (strlen(label) > 0));
+
+	if (tree->label && streq(tree->label, label))
+		return tree;
+
+	for_each_child(tree, child) {
+		node = get_node_by_label(child, label);
+		if (node)
+			return node;
+	}
+
+	return NULL;
+}
+
 static struct node *get_node_by_phandle(struct node *tree, cell_t phandle)
 {
 	struct node *child, *node;	
@@ -229,6 +247,7 @@ static struct node *get_node_by_phandle(
 
 	return NULL;
 }
+
 /*
  * Tree checking functions
  */
@@ -673,9 +692,16 @@ static void apply_fixup(struct node *roo
 	struct node *refnode;
 	cell_t phandle;
 
-	refnode = get_node_by_path(root, f->ref);
-	if (! refnode)
-		die("Reference to non-existent node \"%s\"\n", f->ref);
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
 
 	phandle = get_node_phandle(root, refnode);
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
