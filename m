Return-Path: <claudiu.manoil@nxp.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0043.outbound.protection.outlook.com [104.47.42.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJn4C5TwNzDt1c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:40:43 +1100 (AEDT)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <oss@buserror.net>, <roy.pledge@nxp.com>
Subject: [PATCH 03/17] soc/qman: Fix h/w resource cleanup error path handling
Date: Wed, 16 Nov 2016 16:40:16 +0200
Message-ID: <1479307230-16650-4-git-send-email-claudiu.manoil@nxp.com>
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

qman_query_fq*() may return other error codes apart from
-ERANGE, in which cases the error handling done by the
resource cleanup callers would be wrong.  The patch
fixes the handling of those cases, and cleans up related
code inside the resource cleanup & release handlers (i.e.
replace hardcoded fqid value with corresponding define).

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 119054b..80ff0b7 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -2789,15 +2789,18 @@ static int qpool_cleanup(u32 qp)
 		struct qm_mcr_queryfq_np np;
 
 		err = qman_query_fq_np(&fq, &np);
-		if (err)
+		if (err == -ERANGE)
 			/* FQID range exceeded, found no problems */
 			return 0;
+		else if (WARN_ON(err))
+			return err;
+
 		if ((np.state & QM_MCR_NP_STATE_MASK) != QM_MCR_NP_STATE_OOS) {
 			struct qm_fqd fqd;
 
 			err = qman_query_fq(&fq, &fqd);
 			if (WARN_ON(err))
-				return 0;
+				return err;
 			if (qm_fqd_get_chan(&fqd) == qp) {
 				/* The channel is the FQ's target, clean it */
 				err = qman_shutdown_fq(fq.fqid);
@@ -2836,7 +2839,7 @@ static int cgr_cleanup(u32 cgrid)
 	 * error, looking for non-OOS FQDs whose CGR is the CGR being released
 	 */
 	struct qman_fq fq = {
-		.fqid = 1
+		.fqid = QM_FQID_RANGE_START
 	};
 	int err;
 
@@ -2844,15 +2847,18 @@ static int cgr_cleanup(u32 cgrid)
 		struct qm_mcr_queryfq_np np;
 
 		err = qman_query_fq_np(&fq, &np);
-		if (err)
+		if (err == -ERANGE)
 			/* FQID range exceeded, found no problems */
 			return 0;
+		else if (WARN_ON(err))
+			return err;
+
 		if ((np.state & QM_MCR_NP_STATE_MASK) != QM_MCR_NP_STATE_OOS) {
 			struct qm_fqd fqd;
 
 			err = qman_query_fq(&fq, &fqd);
 			if (WARN_ON(err))
-				return 0;
+				return err;
 			if ((fqd.fq_ctrl & QM_FQCTRL_CGE) &&
 			    fqd.cgid == cgrid) {
 				pr_err("CRGID 0x%x is being used by FQID 0x%x, CGR will be leaked\n",
-- 
1.7.11.7
