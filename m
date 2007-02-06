Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 9AC0FDDF2B
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 22:30:48 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l16BUleS005193
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 04:30:47 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l16BUIxt014599
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 05:30:43 -0600 (CST)
Message-ID: <45C86727.8070809@freescale.com>
Date: Tue, 06 Feb 2007 19:31:51 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: jeff@garzik.org
Subject: [PATCH 3/4] ucc_geth: Remove obsolete workaround of link speed change
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The workaround used a long delay of 4s which caused problem
when two link-changes happens at the same time.

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Wu Xiaochuan <xiao-chuan.wu@freescale.com>
---
 drivers/net/ucc_geth.c     |   71 +++----------------------------------------
 drivers/net/ucc_geth_phy.c |    2 +
 2 files changed, 7 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 50b1fe9..dcec66d 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -1709,75 +1709,13 @@ static void adjust_link(struct net_device *dev)
 		if (mii_info->speed != ugeth->oldspeed) {
 			switch (mii_info->speed) {
 			case 1000:
-#ifdef CONFIG_PPC_MPC836x
-/* FIXME: This code is for 100Mbs BUG fixing,
-remove this when it is fixed!!! */
-				if (ugeth->ug_info->enet_interface ==
-				    ENET_1000_GMII)
-				/* Run the commands which initialize the PHY */
-				{
-					tempval =
-					    (u32) mii_info->mdio_read(ugeth->
-						dev, mii_info->mii_id, 0x1b);
-					tempval |= 0x000f;
-					mii_info->mdio_write(ugeth->dev,
-						mii_info->mii_id, 0x1b,
-						(u16) tempval);
-					tempval =
-					    (u32) mii_info->mdio_read(ugeth->
-						dev, mii_info->mii_id,
-						MII_BMCR);
-					mii_info->mdio_write(ugeth->dev,
-						mii_info->mii_id, MII_BMCR,
-						(u16) (tempval | BMCR_RESET));
-				} else if (ugeth->ug_info->enet_interface ==
-					   ENET_1000_RGMII)
-				/* Run the commands which initialize the PHY */
-				{
-					tempval =
-					    (u32) mii_info->mdio_read(ugeth->
-						dev, mii_info->mii_id, 0x1b);
-					tempval = (tempval & ~0x000f) | 0x000b;
-					mii_info->mdio_write(ugeth->dev,
-						mii_info->mii_id, 0x1b,
-						(u16) tempval);
-					tempval =
-					    (u32) mii_info->mdio_read(ugeth->
-						dev, mii_info->mii_id,
-						MII_BMCR);
-					mii_info->mdio_write(ugeth->dev,
-						mii_info->mii_id, MII_BMCR,
-						(u16) (tempval | BMCR_RESET));
-				}
-				msleep(4000);
-#endif				/* CONFIG_MPC8360 */
-				adjust_enet_interface(ugeth);
+				ugeth->ug_info->enet_interface = ENET_1000_RGMII;
 				break;
 			case 100:
-			case 10:
-#ifdef CONFIG_PPC_MPC836x
-/* FIXME: This code is for 100Mbs BUG fixing,
-remove this lines when it will be fixed!!! */
 				ugeth->ug_info->enet_interface = ENET_100_RGMII;
-				tempval =
-				    (u32) mii_info->mdio_read(ugeth->dev,
-							      mii_info->mii_id,
-							      0x1b);
-				tempval = (tempval & ~0x000f) | 0x000b;
-				mii_info->mdio_write(ugeth->dev,
-						     mii_info->mii_id, 0x1b,
-						     (u16) tempval);
-				tempval =
-				    (u32) mii_info->mdio_read(ugeth->dev,
-							      mii_info->mii_id,
-							      MII_BMCR);
-				mii_info->mdio_write(ugeth->dev,
-						     mii_info->mii_id, MII_BMCR,
-						     (u16) (tempval |
-							    BMCR_RESET));
-				msleep(4000);
-#endif				/* CONFIG_MPC8360 */
-				adjust_enet_interface(ugeth);
+				break;
+			case 10:
+				ugeth->ug_info->enet_interface = ENET_10_RGMII;
 				break;
 			default:
 				ugeth_warn
@@ -1785,6 +1723,7 @@ remove this lines when it will be fixed!!! */
 				     dev->name, mii_info->speed);
 				break;
 			}
+			adjust_enet_interface(ugeth);
 
 			ugeth_info("%s: Speed %dBT", dev->name,
 				   mii_info->speed);
diff --git a/drivers/net/ucc_geth_phy.c b/drivers/net/ucc_geth_phy.c
index 3c86592..6fda6d8 100644
--- a/drivers/net/ucc_geth_phy.c
+++ b/drivers/net/ucc_geth_phy.c
@@ -376,6 +376,8 @@ static int marvell_init(struct ugeth_mii_info *mii_info)
 	ugphy_vdbg("%s: IN", __FUNCTION__);
 
 	ucc_geth_phy_write(mii_info, 0x14, 0x0cd2);
+	ucc_geth_phy_write(mii_info, 0x1b,
+		(ucc_geth_phy_read(mii_info, 0x1b) & ~0x000f) | 0x000b);
 	ucc_geth_phy_write(mii_info, MII_BMCR,
 		  ucc_geth_phy_read(mii_info, MII_BMCR) | BMCR_RESET);
 	msleep(4000);
