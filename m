Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 944541A301F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 02:59:38 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 16 Sep 2015 12:59:36 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id EE6C2C9003C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 12:50:36 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8GGxPsG60227594
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 16:59:33 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8GGx0ri010287
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 12:59:00 -0400
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James.Bottomley@HansenPartnership.com,
 nab@linux-iscsi.org, brking@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 dja@ozlabs.au.ibm.com, andrew.donnellan@au1.ibm.com
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: [PATCH v2 18/30] cxlflash: Remove dual port online dependency
Date: Wed, 16 Sep 2015 11:58:13 -0500
Message-Id: <1442422693-41690-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At present, both ports must be online for the device to
configure properly. Remove this dependency and the unnecessary
internal LUN override logic as well. Additionally, as a refactoring
measure, change the return code variable name to match that used
throughout the driver.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 74eb742..e2cc410 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -1031,7 +1031,7 @@ static int wait_port_offline(u64 *fc_regs, u32 delay_us, u32 nretry)
  */
 static int afu_set_wwpn(struct afu *afu, int port, u64 *fc_regs, u64 wwpn)
 {
-	int ret = 0;
+	int rc = 0;
 
 	set_port_offline(fc_regs);
 
@@ -1039,33 +1039,26 @@ static int afu_set_wwpn(struct afu *afu, int port, u64 *fc_regs, u64 wwpn)
 			       FC_PORT_STATUS_RETRY_CNT)) {
 		pr_debug("%s: wait on port %d to go offline timed out\n",
 			 __func__, port);
-		ret = -1; /* but continue on to leave the port back online */
+		rc = -1; /* but continue on to leave the port back online */
 	}
 
-	if (ret == 0)
+	if (rc == 0)
 		writeq_be(wwpn, &fc_regs[FC_PNAME / 8]);
 
+	/* Always return success after programming WWPN */
+	rc = 0;
+
 	set_port_online(fc_regs);
 
 	if (!wait_port_online(fc_regs, FC_PORT_STATUS_RETRY_INTERVAL_US,
 			      FC_PORT_STATUS_RETRY_CNT)) {
 		pr_debug("%s: wait on port %d to go online timed out\n",
 			 __func__, port);
-		ret = -1;
-
-		/*
-		 * Override for internal lun!!!
-		 */
-		if (afu->internal_lun) {
-			pr_debug("%s: Overriding port %d online timeout!!!\n",
-				 __func__, port);
-			ret = 0;
-		}
 	}
 
-	pr_debug("%s: returning rc=%d\n", __func__, ret);
+	pr_debug("%s: returning rc=%d\n", __func__, rc);
 
-	return ret;
+	return rc;
 }
 
 /**
-- 
2.1.0
