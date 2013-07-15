Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AF4EA2C0242
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jul 2013 02:55:31 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Mon, 15 Jul 2013 22:17:17 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6FF30E005B
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 22:25:18 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6FGtMVK33423450
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 22:25:22 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6FGtOPA013793
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jul 2013 02:55:25 +1000
Subject: [PATCH 01/11] powerpc/pseries: Remove (de)compression in nvram with
 pstore enabled
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Mon, 15 Jul 2013 22:25:20 +0530
Message-ID: <20130715165520.1520.72367.stgit@aruna-ThinkPad-T420>
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

(De)compression support is provided in pstore in subsequent patches which
needs an additional argument 'compressed' to determine if the data
is compressed or not. This patch will take care of removing (de)compression
in nvram with pstore which was making use of 'hsize' argument in pstore write
as 'hsize' will be removed in the subsequent patch.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/nvram.c |   40 --------------------------------
 1 file changed, 40 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 9f8671a..07c3c07 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -640,27 +640,6 @@ static int nvram_pstore_write(enum pstore_type_id type,
 	oops_hdr->report_length = (u16) size;
 	oops_hdr->timestamp = get_seconds();
 
-	if (big_oops_buf) {
-		rc = zip_oops(size);
-		/*
-		 * If compression fails copy recent log messages from
-		 * big_oops_buf to oops_data.
-		 */
-		if (rc != 0) {
-			size_t diff = size - oops_data_sz + hsize;
-
-			if (size > oops_data_sz) {
-				memcpy(oops_data, big_oops_buf, hsize);
-				memcpy(oops_data + hsize, big_oops_buf + diff,
-					oops_data_sz - hsize);
-
-				oops_hdr->report_length = (u16) oops_data_sz;
-			} else
-				memcpy(oops_data, big_oops_buf, size);
-		} else
-			err_type = ERR_TYPE_KERNEL_PANIC_GZ;
-	}
-
 	rc = nvram_write_os_partition(&oops_log_partition, oops_buf,
 		(int) (sizeof(*oops_hdr) + oops_hdr->report_length), err_type,
 		count);
@@ -751,25 +730,6 @@ read_partition:
 	if (nvram_type_ids[read_type] == PSTORE_TYPE_DMESG) {
 		oops_hdr = (struct oops_log_info *)buff;
 		*buf = buff + sizeof(*oops_hdr);
-
-		if (err_type == ERR_TYPE_KERNEL_PANIC_GZ) {
-			big_buff = kmalloc(big_oops_buf_sz, GFP_KERNEL);
-			if (!big_buff)
-				return -ENOMEM;
-
-			rc = unzip_oops(buff, big_buff);
-
-			if (rc != 0) {
-				kfree(buff);
-				kfree(big_buff);
-				goto read_partition;
-			}
-
-			oops_hdr = (struct oops_log_info *)big_buff;
-			*buf = big_buff + sizeof(*oops_hdr);
-			kfree(buff);
-		}
-
 		time->tv_sec = oops_hdr->timestamp;
 		time->tv_nsec = 0;
 		return oops_hdr->report_length;
