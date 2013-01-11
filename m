Return-Path: <B29397@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CF6C12C009A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 20:56:44 +1100 (EST)
From: Peter Chen <peter.chen@freescale.com>
To: <shawn.guo@linaro.org>, <balbi@ti.com>, <kernel@pengutronix.de>,
 <gregkh@linuxfoundation.org>, <r58472@freescale.com>
Subject: [PATCH 1/1] usb: fsl-mxc-udc: fix build error due to mach/hardware.h
Date: Fri, 11 Jan 2013 17:56:28 +0800
Message-ID: <1357898188-10540-1-git-send-email-peter.chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It changes the driver to use platform_device_id rather than cpu_is_xxx
to determine the SoC type, and updates the platform code accordingly.

Compile ok at imx_v6_v7_defconfig with CONFIG_USB_FSL_USB2 enable.
Tested at mx51 bbg board, it works ok after enable phy clock
(Need another patch to fix this problem)

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/mach-imx/clk-imx25.c                     |    6 +-
 arch/arm/mach-imx/clk-imx27.c                     |    6 +-
 arch/arm/mach-imx/clk-imx31.c                     |    6 +-
 arch/arm/mach-imx/clk-imx35.c                     |    6 +-
 arch/arm/mach-imx/clk-imx51-imx53.c               |    6 +-
 arch/arm/mach-imx/devices/devices-common.h        |    1 +
 arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c |   15 +++---
 drivers/usb/gadget/fsl_mxc_udc.c                  |   17 +++----
 drivers/usb/gadget/fsl_udc_core.c                 |   52 +++++++++++++-------
 drivers/usb/gadget/fsl_usb2_udc.h                 |   13 ++++--
 include/linux/fsl_devices.h                       |    8 +++
 11 files changed, 82 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index b197aa7..67e353d 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -254,9 +254,9 @@ int __init mx25_clocks_init(void)
 	clk_register_clkdev(clk[ipg], "ipg", "mxc-ehci.2");
 	clk_register_clkdev(clk[usbotg_ahb], "ahb", "mxc-ehci.2");
 	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.2");
-	clk_register_clkdev(clk[ipg], "ipg", "fsl-usb2-udc");
-	clk_register_clkdev(clk[usbotg_ahb], "ahb", "fsl-usb2-udc");
-	clk_register_clkdev(clk[usb_div], "per", "fsl-usb2-udc");
+	clk_register_clkdev(clk[ipg], "ipg", "imx-udc-mx25");
+	clk_register_clkdev(clk[usbotg_ahb], "ahb", "imx-udc-mx25");
+	clk_register_clkdev(clk[usb_div], "per", "imx-udc-mx25");
 	clk_register_clkdev(clk[nfc_ipg_per], NULL, "imx25-nand.0");
 	/* i.mx25 has the i.mx35 type cspi */
 	clk_register_clkdev(clk[cspi1_ipg], NULL, "imx35-cspi.0");
diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index 4c1d1e4..1ffe3b5 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -236,9 +236,9 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[lcdc_ahb_gate], "ahb", "imx21-fb.0");
 	clk_register_clkdev(clk[csi_ahb_gate], "ahb", "imx27-camera.0");
 	clk_register_clkdev(clk[per4_gate], "per", "imx27-camera.0");
-	clk_register_clkdev(clk[usb_div], "per", "fsl-usb2-udc");
-	clk_register_clkdev(clk[usb_ipg_gate], "ipg", "fsl-usb2-udc");
-	clk_register_clkdev(clk[usb_ahb_gate], "ahb", "fsl-usb2-udc");
+	clk_register_clkdev(clk[usb_div], "per", "imx-udc-mx27");
+	clk_register_clkdev(clk[usb_ipg_gate], "ipg", "imx-udc-mx27");
+	clk_register_clkdev(clk[usb_ahb_gate], "ahb", "imx-udc-mx27");
 	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.0");
 	clk_register_clkdev(clk[usb_ipg_gate], "ipg", "mxc-ehci.0");
 	clk_register_clkdev(clk[usb_ahb_gate], "ahb", "mxc-ehci.0");
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index 8be64e0..ef66eaf 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -139,9 +139,9 @@ int __init mx31_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[usb_div_post], "per", "mxc-ehci.2");
 	clk_register_clkdev(clk[usb_gate], "ahb", "mxc-ehci.2");
 	clk_register_clkdev(clk[ipg], "ipg", "mxc-ehci.2");
-	clk_register_clkdev(clk[usb_div_post], "per", "fsl-usb2-udc");
-	clk_register_clkdev(clk[usb_gate], "ahb", "fsl-usb2-udc");
-	clk_register_clkdev(clk[ipg], "ipg", "fsl-usb2-udc");
+	clk_register_clkdev(clk[usb_div_post], "per", "imx-udc-mx31");
+	clk_register_clkdev(clk[usb_gate], "ahb", "imx-udc-mx31");
+	clk_register_clkdev(clk[ipg], "ipg", "imx-udc-mx31");
 	clk_register_clkdev(clk[csi_gate], NULL, "mx3-camera.0");
 	/* i.mx31 has the i.mx21 type uart */
 	clk_register_clkdev(clk[uart1_gate], "per", "imx21-uart.0");
diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index 66f3d65..69fe9c8 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -251,9 +251,9 @@ int __init mx35_clocks_init()
 	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.2");
 	clk_register_clkdev(clk[ipg], "ipg", "mxc-ehci.2");
 	clk_register_clkdev(clk[usbotg_gate], "ahb", "mxc-ehci.2");
-	clk_register_clkdev(clk[usb_div], "per", "fsl-usb2-udc");
-	clk_register_clkdev(clk[ipg], "ipg", "fsl-usb2-udc");
-	clk_register_clkdev(clk[usbotg_gate], "ahb", "fsl-usb2-udc");
+	clk_register_clkdev(clk[usb_div], "per", "imx-udc-mx35");
+	clk_register_clkdev(clk[ipg], "ipg", "imx-udc-mx35");
+	clk_register_clkdev(clk[usbotg_gate], "ahb", "imx-udc-mx35");
 	clk_register_clkdev(clk[wdog_gate], NULL, "imx2-wdt.0");
 	clk_register_clkdev(clk[nfc_div], NULL, "imx25-nand.0");
 	clk_register_clkdev(clk[csi_gate], NULL, "mx3-camera.0");
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 579023f..fb7cb84 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -269,9 +269,9 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk_register_clkdev(clk[usboh3_per_gate], "per", "mxc-ehci.2");
 	clk_register_clkdev(clk[usboh3_gate], "ipg", "mxc-ehci.2");
 	clk_register_clkdev(clk[usboh3_gate], "ahb", "mxc-ehci.2");
-	clk_register_clkdev(clk[usboh3_per_gate], "per", "fsl-usb2-udc");
-	clk_register_clkdev(clk[usboh3_gate], "ipg", "fsl-usb2-udc");
-	clk_register_clkdev(clk[usboh3_gate], "ahb", "fsl-usb2-udc");
+	clk_register_clkdev(clk[usboh3_per_gate], "per", "imx-udc-mx51");
+	clk_register_clkdev(clk[usboh3_gate], "ipg", "imx-udc-mx51");
+	clk_register_clkdev(clk[usboh3_gate], "ahb", "imx-udc-mx51");
 	clk_register_clkdev(clk[nfc_gate], NULL, "imx51-nand");
 	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
 	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");
diff --git a/arch/arm/mach-imx/devices/devices-common.h b/arch/arm/mach-imx/devices/devices-common.h
index 6277baf..9bd5777 100644
--- a/arch/arm/mach-imx/devices/devices-common.h
+++ b/arch/arm/mach-imx/devices/devices-common.h
@@ -63,6 +63,7 @@ struct platform_device *__init imx_add_flexcan(
 
 #include <linux/fsl_devices.h>
 struct imx_fsl_usb2_udc_data {
+	const char *devid;
 	resource_size_t iobase;
 	resource_size_t irq;
 };
diff --git a/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c b/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
index 37e4439..fb527c7 100644
--- a/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
+++ b/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
@@ -11,35 +11,36 @@
 #include "../hardware.h"
 #include "devices-common.h"
 
-#define imx_fsl_usb2_udc_data_entry_single(soc)				\
+#define imx_fsl_usb2_udc_data_entry_single(soc, _devid)			\
 	{								\
+		.devid = _devid,					\
 		.iobase = soc ## _USB_OTG_BASE_ADDR,			\
 		.irq = soc ## _INT_USB_OTG,				\
 	}
 
 #ifdef CONFIG_SOC_IMX25
 const struct imx_fsl_usb2_udc_data imx25_fsl_usb2_udc_data __initconst =
-	imx_fsl_usb2_udc_data_entry_single(MX25);
+	imx_fsl_usb2_udc_data_entry_single(MX25, "imx-udc-mx25");
 #endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX27
 const struct imx_fsl_usb2_udc_data imx27_fsl_usb2_udc_data __initconst =
-	imx_fsl_usb2_udc_data_entry_single(MX27);
+	imx_fsl_usb2_udc_data_entry_single(MX27, "imx-udc-mx27");
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
 #ifdef CONFIG_SOC_IMX31
 const struct imx_fsl_usb2_udc_data imx31_fsl_usb2_udc_data __initconst =
-	imx_fsl_usb2_udc_data_entry_single(MX31);
+	imx_fsl_usb2_udc_data_entry_single(MX31, "imx-udc-mx31");
 #endif /* ifdef CONFIG_SOC_IMX31 */
 
 #ifdef CONFIG_SOC_IMX35
 const struct imx_fsl_usb2_udc_data imx35_fsl_usb2_udc_data __initconst =
-	imx_fsl_usb2_udc_data_entry_single(MX35);
+	imx_fsl_usb2_udc_data_entry_single(MX35, "imx-udc-mx35");
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
 #ifdef CONFIG_SOC_IMX51
 const struct imx_fsl_usb2_udc_data imx51_fsl_usb2_udc_data __initconst =
-	imx_fsl_usb2_udc_data_entry_single(MX51);
+	imx_fsl_usb2_udc_data_entry_single(MX51, "imx-udc-mx51");
 #endif
 
 struct platform_device *__init imx_add_fsl_usb2_udc(
@@ -57,7 +58,7 @@ struct platform_device *__init imx_add_fsl_usb2_udc(
 			.flags = IORESOURCE_IRQ,
 		},
 	};
-	return imx_add_platform_device_dmamask("fsl-usb2-udc", -1,
+	return imx_add_platform_device_dmamask(data->devid, -1,
 			res, ARRAY_SIZE(res),
 			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
 }
diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
index 1b0f086..f313085 100644
--- a/drivers/usb/gadget/fsl_mxc_udc.c
+++ b/drivers/usb/gadget/fsl_mxc_udc.c
@@ -18,8 +18,6 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
-
 static struct clk *mxc_ahb_clk;
 static struct clk *mxc_per_clk;
 static struct clk *mxc_ipg_clk;
@@ -28,7 +26,7 @@ static struct clk *mxc_ipg_clk;
 #define USBPHYCTRL_OTGBASE_OFFSET	0x608
 #define USBPHYCTRL_EVDO			(1 << 23)
 
-int fsl_udc_clk_init(struct platform_device *pdev)
+int fsl_udc_clk_init(enum fsl_udc_type devtype, struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata;
 	unsigned long freq;
@@ -59,7 +57,7 @@ int fsl_udc_clk_init(struct platform_device *pdev)
 	clk_prepare_enable(mxc_per_clk);
 
 	/* make sure USB_CLK is running at 60 MHz +/- 1000 Hz */
-	if (!cpu_is_mx51()) {
+	if (!(devtype == IMX51_UDC)) {
 		freq = clk_get_rate(mxc_per_clk);
 		if (pdata->phy_mode != FSL_USB2_PHY_ULPI &&
 		    (freq < 59999000 || freq > 60001000)) {
@@ -79,19 +77,18 @@ eclkrate:
 	return ret;
 }
 
-void fsl_udc_clk_finalize(struct platform_device *pdev)
+void fsl_udc_clk_finalize(enum fsl_udc_type devtype,
+	struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
-	if (cpu_is_mx35()) {
+	if (devtype == IMX35_UDC) {
 		unsigned int v;
 
 		/* workaround ENGcm09152 for i.MX35 */
 		if (pdata->workaround & FLS_USB2_WORKAROUND_ENGCM09152) {
-			v = readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
-					USBPHYCTRL_OTGBASE_OFFSET));
+			v = readl(pdata->regs + USBPHYCTRL_OTGBASE_OFFSET);
 			writel(v | USBPHYCTRL_EVDO,
-				MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
-					USBPHYCTRL_OTGBASE_OFFSET));
+				pdata->regs + USBPHYCTRL_OTGBASE_OFFSET);
 		}
 	}
 
diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index c19f7f1..9f9005b 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -41,6 +41,7 @@
 #include <linux/fsl_devices.h>
 #include <linux/dmapool.h>
 #include <linux/delay.h>
+#include <linux/of_device.h>
 
 #include <asm/byteorder.h>
 #include <asm/io.h>
@@ -2438,17 +2439,13 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 	unsigned int i;
 	u32 dccparams;
 
-	if (strcmp(pdev->name, driver_name)) {
-		VDBG("Wrong device");
-		return -ENODEV;
-	}
-
 	udc_controller = kzalloc(sizeof(struct fsl_udc), GFP_KERNEL);
 	if (udc_controller == NULL) {
 		ERR("malloc udc failed\n");
 		return -ENOMEM;
 	}
 
+	udc_controller->devtype = pdev->id_entry->driver_data;
 	pdata = pdev->dev.platform_data;
 	udc_controller->pdata = pdata;
 	spin_lock_init(&udc_controller->lock);
@@ -2505,7 +2502,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 #endif
 
 	/* Initialize USB clocks */
-	ret = fsl_udc_clk_init(pdev);
+	ret = fsl_udc_clk_init(udc_controller->devtype, pdev);
 	if (ret < 0)
 		goto err_iounmap_noclk;
 
@@ -2547,7 +2544,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 		dr_controller_setup(udc_controller);
 	}
 
-	fsl_udc_clk_finalize(pdev);
+	fsl_udc_clk_finalize(udc_controller->devtype, pdev);
 
 	/* Setup gadget structure */
 	udc_controller->gadget.ops = &fsl_gadget_ops;
@@ -2756,22 +2753,41 @@ static int fsl_udc_otg_resume(struct device *dev)
 
 	return fsl_udc_resume(NULL);
 }
-
 /*-------------------------------------------------------------------------
 	Register entry point for the peripheral controller driver
 --------------------------------------------------------------------------*/
-
+static struct platform_device_id fsl_udc_devtype[] = {
+	{
+		.name = "imx-udc-mx25",
+		.driver_data = IMX25_UDC,
+	}, {
+		.name = "imx-udc-mx27",
+		.driver_data = IMX27_UDC,
+	}, {
+		.name = "imx-udc-mx31",
+		.driver_data = IMX31_UDC,
+	}, {
+		.name = "imx-udc-mx35",
+		.driver_data = IMX35_UDC,
+	}, {
+		.name = "imx-udc-mx51",
+		.driver_data = IMX51_UDC,
+	}
+};
+MODULE_DEVICE_TABLE(platform, fsl_udc_devtype);
 static struct platform_driver udc_driver = {
-	.remove  = __exit_p(fsl_udc_remove),
+	.remove		= __exit_p(fsl_udc_remove),
+	/* Just for FSL i.mx SoC currently */
+	.id_table	= fsl_udc_devtype,
 	/* these suspend and resume are not usb suspend and resume */
-	.suspend = fsl_udc_suspend,
-	.resume  = fsl_udc_resume,
-	.driver  = {
-		.name = (char *)driver_name,
-		.owner = THIS_MODULE,
-		/* udc suspend/resume called from OTG driver */
-		.suspend = fsl_udc_otg_suspend,
-		.resume  = fsl_udc_otg_resume,
+	.suspend	= fsl_udc_suspend,
+	.resume		= fsl_udc_resume,
+	.driver		= {
+			.name = (char *)driver_name,
+			.owner = THIS_MODULE,
+			/* udc suspend/resume called from OTG driver */
+			.suspend = fsl_udc_otg_suspend,
+			.resume  = fsl_udc_otg_resume,
 	},
 };
 
diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_usb2_udc.h
index f61a967..bc1f6d0 100644
--- a/drivers/usb/gadget/fsl_usb2_udc.h
+++ b/drivers/usb/gadget/fsl_usb2_udc.h
@@ -505,6 +505,8 @@ struct fsl_udc {
 	u32 ep0_dir;		/* Endpoint zero direction: can be
 				   USB_DIR_IN or USB_DIR_OUT */
 	u8 device_address;	/* Device USB address */
+	/* devtype for kinds of SoC, only i.mx uses it now */
+	enum fsl_udc_type devtype;
 };
 
 /*-------------------------------------------------------------------------*/
@@ -591,15 +593,18 @@ static inline struct ep_queue_head *get_qh_by_ep(struct fsl_ep *ep)
 
 struct platform_device;
 #ifdef CONFIG_ARCH_MXC
-int fsl_udc_clk_init(struct platform_device *pdev);
-void fsl_udc_clk_finalize(struct platform_device *pdev);
+int fsl_udc_clk_init(enum fsl_udc_type devtype, struct platform_device *pdev);
+void fsl_udc_clk_finalize(enum fsl_udc_type devtype,
+		struct platform_device *pdev);
 void fsl_udc_clk_release(void);
 #else
-static inline int fsl_udc_clk_init(struct platform_device *pdev)
+static inline int fsl_udc_clk_init(enum fsl_udc_type devtype,
+		struct platform_device *pdev)
 {
 	return 0;
 }
-static inline void fsl_udc_clk_finalize(struct platform_device *pdev)
+static inline void fsl_udc_clk_finalize(enum fsl_udc_type devtype,
+		struct platform_device *pdev)
 {
 }
 static inline void fsl_udc_clk_release(void)
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index a82296a..7cb3fe0 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -66,6 +66,14 @@ enum fsl_usb2_phy_modes {
 	FSL_USB2_PHY_SERIAL,
 };
 
+enum fsl_udc_type {
+	IMX25_UDC,
+	IMX27_UDC,
+	IMX31_UDC,
+	IMX35_UDC,
+	IMX51_UDC,
+};
+
 struct clk;
 struct platform_device;
 
-- 
1.7.0.4
