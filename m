Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9C3A1DDFDC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Mar 2007 06:29:58 +1100 (EST)
Received: from [192.168.12.21] (unknown [10.149.0.1])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id EAFE68815
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Mar 2007 23:29:56 +0400 (SAMT)
Message-ID: <46003608.70308@ru.mvista.com>
Date: Tue, 20 Mar 2007 22:29:12 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] PPC440EPx/440GRx EMAC support.
Content-Type: multipart/mixed; boundary="------------060705070804040207070702"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060705070804040207070702
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Add PPC440EPx/440GRx EMAC along with
Marvell 88E1111 and ET1011C PHY support.
The M88E1111 chip can be found on Sequoia board.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>



--------------060705070804040207070702
Content-Type: text/plain;
 name="ppc440epx_emac.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc440epx_emac.patch"

diff -ruN linux.orig/drivers/net/ibm_emac/ibm_emac_core.c linux/drivers/net/ibm_emac/ibm_emac_core.c
--- linux.orig/drivers/net/ibm_emac/ibm_emac_core.c	2007-03-16 18:03:51.000000000 +0300
+++ linux/drivers/net/ibm_emac/ibm_emac_core.c	2007-03-18 18:53:08.000000000 +0300
@@ -86,7 +86,8 @@
 static u32 busy_phy_map;
 
 #if defined(CONFIG_IBM_EMAC_PHY_RX_CLK_FIX) && \
-    (defined(CONFIG_405EP) || defined(CONFIG_440EP) || defined(CONFIG_440GR))
+    (defined(CONFIG_405EP) || defined(CONFIG_440EP) || defined(CONFIG_440GR) || \
+     defined(CONFIG_440EPX) || defined(CONFIG_440GRX))
 /* 405EP has "EMAC to PHY Control Register" (CPC0_EPCTL) which can help us
  * with PHY RX clock problem.
  * 440EP/440GR has more sane SDR0_MFR register implementation than 440GX, which
diff -ruN linux.orig/drivers/net/ibm_emac/ibm_emac.h linux/drivers/net/ibm_emac/ibm_emac.h
--- linux.orig/drivers/net/ibm_emac/ibm_emac.h	2007-03-16 18:03:51.000000000 +0300
+++ linux/drivers/net/ibm_emac/ibm_emac.h	2007-03-18 18:53:08.000000000 +0300
@@ -26,7 +26,7 @@
 #if !defined(CONFIG_405GP) && !defined(CONFIG_405GPR) && !defined(CONFIG_405EP) && \
     !defined(CONFIG_440GP) && !defined(CONFIG_440GX) && !defined(CONFIG_440SP) && \
     !defined(CONFIG_440EP) && !defined(CONFIG_NP405H) && !defined(CONFIG_440SPE) && \
-    !defined(CONFIG_440GR)
+    !defined(CONFIG_440GR) && !defined(CONFIG_440EPX) && !defined(CONFIG_440GRX)
 #error	"Unknown SoC. Please, check chip user manual and make sure EMAC defines are OK"
 #endif
 
@@ -227,9 +227,15 @@
 #define EMAC_STACR_PHYD_SHIFT		16
 #define EMAC_STACR_OC			0x00008000
 #define EMAC_STACR_PHYE			0x00004000
+#if defined(CONFIG_IBM_EMAC4V4)
+#define EMAC_STACR_STAC_MASK		0x00003800
+#define EMAC_STACR_STAC_READ		0x00001000
+#define EMAC_STACR_STAC_WRITE		0x00000800
+#else
 #define EMAC_STACR_STAC_MASK		0x00003000
 #define EMAC_STACR_STAC_READ		0x00001000
 #define EMAC_STACR_STAC_WRITE		0x00002000
+#endif
 #if !defined(CONFIG_IBM_EMAC4)
 #define EMAC_STACR_OPBC_MASK		0x00000C00
 #define EMAC_STACR_OPBC_50		0x00000000
@@ -250,8 +256,11 @@
 /*
  * For the 440SPe, AMCC inexplicably changed the polarity of
  * the "operation complete" bit in the MII control register.
+ *
+ * This change is not associated to 440SPe but to EMAC core version used in
+ * 440SPe, 440EPx, 440GRx.
  */
-#if defined(CONFIG_440SPE)
+#if defined(CONFIG_440SPE) || defined(CONFIG_IBM_EMAC4V4)
 static inline int emac_phy_done(u32 stacr)
 {
 	return !(stacr & EMAC_STACR_OC);
diff -ruN linux.orig/drivers/net/ibm_emac/ibm_emac_mal.h linux/drivers/net/ibm_emac/ibm_emac_mal.h
--- linux.orig/drivers/net/ibm_emac/ibm_emac_mal.h	2007-03-16 18:03:51.000000000 +0300
+++ linux/drivers/net/ibm_emac/ibm_emac_mal.h	2007-03-18 18:53:08.000000000 +0300
@@ -35,7 +35,7 @@
     defined(CONFIG_440EP) || defined(CONFIG_440GR) || defined(CONFIG_NP405H)
 #define MAL_VERSION		1
 #elif defined(CONFIG_440GP) || defined(CONFIG_440GX) || defined(CONFIG_440SP) || \
-      defined(CONFIG_440SPE)
+      defined(CONFIG_440SPE) || defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
 #define MAL_VERSION		2
 #else
 #error "Unknown SoC, please check chip manual and choose MAL 'version'"
diff -ruN linux.orig/drivers/net/ibm_emac/ibm_emac_phy.c linux/drivers/net/ibm_emac/ibm_emac_phy.c
--- linux.orig/drivers/net/ibm_emac/ibm_emac_phy.c	2007-03-16 18:03:51.000000000 +0300
+++ linux/drivers/net/ibm_emac/ibm_emac_phy.c	2007-03-18 18:53:08.000000000 +0300
@@ -299,8 +299,71 @@
 	.ops		= &cis8201_phy_ops
 };
 
+/* Marvell 88E1111 */
+static int m88e1111_init(struct mii_phy *phy)
+{
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
+	.phy_id		= 0x01410CC0,
+	.phy_id_mask	= 0x0ffffff0,
+	.name		= "Marvell 88E1111 Ethernet",
+	.ops		= &m88e1111_phy_ops,
+};
+
+/* ET1011C */
+static int et1011c_init(struct mii_phy *phy)
+{
+	u16 reg_short;
+
+	reg_short = (u16)(phy_read(phy,0x16));
+	reg_short &= ~(0x7);
+	reg_short |= 0x6;	/* RGMII Trace Delay */
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
 static struct mii_phy_def *mii_phy_table[] = {
 	&cis8201_phy_def,
+	&m88e1111_phy_def,
+	&et1011c_phy_def,
 	&genmii_phy_def,
 	NULL
 };

--------------060705070804040207070702--
