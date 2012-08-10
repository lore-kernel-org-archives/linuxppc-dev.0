Return-Path: <B36685@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2CCCF2C00F2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 21:15:44 +1000 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH 2/2] powerpc/usb: fix bug of CPU hang when missing USB PHY
 clock
Date: Fri, 10 Aug 2012 18:48:32 +0800
Message-ID: <1344595712-12804-2-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1344595712-12804-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1344595712-12804-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

when missing USB PHY clock, kernel booting up will hang during USB
initialization. We should check USBGP[PHY_CLK_VALID] bit to avoid
CPU hanging in this case.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 drivers/usb/host/ehci-fsl.c |   63 ++++++++++++++++++++++++++++++------------
 drivers/usb/host/ehci-fsl.h |    1 +
 2 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index b7451b2..aeb6d03 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -210,11 +210,11 @@ static void usb_hcd_fsl_remove(struct usb_hcd *hcd,
 	usb_put_hcd(hcd);
 }
 
-static void ehci_fsl_setup_phy(struct usb_hcd *hcd,
+static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 			       enum fsl_usb2_phy_modes phy_mode,
 			       unsigned int port_offset)
 {
-	u32 portsc, temp;
+	u32 portsc, timeout;
 	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
 	void __iomem *non_ehci = hcd->regs;
 	struct device *dev = hcd->self.controller;
@@ -232,9 +232,15 @@ static void ehci_fsl_setup_phy(struct usb_hcd *hcd,
 	case FSL_USB2_PHY_ULPI:
 		if (pdata->controller_ver) {
 			/* controller version 1.6 or above */
-			temp = in_be32(non_ehci + FSL_SOC_USB_CTRL);
-			out_be32(non_ehci + FSL_SOC_USB_CTRL, temp |
-				USB_CTRL_USB_EN | ULPI_PHY_CLK_SEL);
+			setbits32(non_ehci + FSL_SOC_USB_CTRL,
+					ULPI_PHY_CLK_SEL);
+			/*
+			 * Due to controller issue of PHY_CLK_VALID in ULPI
+			 * mode, we set USB_CTRL_USB_EN before checking
+			 * PHY_CLK_VALID, otherwise PHY_CLK_VALID doesn't work.
+			 */
+			clrsetbits_be32(non_ehci + FSL_SOC_USB_CTRL,
+					UTMI_PHY_EN, USB_CTRL_USB_EN);
 		}
 		portsc |= PORT_PTS_ULPI;
 		break;
@@ -247,9 +253,7 @@ static void ehci_fsl_setup_phy(struct usb_hcd *hcd,
 	case FSL_USB2_PHY_UTMI:
 		if (pdata->controller_ver) {
 			/* controller version 1.6 or above */
-			temp = in_be32(non_ehci + FSL_SOC_USB_CTRL);
-			out_be32(non_ehci + FSL_SOC_USB_CTRL, temp |
-				UTMI_PHY_EN | USB_CTRL_USB_EN);
+			setbits32(non_ehci + FSL_SOC_USB_CTRL, UTMI_PHY_EN);
 			mdelay(FSL_UTMI_PHY_DLY);  /* Delay for UTMI PHY CLK to
 						become stable - 10ms*/
 		}
@@ -262,23 +266,39 @@ static void ehci_fsl_setup_phy(struct usb_hcd *hcd,
 	case FSL_USB2_PHY_NONE:
 		break;
 	}
+
+	if ((pdata->controller_ver) && ((phy_mode == FSL_USB2_PHY_ULPI) ||
+			(phy_mode == FSL_USB2_PHY_UTMI))) {
+		for (timeout = 1000; timeout > 0; timeout--) {
+			/* check PHY_CLK_VALID to get phy clk valid */
+			if (in_be32(non_ehci + FSL_SOC_USB_CTRL)
+					& PHY_CLK_VALID)
+				break;
+			udelay(1);
+		}
+		if (timeout == 0) {
+			printk(KERN_WARNING "fsl-ehci: USB PHY clock invalid\n");
+			return -EINVAL;
+		}
+	}
+
 	ehci_writel(ehci, portsc, &ehci->regs->port_status[port_offset]);
+
+	if (phy_mode != FSL_USB2_PHY_ULPI)
+		setbits32(non_ehci + FSL_SOC_USB_CTRL, USB_CTRL_USB_EN);
+
+	return 0;
 }
 
-static void ehci_fsl_usb_setup(struct ehci_hcd *ehci)
+static int ehci_fsl_usb_setup(struct ehci_hcd *ehci)
 {
 	struct usb_hcd *hcd = ehci_to_hcd(ehci);
 	struct fsl_usb2_platform_data *pdata;
 	void __iomem *non_ehci = hcd->regs;
-	u32 temp;
 
 	pdata = hcd->self.controller->platform_data;
 
-	/* Enable PHY interface in the control reg. */
 	if (pdata->have_sysif_regs) {
-		temp = in_be32(non_ehci + FSL_SOC_USB_CTRL);
-		out_be32(non_ehci + FSL_SOC_USB_CTRL, temp | 0x00000004);
-
 		/*
 		* Turn on cache snooping hardware, since some PowerPC platforms
 		* wholly rely on hardware to deal with cache coherent
@@ -293,7 +313,8 @@ static void ehci_fsl_usb_setup(struct ehci_hcd *ehci)
 
 	if ((pdata->operating_mode == FSL_USB2_DR_HOST) ||
 			(pdata->operating_mode == FSL_USB2_DR_OTG))
-		ehci_fsl_setup_phy(hcd, pdata->phy_mode, 0);
+		if (ehci_fsl_setup_phy(hcd, pdata->phy_mode, 0))
+			return -EINVAL;
 
 	if (pdata->operating_mode == FSL_USB2_MPH_HOST) {
 		unsigned int chip, rev, svr;
@@ -307,9 +328,12 @@ static void ehci_fsl_usb_setup(struct ehci_hcd *ehci)
 			ehci->has_fsl_port_bug = 1;
 
 		if (pdata->port_enables & FSL_USB2_PORT0_ENABLED)
-			ehci_fsl_setup_phy(hcd, pdata->phy_mode, 0);
+			if (ehci_fsl_setup_phy(hcd, pdata->phy_mode, 0))
+				return -EINVAL;
+
 		if (pdata->port_enables & FSL_USB2_PORT1_ENABLED)
-			ehci_fsl_setup_phy(hcd, pdata->phy_mode, 1);
+			if (ehci_fsl_setup_phy(hcd, pdata->phy_mode, 1))
+				return -EINVAL;
 	}
 
 	if (pdata->have_sysif_regs) {
@@ -322,12 +346,15 @@ static void ehci_fsl_usb_setup(struct ehci_hcd *ehci)
 #endif
 		out_be32(non_ehci + FSL_SOC_USB_SICTRL, 0x00000001);
 	}
+
+	return 0;
 }
 
 /* called after powerup, by probe or system-pm "wakeup" */
 static int ehci_fsl_reinit(struct ehci_hcd *ehci)
 {
-	ehci_fsl_usb_setup(ehci);
+	if (ehci_fsl_usb_setup(ehci))
+		return -EINVAL;
 	ehci_port_power(ehci, 0);
 
 	return 0;
diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
index 8840368..dbd292e 100644
--- a/drivers/usb/host/ehci-fsl.h
+++ b/drivers/usb/host/ehci-fsl.h
@@ -61,4 +61,5 @@
 #define PLL_RESET               (1<<8)
 #define UTMI_PHY_EN             (1<<9)
 #define ULPI_PHY_CLK_SEL        (1<<10)
+#define PHY_CLK_VALID		(1<<17)
 #endif				/* _EHCI_FSL_H */
-- 
1.6.4
