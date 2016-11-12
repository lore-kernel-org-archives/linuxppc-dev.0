Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tGNNk1b0YzDvf8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Nov 2016 04:01:41 +1100 (AEDT)
From: Colin King <colin.king@canonical.com>
To: Scott Wood <oss@buserror.net>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Roy Pledge <roy.pledge@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] soc/fsl: fix spelling mistakes in critical error messages
Date: Sat, 12 Nov 2016 17:01:30 +0000
Message-Id: <20161112170130.6146-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake "uncommited" to "uncommitted" in
critical error messages.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/soc/fsl/qbman/bman.c | 2 +-
 drivers/soc/fsl/qbman/qman.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
index ffa48fd..48b7eb6 100644
--- a/drivers/soc/fsl/qbman/bman.c
+++ b/drivers/soc/fsl/qbman/bman.c
@@ -391,7 +391,7 @@ static void bm_rcr_finish(struct bm_portal *portal)
 
 	i = bm_in(portal, BM_REG_RCR_PI_CINH) & (BM_RCR_SIZE - 1);
 	if (i != rcr_ptr2idx(rcr->cursor))
-		pr_crit("losing uncommited RCR entries\n");
+		pr_crit("losing uncommitted RCR entries\n");
 
 	i = bm_in(portal, BM_REG_RCR_CI_CINH) & (BM_RCR_SIZE - 1);
 	if (i != rcr->ci)
diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 119054b..deeacd5 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -443,7 +443,7 @@ static inline void qm_eqcr_finish(struct qm_portal *portal)
 
 	DPAA_ASSERT(!eqcr->busy);
 	if (pi != eqcr_ptr2idx(eqcr->cursor))
-		pr_crit("losing uncommited EQCR entries\n");
+		pr_crit("losing uncommitted EQCR entries\n");
 	if (ci != eqcr->ci)
 		pr_crit("missing existing EQCR completions\n");
 	if (eqcr->ci != eqcr_ptr2idx(eqcr->cursor))
-- 
2.10.2
