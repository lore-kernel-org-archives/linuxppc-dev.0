Return-Path: <alexs@linux.vnet.ibm.com>
Received: from mtagate7.uk.ibm.com (mtagate7.uk.ibm.com [195.212.29.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DAD80DDE2A
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 22:50:16 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate7.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m7CCnWtU347312
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 12:49:32 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m7CCnWS71224956
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 13:49:32 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m7CCnV5J009324
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 13:49:32 +0100
Date: Tue, 12 Aug 2008 14:49:31 +0200
From: Alexander Schmidt <alexs@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, lkml
	<linux-kernel@vger.kernel.org>, of-ewg <ewg@lists.openfabrics.org>,
	of-general <general@lists.openfabrics.org>, Roland Dreier
	<rolandd@cisco.com>
Subject: [PATCH 1/5] ib/ehca: update qp_state on cached modify_qp()
Message-ID: <20080812144931.00365782@BL3D1974.boeblingen.de.ibm.com>
In-Reply-To: <20080812143542.0cbde755@BL3D1974.boeblingen.de.ibm.com>
References: <20080812143542.0cbde755@BL3D1974.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Joachim Fenkes <fenkes@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>, Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since the introduction of the port auto-detect mode for ehca, calls to
modify_qp() may be cached in the device driver when the ports are not
activated yet. When a modify_qp() call is cached, the qp state remains
untouched until the port is activated, which will leave the qp in the
reset state. In the reset state, however, it is not allowed to post SQ
WQEs, which confuses applications like ib_mad.

The solution for this problem is to immediately set the qp state as
requested by modify_qp(), even when the call is cached.


Signed-off-by: Alexander Schmidt <alexs@linux.vnet.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_qp.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- infiniband.git.orig/drivers/infiniband/hw/ehca/ehca_qp.c
+++ infiniband.git/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -1534,8 +1534,6 @@ static int internal_modify_qp(struct ib_
 	if (attr_mask & IB_QP_QKEY)
 		my_qp->qkey = attr->qkey;
 
-	my_qp->state = qp_new_state;
-
 modify_qp_exit2:
 	if (squeue_locked) { /* this means: sqe -> rts */
 		spin_unlock_irqrestore(&my_qp->spinlock_s, flags);
@@ -1551,6 +1549,8 @@ modify_qp_exit1:
 int ehca_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int
attr_mask, struct ib_udata *udata)
 {
+	int ret = 0;
+
 	struct ehca_shca *shca = container_of(ibqp->device, struct
ehca_shca, ib_device);
 	struct ehca_qp *my_qp = container_of(ibqp, struct ehca_qp,
ib_qp); @@ -1597,12 +1597,18 @@ int ehca_modify_qp(struct ib_qp *ibqp, s
 				 attr->qp_state,
my_qp->init_attr.port_num, ibqp->qp_type);
 			spin_unlock_irqrestore(&sport->mod_sqp_lock,
flags);
-			return 0;
+			goto out;
 		}
 		spin_unlock_irqrestore(&sport->mod_sqp_lock, flags);
 	}
 
-	return internal_modify_qp(ibqp, attr, attr_mask, 0);
+	ret = internal_modify_qp(ibqp, attr, attr_mask, 0);
+
+out:
+	if ((ret == 0) && (attr_mask & IB_QP_STATE))
+		my_qp->state = attr->qp_state;
+
+	return ret;
 }
 
 void ehca_recover_sqp(struct ib_qp *sqp)
