Return-Path: <alistair@popple.id.au>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:4])
 by ozlabs.org (Postfix) with ESMTP id 916B32C048A
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Nov 2013 13:08:48 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: benh@kernel.crashing.org
Subject: [PATCH 4/8] IBM Akebono: Add support to the OHCI platform driver for
 PPC476GTR
Date: Fri, 22 Nov 2013 13:08:32 +1100
Message-Id: <1385086116-10972-4-git-send-email-alistair@popple.id.au>
In-Reply-To: <1385086057-10884-1-git-send-email-alistair@popple.id.au>
References: <1385086057-10884-1-git-send-email-alistair@popple.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
 Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The IBM Akebono board uses the PPC476GTR SoC which has a OHCI
compliant USB host interface. This patch adds support for it to the
OHCI platform driver.

As we use device tree to pass platform specific data instead of
platform data we remove the check for platform data and instead
provide reasonable defaults if no platform data is present. This is
similar to what is currently done in ehci-platform.c.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/host/ohci-platform.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index a4c6410..e1ae5d3 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -23,6 +23,8 @@
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
+#include <linux/slab.h>
+#include <linux/of.h>
 
 #include "ohci.h"
 
@@ -55,6 +57,8 @@ static const struct ohci_driver_overrides platform_overrides __initconst = {
 	.reset =	ohci_platform_reset,
 };
 
+static struct usb_ohci_pdata ohci_platform_defaults;
+
 static int ohci_platform_probe(struct platform_device *dev)
 {
 	struct usb_hcd *hcd;
@@ -63,14 +67,16 @@ static int ohci_platform_probe(struct platform_device *dev)
 	int irq;
 	int err = -ENOMEM;
 
-	if (!pdata) {
-		WARN_ON(1);
-		return -ENODEV;
-	}
-
 	if (usb_disabled())
 		return -ENODEV;
 
+	/*
+	 * Platforms using DT don't always provide platform data.
+	 * This should provide reasonable defaults.
+	 */
+	if (!pdata)
+		dev->dev.platform_data = pdata = &ohci_platform_defaults;
+
 	irq = platform_get_irq(dev, 0);
 	if (irq < 0) {
 		dev_err(&dev->dev, "no irq provided");
@@ -171,6 +177,11 @@ static int ohci_platform_resume(struct device *dev)
 #define ohci_platform_resume	NULL
 #endif /* CONFIG_PM */
 
+static const struct of_device_id ohci_of_match[] = {
+	{ .compatible = "usb-ohci", },
+	{},
+};
+
 static const struct platform_device_id ohci_platform_table[] = {
 	{ "ohci-platform", 0 },
 	{ }
@@ -191,6 +202,7 @@ static struct platform_driver ohci_platform_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "ohci-platform",
 		.pm	= &ohci_platform_pm_ops,
+		.of_match_table = ohci_of_match,
 	}
 };
 
-- 
1.7.10.4
