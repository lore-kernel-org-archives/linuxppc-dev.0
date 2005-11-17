Return-Path: <dave@cray.com>
Received: from mail1.cray.com (mail1.cray.com [136.162.0.111])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail1.cray.com", Issuer "Cray Inc" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C1E0868775
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 08:58:03 +1100 (EST)
Received: from beaver.us.cray.com (beaver.us.cray.com [172.30.74.51])
	by mail1.cray.com (8.13.3/8.13.3/gw-5323) with ESMTP id jAHLp04Y019590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 15:51:01 -0600 (CST)
Received: from orchid.us.cray.com (orchid.us.cray.com [172.30.27.91])
	by beaver.us.cray.com (8.13.4/8.13.3/hub-5273) with ESMTP id
	jAHLp0XD030803
	for <linuxppc-embedded@ozlabs.org>; Thu, 17 Nov 2005 15:51:00 -0600
Received: from [127.0.0.1] (relay6-internal [192.168.234.20])
	by orchid.us.cray.com (8.13.1/8.12.10/irix-ham-1.4) with ESMTP id
	jAHLoxp91595762 for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 15:50:59 -0600 (CST)
Message-ID: <437CFB43.4060400@cray.com>
Date: Thu, 17 Nov 2005 15:50:59 -0600
From: David Updegraff <dave@cray.com>
MIME-Version: 1.0
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/mixed; boundary="------------000308000001050601010709"
Subject: gianfar generic PHY assumptions.
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
--------------000308000001050601010709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

This patch lets gianfar work on 83xx (or 85xx??) boards that have 
Generic PHYs on them that do _NOT_ happen to have an IRQ line wired to 
external_15.  Surely reasonable that if we can't ID the PHY that its 
probably not irq-wired the Freescale-ADS "way"...

It was critical for us; perhaps usefull for others.

-dbu.

--------------000308000001050601010709
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

diff --git a/drivers/net/gianfar_phy.c b/drivers/net/gianfar_phy.c
index 7c965f2..1c08bd0 100644
--- a/drivers/net/gianfar_phy.c
+++ b/drivers/net/gianfar_phy.c
@@ -234,6 +234,19 @@ static int marvell_config_aneg(struct gf
 
 	return 0;
 }
+/* Init for GENERIC: just here to make sure the gainfar driver does not assume
+ * that it has an interrupt. Since don't even know what model it is, seems 
+ * unlikely that they have bothered to wire in an IRQ line exactly like the 
+ * the platform/ files have assumed.
+ */
+static int genmii_init(struct gfar_mii_info *mii_info)
+{
+	struct gfar_private *priv = netdev_priv(mii_info->dev);
+	if (priv)
+		priv->einfo->board_flags &= ~FSL_GIANFAR_BRD_HAS_PHY_INTR;
+	return 0;
+}
+
 static int genmii_config_aneg(struct gfar_mii_info *mii_info)
 {
 	if (mii_info->autoneg) {
@@ -585,6 +598,7 @@ static struct phy_info phy_info_genmii= 
 	.phy_id_mask	= 0x00000000,
 	.name		= "Generic MII",
 	.features	= MII_BASIC_FEATURES,
+	.init		= genmii_init,
 	.config_aneg	= genmii_config_aneg,
 	.read_status	= genmii_read_status,
 };

--------------000308000001050601010709--
