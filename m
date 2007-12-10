Return-Path: <fenkes@de.ibm.com>
Received: from mtagate8.uk.ibm.com (mtagate8.uk.ibm.com [195.212.29.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A7FBBDDDE6
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 22:21:54 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate8.uk.ibm.com (8.13.8/8.13.8) with ESMTP id lBABLV3Y472162
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 11:21:31 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id lBABLVWa5095594
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 11:21:31 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lBABLEmm022780
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 11:21:15 GMT
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH] IB/ehca: Return correct #SGEs for SRQ
MIME-Version: 1.0
Date: Mon, 10 Dec 2007 12:20:57 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712101220.57876.fenkes@de.ibm.com>
Cc: Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Firmware would round up the number of SGEs to four, because the WQE
structure holds four SGEs. For SRQ, only three are supported, so return a
fixed value instead.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---

The patch will apply cleanly on top of Roland's git. Please review and apply
for 2.6.24 -- Thanks!

 drivers/infiniband/hw/ehca/ehca_qp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index dd12668..eff5fb5 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -838,7 +838,7 @@ struct ib_srq *ehca_create_srq(struct ib_pd *pd,
 
 	/* copy back return values */
 	srq_init_attr->attr.max_wr = qp_init_attr.cap.max_recv_wr;
-	srq_init_attr->attr.max_sge = qp_init_attr.cap.max_recv_sge;
+	srq_init_attr->attr.max_sge = 3;
 
 	/* drive SRQ into RTR state */
 	mqpcb = ehca_alloc_fw_ctrlblock(GFP_KERNEL);
@@ -1750,7 +1750,7 @@ int ehca_query_srq(struct ib_srq *srq, struct ib_srq_attr *srq_attr)
 	}
 
 	srq_attr->max_wr = qpcb->max_nr_outst_recv_wr - 1;
-	srq_attr->max_sge = qpcb->actual_nr_sges_in_rq_wqe;
+	srq_attr->max_sge = 3;
 	srq_attr->srq_limit = EHCA_BMASK_GET(
 		MQPCB_CURR_SRQ_LIMIT, qpcb->curr_srq_limit);
 
-- 
1.5.2
