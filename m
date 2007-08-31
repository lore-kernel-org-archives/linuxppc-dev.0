Return-Path: <fenkes@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 478E8DDFA6
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Sep 2007 00:03:45 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l7VE3dVi044600
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 14:03:39 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l7VE3dVj1458260
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 16:03:39 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7VE3d8t003736
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 16:03:39 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 2/2] IB/ehca: SRQ fixes to enable IPoIB CM
References: <200708311601.42220.fenkes@de.ibm.com>
In-Reply-To: <200708311601.42220.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Fri, 31 Aug 2007 16:03:37 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708311603.38822.fenkes@de.ibm.com>
Cc: Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

a) Report max_srq > 0 if SRQ is supported
b) Report "last wqe reached" event when base QP dies

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_hca.c |   10 +++++--
 drivers/infiniband/hw/ehca/ehca_irq.c |   48 +++++++++++++++++++++-----------
 2 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_hca.c b/drivers/infiniband/hw/ehca/ehca_hca.c
index fc19ef9..cf22472 100644
--- a/drivers/infiniband/hw/ehca/ehca_hca.c
+++ b/drivers/infiniband/hw/ehca/ehca_hca.c
@@ -93,9 +93,13 @@ int ehca_query_device(struct ib_device *ibdev, struct ib_device_attr *props)
 	props->max_pd          = min_t(int, rblock->max_pd, INT_MAX);
 	props->max_ah          = min_t(int, rblock->max_ah, INT_MAX);
 	props->max_fmr         = min_t(int, rblock->max_mr, INT_MAX);
-	props->max_srq         = 0;
-	props->max_srq_wr      = 0;
-	props->max_srq_sge     = 0;
+
+	if (EHCA_BMASK_GET(HCA_CAP_SRQ, shca->hca_cap)) {
+		props->max_srq         = props->max_qp;
+		props->max_srq_wr      = props->max_qp_wr;
+		props->max_srq_sge     = 3;
+	}
+
 	props->max_pkeys       = 16;
 	props->local_ca_ack_delay
 		= rblock->local_ca_ack_delay;
diff --git a/drivers/infiniband/hw/ehca/ehca_irq.c b/drivers/infiniband/hw/ehca/ehca_irq.c
index ee06d8b..a925ea5 100644
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
