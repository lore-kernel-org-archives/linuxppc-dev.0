Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8930668734
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Nov 2005 14:12:51 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
In-Reply-To: <1132715288.26560.262.camel@gaston>
References: <1132715288.26560.262.camel@gaston>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 14:09:38 +1100
Message-Id: <1132715379.26560.264.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Fix USB suspend/resume crasher
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This patch applies on top of the patch that moves the PowerMac specific
> code out of ohci-pci.c to hcd-pci.c where it belongs. This patch isn't
> upstream yet for reasons I don't fully understand (why does USB stuffs
> has such a high latency for going upstream ?), I'm sending it as a reply
> to this email for completeness.

Here it is. it's my understand that it's already been queued somewhere
for submission by David for some time though. 

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-serialfix/drivers/usb/core/hcd-pci.c
===================================================================
--- linux-serialfix.orig/drivers/usb/core/hcd-pci.c	2005-11-21 11:53:15.000000000 +1100
+++ linux-serialfix/drivers/usb/core/hcd-pci.c	2005-11-23 11:23:24.000000000 +1100
@@ -27,6 +27,13 @@
 #include "usb.h"
 #include "hcd.h"
 
+#ifdef CONFIG_PPC_PMAC
+#include <asm/machdep.h>
+#include <asm/pmac_feature.h>
+#include <asm/pci-bridge.h>
+#include <asm/prom.h>
+#endif
+
 
 /* PCI-based HCs are common, but plenty of non-PCI HCs are used too */
 
@@ -277,6 +284,16 @@
 	}
 
 done:
+#ifdef CONFIG_PPC_PMAC
+	if (retval == 0 && _machine == _MACH_Pmac) {
+	   	struct device_node	*of_node;
+
+		/* Disable USB PAD & cell clock */
+		of_node = pci_device_to_OF_node(dev);
+		if (of_node)
+			pmac_call_feature(PMAC_FTR_USB_ENABLE, of_node, 0, 0);
+	}
+#endif /* CONFIG_PPC_PMAC */
 	if (retval == 0)
 		dev->dev.power.power_state = PMSG_SUSPEND;
 	return retval;
@@ -301,6 +318,17 @@
 		return 0;
 	}
 
+#ifdef CONFIG_PPC_PMAC
+	if (_machine == _MACH_Pmac) {
+		struct device_node *of_node;
+
+		/* Re-enable USB PAD & cell clock */
+		of_node = pci_device_to_OF_node(dev);
+		if (of_node)
+			pmac_call_feature(PMAC_FTR_USB_ENABLE, of_node, 0, 1);
+	}
+#endif /* CONFIG_PPC_PMAC */
+
 	/* NOTE:  chip docs cover clean "real suspend" cases (what Linux
 	 * calls "standby", "suspend to RAM", and so on).  There are also
 	 * dirty cases when swsusp fakes a suspend in "shutdown" mode.
Index: linux-serialfix/drivers/usb/host/ohci-pci.c
===================================================================
--- linux-serialfix.orig/drivers/usb/host/ohci-pci.c	2005-11-14 10:42:00.000000000 +1100
+++ linux-serialfix/drivers/usb/host/ohci-pci.c	2005-11-23 11:25:26.000000000 +1100
@@ -114,40 +114,12 @@
 
 static int ohci_pci_suspend (struct usb_hcd *hcd, pm_message_t message)
 {
-	/* root hub was already suspended */
-
-	/* FIXME these PMAC things get called in the wrong places.  ASIC
-	 * clocks should be turned off AFTER entering D3, and on BEFORE
-	 * trying to enter D0.  Evidently the PCI layer doesn't currently
-	 * provide the right sort of platform hooks for this ...
-	 */
-#ifdef CONFIG_PPC_PMAC
-	if (_machine == _MACH_Pmac) {
-	   	struct device_node	*of_node;
- 
-		/* Disable USB PAD & cell clock */
-		of_node = pci_device_to_OF_node (to_pci_dev(hcd->self.controller));
-		if (of_node)
-			pmac_call_feature(PMAC_FTR_USB_ENABLE, of_node, 0, 0);
-	}
-#endif /* CONFIG_PPC_PMAC */
 	return 0;
 }
 
 
 static int ohci_pci_resume (struct usb_hcd *hcd)
 {
-#ifdef CONFIG_PPC_PMAC
-	if (_machine == _MACH_Pmac) {
-		struct device_node *of_node;
-
-		/* Re-enable USB PAD & cell clock */
-		of_node = pci_device_to_OF_node (to_pci_dev(hcd->self.controller));
-		if (of_node)
-			pmac_call_feature (PMAC_FTR_USB_ENABLE, of_node, 0, 1);
-	}
-#endif /* CONFIG_PPC_PMAC */
-
 	usb_hcd_resume_root_hub(hcd);
 	return 0;
 }
