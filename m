Return-Path: <fenkes@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E45E5DDEF1
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 21:16:10 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id m6LBFW6G189018
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 11:15:32 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m6LBFWSn3465302
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 13:15:32 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m6LBFWOY008209
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 13:15:32 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 1/2] IB/ehca: Filter PATH_MIG events if QP was never armed
Date: Mon, 21 Jul 2008 13:15:31 +0200
References: <200807211313.23648.fenkes@de.ibm.com>
In-Reply-To: <200807211313.23648.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807211315.31761.fenkes@de.ibm.com>
Cc: Stefan Roscher <stefan.roscher@de.ibm.com>,
	Alexander Schmidt <alexschm@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Certain firmware versions sometimes cause spurious PATH_MIG events to occur
during QP creation. Filter these events by making sure PATH_MIG events are
only handed down when they actually make sense (i.e. when the QP has been
armed at least once).

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_classes.h |    1 +
 drivers/infiniband/hw/ehca/ehca_irq.c     |    4 ++++
 drivers/infiniband/hw/ehca/ehca_qp.c      |    2 ++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_classes.h b/drivers/infiniband/hw/ehca/ehca_classes.h
index 1e9e99a..0b0618e 100644
--- a/drivers/infiniband/hw/ehca/ehca_classes.h
+++ b/drivers/infiniband/hw/ehca/ehca_classes.h
@@ -194,6 +194,7 @@ struct ehca_qp {
 	u32 packet_count;
 	atomic_t nr_events; /* events seen */
 	wait_queue_head_t wait_completion;
+	int mig_armed;
 };
 
 #define IS_SRQ(qp) (qp->ext_type == EQPT_SRQ)
diff --git a/drivers/infiniband/hw/ehca/ehca_irq.c b/drivers/infiniband/hw/ehca/ehca_irq.c
index 0792d93..99642a6 100644
--- a/drivers/infiniband/hw/ehca/ehca_irq.c
+++ b/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -178,6 +178,10 @@ static void dispatch_qp_event(struct ehca_shca *shca, struct ehca_qp *qp,
 {
 	struct ib_event event;
 
+	/* PATH_MIG without the QP ever having been armed is false alarm */
+	if (event_type == IB_EVENT_PATH_MIG && !qp->mig_armed)
+		return;
+
 	event.device = &shca->ib_device;
 	event.event = event_type;
 
diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index 3f59587..ea13efd 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -1460,6 +1460,8 @@ static int internal_modify_qp(struct ib_qp *ibqp,
 			goto modify_qp_exit2;
 		}
 		mqpcb->path_migration_state = attr->path_mig_state + 1;
+		if (attr->path_mig_state == IB_MIG_REARM)
+			my_qp->mig_armed = 1;
 		update_mask |=
 			EHCA_BMASK_SET(MQPCB_MASK_PATH_MIGRATION_STATE, 1);
 	}
-- 
1.5.5
