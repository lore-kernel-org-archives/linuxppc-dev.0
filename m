Return-Path: <vgallardo@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DD597DDD0C
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Nov 2008 08:03:25 +1100 (EST)
From: Victor Gallardo <vgallardo@amcc.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ibm_newemac: Add support for Arches CPU0 SGMII0 to CPU1 SGMII0
Date: Sat,  1 Nov 2008 14:03:22 -0700
Message-Id: <1225573402-28113-1-git-send-email-vgallardo@amcc.com>
Cc: Victor Gallardo <vgallardo@amcc.com>, Feng Kan <fkan@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Arches, SGMII0 Rx/Tx on CPU0 is wired to SGMII0 Tx/Rx on CPU1.
Add GPCS as a phy type to allow for this.

Signed-off-by: Victor Gallardo <vgallardo@amcc.com>
---
 arch/powerpc/boot/dts/arches.dts |    3 ++-
 drivers/net/ibm_newemac/core.c   |    5 ++++-
 drivers/net/ibm_newemac/phy.c    |   29 +++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/arches.dts b/arch/powerpc/boot/dts/arches.dts
index d9113b1..a5f1597 100644
--- a/arch/powerpc/boot/dts/arches.dts
+++ b/arch/powerpc/boot/dts/arches.dts
@@ -225,7 +225,8 @@
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
 				phy-mode = "sgmii";
-				phy-map = <0xffffffff>;
+				phy-map = <0x00000400>;
+				phy-address = <0x0000000a>;
 				gpcs-address = <0x0000000a>;
 				tah-device = <&TAH0>;
 				tah-channel = <0>;
diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
index 2ee2622..9b62741 100644
--- a/drivers/net/ibm_newemac/core.c
+++ b/drivers/net/ibm_newemac/core.c
@@ -2814,7 +2814,10 @@ static int __devinit emac_probe(struct of_device *ofdev,
 		goto err_detach_rgmii;
 
 	/* Set some link defaults before we can find out real parameters */
-	dev->phy.speed = SPEED_100;
+	if (emac_phy_gpcs(dev->phy_mode))
+		dev->phy.speed = SPEED_1000;
+	else
+		dev->phy.speed = SPEED_100;
 	dev->phy.duplex = DUPLEX_FULL;
 	dev->phy.autoneg = AUTONEG_DISABLE;
 	dev->phy.pause = dev->phy.asym_pause = 0;
diff --git a/drivers/net/ibm_newemac/phy.c b/drivers/net/ibm_newemac/phy.c
index c40cd8d..84e6e45 100644
--- a/drivers/net/ibm_newemac/phy.c
+++ b/drivers/net/ibm_newemac/phy.c
@@ -400,6 +400,18 @@ static int m88e1112_init(struct mii_phy *phy)
 	return  0;
 }
 
+static int gpcs_init(struct mii_phy *phy)
+{
+	if (phy->mode == PHY_MODE_SGMII) {
+		/* Configure GPCS interface to recommended setting for SGMII */
+		phy_write(phy, 0x04, 0x8120); /* AsymPause, FDX */
+		phy_write(phy, 0x07, 0x2801); /* msg_pg, toggle */
+		phy_write(phy, 0x00, 0x0140); /* 1Gbps, FDX     */
+	}
+
+	return 0;
+}
+
 static int et1011c_init(struct mii_phy *phy)
 {
 	u16 reg_short;
@@ -467,12 +479,29 @@ static struct mii_phy_def m88e1112_phy_def = {
 	.ops		= &m88e1112_phy_ops,
 };
 
+static struct mii_phy_ops gpcs_phy_ops = {
+	.init		= gpcs_init,
+	.setup_aneg	= genmii_setup_aneg,
+	.setup_forced	= genmii_setup_forced,
+	.poll_link	= genmii_poll_link,
+	.read_link	= genmii_read_link
+};
+
+static struct mii_phy_def gpcs_phy_def = {
+	.phy_id		= 0xf6d5eeef,
+	.phy_id_mask	= 0xffffffff,
+	.features	= SUPPORTED_1000baseT_Full,
+	.name		= "Internal GPCS",
+	.ops		= &gpcs_phy_ops,
+};
+
 static struct mii_phy_def *mii_phy_table[] = {
 	&et1011c_phy_def,
 	&cis8201_phy_def,
 	&bcm5248_phy_def,
 	&m88e1111_phy_def,
 	&m88e1112_phy_def,
+	&gpcs_phy_def,
 	&genmii_phy_def,
 	NULL
 };
-- 
1.5.5
