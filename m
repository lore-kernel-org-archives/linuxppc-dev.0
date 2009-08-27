Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6A618B7E3C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 03:35:56 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 82E46DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 03:35:55 +1000 (EST)
Date: Thu, 27 Aug 2009 21:35:54 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH 3/5] ucc_geth: Factor out MAC initialization steps into a call
Message-ID: <20090827173554.GC1580@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch factors out MAC initialization into ucc_geth_init_mac()
function that we'll use for suspend/resume.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/ucc_geth.c |   87 ++++++++++++++++++++++++++++-------------------
 1 files changed, 52 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 3b957e6..488b591 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -3413,46 +3413,25 @@ static int ucc_geth_set_mac_addr(struct net_device *dev, void *p)
 	return 0;
 }
 
-/* Called when something needs to use the ethernet device */
-/* Returns 0 for success. */
-static int ucc_geth_open(struct net_device *dev)
+static int ucc_geth_init_mac(struct ucc_geth_private *ugeth)
 {
-	struct ucc_geth_private *ugeth = netdev_priv(dev);
+	struct net_device *dev = ugeth->ndev;
 	int err;
 
-	ugeth_vdbg("%s: IN", __func__);
-
-	/* Test station address */
-	if (dev->dev_addr[0] & ENET_GROUP_ADDR) {
-		if (netif_msg_ifup(ugeth))
-			ugeth_err("%s: Multicast address used for station address"
-				  " - is this what you wanted?", __func__);
-		return -EINVAL;
-	}
-
-	err = init_phy(dev);
-	if (err) {
-		if (netif_msg_ifup(ugeth))
-			ugeth_err("%s: Cannot initialize PHY, aborting.",
-				  dev->name);
-		return err;
-	}
-
 	err = ucc_struct_init(ugeth);
 	if (err) {
 		if (netif_msg_ifup(ugeth))
-			ugeth_err("%s: Cannot configure internal struct, aborting.", dev->name);
-		goto out_err_stop;
+			ugeth_err("%s: Cannot configure internal struct, "
+				  "aborting.", dev->name);
+		goto err;
 	}
 
-	napi_enable(&ugeth->napi);
-
 	err = ucc_geth_startup(ugeth);
 	if (err) {
 		if (netif_msg_ifup(ugeth))
 			ugeth_err("%s: Cannot configure net device, aborting.",
 				  dev->name);
-		goto out_err;
+		goto err;
 	}
 
 	err = adjust_enet_interface(ugeth);
@@ -3460,7 +3439,7 @@ static int ucc_geth_open(struct net_device *dev)
 		if (netif_msg_ifup(ugeth))
 			ugeth_err("%s: Cannot configure net device, aborting.",
 				  dev->name);
-		goto out_err;
+		goto err;
 	}
 
 	/*       Set MACSTNADDR1, MACSTNADDR2                */
@@ -3474,13 +3453,51 @@ static int ucc_geth_open(struct net_device *dev)
 				   &ugeth->ug_regs->macstnaddr1,
 				   &ugeth->ug_regs->macstnaddr2);
 
-	phy_start(ugeth->phydev);
-
 	err = ugeth_enable(ugeth, COMM_DIR_RX_AND_TX);
 	if (err) {
 		if (netif_msg_ifup(ugeth))
 			ugeth_err("%s: Cannot enable net device, aborting.", dev->name);
-		goto out_err;
+		goto err;
+	}
+
+	return 0;
+err:
+	ucc_geth_stop(ugeth);
+	return err;
+}
+
+/* Called when something needs to use the ethernet device */
+/* Returns 0 for success. */
+static int ucc_geth_open(struct net_device *dev)
+{
+	struct ucc_geth_private *ugeth = netdev_priv(dev);
+	int err;
+
+	ugeth_vdbg("%s: IN", __func__);
+
+	/* Test station address */
+	if (dev->dev_addr[0] & ENET_GROUP_ADDR) {
+		if (netif_msg_ifup(ugeth))
+			ugeth_err("%s: Multicast address used for station "
+				  "address - is this what you wanted?",
+				  __func__);
+		return -EINVAL;
+	}
+
+	err = init_phy(dev);
+	if (err) {
+		if (netif_msg_ifup(ugeth))
+			ugeth_err("%s: Cannot initialize PHY, aborting.",
+				  dev->name);
+		return err;
+	}
+
+	err = ucc_geth_init_mac(ugeth);
+	if (err) {
+		if (netif_msg_ifup(ugeth))
+			ugeth_err("%s: Cannot initialize MAC, aborting.",
+				  dev->name);
+		goto err;
 	}
 
 	err = request_irq(ugeth->ug_info->uf_info.irq, ucc_geth_irq_handler,
@@ -3489,16 +3506,16 @@ static int ucc_geth_open(struct net_device *dev)
 		if (netif_msg_ifup(ugeth))
 			ugeth_err("%s: Cannot get IRQ for net device, aborting.",
 				  dev->name);
-		goto out_err;
+		goto err;
 	}
 
+	phy_start(ugeth->phydev);
+	napi_enable(&ugeth->napi);
 	netif_start_queue(dev);
 
 	return err;
 
-out_err:
-	napi_disable(&ugeth->napi);
-out_err_stop:
+err:
 	ucc_geth_stop(ugeth);
 	return err;
 }
-- 
1.6.3.3
