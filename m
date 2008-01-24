Return-Path: <fenkes@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7D0FCDDE09
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 03:59:34 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id m0OGxAg3088752
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 16:59:10 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m0OGxAAp1179694
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 17:59:10 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m0OGx9s9006096
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 17:59:10 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH] IB/ehca: Prevent sending UD packets to QP0
MIME-Version: 1.0
Date: Thu, 24 Jan 2008 17:59:08 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801241759.09065.fenkes@de.ibm.com>
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

IB spec doesn't allow packets to QP0 sent on any other VL than VL15.
Hardware doesn't filter those packets on the send side, so we need to do
this in the driver and firmware.

As eHCA doesn't support QP0, we can just filter out all traffic going to
QP0, regardless of SL or VL.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_reqs.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_reqs.c b/drivers/infiniband/hw/ehca/ehca_reqs.c
index 3aacc8c..2ce8cff 100644
--- a/drivers/infiniband/hw/ehca/ehca_reqs.c
+++ b/drivers/infiniband/hw/ehca/ehca_reqs.c
@@ -209,6 +209,10 @@ static inline int ehca_write_swqe(struct ehca_qp *qp,
 			ehca_gen_err("wr.ud.ah is NULL. qp=%p", qp);
 			return -EINVAL;
 		}
+		if (unlikely(send_wr->wr.ud.remote_qpn == 0)) {
+			ehca_gen_err("dest QP# is 0. qp=%x", qp->real_qp_num);
+			return -EINVAL;
+		}
 		my_av = container_of(send_wr->wr.ud.ah, struct ehca_av, ib_ah);
 		wqe_p->u.ud_av.ud_av = my_av->av;
 
-- 
1.5.2
