Return-Path: <dgibson@ozlabs.org>
Date: Wed, 29 Aug 2007 12:22:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Fix handling of trailing / in fdt_path_offset()
Message-ID: <20070829022250.GA25468@localhost.localdomain>
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

Currently, fdt_path_offset() returns FDL_ERR_BADOFFSET if given a path
with a trailing '/'.  In particular this means that
fdt_path_offset("/") returns FDT_ERR_BADOFFSET rather than 0 as one
would expect.

This patch fixes the function to accept and ignore trailing '/'
characters.  As well as allowing fdt_path_offset("/") this means that
fdt_path_offset("/foo/") will return the same as
fdt_path_offset("/foo") which seems in keeping with the principle of
least surprise.

This also adds a testcase to ensure that fdt_path_offset("/") returns
0 as it should.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/path_offset.c
===================================================================
--- dtc.orig/tests/path_offset.c	2007-08-29 12:04:54.000000000 +1000
+++ dtc/tests/path_offset.c	2007-08-29 12:04:57.000000000 +1000
@@ -58,6 +58,7 @@
 int main(int argc, char *argv[])
 {
 	void *fdt;
+	int root_offset;
 	int subnode1_offset, subnode2_offset;
 	int subnode1_offset_p, subnode2_offset_p;
 	int subsubnode1_offset, subsubnode2_offset;
@@ -66,6 +67,13 @@
 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);
 
+	root_offset = fdt_path_offset(fdt, "/");
+	if (root_offset < 0)
+		FAIL("fdt_path_offset(\"/\") failed: %s",
+		     fdt_strerror(root_offset));
+	else if (root_offset != 0)
+		FAIL("fdt_path_offset(\"/\") returns incorrect offset %d",
+		     root_offset);
 	subnode1_offset = check_subnode(fdt, 0, "subnode1");
 	subnode2_offset = check_subnode(fdt, 0, "subnode2");
 
Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2007-08-29 12:08:48.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2007-08-29 12:08:55.000000000 +1000
@@ -154,7 +154,7 @@
 		while (*p == '/')
 			p++;
 		if (! *p)
-			return -FDT_ERR_BADPATH;
+			return offset;
 		q = strchr(p, '/');
 		if (! q)
 			q = end;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
