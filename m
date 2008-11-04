Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 92F19DDE07
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Nov 2008 01:56:08 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mA4EtGFK014951
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Nov 2008 07:55:16 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mA4Etvkt062516
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Nov 2008 07:56:01 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mA4EtqAZ007773
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Nov 2008 07:55:52 -0700
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	Roland Dreier <rolandd@cisco.com>, LKML <linux-kernel@vger.kernel.org>,
	"OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH] IB/ehca: remove reference to the QP in case of port
	activation failure
Date: Tue, 4 Nov 2008 15:54:43 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200811041554.45560.ossrosch@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, stefan.roscher@de.ibm.com, alexschm@de.ibm.com,
	raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If the initialization of a special QP (e.g. AQP1) fails due to a software timeout,
we have to remove the reference to that special QP struct from the port struct
preventing the driver to access the QP, since it will be/has been destroyed
by the caller, ie in this case ib_mad.
This patch will apply cleanly on top of 2.6.28 git tree.

Signed-off-by: Stefan Roscher <stefan.roscher@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_irq.c |    7 +++++--
 drivers/infiniband/hw/ehca/ehca_qp.c  |    5 +++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_irq.c b/drivers/infiniband/hw/ehca/ehca_irq.c
index cb55be0..9e43459 100644
--- a/drivers/infiniband/hw/ehca/ehca_irq.c
+++ b/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -370,6 +370,10 @@ static void parse_ec(struct ehca_shca *shca, u64 eqe)
 	switch (ec) {
 	case 0x30: /* port availability change */
 		if (EHCA_BMASK_GET(NEQE_PORT_AVAILABILITY, eqe)) {
+			/* only for autodetect mode important */
+			if (ehca_nr_ports >= 0)
+				break;
+
 			int suppress_event;
 			/* replay modify_qp for sqps */
 			spin_lock_irqsave(&sport->mod_sqp_lock, flags);
@@ -387,8 +391,7 @@ static void parse_ec(struct ehca_shca *shca, u64 eqe)
 			sport->port_state = IB_PORT_ACTIVE;
 			dispatch_port_event(shca, port, IB_EVENT_PORT_ACTIVE,
 					    "is active");
-			ehca_query_sma_attr(shca, port,
-					    &sport->saved_attr);
+			ehca_query_sma_attr(shca, port, &sport->saved_attr);
 		} else {
 			sport->port_state = IB_PORT_DOWN;
 			dispatch_port_event(shca, port, IB_EVENT_PORT_ERR,
diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index 4d54b9f..9e05ee2 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -860,6 +860,11 @@ static struct ehca_qp *internal_create_qp(
 	if (qp_type == IB_QPT_GSI) {
 		h_ret = ehca_define_sqp(shca, my_qp, init_attr);
 		if (h_ret != H_SUCCESS) {
+			kfree(my_qp->mod_qp_parm);
+			my_qp->mod_qp_parm = NULL;
+			/* the QP pointer is no longer valid */
+			shca->sport[init_attr->port_num - 1].ibqp_sqp[qp_type] =
+				NULL;
 			ret = ehca2ib_return_code(h_ret);
 			goto create_qp_exit6;
 		}
-- 
1.5.5
