Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C8FAC2C00D4
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2013 17:23:29 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Wed, 10 Apr 2013 12:49:37 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8702E3940059
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2013 12:53:24 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3A7NKUh59900060
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2013 12:53:20 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3A7NM0Q013907
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2013 17:23:23 +1000
Subject: [PATCH 4/8] Read/Write oops nvram partition via pstore
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Wed, 10 Apr 2013 12:53:03 +0530
Message-ID: <20130410072303.20150.61382.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130410071835.20150.56489.stgit@aruna-ThinkPad-T420>
References: <20130410071835.20150.56489.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jkenisto@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch exploits pstore infrastructure in power systems.
IBM's system p machines provide persistent storage for LPARs
through NVRAM. NVRAM's lnx,oops-log partition is used to log
oops messages. In case pstore registration fails it will
fall back to kmsg_dump mechanism.

This patch will read/write the oops messages from/to this
partition via pstore.

Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>
Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/nvram.c |  145 ++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 6701b71..82d32a2 100644
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
@@ -87,6 +88,25 @@ static struct kmsg_dumper nvram_kmsg_dumper = {
 	.dump = oops_to_nvram
 };
 
+static int nvram_pstore_open(struct pstore_info *psi);
+
+static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
+				int *count, struct timespec *time, char **buf,
+				struct pstore_info *psi);
+
+static int nvram_pstore_write(enum pstore_type_id type,
+				enum kmsg_dump_reason reason, u64 *id,
+				unsigned int part, int count, size_t size,
+				struct pstore_info *psi);
+
+static struct pstore_info nvram_pstore_info = {
+	.owner = THIS_MODULE,
+	.name = "nvram",
+	.open = nvram_pstore_open,
+	.read = nvram_pstore_read,
+	.write = nvram_pstore_write,
+};
+
 /* See clobbering_unread_rtas_event() */
 #define NVRAM_RTAS_READ_TIMEOUT 5		/* seconds */
 static unsigned long last_unread_rtas_event;	/* timestamp */
@@ -121,6 +141,13 @@ static char *big_oops_buf, *oops_buf;
 static char *oops_data;
 static size_t oops_data_sz;
 
+#ifdef CONFIG_PSTORE
+static enum pstore_type_id nvram_type_ids[] = {
+	PSTORE_TYPE_DMESG,
+	-1
+};
+static int read_type;
+#endif
 /* Compression parameters */
 #define COMPR_LEVEL 6
 #define WINDOW_BITS 12
@@ -455,6 +482,23 @@ static void __init nvram_init_oops_partition(int rtas_partition_exists)
 	oops_data = oops_buf + sizeof(struct oops_log_info);
 	oops_data_sz = oops_log_partition.size - sizeof(struct oops_log_info);
 
+	nvram_pstore_info.buf = oops_data;
+	nvram_pstore_info.bufsize = oops_data_sz;
+
+	rc = pstore_register(&nvram_pstore_info);
+
+	if (rc != 0) {
+		pr_err("nvram: pstore_register() failed, defaults to "
+				"kmsg_dump; returned %d\n", rc);
+		goto kmsg_dump;
+	} else {
+		/*TODO: Support compression when pstore is configured */
+		pr_info("nvram: Compression of oops text supported only when "
+				"pstore is not configured");
+		return;
+	}
+
+kmsg_dump:
 	/*
 	 * Figure compression (preceded by elimination of each line's <n>
 	 * severity prefix) will reduce the oops/panic report to at most
@@ -663,3 +707,104 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
 
 	spin_unlock_irqrestore(&lock, flags);
 }
+
+#ifdef CONFIG_PSTORE
+static int nvram_pstore_open(struct pstore_info *psi)
+{
+	read_type = -1;
+	return 0;
+}
+
+/*
+ * Called by pstore_dump() when an oops or panic report is logged to the printk
+ * buffer. @size bytes have been written to oops_buf, starting after the
+ * oops_log_info header.
+ */
+static int nvram_pstore_write(enum pstore_type_id type,
+				enum kmsg_dump_reason reason,
+				u64 *id, unsigned int part, int count,
+				size_t size, struct pstore_info *psi)
+{
+	struct oops_log_info *oops_hdr = (struct oops_log_info *) oops_buf;
+
+	/* part 1 has the recent messages from printk buffer */
+	if (part > 1 || clobbering_unread_rtas_event())
+		return -1;
+
+	BUG_ON(type != PSTORE_TYPE_DMESG);
+	BUG_ON(sizeof(*oops_hdr) + size > oops_log_partition.size);
+	oops_hdr->version = OOPS_HDR_VERSION;
+	oops_hdr->report_length = (u16) size;
+	oops_hdr->timestamp = get_seconds();
+	(void) nvram_write_os_partition(&oops_log_partition, oops_buf,
+		(int) (sizeof(*oops_hdr) + size), ERR_TYPE_KERNEL_PANIC,
+		count);
+	*id = part;
+
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
+#else
+static int nvram_pstore_open(struct pstore_info *psi)
+{
+	return 0;
+}
+
+static int nvram_pstore_write(enum pstore_type_id type,
+				enum kmsg_dump_reason reason, u64 *id,
+				unsigned int part, int count, size_t size,
+				struct pstore_info *psi)
+{
+	return 0;
+}
+
+static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
+				int *count, struct timespec *time, char **buf,
+				struct pstore_info *psi)
+{
+	return 0;
+}
+#endif
