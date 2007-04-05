Return-Path: <vanbaren@cideas.com>
Date: Wed, 4 Apr 2007 22:04:33 -0400
From: Jerry Van Baren <gvb.uboot@gmail.com>
To: jdl@jdl.com
Subject: [PATCH dtc] Implement the -R option and add a -S option.
Message-ID: <20070405020433.GA13891@dellserver.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Implement the -R <number> option to add memory reserve slots.
Add a -S <size> option makes the blob at least this number of bytes.

Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>
---
 dtc.c      |   19 ++++++++++++++++---
 dtc.h      |    6 ++++--
 flattree.c |   22 ++++++++++++++++++++--
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/dtc.c b/dtc.c
index a009605..a94a402 100644
--- a/dtc.c
+++ b/dtc.c
@@ -21,6 +21,13 @@
 #include "dtc.h"
 #include "srcpos.h"
 
+/*
+ * Command line options
+ */
+int quiet;		/* Level of quietness */
+int reservenum;		/* Number of memory reservation slots */
+int minsize;		/* Minimum blob size */
+
 char *join_path(char *path, char *name)
 {
 	int lenp = strlen(path);
@@ -85,6 +92,8 @@ static void usage(void)
 	fprintf(stderr, "\t\tBlob version to produce, defaults to %d (relevant for dtb\n\t\tand asm output only)\n", OF_DEFAULT_VERSION);
 	fprintf(stderr, "\t-R <number>\n");
 	fprintf(stderr, "\t\tMake space for <number> reserve map entries (relevant for \n\t\tdtb and asm output only)\n");
+	fprintf(stderr, "\t-S <bytes>\n");
+	fprintf(stderr, "\t\tMake the blob at least <bytes> long (extra space)\n");
 	fprintf(stderr, "\t-b <number>\n");
 	fprintf(stderr, "\t\tSet the physical boot cpu\n");
 	fprintf(stderr, "\t-f\n");
@@ -104,12 +113,13 @@ int main(int argc, char *argv[])
 	FILE *inf = NULL;
 	FILE *outf = NULL;
 	int outversion = OF_DEFAULT_VERSION;
-	int reservenum = 1;
 	int boot_cpuid_phys = 0xfeedbeef;
 
-	quiet = 0;
+	quiet      = 0;
+	reservenum = 0;
+	minsize    = 0;
 
-	while ((opt = getopt(argc, argv, "hI:O:o:V:R:fqb:")) != EOF) {
+	while ((opt = getopt(argc, argv, "hI:O:o:V:R:S:fqb:")) != EOF) {
 		switch (opt) {
 		case 'I':
 			inform = optarg;
@@ -126,6 +136,9 @@ int main(int argc, char *argv[])
 		case 'R':
 			reservenum = strtol(optarg, NULL, 0);
 			break;
+		case 'S':
+			minsize = strtol(optarg, NULL, 0);
+			break;
 		case 'f':
 			force = 1;
 			break;
diff --git a/dtc.h b/dtc.h
index 7ed3df2..8cfe1a1 100644
--- a/dtc.h
+++ b/dtc.h
@@ -37,9 +37,11 @@
 #include "flat_dt.h"
 
 /*
- * Level of quietness
+ * Command line options
  */
-int quiet;
+extern int quiet;		/* Level of quietness */
+extern int reservenum;		/* Number of memory reservation slots */
+extern int minsize;		/* Minimum blob size */
 
 static inline void die(char * str, ...)
 {
diff --git a/flattree.c b/flattree.c
index 780142f..151d16e 100644
--- a/flattree.c
+++ b/flattree.c
@@ -295,10 +295,18 @@ static struct data flatten_reserve_list(struct reserve_info *reservelist,
 {
 	struct reserve_info *re;
 	struct data d = empty_data;
+	static struct reserve_entry null_re = {0,0};
+	int    j;
 
 	for (re = reservelist; re; re = re->next) {
 		d = data_append_re(d, &re->re);
 	}
+	/*
+	 * Add additional reserved slots if the user asked for them.
+	 */
+	for (j = 0; j < reservenum; j++) {
+		d = data_append_re(d, &null_re);
+	}
 	
 	return d;
 }
@@ -324,8 +332,18 @@ static void make_bph(struct boot_param_header *bph,
 	bph->off_dt_struct = cpu_to_be32(reserve_off + reservesize);
 	bph->off_dt_strings = cpu_to_be32(reserve_off + reservesize
 					  + dtsize);
-	bph->totalsize = cpu_to_be32(reserve_off + reservesize
-				     + dtsize + strsize);
+	bph->totalsize = reserve_off + reservesize + dtsize + strsize;
+	if (minsize > 0) {
+		if (bph->totalsize >= minsize) {
+			if (quiet < 1)
+				fprintf(stderr,
+					"Warning: blob size %d >= minimum size %d\n",
+					bph->totalsize, minsize);
+
+		} else
+			bph->totalsize = minsize;
+	}
+	bph->totalsize = cpu_to_be32(bph->totalsize);
 		
 	if (vi->flags & FTF_BOOTCPUID)
 		bph->boot_cpuid_phys = cpu_to_be32(boot_cpuid_phys);
-- 
1.4.4.4
