Return-Path: <B13201@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3D55A100A86
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jan 2010 19:36:11 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/de01egw02-8.14.3) with ESMTP id
	o0E8KtTt014627 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jan 2010 01:20:55 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o0E8QoDn027768
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jan 2010 02:26:54 -0600 (CST)
From: Liu Yu <yu.liu@freescale.com>
To: galak@kernel.crashing.org, davem@davemloft.net
Subject: [PATCH 4/4] phy: add RTBI mode for m88e1111
Date: Thu, 14 Jan 2010 16:13:19 +0800
Message-Id: <1263456799-3306-4-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1263456799-3306-3-git-send-email-yu.liu@freescale.com>
References: <1263456799-3306-1-git-send-email-yu.liu@freescale.com>
	<1263456799-3306-2-git-send-email-yu.liu@freescale.com>
	<1263456799-3306-3-git-send-email-yu.liu@freescale.com>
Cc: netdev@vger.kernel.org, Liu Yu <yu.liu@freescale.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Liu Yu <yu.liu@freescale.com>
---
 drivers/net/phy/marvell.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 6f69b9b..65ed385 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -63,6 +63,7 @@
 #define MII_M1111_HWCFG_MODE_COPPER_RGMII	0xb
 #define MII_M1111_HWCFG_MODE_FIBER_RGMII	0x3
 #define MII_M1111_HWCFG_MODE_SGMII_NO_CLK	0x4
+#define MII_M1111_HWCFG_MODE_COPPER_RTBI	0x9
 #define MII_M1111_HWCFG_FIBER_COPPER_AUTO	0x8000
 #define MII_M1111_HWCFG_FIBER_COPPER_RES	0x2000
 
@@ -269,6 +270,43 @@ static int m88e1111_config_init(struct phy_device *phydev)
 			return err;
 	}
 
+	if (phydev->interface == PHY_INTERFACE_MODE_RTBI) {
+		temp = phy_read(phydev, MII_M1111_PHY_EXT_CR);
+		if (temp < 0)
+			return temp;
+		temp |= (MII_M1111_RX_DELAY | MII_M1111_TX_DELAY);
+		err = phy_write(phydev, MII_M1111_PHY_EXT_CR, temp);
+		if (err < 0)
+			return err;
+
+		temp = phy_read(phydev, MII_M1111_PHY_EXT_SR);
+		if (temp < 0)
+			return temp;
+		temp &= ~(MII_M1111_HWCFG_MODE_MASK | MII_M1111_HWCFG_FIBER_COPPER_RES);
+		temp |= 0x7 | MII_M1111_HWCFG_FIBER_COPPER_AUTO;
+		err = phy_write(phydev, MII_M1111_PHY_EXT_SR, temp);
+		if (err < 0)
+			return err;
+
+		/* soft reset */
+		err = phy_write(phydev, MII_BMCR, BMCR_RESET);
+		if (err < 0)
+			return err;
+		do
+			temp = phy_read(phydev, MII_BMCR);
+		while (temp & BMCR_RESET);
+
+		temp = phy_read(phydev, MII_M1111_PHY_EXT_SR);
+		if (temp < 0)
+			return temp;
+		temp &= ~(MII_M1111_HWCFG_MODE_MASK | MII_M1111_HWCFG_FIBER_COPPER_RES);
+		temp |= MII_M1111_HWCFG_MODE_COPPER_RTBI | MII_M1111_HWCFG_FIBER_COPPER_AUTO;
+		err = phy_write(phydev, MII_M1111_PHY_EXT_SR, temp);
+		if (err < 0)
+			return err;
+	}
+
+
 	err = phy_write(phydev, MII_BMCR, BMCR_RESET);
 	if (err < 0)
 		return err;
-- 
1.6.4
