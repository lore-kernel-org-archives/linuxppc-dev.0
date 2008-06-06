Return-Path: <fenkes@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CC023DE0A4
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 02:35:51 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id m56GZj4K143738
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 16:35:45 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m56GZj7N3719372
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 18:35:45 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m56GZiU9016284
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 18:35:44 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: IB/ehca: Reject send WRs only for RESET, INIT and RTR state
MIME-Version: 1.0
Date: Fri, 6 Jun 2008 18:35:43 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806061835.43802.fenkes@de.ibm.com>
Cc: Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
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
 drivers/infiniband/hw/ehca/ehca_reqs.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_reqs.c b/drivers/infiniband/hw/ehca/ehca_reqs.c
index bbe0436..f093b00 100644
--- a/drivers/infiniband/hw/ehca/ehca_reqs.c
+++ b/drivers/infiniband/hw/ehca/ehca_reqs.c
@@ -421,8 +421,10 @@ int ehca_post_send(struct ib_qp *qp,
 	int ret = 0;
 	unsigned long flags;
 
-	if (unlikely(my_qp->state != IB_QPS_RTS)) {
-		ehca_err(qp->device, "QP not in RTS state  qpn=%x", qp->qp_num);
+	/* Reject WR if QP is in RESET, INIT or RTR state */
+	if (unlikely(my_qp->state < IB_QPS_RTS)) {
+		ehca_err(qp->device, "Invalid QP state  qp_state=%d qpn=%x",
+			 my_qp->state, qp->qp_num);
 		return -EINVAL;
 	}
 
-- 
1.5.5
