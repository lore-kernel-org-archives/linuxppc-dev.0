Return-Path: <lark@linux.net.cn>
Received: from mx.linux.net.cn (unknown [210.82.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 22CF8DDF5D
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 12:35:21 +1000 (EST)
Received: from [192.168.0.123] (unknown [123.118.16.158])
	by mx.linux.net.cn (Postfix) with ESMTP id 76F1D3EC28
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 10:20:47 +0800 (CST)
Message-ID: <48757088.3060800@linux.net.cn>
Date: Thu, 10 Jul 2008 10:14:32 +0800
From: Wang Jian <lark@linux.net.cn>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] Fix 88e1111 copper/fiber selection in RGMII mode
Content-Type: text/plain; charset=GB2312
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MII_M1111_HWCFG_FIBER_COPPER_RES is a bit of MII_M1111_PHY_EXT_SR, not
MII_M1111_PHY_EXT_CR.

Signed-off-by: Wang Jian <lark@linux.net.cn>
---
 drivers/net/phy/marvell.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 737512c..4aa5479 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -158,7 +158,6 @@ static int m88e1111_config_init(struct phy_device
*phydev)
 {
 	int err;
 	int temp;
-	int mode;

 	/* Enable Fiber/Copper auto selection */
 	temp = phy_read(phydev, MII_M1111_PHY_EXT_SR);
@@ -198,9 +197,7 @@ static int m88e1111_config_init(struct phy_device
*phydev)

 		temp &= ~(MII_M1111_HWCFG_MODE_MASK);

-		mode = phy_read(phydev, MII_M1111_PHY_EXT_CR);
-
-		if (mode & MII_M1111_HWCFG_FIBER_COPPER_RES)
+		if (temp & MII_M1111_HWCFG_FIBER_COPPER_RES)
 			temp |= MII_M1111_HWCFG_MODE_FIBER_RGMII;
 		else
 			temp |= MII_M1111_HWCFG_MODE_COPPER_RGMII;
-- 
1.5.5.4
