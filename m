Return-Path: <alex.bou9@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.228])
	by ozlabs.org (Postfix) with ESMTP id 02E8FDDF29
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 06:36:40 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 68so3973248wra.13
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 11:36:38 -0800 (PST)
Message-ID: <d5f62df20802111136u5b08459bj45a577f43ff88cd4@mail.gmail.com>
Date: Mon, 11 Feb 2008 14:36:37 -0500
From: "Alex Bounine" <alex.bou9@gmail.com>
To: jgarzik@pobox.com, netdev@vger.kernel.org
Subject: [PATCH 5/5 v3] Tsi108_eth: Add ethtool support
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add ethtool support to tsi108_eth network driver.

Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
---

diff -pNur linux-2.6.24/drivers/net/tsi108_eth.c
linux-2.6.24-fix/drivers/net/tsi108_eth.c
--- linux-2.6.24/drivers/net/tsi108_eth.c	2008-02-06 17:10:53.000000000 -0500
+++ linux-2.6.24-fix/drivers/net/tsi108_eth.c	2008-02-06
18:09:43.000000000 -0500
@@ -36,6 +36,7 @@
 #include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -1519,12 +1520,46 @@ static void tsi108_init_mac(struct net_d
 	TSI_WRITE(TSI108_EC_INTMASK, ~0);
 }

+static int tsi108_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	struct tsi108_prv_data *data = netdev_priv(dev);
+	unsigned long flags;
+	int rc;
+	
+	spin_lock_irqsave(&data->txlock, flags);
+	rc = mii_ethtool_gset(&data->mii_if, cmd);
+	spin_unlock_irqrestore(&data->txlock, flags);
+
+	return rc;
+}
+
+static int tsi108_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	struct tsi108_prv_data *data = netdev_priv(dev);
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(&data->txlock, flags);
+	rc = mii_ethtool_sset(&data->mii_if, cmd);
+	spin_unlock_irqrestore(&data->txlock, flags);
+	
+	return rc;
+}
+
 static int tsi108_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct tsi108_prv_data *data = netdev_priv(dev);
+	if (!netif_running(dev))
+		return -EINVAL;
 	return generic_mii_ioctl(&data->mii_if, if_mii(rq), cmd, NULL);
 }

+static const struct ethtool_ops tsi108_ethtool_ops = {
+	.get_link 	= ethtool_op_get_link,
+	.get_settings	= tsi108_get_settings,
+	.set_settings	= tsi108_set_settings,
+};
+
 static int
 tsi108_init_one(struct platform_device *pdev)
 {
@@ -1589,6 +1624,7 @@ tsi108_init_one(struct platform_device *
 	dev->get_stats = tsi108_get_stats;
 	netif_napi_add(dev, &data->napi, tsi108_poll, 64);
 	dev->do_ioctl = tsi108_do_ioctl;
+	dev->ethtool_ops = &tsi108_ethtool_ops;

 	/* Apparently, the Linux networking code won't use scatter-gather
 	 * if the hardware doesn't do checksums.  However, it's faster
