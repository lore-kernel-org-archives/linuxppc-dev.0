Return-Path: <dgibson@ozlabs.org>
Date: Mon, 4 Aug 2008 15:30:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Make many functions 'static'
Message-ID: <20080804053013.GC7086@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch marks various functions not shared between c files
'static', as they should be.  There are a couple of functions in dtc,
and many in the testsuite.

This is *almost* enough to enable the -Wmissing-prototypes warning.
It's not quite enough, because there's a mess of junk in the flex
generated code which triggers that warning which I'm not yet sure how
to deal with.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/data.c
===================================================================
--- dtc.orig/data.c	2008-08-04 15:12:33.000000000 +1000
+++ dtc/data.c	2008-08-04 15:12:46.000000000 +1000
@@ -217,7 +217,7 @@ struct data data_insert_at_marker(struct
 	return d;
 }
 
-struct data data_append_markers(struct data d, struct marker *m)
+static struct data data_append_markers(struct data d, struct marker *m)
 {
 	struct marker **mp = &d.markers;
 
Index: dtc/tests/get_name.c
===================================================================
--- dtc.orig/tests/get_name.c	2008-08-04 15:14:38.000000000 +1000
+++ dtc/tests/get_name.c	2008-08-04 15:14:40.000000000 +1000
@@ -28,7 +28,7 @@
 #include "tests.h"
 #include "testdata.h"
 
-void check_name(void *fdt, const char *path)
+static void check_name(void *fdt, const char *path)
 {
 	int offset;
 	const char *getname, *getname2, *checkname;
Index: dtc/tests/get_path.c
===================================================================
--- dtc.orig/tests/get_path.c	2008-08-04 15:17:19.000000000 +1000
+++ dtc/tests/get_path.c	2008-08-04 15:17:41.000000000 +1000
@@ -30,7 +30,7 @@
 
 #define POISON	('\xff')
 
-void check_path_buf(void *fdt, const char *path, int pathlen, int buflen)
+static void check_path_buf(void *fdt, const char *path, int pathlen, int buflen)
 {
 	int offset;
 	char buf[buflen+1];
@@ -63,7 +63,7 @@ void check_path_buf(void *fdt, const cha
 		FAIL("fdt_get_path([%d bytes]) overran buffer", buflen);
 }
 
-void check_path(void *fdt, const char *path)
+static void check_path(void *fdt, const char *path)
 {
 	int pathlen = strlen(path);
 
Index: dtc/tests/get_phandle.c
===================================================================
--- dtc.orig/tests/get_phandle.c	2008-08-04 15:14:50.000000000 +1000
+++ dtc/tests/get_phandle.c	2008-08-04 15:14:53.000000000 +1000
@@ -28,7 +28,7 @@
 #include "tests.h"
 #include "testdata.h"
 
-void check_phandle(void *fdt, const char *path, uint32_t checkhandle)
+static void check_phandle(void *fdt, const char *path, uint32_t checkhandle)
 {
 	int offset;
 	uint32_t phandle;
Index: dtc/tests/node_offset_by_prop_value.c
===================================================================
--- dtc.orig/tests/node_offset_by_prop_value.c	2008-08-04 15:15:40.000000000 +1000
+++ dtc/tests/node_offset_by_prop_value.c	2008-08-04 15:16:17.000000000 +1000
@@ -29,7 +29,7 @@
 #include "tests.h"
 #include "testdata.h"
 
-void vcheck_search(void *fdt, const char *propname, const void *propval,
+static void vcheck_search(void *fdt, const char *propname, const void *propval,
 		  int proplen, va_list ap)
 {
 	int offset = -1, target;
@@ -48,7 +48,7 @@ void vcheck_search(void *fdt, const char
 	} while (target >= 0);
 }
 
-void check_search(void *fdt, const char *propname, const void *propval,
+static void check_search(void *fdt, const char *propname, const void *propval,
 		  int proplen, ...)
 {
 	va_list ap;
@@ -58,7 +58,8 @@ void check_search(void *fdt, const char 
 	va_end(ap);
 }
 
-void check_search_str(void *fdt, const char *propname, const char *propval, ...)
+static void check_search_str(void *fdt, const char *propname,
+			     const char *propval, ...)
 {
 	va_list ap;
 
Index: dtc/tests/parent_offset.c
===================================================================
--- dtc.orig/tests/parent_offset.c	2008-08-04 15:15:19.000000000 +1000
+++ dtc/tests/parent_offset.c	2008-08-04 15:15:29.000000000 +1000
@@ -28,7 +28,7 @@
 #include "tests.h"
 #include "testdata.h"
 
-int path_parent_len(const char *path)
+static int path_parent_len(const char *path)
 {
 	const char *p = strrchr(path, '/');
 
@@ -40,7 +40,7 @@ int path_parent_len(const char *path)
 		return p - path;
 }
 
-void check_path(struct fdt_header *fdt, const char *path)
+static void check_path(struct fdt_header *fdt, const char *path)
 {
 	char *parentpath;
 	int nodeoffset, parentoffset, parentpathoffset, pathparentlen;
Index: dtc/tests/path_offset.c
===================================================================
--- dtc.orig/tests/path_offset.c	2008-08-04 15:14:18.000000000 +1000
+++ dtc/tests/path_offset.c	2008-08-04 15:14:20.000000000 +1000
@@ -28,7 +28,7 @@
 #include "tests.h"
 #include "testdata.h"
 
-int check_subnode(void *fdt, int parent, const char *name)
+static int check_subnode(void *fdt, int parent, const char *name)
 {
 	int offset;
 	const struct fdt_node_header *nh;
Index: dtc/tests/subnode_offset.c
===================================================================
--- dtc.orig/tests/subnode_offset.c	2008-08-04 15:13:27.000000000 +1000
+++ dtc/tests/subnode_offset.c	2008-08-04 15:13:43.000000000 +1000
@@ -28,7 +28,7 @@
 #include "tests.h"
 #include "testdata.h"
 
-int check_subnode(struct fdt_header *fdt, int parent, const char *name)
+static int check_subnode(struct fdt_header *fdt, int parent, const char *name)
 {
 	int offset;
 	const struct fdt_node_header *nh;
Index: dtc/tests/supernode_atdepth_offset.c
===================================================================
--- dtc.orig/tests/supernode_atdepth_offset.c	2008-08-04 15:16:38.000000000 +1000
+++ dtc/tests/supernode_atdepth_offset.c	2008-08-04 15:17:06.000000000 +1000
@@ -28,7 +28,7 @@
 #include "tests.h"
 #include "testdata.h"
 
-int path_depth(const char *path)
+static int path_depth(const char *path)
 {
 	const char *p;
 	int depth = 0;
@@ -49,7 +49,7 @@ int path_depth(const char *path)
 		return depth;
 }
 
-int path_prefix(const char *path, int depth)
+static int path_prefix(const char *path, int depth)
 {
 	const char *p;
 	int i;
@@ -67,7 +67,7 @@ int path_prefix(const char *path, int de
 	return p - path;
 }
 
-void check_supernode_atdepth(struct fdt_header *fdt, const char *path,
+static void check_supernode_atdepth(struct fdt_header *fdt, const char *path,
 			     int depth)
 {
 	int pdepth = path_depth(path);
@@ -106,7 +106,7 @@ void check_supernode_atdepth(struct fdt_
 		     "instead of %d", nodedepth, pdepth);
 }
 
-void check_supernode_overdepth(struct fdt_header *fdt, const char *path)
+static void check_supernode_overdepth(struct fdt_header *fdt, const char *path)
 {
 	int pdepth = path_depth(path);
 	int nodeoffset, err;
@@ -121,7 +121,7 @@ void check_supernode_overdepth(struct fd
 		     "of FDT_ERR_NOTFOUND", path, pdepth+1, err);
 }
 
-void check_path(struct fdt_header *fdt, const char *path)
+static void check_path(struct fdt_header *fdt, const char *path)
 {
 	int i;
 
Index: dtc/treesource.c
===================================================================
--- dtc.orig/treesource.c	2008-08-04 15:12:55.000000000 +1000
+++ dtc/treesource.c	2008-08-04 15:13:09.000000000 +1000
@@ -52,7 +52,7 @@ static void write_prefix(FILE *f, int le
 		fputc('\t', f);
 }
 
-int isstring(char c)
+static int isstring(char c)
 {
 	return (isprint(c)
 		|| (c == '\0')
Index: dtc/tests/dtbs_equal_ordered.c
===================================================================
--- dtc.orig/tests/dtbs_equal_ordered.c	2008-08-04 15:25:06.000000000 +1000
+++ dtc/tests/dtbs_equal_ordered.c	2008-08-04 15:25:24.000000000 +1000
@@ -29,7 +29,7 @@
 #include "tests.h"
 #include "testdata.h"
 
-void compare_mem_rsv(const void *fdt1, const void *fdt2)
+static void compare_mem_rsv(const void *fdt1, const void *fdt2)
 {
 	int i;
 	uint64_t addr1, size1, addr2, size2;
@@ -56,7 +56,7 @@ void compare_mem_rsv(const void *fdt1, c
 	}
 }
 
-void compare_structure(const void *fdt1, const void *fdt2)
+static void compare_structure(const void *fdt1, const void *fdt2)
 {
 	int nextoffset1 = 0, nextoffset2 = 0;
 	int offset1, offset2;
Index: dtc/tests/incbin.c
===================================================================
--- dtc.orig/tests/incbin.c	2008-08-04 15:20:53.000000000 +1000
+++ dtc/tests/incbin.c	2008-08-04 15:21:08.000000000 +1000
@@ -31,7 +31,7 @@
 
 #define CHUNKSIZE	1024
 
-char *load_file(const char *name, int *len)
+static char *load_file(const char *name, int *len)
 {
 	FILE *f;
 	char *buf = NULL;
Index: dtc/tests/mangle-layout.c
===================================================================
--- dtc.orig/tests/mangle-layout.c	2008-08-04 15:19:19.000000000 +1000
+++ dtc/tests/mangle-layout.c	2008-08-04 15:19:30.000000000 +1000
@@ -35,7 +35,7 @@ struct bufstate {
 	int size;
 };
 
-void expand_buf(struct bufstate *buf, int newsize)
+static void expand_buf(struct bufstate *buf, int newsize)
 {
 	buf->buf = realloc(buf->buf, newsize);
 	if (!buf->buf)
@@ -43,7 +43,7 @@ void expand_buf(struct bufstate *buf, in
 	buf->size = newsize;
 }
 
-void new_header(struct bufstate *buf, int version, const void *fdt)
+static void new_header(struct bufstate *buf, int version, const void *fdt)
 {
 	int hdrsize;
 
@@ -63,7 +63,7 @@ void new_header(struct bufstate *buf, in
 	fdt_set_boot_cpuid_phys(buf->buf, fdt_boot_cpuid_phys(fdt));
 }
 
-void add_block(struct bufstate *buf, int version, char block, const void *fdt)
+static void add_block(struct bufstate *buf, int version, char block, const void *fdt)
 {
 	int align, size;
 	const void *src;
Index: dtc/tests/node_check_compatible.c
===================================================================
--- dtc.orig/tests/node_check_compatible.c	2008-08-04 15:18:13.000000000 +1000
+++ dtc/tests/node_check_compatible.c	2008-08-04 15:18:30.000000000 +1000
@@ -29,7 +29,8 @@
 #include "tests.h"
 #include "testdata.h"
 
-void check_compatible(const void *fdt, const char *path, const char *compat)
+static void check_compatible(const void *fdt, const char *path,
+			     const char *compat)
 {
 	int offset, err;
 
Index: dtc/tests/node_offset_by_compatible.c
===================================================================
--- dtc.orig/tests/node_offset_by_compatible.c	2008-08-04 15:18:35.000000000 +1000
+++ dtc/tests/node_offset_by_compatible.c	2008-08-04 15:18:47.000000000 +1000
@@ -29,7 +29,7 @@
 #include "tests.h"
 #include "testdata.h"
 
-void check_search(void *fdt, const char *compat, ...)
+static void check_search(void *fdt, const char *compat, ...)
 {
 	va_list ap;
 	int offset = -1, target;
Index: dtc/tests/node_offset_by_phandle.c
===================================================================
--- dtc.orig/tests/node_offset_by_phandle.c	2008-08-04 15:17:58.000000000 +1000
+++ dtc/tests/node_offset_by_phandle.c	2008-08-04 15:18:06.000000000 +1000
@@ -29,7 +29,7 @@
 #include "tests.h"
 #include "testdata.h"
 
-void check_search(void *fdt, uint32_t phandle, int target)
+static void check_search(void *fdt, uint32_t phandle, int target)
 {
 	int offset;
 
Index: dtc/tests/nopulate.c
===================================================================
--- dtc.orig/tests/nopulate.c	2008-08-04 15:19:44.000000000 +1000
+++ dtc/tests/nopulate.c	2008-08-04 15:19:56.000000000 +1000
@@ -30,7 +30,7 @@
 #include "tests.h"
 #include "testdata.h"
 
-int nopulate_struct(char *buf, const char *fdt)
+static int nopulate_struct(char *buf, const char *fdt)
 {
 	int offset, nextoffset = 0;
 	uint32_t tag;
Index: dtc/tests/notfound.c
===================================================================
--- dtc.orig/tests/notfound.c	2008-08-04 15:19:00.000000000 +1000
+++ dtc/tests/notfound.c	2008-08-04 15:19:10.000000000 +1000
@@ -28,7 +28,7 @@
 #include "tests.h"
 #include "testdata.h"
 
-void check_error(const char *s, int err)
+static void check_error(const char *s, int err)
 {
 	if (err != -FDT_ERR_NOTFOUND)
 		FAIL("%s return error %s instead of -FDT_ERR_NOTFOUND", s,
Index: dtc/tests/path-references.c
===================================================================
--- dtc.orig/tests/path-references.c	2008-08-04 15:24:35.000000000 +1000
+++ dtc/tests/path-references.c	2008-08-04 15:24:52.000000000 +1000
@@ -28,7 +28,7 @@
 #include "tests.h"
 #include "testdata.h"
 
-void check_ref(const void *fdt, int node, const char *checkpath)
+static void check_ref(const void *fdt, int node, const char *checkpath)
 {
 	const char *p;
 	int len;
Index: dtc/tests/references.c
===================================================================
--- dtc.orig/tests/references.c	2008-08-04 15:20:26.000000000 +1000
+++ dtc/tests/references.c	2008-08-04 15:20:39.000000000 +1000
@@ -28,7 +28,7 @@
 #include "tests.h"
 #include "testdata.h"
 
-void check_ref(const void *fdt, int node, uint32_t checkref)
+static void check_ref(const void *fdt, int node, uint32_t checkref)
 {
 	const uint32_t *p;
 	uint32_t ref;
Index: dtc/tests/set_name.c
===================================================================
--- dtc.orig/tests/set_name.c	2008-08-04 15:20:00.000000000 +1000
+++ dtc/tests/set_name.c	2008-08-04 15:20:13.000000000 +1000
@@ -28,7 +28,7 @@
 #include "tests.h"
 #include "testdata.h"
 
-void check_set_name(void *fdt, const char *path, const char *newname)
+static void check_set_name(void *fdt, const char *path, const char *newname)
 {
 	int offset;
 	const char *getname, *oldname;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
