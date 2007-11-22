Return-Path: <fenkes@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 565F6DDE17
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 21:26:33 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id lAMAQSs2276794
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 10:26:28 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id lAMAQScq2752764
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 11:26:28 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lAMAQRZY021644
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 11:26:28 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH] IB/ehca: Fix static rate regression
MIME-Version: 1.0
Date: Thu, 22 Nov 2007 12:26:26 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711221126.27465.fenkes@de.ibm.com>
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

Wrong choice of port number caused modify_qp() to fail -- fixed.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
Please apply this for 2.6.24-rc4 as it fixes a regression introduced in rc3.
Thanks!

 drivers/infiniband/hw/ehca/ehca_qp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index 2e3e654..dd12668 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -1203,7 +1203,7 @@ static int internal_modify_qp(struct ib_qp *ibqp,
 		mqpcb->service_level = attr->ah_attr.sl;
 		update_mask |= EHCA_BMASK_SET(MQPCB_MASK_SERVICE_LEVEL, 1);
 
-		if (ehca_calc_ipd(shca, my_qp->init_attr.port_num,
+		if (ehca_calc_ipd(shca, mqpcb->prim_phys_port,
 				  attr->ah_attr.static_rate,
 				  &mqpcb->max_static_rate)) {
 			ret = -EINVAL;
@@ -1302,7 +1302,7 @@ static int internal_modify_qp(struct ib_qp *ibqp,
 		mqpcb->source_path_bits_al = attr->alt_ah_attr.src_path_bits;
 		mqpcb->service_level_al = attr->alt_ah_attr.sl;
 
-		if (ehca_calc_ipd(shca, my_qp->init_attr.port_num,
+		if (ehca_calc_ipd(shca, mqpcb->alt_phys_port,
 				  attr->alt_ah_attr.static_rate,
 				  &mqpcb->max_static_rate_al)) {
 			ret = -EINVAL;
-- 
1.5.2
