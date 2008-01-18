Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 54805DE27E
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 04:06:09 +1100 (EST)
Received: from pd3mr4so.prod.shaw.ca
	(pd3mr4so-qfe3.prod.shaw.ca [10.0.141.180]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JUU001JONGUR8B0@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 18 Jan 2008 10:05:18 -0700 (MST)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
	by pd3mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JUU001PZNGQMC30@pd3mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 18 Jan 2008 10:05:19 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JUU00MIANGPUP00@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 18 Jan 2008 10:05:13 -0700 (MST)
Date: Fri, 18 Jan 2008 10:04:49 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC/PATCH 1/2] [POWERPC] mpc5200: normalize compatible property
	bindings
In-reply-to: <20080118170324.10592.47360.stgit@trillian.secretlab.ca>
To: linuxppc-dev@ozlabs.org, jrigby@freescale.com, matt@genesi-usa.com,
	tnt@246tnt.com
Message-id: <20080118170443.10592.97538.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20080118170324.10592.47360.stgit@trillian.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Update MPC5200 drivers to also look for compatible properties in the
form "fsl,mpc5200-*" to better conform to open firmware generic names
recommended practice as published here:

http://www.openfirmware.org/1275/practice/gnames/gnamv14a.html

This patch should *not* break compatibility with older device trees
which do not use the 'fsl,' prefix.  The drivers will still bind against
the older names also.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/52xx/lite5200.c       |   14 +++++++-
 arch/powerpc/platforms/52xx/lite5200_pm.c    |    8 ++++-
 arch/powerpc/platforms/52xx/mpc52xx_common.c |   43 ++++++++++++++++----------
 arch/powerpc/platforms/52xx/mpc52xx_pci.c    |    9 ++++-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c    |   14 +++++++-
 arch/powerpc/platforms/52xx/mpc52xx_pm.c     |    8 ++++-
 arch/powerpc/sysdev/bestcomm/bestcomm.c      |   13 +++++---
 drivers/ata/pata_mpc52xx.c                   |    6 +---
 drivers/net/fec_mpc52xx.c                    |    6 +---
 drivers/net/fec_mpc52xx_phy.c                |    8 ++---
 drivers/serial/mpc52xx_uart.c                |    4 ++
 drivers/spi/mpc52xx_psc_spi.c                |    5 ++-
 drivers/usb/host/ohci-ppc-of.c               |    2 +
 13 files changed, 94 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index 5a8d190..f8ba5f2 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -44,9 +44,14 @@ lite5200_fix_clock_config(void)
 {
 	struct device_node *np;
 	struct mpc52xx_cdm  __iomem *cdm;
+	struct of_device_id cdm_ids[] = {
+		{ .compatible = "fsl,mpc5200-cdm", },
+		{ .compatible = "mpc5200-cdm", },
+		{}
+	};
 
 	/* Map zones */
-	np = of_find_compatible_node(NULL, NULL, "mpc5200-cdm");
+	np = of_find_matching_node(NULL, cdm_ids);
 	cdm = of_iomap(np, 0);
 	of_node_put(np);
 	if (!cdm) {
@@ -79,9 +84,14 @@ lite5200_fix_port_config(void)
 {
 	struct device_node *np;
 	struct mpc52xx_gpio __iomem *gpio;
+	struct of_device_id gpio_ids[] = {
+		{ .compatible = "fsl,mpc5200-gpio", },
+		{ .compatible = "mpc5200-gpio", },
+		{}
+	};
 	u32 port_config;
 
-	np = of_find_compatible_node(NULL, NULL, "mpc5200-gpio");
+	np = of_find_matching_node(NULL, gpio_ids);
 	gpio = of_iomap(np, 0);
 	of_node_put(np);
 	if (!gpio) {
diff --git a/arch/powerpc/platforms/52xx/lite5200_pm.c b/arch/powerpc/platforms/52xx/lite5200_pm.c
index c3ada1e..1679662 100644
--- a/arch/powerpc/platforms/52xx/lite5200_pm.c
+++ b/arch/powerpc/platforms/52xx/lite5200_pm.c
@@ -43,6 +43,12 @@ static int lite5200_pm_set_target(suspend_state_t state)
 static int lite5200_pm_prepare(void)
 {
 	struct device_node *np;
+	struct of_device_id immr_ids[] = {
+		{ .compatible = "fsl,mpc5200-immr", },
+		{ .type = "soc", .compatible = "mpc5200", }, /* lite5200 */
+		{ .type = "builtin", .compatible = "mpc5200", }, /* efika */
+		{}
+	};
 
 	/* deep sleep? let mpc52xx code handle that */
 	if (lite5200_pm_target_state == PM_SUSPEND_STANDBY)
@@ -52,7 +58,7 @@ static int lite5200_pm_prepare(void)
 		return -EINVAL;
 
 	/* map registers */
-	np = of_find_compatible_node(NULL, NULL, "mpc5200");
+	np = of_find_matching_node(NULL, immr_ids);
 	mbar = of_iomap(np, 0);
 	of_node_put(np);
 	if (!mbar) {
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 6695593..0211890 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -64,8 +64,13 @@ mpc5200_setup_xlb_arbiter(void)
 {
 	struct device_node *np;
 	struct mpc52xx_xlb  __iomem *xlb;
+	struct of_device_id xlb_ids[] = {
+		{ .compatible = "fsl,mpc5200-xlb", },
+		{ .compatible = "mpc5200-xlb", },
+		{}
+	};
 
-	np = of_find_compatible_node(NULL, NULL, "mpc5200-xlb");
+	np = of_find_matching_node(NULL, xlb_ids);
 	xlb = of_iomap(np, 0);
 	of_node_put(np);
 	if (!xlb) {
@@ -88,6 +93,9 @@ mpc5200_setup_xlb_arbiter(void)
 	iounmap(xlb);
 }
 
+/*
+ * Match table used by mpc52xx_declare_of_platform_devices
+ */
 static struct of_device_id mpc52xx_bus_ids[] __initdata= {
 	{ .compatible = "fsl,mpc5200-immr", },
 	{ .compatible = "fsl,lpb", },
@@ -95,9 +103,14 @@ static struct of_device_id mpc52xx_bus_ids[] __initdata= {
 	/* depreciated matches; shouldn't be used in new device trees */
 	{ .type = "builtin", .compatible = "mpc5200", }, /* efika */
 	{ .type = "soc", .compatible = "mpc5200", }, /* lite5200 */
-	{},
+	{}
 };
 
+/**
+ * mpc52xx_declare_of_platform_devices: register internal devices and children
+ *					of the localplus bus to the of_platform
+ *					bus.
+ */
 void __init
 mpc52xx_declare_of_platform_devices(void)
 {
@@ -107,33 +120,31 @@ mpc52xx_declare_of_platform_devices(void)
 			"Error while probing of_platform bus\n");
 }
 
+/*
+ * match tables used by mpc52xx_map_wdt()
+ */
+static struct of_device_id mpc52xx_gpt_ids[] __initdata = {
+	{ .compatible = "fsl,mpc5200-gpt", },
+	{ .compatible = "mpc5200-gpt", }, /* old */
+	{}
+};
+
 void __init
 mpc52xx_map_wdt(void)
 {
-	const void *has_wdt;
 	struct device_node *np;
-
 	/* mpc52xx_wdt is mapped here and used in mpc52xx_restart,
 	 * possibly from a interrupt context. wdt is only implement
 	 * on a gpt0, so check has-wdt property before mapping.
 	 */
-	for_each_compatible_node(np, NULL, "fsl,mpc5200-gpt") {
-		has_wdt = of_get_property(np, "fsl,has-wdt", NULL);
-		if (has_wdt) {
+	for_each_matching_node(np, mpc52xx_gpt_ids) {
+		if (of_get_property(np, "fsl,has-wdt", NULL) ||
+		    of_get_property(np, "has-wdt", NULL)) {
 			mpc52xx_wdt = of_iomap(np, 0);
 			of_node_put(np);
 			return;
 		}
 	}
-	for_each_compatible_node(np, NULL, "mpc5200-gpt") {
-		has_wdt = of_get_property(np, "has-wdt", NULL);
-		if (has_wdt) {
-			mpc52xx_wdt = of_iomap(np, 0);
-			of_node_put(np);
-			return;
-		}
-
-	}
 }
 
 void
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index 4b79398..0e71722 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -410,10 +410,13 @@ mpc52xx_add_bridge(struct device_node *node)
 void __init mpc52xx_setup_pci(void)
 {
 	struct device_node *pci;
+	struct of_device_id pci_ids[] = {
+		{ .type = "pci", .compatible = "fsl,mpc5200-pci", },
+		{ .type = "pci", .compatible = "mpc5200-pci", },
+		{}
+	};
 
-	pci = of_find_compatible_node(NULL, NULL, "fsl,mpc5200-pci");
-	if (!pci)
-		pci = of_find_compatible_node(NULL, NULL, "mpc5200-pci");
+	pci = of_find_matching_node(NULL, pci_ids);
 	if (!pci)
 		return;
 
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 07e8987..3f9d3cb 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -365,15 +365,25 @@ void __init mpc52xx_init_irq(void)
 	u32 intr_ctrl;
 	struct device_node *picnode;
 	struct device_node *np;
+	struct of_device_id pic_ids[] = {
+		{ .compatible = "fsl,mpc5200-pic", },
+		{ .compatible = "mpc5200-pic", },
+		{}
+	};
+	struct of_device_id sdma_ids[] = {
+		{ .compatible = "fsl,mpc5200-bestcomm", },
+		{ .compatible = "mpc5200-bestcomm", },
+		{}
+	};
 
 	/* Remap the necessary zones */
-	picnode = of_find_compatible_node(NULL, NULL, "mpc5200-pic");
+	picnode = of_find_matching_node(NULL, pic_ids);
 	intr = of_iomap(picnode, 0);
 	if (!intr)
 		panic(__FILE__	": find_and_map failed on 'mpc5200-pic'. "
 				"Check node !");
 
-	np = of_find_compatible_node(NULL, NULL, "mpc5200-bestcomm");
+	np = of_find_matching_node(NULL, sdma_ids);
 	sdma = of_iomap(np, 0);
 	of_node_put(np);
 	if (!sdma)
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pm.c b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
index 52f0277..722c8d4 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pm.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
@@ -60,9 +60,15 @@ int mpc52xx_set_wakeup_gpio(u8 pin, u8 level)
 int mpc52xx_pm_prepare(void)
 {
 	struct device_node *np;
+	struct of_device_id immr_ids[] = {
+		{ .compatible = "fsl,mpc5200-immr", },
+		{ .type = "soc", .compatible = "mpc5200", }, /* lite5200 */
+		{ .type = "builtin", .compatible = "mpc5200", }, /* efika */
+		{}
+	};
 
 	/* map the whole register space */
-	np = of_find_compatible_node(NULL, NULL, "mpc5200");
+	np = of_find_matching_node(NULL, immr_ids);
 	mbar = of_iomap(np, 0);
 	of_node_put(np);
 	if (!mbar) {
diff --git a/arch/powerpc/sysdev/bestcomm/bestcomm.c b/arch/powerpc/sysdev/bestcomm/bestcomm.c
index 740ad73..c6b04c6 100644
--- a/arch/powerpc/sysdev/bestcomm/bestcomm.c
+++ b/arch/powerpc/sysdev/bestcomm/bestcomm.c
@@ -363,6 +363,11 @@ mpc52xx_bcom_probe(struct of_device *op, const struct of_device_id *match)
 {
 	struct device_node *ofn_sram;
 	struct resource res_bcom;
+	struct of_device_id sram_ids[] = {
+		{ .compatible = "fsl,mpc5200-sram", },
+		{ .compatible = "mpc5200-sram", },
+		{}
+	};
 
 	int rv;
 
@@ -373,7 +378,7 @@ mpc52xx_bcom_probe(struct of_device *op, const struct of_device_id *match)
 	of_node_get(op->node);
 
 	/* Prepare SRAM */
-	ofn_sram = of_find_compatible_node(NULL, "sram", "mpc5200-sram");
+	ofn_sram = of_find_matching_node(NULL, sram_ids);
 	if (!ofn_sram) {
 		printk(KERN_ERR DRIVER_NAME ": "
 			"No SRAM found in device tree\n");
@@ -478,10 +483,8 @@ mpc52xx_bcom_remove(struct of_device *op)
 }
 
 static struct of_device_id mpc52xx_bcom_of_match[] = {
-	{
-		.type		= "dma-controller",
-		.compatible	= "mpc5200-bestcomm",
-	},
+	{ .type = "dma-controller", .compatible = "fsl,mpc5200-bestcomm", },
+	{ .type = "dma-controller", .compatible = "mpc5200-bestcomm", },
 	{},
 };
 
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 50c56e2..1a7ca37 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -494,10 +494,8 @@ mpc52xx_ata_resume(struct of_device *op)
 
 
 static struct of_device_id mpc52xx_ata_of_match[] = {
-	{
-		.type		= "ata",
-		.compatible	= "mpc5200-ata",
-	},
+	{ .compatible = "fsl,mpc5200-ata", },
+	{ .compatible = "mpc5200-ata", },
 	{},
 };
 
diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
index 79f7ead..2700482 100644
--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -1056,10 +1056,8 @@ static int mpc52xx_fec_of_resume(struct of_device *op)
 #endif
 
 static struct of_device_id mpc52xx_fec_match[] = {
-	{
-		.type		= "network",
-		.compatible	= "mpc5200-fec",
-	},
+	{ .type = "network", .compatible = "fsl,mpc5200-fec", },
+	{ .type = "network", .compatible = "mpc5200-fec", },
 	{ }
 };
 
diff --git a/drivers/net/fec_mpc52xx_phy.c b/drivers/net/fec_mpc52xx_phy.c
index ba6e8b2..1837584 100644
--- a/drivers/net/fec_mpc52xx_phy.c
+++ b/drivers/net/fec_mpc52xx_phy.c
@@ -177,11 +177,9 @@ static int mpc52xx_fec_mdio_remove(struct of_device *of)
 
 
 static struct of_device_id mpc52xx_fec_mdio_match[] = {
-	{
-		.type = "mdio",
-		.compatible = "mpc5200b-fec-phy",
-	},
-	{},
+	{ .compatible = "fsl,mpc5200b-mdio", },
+	{ .compatible = "mpc5200b-fec-phy", },
+	{}
 };
 
 struct of_platform_driver mpc52xx_fec_mdio_driver = {
diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index a269ae1..06f4316 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -130,7 +130,9 @@ static irqreturn_t mpc52xx_uart_int(int irq, void *dev_id);
 
 #if defined(CONFIG_PPC_MERGE)
 static const struct of_device_id mpc52xx_uart_of_match[] = {
-	{ .type = "serial", .compatible = "mpc5200-psc-uart", },
+	{ .type = "serial", .compatible = "fsl,mpc5200-psc-uart", },
+	{ .type = "serial", .compatible = "mpc5200-psc-uart", }, /* lite5200 */
+	{ .type = "serial", .compatible = "mpc5200-serial", }, /* efika */
 	{},
 };
 #endif
diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index d398c93..a3ebc63 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -628,8 +628,9 @@ static int __exit mpc52xx_psc_spi_of_remove(struct of_device *op)
 }
 
 static struct of_device_id mpc52xx_psc_spi_of_match[] = {
-	{ .type = "spi", .compatible = "mpc5200-psc-spi", },
-	{},
+	{ .compatible = "fsl,mpc5200-psc-spi", },
+	{ .compatible = "mpc5200-psc-spi", }, /* old */
+	{}
 };
 
 MODULE_DEVICE_TABLE(of, mpc52xx_psc_spi_of_match);
diff --git a/drivers/usb/host/ohci-ppc-of.c b/drivers/usb/host/ohci-ppc-of.c
index 0c3e6b7..a672527 100644
--- a/drivers/usb/host/ohci-ppc-of.c
+++ b/drivers/usb/host/ohci-ppc-of.c
@@ -136,6 +136,8 @@ ohci_hcd_ppc_of_probe(struct of_device *op, const struct of_device_id *match)
 	ohci = hcd_to_ohci(hcd);
 	if (is_bigendian) {
 		ohci->flags |= OHCI_QUIRK_BE_MMIO | OHCI_QUIRK_BE_DESC;
+		if (of_device_is_compatible(dn, "fsl,mpc5200-ohci"))
+			ohci->flags |= OHCI_QUIRK_FRAME_NO;
 		if (of_device_is_compatible(dn, "mpc5200-ohci"))
 			ohci->flags |= OHCI_QUIRK_FRAME_NO;
 	}
