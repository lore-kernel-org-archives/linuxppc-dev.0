Return-Path: <vanbaren@cideas.com>
Received: from sccrmhc13.comcast.net (sccrmhc13.comcast.net [63.240.77.83])
	by ozlabs.org (Postfix) with ESMTP id CDDE2DDE3D
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 12:05:40 +1000 (EST)
Date: Tue, 17 Apr 2007 22:05:35 -0400
From: Jerry Van Baren <gvb.uboot@gmail.com>
To: linuxppc-dev@ozlabs.org, jdl@jdl.com
Subject: [PATCH: dtc] Improve -S handling
Message-ID: <20070418020535.GA16224@dellserver.lan>
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

If the user requests extra space, pad out the blob (previously the unused
  data was undefined).

Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>
---

Hi Jon, David, Milton,

This improves the -S option to pad out the blob with zeros when the user
asks for extra space.

Best regards,
gvb

 flattree.c |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/flattree.c b/flattree.c
index 151d16e..d2ee0dc 100644
--- a/flattree.c
+++ b/flattree.c
@@ -310,6 +310,7 @@ static struct data flatten_reserve_list(struct reserve_info *reservelist,
 	
 	return d;
 }
+
 static void make_bph(struct boot_param_header *bph,
 		     struct version_info *vi,
 		     int reservesize, int dtsize, int strsize,
@@ -358,12 +359,15 @@ void dt_to_blob(FILE *f, struct boot_info *bi, int version,
 {
 	struct version_info *vi = NULL;
 	int i;
+	int size;
 	struct data dtbuf = empty_data;
 	struct data strbuf = empty_data;
 	struct data reservebuf;
 	struct boot_param_header bph;
 	struct reserve_entry termre = {.address = 0, .size = 0};
 
+	size = 0;
+
 	for (i = 0; i < ARRAY_SIZE(version_table); i++) {
 		if (version_table[i].version == version)
 			vi = &version_table[i];
@@ -384,10 +388,13 @@ void dt_to_blob(FILE *f, struct boot_info *bi, int version,
 		 boot_cpuid_phys);
 
 	fwrite(&bph, vi->hdr_size, 1, f);
+	size += vi->hdr_size;
 
 	/* Align the reserve map to an 8 byte boundary */
-	for (i = vi->hdr_size; i < be32_to_cpu(bph.off_mem_rsvmap); i++)
+	for (i = vi->hdr_size; i < be32_to_cpu(bph.off_mem_rsvmap); i++) {
 		fputc(0, f);
+		size += 1;
+	}
 
 	/*
 	 * Reserve map entries.
@@ -396,9 +403,27 @@ void dt_to_blob(FILE *f, struct boot_info *bi, int version,
 	 */
 	fwrite(reservebuf.val, reservebuf.len, 1, f);
 	fwrite(&termre, sizeof(termre), 1, f);
+	size += reservebuf.len + sizeof(termre);
 
 	fwrite(dtbuf.val, dtbuf.len, 1, f);
 	fwrite(strbuf.val, strbuf.len, 1, f);
+	size += dtbuf.len + strbuf.len;
+
+	/*
+	 * If the user asked for more space than is used, pad it out.
+	 */
+	if (minsize > 0) {
+		int padlen = minsize - size;
+
+		if (padlen > 0) {
+			char *zeroes = calloc(padlen, 1);
+
+			if (zeroes != NULL) {
+				fwrite(zeroes, padlen, 1, f);
+				free(zeroes);
+			}
+		}
+	}
 
 	if (ferror(f))
 		die("Error writing device tree blob: %s\n", strerror(errno));
@@ -504,6 +529,14 @@ void dt_to_asm(FILE *f, struct boot_info *bi, int version, int boot_cpuid_phys)
 
 	emit_label(f, symprefix, "blob_end");
 
+	/*
+	 * If the user asked for more space than is used, pad it out.
+	 */
+	if (minsize > 0) {
+		fprintf(f, "\t.space\t%d - (%s_blob_end - %s_blob_start), 0\n", 
+			minsize, symprefix, symprefix);
+	}
+
 	data_free(strbuf);
 }
 
-- 
1.4.4.4
