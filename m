Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C12A4DDF09
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 22:20:42 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id m91CJkja638174
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 12:19:46 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m91CJkUq2629782
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 14:19:46 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m91CJhgv021619
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 14:19:43 +0200
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, general@lists.openfabrics.org
Subject: [PATCH 1/1] IB/ehca: Disallow creating UC QP with SRQ
Date: Wed, 1 Oct 2008 13:06:31 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200810011306.31544.hnguyen@linux.vnet.ibm.com>
Cc: micfaath@de.ibm.com, raisch@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

IB/ehca: Disallow creating QP for UC with SRQ

This patch prevents a UC QP to be created with SRQ, since current
firmware does not support this feature.

Signed-off-by: Michael Faath <micfaath@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_qp.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index b6bcee0..46897cd 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -460,6 +460,12 @@ static struct ehca_qp *internal_create_qp(
 		struct ehca_qp *my_srq =
 			container_of(init_attr->srq, struct ehca_qp, ib_srq);
 
+		if (qp_type == IB_QPT_UC) {
+			ehca_err(pd->device, "UC with SRQ not supported");
+			atomic_dec(&shca->num_qps);
+			return ERR_PTR(-EINVAL);
+		}
+
 		has_srq = 1;
 		parms.ext_type = EQPT_SRQBASE;
 		parms.srq_qpn = my_srq->real_qp_num;
-- 
1.5.5
