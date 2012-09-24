Return-Path: <B36685@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ADCAB2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2012 00:37:57 +1000 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <greg@kroah.com>
Subject: [PATCH] powerpc/usb: remove checking PHY_CLK_VALID for UTMI PHY
Date: Mon, 24 Sep 2012 22:01:35 +0800
Message-ID: <1348495295-19109-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-usb@vger.kernel.org, Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PHY_CLK_VALID bit doesn't work properly with UTMI PHY.
e.g. This bit is always zero on P5040, etc.
There is no need to check this bit for UTMI PHY, just keep
checking for ULPI PHY to prevent system hanging.

This patch should be squashed into previous commit 3735ba8db8e6e
"powerpc/usb: fix bug of CPU hang when missing USB PHY clock"

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 drivers/usb/host/ehci-fsl.c |    3 +--
 include/linux/fsl_devices.h |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 11ff4b4..9bfde82 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -267,8 +267,7 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 		break;
 	}
 
-	if ((pdata->controller_ver) && ((phy_mode == FSL_USB2_PHY_ULPI) ||
-			(phy_mode == FSL_USB2_PHY_UTMI))) {
+	if (pdata->controller_ver && (phy_mode == FSL_USB2_PHY_ULPI)) {
 		/* check PHY_CLK_VALID to get phy clk valid */
 		if (!spin_event_timeout(in_be32(non_ehci + FSL_SOC_USB_CTRL) &
 				PHY_CLK_VALID, FSL_USB_PHY_CLK_TIMEOUT, 0)) {
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index ccfc4bb..700bf31 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -19,7 +19,7 @@
 
 #define FSL_UTMI_PHY_DLY	10	/*As per P1010RM, delay for UTMI
 				PHY CLK to become stable - 10ms*/
-#define FSL_USB_PHY_CLK_TIMEOUT	1000	/* uSec */
+#define FSL_USB_PHY_CLK_TIMEOUT	10000	/* uSec */
 #define FSL_USB_VER_OLD		0
 #define FSL_USB_VER_1_6		1
 #define FSL_USB_VER_2_2		2
-- 
1.6.4
