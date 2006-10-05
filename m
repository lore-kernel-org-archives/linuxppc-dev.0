Return-Path: <ossthema@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A2E1667DCC
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 01:40:09 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id k95Fe48E019734
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Oct 2006 15:40:04 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k95FgGIB2949358
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Oct 2006 17:42:16 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k95Fe3rS018283
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Oct 2006 17:40:04 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH 2.6.19-rc1 2/2] ehea: fix port state notification,
	default queue sizes
Date: Thu, 5 Oct 2006 16:53:14 +0200
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200610051653.15186.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch includes a bug fix for the port state notification
and fixes the default queue sizes.


Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
---
 drivers/net/ehea/ehea.h      |   13 +++++++------
 drivers/net/ehea/ehea_main.c |    6 +++---
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ehea/ehea.h b/drivers/net/ehea/ehea.h
index 23b451a..b40724f 100644
--- a/drivers/net/ehea/ehea.h
+++ b/drivers/net/ehea/ehea.h
@@ -39,7 +39,7 @@ #include <asm/abs_addr.h>
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0028"
+#define DRV_VERSION	"EHEA_0034"
 
 #define EHEA_MSG_DEFAULT (NETIF_MSG_LINK | NETIF_MSG_TIMER \
 	| NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
@@ -50,6 +50,7 @@ #define EHEA_MAX_ENTRIES_RQ3 16383
 #define EHEA_MAX_ENTRIES_SQ  32767
 #define EHEA_MIN_ENTRIES_QP  127
 
+#define EHEA_SMALL_QUEUES
 #define EHEA_NUM_TX_QP 1
 
 #ifdef EHEA_SMALL_QUEUES
@@ -59,11 +60,11 @@ #define EHEA_DEF_ENTRIES_RQ1    4095
 #define EHEA_DEF_ENTRIES_RQ2    1023
 #define EHEA_DEF_ENTRIES_RQ3    1023
 #else
-#define EHEA_MAX_CQE_COUNT     32000
-#define EHEA_DEF_ENTRIES_SQ    16000
-#define EHEA_DEF_ENTRIES_RQ1   32080
-#define EHEA_DEF_ENTRIES_RQ2    4020
-#define EHEA_DEF_ENTRIES_RQ3    4020
+#define EHEA_MAX_CQE_COUNT      4080
+#define EHEA_DEF_ENTRIES_SQ     4080
+#define EHEA_DEF_ENTRIES_RQ1    8160
+#define EHEA_DEF_ENTRIES_RQ2    2040
+#define EHEA_DEF_ENTRIES_RQ3    2040
 #endif
 
 #define EHEA_MAX_ENTRIES_EQ 20
diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index 263d1c5..0edb2f8 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -769,7 +769,7 @@ static void ehea_parse_eqe(struct ehea_a
 		if (EHEA_BMASK_GET(NEQE_PORT_UP, eqe)) {
 			if (!netif_carrier_ok(port->netdev)) {
 				ret = ehea_sense_port_attr(
-					adapter->port[portnum]);
+					port);
 				if (ret) {
 					ehea_error("failed resensing port "
 						   "attributes");
@@ -821,7 +821,7 @@ static void ehea_parse_eqe(struct ehea_a
 		netif_stop_queue(port->netdev);
 		break;
 	default:
-		ehea_error("unknown event code %x", ec);
+		ehea_error("unknown event code %x, eqe=0x%lX", ec, eqe);
 		break;
 	}
 }
@@ -1845,7 +1845,7 @@ static int ehea_start_xmit(struct sk_buf
 
 	if (netif_msg_tx_queued(port)) {
 		ehea_info("post swqe on QP %d", pr->qp->init_attr.qp_nr);
-		ehea_dump(swqe, sizeof(*swqe), "swqe");
+		ehea_dump(swqe, 512, "swqe");
 	}
 
 	ehea_post_swqe(pr->qp, swqe);
