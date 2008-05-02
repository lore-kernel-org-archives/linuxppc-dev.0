Return-Path: <afleming@ld0175-tx32.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87C61DE67C
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 04:04:00 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m42I3pDW013023
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 11:03:51 -0700 (MST)
Received: from ld0175-tx32.am.freescale.net (ld0175-tx32.am.freescale.net
	[10.82.19.125])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m42I3oZ6019701
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 13:03:50 -0500 (CDT)
From: Andy Fleming <afleming@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH v2.6.26] powerpc: Add support for multiple gfar mdio interfaces
Date: Fri,  2 May 2008 13:03:50 -0500
Message-Id: <1209751430-25656-1-git-send-email-afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The old code assumed there was only one, but the 8572 actually has 3.

Also, our usual id, 0xe0024520, gets resolved to -1 somewhere, and this was
preventing the multiple buses from having different ids.  So we only keep
the low 20 bits, which have the interesting info, anyway.

Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.c |   84 ++++++++++++++++++----------------------
 1 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 3a7054e..52f52b2 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -207,66 +207,58 @@ static int __init of_add_fixed_phys(void)
 arch_initcall(of_add_fixed_phys);
 #endif /* CONFIG_FIXED_PHY */
 
-static int __init gfar_mdio_of_init(void)
+static int gfar_mdio_of_init_one(struct device_node *np)
 {
-	struct device_node *np = NULL;
+	int k;
+	struct device_node *child = NULL;
+	struct gianfar_mdio_data mdio_data;
 	struct platform_device *mdio_dev;
 	struct resource res;
 	int ret;
 
-	np = of_find_compatible_node(np, NULL, "fsl,gianfar-mdio");
-
-	/* try the deprecated version */
-	if (!np)
-		np = of_find_compatible_node(np, "mdio", "gianfar");
+	memset(&res, 0, sizeof(res));
+	memset(&mdio_data, 0, sizeof(mdio_data));
 
-	if (np) {
-		int k;
-		struct device_node *child = NULL;
-		struct gianfar_mdio_data mdio_data;
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret)
+		return ret;
 
-		memset(&res, 0, sizeof(res));
-		memset(&mdio_data, 0, sizeof(mdio_data));
+	mdio_dev = platform_device_register_simple("fsl-gianfar_mdio",
+			res.start&0xfffff, &res, 1);
+	if (IS_ERR(mdio_dev))
+		return PTR_ERR(mdio_dev);
 
-		ret = of_address_to_resource(np, 0, &res);
-		if (ret)
-			goto err;
+	for (k = 0; k < 32; k++)
+		mdio_data.irq[k] = PHY_POLL;
 
-		mdio_dev =
-		    platform_device_register_simple("fsl-gianfar_mdio",
-						    res.start, &res, 1);
-		if (IS_ERR(mdio_dev)) {
-			ret = PTR_ERR(mdio_dev);
-			goto err;
+	while ((child = of_get_next_child(np, child)) != NULL) {
+		int irq = irq_of_parse_and_map(child, 0);
+		if (irq != NO_IRQ) {
+			const u32 *id = of_get_property(child, "reg", NULL);
+			mdio_data.irq[*id] = irq;
 		}
+	}
 
-		for (k = 0; k < 32; k++)
-			mdio_data.irq[k] = PHY_POLL;
+	ret = platform_device_add_data(mdio_dev, &mdio_data,
+				sizeof(struct gianfar_mdio_data));
+	if (ret)
+		platform_device_unregister(mdio_dev);
 
-		while ((child = of_get_next_child(np, child)) != NULL) {
-			int irq = irq_of_parse_and_map(child, 0);
-			if (irq != NO_IRQ) {
-				const u32 *id = of_get_property(child,
-							"reg", NULL);
-				mdio_data.irq[*id] = irq;
-			}
-		}
+	return ret;
+}
 
-		ret =
-		    platform_device_add_data(mdio_dev, &mdio_data,
-					     sizeof(struct gianfar_mdio_data));
-		if (ret)
-			goto unreg;
-	}
+static int __init gfar_mdio_of_init(void)
+{
+	struct device_node *np = NULL;
 
-	of_node_put(np);
-	return 0;
+	for_each_compatible_node(np, NULL, "fsl,gianfar-mdio")
+		gfar_mdio_of_init_one(np);
 
-unreg:
-	platform_device_unregister(mdio_dev);
-err:
-	of_node_put(np);
-	return ret;
+	/* try the deprecated version */
+	for_each_compatible_node(np, "mdio", "gianfar");
+		gfar_mdio_of_init_one(np);
+
+	return 0;
 }
 
 arch_initcall(gfar_mdio_of_init);
@@ -390,7 +382,7 @@ static int __init gfar_of_init(void)
 
 			gfar_data.phy_id = *id;
 			snprintf(gfar_data.bus_id, MII_BUS_ID_SIZE, "%llx",
-				 (unsigned long long)res.start);
+				 (unsigned long long)res.start&0xfffff);
 
 			of_node_put(phy);
 			of_node_put(mdio);
-- 
1.5.4.GIT
