Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A2BD4DDE49
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 04:44:42 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78Ijwh1027901
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:45:58 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78IidfL393778
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:44:39 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78IicTN000537
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:44:39 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openib-general@openib.org
Subject: [PATCH 7/7] IB/ehca: Prevent overwriting QP init attributes given by
	caller
Date: Wed, 8 Aug 2007 20:44:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708082044.38247.ossrosch@linux.vnet.ibm.com>
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

Signed-off-by: Stefan Roscher <stefan.roscher@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_qp.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index d8c1c22..6efda3d 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -709,12 +709,12 @@ static struct ehca_qp *internal_create_qp(
 		my_qp->ib_qp.event_handler = init_attr->event_handler;
 	}
 
-	init_attr->cap.max_inline_data = 0; /* not supported yet */
-	init_attr->cap.max_recv_sge = parms.rqueue.act_nr_sges;
-	init_attr->cap.max_recv_wr = parms.rqueue.act_nr_wqes;
-	init_attr->cap.max_send_sge = parms.squeue.act_nr_sges;
-	init_attr->cap.max_send_wr = parms.squeue.act_nr_wqes;
 	my_qp->init_attr = *init_attr;
+	my_qp->init_attr.cap.max_inline_data = 0; /* not supported yet */
+	my_qp->init_attr.cap.max_recv_sge = parms.rqueue.act_nr_sges;
+	my_qp->init_attr.cap.max_recv_wr = parms.rqueue.act_nr_wqes;
+	my_qp->init_attr.cap.max_send_sge = parms.squeue.act_nr_sges;
+	my_qp->init_attr.cap.max_send_wr = parms.squeue.act_nr_wqes;
 
 	/* NOTE: define_apq0() not supported yet */
 	if (qp_type == IB_QPT_GSI) {
@@ -825,10 +825,6 @@ struct ib_srq *ehca_create_srq(struct ib_pd *pd,
 	if (IS_ERR(my_qp))
 		return (struct ib_srq *)my_qp;
 
-	/* copy back return values */
-	srq_init_attr->attr.max_wr = qp_init_attr.cap.max_recv_wr;
-	srq_init_attr->attr.max_sge = qp_init_attr.cap.max_recv_sge;
-
 	/* drive SRQ into RTR state */
 	mqpcb = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
 	if (!mqpcb) {
-- 
1.5.2
