Return-Path: <dgibson@ozlabs.org>
Date: Wed, 17 Oct 2007 12:39:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Improve -Odts output
Message-ID: <20071017023910.GH28260@localhost.localdomain>
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

This patch makes improvements to the way properties are printed when
in dtc is producing dts output.  
	- Characters which need escaping are now properly handled when
printing properties as strings
	- The heuristics for what format to use for a property are
improved so that 'compatible' properties will be displayed as
expected.
	- escapes.dts is altered to better demonstrate the changes,
and the string_escapes testcase is adjusted accordingly.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/treesource.c
===================================================================
--- dtc.orig/treesource.c	2007-10-17 10:27:35.000000000 +1000
+++ dtc/treesource.c	2007-10-17 11:43:18.000000000 +1000
@@ -56,22 +56,31 @@
 	PROP_BYTES,
 };
 
+int isstring(char c)
+{
+	return (isprint(c)
+		|| (c == '\0')
+		|| strchr("\a\b\t\n\v\f\r", c));
+}
+
 static enum proptype guess_type(struct property *prop)
 {
 	int len = prop->val.len;
 	char *p = prop->val.val;
-	int nnoprint = 0;
+	int nnotstring = 0, nnul = 0;
 	int i;
 
 	if (len == 0)
 		return PROP_EMPTY;
 
 	for (i = 0; i < len; i++) {
-		if (! isprint(p[i]))
-			nnoprint++;
+		if (! isstring(p[i]))
+			nnotstring++;
+		if (p[i] == '\0')
+			nnul++;
 	}
 
-	if ((nnoprint == 1) && (p[len-1] == '\0'))
+	if ((p[len-1] == '\0') && (nnotstring == 0) && (nnul < (len-nnul)))
 		return PROP_STRING;
 	else if ((len % sizeof(cell_t)) == 0)
 		return PROP_CELLS;
@@ -79,6 +88,87 @@
 		return PROP_BYTES;
 }
 
+static void write_propval_string(FILE *f, struct data val)
+{
+	char *str = val.val;
+	int i;
+
+	assert(str[val.len-1] == '\0');
+
+	fprintf(f, " = \"");
+	for (i = 0; i < (val.len-1); i++) {
+		char c = str[i];
+
+		switch (c) {
+		case '\a':
+			fprintf(f, "\\a");
+			break;
+		case '\b':
+			fprintf(f, "\\b");
+			break;
+		case '\t':
+			fprintf(f, "\\t");
+			break;
+		case '\n':
+			fprintf(f, "\\n");
+			break;
+		case '\v':
+			fprintf(f, "\\v");
+			break;
+		case '\f':
+			fprintf(f, "\\f");
+			break;
+		case '\r':
+			fprintf(f, "\\r");
+			break;
+		case '\\':
+			fprintf(f, "\\\\");
+			break;
+		case '\"':
+			fprintf(f, "\\\"");
+			break;
+		case '\0':
+			fprintf(f, "\", \"");
+			break;
+		default:
+			if (isprint(c))
+				fprintf(f, "%c", c);
+			else
+				fprintf(f, "\\x%02hhx", c);
+		}
+	}
+	fprintf(f, "\";\n");
+}
+
+static void write_propval_cells(FILE *f, struct data val)
+{
+	void *propend = val.val + val.len;
+	cell_t *cp = (cell_t *)val.val;
+
+	fprintf(f, " = <");
+	for (;;) {
+		fprintf(f, "%x", be32_to_cpu(*cp++));
+		if ((void *)cp >= propend)
+			break;
+		fprintf(f, " ");
+	}
+	fprintf(f, ">;\n");
+}
+
+static void write_propval_bytes(FILE *f, struct data val)
+{
+	void *propend = val.val + val.len;
+	char *bp = val.val;
+
+	fprintf(f, " = [");
+	for (;;) {
+		fprintf(f, "%02hhx", *bp++);
+		if ((void *)bp >= propend)
+			break;
+		fprintf(f, " ");
+	}
+	fprintf(f, "];\n");
+}
 
 static void write_tree_source_node(FILE *f, struct node *tree, int level)
 {
@@ -92,15 +182,11 @@
 		fprintf(f, "/ {\n");
 
 	for_each_property(tree, prop) {
-		cell_t *cp;
-		char *bp;
-		void *propend;
 		enum proptype type;
 
 		write_prefix(f, level);
 		fprintf(f, "\t%s", prop->name);
 		type = guess_type(prop);
-		propend = prop->val.val + prop->val.len;
 
 		switch (type) {
 		case PROP_EMPTY:
@@ -108,31 +194,15 @@
 			break;
 
 		case PROP_STRING:
-			fprintf(f, " = \"%s\";\n", (char *)prop->val.val);
+			write_propval_string(f, prop->val);
 			break;
 
 		case PROP_CELLS:
-			fprintf(f, " = <");
-			cp = (cell_t *)prop->val.val;
-			for (;;) {
-				fprintf(f, "%x", be32_to_cpu(*cp++));
-				if ((void *)cp >= propend)
-					break;
-				fprintf(f, " ");
-			}
-			fprintf(f, ">;\n");
+			write_propval_cells(f, prop->val);
 			break;
 
 		case PROP_BYTES:
-			fprintf(f, " = [");
-			bp = prop->val.val;
-			for (;;) {
-				fprintf(f, "%02hhx", *bp++);
-				if ((void *)bp >= propend)
-					break;
-				fprintf(f, " ");
-			}
-			fprintf(f, "];\n");
+			write_propval_bytes(f, prop->val);
 			break;
 		}
 	}
Index: dtc/tests/escapes.dts
===================================================================
--- dtc.orig/tests/escapes.dts	2007-10-17 11:36:37.000000000 +1000
+++ dtc/tests/escapes.dts	2007-10-17 12:32:27.000000000 +1000
@@ -1,4 +1,5 @@
 / {
 	compatible = "test_string_escapes";
-	escape-str = "nastystring: \a\b\t\n\v\f\r\\\"\xff";
+	escape-str = "nastystring: \a\b\t\n\v\f\r\\\"";
+	escape-str-2 = "\xde\xad\xbe\xef";
 };
Index: dtc/tests/string_escapes.c
===================================================================
--- dtc.orig/tests/string_escapes.c	2007-10-17 12:31:56.000000000 +1000
+++ dtc/tests/string_escapes.c	2007-10-17 12:32:04.000000000 +1000
@@ -37,6 +37,8 @@
 
 	check_getprop(fdt, 0, "escape-str",
 		      strlen(TEST_STRING_2)+1, TEST_STRING_2);
+	check_getprop(fdt, 0, "escape-str-2",
+		      strlen(TEST_STRING_3)+1, TEST_STRING_3);
 
 	PASS();
 }
Index: dtc/tests/testdata.h
===================================================================
--- dtc.orig/tests/testdata.h	2007-10-17 12:28:50.000000000 +1000
+++ dtc/tests/testdata.h	2007-10-17 12:31:45.000000000 +1000
@@ -24,7 +24,8 @@
 #define TEST_VALUE_2	cell_to_fdt(0xabcd1234)
 
 #define TEST_STRING_1	"hello world"
-#define TEST_STRING_2	"nastystring: \a\b\t\n\v\f\r\\\"\xff"
+#define TEST_STRING_2	"nastystring: \a\b\t\n\v\f\r\\\""
+#define TEST_STRING_3	"\xde\xad\xbe\xef"
 
 #ifndef __ASSEMBLY__
 extern struct fdt_header _test_tree1;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
