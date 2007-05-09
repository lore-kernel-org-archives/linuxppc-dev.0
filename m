Return-Path: <fenkes@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4A788DDF2E
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 21:48:37 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l49BmX60082996
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 11:48:33 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l49BmXb71921258
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 13:48:33 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l49BmMVa001138
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 13:48:23 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 3/6] IB/ehca: Fix AQP0/1 QP number
MIME-Version: 1.0
Date: Wed, 9 May 2007 13:48:11 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705091348.12551.fenkes@de.ibm.com>
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

From: Hoang-Nam Nguyen <hnguyen@de.ibm.com>

AQP0/1 should report qp_num={0|1} and the actual QP# should be stored in
struct ehca_qp, not the other way round.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_qp.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index e21d796..b5bc787 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -523,6 +523,8 @@ struct ib_qp *ehca_create_qp(struct ib_p
 		goto create_qp_exit1;
 	}
 
+	my_qp->ib_qp.qp_num = my_qp->real_qp_num;
+
 	switch (init_attr->qp_type) {
 	case IB_QPT_RC:
 	        if (isdaqp == 0) {
@@ -568,7 +570,7 @@ struct ib_qp *ehca_create_qp(struct ib_p
 			parms.act_nr_recv_wqes = init_attr->cap.max_recv_wr;
 			parms.act_nr_send_sges = init_attr->cap.max_send_sge;
 			parms.act_nr_recv_sges = init_attr->cap.max_recv_sge;
-			my_qp->real_qp_num =
+			my_qp->ib_qp.qp_num =
 				(init_attr->qp_type == IB_QPT_SMI) ? 0 : 1;
 		}
 
@@ -595,7 +597,6 @@ struct ib_qp *ehca_create_qp(struct ib_p
 	my_qp->ib_qp.recv_cq = init_attr->recv_cq;
 	my_qp->ib_qp.send_cq = init_attr->send_cq;
 
-	my_qp->ib_qp.qp_num = my_qp->real_qp_num;
 	my_qp->ib_qp.qp_type = init_attr->qp_type;
 
 	my_qp->qp_type = init_attr->qp_type;
-- 
1.4.2.1
