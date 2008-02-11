Return-Path: <alex.bou9@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.236])
	by ozlabs.org (Postfix) with ESMTP id 27100DDEE0
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 06:36:13 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so4679025wxd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 11:36:13 -0800 (PST)
Message-ID: <d5f62df20802111136p3ba13f8cudae073a178b77aa9@mail.gmail.com>
Date: Mon, 11 Feb 2008 14:36:12 -0500
From: "Alex Bounine" <alex.bou9@gmail.com>
To: jgarzik@pobox.com, netdev@vger.kernel.org
Subject: [PATCH 4/5 v3] Tsi108_eth: fix link recovery after disconnect
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

Bug fix for tsi108_eth network driver.
This patch fixes a problem with link recovery after connection was lost.

Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
---

diff -pNur linux-2.6.24/drivers/net/tsi108_eth.c
linux-2.6.24-fix/drivers/net/tsi108_eth.c
--- linux-2.6.24/drivers/net/tsi108_eth.c	2008-02-06 16:16:00.000000000 -0500
+++ linux-2.6.24-fix/drivers/net/tsi108_eth.c	2008-02-06
16:57:41.000000000 -0500
@@ -338,22 +338,21 @@ static void tsi108_check_phy(struct net_

 			TSI_WRITE(TSI108_MAC_CFG2, mac_cfg2_reg);
 			TSI_WRITE(TSI108_EC_PORTCTRL, portctrl_reg);
+		}

-			if (data->link_up == 0) {
-				/* The manual says it can take 3-4 usecs for the speed change
-				 * to take effect.
-				 */
-				udelay(5);
-
-				spin_lock(&data->txlock);
-				if (is_valid_ether_addr(dev->dev_addr) && data->txfree)
-					netif_wake_queue(dev);
+		if (data->link_up == 0) {
+			/* The manual says it can take 3-4 usecs for the speed change
+			 * to take effect.
+			 */
+			udelay(5);

-				data->link_up = 1;
-				spin_unlock(&data->txlock);
-			}
-		}
+			spin_lock(&data->txlock);
+			if (is_valid_ether_addr(dev->dev_addr) && data->txfree)
+				netif_wake_queue(dev);

+			data->link_up = 1;
+			spin_unlock(&data->txlock);
+		}
 	} else {
 		if (data->link_up == 1) {
 			netif_stop_queue(dev);
@@ -1267,12 +1266,11 @@ static void tsi108_init_phy(struct net_d
 	 * PHY_STAT register before the link up status bit is set.
 	 */

-	data->link_up = 1;
+	data->link_up = 0;

 	while (!((phyval = tsi108_read_mii(data, MII_BMSR)) &
 		 BMSR_LSTATUS)) {
 		if (i++ > (MII_READ_DELAY / 10)) {
-			data->link_up = 0;
 			break;
 		}
 		spin_unlock_irqrestore(&phy_lock, flags);
