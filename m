Return-Path: <B31383@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.186])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5B804B7126
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Apr 2011 22:48:34 +1000 (EST)
Received: from mail114-ch1 (localhost.localdomain [127.0.0.1])	by
	mail114-ch1-R.bigfish.com (Postfix) with ESMTP id 10E47FB007A	for
	<linuxppc-dev@lists.ozlabs.org>; Sat, 23 Apr 2011 12:33:20 +0000 (UTC)
Received: from CH1EHSMHS034.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.242])	by mail114-ch1.bigfish.com (Postfix) with ESMTP id
	B42ED1B7804F	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Apr 2011 12:33:19 +0000 (UTC)
From: Ramneek Mehresh <ramneek.mehresh@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: Add UTMI PHY support for 85xx platforms
Date: Sat, 23 Apr 2011 18:03:14 +0530
Message-ID: <1303561994-22122-1-git-send-email-ramneek.mehresh@freescale.com>
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

Add UTMI internal PHY support for P5020/P3041/P101x platforms.
 - for both USB Host and Peripheral modes

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
Applies on git://git.am.freescale.net/mirrors/linux-2.6.git
(branch master)

 drivers/usb/gadget/fsl_udc_core.c |    7 ++++++-
 drivers/usb/gadget/fsl_usb2_udc.h |   19 +++++++++++++++++++
 drivers/usb/host/ehci-fsl.c       |   10 ++++++++--
 drivers/usb/host/ehci-fsl.h       |   12 +++++++++++-
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 07499c1..c669600 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2004-2007 Freescale Semicondutor, Inc. All rights reserved.
+ * Copyright (C) 2004-2011 Freescale Semiconductor, Inc.
  *
  * Author: Li Yang <leoli@freescale.com>
  *         Jiang Bo <tanya.jiang@freescale.com>
@@ -195,6 +195,11 @@ static int dr_controller_setup(struct fsl_udc *udc)
 		portctrl |= PORTSCX_PTW_16BIT;
 		/* fall through */
 	case FSL_USB2_PHY_UTMI:
+#ifdef CONFIG_PPC_85xx
+		setbits32(&usb_sys_regs->control, USB_CTRL_UTMI_PHY_EN |
+				USB_CTRL_USB_EN);
+		udelay(10*1000);  /* delay for PHY clk to ready */
+#endif
 		portctrl |= PORTSCX_PTS_UTMI;
 		break;
 	case FSL_USB2_PHY_SERIAL:
diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_usb2_udc.h
index e88cce5..d489c62 100644
--- a/drivers/usb/gadget/fsl_usb2_udc.h
+++ b/drivers/usb/gadget/fsl_usb2_udc.h
@@ -1,3 +1,20 @@
+/* Copyright (C) 2011 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
 /*
  * Freescale USB device/endpoint management registers
  */
@@ -346,6 +363,8 @@ struct usb_sys_interface {
 /* control Register Bit Masks */
 #define  USB_CTRL_IOENB                       0x00000004
 #define  USB_CTRL_ULPI_INT0EN                 0x00000001
+#define USB_CTRL_UTMI_PHY_EN		      0x00000200
+#define USB_CTRL_USB_EN			      0x00000004
 
 /* Endpoint Queue Head data struct
  * Rem: all the variables of qh are LittleEndian Mode
diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 5c761df..55f4ab5 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -1,6 +1,6 @@
 /*
  * Copyright 2005-2009 MontaVista Software, Inc.
- * Copyright 2008      Freescale Semiconductor, Inc.
+ * Copyright 2011      Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -183,10 +183,11 @@ static void ehci_fsl_setup_phy(struct ehci_hcd *ehci,
 			       unsigned int port_offset)
 {
 	u32 portsc;
+	struct usb_hcd *hcd = ehci_to_hcd(ehci);
+	void __iomem *non_ehci = hcd->regs;
 
 	portsc = ehci_readl(ehci, &ehci->regs->port_status[port_offset]);
 	portsc &= ~(PORT_PTS_MSK | PORT_PTS_PTW);
-
 	switch (phy_mode) {
 	case FSL_USB2_PHY_ULPI:
 		portsc |= PORT_PTS_ULPI;
@@ -198,6 +199,11 @@ static void ehci_fsl_setup_phy(struct ehci_hcd *ehci,
 		portsc |= PORT_PTS_PTW;
 		/* fall through */
 	case FSL_USB2_PHY_UTMI:
+#ifdef CONFIG_PPC_85xx
+		setbits32(non_ehci + FSL_SOC_USB_CTRL, UTMI_PHY_EN |
+				USB_CTRL_USB_EN);
+		udelay(10*1000);  /* delay for PHY clk to ready */
+#endif
 		portsc |= PORT_PTS_UTMI;
 		break;
 	case FSL_USB2_PHY_NONE:
diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
index 3fabed3..06a94e9 100644
--- a/drivers/usb/host/ehci-fsl.h
+++ b/drivers/usb/host/ehci-fsl.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2005-2010 Freescale Semiconductor, Inc.
+/* Copyright (C) 2005-2011 Freescale Semiconductor, Inc.
  * Copyright (c) 2005 MontaVista Software
  *
  * This program is free software; you can redistribute  it and/or modify it
@@ -42,4 +42,14 @@
 #define FSL_SOC_USB_SICTRL	0x410	/* NOTE: big-endian */
 #define FSL_SOC_USB_CTRL	0x500	/* NOTE: big-endian */
 #define SNOOP_SIZE_2GB		0x1e
+
+/* control Register Bit Masks */
+#define ULPI_INT_EN		(1<<0)
+#define WU_INT_EN		(1<<1)
+#define USB_CTRL_USB_EN		(1<<2)
+#define LINE_STATE_FILTER__EN	(1<<3)
+#define KEEP_OTG_ON		(1<<4)
+#define OTG_PORT		(1<<5)
+#define PLL_RESET		(1<<8)
+#define UTMI_PHY_EN		(1<<9)
 #endif				/* _EHCI_FSL_H */
-- 
1.6.1
