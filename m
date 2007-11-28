Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F9D0DDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 03:22:58 +1100 (EST)
Date: Wed, 28 Nov 2007 10:21:12 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH][DTC] Add an option to pad the blob that is generated
Message-ID: <Pine.LNX.4.64.0711281020240.5095@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are times when we need extra space in the blob and just want
to have it added on w/o know the exact size to make it.

The padding and min size options are mutually exclusive.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 dtc.c      |   14 +++++++++++++-
 dtc.h      |    1 +
 flattree.c |   20 +++++++++++++-------
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/dtc.c b/dtc.c
index 602b296..cf9a6a9 100644
--- a/dtc.c
+++ b/dtc.c
@@ -29,6 +29,7 @@
 int quiet;		/* Level of quietness */
 int reservenum;		/* Number of memory reservation slots */
 int minsize;		/* Minimum blob size */
+int padsize;		/* Additional padding to blob */

 char *join_path(char *path, char *name)
 {
@@ -97,6 +98,8 @@ static void  __attribute__ ((noreturn)) usage(void)
 	fprintf(stderr, "\t\tMake space for <number> reserve map entries (relevant for \n\t\tdtb and asm output only)\n");
 	fprintf(stderr, "\t-S <bytes>\n");
 	fprintf(stderr, "\t\tMake the blob at least <bytes> long (extra space)\n");
+	fprintf(stderr, "\t-p <bytes>\n");
+	fprintf(stderr, "\t\tAdd padding to the blob of <bytes> long (extra space)\n");
 	fprintf(stderr, "\t-b <number>\n");
 	fprintf(stderr, "\t\tSet the physical boot cpu\n");
 	fprintf(stderr, "\t-f\n");
@@ -124,8 +127,9 @@ int main(int argc, char *argv[])
 	quiet      = 0;
 	reservenum = 0;
 	minsize    = 0;
+	padsize    = 0;

-	while ((opt = getopt(argc, argv, "hI:O:o:V:R:S:fcqb:v")) != EOF) {
+	while ((opt = getopt(argc, argv, "hI:O:o:V:R:S:p:fcqb:v")) != EOF) {
 		switch (opt) {
 		case 'I':
 			inform = optarg;
@@ -145,6 +149,9 @@ int main(int argc, char *argv[])
 		case 'S':
 			minsize = strtol(optarg, NULL, 0);
 			break;
+		case 'p':
+			padsize = strtol(optarg, NULL, 0);
+			break;
 		case 'f':
 			force = 1;
 			break;
@@ -173,6 +180,11 @@ int main(int argc, char *argv[])
 	else
 		arg = argv[optind];

+	/* minsize and padsize are mutually exclusive */
+	if ((minsize) && (padsize)) {
+		die("Can't set both -p and -S\n");
+	}
+
 	fprintf(stderr, "DTC: %s->%s  on file \"%s\"\n",
 		inform, outform, arg);

diff --git a/dtc.h b/dtc.h
index d080153..0100ad1 100644
--- a/dtc.h
+++ b/dtc.h
@@ -43,6 +43,7 @@
 extern int quiet;		/* Level of quietness */
 extern int reservenum;		/* Number of memory reservation slots */
 extern int minsize;		/* Minimum blob size */
+extern int padsize;		/* Additional padding to blob */

 static inline void __attribute__((noreturn)) die(char * str, ...)
 {
diff --git a/flattree.c b/flattree.c
index 5889900..3c13566 100644
--- a/flattree.c
+++ b/flattree.c
@@ -366,7 +366,7 @@ void dt_to_blob(FILE *f, struct boot_info *bi, int version,
 	struct data dtbuf      = empty_data;
 	struct data strbuf     = empty_data;
 	struct fdt_header fdt;
-	int padlen;
+	int padlen = 0;

 	for (i = 0; i < ARRAY_SIZE(version_table); i++) {
 		if (version_table[i].version == version)
@@ -387,16 +387,17 @@ void dt_to_blob(FILE *f, struct boot_info *bi, int version,
 	/*
 	 * If the user asked for more space than is used, adjust the totalsize.
 	 */
-	padlen = minsize - be32_to_cpu(fdt.totalsize);
-	if (padlen > 0) {
-		fdt.totalsize = cpu_to_be32(minsize);
-	} else {
-		if ((minsize > 0) && (quiet < 1))
+	if (minsize > 0) {
+		padlen = minsize - be32_to_cpu(fdt.totalsize);
+		if ((padlen < 0) && (quiet < 1))
 			fprintf(stderr,
 				"Warning: blob size %d >= minimum size %d\n",
 				be32_to_cpu(fdt.totalsize), minsize);
 	}

+	if (padsize > 0)
+		padlen = padsize;
+
 	/*
 	 * Assemble the blob: start with the header, add with alignment
 	 * the reserve buffer, add the reserve map terminating zeroes,
@@ -413,8 +414,10 @@ void dt_to_blob(FILE *f, struct boot_info *bi, int version,
 	 * If the user asked for more space than is used, pad out the blob.
 	 */
 	if (padlen > 0) {
+		int tsize = be32_to_cpu(fdt.totalsize);
+		tsize += padlen;
 		blob = data_append_zeroes(blob, padlen);
-		fdt.totalsize = cpu_to_be32(minsize);
+		fdt.totalsize = cpu_to_be32(tsize);
 	}

 	fwrite(blob.val, blob.len, 1, f);
@@ -544,6 +547,9 @@ void dt_to_asm(FILE *f, struct boot_info *bi, int version, int boot_cpuid_phys)
 		fprintf(f, "\t.space\t%d - (_%s_blob_end - _%s_blob_start), 0\n",
 			minsize, symprefix, symprefix);
 	}
+	if (padsize > 0) {
+		fprintf(f, "\t.space\t%d, 0\n", padsize);
+	}
 	emit_label(f, symprefix, "blob_abs_end");

 	data_free(strbuf);
-- 
1.5.3.4
