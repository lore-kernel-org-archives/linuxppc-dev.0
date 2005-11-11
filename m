Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AB99F68704
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2005 08:55:53 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eddy Petrisor <eddy.petrisor@gmail.com>
In-Reply-To: <43751182.1020009@gmail.com>
References: <1130999620.4680.28.camel@gaston>
	<51ad2e0d0511051358p2fe15f1i7278615996183eb1@mail.gmail.com>
	<1131229041.5229.29.camel@gaston>  <43751182.1020009@gmail.com>
Content-Type: text/plain
Date: Sat, 12 Nov 2005 08:52:26 +1100
Message-Id: <1131745946.24637.251.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: 2.6.14 USB vs. sleep issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The latest patch that is candidate for upstream is:

Index: 2.6.14-ben/drivers/usb/core/hcd-pci.c
===================================================================
--- 2.6.14-ben.orig/drivers/usb/core/hcd-pci.c
+++ 2.6.14-ben/drivers/usb/core/hcd-pci.c
@@ -32,6 +32,13 @@
 #include <linux/usb.h>
 #include "hcd.h"
 
+#ifdef CONFIG_PPC_PMAC
+#include <asm/machdep.h>
+#include <asm/pmac_feature.h>
+#include <asm/pci-bridge.h>
+#include <asm/prom.h>
+#endif
+
 
 /* PCI-based HCs are common, but plenty of non-PCI HCs are used too */
 
@@ -278,6 +285,18 @@ int usb_hcd_pci_suspend (struct pci_dev 
 		break;
 	}
 
+#ifdef CONFIG_PPC_PMAC
+	if (retval == 0 && _machine == _MACH_Pmac) {
+	   	struct device_node	*of_node;
+
+		/* Disable USB PAD & cell clock */
+		of_node = pci_device_to_OF_node (to_pci_dev(hcd->self.
+							    controller));
+		if (of_node)
+			pmac_call_feature(PMAC_FTR_USB_ENABLE, of_node, 0, 0);
+	}
+#endif /* CONFIG_PPC_PMAC */
+
 	/* update power_state **ONLY** to make sysfs happier */
 	if (retval == 0)
 		dev->dev.power.power_state = message;
@@ -303,6 +322,18 @@ int usb_hcd_pci_resume (struct pci_dev *
 		return 0;
 	}
 
+#ifdef CONFIG_PPC_PMAC
+	if (_machine == _MACH_Pmac) {
+		struct device_node *of_node;
+
+		/* Re-enable USB PAD & cell clock */
+		of_node = pci_device_to_OF_node (to_pci_dev(hcd->self.
+							    controller));
+		if (of_node)
+			pmac_call_feature(PMAC_FTR_USB_ENABLE, of_node, 0, 1);
+	}
+#endif /* CONFIG_PPC_PMAC */
+
 	/* NOTE:  chip docs cover clean "real suspend" cases (what Linux
 	 * calls "standby", "suspend to RAM", and so on).  There are also
 	 * dirty cases when swsusp fakes a suspend in "shutdown" mode.
Index: 2.6.14-ben/drivers/usb/core/hcd.c
===================================================================
--- 2.6.14-ben.orig/drivers/usb/core/hcd.c
+++ 2.6.14-ben/drivers/usb/core/hcd.c
@@ -1600,7 +1600,8 @@ irqreturn_t usb_hcd_irq (int irq, void *
 	struct usb_hcd		*hcd = __hcd;
 	int			start = hcd->state;
 
-	if (start == HC_STATE_HALT)
+	if (start == HC_STATE_HALT ||
+	    !test_bit(HC_FLAG_IRQ_ON, &hcd->bitflags))
 		return IRQ_NONE;
 	if (hcd->driver->irq (hcd, r) == IRQ_NONE)
 		return IRQ_NONE;
@@ -1736,6 +1737,9 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	if (hcd->driver->irq) {
 		char	buf[8], *bufp = buf;
 
+		set_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+		mb();
+
 #ifdef __sparc__
 		bufp = __irq_itoa(irqnum);
 #else
Index: 2.6.14-ben/drivers/usb/core/hcd.h
===================================================================
--- 2.6.14-ben.orig/drivers/usb/core/hcd.h
+++ 2.6.14-ben/drivers/usb/core/hcd.h
@@ -71,6 +71,9 @@ struct usb_hcd {	/* usb_bus.hcpriv point
 	/*
 	 * hardware info/state
 	 */
+       unsigned long           bitflags;       /* various single-bit flags */
+#define HC_FLAG_IRQ_ON         0
+
 	const struct hc_driver	*driver;	/* hw-specific hooks */
 	unsigned		saw_irq : 1;
 	unsigned		can_wakeup:1;	/* hw supports wakeup? */
Index: 2.6.14-ben/drivers/usb/host/ehci-hcd.c
===================================================================
--- 2.6.14-ben.orig/drivers/usb/host/ehci-hcd.c
+++ 2.6.14-ben/drivers/usb/host/ehci-hcd.c
@@ -750,6 +750,12 @@ static int ehci_suspend (struct usb_hcd 
 	if (time_before (jiffies, ehci->next_statechange))
 		msleep (100);
 
+	/* Disable emission of interrupts during suspend */
+	writel(0, &ehci->regs->intr_enable);
+	mb();
+	clear_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+	synchronize_irq(to_pci_dev(hcd->self.controller)->irq);
+
 #ifdef	CONFIG_USB_SUSPEND
 	(void) usb_suspend_device (hcd->self.root_hub, message);
 #else
@@ -776,6 +782,8 @@ static int ehci_resume (struct usb_hcd *
 	if (time_before (jiffies, ehci->next_statechange))
 		msleep (100);
 
+	set_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+
 	/* If any port is suspended (or owned by the companion),
 	 * we know we can/must resume the HC (and mustn't reset it).
 	 */
Index: 2.6.14-ben/drivers/usb/host/ehci-q.c
===================================================================
--- 2.6.14-ben.orig/drivers/usb/host/ehci-q.c
+++ 2.6.14-ben/drivers/usb/host/ehci-q.c
@@ -926,6 +926,11 @@ submit_async (
 #endif
 
 	spin_lock_irqsave (&ehci->lock, flags);
+	if (HC_IS_SUSPENDED(ehci_to_hcd(ehci)->state)) {
+		spin_unlock_irqrestore (&ehci->lock, flags);
+		return -ESHUTDOWN;
+	}
+
 	qh = qh_append_tds (ehci, urb, qtd_list, epnum, &ep->hcpriv);
 
 	/* Control/bulk operations through TTs don't need scheduling,
Index: 2.6.14-ben/drivers/usb/host/ehci-sched.c
===================================================================
--- 2.6.14-ben.orig/drivers/usb/host/ehci-sched.c
+++ 2.6.14-ben/drivers/usb/host/ehci-sched.c
@@ -602,6 +602,11 @@ static int intr_submit (
 
 	spin_lock_irqsave (&ehci->lock, flags);
 
+	if (HC_IS_SUSPENDED(ehci_to_hcd(ehci)->state)) {
+		spin_unlock_irqrestore (&ehci->lock, flags);
+		return -ESHUTDOWN;
+	}
+
 	/* get qh and force any scheduling errors */
 	INIT_LIST_HEAD (&empty);
 	qh = qh_append_tds (ehci, urb, &empty, epnum, &ep->hcpriv);
@@ -1456,6 +1461,11 @@ static int itd_submit (struct ehci_hcd *
 
 	/* schedule ... need to lock */
 	spin_lock_irqsave (&ehci->lock, flags);
+	if (HC_IS_SUSPENDED(ehci_to_hcd(ehci)->state)) {
+		spin_unlock_irqrestore (&ehci->lock, flags);
+		status = -ESHUTDOWN;
+		goto done;
+	}
 	status = iso_stream_schedule (ehci, urb, stream);
  	if (likely (status == 0))
 		itd_link_urb (ehci, urb, ehci->periodic_size << 3, stream);
@@ -1815,6 +1825,11 @@ static int sitd_submit (struct ehci_hcd 
 
 	/* schedule ... need to lock */
 	spin_lock_irqsave (&ehci->lock, flags);
+	if (HC_IS_SUSPENDED(ehci_to_hcd(ehci)->state)) {
+		spin_unlock_irqrestore (&ehci->lock, flags);
+		status = -ESHUTDOWN;
+		goto done;
+	}
 	status = iso_stream_schedule (ehci, urb, stream);
  	if (status == 0)
 		sitd_link_urb (ehci, urb, ehci->periodic_size << 3, stream);
Index: 2.6.14-ben/drivers/usb/host/ohci-hcd.c
===================================================================
--- 2.6.14-ben.orig/drivers/usb/host/ohci-hcd.c
+++ 2.6.14-ben/drivers/usb/host/ohci-hcd.c
@@ -252,6 +252,10 @@ static int ohci_urb_enqueue (
 
 	spin_lock_irqsave (&ohci->lock, flags);
 
+	if (HC_IS_SUSPENDED(hcd->state)) {
+		retval = -ESHUTDOWN;
+		goto fail;
+	}
 	/* don't submit to a dead HC */
 	if (!HC_IS_RUNNING(hcd->state)) {
 		retval = -ENODEV;
Index: 2.6.14-ben/drivers/usb/host/ohci-hub.c
===================================================================
--- 2.6.14-ben.orig/drivers/usb/host/ohci-hub.c
+++ 2.6.14-ben/drivers/usb/host/ohci-hub.c
@@ -219,13 +219,6 @@ static int ohci_hub_resume (struct usb_h
 	/* Sometimes PCI D3 suspend trashes frame timings ... */
 	periodic_reinit (ohci);
 
-	/* interrupts might have been disabled */
-	ohci_writel (ohci, OHCI_INTR_INIT, &ohci->regs->intrenable);
-	if (ohci->ed_rm_list)
-		ohci_writel (ohci, OHCI_INTR_SF, &ohci->regs->intrenable);
-	ohci_writel (ohci, ohci_readl (ohci, &ohci->regs->intrstatus),
-			&ohci->regs->intrstatus);
-
 	/* Then re-enable operations */
 	ohci_writel (ohci, OHCI_USB_OPER, &ohci->regs->control);
 	(void) ohci_readl (ohci, &ohci->regs->control);
@@ -241,6 +234,13 @@ static int ohci_hub_resume (struct usb_h
 	/* TRSMRCY */
 	msleep (10);
 
+	/* interrupts might have been disabled */
+	ohci_writel (ohci, OHCI_INTR_INIT, &ohci->regs->intrenable);
+	if (ohci->ed_rm_list)
+		ohci_writel (ohci, OHCI_INTR_SF, &ohci->regs->intrenable);
+	ohci_writel (ohci, ohci_readl (ohci, &ohci->regs->intrstatus),
+			&ohci->regs->intrstatus);
+
 	/* keep it alive for ~5x suspend + resume costs */
 	ohci->next_statechange = jiffies + msecs_to_jiffies (250);
 
Index: 2.6.14-ben/drivers/usb/host/ohci-pci.c
===================================================================
--- 2.6.14-ben.orig/drivers/usb/host/ohci-pci.c
+++ 2.6.14-ben/drivers/usb/host/ohci-pci.c
@@ -14,13 +14,6 @@
  * This file is licenced under the GPL.
  */
  
-#ifdef CONFIG_PPC_PMAC
-#include <asm/machdep.h>
-#include <asm/pmac_feature.h>
-#include <asm/pci-bridge.h>
-#include <asm/prom.h>
-#endif
-
 #ifndef CONFIG_PCI
 #error "This file is PCI bus glue.  CONFIG_PCI must be defined."
 #endif
@@ -118,6 +111,12 @@ static int ohci_pci_suspend (struct usb_
 	if (time_before (jiffies, ohci->next_statechange))
 		msleep (100);
 
+	/* Disable emission of interrupts during suspend */
+	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
+	mb();
+	clear_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+	synchronize_irq(to_pci_dev(hcd->self.controller)->irq);
+
 #ifdef	CONFIG_USB_SUSPEND
 	(void) usb_suspend_device (hcd->self.root_hub, message);
 #else
@@ -129,16 +128,6 @@ static int ohci_pci_suspend (struct usb_
 	/* let things settle down a bit */
 	msleep (100);
 	
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
 
@@ -148,20 +137,11 @@ static int ohci_pci_resume (struct usb_h
 	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
 	int			retval = 0;
 
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
 	/* resume root hub */
 	if (time_before (jiffies, ohci->next_statechange))
 		msleep (100);
+	set_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+
 #ifdef	CONFIG_USB_SUSPEND
 	/* get extra cleanup even if remote wakeup isn't in use */
 	retval = usb_resume_device (hcd->self.root_hub);
Index: 2.6.14-ben/drivers/usb/host/uhci-hcd.c
===================================================================
--- 2.6.14-ben.orig/drivers/usb/host/uhci-hcd.c
+++ 2.6.14-ben/drivers/usb/host/uhci-hcd.c
@@ -797,6 +797,11 @@ static int uhci_suspend(struct usb_hcd *
 
 done:
 	spin_unlock_irq(&uhci->lock);
+	if (rc == 0) {
+		mb();
+		clear_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+		synchronize_irq(hcd->irq);
+	}
 	return rc;
 }
 
@@ -818,6 +823,8 @@ static int uhci_resume(struct usb_hcd *h
 	 * system wakeup.  Check it and reconfigure to avoid problems.
 	 */
 	check_and_reset_hc(uhci);
+	set_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+	mb();
 	configure_hc(uhci);
 
 #ifndef CONFIG_USB_SUSPEND
