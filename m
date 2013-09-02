Return-Path: <B36685@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 645162C0095
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Sep 2013 16:29:21 +1000 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH] fsl/ehci: fix failure of checking PHY_CLK_VALID during
 reinitialization
Date: Mon, 2 Sep 2013 13:25:52 +0800
Message-ID: <1378099552-2713-1-git-send-email-Shengzhou.Liu@freescale.com>
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

In case of usb phy reinitialization:
e.g. insmod usb-module(usb works well) -> rmmod usb-module -> insmod usb-module
It found the PHY_CLK_VALID bit didn't work if it's not with the power-on reset.
So we just check PHY_CLK_VALID bit during the stage with POR, this can be met
by the tricky of checking FSL_SOC_USB_PRICTRL register.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
based on master branch of upstream, from sdk1.4

 drivers/usb/host/ehci-fsl.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index bd831ec..3156e12 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -270,8 +270,9 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 	if (pdata->have_sysif_regs && pdata->controller_ver &&
 	    (phy_mode == FSL_USB2_PHY_ULPI)) {
 		/* check PHY_CLK_VALID to get phy clk valid */
-		if (!spin_event_timeout(in_be32(non_ehci + FSL_SOC_USB_CTRL) &
-				PHY_CLK_VALID, FSL_USB_PHY_CLK_TIMEOUT, 0)) {
+		if (!(spin_event_timeout(in_be32(non_ehci + FSL_SOC_USB_CTRL) &
+				PHY_CLK_VALID, FSL_USB_PHY_CLK_TIMEOUT, 0) ||
+				in_be32(non_ehci + FSL_SOC_USB_PRICTRL))) {
 			printk(KERN_WARNING "fsl-ehci: USB PHY clock invalid\n");
 			return -EINVAL;
 		}
-- 
1.7.0.4
