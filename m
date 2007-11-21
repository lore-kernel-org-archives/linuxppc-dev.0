Return-Path: <osstklei@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D4010DDE43
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 03:44:06 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id lALGhv1O028884
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 16:43:57 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id lALGhukF2986162
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 17:43:56 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lALGhtJn013183
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 17:43:56 +0100
From: Thomas Klein <osstklei@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 2/2][2.6.24] ehea: Reworked rcv queue handling to log only
	fatal errors
Date: Wed, 21 Nov 2007 17:42:27 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200711211742.27706.osstklei@de.ibm.com>
Cc: Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
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

Prevent driver from brawly logging packet checksum errors.

Signed-off-by: Thomas Klein <tklein@de.ibm.com>

---
 drivers/net/ehea/ehea.h      |    2 +-
 drivers/net/ehea/ehea_main.c |   11 +++++------
 drivers/net/ehea/ehea_qmr.h  |    4 ++--
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ehea/ehea.h b/drivers/net/ehea/ehea.h
index 5935899..ea67615 100644
--- a/drivers/net/ehea/ehea.h
+++ b/drivers/net/ehea/ehea.h
@@ -40,7 +40,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0082"
+#define DRV_VERSION	"EHEA_0083"
 
 /* eHEA capability flags */
 #define DLPAR_PORT_ADD_REM 1
diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index d2f715d..869e160 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -410,11 +410,6 @@ static int ehea_treat_poll_error(struct ehea_port_res *pr, int rq,
 	if (cqe->status & EHEA_CQE_STAT_ERR_CRC)
 		pr->p_stats.err_frame_crc++;
 
-	if (netif_msg_rx_err(pr->port)) {
-		ehea_error("CQE Error for QP %d", pr->qp->init_attr.qp_nr);
-		ehea_dump(cqe, sizeof(*cqe), "CQE");
-	}
-
 	if (rq == 2) {
 		*processed_rq2 += 1;
 		skb = get_skb_by_index(pr->rq2_skba.arr, pr->rq2_skba.len, cqe);
@@ -426,7 +421,11 @@ static int ehea_treat_poll_error(struct ehea_port_res *pr, int rq,
 	}
 
 	if (cqe->status & EHEA_CQE_STAT_FAT_ERR_MASK) {
-		ehea_error("Critical receive error. Resetting port.");
+		if (netif_msg_rx_err(pr->port)) {
+			ehea_error("Critical receive error for QP %d. "
+				   "Resetting port.", pr->qp->init_attr.qp_nr);
+			ehea_dump(cqe, sizeof(*cqe), "CQE");
+		}
 		schedule_work(&pr->port->reset_task);
 		return 1;
 	}
diff --git a/drivers/net/ehea/ehea_qmr.h b/drivers/net/ehea/ehea_qmr.h
index 562de0e..bc62d38 100644
--- a/drivers/net/ehea/ehea_qmr.h
+++ b/drivers/net/ehea/ehea_qmr.h
@@ -145,8 +145,8 @@ struct ehea_rwqe {
 #define EHEA_CQE_VLAN_TAG_XTRACT   0x0400
 
 #define EHEA_CQE_TYPE_RQ           0x60
-#define EHEA_CQE_STAT_ERR_MASK     0x720F
-#define EHEA_CQE_STAT_FAT_ERR_MASK 0x1F
+#define EHEA_CQE_STAT_ERR_MASK     0x700F
+#define EHEA_CQE_STAT_FAT_ERR_MASK 0xF
 #define EHEA_CQE_STAT_ERR_TCP      0x4000
 #define EHEA_CQE_STAT_ERR_IP       0x2000
 #define EHEA_CQE_STAT_ERR_CRC      0x1000
-- 
1.5.2
