Return-Path: <B31383@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0846FB6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Apr 2011 23:48:23 +1000 (EST)
Received: from mail54-tx2 (localhost.localdomain [127.0.0.1])	by
	mail54-tx2-R.bigfish.com (Postfix) with ESMTP id 0F8A630377	for
	<linuxppc-dev@lists.ozlabs.org>; Sat, 23 Apr 2011 13:48:06 +0000 (UTC)
Received: from TX2EHSMHS040.bigfish.com (unknown [10.9.14.248])	by
	mail54-tx2.bigfish.com (Postfix) with ESMTP id A516AB60051	for
	<linuxppc-dev@lists.ozlabs.org>; Sat, 23 Apr 2011 13:48:05 +0000 (UTC)
From: Ramneek Mehresh <ramneek.mehresh@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] [v1] powerpc/85xx: Add ULPI PHY support for P101x platforms
Date: Sat, 23 Apr 2011 19:18:00 +0530
Message-ID: <1303566480-28095-1-git-send-email-ramneek.mehresh@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Ramneek Mehresh <ramneek.mehresh@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for USB ULPI (external) PHY for P101x platforms
 - for both USB Host and Peripheral modes

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
---
Changes for v1:
	- removing the usage of variable temp

Applies on git://git.am.freescale.net/mirrors/linux-2.6.git
(branch master)

 drivers/usb/gadget/fsl_udc_core.c |    6 ++++++
 drivers/usb/gadget/fsl_usb2_udc.h |    1 +
 drivers/usb/host/ehci-fsl.c       |    5 +++++
 drivers/usb/host/ehci-fsl.h       |    1 +
 4 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index c669600..4f7578a 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -189,6 +189,12 @@ static int dr_controller_setup(struct fsl_udc *udc)
 	portctrl &= ~(PORTSCX_PHY_TYPE_SEL | PORTSCX_PORT_WIDTH);
 	switch (udc->phy_mode) {
 	case FSL_USB2_PHY_ULPI:
+#ifdef CONFIG_PPC_85xx
+		ctrl = __raw_readl(&usb_sys_regs->control);
+		ctrl &= ~USB_CTRL_UTMI_PHY_EN;
+		ctrl |= USB_CTRL_ULPI_PHY_CLK_SEL;
+		__raw_writel(ctrl, &usb_sys_regs->control);
+#endif
 		portctrl |= PORTSCX_PTS_ULPI;
 		break;
 	case FSL_USB2_PHY_UTMI_WIDE:
diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_usb2_udc.h
index d489c62..78e55ba 100644
--- a/drivers/usb/gadget/fsl_usb2_udc.h
+++ b/drivers/usb/gadget/fsl_usb2_udc.h
@@ -365,6 +365,7 @@ struct usb_sys_interface {
 #define  USB_CTRL_ULPI_INT0EN                 0x00000001
 #define USB_CTRL_UTMI_PHY_EN		      0x00000200
 #define USB_CTRL_USB_EN			      0x00000004
+#define USB_CTRL_ULPI_PHY_CLK_SEL	      0x00000400
 
 /* Endpoint Queue Head data struct
  * Rem: all the variables of qh are LittleEndian Mode
diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 55f4ab5..d698ac8 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -190,6 +190,11 @@ static void ehci_fsl_setup_phy(struct ehci_hcd *ehci,
 	portsc &= ~(PORT_PTS_MSK | PORT_PTS_PTW);
 	switch (phy_mode) {
 	case FSL_USB2_PHY_ULPI:
+#ifdef CONFIG_PPC_85xx
+		out_be32(non_ehci + FSL_SOC_USB_CTRL,
+			in_be32(non_ehci + FSL_SOC_USB_CTRL) |
+			USB_CTRL_USB_EN | ULPI_PHY_CLK_SEL);
+#endif
 		portsc |= PORT_PTS_ULPI;
 		break;
 	case FSL_USB2_PHY_SERIAL:
diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
index 06a94e9..6ed589c 100644
--- a/drivers/usb/host/ehci-fsl.h
+++ b/drivers/usb/host/ehci-fsl.h
@@ -52,4 +52,5 @@
 #define OTG_PORT		(1<<5)
 #define PLL_RESET		(1<<8)
 #define UTMI_PHY_EN		(1<<9)
+#define ULPI_PHY_CLK_SEL	(1<<10)
 #endif				/* _EHCI_FSL_H */
-- 
1.6.1
