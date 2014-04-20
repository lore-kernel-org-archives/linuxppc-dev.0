Return-Path: <punnaiah.choudary.kalluri@xilinx.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 72EB114009D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 02:23:46 +1000 (EST)
From: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
To: <leoli@freescale.com>, <balbi@ti.com>, <michal.simek@xilinx.c>
Subject: [RFC PATCH 2/2] usb: ehci-fsl: Add support for zynq usb host
 controller
Date: Sun, 20 Apr 2014 21:53:29 +0530
In-Reply-To: <1398011009-10978-1-git-send-email-punnaia@xilinx.com>
References: <1398011009-10978-1-git-send-email-punnaia@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <b036d410-ce7b-427a-a5ad-da3c8ec113a0@CH1EHSMHS019.ehs.local>
Cc: Punnaiah Choudary Kalluri <punnaia@xilinx.com>, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since zynq soc usb controller is a synopsys IP and there is a driver
available for this controller from freescale in opensource, reusing this
driver for zynq use.

Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
---
 drivers/usb/host/Kconfig    |    2 +-
 drivers/usb/host/ehci-fsl.c |   63 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 3d9e540..295274e 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -117,7 +117,7 @@ config XPS_USB_HCD_XILINX
 
 config USB_EHCI_FSL
 	bool "Support for Freescale PPC on-chip EHCI USB controller"
-	depends on FSL_SOC
+	depends on FSL_SOC || ARCH_ZYNQ
 	select USB_EHCI_ROOT_HUB_TT
 	select USB_FSL_MPH_DR_OF if OF
 	---help---
diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 6f2c8d3..54db34f 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -23,11 +23,13 @@
  * Anton Vorontsov <avorontsov@ru.mvista.com>.
  */
 
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/err.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/fsl_devices.h>
 
@@ -86,6 +88,15 @@ static int usb_hcd_fsl_probe(const struct hc_driver *driver,
 	}
 	irq = res->start;
 
+#ifdef CONFIG_ARCH_ZYNQ
+	pdata->clk = devm_clk_get(pdev->dev.parent, NULL);
+	if (IS_ERR(pdata->clk))
+		return PTR_ERR(pdata->clk);
+
+	retval = clk_prepare_enable(pdata->clk);
+	if (retval)
+		return retval;
+#endif
 	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
 	if (!hcd) {
 		retval = -ENOMEM;
@@ -121,9 +132,11 @@ static int usb_hcd_fsl_probe(const struct hc_driver *driver,
 		goto err2;
 	}
 
+#ifdef CONFIG_FSL_SOC
 	/* Enable USB controller, 83xx or 8536 */
 	if (pdata->have_sysif_regs && pdata->controller_ver < FSL_USB_VER_1_6)
 		setbits32(hcd->regs + FSL_SOC_USB_CTRL, 0x4);
+#endif
 
 	/* Don't need to set host mode here. It will be done by tdi_reset() */
 
@@ -159,6 +172,9 @@ static int usb_hcd_fsl_probe(const struct hc_driver *driver,
       err2:
 	usb_put_hcd(hcd);
       err1:
+#ifdef CONFIG_ARCH_ZYNQ
+	clk_disable_unprepare(pdata->clk);
+#endif
 	dev_err(&pdev->dev, "init %s fail, %d\n", dev_name(&pdev->dev), retval);
 	if (pdata->exit)
 		pdata->exit(pdev);
@@ -203,6 +219,7 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 {
 	u32 portsc;
 	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+#ifdef CONFIG_FSL_SOC
 	void __iomem *non_ehci = hcd->regs;
 	struct device *dev = hcd->self.controller;
 	struct fsl_usb2_platform_data *pdata = dev_get_platdata(dev);
@@ -211,18 +228,21 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 		dev_warn(hcd->self.controller, "Could not get controller version\n");
 		return -ENODEV;
 	}
+#endif
 
 	portsc = ehci_readl(ehci, &ehci->regs->port_status[port_offset]);
 	portsc &= ~(PORT_PTS_MSK | PORT_PTS_PTW);
 
 	switch (phy_mode) {
 	case FSL_USB2_PHY_ULPI:
+#ifdef CONFIG_FSL_SOC
 		if (pdata->have_sysif_regs && pdata->controller_ver) {
 			/* controller version 1.6 or above */
 			clrbits32(non_ehci + FSL_SOC_USB_CTRL, UTMI_PHY_EN);
 			setbits32(non_ehci + FSL_SOC_USB_CTRL,
 				ULPI_PHY_CLK_SEL | USB_CTRL_USB_EN);
 		}
+#endif
 		portsc |= PORT_PTS_ULPI;
 		break;
 	case FSL_USB2_PHY_SERIAL:
@@ -232,6 +252,7 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 		portsc |= PORT_PTS_PTW;
 		/* fall through */
 	case FSL_USB2_PHY_UTMI:
+#ifdef CONFIG_FSL_SOC
 		if (pdata->have_sysif_regs && pdata->controller_ver) {
 			/* controller version 1.6 or above */
 			setbits32(non_ehci + FSL_SOC_USB_CTRL, UTMI_PHY_EN);
@@ -242,12 +263,14 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 		if (pdata->have_sysif_regs)
 			setbits32(non_ehci + FSL_SOC_USB_CTRL,
 				  CTRL_UTMI_PHY_EN);
+#endif
 		portsc |= PORT_PTS_UTMI;
 		break;
 	case FSL_USB2_PHY_NONE:
 		break;
 	}
 
+#ifdef CONFIG_FSL_SOC
 	if (pdata->have_sysif_regs && pdata->controller_ver &&
 	    (phy_mode == FSL_USB2_PHY_ULPI)) {
 		/* check PHY_CLK_VALID to get phy clk valid */
@@ -258,11 +281,14 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 			return -EINVAL;
 		}
 	}
+#endif
 
 	ehci_writel(ehci, portsc, &ehci->regs->port_status[port_offset]);
 
+#ifdef CONFIG_FSL_SOC
 	if (phy_mode != FSL_USB2_PHY_ULPI && pdata->have_sysif_regs)
 		setbits32(non_ehci + FSL_SOC_USB_CTRL, USB_CTRL_USB_EN);
+#endif
 
 	return 0;
 }
@@ -271,10 +297,13 @@ static int ehci_fsl_usb_setup(struct ehci_hcd *ehci)
 {
 	struct usb_hcd *hcd = ehci_to_hcd(ehci);
 	struct fsl_usb2_platform_data *pdata;
+#ifdef CONFIG_FSL_SOC
 	void __iomem *non_ehci = hcd->regs;
+#endif
 
 	pdata = dev_get_platdata(hcd->self.controller);
 
+#ifdef CONFIG_FSL_SOC
 	if (pdata->have_sysif_regs) {
 		/*
 		* Turn on cache snooping hardware, since some PowerPC platforms
@@ -287,6 +316,7 @@ static int ehci_fsl_usb_setup(struct ehci_hcd *ehci)
 		/* SNOOP2 starts from 0x80000000, size 2G */
 		out_be32(non_ehci + FSL_SOC_USB_SNOOP2, 0x80000000 | SNOOP_SIZE_2GB);
 	}
+#endif
 
 	if ((pdata->operating_mode == FSL_USB2_DR_HOST) ||
 			(pdata->operating_mode == FSL_USB2_DR_OTG))
@@ -294,6 +324,7 @@ static int ehci_fsl_usb_setup(struct ehci_hcd *ehci)
 			return -EINVAL;
 
 	if (pdata->operating_mode == FSL_USB2_MPH_HOST) {
+#ifdef CONFIG_FSL_SOC
 		unsigned int chip, rev, svr;
 
 		svr = mfspr(SPRN_SVR);
@@ -304,6 +335,7 @@ static int ehci_fsl_usb_setup(struct ehci_hcd *ehci)
 		if ((rev == 1) && (chip >= 0x8050) && (chip <= 0x8055))
 			ehci->has_fsl_port_bug = 1;
 
+#endif
 		if (pdata->port_enables & FSL_USB2_PORT0_ENABLED)
 			if (ehci_fsl_setup_phy(hcd, pdata->phy_mode, 0))
 				return -EINVAL;
@@ -313,6 +345,7 @@ static int ehci_fsl_usb_setup(struct ehci_hcd *ehci)
 				return -EINVAL;
 	}
 
+#ifdef CONFIG_FSL_SOC
 	if (pdata->have_sysif_regs) {
 #ifdef CONFIG_FSL_SOC_BOOKE
 		out_be32(non_ehci + FSL_SOC_USB_PRICTRL, 0x00000008);
@@ -323,6 +356,7 @@ static int ehci_fsl_usb_setup(struct ehci_hcd *ehci)
 #endif
 		out_be32(non_ehci + FSL_SOC_USB_SICTRL, 0x00000001);
 	}
+#endif
 
 	return 0;
 }
@@ -346,8 +380,10 @@ static int ehci_fsl_setup(struct usb_hcd *hcd)
 
 	dev = hcd->self.controller;
 	pdata = dev_get_platdata(hcd->self.controller);
+#ifdef FSL_SOC
 	ehci->big_endian_desc = pdata->big_endian_desc;
 	ehci->big_endian_mmio = pdata->big_endian_mmio;
+#endif
 
 	/* EHCI registers start at offset 0x100 */
 	ehci->caps = hcd->regs + 0x100;
@@ -537,18 +573,25 @@ static inline int ehci_fsl_mpc512x_drv_resume(struct device *dev)
 }
 #endif /* CONFIG_PPC_MPC512x */
 
+#ifdef CONFIG_FSL_SOC
 static struct ehci_fsl *hcd_to_ehci_fsl(struct usb_hcd *hcd)
 {
 	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
 
 	return container_of(ehci, struct ehci_fsl, ehci);
 }
+#endif
 
 static int ehci_fsl_drv_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
+#ifdef CONFIG_FSL_SOC
 	struct ehci_fsl *ehci_fsl = hcd_to_ehci_fsl(hcd);
 	void __iomem *non_ehci = hcd->regs;
+#endif
+#ifdef CONFIG_ARCH_ZYNQ
+	struct fsl_usb2_platform_data *pdata = dev_get_platdata(dev);
+#endif
 
 	if (of_device_is_compatible(dev->parent->of_node,
 				    "fsl,mpc5121-usb2-dr")) {
@@ -557,33 +600,51 @@ static int ehci_fsl_drv_suspend(struct device *dev)
 
 	ehci_prepare_ports_for_controller_suspend(hcd_to_ehci(hcd),
 			device_may_wakeup(dev));
+#ifdef CONFIG_FSL_SOC
 	if (!fsl_deep_sleep())
 		return 0;
 
 	ehci_fsl->usb_ctrl = in_be32(non_ehci + FSL_SOC_USB_CTRL);
+#endif
+#ifdef CONFIG_ARCH_ZYNQ
+	clk_disable(pdata->clk);
+#endif
 	return 0;
 }
 
 static int ehci_fsl_drv_resume(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
-	struct ehci_fsl *ehci_fsl = hcd_to_ehci_fsl(hcd);
 	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+#ifdef CONFIG_FSL_SOC
+	struct ehci_fsl *ehci_fsl = hcd_to_ehci_fsl(hcd);
 	void __iomem *non_ehci = hcd->regs;
+#endif
+#ifdef CONFIG_ARCH_ZYNQ
+	struct fsl_usb2_platform_data *pdata = dev_get_platdata(dev);
+#endif
+
 
 	if (of_device_is_compatible(dev->parent->of_node,
 				    "fsl,mpc5121-usb2-dr")) {
 		return ehci_fsl_mpc512x_drv_resume(dev);
 	}
+#ifdef CONFIG_ARCH_ZYNQ
+	clk_disable(pdata->clk);
+#endif
 
 	ehci_prepare_ports_for_controller_resume(ehci);
+#ifdef CONFIG_FSL_SOC
 	if (!fsl_deep_sleep())
 		return 0;
+#endif
 
 	usb_root_hub_lost_power(hcd->self.root_hub);
 
+#ifdef CONFIG_FSL_SOC
 	/* Restore USB PHY settings and enable the controller. */
 	out_be32(non_ehci + FSL_SOC_USB_CTRL, ehci_fsl->usb_ctrl);
+#endif
 
 	ehci_reset(ehci);
 	ehci_fsl_reinit(ehci);
-- 
1.7.4
