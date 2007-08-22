Return-Path: <ossthema@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4915EDE09F
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 00:53:51 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l7MErlWh130350
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 14:53:47 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l7MErkaX2003106
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 16:53:46 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7MErkDk028110
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 16:53:46 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH 3/4] ehea: fix queue destructor
Date: Wed, 22 Aug 2007 16:21:28 +0200
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708221621.28487.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Includes hcp_epas_dtor in eq/cq/qp destructors to unmap
HW register.

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>

---
 drivers/net/ehea/ehea_qmr.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ehea/ehea_qmr.c b/drivers/net/ehea/ehea_qmr.c
index a36fa6c..c82e245 100644
--- a/drivers/net/ehea/ehea_qmr.c
+++ b/drivers/net/ehea/ehea_qmr.c
@@ -235,6 +235,8 @@ int ehea_destroy_cq(struct ehea_cq *cq)
 	if (!cq)
 		return 0;
 
+	hcp_epas_dtor(&cq->epas);
+
 	if ((hret = ehea_destroy_cq_res(cq, NORMAL_FREE)) == H_R_STATE) {
 		ehea_error_data(cq->adapter, cq->fw_handle);
 		hret = ehea_destroy_cq_res(cq, FORCE_FREE);
@@ -361,6 +363,8 @@ int ehea_destroy_eq(struct ehea_eq *eq)
 	if (!eq)
 		return 0;
 
+	hcp_epas_dtor(&eq->epas);
+
 	if ((hret = ehea_destroy_eq_res(eq, NORMAL_FREE)) == H_R_STATE) {
 		ehea_error_data(eq->adapter, eq->fw_handle);
 		hret = ehea_destroy_eq_res(eq, FORCE_FREE);
@@ -541,6 +545,8 @@ int ehea_destroy_qp(struct ehea_qp *qp)
 	if (!qp)
 		return 0;
 
+	hcp_epas_dtor(&qp->epas);
+
 	if ((hret = ehea_destroy_qp_res(qp, NORMAL_FREE)) == H_R_STATE) {
 		ehea_error_data(qp->adapter, qp->fw_handle);
 		hret = ehea_destroy_qp_res(qp, FORCE_FREE);
-- 
1.5.2
