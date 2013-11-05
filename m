Return-Path: <alistair@popple.id.au>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:4])
 by ozlabs.org (Postfix) with ESMTP id 25C9C2C0446
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2013 16:32:03 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/7] IBM Akebono: Add support to the EHCI platform driver for
 Akebono
Date: Tue,  5 Nov 2013 16:31:09 +1100
Message-Id: <1383629471-16979-5-git-send-email-alistair@popple.id.au>
In-Reply-To: <1383629471-16979-1-git-send-email-alistair@popple.id.au>
References: <1383629471-16979-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, linux-usb@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The IBM Akebono board has an EHCI compliant USB host interface. This
patch adds support for it to the EHCI platform driver.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/host/ehci-platform.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index f6b790c..0a67616 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -203,9 +203,10 @@ static int ehci_platform_resume(struct device *dev)
 #define ehci_platform_resume	NULL
 #endif /* CONFIG_PM */
 
-static const struct of_device_id vt8500_ehci_ids[] = {
+static const struct of_device_id ehci_platform_ids[] = {
 	{ .compatible = "via,vt8500-ehci", },
 	{ .compatible = "wm,prizm-ehci", },
+	{ .compatible = "ibm,akebono-ehci", },
 	{}
 };
 
@@ -229,7 +230,7 @@ static struct platform_driver ehci_platform_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "ehci-platform",
 		.pm	= &ehci_platform_pm_ops,
-		.of_match_table = vt8500_ehci_ids,
+		.of_match_table = ehci_platform_ids,
 	}
 };
 
-- 
1.7.10.4
