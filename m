Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A0DC2DDDE0
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 02:34:53 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB2FY4UX005857
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Dec 2008 08:34:04 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB2FYYpi148166
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Dec 2008 08:34:35 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB2FYM4j028684
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Dec 2008 08:34:22 -0700
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	"OF-EWG" <ewg@lists.openfabrics.org>,
	LKML <linux-kernel@vger.kernel.org>, Roland Dreier <rolandd@cisco.com>
Subject: [PATCH] IB/ehca: replace modulus operations in flush error completion
	path
Date: Tue, 2 Dec 2008 16:31:56 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200812021631.58810.ossrosch@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, stefan.roscher@de.ibm.com, alexschm@de.ibm.com,
	raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With the latest flush error completion patch we introduced modulus operation
to calculate the next index within a qmap. Based on comments from other
mailing lists we decided to optimize this operation by using an addition and
an if-statement instead of modulus, even though this is in error path.

Signed-off-by: Stefan Roscher <stefan.roscher@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_classes.h |    7 +++++++
 drivers/infiniband/hw/ehca/ehca_qp.c      |   12 ++++++------
 drivers/infiniband/hw/ehca/ehca_reqs.c    |   13 ++++++-------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_classes.h b/drivers/infiniband/hw/ehca/ehca_classes.h
index 7fc35cf..c825142 100644
--- a/drivers/infiniband/hw/ehca/ehca_classes.h
+++ b/drivers/infiniband/hw/ehca/ehca_classes.h
@@ -175,6 +175,13 @@ struct ehca_queue_map {
 	unsigned int next_wqe_idx;   /* Idx to first wqe to be flushed */
 };
 
+/* function to calculate the next index for the qmap */
+static inline unsigned int next_index(unsigned int cur_index, unsigned int limit)
+{
+	unsigned int temp = cur_index + 1;
+	return (temp == limit) ? 0 : temp;
+}
+
 struct ehca_qp {
 	union {
 		struct ib_qp ib_qp;
diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index cadbf0c..f161cf1 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -1138,14 +1138,14 @@ static int calc_left_cqes(u64 wqe_p, struct ipz_queue *ipz_queue,
 		return -EFAULT;
 	}
 
-	tail_idx = (qmap->tail + 1) % qmap->entries;
+	tail_idx = next_index(qmap->tail, qmap->entries);
 	wqe_idx = q_ofs / ipz_queue->qe_size;
 
 	/* check all processed wqes, whether a cqe is requested or not */
 	while (tail_idx != wqe_idx) {
 		if (qmap->map[tail_idx].cqe_req)
 			qmap->left_to_poll++;
-		tail_idx = (tail_idx + 1) % qmap->entries;
+		tail_idx = next_index(tail_idx, qmap->entries);
 	}
 	/* save index in queue, where we have to start flushing */
 	qmap->next_wqe_idx = wqe_idx;
@@ -1195,14 +1195,14 @@ static int check_for_left_cqes(struct ehca_qp *my_qp, struct ehca_shca *shca)
 	} else {
 		spin_lock_irqsave(&my_qp->send_cq->spinlock, flags);
 		my_qp->sq_map.left_to_poll = 0;
-		my_qp->sq_map.next_wqe_idx = (my_qp->sq_map.tail + 1) %
-						my_qp->sq_map.entries;
+		my_qp->sq_map.next_wqe_idx = next_index(my_qp->sq_map.tail,
+							my_qp->sq_map.entries);
 		spin_unlock_irqrestore(&my_qp->send_cq->spinlock, flags);
 
 		spin_lock_irqsave(&my_qp->recv_cq->spinlock, flags);
 		my_qp->rq_map.left_to_poll = 0;
-		my_qp->rq_map.next_wqe_idx = (my_qp->rq_map.tail + 1) %
-						my_qp->rq_map.entries;
+		my_qp->rq_map.next_wqe_idx = next_index(my_qp->rq_map.tail,
+							my_qp->rq_map.entries);
 		spin_unlock_irqrestore(&my_qp->recv_cq->spinlock, flags);
 	}
 
diff --git a/drivers/infiniband/hw/ehca/ehca_reqs.c b/drivers/infiniband/hw/ehca/ehca_reqs.c
index 00a648f..c711268 100644
--- a/drivers/infiniband/hw/ehca/ehca_reqs.c
+++ b/drivers/infiniband/hw/ehca/ehca_reqs.c
@@ -726,13 +726,13 @@ repoll:
 		 * set left_to_poll to 0 because in error state, we will not
 		 * get any additional CQEs
 		 */
-		my_qp->sq_map.next_wqe_idx = (my_qp->sq_map.tail + 1) %
-						my_qp->sq_map.entries;
+		my_qp->sq_map.next_wqe_idx = next_index(my_qp->sq_map.tail,
+							my_qp->sq_map.entries);
 		my_qp->sq_map.left_to_poll = 0;
 		ehca_add_to_err_list(my_qp, 1);
 
-		my_qp->rq_map.next_wqe_idx = (my_qp->rq_map.tail + 1) %
-						my_qp->rq_map.entries;
+		my_qp->rq_map.next_wqe_idx = next_index(my_qp->rq_map.tail,
+							my_qp->rq_map.entries);
 		my_qp->rq_map.left_to_poll = 0;
 		if (HAS_RQ(my_qp))
 			ehca_add_to_err_list(my_qp, 0);
@@ -860,9 +860,8 @@ static int generate_flush_cqes(struct ehca_qp *my_qp, struct ib_cq *cq,
 
 		/* mark as reported and advance next_wqe pointer */
 		qmap_entry->reported = 1;
-		qmap->next_wqe_idx++;
-		if (qmap->next_wqe_idx == qmap->entries)
-			qmap->next_wqe_idx = 0;
+		qmap->next_wqe_idx = next_index(qmap->next_wqe_idx,
+						qmap->entries);
 		qmap_entry = &qmap->map[qmap->next_wqe_idx];
 
 		wc++; nr++;
-- 
1.5.5
