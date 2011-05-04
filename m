Return-Path: <B31383@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DD4AC1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 May 2011 00:12:11 +1000 (EST)
From: Ramneek Mehresh <ramneek.mehresh@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linuxppc-release@linux.freescale.net>
Subject: [PATCH] fsl/usb: Unused endpoint failure for USB gadget
Date: Wed, 4 May 2011 19:41:55 +0530
Message-ID: <1304518315-29351-1-git-send-email-ramneek.mehresh@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Suchit Lepcha <Suchit.Lepcha@freescale.com>,
	dbrownell@users.sourceforge.net, gregkh@suse.de,
	Ramneek Mehresh <ramneek.mehresh@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Though USB controller works without this most of the time, an issue was faced
where USB was configured as printer device and it was dropping first
packet(64 bytes) in full speed mode due to DATA PID mismatch.
The problem gets resolved once unused endpoints are configured as bulk.
As per P1020 RM (Table17-31, bits 19-18, bits 3-2) "When only one endpoint
(RX or TX, but not both) of an endpoint pair is used, the unused endpoint
should be configured as a bulk type endpoint." So according to the RM,
this patch is initializing TX and RX endpoints as bulk type

Signed-off-by: Suchit Lepcha <Suchit.Lepcha@freescale.com>
Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
---
Applies on git://git.am.freescale.net/mirrors/linux-2.6.git
(branch master)

 drivers/usb/gadget/fsl_udc_core.c |   27 +++++++++++++++++++++------
 1 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 07499c1..bac8ca9 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -1,5 +1,6 @@
 /*
- * Copyright (C) 2004-2007 Freescale Semicondutor, Inc. All rights reserved.
+ * Copyright (C) 2004-2007,2011 Freescale Semiconductor, Inc.
+ * All rights reserved.
  *
  * Author: Li Yang <leoli@freescale.com>
  *         Jiang Bo <tanya.jiang@freescale.com>
@@ -177,7 +178,8 @@ static void nuke(struct fsl_ep *ep, int status)
 
 static int dr_controller_setup(struct fsl_udc *udc)
 {
-	unsigned int tmp, portctrl;
+	unsigned int tmp, portctrl, ep_num;
+	unsigned int max_no_of_ep;
 #ifndef CONFIG_ARCH_MXC
 	unsigned int ctrl;
 #endif
@@ -242,6 +244,14 @@ static int dr_controller_setup(struct fsl_udc *udc)
 		udc->ep_qh, (int)tmp,
 		fsl_readl(&dr_regs->endpointlistaddr));
 
+	max_no_of_ep = (0x0000001F & fsl_readl(&dr_regs->dccparams));
+	for (ep_num = 1; ep_num < max_no_of_ep; ep_num++) {
+		tmp = fsl_readl(&dr_regs->endptctrl[ep_num]);
+		tmp &= ~(EPCTRL_TX_TYPE | EPCTRL_RX_TYPE);
+		tmp |= (EPCTRL_EP_TYPE_BULK << EPCTRL_TX_EP_TYPE_SHIFT)
+		| (EPCTRL_EP_TYPE_BULK << EPCTRL_RX_EP_TYPE_SHIFT);
+		fsl_writel(tmp, &dr_regs->endptctrl[ep_num]);
+	}
 	/* Config control enable i/o output, cpu endian register */
 #ifndef CONFIG_ARCH_MXC
 	ctrl = __raw_readl(&usb_sys_regs->control);
@@ -318,12 +328,14 @@ static void dr_ep_setup(unsigned char ep_num, unsigned char dir,
 		if (ep_num)
 			tmp_epctrl |= EPCTRL_TX_DATA_TOGGLE_RST;
 		tmp_epctrl |= EPCTRL_TX_ENABLE;
+		tmp_epctrl &= ~EPCTRL_TX_TYPE;
 		tmp_epctrl |= ((unsigned int)(ep_type)
 				<< EPCTRL_TX_EP_TYPE_SHIFT);
 	} else {
 		if (ep_num)
 			tmp_epctrl |= EPCTRL_RX_DATA_TOGGLE_RST;
 		tmp_epctrl |= EPCTRL_RX_ENABLE;
+		tmp_epctrl &= ~EPCTRL_RX_TYPE;
 		tmp_epctrl |= ((unsigned int)(ep_type)
 				<< EPCTRL_RX_EP_TYPE_SHIFT);
 	}
@@ -546,10 +558,13 @@ static int fsl_ep_disable(struct usb_ep *_ep)
 	/* disable ep on controller */
 	ep_num = ep_index(ep);
 	epctrl = fsl_readl(&dr_regs->endptctrl[ep_num]);
-	if (ep_is_in(ep))
-		epctrl &= ~EPCTRL_TX_ENABLE;
-	else
-		epctrl &= ~EPCTRL_RX_ENABLE;
+	if (ep_is_in(ep)) {
+		epctrl &= ~(EPCTRL_TX_ENABLE | EPCTRL_TX_TYPE);
+		epctrl |= EPCTRL_EP_TYPE_BULK << EPCTRL_TX_EP_TYPE_SHIFT;
+	} else {
+		epctrl &= ~(EPCTRL_RX_ENABLE | EPCTRL_TX_TYPE);
+		epctrl |= EPCTRL_EP_TYPE_BULK << EPCTRL_RX_EP_TYPE_SHIFT;
+	}
 	fsl_writel(epctrl, &dr_regs->endptctrl[ep_num]);
 
 	udc = (struct fsl_udc *)ep->udc;
-- 
1.6.1
