Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E2D4CB7696
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 19:37:04 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linux-usb@vger.kernel.org
Subject: [PATCH v2 2/3] USB: add of_platform glue driver for FSL USB DR
	controller
Date: Tue, 28 Sep 2010 11:36:33 +0200
Message-Id: <1285666594-21150-3-git-send-email-agust@denx.de>
In-Reply-To: <1285666594-21150-1-git-send-email-agust@denx.de>
References: <1285666594-21150-1-git-send-email-agust@denx.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	Greg Kroah-Hartman <gregkh@suse.de>, linuxppc-dev@ozlabs.org,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The driver creates platform devices based on the information
from USB nodes in the flat device tree. This is the replacement
for old arch fsl_soc usb code removed by the previous patch.
It uses usual of-style binding, available EHCI-HCD and UDC
drivers can be bound to the created devices. The new of-style
driver additionaly instantiates USB OTG platform device, as the
appropriate USB OTG driver will be added soon.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
v2:
 - drop unneeded PPC_OF dependency
 - fix spelling bug in mode table and fix coding style
 - print a warning if no valid dr_mode found
 - add remove hook to unregister platform devices
   created by probe. So the driver can be unbound
 - fix OTG platform device creation order
 - drop fs_initcall, replaced by module_init() now
 - add module_exit(), MODULE_DESCRIPTION, MODULE_LICENSE

 drivers/usb/gadget/Kconfig       |    1 +
 drivers/usb/host/Kconfig         |    4 +
 drivers/usb/host/Makefile        |    1 +
 drivers/usb/host/fsl-mph-dr-of.c |  213 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 219 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/host/fsl-mph-dr-of.c

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index fab765d..0fe5bc8 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -158,6 +158,7 @@ config USB_GADGET_FSL_USB2
 	boolean "Freescale Highspeed USB DR Peripheral Controller"
 	depends on FSL_SOC || ARCH_MXC
 	select USB_GADGET_DUALSPEED
+	select USB_FSL_MPH_DR_OF
 	help
 	   Some of Freescale PowerPC processors have a High Speed
 	   Dual-Role(DR) USB controller, which supports device mode.
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 2d926ce..f3a90b0 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -112,10 +112,14 @@ config XPS_USB_HCD_XILINX
 		support both high speed and full speed devices, or high speed
 		devices only.
 
+config USB_FSL_MPH_DR_OF
+	tristate
+
 config USB_EHCI_FSL
 	bool "Support for Freescale on-chip EHCI USB controller"
 	depends on USB_EHCI_HCD && FSL_SOC
 	select USB_EHCI_ROOT_HUB_TT
+	select USB_FSL_MPH_DR_OF
 	---help---
 	  Variation of ARC USB block used in some Freescale chips.
 
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index b6315aa..aacbe82 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -33,4 +33,5 @@ obj-$(CONFIG_USB_R8A66597_HCD)	+= r8a66597-hcd.o
 obj-$(CONFIG_USB_ISP1760_HCD)	+= isp1760.o
 obj-$(CONFIG_USB_HWA_HCD)	+= hwa-hc.o
 obj-$(CONFIG_USB_IMX21_HCD)	+= imx21-hcd.o
+obj-$(CONFIG_USB_FSL_MPH_DR_OF)	+= fsl-mph-dr-of.o
 
diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
new file mode 100644
index 0000000..ee8cb94
--- /dev/null
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -0,0 +1,213 @@
+/*
+ * Setup platform devices needed by the Freescale multi-port host
+ * and/or dual-role USB controller modules based on the description
+ * in flat device tree.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/fsl_devices.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+
+struct fsl_usb2_dev_data {
+	char *dr_mode;		/* controller mode */
+	char *drivers[3];	/* drivers to instantiate for this mode */
+	enum fsl_usb2_operating_modes op_mode;	/* operating mode */
+};
+
+struct fsl_usb2_dev_data dr_mode_data[] __devinitdata = {
+	{
+		.dr_mode = "host",
+		.drivers = { "fsl-ehci", NULL, NULL, },
+		.op_mode = FSL_USB2_DR_HOST,
+	},
+	{
+		.dr_mode = "otg",
+		.drivers = { "fsl-usb2-otg", "fsl-ehci", "fsl-usb2-udc", },
+		.op_mode = FSL_USB2_DR_OTG,
+	},
+	{
+		.dr_mode = "peripheral",
+		.drivers = { "fsl-usb2-udc", NULL, NULL, },
+		.op_mode = FSL_USB2_DR_DEVICE,
+	},
+};
+
+struct fsl_usb2_dev_data * __devinit get_dr_mode_data(struct device_node *np)
+{
+	const unsigned char *prop;
+	int i;
+
+	prop = of_get_property(np, "dr_mode", NULL);
+	if (prop) {
+		for (i = 0; i < ARRAY_SIZE(dr_mode_data); i++) {
+			if (!strcmp(prop, dr_mode_data[i].dr_mode))
+				return &dr_mode_data[i];
+		}
+	}
+	pr_warn("%s: Invalid 'dr_mode' property, fallback to host mode\n",
+		np->full_name);
+	return &dr_mode_data[0]; /* mode not specified, use host */
+}
+
+static enum fsl_usb2_phy_modes __devinit determine_usb_phy(const char *phy_type)
+{
+	if (!phy_type)
+		return FSL_USB2_PHY_NONE;
+	if (!strcasecmp(phy_type, "ulpi"))
+		return FSL_USB2_PHY_ULPI;
+	if (!strcasecmp(phy_type, "utmi"))
+		return FSL_USB2_PHY_UTMI;
+	if (!strcasecmp(phy_type, "utmi_wide"))
+		return FSL_USB2_PHY_UTMI_WIDE;
+	if (!strcasecmp(phy_type, "serial"))
+		return FSL_USB2_PHY_SERIAL;
+
+	return FSL_USB2_PHY_NONE;
+}
+
+struct platform_device * __devinit fsl_usb2_device_register(
+					struct platform_device *ofdev,
+					struct fsl_usb2_platform_data *pdata,
+					const char *name, int id)
+{
+	struct platform_device *pdev;
+	const struct resource *res = ofdev->resource;
+	unsigned int num = ofdev->num_resources;
+	int retval;
+
+	pdev = platform_device_alloc(name, id);
+	if (!pdev) {
+		retval = -ENOMEM;
+		goto error;
+	}
+
+	pdev->dev.parent = &ofdev->dev;
+
+	pdev->dev.coherent_dma_mask = ofdev->dev.coherent_dma_mask;
+	pdev->dev.dma_mask = &pdev->archdata.dma_mask;
+	*pdev->dev.dma_mask = *ofdev->dev.dma_mask;
+
+	retval = platform_device_add_data(pdev, pdata, sizeof(*pdata));
+	if (retval)
+		goto error;
+
+	if (num) {
+		retval = platform_device_add_resources(pdev, res, num);
+		if (retval)
+			goto error;
+	}
+
+	retval = platform_device_add(pdev);
+	if (retval)
+		goto error;
+
+	return pdev;
+
+error:
+	platform_device_put(pdev);
+	return ERR_PTR(retval);
+}
+
+static int __devinit fsl_usb2_mph_dr_of_probe(struct platform_device *ofdev,
+					   const struct of_device_id *match)
+{
+	struct device_node *np = ofdev->dev.of_node;
+	struct platform_device *usb_dev;
+	struct fsl_usb2_platform_data data, *pdata;
+	struct fsl_usb2_dev_data *dev_data;
+	const unsigned char *prop;
+	static unsigned int idx;
+	int i;
+
+	if (!of_device_is_available(np))
+		return -ENODEV;
+
+	pdata = match->data;
+	if (!pdata) {
+		memset(&data, 0, sizeof(data));
+		pdata = &data;
+	}
+
+	dev_data = get_dr_mode_data(np);
+
+	if (of_device_is_compatible(np, "fsl-usb2-mph")) {
+		if (of_get_property(np, "port0", NULL))
+			pdata->port_enables |= FSL_USB2_PORT0_ENABLED;
+
+		if (of_get_property(np, "port1", NULL))
+			pdata->port_enables |= FSL_USB2_PORT1_ENABLED;
+
+		pdata->operating_mode = FSL_USB2_MPH_HOST;
+	} else {
+		/* setup mode selected in the device tree */
+		pdata->operating_mode = dev_data->op_mode;
+	}
+
+	prop = of_get_property(np, "phy_type", NULL);
+	pdata->phy_mode = determine_usb_phy(prop);
+
+	for (i = 0; i < ARRAY_SIZE(dev_data->drivers); i++) {
+		if (!dev_data->drivers[i])
+			continue;
+		usb_dev = fsl_usb2_device_register(ofdev, pdata,
+					dev_data->drivers[i], idx);
+		if (IS_ERR(usb_dev)) {
+			dev_err(&ofdev->dev, "Can't register usb device\n");
+			return PTR_ERR(usb_dev);
+		}
+	}
+	idx++;
+	return 0;
+}
+
+static int __devexit __unregister_subdev(struct device *dev, void *d)
+{
+	platform_device_unregister(to_platform_device(dev));
+	return 0;
+}
+
+static int __devexit fsl_usb2_mph_dr_of_remove(struct platform_device *ofdev)
+{
+	device_for_each_child(&ofdev->dev, NULL, __unregister_subdev);
+	return 0;
+}
+
+static const struct of_device_id fsl_usb2_mph_dr_of_match[] = {
+	{ .compatible = "fsl-usb2-mph", },
+	{ .compatible = "fsl-usb2-dr", },
+	{},
+};
+
+static struct of_platform_driver fsl_usb2_mph_dr_driver = {
+	.driver = {
+		.name = "fsl-usb2-mph-dr",
+		.owner = THIS_MODULE,
+		.of_match_table = fsl_usb2_mph_dr_of_match,
+	},
+	.probe	= fsl_usb2_mph_dr_of_probe,
+	.remove	= __devexit_p(fsl_usb2_mph_dr_of_remove),
+};
+
+static int __init fsl_usb2_mph_dr_init(void)
+{
+	return of_register_platform_driver(&fsl_usb2_mph_dr_driver);
+}
+module_init(fsl_usb2_mph_dr_init);
+
+static void __exit fsl_usb2_mph_dr_exit(void)
+{
+	of_unregister_platform_driver(&fsl_usb2_mph_dr_driver);
+}
+module_exit(fsl_usb2_mph_dr_exit);
+
+MODULE_DESCRIPTION("FSL MPH DR OF devices driver");
+MODULE_AUTHOR("Anatolij Gustschin <agust@denx.de>");
+MODULE_LICENSE("GPL");
-- 
1.7.0.4
