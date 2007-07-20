Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 58D4ADDEDB
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 23:51:17 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6KDpBV1450532
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 13:51:11 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6KDp2LZ2007176
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 15:51:10 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6KDok12014646
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 15:50:46 +0200
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openib-general@openib.org
Subject: [PATCH 2/5] ehca: Generate event when SRQ limit reached
Date: Fri, 20 Jul 2007 16:02:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707201602.19142.hnguyen@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, raisch@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Joachim Fenkes <fenkes@de.ibm.com>
Date: Thu, 19 Jul 2007 20:51:43 +0200
Subject: [PATCH 2/5] IB/ehca: Generate event when SRQ limit reached

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_irq.c |   42 ++++++++++++++++++++++-----------
 1 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_irq.c b/drivers/infiniband/hw/ehca/ehca_irq.c
index 4fb01fc..71c0799 100644
--- a/drivers/infiniband/hw/ehca/ehca_irq.c
+++ b/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -175,9 +175,8 @@ error_data1:
 
 }
 
-static void qp_event_callback(struct ehca_shca *shca,
-			      u64 eqe,
-			      enum ib_event_type event_type)
+static void qp_event_callback(struct ehca_shca *shca, u64 eqe,
+			      enum ib_event_type event_type, int fatal)
 {
 	struct ib_event event;
 	struct ehca_qp *qp;
@@ -191,16 +190,26 @@ static void qp_event_callback(struct ehca_shca *shca,
 	if (!qp)
 		return;
 
-	ehca_error_data(shca, qp, qp->ipz_qp_handle.handle);
+	if (fatal)
+		ehca_error_data(shca, qp, qp->ipz_qp_handle.handle);
 
-	if (!qp->ib_qp.event_handler)
-		return;
+	event.device = &shca->ib_device;
 
-	event.device     = &shca->ib_device;
-	event.event      = event_type;
-	event.element.qp = &qp->ib_qp;
+	if (qp->ext_type == EQPT_SRQ) {
+		if (!qp->ib_srq.event_handler)
+			return;
 
-	qp->ib_qp.event_handler(&event, qp->ib_qp.qp_context);
+		event.event = fatal ? IB_EVENT_SRQ_ERR : event_type;
+		event.element.srq = &qp->ib_srq;
+		qp->ib_srq.event_handler(&event, qp->ib_srq.srq_context);
+	} else {
+		if (!qp->ib_qp.event_handler)
+			return;
+
+		event.event = event_type;
+		event.element.qp = &qp->ib_qp;
+		qp->ib_qp.event_handler(&event, qp->ib_qp.qp_context);
+	}
 
 	return;
 }
@@ -234,17 +243,17 @@ static void parse_identifier(struct ehca_shca *shca, u64 eqe)
 
 	switch (identifier) {
 	case 0x02: /* path migrated */
-		qp_event_callback(shca, eqe, IB_EVENT_PATH_MIG);
+		qp_event_callback(shca, eqe, IB_EVENT_PATH_MIG, 0);
 		break;
 	case 0x03: /* communication established */
-		qp_event_callback(shca, eqe, IB_EVENT_COMM_EST);
+		qp_event_callback(shca, eqe, IB_EVENT_COMM_EST, 0);
 		break;
 	case 0x04: /* send queue drained */
-		qp_event_callback(shca, eqe, IB_EVENT_SQ_DRAINED);
+		qp_event_callback(shca, eqe, IB_EVENT_SQ_DRAINED, 0);
 		break;
 	case 0x05: /* QP error */
 	case 0x06: /* QP error */
-		qp_event_callback(shca, eqe, IB_EVENT_QP_FATAL);
+		qp_event_callback(shca, eqe, IB_EVENT_QP_FATAL, 1);
 		break;
 	case 0x07: /* CQ error */
 	case 0x08: /* CQ error */
@@ -278,6 +287,11 @@ static void parse_identifier(struct ehca_shca *shca, u64 eqe)
 		ehca_err(&shca->ib_device, "Interface trace stopped.");
 		break;
 	case 0x14: /* first error capture info available */
+		ehca_info(&shca->ib_device, "First error capture available");
+		break;
+	case 0x15: /* SRQ limit reached */
+		qp_event_callback(shca, eqe, IB_EVENT_SRQ_LIMIT_REACHED, 0);
+		break;
 	default:
 		ehca_err(&shca->ib_device, "Unknown identifier: %x on %s.",
 			 identifier, shca->ib_device.name);
-- 
1.5.2
