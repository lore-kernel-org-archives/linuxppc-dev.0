Return-Path: <wfarnsworth@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 23BCA67A6F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Apr 2005 03:31:16 +1000 (EST)
Received: from rhino.az.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA22165
	for <linuxppc-embedded@ozlabs.org>; Wed, 6 Apr 2005 10:31:10 -0700
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <1112808085.24527.296.camel@rhino.az.mvista.com>
References: <1112808085.24527.296.camel@rhino.az.mvista.com>
Content-Type: multipart/mixed; boundary="=-fL0e0bXQkqo0Wvp1S/GP"
Message-Id: <1112808669.24673.304.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 06 Apr 2005 10:31:09 -0700
Subject: Re: [PATCH 1/3] PPC440EP: IBM EMAC support for the Bamboo board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



--=-fL0e0bXQkqo0Wvp1S/GP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This adds support for the Bamboo board in the EMAC driver.

Jason McMullan pointed out to me that for the Bamboo Rev. 0 to boot from
ethernet, the ANEG pin on SW2 needs to be turned off.  If we use this,
we can avoid using the PVR to determine which board rev, we're running
on.  This patch addresses this.

Comments would be appreciated.

-Wade Farnsworth

Signed-off by: Wade Farnsworth <wfarnsworth@mvista.com>

--=-fL0e0bXQkqo0Wvp1S/GP
Content-Disposition: attachment; filename=ibm440ep-ibm_emac.patch
Content-Type: text/x-patch; name=ibm440ep-ibm_emac.patch
Content-Transfer-Encoding: 7bit

diff -uprN linux-2.5-orig/drivers/net/ibm_emac/ibm_emac_phy.c linux-2.5-440ep/drivers/net/ibm_emac/ibm_emac_phy.c
--- linux-2.5-orig/drivers/net/ibm_emac/ibm_emac_phy.c	2005-04-05 15:31:14.000000000 -0700
+++ linux-2.5-440ep/drivers/net/ibm_emac/ibm_emac_phy.c	2005-04-05 15:36:58.000000000 -0700
@@ -24,6 +24,7 @@
 #include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/delay.h>
+#include <linux/vmalloc.h>
 
 #include "ibm_emac_phy.h"
 
@@ -78,6 +79,45 @@ static int cis8201_init(struct mii_phy *
 	return 0;
 }
 
+#ifdef CONFIG_BAMBOO
+static int ac104_init(struct mii_phy *phy)
+{
+	/* 
+	 * SW2 on the Bamboo is used for ethernet configuration and is accessed
+	 * via the CONFIG2 register in the FPGA.  If the ANEG pin is set, 
+	 * overwrite the supported features with the settings in SW2.
+	 */
+	u8 *config2_addr, config2_val;
+	config2_addr = ioremap64(BAMBOO_FPGA_CONFIG2_REG_ADDR, 0x8);
+	config2_val = * config2_addr;
+	iounmap(*config2_addr);
+	if (BAMBOO_AUTONEGOTIATE(config2_val))
+		return 0;
+	phy->def->features = SUPPORTED_TP | SUPPORTED_MII;
+	if (BAMBOO_FORCE_100Mbps(config2_val)) {
+		phy->speed = SPEED_100;
+		if (BAMBOO_FULL_DUPLEX_EN(config2_val)) {
+			phy->def->features |= SUPPORTED_100baseT_Full;
+			phy->duplex = DUPLEX_FULL;	
+		} else {
+			phy->def->features |= SUPPORTED_100baseT_Half;
+			phy->duplex = DUPLEX_HALF;
+		}
+	} else {
+		phy->speed = SPEED_10;
+		if (BAMBOO_FULL_DUPLEX_EN(config2_val)) {
+			phy->def->features |= SUPPORTED_10baseT_Full;
+			phy->duplex = DUPLEX_FULL;
+		} else {
+			phy->def->features |= SUPPORTED_10baseT_Half;
+			phy->duplex = DUPLEX_HALF;
+		}
+	}
+
+	return 0;
+}
+#endif
+
 static int genmii_setup_aneg(struct mii_phy *phy, u32 advertise)
 {
 	u16 ctl, adv;
@@ -226,6 +266,17 @@ static struct mii_phy_ops cis8201_phy_op
 	read_link:cis8201_read_link
 };
 
+/* AC104 phy ops */
+static struct mii_phy_ops ac104_phy_ops = {
+#ifdef CONFIG_BAMBOO
+	init:ac104_init,
+#endif
+	setup_aneg:genmii_setup_aneg,
+	setup_forced:genmii_setup_forced,
+	poll_link:genmii_poll_link,
+	read_link:genmii_read_link
+};
+
 /* Generic implementation for most 10/100 PHYs */
 static struct mii_phy_ops generic_phy_ops = {
 	setup_aneg:genmii_setup_aneg,
@@ -243,6 +294,15 @@ static struct mii_phy_def cis8201_phy_de
 	ops:&cis8201_phy_ops
 };
 
+static struct mii_phy_def ac104_phy_def = {
+	phy_id:0x00225540,
+	phy_id_mask:0x00fffff0,
+	name:"AC104 Ethernet",
+	features:MII_BASIC_FEATURES,
+	magic_aneg:0,
+	ops:&ac104_phy_ops
+};
+
 static struct mii_phy_def genmii_phy_def = {
 	phy_id:0x00000000,
 	phy_id_mask:0x00000000,
@@ -254,6 +314,7 @@ static struct mii_phy_def genmii_phy_def
 
 static struct mii_phy_def *mii_phy_table[] = {
 	&cis8201_phy_def,
+	&ac104_phy_def,
 	&genmii_phy_def,
 	NULL
 };

--=-fL0e0bXQkqo0Wvp1S/GP--
