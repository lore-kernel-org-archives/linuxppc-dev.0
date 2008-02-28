Return-Path: <dgibson@ozlabs.org>
Date: Thu, 28 Feb 2008 20:55:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Test and fix conversion to/from old dtb versions
Message-ID: <20080228095537.GN24330@localhost.localdomain>
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

This patch adds testcases which test dtc when used to convert between
different dtb versions.  These tests uncovered a couple of bugs
handling old dtb versions, which are also fixed.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2008-02-28 16:58:46.000000000 +1100
+++ dtc/tests/run_tests.sh	2008-02-28 20:53:39.000000000 +1100
@@ -173,6 +173,19 @@
 	run_test dtbs_equal_ordered $tree odts_$tree.test.dtb
     done
 
+    # Check version conversions
+    for tree in test_tree1.dtb ; do
+	 for aver in 1 2 3 16 17; do
+	     atree="ov${aver}_$tree.test.dtb"
+	     run_test dtc.sh -I dtb -O dtb -V$aver -o $atree $tree
+	     for bver in 16 17; do
+		 btree="ov${bver}_$atree"
+		 run_test dtc.sh -I dtb -O dtb -V$bver -o $btree $atree
+		 run_test dtbs_equal_ordered $btree $tree
+	     done
+	 done
+    done
+
     # Check some checks
     run_test dtc-checkfails.sh duplicate_node_names -- -I dts -O dtb dup-nodename.dts
     run_test dtc-checkfails.sh duplicate_property_names -- -I dts -O dtb dup-propname.dts
Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2008-02-28 17:02:36.000000000 +1100
+++ dtc/flattree.c	2008-02-28 20:53:39.000000000 +1100
@@ -410,7 +410,7 @@
 	 * the reserve buffer, add the reserve map terminating zeroes,
 	 * the device tree itself, and finally the strings.
 	 */
-	blob = data_append_data(blob, &fdt, sizeof(fdt));
+	blob = data_append_data(blob, &fdt, vi->hdr_size);
 	blob = data_append_align(blob, 8);
 	blob = data_merge(blob, reservebuf);
 	blob = data_append_zeroes(blob, sizeof(struct fdt_reserve_entry));
@@ -809,7 +809,7 @@
 
 struct boot_info *dt_from_blob(FILE *f)
 {
-	u32 magic, totalsize, version, size_str, size_dt;
+	u32 magic, totalsize, version, size_dt;
 	u32 off_dt, off_str, off_mem_rsvmap;
 	int rc;
 	char *blob;
@@ -889,11 +889,13 @@
 	if (off_str > totalsize)
 		die("String table offset exceeds total size\n");
 
-	size_str = -1;
 	if (version >= 3) {
-		size_str = be32_to_cpu(fdt->size_dt_strings);
+		u32 size_str = be32_to_cpu(fdt->size_dt_strings);
 		if (off_str+size_str > totalsize)
 			die("String table extends past total size\n");
+		inbuf_init(&strbuf, blob + off_str, blob + off_str + size_str);
+	} else {
+		inbuf_init(&strbuf, blob + off_str, blob + totalsize);
 	}
 
 	if (version >= 17) {
@@ -911,10 +913,6 @@
 	inbuf_init(&memresvbuf,
 		   blob + off_mem_rsvmap, blob + totalsize);
 	inbuf_init(&dtbuf, blob + off_dt, blob + totalsize);
-	if (size_str >= 0)
-		inbuf_init(&strbuf, blob + off_str, blob + off_str + size_str);
-	else
-		inbuf_init(&strbuf, blob + off_str, blob + totalsize);
 
 	reservelist = flat_read_mem_reserve(&memresvbuf);
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
