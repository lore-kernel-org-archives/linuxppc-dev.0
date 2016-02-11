Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ABB6D1A03D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 12:32:47 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 10 Feb 2016 20:32:45 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D144DC9003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 20:32:40 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1B1WgWH34930886
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 01:32:42 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1B1TPhN003811
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 20:29:26 -0500
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: james.bottomley@hansenpartnership.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, brking@linux.vnet.ibm.com,
 jthumshirn@suse.de, manoj@linux.vnet.ibm.com,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH v2 7/7] ibmvscsi: use H_CLOSED instead of magic number
Date: Wed, 10 Feb 2016 19:32:28 -0600
Message-Id: <1455154348-3226-8-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1455154348-3226-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1455154348-3226-1-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In a couple places the magic value of 2 is used to check the return
code of hypercalls. This translates to H_CLOSED.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 6025481..d9534ee 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -314,7 +314,7 @@ static int ibmvscsi_reset_crq_queue(struct crq_queue *queue,
 	rc = plpar_hcall_norets(H_REG_CRQ,
 				vdev->unit_address,
 				queue->msg_token, PAGE_SIZE);
-	if (rc == 2) {
+	if (rc == H_CLOSED) {
 		/* Adapter is good, but other end is not ready */
 		dev_warn(hostdata->dev, "Partner adapter not ready\n");
 	} else if (rc != 0) {
@@ -364,7 +364,7 @@ static int ibmvscsi_init_crq_queue(struct crq_queue *queue,
 		rc = ibmvscsi_reset_crq_queue(queue,
 					      hostdata);
 
-	if (rc == 2) {
+	if (rc == H_CLOSED) {
 		/* Adapter is good, but other end is not ready */
 		dev_warn(hostdata->dev, "Partner adapter not ready\n");
 		retrc = 0;
-- 
2.5.0
