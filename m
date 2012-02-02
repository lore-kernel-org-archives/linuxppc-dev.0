Return-Path: <B36685@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E645A104785
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2012 14:24:18 +1100 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linux-usb@vger.kernel.org>
Subject: [PATCH v2] powerpc/usb: fix issue of CPU halt when missing USB PHY
 clock
Date: Thu, 2 Feb 2012 11:23:14 +0800
Message-ID: <1328152994-2879-1-git-send-email-Shengzhou.Liu@freescale.com>
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

when missing USB PHY clock, kernel booting up will halt during USB
initialization. We should check USBGP[PHY_CLK_VALID] bit to avoid
CPU hang in this case.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
v2: changes: return -ENODEV instead of -1

 drivers/usb/host/ehci-fsl.c |   11 +++++++++--
 drivers/usb/host/ehci-fsl.h |    1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index b556a72..c26a82e 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -239,7 +239,7 @@ static void ehci_fsl_setup_phy(struct ehci_hcd *ehci,
 	ehci_writel(ehci, portsc, &ehci->regs->port_status[port_offset]);
 }
 
-static void ehci_fsl_usb_setup(struct ehci_hcd *ehci)
+static int ehci_fsl_usb_setup(struct ehci_hcd *ehci)
 {
 	struct usb_hcd *hcd = ehci_to_hcd(ehci);
 	struct fsl_usb2_platform_data *pdata;
@@ -299,12 +299,19 @@ static void ehci_fsl_usb_setup(struct ehci_hcd *ehci)
 #endif
 		out_be32(non_ehci + FSL_SOC_USB_SICTRL, 0x00000001);
 	}
+
+	if (!(in_be32(non_ehci + FSL_SOC_USB_CTRL) & CTRL_PHY_CLK_VALID)) {
+		printk(KERN_WARNING "fsl-ehci: USB PHY clock invalid\n");
+		return -ENODEV;
+	}
+	return 0;
 }
 
 /* called after powerup, by probe or system-pm "wakeup" */
 static int ehci_fsl_reinit(struct ehci_hcd *ehci)
 {
-	ehci_fsl_usb_setup(ehci);
+	if (ehci_fsl_usb_setup(ehci))
+		return -ENODEV;
 	ehci_port_power(ehci, 0);
 
 	return 0;
diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
index 4918062..dd3dc47 100644
--- a/drivers/usb/host/ehci-fsl.h
+++ b/drivers/usb/host/ehci-fsl.h
@@ -45,5 +45,6 @@
 #define FSL_SOC_USB_PRICTRL	0x40c	/* NOTE: big-endian */
 #define FSL_SOC_USB_SICTRL	0x410	/* NOTE: big-endian */
 #define FSL_SOC_USB_CTRL	0x500	/* NOTE: big-endian */
+#define CTRL_PHY_CLK_VALID      (1 << 17)
 #define SNOOP_SIZE_2GB		0x1e
 #endif				/* _EHCI_FSL_H */
-- 
1.6.4
