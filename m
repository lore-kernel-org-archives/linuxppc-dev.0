Return-Path: <B29397@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe006.messaging.microsoft.com [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 65D0E2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2013 13:16:16 +1100 (EST)
From: Peter Chen <peter.chen@freescale.com>
To: <shawn.guo@linaro.org>, <balbi@ti.com>, <kernel@pengutronix.de>,
 <gregkh@linuxfoundation.org>, <r58472@freescale.com>
Subject: [PATCH v7 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
Date: Fri, 18 Jan 2013 10:15:47 +0800
Message-ID: <1358475349-27710-2-git-send-email-peter.chen@freescale.com>
In-Reply-To: <1358475349-27710-1-git-send-email-peter.chen@freescale.com>
References: <1358475349-27710-1-git-send-email-peter.chen@freescale.com>
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
differentiate SoCs. Besides, one cpu_is_mx35 is useless as it has
already used pdata to differentiate runtime

Meanwhile we update the platform code accordingly.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/mach-imx/devices/devices-common.h        |    1 +
 arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c |   15 ++++----
 drivers/usb/gadget/fsl_mxc_udc.c                  |   30 ++++++++--------
 drivers/usb/gadget/fsl_udc_core.c                 |   38 ++++++++++++---------
 4 files changed, 46 insertions(+), 38 deletions(-)

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
index 37e4439..3c06bd9 100644
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
+	imx_fsl_usb2_udc_data_entry_single(MX25, "imx-udc-mx27");
 #endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX27
 const struct imx_fsl_usb2_udc_data imx27_fsl_usb2_udc_data __initconst =
-	imx_fsl_usb2_udc_data_entry_single(MX27);
+	imx_fsl_usb2_udc_data_entry_single(MX27, "imx-udc-mx27");
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
 #ifdef CONFIG_SOC_IMX31
 const struct imx_fsl_usb2_udc_data imx31_fsl_usb2_udc_data __initconst =
-	imx_fsl_usb2_udc_data_entry_single(MX31);
+	imx_fsl_usb2_udc_data_entry_single(MX31, "imx-udc-mx27");
 #endif /* ifdef CONFIG_SOC_IMX31 */
 
 #ifdef CONFIG_SOC_IMX35
 const struct imx_fsl_usb2_udc_data imx35_fsl_usb2_udc_data __initconst =
-	imx_fsl_usb2_udc_data_entry_single(MX35);
+	imx_fsl_usb2_udc_data_entry_single(MX35, "imx-udc-mx27");
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
index 1b0f086..aa81ac5 100644
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
@@ -58,8 +56,12 @@ int fsl_udc_clk_init(struct platform_device *pdev)
 	clk_prepare_enable(mxc_ahb_clk);
 	clk_prepare_enable(mxc_per_clk);
 
-	/* make sure USB_CLK is running at 60 MHz +/- 1000 Hz */
-	if (!cpu_is_mx51()) {
+	/*
+	 * Make sure USB_CLK is running at 60 MHz +/- 1000 Hz
+	 * Only two types of udc currently, imx-udc-mx27 and
+	 * imx-udc-mx51 (mx51 & mx53)
+	 */
+	if (strcmp(pdev->id_entry->name, "imx-udc-mx27") == 0) {
 		freq = clk_get_rate(mxc_per_clk);
 		if (pdata->phy_mode != FSL_USB2_PHY_ULPI &&
 		    (freq < 59999000 || freq > 60001000)) {
@@ -82,17 +84,15 @@ eclkrate:
 void fsl_udc_clk_finalize(struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
-	if (cpu_is_mx35()) {
-		unsigned int v;
-
-		/* workaround ENGcm09152 for i.MX35 */
-		if (pdata->workaround & FLS_USB2_WORKAROUND_ENGCM09152) {
-			v = readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
-					USBPHYCTRL_OTGBASE_OFFSET));
-			writel(v | USBPHYCTRL_EVDO,
-				MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
-					USBPHYCTRL_OTGBASE_OFFSET));
-		}
+	unsigned int v;
+
+	/* workaround ENGcm09152 for i.MX35 */
+	if (pdata->workaround & FLS_USB2_WORKAROUND_ENGCM09152) {
+		v = readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
+				USBPHYCTRL_OTGBASE_OFFSET));
+		writel(v | USBPHYCTRL_EVDO,
+			MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
+				USBPHYCTRL_OTGBASE_OFFSET));
 	}
 
 	/* ULPI transceivers don't need usbpll */
diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index c19f7f1..5fc1d72 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -41,6 +41,7 @@
 #include <linux/fsl_devices.h>
 #include <linux/dmapool.h>
 #include <linux/delay.h>
+#include <linux/of_device.h>
 
 #include <asm/byteorder.h>
 #include <asm/io.h>
@@ -2438,11 +2439,6 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
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
@@ -2756,22 +2752,32 @@ static int fsl_udc_otg_resume(struct device *dev)
 
 	return fsl_udc_resume(NULL);
 }
-
 /*-------------------------------------------------------------------------
 	Register entry point for the peripheral controller driver
 --------------------------------------------------------------------------*/
-
+static const struct platform_device_id fsl_udc_devtype[] = {
+	{
+		.name = "imx-udc-mx27",
+	}, {
+		.name = "imx-udc-mx51",
+	}, {
+		/* sentinel */
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
 
-- 
1.7.0.4
