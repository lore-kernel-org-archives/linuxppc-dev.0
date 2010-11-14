Return-Path: <jkenisto@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AAA50B73A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Nov 2010 15:15:52 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAE440L5025137
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 21:04:00 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAE4FYcw220146
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 21:15:36 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAE4FYmP025219
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 21:15:34 -0700
Received: from localhost.localdomain (w-jimk.beaverton.ibm.com [9.47.28.66])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	oAE4FXSG025207
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Nov 2010 21:15:33 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
Subject: [PATCH 4/6] nvram: Add compression to fit more printk output into
	NVRAM
To: linuxppc-dev@lists.ozlabs.org
Date: Sat, 13 Nov 2010 20:15:33 -0800
Message-ID: <20101114041533.9457.1431.stgit@localhost.localdomain>
In-Reply-To: <20101114041510.9457.92921.stgit@localhost.localdomain>
References: <20101114041510.9457.92921.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Capture more than twice as much text from the printk buffer, and
compress it to fit it in the ibm,oops-log NVRAM partition.

Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>
---

 arch/powerpc/include/asm/rtas.h        |    6 +
 arch/powerpc/platforms/pseries/nvram.c |  195 ++++++++++++++++++++++++++++----
 2 files changed, 177 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 3d35f8a..6e0f4b5 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -205,10 +205,12 @@ extern void pSeries_log_error(char *buf, unsigned int err_type, int fatal);
 #define ERR_FLAG_ALREADY_LOGGED	0x0
 #define ERR_FLAG_BOOT		0x1 	/* log was pulled from NVRAM on boot */
 #define ERR_TYPE_RTAS_LOG	0x2	/* from rtas event-scan */
-#define ERR_TYPE_KERNEL_PANIC	0x4	/* from panic() */
+#define ERR_TYPE_KERNEL_PANIC	0x4	/* from die()/panic() */
+#define ERR_TYPE_KERNEL_PANIC_GZ 0x8	/* ditto, compressed */
 
 /* All the types and not flags */
-#define ERR_TYPE_MASK	(ERR_TYPE_RTAS_LOG | ERR_TYPE_KERNEL_PANIC)
+#define ERR_TYPE_MASK \
+	(ERR_TYPE_RTAS_LOG | ERR_TYPE_KERNEL_PANIC | ERR_TYPE_KERNEL_PANIC_GZ)
 
 #define RTAS_DEBUG KERN_DEBUG "RTAS: "
  
diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index e1bc1a4..8e5ed74 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -17,7 +17,10 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/ctype.h>
 #include <linux/kmsg_dump.h>
+#include <linux/zlib.h>
 #include <asm/uaccess.h>
 #include <asm/nvram.h>
 #include <asm/rtas.h>
@@ -74,9 +77,24 @@ static struct kmsg_dumper nvram_kmsg_dumper = {
 	.dump = oops_to_nvram
 };
 
-/* We preallocate oops_buf during init to avoid kmalloc during oops/panic. */
-static size_t oops_buf_sz;
-static char *oops_buf;
+/*
+ * big_oops_buf[] holds the uncompressed text we're capturing.  little_oops_buf
+ * holds the compressed text, plus its length.  little_oops_buf gets written
+ * to NVRAM.
+ *
+ * We preallocate these buffers during init to avoid kmalloc during oops/panic.
+ */
+static size_t big_oops_buf_sz, little_oops_buf_sz;
+static char *big_oops_buf;
+
+static struct oops_parition_data {
+#define OOPS_PTN_PREFIX_SZ sizeof(unsigned short)
+	unsigned short length;
+	char buf[0];
+} *little_oops_buf;
+
+#define COMPR_LEVEL 6
+static struct z_stream_s stream;
 
 static ssize_t pSeries_nvram_read(char *buf, size_t count, loff_t *index)
 {
@@ -374,13 +392,42 @@ static void __init nvram_init_oops_partition(int rtas_partition_exists)
 		memcpy(&oops_log_partition, &rtas_log_partition,
 						sizeof(rtas_log_partition));
 	}
-	oops_buf_sz = oops_log_partition.size - sizeof(struct err_log_info);
-	oops_buf = kmalloc(oops_buf_sz, GFP_KERNEL);
+
+	little_oops_buf_sz = oops_log_partition.size - OOPS_PTN_PREFIX_SZ;
+	little_oops_buf = kmalloc(oops_log_partition.size, GFP_KERNEL);
+	if (!little_oops_buf) {
+		pr_err("nvram: No memory for %s partition\n",
+						oops_log_partition.name);
+		return;
+	}
+	/*
+	 * Figure compression (preceded by elimination of each line's <n>
+	 * severity prefix) will reduce the oops/panic report to at most
+	 * 45% of its original size.
+	 */
+	big_oops_buf_sz = (little_oops_buf_sz * 100) / 45;
+	big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
+	if (big_oops_buf) {
+		stream.workspace = vmalloc(zlib_deflate_workspacesize());
+		if (!stream.workspace) {
+			pr_err("nvram: No memory for compression workspace; "
+				"skipping compression of %s partition data\n",
+				oops_log_partition.name);
+			kfree(big_oops_buf);
+			big_oops_buf = NULL;
+		}
+	} else {
+		pr_err("No memory for uncompressed %s data; "
+			"skipping compression\n", oops_log_partition.name);
+		stream.workspace = NULL;
+	}
+
 	rc = kmsg_dump_register(&nvram_kmsg_dumper);
 	if (rc != 0) {
 		pr_err("nvram: kmsg_dump_register() failed; returned %d\n", rc);
-		kfree(oops_buf);
-		return;
+		kfree(little_oops_buf);
+		kfree(big_oops_buf);
+		vfree(stream.workspace);
 	}
 }
 
@@ -527,7 +574,105 @@ static size_t capture_oops(const char *old_msgs, size_t old_len,
 	return nc1 + nc2;
 }
 
-/* our kmsg_dump callback */
+/*
+ * For a panic, capture the last capture_len chars of the printk buffer.
+ * For an oops, ensure that we have the start of the oops report, and the
+ * message(s) leading up to it.
+ */
+static size_t capture_msgs(enum kmsg_dump_reason reason,
+				const char *old_msgs, size_t old_len,
+				const char *new_msgs, size_t new_len,
+				char *captured, size_t capture_len)
+{
+	size_t text_len;
+
+	text_len = capture_last_msgs(old_msgs, old_len, new_msgs, new_len,
+						captured, capture_len);
+	if (reason == KMSG_DUMP_OOPS) {
+		const char *poops = strnrstr(captured, OOPS_TAG, capture_len);
+		if (!poops || poops < captured + PREAMBLE_CHARS)
+			text_len = capture_oops(old_msgs, old_len, new_msgs,
+				new_len, captured, capture_len, text_len);
+	}
+	return text_len;
+}
+
+/* Squeeze out each line's <n> severity prefix. */
+static size_t elide_severities(char *buf, size_t len)
+{
+	char *in, *out, *buf_end = buf + len;
+	/* Assume a <n> at the very beginning marks the start of a line. */
+	int newline = 1;
+
+	in = out = buf;
+	while (in < buf_end) {
+		if (newline && in+3 <= buf_end &&
+				*in == '<' && isdigit(in[1]) && in[2] == '>') {
+			in += 3;
+			newline = 0;
+		} else {
+			newline = (*in == '\n');
+			*out++ = *in++;
+		}
+	}
+	return out - buf;
+}
+
+/* Derived from logfs_compress() */
+static int nvram_compress(const void *in, void *out, size_t inlen,
+							size_t outlen)
+{
+	int err, ret;
+
+	ret = -EIO;
+	err = zlib_deflateInit(&stream, COMPR_LEVEL);
+	if (err != Z_OK)
+		goto error;
+
+	stream.next_in = in;
+	stream.avail_in = inlen;
+	stream.total_in = 0;
+	stream.next_out = out;
+	stream.avail_out = outlen;
+	stream.total_out = 0;
+
+	err = zlib_deflate(&stream, Z_FINISH);
+	if (err != Z_STREAM_END)
+		goto error;
+
+	err = zlib_deflateEnd(&stream);
+	if (err != Z_OK)
+		goto error;
+
+	if (stream.total_out >= stream.total_in)
+		goto error;
+
+	ret = stream.total_out;
+error:
+	return ret;
+}
+
+/* Compress the text from big_oops_buf into little_oops_buf. */
+static int zip_oops(size_t text_len)
+{
+	int zipped_len = nvram_compress(big_oops_buf, little_oops_buf->buf,
+					text_len, little_oops_buf_sz);
+	if (zipped_len < 0) {
+		pr_err("nvram: compression failed; returned %d\n", zipped_len);
+		pr_err("nvram: logging uncompressed oops/panic report\n");
+		return -1;
+	}
+	little_oops_buf->length = (unsigned short) zipped_len;
+	return 0;
+}
+
+/*
+ * This is our kmsg_dump callback, called after an oops or panic report
+ * has been written to the printk buffer.  We want to capture as much
+ * of the printk buffer as possible.  First, capture as much as we can
+ * that we think will compress sufficiently to fit in the ibm,oops-log
+ * partition.  If that's too much, go back and capture uncompressed text.
+ */
 static void oops_to_nvram(struct kmsg_dumper *dumper,
 		enum kmsg_dump_reason reason,
 		const char *old_msgs, unsigned long old_len,
@@ -535,19 +680,25 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
 {
 	static unsigned int oops_count = 0;
 	size_t text_len;
-
-	text_len = capture_last_msgs(old_msgs, old_len, new_msgs, new_len,
-						oops_buf, oops_buf_sz);
-	if (reason == KMSG_DUMP_OOPS) {
-		/*
-		 * Ensure that we have the start of the oops report,
-		 * and the message(s) leading up to it.
-		 */
-		const char *poops = strnrstr(oops_buf, OOPS_TAG, oops_buf_sz);
-		if (!poops || poops < oops_buf + PREAMBLE_CHARS)
-			text_len = capture_oops(old_msgs, old_len, new_msgs,
-				new_len, oops_buf, oops_buf_sz, text_len);
+	unsigned int err_type = ERR_TYPE_KERNEL_PANIC_GZ;
+	int rc = -1;
+
+	if (big_oops_buf) {
+		text_len = capture_msgs(reason, old_msgs, old_len,
+			new_msgs, new_len, big_oops_buf, big_oops_buf_sz);
+		text_len = elide_severities(big_oops_buf, text_len);
+		rc = zip_oops(text_len);
 	}
-	(void) nvram_write_os_partition(&oops_log_partition, oops_buf,
-		(int) text_len, ERR_TYPE_KERNEL_PANIC, ++oops_count);
+	if (rc != 0) {
+		text_len = capture_msgs(reason, old_msgs, old_len,
+				new_msgs, new_len, little_oops_buf->buf,
+				little_oops_buf_sz);
+		err_type = ERR_TYPE_KERNEL_PANIC;
+		little_oops_buf->length = (unsigned short) text_len;
+	}
+
+	(void) nvram_write_os_partition(&oops_log_partition,
+		(char*) little_oops_buf,
+		(int) (OOPS_PTN_PREFIX_SZ + little_oops_buf->length),
+		err_type, ++oops_count);
 }
