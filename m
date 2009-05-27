Return-Path: <Kexin.Hao@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 2563FDDFE7
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 11:49:03 +1000 (EST)
Subject: [PATCH] net/ucc_geth: allow to set mac address on running device
From: Kevin Hao <kexin.hao@windriver.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 27 May 2009 09:48:56 +0800
Message-Id: <1243388936.13410.4.camel@kevin>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, leoli@freescale.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Inspired by the patch for 8139too (bda6a15a).

Currently we can't set mac address on a running ucc_geth device.
But this is needed when you use this device as a bonding slave in
bonding device in balance-alb mode. So add this feature for ucc_geth
device.

Signed-off-by: Kevin Hao <kexin.hao@windriver.com>
---
 drivers/net/ucc_geth.c |   33 ++++++++++++++++++++++++++++++++-
 1 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 9dd16c9..3c595d7 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -3339,6 +3339,37 @@ static void ucc_netpoll(struct net_device *dev)
 }
 #endif /* CONFIG_NET_POLL_CONTROLLER */
 
+static int ucc_geth_set_mac_addr(struct net_device *dev, void *p)
+{
+	struct ucc_geth_private *ugeth = netdev_priv(dev);
+	struct sockaddr *addr = p;
+
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
+
+	/*
+	 * If device is not running, we will set mac addr register
+	 * when opening the device.
+	 */
+	if (!netif_running(dev))
+		return 0;
+
+	spin_lock_irq(&ugeth->lock);
+	init_mac_station_addr_regs(dev->dev_addr[0],
+				   dev->dev_addr[1],
+				   dev->dev_addr[2],
+				   dev->dev_addr[3],
+				   dev->dev_addr[4],
+				   dev->dev_addr[5],
+				   &ugeth->ug_regs->macstnaddr1,
+				   &ugeth->ug_regs->macstnaddr2);
+	spin_unlock_irq(&ugeth->lock);
+
+	return 0;
+}
+
 /* Called when something needs to use the ethernet device */
 /* Returns 0 for success. */
 static int ucc_geth_open(struct net_device *dev)
@@ -3515,7 +3546,7 @@ static const struct net_device_ops ucc_geth_netdev_ops = {
 	.ndo_stop		= ucc_geth_close,
 	.ndo_start_xmit		= ucc_geth_start_xmit,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_mac_address	= eth_mac_addr,
+	.ndo_set_mac_address	= ucc_geth_set_mac_addr,
 	.ndo_change_mtu		= eth_change_mtu,
 	.ndo_set_multicast_list	= ucc_geth_set_multi,
 	.ndo_tx_timeout		= ucc_geth_timeout,
-- 
1.6.0.4.771.gef3b3
