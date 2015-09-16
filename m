Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7F5E1A31B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 03:02:30 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 16 Sep 2015 13:02:28 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A899A38C8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 13:02:25 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8GH2Pc957868540
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 17:02:25 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8GH2OIf014091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 13:02:25 -0400
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James.Bottomley@HansenPartnership.com,
 nab@linux-iscsi.org, brking@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 dja@ozlabs.au.ibm.com, andrew.donnellan@au1.ibm.com
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: [PATCH v2 26/30] cxlflash: Fix to prevent EEH recovery failure
Date: Wed, 16 Sep 2015 12:02:00 -0500
Message-Id: <1442422920-42077-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The process_sense() routine can perform a read capacity which
can take some time to complete. If an EEH occurs while waiting
on the read capacity, the EEH handler is unable to obtain the
context's mutex in order to put the context in an error state.
The EEH handler will sit and wait until the context is free,
but this wait can last longer than the EEH handler tolerates,
leading to a failed recovery.

To address this issue, make the context unavailable to new,
non-system owned threads and release the context while calling
into process_sense(). After returning from process_sense() the
context mutex is reacquired and the context is made available
again. The context can be safely moved to the error state if
needed during the unavailable window as no other threads will
hold its reference.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/superpipe.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
index fb79b79fe..1c5e9ac 100644
--- a/drivers/scsi/cxlflash/superpipe.c
+++ b/drivers/scsi/cxlflash/superpipe.c
@@ -1790,12 +1790,21 @@ static int cxlflash_disk_verify(struct scsi_device *sdev,
 	 * inquiry (i.e. the Unit attention is due to the WWN changing).
 	 */
 	if (verify->hint & DK_CXLFLASH_VERIFY_HINT_SENSE) {
+		/* Can't hold mutex across process_sense/read_cap16,
+		 * since we could have an intervening EEH event.
+		 */
+		ctxi->unavail = true;
+		mutex_unlock(&ctxi->mutex);
 		rc = process_sense(sdev, verify);
 		if (unlikely(rc)) {
 			dev_err(dev, "%s: Failed to validate sense data (%d)\n",
 				__func__, rc);
+			mutex_lock(&ctxi->mutex);
+			ctxi->unavail = false;
 			goto out;
 		}
+		mutex_lock(&ctxi->mutex);
+		ctxi->unavail = false;
 	}
 
 	switch (gli->mode) {
-- 
2.1.0
