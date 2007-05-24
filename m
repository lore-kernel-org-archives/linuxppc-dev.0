Return-Path: <fenkes@de.ibm.com>
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [195.212.29.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1AF6BDDE08
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 00:51:15 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l4OEpAFE756186
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 14:51:10 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l4OEpApH2945272
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 15:51:10 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l4OEp9F0032426
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 15:51:10 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH] IB/ehca: Refactor "maybe missed event" code
MIME-Version: 1.0
Date: Thu, 24 May 2007 16:51:05 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705241651.05860.fenkes@de.ibm.com>
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

Refactored Roland's patch so the queue arithmetic is done in a little less
lines. Also, moved the spinlock inside the block it's used in.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_reqs.c |    2 +-
 drivers/infiniband/hw/ehca/ipz_pt_fn.h |   28 ++++++++++------------------
 2 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_reqs.c b/drivers/infiniband/hw/ehca/ehca_reqs.c
index caec9de..56c4527 100644
--- a/drivers/infiniband/hw/ehca/ehca_reqs.c
+++ b/drivers/infiniband/hw/ehca/ehca_reqs.c
@@ -637,7 +637,6 @@ poll_cq_exit0:
 int ehca_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify_flags notify_flags)
 {
 	struct ehca_cq *my_cq = container_of(cq, struct ehca_cq, ib_cq);
-	unsigned long spl_flags;
 	int ret = 0;
 
 	switch (notify_flags & IB_CQ_SOLICITED_MASK) {
@@ -652,6 +651,7 @@ int ehca_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify_flags notify_flags)
 	}
 
 	if (notify_flags & IB_CQ_REPORT_MISSED_EVENTS) {
+		unsigned long spl_flags;
 		spin_lock_irqsave(&my_cq->spinlock, spl_flags);
 		ret = ipz_qeit_is_valid(&my_cq->ipz_queue);
 		spin_unlock_irqrestore(&my_cq->spinlock, spl_flags);
diff --git a/drivers/infiniband/hw/ehca/ipz_pt_fn.h b/drivers/infiniband/hw/ehca/ipz_pt_fn.h
index 57f141a..007f088 100644
--- a/drivers/infiniband/hw/ehca/ipz_pt_fn.h
+++ b/drivers/infiniband/hw/ehca/ipz_pt_fn.h
@@ -105,7 +105,6 @@ void *ipz_qpageit_get_inc(struct ipz_queue *queue);
  * step in struct ipz_queue, will wrap in ringbuffer
  * returns address (kv) of Queue Entry BEFORE increment
  * warning don't use in parallel with ipz_qpageit_get_inc()
- * warning unpredictable results may occur if steps>act_nr_of_queue_entries
  */
 static inline void *ipz_qeit_get_inc(struct ipz_queue *queue)
 {
@@ -121,31 +120,24 @@ static inline void *ipz_qeit_get_inc(struct ipz_queue *queue)
 }
 
 /*
+ * return a bool indicating whether current Queue Entry is valid
+ */
+static inline int ipz_qeit_is_valid(struct ipz_queue *queue)
+{
+	struct ehca_cqe *cqe = ipz_qeit_get(queue);
+	return ((cqe->cqe_flags >> 7) == (queue->toggle_state & 1));
+}
+
+/*
  * return current Queue Entry, increment Queue Entry iterator by one
  * step in struct ipz_queue, will wrap in ringbuffer
  * returns address (kv) of Queue Entry BEFORE increment
  * returns 0 and does not increment, if wrong valid state
  * warning don't use in parallel with ipz_qpageit_get_inc()
- * warning unpredictable results may occur if steps>act_nr_of_queue_entries
  */
 static inline void *ipz_qeit_get_inc_valid(struct ipz_queue *queue)
 {
-	struct ehca_cqe *cqe = ipz_qeit_get(queue);
-	u32 cqe_flags = cqe->cqe_flags;
-
-	if ((cqe_flags >> 7) != (queue->toggle_state & 1))
-		return NULL;
-
-	ipz_qeit_get_inc(queue);
-	return cqe;
-}
-
-static inline int ipz_qeit_is_valid(struct ipz_queue *queue)
-{
-	struct ehca_cqe *cqe = ipz_qeit_get(queue);
-	u32 cqe_flags = cqe->cqe_flags;
-
-	return cqe_flags >> 7 == (queue->toggle_state & 1);
+	return ipz_qeit_is_valid(queue) ? ipz_qeit_get_inc(queue) : NULL;
 }
 
 /*
-- 
1.5.2
