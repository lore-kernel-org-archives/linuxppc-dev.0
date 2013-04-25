Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 333B02C0247
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 20:18:58 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 25 Apr 2013 20:16:39 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7AEE02CE804D
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 20:18:48 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3PAIfKV13172740
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 20:18:41 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3PAIkOi009570
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 20:18:47 +1000
Subject: [PATCH v3 4/8] powerpc/pseries: Read/Write oops nvram partition via
 pstore
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 25 Apr 2013 15:48:37 +0530
Message-ID: <20130425101837.21017.97072.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130425100952.21017.51799.stgit@aruna-ThinkPad-T420>
References: <20130425100952.21017.51799.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jkenisto@linux.vnet.ibm.com, tony.luck@intel.com, mahesh@linux.vnet.ibm.com,
 cbouatmailru@gmail.com, anton@samba.org, ccross@android.com,
 keescook@chromium.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IBM's p series machines provide persistent storage for LPARs through NVRAM.
NVRAM's lnx,oops-log partition is used to log oops messages.
Currently the kernel provides the contents of p-series NVRAM only as a
simple stream of bytes via /dev/nvram, which must be interpreted in user
space by the nvram command in the powerpc-utils package.

This patch set exploits the pstore subsystem to expose oops partition in
NVRAM as a separate file in /dev/pstore. For instance, Oops messages will be
stored in a file named [dmesg-nvram-2]. In case pstore registration fails it
will fall back to kmsg_dump mechanism.

This patch will read/write the oops messages from/to this partition via pstore.

Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>
Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/nvram.c |  172 +++++++++++++++++++++++++++++---
 1 file changed, 157 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 088f023..9edec8e 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -18,6 +18,7 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/kmsg_dump.h>
+#include <linux/pstore.h>
 #include <linux/ctype.h>
 #include <linux/zlib.h>
 #include <asm/uaccess.h>
@@ -127,6 +128,14 @@ static size_t oops_data_sz;
 #define MEM_LEVEL 4
 static struct z_stream_s stream;
 
+#ifdef CONFIG_PSTORE
+static enum pstore_type_id nvram_type_ids[] = {
+	PSTORE_TYPE_DMESG,
+	-1
+};
+static int read_type;
+#endif
+
 static ssize_t pSeries_nvram_read(char *buf, size_t count, loff_t *index)
 {
 	unsigned int i;
@@ -430,6 +439,149 @@ static int __init pseries_nvram_init_os_partition(struct nvram_os_partition
 	return 0;
 }
 
+/*
+ * Are we using the ibm,rtas-log for oops/panic reports?  And if so,
+ * would logging this oops/panic overwrite an RTAS event that rtas_errd
+ * hasn't had a chance to read and process?  Return 1 if so, else 0.
+ *
+ * We assume that if rtas_errd hasn't read the RTAS event in
+ * NVRAM_RTAS_READ_TIMEOUT seconds, it's probably not going to.
+ */
+static int clobbering_unread_rtas_event(void)
+{
+	return (oops_log_partition.index == rtas_log_partition.index
+		&& last_unread_rtas_event
+		&& get_seconds() - last_unread_rtas_event <=
+						NVRAM_RTAS_READ_TIMEOUT);
+}
+
+#ifdef CONFIG_PSTORE
+static int nvram_pstore_open(struct pstore_info *psi)
+{
+	/* Reset the iterator to start reading partitions again */
+	read_type = -1;
+	return 0;
+}
+
+/**
+ * nvram_pstore_write - pstore write callback for nvram
+ * @type:               Type of message logged
+ * @reason:             reason behind dump (oops/panic)
+ * @id:                 identifier to indicate the write performed
+ * @part:               pstore writes data to registered buffer in parts,
+ *                      part number will indicate the same.
+ * @count:              Indicates oops count
+ * @size:               number of bytes written to the registered buffer
+ * @psi:                registered pstore_info structure
+ *
+ * Called by pstore_dump() when an oops or panic report is logged in the
+ * printk buffer.
+ * Returns 0 on successful write.
+ */
+static int nvram_pstore_write(enum pstore_type_id type,
+				enum kmsg_dump_reason reason,
+				u64 *id, unsigned int part, int count,
+				size_t size, struct pstore_info *psi)
+{
+	int rc;
+	struct oops_log_info *oops_hdr = (struct oops_log_info *) oops_buf;
+
+	/* part 1 has the recent messages from printk buffer */
+	if (part > 1 || type != PSTORE_TYPE_DMESG ||
+				clobbering_unread_rtas_event())
+		return -1;
+
+	oops_hdr->version = OOPS_HDR_VERSION;
+	oops_hdr->report_length = (u16) size;
+	oops_hdr->timestamp = get_seconds();
+	rc = nvram_write_os_partition(&oops_log_partition, oops_buf,
+		(int) (sizeof(*oops_hdr) + size), ERR_TYPE_KERNEL_PANIC,
+		count);
+
+	if (rc != 0)
+		return rc;
+
+	*id = part;
+	return 0;
+}
+
+/*
+ * Reads the oops/panic report.
+ * Returns the length of the data we read from each partition.
+ * Returns 0 if we've been called before.
+ */
+static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
+				int *count, struct timespec *time, char **buf,
+				struct pstore_info *psi)
+{
+	struct oops_log_info *oops_hdr;
+	unsigned int err_type, id_no;
+	struct nvram_os_partition *part = NULL;
+	char *buff = NULL;
+
+	read_type++;
+
+	switch (nvram_type_ids[read_type]) {
+	case PSTORE_TYPE_DMESG:
+		part = &oops_log_partition;
+		*type = PSTORE_TYPE_DMESG;
+		break;
+	default:
+		return 0;
+	}
+
+	buff = kmalloc(part->size, GFP_KERNEL);
+
+	if (!buff)
+		return -ENOMEM;
+
+	if (nvram_read_partition(part, buff, part->size, &err_type, &id_no)) {
+		kfree(buff);
+		return 0;
+	}
+
+	*count = 0;
+	*id = id_no;
+	oops_hdr = (struct oops_log_info *)buff;
+	*buf = buff + sizeof(*oops_hdr);
+	time->tv_sec = oops_hdr->timestamp;
+	time->tv_nsec = 0;
+	return oops_hdr->report_length;
+}
+
+static struct pstore_info nvram_pstore_info = {
+	.owner = THIS_MODULE,
+	.name = "nvram",
+	.open = nvram_pstore_open,
+	.read = nvram_pstore_read,
+	.write = nvram_pstore_write,
+};
+
+static int nvram_pstore_init(void)
+{
+	int rc = 0;
+
+	nvram_pstore_info.buf = oops_data;
+	nvram_pstore_info.bufsize = oops_data_sz;
+
+	rc = pstore_register(&nvram_pstore_info);
+	if (rc != 0)
+		pr_err("nvram: pstore_register() failed, defaults to "
+				"kmsg_dump; returned %d\n", rc);
+	else
+		/*TODO: Support compression when pstore is configured */
+		pr_info("nvram: Compression of oops text supported only when "
+				"pstore is not configured");
+
+	return rc;
+}
+#else
+static int nvram_pstore_init(void)
+{
+	return -1;
+}
+#endif
+
 static void __init nvram_init_oops_partition(int rtas_partition_exists)
 {
 	int rc;
@@ -453,6 +605,11 @@ static void __init nvram_init_oops_partition(int rtas_partition_exists)
 	oops_data = oops_buf + sizeof(struct oops_log_info);
 	oops_data_sz = oops_log_partition.size - sizeof(struct oops_log_info);
 
+	rc = nvram_pstore_init();
+
+	if (!rc)
+		return;
+
 	/*
 	 * Figure compression (preceded by elimination of each line's <n>
 	 * severity prefix) will reduce the oops/panic report to at most
@@ -525,21 +682,6 @@ int __init pSeries_nvram_init(void)
 	return 0;
 }
 
-/*
- * Are we using the ibm,rtas-log for oops/panic reports?  And if so,
- * would logging this oops/panic overwrite an RTAS event that rtas_errd
- * hasn't had a chance to read and process?  Return 1 if so, else 0.
- *
- * We assume that if rtas_errd hasn't read the RTAS event in
- * NVRAM_RTAS_READ_TIMEOUT seconds, it's probably not going to.
- */
-static int clobbering_unread_rtas_event(void)
-{
-	return (oops_log_partition.index == rtas_log_partition.index
-		&& last_unread_rtas_event
-		&& get_seconds() - last_unread_rtas_event <=
-						NVRAM_RTAS_READ_TIMEOUT);
-}
 
 /* Derived from logfs_compress() */
 static int nvram_compress(const void *in, void *out, size_t inlen,
