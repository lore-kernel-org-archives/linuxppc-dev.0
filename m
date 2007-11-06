Return-Path: <dgibson@ozlabs.org>
Date: Wed, 7 Nov 2007 10:21:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: [1/2] dtc: Refactor printing of property values in -Odts mode
Message-ID: <20071106232120.GH31367@localhost.localdomain>
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

Currently the main recursive tree printing function,
write_tree_source_node(), calls guess_type() to apply heuristics to
see how to print a property value, then calls the appropriate
write_propval_*() function to print it.

However, future heuristics for handling internal labels and the like
don't work well this way.  Therefore, this patch refactors things to
have write_tree_source_node() call a new write_propval() function,
which incorporates the heurstic logic from guess_type() and also calls
the right function to do the actual printing.

No behavioural change.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 treesource.c |   97 +++++++++++++++++++++++------------------------------------
 1 file changed, 38 insertions(+), 59 deletions(-)

Index: dtc/treesource.c
===================================================================
--- dtc.orig/treesource.c	2007-11-07 09:55:03.000000000 +1100
+++ dtc/treesource.c	2007-11-07 10:19:13.000000000 +1100
@@ -49,13 +49,6 @@
 		fputc('\t', f);
 }
 
-enum proptype {
-	PROP_EMPTY,
-	PROP_STRING,
-	PROP_CELLS,
-	PROP_BYTES,
-};
-
 int isstring(char c)
 {
 	return (isprint(c)
@@ -63,31 +56,6 @@
 		|| strchr("\a\b\t\n\v\f\r", c));
 }
 
-static enum proptype guess_type(struct property *prop)
-{
-	int len = prop->val.len;
-	char *p = prop->val.val;
-	int nnotstring = 0, nnul = 0;
-	int i;
-
-	if (len == 0)
-		return PROP_EMPTY;
-
-	for (i = 0; i < len; i++) {
-		if (! isstring(p[i]))
-			nnotstring++;
-		if (p[i] == '\0')
-			nnul++;
-	}
-
-	if ((p[len-1] == '\0') && (nnotstring == 0) && (nnul < (len-nnul)))
-		return PROP_STRING;
-	else if ((len % sizeof(cell_t)) == 0)
-		return PROP_CELLS;
-	else
-		return PROP_BYTES;
-}
-
 static void write_propval_string(FILE *f, struct data val)
 {
 	char *str = val.val;
@@ -95,7 +63,7 @@
 
 	assert(str[val.len-1] == '\0');
 
-	fprintf(f, " = \"");
+	fprintf(f, "\"");
 	for (i = 0; i < (val.len-1); i++) {
 		char c = str[i];
 
@@ -137,7 +105,7 @@
 				fprintf(f, "\\x%02hhx", c);
 		}
 	}
-	fprintf(f, "\";\n");
+	fprintf(f, "\"");
 }
 
 static void write_propval_cells(FILE *f, struct data val)
@@ -145,14 +113,14 @@
 	void *propend = val.val + val.len;
 	cell_t *cp = (cell_t *)val.val;
 
-	fprintf(f, " = <");
+	fprintf(f, "<");
 	for (;;) {
 		fprintf(f, "%x", be32_to_cpu(*cp++));
 		if ((void *)cp >= propend)
 			break;
 		fprintf(f, " ");
 	}
-	fprintf(f, ">;\n");
+	fprintf(f, ">");
 }
 
 static void write_propval_bytes(FILE *f, struct data val)
@@ -160,14 +128,45 @@
 	void *propend = val.val + val.len;
 	char *bp = val.val;
 
-	fprintf(f, " = [");
+	fprintf(f, "[");
 	for (;;) {
 		fprintf(f, "%02hhx", *bp++);
 		if ((void *)bp >= propend)
 			break;
 		fprintf(f, " ");
 	}
-	fprintf(f, "];\n");
+	fprintf(f, "]");
+}
+
+static void write_propval(FILE *f, struct property *prop)
+{
+	int len = prop->val.len;
+	char *p = prop->val.val;
+	int nnotstring = 0, nnul = 0;
+	int i;
+
+	if (len == 0) {
+		fprintf(f, ";\n");
+		return;
+	}
+
+	for (i = 0; i < len; i++) {
+		if (! isstring(p[i]))
+			nnotstring++;
+		if (p[i] == '\0')
+			nnul++;
+	}
+
+	fprintf(f, " = ");
+
+	if ((p[len-1] == '\0') && (nnotstring == 0) && (nnul < (len-nnul))) {
+		write_propval_string(f, prop->val);
+	} else if (((len % sizeof(cell_t)) == 0)) {
+		write_propval_cells(f, prop->val);
+	} else {
+		write_propval_bytes(f, prop->val);
+	}
+	fprintf(f, ";\n");
 }
 
 static void write_tree_source_node(FILE *f, struct node *tree, int level)
@@ -184,31 +183,11 @@
 		fprintf(f, "/ {\n");
 
 	for_each_property(tree, prop) {
-		enum proptype type;
-
 		write_prefix(f, level+1);
 		if (prop->label)
 			fprintf(f, "%s: ", prop->label);
 		fprintf(f, "%s", prop->name);
-		type = guess_type(prop);
-
-		switch (type) {
-		case PROP_EMPTY:
-			fprintf(f, ";\n");
-			break;
-
-		case PROP_STRING:
-			write_propval_string(f, prop->val);
-			break;
-
-		case PROP_CELLS:
-			write_propval_cells(f, prop->val);
-			break;
-
-		case PROP_BYTES:
-			write_propval_bytes(f, prop->val);
-			break;
-		}
+		write_propval(f, prop);
 	}
 	for_each_child(tree, child) {
 		fprintf(f, "\n");

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
