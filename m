Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16953.5968.397116.341920@cargo.ozlabs.ibm.com>
Date: Thu, 17 Mar 2005 16:36:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] Make sleep/wakeup work with USB on powerbooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am currently using this patch on my powerbook to fix the problems
that USB was causing with sleep and wakeup.  Basically one of the USB
controllers was getting a spurious wakeup immediately when put it
into the suspend state.  This would cause the resume routine to be run
after we had turned off the device, causing a machine check.

Also we had some races where we would turn off the clock to the apple
OHCI cell(s) and then try to access them.  With this patch, sleep and
wakeup are quite reliable.  The patch is against 2.6.11.

Paul.

diff -urN linux-2.6.11/drivers/usb/core/hcd-pci.c pmac-2.6.11/drivers/usb/core/hcd-pci.c
--- linux-2.6.11/drivers/usb/core/hcd-pci.c	2004-12-19 00:54:45.000000000 +1100
+++ pmac-2.6.11/drivers/usb/core/hcd-pci.c	2005-02-07 14:49:12.000000000 +1100
@@ -32,6 +32,12 @@
 #include <linux/usb.h>
 #include "hcd.h"
 
+#ifdef CONFIG_PMAC_PBOOK
+#include <asm/machdep.h>
+#include <asm/pmac_feature.h>
+#include <asm/pci-bridge.h>
+#include <asm/prom.h>
+#endif
 
 /* PCI-based HCs are normal, but custom bus glue should be ok */
 
@@ -360,6 +366,17 @@
 		break;
 	}
 
+#ifdef CONFIG_PMAC_PBOOK
+	if (retval == 0 && _machine == _MACH_Pmac) {
+	   	struct device_node	*of_node;
+ 
+		/* Disable USB PAD & cell clock */
+		of_node = pci_device_to_OF_node (dev);
+		if (of_node)
+			pmac_call_feature(PMAC_FTR_USB_ENABLE, of_node, 0, 0);
+	}
+#endif /* CONFIG_PMAC_PBOOK */
+
 	/* update power_state **ONLY** to make sysfs happier */
 	if (retval == 0)
 		dev->dev.power.power_state = state;
@@ -380,6 +397,20 @@
 	int			has_pci_pm;
 
 	hcd = pci_get_drvdata(dev);
+
+#ifdef CONFIG_PMAC_PBOOK
+	if (_machine == _MACH_Pmac) {
+		struct device_node *of_node;
+
+		/* Re-enable USB PAD & cell clock */
+		of_node = pci_device_to_OF_node(dev);
+		if (of_node) {
+			pmac_call_feature (PMAC_FTR_USB_ENABLE, of_node, 0, 1);
+			mdelay(10);
+		}
+	}
+#endif /* CONFIG_PMAC_PBOOK */
+
 	if (hcd->state != HCD_STATE_SUSPENDED) {
 		dev_dbg (hcd->self.controller, 
 				"can't resume, not suspended!\n");
@@ -396,14 +427,8 @@
 
 	if (has_pci_pm)
 		pci_set_power_state (dev, 0);
+	mdelay(1);
 	dev->dev.power.power_state = 0;
-	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
-				hcd->driver->description, hcd);
-	if (retval < 0) {
-		dev_err (hcd->self.controller,
-			"can't restore IRQ after resume!\n");
-		return retval;
-	}
 	hcd->saw_irq = 0;
 	pci_restore_state (dev);
 #ifdef	CONFIG_USB_SUSPEND
@@ -417,6 +442,16 @@
 				"resume fail, retval %d\n", retval);
 		usb_hc_died (hcd);
 	}
+	if (retval)
+		return retval;
+
+	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
+				hcd->driver->description, hcd);
+	if (retval < 0) {
+		dev_err (hcd->self.controller,
+			"can't restore IRQ after resume!\n");
+		return retval;
+	}
 
 	return retval;
 }
diff -urN linux-2.6.11/drivers/usb/host/ohci-hcd.c pmac-2.6.11/drivers/usb/host/ohci-hcd.c
--- linux-2.6.11/drivers/usb/host/ohci-hcd.c	2005-01-31 17:33:41.000000000 +1100
+++ pmac-2.6.11/drivers/usb/host/ohci-hcd.c	2005-02-07 16:27:33.000000000 +1100
@@ -609,8 +609,10 @@
  	ohci_writel (ohci, ohci->hc_control, &ohci->regs->control);
 	ohci_to_hcd(ohci)->state = USB_STATE_RUNNING;
 
+#ifdef CONFIG_USB_SUSPEND
 	/* wake on ConnectStatusChange, matching external hubs */
 	ohci_writel (ohci, RH_HS_DRWE, &ohci->regs->roothub.status);
+#endif
 
 	/* Choose the interrupts we care about now, others later on demand */
 	mask = OHCI_INTR_INIT;
@@ -720,7 +722,9 @@
 
 	if (ints & OHCI_INTR_RD) {
 		ohci_vdbg (ohci, "resume detect\n");
-		schedule_work(&ohci->rh_resume);
+		ohci_writel (ohci, OHCI_INTR_RD, &regs->intrstatus);
+		if (!(ohci->flags & OHCI_SUSPENDING))
+			schedule_work(&ohci->rh_resume);
 	}
 
 	if (ints & OHCI_INTR_WDH) {
diff -urN linux-2.6.11/drivers/usb/host/ohci-hub.c pmac-2.6.11/drivers/usb/host/ohci-hub.c
--- linux-2.6.11/drivers/usb/host/ohci-hub.c	2004-12-23 10:48:43.000000000 +1100
+++ pmac-2.6.11/drivers/usb/host/ohci-hub.c	2005-02-07 15:23:56.000000000 +1100
@@ -102,10 +102,12 @@
 	ohci_writel (ohci, ohci_readl (ohci, &ohci->regs->intrstatus),
 			&ohci->regs->intrstatus);
 
+#ifdef CONFIG_USB_SUSPEND
 	/* maybe resume can wake root hub */
 	if (hcd->remote_wakeup)
 		ohci->hc_control |= OHCI_CTRL_RWE;
 	else
+#endif
 		ohci->hc_control &= ~OHCI_CTRL_RWE;
 
 	/* Suspend hub */
diff -urN linux-2.6.11/drivers/usb/host/ohci-pci.c pmac-2.6.11/drivers/usb/host/ohci-pci.c
--- linux-2.6.11/drivers/usb/host/ohci-pci.c	2004-12-19 02:22:52.000000000 +1100
+++ pmac-2.6.11/drivers/usb/host/ohci-pci.c	2005-02-07 15:23:53.000000000 +1100
@@ -114,23 +114,22 @@
 	(void) usb_suspend_device (hcd->self.root_hub, state);
 #else
 	usb_lock_device (hcd->self.root_hub);
+
+	/* don't wake on ConnectStatusChange */
+	ohci_writel(ohci, RH_HS_CRWE, &ohci->regs->roothub.status);
+	ohci_readl(ohci, &ohci->regs->roothub.status);
+	ohci->flags |= OHCI_SUSPENDING;
+	msleep(10);
+
 	(void) ohci_hub_suspend (hcd);
 	usb_unlock_device (hcd->self.root_hub);
+
 #endif
 
 	/* let things settle down a bit */
+	flush_scheduled_work();
 	msleep (100);
 	
-#ifdef CONFIG_PMAC_PBOOK
-	if (_machine == _MACH_Pmac) {
-	   	struct device_node	*of_node;
- 
-		/* Disable USB PAD & cell clock */
-		of_node = pci_device_to_OF_node (to_pci_dev(hcd->self.controller));
-		if (of_node)
-			pmac_call_feature(PMAC_FTR_USB_ENABLE, of_node, 0, 0);
-	}
-#endif /* CONFIG_PMAC_PBOOK */
 	return 0;
 }
 
@@ -140,17 +139,6 @@
 	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
 	int			retval = 0;
 
-#ifdef CONFIG_PMAC_PBOOK
-	if (_machine == _MACH_Pmac) {
-		struct device_node *of_node;
-
-		/* Re-enable USB PAD & cell clock */
-		of_node = pci_device_to_OF_node (to_pci_dev(hcd->self.controller));
-		if (of_node)
-			pmac_call_feature (PMAC_FTR_USB_ENABLE, of_node, 0, 1);
-	}
-#endif /* CONFIG_PMAC_PBOOK */
-
 	/* resume root hub */
 	if (time_before (jiffies, ohci->next_statechange))
 		msleep (100);
@@ -159,6 +147,7 @@
 	retval = usb_resume_device (hcd->self.root_hub);
 #else
 	usb_lock_device (hcd->self.root_hub);
+	ohci->flags &= ~OHCI_SUSPENDING;
 	retval = ohci_hub_resume (hcd);
 	usb_unlock_device (hcd->self.root_hub);
 #endif
diff -urN linux-2.6.11/drivers/usb/host/ohci.h pmac-2.6.11/drivers/usb/host/ohci.h
--- linux-2.6.11/drivers/usb/host/ohci.h	2004-12-19 02:22:52.000000000 +1100
+++ pmac-2.6.11/drivers/usb/host/ohci.h	2005-02-06 12:32:37.000000000 +1100
@@ -397,6 +397,7 @@
 #define	OHCI_QUIRK_INITRESET	0x04			/* SiS, OPTi, ... */
 #define	OHCI_BIG_ENDIAN		0x08			/* big endian HC */
 	// there are also chip quirks/bugs in init logic
+#define OHCI_SUSPENDING		0x100
 
 };
 
