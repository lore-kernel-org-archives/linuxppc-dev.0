Return-Path: <miltonm@sullivan.realtime.net>
Date: Sat, 7 Jul 2007 01:18:51 -0500 (CDT)
Subject: [PATCH 07/11] dtc: implement labels on property data
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Jon Loeliger <jdl@jdl.com>
Message-Id: <dtc-5-07.miltonm@bga.com>
In-Reply-To: <dtc-5-00.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Extend the parser grammer to allow labels before or after any
property data (string, cell list, or byte list), and any
byte or cell within the property data.

Store the labels using the same linked list structure as node
references using in a parallel list.  

When writing assembly output emit global labels as offsets from
the start of the definition of the data.

Note that the alignment for a cell list is done as part of the
opening < delimiter, not the = or , before it.  To label a cell
after a string or byte list put the label inside the cell list.

For example,
	prop = zero: [ aa bb ], two: < four: 1234 > eight: ;
will produce labels with offsets 0, 2, 4, and 8 bytes from
the beginning of the data for property prop. 

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
The testcase in the following patch will also note in the source
tree the gap between labels two and four above.

I took out the explcit list of fields in emtpy_data because it
would have required a third line to add the label field and all
fields were initialized to the default value.

Index: dtc/data.c
===================================================================
--- dtc.orig/data.c	2007-06-14 06:52:52.000000000 -0500
+++ dtc/data.c	2007-06-14 16:18:12.000000000 -0500
@@ -29,12 +29,17 @@ void fixup_free(struct fixup *f)
 
 void data_free(struct data d)
 {
-	struct fixup *f;
+	struct fixup *f, *nf;
 
 	f = d.refs;
 	while (f) {
-		struct fixup *nf;
+		nf = f->next;
+		fixup_free(f);
+		f = nf;
+	}
 
+	f = d.labels;
+	while (f) {
 		nf = f->next;
 		fixup_free(f);
 		f = nf;
@@ -198,27 +203,36 @@ struct data data_append_data(struct data
 	return d;
 }
 
-struct data data_merge(struct data d1, struct data d2)
+void fixup_merge(struct fixup **fd, struct fixup **fd2, int d1_len)
 {
-	struct data d;
 	struct fixup **ff;
 	struct fixup *f, *f2;
 
-	d = data_append_data(d1, d2.val, d2.len);
-
 	/* Extract d2's fixups */
-	f2 = d2.refs;
-	d2.refs = NULL;
+	f2 = *fd2;
+	*fd2 = NULL;
 
 	/* Tack them onto d's list of fixups */
-	ff = &d.refs;
+	ff = fd;
 	while (*ff)
 		ff = &((*ff)->next);
 	*ff = f2;
 
 	/* And correct them for their new position */
 	for (f = f2; f; f = f->next)
-		f->offset += d1.len;
+		f->offset += d1_len;
+
+
+}
+
+struct data data_merge(struct data d1, struct data d2)
+{
+	struct data d;
+
+	d = data_append_data(d1, d2.val, d2.len);
+
+	fixup_merge(&d.refs, &d2.refs, d1.len);
+	fixup_merge(&d.labels, &d2.labels, d1.len);
 
 	data_free(d2);
 
@@ -285,6 +299,22 @@ struct data data_add_fixup(struct data d
 	return nd;
 }
 
+struct data data_add_label(struct data d, char *label)
+{
+	struct fixup *f;
+	struct data nd;
+
+	f = xmalloc(sizeof(*f));
+	f->offset = d.len;
+	f->ref = label;
+	f->next = d.labels;
+
+	nd = d;
+	nd.labels = f;
+
+	return nd;
+}
+
 int data_is_one_string(struct data d)
 {
 	int i;
Index: dtc/dtc-parser.y
===================================================================
--- dtc.orig/dtc-parser.y	2007-06-14 06:52:52.000000000 -0500
+++ dtc/dtc-parser.y	2007-06-14 06:52:52.000000000 -0500
@@ -131,9 +131,11 @@ propdata:	propdataprefix DT_STRING { $$ 
 			$$ = data_merge(data_append_align($1, sizeof(cell_t)), $3);
 		}
 	|	propdataprefix '[' bytestring ']' { $$ = data_merge($1, $3); }
+	|	propdata DT_LABEL { $$ = data_add_label($1, $2); }
 	;
 
 propdataprefix:	propdata ',' { $$ = $1; }
+	|	propdataprefix DT_LABEL { $$ = data_add_label($1, $2); }
 	|	/* empty */ { $$ = empty_data; }
 	;
 
@@ -150,10 +152,12 @@ celllist:	celllist opt_cell_base DT_CELL
 	|	celllist DT_REF	{
 			$$ = data_append_cell(data_add_fixup($1, $2), -1);
 		}
+	|	celllist DT_LABEL { $$ = data_add_label($1, $2); }
 	|	/* empty */ { $$ = empty_data; }
 	;
 
 bytestring:	bytestring DT_BYTE { $$ = data_append_byte($1, $2); }
+	|	bytestring DT_LABEL { $$ = data_add_label($1, $2); }
 	|	/* empty */ { $$ = empty_data; }
 	;
 
Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2007-06-14 06:52:17.000000000 -0500
+++ dtc/dtc.h	2007-06-14 16:59:49.000000000 -0500
@@ -111,10 +111,10 @@ struct data {
 	char *val;
 	int asize;
 	struct fixup *refs;
+	struct fixup *labels;
 };
 
-#define empty_data \
-	((struct data){.len = 0, .val = NULL, .asize = 0, .refs = NULL})
+#define empty_data ((struct data){ /* all .members = 0 or NULL */ })
 
 void fixup_free(struct fixup *f);
 void data_free(struct data d);
@@ -135,6 +135,7 @@ struct data data_append_zeroes(struct da
 struct data data_append_align(struct data d, int align);
 
 struct data data_add_fixup(struct data d, char *ref);
+struct data data_add_label(struct data d, char *label);
 
 int data_is_one_string(struct data d);
 
Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2007-06-14 06:52:52.000000000 -0500
+++ dtc/flattree.c	2007-06-14 06:52:52.000000000 -0500
@@ -121,6 +121,12 @@ static void emit_label(FILE *f, char *pr
 	fprintf(f, "_%s_%s:\n", prefix, label);
 }
 
+static void emit_offset_label(FILE *f, char *label, int offset)
+{
+	fprintf(f, "\t.globl\t%s\n", label);
+	fprintf(f, "%s\t= . + %d\n", label, offset);
+}
+
 static void asm_emit_cell(void *e, cell_t val)
 {
 	FILE *f = e;
@@ -157,6 +163,13 @@ static void asm_emit_data(void *e, struc
 {
 	FILE *f = e;
 	int off = 0;
+	struct fixup *l;
+
+	l = d.labels;
+	while (l) {
+		emit_offset_label(f, l->ref, l->offset);
+		l = l->next;
+	}
 
 	while ((d.len - off) >= sizeof(u32)) {
 		fprintf(f, "\t.long\t0x%x\n",
