Return-Path: <fenkes@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 97717DDF84
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Sep 2007 00:03:05 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l7VE30L3146500
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 14:03:00 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l7VE315V2297960
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 16:03:01 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7VE301I013704
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 16:03:00 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 1/2] IB/ehca: fix Small QP regressions
Date: Fri, 31 Aug 2007 16:02:59 +0200
References: <200708311601.42220.fenkes@de.ibm.com>
In-Reply-To: <200708311601.42220.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708311602.59890.fenkes@de.ibm.com>
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

The new Small QP code had a few bugs that would also trigger for non-Small
QPs. Fix them.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_qp.c   |   10 ++++++----
 drivers/infiniband/hw/ehca/ipz_pt_fn.c |    2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index b178cba..84d435a 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -600,10 +600,12 @@ static struct ehca_qp *internal_create_qp(
 
 	if (EHCA_BMASK_GET(HCA_CAP_MINI_QP, shca->hca_cap)
 	    && !(context && udata)) { /* no small QP support in userspace ATM */
-		ehca_determine_small_queue(
-			&parms.squeue, max_send_sge, is_llqp);
-		ehca_determine_small_queue(
-			&parms.rqueue, max_recv_sge, is_llqp);
+		if (HAS_SQ(my_qp))
+			ehca_determine_small_queue(
+				&parms.squeue, max_send_sge, is_llqp);
+		if (HAS_RQ(my_qp))
+			ehca_determine_small_queue(
+				&parms.rqueue, max_recv_sge, is_llqp);
 		parms.qp_storage =
 			(parms.squeue.is_small || parms.rqueue.is_small);
 	}
diff --git a/drivers/infiniband/hw/ehca/ipz_pt_fn.c b/drivers/infiniband/hw/ehca/ipz_pt_fn.c
index a090c67..29bd476 100644
--- a/drivers/infiniband/hw/ehca/ipz_pt_fn.c
+++ b/drivers/infiniband/hw/ehca/ipz_pt_fn.c
@@ -172,7 +172,7 @@ static void free_small_queue_page(struct ipz_queue *queue, struct ehca_pd *pd)
 	unsigned long bit;
 	int free_page = 0;
 
-	bit = ((unsigned long)queue->queue_pages[0] & PAGE_MASK)
+	bit = ((unsigned long)queue->queue_pages[0] & ~PAGE_MASK)
 		>> (order + 9);
 
 	mutex_lock(&pd->lock);
-- 
1.5.2
