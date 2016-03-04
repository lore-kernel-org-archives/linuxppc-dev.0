Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D33061A0D72
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Mar 2016 08:58:43 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 16:58:41 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 24A726E8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 16:45:31 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u24LweUY33882210
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 21:58:40 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u24LsKFY031537
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 16:54:22 -0500
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 7/7] cxlflash: Increase cmd_per_lun for better throughput
Date: Fri,  4 Mar 2016 15:55:20 -0600
Message-Id: <1457128520-53056-7-git-send-email-ukrishn@linux.vnet.ibm.com>
In-Reply-To: <1457128520-53056-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1457128424-53017-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1457128520-53056-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>

With the current value of cmd_per_lun at 16, the throughput
over a single adapter is limited to around 150kIOPS.

Increase the value of cmd_per_lun to 256 to improve
throughput. With this change a single adapter is able to
attain close to the maximum throughput (380kIOPS).
Also change the number of RRQ entries that can be queued.

Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/common.h | 8 +++++---
 drivers/scsi/cxlflash/main.c   | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/cxlflash/common.h b/drivers/scsi/cxlflash/common.h
index 5ada926..a8ac4c0 100644
--- a/drivers/scsi/cxlflash/common.h
+++ b/drivers/scsi/cxlflash/common.h
@@ -34,7 +34,6 @@ extern const struct file_operations cxlflash_cxl_fops;
 								   sectors
 								*/
 
-#define NUM_RRQ_ENTRY    16     /* for master issued cmds */
 #define MAX_RHT_PER_CONTEXT (PAGE_SIZE / sizeof(struct sisl_rht_entry))
 
 /* AFU command retry limit */
@@ -48,9 +47,12 @@ extern const struct file_operations cxlflash_cxl_fops;
 							   index derivation
 							 */
 
-#define CXLFLASH_MAX_CMDS               16
+#define CXLFLASH_MAX_CMDS               256
 #define CXLFLASH_MAX_CMDS_PER_LUN       CXLFLASH_MAX_CMDS
 
+/* RRQ for master issued cmds */
+#define NUM_RRQ_ENTRY                   CXLFLASH_MAX_CMDS
+
 
 static inline void check_sizes(void)
 {
@@ -149,7 +151,7 @@ struct afu_cmd {
 struct afu {
 	/* Stuff requiring alignment go first. */
 
-	u64 rrq_entry[NUM_RRQ_ENTRY];	/* 128B RRQ */
+	u64 rrq_entry[NUM_RRQ_ENTRY];	/* 2K RRQ */
 	/*
 	 * Command & data for AFU commands.
 	 */
diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 0f062a4..3879b46 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -2253,7 +2253,7 @@ static struct scsi_host_template driver_template = {
 	.eh_device_reset_handler = cxlflash_eh_device_reset_handler,
 	.eh_host_reset_handler = cxlflash_eh_host_reset_handler,
 	.change_queue_depth = cxlflash_change_queue_depth,
-	.cmd_per_lun = 16,
+	.cmd_per_lun = CXLFLASH_MAX_CMDS_PER_LUN,
 	.can_queue = CXLFLASH_MAX_CMDS,
 	.this_id = -1,
 	.sg_tablesize = SG_NONE,	/* No scatter gather support */
-- 
2.1.0
