Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Nov 2007 14:39:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: dtc: Merge refs and labels into single "markers" list (v2)
Message-ID: <20071122033923.GI19445@localhost.localdomain>
References: <20071122003707.GF19445@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071122003707.GF19445@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, every 'data' object, used to represent property values, has
two lists of fixup structures - one for labels and one for references.
Sometimes we want to look at them separately, but other times we need
to consider both types of fixup.

I'm planning to implement string references, where a full path rather
than a phandle is substituted into a property value.  Adding yet
another list of fixups for that would start to get silly.  So, this
patch merges the "refs" and "labels" lists into a single list of
"markers", each of which has a type field indicating if it represents
a label or a phandle reference.  String references or any other new
type of in-data marker will then just need a new type value - merging
data blocks and other common manipulations will just work.

While I was at it I made some cleanups to the handling of fixups which
simplify things further.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---

Updated to apply on top of the new version of the checking
infrastructure patch.

 checks.c     |   20 ++++-------
 data.c       |  101 ++++++++++++++++-------------------------------------------
 dtc-parser.y |   11 +++---
 dtc.h        |   24 +++++++++-----
 flattree.c   |   11 +++---
 treesource.c |   62 ++++++++++++++++++------------------
 6 files changed, 97 insertions(+), 132 deletions(-)

Index: dtc/checks.c
===================================================================
--- dtc.orig/checks.c	2007-11-22 14:02:26.000000000 +1100
+++ dtc/checks.c	2007-11-22 14:38:39.000000000 +1100
@@ -243,26 +243,22 @@
 static void fixup_phandle_references(struct check *c, struct node *dt,
 				     struct node *node, struct property *prop)
 {
-      struct fixup *f = prop->val.refs;
+      struct marker *m = prop->val.markers;
       struct node *refnode;
       cell_t phandle;
 
-      while (f) {
-	      assert(f->offset + sizeof(cell_t) <= prop->val.len);
+      for_each_marker_of_type(m, REF_PHANDLE) {
+	      assert(m->offset + sizeof(cell_t) <= prop->val.len);
 
-	      refnode = get_node_by_ref(dt, f->ref);
+	      refnode = get_node_by_ref(dt, m->ref);
 	      if (! refnode) {
 		      FAIL(c, "Reference to non-existent node or label \"%s\"\n",
-			   f->ref);
-	      } else {
-		      phandle = get_node_phandle(dt, refnode);
-
-		      *((cell_t *)(prop->val.val + f->offset)) = cpu_to_be32(phandle);
+			   m->ref);
+		      continue;
 	      }
 
-              prop->val.refs = f->next;
-              fixup_free(f);
-              f = prop->val.refs;
+	      phandle = get_node_phandle(dt, refnode);
+	      *((cell_t *)(prop->val.val + m->offset)) = cpu_to_be32(phandle);
       }
 }
 CHECK(phandle_references, NULL, NULL, fixup_phandle_references, NULL, ERROR,
Index: dtc/data.c
===================================================================
--- dtc.orig/data.c	2007-11-22 13:54:57.000000000 +1100
+++ dtc/data.c	2007-11-22 14:38:39.000000000 +1100
@@ -20,28 +20,16 @@
 
 #include "dtc.h"
 
-void fixup_free(struct fixup *f)
-{
-	free(f->ref);
-	free(f);
-}
-
 void data_free(struct data d)
 {
-	struct fixup *f, *nf;
+	struct marker *m, *nm;
 
-	f = d.refs;
-	while (f) {
-		nf = f->next;
-		fixup_free(f);
-		f = nf;
-	}
-
-	f = d.labels;
-	while (f) {
-		nf = f->next;
-		fixup_free(f);
-		f = nf;
+	m = d.markers;
+	while (m) {
+		nm = m->next;
+		free(m->ref);
+		free(m);
+		m = nm;
 	}
 
 	assert(!d.val || d.asize);
@@ -214,37 +202,29 @@
 	return d;
 }
 
-void fixup_merge(struct fixup **fd, struct fixup **fd2, int d1_len)
+struct data data_append_markers(struct data d, struct marker *m)
 {
-	struct fixup **ff;
-	struct fixup *f, *f2;
-
-	/* Extract d2's fixups */
-	f2 = *fd2;
-	*fd2 = NULL;
-
-	/* Tack them onto d's list of fixups */
-	ff = fd;
-	while (*ff)
-		ff = &((*ff)->next);
-	*ff = f2;
-
-	/* And correct them for their new position */
-	for (f = f2; f; f = f->next)
-		f->offset += d1_len;
-
+	struct marker **mp = &d.markers;
 
+	/* Find the end of the markerlist */
+	while (*mp)
+		mp = &((*mp)->next);
+	*mp = m;
+	return d;
 }
 
 struct data data_merge(struct data d1, struct data d2)
 {
 	struct data d;
+	struct marker *m2 = d2.markers;
 
-	d = data_append_data(d1, d2.val, d2.len);
+	d = data_append_markers(data_append_data(d1, d2.val, d2.len), m2);
 
-	fixup_merge(&d.refs, &d2.refs, d1.len);
-	fixup_merge(&d.labels, &d2.labels, d1.len);
+	/* Adjust for the length of d1 */
+	for_each_marker(m2)
+		m2->offset += d1.len;
 
+	d2.markers = NULL; /* So data_free() doesn't clobber them */
 	data_free(d2);
 
 	return d;
@@ -294,42 +274,17 @@
 	return data_append_zeroes(d, newlen - d.len);
 }
 
-struct data data_add_fixup(struct data d, char *ref)
+struct data data_add_marker(struct data d, enum markertype type, char *ref)
 {
-	struct fixup *f;
-	struct data nd;
+	struct marker *m;
 
-	f = xmalloc(sizeof(*f));
-	f->offset = d.len;
-	f->ref = ref;
-	f->next = d.refs;
+	m = xmalloc(sizeof(*m));
+	m->offset = d.len;
+	m->type = type;
+	m->ref = ref;
+	m->next = NULL;
 
-	nd = d;
-	nd.refs = f;
-
-	return nd;
-}
-
-struct data data_add_label(struct data d, char *label)
-{
-	struct fixup *f, **p;
-	struct data nd;
-
-	f = xmalloc(sizeof(*f));
-	f->offset = d.len;
-	f->ref = label;
-
-	nd = d;
-	p = &nd.labels;
-
-	/* adding to end keeps them sorted */
-	while (*p)
-		p = &((*p)->next);
-
-	f->next = *p;
-	*p = f;
-
-	return nd;
+	return data_append_markers(d, m);
 }
 
 int data_is_one_string(struct data d)
Index: dtc/dtc-parser.y
===================================================================
--- dtc.orig/dtc-parser.y	2007-11-22 13:54:57.000000000 +1100
+++ dtc/dtc-parser.y	2007-11-22 14:38:39.000000000 +1100
@@ -194,7 +194,7 @@
 		}
 	| propdata DT_LABEL
 		{
-			$$ = data_add_label($1, $2);
+			$$ = data_add_marker($1, LABEL, $2);
 		}
 	;
 
@@ -209,7 +209,7 @@
 		}
 	| propdataprefix DT_LABEL
 		{
-			$$ = data_add_label($1, $2);
+			$$ = data_add_marker($1, LABEL, $2);
 		}
 	;
 
@@ -224,11 +224,12 @@
 		}
 	| celllist DT_REF
 		{
-			$$ = data_append_cell(data_add_fixup($1, $2), -1);
+			$$ = data_append_cell(data_add_marker($1, REF_PHANDLE,
+							      $2), -1);
 		}
 	| celllist DT_LABEL
 		{
-			$$ = data_add_label($1, $2);
+			$$ = data_add_marker($1, LABEL, $2);
 		}
 	;
 
@@ -262,7 +263,7 @@
 		}
 	| bytestring DT_LABEL
 		{
-			$$ = data_add_label($1, $2);
+			$$ = data_add_marker($1, LABEL, $2);
 		}
 	;
 
Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2007-11-22 13:54:57.000000000 +1100
+++ dtc/dtc.h	2007-11-22 14:38:39.000000000 +1100
@@ -101,23 +101,34 @@
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 /* Data blobs */
-struct fixup {
+enum markertype {
+	REF_PHANDLE,
+	LABEL,
+};
+
+struct  marker {
+	enum markertype type;
 	int offset;
 	char *ref;
-	struct fixup *next;
+	struct marker *next;
 };
 
 struct data {
 	int len;
 	char *val;
 	int asize;
-	struct fixup *refs;
-	struct fixup *labels;
+	struct marker *markers;
 };
 
+
 #define empty_data ((struct data){ /* all .members = 0 or NULL */ })
 
-void fixup_free(struct fixup *f);
+#define for_each_marker(m) \
+	for (; (m); (m) = (m)->next)
+#define for_each_marker_of_type(m, t) \
+	for_each_marker(m) \
+		if ((m)->type == (t))
+
 void data_free(struct data d);
 
 struct data data_grow_for(struct data d, int xlen);
@@ -135,8 +146,7 @@
 struct data data_append_zeroes(struct data d, int len);
 struct data data_append_align(struct data d, int align);
 
-struct data data_add_fixup(struct data d, char *ref);
-struct data data_add_label(struct data d, char *label);
+struct data data_add_marker(struct data d, enum markertype type, char *ref);
 
 int data_is_one_string(struct data d);
 
Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2007-11-22 13:54:57.000000000 +1100
+++ dtc/flattree.c	2007-11-22 14:02:49.000000000 +1100
@@ -162,12 +162,13 @@
 {
 	FILE *f = e;
 	int off = 0;
-	struct fixup *l;
+	struct marker *m;
 
-	l = d.labels;
-	while (l) {
-		emit_offset_label(f, l->ref, l->offset);
-		l = l->next;
+	m = d.markers;
+	while (m) {
+		if (m->type == LABEL)
+			emit_offset_label(f, m->ref, m->offset);
+		m = m->next;
 	}
 
 	while ((d.len - off) >= sizeof(u32)) {
Index: dtc/treesource.c
===================================================================
--- dtc.orig/treesource.c	2007-11-22 13:54:57.000000000 +1100
+++ dtc/treesource.c	2007-11-22 14:02:49.000000000 +1100
@@ -61,7 +61,7 @@
 	char *str = val.val;
 	int i;
 	int newchunk = 1;
-	struct fixup *l = val.labels;
+	struct marker *m = val.markers;
 
 	assert(str[val.len-1] == '\0');
 
@@ -69,10 +69,12 @@
 		char c = str[i];
 
 		if (newchunk) {
-			while (l && (l->offset <= i)) {
-				assert(l->offset == i);
-				fprintf(f, "%s: ", l->ref);
-				l = l->next;
+			while (m && (m->offset <= i)) {
+				if (m->type == LABEL) {
+					assert(m->offset == i);
+					fprintf(f, "%s: ", m->ref);
+				}
+				m = m->next;
 			}
 			fprintf(f, "\"");
 			newchunk = 0;
@@ -120,10 +122,9 @@
 	fprintf(f, "\"");
 
 	/* Wrap up any labels at the end of the value */
-	while (l) {
-		assert (l->offset == val.len);
-		fprintf(f, " %s:", l->ref);
-		l = l->next;
+	for_each_marker_of_type(m, LABEL) {
+		assert (m->offset == val.len);
+		fprintf(f, " %s:", m->ref);
 	}
 }
 
@@ -131,14 +132,16 @@
 {
 	void *propend = val.val + val.len;
 	cell_t *cp = (cell_t *)val.val;
-	struct fixup *l = val.labels;
+	struct marker *m = val.markers;
 
 	fprintf(f, "<");
 	for (;;) {
-		while (l && (l->offset <= ((char *)cp - val.val))) {
-			assert(l->offset == ((char *)cp - val.val));
-			fprintf(f, "%s: ", l->ref);
-			l = l->next;
+		while (m && (m->offset <= ((char *)cp - val.val))) {
+			if (m->type == LABEL) {
+				assert(m->offset == ((char *)cp - val.val));
+				fprintf(f, "%s: ", m->ref);
+			}
+			m = m->next;
 		}
 
 		fprintf(f, "0x%x", be32_to_cpu(*cp++));
@@ -148,10 +151,9 @@
 	}
 
 	/* Wrap up any labels at the end of the value */
-	while (l) {
-		assert (l->offset == val.len);
-		fprintf(f, " %s:", l->ref);
-		l = l->next;
+	for_each_marker_of_type(m, LABEL) {
+		assert (m->offset == val.len);
+		fprintf(f, " %s:", m->ref);
 	}
 	fprintf(f, ">");
 }
@@ -160,13 +162,14 @@
 {
 	void *propend = val.val + val.len;
 	char *bp = val.val;
-	struct fixup *l = val.labels;
+	struct marker *m = val.markers;
 
 	fprintf(f, "[");
 	for (;;) {
-		while (l && (l->offset == (bp-val.val))) {
-			fprintf(f, "%s: ", l->ref);
-			l = l->next;
+		while (m && (m->offset == (bp-val.val))) {
+			if (m->type == LABEL)
+				fprintf(f, "%s: ", m->ref);
+			m = m->next;
 		}
 
 		fprintf(f, "%02hhx", *bp++);
@@ -176,10 +179,9 @@
 	}
 
 	/* Wrap up any labels at the end of the value */
-	while (l) {
-		assert (l->offset == val.len);
-		fprintf(f, " %s:", l->ref);
-		l = l->next;
+	for_each_marker_of_type(m, LABEL) {
+		assert (m->offset == val.len);
+		fprintf(f, " %s:", m->ref);
 	}
 	fprintf(f, "]");
 }
@@ -188,7 +190,7 @@
 {
 	int len = prop->val.len;
 	char *p = prop->val.val;
-	struct fixup *l;
+	struct marker *m = prop->val.markers;
 	int nnotstring = 0, nnul = 0;
 	int nnotstringlbl = 0, nnotcelllbl = 0;
 	int i;
@@ -205,10 +207,10 @@
 			nnul++;
 	}
 
-	for (l = prop->val.labels; l; l = l->next) {
-		if ((l->offset > 0) && (prop->val.val[l->offset - 1] != '\0'))
+	for_each_marker_of_type(m, LABEL) {
+		if ((m->offset > 0) && (prop->val.val[m->offset - 1] != '\0'))
 			nnotstringlbl++;
-		if ((l->offset % sizeof(cell_t)) != 0)
+		if ((m->offset % sizeof(cell_t)) != 0)
 			nnotcelllbl++;
 	}
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
