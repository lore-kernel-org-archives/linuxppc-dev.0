Return-Path: <B29397@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 16B8A2C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 01:16:28 +1100 (EST)
From: Peter Chen <peter.chen@freescale.com>
To: <shawn.guo@linaro.org>, <balbi@ti.com>, <kernel@pengutronix.de>,
 <gregkh@linuxfoundation.org>, <r58472@freescale.com>
Subject: [PATCH v4 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
Date: Mon, 14 Jan 2013 22:16:07 +0800
Message-ID: <1358172969-14898-2-git-send-email-peter.chen@freescale.com>
In-Reply-To: <1358172969-14898-1-git-send-email-peter.chen@freescale.com>
References: <1358172969-14898-1-git-send-email-peter.chen@freescale.com>
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

As mach/hardware.h is deleted, we need to use platform_device_id to
differentiate SoCs.

Besides we update the platform code accordingly.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/mach-imx/devices/devices-common.h        |    1 +
 arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c |   15 +++---
 drivers/usb/gadget/fsl_mxc_udc.c                  |   11 ++--
 drivers/usb/gadget/fsl_udc_core.c                 |   52 +++++++++++++-------
 drivers/usb/gadget/fsl_usb2_udc.h                 |   13 ++++--
 include/linux/fsl_devices.h                       |    8 +++
 6 files changed, 65 insertions(+), 35 deletions(-)

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
index 1b0f086..6df45f7 100644
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
@@ -79,10 +77,11 @@ eclkrate:
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
diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index c19f7f1..c32119b 100644
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
+static const struct platform_device_id fsl_udc_devtype[] = {
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
