Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0A053DDECB
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 04:43:51 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78IhmQh025310
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:43:48 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78IhmFE528040
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:43:48 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78IhloB030334
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:43:48 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openib-general@openib.org
Subject: [PATCH 6/7] IB/ehca: Generate last WQE reached,
	when base QP for SRQ has entered error state
Date: Wed, 8 Aug 2007 20:43:46 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708082043.47353.ossrosch@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, "\"Hoang-Nam Nguyen\" @dyn-9-152-249-53"
	<Hoang-Nam.Nguyen@d01av04.pok.ibm.com>, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Joachim Fenkes <fenkes@de.ibm.com>
Date: Wed, 8 Aug 2007 19:51:30 +0200

Signed-off-by: Stefan Roscher <stefan.roscher@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_irq.c |   48 +++++++++++++++++++++-----------
 1 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_irq.c b/drivers/infiniband/hw/ehca/ehca_irq.c
index ee06d8b..941816a 100644
--- a/drivers/infiniband/hw/ehca/ehca_irq.c
+++ b/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -175,41 +175,55 @@ error_data1:
 
 }
 
-static void qp_event_callback(struct ehca_shca *shca, u64 eqe,
-			      enum ib_event_type event_type, int fatal)
+static void dispatch_qp_event(struct ehca_shca *shca, struct ehca_qp *qp,
+			      enum ib_event_type event_type)
 {
 	struct ib_event event;
-	struct ehca_qp *qp;
-	u32 token = EHCA_BMASK_GET(EQE_QP_TOKEN, eqe);
-
-	read_lock(&ehca_qp_idr_lock);
-	qp = idr_find(&ehca_qp_idr, token);
-	read_unlock(&ehca_qp_idr_lock);
-
-
-	if (!qp)
-		return;
-
-	if (fatal)
-		ehca_error_data(shca, qp, qp->ipz_qp_handle.handle);
 
 	event.device = &shca->ib_device;
+	event.event = event_type;
 
 	if (qp->ext_type == EQPT_SRQ) {
 		if (!qp->ib_srq.event_handler)
 			return;
 
-		event.event = fatal ? IB_EVENT_SRQ_ERR : event_type;
 		event.element.srq = &qp->ib_srq;
 		qp->ib_srq.event_handler(&event, qp->ib_srq.srq_context);
 	} else {
 		if (!qp->ib_qp.event_handler)
 			return;
 
-		event.event = event_type;
 		event.element.qp = &qp->ib_qp;
 		qp->ib_qp.event_handler(&event, qp->ib_qp.qp_context);
 	}
+}
+
+static void qp_event_callback(struct ehca_shca *shca, u64 eqe,
+			      enum ib_event_type event_type, int fatal)
+{
+	struct ehca_qp *qp;
+	u32 token = EHCA_BMASK_GET(EQE_QP_TOKEN, eqe);
+
+	read_lock(&ehca_qp_idr_lock);
+	qp = idr_find(&ehca_qp_idr, token);
+	read_unlock(&ehca_qp_idr_lock);
+
+	if (!qp)
+		return;
+
+	if (fatal)
+		ehca_error_data(shca, qp, qp->ipz_qp_handle.handle);
+
+	dispatch_qp_event(shca, qp, fatal && qp->ext_type == EQPT_SRQ ?
+			  IB_EVENT_SRQ_ERR : event_type);
+
+	/*
+	 * eHCA only processes one WQE at a time for SRQ base QPs,
+	 * so the last WQE has been processed as soon as the QP enters
+	 * error state.
+	 */
+	if (fatal && qp->ext_type == EQPT_SRQBASE)
+		dispatch_qp_event(shca, qp, IB_EVENT_QP_LAST_WQE_REACHED);
 
 	return;
 }
-- 
1.5.2
