Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CDAF02C03BE
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jun 2013 18:33:33 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 27 Jun 2013 13:58:50 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C029E1258043
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jun 2013 14:02:33 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5R8XbKA12386526
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jun 2013 14:03:37 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5R8XEOl030337
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jun 2013 18:33:18 +1000
Subject: [PATCH v2 3/3] powerpc/pseries: Support compression of oops text
 via pstore
To: tony.luck@intel.com, keescook@chromium.org, benh@kernel.crashing.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 27 Jun 2013 14:03:13 +0530
Message-ID: <20130627083313.16749.86762.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130627082941.16749.67023.stgit@aruna-ThinkPad-T420>
References: <20130627082941.16749.67023.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jkenisto@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
 cbouatmailru@gmail.com, anton@samba.org, ccross@android.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch set supports compression of oops messages while writing to NVRAM,
this helps in capturing more of oops data to lnx,oops-log. The pstore file
for oops messages will be in decompressed format making it readable.

In case compression fails, the patch takes care of copying the header added
by pstore and last oops_data_sz bytes of big_oops_buf to NVRAM so that we
have recent oops messages in lnx,oops-log.

In case decompression fails, it will result in absence of oops file but still
have files (in /dev/pstore) for other partitions.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/nvram.c |  131 +++++++++++++++++++++++++++++---
 1 file changed, 117 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 588bab5..9f8671a 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -539,6 +539,65 @@ static int zip_oops(size_t text_len)
 }
 
 #ifdef CONFIG_PSTORE
+/* Derived from logfs_uncompress */
+int nvram_decompress(void *in, void *out, size_t inlen, size_t outlen)
+{
+	int err, ret;
+
+	ret = -EIO;
+	err = zlib_inflateInit(&stream);
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
+	err = zlib_inflate(&stream, Z_FINISH);
+	if (err != Z_STREAM_END)
+		goto error;
+
+	err = zlib_inflateEnd(&stream);
+	if (err != Z_OK)
+		goto error;
+
+	ret = stream.total_out;
+error:
+	return ret;
+}
+
+static int unzip_oops(char *oops_buf, char *big_buf)
+{
+	struct oops_log_info *oops_hdr = (struct oops_log_info *)oops_buf;
+	u64 timestamp = oops_hdr->timestamp;
+	char *big_oops_data = NULL;
+	char *oops_data_buf = NULL;
+	size_t big_oops_data_sz;
+	int unzipped_len;
+
+	big_oops_data = big_buf + sizeof(struct oops_log_info);
+	big_oops_data_sz = big_oops_buf_sz - sizeof(struct oops_log_info);
+	oops_data_buf = oops_buf + sizeof(struct oops_log_info);
+
+	unzipped_len = nvram_decompress(oops_data_buf, big_oops_data,
+					oops_hdr->report_length,
+					big_oops_data_sz);
+
+	if (unzipped_len < 0) {
+		pr_err("nvram: decompression failed; returned %d\n",
+								unzipped_len);
+		return -1;
+	}
+	oops_hdr = (struct oops_log_info *)big_buf;
+	oops_hdr->version = OOPS_HDR_VERSION;
+	oops_hdr->report_length = (u16) unzipped_len;
+	oops_hdr->timestamp = timestamp;
+	return 0;
+}
+
 static int nvram_pstore_open(struct pstore_info *psi)
 {
 	/* Reset the iterator to start reading partitions again */
@@ -569,6 +628,7 @@ static int nvram_pstore_write(enum pstore_type_id type,
 				struct pstore_info *psi)
 {
 	int rc;
+	unsigned int err_type = ERR_TYPE_KERNEL_PANIC;
 	struct oops_log_info *oops_hdr = (struct oops_log_info *) oops_buf;
 
 	/* part 1 has the recent messages from printk buffer */
@@ -579,8 +639,30 @@ static int nvram_pstore_write(enum pstore_type_id type,
 	oops_hdr->version = OOPS_HDR_VERSION;
 	oops_hdr->report_length = (u16) size;
 	oops_hdr->timestamp = get_seconds();
+
+	if (big_oops_buf) {
+		rc = zip_oops(size);
+		/*
+		 * If compression fails copy recent log messages from
+		 * big_oops_buf to oops_data.
+		 */
+		if (rc != 0) {
+			size_t diff = size - oops_data_sz + hsize;
+
+			if (size > oops_data_sz) {
+				memcpy(oops_data, big_oops_buf, hsize);
+				memcpy(oops_data + hsize, big_oops_buf + diff,
+					oops_data_sz - hsize);
+
+				oops_hdr->report_length = (u16) oops_data_sz;
+			} else
+				memcpy(oops_data, big_oops_buf, size);
+		} else
+			err_type = ERR_TYPE_KERNEL_PANIC_GZ;
+	}
+
 	rc = nvram_write_os_partition(&oops_log_partition, oops_buf,
-		(int) (sizeof(*oops_hdr) + size), ERR_TYPE_KERNEL_PANIC,
+		(int) (sizeof(*oops_hdr) + oops_hdr->report_length), err_type,
 		count);
 
 	if (rc != 0)
@@ -602,10 +684,11 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
 	struct oops_log_info *oops_hdr;
 	unsigned int err_type, id_no, size = 0;
 	struct nvram_os_partition *part = NULL;
-	char *buff = NULL;
-	int sig = 0;
+	char *buff = NULL, *big_buff = NULL;
+	int rc, sig = 0;
 	loff_t p;
 
+read_partition:
 	read_type++;
 
 	switch (nvram_type_ids[read_type]) {
@@ -668,6 +751,25 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
 	if (nvram_type_ids[read_type] == PSTORE_TYPE_DMESG) {
 		oops_hdr = (struct oops_log_info *)buff;
 		*buf = buff + sizeof(*oops_hdr);
+
+		if (err_type == ERR_TYPE_KERNEL_PANIC_GZ) {
+			big_buff = kmalloc(big_oops_buf_sz, GFP_KERNEL);
+			if (!big_buff)
+				return -ENOMEM;
+
+			rc = unzip_oops(buff, big_buff);
+
+			if (rc != 0) {
+				kfree(buff);
+				kfree(big_buff);
+				goto read_partition;
+			}
+
+			oops_hdr = (struct oops_log_info *)big_buff;
+			*buf = big_buff + sizeof(*oops_hdr);
+			kfree(buff);
+		}
+
 		time->tv_sec = oops_hdr->timestamp;
 		time->tv_nsec = 0;
 		return oops_hdr->report_length;
@@ -689,17 +791,18 @@ static int nvram_pstore_init(void)
 {
 	int rc = 0;
 
-	nvram_pstore_info.buf = oops_data;
-	nvram_pstore_info.bufsize = oops_data_sz;
+	if (big_oops_buf) {
+		nvram_pstore_info.buf = big_oops_buf;
+		nvram_pstore_info.bufsize = big_oops_buf_sz;
+	} else {
+		nvram_pstore_info.buf = oops_data;
+		nvram_pstore_info.bufsize = oops_data_sz;
+	}
 
 	rc = pstore_register(&nvram_pstore_info);
 	if (rc != 0)
 		pr_err("nvram: pstore_register() failed, defaults to "
 				"kmsg_dump; returned %d\n", rc);
-	else
-		/*TODO: Support compression when pstore is configured */
-		pr_info("nvram: Compression of oops text supported only when "
-				"pstore is not configured");
 
 	return rc;
 }
@@ -733,11 +836,6 @@ static void __init nvram_init_oops_partition(int rtas_partition_exists)
 	oops_data = oops_buf + sizeof(struct oops_log_info);
 	oops_data_sz = oops_log_partition.size - sizeof(struct oops_log_info);
 
-	rc = nvram_pstore_init();
-
-	if (!rc)
-		return;
-
 	/*
 	 * Figure compression (preceded by elimination of each line's <n>
 	 * severity prefix) will reduce the oops/panic report to at most
@@ -761,6 +859,11 @@ static void __init nvram_init_oops_partition(int rtas_partition_exists)
 		stream.workspace = NULL;
 	}
 
+	rc = nvram_pstore_init();
+
+	if (!rc)
+		return;
+
 	rc = kmsg_dump_register(&nvram_kmsg_dumper);
 	if (rc != 0) {
 		pr_err("nvram: kmsg_dump_register() failed; returned %d\n", rc);
