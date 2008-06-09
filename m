Return-Path: <fenkes@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4A0D0DDFE7
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jun 2008 21:25:05 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id m59BOMdj270912
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jun 2008 11:24:22 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m59BOMkt3416258
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jun 2008 13:24:22 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m59BOLDJ027851
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jun 2008 13:24:21 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: Dotan Barak <dotanba@gmail.com>, LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	OF-General <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, OF-EWG <ewg@lists.openfabrics.org>
Subject: [PATCH] IB/ehca: Reject recv WRs if QP is in RESET state
Date: Mon, 9 Jun 2008 13:24:20 +0200
References: <200806061835.43802.fenkes@de.ibm.com> <48499C11.7030504@gmail.com>
In-Reply-To: <48499C11.7030504@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806091324.20869.fenkes@de.ibm.com>
Cc: Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
On Friday 06 June 2008 22:20, Dotan Barak wrote:

> I checked the code in the ehca driver and noticed that
> post RR to a QP is being accepted in any state (including the RESET state).

You're right, this is only consistent -- thanks for pointing it out!

Regards,
  Joachim

 drivers/infiniband/hw/ehca/ehca_reqs.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_reqs.c b/drivers/infiniband/hw/ehca/ehca_reqs.c
index f093b00..ad197f4 100644
--- a/drivers/infiniband/hw/ehca/ehca_reqs.c
+++ b/drivers/infiniband/hw/ehca/ehca_reqs.c
@@ -544,8 +544,16 @@ int ehca_post_recv(struct ib_qp *qp,
 		   struct ib_recv_wr *recv_wr,
 		   struct ib_recv_wr **bad_recv_wr)
 {
-	return internal_post_recv(container_of(qp, struct ehca_qp, ib_qp),
-				  qp->device, recv_wr, bad_recv_wr);
+	struct ehca_qp *my_qp = container_of(qp, struct ehca_qp, ib_qp);
+
+	/* Reject WR if QP is in RESET state */
+	if (unlikely(my_qp->state == IB_QPS_RESET)) {
+		ehca_err(qp->device, "Invalid QP state  qp_state=%d qpn=%x",
+			 my_qp->state, qp->qp_num);
+		return -EINVAL;
+	}
+
+	return internal_post_recv(my_qp, qp->device, recv_wr, bad_recv_wr);
 }
 
 int ehca_post_srq_recv(struct ib_srq *srq,
-- 
1.5.5
