Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D26FF2C0168
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 20:18:23 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 25 Apr 2013 20:12:26 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 79AEE3578052
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 20:18:19 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3PAIC7i11534480
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 20:18:12 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3PAIHbb017358
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 20:18:18 +1000
Subject: [PATCH v3 2/8] powerpc/pseries: Add version and timestamp to oops
 header
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 25 Apr 2013 15:48:06 +0530
Message-ID: <20130425101806.21017.25424.stgit@aruna-ThinkPad-T420>
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

Introduce version and timestamp information in the oops header.
oops_log_info (oops header) holds version (to distinguish between old
and new format oops header), length of the oops text
(compressed or uncompressed) and timestamp.

The version field will sit in the same place as the length in old
headers. version is assigned 5000 (greater than oops partition size)
so that existing tools will refuse to dump new style partitions as
the length is too large. The updated tools will work with both
old and new format headers.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Reviewed-by: Jim Keniston <jkenisto@us.ibm.com>
---
 arch/powerpc/platforms/pseries/nvram.c |   57 +++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index e54a8b7..742735a 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -29,6 +29,13 @@
 /* Max bytes to read/write in one go */
 #define NVRW_CNT 0x20
 
+/*
+ * Set oops header version to distingush between old and new format header.
+ * lnx,oops-log partition max size is 4000, header version > 4000 will
+ * help in identifying new header.
+ */
+#define OOPS_HDR_VERSION 5000
+
 static unsigned int nvram_size;
 static int nvram_fetch, nvram_store;
 static char nvram_buf[NVRW_CNT];	/* assume this is in the first 4GB */
@@ -67,6 +74,12 @@ static const char *pseries_nvram_os_partitions[] = {
 	NULL
 };
 
+struct oops_log_info {
+	u16 version;
+	u16 report_length;
+	u64 timestamp;
+} __attribute__((packed));
+
 static void oops_to_nvram(struct kmsg_dumper *dumper,
 			  enum kmsg_dump_reason reason);
 
@@ -83,28 +96,28 @@ static unsigned long last_unread_rtas_event;	/* timestamp */
 
  * big_oops_buf[] holds the uncompressed text we're capturing.
  *
- * oops_buf[] holds the compressed text, preceded by a prefix.
- * The prefix is just a u16 holding the length of the compressed* text.
- * (*Or uncompressed, if compression fails.)  oops_buf[] gets written
- * to NVRAM.
+ * oops_buf[] holds the compressed text, preceded by a oops header.
+ * oops header has u16 holding the version of oops header (to differentiate
+ * between old and new format header) followed by u16 holding the length of
+ * the compressed* text (*Or uncompressed, if compression fails.) and u64
+ * holding the timestamp. oops_buf[] gets written to NVRAM.
  *
- * oops_len points to the prefix.  oops_data points to the compressed text.
+ * oops_log_info points to the header. oops_data points to the compressed text.
  *
  * +- oops_buf
- * |		+- oops_data
- * v		v
- * +------------+-----------------------------------------------+
- * | length	| text                                          |
- * | (2 bytes)	| (oops_data_sz bytes)                          |
- * +------------+-----------------------------------------------+
+ * |                                   +- oops_data
+ * v                                   v
+ * +-----------+-----------+-----------+------------------------+
+ * | version   | length    | timestamp | text                   |
+ * | (2 bytes) | (2 bytes) | (8 bytes) | (oops_data_sz bytes)   |
+ * +-----------+-----------+-----------+------------------------+
  * ^
- * +- oops_len
+ * +- oops_log_info
  *
  * We preallocate these buffers during init to avoid kmalloc during oops/panic.
  */
 static size_t big_oops_buf_sz;
 static char *big_oops_buf, *oops_buf;
-static u16 *oops_len;
 static char *oops_data;
 static size_t oops_data_sz;
 
@@ -425,9 +438,8 @@ static void __init nvram_init_oops_partition(int rtas_partition_exists)
 						oops_log_partition.name);
 		return;
 	}
-	oops_len = (u16*) oops_buf;
-	oops_data = oops_buf + sizeof(u16);
-	oops_data_sz = oops_log_partition.size - sizeof(u16);
+	oops_data = oops_buf + sizeof(struct oops_log_info);
+	oops_data_sz = oops_log_partition.size - sizeof(struct oops_log_info);
 
 	/*
 	 * Figure compression (preceded by elimination of each line's <n>
@@ -555,6 +567,7 @@ error:
 /* Compress the text from big_oops_buf into oops_buf. */
 static int zip_oops(size_t text_len)
 {
+	struct oops_log_info *oops_hdr = (struct oops_log_info *)oops_buf;
 	int zipped_len = nvram_compress(big_oops_buf, oops_data, text_len,
 								oops_data_sz);
 	if (zipped_len < 0) {
@@ -562,7 +575,9 @@ static int zip_oops(size_t text_len)
 		pr_err("nvram: logging uncompressed oops/panic report\n");
 		return -1;
 	}
-	*oops_len = (u16) zipped_len;
+	oops_hdr->version = OOPS_HDR_VERSION;
+	oops_hdr->report_length = (u16) zipped_len;
+	oops_hdr->timestamp = get_seconds();
 	return 0;
 }
 
@@ -576,6 +591,7 @@ static int zip_oops(size_t text_len)
 static void oops_to_nvram(struct kmsg_dumper *dumper,
 			  enum kmsg_dump_reason reason)
 {
+	struct oops_log_info *oops_hdr = (struct oops_log_info *)oops_buf;
 	static unsigned int oops_count = 0;
 	static bool panicking = false;
 	static DEFINE_SPINLOCK(lock);
@@ -622,11 +638,14 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
 		kmsg_dump_get_buffer(dumper, false,
 				     oops_data, oops_data_sz, &text_len);
 		err_type = ERR_TYPE_KERNEL_PANIC;
-		*oops_len = (u16) text_len;
+		oops_hdr->version = OOPS_HDR_VERSION;
+		oops_hdr->report_length = (u16) text_len;
+		oops_hdr->timestamp = get_seconds();
 	}
 
 	(void) nvram_write_os_partition(&oops_log_partition, oops_buf,
-		(int) (sizeof(*oops_len) + *oops_len), err_type, ++oops_count);
+		(int) (sizeof(*oops_hdr) + oops_hdr->report_length), err_type,
+		++oops_count);
 
 	spin_unlock_irqrestore(&lock, flags);
 }
