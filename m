Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 177531A0CDD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 22:03:30 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ACCA81400E2
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2014 22:03:29 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 3 Dec 2014 21:03:29 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 82EE93578053
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2014 22:03:27 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB3B3R4v27590816
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Dec 2014 22:03:27 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB3B3Rha006918
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Dec 2014 22:03:27 +1100
Subject: [PATCH 2/2] pstore: add pstore support on powernv
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Wed, 03 Dec 2014 16:33:15 +0530
Message-ID: <20141203110315.25444.88272.stgit@localhost.localdomain>
In-Reply-To: <20141203110141.25444.71759.stgit@localhost.localdomain>
References: <20141203110141.25444.71759.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch extends pstore, a generic interface to platform dependent
persistent storage, support for powernv  platform to capture certain
useful information, during dying moments. Such support is already in
place for  pseries platform.  This patch while adding pstore support
for  powernv platform,  moves common code for pseries and powernv to
arch/powerpc/kernel/nvram_64.c file.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/nvram.h            |   50 ++
 arch/powerpc/include/asm/rtas.h             |    2 
 arch/powerpc/kernel/nvram_64.c              |  679 +++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-nvram.c |   10 
 arch/powerpc/platforms/pseries/nvram.c      |  663 --------------------------
 5 files changed, 745 insertions(+), 659 deletions(-)

diff --git a/arch/powerpc/include/asm/nvram.h b/arch/powerpc/include/asm/nvram.h
index b0fe0fe..09a518b 100644
--- a/arch/powerpc/include/asm/nvram.h
+++ b/arch/powerpc/include/asm/nvram.h
@@ -9,12 +9,43 @@
 #ifndef _ASM_POWERPC_NVRAM_H
 #define _ASM_POWERPC_NVRAM_H
 
-
+#include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/list.h>
 #include <uapi/asm/nvram.h>
 
+/*
+ * Set oops header version to distinguish between old and new format header.
+ * lnx,oops-log partition max size is 4000, header version > 4000 will
+ * help in identifying new header.
+ */
+#define OOPS_HDR_VERSION 5000
+
+struct err_log_info {
+	__be32 error_type;
+	__be32 seq_num;
+};
+
+struct nvram_os_partition {
+	const char *name;
+	int req_size;	/* desired size, in bytes */
+	int min_size;	/* minimum acceptable size (0 means req_size) */
+	long size;	/* size of data portion (excluding err_log_info) */
+	long index;	/* offset of data portion of partition */
+	bool os_partition; /* partition initialized by OS, not FW */
+};
+
+struct oops_log_info {
+	__be16 version;
+	__be16 report_length;
+	__be64 timestamp;
+} __attribute__((packed));
+
+extern struct nvram_os_partition oops_log_partition;
+
 #ifdef CONFIG_PPC_PSERIES
+extern struct nvram_os_partition rtas_log_partition;
+
 extern int nvram_write_error_log(char * buff, int length,
 					 unsigned int err_type, unsigned int err_seq);
 extern int nvram_read_error_log(char * buff, int length,
@@ -50,6 +81,23 @@ extern void	pmac_xpram_write(int xpaddr, u8 data);
 /* Synchronize NVRAM */
 extern void	nvram_sync(void);
 
+/* Initialize NVRAM OS partition */
+extern int __init nvram_init_os_partition(struct nvram_os_partition *part);
+
+/* Initialize NVRAM oops partition */
+extern void __init nvram_init_oops_partition(int rtas_partition_exists);
+
+/* Read a NVRAM partition */
+extern int nvram_read_partition(struct nvram_os_partition *part, char *buff,
+				int length, unsigned int *err_type,
+				unsigned int *error_log_cnt);
+
+/* Write to NVRAM OS partition */
+extern int nvram_write_os_partition(struct nvram_os_partition *part,
+				    char *buff, int length,
+				    unsigned int err_type,
+				    unsigned int error_log_cnt);
+
 /* Determine NVRAM size */
 extern ssize_t nvram_get_size(void);
 
diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index b390f55..a033fe9 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -343,6 +343,8 @@ extern int early_init_dt_scan_rtas(unsigned long node,
 extern void pSeries_log_error(char *buf, unsigned int err_type, int fatal);
 
 #ifdef CONFIG_PPC_PSERIES
+extern unsigned long last_rtas_event;
+extern int clobbering_unread_rtas_event(void);
 extern int pseries_devicetree_update(s32 scope);
 extern void post_mobility_fixup(void);
 #endif
diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 34f7c9b..8c439a3 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -26,6 +26,9 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/kmsg_dump.h>
+#include <linux/pstore.h>
+#include <linux/zlib.h>
 #include <asm/uaccess.h>
 #include <asm/nvram.h>
 #include <asm/rtas.h>
@@ -54,6 +57,682 @@ struct nvram_partition {
 
 static LIST_HEAD(nvram_partitions);
 
+#ifdef CONFIG_PPC_PSERIES
+struct nvram_os_partition rtas_log_partition = {
+	.name = "ibm,rtas-log",
+	.req_size = 2079,
+	.min_size = 1055,
+	.index = -1,
+	.os_partition = true
+};
+#endif
+
+struct nvram_os_partition oops_log_partition = {
+	.name = "lnx,oops-log",
+	.req_size = 4000,
+	.min_size = 2000,
+	.index = -1,
+	.os_partition = true
+};
+
+static const char *nvram_os_partitions[] = {
+#ifdef CONFIG_PPC_PSERIES
+	"ibm,rtas-log",
+#endif
+	"lnx,oops-log",
+	NULL
+};
+
+static void oops_to_nvram(struct kmsg_dumper *dumper,
+			  enum kmsg_dump_reason reason);
+
+static struct kmsg_dumper nvram_kmsg_dumper = {
+	.dump = oops_to_nvram
+};
+
+/*
+ * For capturing and compressing an oops or panic report...
+
+ * big_oops_buf[] holds the uncompressed text we're capturing.
+ *
+ * oops_buf[] holds the compressed text, preceded by a oops header.
+ * oops header has u16 holding the version of oops header (to differentiate
+ * between old and new format header) followed by u16 holding the length of
+ * the compressed* text (*Or uncompressed, if compression fails.) and u64
+ * holding the timestamp. oops_buf[] gets written to NVRAM.
+ *
+ * oops_log_info points to the header. oops_data points to the compressed text.
+ *
+ * +- oops_buf
+ * |                                   +- oops_data
+ * v                                   v
+ * +-----------+-----------+-----------+------------------------+
+ * | version   | length    | timestamp | text                   |
+ * | (2 bytes) | (2 bytes) | (8 bytes) | (oops_data_sz bytes)   |
+ * +-----------+-----------+-----------+------------------------+
+ * ^
+ * +- oops_log_info
+ *
+ * We preallocate these buffers during init to avoid kmalloc during oops/panic.
+ */
+static size_t big_oops_buf_sz;
+static char *big_oops_buf, *oops_buf;
+static char *oops_data;
+static size_t oops_data_sz;
+
+/* Compression parameters */
+#define COMPR_LEVEL 6
+#define WINDOW_BITS 12
+#define MEM_LEVEL 4
+static struct z_stream_s stream;
+
+#ifdef CONFIG_PSTORE
+#ifdef CONFIG_PPC_POWERNV
+static struct nvram_os_partition skiboot_partition = {
+	.name = "ibm,skiboot",
+	.index = -1,
+	.os_partition = false
+};
+#endif
+
+#ifdef CONFIG_PPC_PSERIES
+static struct nvram_os_partition of_config_partition = {
+	.name = "of-config",
+	.index = -1,
+	.os_partition = false
+};
+#endif
+
+static struct nvram_os_partition common_partition = {
+	.name = "common",
+	.index = -1,
+	.os_partition = false
+};
+
+static enum pstore_type_id nvram_type_ids[] = {
+	PSTORE_TYPE_DMESG,
+	PSTORE_TYPE_PPC_COMMON,
+	-1,
+	-1,
+	-1
+};
+static int read_type;
+#endif
+
+/* nvram_write_os_partition
+ *
+ * We need to buffer the error logs into nvram to ensure that we have
+ * the failure information to decode.  If we have a severe error there
+ * is no way to guarantee that the OS or the machine is in a state to
+ * get back to user land and write the error to disk.  For example if
+ * the SCSI device driver causes a Machine Check by writing to a bad
+ * IO address, there is no way of guaranteeing that the device driver
+ * is in any state that is would also be able to write the error data
+ * captured to disk, thus we buffer it in NVRAM for analysis on the
+ * next boot.
+ *
+ * In NVRAM the partition containing the error log buffer will looks like:
+ * Header (in bytes):
+ * +-----------+----------+--------+------------+------------------+
+ * | signature | checksum | length | name       | data             |
+ * |0          |1         |2      3|4         15|16        length-1|
+ * +-----------+----------+--------+------------+------------------+
+ *
+ * The 'data' section would look like (in bytes):
+ * +--------------+------------+-----------------------------------+
+ * | event_logged | sequence # | error log                         |
+ * |0            3|4          7|8                  error_log_size-1|
+ * +--------------+------------+-----------------------------------+
+ *
+ * event_logged: 0 if event has not been logged to syslog, 1 if it has
+ * sequence #: The unique sequence # for each event. (until it wraps)
+ * error log: The error log from event_scan
+ */
+int nvram_write_os_partition(struct nvram_os_partition *part,
+			     char *buff, int length,
+			     unsigned int err_type,
+			     unsigned int error_log_cnt)
+{
+	int rc;
+	loff_t tmp_index;
+	struct err_log_info info;
+
+	if (part->index == -1)
+		return -ESPIPE;
+
+	if (length > part->size)
+		length = part->size;
+
+	info.error_type = cpu_to_be32(err_type);
+	info.seq_num = cpu_to_be32(error_log_cnt);
+
+	tmp_index = part->index;
+
+	rc = ppc_md.nvram_write((char *)&info, sizeof(struct err_log_info),
+				&tmp_index);
+	if (rc <= 0) {
+		pr_err("%s: Failed nvram_write (%d)\n", __func__, rc);
+		return rc;
+	}
+
+	rc = ppc_md.nvram_write(buff, length, &tmp_index);
+	if (rc <= 0) {
+		pr_err("%s: Failed nvram_write (%d)\n", __func__, rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+/* nvram_read_partition
+ *
+ * Reads nvram partition for at most 'length'
+ */
+int nvram_read_partition(struct nvram_os_partition *part, char *buff,
+			 int length, unsigned int *err_type,
+			 unsigned int *error_log_cnt)
+{
+	int rc;
+	loff_t tmp_index;
+	struct err_log_info info;
+
+	if (part->index == -1)
+		return -1;
+
+	if (length > part->size)
+		length = part->size;
+
+	tmp_index = part->index;
+
+	if (part->os_partition) {
+		rc = ppc_md.nvram_read((char *)&info,
+					sizeof(struct err_log_info),
+					&tmp_index);
+		if (rc <= 0) {
+			pr_err("%s: Failed nvram_read (%d)\n", __func__, rc);
+			return rc;
+		}
+	}
+
+	rc = ppc_md.nvram_read(buff, length, &tmp_index);
+	if (rc <= 0) {
+		pr_err("%s: Failed nvram_read (%d)\n", __func__, rc);
+		return rc;
+	}
+
+	if (part->os_partition) {
+		*error_log_cnt = be32_to_cpu(info.seq_num);
+		*err_type = be32_to_cpu(info.error_type);
+	}
+
+	return 0;
+}
+
+/* nvram_init_os_partition
+ *
+ * This sets up a partition with an "OS" signature.
+ *
+ * The general strategy is the following:
+ * 1.) If a partition with the indicated name already exists...
+ *	- If it's large enough, use it.
+ *	- Otherwise, recycle it and keep going.
+ * 2.) Search for a free partition that is large enough.
+ * 3.) If there's not a free partition large enough, recycle any obsolete
+ * OS partitions and try again.
+ * 4.) Will first try getting a chunk that will satisfy the requested size.
+ * 5.) If a chunk of the requested size cannot be allocated, then try finding
+ * a chunk that will satisfy the minum needed.
+ *
+ * Returns 0 on success, else -1.
+ */
+int __init nvram_init_os_partition(struct nvram_os_partition *part)
+{
+	loff_t p;
+	int size;
+
+	/* Look for ours */
+	p = nvram_find_partition(part->name, NVRAM_SIG_OS, &size);
+
+	/* Found one but too small, remove it */
+	if (p && size < part->min_size) {
+		pr_info("nvram: Found too small %s partition,"
+					" removing it...\n", part->name);
+		nvram_remove_partition(part->name, NVRAM_SIG_OS, NULL);
+		p = 0;
+	}
+
+	/* Create one if we didn't find */
+	if (!p) {
+		p = nvram_create_partition(part->name, NVRAM_SIG_OS,
+					part->req_size, part->min_size);
+		if (p == -ENOSPC) {
+			pr_info("nvram: No room to create %s partition, "
+				"deleting any obsolete OS partitions...\n",
+				part->name);
+			nvram_remove_partition(NULL, NVRAM_SIG_OS,
+					nvram_os_partitions);
+			p = nvram_create_partition(part->name, NVRAM_SIG_OS,
+					part->req_size, part->min_size);
+		}
+	}
+
+	if (p <= 0) {
+		pr_err("nvram: Failed to find or create %s"
+		       " partition, err %d\n", part->name, (int)p);
+		return -1;
+	}
+
+	part->index = p;
+	part->size = nvram_get_partition_size(p) - sizeof(struct err_log_info);
+
+	return 0;
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
+	struct oops_log_info *oops_hdr = (struct oops_log_info *)oops_buf;
+	int zipped_len = nvram_compress(big_oops_buf, oops_data, text_len,
+								oops_data_sz);
+	if (zipped_len < 0) {
+		pr_err("nvram: compression failed; returned %d\n", zipped_len);
+		pr_err("nvram: logging uncompressed oops/panic report\n");
+		return -1;
+	}
+	oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
+	oops_hdr->report_length = cpu_to_be16(zipped_len);
+	oops_hdr->timestamp = cpu_to_be64(get_seconds());
+	return 0;
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
+ * @compressed:         Flag to indicate the log is compressed
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
+				bool compressed, size_t size,
+				struct pstore_info *psi)
+{
+	int rc;
+	unsigned int err_type = ERR_TYPE_KERNEL_PANIC;
+	struct oops_log_info *oops_hdr = (struct oops_log_info *) oops_buf;
+
+	/* part 1 has the recent messages from printk buffer */
+	if (part > 1 || (type != PSTORE_TYPE_DMESG))
+		return -1;
+
+#ifdef CONFIG_PPC_PSERIES
+	if (clobbering_unread_rtas_event())
+		return -1;
+#endif
+
+	oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
+	oops_hdr->report_length = cpu_to_be16(size);
+	oops_hdr->timestamp = cpu_to_be64(get_seconds());
+
+	if (compressed)
+		err_type = ERR_TYPE_KERNEL_PANIC_GZ;
+
+	rc = nvram_write_os_partition(&oops_log_partition, oops_buf,
+		(int) (sizeof(*oops_hdr) + size), err_type, count);
+
+	if (rc != 0)
+		return rc;
+
+	*id = part;
+	return 0;
+}
+
+/*
+ * Reads the oops/panic report, rtas, of-config and common partition.
+ * Returns the length of the data we read from each partition.
+ * Returns 0 if we've been called before.
+ */
+static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
+				int *count, struct timespec *time, char **buf,
+				bool *compressed, struct pstore_info *psi)
+{
+	struct oops_log_info *oops_hdr;
+	unsigned int err_type, id_no, size = 0;
+	struct nvram_os_partition *part = NULL;
+	char *buff = NULL;
+	int sig = 0;
+	loff_t p;
+
+	read_type++;
+
+	switch (nvram_type_ids[read_type]) {
+	case PSTORE_TYPE_DMESG:
+		part = &oops_log_partition;
+		*type = PSTORE_TYPE_DMESG;
+		break;
+	case PSTORE_TYPE_PPC_COMMON:
+		sig = NVRAM_SIG_SYS;
+		part = &common_partition;
+		*type = PSTORE_TYPE_PPC_COMMON;
+		*id = PSTORE_TYPE_PPC_COMMON;
+		time->tv_sec = 0;
+		time->tv_nsec = 0;
+		break;
+#ifdef CONFIG_PPC_PSERIES
+	case PSTORE_TYPE_PPC_RTAS:
+		part = &rtas_log_partition;
+		*type = PSTORE_TYPE_PPC_RTAS;
+		time->tv_sec = last_rtas_event;
+		time->tv_nsec = 0;
+		break;
+	case PSTORE_TYPE_PPC_OF:
+		sig = NVRAM_SIG_OF;
+		part = &of_config_partition;
+		*type = PSTORE_TYPE_PPC_OF;
+		*id = PSTORE_TYPE_PPC_OF;
+		time->tv_sec = 0;
+		time->tv_nsec = 0;
+		break;
+#endif
+#ifdef CONFIG_PPC_POWERNV
+	case PSTORE_TYPE_PPC_OPAL:
+		sig = NVRAM_SIG_FW;
+		part = &skiboot_partition;
+		*type = PSTORE_TYPE_PPC_OPAL;
+		*id = PSTORE_TYPE_PPC_OPAL;
+		time->tv_sec = 0;
+		time->tv_nsec = 0;
+		break;
+#endif
+	default:
+		return 0;
+	}
+
+	if (!part->os_partition) {
+		p = nvram_find_partition(part->name, sig, &size);
+		if (p <= 0) {
+			pr_err("nvram: Failed to find partition %s, "
+				"err %d\n", part->name, (int)p);
+			return 0;
+		}
+		part->index = p;
+		part->size = size;
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
+
+	if (part->os_partition)
+		*id = id_no;
+
+	if (nvram_type_ids[read_type] == PSTORE_TYPE_DMESG) {
+		size_t length, hdr_size;
+
+		oops_hdr = (struct oops_log_info *)buff;
+		if (be16_to_cpu(oops_hdr->version) < OOPS_HDR_VERSION) {
+			/* Old format oops header had 2-byte record size */
+			hdr_size = sizeof(u16);
+			length = be16_to_cpu(oops_hdr->version);
+			time->tv_sec = 0;
+			time->tv_nsec = 0;
+		} else {
+			hdr_size = sizeof(*oops_hdr);
+			length = be16_to_cpu(oops_hdr->report_length);
+			time->tv_sec = be64_to_cpu(oops_hdr->timestamp);
+			time->tv_nsec = 0;
+		}
+		*buf = kmalloc(length, GFP_KERNEL);
+		if (*buf == NULL)
+			return -ENOMEM;
+		memcpy(*buf, buff + hdr_size, length);
+		kfree(buff);
+
+		if (err_type == ERR_TYPE_KERNEL_PANIC_GZ)
+			*compressed = true;
+		else
+			*compressed = false;
+		return length;
+	}
+
+	*buf = buff;
+	return part->size;
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
+	if (machine_is(pseries)) {
+		nvram_type_ids[2] = PSTORE_TYPE_PPC_RTAS;
+		nvram_type_ids[3] = PSTORE_TYPE_PPC_OF;
+	} else
+		nvram_type_ids[2] = PSTORE_TYPE_PPC_OPAL;
+
+	nvram_pstore_info.buf = oops_data;
+	nvram_pstore_info.bufsize = oops_data_sz;
+
+	rc = pstore_register(&nvram_pstore_info);
+	if (rc != 0)
+		pr_err("nvram: pstore_register() failed, defaults to "
+				"kmsg_dump; returned %d\n", rc);
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
+void __init nvram_init_oops_partition(int rtas_partition_exists)
+{
+	int rc;
+
+	rc = nvram_init_os_partition(&oops_log_partition);
+	if (rc != 0) {
+#ifdef CONFIG_PPC_PSERIES
+		if (!rtas_partition_exists) {
+			pr_err("nvram: Failed to initialize oops partition!");
+			return;
+		}
+		pr_notice("nvram: Using %s partition to log both"
+			" RTAS errors and oops/panic reports\n",
+			rtas_log_partition.name);
+		memcpy(&oops_log_partition, &rtas_log_partition,
+						sizeof(rtas_log_partition));
+#else
+		pr_err("nvram: Failed to initialize oops partition!");
+		return;
+#endif
+	}
+	oops_buf = kmalloc(oops_log_partition.size, GFP_KERNEL);
+	if (!oops_buf) {
+		pr_err("nvram: No memory for %s partition\n",
+						oops_log_partition.name);
+		return;
+	}
+	oops_data = oops_buf + sizeof(struct oops_log_info);
+	oops_data_sz = oops_log_partition.size - sizeof(struct oops_log_info);
+
+	rc = nvram_pstore_init();
+
+	if (!rc)
+		return;
+
+	/*
+	 * Figure compression (preceded by elimination of each line's <n>
+	 * severity prefix) will reduce the oops/panic report to at most
+	 * 45% of its original size.
+	 */
+	big_oops_buf_sz = (oops_data_sz * 100) / 45;
+	big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
+	if (big_oops_buf) {
+		stream.workspace =  kmalloc(zlib_deflate_workspacesize(
+					WINDOW_BITS, MEM_LEVEL), GFP_KERNEL);
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
+	rc = kmsg_dump_register(&nvram_kmsg_dumper);
+	if (rc != 0) {
+		pr_err("nvram: kmsg_dump_register() failed; returned %d\n", rc);
+		kfree(oops_buf);
+		kfree(big_oops_buf);
+		kfree(stream.workspace);
+	}
+}
+
+/*
+ * This is our kmsg_dump callback, called after an oops or panic report
+ * has been written to the printk buffer.  We want to capture as much
+ * of the printk buffer as possible.  First, capture as much as we can
+ * that we think will compress sufficiently to fit in the lnx,oops-log
+ * partition.  If that's too much, go back and capture uncompressed text.
+ */
+static void oops_to_nvram(struct kmsg_dumper *dumper,
+			  enum kmsg_dump_reason reason)
+{
+	struct oops_log_info *oops_hdr = (struct oops_log_info *)oops_buf;
+	static unsigned int oops_count = 0;
+	static bool panicking = false;
+	static DEFINE_SPINLOCK(lock);
+	unsigned long flags;
+	size_t text_len;
+	unsigned int err_type = ERR_TYPE_KERNEL_PANIC_GZ;
+	int rc = -1;
+
+	switch (reason) {
+	case KMSG_DUMP_RESTART:
+	case KMSG_DUMP_HALT:
+	case KMSG_DUMP_POWEROFF:
+		/* These are almost always orderly shutdowns. */
+		return;
+	case KMSG_DUMP_OOPS:
+		break;
+	case KMSG_DUMP_PANIC:
+		panicking = true;
+		break;
+	case KMSG_DUMP_EMERG:
+		if (panicking)
+			/* Panic report already captured. */
+			return;
+		break;
+	default:
+		pr_err("%s: ignoring unrecognized KMSG_DUMP_* reason %d\n",
+		       __func__, (int) reason);
+		return;
+	}
+
+#ifdef CONFIG_PPC_PSERIES
+	if (clobbering_unread_rtas_event())
+		return;
+#endif
+
+	if (!spin_trylock_irqsave(&lock, flags))
+		return;
+
+	if (big_oops_buf) {
+		kmsg_dump_get_buffer(dumper, false,
+				     big_oops_buf, big_oops_buf_sz, &text_len);
+		rc = zip_oops(text_len);
+	}
+	if (rc != 0) {
+		kmsg_dump_rewind(dumper);
+		kmsg_dump_get_buffer(dumper, false,
+				     oops_data, oops_data_sz, &text_len);
+		err_type = ERR_TYPE_KERNEL_PANIC;
+		oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
+		oops_hdr->report_length = cpu_to_be16(text_len);
+		oops_hdr->timestamp = cpu_to_be64(get_seconds());
+	}
+
+	(void) nvram_write_os_partition(&oops_log_partition, oops_buf,
+		(int) (sizeof(*oops_hdr) + text_len), err_type,
+		++oops_count);
+
+	spin_unlock_irqrestore(&lock, flags);
+}
+
 static loff_t dev_nvram_llseek(struct file *file, loff_t offset, int origin)
 {
 	int size;
diff --git a/arch/powerpc/platforms/powernv/opal-nvram.c b/arch/powerpc/platforms/powernv/opal-nvram.c
index f9896fd..9db4398 100644
--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 
 #include <asm/opal.h>
+#include <asm/nvram.h>
 #include <asm/machdep.h>
 
 static unsigned int nvram_size;
@@ -62,6 +63,15 @@ static ssize_t opal_nvram_write(char *buf, size_t count, loff_t *index)
 	return count;
 }
 
+static int __init opal_nvram_init_log_partitions(void)
+{
+	/* Scan nvram for partitions */
+	nvram_scan_partitions();
+	nvram_init_oops_partition(0);
+	return 0;
+}
+machine_arch_initcall(powernv, opal_nvram_init_log_partitions);
+
 void __init opal_nvram_init(void)
 {
 	struct device_node *np;
diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 11a3b61..97b8fc6 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -30,129 +30,17 @@
 /* Max bytes to read/write in one go */
 #define NVRW_CNT 0x20
 
-/*
- * Set oops header version to distinguish between old and new format header.
- * lnx,oops-log partition max size is 4000, header version > 4000 will
- * help in identifying new header.
- */
-#define OOPS_HDR_VERSION 5000
-
 static unsigned int nvram_size;
 static int nvram_fetch, nvram_store;
 static char nvram_buf[NVRW_CNT];	/* assume this is in the first 4GB */
 static DEFINE_SPINLOCK(nvram_lock);
 
-struct err_log_info {
-	__be32 error_type;
-	__be32 seq_num;
-};
-
-struct nvram_os_partition {
-	const char *name;
-	int req_size;	/* desired size, in bytes */
-	int min_size;	/* minimum acceptable size (0 means req_size) */
-	long size;	/* size of data portion (excluding err_log_info) */
-	long index;	/* offset of data portion of partition */
-	bool os_partition; /* partition initialized by OS, not FW */
-};
-
-static struct nvram_os_partition rtas_log_partition = {
-	.name = "ibm,rtas-log",
-	.req_size = 2079,
-	.min_size = 1055,
-	.index = -1,
-	.os_partition = true
-};
-
-static struct nvram_os_partition oops_log_partition = {
-	.name = "lnx,oops-log",
-	.req_size = 4000,
-	.min_size = 2000,
-	.index = -1,
-	.os_partition = true
-};
-
-static const char *pseries_nvram_os_partitions[] = {
-	"ibm,rtas-log",
-	"lnx,oops-log",
-	NULL
-};
-
-struct oops_log_info {
-	__be16 version;
-	__be16 report_length;
-	__be64 timestamp;
-} __attribute__((packed));
-
-static void oops_to_nvram(struct kmsg_dumper *dumper,
-			  enum kmsg_dump_reason reason);
-
-static struct kmsg_dumper nvram_kmsg_dumper = {
-	.dump = oops_to_nvram
-};
-
 /* See clobbering_unread_rtas_event() */
 #define NVRAM_RTAS_READ_TIMEOUT 5		/* seconds */
 static unsigned long last_unread_rtas_event;	/* timestamp */
 
-/*
- * For capturing and compressing an oops or panic report...
-
- * big_oops_buf[] holds the uncompressed text we're capturing.
- *
- * oops_buf[] holds the compressed text, preceded by a oops header.
- * oops header has u16 holding the version of oops header (to differentiate
- * between old and new format header) followed by u16 holding the length of
- * the compressed* text (*Or uncompressed, if compression fails.) and u64
- * holding the timestamp. oops_buf[] gets written to NVRAM.
- *
- * oops_log_info points to the header. oops_data points to the compressed text.
- *
- * +- oops_buf
- * |                                   +- oops_data
- * v                                   v
- * +-----------+-----------+-----------+------------------------+
- * | version   | length    | timestamp | text                   |
- * | (2 bytes) | (2 bytes) | (8 bytes) | (oops_data_sz bytes)   |
- * +-----------+-----------+-----------+------------------------+
- * ^
- * +- oops_log_info
- *
- * We preallocate these buffers during init to avoid kmalloc during oops/panic.
- */
-static size_t big_oops_buf_sz;
-static char *big_oops_buf, *oops_buf;
-static char *oops_data;
-static size_t oops_data_sz;
-
-/* Compression parameters */
-#define COMPR_LEVEL 6
-#define WINDOW_BITS 12
-#define MEM_LEVEL 4
-static struct z_stream_s stream;
-
 #ifdef CONFIG_PSTORE
-static struct nvram_os_partition of_config_partition = {
-	.name = "of-config",
-	.index = -1,
-	.os_partition = false
-};
-
-static struct nvram_os_partition common_partition = {
-	.name = "common",
-	.index = -1,
-	.os_partition = false
-};
-
-static enum pstore_type_id nvram_type_ids[] = {
-	PSTORE_TYPE_DMESG,
-	PSTORE_TYPE_PPC_RTAS,
-	PSTORE_TYPE_PPC_OF,
-	PSTORE_TYPE_PPC_COMMON,
-	-1
-};
-static int read_type;
-static unsigned long last_rtas_event;
+unsigned long last_rtas_event;
 #endif
 
 static ssize_t pSeries_nvram_read(char *buf, size_t count, loff_t *index)
@@ -246,73 +134,11 @@ static ssize_t pSeries_nvram_get_size(void)
 	return nvram_size ? nvram_size : -ENODEV;
 }
 
-
-/* nvram_write_os_partition, nvram_write_error_log
+/* nvram_write_error_log
  *
  * We need to buffer the error logs into nvram to ensure that we have
- * the failure information to decode.  If we have a severe error there
- * is no way to guarantee that the OS or the machine is in a state to
- * get back to user land and write the error to disk.  For example if
- * the SCSI device driver causes a Machine Check by writing to a bad
- * IO address, there is no way of guaranteeing that the device driver
- * is in any state that is would also be able to write the error data
- * captured to disk, thus we buffer it in NVRAM for analysis on the
- * next boot.
- *
- * In NVRAM the partition containing the error log buffer will looks like:
- * Header (in bytes):
- * +-----------+----------+--------+------------+------------------+
- * | signature | checksum | length | name       | data             |
- * |0          |1         |2      3|4         15|16        length-1|
- * +-----------+----------+--------+------------+------------------+
- *
- * The 'data' section would look like (in bytes):
- * +--------------+------------+-----------------------------------+
- * | event_logged | sequence # | error log                         |
- * |0            3|4          7|8                  error_log_size-1|
- * +--------------+------------+-----------------------------------+
- *
- * event_logged: 0 if event has not been logged to syslog, 1 if it has
- * sequence #: The unique sequence # for each event. (until it wraps)
- * error log: The error log from event_scan
+ * the failure information to decode.
  */
-static int nvram_write_os_partition(struct nvram_os_partition *part,
-				    char *buff, int length,
-				    unsigned int err_type,
-				    unsigned int error_log_cnt)
-{
-	int rc;
-	loff_t tmp_index;
-	struct err_log_info info;
-	
-	if (part->index == -1) {
-		return -ESPIPE;
-	}
-
-	if (length > part->size) {
-		length = part->size;
-	}
-
-	info.error_type = cpu_to_be32(err_type);
-	info.seq_num = cpu_to_be32(error_log_cnt);
-
-	tmp_index = part->index;
-
-	rc = ppc_md.nvram_write((char *)&info, sizeof(struct err_log_info), &tmp_index);
-	if (rc <= 0) {
-		pr_err("%s: Failed nvram_write (%d)\n", __func__, rc);
-		return rc;
-	}
-
-	rc = ppc_md.nvram_write(buff, length, &tmp_index);
-	if (rc <= 0) {
-		pr_err("%s: Failed nvram_write (%d)\n", __func__, rc);
-		return rc;
-	}
-	
-	return 0;
-}
-
 int nvram_write_error_log(char * buff, int length,
                           unsigned int err_type, unsigned int error_log_cnt)
 {
@@ -328,50 +154,6 @@ int nvram_write_error_log(char * buff, int length,
 	return rc;
 }
 
-/* nvram_read_partition
- *
- * Reads nvram partition for at most 'length'
- */
-static int nvram_read_partition(struct nvram_os_partition *part, char *buff,
-				int length, unsigned int *err_type,
-				unsigned int *error_log_cnt)
-{
-	int rc;
-	loff_t tmp_index;
-	struct err_log_info info;
-	
-	if (part->index == -1)
-		return -1;
-
-	if (length > part->size)
-		length = part->size;
-
-	tmp_index = part->index;
-
-	if (part->os_partition) {
-		rc = ppc_md.nvram_read((char *)&info,
-					sizeof(struct err_log_info),
-					&tmp_index);
-		if (rc <= 0) {
-			pr_err("%s: Failed nvram_read (%d)\n", __func__, rc);
-			return rc;
-		}
-	}
-
-	rc = ppc_md.nvram_read(buff, length, &tmp_index);
-	if (rc <= 0) {
-		pr_err("%s: Failed nvram_read (%d)\n", __func__, rc);
-		return rc;
-	}
-
-	if (part->os_partition) {
-		*error_log_cnt = be32_to_cpu(info.seq_num);
-		*err_type = be32_to_cpu(info.error_type);
-	}
-
-	return 0;
-}
-
 /* nvram_read_error_log
  *
  * Reads nvram for error log for at most 'length'
@@ -407,67 +189,6 @@ int nvram_clear_error_log(void)
 	return 0;
 }
 
-/* pseries_nvram_init_os_partition
- *
- * This sets up a partition with an "OS" signature.
- *
- * The general strategy is the following:
- * 1.) If a partition with the indicated name already exists...
- *	- If it's large enough, use it.
- *	- Otherwise, recycle it and keep going.
- * 2.) Search for a free partition that is large enough.
- * 3.) If there's not a free partition large enough, recycle any obsolete
- * OS partitions and try again.
- * 4.) Will first try getting a chunk that will satisfy the requested size.
- * 5.) If a chunk of the requested size cannot be allocated, then try finding
- * a chunk that will satisfy the minum needed.
- *
- * Returns 0 on success, else -1.
- */
-static int __init pseries_nvram_init_os_partition(struct nvram_os_partition
-									*part)
-{
-	loff_t p;
-	int size;
-
-	/* Look for ours */
-	p = nvram_find_partition(part->name, NVRAM_SIG_OS, &size);
-
-	/* Found one but too small, remove it */
-	if (p && size < part->min_size) {
-		pr_info("nvram: Found too small %s partition,"
-					" removing it...\n", part->name);
-		nvram_remove_partition(part->name, NVRAM_SIG_OS, NULL);
-		p = 0;
-	}
-
-	/* Create one if we didn't find */
-	if (!p) {
-		p = nvram_create_partition(part->name, NVRAM_SIG_OS,
-					part->req_size, part->min_size);
-		if (p == -ENOSPC) {
-			pr_info("nvram: No room to create %s partition, "
-				"deleting any obsolete OS partitions...\n",
-				part->name);
-			nvram_remove_partition(NULL, NVRAM_SIG_OS,
-						pseries_nvram_os_partitions);
-			p = nvram_create_partition(part->name, NVRAM_SIG_OS,
-					part->req_size, part->min_size);
-		}
-	}
-
-	if (p <= 0) {
-		pr_err("nvram: Failed to find or create %s"
-		       " partition, err %d\n", part->name, (int)p);
-		return -1;
-	}
-
-	part->index = p;
-	part->size = nvram_get_partition_size(p) - sizeof(struct err_log_info);
-	
-	return 0;
-}
-
 /*
  * Are we using the ibm,rtas-log for oops/panic reports?  And if so,
  * would logging this oops/panic overwrite an RTAS event that rtas_errd
@@ -476,7 +197,7 @@ static int __init pseries_nvram_init_os_partition(struct nvram_os_partition
  * We assume that if rtas_errd hasn't read the RTAS event in
  * NVRAM_RTAS_READ_TIMEOUT seconds, it's probably not going to.
  */
-static int clobbering_unread_rtas_event(void)
+int clobbering_unread_rtas_event(void)
 {
 	return (oops_log_partition.index == rtas_log_partition.index
 		&& last_unread_rtas_event
@@ -484,311 +205,6 @@ static int clobbering_unread_rtas_event(void)
 						NVRAM_RTAS_READ_TIMEOUT);
 }
 
-/* Derived from logfs_compress() */
-static int nvram_compress(const void *in, void *out, size_t inlen,
-							size_t outlen)
-{
-	int err, ret;
-
-	ret = -EIO;
-	err = zlib_deflateInit2(&stream, COMPR_LEVEL, Z_DEFLATED, WINDOW_BITS,
-						MEM_LEVEL, Z_DEFAULT_STRATEGY);
-	if (err != Z_OK)
-		goto error;
-
-	stream.next_in = in;
-	stream.avail_in = inlen;
-	stream.total_in = 0;
-	stream.next_out = out;
-	stream.avail_out = outlen;
-	stream.total_out = 0;
-
-	err = zlib_deflate(&stream, Z_FINISH);
-	if (err != Z_STREAM_END)
-		goto error;
-
-	err = zlib_deflateEnd(&stream);
-	if (err != Z_OK)
-		goto error;
-
-	if (stream.total_out >= stream.total_in)
-		goto error;
-
-	ret = stream.total_out;
-error:
-	return ret;
-}
-
-/* Compress the text from big_oops_buf into oops_buf. */
-static int zip_oops(size_t text_len)
-{
-	struct oops_log_info *oops_hdr = (struct oops_log_info *)oops_buf;
-	int zipped_len = nvram_compress(big_oops_buf, oops_data, text_len,
-								oops_data_sz);
-	if (zipped_len < 0) {
-		pr_err("nvram: compression failed; returned %d\n", zipped_len);
-		pr_err("nvram: logging uncompressed oops/panic report\n");
-		return -1;
-	}
-	oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
-	oops_hdr->report_length = cpu_to_be16(zipped_len);
-	oops_hdr->timestamp = cpu_to_be64(get_seconds());
-	return 0;
-}
-
-#ifdef CONFIG_PSTORE
-static int nvram_pstore_open(struct pstore_info *psi)
-{
-	/* Reset the iterator to start reading partitions again */
-	read_type = -1;
-	return 0;
-}
-
-/**
- * nvram_pstore_write - pstore write callback for nvram
- * @type:               Type of message logged
- * @reason:             reason behind dump (oops/panic)
- * @id:                 identifier to indicate the write performed
- * @part:               pstore writes data to registered buffer in parts,
- *                      part number will indicate the same.
- * @count:              Indicates oops count
- * @compressed:         Flag to indicate the log is compressed
- * @size:               number of bytes written to the registered buffer
- * @psi:                registered pstore_info structure
- *
- * Called by pstore_dump() when an oops or panic report is logged in the
- * printk buffer.
- * Returns 0 on successful write.
- */
-static int nvram_pstore_write(enum pstore_type_id type,
-				enum kmsg_dump_reason reason,
-				u64 *id, unsigned int part, int count,
-				bool compressed, size_t size,
-				struct pstore_info *psi)
-{
-	int rc;
-	unsigned int err_type = ERR_TYPE_KERNEL_PANIC;
-	struct oops_log_info *oops_hdr = (struct oops_log_info *) oops_buf;
-
-	/* part 1 has the recent messages from printk buffer */
-	if (part > 1 || type != PSTORE_TYPE_DMESG ||
-				clobbering_unread_rtas_event())
-		return -1;
-
-	oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
-	oops_hdr->report_length = cpu_to_be16(size);
-	oops_hdr->timestamp = cpu_to_be64(get_seconds());
-
-	if (compressed)
-		err_type = ERR_TYPE_KERNEL_PANIC_GZ;
-
-	rc = nvram_write_os_partition(&oops_log_partition, oops_buf,
-		(int) (sizeof(*oops_hdr) + size), err_type, count);
-
-	if (rc != 0)
-		return rc;
-
-	*id = part;
-	return 0;
-}
-
-/*
- * Reads the oops/panic report, rtas, of-config and common partition.
- * Returns the length of the data we read from each partition.
- * Returns 0 if we've been called before.
- */
-static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
-				int *count, struct timespec *time, char **buf,
-				bool *compressed, struct pstore_info *psi)
-{
-	struct oops_log_info *oops_hdr;
-	unsigned int err_type, id_no, size = 0;
-	struct nvram_os_partition *part = NULL;
-	char *buff = NULL;
-	int sig = 0;
-	loff_t p;
-
-	read_type++;
-
-	switch (nvram_type_ids[read_type]) {
-	case PSTORE_TYPE_DMESG:
-		part = &oops_log_partition;
-		*type = PSTORE_TYPE_DMESG;
-		break;
-	case PSTORE_TYPE_PPC_RTAS:
-		part = &rtas_log_partition;
-		*type = PSTORE_TYPE_PPC_RTAS;
-		time->tv_sec = last_rtas_event;
-		time->tv_nsec = 0;
-		break;
-	case PSTORE_TYPE_PPC_OF:
-		sig = NVRAM_SIG_OF;
-		part = &of_config_partition;
-		*type = PSTORE_TYPE_PPC_OF;
-		*id = PSTORE_TYPE_PPC_OF;
-		time->tv_sec = 0;
-		time->tv_nsec = 0;
-		break;
-	case PSTORE_TYPE_PPC_COMMON:
-		sig = NVRAM_SIG_SYS;
-		part = &common_partition;
-		*type = PSTORE_TYPE_PPC_COMMON;
-		*id = PSTORE_TYPE_PPC_COMMON;
-		time->tv_sec = 0;
-		time->tv_nsec = 0;
-		break;
-	default:
-		return 0;
-	}
-
-	if (!part->os_partition) {
-		p = nvram_find_partition(part->name, sig, &size);
-		if (p <= 0) {
-			pr_err("nvram: Failed to find partition %s, "
-				"err %d\n", part->name, (int)p);
-			return 0;
-		}
-		part->index = p;
-		part->size = size;
-	}
-
-	buff = kmalloc(part->size, GFP_KERNEL);
-
-	if (!buff)
-		return -ENOMEM;
-
-	if (nvram_read_partition(part, buff, part->size, &err_type, &id_no)) {
-		kfree(buff);
-		return 0;
-	}
-
-	*count = 0;
-
-	if (part->os_partition)
-		*id = id_no;
-
-	if (nvram_type_ids[read_type] == PSTORE_TYPE_DMESG) {
-		size_t length, hdr_size;
-
-		oops_hdr = (struct oops_log_info *)buff;
-		if (be16_to_cpu(oops_hdr->version) < OOPS_HDR_VERSION) {
-			/* Old format oops header had 2-byte record size */
-			hdr_size = sizeof(u16);
-			length = be16_to_cpu(oops_hdr->version);
-			time->tv_sec = 0;
-			time->tv_nsec = 0;
-		} else {
-			hdr_size = sizeof(*oops_hdr);
-			length = be16_to_cpu(oops_hdr->report_length);
-			time->tv_sec = be64_to_cpu(oops_hdr->timestamp);
-			time->tv_nsec = 0;
-		}
-		*buf = kmalloc(length, GFP_KERNEL);
-		if (*buf == NULL)
-			return -ENOMEM;
-		memcpy(*buf, buff + hdr_size, length);
-		kfree(buff);
-
-		if (err_type == ERR_TYPE_KERNEL_PANIC_GZ)
-			*compressed = true;
-		else
-			*compressed = false;
-		return length;
-	}
-
-	*buf = buff;
-	return part->size;
-}
-
-static struct pstore_info nvram_pstore_info = {
-	.owner = THIS_MODULE,
-	.name = "nvram",
-	.open = nvram_pstore_open,
-	.read = nvram_pstore_read,
-	.write = nvram_pstore_write,
-};
-
-static int nvram_pstore_init(void)
-{
-	int rc = 0;
-
-	nvram_pstore_info.buf = oops_data;
-	nvram_pstore_info.bufsize = oops_data_sz;
-
-	rc = pstore_register(&nvram_pstore_info);
-	if (rc != 0)
-		pr_err("nvram: pstore_register() failed, defaults to "
-				"kmsg_dump; returned %d\n", rc);
-
-	return rc;
-}
-#else
-static int nvram_pstore_init(void)
-{
-	return -1;
-}
-#endif
-
-static void __init nvram_init_oops_partition(int rtas_partition_exists)
-{
-	int rc;
-
-	rc = pseries_nvram_init_os_partition(&oops_log_partition);
-	if (rc != 0) {
-		if (!rtas_partition_exists)
-			return;
-		pr_notice("nvram: Using %s partition to log both"
-			" RTAS errors and oops/panic reports\n",
-			rtas_log_partition.name);
-		memcpy(&oops_log_partition, &rtas_log_partition,
-						sizeof(rtas_log_partition));
-	}
-	oops_buf = kmalloc(oops_log_partition.size, GFP_KERNEL);
-	if (!oops_buf) {
-		pr_err("nvram: No memory for %s partition\n",
-						oops_log_partition.name);
-		return;
-	}
-	oops_data = oops_buf + sizeof(struct oops_log_info);
-	oops_data_sz = oops_log_partition.size - sizeof(struct oops_log_info);
-
-	rc = nvram_pstore_init();
-
-	if (!rc)
-		return;
-
-	/*
-	 * Figure compression (preceded by elimination of each line's <n>
-	 * severity prefix) will reduce the oops/panic report to at most
-	 * 45% of its original size.
-	 */
-	big_oops_buf_sz = (oops_data_sz * 100) / 45;
-	big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
-	if (big_oops_buf) {
-		stream.workspace =  kmalloc(zlib_deflate_workspacesize(
-					WINDOW_BITS, MEM_LEVEL), GFP_KERNEL);
-		if (!stream.workspace) {
-			pr_err("nvram: No memory for compression workspace; "
-				"skipping compression of %s partition data\n",
-				oops_log_partition.name);
-			kfree(big_oops_buf);
-			big_oops_buf = NULL;
-		}
-	} else {
-		pr_err("No memory for uncompressed %s data; "
-			"skipping compression\n", oops_log_partition.name);
-		stream.workspace = NULL;
-	}
-
-	rc = kmsg_dump_register(&nvram_kmsg_dumper);
-	if (rc != 0) {
-		pr_err("nvram: kmsg_dump_register() failed; returned %d\n", rc);
-		kfree(oops_buf);
-		kfree(big_oops_buf);
-		kfree(stream.workspace);
-	}
-}
-
 static int __init pseries_nvram_init_log_partitions(void)
 {
 	int rc;
@@ -796,7 +212,7 @@ static int __init pseries_nvram_init_log_partitions(void)
 	/* Scan nvram for partitions */
 	nvram_scan_partitions();
 
-	rc = pseries_nvram_init_os_partition(&rtas_log_partition);
+	rc = nvram_init_os_partition(&rtas_log_partition);
 	nvram_init_oops_partition(rc == 0);
 	return 0;
 }
@@ -832,72 +248,3 @@ int __init pSeries_nvram_init(void)
 	return 0;
 }
 
-
-/*
- * This is our kmsg_dump callback, called after an oops or panic report
- * has been written to the printk buffer.  We want to capture as much
- * of the printk buffer as possible.  First, capture as much as we can
- * that we think will compress sufficiently to fit in the lnx,oops-log
- * partition.  If that's too much, go back and capture uncompressed text.
- */
-static void oops_to_nvram(struct kmsg_dumper *dumper,
-			  enum kmsg_dump_reason reason)
-{
-	struct oops_log_info *oops_hdr = (struct oops_log_info *)oops_buf;
-	static unsigned int oops_count = 0;
-	static bool panicking = false;
-	static DEFINE_SPINLOCK(lock);
-	unsigned long flags;
-	size_t text_len;
-	unsigned int err_type = ERR_TYPE_KERNEL_PANIC_GZ;
-	int rc = -1;
-
-	switch (reason) {
-	case KMSG_DUMP_RESTART:
-	case KMSG_DUMP_HALT:
-	case KMSG_DUMP_POWEROFF:
-		/* These are almost always orderly shutdowns. */
-		return;
-	case KMSG_DUMP_OOPS:
-		break;
-	case KMSG_DUMP_PANIC:
-		panicking = true;
-		break;
-	case KMSG_DUMP_EMERG:
-		if (panicking)
-			/* Panic report already captured. */
-			return;
-		break;
-	default:
-		pr_err("%s: ignoring unrecognized KMSG_DUMP_* reason %d\n",
-		       __func__, (int) reason);
-		return;
-	}
-
-	if (clobbering_unread_rtas_event())
-		return;
-
-	if (!spin_trylock_irqsave(&lock, flags))
-		return;
-
-	if (big_oops_buf) {
-		kmsg_dump_get_buffer(dumper, false,
-				     big_oops_buf, big_oops_buf_sz, &text_len);
-		rc = zip_oops(text_len);
-	}
-	if (rc != 0) {
-		kmsg_dump_rewind(dumper);
-		kmsg_dump_get_buffer(dumper, false,
-				     oops_data, oops_data_sz, &text_len);
-		err_type = ERR_TYPE_KERNEL_PANIC;
-		oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
-		oops_hdr->report_length = cpu_to_be16(text_len);
-		oops_hdr->timestamp = cpu_to_be64(get_seconds());
-	}
-
-	(void) nvram_write_os_partition(&oops_log_partition, oops_buf,
-		(int) (sizeof(*oops_hdr) + text_len), err_type,
-		++oops_count);
-
-	spin_unlock_irqrestore(&lock, flags);
-}
