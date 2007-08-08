Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7C456DDE3B
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 04:38:04 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78Ic1RK020424
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:38:01 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78Ic12s456928
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:38:01 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78Ic0Tg031256
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:38:01 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openib-general@openib.org
Subject: [PATCH 1/7] IB/ehca: Small QP userspace support and fixes
Date: Wed, 8 Aug 2007 20:37:59 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708082038.00127.ossrosch@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, Hoang-Nam Nguyen <Hoang-Nam.Nguyen@dyn-9-152-249-53>,
	raisch@de.ibm.com
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
 drivers/infiniband/hw/ehca/ehca_qp.c   |    7 +++----
 drivers/infiniband/hw/ehca/ipz_pt_fn.c |    3 ++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index b178cba..cfa83fa 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -273,6 +273,7 @@ static inline void queue2resp(struct ipzu_queue_resp *resp,
 	resp->queue_length = queue->queue_length;
 	resp->pagesize = queue->pagesize;
 	resp->toggle_state = queue->toggle_state;
+	resp->offset = queue->offset;
 }
 
 /*
@@ -598,8 +599,7 @@ static struct ehca_qp *internal_create_qp(
 	parms.squeue.max_sge = max_send_sge;
 	parms.rqueue.max_sge = max_recv_sge;
 
-	if (EHCA_BMASK_GET(HCA_CAP_MINI_QP, shca->hca_cap)
-	    && !(context && udata)) { /* no small QP support in userspace ATM */
+	if (EHCA_BMASK_GET(HCA_CAP_MINI_QP, shca->hca_cap)) {
 		ehca_determine_small_queue(
 			&parms.squeue, max_send_sge, is_llqp);
 		ehca_determine_small_queue(
@@ -739,8 +739,7 @@ static struct ehca_qp *internal_create_qp(
 		resp.ext_type = my_qp->ext_type;
 		resp.qkey = my_qp->qkey;
 		resp.real_qp_num = my_qp->real_qp_num;
-		resp.ipz_rqueue.offset = my_qp->ipz_rqueue.offset;
-		resp.ipz_squeue.offset = my_qp->ipz_squeue.offset;
+
 		if (HAS_SQ(my_qp))
 			queue2resp(&resp.ipz_squeue, &my_qp->ipz_squeue);
 		if (HAS_RQ(my_qp))
diff --git a/drivers/infiniband/hw/ehca/ipz_pt_fn.c b/drivers/infiniband/hw/ehca/ipz_pt_fn.c
index a090c67..661f8db 100644
--- a/drivers/infiniband/hw/ehca/ipz_pt_fn.c
+++ b/drivers/infiniband/hw/ehca/ipz_pt_fn.c
@@ -158,6 +158,7 @@ static int alloc_small_queue_page(struct ipz_queue *queue, struct ehca_pd *pd)
 
 	queue->queue_pages[0] = (void *)(page->page | (bit << (order + 9)));
 	queue->small_page = page;
+	queue->offset = bit << (order + 9);
 	return 1;
 
 out:
@@ -172,7 +173,7 @@ static void free_small_queue_page(struct ipz_queue *queue, struct ehca_pd *pd)
 	unsigned long bit;
 	int free_page = 0;
 
-	bit = ((unsigned long)queue->queue_pages[0] & PAGE_MASK)
+	bit = ((unsigned long)queue->queue_pages[0] & ~PAGE_MASK)
 		>> (order + 9);
 
 	mutex_lock(&pd->lock);
-- 
1.5.2
