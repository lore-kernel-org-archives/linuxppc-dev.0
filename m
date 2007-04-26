Return-Path: <mgreer@mvista.com>
Date: Wed, 25 Apr 2007 17:00:09 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 8/13] powerpc: Add arch/powerpc mv64x60_eth platform data setup
Message-ID: <20070426000009.GJ4046@mag.az.mvista.com>
References: <20070425234630.GA4046@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070425234630.GA4046@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Dale Farnsworth <dale@farnsworth.org>

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
---

 arch/powerpc/sysdev/mv64x60.c |  135 ++++++++++++++++++++++++++++++++++++++++++
 drivers/net/Kconfig           |    2 
 2 files changed, 136 insertions(+), 1 deletion(-)

Index: linux-2.6-powerpc-df/drivers/net/Kconfig
===================================================================
--- linux-2.6-powerpc-df.orig/drivers/net/Kconfig
+++ linux-2.6-powerpc-df/drivers/net/Kconfig
@@ -2301,7 +2301,7 @@ config UGETH_HAS_GIGA
 
 config MV643XX_ETH
 	tristate "MV-643XX Ethernet support"
-	depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX || MV64360 || MOMENCO_OCELOT_3 || (PPC_MULTIPLATFORM && PPC32)
+	depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX || MV64360 || MV64X60 || MOMENCO_OCELOT_3 || (PPC_MULTIPLATFORM && PPC32)
 	select MII
 	help
 	  This driver supports the gigabit Ethernet on the Marvell MV643XX
Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.c
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/sysdev/mv64x60.c
+++ linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.c
@@ -511,3 +511,138 @@ ret_node_put:
 }
 
 arch_initcall(mv64x60_mpsc_platform_device_init);
+
+/*
+ * Create mv64x60_eth platform device
+ */
+static int __init eth_register_shared_pdev(struct device_node *np)
+{
+	struct platform_device *pdev;
+	struct resource res;
+	int err;
+
+	np = of_get_parent(np);
+	if (!np)
+		return -ENODEV;
+
+	err = of_address_to_resource(np, 0, &res);
+	of_node_put(np);
+	if (err)
+		return err;
+
+	pdev = platform_device_register_simple(MV643XX_ETH_SHARED_NAME, 0,
+					       &res, 1);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return 0;
+}
+
+static int __init mv64x60_eth_platform_device_init(void)
+{
+	struct device_node *np = NULL;
+	unsigned int i;
+	struct platform_device *pdev;
+	int err;
+
+	for (i = 0;
+	     (np = of_find_compatible_node(np, "network", "mv64x60-eth"));
+	     i++) {
+		struct device_node *phy;
+		struct mv643xx_eth_platform_data pdata;
+		const u8 *mac_addr;
+		const void *prop;
+		const phandle *ph;
+		struct resource res;
+
+		if (i == 0) {
+			err = eth_register_shared_pdev(np);
+			if (err)
+				goto ret_node_put;
+		}
+
+		memset(&res, 0, sizeof(res));
+		of_irq_to_resource(np, 0, &res);
+
+		pdev = platform_device_register_simple(MV643XX_ETH_NAME,
+						       i, &res, 1);
+		if (IS_ERR(pdev)) {
+			err = PTR_ERR(pdev);
+			goto ret_node_put;
+		}
+
+		memset(&pdata, 0, sizeof(pdata));
+
+		prop = of_get_property(np, "block-index", NULL);
+		if (prop)
+			pdata.port_number = *(int *)prop;
+		else
+			pdata.port_number = i;
+
+		mac_addr = of_get_mac_address(np);
+		if (mac_addr)
+			memcpy(pdata.mac_addr, mac_addr, 6);
+
+		prop = of_get_property(np, "speed", NULL);
+		if (prop)
+			pdata.speed = *(int *)prop;
+
+		prop = of_get_property(np, "tx_queue_size", NULL);
+		if (prop)
+			pdata.tx_queue_size = *(int *)prop;
+
+		prop = of_get_property(np, "rx_queue_size", NULL);
+		if (prop)
+			pdata.rx_queue_size = *(int *)prop;
+
+		prop = of_get_property(np, "tx_sram_addr", NULL);
+		if (prop)
+			pdata.tx_sram_addr = *(int *)prop;
+
+		prop = of_get_property(np, "tx_sram_size", NULL);
+		if (prop)
+			pdata.tx_sram_size = *(int *)prop;
+
+		prop = of_get_property(np, "rx_sram_addr", NULL);
+		if (prop)
+			pdata.rx_sram_addr = *(int *)prop;
+
+		prop = of_get_property(np, "rx_sram_size", NULL);
+		if (prop)
+			pdata.rx_sram_size = *(int *)prop;
+
+		ph = of_get_property(np, "phy", NULL);
+		if (!ph) {
+			err = -ENODEV;
+			goto ret_unreg;
+		}
+
+		phy = of_find_node_by_phandle(*ph);
+		if (phy == NULL) {
+			err = -ENODEV;
+			goto ret_unreg;
+		}
+
+		prop = of_get_property(phy, "reg", NULL);
+		if (prop) {
+			pdata.force_phy_addr = 1;
+			pdata.phy_addr = *(int *)prop;
+		}
+
+		of_node_put(phy);
+
+		err = platform_device_add_data(pdev, &pdata, sizeof(pdata));
+		if (err)
+			goto ret_unreg;
+	}
+
+	return 0;
+
+ret_unreg:
+	platform_device_unregister(pdev);
+ret_node_put:
+	of_node_put(np);
+	return err;
+}
+
+arch_initcall(mv64x60_eth_platform_device_init);
