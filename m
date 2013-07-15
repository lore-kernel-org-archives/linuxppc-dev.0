Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E8682C0489
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jul 2013 02:56:48 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Mon, 15 Jul 2013 22:21:13 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 607573940057
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 22:26:39 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6FGvN5B31129854
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 22:27:23 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6FGufWk019462
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jul 2013 02:56:42 +1000
Subject: [PATCH 08/11] powerpc/pseries: Read and write to the 'compressed'
 flag of pstore
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Mon, 15 Jul 2013 22:26:37 +0530
Message-ID: <20130715165637.1520.4138.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130715164844.1520.27771.stgit@aruna-ThinkPad-T420>
References: <20130715164844.1520.27771.stgit@aruna-ThinkPad-T420>
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

If data returned from pstore is compressed, nvram's write callback
will add a flag ERR_TYPE_KERNEL_PANIC_GZ indicating the data is compressed
while writing to nvram. If the data read from nvram is compressed, nvram's
read callback will set the flag 'compressed'. The patch adds backward
compatibilty with old format oops header when reading from pstore.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/nvram.c |   34 +++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 78c6f45..6f383eb 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -581,6 +581,9 @@ static int nvram_pstore_write(enum pstore_type_id type,
 	oops_hdr->report_length = (u16) size;
 	oops_hdr->timestamp = get_seconds();
 
+	if (compressed)
+		err_type = ERR_TYPE_KERNEL_PANIC_GZ;
+
 	rc = nvram_write_os_partition(&oops_log_partition, oops_buf,
 		(int) (sizeof(*oops_hdr) + oops_hdr->report_length), err_type,
 		count);
@@ -604,11 +607,10 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
 	struct oops_log_info *oops_hdr;
 	unsigned int err_type, id_no, size = 0;
 	struct nvram_os_partition *part = NULL;
-	char *buff = NULL, *big_buff = NULL;
-	int rc, sig = 0;
+	char *buff = NULL;
+	int  sig = 0;
 	loff_t p;
 
-read_partition:
 	read_type++;
 
 	switch (nvram_type_ids[read_type]) {
@@ -669,14 +671,32 @@ read_partition:
 		*id = id_no;
 
 	if (nvram_type_ids[read_type] == PSTORE_TYPE_DMESG) {
+		u16 length;
 		oops_hdr = (struct oops_log_info *)buff;
-		*buf = buff + sizeof(*oops_hdr);
-		time->tv_sec = oops_hdr->timestamp;
-		time->tv_nsec = 0;
-		return oops_hdr->report_length;
+
+		/* Provide backward compatibility with old format headers */
+		if (oops_hdr->version < OOPS_HDR_VERSION) {
+			*buf = buff + sizeof(u16);
+			length = oops_hdr->version;
+			time->tv_sec = 0;
+			time->tv_nsec = 0;
+		} else {
+			*buf = buff + sizeof(*oops_hdr);
+			length = oops_hdr->report_length;
+			time->tv_sec = oops_hdr->timestamp;
+			time->tv_nsec = 0;
+		}
+
+		if (err_type == ERR_TYPE_KERNEL_PANIC_GZ)
+			*compressed = true;
+		else
+			*compressed = false;
+
+		return length;
 	}
 
 	*buf = buff;
+	*compressed = false;
 	return part->size;
 }
 
