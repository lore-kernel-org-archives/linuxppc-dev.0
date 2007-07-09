Return-Path: <fenkes@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0E3BEDDD09
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jul 2007 23:31:59 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l69DVtR4200800
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 13:31:55 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l69DVtjM1986640
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 15:31:55 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l69DVsm8010341
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 15:31:54 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 11/13] IB/ehca: return QP pointer in poll_cq(),
	add two unlikely() statements
References: <200707091502.22407.fenkes@de.ibm.com>
In-Reply-To: <200707091502.22407.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Mon, 9 Jul 2007 15:31:53 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707091531.54219.fenkes@de.ibm.com>
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

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_reqs.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_reqs.c b/drivers/infiniband/hw/ehca/ehca_reqs.c
index 73f0c06..fd3ba22 100644
--- a/drivers/infiniband/hw/ehca/ehca_reqs.c
+++ b/drivers/infiniband/hw/ehca/ehca_reqs.c
@@ -517,6 +517,7 @@ static inline int ehca_poll_cq_one(struct ib_cq *cq, struct ib_wc *wc)
 	int ret = 0;
 	struct ehca_cq *my_cq = container_of(cq, struct ehca_cq, ib_cq);
 	struct ehca_cqe *cqe;
+	struct ehca_qp *my_qp;
 	int cqe_count = 0;
 
 poll_cq_one_read_cqe:
@@ -568,7 +569,7 @@ poll_cq_one_read_cqe:
 	}
 
 	/* tracing cqe */
-	if (ehca_debug_level) {
+	if (unlikely(ehca_debug_level)) {
 		ehca_dbg(cq->device,
 			 "Received COMPLETION ehca_cq=%p cq_num=%x -----",
 			 my_cq, my_cq->cq_number);
@@ -602,7 +603,11 @@ poll_cq_one_read_cqe:
 	} else
 		wc->status = IB_WC_SUCCESS;
 
-	wc->qp = NULL;
+	read_lock(&ehca_qp_idr_lock);
+	my_qp = idr_find(&ehca_qp_idr, cqe->qp_token);
+	wc->qp = &my_qp->ib_qp;
+	read_unlock(&ehca_qp_idr_lock);
+
 	wc->byte_len = cqe->nr_bytes_transferred;
 	wc->pkey_index = cqe->pkey_index;
 	wc->slid = cqe->rlid;
@@ -612,7 +617,7 @@ poll_cq_one_read_cqe:
 	wc->imm_data = cpu_to_be32(cqe->immediate_data);
 	wc->sl = cqe->service_level;
 
-	if (wc->status != IB_WC_SUCCESS)
+	if (unlikely(wc->status != IB_WC_SUCCESS))
 		ehca_dbg(cq->device,
 			 "ehca_cq=%p cq_num=%x WARNING unsuccessful cqe "
 			 "OPType=%x status=%x qp_num=%x src_qp=%x wr_id=%lx "
-- 
1.5.2
