Return-Path: <jkenisto@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 89294B7091
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jul 2011 03:54:55 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p6PHsqql026719
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2011 11:54:52 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p6PHspBu202060
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2011 11:54:51 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p6PHspuh000600
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2011 11:54:51 -0600
From: Jim Keniston <jkenisto@us.ibm.com>
Subject: [PATCH] powerpc/nvram: Add compression to fit more oops output into
	NVRAM
To: benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Date: Mon, 25 Jul 2011 10:54:50 -0700
Message-ID: <20110725175450.6146.18756.stgit@localhost.localdomain>
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
compress it to fit it in the lnx,oops-log NVRAM partition.  You
can view the compressed text using the new (as of July 20) --unzip
option of the nvram command in the powerpc-utils package.

Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>
---

 arch/powerpc/include/asm/rtas.h        |    6 +
 arch/powerpc/platforms/pseries/nvram.c |  171 +++++++++++++++++++++++++++++++-
 2 files changed, 168 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 58625d1..41f69ae 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -249,10 +249,12 @@ extern void pSeries_log_error(char *buf, unsigned int err_type, int fatal);
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
index 00cc3a0..a76b228 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -18,6 +18,8 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/kmsg_dump.h>
+#include <linux/ctype.h>
+#include <linux/zlib.h>
 #include <asm/uaccess.h>
 #include <asm/nvram.h>
 #include <asm/rtas.h>
@@ -78,8 +80,41 @@ static struct kmsg_dumper nvram_kmsg_dumper = {
 #define NVRAM_RTAS_READ_TIMEOUT 5		/* seconds */
 static unsigned long last_unread_rtas_event;	/* timestamp */
 
-/* We preallocate oops_buf during init to avoid kmalloc during oops/panic. */
-static char *oops_buf;
+/*
+ * For capturing and compressing an oops or panic report...
+
+ * big_oops_buf[] holds the uncompressed text we're capturing.
+ *
+ * oops_buf[] holds the compressed text, preceded by a prefix.
+ * The prefix is just a u16 holding the length of the compressed* text.
+ * (*Or uncompressed, if compression fails.)  oops_buf[] gets written
+ * to NVRAM.
+ *
+ * oops_len points to the prefix.  oops_data points to the compressed text.
+ *
+ * +- oops_buf
+ * |		+- oops_data
+ * v		v
+ * +------------+-----------------------------------------------+
+ * | length	| text                                          |
+ * | (2 bytes)	| (oops_data_sz bytes)                          |
+ * +------------+-----------------------------------------------+
+ * ^
+ * +- oops_len
+ *
+ * We preallocate these buffers during init to avoid kmalloc during oops/panic.
+ */
+static size_t big_oops_buf_sz;
+static char *big_oops_buf, *oops_buf;
+static u16 *oops_len;
+static char *oops_data;
+static size_t oops_data_sz;
+
+/* Compression parameters */
+#define COMPR_LEVEL 6
+#define WINDOW_BITS 12
+#define MEM_LEVEL 4
+static struct z_stream_s stream;
 
 static ssize_t pSeries_nvram_read(char *buf, size_t count, loff_t *index)
 {
@@ -387,11 +422,44 @@ static void __init nvram_init_oops_partition(int rtas_partition_exists)
 						sizeof(rtas_log_partition));
 	}
 	oops_buf = kmalloc(oops_log_partition.size, GFP_KERNEL);
+	if (!oops_buf) {
+		pr_err("nvram: No memory for %s partition\n",
+						oops_log_partition.name);
+		return;
+	}
+	oops_len = (u16*) oops_buf;
+	oops_data = oops_buf + sizeof(u16);
+	oops_data_sz = oops_log_partition.size - sizeof(u16);
+
+	/*
+	 * Figure compression (preceded by elimination of each line's <n>
+	 * severity prefix) will reduce the oops/panic report to at most
+	 * 45% of its original size.
+	 */
+	big_oops_buf_sz = (oops_data_sz * 100) / 45;
+	big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
+	if (big_oops_buf) {
+		stream.workspace = kmalloc(zlib_deflate_workspacesize(
+				WINDOW_BITS, MEM_LEVEL), GFP_KERNEL);
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
 		kfree(oops_buf);
-		return;
+		kfree(big_oops_buf);
+		kfree(stream.workspace);
 	}
 }
 
@@ -473,7 +541,83 @@ static int clobbering_unread_rtas_event(void)
 						NVRAM_RTAS_READ_TIMEOUT);
 }
 
-/* our kmsg_dump callback */
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
+	err = zlib_deflateInit2(&stream, COMPR_LEVEL, Z_DEFLATED, WINDOW_BITS,
+						MEM_LEVEL, Z_DEFAULT_STRATEGY);
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
+/* Compress the text from big_oops_buf into oops_buf. */
+static int zip_oops(size_t text_len)
+{
+	int zipped_len = nvram_compress(big_oops_buf, oops_data, text_len,
+								oops_data_sz);
+	if (zipped_len < 0) {
+		pr_err("nvram: compression failed; returned %d\n", zipped_len);
+		pr_err("nvram: logging uncompressed oops/panic report\n");
+		return -1;
+	}
+	*oops_len = (u16) zipped_len;
+	return 0;
+}
+
+/*
+ * This is our kmsg_dump callback, called after an oops or panic report
+ * has been written to the printk buffer.  We want to capture as much
+ * of the printk buffer as possible.  First, capture as much as we can
+ * that we think will compress sufficiently to fit in the lnx,oops-log
+ * partition.  If that's too much, go back and capture uncompressed text.
+ */
 static void oops_to_nvram(struct kmsg_dumper *dumper,
 		enum kmsg_dump_reason reason,
 		const char *old_msgs, unsigned long old_len,
@@ -482,6 +626,8 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
 	static unsigned int oops_count = 0;
 	static bool panicking = false;
 	size_t text_len;
+	unsigned int err_type = ERR_TYPE_KERNEL_PANIC_GZ;
+	int rc = -1;
 
 	switch (reason) {
 	case KMSG_DUMP_RESTART:
@@ -509,8 +655,19 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
 	if (clobbering_unread_rtas_event())
 		return;
 
-	text_len = capture_last_msgs(old_msgs, old_len, new_msgs, new_len,
-					oops_buf, oops_log_partition.size);
+	if (big_oops_buf) {
+		text_len = capture_last_msgs(old_msgs, old_len,
+			new_msgs, new_len, big_oops_buf, big_oops_buf_sz);
+		text_len = elide_severities(big_oops_buf, text_len);
+		rc = zip_oops(text_len);
+	}
+	if (rc != 0) {
+		text_len = capture_last_msgs(old_msgs, old_len,
+				new_msgs, new_len, oops_data, oops_data_sz);
+		err_type = ERR_TYPE_KERNEL_PANIC;
+		*oops_len = (u16) text_len;
+	}
+
 	(void) nvram_write_os_partition(&oops_log_partition, oops_buf,
-		(int) text_len, ERR_TYPE_KERNEL_PANIC, ++oops_count);
+		(int) (sizeof(*oops_len) + *oops_len), err_type, ++oops_count);
 }
