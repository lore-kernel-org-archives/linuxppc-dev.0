Return-Path: <SRS0=XvZf=QC=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 4BBF4DDE27
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 17:11:45 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ibm_newemac: Add ET1011c PHY support
Date: Fri, 9 Nov 2007 07:07:01 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200711090707.01421.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds support for the Agere ET1011c PHY as found on the AMCC Taishan
board.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 drivers/net/ibm_newemac/phy.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ibm_newemac/phy.c b/drivers/net/ibm_newemac/phy.c
index 1404457..4270a66 100644
--- a/drivers/net/ibm_newemac/phy.c
+++ b/drivers/net/ibm_newemac/phy.c
@@ -314,6 +314,38 @@ static struct mii_phy_def bcm5248_phy_def = {
 	.ops		= &generic_phy_ops
 };
 
+static int et1011c_init(struct mii_phy *phy)
+{
+	u16 reg_short;
+
+	reg_short = (u16)(phy_read(phy, 0x16));
+	reg_short &= ~(0x7);
+	reg_short |= 0x6;		/* RGMII Trace Delay*/
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
 static int m88e1111_init(struct mii_phy *phy)
 {
 	printk("%s: Marvell 88E1111 Ethernet\n", __FUNCTION__);
@@ -344,6 +376,7 @@ static struct mii_phy_def m88e1111_phy_def = {
 };
 
 static struct mii_phy_def *mii_phy_table[] = {
+	&et1011c_phy_def,
 	&cis8201_phy_def,
 	&bcm5248_phy_def,
 	&m88e1111_phy_def,
-- 
1.5.3.5.561.g140d
