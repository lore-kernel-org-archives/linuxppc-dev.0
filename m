Return-Path: <B36685@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe005.messaging.microsoft.com
 [65.55.88.15]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 41A87B6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2012 21:06:29 +1100 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linux-usb@vger.kernel.org>
Subject: [PATCH] powerpc/usb: fix bug of kernel hang when initializing usb
Date: Thu, 16 Feb 2012 18:02:20 +0800
Message-ID: <1329386540-12341-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If USB UTMI PHY is not enable, writing to portsc register will lead to
kernel hang during boot up.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
Apply for master branch of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
Tested on P5020DS, the issue was reported by Benjamin Herrenschmidt. 

 drivers/usb/host/ehci-fsl.c |    4 ++++
 drivers/usb/host/ehci-fsl.h |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index c26a82e..0090ed2 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -216,6 +216,8 @@ static void ehci_fsl_setup_phy(struct ehci_hcd *ehci,
 			       unsigned int port_offset)
 {
 	u32 portsc;
+	struct usb_hcd *hcd = ehci_to_hcd(ehci);
+	void __iomem *non_ehci = hcd->regs;
 
 	portsc = ehci_readl(ehci, &ehci->regs->port_status[port_offset]);
 	portsc &= ~(PORT_PTS_MSK | PORT_PTS_PTW);
@@ -231,6 +233,8 @@ static void ehci_fsl_setup_phy(struct ehci_hcd *ehci,
 		portsc |= PORT_PTS_PTW;
 		/* fall through */
 	case FSL_USB2_PHY_UTMI:
+		/* enable UTMI PHY */
+		setbits32(non_ehci + FSL_SOC_USB_CTRL, CTRL_UTMI_PHY_EN);
 		portsc |= PORT_PTS_UTMI;
 		break;
 	case FSL_USB2_PHY_NONE:
diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
index bdf43e2..0e400c2 100644
--- a/drivers/usb/host/ehci-fsl.h
+++ b/drivers/usb/host/ehci-fsl.h
@@ -45,6 +45,7 @@
 #define FSL_SOC_USB_PRICTRL	0x40c	/* NOTE: big-endian */
 #define FSL_SOC_USB_SICTRL	0x410	/* NOTE: big-endian */
 #define FSL_SOC_USB_CTRL	0x500	/* NOTE: big-endian */
+#define CTRL_UTMI_PHY_EN	(1<<9)
 #define CTRL_PHY_CLK_VALID	(1 << 17)
 #define SNOOP_SIZE_2GB		0x1e
 #endif				/* _EHCI_FSL_H */
-- 
1.6.4
