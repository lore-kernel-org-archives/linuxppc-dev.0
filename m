Return-Path: <benh@ozlabs.org>
To: <jgarzik@pobox.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 05 Dec 2007 11:14:26 +1100
Subject: [PATCH 2/11] ibm_newemac: Add ET1011c PHY support
Message-Id: <20071205001535.9F45CDDF45@ozlabs.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stefan Roese <sr@denx.de>

This adds support for the Agere ET1011c PHY as found on the AMCC Taishan
board.

Signed-off-by: Stefan Roese <sr@denx.de>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/net/ibm_newemac/phy.c |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

Index: linux-work/drivers/net/ibm_newemac/phy.c
===================================================================
--- linux-work.orig/drivers/net/ibm_newemac/phy.c	2007-12-03 11:58:16.000000000 +1100
+++ linux-work/drivers/net/ibm_newemac/phy.c	2007-12-03 11:59:53.000000000 +1100
@@ -327,6 +327,42 @@ static int m88e1111_init(struct mii_phy 
 	return  0;
 }
 
+static int et1011c_init(struct mii_phy *phy)
+{
+	u16 reg_short;
+
+	reg_short = (u16)(phy_read(phy, 0x16));
+	reg_short &= ~(0x7);
+	reg_short |= 0x6;	/* RGMII Trace Delay*/
+	phy_write(phy, 0x16, reg_short);
+
+	reg_short = (u16)(phy_read(phy, 0x17));
+	reg_short &= ~(0x40);
+	phy_write(phy, 0x17, reg_short);
+
+	phy_write(phy, 0x1c, 0x74f0);
+	return 0;
+}
+
+static struct mii_phy_ops et1011c_phy_ops = {
+	.init		= et1011c_init,
+	.setup_aneg	= genmii_setup_aneg,
+	.setup_forced	= genmii_setup_forced,
+	.poll_link	= genmii_poll_link,
+	.read_link	= genmii_read_link
+};
+
+static struct mii_phy_def et1011c_phy_def = {
+	.phy_id		= 0x0282f000,
+	.phy_id_mask	= 0x0fffff00,
+	.name		= "ET1011C Gigabit Ethernet",
+	.ops		= &et1011c_phy_ops
+};
+
+
+
+
+
 static struct mii_phy_ops m88e1111_phy_ops = {
 	.init		= m88e1111_init,
 	.setup_aneg	= genmii_setup_aneg,
@@ -344,6 +380,7 @@ static struct mii_phy_def m88e1111_phy_d
 };
 
 static struct mii_phy_def *mii_phy_table[] = {
+	&et1011c_phy_def,
 	&cis8201_phy_def,
 	&bcm5248_phy_def,
 	&m88e1111_phy_def,
