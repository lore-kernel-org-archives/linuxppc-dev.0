Return-Path: <claudiu.manoil@nxp.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0043.outbound.protection.outlook.com [104.47.34.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJn4l4l54zDvdX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:41:11 +1100 (AEDT)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <oss@buserror.net>, <roy.pledge@nxp.com>
Subject: [PATCH 16/17] soc/qman: Clean up CGR CSCN target update operations
Date: Wed, 16 Nov 2016 16:40:29 +0200
Message-ID: <1479307230-16650-17-git-send-email-claudiu.manoil@nxp.com>
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

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c | 37 +++++++++++++++++++++++--------------
 include/soc/fsl/qman.h       |  4 ++--
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index ac020fd..d287ef0 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -2248,7 +2248,23 @@ static int qm_modify_cgr(struct qman_cgr *cgr, u32 flags,
 }
 
 #define PORTAL_IDX(n)	(n->config->channel - QM_CHANNEL_SWPORTAL0)
-#define TARG_MASK(n)	(BIT(31) >> PORTAL_IDX(n))
+
+/* congestion state change notification target update control */
+static void qm_cgr_cscn_targ_set(struct __qm_mc_cgr *cgr, int pi, u32 val)
+{
+	if (qman_ip_rev >= QMAN_REV30)
+		cgr->cscn_targ_upd_ctrl = QM_CGR_TARG_UDP_CTRL_WRITE_BIT | pi;
+	else
+		cgr->cscn_targ = val | QM_CGR_TARG_PORTAL(pi);
+}
+
+static void qm_cgr_cscn_targ_clear(struct __qm_mc_cgr *cgr, int pi, u32 val)
+{
+	if (qman_ip_rev >= QMAN_REV30)
+		cgr->cscn_targ_upd_ctrl = pi;
+	else
+		cgr->cscn_targ = val & ~QM_CGR_TARG_PORTAL(pi);
+}
 
 static u8 qman_cgr_cpus[CGR_NUM];
 
@@ -2298,13 +2314,8 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 		if (ret)
 			goto out;
 
-		if ((qman_ip_rev & 0xFF00) >= QMAN_REV30)
-			local_opts.cgr.cscn_targ_upd_ctrl =
-				QM_CGR_TARG_UDP_CTRL_WRITE_BIT | PORTAL_IDX(p);
-		else
-			/* Overwrite TARG */
-			local_opts.cgr.cscn_targ = cgr_state.cgr.cscn_targ |
-						   TARG_MASK(p);
+		qm_cgr_cscn_targ_set(&local_opts.cgr, PORTAL_IDX(p),
+				     cgr_state.cgr.cscn_targ);
 		local_opts.we_mask |= QM_CGR_WE_CSCN_TARG;
 
 		/* send init if flags indicate so */
@@ -2371,13 +2382,11 @@ int qman_delete_cgr(struct qman_cgr *cgr)
 		list_add(&cgr->node, &p->cgr_cbs);
 		goto release_lock;
 	}
-	/* Overwrite TARG */
+
 	local_opts.we_mask = QM_CGR_WE_CSCN_TARG;
-	if ((qman_ip_rev & 0xFF00) >= QMAN_REV30)
-		local_opts.cgr.cscn_targ_upd_ctrl = PORTAL_IDX(p);
-	else
-		local_opts.cgr.cscn_targ = cgr_state.cgr.cscn_targ &
-							 ~(TARG_MASK(p));
+	qm_cgr_cscn_targ_clear(&local_opts.cgr, PORTAL_IDX(p),
+			       cgr_state.cgr.cscn_targ);
+
 	ret = qm_modify_cgr(cgr, 0, &local_opts);
 	if (ret)
 		/* add back to the list */
diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
index c80ecca..d01d5a3 100644
--- a/include/soc/fsl/qman.h
+++ b/include/soc/fsl/qman.h
@@ -553,8 +553,8 @@ struct __qm_mc_cgr {
 	u8 cscn_en;	/* boolean, use QM_CGR_EN */
 	union {
 		struct {
-			u16 cscn_targ_upd_ctrl; /* use QM_CSCN_TARG_UDP_ */
-			u16 cscn_targ_dcp_low;	/* CSCN_TARG_DCP low-16bits */
+			u16 cscn_targ_upd_ctrl; /* use QM_CGR_TARG_UDP_* */
+			u16 cscn_targ_dcp_low;
 		};
 		u32 cscn_targ;	/* use QM_CGR_TARG_* */
 	};
-- 
1.7.11.7
