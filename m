Return-Path: <fenkes@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2717DDE1A6
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 18:04:50 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id m3L84j2U139786
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 08:04:45 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m3L84jQI4304934
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 10:04:45 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m3L84isg017784
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 10:04:45 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 1/5] IB/ehca: Prevent posting of SQ WQEs if QP not in RTS
Date: Mon, 21 Apr 2008 09:04:44 +0100
References: <200804211003.10695.fenkes@de.ibm.com>
In-Reply-To: <200804211003.10695.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804211004.44666.fenkes@de.ibm.com>
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

...as required by IB Spec, C10-29.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_classes.h |    1 +
 drivers/infiniband/hw/ehca/ehca_qp.c      |    3 +++
 drivers/infiniband/hw/ehca/ehca_reqs.c    |    5 +++++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_classes.h b/drivers/infiniband/hw/ehca/ehca_classes.h
index 0d13fe0..3d6d946 100644
--- a/drivers/infiniband/hw/ehca/ehca_classes.h
+++ b/drivers/infiniband/hw/ehca/ehca_classes.h
@@ -160,6 +160,7 @@ struct ehca_qp {
 	};
 	u32 qp_type;
 	enum ehca_ext_qp_type ext_type;
+	enum ib_qp_state state;
 	struct ipz_queue ipz_squeue;
 	struct ipz_queue ipz_rqueue;
 	struct h_galpas galpas;
diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index 3eb14a5..5a653d7 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -550,6 +550,7 @@ static struct ehca_qp *internal_create_qp(
 	spin_lock_init(&my_qp->spinlock_r);
 	my_qp->qp_type = qp_type;
 	my_qp->ext_type = parms.ext_type;
+	my_qp->state = IB_QPS_RESET;
 
 	if (init_attr->recv_cq)
 		my_qp->recv_cq =
@@ -1508,6 +1509,8 @@ static int internal_modify_qp(struct ib_qp *ibqp,
 	if (attr_mask & IB_QP_QKEY)
 		my_qp->qkey = attr->qkey;
 
+	my_qp->state = qp_new_state;
+
 modify_qp_exit2:
 	if (squeue_locked) { /* this means: sqe -> rts */
 		spin_unlock_irqrestore(&my_qp->spinlock_s, flags);
diff --git a/drivers/infiniband/hw/ehca/ehca_reqs.c b/drivers/infiniband/hw/ehca/ehca_reqs.c
index a20bbf4..0b2359e 100644
--- a/drivers/infiniband/hw/ehca/ehca_reqs.c
+++ b/drivers/infiniband/hw/ehca/ehca_reqs.c
@@ -421,6 +421,11 @@ int ehca_post_send(struct ib_qp *qp,
 	int ret = 0;
 	unsigned long flags;
 
+	if (unlikely(my_qp->state != IB_QPS_RTS)) {
+		ehca_err(qp->device, "QP not in RTS state  qpn=%x", qp->qp_num);
+		return -EINVAL;
+	}
+
 	/* LOCK the QUEUE */
 	spin_lock_irqsave(&my_qp->spinlock_s, flags);
 
-- 
1.5.5
