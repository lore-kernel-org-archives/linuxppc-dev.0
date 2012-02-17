Return-Path: <B37022@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A596D1007D5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 17:02:15 +1100 (EST)
From: Pan Jiafei <Jiafei.Pan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] USB: ehci-fsl: Turn on cache snooping on MPC8xxx
Date: Fri, 17 Feb 2012 13:57:16 +0800
Message-ID: <1329458236-4619-1-git-send-email-Jiafei.Pan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-usb@vger.kernel.org, Pan Jiafei <Jiafei.Pan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If a MPC8xxx was being used, 'have_sysif_regs' should be set and
it should setup cache snooping for all the 4GB space on both PPC32
and PPC64.

Signed-off-by: Pan Jiafei <Jiafei.Pan@freescale.com>
---
 drivers/usb/host/ehci-fsl.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index c26a82e..8327d3e 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -252,21 +252,18 @@ static int ehci_fsl_usb_setup(struct ehci_hcd *ehci)
 	if (pdata->have_sysif_regs) {
 		temp = in_be32(non_ehci + FSL_SOC_USB_CTRL);
 		out_be32(non_ehci + FSL_SOC_USB_CTRL, temp | 0x00000004);
-		out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0000001b);
-	}
 
-#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
-	/*
-	 * Turn on cache snooping hardware, since some PowerPC platforms
-	 * wholly rely on hardware to deal with cache coherent
-	 */
+		/*
+		* Turn on cache snooping hardware, since some PowerPC platforms
+		* wholly rely on hardware to deal with cache coherent
+		*/
 
-	/* Setup Snooping for all the 4GB space */
-	/* SNOOP1 starts from 0x0, size 2G */
-	out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0 | SNOOP_SIZE_2GB);
-	/* SNOOP2 starts from 0x80000000, size 2G */
-	out_be32(non_ehci + FSL_SOC_USB_SNOOP2, 0x80000000 | SNOOP_SIZE_2GB);
-#endif
+		/* Setup Snooping for all the 4GB space */
+		/* SNOOP1 starts from 0x0, size 2G */
+		out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0 | SNOOP_SIZE_2GB);
+		/* SNOOP2 starts from 0x80000000, size 2G */
+		out_be32(non_ehci + FSL_SOC_USB_SNOOP2, 0x80000000 | SNOOP_SIZE_2GB);
+	}
 
 	if ((pdata->operating_mode == FSL_USB2_DR_HOST) ||
 			(pdata->operating_mode == FSL_USB2_DR_OTG))
-- 
1.7.5.1
