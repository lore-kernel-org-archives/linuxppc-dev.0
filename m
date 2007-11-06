Return-Path: <dgibson@ozlabs.org>
Date: Wed, 7 Nov 2007 10:22:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: [2/2] dtc: Make -Idts -Odts preserve property-internal labels
Message-ID: <20071106232225.GI31367@localhost.localdomain>
References: <20071106232120.GH31367@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071106232120.GH31367@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch changes -Odts mode output so that labels within property
values in the input are preserved in the output.  Applied on top of
the earlier patch to preserve node and property labels in -Odts mode,
this means that dtc in -Idts -Odts mode will transfer all labels in
the input to the output.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 tests/label01.dts |    7 +++--
 treesource.c      |   66 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 65 insertions(+), 8 deletions(-)

Index: dtc/treesource.c
===================================================================
--- dtc.orig/treesource.c	2007-11-07 10:19:13.000000000 +1100
+++ dtc/treesource.c	2007-11-07 10:19:42.000000000 +1100
@@ -60,13 +60,24 @@
 {
 	char *str = val.val;
 	int i;
+	int newchunk = 1;
+	struct fixup *l = val.labels;
 
 	assert(str[val.len-1] == '\0');
 
-	fprintf(f, "\"");
 	for (i = 0; i < (val.len-1); i++) {
 		char c = str[i];
 
+		if (newchunk) {
+			while (l && (l->offset <= i)) {
+				assert(l->offset == i);
+				fprintf(f, "%s: ", l->ref);
+				l = l->next;
+			}
+			fprintf(f, "\"");
+			newchunk = 0;
+		}
+
 		switch (c) {
 		case '\a':
 			fprintf(f, "\\a");
@@ -96,7 +107,8 @@
 			fprintf(f, "\\\"");
 			break;
 		case '\0':
-			fprintf(f, "\", \"");
+			fprintf(f, "\", ");
+			newchunk = 1;
 			break;
 		default:
 			if (isprint(c))
@@ -106,20 +118,41 @@
 		}
 	}
 	fprintf(f, "\"");
+
+	/* Wrap up any labels at the end of the value */
+	while (l) {
+		assert (l->offset == val.len);
+		fprintf(f, " %s:", l->ref);
+		l = l->next;
+	}
 }
 
 static void write_propval_cells(FILE *f, struct data val)
 {
 	void *propend = val.val + val.len;
 	cell_t *cp = (cell_t *)val.val;
+	struct fixup *l = val.labels;
 
 	fprintf(f, "<");
 	for (;;) {
+		while (l && (l->offset <= ((char *)cp - val.val))) {
+			assert(l->offset == ((char *)cp - val.val));
+			fprintf(f, "%s: ", l->ref);
+			l = l->next;
+		}
+
 		fprintf(f, "%x", be32_to_cpu(*cp++));
 		if ((void *)cp >= propend)
 			break;
 		fprintf(f, " ");
 	}
+
+	/* Wrap up any labels at the end of the value */
+	while (l) {
+		assert (l->offset == val.len);
+		fprintf(f, " %s:", l->ref);
+		l = l->next;
+	}
 	fprintf(f, ">");
 }
 
@@ -127,14 +160,27 @@
 {
 	void *propend = val.val + val.len;
 	char *bp = val.val;
+	struct fixup *l = val.labels;
 
 	fprintf(f, "[");
 	for (;;) {
+		while (l && (l->offset == (bp-val.val))) {
+			fprintf(f, "%s: ", l->ref);
+			l = l->next;
+		}
+
 		fprintf(f, "%02hhx", *bp++);
 		if ((void *)bp >= propend)
 			break;
 		fprintf(f, " ");
 	}
+
+	/* Wrap up any labels at the end of the value */
+	while (l) {
+		assert (l->offset == val.len);
+		fprintf(f, " %s:", l->ref);
+		l = l->next;
+	}
 	fprintf(f, "]");
 }
 
@@ -142,7 +188,9 @@
 {
 	int len = prop->val.len;
 	char *p = prop->val.val;
+	struct fixup *l;
 	int nnotstring = 0, nnul = 0;
+	int nnotstringlbl = 0, nnotcelllbl = 0;
 	int i;
 
 	if (len == 0) {
@@ -157,15 +205,23 @@
 			nnul++;
 	}
 
-	fprintf(f, " = ");
+	for (l = prop->val.labels; l; l = l->next) {
+		if ((l->offset > 0) && (prop->val.val[l->offset - 1] != '\0'))
+			nnotstringlbl++;
+		if ((l->offset % sizeof(cell_t)) != 0)
+			nnotcelllbl++;
+	}
 
-	if ((p[len-1] == '\0') && (nnotstring == 0) && (nnul < (len-nnul))) {
+	fprintf(f, " = ");
+	if ((p[len-1] == '\0') && (nnotstring == 0) && (nnul < (len-nnul))
+	    && (nnotstringlbl == 0)) {
 		write_propval_string(f, prop->val);
-	} else if (((len % sizeof(cell_t)) == 0)) {
+	} else if (((len % sizeof(cell_t)) == 0) && (nnotcelllbl == 0)) {
 		write_propval_cells(f, prop->val);
 	} else {
 		write_propval_bytes(f, prop->val);
 	}
+
 	fprintf(f, ";\n");
 }
 
Index: dtc/tests/label01.dts
===================================================================
--- dtc.orig/tests/label01.dts	2007-11-07 09:55:03.000000000 +1100
+++ dtc/tests/label01.dts	2007-11-07 10:19:42.000000000 +1100
@@ -36,10 +36,11 @@
 	};
 
 	node: randomnode {
-		prop: string = data: "\xff\0stuffstuff\t\t\t\n\n\n" data_end: ;
-		blob = [byte: 0a 0b 0c 0d de ea ad be ef byte_end: ];
-		ref = < cell: &/memory@0 cell_end: >;
+		prop: string = str: "foo", str_mid: "stuffstuff\t\t\t\n\n\n" str_end: ;
+		blob = [byte: 0a 0b 0c 0d byte_mid: de ea ad be ef byte_end: ];
+		ref = < cell: &/memory@0 0 cell_mid: ffffffff cell_end: >;
 		mixed = "abc", pre: [1234] post: , gap: < aligned: a b c>;
+		tricky1 = [61 lt1: 62 63 00];
 		subnode: child {
 		};
 		/* subnode_end: is auto-generated by node emit */

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
