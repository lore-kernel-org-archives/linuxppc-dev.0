Return-Path: <fenkes@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C8040DDEB6
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 23:26:40 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l8BDQZap209212
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 13:26:35 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8BDQZuG2220248
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 15:26:35 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8BDQYv0029897
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 15:26:35 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 01/12] IB/ehca: Small QP userspace support
Date: Tue, 11 Sep 2007 15:26:33 +0200
References: <200709111518.26276.fenkes@de.ibm.com>
In-Reply-To: <200709111518.26276.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709111526.34394.fenkes@de.ibm.com>
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
 drivers/infiniband/hw/ehca/ehca_qp.c   |    7 +++----
 drivers/infiniband/hw/ehca/ipz_pt_fn.c |    1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index 84d435a..13b61c3 100644
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
 		if (HAS_SQ(my_qp))
 			ehca_determine_small_queue(
 				&parms.squeue, max_send_sge, is_llqp);
@@ -741,8 +741,7 @@ static struct ehca_qp *internal_create_qp(
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
index 29bd476..661f8db 100644
--- a/drivers/infiniband/hw/ehca/ipz_pt_fn.c
+++ b/drivers/infiniband/hw/ehca/ipz_pt_fn.c
@@ -158,6 +158,7 @@ static int alloc_small_queue_page(struct ipz_queue *queue, struct ehca_pd *pd)
 
 	queue->queue_pages[0] = (void *)(page->page | (bit << (order + 9)));
 	queue->small_page = page;
+	queue->offset = bit << (order + 9);
 	return 1;
 
 out:
-- 
1.5.2
