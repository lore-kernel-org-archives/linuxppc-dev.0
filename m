Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BBB082C027F
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 23:18:47 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Fri, 16 Aug 2013 23:07:42 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C2AD12BB004F
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 23:18:43 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7GD2hkU721162
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 23:02:43 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7GDIg6O014982
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 23:18:43 +1000
Subject: [RFC PATCH v2 08/11] powerpc/pseries: Read and write to the
 'compressed' flag of pstore
To: linuxppc-dev@ozlabs.org, tony.luck@intel.com, linux-kernel@vger.kernel.org,
 keescook@chromium.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Fri, 16 Aug 2013 18:48:36 +0530
Message-ID: <20130816131836.3338.4640.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
References: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: jkenisto@linux.vnet.ibm.com, cbouatmailru@gmail.com,
 mahesh@linux.vnet.ibm.com, ccross@android.com
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
 arch/powerpc/platforms/pseries/nvram.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 6c4dc52a..d276cd3 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -581,6 +581,9 @@ static int nvram_pstore_write(enum pstore_type_id type,
 	oops_hdr->report_length = (u16) size;
 	oops_hdr->timestamp = get_seconds();
 
+	if (compressed)
+		err_type = ERR_TYPE_KERNEL_PANIC_GZ;
+
 	rc = nvram_write_os_partition(&oops_log_partition, oops_buf,
 		(int) (sizeof(*oops_hdr) + size), err_type, count);
 
@@ -687,6 +690,11 @@ static ssize_t nvram_pstore_read(u64 *id, enum pstore_type_id *type,
 			return -ENOMEM;
 		memcpy(*buf, buff + hdr_size, length);
 		kfree(buff);
+
+		if (err_type == ERR_TYPE_KERNEL_PANIC_GZ)
+			*compressed = true;
+		else
+			*compressed = false;
 		return length;
 	}
 
