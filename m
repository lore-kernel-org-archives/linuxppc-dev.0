Return-Path: <jonsmirl@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.186])
	by ozlabs.org (Postfix) with ESMTP id D5096DDDEC
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Oct 2008 08:41:02 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so444132rnf.16
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 14:41:00 -0700 (PDT)
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH] Implement polling for 5200FEC to make netconsole work.
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
Date: Sat, 18 Oct 2008 17:40:59 -0400
Message-ID: <20081018214059.1506.28013.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Implement polling for 5200FEC to make netconsole work. Tested on Phytec pcm030 and Efika.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 drivers/net/fec_mpc52xx.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
index 4e4f683..aec3b97 100644
--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -401,6 +401,21 @@ static int mpc52xx_fec_hard_start_xmit(struct sk_buff *skb, struct net_device *d
 	return 0;
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void mpc52xx_fec_poll_controller(struct net_device *dev)
+{
+	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
+
+	disable_irq(priv->t_irq);
+	mpc52xx_fec_tx_interrupt(priv->t_irq, dev);
+	enable_irq(priv->t_irq);
+	disable_irq(priv->r_irq);
+	mpc52xx_fec_rx_interrupt(priv->r_irq, dev);
+	enable_irq(priv->r_irq);
+}
+#endif
+
+
 /* This handles BestComm transmit task interrupts
  */
 static irqreturn_t mpc52xx_fec_tx_interrupt(int irq, void *dev_id)
@@ -926,6 +941,9 @@ mpc52xx_fec_probe(struct of_device *op, const struct of_device_id *match)
 	ndev->tx_timeout	= mpc52xx_fec_tx_timeout;
 	ndev->watchdog_timeo	= FEC_WATCHDOG_TIMEOUT;
 	ndev->base_addr		= mem.start;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	ndev->poll_controller = mpc52xx_fec_poll_controller;
+#endif
 
 	priv->t_irq = priv->r_irq = ndev->irq = NO_IRQ; /* IRQ are free for now */
 
