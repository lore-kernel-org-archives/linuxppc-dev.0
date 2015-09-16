Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 65A2C1A2C7F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 07:28:15 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 16 Sep 2015 15:28:13 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id E97011FF0046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 15:19:20 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8GLR2hU64028806
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 14:27:02 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8GLSAw7001473
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 15:28:10 -0600
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: [PATCH v2 05/30] cxlflash: Fix data corruption when vLUN used over
 multiple cards
Date: Wed, 16 Sep 2015 16:27:47 -0500
Message-Id: <1442438867-49354-1-git-send-email-mrochs@linux.vnet.ibm.com>
In-Reply-To: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
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
