Return-Path: <henk.stegeman@gmail.com>
Received: from mail-bw0-f216.google.com (mail-bw0-f216.google.com
	[209.85.218.216]) by ozlabs.org (Postfix) with ESMTP id 55496DDE0A
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 21:41:16 +1100 (EST)
Received: by bwz12 with SMTP id 12so11058680bwz.9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 02:41:14 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 18 Feb 2009 11:41:14 +0100
Message-ID: <ae4f76fd0902180241s28458450hd91ebf8da94ceb53@mail.gmail.com>
Subject: net_device_ops support in bridging and fec_mpc52xx.c
From: Henk Stegeman <henk.stegeman@gmail.com>
To: linuxppc-dev@ozlabs.org, bridge@osdl.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I discovered the hard way that because linux bridging uses
net_device_ops, bridging only works with network drivers that publish
their device operations trough net_device_ops.

In my case running:

brctl addif br0 eth0 (where eth0 fec_mpc52xx.c did not yet support
net_device_ops) gave me a:

Unable to handle kernel paging request...

After changing fec_mpc52xx.c to support net_device_ops the problem was fixed.

If possible some kind of detection in the bridging software is i think
mostly appreciated for early detection of this problem, as it is
pretty hard to relate the error message to a not updated driver.

cheers,

Henk

diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
index cd8e98b..a2841eb 100644
--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -888,6 +888,22 @@ static int mpc52xx_fec_ioctl(struct net_device
*dev, struct ifreq *rq, int cmd)
 /* ======================================================================== */
 /* OF Driver                                                                */
 /* ======================================================================== */
+static const struct net_device_ops mpc52xx_fec_netdev_ops = {
+       .ndo_open               = mpc52xx_fec_open,
+       .ndo_stop               = mpc52xx_fec_close,
+       .ndo_start_xmit         = mpc52xx_fec_hard_start_xmit,
+       .ndo_tx_timeout         = mpc52xx_fec_tx_timeout,
+       .ndo_get_stats          = mpc52xx_fec_get_stats,
+       .ndo_set_multicast_list = mpc52xx_fec_set_multicast_list,
+       .ndo_validate_addr      = eth_validate_addr,
+       .ndo_set_mac_address    = mpc52xx_fec_set_mac_address,
+       .ndo_do_ioctl           = mpc52xx_fec_ioctl,
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+       .ndo_poll_controller     = mpc52xx_fec_poll_controller,
+#endif
+};
+

 static int __devinit
 mpc52xx_fec_probe(struct of_device *op, const struct of_device_id *match)
@@ -929,20 +945,7 @@ mpc52xx_fec_probe(struct of_device *op, const
struct of_device_id *match)
 		return -EBUSY;

 	/* Init ether ndev with what we have */
-	ndev->open		= mpc52xx_fec_open;
-	ndev->stop		= mpc52xx_fec_close;
-	ndev->hard_start_xmit	= mpc52xx_fec_hard_start_xmit;
-	ndev->do_ioctl		= mpc52xx_fec_ioctl;
-	ndev->ethtool_ops	= &mpc52xx_fec_ethtool_ops;
-	ndev->get_stats		= mpc52xx_fec_get_stats;
-	ndev->set_mac_address	= mpc52xx_fec_set_mac_address;
-	ndev->set_multicast_list = mpc52xx_fec_set_multicast_list;
-	ndev->tx_timeout	= mpc52xx_fec_tx_timeout;
-	ndev->watchdog_timeo	= FEC_WATCHDOG_TIMEOUT;
-	ndev->base_addr		= mem.start;
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	ndev->poll_controller = mpc52xx_fec_poll_controller;
-#endif
+	ndev->netdev_ops = &mpc52xx_fec_netdev_ops;

 	priv->t_irq = priv->r_irq = ndev->irq = NO_IRQ; /* IRQ are free for now */
