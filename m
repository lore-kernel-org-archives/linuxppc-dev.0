Return-Path: <vanbaren@cideas.com>
Received: from alnrmhc16.comcast.net (alnrmhc16.comcast.net [204.127.225.96])
	by ozlabs.org (Postfix) with ESMTP id 8381DDDDF4
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2007 11:59:54 +1000 (EST)
Date: Wed, 18 Apr 2007 21:59:51 -0400
From: Jerry Van Baren <gvb.uboot@gmail.com>
To: linuxppc-dev@ozlabs.org, u-boot-users@lists.sourceforge.net,
	jdl@jdl.com
Subject: [PATCH: dtc take 2] Assemble the blob in memory before writing it out.
Message-ID: <20070419015951.GA9339@dellserver.lan>
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

This makes padding out the blob if the user requested extra size much
easer.  The assembly and writing to the file is more straight forward too.

Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>
---

Hi David, Jon,

I wasn't happy with David's suggestion on the -S handling.  I also wasn't
all that wild about how the blob was assembled and then written to the
file piecemeal with "ad-hoc" alignment padding.  I realized I could fix
both by assembling the blob in memory as a "struct data" and then write
the whole thing out in one fell swoop.

Makes it a lot simpler and cleaner to my eyes.

Hope y'all agree,
gvb


 flattree.c |   82 +++++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 48 insertions(+), 34 deletions(-)

diff --git a/flattree.c b/flattree.c
index 151d16e..caff758 100644
--- a/flattree.c
+++ b/flattree.c
@@ -310,6 +310,7 @@ static struct data flatten_reserve_list(struct reserve_info *reservelist,
 	
 	return d;
 }
+
 static void make_bph(struct boot_param_header *bph,
 		     struct version_info *vi,
 		     int reservesize, int dtsize, int strsize,
@@ -332,19 +333,8 @@ static void make_bph(struct boot_param_header *bph,
 	bph->off_dt_struct = cpu_to_be32(reserve_off + reservesize);
 	bph->off_dt_strings = cpu_to_be32(reserve_off + reservesize
 					  + dtsize);
-	bph->totalsize = reserve_off + reservesize + dtsize + strsize;
-	if (minsize > 0) {
-		if (bph->totalsize >= minsize) {
-			if (quiet < 1)
-				fprintf(stderr,
-					"Warning: blob size %d >= minimum size %d\n",
-					bph->totalsize, minsize);
+	bph->totalsize = cpu_to_be32(reserve_off + reservesize + dtsize + strsize);
 
-		} else
-			bph->totalsize = minsize;
-	}
-	bph->totalsize = cpu_to_be32(bph->totalsize);
-		
 	if (vi->flags & FTF_BOOTCPUID)
 		bph->boot_cpuid_phys = cpu_to_be32(boot_cpuid_phys);
 	if (vi->flags & FTF_STRTABSIZE)
@@ -358,11 +348,11 @@ void dt_to_blob(FILE *f, struct boot_info *bi, int version,
 {
 	struct version_info *vi = NULL;
 	int i;
-	struct data dtbuf = empty_data;
-	struct data strbuf = empty_data;
-	struct data reservebuf;
+	struct data blob       = empty_data;
+	struct data reservebuf = empty_data;
+	struct data dtbuf      = empty_data;
+	struct data strbuf     = empty_data;
 	struct boot_param_header bph;
-	struct reserve_entry termre = {.address = 0, .size = 0};
 
 	for (i = 0; i < ARRAY_SIZE(version_table); i++) {
 		if (version_table[i].version == version)
@@ -371,9 +361,6 @@ void dt_to_blob(FILE *f, struct boot_info *bi, int version,
 	if (!vi)
 		die("Unknown device tree blob version %d\n", version);
 
-	dtbuf = empty_data;
-	strbuf = empty_data;
-
 	flatten_tree(bi->dt, &bin_emitter, &dtbuf, &strbuf, vi);
 	bin_emit_cell(&dtbuf, OF_DT_END);
 
@@ -383,28 +370,46 @@ void dt_to_blob(FILE *f, struct boot_info *bi, int version,
 	make_bph(&bph, vi, reservebuf.len, dtbuf.len, strbuf.len,
 		 boot_cpuid_phys);
 
-	fwrite(&bph, vi->hdr_size, 1, f);
-
-	/* Align the reserve map to an 8 byte boundary */
-	for (i = vi->hdr_size; i < be32_to_cpu(bph.off_mem_rsvmap); i++)
-		fputc(0, f);
+	/*
+	 * Assemble the blob: start with the header, add with alignment
+	 * the reserve buffer, add the reserve map terminating zeroes,
+	 * the device tree itself, and finally the strings.
+	 */
+	blob = data_append_data(blob, &bph, sizeof(bph));
+	blob = data_append_align(blob, 8);
+	blob = data_merge(blob, reservebuf);
+	blob = data_append_zeroes(blob, sizeof(struct reserve_entry));
+	blob = data_merge(blob, dtbuf);
+	blob = data_merge(blob, strbuf);
 
 	/*
-	 * Reserve map entries.
-	 * Each entry is an (address, size) pair of u64 values.
-	 * Always supply a zero-sized temination entry.
+	 * If the user asked for more space than is used, pad out the blob.
 	 */
-	fwrite(reservebuf.val, reservebuf.len, 1, f);
-	fwrite(&termre, sizeof(termre), 1, f);
+	if (minsize > 0) {
+		int padlen = minsize - be32_to_cpu(bph.totalsize);
+
+fprintf(stderr, "minsize = %d, totalsize = %d, padlen = %d\n", minsize, be32_to_cpu(bph.totalsize), padlen);
+		if (padlen > 0) {
+			blob = data_append_zeroes(blob, padlen);
+			bph.totalsize = cpu_to_be32(minsize);
+		} else {
+			if (quiet < 1)
+				fprintf(stderr,
+					"Warning: blob size %d >= minimum size %d\n",
+					be32_to_cpu(bph.totalsize), minsize);
+		}
+	}
 
-	fwrite(dtbuf.val, dtbuf.len, 1, f);
-	fwrite(strbuf.val, strbuf.len, 1, f);
+	fwrite(blob.val, blob.len, 1, f);
 
 	if (ferror(f))
 		die("Error writing device tree blob: %s\n", strerror(errno));
 
-	data_free(dtbuf);
-	data_free(strbuf);
+	/*
+	 * data_merge() frees the right-hand element so only the blob
+	 * remains to be freed.
+	 */
+	data_free(blob);
 }
 
 static void dump_stringtable_asm(FILE *f, struct data strbuf)
@@ -447,7 +452,7 @@ void dt_to_asm(FILE *f, struct boot_info *bi, int version, int boot_cpuid_phys)
 	emit_label(f, symprefix, "blob_start");
 	emit_label(f, symprefix, "header");
 	fprintf(f, "\t.long\tOF_DT_HEADER /* magic */\n");
-	fprintf(f, "\t.long\t_%s_blob_end - _%s_blob_start /* totalsize */\n",
+	fprintf(f, "\t.long\t_%s_blob_abs_end - _%s_blob_start /* totalsize */\n",
 		symprefix, symprefix);
 	fprintf(f, "\t.long\t_%s_struct_start - _%s_blob_start /* off_dt_struct */\n",
 		symprefix, symprefix);
@@ -504,6 +509,15 @@ void dt_to_asm(FILE *f, struct boot_info *bi, int version, int boot_cpuid_phys)
 
 	emit_label(f, symprefix, "blob_end");
 
+	/*
+	 * If the user asked for more space than is used, pad it out.
+	 */
+	if (minsize > 0) {
+		fprintf(f, "\t.space\t%d - (_%s_blob_end - _%s_blob_start), 0\n", 
+			minsize, symprefix, symprefix);
+	}
+	emit_label(f, symprefix, "blob_abs_end");
+
 	data_free(strbuf);
 }
 
-- 
1.4.4.4
