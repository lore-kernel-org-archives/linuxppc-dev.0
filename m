Return-Path: <xuelin.shi@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0183.outbound.protection.outlook.com [207.46.163.183])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D0C31A017C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jul 2014 18:06:50 +1000 (EST)
From: <xuelin.shi@freescale.com>
To: <dan.j.williams@intel.com>, <vinod.koul@intel.com>
Subject: [PATCH] dmaengine: fix potential race condition in fsl raid
Date: Mon, 14 Jul 2014 15:20:28 +0800
Message-ID: <1405322428-20461-1-git-send-email-xuelin.shi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: dmaengine@vger.kernel.org, Xuelin Shi <xuelin.shi@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Xuelin Shi <b29237@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Xuelin Shi <xuelin.shi@freescale.com>

checking available slots in HW should be under the lock.

Signed-off-by: Xuelin Shi <b29237@freescale.com>
---
 drivers/dma/fsl_raid.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
index 935d05a..fccad86 100644
--- a/drivers/dma/fsl_raid.c
+++ b/drivers/dma/fsl_raid.c
@@ -112,11 +112,11 @@ static void re_jr_issue_pending(struct dma_chan *chan)
 
 	jr = container_of(chan, struct re_jr, chan);
 
+	spin_lock_irqsave(&jr->desc_lock, flags);
 	avail = RE_JR_INB_SLOT_AVAIL(in_be32(&jr->jrregs->inbring_slot_avail));
 	if (!avail)
-		return;
+		goto out;
 
-	spin_lock_irqsave(&jr->desc_lock, flags);
 	list_for_each_entry_safe(desc, _desc, &jr->submit_q, node) {
 		if (!avail)
 			break;
@@ -132,6 +132,7 @@ static void re_jr_issue_pending(struct dma_chan *chan)
 		out_be32(&jr->jrregs->inbring_add_job, RE_JR_INB_JOB_ADD(1));
 		avail--;
 	}
+out:
 	spin_unlock_irqrestore(&jr->desc_lock, flags);
 }
 
-- 
1.9.1
