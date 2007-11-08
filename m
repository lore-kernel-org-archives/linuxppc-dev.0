Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 08 Nov 2007 19:06:58 +1100
Subject: [PATCH 2/6] ibm_newemac: Add ET1011c PHY support
In-Reply-To: <1194509217.421165.545980042680.qpush@grosgo>
Message-Id: <20071108080729.E09F7DDDFB@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds support for the ET1011c PHY as found on the taishan
board.

The code comes from the kernel distributed with the board by
AMCC and developped by DENX.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

And don't ask me about using phylib, it's in plan :-)

 drivers/net/ibm_newemac/phy.c |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

Index: linux-work/drivers/net/ibm_newemac/phy.c
===================================================================
--- linux-work.orig/drivers/net/ibm_newemac/phy.c	2007-11-08 15:11:30.000000000 +1100
+++ linux-work/drivers/net/ibm_newemac/phy.c	2007-11-08 15:11:54.000000000 +1100
@@ -327,6 +327,42 @@ static int m88e1111_init(struct mii_phy 
 	return  0;
 }
 
+static int et1011c_init(struct mii_phy *phy)
+{
+        u16 reg_short;
+
+        reg_short = (u16)(phy_read(phy,0x16));
+        reg_short &= ~(0x7);
+        reg_short |= 0x6;       /* RGMII Trace Delay*/
+        phy_write(phy, 0x16, reg_short);
+
+        reg_short = (u16)(phy_read(phy, 0x17));
+        reg_short &= ~(0x40);
+        phy_write(phy, 0x17, reg_short);
+
+        phy_write(phy,0x1c,0x74f0);
+        return 0;
+}
+
+static struct mii_phy_ops et1011c_phy_ops = {
+        .init           = et1011c_init,
+        .setup_aneg     = genmii_setup_aneg,
+        .setup_forced   = genmii_setup_forced,
+        .poll_link      = genmii_poll_link,
+        .read_link      = genmii_read_link
+};
+
+static struct mii_phy_def et1011c_phy_def = {
+        .phy_id         = 0x0282f000,
+        .phy_id_mask    = 0x0fffff00,
+        .name           = "ET1011C Gigabit Ethernet",
+        .ops            = &et1011c_phy_ops
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
