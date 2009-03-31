Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 8CE5BDE05A
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 19:27:38 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so1472031waf.9
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 01:27:38 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 10/14] net: Rework ucc_geth driver to use of_mdio
	infrastructure
To: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Date: Tue, 31 Mar 2009 02:27:35 -0600
Message-ID: <20090331082735.1427.92022.stgit@localhost.localdomain>
In-Reply-To: <20090331075537.1427.7819.stgit@localhost.localdomain>
References: <20090331075537.1427.7819.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: olof@lixom.net, afleming@freescale.com,
	Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
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

 drivers/net/ucc_geth.c |   47 ++++++++++++-----------------------------------
 drivers/net/ucc_geth.h |    2 +-
 2 files changed, 13 insertions(+), 36 deletions(-)


diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 933fcfb..471a30a 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -28,6 +28,7 @@
 #include <linux/mii.h>
 #include <linux/phy.h>
 #include <linux/workqueue.h>
+#include <linux/of_mdio.h>
 #include <linux/of_platform.h>
 
 #include <asm/uaccess.h>
@@ -1543,12 +1544,14 @@ static int init_phy(struct net_device *dev)
 	priv->oldspeed = 0;
 	priv->oldduplex = -1;
 
-	phydev = phy_connect(dev, ug_info->phy_bus_id, &adjust_link, 0,
-			     priv->phy_interface);
+	if (!ug_info->phy_node)
+		return 0;
 
-	if (IS_ERR(phydev)) {
+	phydev = of_phy_connect(dev, ug_info->phy_node, &adjust_link, 0,
+				priv->phy_interface);
+	if (!phydev) {
 		printk("%s: Could not attach to PHY\n", dev->name);
-		return PTR_ERR(phydev);
+		return -ENODEV;
 	}
 
 	phydev->supported &= (ADVERTISED_10baseT_Half |
@@ -3520,14 +3523,12 @@ static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *ma
 {
 	struct device *device = &ofdev->dev;
 	struct device_node *np = ofdev->node;
-	struct device_node *mdio;
 	struct net_device *dev = NULL;
 	struct ucc_geth_private *ugeth = NULL;
 	struct ucc_geth_info *ug_info;
 	struct resource res;
 	struct device_node *phy;
 	int err, ucc_num, max_speed = 0;
-	const phandle *ph;
 	const u32 *fixed_link;
 	const unsigned int *prop;
 	const char *sprop;
@@ -3627,45 +3628,21 @@ static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *ma
 	ug_info->uf_info.irq = irq_of_parse_and_map(np, 0);
 	fixed_link = of_get_property(np, "fixed-link", NULL);
 	if (fixed_link) {
-		snprintf(ug_info->phy_bus_id, sizeof(ug_info->phy_bus_id),
-			 PHY_ID_FMT, "0", fixed_link[0]);
 		phy = NULL;
 	} else {
-		char bus_name[MII_BUS_ID_SIZE];
-
-		ph = of_get_property(np, "phy-handle", NULL);
-		phy = of_find_node_by_phandle(*ph);
-
+		phy = of_parse_phandle(np, "phy-handle", 0);
 		if (phy == NULL)
 			return -ENODEV;
-
-		/* set the PHY address */
-		prop = of_get_property(phy, "reg", NULL);
-		if (prop == NULL)
-			return -1;
-
-		/* Set the bus id */
-		mdio = of_get_parent(phy);
-
-		if (mdio == NULL)
-			return -ENODEV;
-
-		err = of_address_to_resource(mdio, 0, &res);
-
-		if (err) {
-			of_node_put(mdio);
-			return err;
-		}
-		fsl_pq_mdio_bus_name(bus_name, mdio);
-		of_node_put(mdio);
-		snprintf(ug_info->phy_bus_id, sizeof(ug_info->phy_bus_id),
-			"%s:%02x", bus_name, *prop);
 	}
+	ug_info->phy_node = phy;
 
 	/* get the phy interface type, or default to MII */
 	prop = of_get_property(np, "phy-connection-type", NULL);
 	if (!prop) {
 		/* handle interface property present in old trees */
+		if (!phy)
+			return -ENODEV;
+
 		prop = of_get_property(phy, "interface", NULL);
 		if (prop != NULL) {
 			phy_interface = enet_to_phy_interface[*prop];
diff --git a/drivers/net/ucc_geth.h b/drivers/net/ucc_geth.h
index e3a25e6..77e01de 100644
--- a/drivers/net/ucc_geth.h
+++ b/drivers/net/ucc_geth.h
@@ -1101,7 +1101,7 @@ struct ucc_geth_info {
 	u32 eventRegMask;
 	u16 pausePeriod;
 	u16 extensionField;
-	char phy_bus_id[BUS_ID_SIZE];
+	struct device_node *phy_node;
 	u8 weightfactor[NUM_TX_QUEUES];
 	u8 interruptcoalescingmaxvalue[NUM_RX_QUEUES];
 	u8 l2qt[UCC_GETH_VLAN_PRIORITY_MAX];
