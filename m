Return-Path: <claudiu.manoil@nxp.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0048.outbound.protection.outlook.com [104.47.34.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJn4L17JDzDvgr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:40:49 +1100 (AEDT)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <oss@buserror.net>, <roy.pledge@nxp.com>
Subject: [PATCH 07/17] soc/qman: test: Fix implementation of fd_cmp()
Date: Wed, 16 Nov 2016 16:40:20 +0200
Message-ID: <1479307230-16650-8-git-send-email-claudiu.manoil@nxp.com>
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

This function must only return the truth value of whether
two frame descriptors are different or not.
It does NOT have to compute some obscure difference between
fd fields and return it as an int, making sparse complain
about type conversions in the process.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/soc/fsl/qbman/qman_test_api.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman_test_api.c b/drivers/soc/fsl/qbman/qman_test_api.c
index 6880ff1..dba6a80 100644
--- a/drivers/soc/fsl/qbman/qman_test_api.c
+++ b/drivers/soc/fsl/qbman/qman_test_api.c
@@ -90,22 +90,15 @@ static void fd_inc(struct qm_fd *fd)
 }
 
 /* The only part of the 'fd' we can't memcmp() is the ppid */
-static int fd_cmp(const struct qm_fd *a, const struct qm_fd *b)
+static bool fd_neq(const struct qm_fd *a, const struct qm_fd *b)
 {
-	int r = (qm_fd_addr_get64(a) == qm_fd_addr_get64(b)) ? 0 : -1;
+	bool neq = qm_fd_addr_get64(a) != qm_fd_addr_get64(b);
 
-	if (!r) {
-		enum qm_fd_format fmt_a, fmt_b;
+	neq |= qm_fd_get_format(a) != qm_fd_get_format(b);
+	neq |= a->cfg != b->cfg;
+	neq |= a->cmd != b->cmd;
 
-		fmt_a = qm_fd_get_format(a);
-		fmt_b = qm_fd_get_format(b);
-		r = fmt_a - fmt_b;
-	}
-	if (!r)
-		r = a->cfg - b->cfg;
-	if (!r)
-		r = a->cmd - b->cmd;
-	return r;
+	return neq;
 }
 
 /* test */
@@ -217,12 +210,12 @@ static enum qman_cb_dqrr_result cb_dqrr(struct qman_portal *p,
 					struct qman_fq *fq,
 					const struct qm_dqrr_entry *dq)
 {
-	if (WARN_ON(fd_cmp(&fd_dq, &dq->fd))) {
+	if (WARN_ON(fd_neq(&fd_dq, &dq->fd))) {
 		pr_err("BADNESS: dequeued frame doesn't match;\n");
 		return qman_cb_dqrr_consume;
 	}
 	fd_inc(&fd_dq);
-	if (!(dq->stat & QM_DQRR_STAT_UNSCHEDULED) && !fd_cmp(&fd_dq, &fd)) {
+	if (!(dq->stat & QM_DQRR_STAT_UNSCHEDULED) && !fd_neq(&fd_dq, &fd)) {
 		sdqcr_complete = 1;
 		wake_up(&waitqueue);
 	}
-- 
1.7.11.7
