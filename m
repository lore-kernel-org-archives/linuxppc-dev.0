Return-Path: <claudiu.manoil@nxp.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0062.outbound.protection.outlook.com [104.47.34.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJn4R5r5CzDvg0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:40:55 +1100 (AEDT)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <oss@buserror.net>, <roy.pledge@nxp.com>
Subject: [PATCH 12/17] soc/qman: Fix accesses to fqid, cleanup
Date: Wed, 16 Nov 2016 16:40:25 +0200
Message-ID: <1479307230-16650-13-git-send-email-claudiu.manoil@nxp.com>
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

Preventively mask every access to the 'fqid' h/w field,
since it is defined as a 24-bit field, for every h/w
descriptor.  Add generic accessors for this field to
ensure correct access.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c | 32 ++++++++++++++++----------------
 include/soc/fsl/qman.h       |  5 +++++
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 53d9bfb..099ba8e 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -471,7 +471,7 @@ static inline void eqcr_commit_checks(struct qm_eqcr *eqcr)
 {
 	DPAA_ASSERT(eqcr->busy);
 	DPAA_ASSERT(eqcr->cursor->orp == (eqcr->cursor->orp & 0x00ffffff));
-	DPAA_ASSERT(eqcr->cursor->fqid == (eqcr->cursor->fqid & 0x00ffffff));
+	DPAA_ASSERT(!(eqcr->cursor->fqid & ~QM_FQID_MASK));
 	DPAA_ASSERT(eqcr->available >= 1);
 }
 
@@ -1387,7 +1387,7 @@ static void qm_mr_process_task(struct work_struct *work)
 			case QM_MR_VERB_FQRN:
 			case QM_MR_VERB_FQRL:
 				/* Lookup in the retirement table */
-				fq = fqid_to_fq(msg->fq.fqid);
+				fq = fqid_to_fq(qm_fqid_get(&msg->fq));
 				if (WARN_ON(!fq))
 					break;
 				fq_state_change(p, fq, msg, verb);
@@ -1755,7 +1755,7 @@ int qman_init_fq(struct qman_fq *fq, u32 flags, struct qm_mcc_initfq *opts)
 	mcc = qm_mc_start(&p->p);
 	if (opts)
 		mcc->initfq = *opts;
-	mcc->fq.fqid = fq->fqid;
+	qm_fqid_set(&mcc->fq, fq->fqid);
 	mcc->initfq.count = 0;
 	/*
 	 * If the FQ does *not* have the TO_DCPORTAL flag, contextB is set as a
@@ -1851,7 +1851,7 @@ int qman_schedule_fq(struct qman_fq *fq)
 		goto out;
 	}
 	mcc = qm_mc_start(&p->p);
-	mcc->fq.fqid = fq->fqid;
+	qm_fqid_set(&mcc->fq, fq->fqid);
 	qm_mc_commit(&p->p, QM_MCC_VERB_ALTER_SCHED);
 	if (!qm_mc_result_timeout(&p->p, &mcr)) {
 		dev_err(p->config->dev, "ALTER_SCHED timeout\n");
@@ -1894,7 +1894,7 @@ int qman_retire_fq(struct qman_fq *fq, u32 *flags)
 		goto out;
 	}
 	mcc = qm_mc_start(&p->p);
-	mcc->fq.fqid = fq->fqid;
+	qm_fqid_set(&mcc->fq, fq->fqid);
 	qm_mc_commit(&p->p, QM_MCC_VERB_ALTER_RETIRE);
 	if (!qm_mc_result_timeout(&p->p, &mcr)) {
 		dev_crit(p->config->dev, "ALTER_RETIRE timeout\n");
@@ -1937,7 +1937,7 @@ int qman_retire_fq(struct qman_fq *fq, u32 *flags)
 
 			msg.verb = QM_MR_VERB_FQRNI;
 			msg.fq.fqs = mcr->alterfq.fqs;
-			msg.fq.fqid = fq->fqid;
+			qm_fqid_set(&msg.fq, fq->fqid);
 			msg.fq.contextB = fq_to_tag(fq);
 			fq->cb.fqs(p, fq, &msg);
 		}
@@ -1973,7 +1973,7 @@ int qman_oos_fq(struct qman_fq *fq)
 		goto out;
 	}
 	mcc = qm_mc_start(&p->p);
-	mcc->fq.fqid = fq->fqid;
+	qm_fqid_set(&mcc->fq, fq->fqid);
 	qm_mc_commit(&p->p, QM_MCC_VERB_ALTER_OOS);
 	if (!qm_mc_result_timeout(&p->p, &mcr)) {
 		ret = -ETIMEDOUT;
@@ -1999,7 +1999,7 @@ int qman_query_fq(struct qman_fq *fq, struct qm_fqd *fqd)
 	int ret = 0;
 
 	mcc = qm_mc_start(&p->p);
-	mcc->fq.fqid = fq->fqid;
+	qm_fqid_set(&mcc->fq, fq->fqid);
 	qm_mc_commit(&p->p, QM_MCC_VERB_QUERYFQ);
 	if (!qm_mc_result_timeout(&p->p, &mcr)) {
 		ret = -ETIMEDOUT;
@@ -2025,7 +2025,7 @@ static int qman_query_fq_np(struct qman_fq *fq,
 	int ret = 0;
 
 	mcc = qm_mc_start(&p->p);
-	mcc->fq.fqid = fq->fqid;
+	qm_fqid_set(&mcc->fq, fq->fqid);
 	qm_mc_commit(&p->p, QM_MCC_VERB_QUERYFQ_NP);
 	if (!qm_mc_result_timeout(&p->p, &mcr)) {
 		ret = -ETIMEDOUT;
@@ -2206,7 +2206,7 @@ int qman_enqueue(struct qman_fq *fq, const struct qm_fd *fd)
 	if (unlikely(!eq))
 		goto out;
 
-	eq->fqid = fq->fqid;
+	qm_fqid_set(eq, fq->fqid);
 	eq->tag = fq_to_tag(fq);
 	eq->fd = *fd;
 
@@ -2468,7 +2468,7 @@ static int _qm_dqrr_consume_and_match(struct qm_portal *p, u32 fqid, int s,
 	} while (wait && !dqrr);
 
 	while (dqrr) {
-		if (dqrr->fqid == fqid && (dqrr->stat & s))
+		if (qm_fqid_get(dqrr) == fqid && (dqrr->stat & s))
 			found = 1;
 		qm_dqrr_cdc_consume_1ptr(p, dqrr, 0);
 		qm_dqrr_pvb_update(p);
@@ -2504,7 +2504,7 @@ static int qman_shutdown_fq(u32 fqid)
 	dev = p->config->dev;
 	/* Determine the state of the FQID */
 	mcc = qm_mc_start(&p->p);
-	mcc->fq.fqid = fqid;
+	qm_fqid_set(&mcc->fq, fqid);
 	qm_mc_commit(&p->p, QM_MCC_VERB_QUERYFQ_NP);
 	if (!qm_mc_result_timeout(&p->p, &mcr)) {
 		dev_err(dev, "QUERYFQ_NP timeout\n");
@@ -2519,7 +2519,7 @@ static int qman_shutdown_fq(u32 fqid)
 
 	/* Query which channel the FQ is using */
 	mcc = qm_mc_start(&p->p);
-	mcc->fq.fqid = fqid;
+	qm_fqid_set(&mcc->fq, fqid);
 	qm_mc_commit(&p->p, QM_MCC_VERB_QUERYFQ);
 	if (!qm_mc_result_timeout(&p->p, &mcr)) {
 		dev_err(dev, "QUERYFQ timeout\n");
@@ -2539,7 +2539,7 @@ static int qman_shutdown_fq(u32 fqid)
 	case QM_MCR_NP_STATE_PARKED:
 		orl_empty = 0;
 		mcc = qm_mc_start(&p->p);
-		mcc->fq.fqid = fqid;
+		qm_fqid_set(&mcc->fq, fqid);
 		qm_mc_commit(&p->p, QM_MCC_VERB_ALTER_RETIRE);
 		if (!qm_mc_result_timeout(&p->p, &mcr)) {
 			dev_err(dev, "QUERYFQ_NP timeout\n");
@@ -2634,7 +2634,7 @@ static int qman_shutdown_fq(u32 fqid)
 			cpu_relax();
 		}
 		mcc = qm_mc_start(&p->p);
-		mcc->fq.fqid = fqid;
+		qm_fqid_set(&mcc->fq, fqid);
 		qm_mc_commit(&p->p, QM_MCC_VERB_ALTER_OOS);
 		if (!qm_mc_result_timeout(&p->p, &mcr)) {
 			ret = -ETIMEDOUT;
@@ -2654,7 +2654,7 @@ static int qman_shutdown_fq(u32 fqid)
 	case QM_MCR_NP_STATE_RETIRED:
 		/* Send OOS Command */
 		mcc = qm_mc_start(&p->p);
-		mcc->fq.fqid = fqid;
+		qm_fqid_set(&mcc->fq, fqid);
 		qm_mc_commit(&p->p, QM_MCC_VERB_ALTER_OOS);
 		if (!qm_mc_result_timeout(&p->p, &mcr)) {
 			ret = -ETIMEDOUT;
diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
index 1405810..f3fa53f 100644
--- a/include/soc/fsl/qman.h
+++ b/include/soc/fsl/qman.h
@@ -262,6 +262,11 @@ struct qm_dqrr_entry {
 #define QM_DQRR_STAT_UNSCHEDULED	0x02	/* Unscheduled dequeue */
 #define QM_DQRR_STAT_DQCR_EXPIRED	0x01	/* VDQCR or PDQCR expired*/
 
+/* 'fqid' is a 24-bit field in every h/w descriptor */
+#define QM_FQID_MASK	GENMASK(23, 0)
+#define qm_fqid_set(p, v) ((p)->fqid = ((v) & QM_FQID_MASK))
+#define qm_fqid_get(p)    ((p)->fqid & QM_FQID_MASK)
+
 /* "ERN Message Response" */
 /* "FQ State Change Notification" */
 union qm_mr_entry {
-- 
1.7.11.7
