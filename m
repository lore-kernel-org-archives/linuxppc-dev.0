Return-Path: <wfarnsworth@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id B110767A46
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 05:59:01 +1100 (EST)
Received: from rhino.az.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA16091
	for <linuxppc-embedded@ozlabs.org>; Tue, 15 Mar 2005 10:58:55 -0800
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <1110912458.24527.27.camel@rhino.az.mvista.com>
References: <1110907039.24673.12.camel@rhino.az.mvista.com>
	<1110912458.24527.27.camel@rhino.az.mvista.com>
Content-Type: multipart/mixed; boundary="=-K+EL5Uvz79zgkJxJY0b0"
Message-Id: <1110913134.24673.32.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 15 Mar 2005 11:58:54 -0700
Subject: Re: [PATCH 3/3] PPC440EP IBM EMAC support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



--=-K+EL5Uvz79zgkJxJY0b0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds support to the IBM EMAC ethernet driver for the 440EP.

Regards,
Wade Farnsworth

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>


--=-K+EL5Uvz79zgkJxJY0b0
Content-Disposition: attachment; filename=ibm440ep-ibm_emac.patch
Content-Type: text/plain; name=ibm440ep-ibm_emac.patch
Content-Transfer-Encoding: 7bit

--- linux-2.6.11-bk7/drivers/net/ibm_emac/ibm_emac_phy.c	2005-03-02 00:38:13.000000000 -0700
+++ linux-2.6.11-bk7-440ep/drivers/net/ibm_emac/ibm_emac_phy.c	2005-03-11 16:32:01.000000000 -0700
@@ -27,6 +27,12 @@
 
 #include "ibm_emac_phy.h"
 
+#ifdef CONFIG_BAMBOO
+#define BAMBOO_REV0 (mfspr(PVR) == PVR_440EP_RA)
+#else
+#define BAMBOO_REV0 0
+#endif
+
 static int reset_one_mii_phy(struct mii_phy *phy, int phy_id)
 {
 	u16 val;
@@ -109,6 +115,54 @@ static int genmii_setup_aneg(struct mii_
 	return 0;
 }
 
+static int ac104_setup_aneg(struct mii_phy *phy, u32 advertise)
+{
+	/* Rev. 0 of the IBM 440EP Eval Board has improperly biased RJ-45 
+	 * sockets, causing 100baseTx to be disabled.  Removing inductors L17 
+	 * and L18 enables 100baseTx, but disables 10baseT.  Therefore, only 
+	 * one speed will be allowed.
+	 * 
+	 * Rev. 1 boards and any other boards using the AC104 can use the
+	 * generic function.
+	 */
+	u16 ctl, adv, bmcr;
+
+	if (!BAMBOO_REV0)
+		return genmii_setup_aneg(phy, advertise);
+
+
+	phy->autoneg = 1;
+	phy->speed = SPEED_10;
+	phy->duplex = DUPLEX_HALF;
+	phy->pause = 0;
+	phy->advertising = advertise;
+
+	bmcr = phy_read(phy, MII_BMCR);
+
+	/* Setup standard advertise */
+	adv = phy_read(phy, MII_ADVERTISE);
+	adv &= ~(ADVERTISE_ALL | ADVERTISE_100BASE4);
+	if (bmcr & BMCR_SPEED100) {
+		if (advertise & ADVERTISED_100baseT_Half)
+			adv |= ADVERTISE_100HALF;
+		if (advertise & ADVERTISED_100baseT_Full)
+			adv |= ADVERTISE_100FULL;
+	} else {
+		if (advertise & ADVERTISED_10baseT_Half)
+			adv |= ADVERTISE_10HALF;
+		if (advertise & ADVERTISED_10baseT_Full)
+			adv |= ADVERTISE_10FULL;
+	}
+	phy_write(phy, MII_ADVERTISE, adv);
+
+	/* Start/Restart aneg */
+	ctl = phy_read(phy, MII_BMCR);
+	ctl |= (BMCR_ANENABLE | BMCR_ANRESTART);
+	phy_write(phy, MII_BMCR, ctl);
+
+	return 0;
+}
+
 static int genmii_setup_forced(struct mii_phy *phy, int speed, int fd)
 {
 	u16 ctl;
@@ -226,6 +280,14 @@ static struct mii_phy_ops cis8201_phy_op
 	read_link:cis8201_read_link
 };
 
+/* AC104 phy ops */
+static struct mii_phy_ops ac104_phy_ops = {
+	setup_aneg:ac104_setup_aneg,
+	setup_forced:genmii_setup_forced,
+	poll_link:genmii_poll_link,
+	read_link:genmii_read_link
+};
+
 /* Generic implementation for most 10/100 PHYs */
 static struct mii_phy_ops generic_phy_ops = {
 	setup_aneg:genmii_setup_aneg,
@@ -243,6 +305,15 @@ static struct mii_phy_def cis8201_phy_de
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
@@ -254,6 +325,7 @@ static struct mii_phy_def genmii_phy_def
 
 static struct mii_phy_def *mii_phy_table[] = {
 	&cis8201_phy_def,
+	&ac104_phy_def,
 	&genmii_phy_def,
 	NULL
 };

--=-K+EL5Uvz79zgkJxJY0b0--
