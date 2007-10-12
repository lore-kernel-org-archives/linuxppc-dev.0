Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC96BDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 23:04:19 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l9CD36xO014699
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 17:03:06 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l9CD3672014696
	for linuxppc-dev@ozlabs.org; Fri, 12 Oct 2007 17:03:06 +0400
Date: Fri, 12 Oct 2007 17:03:05 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC: Add NEW EMAC driver support to 440EPx Sequoia board.
Message-ID: <20071012130305.GA14682@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch enables NEW EMAC support for PowerPC 440EPx Sequoia board
and adds BCM5248 and Marvell 88E1111 PHY support to NEW EMAC driver.
These PHY chips are used on PowerPC440EPx boards.
The PHY code is based on the previous work by Stefan Roese <sr@denx.de>

Signed-off-by: Stefan Roese <sr@denx.de>
Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

---
 arch/powerpc/platforms/44x/Kconfig |    7 ++----
 drivers/net/ibm_newemac/phy.c      |   39 +++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 4 deletions(-)

--- linux.orig/arch/powerpc/platforms/44x/Kconfig	2007-07-30 15:05:50.000000000 +0400
+++ linux/arch/powerpc/platforms/44x/Kconfig	2007-07-30 17:59:05.000000000 +0400
@@ -48,10 +48,9 @@
 config 440EPX
 	bool
 	select PPC_FPU
-# Disabled until the new EMAC Driver is merged.
-#	select IBM_NEW_EMAC_EMAC4
-#	select IBM_NEW_EMAC_RGMII
-#	select IBM_NEW_EMAC_ZMII
+	select IBM_NEW_EMAC_EMAC4
+	select IBM_NEW_EMAC_RGMII
+	select IBM_NEW_EMAC_ZMII
 
 config 440GP
 	bool
--- linux.orig/drivers/net/ibm_newemac/phy.c	2007-06-15 21:45:18.000000000 +0400
+++ linux/drivers/net/ibm_newemac/phy.c	2007-06-15 20:45:15.000000000 +0400
@@ -306,8 +306,47 @@
 	.ops		= &cis8201_phy_ops
 };
 
+static struct mii_phy_def bcm5248_phy_def = {
+
+	.phy_id		= 0x0143bc00,
+	.phy_id_mask	= 0x0ffffff0,
+	.name		= "BCM5248 10/100 SMII Ethernet",
+	.ops		= &generic_phy_ops
+};
+
+static int m88e1111_init(struct mii_phy *phy)
+{
+	printk("%s: Marvell 88E1111 Ethernet\n", __FUNCTION__);
+	phy_write(phy, 0x14, 0x0ce3);
+	phy_write(phy, 0x18, 0x4101);
+	phy_write(phy, 0x09, 0x0e00);
+	phy_write(phy, 0x04, 0x01e1);
+	phy_write(phy, 0x00, 0x9140);
+	phy_write(phy, 0x00, 0x1140);
+
+	return  0;
+}
+
+static struct mii_phy_ops m88e1111_phy_ops = {
+	.init		= m88e1111_init,
+	.setup_aneg	= genmii_setup_aneg,
+	.setup_forced	= genmii_setup_forced,
+	.poll_link	= genmii_poll_link,
+	.read_link	= genmii_read_link
+};
+
+static struct mii_phy_def m88e1111_phy_def = {
+
+	.phy_id		= 0x01410CC0,
+	.phy_id_mask	= 0x0ffffff0,
+	.name		= "Marvell 88E1111 Ethernet",
+	.ops		= &m88e1111_phy_ops,
+};
+
 static struct mii_phy_def *mii_phy_table[] = {
 	&cis8201_phy_def,
+	&bcm5248_phy_def,
+	&m88e1111_phy_def,
 	&genmii_phy_def,
 	NULL
 };
