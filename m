Return-Path: <B29397@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2E1532C06F6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2013 21:03:46 +1100 (EST)
From: Peter Chen <peter.chen@freescale.com>
To: <shawn.guo@linaro.org>, <balbi@ti.com>, <kernel@pengutronix.de>,
 <gregkh@linuxfoundation.org>, <r58472@freescale.com>
Subject: [PATCH v6 3/3] ARM: i.MX clock: Change the connection-id for
 fsl-usb2-udc
Date: Thu, 17 Jan 2013 18:03:17 +0800
Message-ID: <1358416997-29099-4-git-send-email-peter.chen@freescale.com>
In-Reply-To: <1358416997-29099-1-git-send-email-peter.chen@freescale.com>
References: <1358416997-29099-1-git-send-email-peter.chen@freescale.com>
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

As we use platform_device_id for fsl-usb2-udc driver, it needs to
change clk connection-id, or the related devm_clk_get will be failed.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/mach-imx/clk-imx25.c       |    6 +++---
 arch/arm/mach-imx/clk-imx27.c       |    6 +++---
 arch/arm/mach-imx/clk-imx31.c       |    6 +++---
 arch/arm/mach-imx/clk-imx35.c       |    6 +++---
 arch/arm/mach-imx/clk-imx51-imx53.c |    6 +++---
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index b197aa7..2c570cd 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -254,9 +254,9 @@ int __init mx25_clocks_init(void)
 	clk_register_clkdev(clk[ipg], "ipg", "mxc-ehci.2");
 	clk_register_clkdev(clk[usbotg_ahb], "ahb", "mxc-ehci.2");
 	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.2");
-	clk_register_clkdev(clk[ipg], "ipg", "fsl-usb2-udc");
-	clk_register_clkdev(clk[usbotg_ahb], "ahb", "fsl-usb2-udc");
-	clk_register_clkdev(clk[usb_div], "per", "fsl-usb2-udc");
+	clk_register_clkdev(clk[ipg], "ipg", "imx-udc-mx27");
+	clk_register_clkdev(clk[usbotg_ahb], "ahb", "imx-udc-mx27");
+	clk_register_clkdev(clk[usb_div], "per", "imx-udc-mx27");
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
index 8be64e0..16ccbd4 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -139,9 +139,9 @@ int __init mx31_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[usb_div_post], "per", "mxc-ehci.2");
 	clk_register_clkdev(clk[usb_gate], "ahb", "mxc-ehci.2");
 	clk_register_clkdev(clk[ipg], "ipg", "mxc-ehci.2");
-	clk_register_clkdev(clk[usb_div_post], "per", "fsl-usb2-udc");
-	clk_register_clkdev(clk[usb_gate], "ahb", "fsl-usb2-udc");
-	clk_register_clkdev(clk[ipg], "ipg", "fsl-usb2-udc");
+	clk_register_clkdev(clk[usb_div_post], "per", "imx-udc-mx27");
+	clk_register_clkdev(clk[usb_gate], "ahb", "imx-udc-mx27");
+	clk_register_clkdev(clk[ipg], "ipg", "imx-udc-mx27");
 	clk_register_clkdev(clk[csi_gate], NULL, "mx3-camera.0");
 	/* i.mx31 has the i.mx21 type uart */
 	clk_register_clkdev(clk[uart1_gate], "per", "imx21-uart.0");
diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index 66f3d65..f0727e8 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -251,9 +251,9 @@ int __init mx35_clocks_init()
 	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.2");
 	clk_register_clkdev(clk[ipg], "ipg", "mxc-ehci.2");
 	clk_register_clkdev(clk[usbotg_gate], "ahb", "mxc-ehci.2");
-	clk_register_clkdev(clk[usb_div], "per", "fsl-usb2-udc");
-	clk_register_clkdev(clk[ipg], "ipg", "fsl-usb2-udc");
-	clk_register_clkdev(clk[usbotg_gate], "ahb", "fsl-usb2-udc");
+	clk_register_clkdev(clk[usb_div], "per", "imx-udc-mx27");
+	clk_register_clkdev(clk[ipg], "ipg", "imx-udc-mx27");
+	clk_register_clkdev(clk[usbotg_gate], "ahb", "imx-udc-mx27");
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
-- 
1.7.0.4
