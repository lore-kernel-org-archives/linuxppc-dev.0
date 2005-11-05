Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B0B0668679
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Nov 2005 09:18:56 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bin Zhang <yangtze31@gmail.com>
In-Reply-To: <51ad2e0d0511051358p2fe15f1i7278615996183eb1@mail.gmail.com>
References: <1130999620.4680.28.camel@gaston>
	<51ad2e0d0511051358p2fe15f1i7278615996183eb1@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 06 Nov 2005 09:17:20 +1100
Message-Id: <1131229041.5229.29.camel@gaston>
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

On Sat, 2005-11-05 at 22:58 +0100, Bin Zhang wrote:
> On 11/3/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > For those who experience crashes on sleep and/or wakeup (typically due
> > to USB) with 2.6.14, I made a test patch that might help. Please let me
> > know if it makes things more reliable.
> >
> I've tried your patch with usb wifi dlink dwl-g122 (my eth1). It works.
> There are some differences in /var/log/syslog :

I have another patch tho:

Index: linux-2.6.14-benh/drivers/usb/core/hcd-pci.c
===================================================================
--- linux-2.6.14-benh.orig/drivers/usb/core/hcd-pci.c	2005-10-31 10:54:44.000000000 +1100
+++ linux-2.6.14-benh/drivers/usb/core/hcd-pci.c	2005-11-05 11:58:55.000000000 +1100
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
 
@@ -278,6 +285,18 @@
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
@@ -303,6 +322,18 @@
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
@@ -381,7 +412,6 @@
 		usb_hc_died (hcd);
 	}
 
-	retval = pci_enable_device(dev);
 	return retval;
 }
 EXPORT_SYMBOL (usb_hcd_pci_resume);
Index: linux-2.6.14-benh/drivers/usb/host/ehci-hcd.c
===================================================================
--- linux-2.6.14-benh.orig/drivers/usb/host/ehci-hcd.c	2005-10-31 10:54:44.000000000 +1100
+++ linux-2.6.14-benh/drivers/usb/host/ehci-hcd.c	2005-11-06 08:26:42.000000000 +1100
@@ -750,6 +750,15 @@
 	if (time_before (jiffies, ehci->next_statechange))
 		msleep (100);
 
+	/* Disable emission of interrupts during suspend */
+	writel(0, &ehci->regs->intr_enable);
+	mb();
+	clear_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+	synchronize_irq(dev->irq);
+
+	/* Tell root hub not to bother trying to resume */
+	set_bit(HC_FLAG_SUSPEND_RH, &hcd->bitflags);
+
 #ifdef	CONFIG_USB_SUSPEND
 	(void) usb_suspend_device (hcd->self.root_hub, message);
 #else
@@ -776,6 +785,9 @@
 	if (time_before (jiffies, ehci->next_statechange))
 		msleep (100);
 
+	clear_bit(HC_FLAG_SUSPEND_RH, &hcd->bitflags);
+	set_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+
 	/* If any port is suspended (or owned by the companion),
 	 * we know we can/must resume the HC (and mustn't reset it).
 	 */
Index: linux-2.6.14-benh/drivers/usb/host/ehci-q.c
===================================================================
--- linux-2.6.14-benh.orig/drivers/usb/host/ehci-q.c	2005-10-31 10:54:44.000000000 +1100
+++ linux-2.6.14-benh/drivers/usb/host/ehci-q.c	2005-11-03 17:03:27.000000000 +1100
@@ -926,6 +926,11 @@
 #endif
 
 	spin_lock_irqsave (&ehci->lock, flags);
+	if (HC_IS_SUSPENDED(ehci_to_hcd(ehci)->state)) {
+		spin_unlock_irqrestore (&ehci->lock, flags);
+		return -ESHUTDOWN;
+	}
+
 	qh = qh_append_tds (ehci, urb, qtd_list, epnum, &ep->hcpriv);
 
 	/* Control/bulk operations through TTs don't need scheduling,
Index: linux-2.6.14-benh/drivers/usb/host/ehci-sched.c
===================================================================
--- linux-2.6.14-benh.orig/drivers/usb/host/ehci-sched.c	2005-10-31 10:54:44.000000000 +1100
+++ linux-2.6.14-benh/drivers/usb/host/ehci-sched.c	2005-11-03 17:05:54.000000000 +1100
@@ -602,6 +602,11 @@
 
 	spin_lock_irqsave (&ehci->lock, flags);
 
+	if (HC_IS_SUSPENDED(ehci_to_hcd(ehci)->state)) {
+		spin_unlock_irqrestore (&ehci->lock, flags);
+		return -ESHUTDOWN;
+	}
+
 	/* get qh and force any scheduling errors */
 	INIT_LIST_HEAD (&empty);
 	qh = qh_append_tds (ehci, urb, &empty, epnum, &ep->hcpriv);
@@ -1456,6 +1461,11 @@
 
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
@@ -1815,6 +1825,11 @@
 
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
Index: linux-2.6.14-benh/drivers/usb/host/ohci-hcd.c
===================================================================
--- linux-2.6.14-benh.orig/drivers/usb/host/ohci-hcd.c	2005-10-31 10:54:44.000000000 +1100
+++ linux-2.6.14-benh/drivers/usb/host/ohci-hcd.c	2005-11-06 08:34:41.000000000 +1100
@@ -252,6 +252,10 @@
 
 	spin_lock_irqsave (&ohci->lock, flags);
 
+	if (HC_IS_SUSPENDED(hcd->state)) {
+		retval = -ESHUTDOWN;
+		goto fail;
+	}
 	/* don't submit to a dead HC */
 	if (!HC_IS_RUNNING(hcd->state)) {
 		retval = -ENODEV;
Index: linux-2.6.14-benh/drivers/usb/host/ohci-hub.c
===================================================================
--- linux-2.6.14-benh.orig/drivers/usb/host/ohci-hub.c	2005-10-31 10:54:44.000000000 +1100
+++ linux-2.6.14-benh/drivers/usb/host/ohci-hub.c	2005-11-05 13:12:24.000000000 +1100
@@ -139,6 +139,9 @@
 	u32			temp, enables;
 	int			status = -EINPROGRESS;
 
+	if (test_bit(HC_FLAG_SUSPEND_RH, &hcd->bitflags))
+		return -ESHUTDOWN;
+
 	if (time_before (jiffies, ohci->next_statechange))
 		msleep(5);
 
@@ -219,13 +222,6 @@
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
@@ -241,6 +237,13 @@
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
 
@@ -308,6 +311,9 @@
 	int		can_suspend = hcd->can_wakeup;
 	unsigned long	flags;
 
+	if (test_bit(HC_FLAG_SUSPEND_RH, &hcd->bitflags))
+		return 0;
+
 	spin_lock_irqsave (&ohci->lock, flags);
 
 	/* handle autosuspended root:  finish resuming before
@@ -441,6 +447,9 @@
 		return -EINVAL;
 	port--;
 
+	if (test_bit(HC_FLAG_SUSPEND_RH, &hcd->bitflags))
+		return -ESHUTDOWN;
+
 	/* start port reset before HNP protocol times out */
 	status = ohci_readl(ohci, &ohci->regs->roothub.portstatus [port]);
 	if (!(status & RH_PS_CCS))
@@ -526,6 +535,9 @@
 	u32		temp;
 	int		retval = 0;
 
+	if (test_bit(HC_FLAG_SUSPEND_RH, &hcd->bitflags))
+		return -ESHUTDOWN;
+
 	switch (typeReq) {
 	case ClearHubFeature:
 		switch (wValue) {
Index: linux-2.6.14-benh/drivers/usb/host/ohci-pci.c
===================================================================
--- linux-2.6.14-benh.orig/drivers/usb/host/ohci-pci.c	2005-10-31 10:52:24.000000000 +1100
+++ linux-2.6.14-benh/drivers/usb/host/ohci-pci.c	2005-11-05 12:46:53.000000000 +1100
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
@@ -118,6 +111,15 @@
 	if (time_before (jiffies, ohci->next_statechange))
 		msleep (100);
 
+	/* Disable emission of interrupts during suspend */
+	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
+	mb();
+	clear_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+	synchronize_irq(dev->irq);
+
+	/* Tell root hub not to bother trying to resume */
+	set_bit(HC_FLAG_SUSPEND_RH, &hcd->bitflags);
+
 #ifdef	CONFIG_USB_SUSPEND
 	(void) usb_suspend_device (hcd->self.root_hub, message);
 #else
@@ -129,16 +131,6 @@
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
 
@@ -148,20 +140,13 @@
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
+
+	clear_bit(HC_FLAG_SUSPEND_RH, &hcd->bitflags);
+	set_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+
 #ifdef	CONFIG_USB_SUSPEND
 	/* get extra cleanup even if remote wakeup isn't in use */
 	retval = usb_resume_device (hcd->self.root_hub);
Index: linux-2.6.14-benh/drivers/usb/core/hcd.c
===================================================================
--- linux-2.6.14-benh.orig/drivers/usb/core/hcd.c	2005-10-31 10:54:44.000000000 +1100
+++ linux-2.6.14-benh/drivers/usb/core/hcd.c	2005-11-05 11:56:48.000000000 +1100
@@ -1600,7 +1600,8 @@
 	struct usb_hcd		*hcd = __hcd;
 	int			start = hcd->state;
 
-	if (start == HC_STATE_HALT)
+	if (start == HC_STATE_HALT ||
+	    !test_bit(HC_FLAG_IRQ_ON, &hcd->bitflags))
 		return IRQ_NONE;
 	if (hcd->driver->irq (hcd, r) == IRQ_NONE)
 		return IRQ_NONE;
@@ -1736,6 +1737,9 @@
 	if (hcd->driver->irq) {
 		char	buf[8], *bufp = buf;
 
+		set_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+		wmb();
+
 #ifdef __sparc__
 		bufp = __irq_itoa(irqnum);
 #else
Index: linux-2.6.14-benh/drivers/usb/core/hcd.h
===================================================================
--- linux-2.6.14-benh.orig/drivers/usb/core/hcd.h	2005-10-31 10:54:44.000000000 +1100
+++ linux-2.6.14-benh/drivers/usb/core/hcd.h	2005-11-05 12:19:11.000000000 +1100
@@ -71,6 +71,10 @@
 	/*
 	 * hardware info/state
 	 */
+       unsigned long           bitflags;       /* various single-bit flags */
+#define HC_FLAG_IRQ_ON         0
+#define HC_FLAG_SUSPEND_RH     1
+
 	const struct hc_driver	*driver;	/* hw-specific hooks */
 	unsigned		saw_irq : 1;
 	unsigned		can_wakeup:1;	/* hw supports wakeup? */
Index: linux-2.6.14-benh/drivers/usb/host/ehci-hub.c
===================================================================
--- linux-2.6.14-benh.orig/drivers/usb/host/ehci-hub.c	2005-10-31 10:54:44.000000000 +1100
+++ linux-2.6.14-benh/drivers/usb/host/ehci-hub.c	2005-11-05 13:12:39.000000000 +1100
@@ -90,8 +90,12 @@
 	int			i;
 	int			intr_enable;
 
+	if (test_bit(HC_FLAG_SUSPEND_RH, &hcd->bitflags))
+		return -ESHUTDOWN;
+
 	if (time_before (jiffies, ehci->next_statechange))
 		msleep(5);
+
 	spin_lock_irq (&ehci->lock);
 
 	/* re-init operational registers in case we lost power */
@@ -215,7 +219,8 @@
 	unsigned long	flags;
 
 	/* if !USB_SUSPEND, root hub timers won't get shut down ... */
-	if (!HC_IS_RUNNING(hcd->state))
+	if (!HC_IS_RUNNING(hcd->state) ||
+	    test_bit(HC_FLAG_SUSPEND_RH, &hcd->bitflags))
 		return 0;
 
 	/* init status to no-changes */
@@ -313,6 +318,8 @@
 	unsigned long	flags;
 	int		retval = 0;
 
+	if (test_bit(HC_FLAG_SUSPEND_RH, &hcd->bitflags))
+		return -ESHUTDOWN;
 	/*
 	 * FIXME:  support SetPortFeatures USB_PORT_FEAT_INDICATOR.
 	 * HCS_INDICATOR may say we can change LEDs to off/amber/green.
Index: linux-2.6.14-benh/drivers/usb/host/uhci-hcd.c
===================================================================
--- linux-2.6.14-benh.orig/drivers/usb/host/uhci-hcd.c	2005-10-31 10:54:44.000000000 +1100
+++ linux-2.6.14-benh/drivers/usb/host/uhci-hcd.c	2005-11-06 08:35:39.000000000 +1100
@@ -770,6 +770,12 @@
 
 	dev_dbg(uhci_dev(uhci), "%s\n", __FUNCTION__);
 
+	/* Disable emission of interrupts during suspend */
+	pci_write_config_word(to_pci_dev(uhci_dev(uhci)), USBLEGSUP, 0);
+	mb();
+	clear_bit(HC_FLAG_IRQ_ON, &hcd->bitflags);
+	synchronize_irq(dev->irq);
+
 	spin_lock_irq(&uhci->lock);
 	if (uhci->hc_inaccessible)	/* Dead or already suspended */
 		goto done;
@@ -787,7 +793,8 @@
 	};
 
 	/* All PCI host controllers are required to disable IRQ generation
-	 * at the source, so we must turn off PIRQ.
+	 * at the source, so we must turn off PIRQ. Already done earlier
+	 * but better be safe than sorry...
 	 */
 	pci_write_config_word(to_pci_dev(uhci_dev(uhci)), USBLEGSUP, 0);
 	uhci->hc_inaccessible = 1;
