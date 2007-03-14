Return-Path: <dgibson@ozlabs.org>
Date: Wed, 14 Mar 2007 11:02:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: [dtc] Add support for flat device tree format version 17
Message-ID: <20070314000240.GD25514@localhost.localdomain>
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

libfdt defined a new version of the flattened device tree format,
version 17.  It is backwards compatible with version 16, just adding
an extra header field giving the size of the blob's structure blob.

This patch adds support to dtc allowing it to read and write version
17 blobs.  It also makes version 17 the default output version for
blobs.

At the same time we change the code to consistently using decimal
numbers for versions.  Previously we sometimes used 16 and sometimes
0x10 to refer to version 16.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c	2007-03-14 11:00:05.000000000 +1100
+++ dtc/dtc.c	2007-03-14 11:01:05.000000000 +1100
@@ -113,7 +113,7 @@ int main(int argc, char *argv[])
 	int opt;
 	FILE *inf = NULL;
 	FILE *outf = NULL;
-	int outversion = 0x10;
+	int outversion = 17;
 	int reservenum = 1;
 	int boot_cpuid_phys = 0xfeedbeef;
 
Index: dtc/flat_dt.h
===================================================================
--- dtc.orig/flat_dt.h	2007-03-14 11:00:06.000000000 +1100
+++ dtc/flat_dt.h	2007-03-14 11:00:06.000000000 +1100
@@ -25,11 +25,15 @@ struct boot_param_header {
 					    booting on */
 	/* version 3 fields below */
         uint32_t size_dt_strings;        /* size of the strings block */
+
+	/* version 17 fields below */
+	uint32_t size_dt_struct;         /* size of the DT structure block */
 };
 
 #define BPH_V1_SIZE	(7*sizeof(uint32_t))
 #define BPH_V2_SIZE	(BPH_V1_SIZE + sizeof(uint32_t))
 #define BPH_V3_SIZE	(BPH_V2_SIZE + sizeof(uint32_t))
+#define BPH_V17_SIZE	(BPH_V3_SIZE + sizeof(uint32_t))
 
 struct reserve_entry {
 	uint64_t address;
Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2007-03-14 11:00:06.000000000 +1100
+++ dtc/flattree.c	2007-03-14 11:00:06.000000000 +1100
@@ -26,6 +26,7 @@
 #define FTF_NAMEPROPS	0x4
 #define FTF_BOOTCPUID	0x8
 #define FTF_STRTABSIZE	0x10
+#define FTF_STRUCTSIZE	0x20
 
 static struct version_info {
 	int version;
@@ -39,8 +40,10 @@ static struct version_info {
 	 FTF_FULLPATH|FTF_VARALIGN|FTF_NAMEPROPS|FTF_BOOTCPUID},
 	{3, 1, BPH_V3_SIZE,
 	 FTF_FULLPATH|FTF_VARALIGN|FTF_NAMEPROPS|FTF_BOOTCPUID|FTF_STRTABSIZE},
-	{0x10, 0x10, BPH_V3_SIZE,
+	{16, 16, BPH_V3_SIZE,
 	 FTF_BOOTCPUID|FTF_STRTABSIZE},
+	{17, 16, BPH_V17_SIZE,
+	 FTF_BOOTCPUID|FTF_STRTABSIZE|FTF_STRUCTSIZE},
 };
 
 struct emitter {
@@ -328,6 +331,8 @@ static void make_bph(struct boot_param_h
 		bph->boot_cpuid_phys = cpu_to_be32(boot_cpuid_phys);
 	if (vi->flags & FTF_STRTABSIZE)
 		bph->size_dt_strings = cpu_to_be32(strsize);
+	if (vi->flags & FTF_STRUCTSIZE)
+		bph->size_dt_struct = cpu_to_be32(dtsize);
 }
 
 void dt_to_blob(FILE *f, struct boot_info *bi, int version,
@@ -742,7 +747,7 @@ static struct node *unflatten_tree(struc
 
 struct boot_info *dt_from_blob(FILE *f)
 {
-	u32 magic, totalsize, version, size_str;
+	u32 magic, totalsize, version, size_str, size_dt;
 	u32 off_dt, off_str, off_mem_rsvmap;
 	int rc;
 	char *blob;
@@ -841,8 +846,15 @@ struct boot_info *dt_from_blob(FILE *f)
 		if (off_str+size_str > totalsize)
 			die("String table extends past total size\n");
 	}
+
+	if (version >= 17) {
+		size_dt = be32_to_cpu(bph->size_dt_struct);
+		fprintf(stderr, "\tsize_dt_struct:\t\t%d\n", size_dt);
+		if (off_dt+size_dt > totalsize)
+			die("Structure block extends past total size\n");
+	}
 			
-	if (version < 0x10) {
+	if (version < 16) {
 		flags |= FTF_FULLPATH | FTF_NAMEPROPS | FTF_VARALIGN;
 	}
 
Index: dtc/ftdump.c
===================================================================
--- dtc.orig/ftdump.c	2007-03-14 11:00:06.000000000 +1100
+++ dtc/ftdump.c	2007-03-14 11:00:06.000000000 +1100
@@ -144,7 +144,7 @@ static void dump_blob(void *blob)
 		}
 		sz = GET_CELL(p);
 		s = p_strings + be32_to_cpu(GET_CELL(p));
-		if (version < 0x10 && sz >= 8)
+		if (version < 16 && sz >= 8)
 			p = PALIGN(p, 8);
 		t = p;
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
