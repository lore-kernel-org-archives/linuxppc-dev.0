Return-Path: <wfarnsworth@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id A4D3567CBE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jul 2005 02:03:40 +1000 (EST)
Received: from rhino.az.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA06409
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Jul 2005 09:03:38 -0700
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <1122393448.22059.32.camel@rhino.az.mvista.com>
References: <1122393448.22059.32.camel@rhino.az.mvista.com>
Content-Type: multipart/mixed; boundary="=-oH9myiFFA6dAKA7QrSDZ"
Message-Id: <1122393818.22059.38.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 26 Jul 2005 09:03:38 -0700
Subject: Re: [PATCH 2/3] IBM EMAC support for the PPC440EP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



--=-oH9myiFFA6dAKA7QrSDZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This adds support to the IBM EMAC ethernet driver for the 440EP.

Signed-off by: Wade Farnsworth <wfarnsworth@mvista.com>



--=-oH9myiFFA6dAKA7QrSDZ
Content-Disposition: attachment; filename=440ep-net.patch
Content-Type: text/x-patch; name=440ep-net.patch
Content-Transfer-Encoding: 7bit

diff -uprN linux-2.6.12/drivers/net/ibm_emac/ibm_emac_phy.c linux-2.6.12-440ep/drivers/net/ibm_emac/ibm_emac_phy.c
--- linux-2.6.12/drivers/net/ibm_emac/ibm_emac_phy.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-440ep/drivers/net/ibm_emac/ibm_emac_phy.c	2005-07-25 11:32:38.000000000 -0700
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
+	iounmap(config2_addr);
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
@@ -234,6 +285,15 @@ static struct mii_phy_ops generic_phy_op
 	read_link:genmii_read_link
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
 static struct mii_phy_def cis8201_phy_def = {
 	phy_id:0x000fc410,
 	phy_id_mask:0x000ffff0,
@@ -254,6 +314,7 @@ static struct mii_phy_def genmii_phy_def
 
 static struct mii_phy_def *mii_phy_table[] = {
 	&cis8201_phy_def,
+	&ac104_phy_def,
 	&genmii_phy_def,
 	NULL
 };

--=-oH9myiFFA6dAKA7QrSDZ--
