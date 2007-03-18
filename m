Return-Path: <gerald.vanbaren@comcast.net>
Received: from rwcrmhc12.comcast.net (rwcrmhc12.comcast.net [204.127.192.82])
	by ozlabs.org (Postfix) with ESMTP id 6B8E1DDEE5
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 07:49:29 +1100 (EST)
Message-ID: <45FDA5D4.7050004@comcast.net>
Date: Sun, 18 Mar 2007 16:49:24 -0400
From: Jerry Van Baren <gerald.vanbaren@comcast.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] DTC: Improve options handling - respin
References: <45FC1F69.9080204@comcast.net>
	<20070317231337.GA11017@localhost.localdomain>
In-Reply-To: <20070317231337.GA11017@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------020403080407060104070307"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020403080407060104070307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David Gibson wrote:
> On Sat, Mar 17, 2007 at 01:03:37PM -0400, Jerry Van Baren wrote:
>> Hi David, Jon,
>>
>> Here is another fairly trivial patch for dtc.  It adds -h to get the 
>> usage message.  It adds -q (-qq/-qqq) to suppress warnings/errors.
>> It removes the -R option which is advertised but does nothing
>> useful.
> 
> NAK.  -R does do something that I believe is useful.

Hi David, Jon,

I was just seeing if I could get a rise out of you. It worked. ;-)

Attached is a respin of my previous two patches: it adds the -h and -q 
options and #defines the default version but does _not_ delete the -R 
option (left as an exercise for the reader to make it useful :-).

Best regards,
gvb

--------------020403080407060104070307
Content-Type: text/plain;
 name="0001-Improve-options-define-default-version.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Improve-options-define-default-version.txt"

Subject: [PATCH] Improve options, #define default version.

Add -h option for help
Add -q quiet option to reduce or suppress the whining
Create #define for the default version value.

Signed-off-by: vanbaren@cideas.com <vanbaren@cideas.com>
---
 dtc.c      |   23 ++++++++++++++++++-----
 dtc.h      |    5 +++++
 flat_dt.h  |    2 ++
 livetree.c |    9 +++++----
 4 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/dtc.c b/dtc.c
index f15d90f..051a68b 100644
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
@@ -92,7 +96,7 @@ static void usage(void)
 	fprintf(stderr, "\t\t\tdtb - device tree blob\n");
 	fprintf(stderr, "\t\t\tasm - assembler source\n");
 	fprintf(stderr, "\t-V <output version>\n");
-	fprintf(stderr, "\t\tBlob version to produce, defaults to 16 (relevant for dtb\n\t\tand asm output only)\n");
+	fprintf(stderr, "\t\tBlob version to produce, defaults to %d (relevant for dtb\n\t\tand asm output only)\n", OF_DEFAULT_VERSION);
 	fprintf(stderr, "\t-R <number>\n");
 	fprintf(stderr, "\t\tMake space for <number> reserve map entries (relevant for \n\t\tdtb and asm output only)\n");
 	fprintf(stderr, "\t-b <number>\n");
@@ -113,11 +117,13 @@ int main(int argc, char *argv[])
 	int opt;
 	FILE *inf = NULL;
 	FILE *outf = NULL;
-	int outversion = 17;
+	int outversion = OF_DEFAULT_VERSION;
 	int reservenum = 1;
 	int boot_cpuid_phys = 0xfeedbeef;
 
-	while ((opt = getopt(argc, argv, "I:O:o:V:R:fb:")) != EOF) {
+	quiet = 0;
+
+	while ((opt = getopt(argc, argv, "hI:O:o:V:R:fqb:")) != EOF) {
 		switch (opt) {
 		case 'I':
 			inform = optarg;
@@ -137,9 +143,13 @@ int main(int argc, char *argv[])
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
@@ -174,9 +184,12 @@ int main(int argc, char *argv[])
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
diff --git a/flat_dt.h b/flat_dt.h
index d5abd80..a8482b4 100644
--- a/flat_dt.h
+++ b/flat_dt.h
@@ -2,6 +2,8 @@
 #define _FLAT_DT_H_
 
 
+#define OF_DEFAULT_VERSION	17
+
 #define OF_DT_HEADER            0xd00dfeed      /* 4: version, 4: total size */
 
 #define OF_DT_BEGIN_NODE	0x1             /* Start node: full name */
diff --git a/livetree.c b/livetree.c
index 84f2f64..45642dc 100644
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
@@ -512,13 +512,14 @@ static int check_cpus(struct node *root, int outversion, int boot_cpuid_phys)
 			char *eptr;
 
 			unitnum = strtol(get_unitname(cpu), &eptr, 16);
-			if (*eptr)
+			if (*eptr) {
 				WARNMSG("%s has bad format unit name %s (should be CPU number\n",
 					cpu->fullpath, get_unitname(cpu));
-			else if (unitnum != propval_cell(prop))
+			} else if (unitnum != propval_cell(prop)) {
 				WARNMSG("%s unit name \"%s\" does not match \"reg\" property <%x>\n",
 				       cpu->fullpath, get_unitname(cpu),
 				       propval_cell(prop));
+			}
 		}
 
 /* 		CHECK_HAVE_ONECELL(cpu, "d-cache-line-size"); */
-- 
1.4.4.4


--------------020403080407060104070307--
