Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 87ECDDDFA6
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 04:49:42 +1000 (EST)
Subject: [PATCH] ucc_geth.c, make PHY device optional.
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>,
	Netdev <netdev@vger.kernel.org>, Li Yang-r58472 <LeoLi@freescale.com>
Content-Type: text/plain
Date: Fri, 29 Jun 2007 20:49:40 +0200
Message-Id: <1183142980.20673.89.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes the PHY optional for ucc_geth.c ethernet driver.
This is useful to support a direct mii to mii connection to, for example,
a onboard swicth.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>
----
diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 32bb748..8630294 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -2273,7 +2273,8 @@ static void ucc_geth_stop(struct ucc_geth_private *ugeth)
 	ugeth_disable(ugeth, COMM_DIR_RX_AND_TX);
 
 	/* Tell the kernel the link is down */
-	phy_stop(phydev);
+	if (phydev)
+		phy_stop(phydev);
 
 	/* Mask all interrupts */
 	out_be32(ugeth->uccf->p_ucce, 0x00000000);
@@ -3687,14 +3688,16 @@ static int ucc_geth_open(struct net_device *dev)
 				   dev->dev_addr[5],
 				   &ugeth->ug_regs->macstnaddr1,
 				   &ugeth->ug_regs->macstnaddr2);
-
-	err = init_phy(dev);
+	err = 0;
+	if (ugeth->ug_info->mdio_bus != ~0)
+		err = init_phy(dev);
 	if (err) {
 		ugeth_err("%s: Cannot initialize PHY, aborting.", dev->name);
 		return err;
 	}
 
-	phy_start(ugeth->phydev);
+	if (ugeth->phydev)
+		phy_start(ugeth->phydev);
 
 	err =
 	    request_irq(ugeth->ug_info->uf_info.irq, ucc_geth_irq_handler, 0,
@@ -3726,8 +3729,9 @@ static int ucc_geth_close(struct net_device *dev)
 	ugeth_vdbg("%s: IN", __FUNCTION__);
 
 	ucc_geth_stop(ugeth);
-
-	phy_disconnect(ugeth->phydev);
+	
+	if (ugeth->phydev)
+		phy_disconnect(ugeth->phydev);
 	ugeth->phydev = NULL;
 
 	netif_stop_queue(dev);
@@ -3807,17 +3811,16 @@ static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *ma
 	ug_info->uf_info.irq = irq_of_parse_and_map(np, 0);
 
 	ph = of_get_property(np, "phy-handle", NULL);
-	phy = of_find_node_by_phandle(*ph);
-
-	if (phy == NULL)
-		return -ENODEV;
-
-	/* set the PHY address */
-	prop = of_get_property(phy, "reg", NULL);
-	if (prop == NULL)
-		return -1;
-	ug_info->phy_address = *prop;
-
+	if (ph != NULL) {
+		phy = of_find_node_by_phandle(*ph);
+		if (phy == NULL)
+			return -ENODEV;
+		/* set the PHY address */
+		prop = of_get_property(phy, "reg", NULL);
+		if (prop == NULL)
+			return -1;
+		ug_info->phy_address = *prop;
+	}
 	/* get the phy interface type, or default to MII */
 	prop = of_get_property(np, "phy-connection-type", NULL);
 	if (!prop) {
@@ -3857,19 +3860,22 @@ static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *ma
 		ug_info->uf_info.utftt = UCC_GETH_UTFTT_GIGA_INIT;
 	}
 
-	/* Set the bus id */
-	mdio = of_get_parent(phy);
+	ug_info->mdio_bus = ~0; /* Means no MDIO bus */
+	if (ph) {
+		/* Set the bus id */
+		mdio = of_get_parent(phy);
 
-	if (mdio == NULL)
-		return -1;
+		if (mdio == NULL)
+			return -1;
 
-	err = of_address_to_resource(mdio, 0, &res);
-	of_node_put(mdio);
+		err = of_address_to_resource(mdio, 0, &res);
+		of_node_put(mdio);
 
-	if (err)
-		return -1;
+		if (err)
+			return -1;
 
-	ug_info->mdio_bus = res.start;
+		ug_info->mdio_bus = res.start;
+	}
 
 	printk(KERN_INFO "ucc_geth: UCC%1d at 0x%8x (irq = %d) \n",
 		ug_info->uf_info.ucc_num + 1, ug_info->uf_info.regs,
