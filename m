Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 9A1CFB7F3D
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 07:24:37 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/11] powerpc/mpc5121: add USB host support
Date: Tue, 19 Jan 2010 21:24:10 +0100
Message-Id: <1263932653-3634-9-git-send-email-agust@denx.de>
In-Reply-To: <1263932653-3634-1-git-send-email-agust@denx.de>
References: <1263932653-3634-1-git-send-email-agust@denx.de>
Cc: wd@denx.de, dzu@denx.de, linux-usb@vger.kernel.org,
	Bruce Schmid <duck@freescale.com>, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Platform specific code for MPC5121 USB Host support.
MPC5121 Rev 2.0 silicon EHCI registers are big endian.
Add appropriate support by specifying "big-endian-regs"
property in device tree node for USB controller. Also
allow specifying DRVVBUS and PWR_FAULT signal polarity
of MPC5121 internal PHY using "invert-drvvbus" and
"invert-pwr-fault" properties.

Signed-off-by: Bruce Schmid <duck@freescale.com>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: linux-usb@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>
---
Note that EHCI FSL driver extention in this patch
applies on top of the following two patches (in the
linux-next tree):

commit 23c3314b88f91db51bd198ed92e34cffb67788dd
Author: Anton Vorontsov <avorontsov@ru.mvista.com>
Date:   Mon Dec 14 18:41:12 2009 +0300

    USB: ehci-fsl: Add power management support

commit bf4bf2d9f646eb0cc531d213a13ffcedf9d6785f
Author: Anton Vorontsov <avorontsov@ru.mvista.com>
Date:   Mon Dec 14 18:41:05 2009 +0300

    USB: ehci-fsl: Fix sparse warnings

 Documentation/powerpc/dts-bindings/fsl/usb.txt |    8 ++
 arch/powerpc/platforms/512x/Kconfig            |    6 +
 arch/powerpc/platforms/512x/Makefile           |    2 +-
 arch/powerpc/platforms/512x/mpc5121_ads.c      |    1 +
 arch/powerpc/platforms/512x/mpc5121_usb.c      |  117 ++++++++++++++++++++++++
 arch/powerpc/platforms/512x/mpc512x.h          |    1 +
 arch/powerpc/sysdev/fsl_soc.c                  |   10 ++
 arch/powerpc/sysdev/fsl_soc.h                  |    9 ++
 drivers/usb/host/ehci-fsl.c                    |  116 +++++++++++++++++-------
 drivers/usb/host/ehci-fsl.h                    |   19 ++++-
 drivers/usb/host/ehci-mem.c                    |    2 +-
 include/linux/fsl_devices.h                    |   10 ++
 12 files changed, 265 insertions(+), 36 deletions(-)
 create mode 100644 arch/powerpc/platforms/512x/mpc5121_usb.c

diff --git a/Documentation/powerpc/dts-bindings/fsl/usb.txt b/Documentation/powerpc/dts-bindings/fsl/usb.txt
index b001524..9050154 100644
--- a/Documentation/powerpc/dts-bindings/fsl/usb.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/usb.txt
@@ -33,6 +33,14 @@ Recommended properties :
  - interrupt-parent : the phandle for the interrupt controller that
    services interrupts for this device.
 
+Optional properties :
+ - big-endian-regs : boolean; if defined, indicates the USB host
+   controller registers format is big endian.
+ - invert-drvvbus : boolean; for MPC5121 only. Indicates the port
+   power polarity of internal PHY signal DRVVBUS is inverted.
+ - invert-pwr-fault : boolean; for MPC5121 only. Indicates the
+   PWR_FAULT signal polarity is inverted.
+
 Example multi port host USB controller device node :
 	usb@22000 {
 		compatible = "fsl-usb2-mph";
diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index 4dac9b0..3fec738 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -9,6 +9,9 @@ config PPC_MPC512x
 config PPC_MPC5121
 	bool
 	select PPC_MPC512x
+	select USB_ARCH_HAS_EHCI
+	select USB_EHCI_BIG_ENDIAN_DESC
+	select USB_EHCI_BIG_ENDIAN_MMIO
 
 config MPC5121_ADS
 	bool "Freescale MPC5121E ADS"
@@ -30,3 +33,6 @@ config MPC5121_GENERIC
 
 	  Compatible boards include:  Protonic LVT base boards (ZANMCU
 	  and VICVT2).
+
+config USB_FSL_BIG_ENDIAN_MMIO
+	bool
diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platforms/512x/Makefile
index 90be2f5..49adabc 100644
--- a/arch/powerpc/platforms/512x/Makefile
+++ b/arch/powerpc/platforms/512x/Makefile
@@ -1,6 +1,6 @@
 #
 # Makefile for the Freescale PowerPC 512x linux kernel.
 #
-obj-y				+= clock.o mpc512x_shared.o
+obj-y				+= clock.o mpc512x_shared.o mpc5121_usb.o
 obj-$(CONFIG_MPC5121_ADS)	+= mpc5121_ads.o mpc5121_ads_cpld.o
 obj-$(CONFIG_MPC5121_GENERIC)	+= mpc5121_generic.o
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
index 2f40404..a497c14 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
@@ -42,6 +42,7 @@ static void __init mpc5121_ads_setup_arch(void)
 	for_each_compatible_node(np, "pci", "fsl,mpc5121-pci")
 		mpc83xx_add_bridge(np);
 #endif
+	mpc5121_usb_init();
 }
 
 static void __init mpc5121_ads_init_IRQ(void)
diff --git a/arch/powerpc/platforms/512x/mpc5121_usb.c b/arch/powerpc/platforms/512x/mpc5121_usb.c
new file mode 100644
index 0000000..7b45651
--- /dev/null
+++ b/arch/powerpc/platforms/512x/mpc5121_usb.c
@@ -0,0 +1,117 @@
+/*
+ * Copyright (C) 2007,2008 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Author: Bruce Schmid <duck@freescale.com>, Tue Oct 2 2007
+ *
+ * Description:
+ * MPC5121 USB platform-specific routines
+ *
+ * This is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/fsl_devices.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/stddef.h>
+#include <linux/of_platform.h>
+#include <sysdev/fsl_soc.h>
+
+#define USBGENCTRL		0x200		/* NOTE: big endian */
+#define GC_WU_INT_CLR		(1 << 5)	/* Wakeup int clear */
+#define GC_ULPI_SEL		(1 << 4)	/* ULPI i/f select (usb0 only)*/
+#define GC_PPP			(1 << 3)	/* Inv. Port Power Polarity */
+#define GC_PFP			(1 << 2)	/* Inv. Power Fault Polarity */
+#define GC_WU_ULPI_EN		(1 << 1)	/* Wakeup on ULPI event */
+#define GC_WU_IE		(1 << 1)	/* Wakeup interrupt enable */
+
+#define ISIPHYCTRL		0x204		/* NOTE: big endian */
+#define PHYCTRL_PHYE		(1 << 4)	/* On-chip UTMI PHY enable */
+#define PHYCTRL_BSENH		(1 << 3)	/* Bit Stuff Enable High */
+#define PHYCTRL_BSEN		(1 << 2)	/* Bit Stuff Enable */
+#define PHYCTRL_LSFE		(1 << 1)	/* Line State Filter Enable */
+#define PHYCTRL_PXE		(1 << 0)	/* PHY oscillator enable */
+
+static struct clk *dr_clk1;
+static struct clk *dr_clk2;
+static int dr_used;
+
+static int mpc5121_usb_dr_init(struct platform_device *pdev)
+{
+	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
+
+	/* enable the clock if we haven't already */
+	if (!dr_used) {
+		dr_clk1 = clk_get(&pdev->dev, "usb1_clk");
+		if (IS_ERR(dr_clk1)) {
+			dev_err(&pdev->dev, "usb1: clk_get failed\n");
+			return -ENODEV;
+		}
+		clk_enable(dr_clk1);
+		dr_clk2 = clk_get(&pdev->dev, "usb2_clk");
+		if (IS_ERR(dr_clk2)) {
+			dev_err(&pdev->dev, "usb2: clk_get failed\n");
+			return -ENODEV;
+		}
+		clk_enable(dr_clk2);
+	}
+	dr_used++;
+
+	pdata->big_endian_desc = 1;
+	pdata->es = 1;
+
+	if (pdata->phy_mode == FSL_USB2_PHY_UTMI_WIDE) {
+		struct device_node *np;
+		u32 reg = 0;
+
+		np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-usb2-dr");
+		if (!np) {
+			pr_err("No USB node found\n");
+			return -ENODEV;
+		}
+
+		if (of_get_property(np, "invert-drvvbus", NULL))
+			reg |= GC_PPP;
+
+		if (of_get_property(np, "invert-pwr-fault", NULL))
+			reg |= GC_PFP;
+
+		of_node_put(np);
+		out_be32(pdata->regs + ISIPHYCTRL, PHYCTRL_PHYE | PHYCTRL_PXE);
+		out_be32(pdata->regs + USBGENCTRL, reg);
+	}
+	return 0;
+}
+
+static void mpc5121_usb_dr_uninit(struct platform_device *pdev)
+{
+	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
+
+	pdata->regs = NULL;
+
+	dr_used--;
+	if (!dr_used) {
+		clk_disable(dr_clk1);
+		clk_disable(dr_clk2);
+		clk_put(dr_clk1);
+		clk_put(dr_clk2);
+		dr_clk1 = NULL;
+		dr_clk2 = NULL;
+	}
+}
+
+void mpc5121_usb_init(void)
+{
+	fsl_platform_usb_ops.init = mpc5121_usb_dr_init;
+	fsl_platform_usb_ops.uninit = mpc5121_usb_dr_uninit;
+}
diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
index c38875c..e92a282 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -13,5 +13,6 @@
 #define __MPC512X_H__
 extern void __init mpc512x_init_IRQ(void);
 extern void mpc512x_restart(char *cmd);
+extern void mpc5121_usb_init(void);
 void __init mpc512x_declare_of_platform_devices(void);
 #endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index b91f7ac..19a455d 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -209,6 +209,9 @@ static int __init of_add_fixed_phys(void)
 arch_initcall(of_add_fixed_phys);
 #endif /* CONFIG_FIXED_PHY */
 
+struct fsl_platform_usb_ops fsl_platform_usb_ops;
+EXPORT_SYMBOL(fsl_platform_usb_ops);
+
 static enum fsl_usb2_phy_modes determine_usb_phy(const char *phy_type)
 {
 	if (!phy_type)
@@ -267,6 +270,9 @@ static int __init fsl_usb_of_init(void)
 		if (prop)
 			usb_data.port_enables |= FSL_USB2_PORT1_ENABLED;
 
+		if (of_get_property(np, "big-endian-regs", NULL))
+			usb_data.big_endian_mmio = 1;
+
 		prop = of_get_property(np, "phy_type", NULL);
 		usb_data.phy_mode = determine_usb_phy(prop);
 
@@ -332,9 +338,13 @@ static int __init fsl_usb_of_init(void)
 			ret = -EINVAL;
 			goto err;
 		}
+		if (of_get_property(np, "big-endian-regs", NULL))
+			usb_data.big_endian_mmio = 1;
 
 		prop = of_get_property(np, "phy_type", NULL);
 		usb_data.phy_mode = determine_usb_phy(prop);
+		usb_data.platform_init = fsl_platform_usb_ops.init;
+		usb_data.platform_uninit = fsl_platform_usb_ops.uninit;
 
 		if (usb_dev_dr_host) {
 			usb_dev_dr_host->dev.coherent_dma_mask = 0xffffffffUL;
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 42381bb..19754be 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -35,5 +35,14 @@ struct platform_diu_data_ops {
 extern struct platform_diu_data_ops diu_ops;
 #endif
 
+struct platform_device;
+
+struct fsl_platform_usb_ops {
+	int (*init)(struct platform_device *);
+	void (*uninit)(struct platform_device *);
+};
+
+extern struct fsl_platform_usb_ops fsl_platform_usb_ops;
+
 #endif
 #endif
diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 0e26aa1..c4ec00c 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -57,7 +57,7 @@ static int usb_hcd_fsl_probe(const struct hc_driver *driver,
 	pr_debug("initializing FSL-SOC USB Controller\n");
 
 	/* Need platform data for setup */
-	pdata = (struct fsl_usb2_platform_data *)pdev->dev.platform_data;
+	pdata = pdev->dev.platform_data;
 	if (!pdata) {
 		dev_err(&pdev->dev,
 			"No platform data for %s.\n", dev_name(&pdev->dev));
@@ -77,14 +77,13 @@ static int usb_hcd_fsl_probe(const struct hc_driver *driver,
 		return -ENODEV;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
 		dev_err(&pdev->dev,
 			"Found HC with no IRQ. Check %s setup!\n",
 			dev_name(&pdev->dev));
 		return -ENODEV;
 	}
-	irq = res->start;
 
 	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
 	if (!hcd) {
@@ -116,13 +115,39 @@ static int usb_hcd_fsl_probe(const struct hc_driver *driver,
 		goto err3;
 	}
 
-	/* Enable USB controller */
-	temp = in_be32(hcd->regs + 0x500);
-	out_be32(hcd->regs + 0x500, temp | 0x4);
+	pdata->regs = hcd->regs;
+
+	/*
+	 * do platform specific init: check the clock, grab/config pins, etc.
+	 */
+	if (pdata->platform_init && pdata->platform_init(pdev)) {
+		retval = -ENODEV;
+		goto err3;
+	}
+
+	/*
+	 * Check if it is MPC5121 SoC, otherwise set pdata->have_sysif_regs
+	 * flag for 83xx or 8536 system interface registers.
+	 */
+	if (pdata->big_endian_mmio)
+		temp = in_be32(hcd->regs + FSL_SOC_USB_ID);
+	else
+		temp = in_le32(hcd->regs + FSL_SOC_USB_ID);
+
+	if ((temp & ID_MSK) != (~((temp & NID_MSK) >> 8) & ID_MSK))
+		pdata->have_sysif_regs = 1;
+
+	/* Enable USB controller, 83xx or 8536 */
+	if (pdata->have_sysif_regs)
+		setbits32(hcd->regs + FSL_SOC_USB_CTRL, 0x4);
 
 	/* Set to Host mode */
-	temp = in_le32(hcd->regs + 0x1a8);
-	out_le32(hcd->regs + 0x1a8, temp | 0x3);
+	if (pdata->big_endian_mmio) {
+		setbits32(hcd->regs + FSL_SOC_USB_USBMODE, USBMODE_CM_HOST);
+	} else {
+		clrsetbits_le32(hcd->regs + FSL_SOC_USB_USBMODE,
+				USBMODE_CM_MASK, USBMODE_CM_HOST);
+	}
 
 	retval = usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHARED);
 	if (retval != 0)
@@ -137,6 +162,8 @@ static int usb_hcd_fsl_probe(const struct hc_driver *driver,
 	usb_put_hcd(hcd);
       err1:
 	dev_err(&pdev->dev, "init %s fail, %d\n", dev_name(&pdev->dev), retval);
+	if (pdata->platform_uninit)
+		pdata->platform_uninit(pdev);
 	return retval;
 }
 
@@ -154,17 +181,30 @@ static int usb_hcd_fsl_probe(const struct hc_driver *driver,
 static void usb_hcd_fsl_remove(struct usb_hcd *hcd,
 			       struct platform_device *pdev)
 {
+	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
+
 	usb_remove_hcd(hcd);
+
+	/*
+	 * do platform specific un-initialization:
+	 * release iomux pins, disable clock, etc.
+	 */
+	if (pdata->platform_uninit)
+		pdata->platform_uninit(pdev);
 	iounmap(hcd->regs);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
 }
 
-static void mpc83xx_setup_phy(struct ehci_hcd *ehci,
-			      enum fsl_usb2_phy_modes phy_mode,
-			      unsigned int port_offset)
+static void ehci_fsl_setup_phy(struct ehci_hcd *ehci,
+			       enum fsl_usb2_phy_modes phy_mode,
+			       unsigned int port_offset)
 {
-	u32 portsc = 0;
+	u32 portsc;
+
+	portsc = ehci_readl(ehci, &ehci->regs->port_status[port_offset]);
+	portsc &= ~(PORT_PTS_MSK | PORT_PTS_PTW);
+
 	switch (phy_mode) {
 	case FSL_USB2_PHY_ULPI:
 		portsc |= PORT_PTS_ULPI;
@@ -184,20 +224,21 @@ static void mpc83xx_setup_phy(struct ehci_hcd *ehci,
 	ehci_writel(ehci, portsc, &ehci->regs->port_status[port_offset]);
 }
 
-static void mpc83xx_usb_setup(struct usb_hcd *hcd)
+static void ehci_fsl_usb_setup(struct ehci_hcd *ehci)
 {
-	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	struct usb_hcd *hcd = ehci_to_hcd(ehci);
 	struct fsl_usb2_platform_data *pdata;
 	void __iomem *non_ehci = hcd->regs;
-	u32 temp;
+	u32 tmp;
+
+	pdata = hcd->self.controller->platform_data;
 
-	pdata =
-	    (struct fsl_usb2_platform_data *)hcd->self.controller->
-	    platform_data;
 	/* Enable PHY interface in the control reg. */
-	temp = in_be32(non_ehci + FSL_SOC_USB_CTRL);
-	out_be32(non_ehci + FSL_SOC_USB_CTRL, temp | 0x00000004);
-	out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0000001b);
+	if (pdata->have_sysif_regs) {
+		tmp = in_be32(non_ehci + FSL_SOC_USB_CTRL);
+		out_be32(non_ehci + FSL_SOC_USB_CTRL, tmp | 0x00000004);
+		out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0000001b);
+	}
 
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 	/*
@@ -214,7 +255,7 @@ static void mpc83xx_usb_setup(struct usb_hcd *hcd)
 
 	if ((pdata->operating_mode == FSL_USB2_DR_HOST) ||
 			(pdata->operating_mode == FSL_USB2_DR_OTG))
-		mpc83xx_setup_phy(ehci, pdata->phy_mode, 0);
+		ehci_fsl_setup_phy(ehci, pdata->phy_mode, 0);
 
 	if (pdata->operating_mode == FSL_USB2_MPH_HOST) {
 		unsigned int chip, rev, svr;
@@ -228,27 +269,31 @@ static void mpc83xx_usb_setup(struct usb_hcd *hcd)
 			ehci->has_fsl_port_bug = 1;
 
 		if (pdata->port_enables & FSL_USB2_PORT0_ENABLED)
-			mpc83xx_setup_phy(ehci, pdata->phy_mode, 0);
+			ehci_fsl_setup_phy(ehci, pdata->phy_mode, 0);
 		if (pdata->port_enables & FSL_USB2_PORT1_ENABLED)
-			mpc83xx_setup_phy(ehci, pdata->phy_mode, 1);
+			ehci_fsl_setup_phy(ehci, pdata->phy_mode, 1);
 	}
 
 	/* put controller in host mode. */
-	ehci_writel(ehci, 0x00000003, non_ehci + FSL_SOC_USB_USBMODE);
+	tmp = USBMODE_CM_HOST | (pdata->es ? USBMODE_ES : 0);
+	ehci_writel(ehci, tmp, non_ehci + FSL_SOC_USB_USBMODE);
+
+	if (pdata->have_sysif_regs) {
 #ifdef CONFIG_PPC_85xx
-	out_be32(non_ehci + FSL_SOC_USB_PRICTRL, 0x00000008);
-	out_be32(non_ehci + FSL_SOC_USB_AGECNTTHRSH, 0x00000080);
+		out_be32(non_ehci + FSL_SOC_USB_PRICTRL, 0x00000008);
+		out_be32(non_ehci + FSL_SOC_USB_AGECNTTHRSH, 0x00000080);
 #else
-	out_be32(non_ehci + FSL_SOC_USB_PRICTRL, 0x0000000c);
-	out_be32(non_ehci + FSL_SOC_USB_AGECNTTHRSH, 0x00000040);
+		out_be32(non_ehci + FSL_SOC_USB_PRICTRL, 0x0000000c);
+		out_be32(non_ehci + FSL_SOC_USB_AGECNTTHRSH, 0x00000040);
 #endif
-	out_be32(non_ehci + FSL_SOC_USB_SICTRL, 0x00000001);
+		out_be32(non_ehci + FSL_SOC_USB_SICTRL, 0x00000001);
+	}
 }
 
 /* called after powerup, by probe or system-pm "wakeup" */
 static int ehci_fsl_reinit(struct ehci_hcd *ehci)
 {
-	mpc83xx_usb_setup(ehci_to_hcd(ehci));
+	ehci_fsl_usb_setup(ehci);
 	ehci_port_power(ehci, 0);
 
 	return 0;
@@ -259,6 +304,11 @@ static int ehci_fsl_setup(struct usb_hcd *hcd)
 {
 	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
 	int retval;
+	struct fsl_usb2_platform_data *pdata;
+
+	pdata = hcd->self.controller->platform_data;
+	ehci->big_endian_desc = pdata->big_endian_desc;
+	ehci->big_endian_mmio = pdata->big_endian_mmio;
 
 	/* EHCI registers start at offset 0x100 */
 	ehci->caps = hcd->regs + 0x100;
@@ -369,7 +419,7 @@ static const struct hc_driver ehci_fsl_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq = ehci_irq,
-	.flags = HCD_USB2,
+	.flags = HCD_USB2 | HCD_MEMORY,
 
 	/*
 	 * basic lifecycle operations
diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
index b5e59db..3525bb4 100644
--- a/drivers/usb/host/ehci-fsl.h
+++ b/drivers/usb/host/ehci-fsl.h
@@ -1,4 +1,4 @@
-/* Copyright (c) 2005 freescale semiconductor
+/* Copyright (C) 2005-2009 Freescale Semiconductor, Inc. All rights reserved.
  * Copyright (c) 2005 MontaVista Software
  *
  * This program is free software; you can redistribute  it and/or modify it
@@ -19,6 +19,11 @@
 #define _EHCI_FSL_H
 
 /* offsets for the non-ehci registers in the FSL SOC USB controller */
+#define FSL_SOC_USB_ID		0x0
+#define ID_MSK			0x3f
+#define NID_MSK			0x3f00
+#define FSL_SOC_USB_SBUSCFG	0x90
+#define FSL_SOC_USB_BURSTSIZE	0x160
 #define FSL_SOC_USB_ULPIVP	0x170
 #define FSL_SOC_USB_PORTSC1	0x184
 #define PORT_PTS_MSK		(3<<30)
@@ -26,8 +31,20 @@
 #define PORT_PTS_ULPI		(2<<30)
 #define	PORT_PTS_SERIAL		(3<<30)
 #define PORT_PTS_PTW		(1<<28)
+#define PORT_PTS_PHCD		(1<<23)
 #define FSL_SOC_USB_PORTSC2	0x188
 #define FSL_SOC_USB_USBMODE	0x1a8
+#define USBMODE_CM_MASK		(3 << 0)	/* controller mode mask */
+#define USBMODE_CM_HOST		(3 << 0)	/* controller mode: host */
+#define USBMODE_ES		(1 << 2)	/* (Big) Endian Select */
+
+#define FSL_SOC_USB_USBGENCTRL 	0x200
+#define USBGENCTRL_PPP 		(1 << 3)
+#define USBGENCTRL_PFP		(1 << 2)
+#define FSL_SOC_USB_ISIPHYCTRL	0x204
+#define ISIPHYCTRL_PXE		(1)
+#define ISIPHYCTRL_PHYE		(1 << 4)
+
 #define FSL_SOC_USB_SNOOP1	0x400	/* NOTE: big-endian */
 #define FSL_SOC_USB_SNOOP2	0x404	/* NOTE: big-endian */
 #define FSL_SOC_USB_AGECNTTHRSH	0x408	/* NOTE: big-endian */
diff --git a/drivers/usb/host/ehci-mem.c b/drivers/usb/host/ehci-mem.c
index aeda96e..1e7e004 100644
--- a/drivers/usb/host/ehci-mem.c
+++ b/drivers/usb/host/ehci-mem.c
@@ -40,7 +40,7 @@ static inline void ehci_qtd_init(struct ehci_hcd *ehci, struct ehci_qtd *qtd,
 {
 	memset (qtd, 0, sizeof *qtd);
 	qtd->qtd_dma = dma;
-	qtd->hw_token = cpu_to_le32 (QTD_STS_HALT);
+	qtd->hw_token = cpu_to_hc32(ehci, QTD_STS_HALT);
 	qtd->hw_next = EHCI_LIST_END(ehci);
 	qtd->hw_alt_next = EHCI_LIST_END(ehci);
 	INIT_LIST_HEAD (&qtd->qtd_list);
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 28e33fe..dfe603f 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -58,11 +58,21 @@ enum fsl_usb2_phy_modes {
 	FSL_USB2_PHY_SERIAL,
 };
 
+struct platform_device;
 struct fsl_usb2_platform_data {
 	/* board specific information */
 	enum fsl_usb2_operating_modes	operating_mode;
 	enum fsl_usb2_phy_modes		phy_mode;
 	unsigned int			port_enables;
+
+	char				*name;		/* pretty print */
+	int (*platform_init) (struct platform_device *);
+	void (*platform_uninit) (struct platform_device *);
+	void __iomem			*regs;	/* ioremap'd register base */
+	unsigned			big_endian_mmio:1;
+	unsigned			big_endian_desc:1;
+	unsigned			es:1;		/* need USBMODE:ES */
+	unsigned			have_sysif_regs:1;
 };
 
 /* Flags in fsl_usb2_mph_platform_data */
-- 
1.5.6.3
