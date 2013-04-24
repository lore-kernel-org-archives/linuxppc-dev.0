Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B2B62C0244
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 16:20:24 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 11:44:45 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 86E20E004A
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 11:52:22 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3O6KEsq58720372
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 11:50:14 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3O6KFIA013945
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Apr 2013 16:20:18 +1000
Subject: [PATCH v2 3/8] powerpc/pseries: Introduce generic read function to
 read nvram-partitions
To: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 11:50:14 +0530
Message-ID: <20130424062014.7341.66401.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20130424061807.7341.909.stgit@aruna-ThinkPad-T420>
References: <20130424061807.7341.909.stgit@aruna-ThinkPad-T420>
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

Introduce generic read function to read nvram partitions other than rtas.
nvram_read_error_log will be retained which is used to read rtas partition
from rtasd. nvram_read_partition is the generic read function to read from
any nvram partition.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Reviewed-by: Jim Keniston <jkenisto@us.ibm.com>
---
 arch/powerpc/platforms/pseries/nvram.c |   32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 742735a..088f023 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -293,34 +293,35 @@ int nvram_write_error_log(char * buff, int length,
 	return rc;
 }
 
-/* nvram_read_error_log
+/* nvram_read_partition
  *
- * Reads nvram for error log for at most 'length'
+ * Reads nvram partition for at most 'length'
  */
-int nvram_read_error_log(char * buff, int length,
-                         unsigned int * err_type, unsigned int * error_log_cnt)
+int nvram_read_partition(struct nvram_os_partition *part, char *buff,
+			int length, unsigned int *err_type,
+			unsigned int *error_log_cnt)
 {
 	int rc;
 	loff_t tmp_index;
 	struct err_log_info info;
 	
-	if (rtas_log_partition.index == -1)
+	if (part->index == -1)
 		return -1;
 
-	if (length > rtas_log_partition.size)
-		length = rtas_log_partition.size;
+	if (length > part->size)
+		length = part->size;
 
-	tmp_index = rtas_log_partition.index;
+	tmp_index = part->index;
 
 	rc = ppc_md.nvram_read((char *)&info, sizeof(struct err_log_info), &tmp_index);
 	if (rc <= 0) {
-		printk(KERN_ERR "nvram_read_error_log: Failed nvram_read (%d)\n", rc);
+		pr_err("%s: Failed nvram_read (%d)\n", __FUNCTION__, rc);
 		return rc;
 	}
 
 	rc = ppc_md.nvram_read(buff, length, &tmp_index);
 	if (rc <= 0) {
-		printk(KERN_ERR "nvram_read_error_log: Failed nvram_read (%d)\n", rc);
+		pr_err("%s: Failed nvram_read (%d)\n", __FUNCTION__, rc);
 		return rc;
 	}
 
@@ -330,6 +331,17 @@ int nvram_read_error_log(char * buff, int length,
 	return 0;
 }
 
+/* nvram_read_error_log
+ *
+ * Reads nvram for error log for at most 'length'
+ */
+int nvram_read_error_log(char *buff, int length,
+			unsigned int *err_type, unsigned int *error_log_cnt)
+{
+	return nvram_read_partition(&rtas_log_partition, buff, length,
+						err_type, error_log_cnt);
+}
+
 /* This doesn't actually zero anything, but it sets the event_logged
  * word to tell that this event is safely in syslog.
  */
