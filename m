Return-Path: <ossthema@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E53FADDE37
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 00:33:40 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6NEXZGG279160
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 14:33:35 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6NEXRXh2203692
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 16:33:35 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6NEXAGs002095
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 16:33:10 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] eHEA: net_poll support
Date: Mon, 23 Jul 2007 16:05:03 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707231605.03459.ossthema@de.ibm.com>
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

net_poll support for eHEA added

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
---


 drivers/net/ehea/ehea.h      |    2 +-
 drivers/net/ehea/ehea_main.c |   22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ehea/ehea.h b/drivers/net/ehea/ehea.h
index 489c8b2..8ee2c2c 100644
--- a/drivers/net/ehea/ehea.h
+++ b/drivers/net/ehea/ehea.h
@@ -39,7 +39,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0071"
+#define DRV_VERSION	"EHEA_0072"
 
 /* eHEA capability flags */
 #define DLPAR_PORT_ADD_REM 1
diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index 4c70a93..58702f5 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -589,6 +589,23 @@ static int ehea_poll(struct net_device *dev, int *budget)
 	return 1;
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void ehea_netpoll(struct net_device *dev)
+{
+	struct ehea_port *port = netdev_priv(dev);
+
+	netif_rx_schedule(port->port_res[0].d_netdev);
+}
+#endif
+
+static int ehea_poll_firstqueue(struct net_device *dev, int *budget)
+{
+	struct ehea_port *port = netdev_priv(dev);
+	struct net_device *d_dev = port->port_res[0].d_netdev;
+
+	return ehea_poll(d_dev, budget);
+}
+
 static irqreturn_t ehea_recv_irq_handler(int irq, void *param)
 {
 	struct ehea_port_res *pr = param;
@@ -2626,7 +2643,10 @@ struct ehea_port *ehea_setup_single_port(struct ehea_adapter *adapter,
 	memcpy(dev->dev_addr, &port->mac_addr, ETH_ALEN);
 
 	dev->open = ehea_open;
-	dev->poll = ehea_poll;
+	dev->poll = ehea_poll_firstqueue;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = ehea_netpoll;
+#endif
 	dev->weight = 64;
 	dev->stop = ehea_stop;
 	dev->hard_start_xmit = ehea_start_xmit;
-- 
1.5.2
