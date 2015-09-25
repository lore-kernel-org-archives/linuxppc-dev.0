Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B7731A1DA2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2015 09:17:19 +1000 (AEST)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Fri, 25 Sep 2015 17:17:17 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 546A73E40041
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 17:17:15 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8PNHFgW66584798
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 16:17:15 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8PNHEEP022197
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 17:17:15 -0600
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: [PATCH v4 14/32] cxlflash: Fix location of setting resid
Date: Fri, 25 Sep 2015 18:16:37 -0500
Message-Id: <1443222997-9462-1-git-send-email-mrochs@linux.vnet.ibm.com>
In-Reply-To: <1443222593-8828-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1443222593-8828-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The resid is incorrectly set which can lead to unnecessary retry
attempts by the stack. This is due to resid _always_ being set
using a value returned from the adapter. Instead, the value
should only be interpreted and set when in an underrun scenario.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 110037d..5503a40 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -107,6 +107,7 @@ static void process_cmd_err(struct afu_cmd *cmd, struct scsi_cmnd *scp)
 {
 	struct sisl_ioarcb *ioarcb;
 	struct sisl_ioasa *ioasa;
+	u32 resid;
 
 	if (unlikely(!cmd))
 		return;
@@ -115,9 +116,10 @@ static void process_cmd_err(struct afu_cmd *cmd, struct scsi_cmnd *scp)
 	ioasa = &(cmd->sa);
 
 	if (ioasa->rc.flags & SISL_RC_FLAGS_UNDERRUN) {
-		pr_debug("%s: cmd underrun cmd = %p scp = %p\n",
-			 __func__, cmd, scp);
-		scp->result = (DID_ERROR << 16);
+		resid = ioasa->resid;
+		scsi_set_resid(scp, resid);
+		pr_debug("%s: cmd underrun cmd = %p scp = %p, resid = %d\n",
+			 __func__, cmd, scp, resid);
 	}
 
 	if (ioasa->rc.flags & SISL_RC_FLAGS_OVERRUN) {
@@ -158,8 +160,7 @@ static void process_cmd_err(struct afu_cmd *cmd, struct scsi_cmnd *scp)
 				/* If the SISL_RC_FLAGS_OVERRUN flag was set,
 				 * then we will handle this error else where.
 				 * If not then we must handle it here.
-				 * This is probably an AFU bug. We will
-				 * attempt a retry to see if that resolves it.
+				 * This is probably an AFU bug.
 				 */
 				scp->result = (DID_ERROR << 16);
 			}
@@ -183,7 +184,7 @@ static void process_cmd_err(struct afu_cmd *cmd, struct scsi_cmnd *scp)
 		/* We have an AFU error */
 		switch (ioasa->rc.afu_rc) {
 		case SISL_AFU_RC_NO_CHANNELS:
-			scp->result = (DID_MEDIUM_ERROR << 16);
+			scp->result = (DID_NO_CONNECT << 16);
 			break;
 		case SISL_AFU_RC_DATA_DMA_ERR:
 			switch (ioasa->afu_extra) {
@@ -217,7 +218,6 @@ static void process_cmd_err(struct afu_cmd *cmd, struct scsi_cmnd *scp)
 static void cmd_complete(struct afu_cmd *cmd)
 {
 	struct scsi_cmnd *scp;
-	u32 resid;
 	ulong lock_flags;
 	struct afu *afu = cmd->parent;
 	struct cxlflash_cfg *cfg = afu->parent;
@@ -229,14 +229,11 @@ static void cmd_complete(struct afu_cmd *cmd)
 
 	if (cmd->rcb.scp) {
 		scp = cmd->rcb.scp;
-		if (unlikely(cmd->sa.rc.afu_rc ||
-			     cmd->sa.rc.scsi_rc ||
-			     cmd->sa.rc.fc_rc))
+		if (unlikely(cmd->sa.ioasc))
 			process_cmd_err(cmd, scp);
 		else
 			scp->result = (DID_OK << 16);
 
-		resid = cmd->sa.resid;
 		cmd_is_tmf = cmd->cmd_tmf;
 		cmd_checkin(cmd); /* Don't use cmd after here */
 
@@ -244,7 +241,6 @@ static void cmd_complete(struct afu_cmd *cmd)
 				     "ioasc=%d\n", __func__, scp, scp->result,
 				     cmd->sa.ioasc);
 
-		scsi_set_resid(scp, resid);
 		scsi_dma_unmap(scp);
 		scp->scsi_done(scp);
 
-- 
2.1.0
