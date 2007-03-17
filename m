Return-Path: <gerald.vanbaren@comcast.net>
Received: from rwcrmhc13.comcast.net (rwcrmhc13.comcast.net [216.148.227.153])
	by ozlabs.org (Postfix) with ESMTP id C42A2DDDDB
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Mar 2007 04:03:39 +1100 (EST)
Message-ID: <45FC1F69.9080204@comcast.net>
Date: Sat, 17 Mar 2007 13:03:37 -0400
From: Jerry Van Baren <gerald.vanbaren@comcast.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] DTC: Improve options handling
Content-Type: multipart/mixed; boundary="------------090303020609000003040708"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090303020609000003040708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi David, Jon,

Here is another fairly trivial patch for dtc.  It adds -h to get the 
usage message.  It adds -q (-qq/-qqq) to suppress warnings/errors.
It removes the -R option which is advertised but does nothing useful.

Best regards,
gvb

--------------090303020609000003040708
Content-Type: text/plain;
 name="0001-Improve-options-handling.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Improve-options-handling.txt"

Subject: [PATCH] Improve options handling

Remove unused -R option
Add -h option for help
Add -q quiet option to reduce or suppress the whining

Signed-off-by: vanbaren@cideas.com <vanbaren@cideas.com>
---
 dtc.c      |   24 ++++++++++++++++--------
 dtc.h      |    5 +++++
 livetree.c |   10 ++++++----
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/dtc.c b/dtc.c
index f15d90f..dc0077b 100644
--- a/dtc.c
+++ b/dtc.c
@@ -81,6 +81,10 @@ static void usage(void)
 	fprintf(stderr, "Usage:\n");
 	fprintf(stderr, "\tdtc [options] <input file>\n");
 	fprintf(stderr, "\nOptions:\n");
+	fprintf(stderr, "\t-h\n");
+	fprintf(stderr, "\t\tThis help text\n");
+	fprintf(stderr, "\t-q\n");
+	fprintf(stderr, "\t\tQuiet: -q suppress warnings, -qq errors, -qqq all\n");
 	fprintf(stderr, "\t-I <input format>\n");
 	fprintf(stderr, "\t\tInput formats are:\n");
 	fprintf(stderr, "\t\t\tdts - device tree source text\n");
@@ -93,7 +97,6 @@ static void usage(void)
 	fprintf(stderr, "\t\t\tasm - assembler source\n");
 	fprintf(stderr, "\t-V <output version>\n");
 	fprintf(stderr, "\t\tBlob version to produce, defaults to 16 (relevant for dtb\n\t\tand asm output only)\n");
-	fprintf(stderr, "\t-R <number>\n");
 	fprintf(stderr, "\t\tMake space for <number> reserve map entries (relevant for \n\t\tdtb and asm output only)\n");
 	fprintf(stderr, "\t-b <number>\n");
 	fprintf(stderr, "\t\tSet the physical boot cpu\n");
@@ -114,10 +117,11 @@ int main(int argc, char *argv[])
 	FILE *inf = NULL;
 	FILE *outf = NULL;
 	int outversion = 17;
-	int reservenum = 1;
 	int boot_cpuid_phys = 0xfeedbeef;
 
-	while ((opt = getopt(argc, argv, "I:O:o:V:R:fb:")) != EOF) {
+	quiet = 0;
+
+	while ((opt = getopt(argc, argv, "hI:O:o:V:fqb:")) != EOF) {
 		switch (opt) {
 		case 'I':
 			inform = optarg;
@@ -131,15 +135,16 @@ int main(int argc, char *argv[])
 		case 'V':
 			outversion = strtol(optarg, NULL, 0);
 			break;
-		case 'R':
-			reservenum = strtol(optarg, NULL, 0);
-			break;
 		case 'f':
 			force = 1;
 			break;
+		case 'q':
+			quiet++;
+			break;
 		case 'b':
 			boot_cpuid_phys = strtol(optarg, NULL, 0);
 			break;
+		case 'h':
 		default:
 			usage();
 		}
@@ -174,9 +179,12 @@ int main(int argc, char *argv[])
 		die("Couldn't read input tree\n");
 
 	if (! check_device_tree(bi->dt, outversion, boot_cpuid_phys)) {
-		fprintf(stderr, "Input tree has errors\n");
-		if (! force)
+		if ((force) && (quiet < 3))
+			fprintf(stderr, "Input tree has errors, output forced\n");
+		if (! force) {
+			fprintf(stderr, "Input tree has errors, not writing output (use -f to force output)\n");
 			exit(1);
+		}
 	}
 
 	if (streq(outname, "-")) {
diff --git a/dtc.h b/dtc.h
index 8d3964c..e3e2863 100644
--- a/dtc.h
+++ b/dtc.h
@@ -36,6 +36,11 @@
 
 #include "flat_dt.h"
 
+/*
+ * Level of quietness
+ */
+int quiet;
+
 static inline void die(char * str, ...)
 {
 	va_list ap;
diff --git a/livetree.c b/livetree.c
index 84f2f64..f7b6108 100644
--- a/livetree.c
+++ b/livetree.c
@@ -252,8 +252,8 @@ static struct node *get_node_by_phandle(struct node *tree, cell_t phandle)
  * Tree checking functions
  */
 
-#define ERRMSG(...) fprintf(stderr, "ERROR: " __VA_ARGS__)
-#define WARNMSG(...) fprintf(stderr, "Warning: " __VA_ARGS__)
+#define ERRMSG(...) if (quiet < 2) fprintf(stderr, "ERROR: " __VA_ARGS__)
+#define WARNMSG(...) if (quiet < 1) fprintf(stderr, "Warning: " __VA_ARGS__)
 
 static int must_be_one_cell(struct property *prop, struct node *node)
 {
@@ -512,13 +512,15 @@ static int check_cpus(struct node *root, int outversion, int boot_cpuid_phys)
 			char *eptr;
 
 			unitnum = strtol(get_unitname(cpu), &eptr, 16);
-			if (*eptr)
+			if (*eptr) {
 				WARNMSG("%s has bad format unit name %s (should be CPU number\n",
 					cpu->fullpath, get_unitname(cpu));
-			else if (unitnum != propval_cell(prop))
+			}
+			else if (unitnum != propval_cell(prop)) {
 				WARNMSG("%s unit name \"%s\" does not match \"reg\" property <%x>\n",
 				       cpu->fullpath, get_unitname(cpu),
 				       propval_cell(prop));
+			}
 		}
 
 /* 		CHECK_HAVE_ONECELL(cpu, "d-cache-line-size"); */
-- 
1.4.4.4


--------------090303020609000003040708--
