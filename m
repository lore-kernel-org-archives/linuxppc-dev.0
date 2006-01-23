Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5E109681BD
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jan 2006 10:05:18 +1100 (EST)
Date: Mon, 23 Jan 2006 16:58:04 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: cleaned up fsl_soc.c
Message-ID: <Pine.LNX.4.44.0601231657380.19842-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Cleaned up fsl_soc.c based on comments from Olof Johansson.  Ran through
Lindent, and split gfar_mdio init into its own function.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 9a8e139654ff5807b5b8fc3f73e9d118f22a3947
tree 04fed9acbcb1565682808ac49946898ddc18a153
parent b87359141569cb0fb0fad4ba6fed7de04ec22af9
author Kumar Gala <galak@kernel.crashing.org> Mon, 23 Jan 2006 17:04:23 -0600
committer Kumar Gala <galak@kernel.crashing.org> Mon, 23 Jan 2006 17:04:23 -0600

 arch/powerpc/sysdev/fsl_soc.c |  152 +++++++++++++++++++++++++----------------
 1 files changed, 94 insertions(+), 58 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 064c9de..e0887d5 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -40,7 +40,7 @@ phys_addr_t get_immrbase(void)
 		return immrbase;
 
 	soc = of_find_node_by_type(NULL, "soc");
-	if (soc != 0) {
+	if (soc) {
 		unsigned int size;
 		void *prop = get_property(soc, "reg", &size);
 		immrbase = of_translate_address(soc, prop);
@@ -49,21 +49,20 @@ phys_addr_t get_immrbase(void)
 
 	return immrbase;
 }
-EXPORT_SYMBOL(get_immrbase);
 
-static const char * gfar_tx_intr = "tx";
-static const char * gfar_rx_intr = "rx";
-static const char * gfar_err_intr = "error";
+EXPORT_SYMBOL(get_immrbase);
 
-static int __init gfar_of_init(void)
+static int __init gfar_mdio_of_init(void)
 {
 	struct device_node *np;
 	unsigned int i;
-	struct platform_device *mdio_dev, *gfar_dev;
+	struct platform_device *mdio_dev;
 	struct resource res;
 	int ret;
 
-	for (np = NULL, i = 0; (np = of_find_compatible_node(np, "mdio", "gianfar")) != NULL; i++) {
+	for (np = NULL, i = 0;
+	     (np = of_find_compatible_node(np, "mdio", "gianfar")) != NULL;
+	     i++) {
 		int k;
 		struct device_node *child = NULL;
 		struct gianfar_mdio_data mdio_data;
@@ -73,12 +72,14 @@ static int __init gfar_of_init(void)
 
 		ret = of_address_to_resource(np, 0, &res);
 		if (ret)
-			goto mdio_err;
+			goto err;
 
-		mdio_dev = platform_device_register_simple("fsl-gianfar_mdio", res.start, &res, 1);
+		mdio_dev =
+		    platform_device_register_simple("fsl-gianfar_mdio",
+						    res.start, &res, 1);
 		if (IS_ERR(mdio_dev)) {
 			ret = PTR_ERR(mdio_dev);
-			goto mdio_err;
+			goto err;
 		}
 
 		for (k = 0; k < 32; k++)
@@ -86,17 +87,44 @@ static int __init gfar_of_init(void)
 
 		while ((child = of_get_next_child(np, child)) != NULL) {
 			if (child->n_intrs) {
-				u32 *id = (u32 *) get_property(child, "reg", NULL);
+				u32 *id =
+				    (u32 *) get_property(child, "reg", NULL);
 				mdio_data.irq[*id] = child->intrs[0].line;
 			}
 		}
 
-		ret = platform_device_add_data(mdio_dev, &mdio_data, sizeof(struct gianfar_mdio_data));
+		ret =
+		    platform_device_add_data(mdio_dev, &mdio_data,
+					     sizeof(struct gianfar_mdio_data));
 		if (ret)
-			goto mdio_unreg;
+			goto unreg;
 	}
 
-	for (np = NULL, i = 0; (np = of_find_compatible_node(np, "network", "gianfar")) != NULL; i++) {
+	return 0;
+
+unreg:
+	platform_device_unregister(mdio_dev);
+err:
+	return ret;
+}
+
+arch_initcall(gfar_mdio_of_init);
+
+static const char *gfar_tx_intr = "tx";
+static const char *gfar_rx_intr = "rx";
+static const char *gfar_err_intr = "error";
+
+static int __init gfar_of_init(void)
+{
+	struct device_node *np;
+	unsigned int i;
+	struct platform_device *gfar_dev;
+	struct resource res;
+	int ret;
+
+	for (np = NULL, i = 0;
+	     (np = of_find_compatible_node(np, "network", "gianfar")) != NULL;
+	     i++) {
 		struct resource r[4];
 		struct device_node *phy, *mdio;
 		struct gianfar_platform_data gfar_data;
@@ -110,7 +138,7 @@ static int __init gfar_of_init(void)
 
 		ret = of_address_to_resource(np, 0, &r[0]);
 		if (ret)
-			goto gfar_err;
+			goto err;
 
 		r[1].start = np->intrs[0].line;
 		r[1].end = np->intrs[0].line;
@@ -133,11 +161,13 @@ static int __init gfar_of_init(void)
 			r[3].flags = IORESOURCE_IRQ;
 		}
 
-		gfar_dev = platform_device_register_simple("fsl-gianfar", i, &r[0], np->n_intrs + 1);
+		gfar_dev =
+		    platform_device_register_simple("fsl-gianfar", i, &r[0],
+						    np->n_intrs + 1);
 
 		if (IS_ERR(gfar_dev)) {
 			ret = PTR_ERR(gfar_dev);
-			goto gfar_err;
+			goto err;
 		}
 
 		mac_addr = get_property(np, "address", NULL);
@@ -145,26 +175,26 @@ static int __init gfar_of_init(void)
 
 		if (model && !strcasecmp(model, "TSEC"))
 			gfar_data.device_flags =
-				FSL_GIANFAR_DEV_HAS_GIGABIT |
-				FSL_GIANFAR_DEV_HAS_COALESCE |
-				FSL_GIANFAR_DEV_HAS_RMON |
-				FSL_GIANFAR_DEV_HAS_MULTI_INTR;
+			    FSL_GIANFAR_DEV_HAS_GIGABIT |
+			    FSL_GIANFAR_DEV_HAS_COALESCE |
+			    FSL_GIANFAR_DEV_HAS_RMON |
+			    FSL_GIANFAR_DEV_HAS_MULTI_INTR;
 		if (model && !strcasecmp(model, "eTSEC"))
 			gfar_data.device_flags =
-				FSL_GIANFAR_DEV_HAS_GIGABIT |
-				FSL_GIANFAR_DEV_HAS_COALESCE |
-				FSL_GIANFAR_DEV_HAS_RMON |
-				FSL_GIANFAR_DEV_HAS_MULTI_INTR |
-				FSL_GIANFAR_DEV_HAS_CSUM |
-				FSL_GIANFAR_DEV_HAS_VLAN |
-				FSL_GIANFAR_DEV_HAS_EXTENDED_HASH;
+			    FSL_GIANFAR_DEV_HAS_GIGABIT |
+			    FSL_GIANFAR_DEV_HAS_COALESCE |
+			    FSL_GIANFAR_DEV_HAS_RMON |
+			    FSL_GIANFAR_DEV_HAS_MULTI_INTR |
+			    FSL_GIANFAR_DEV_HAS_CSUM |
+			    FSL_GIANFAR_DEV_HAS_VLAN |
+			    FSL_GIANFAR_DEV_HAS_EXTENDED_HASH;
 
 		ph = (phandle *) get_property(np, "phy-handle", NULL);
 		phy = of_find_node_by_phandle(*ph);
 
 		if (phy == NULL) {
 			ret = -ENODEV;
-			goto gfar_unreg;
+			goto unreg;
 		}
 
 		mdio = of_get_parent(phy);
@@ -174,7 +204,7 @@ static int __init gfar_of_init(void)
 		if (ret) {
 			of_node_put(phy);
 			of_node_put(mdio);
-			goto gfar_unreg;
+			goto unreg;
 		}
 
 		gfar_data.phy_id = *id;
@@ -183,23 +213,22 @@ static int __init gfar_of_init(void)
 		of_node_put(phy);
 		of_node_put(mdio);
 
-		ret = platform_device_add_data(gfar_dev, &gfar_data, sizeof(struct gianfar_platform_data));
+		ret =
+		    platform_device_add_data(gfar_dev, &gfar_data,
+					     sizeof(struct
+						    gianfar_platform_data));
 		if (ret)
-			goto gfar_unreg;
+			goto unreg;
 	}
 
 	return 0;
 
-mdio_unreg:
-	platform_device_unregister(mdio_dev);
-mdio_err:
-	return ret;
-
-gfar_unreg:
+unreg:
 	platform_device_unregister(gfar_dev);
-gfar_err:
+err:
 	return ret;
 }
+
 arch_initcall(gfar_of_init);
 
 static int __init fsl_i2c_of_init(void)
@@ -209,17 +238,19 @@ static int __init fsl_i2c_of_init(void)
 	struct platform_device *i2c_dev;
 	int ret;
 
-	for (np = NULL, i = 0; (np = of_find_compatible_node(np, "i2c", "fsl-i2c")) != NULL; i++) {
+	for (np = NULL, i = 0;
+	     (np = of_find_compatible_node(np, "i2c", "fsl-i2c")) != NULL;
+	     i++) {
 		struct resource r[2];
 		struct fsl_i2c_platform_data i2c_data;
-		unsigned char * flags = NULL;
+		unsigned char *flags = NULL;
 
 		memset(&r, 0, sizeof(r));
 		memset(&i2c_data, 0, sizeof(i2c_data));
 
 		ret = of_address_to_resource(np, 0, &r[0]);
 		if (ret)
-			goto i2c_err;
+			goto err;
 
 		r[1].start = np->intrs[0].line;
 		r[1].end = np->intrs[0].line;
@@ -228,7 +259,7 @@ static int __init fsl_i2c_of_init(void)
 		i2c_dev = platform_device_register_simple("fsl-i2c", i, r, 2);
 		if (IS_ERR(i2c_dev)) {
 			ret = PTR_ERR(i2c_dev);
-			goto i2c_err;
+			goto err;
 		}
 
 		i2c_data.device_flags = 0;
@@ -240,18 +271,22 @@ static int __init fsl_i2c_of_init(void)
 		if (flags)
 			i2c_data.device_flags |= FSL_I2C_DEV_CLOCK_5200;
 
-		ret = platform_device_add_data(i2c_dev, &i2c_data, sizeof(struct fsl_i2c_platform_data));
+		ret =
+		    platform_device_add_data(i2c_dev, &i2c_data,
+					     sizeof(struct
+						    fsl_i2c_platform_data));
 		if (ret)
-			goto i2c_unreg;
+			goto unreg;
 	}
 
 	return 0;
 
-i2c_unreg:
+unreg:
 	platform_device_unregister(i2c_dev);
-i2c_err:
+err:
 	return ret;
 }
+
 arch_initcall(fsl_i2c_of_init);
 
 #ifdef CONFIG_PPC_83xx
@@ -267,51 +302,52 @@ static int __init mpc83xx_wdt_init(void)
 
 	if (!np) {
 		ret = -ENODEV;
-		goto mpc83xx_wdt_nodev;
+		goto nodev;
 	}
 
 	soc = of_find_node_by_type(NULL, "soc");
 
 	if (!soc) {
 		ret = -ENODEV;
-		goto mpc83xx_wdt_nosoc;
+		goto nosoc;
 	}
 
 	freq = (unsigned int *)get_property(soc, "bus-frequency", NULL);
 	if (!freq) {
 		ret = -ENODEV;
-		goto mpc83xx_wdt_err;
+		goto err;
 	}
 
 	memset(&r, 0, sizeof(r));
 
 	ret = of_address_to_resource(np, 0, &r);
 	if (ret)
-		goto mpc83xx_wdt_err;
+		goto err;
 
 	dev = platform_device_register_simple("mpc83xx_wdt", 0, &r, 1);
 	if (IS_ERR(dev)) {
 		ret = PTR_ERR(dev);
-		goto mpc83xx_wdt_err;
+		goto err;
 	}
 
 	ret = platform_device_add_data(dev, freq, sizeof(int));
 	if (ret)
-		goto mpc83xx_wdt_unreg;
+		goto unreg;
 
 	of_node_put(soc);
 	of_node_put(np);
 
 	return 0;
 
-mpc83xx_wdt_unreg:
+unreg:
 	platform_device_unregister(dev);
-mpc83xx_wdt_err:
+err:
 	of_node_put(soc);
-mpc83xx_wdt_nosoc:
+nosoc:
 	of_node_put(np);
-mpc83xx_wdt_nodev:
+nodev:
 	return ret;
 }
+
 arch_initcall(mpc83xx_wdt_init);
 #endif
