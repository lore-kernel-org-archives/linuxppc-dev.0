Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D72021A2CFD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 02:53:29 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 16 Sep 2015 10:53:27 -0600
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9ABF86E8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 12:45:08 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8GGrO5163897730
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 16:53:24 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8GGrO5e029847
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 12:53:24 -0400
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James.Bottomley@HansenPartnership.com,
 nab@linux-iscsi.org, brking@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 dja@ozlabs.au.ibm.com, andrew.donnellan@au1.ibm.com
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: [PATCH v2 05/30] cxlflash: Fix data corruption when vLUN used over
 multiple cards
Date: Wed, 16 Sep 2015 11:53:00 -0500
Message-Id: <1442422380-41110-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the same virtual LUN is accessed over multiple cards, only accesses
made over the first card will be valid. Accesses made over the second
card will go to the wrong LUN causing data corruption.

This is because the global LUN's mode word was being used to determine
whether the LUN table for that card needs to be programmed. The mode
word would be setup by the first card, causing the LUN table for the
second card to not be programmed.

By unconditionally initializing the LUN table (not depending on the
mode word), the problem is avoided.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/vlun.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/cxlflash/vlun.c b/drivers/scsi/cxlflash/vlun.c
index 68994c4..96b074f 100644
--- a/drivers/scsi/cxlflash/vlun.c
+++ b/drivers/scsi/cxlflash/vlun.c
@@ -915,16 +915,9 @@ int cxlflash_disk_virtual_open(struct scsi_device *sdev, void *arg)
 
 	pr_debug("%s: ctxid=%llu ls=0x%llx\n", __func__, ctxid, lun_size);
 
+	/* Setup the LUNs block allocator on first call */
 	mutex_lock(&gli->mutex);
 	if (gli->mode == MODE_NONE) {
-		/* Setup the LUN table and block allocator on first call */
-		rc = init_luntable(cfg, lli);
-		if (rc) {
-			dev_err(dev, "%s: call to init_luntable failed "
-				"rc=%d!\n", __func__, rc);
-			goto err0;
-		}
-
 		rc = init_vlun(lli);
 		if (rc) {
 			dev_err(dev, "%s: call to init_vlun failed rc=%d!\n",
@@ -942,6 +935,13 @@ int cxlflash_disk_virtual_open(struct scsi_device *sdev, void *arg)
 	}
 	mutex_unlock(&gli->mutex);
 
+	rc = init_luntable(cfg, lli);
+	if (rc) {
+		dev_err(dev, "%s: call to init_luntable failed rc=%d!\n",
+			__func__, rc);
+		goto err1;
+	}
+
 	ctxi = get_context(cfg, rctxid, lli, 0);
 	if (unlikely(!ctxi)) {
 		dev_err(dev, "%s: Bad context! (%llu)\n", __func__, ctxid);
-- 
2.1.0
