Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ABC822C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 16:47:33 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <galak@kernel.crashing.org>
Subject: [RFC][PATCH 1/1] USB/EHCI: work for different PHY_CLK_VALID detecting
 order
Date: Wed, 24 Apr 2013 14:47:35 +0800
Message-ID: <1366786055-14671-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Due to different controller issue of PHY_CLK_VALID in ULPI mode,
in some cases, after set PHY_CLK_SEL, we should set
USB_CTRL_USB_EN before checking PHY_CLK_VALID, otherwise
PHY_CLK_VALID doesn't work.

But in other cases USB_CTRL_USB_EN is already set previously and
PHY_CLK_VALID is not valid once USB_CTRL_USB_EN is set. But
since PHY_CLK_VALID is w1c, we can force clear USB_CTRL_USB_EN
firstly after set PHY_CLK_SEL, then PHY_CLK_VALID status can
be kept even we re-set USB_CTRL_USB_EN.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 drivers/usb/host/ehci-fsl.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index d81d2fc..57f2aa0 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -234,11 +234,20 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 			/* controller version 1.6 or above */
 			setbits32(non_ehci + FSL_SOC_USB_CTRL,
 					ULPI_PHY_CLK_SEL);
+
 			/*
-			 * Due to controller issue of PHY_CLK_VALID in ULPI
-			 * mode, we set USB_CTRL_USB_EN before checking
-			 * PHY_CLK_VALID, otherwise PHY_CLK_VALID doesn't work.
+			 * Due to different controller issue of PHY_CLK_VALID
+			 * in ULPI mode, in some cases we should set
+			 * USB_CTRL_USB_EN before checking PHY_CLK_VALID,
+			 * otherwise PHY_CLK_VALID doesn't work.
+			 *
+			 * But in other cases USB_CTRL_USB_EN is already set
+			 * and PHY_CLK_VALID is not valid once USB_CTRL_USB_EN
+			 * is set. But since PHY_CLK_VALID is w1c, we can force
+			 * clear USB_CTRL_USB_EN firstly then PHY_CLK_VALID
+			 * status can be kept even we re-set USB_CTRL_USB_EN.
 			 */
+			clrbits32(non_ehci + FSL_SOC_USB_CTRL, USB_CTRL_USB_EN);
 			clrsetbits_be32(non_ehci + FSL_SOC_USB_CTRL,
 					UTMI_PHY_EN, USB_CTRL_USB_EN);
 		}
-- 
1.7.9.5
