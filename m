Return-Path: <dgibson@ozlabs.org>
Date: Wed, 16 Jan 2008 17:20:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: [libfdt] RFC: Node iterators
Message-ID: <20080116062022.GD5016@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's my counter-attempt at node iterators for libfdt.  It's based on
an internal function very similar to Scott's fdt_next_node(), but the
exported interfaces are altered to be (IMO) safer and simpler.

So far, it only handles iterating across immediate children of a node,
not traversing an entire subtree.  I'm still working on extending the
internals to cover that case.  No property iteration as yet, either.

Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2008-01-16 15:06:49.000000000 +1100
+++ dtc/libfdt/fdt_ro.c	2008-01-16 16:27:55.000000000 +1100
@@ -65,7 +65,7 @@
 static int nodename_eq(const void *fdt, int offset,
 		       const char *s, int len)
 {
-	const char *p = fdt_offset_ptr(fdt, offset, len+1);
+	const char *p = fdt_offset_ptr(fdt, offset + FDT_TAGSIZE, len+1);
 
 	if (! p)
 		/* short match */
@@ -104,50 +104,16 @@ int fdt_num_mem_rsv(const void *fdt)
 	return i;
 }
 
-int fdt_subnode_offset_namelen(const void *fdt, int parentoffset,
+int fdt_subnode_offset_namelen(const void *fdt, int offset,
 			       const char *name, int namelen)
 {
-	int level = 0;
-	uint32_t tag;
-	int offset, nextoffset;
-
 	CHECK_HEADER(fdt);
 
-	tag = fdt_next_tag(fdt, parentoffset, &nextoffset);
-	if (tag != FDT_BEGIN_NODE)
-		return -FDT_ERR_BADOFFSET;
-
-	do {
-		offset = nextoffset;
-		tag = fdt_next_tag(fdt, offset, &nextoffset);
-
-		switch (tag) {
-		case FDT_END:
-			return -FDT_ERR_TRUNCATED;
-
-		case FDT_BEGIN_NODE:
-			level++;
-			if (level != 1)
-				continue;
-			if (nodename_eq(fdt, offset+FDT_TAGSIZE, name, namelen))
-				/* Found it! */
-				return offset;
-			break;
-
-		case FDT_END_NODE:
-			level--;
-			break;
-
-		case FDT_PROP:
-		case FDT_NOP:
-			break;
-
-		default:
-			return -FDT_ERR_BADSTRUCTURE;
-		}
-	} while (level >= 0);
+	for_each_subnode(fdt, offset)
+		if (nodename_eq(fdt, offset, name, namelen))
+			return offset;
 
-	return -FDT_ERR_NOTFOUND;
+	return offset;
 }
 
 int fdt_subnode_offset(const void *fdt, int parentoffset,
Index: dtc/libfdt/fdt.c
===================================================================
--- dtc.orig/libfdt/fdt.c	2008-01-16 16:26:48.000000000 +1100
+++ dtc/libfdt/fdt.c	2008-01-16 17:03:09.000000000 +1100
@@ -129,6 +129,58 @@ uint32_t fdt_next_tag(const void *fdt, i
 	return tag;
 }
 
+static int _fdt_next_node(const void *fdt, int offset, int *depth)
+{
+	uint32_t tag;
+	int nextoffset;
+
+	tag = fdt_next_tag(fdt, offset, &nextoffset);
+	if (tag != FDT_BEGIN_NODE)
+		return -FDT_ERR_BADOFFSET;
+
+	do {
+		offset = nextoffset;
+		tag = fdt_next_tag(fdt, offset, &nextoffset);
+
+		switch (tag) {
+		case FDT_PROP:
+		case FDT_NOP:
+			break;
+
+		case FDT_BEGIN_NODE:
+			(*depth)++;
+			if (*depth == 1)
+				return offset;
+			break;
+
+		case FDT_END_NODE:
+			(*depth)--;
+			break;
+
+		case FDT_END:
+			return -FDT_ERR_TRUNCATED;
+
+		default:
+			return -FDT_ERR_BADSTRUCTURE;
+		}
+	} while (*depth >= 0);
+
+	return -FDT_ERR_NOTFOUND;
+}
+
+int _fdt_first_subnode(const void *fdt, int offset)
+{
+	int depth = 0;
+
+	return _fdt_next_node(fdt, offset, &depth);
+}
+
+int _fdt_next_subnode(const void *fdt, int offset)
+{
+	int depth = 1;
+	return _fdt_next_node(fdt, offset, &depth);
+}
+
 const char *_fdt_find_string(const char *strtab, int tabsize, const char *s)
 {
 	int len = strlen(s) + 1;
Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2008-01-16 16:27:09.000000000 +1100
+++ dtc/libfdt/libfdt.h	2008-01-16 17:06:31.000000000 +1100
@@ -131,6 +131,18 @@ static inline void *fdt_offset_ptr_w(voi
 uint32_t fdt_next_tag(const void *fdt, int offset, int *nextoffset);
 
 /**********************************************************************/
+/* Traversal functions                                                */
+/**********************************************************************/
+
+int _fdt_first_subnode(const void *fdt, int offset);
+int _fdt_next_subnode(const void *fdt, int offset);
+
+#define for_each_subnode(fdt, offset) \
+	for ((offset) = _fdt_first_subnode((fdt), (offset));	\
+	     (offset) >= 0; \
+	     (offset) = _fdt_next_subnode((fdt), (offset)))
+
+/**********************************************************************/
 /* General functions                                                  */
 /**********************************************************************/
 


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
