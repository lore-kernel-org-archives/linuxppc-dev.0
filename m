Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id CADE6DDF0E
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 00:22:51 +1100 (EST)
Date: Fri, 1 Feb 2008 16:22:54 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Li Yang <leoli@freescale.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH for 2.6.25 2/2] [NET] ucc_geth: add support for netpoll
Message-ID: <20080201132254.GB1790@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds netpoll support for the QE UCC Gigabit Ethernet
driver. Tested using netconsole and KGDBoE.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Just resending this.

 drivers/net/ucc_geth.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index e41da46..fba0811 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -3666,6 +3666,23 @@ static irqreturn_t ucc_geth_irq_handler(int irq, void *info)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+/*
+ * Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+ */
+static void ucc_netpoll(struct net_device *dev)
+{
+	struct ucc_geth_private *ugeth = netdev_priv(dev);
+	int irq = ugeth->ug_info->uf_info.irq;
+
+	disable_irq(irq);
+	ucc_geth_irq_handler(irq, dev);
+	enable_irq(irq);
+}
+#endif /* CONFIG_NET_POLL_CONTROLLER */
+
 /* Called when something needs to use the ethernet device */
 /* Returns 0 for success. */
 static int ucc_geth_open(struct net_device *dev)
@@ -4008,6 +4025,9 @@ static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *ma
 #ifdef CONFIG_UGETH_NAPI
 	netif_napi_add(dev, &ugeth->napi, ucc_geth_poll, UCC_GETH_DEV_WEIGHT);
 #endif				/* CONFIG_UGETH_NAPI */
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = ucc_netpoll;
+#endif
 	dev->stop = ucc_geth_close;
 //    dev->change_mtu = ucc_geth_change_mtu;
 	dev->mtu = 1500;
-- 
1.5.2.2
