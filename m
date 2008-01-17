Return-Path: <fenkes@de.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EE67CDDE41
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 01:07:33 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m0HE7TLt131986
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 14:07:29 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m0HE7TwB4739146
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 14:07:29 GMT
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m0HE7POv011432
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 14:07:26 GMT
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 4/4] IB/ehca: Prevent RDMA-related connection failures
References: <200801171502.34287.fenkes@de.ibm.com>
In-Reply-To: <200801171502.34287.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Thu, 17 Jan 2008 15:07:24 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801171507.25145.fenkes@de.ibm.com>
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

Some HW revisions of eHCA2 may cause an RC connection to break if they
received RDMA Reads over that connection before. This can be prevented by
assuring that, after the first RDMA Read, the QP receives a new RDMA Read
every few million link packets.

Include code into the driver that inserts an empty (size 0) RDMA Read into
the message stream every now and then if the consumer doesn't post them
frequently enough.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_classes.h |    5 ++
 drivers/infiniband/hw/ehca/ehca_qp.c      |   14 +++-
 drivers/infiniband/hw/ehca/ehca_reqs.c    |  112 ++++++++++++++++++++--------
 3 files changed, 95 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_classes.h b/drivers/infiniband/hw/ehca/ehca_classes.h
index 2502366..f281d16 100644
--- a/drivers/infiniband/hw/ehca/ehca_classes.h
+++ b/drivers/infiniband/hw/ehca/ehca_classes.h
@@ -183,6 +183,11 @@ struct ehca_qp {
 	u32 mm_count_squeue;
 	u32 mm_count_rqueue;
 	u32 mm_count_galpa;
+	/* unsolicited ack circumvention */
+	int unsol_ack_circ;
+	int mtu_shift;
+	u32 message_count;
+	u32 packet_count;
 };
 
 #define IS_SRQ(qp) (qp->ext_type == EQPT_SRQ)
diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index bb7ccef..6c050e0 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -592,10 +592,8 @@ static struct ehca_qp *internal_create_qp(
 		goto create_qp_exit1;
 	}
 
-	if (init_attr->sq_sig_type == IB_SIGNAL_ALL_WR)
-		parms.sigtype = HCALL_SIGT_EVERY;
-	else
-		parms.sigtype = HCALL_SIGT_BY_WQE;
+	/* Always signal by WQE so we can hide circ. WQEs */
+	parms.sigtype = HCALL_SIGT_BY_WQE;
 
 	/* UD_AV CIRCUMVENTION */
 	max_send_sge = init_attr->cap.max_send_sge;
@@ -618,6 +616,10 @@ static struct ehca_qp *internal_create_qp(
 	parms.squeue.max_sge = max_send_sge;
 	parms.rqueue.max_sge = max_recv_sge;
 
+	/* RC QPs need one more SWQE for unsolicited ack circumvention */
+	if (qp_type == IB_QPT_RC)
+		parms.squeue.max_wr++;
+
 	if (EHCA_BMASK_GET(HCA_CAP_MINI_QP, shca->hca_cap)) {
 		if (HAS_SQ(my_qp))
 			ehca_determine_small_queue(
@@ -650,6 +652,8 @@ static struct ehca_qp *internal_create_qp(
 			parms.squeue.act_nr_sges = 1;
 			parms.rqueue.act_nr_sges = 1;
 		}
+		/* hide the extra WQE */
+		parms.squeue.act_nr_wqes--;
 		break;
 	case IB_QPT_UD:
 	case IB_QPT_GSI:
@@ -1295,6 +1299,8 @@ static int internal_modify_qp(struct ib_qp *ibqp,
 	}
 
 	if (attr_mask & IB_QP_PATH_MTU) {
+		/* store ld(MTU) */
+		my_qp->mtu_shift = attr->path_mtu + 7;
 		mqpcb->path_mtu = attr->path_mtu;
 		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_PATH_MTU, 1);
 	}
diff --git a/drivers/infiniband/hw/ehca/ehca_reqs.c b/drivers/infiniband/hw/ehca/ehca_reqs.c
index ea91360..3aacc8c 100644
--- a/drivers/infiniband/hw/ehca/ehca_reqs.c
+++ b/drivers/infiniband/hw/ehca/ehca_reqs.c
@@ -50,6 +50,9 @@
 #include "hcp_if.h"
 #include "hipz_fns.h"
 
+/* in RC traffic, insert an empty RDMA READ every this many packets */
+#define ACK_CIRC_THRESHOLD 2000000
+
 static inline int ehca_write_rwqe(struct ipz_queue *ipz_rqueue,
 				  struct ehca_wqe *wqe_p,
 				  struct ib_recv_wr *recv_wr)
@@ -81,7 +84,7 @@ static inline int ehca_write_rwqe(struct ipz_queue *ipz_rqueue,
 	if (ehca_debug_level) {
 		ehca_gen_dbg("RECEIVE WQE written into ipz_rqueue=%p",
 			     ipz_rqueue);
-		ehca_dmp( wqe_p, 16*(6 + wqe_p->nr_of_data_seg), "recv wqe");
+		ehca_dmp(wqe_p, 16*(6 + wqe_p->nr_of_data_seg), "recv wqe");
 	}
 
 	return 0;
@@ -135,7 +138,8 @@ static void trace_send_wr_ud(const struct ib_send_wr *send_wr)
 
 static inline int ehca_write_swqe(struct ehca_qp *qp,
 				  struct ehca_wqe *wqe_p,
-				  const struct ib_send_wr *send_wr)
+				  const struct ib_send_wr *send_wr,
+				  int hidden)
 {
 	u32 idx;
 	u64 dma_length;
@@ -176,7 +180,9 @@ static inline int ehca_write_swqe(struct ehca_qp *qp,
 
 	wqe_p->wr_flag = 0;
 
-	if (send_wr->send_flags & IB_SEND_SIGNALED)
+	if ((send_wr->send_flags & IB_SEND_SIGNALED ||
+	    qp->init_attr.sq_sig_type == IB_SIGNAL_ALL_WR)
+	    && !hidden)
 		wqe_p->wr_flag |= WQE_WRFLAG_REQ_SIGNAL_COM;
 
 	if (send_wr->opcode == IB_WR_SEND_WITH_IMM ||
@@ -199,7 +205,7 @@ static inline int ehca_write_swqe(struct ehca_qp *qp,
 
 		wqe_p->destination_qp_number = send_wr->wr.ud.remote_qpn << 8;
 		wqe_p->local_ee_context_qkey = remote_qkey;
-		if (!send_wr->wr.ud.ah) {
+		if (unlikely(!send_wr->wr.ud.ah)) {
 			ehca_gen_err("wr.ud.ah is NULL. qp=%p", qp);
 			return -EINVAL;
 		}
@@ -255,6 +261,15 @@ static inline int ehca_write_swqe(struct ehca_qp *qp,
 		} /* eof idx */
 		wqe_p->u.nud.atomic_1st_op_dma_len = dma_length;
 
+		/* unsolicited ack circumvention */
+		if (send_wr->opcode == IB_WR_RDMA_READ) {
+			/* on RDMA read, switch on and reset counters */
+			qp->message_count = qp->packet_count = 0;
+			qp->unsol_ack_circ = 1;
+		} else
+			/* else estimate #packets */
+			qp->packet_count += (dma_length >> qp->mtu_shift) + 1;
+
 		break;
 
 	default:
@@ -355,13 +370,49 @@ static inline void map_ib_wc_status(u32 cqe_status,
 		*wc_status = IB_WC_SUCCESS;
 }
 
+static inline int post_one_send(struct ehca_qp *my_qp,
+			 struct ib_send_wr *cur_send_wr,
+			 struct ib_send_wr **bad_send_wr,
+			 int hidden)
+{
+	struct ehca_wqe *wqe_p;
+	int ret;
+	u64 start_offset = my_qp->ipz_squeue.current_q_offset;
+
+	/* get pointer next to free WQE */
+	wqe_p = ipz_qeit_get_inc(&my_qp->ipz_squeue);
+	if (unlikely(!wqe_p)) {
+		/* too many posted work requests: queue overflow */
+		if (bad_send_wr)
+			*bad_send_wr = cur_send_wr;
+		ehca_err(my_qp->ib_qp.device, "Too many posted WQEs "
+			 "qp_num=%x", my_qp->ib_qp.qp_num);
+		return -ENOMEM;
+	}
+	/* write a SEND WQE into the QUEUE */
+	ret = ehca_write_swqe(my_qp, wqe_p, cur_send_wr, hidden);
+	/*
+	 * if something failed,
+	 * reset the free entry pointer to the start value
+	 */
+	if (unlikely(ret)) {
+		my_qp->ipz_squeue.current_q_offset = start_offset;
+		if (bad_send_wr)
+			*bad_send_wr = cur_send_wr;
+		ehca_err(my_qp->ib_qp.device, "Could not write WQE "
+			 "qp_num=%x", my_qp->ib_qp.qp_num);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int ehca_post_send(struct ib_qp *qp,
 		   struct ib_send_wr *send_wr,
 		   struct ib_send_wr **bad_send_wr)
 {
 	struct ehca_qp *my_qp = container_of(qp, struct ehca_qp, ib_qp);
 	struct ib_send_wr *cur_send_wr;
-	struct ehca_wqe *wqe_p;
 	int wqe_cnt = 0;
 	int ret = 0;
 	unsigned long flags;
@@ -369,37 +420,33 @@ int ehca_post_send(struct ib_qp *qp,
 	/* LOCK the QUEUE */
 	spin_lock_irqsave(&my_qp->spinlock_s, flags);
 
+	/* Send an empty extra RDMA read if:
+	 *  1) there has been an RDMA read on this connection before
+	 *  2) no RDMA read occurred for ACK_CIRC_THRESHOLD link packets
+	 *  3) we can be sure that any previous extra RDMA read has been
+	 *     processed so we don't overflow the SQ
+	 */
+	if (unlikely(my_qp->unsol_ack_circ &&
+		     my_qp->packet_count > ACK_CIRC_THRESHOLD &&
+		     my_qp->message_count > my_qp->init_attr.cap.max_send_wr)) {
+		/* insert an empty RDMA READ to fix up the remote QP state */
+		struct ib_send_wr circ_wr;
+		memset(&circ_wr, 0, sizeof(circ_wr));
+		circ_wr.opcode = IB_WR_RDMA_READ;
+		post_one_send(my_qp, &circ_wr, NULL, 1); /* ignore retcode */
+		wqe_cnt++;
+		ehca_dbg(qp->device, "posted circ wr  qp_num=%x", qp->qp_num);
+		my_qp->message_count = my_qp->packet_count = 0;
+	}
+
 	/* loop processes list of send reqs */
 	for (cur_send_wr = send_wr; cur_send_wr != NULL;
 	     cur_send_wr = cur_send_wr->next) {
-		u64 start_offset = my_qp->ipz_squeue.current_q_offset;
-		/* get pointer next to free WQE */
-		wqe_p = ipz_qeit_get_inc(&my_qp->ipz_squeue);
-		if (unlikely(!wqe_p)) {
-			/* too many posted work requests: queue overflow */
-			if (bad_send_wr)
-				*bad_send_wr = cur_send_wr;
-			if (wqe_cnt == 0) {
-				ret = -ENOMEM;
-				ehca_err(qp->device, "Too many posted WQEs "
-					 "qp_num=%x", qp->qp_num);
-			}
-			goto post_send_exit0;
-		}
-		/* write a SEND WQE into the QUEUE */
-		ret = ehca_write_swqe(my_qp, wqe_p, cur_send_wr);
-		/*
-		 * if something failed,
-		 * reset the free entry pointer to the start value
-		 */
+		ret = post_one_send(my_qp, cur_send_wr, bad_send_wr, 0);
 		if (unlikely(ret)) {
-			my_qp->ipz_squeue.current_q_offset = start_offset;
-			*bad_send_wr = cur_send_wr;
-			if (wqe_cnt == 0) {
-				ret = -EINVAL;
-				ehca_err(qp->device, "Could not write WQE "
-					 "qp_num=%x", qp->qp_num);
-			}
+			/* if one or more WQEs were successful, don't fail */
+			if (wqe_cnt)
+				ret = 0;
 			goto post_send_exit0;
 		}
 		wqe_cnt++;
@@ -410,6 +457,7 @@ int ehca_post_send(struct ib_qp *qp,
 post_send_exit0:
 	iosync(); /* serialize GAL register access */
 	hipz_update_sqa(my_qp, wqe_cnt);
+	my_qp->message_count += wqe_cnt;
 	spin_unlock_irqrestore(&my_qp->spinlock_s, flags);
 	return ret;
 }
-- 
1.5.2
