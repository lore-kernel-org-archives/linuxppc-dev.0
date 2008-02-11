Return-Path: <Alexandre.Bounine@tundra.com>
Received: from mx2.tundra.com (mail2.tundra.com [142.46.200.162])
	by ozlabs.org (Postfix) with ESMTP id B1BC0DE081
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 03:32:37 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH 4/5 v2] Tsi108_eth: fix link recovery after disconnect
Date: Mon, 11 Feb 2008 11:32:35 -0500
Message-ID: <1B5F013528140F45B5C671039279CA5702A96391@NANUK.pc.tundra.com>
From: "Alexandre Bounine" <Alexandre.Bounine@tundra.com>
To: <jgarzik@pobox.com>, <netdev@vger.kernel.org>
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
=20=20=20
Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
---

diff -pNur linux-2.6.24/drivers/net/tsi108_eth.c
linux-2.6.24-fix/drivers/net/tsi108_eth.c
--- linux-2.6.24/drivers/net/tsi108_eth.c	2008-02-06
16:16:00.000000000 -0500
+++ linux-2.6.24-fix/drivers/net/tsi108_eth.c	2008-02-06
16:57:41.000000000 -0500
@@ -338,22 +338,21 @@ static void tsi108_check_phy(struct net_
=20
 			TSI_WRITE(TSI108_MAC_CFG2, mac_cfg2_reg);
 			TSI_WRITE(TSI108_EC_PORTCTRL, portctrl_reg);
+		}
=20
-			if (data->link_up =3D=3D 0) {
-				/* The manual says it can take 3-4 usecs
for the speed change
-				 * to take effect.
-				 */
-				udelay(5);
-
-				spin_lock(&data->txlock);
-				if (is_valid_ether_addr(dev->dev_addr)
&& data->txfree)
-					netif_wake_queue(dev);
+		if (data->link_up =3D=3D 0) {
+			/* The manual says it can take 3-4 usecs for the
speed change
+			 * to take effect.
+			 */
+			udelay(5);
=20
-				data->link_up =3D 1;
-				spin_unlock(&data->txlock);
-			}
-		}
+			spin_lock(&data->txlock);
+			if (is_valid_ether_addr(dev->dev_addr) &&
data->txfree)
+				netif_wake_queue(dev);
=20
+			data->link_up =3D 1;
+			spin_unlock(&data->txlock);
+		}
 	} else {
 		if (data->link_up =3D=3D 1) {
 			netif_stop_queue(dev);
@@ -1267,12 +1266,11 @@ static void tsi108_init_phy(struct net_d
 	 * PHY_STAT register before the link up status bit is set.
 	 */
=20
-	data->link_up =3D 1;
+	data->link_up =3D 0;
=20
 	while (!((phyval =3D tsi108_read_mii(data, MII_BMSR)) &
 		 BMSR_LSTATUS)) {
 		if (i++ > (MII_READ_DELAY / 10)) {
-			data->link_up =3D 0;
 			break;
 		}
 		spin_unlock_irqrestore(&phy_lock, flags);


---=0D
=0D
Important Notice: This message is intended for the use of the individual to=
 whom it is addressed and may contain information which is privileged, conf=
idential and/or exempt from disclosure under applicable law. If the reader =
of this message is not the intended recipient, or is not the employee or ag=
ent responsible for delivering the message to the intended recipient, you a=
re hereby notified that any dissemination, distribution, or copying of this=
 communication is strictly prohibited. If you have received this communicat=
ion in error, please notify the sender immediately by telephone or return e=
-mail and delete the original message from your systems. Thank you. =0D
