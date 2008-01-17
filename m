Return-Path: <dgibson@ozlabs.org>
Date: Thu, 17 Jan 2008 16:10:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [libfdt] RFC: Node iterators (v2)
Message-ID: <20080117051009.GA12239@localhost.localdomain>
References: <20080116062022.GD5016@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080116062022.GD5016@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 16, 2008 at 05:20:22PM +1100, David Gibson wrote:
> Here's my counter-attempt at node iterators for libfdt.  It's based on
> an internal function very similar to Scott's fdt_next_node(), but the
> exported interfaces are altered to be (IMO) safer and simpler.
> 
> So far, it only handles iterating across immediate children of a node,
> not traversing an entire subtree.  I'm still working on extending the
> internals to cover that case.  No property iteration as yet, either.

And here's a revised version.  This now also handles recursive
iteration and iteration across nodes without respect to depth.  I've
removed the for_each() macros for the time being, because they were
making my brain hurt, but I'm still contemplating bringing them back.
Several libfdt functions are now implemented using the new iterator,
so this ends up as a code-size-reducing patch.

I'm pretty happy with the basic outline of this now, although the
names and details might want a bit of polish still.

Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2008-01-17 11:53:56.000000000 +1100
+++ dtc/libfdt/fdt_ro.c	2008-01-17 15:46:04.000000000 +1100
@@ -65,7 +65,7 @@
 static int nodename_eq(const void *fdt, int offset,
 		       const char *s, int len)
 {
-	const char *p = fdt_offset_ptr(fdt, offset, len+1);
+	const char *p = fdt_offset_ptr(fdt, offset + FDT_TAGSIZE, len+1);
 
 	if (! p)
 		/* short match */
@@ -104,50 +104,24 @@ int fdt_num_mem_rsv(const void *fdt)
 	return i;
 }
 
-int fdt_subnode_offset_namelen(const void *fdt, int parentoffset,
+int fdt_subnode_offset_namelen(const void *fdt, int offset,
 			       const char *name, int namelen)
 {
-	int level = 0;
-	uint32_t tag;
-	int offset, nextoffset;
+	int depth;
 
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
+	for (depth = 0;
+	     offset >= 0;
+	     offset = _fdt_next_node(fdt, offset, &depth)) {
+		if (depth < 0)
+			return -FDT_ERR_NOTFOUND;
+		else if ((depth == 1)
+			 && nodename_eq(fdt, offset, name, namelen))
+			return offset;
+	}
 
-	return -FDT_ERR_NOTFOUND;
+	return offset; /* error */
 }
 
 int fdt_subnode_offset(const void *fdt, int parentoffset,
@@ -307,76 +281,61 @@ uint32_t fdt_get_phandle(const void *fdt
 
 int fdt_get_path(const void *fdt, int nodeoffset, char *buf, int buflen)
 {
-	uint32_t tag;
-	int p = 0, overflow = 0;
-	int offset, nextoffset, namelen;
+	int pdepth = 0, p = 0;
+	int offset, depth, namelen;
 	const char *name;
 
 	CHECK_HEADER(fdt);
 
-	tag = fdt_next_tag(fdt, 0, &nextoffset);
-	if (tag != FDT_BEGIN_NODE)
-		return -FDT_ERR_BADSTRUCTURE;
-
 	if (buflen < 2)
 		return -FDT_ERR_NOSPACE;
-	buf[0] = '/';
-	p = 1;
 
-	while (nextoffset <= nodeoffset) {
-		offset = nextoffset;
-		tag = fdt_next_tag(fdt, offset, &nextoffset);
-		switch (tag) {
-		case FDT_END:
-			return -FDT_ERR_BADOFFSET;
+	for (offset = 0, depth = 0;
+	     (offset >= 0) && (offset <= nodeoffset);
+	     offset = _fdt_next_node(fdt, offset, &depth)) {
+		if (pdepth < depth)
+			continue; /* overflowed buffer */
 
-		case FDT_BEGIN_NODE:
-			name = fdt_get_name(fdt, offset, &namelen);
-			if (!name)
-				return namelen;
-			if (overflow || ((p + namelen + 1) > buflen)) {
-				overflow++;
-				break;
-			}
+		while (pdepth > depth) {
+			do {
+				p--;
+			} while (buf[p-1] != '/');
+			pdepth--;
+		}
+
+		name = fdt_get_name(fdt, offset, &namelen);
+		if (!name)
+			return namelen;
+		if ((p + namelen + 1) <= buflen) {
 			memcpy(buf + p, name, namelen);
 			p += namelen;
 			buf[p++] = '/';
-			break;
-
-		case FDT_END_NODE:
-			if (overflow) {
-				overflow--;
-				break;
-			}
-			do {
-				p--;
-			} while  (buf[p-1] != '/');
-			break;
+			pdepth++;
+		}
 
-		case FDT_PROP:
-		case FDT_NOP:
-			break;
+		if (offset == nodeoffset) {
+			if (pdepth < (depth + 1))
+				return -FDT_ERR_NOSPACE;
 
-		default:
-			return -FDT_ERR_BADSTRUCTURE;
+			if (p > 1) /* special case so that root path is "/", not "" */
+				p--;
+			buf[p] = '\0';
+			return p;
 		}
 	}
 
-	if (overflow)
-		return -FDT_ERR_NOSPACE;
+	if ((offset == -FDT_ERR_NOTFOUND) || (offset >= 0))
+		return -FDT_ERR_BADOFFSET;
+	else if (offset == -FDT_ERR_BADOFFSET)
+		return -FDT_ERR_BADSTRUCTURE;
 
-	if (p > 1) /* special case so that root path is "/", not "" */
-		p--;
-	buf[p] = '\0';
-	return p;
+	return offset; /* error from _fdt_next_node() */
 }
 
 int fdt_supernode_atdepth_offset(const void *fdt, int nodeoffset,
 				 int supernodedepth, int *nodedepth)
 {
-	int level = -1;
-	uint32_t tag;
-	int offset, nextoffset = 0;
+	int offset, depth;
 	int supernodeoffset = -FDT_ERR_INTERNAL;
 
 	CHECK_HEADER(fdt);
@@ -384,38 +343,29 @@ int fdt_supernode_atdepth_offset(const v
 	if (supernodedepth < 0)
 		return -FDT_ERR_NOTFOUND;
 
-	do {
-		offset = nextoffset;
-		tag = fdt_next_tag(fdt, offset, &nextoffset);
-		switch (tag) {
-		case FDT_END:
-			return -FDT_ERR_BADOFFSET;
-
-		case FDT_BEGIN_NODE:
-			level++;
-			if (level == supernodedepth)
-				supernodeoffset = offset;
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
+	for (offset = 0, depth = 0;
+	     (offset >= 0) && (offset <= nodeoffset);
+	     offset = _fdt_next_node(fdt, offset, &depth)) {
+		if (depth == supernodedepth)
+			supernodeoffset = offset;
+
+		if (offset == nodeoffset) {
+			if (nodedepth)
+				*nodedepth = depth;
+
+			if (supernodedepth > depth)
+				return -FDT_ERR_NOTFOUND;
+			else
+				return supernodeoffset;
 		}
-	} while (offset < nodeoffset);
+	}
 
-	if (nodedepth)
-		*nodedepth = level;
+	if ((offset == -FDT_ERR_NOTFOUND) || (offset >= 0))
+		return -FDT_ERR_BADOFFSET;
+	else if (offset == -FDT_ERR_BADOFFSET)
+		return -FDT_ERR_BADSTRUCTURE;
 
-	if (supernodedepth > level)
-		return -FDT_ERR_NOTFOUND;
-	return supernodeoffset;
+	return offset; /* error from _fdt_next_node() */
 }
 
 int fdt_node_depth(const void *fdt, int nodeoffset)
@@ -443,51 +393,27 @@ int fdt_node_offset_by_prop_value(const 
 				  const char *propname,
 				  const void *propval, int proplen)
 {
-	uint32_t tag;
-	int offset, nextoffset;
+	int offset;
 	const void *val;
 	int len;
 
 	CHECK_HEADER(fdt);
 
-	if (startoffset >= 0) {
-		tag = fdt_next_tag(fdt, startoffset, &nextoffset);
-		if (tag != FDT_BEGIN_NODE)
-			return -FDT_ERR_BADOFFSET;
-	} else {
-		nextoffset = 0;
-	}
-
 	/* FIXME: The algorithm here is pretty horrible: we scan each
 	 * property of a node in fdt_getprop(), then if that didn't
 	 * find what we want, we scan over them again making our way
 	 * to the next node.  Still it's the easiest to implement
 	 * approach; performance can come later. */
-	do {
-		offset = nextoffset;
-		tag = fdt_next_tag(fdt, offset, &nextoffset);
-
-		switch (tag) {
-		case FDT_BEGIN_NODE:
-			val = fdt_getprop(fdt, offset, propname, &len);
-			if (val
-			    && (len == proplen)
-			    && (memcmp(val, propval, len) == 0))
-				return offset;
-			break;
-
-		case FDT_PROP:
-		case FDT_END:
-		case FDT_END_NODE:
-		case FDT_NOP:
-			break;
-
-		default:
-			return -FDT_ERR_BADSTRUCTURE;
-		}
-	} while (tag != FDT_END);
+	for (offset = _fdt_next_node(fdt, startoffset, NULL);
+	     offset >= 0;
+	     offset = _fdt_next_node(fdt, offset, NULL)) {
+		val = fdt_getprop(fdt, offset, propname, &len);
+		if (val && (len == proplen)
+		    && (memcmp(val, propval, len) == 0))
+			return offset;
+	}
 
-	return -FDT_ERR_NOTFOUND;
+	return offset; /* error from _fdt_next_node() */
 }
 
 int fdt_node_offset_by_phandle(const void *fdt, uint32_t phandle)
@@ -553,31 +479,15 @@ int fdt_node_offset_by_compatible(const 
 	 * that didn't find what we want, we scan over them again
 	 * making our way to the next node.  Still it's the easiest to
 	 * implement approach; performance can come later. */
-	do {
-		offset = nextoffset;
-		tag = fdt_next_tag(fdt, offset, &nextoffset);
-
-		switch (tag) {
-		case FDT_BEGIN_NODE:
-			err = fdt_node_check_compatible(fdt, offset,
-							compatible);
-			if ((err < 0)
-			    && (err != -FDT_ERR_NOTFOUND))
-				return err;
-			else if (err == 0)
-				return offset;
-			break;
-
-		case FDT_PROP:
-		case FDT_END:
-		case FDT_END_NODE:
-		case FDT_NOP:
-			break;
-
-		default:
-			return -FDT_ERR_BADSTRUCTURE;
-		}
-	} while (tag != FDT_END);
+	for (offset = _fdt_next_node(fdt, startoffset, NULL);
+	     offset >= 0;
+	     offset = _fdt_next_node(fdt, offset, NULL)) {
+		err = fdt_node_check_compatible(fdt, offset, compatible);
+		if ((err < 0) && (err != -FDT_ERR_NOTFOUND))
+			return err;
+		else if (err == 0)
+			return offset;
+	}
 
-	return -FDT_ERR_NOTFOUND;
+	return offset; /* error from _fdt_next_node() */
 }
Index: dtc/libfdt/fdt.c
===================================================================
--- dtc.orig/libfdt/fdt.c	2008-01-17 11:53:56.000000000 +1100
+++ dtc/libfdt/fdt.c	2008-01-17 14:57:23.000000000 +1100
@@ -129,6 +129,47 @@ uint32_t fdt_next_tag(const void *fdt, i
 	return tag;
 }
 
+int _fdt_next_node(const void *fdt, int offset, int *depth)
+{
+	int nextoffset = 0;
+	uint32_t tag;
+
+	if (offset >= 0) {
+		tag = fdt_next_tag(fdt, offset, &nextoffset);
+		if (tag != FDT_BEGIN_NODE)
+			return -FDT_ERR_BADOFFSET;
+	}
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
+			if (depth)
+				(*depth)++;
+			break;
+
+		case FDT_END_NODE:
+			if (depth)
+				(*depth)--;
+			break;
+
+		case FDT_END:
+			return -FDT_ERR_NOTFOUND;
+
+		default:
+			return -FDT_ERR_BADSTRUCTURE;
+		}
+	} while (tag != FDT_BEGIN_NODE);
+
+	return offset;
+}
+
 const char *_fdt_find_string(const char *strtab, int tabsize, const char *s)
 {
 	int len = strlen(s) + 1;
Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2008-01-17 11:53:56.000000000 +1100
+++ dtc/libfdt/libfdt.h	2008-01-17 15:05:11.000000000 +1100
@@ -131,6 +131,12 @@ static inline void *fdt_offset_ptr_w(voi
 uint32_t fdt_next_tag(const void *fdt, int offset, int *nextoffset);
 
 /**********************************************************************/
+/* Traversal functions                                                */
+/**********************************************************************/
+
+int _fdt_next_node(const void *fdt, int offset, int *depth);
+
+/**********************************************************************/
 /* General functions                                                  */
 /**********************************************************************/
 


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
