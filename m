Return-Path: <osstklei@de.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [195.212.29.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A283CDDDCA
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 03:40:00 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.8/8.13.8) with ESMTP id lALGdsqM026498
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 16:39:54 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id lALGdsdd2629658
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 16:39:54 GMT
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lALGdci7006571
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 16:39:38 GMT
From: Thomas Klein <osstklei@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 1/2][2.6.24] ehea: Improve tx packets counting
Date: Wed, 21 Nov 2007 17:37:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200711211737.58789.osstklei@de.ibm.com>
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

Using own tx_packets counter instead of firmware counters.

Signed-off-by: Thomas Klein <tklein@de.ibm.com>

---
 drivers/net/ehea/ehea.h      |    2 +-
 drivers/net/ehea/ehea_main.c |    9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ehea/ehea.h b/drivers/net/ehea/ehea.h
index f78e5bf..5935899 100644
--- a/drivers/net/ehea/ehea.h
+++ b/drivers/net/ehea/ehea.h
@@ -40,7 +40,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0080"
+#define DRV_VERSION	"EHEA_0082"
 
 /* eHEA capability flags */
 #define DLPAR_PORT_ADD_REM 1
diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index f0319f1..d2f715d 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -136,7 +136,7 @@ static struct net_device_stats *ehea_get_stats(struct net_device *dev)
 	struct ehea_port *port = netdev_priv(dev);
 	struct net_device_stats *stats = &port->stats;
 	struct hcp_ehea_port_cb2 *cb2;
-	u64 hret, rx_packets;
+	u64 hret, rx_packets, tx_packets;
 	int i;
 
 	memset(stats, 0, sizeof(*stats));
@@ -162,7 +162,11 @@ static struct net_device_stats *ehea_get_stats(struct net_device *dev)
 	for (i = 0; i < port->num_def_qps; i++)
 		rx_packets += port->port_res[i].rx_packets;
 
-	stats->tx_packets = cb2->txucp + cb2->txmcp + cb2->txbcp;
+	tx_packets = 0;
+	for (i = 0; i < port->num_def_qps + port->num_add_tx_qps; i++)
+		tx_packets += port->port_res[i].tx_packets;
+
+	stats->tx_packets = tx_packets;
 	stats->multicast = cb2->rxmcp;
 	stats->rx_errors = cb2->rxuerr;
 	stats->rx_bytes = cb2->rxo;
@@ -2000,6 +2004,7 @@ static int ehea_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	ehea_post_swqe(pr->qp, swqe);
+	pr->tx_packets++;
 
 	if (unlikely(atomic_read(&pr->swqe_avail) <= 1)) {
 		spin_lock_irqsave(&pr->netif_queue, flags);
-- 
1.5.2
