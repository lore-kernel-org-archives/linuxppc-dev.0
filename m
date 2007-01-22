Return-Path: <osstklei@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 48C8CDDE9F
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 22:54:57 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l0MBspn2137012
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 11:54:51 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0MBspNU2789546
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 12:54:51 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0MBso11016864
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 12:54:51 +0100
From: Thomas Klein <osstklei@de.ibm.com>
Subject: [PATCH 2.6.20-rc5 6/7] ehea: Added logging off associated errors
Date: Mon, 22 Jan 2007 12:54:50 +0100
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701221254.50615.osstklei@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Stefan Roscher <roscher@de.ibm.com>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <ossrosch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added logging of error events associated with a specific queue pair

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---


 drivers/net/ehea/ehea_main.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nurp -X dontdiff linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c	2007-01-19 14:25:38.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2007-01-19 14:31:34.000000000 +0100
@@ -558,12 +558,12 @@ static irqreturn_t ehea_qp_aff_irq_handl
 	u32 qp_token;
 
 	eqe = ehea_poll_eq(port->qp_eq);
-	ehea_debug("eqe=%p", eqe);
+
 	while (eqe) {
-		ehea_debug("*eqe=%lx", *(u64*)eqe);
-		eqe = ehea_poll_eq(port->qp_eq);
 		qp_token = EHEA_BMASK_GET(EHEA_EQE_QP_TOKEN, eqe->entry);
-		ehea_debug("next eqe=%p", eqe);
+		ehea_error("QP aff_err: entry=0x%lx, token=0x%x",
+			   eqe->entry, qp_token);
+		eqe = ehea_poll_eq(port->qp_eq);
 	}
 
 	return IRQ_HANDLED;
