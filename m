Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 38E83B8DC8
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Feb 2010 00:44:35 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 08/11] powerpc/mpc5121: add USB host support
Date: Fri,  5 Feb 2010 14:42:54 +0100
Message-Id: <1265377377-29327-9-git-send-email-agust@denx.de>
In-Reply-To: <1265377377-29327-1-git-send-email-agust@denx.de>
References: <1265377377-29327-1-git-send-email-agust@denx.de>
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

The patch also contains changes to FSL EHCI platform driver
needed to support MPC5121 USB controller. MPC5121 Rev 2.0
silicon EHCI registers are in big endian format. The
appropriate flags are set using the information in the
platform data structure. 83xx system interface registers
are not available on 512x, so the access to these registers
is isolated for 512x. Furthermore the USB controller clock
must be enabled before 512x register access which is done
by providing platform specific init callback.

The 512x internal USB PHY doesn't provide supply voltage.
For boards using different power switches allow specifying
DRVVBUS and PWR_FAULT signal polarity of the MPC5121 internal
PHY using "fsl,invert-drvvbus" and "fsl,invert-pwr-fault"
properties in the device tree USB node.

Signed-off-by: Bruce Schmid <duck@freescale.com>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: linux-usb@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>
---
Changes since V2:
 - drop fsl,big-endian-regs property and set the appropriate
   flag in the platform code.
 - test for "fsl,mpc5121-usb2-dr" compatible nodes directly
   and instantiate the platform devices if this node is
   present. Enable the USB controller clocks only for
   devices described in the device tree
 - update the dts-bindings description and provide an
   example for mpc5121ads USB node
 
Changes since v1:
 - prefix the property names with 'fsl,'
 - drop currently unused USB_FSL_BIG_ENDIAN_MMIO config option
 - remove unrelated changes which can be addressed by
   separate patch
 - fix commit message

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

 Documentation/powerpc/dts-bindings/fsl/usb.txt |   22 ++++
 arch/powerpc/platforms/512x/Kconfig            |    3 +
 arch/powerpc/platforms/512x/Makefile           |    2 +-
 arch/powerpc/platforms/512x/mpc5121_usb.c      |  138 ++++++++++++++++++++++++
 arch/powerpc/platforms/512x/mpc512x.h          |    1 +
 arch/powerpc/platforms/512x/mpc512x_shared.c   |    1 +
 arch/powerpc/sysdev/fsl_soc.c                  |   13 +++
 arch/powerpc/sysdev/fsl_soc.h                  |    9 ++
 drivers/usb/host/ehci-fsl.c                    |  111 ++++++++++++++-----
 drivers/usb/host/ehci-fsl.h                    |   19 +++-
 drivers/usb/host/ehci-mem.c                    |    2 +-
 include/linux/fsl_devices.h                    |   10 ++
 12 files changed, 298 insertions(+), 33 deletions(-)
 create mode 100644 arch/powerpc/platforms/512x/mpc5121_usb.c

diff --git a/Documentation/powerpc/dts-bindings/fsl/usb.txt b/Documentation/powerpc/dts-bindings/fsl/usb.txt
index b001524..76a7c2c 100644
--- a/Documentation/powerpc/dts-bindings/fsl/usb.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/usb.txt
@@ -8,6 +8,7 @@ and additions :
 Required properties :
  - compatible : Should be "fsl-usb2-mph" for multi port host USB
    controllers, or "fsl-usb2-dr" for dual role USB controllers
+   or "fsl,mpc5121-usb2-dr" for dual role USB controllers of MPC5121
  - phy_type : For multi port host USB controllers, should be one of
    "ulpi", or "serial". For dual role USB controllers, should be
    one of "ulpi", "utmi", "utmi_wide", or "serial".
@@ -33,6 +34,12 @@ Recommended properties :
  - interrupt-parent : the phandle for the interrupt controller that
    services interrupts for this device.
 
+Optional properties :
+ - fsl,invert-drvvbus : boolean; for MPC5121 only. Indicates the port
+   power polarity of internal PHY signal DRVVBUS is inverted.
+ - fsl,invert-pwr-fault : boolean; for MPC5121 only. Indicates the
+   PWR_FAULT signal polarity is inverted.
+
 Example multi port host USB controller device node :
 	usb@22000 {
 		compatible = "fsl-usb2-mph";
@@ -57,3 +64,18 @@ Example dual role USB controller device node :
 		dr_mode = "otg";
 		phy = "ulpi";
 	};
+
+Example dual role USB controller device node for MPC5121ADS:
+
+	usb@4000 {
+		compatible = "fsl,mpc5121-usb2-dr";
+		reg = <0x4000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupt-parent = < &ipic >;
+		interrupts = <44 0x8>;
+		dr_mode = "otg";
+		phy_type = "utmi_wide";
+		fsl,invert-drvvbus;
+		fsl,invert-pwr-fault;
+	};
diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index 4dac9b0..fed7b5d 100644
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
diff --git a/arch/powerpc/platforms/512x/mpc5121_usb.c b/arch/powerpc/platforms/512x/mpc5121_usb.c
new file mode 100644
index 0000000..9536750
--- /dev/null
+++ b/arch/powerpc/platforms/512x/mpc5121_usb.c
@@ -0,0 +1,138 @@
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
+#define USB_ULPI		0x3000
+#define USB_UTMI		0x4000
+
+static struct dr_clk {
+	struct clk *clk;
+	const char *clk_name;
+} mpc512x_usb_dr_clk[2] = {
+	{ NULL, "usb1_clk", },
+	{ NULL, "usb2_clk", },
+};
+
+static inline struct dr_clk *get_pdev_clk(struct platform_device *pdev)
+{
+	switch (pdev->resource->start & 0xf000) {
+	case USB_ULPI:
+		return &mpc512x_usb_dr_clk[0];
+	case USB_UTMI:
+		return &mpc512x_usb_dr_clk[1];
+	default:
+		return NULL;
+	}
+}
+
+static int mpc5121_usb_dr_init(struct platform_device *pdev)
+{
+	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
+	struct dr_clk *dr_clk;
+
+	dr_clk = get_pdev_clk(pdev);
+	if (!dr_clk)
+		return -EINVAL;
+
+	/* enable the clock if we haven't already */
+	if (!dr_clk->clk) {
+		dr_clk->clk = clk_get(&pdev->dev, dr_clk->clk_name);
+		if (IS_ERR(dr_clk->clk)) {
+			dev_err(&pdev->dev, "%s: clk_get failed\n",
+				dr_clk->clk_name);
+			dr_clk->clk = NULL;
+			return -ENODEV;
+		}
+		clk_enable(dr_clk->clk);
+	}
+
+	pdata->big_endian_desc = 1;
+	pdata->big_endian_mmio = 1;
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
+		if (of_get_property(np, "fsl,invert-drvvbus", NULL))
+			reg |= GC_PPP;
+
+		if (of_get_property(np, "fsl,invert-pwr-fault", NULL))
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
+	struct dr_clk *dr_clk;
+
+	pdata->regs = NULL;
+
+	dr_clk = get_pdev_clk(pdev);
+	if (!dr_clk)
+		return;
+
+	if (dr_clk->clk) {
+		clk_disable(dr_clk->clk);
+		clk_put(dr_clk->clk);
+		dr_clk->clk = NULL;
+	}
+}
+
+void __init mpc5121_usb_init(void)
+{
+	fsl_platform_usb_ops.init = mpc5121_usb_dr_init;
+	fsl_platform_usb_ops.uninit = mpc5121_usb_dr_uninit;
+}
diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
index b2daca0..d72b2c7 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -16,4 +16,5 @@ extern void __init mpc512x_init(void);
 extern int __init mpc5121_clk_init(void);
 void __init mpc512x_declare_of_platform_devices(void);
 extern void mpc512x_restart(char *cmd);
+extern void __init mpc5121_usb_init(void);
 #endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 8bb34b2..4de8175 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -104,4 +104,5 @@ void __init mpc512x_init(void)
 	mpc512x_declare_of_platform_devices();
 	mpc5121_clk_init();
 	mpc512x_restart_init();
+	mpc5121_usb_init();
 }
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 7bd6436..75a0c07 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -209,6 +209,9 @@ static int __init of_add_fixed_phys(void)
 arch_initcall(of_add_fixed_phys);
 #endif /* CONFIG_FIXED_PHY */
 
+struct fsl_platform_usb_ops fsl_platform_usb_ops;
+EXPORT_SYMBOL(fsl_platform_usb_ops);
+
 struct fsl_usb2_dev_data {
 	char *dr_mode;		/* controller mode */
 	char *drivers[2];	/* drivers to instantiate for this mode */
@@ -345,6 +348,16 @@ static int __init fsl_usb_of_init(void)
 			return ret;
 	}
 
+	for_each_compatible_node(np, NULL, "fsl,mpc5121-usb2-dr") {
+		memset(&pdata, 0, sizeof(pdata));
+		pdata.platform_init = fsl_platform_usb_ops.init;
+		pdata.platform_uninit = fsl_platform_usb_ops.uninit;
+		ret = fsl_usb2_register_device(np, get_dr_data(np),
+						&pdata, idx++);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 arch_initcall(fsl_usb_of_init);
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
index 0e26aa1..6b3f1df 100644
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
@@ -116,13 +116,39 @@ static int usb_hcd_fsl_probe(const struct hc_driver *driver,
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
@@ -137,6 +163,8 @@ static int usb_hcd_fsl_probe(const struct hc_driver *driver,
 	usb_put_hcd(hcd);
       err1:
 	dev_err(&pdev->dev, "init %s fail, %d\n", dev_name(&pdev->dev), retval);
+	if (pdata->platform_uninit)
+		pdata->platform_uninit(pdev);
 	return retval;
 }
 
@@ -154,17 +182,30 @@ static int usb_hcd_fsl_probe(const struct hc_driver *driver,
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
@@ -184,20 +225,21 @@ static void mpc83xx_setup_phy(struct ehci_hcd *ehci,
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
@@ -214,7 +256,7 @@ static void mpc83xx_usb_setup(struct usb_hcd *hcd)
 
 	if ((pdata->operating_mode == FSL_USB2_DR_HOST) ||
 			(pdata->operating_mode == FSL_USB2_DR_OTG))
-		mpc83xx_setup_phy(ehci, pdata->phy_mode, 0);
+		ehci_fsl_setup_phy(ehci, pdata->phy_mode, 0);
 
 	if (pdata->operating_mode == FSL_USB2_MPH_HOST) {
 		unsigned int chip, rev, svr;
@@ -228,27 +270,31 @@ static void mpc83xx_usb_setup(struct usb_hcd *hcd)
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
@@ -259,6 +305,11 @@ static int ehci_fsl_setup(struct usb_hcd *hcd)
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
@@ -369,7 +420,7 @@ static const struct hc_driver ehci_fsl_hc_driver = {
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
1.6.3.3
