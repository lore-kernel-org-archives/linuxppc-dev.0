Return-Path: <fenkes@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2C81BDDF5B
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jul 2007 23:26:36 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l69DQWOU016826
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 13:26:32 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l69DQWt01642638
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 15:26:32 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l69DQVQ6022835
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 15:26:32 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 05/13] IB/ehca: Support UD low latency QPs
References: <200707091502.22407.fenkes@de.ibm.com>
In-Reply-To: <200707091502.22407.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Mon, 9 Jul 2007 15:26:31 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707091526.31709.fenkes@de.ibm.com>
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

From: Stefan Roscher <stefan.roscher@de.ibm.com>

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_qp.c |   84 +++++++++++++++++++++++-----------
 1 files changed, 57 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index 9486a44..ffd1ce9 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -275,6 +275,11 @@ static inline void queue2resp(struct ipzu_queue_resp *resp,
 	resp->toggle_state = queue->toggle_state;
 }
 
+static inline int ll_qp_msg_size(int nr_sge)
+{
+	return 128 << nr_sge;
+}
+
 /*
  * init_qp_queue initializes/constructs r/squeue and registers queue pages.
  */
@@ -363,8 +368,6 @@ struct ehca_qp *internal_create_qp(struct ib_pd *pd,
 				   struct ib_srq_init_attr *srq_init_attr,
 				   struct ib_udata *udata, int is_srq)
 {
-	static int da_rc_msg_size[] = { 128, 256, 512, 1024, 2048, 4096 };
-	static int da_ud_sq_msg_size[]={ 128, 384, 896, 1920, 3968 };
 	struct ehca_qp *my_qp;
 	struct ehca_pd *my_pd = container_of(pd, struct ehca_pd, ib_pd);
 	struct ehca_shca *shca = container_of(pd->device, struct ehca_shca,
@@ -396,6 +399,7 @@ struct ehca_qp *internal_create_qp(struct ib_pd *pd,
 		parms.ll_comp_flags = qp_type & LLQP_COMP_MASK;
 	}
 	qp_type &= 0x1F;
+	init_attr->qp_type &= 0x1F;
 
 	/* handle SRQ base QPs */
 	if (init_attr->srq) {
@@ -435,23 +439,49 @@ struct ehca_qp *internal_create_qp(struct ib_pd *pd,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (is_llqp && (qp_type != IB_QPT_RC && qp_type != IB_QPT_UD)) {
-		ehca_err(pd->device, "unsupported LL QP Type=%x", qp_type);
-		return ERR_PTR(-EINVAL);
-	} else if (is_llqp && qp_type == IB_QPT_RC &&
-		   (init_attr->cap.max_send_wr > 255 ||
-		    init_attr->cap.max_recv_wr > 255 )) {
-		ehca_err(pd->device, "Invalid Number of max_sq_wr=%x "
-			 "or max_rq_wr=%x for RC LLQP",
-			 init_attr->cap.max_send_wr,
-			 init_attr->cap.max_recv_wr);
-		return ERR_PTR(-EINVAL);
-	} else if (is_llqp && qp_type == IB_QPT_UD &&
-		 init_attr->cap.max_send_wr > 255) {
-		ehca_err(pd->device,
-			 "Invalid Number of max_send_wr=%x for UD QP_TYPE=%x",
-			 init_attr->cap.max_send_wr, qp_type);
-		return ERR_PTR(-EINVAL);
+	if (is_llqp) {
+		switch (qp_type) {
+		case IB_QPT_RC:
+			if ((init_attr->cap.max_send_wr > 255) ||
+			    (init_attr->cap.max_recv_wr > 255)) {
+				ehca_err(pd->device,
+					 "Invalid Number of max_sq_wr=%x "
+					 "or max_rq_wr=%x for RC LLQP",
+					 init_attr->cap.max_send_wr,
+					 init_attr->cap.max_recv_wr);
+				return ERR_PTR(-EINVAL);
+			}
+			break;
+		case IB_QPT_UD:
+			if (!EHCA_BMASK_GET(HCA_CAP_UD_LL_QP, shca->hca_cap)) {
+				ehca_err(pd->device, "UD LLQP not supported "
+					 "by this adapter");
+				return ERR_PTR(-ENOSYS);
+			}
+			if (!(init_attr->cap.max_send_sge <= 5
+			    && init_attr->cap.max_send_sge >= 1
+			    && init_attr->cap.max_recv_sge <= 5
+			    && init_attr->cap.max_recv_sge >= 1)) {
+				ehca_err(pd->device,
+					 "Invalid Number of max_send_sge=%x "
+					 "or max_recv_sge=%x for UD LLQP",
+					 init_attr->cap.max_send_sge,
+					 init_attr->cap.max_recv_sge);
+				return ERR_PTR(-EINVAL);
+			} else if (init_attr->cap.max_send_wr > 255) {
+				ehca_err(pd->device,
+					 "Invalid Number of "
+					 "ax_send_wr=%x for UD QP_TYPE=%x",
+					 init_attr->cap.max_send_wr, qp_type);
+				return ERR_PTR(-EINVAL);
+			}
+			break;
+		default:
+			ehca_err(pd->device, "unsupported LL QP Type=%x",
+				 qp_type);
+			return ERR_PTR(-EINVAL);
+			break;
+		}
 	}
 
 	if (pd->uobject && udata)
@@ -509,7 +539,7 @@ struct ehca_qp *internal_create_qp(struct ib_pd *pd,
 	/* UD_AV CIRCUMVENTION */
 	max_send_sge = init_attr->cap.max_send_sge;
 	max_recv_sge = init_attr->cap.max_recv_sge;
-	if (parms.servicetype == ST_UD) {
+	if (parms.servicetype == ST_UD && !is_llqp) {
 		max_send_sge += 2;
 		max_recv_sge += 2;
 	}
@@ -547,8 +577,8 @@ struct ehca_qp *internal_create_qp(struct ib_pd *pd,
 			rwqe_size = offsetof(struct ehca_wqe, u.nud.sg_list[
 					     (parms.act_nr_recv_sges)]);
 		} else { /* for LLQP we need to use msg size, not wqe size */
-		        swqe_size = da_rc_msg_size[max_send_sge];
-			rwqe_size = da_rc_msg_size[max_recv_sge];
+			swqe_size = ll_qp_msg_size(max_send_sge);
+			rwqe_size = ll_qp_msg_size(max_recv_sge);
 			parms.act_nr_send_sges = 1;
 			parms.act_nr_recv_sges = 1;
 		}
@@ -563,15 +593,15 @@ struct ehca_qp *internal_create_qp(struct ib_pd *pd,
 	case IB_QPT_UD:
 	case IB_QPT_GSI:
 	case IB_QPT_SMI:
-		/* UD circumvention */
-		parms.act_nr_recv_sges -= 2;
-		parms.act_nr_send_sges -= 2;
 		if (is_llqp) {
-		        swqe_size = da_ud_sq_msg_size[max_send_sge];
-			rwqe_size = da_rc_msg_size[max_recv_sge];
+			swqe_size = ll_qp_msg_size(parms.act_nr_send_sges);
+			rwqe_size = ll_qp_msg_size(parms.act_nr_recv_sges);
 			parms.act_nr_send_sges = 1;
 			parms.act_nr_recv_sges = 1;
 		} else {
+			/* UD circumvention */
+			parms.act_nr_send_sges -= 2;
+			parms.act_nr_recv_sges -= 2;
 			swqe_size = offsetof(struct ehca_wqe,
 					     u.ud_av.sg_list[parms.act_nr_send_sges]);
 			rwqe_size = offsetof(struct ehca_wqe,
-- 
1.5.2
