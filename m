Return-Path: <dgibson@ozlabs.org>
Date: Fri, 29 Aug 2008 14:19:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Fix bugs in fdt_get_path()
Message-ID: <20080829041913.GC30197@yookeroo.seuss>
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

The current implementation of fdt_get_path() has a couple of bugs,
fixed by this patch.

First, contrary to its documentation, on success it returns the length
of the node's path, rather than 0.  The testcase is correspondingly
wrong, and the patch fixes this as well.

Second, in some circumstances, it will return -FDT_ERR_BADOFFSET
instead of -FDT_ERR_NOSPACE when given insufficient buffer space.
Specifically this happens when there is insufficient space even to
hold the path's second last component.  This behaviour is corrected,
and the testcase updated to check it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/get_path.c
===================================================================
--- dtc.orig/tests/get_path.c	2008-08-29 14:11:09.000000000 +1000
+++ dtc/tests/get_path.c	2008-08-29 14:11:11.000000000 +1000
@@ -43,6 +43,8 @@ static void check_path_buf(void *fdt, co
 	memset(buf, POISON, sizeof(buf)); /* poison the buffer */
 
 	len = fdt_get_path(fdt, offset, buf, buflen);
+	verbose_printf("get_path() %s -> %d -> %s\n", path, offset, buf);
+
 	if (buflen <= pathlen) {
 		if (len != -FDT_ERR_NOSPACE)
 			FAIL("fdt_get_path([%d bytes]) returns %d with "
@@ -51,9 +53,9 @@ static void check_path_buf(void *fdt, co
 		if (len < 0)
 			FAIL("fdt_get_path([%d bytes]): %s", buflen,
 			     fdt_strerror(len));
-		if (len != pathlen)
-			FAIL("fdt_get_path([%d bytes]) reports length %d "
-			     "instead of %d", buflen, len, pathlen);
+		if (len != 0)
+			FAIL("fdt_get_path([%d bytes]) returns %d "
+			     "instead of 0", buflen, len);
 		if (strcmp(buf, path) != 0)
 			FAIL("fdt_get_path([%d bytes]) returns \"%s\" "
 			     "instead of \"%s\"", buflen, buf, path);
@@ -70,6 +72,8 @@ static void check_path(void *fdt, const 
 	check_path_buf(fdt, path, pathlen, 1024);
 	check_path_buf(fdt, path, pathlen, pathlen+1);
 	check_path_buf(fdt, path, pathlen, pathlen);
+	check_path_buf(fdt, path, pathlen, 0);
+	check_path_buf(fdt, path, pathlen, 2);
 }
 
 int main(int argc, char *argv[])
Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2008-08-29 14:11:11.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2008-08-29 14:11:11.000000000 +1000
@@ -328,9 +328,6 @@ int fdt_get_path(const void *fdt, int no
 	for (offset = 0, depth = 0;
 	     (offset >= 0) && (offset <= nodeoffset);
 	     offset = fdt_next_node(fdt, offset, &depth)) {
-		if (pdepth < depth)
-			continue; /* overflowed buffer */
-
 		while (pdepth > depth) {
 			do {
 				p--;
@@ -338,14 +335,16 @@ int fdt_get_path(const void *fdt, int no
 			pdepth--;
 		}
 
-		name = fdt_get_name(fdt, offset, &namelen);
-		if (!name)
-			return namelen;
-		if ((p + namelen + 1) <= buflen) {
-			memcpy(buf + p, name, namelen);
-			p += namelen;
-			buf[p++] = '/';
-			pdepth++;
+		if (pdepth >= depth) {
+			name = fdt_get_name(fdt, offset, &namelen);
+			if (!name)
+				return namelen;
+			if ((p + namelen + 1) <= buflen) {
+				memcpy(buf + p, name, namelen);
+				p += namelen;
+				buf[p++] = '/';
+				pdepth++;
+			}
 		}
 
 		if (offset == nodeoffset) {
@@ -355,7 +354,7 @@ int fdt_get_path(const void *fdt, int no
 			if (p > 1) /* special case so that root path is "/", not "" */
 				p--;
 			buf[p] = '\0';
-			return p;
+			return 0;
 		}
 	}
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
