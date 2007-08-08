Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D6885DDE3B
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 04:39:55 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78IfA6I024583
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:41:10 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78IdqhN523360
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:39:52 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78IdpSe014633
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:39:51 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openib-general@openib.org
Subject: [PATCH 2/7] IB/ehca: Ensure non-existing queues aren't made small
	queues
Date: Wed, 8 Aug 2007 20:39:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708082039.50878.ossrosch@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, raisch@de.ibm.com,
	"\"Hoang-Nam Nguyen\" @dyn-9-152-249-53"
	<Hoang-Nam.Nguyen@d01av02.pok.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stefan Roscher <stefan.roscher@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_qp.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index cfa83fa..13b61c3 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -600,10 +600,12 @@ static struct ehca_qp *internal_create_qp(
 	parms.rqueue.max_sge = max_recv_sge;
 
 	if (EHCA_BMASK_GET(HCA_CAP_MINI_QP, shca->hca_cap)) {
-		ehca_determine_small_queue(
-			&parms.squeue, max_send_sge, is_llqp);
-		ehca_determine_small_queue(
-			&parms.rqueue, max_recv_sge, is_llqp);
+		if (HAS_SQ(my_qp))
+			ehca_determine_small_queue(
+				&parms.squeue, max_send_sge, is_llqp);
+		if (HAS_RQ(my_qp))
+			ehca_determine_small_queue(
+				&parms.rqueue, max_recv_sge, is_llqp);
 		parms.qp_storage =
 			(parms.squeue.is_small || parms.rqueue.is_small);
 	}
-- 
1.5.2
