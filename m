Return-Path: <B29397@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8BD342C0267
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2013 21:02:20 +1100 (EST)
From: Peter Chen <peter.chen@freescale.com>
To: <shawn.guo@linaro.org>, <balbi@ti.com>, <kernel@pengutronix.de>,
 <gregkh@linuxfoundation.org>, <r58472@freescale.com>
Subject: [PATCH v6 2/3] usb: fsl_mxc_udc: replace MX35_IO_ADDRESS to ioremap
Date: Thu, 17 Jan 2013 18:01:13 +0800
Message-ID: <1358416874-27011-3-git-send-email-peter.chen@freescale.com>
In-Reply-To: <1358416874-27011-1-git-send-email-peter.chen@freescale.com>
References: <1358416874-27011-1-git-send-email-peter.chen@freescale.com>
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

As mach/hardware.h is deleted, we can't visit platform code at driver.
It has no phy driver to combine with this controller, so it has to use
ioremap to map phy address as a workaround.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/gadget/fsl_mxc_udc.c  |   30 +++++++++++++++++++++++-------
 drivers/usb/gadget/fsl_udc_core.c |    4 +++-
 drivers/usb/gadget/fsl_usb2_udc.h |    5 +++--
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
index de851e5..d3bd7b0 100644
--- a/drivers/usb/gadget/fsl_mxc_udc.c
+++ b/drivers/usb/gadget/fsl_mxc_udc.c
@@ -23,7 +23,8 @@ static struct clk *mxc_per_clk;
 static struct clk *mxc_ipg_clk;
 
 /* workaround ENGcm09152 for i.MX35 */
-#define USBPHYCTRL_OTGBASE_OFFSET	0x608
+#define MX35_USBPHYCTRL_OFFSET		0x600
+#define USBPHYCTRL_OTGBASE_OFFSET	0x8
 #define USBPHYCTRL_EVDO			(1 << 23)
 
 int fsl_udc_clk_init(struct platform_device *pdev)
@@ -77,25 +78,40 @@ eclkrate:
 	return ret;
 }
 
-void fsl_udc_clk_finalize(struct platform_device *pdev)
+int fsl_udc_clk_finalize(struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
-	unsigned int v;
+	int ret = 0;
 
 	/* workaround ENGcm09152 for i.MX35 */
 	if (pdata->workaround & FLS_USB2_WORKAROUND_ENGCM09152) {
-		v = readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
-				USBPHYCTRL_OTGBASE_OFFSET));
+		unsigned int v;
+		struct resource *res = platform_get_resource
+			(pdev, IORESOURCE_MEM, 0);
+		void __iomem *phy_regs = ioremap(res->start +
+						MX35_USBPHYCTRL_OFFSET, 512);
+		if (!phy_regs) {
+			dev_err(&pdev->dev, "ioremap for phy address fails\n");
+			ret = -EINVAL;
+			goto ioremap_err;
+		}
+
+		v = readl(phy_regs + USBPHYCTRL_OTGBASE_OFFSET);
 		writel(v | USBPHYCTRL_EVDO,
-			MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
-				USBPHYCTRL_OTGBASE_OFFSET));
+			phy_regs + USBPHYCTRL_OTGBASE_OFFSET);
+
+		iounmap(phy_regs);
 	}
 
+
+ioremap_err:
 	/* ULPI transceivers don't need usbpll */
 	if (pdata->phy_mode == FSL_USB2_PHY_ULPI) {
 		clk_disable_unprepare(mxc_per_clk);
 		mxc_per_clk = NULL;
 	}
+
+	return ret;
 }
 
 void fsl_udc_clk_release(void)
diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 5fc1d72..667275c 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -2543,7 +2543,9 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 		dr_controller_setup(udc_controller);
 	}
 
-	fsl_udc_clk_finalize(pdev);
+	ret = fsl_udc_clk_finalize(pdev);
+	if (ret)
+		goto err_free_irq;
 
 	/* Setup gadget structure */
 	udc_controller->gadget.ops = &fsl_gadget_ops;
diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_usb2_udc.h
index f61a967..c6703bb 100644
--- a/drivers/usb/gadget/fsl_usb2_udc.h
+++ b/drivers/usb/gadget/fsl_usb2_udc.h
@@ -592,15 +592,16 @@ static inline struct ep_queue_head *get_qh_by_ep(struct fsl_ep *ep)
 struct platform_device;
 #ifdef CONFIG_ARCH_MXC
 int fsl_udc_clk_init(struct platform_device *pdev);
-void fsl_udc_clk_finalize(struct platform_device *pdev);
+int fsl_udc_clk_finalize(struct platform_device *pdev);
 void fsl_udc_clk_release(void);
 #else
 static inline int fsl_udc_clk_init(struct platform_device *pdev)
 {
 	return 0;
 }
-static inline void fsl_udc_clk_finalize(struct platform_device *pdev)
+static inline int fsl_udc_clk_finalize(struct platform_device *pdev)
 {
+	return 0;
 }
 static inline void fsl_udc_clk_release(void)
 {
-- 
1.7.0.4
