Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id A256CDE1F5
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 16:00:58 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so215150waf.9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 22:00:58 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 8/9] net/pasemi_mac: Rework pasemi_mac driver to use of_mdio
	infrastructure
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, afleming@freescale.com,
	avorontsov@ru.mvista.com, davem@davemloft.net, galak@kernel.crashing.org
Date: Wed, 18 Mar 2009 23:00:55 -0600
Message-ID: <20090319050055.11320.62033.stgit@localhost.localdomain>
In-Reply-To: <20090319050015.11320.61641.stgit@localhost.localdomain>
References: <20090319050015.11320.61641.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This patch simplifies the driver by making use of more common code.
    
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/net/pasemi_mac.c |   19 +++----------------
 drivers/net/pasemi_mac.h |    1 -
 2 files changed, 3 insertions(+), 17 deletions(-)


diff --git a/drivers/net/pasemi_mac.c b/drivers/net/pasemi_mac.c
index d0349e7..8c92d1f 100644
--- a/drivers/net/pasemi_mac.c
+++ b/drivers/net/pasemi_mac.c
@@ -1086,34 +1086,21 @@ static int pasemi_mac_phy_init(struct net_device *dev)
 	struct pasemi_mac *mac = netdev_priv(dev);
 	struct device_node *dn, *phy_dn;
 	struct phy_device *phydev;
-	unsigned int phy_id;
 	const phandle *ph;
 	const unsigned int *prop;
 	struct resource r;
 	int ret;
 
 	dn = pci_device_to_OF_node(mac->pdev);
-	ph = of_get_property(dn, "phy-handle", NULL);
-	if (!ph)
-		return -ENODEV;
-	phy_dn = of_find_node_by_phandle(*ph);
-
-	prop = of_get_property(phy_dn, "reg", NULL);
-	ret = of_address_to_resource(phy_dn->parent, 0, &r);
-	if (ret)
-		goto err;
-
-	phy_id = *prop;
-	snprintf(mac->phy_id, sizeof(mac->phy_id), "%x:%02x",
-		 (int)r.start, phy_id);
-
+	phy_dn = of_parse_phandle(dn, "phy-handle", 0);
 	of_node_put(phy_dn);
 
 	mac->link = 0;
 	mac->speed = 0;
 	mac->duplex = -1;
 
-	phydev = phy_connect(dev, mac->phy_id, &pasemi_adjust_link, 0, PHY_INTERFACE_MODE_SGMII);
+	phydev = of_phy_connect(dev, phy_dn, &pasemi_adjust_link, 0,
+				PHY_INTERFACE_MODE_SGMII);
 
 	if (IS_ERR(phydev)) {
 		printk(KERN_ERR "%s: Could not attach to phy\n", dev->name);
diff --git a/drivers/net/pasemi_mac.h b/drivers/net/pasemi_mac.h
index 1a115ec..e2f4efa 100644
--- a/drivers/net/pasemi_mac.h
+++ b/drivers/net/pasemi_mac.h
@@ -100,7 +100,6 @@ struct pasemi_mac {
 	int	duplex;
 
 	unsigned int	msg_enable;
-	char	phy_id[BUS_ID_SIZE];
 };
 
 /* Software status descriptor (ring_info) */
