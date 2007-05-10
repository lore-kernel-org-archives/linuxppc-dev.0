Return-Path: <mgreer@mvista.com>
Date: Thu, 10 May 2007 13:07:31 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 7/13] powerpc: Create Marvell mv64x60 ethernet platform_data
Message-ID: <20070510200731.GH19756@mag.az.mvista.com>
References: <20070510200237.GA19756@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070510200237.GA19756@mag.az.mvista.com>
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

This patch creates platform_device entries for the Marvell mv64x60
ethernet controller ports, based on information contained in the
device tree.

This driver (like the other mv64x60 drivers) are unusual in that it
works on both the MIPS and PowerPC architectures.  Because of that,
the drivers do not support the normal PowerPC of_platform_bus_type.
They support platform_bus_type instead.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/sysdev/mv64x60_dev.c |  127 ++++++++++++++++++++++++++++
 drivers/net/Kconfig               |    2 
 2 files changed, 128 insertions(+), 1 deletion(-)

Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60_dev.c
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/sysdev/mv64x60_dev.c
+++ linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60_dev.c
@@ -201,6 +201,128 @@ error:
 	return err;
 }
 
+/*
+ * Create mv64x60_eth platform devices
+ */
+static int __init eth_register_shared_pdev(struct device_node *np)
+{
+	struct platform_device *pdev;
+	struct resource r[1];
+	int err;
+
+	np = of_get_parent(np);
+	if (!np)
+		return -ENODEV;
+
+	err = of_address_to_resource(np, 0, &r[0]);
+	of_node_put(np);
+	if (err)
+		return err;
+
+	pdev = platform_device_register_simple(MV643XX_ETH_SHARED_NAME, 0,
+					       r, 1);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return 0;
+}
+
+static int __init mv64x60_eth_device_setup(struct device_node *np, int id)
+{
+	struct resource r[1];
+	struct mv643xx_eth_platform_data pdata;
+	struct platform_device *pdev;
+	struct device_node *phy;
+	const u8 *mac_addr;
+	const int *prop;
+	const phandle *ph;
+	int err;
+
+	/* only register the shared platform device the first time through */
+	if (id == 0 && (err = eth_register_shared_pdev(np)))
+		return err;;
+
+	memset(r, 0, sizeof(r));
+	of_irq_to_resource(np, 0, &r[0]);
+
+	memset(&pdata, 0, sizeof(pdata));
+
+	prop = of_get_property(np, "block-index", NULL);
+	if (!prop)
+		return -ENODEV;
+	pdata.port_number = *prop;
+
+	mac_addr = of_get_mac_address(np);
+	if (mac_addr)
+		memcpy(pdata.mac_addr, mac_addr, 6);
+
+	prop = of_get_property(np, "speed", NULL);
+	if (prop)
+		pdata.speed = *prop;
+
+	prop = of_get_property(np, "tx_queue_size", NULL);
+	if (prop)
+		pdata.tx_queue_size = *prop;
+
+	prop = of_get_property(np, "rx_queue_size", NULL);
+	if (prop)
+		pdata.rx_queue_size = *prop;
+
+	prop = of_get_property(np, "tx_sram_addr", NULL);
+	if (prop)
+		pdata.tx_sram_addr = *prop;
+
+	prop = of_get_property(np, "tx_sram_size", NULL);
+	if (prop)
+		pdata.tx_sram_size = *prop;
+
+	prop = of_get_property(np, "rx_sram_addr", NULL);
+	if (prop)
+		pdata.rx_sram_addr = *prop;
+
+	prop = of_get_property(np, "rx_sram_size", NULL);
+	if (prop)
+		pdata.rx_sram_size = *prop;
+
+	ph = of_get_property(np, "phy", NULL);
+	if (!ph)
+		return -ENODEV;
+
+	phy = of_find_node_by_phandle(*ph);
+	if (phy == NULL)
+		return -ENODEV;
+
+	prop = of_get_property(phy, "reg", NULL);
+	if (prop) {
+		pdata.force_phy_addr = 1;
+		pdata.phy_addr = *prop;
+	}
+
+	of_node_put(phy);
+
+	pdev = platform_device_alloc(MV643XX_ETH_NAME, pdata.port_number);
+	if (!pdev)
+		return -ENOMEM;
+
+	err = platform_device_add_resources(pdev, r, 1);
+	if (err)
+		goto error;
+
+	err = platform_device_add_data(pdev, &pdata, sizeof(pdata));
+	if (err)
+		goto error;
+
+	err = platform_device_add(pdev);
+	if (err)
+		goto error;
+
+	return 0;
+
+error:
+	platform_device_put(pdev);
+	return err;
+}
+
 static int __init mv64x60_device_setup(void)
 {
 	struct device_node *np = NULL;
@@ -212,6 +334,11 @@ static int __init mv64x60_device_setup(v
 		if ((err = mv64x60_mpsc_device_setup(np, id)))
 			goto error;
 
+	for (id = 0;
+	     (np = of_find_compatible_node(np, "network", "mv64x60-eth")); id++)
+		if ((err = mv64x60_eth_device_setup(np, id)))
+			goto error;
+
 	return 0;
 
 error:
Index: linux-2.6-powerpc-df/drivers/net/Kconfig
===================================================================
--- linux-2.6-powerpc-df.orig/drivers/net/Kconfig
+++ linux-2.6-powerpc-df/drivers/net/Kconfig
@@ -2299,7 +2299,7 @@ config UGETH_TX_ON_DEMAND
 
 config MV643XX_ETH
 	tristate "MV-643XX Ethernet support"
-	depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX || MV64360 || MOMENCO_OCELOT_3 || (PPC_MULTIPLATFORM && PPC32)
+	depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX || MV64360 || MV64X60 || MOMENCO_OCELOT_3 || (PPC_MULTIPLATFORM && PPC32)
 	select MII
 	help
 	  This driver supports the gigabit Ethernet on the Marvell MV643XX
