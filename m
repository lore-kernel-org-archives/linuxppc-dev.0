Return-Path: <alistair@popple.id.au>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:4])
 by ozlabs.org (Postfix) with ESMTP id B61DE2C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 18:38:52 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC PATCH] ehci-platform: Merge ppc-of EHCI driver into the
 ehci-platform driver
Date: Wed, 06 Nov 2013 18:39:19 +1100
Message-ID: <1690980.YlPWToa1rW@mexican>
In-Reply-To: <1383710296.4776.119.camel@pasglop>
References: <Pine.LNX.4.44L0.1311051004080.1360-100000@iolanthe.rowland.org>
 <2440701.siW6M1PPWz@mexican> <1383710296.4776.119.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the ppc-of driver uses the compatibility string
"usb-ehci". This means platforms that use device-tree and implement an
EHCI compatible interface have to either use the ppc-of driver or add
a compatible line to the ehci-platform driver. It would be more
appropriate for the platform driver to be compatible with "usb-ehci"
as non-powerpc platforms are also beginning to utilise device-tree.

This patch merges the device tree property parsing from ehci-ppc-of
into the platform driver and adds a "usb-ehci" compatibility
string. The existing ehci-ppc-of driver is renamed to ehci-440epx as
it contains platform specific work arounds for the 440EPX SoC.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---

So I could submit something like this that essentially merges the ppc-of 
driver into the platform driver instead of adding the "ibm,akebono-ehci" 
compatible line to the platform driver.

However I'm still fairly new to device-tree so I'm not sure what (if any) the 
broader impact would be. A quick grep for "usb-ehci" turned up a couple of ARM 
device tree's using it however they all provided their own drivers and don't 
select CONFIG_USB_EHCI_HCD_PLATFORM so I'm guess they shouldn't be impacted.

I have attempted to fix up any PowerPC device trees/configs, although I wasn't 
sure if "usb-ehci" should remain in sequoia.dts or not given that it needs to 
use the 440EPX specific driver.

Also this hasn't been tested (beyond compilation) yet.

 arch/powerpc/boot/dts/sequoia.dts              |    2 +-
 arch/powerpc/configs/44x/canyonlands_defconfig |    1 +
 drivers/usb/host/Kconfig                       |    8 +-
 drivers/usb/host/ehci-440epx.c                 |  236 
++++++++++++++++++++++++
 drivers/usb/host/ehci-hcd.c                    |    6 +-
 drivers/usb/host/ehci-platform.c               |   18 +-
 drivers/usb/host/ehci-ppc-of.c                 |  236 
------------------------
 7 files changed, 261 insertions(+), 246 deletions(-)
 create mode 100644 drivers/usb/host/ehci-440epx.c
 delete mode 100644 drivers/usb/host/ehci-ppc-of.c

diff --git a/arch/powerpc/boot/dts/sequoia.dts 
b/arch/powerpc/boot/dts/sequoia.dts
index b1d3292..e28371e 100644
--- a/arch/powerpc/boot/dts/sequoia.dts
+++ b/arch/powerpc/boot/dts/sequoia.dts
@@ -153,7 +153,7 @@
 		};
 
 		USB0: ehci@e0000300 {
-			compatible = "ibm,usb-ehci-440epx", "usb-ehci";
+			compatible = "ibm,usb-ehci-440epx";
 			interrupt-parent = <&UIC0>;
 			interrupts = <0x1a 0x4>;
 			reg = <0x00000000 0xe0000300 0x00000090 0x00000000 
0xe0000390 0x00000070>;
diff --git a/arch/powerpc/configs/44x/canyonlands_defconfig 
b/arch/powerpc/configs/44x/canyonlands_defconfig
index d5be93e..16dc37f 100644
--- a/arch/powerpc/configs/44x/canyonlands_defconfig
+++ b/arch/powerpc/configs/44x/canyonlands_defconfig
@@ -75,6 +75,7 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_DEVICEFS=y
 CONFIG_USB_MON=y
 CONFIG_USB_EHCI_HCD=m
+CONFIG_USB_EHCI_HCD_PLATFORM=m
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
 CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index b3f20d7..b8d7c24 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -188,13 +188,13 @@ config USB_EHCI_TEGRA
          This driver enables support for the internal USB Host Controllers
          found in NVIDIA Tegra SoCs. The controllers are EHCI compliant.
 
-config USB_EHCI_HCD_PPC_OF
-	bool "EHCI support for PPC USB controller on OF platform bus"
-	depends on PPC_OF
+config USB_EHCI_HCD_440EPX
+	bool "EHCI support for PPC USB controller on 440EPX"
+	depends on PPC_OF && 440EPX
 	default y
 	---help---
 	  Enables support for the USB controller present on the PowerPC
-	  OpenFirmware platform bus.
+	  440EPX SoC.
 
 config USB_EHCI_SH
 	bool "EHCI support for SuperH USB controller"
diff --git a/drivers/usb/host/ehci-440epx.c b/drivers/usb/host/ehci-440epx.c
new file mode 100644
index 0000000..4223700
--- /dev/null
+++ b/drivers/usb/host/ehci-440epx.c
@@ -0,0 +1,236 @@
+/*
+ * EHCI HCD (Host Controller Driver) for USB.
+ *
+ * Bus Glue for PPC On-Chip EHCI driver on the of_platform bus
+ * Tested on AMCC PPC 440EPx
+ *
+ * Valentine Barshak <vbarshak@ru.mvista.com>
+ *
+ * Based on "ehci-ppc-soc.c" by Stefan Roese <sr@denx.de>
+ * and "ohci-ppc-of.c" by Sylvain Munaut <tnt@246tNt.com>
+ *
+ * This file is licenced under the GPL.
+ */
+
+#include <linux/err.h>
+#include <linux/signal.h>
+
+#include <linux/of.h>
+#include <linux/of_platform.h>
+
+
+static const struct hc_driver ehci_440epx_hc_driver = {
+	.description		= hcd_name,
+	.product_desc		= "OF EHCI",
+	.hcd_priv_size		= sizeof(struct ehci_hcd),
+
+	/*
+	 * generic hardware linkage
+	 */
+	.irq			= ehci_irq,
+	.flags			= HCD_MEMORY | HCD_USB2,
+
+	/*
+	 * basic lifecycle operations
+	 */
+	.reset			= ehci_setup,
+	.start			= ehci_run,
+	.stop			= ehci_stop,
+	.shutdown		= ehci_shutdown,
+
+	/*
+	 * managing i/o requests and associated device resources
+	 */
+	.urb_enqueue		= ehci_urb_enqueue,
+	.urb_dequeue		= ehci_urb_dequeue,
+	.endpoint_disable	= ehci_endpoint_disable,
+	.endpoint_reset		= ehci_endpoint_reset,
+
+	/*
+	 * scheduling support
+	 */
+	.get_frame_number	= ehci_get_frame,
+
+	/*
+	 * root hub support
+	 */
+	.hub_status_data	= ehci_hub_status_data,
+	.hub_control		= ehci_hub_control,
+#ifdef	CONFIG_PM
+	.bus_suspend		= ehci_bus_suspend,
+	.bus_resume		= ehci_bus_resume,
+#endif
+	.relinquish_port	= ehci_relinquish_port,
+	.port_handed_over	= ehci_port_handed_over,
+
+	.clear_tt_buffer_complete	= ehci_clear_tt_buffer_complete,
+};
+
+
+/*
+ * 440EPx Errata USBH_3
+ * Fix: Enable Break Memory Transfer (BMT) in INSNREG3
+ */
+#define PPC440EPX_EHCI0_INSREG_BMT	(0x1 << 0)
+static int
+ppc44x_enable_bmt(struct device_node *dn)
+{
+	__iomem u32 *insreg_virt;
+
+	insreg_virt = of_iomap(dn, 1);
+	if (!insreg_virt)
+		return  -EINVAL;
+
+	out_be32(insreg_virt + 3, PPC440EPX_EHCI0_INSREG_BMT);
+
+	iounmap(insreg_virt);
+	return 0;
+}
+
+
+static int ehci_hcd_440epx_probe(struct platform_device *op)
+{
+	struct device_node *dn = op->dev.of_node;
+	struct usb_hcd *hcd;
+	struct ehci_hcd	*ehci = NULL;
+	struct resource res;
+	int irq;
+	int rv;
+
+	struct device_node *np;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	dev_dbg(&op->dev, "initializing PPC-OF USB Controller\n");
+
+	rv = of_address_to_resource(dn, 0, &res);
+	if (rv)
+		return rv;
+
+	hcd = usb_create_hcd(&ehci_440epx_hc_driver, &op->dev, "PPC-OF USB");
+	if (!hcd)
+		return -ENOMEM;
+
+	hcd->rsrc_start = res.start;
+	hcd->rsrc_len = resource_size(&res);
+
+	irq = irq_of_parse_and_map(dn, 0);
+	if (irq == NO_IRQ) {
+		printk(KERN_ERR "%s: irq_of_parse_and_map failed\n", __FILE__);
+		rv = -EBUSY;
+		goto err_irq;
+	}
+
+	hcd->regs = devm_ioremap_resource(&op->dev, &res);
+	if (IS_ERR(hcd->regs)) {
+		rv = PTR_ERR(hcd->regs);
+		goto err_ioremap;
+	}
+
+	ehci = hcd_to_ehci(hcd);
+	np = of_find_compatible_node(NULL, NULL, "ibm,usb-ohci-440epx");
+	if (np != NULL) {
+		/* claim we really affected by usb23 erratum */
+		if (!of_address_to_resource(np, 0, &res))
+			ehci->ohci_hcctrl_reg =
+				devm_ioremap(&op->dev,
+					     res.start + OHCI_HCCTRL_OFFSET,
+					     OHCI_HCCTRL_LEN);
+		else
+			pr_debug("%s: no ohci offset in fdt\n", __FILE__);
+		if (!ehci->ohci_hcctrl_reg) {
+			pr_debug("%s: ioremap for ohci hcctrl failed\n", __FILE__);
+		} else {
+			ehci->has_amcc_usb23 = 1;
+		}
+	}
+
+	if (of_get_property(dn, "big-endian", NULL)) {
+		ehci->big_endian_mmio = 1;
+		ehci->big_endian_desc = 1;
+	}
+	if (of_get_property(dn, "big-endian-regs", NULL))
+		ehci->big_endian_mmio = 1;
+	if (of_get_property(dn, "big-endian-desc", NULL))
+		ehci->big_endian_desc = 1;
+
+	ehci->caps = hcd->regs;
+
+	if (of_device_is_compatible(dn, "ibm,usb-ehci-440epx")) {
+		rv = ppc44x_enable_bmt(dn);
+		ehci_dbg(ehci, "Break Memory Transfer (BMT) is %senabled!\n",
+				rv ? "NOT ": "");
+	}
+
+	rv = usb_add_hcd(hcd, irq, 0);
+	if (rv)
+		goto err_ioremap;
+
+	return 0;
+
+err_ioremap:
+	irq_dispose_mapping(irq);
+err_irq:
+	usb_put_hcd(hcd);
+
+	return rv;
+}
+
+
+static int ehci_hcd_440epx_remove(struct platform_device *op)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(op);
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+
+	struct device_node *np;
+	struct resource res;
+
+	dev_dbg(&op->dev, "stopping PPC-OF USB Controller\n");
+
+	usb_remove_hcd(hcd);
+
+	irq_dispose_mapping(hcd->irq);
+
+	/* use request_mem_region to test if the ohci driver is loaded.  if so
+	 * ensure the ohci core is operational.
+	 */
+	if (ehci->has_amcc_usb23) {
+		np = of_find_compatible_node(NULL, NULL, "ibm,usb-ohci-440epx");
+		if (np != NULL) {
+			if (!of_address_to_resource(np, 0, &res))
+				if (!request_mem_region(res.start,
+							    0x4, hcd_name))
+					set_ohci_hcfs(ehci, 1);
+				else
+					release_mem_region(res.start, 0x4);
+			else
+				pr_debug("%s: no ohci offset in fdt\n", __FILE__);
+			of_node_put(np);
+		}
+	}
+	usb_put_hcd(hcd);
+
+	return 0;
+}
+
+
+static const struct of_device_id ehci_hcd_440epx_match[] = {
+	{
+		.compatible = "ibm,usb-ehci-440epx",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ehci_hcd_440epx_match);
+
+
+static struct platform_driver ehci_hcd_440epx_driver = {
+	.probe		= ehci_hcd_440epx_probe,
+	.remove		= ehci_hcd_440epx_remove,
+	.shutdown	= usb_hcd_platform_shutdown,
+	.driver = {
+		.name = "ppc-of-ehci",
+		.owner = THIS_MODULE,
+		.of_match_table = ehci_hcd_440epx_match,
+	},
+};
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 86ab9fd..3b04f25 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1228,9 +1228,9 @@ MODULE_LICENSE ("GPL");
 #define	PS3_SYSTEM_BUS_DRIVER	ps3_ehci_driver
 #endif
 
-#ifdef CONFIG_USB_EHCI_HCD_PPC_OF
-#include "ehci-ppc-of.c"
-#define OF_PLATFORM_DRIVER	ehci_hcd_ppc_of_driver
+#ifdef CONFIG_USB_EHCI_HCD_440EPX
+#include "ehci-440epx.c"
+#define OF_PLATFORM_DRIVER	ehci_hcd_440epx_driver
 #endif
 
 #ifdef CONFIG_XPS_USB_HCD_XILINX
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-
platform.c
index f6b790c..027f368 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -77,6 +77,7 @@ static int ehci_platform_probe(struct platform_device *dev)
 	struct usb_hcd *hcd;
 	struct resource *res_mem;
 	struct usb_ehci_pdata *pdata;
+	struct device_node *dn = dev->dev.of_node;
 	int irq;
 	int err = -ENOMEM;
 
@@ -96,6 +97,18 @@ static int ehci_platform_probe(struct platform_device *dev)
 
 	pdata = dev_get_platdata(&dev->dev);
 
+	/* Initialise platform data from device tree if available. */
+	if (!dn) {
+		if (of_get_property(dn, "big-endian", NULL)) {
+			pdata->big_endian_mmio = 1;
+			pdata->big_endian_desc = 1;
+		}
+		if (of_get_property(dn, "big-endian-regs", NULL))
+			pdata->big_endian_mmio = 1;
+		if (of_get_property(dn, "big-endian-desc", NULL))
+			pdata->big_endian_desc = 1;
+	}
+
 	irq = platform_get_irq(dev, 0);
 	if (irq < 0) {
 		dev_err(&dev->dev, "no irq provided");
@@ -203,9 +216,10 @@ static int ehci_platform_resume(struct device *dev)
 #define ehci_platform_resume	NULL
 #endif /* CONFIG_PM */
 
-static const struct of_device_id vt8500_ehci_ids[] = {
+static const struct of_device_id ehci_platform_ids[] = {
 	{ .compatible = "via,vt8500-ehci", },
 	{ .compatible = "wm,prizm-ehci", },
+	{ .compatible = "usb-ehci", },
 	{}
 };
 
@@ -229,7 +243,7 @@ static struct platform_driver ehci_platform_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "ehci-platform",
 		.pm	= &ehci_platform_pm_ops,
-		.of_match_table = vt8500_ehci_ids,
+		.of_match_table = ehci_platform_ids,
 	}
 };
 
diff --git a/drivers/usb/host/ehci-ppc-of.c b/drivers/usb/host/ehci-ppc-of.c
deleted file mode 100644
index 932293f..0000000
--- a/drivers/usb/host/ehci-ppc-of.c
+++ /dev/null
@@ -1,236 +0,0 @@
-/*
- * EHCI HCD (Host Controller Driver) for USB.
- *
- * Bus Glue for PPC On-Chip EHCI driver on the of_platform bus
- * Tested on AMCC PPC 440EPx
- *
- * Valentine Barshak <vbarshak@ru.mvista.com>
- *
- * Based on "ehci-ppc-soc.c" by Stefan Roese <sr@denx.de>
- * and "ohci-ppc-of.c" by Sylvain Munaut <tnt@246tNt.com>
- *
- * This file is licenced under the GPL.
- */
-
-#include <linux/err.h>
-#include <linux/signal.h>
-
-#include <linux/of.h>
-#include <linux/of_platform.h>
-
-
-static const struct hc_driver ehci_ppc_of_hc_driver = {
-	.description		= hcd_name,
-	.product_desc		= "OF EHCI",
-	.hcd_priv_size		= sizeof(struct ehci_hcd),
-
-	/*
-	 * generic hardware linkage
-	 */
-	.irq			= ehci_irq,
-	.flags			= HCD_MEMORY | HCD_USB2,
-
-	/*
-	 * basic lifecycle operations
-	 */
-	.reset			= ehci_setup,
-	.start			= ehci_run,
-	.stop			= ehci_stop,
-	.shutdown		= ehci_shutdown,
-
-	/*
-	 * managing i/o requests and associated device resources
-	 */
-	.urb_enqueue		= ehci_urb_enqueue,
-	.urb_dequeue		= ehci_urb_dequeue,
-	.endpoint_disable	= ehci_endpoint_disable,
-	.endpoint_reset		= ehci_endpoint_reset,
-
-	/*
-	 * scheduling support
-	 */
-	.get_frame_number	= ehci_get_frame,
-
-	/*
-	 * root hub support
-	 */
-	.hub_status_data	= ehci_hub_status_data,
-	.hub_control		= ehci_hub_control,
-#ifdef	CONFIG_PM
-	.bus_suspend		= ehci_bus_suspend,
-	.bus_resume		= ehci_bus_resume,
-#endif
-	.relinquish_port	= ehci_relinquish_port,
-	.port_handed_over	= ehci_port_handed_over,
-
-	.clear_tt_buffer_complete	= ehci_clear_tt_buffer_complete,
-};
-
-
-/*
- * 440EPx Errata USBH_3
- * Fix: Enable Break Memory Transfer (BMT) in INSNREG3
- */
-#define PPC440EPX_EHCI0_INSREG_BMT	(0x1 << 0)
-static int
-ppc44x_enable_bmt(struct device_node *dn)
-{
-	__iomem u32 *insreg_virt;
-
-	insreg_virt = of_iomap(dn, 1);
-	if (!insreg_virt)
-		return  -EINVAL;
-
-	out_be32(insreg_virt + 3, PPC440EPX_EHCI0_INSREG_BMT);
-
-	iounmap(insreg_virt);
-	return 0;
-}
-
-
-static int ehci_hcd_ppc_of_probe(struct platform_device *op)
-{
-	struct device_node *dn = op->dev.of_node;
-	struct usb_hcd *hcd;
-	struct ehci_hcd	*ehci = NULL;
-	struct resource res;
-	int irq;
-	int rv;
-
-	struct device_node *np;
-
-	if (usb_disabled())
-		return -ENODEV;
-
-	dev_dbg(&op->dev, "initializing PPC-OF USB Controller\n");
-
-	rv = of_address_to_resource(dn, 0, &res);
-	if (rv)
-		return rv;
-
-	hcd = usb_create_hcd(&ehci_ppc_of_hc_driver, &op->dev, "PPC-OF USB");
-	if (!hcd)
-		return -ENOMEM;
-
-	hcd->rsrc_start = res.start;
-	hcd->rsrc_len = resource_size(&res);
-
-	irq = irq_of_parse_and_map(dn, 0);
-	if (irq == NO_IRQ) {
-		printk(KERN_ERR "%s: irq_of_parse_and_map failed\n", __FILE__);
-		rv = -EBUSY;
-		goto err_irq;
-	}
-
-	hcd->regs = devm_ioremap_resource(&op->dev, &res);
-	if (IS_ERR(hcd->regs)) {
-		rv = PTR_ERR(hcd->regs);
-		goto err_ioremap;
-	}
-
-	ehci = hcd_to_ehci(hcd);
-	np = of_find_compatible_node(NULL, NULL, "ibm,usb-ohci-440epx");
-	if (np != NULL) {
-		/* claim we really affected by usb23 erratum */
-		if (!of_address_to_resource(np, 0, &res))
-			ehci->ohci_hcctrl_reg =
-				devm_ioremap(&op->dev,
-					     res.start + OHCI_HCCTRL_OFFSET,
-					     OHCI_HCCTRL_LEN);
-		else
-			pr_debug("%s: no ohci offset in fdt\n", __FILE__);
-		if (!ehci->ohci_hcctrl_reg) {
-			pr_debug("%s: ioremap for ohci hcctrl failed\n", __FILE__);
-		} else {
-			ehci->has_amcc_usb23 = 1;
-		}
-	}
-
-	if (of_get_property(dn, "big-endian", NULL)) {
-		ehci->big_endian_mmio = 1;
-		ehci->big_endian_desc = 1;
-	}
-	if (of_get_property(dn, "big-endian-regs", NULL))
-		ehci->big_endian_mmio = 1;
-	if (of_get_property(dn, "big-endian-desc", NULL))
-		ehci->big_endian_desc = 1;
-
-	ehci->caps = hcd->regs;
-
-	if (of_device_is_compatible(dn, "ibm,usb-ehci-440epx")) {
-		rv = ppc44x_enable_bmt(dn);
-		ehci_dbg(ehci, "Break Memory Transfer (BMT) is %senabled!\n",
-				rv ? "NOT ": "");
-	}
-
-	rv = usb_add_hcd(hcd, irq, 0);
-	if (rv)
-		goto err_ioremap;
-
-	return 0;
-
-err_ioremap:
-	irq_dispose_mapping(irq);
-err_irq:
-	usb_put_hcd(hcd);
-
-	return rv;
-}
-
-
-static int ehci_hcd_ppc_of_remove(struct platform_device *op)
-{
-	struct usb_hcd *hcd = platform_get_drvdata(op);
-	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
-
-	struct device_node *np;
-	struct resource res;
-
-	dev_dbg(&op->dev, "stopping PPC-OF USB Controller\n");
-
-	usb_remove_hcd(hcd);
-
-	irq_dispose_mapping(hcd->irq);
-
-	/* use request_mem_region to test if the ohci driver is loaded.  if so
-	 * ensure the ohci core is operational.
-	 */
-	if (ehci->has_amcc_usb23) {
-		np = of_find_compatible_node(NULL, NULL, "ibm,usb-ohci-440epx");
-		if (np != NULL) {
-			if (!of_address_to_resource(np, 0, &res))
-				if (!request_mem_region(res.start,
-							    0x4, hcd_name))
-					set_ohci_hcfs(ehci, 1);
-				else
-					release_mem_region(res.start, 0x4);
-			else
-				pr_debug("%s: no ohci offset in fdt\n", __FILE__);
-			of_node_put(np);
-		}
-	}
-	usb_put_hcd(hcd);
-
-	return 0;
-}
-
-
-static const struct of_device_id ehci_hcd_ppc_of_match[] = {
-	{
-		.compatible = "usb-ehci",
-	},
-	{},
-};
-MODULE_DEVICE_TABLE(of, ehci_hcd_ppc_of_match);
-
-
-static struct platform_driver ehci_hcd_ppc_of_driver = {
-	.probe		= ehci_hcd_ppc_of_probe,
-	.remove		= ehci_hcd_ppc_of_remove,
-	.shutdown	= usb_hcd_platform_shutdown,
-	.driver = {
-		.name = "ppc-of-ehci",
-		.owner = THIS_MODULE,
-		.of_match_table = ehci_hcd_ppc_of_match,
-	},
-};
-- 
1.7.10.4
