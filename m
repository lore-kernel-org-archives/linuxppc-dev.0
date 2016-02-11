Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C3071A0018
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 09:24:43 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 11 Feb 2016 15:24:41 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id E59A43E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 15:11:15 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1BMOcrL25952366
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 15:24:38 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1BMOclJ024382
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 15:24:38 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: james.bottomley@hansenpartnership.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, brking@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH] ibmvfc: byteswap scsi_id, wwpn, and node_name prior to logging
Date: Thu, 11 Feb 2016 16:24:35 -0600
Message-Id: <1455229475-3984-1-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When logging async events the scsi_id, wwpn, and node_name values
are used directly from the CRQ struct which are of type __be64. This
can be confusing to someone looking through the log on a LE system.
Instead byteswap these values to host endian prior to logging.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 6aa317c..fc523c3 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -2636,7 +2636,8 @@ static void ibmvfc_handle_async(struct ibmvfc_async_crq *crq,
 	struct ibmvfc_target *tgt;
 
 	ibmvfc_log(vhost, desc->log_level, "%s event received. scsi_id: %llx, wwpn: %llx,"
-		   " node_name: %llx%s\n", desc->desc, crq->scsi_id, crq->wwpn, crq->node_name,
+		   " node_name: %llx%s\n", desc->desc, be64_to_cpu(crq->scsi_id),
+		   be64_to_cpu(crq->wwpn), be64_to_cpu(crq->node_name),
 		   ibmvfc_get_link_state(crq->link_state));
 
 	switch (be64_to_cpu(crq->event)) {
-- 
2.5.0
