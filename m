Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	Ulrich.Weigand@de.ibm.com
Subject: [PATCH 5/8] powerpc/pseries: Fix endian issues in nvram code
Date: Thu, 12 Dec 2013 15:59:38 +1100
Message-Id: <1386824381-14032-6-git-send-email-anton@samba.org>
In-Reply-To: <1386824381-14032-1-git-send-email-anton@samba.org>
References: <1386824381-14032-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The NVRAM code has a number of endian issues. I noticed a very
confused error log count:

RTAS: 100663330 -------- RTAS event begin --------

100663330 == 0x06000022. 0x6 LE error logs and 0x22 BE error logs.

The pstore code has similar issues - if we write an oops in one
endian and attempt to read it in another we get junk.

Make both of these formats big endian, and byteswap as required.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/pseries/nvram.c | 46 +++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 7bfaf58..d7096f2 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -43,8 +43,8 @@ static char nvram_buf[NVRW_CNT];	/* assume this is in the first 4GB */
 static DEFINE_SPINLOCK(nvram_lock);
 
 struct err_log_info {
-	int error_type;
-	unsigned int seq_num;
+	__be32 error_type;
+	__be32 seq_num;
 };
 
 struct nvram_os_partition {
@@ -79,9 +79,9 @@ static const char *pseries_nvram_os_partitions[] = {
 };
 
 struct oops_log_info {
-	u16 version;
-	u16 report_length;
-	u64 timestamp;
+	__be16 version;
+	__be16 report_length;
+	__be64 timestamp;
 } __attribute__((packed));
 
 static void oops_to_nvram(struct kmsg_dumper *dumper,
@@ -291,8 +291,8 @@ int nvram_write_os_partition(struct nvram_os_partition *part, char * buff,
 		length = part->size;
 	}
 
-	info.error_type = err_type;
-	info.seq_num = error_log_cnt;
+	info.error_type = cpu_to_be32(err_type);
+	info.seq_num = cpu_to_be32(error_log_cnt);
 
 	tmp_index = part->index;
 
@@ -364,8 +364,8 @@ int nvram_read_partition(struct nvram_os_partition *part, char *buff,
 	}
 
 	if (part->os_partition) {
-		*error_log_cnt = info.seq_num;
-		*err_type = info.error_type;
+		*error_log_cnt = be32_to_cpu(info.seq_num);
+		*err_type = be32_to_cpu(info.error_type);
 	}
 
 	return 0;
@@ -529,9 +529,9 @@ static int zip_oops(size_t text_len)
 		pr_err("nvram: logging uncompressed oops/panic report\n");
 		return -1;
 	}
-	oops_hdr->version = OOPS_HDR_VERSION;
-	oops_hdr->report_length = (u16) zipped_len;
-	oops_hdr->timestamp = get_seconds();
+	oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
+	oops_hdr->report_length = cpu_to_be16(zipped_len);
+	oops_hdr->timestamp = cpu_to_be64(get_seconds());
 	return 0;
 }
 
@@ -574,9 +574,9 @@ static int nvram_pstore_write(enum pstore_type_id type,
 				clobbering_unread_rtas_event())
 		return -1;
 
-	oops_hdr->version = OOPS_HDR_VERSION;
-	oops_hdr->report_length = (u16) size;
-	oops_hdr->timestamp = get_seconds();
+	oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
+	oops_hdr->report_length = cpu_to_be16(size);
+	oops_hdr->timestamp = cpu_to_be64(get_seconds());
 
 	if (compressed)
 		err_type = ERR_TYPE_KERNEL_PANIC_GZ;
@@ -670,16 +670,16 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
 		size_t length, hdr_size;
 
 		oops_hdr = (struct oops_log_info *)buff;
-		if (oops_hdr->version < OOPS_HDR_VERSION) {
+		if (be16_to_cpu(oops_hdr->version) < OOPS_HDR_VERSION) {
 			/* Old format oops header had 2-byte record size */
 			hdr_size = sizeof(u16);
-			length = oops_hdr->version;
+			length = be16_to_cpu(oops_hdr->version);
 			time->tv_sec = 0;
 			time->tv_nsec = 0;
 		} else {
 			hdr_size = sizeof(*oops_hdr);
-			length = oops_hdr->report_length;
-			time->tv_sec = oops_hdr->timestamp;
+			length = be16_to_cpu(oops_hdr->report_length);
+			time->tv_sec = be64_to_cpu(oops_hdr->timestamp);
 			time->tv_nsec = 0;
 		}
 		*buf = kmalloc(length, GFP_KERNEL);
@@ -889,13 +889,13 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
 		kmsg_dump_get_buffer(dumper, false,
 				     oops_data, oops_data_sz, &text_len);
 		err_type = ERR_TYPE_KERNEL_PANIC;
-		oops_hdr->version = OOPS_HDR_VERSION;
-		oops_hdr->report_length = (u16) text_len;
-		oops_hdr->timestamp = get_seconds();
+		oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
+		oops_hdr->report_length = cpu_to_be16(text_len);
+		oops_hdr->timestamp = cpu_to_be64(get_seconds());
 	}
 
 	(void) nvram_write_os_partition(&oops_log_partition, oops_buf,
-		(int) (sizeof(*oops_hdr) + oops_hdr->report_length), err_type,
+		(int) (sizeof(*oops_hdr) + text_len), err_type,
 		++oops_count);
 
 	spin_unlock_irqrestore(&lock, flags);
-- 
1.8.3.2
