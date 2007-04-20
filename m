Return-Path: <vanbaren@cideas.com>
Received: from alnrmhc12.comcast.net (alnrmhc12.comcast.net [204.127.225.92])
	by ozlabs.org (Postfix) with ESMTP id 0750BDDD0A
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2007 12:22:38 +1000 (EST)
Date: Thu, 19 Apr 2007 22:22:35 -0400
From: Jerry Van Baren <gvb.uboot@gmail.com>
To: linuxppc-dev@ozlabs.org, jdl@jdl.com,
	u-boot-users@lists.sourceforge.net
Subject: [PATCH] Fix the -S to modify the totalsize properly.
Message-ID: <20070420022235.GA1703@dellserver.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With the last improvement to pad out the blob, I broke the blob
header totalsize adjustment.  The adjustment was moved up in the
code before the memory image of the blob is created.

Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>
---

Hi Jon,

This fixes my header totalsize screwup.  Until this is applied, the -S
adds padding but is not effective.

My apologies,
gvb


 flattree.c |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/flattree.c b/flattree.c
index 913b02f..b54f7ef 100644
--- a/flattree.c
+++ b/flattree.c
@@ -353,6 +353,7 @@ void dt_to_blob(FILE *f, struct boot_info *bi, int version,
 	struct data dtbuf      = empty_data;
 	struct data strbuf     = empty_data;
 	struct boot_param_header bph;
+	int padlen;
 
 	for (i = 0; i < ARRAY_SIZE(version_table); i++) {
 		if (version_table[i].version == version)
@@ -371,6 +372,19 @@ void dt_to_blob(FILE *f, struct boot_info *bi, int version,
 		 boot_cpuid_phys);
 
 	/*
+	 * If the user asked for more space than is used, adjust the totalsize.
+	 */
+	padlen = minsize - be32_to_cpu(bph.totalsize);
+	if (padlen > 0) {
+		bph.totalsize = cpu_to_be32(minsize);
+	} else {
+		if ((minsize > 0) && (quiet < 1))
+			fprintf(stderr,
+				"Warning: blob size %d >= minimum size %d\n",
+				be32_to_cpu(bph.totalsize), minsize);
+	}
+
+	/*
 	 * Assemble the blob: start with the header, add with alignment
 	 * the reserve buffer, add the reserve map terminating zeroes,
 	 * the device tree itself, and finally the strings.
@@ -385,18 +399,9 @@ void dt_to_blob(FILE *f, struct boot_info *bi, int version,
 	/*
 	 * If the user asked for more space than is used, pad out the blob.
 	 */
-	if (minsize > 0) {
-		int padlen = minsize - be32_to_cpu(bph.totalsize);
-
-		if (padlen > 0) {
-			blob = data_append_zeroes(blob, padlen);
-			bph.totalsize = cpu_to_be32(minsize);
-		} else {
-			if (quiet < 1)
-				fprintf(stderr,
-					"Warning: blob size %d >= minimum size %d\n",
-					be32_to_cpu(bph.totalsize), minsize);
-		}
+	if (padlen > 0) {
+		blob = data_append_zeroes(blob, padlen);
+		bph.totalsize = cpu_to_be32(minsize);
 	}
 
 	fwrite(blob.val, blob.len, 1, f);
-- 
1.4.4.4
