Return-Path: <f.fainelli@gmail.com>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2B151A0867
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 07:39:13 +1000 (EST)
Received: by mail-pa0-f42.google.com with SMTP id rd3so1806396pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 14:39:11 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH RESEND net-next 4/9] net: systemport: use the new fixed PHY
 helpers
Date: Wed, 21 May 2014 14:38:46 -0700
Message-Id: <1400708331-18088-5-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1400708331-18088-1-git-send-email-f.fainelli@gmail.com>
References: <1400708331-18088-1-git-send-email-f.fainelli@gmail.com>
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
 drivers/net/ethernet/broadcom/bcmsysport.c | 17 +++++++++++++++--
 drivers/net/ethernet/broadcom/bcmsysport.h |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index d40c5b969e9e..dc708a888f80 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1327,8 +1327,8 @@ static int bcm_sysport_open(struct net_device *dev)
 	/* Read CRC forward */
 	priv->crc_fwd = !!(umac_readl(priv, UMAC_CMD) & CMD_CRC_FWD);
 
-	priv->phydev = of_phy_connect_fixed_link(dev, bcm_sysport_adj_link,
-							priv->phy_interface);
+	priv->phydev = of_phy_connect(dev, priv->phy_dn, bcm_sysport_adj_link,
+					0, priv->phy_interface);
 	if (!priv->phydev) {
 		netdev_err(dev, "could not attach to PHY\n");
 		return -ENODEV;
@@ -1551,6 +1551,19 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 	if (priv->phy_interface < 0)
 		priv->phy_interface = PHY_INTERFACE_MODE_GMII;
 
+	/* In the case of a fixed PHY, the DT node associated
+	 * to the PHY is the Ethernet MAC DT node.
+	 */
+	if (of_phy_is_fixed_link(dn)) {
+		ret = of_phy_register_fixed_link(dn);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to register fixed PHY\n");
+			goto err;
+		}
+
+		priv->phy_dn = dn;
+	}
+
 	/* Initialize netdevice members */
 	macaddr = of_get_mac_address(dn);
 	if (!macaddr || !is_valid_ether_addr(macaddr)) {
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.h b/drivers/net/ethernet/broadcom/bcmsysport.h
index abdeb62616df..73fd04a94797 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.h
+++ b/drivers/net/ethernet/broadcom/bcmsysport.h
@@ -656,6 +656,7 @@ struct bcm_sysport_priv {
 	unsigned int		rx_c_index;
 
 	/* PHY device */
+	struct device_node	*phy_dn;
 	struct phy_device	*phydev;
 	phy_interface_t		phy_interface;
 	int			old_pause;
-- 
1.9.1
