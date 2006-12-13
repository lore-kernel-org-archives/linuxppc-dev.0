Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id DE51267C56
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 04:43:10 +1100 (EST)
From: timur@freescale.com
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Update ucc_geth.c for new workqueue structure
Date: Wed, 13 Dec 2006 11:43:06 -0600
Message-Id: <11660317861257-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Timur Tabi <timur@freescale.com>

The workqueue interface changed with David Howell's patch on 11/22/2006
(SHA 65f27f38446e1976cc98fd3004b110fedcddd189).  Several drivers were
updated with that patch to handle the new interface, but ucc_geth.c
was not one of them.  This patch updates ucc_geth.c to support the new
model.

A compiler warning in set_mac_addr() was also fixed.

Signed-off-by: Timur Tabi <timur@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
 drivers/net/ucc_geth.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 1f05511..d33bb0c 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -29,6 +29,7 @@
 #include <linux/fsl_devices.h>
 #include <linux/ethtool.h>
 #include <linux/mii.h>
+#include <linux/workqueue.h>
 
 #include <asm/of_platform.h>
 #include <asm/uaccess.h>
@@ -472,7 +473,7 @@ static void put_enet_addr_container(stru
 	kfree(enet_addr_cont);
 }
 
-static int set_mac_addr(__be16 __iomem *reg, u8 *mac)
+static void set_mac_addr(__be16 __iomem *reg, u8 *mac)
 {
 	out_be16(&reg[0], ((u16)mac[5] << 8) | mac[4]);
 	out_be16(&reg[1], ((u16)mac[3] << 8) | mac[2]);
@@ -3918,10 +3919,11 @@ static irqreturn_t phy_interrupt(int irq
 }
 
 /* Scheduled by the phy_interrupt/timer to handle PHY changes */
-static void ugeth_phy_change(void *data)
+static void ugeth_phy_change(struct work_struct *work)
 {
-	struct net_device *dev = (struct net_device *)data;
-	struct ucc_geth_private *ugeth = netdev_priv(dev);
+	struct ucc_geth_private *ugeth =
+		container_of(work, struct ucc_geth_private, tq);
+	struct net_device *dev = ugeth->dev;
 	struct ucc_geth *ug_regs;
 	int result = 0;
 
@@ -4078,7 +4080,7 @@ static int ucc_geth_open(struct net_devi
 #endif				/* CONFIG_UGETH_NAPI */
 
 	/* Set up the PHY change work queue */
-	INIT_WORK(&ugeth->tq, ugeth_phy_change, dev);
+	INIT_WORK(&ugeth->tq, ugeth_phy_change);
 
 	init_timer(&ugeth->phy_info_timer);
 	ugeth->phy_info_timer.function = &ugeth_phy_startup_timer;
-- 
1.4.4
