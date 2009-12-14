Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id AAB921009E1
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2009 02:41:13 +1100 (EST)
Date: Mon, 14 Dec 2009 18:41:12 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 2/2] USB: ehci-fsl: Add power management support
Message-ID: <20091214154112.GB26805@oksana.dev.rtsoft.ru>
References: <20091214154025.GA24035@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091214154025.GA24035@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>,
	Jerry Huang <Chang-Ming.Huang@freescale.com>,
	linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

EHCI FSL controller preserve its state during sleep mode, so nothing
fancy needs to be done.

Though, during 'deep sleep' mode (as found in MPC831x CPUs) the
controller turns off and needs to be reinitialized upon resume.

This patch adds support for hibernation and resuming after deep sleep.
Based on Dave Liu and Jerry Huang's work[1].

[1] http://www.bitshrine.org/gpp/linux-fsl-2.6.24.3-MPC8315ERDB-usb-power-mangement.patch

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/usb/host/ehci-fsl.c |   90 +++++++++++++++++++++++++++++++++++++++---
 1 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 593a7e7..0e26aa1 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -1,5 +1,6 @@
 /*
- * Copyright (c) 2005 MontaVista Software
+ * Copyright 2005-2009 MontaVista Software, Inc.
+ * Copyright 2008      Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -17,17 +18,20 @@
  *
  * Ported to 834x by Randy Vinson <rvinson@mvista.com> using code provided
  * by Hunter Wu.
+ * Power Management support by Dave Liu <daveliu@freescale.com>,
+ * Jerry Huang <Chang-Ming.Huang@freescale.com> and
+ * Anton Vorontsov <avorontsov@ru.mvista.com>.
  */
 
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/fsl_devices.h>
 
 #include "ehci-fsl.h"
 
-/* FIXME: Power Management is un-ported so temporarily disable it */
-#undef CONFIG_PM
-
-
 /* configure so an HC device and id are always provided */
 /* always called with process context; sleeping is OK */
 
@@ -285,10 +289,81 @@ static int ehci_fsl_setup(struct usb_hcd *hcd)
 	return retval;
 }
 
+struct ehci_fsl {
+	struct ehci_hcd	ehci;
+
+#ifdef CONFIG_PM
+	/* Saved USB PHY settings, need to restore after deep sleep. */
+	u32 usb_ctrl;
+#endif
+};
+
+#ifdef CONFIG_PM
+
+static struct ehci_fsl *hcd_to_ehci_fsl(struct usb_hcd *hcd)
+{
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+
+	return container_of(ehci, struct ehci_fsl, ehci);
+}
+
+static int ehci_fsl_drv_suspend(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct ehci_fsl *ehci_fsl = hcd_to_ehci_fsl(hcd);
+	void __iomem *non_ehci = hcd->regs;
+
+	if (!fsl_deep_sleep())
+		return 0;
+
+	ehci_fsl->usb_ctrl = in_be32(non_ehci + FSL_SOC_USB_CTRL);
+	return 0;
+}
+
+static int ehci_fsl_drv_resume(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct ehci_fsl *ehci_fsl = hcd_to_ehci_fsl(hcd);
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	void __iomem *non_ehci = hcd->regs;
+
+	if (!fsl_deep_sleep())
+		return 0;
+
+	usb_root_hub_lost_power(hcd->self.root_hub);
+
+	/* Restore USB PHY settings and enable the controller. */
+	out_be32(non_ehci + FSL_SOC_USB_CTRL, ehci_fsl->usb_ctrl);
+
+	ehci_reset(ehci);
+	ehci_fsl_reinit(ehci);
+
+	return 0;
+}
+
+static int ehci_fsl_drv_restore(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+
+	usb_root_hub_lost_power(hcd->self.root_hub);
+	return 0;
+}
+
+static struct dev_pm_ops ehci_fsl_pm_ops = {
+	.suspend = ehci_fsl_drv_suspend,
+	.resume = ehci_fsl_drv_resume,
+	.restore = ehci_fsl_drv_restore,
+};
+
+#define EHCI_FSL_PM_OPS		(&ehci_fsl_pm_ops)
+#else
+#define EHCI_FSL_PM_OPS		NULL
+#endif /* CONFIG_PM */
+
 static const struct hc_driver ehci_fsl_hc_driver = {
 	.description = hcd_name,
 	.product_desc = "Freescale On-Chip EHCI Host Controller",
-	.hcd_priv_size = sizeof(struct ehci_hcd),
+	.hcd_priv_size = sizeof(struct ehci_fsl),
 
 	/*
 	 * generic hardware linkage
@@ -355,6 +430,7 @@ static struct platform_driver ehci_fsl_driver = {
 	.remove = ehci_fsl_drv_remove,
 	.shutdown = usb_hcd_platform_shutdown,
 	.driver = {
-		   .name = "fsl-ehci",
+		.name = "fsl-ehci",
+		.pm = EHCI_FSL_PM_OPS,
 	},
 };
-- 
1.6.3.3
