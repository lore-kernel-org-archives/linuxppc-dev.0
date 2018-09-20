Return-Path: <madalin.bucur@nxp.com>
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GL0c5wh4zF3Ny
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 01:16:16 +1000 (AEST)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: leoyang.li@nxp.com
Cc: roy.pledge@nxp.com, claudiu.manoil@nxp.com, catalin.marinas@arm.com,
 oss@buserror.net, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 3/4] soc/fsl/qbman: Use last response to determine valid bit
Date: Thu, 20 Sep 2018 18:06:50 +0300
Message-Id: <1537456011-10769-4-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
References: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Roy Pledge <roy.pledge@nxp.com>

Use the last valid response when determining what valid bit
to use next for management commands. This is needed in the
case that the portal was previously used by other software
like a bootloader or if the kernel is restarted without a
hardware reset.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 7dbcb475a59c..7f4c57999e08 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -850,12 +850,24 @@ static inline void qm_mr_set_ithresh(struct qm_portal *portal, u8 ithresh)
 
 static inline int qm_mc_init(struct qm_portal *portal)
 {
+	u8 rr0, rr1;
 	struct qm_mc *mc = &portal->mc;
 
 	mc->cr = portal->addr.ce + QM_CL_CR;
 	mc->rr = portal->addr.ce + QM_CL_RR0;
-	mc->rridx = (mc->cr->_ncw_verb & QM_MCC_VERB_VBIT)
-		    ? 0 : 1;
+	/*
+	 * The expected valid bit polarity for the next CR command is 0
+	 * if RR1 contains a valid response, and is 1 if RR0 contains a
+	 * valid response. If both RR contain all 0, this indicates either
+	 * that no command has been executed since reset (in which case the
+	 * expected valid bit polarity is 1)
+	 */
+	rr0 = mc->rr->verb;
+	rr1 = (mc->rr+1)->verb;
+	if ((rr0 == 0 && rr1 == 0) || rr0 != 0)
+		mc->rridx = 1;
+	else
+		mc->rridx = 0;
 	mc->vbit = mc->rridx ? QM_MCC_VERB_VBIT : 0;
 #ifdef CONFIG_FSL_DPAA_CHECKING
 	mc->state = qman_mc_idle;
-- 
2.1.0
