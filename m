Return-Path: <f.fainelli@gmail.com>
Received: from mail-ie0-x22c.google.com (mail-ie0-x22c.google.com
 [IPv6:2607:f8b0:4001:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC6A31A0605
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 02:48:20 +1000 (EST)
Received: by mail-ie0-f172.google.com with SMTP id tp5so3866339ieb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 09:48:17 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 3/9] net: bcmgenet: use the new fixed PHY helpers
Date: Thu, 22 May 2014 09:47:45 -0700
Message-Id: <1400777271-32199-4-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1400777271-32199-1-git-send-email-f.fainelli@gmail.com>
References: <1400777271-32199-1-git-send-email-f.fainelli@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Aida Mynzhasova <aida.mynzhasova@skitlab.ru>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Richard Cochran <richardcochran@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Vitaly Bordug <vbordug@ru.mvista.com>, Grant Likely <grant.likely@linaro.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

of_phy_connect_fixed_link() is becoming obsolete, and also required
platform code to register the fixed PHYs at the specified addresses for
those to be usable. Get rid of it and use the new of_phy_is_fixed_link()
plus of_phy_register_fixed_link() helpers to transition over the new
scheme.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
No changes in v2

 drivers/net/ethernet/broadcom/genet/bcmmii.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 4608673beaff..add8d8596084 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -298,6 +298,7 @@ int bcmgenet_mii_config(struct net_device *dev)
 static int bcmgenet_mii_probe(struct net_device *dev)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
+	struct device_node *dn = priv->pdev->dev.of_node;
 	struct phy_device *phydev;
 	unsigned int phy_flags;
 	int ret;
@@ -307,15 +308,19 @@ static int bcmgenet_mii_probe(struct net_device *dev)
 		return 0;
 	}
 
-	if (priv->phy_dn)
-		phydev = of_phy_connect(dev, priv->phy_dn,
-					bcmgenet_mii_setup, 0,
-					priv->phy_interface);
-	else
-		phydev = of_phy_connect_fixed_link(dev,
-					bcmgenet_mii_setup,
-					priv->phy_interface);
+	/* In the case of a fixed PHY, the DT node associated
+	 * to the PHY is the Ethernet MAC DT node.
+	 */
+	if (of_phy_is_fixed_link(dn)) {
+		ret = of_phy_register_fixed_link(dn);
+		if (ret)
+			return ret;
+
+		priv->phy_dn = dn;
+	}
 
+	phydev = of_phy_connect(dev, priv->phy_dn, bcmgenet_mii_setup, 0,
+				priv->phy_interface);
 	if (!phydev) {
 		pr_err("could not attach to PHY\n");
 		return -ENODEV;
-- 
1.9.1
