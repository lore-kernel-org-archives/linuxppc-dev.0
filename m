Return-Path: <claudiu.manoil@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0043.outbound.protection.outlook.com [104.47.36.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJn4Q36sGzDvYD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:40:54 +1100 (AEDT)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <oss@buserror.net>, <roy.pledge@nxp.com>
Subject: [PATCH 10/17] soc/qman: Remove redundant checks from qman_create_cgr()
Date: Wed, 16 Nov 2016 16:40:23 +0200
Message-ID: <1479307230-16650-11-git-send-email-claudiu.manoil@nxp.com>
In-Reply-To: <1479307230-16650-1-git-send-email-claudiu.manoil@nxp.com>
References: <1479307230-16650-1-git-send-email-claudiu.manoil@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

opts is checked redundantly.
Move local_opts declaration inside its usage scope.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 283c2d3..6715485 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -2294,7 +2294,6 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 		    struct qm_mcc_initcgr *opts)
 {
 	struct qm_mcr_querycgr cgr_state;
-	struct qm_mcc_initcgr local_opts = {};
 	int ret;
 	struct qman_portal *p;
 
@@ -2316,11 +2315,12 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 	spin_lock(&p->cgr_lock);
 
 	if (opts) {
+		struct qm_mcc_initcgr local_opts = *opts;
+
 		ret = qman_query_cgr(cgr, &cgr_state);
 		if (ret)
 			goto out;
-		if (opts)
-			local_opts = *opts;
+
 		if ((qman_ip_rev & 0xFF00) >= QMAN_REV30)
 			local_opts.cgr.cscn_targ_upd_ctrl =
 				QM_CGR_TARG_UDP_CTRL_WRITE_BIT | PORTAL_IDX(p);
@@ -2331,7 +2331,7 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 		local_opts.we_mask |= QM_CGR_WE_CSCN_TARG;
 
 		/* send init if flags indicate so */
-		if (opts && (flags & QMAN_CGR_FLAG_USE_INIT))
+		if (flags & QMAN_CGR_FLAG_USE_INIT)
 			ret = qm_modify_cgr(cgr, QMAN_CGR_FLAG_USE_INIT,
 					    &local_opts);
 		else
-- 
1.7.11.7
