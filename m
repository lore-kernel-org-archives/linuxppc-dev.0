Return-Path: <fenkes@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1E9DADDF47
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jul 2007 23:27:19 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id l69DRFfD438440
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 13:27:15 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l69DRFuY2162720
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 15:27:15 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l69DREr8029279
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 15:27:14 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 06/13] IB/ehca: Set SEND_GRH flag for all non-LL UD QPs on
	eHCA2
References: <200707091502.22407.fenkes@de.ibm.com>
In-Reply-To: <200707091502.22407.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Mon, 9 Jul 2007 15:27:13 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707091527.14272.fenkes@de.ibm.com>
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
 drivers/infiniband/hw/ehca/ehca_qp.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index ffd1ce9..cbb8b5b 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -1054,6 +1054,17 @@ static int internal_modify_qp(struct ib_qp *ibqp,
 		 "ehca_qp=%p qp_num=%x <VALID STATE CHANGE> qp_state_xsit=%x",
 		 my_qp, ibqp->qp_num, statetrans);
 
+	/* eHCA2 rev2 and higher require the SEND_GRH_FLAG to be set
+	 * in non-LL UD QPs.
+	 */
+	if ((my_qp->qp_type == IB_QPT_UD) &&
+	    (my_qp->ext_type != EQPT_LLQP) &&
+	    (statetrans == IB_QPST_INIT2RTR) &&
+	    (shca->hw_level >= 0x22)){
+		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_SEND_GRH_FLAG, 1);
+		mqpcb->send_grh_flag = 1;
+	}
+
 	/* sqe -> rts: set purge bit of bad wqe before actual trans */
 	if ((my_qp->qp_type == IB_QPT_UD ||
 	     my_qp->qp_type == IB_QPT_GSI ||
-- 
1.5.2
