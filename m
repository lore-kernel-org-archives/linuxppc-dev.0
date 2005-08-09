Return-Path: <dale@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 9 Aug 2005 11:26:19 -0700
To: Linuxppc-embedded@ozlabs.org
Message-ID: <20050809182619.GA15159@xyzzy.farnsworth.org>
References: <42F89F49.4000205@softadvances.com>
	<A9E0A66D-CE6F-4A55-80FD-5D9E57BB6035@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A9E0A66D-CE6F-4A55-80FD-5D9E57BB6035@freescale.com>
Subject: Re: [linuxppc] 2.6.12-3 header <asm/usb.h> missing ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2005 at 02:50:50PM +0000, Kumar Gala wrote:
> Why are we bothering with asm-ppc/usb.h anyways?
> 
> The structure defn only appears to be used once.  If this is true,  
> why not just define it in the .c file.
> 
> - kumar

I previously added asm-ppc/usb.h.

It provides platform-specific callback functions for when the usb HC is
probed and removed.  I attempted to use them for power management on the
ibmstb4 (redwood5) platform, but that code was bogus so I retracted it.

Also, I saw that there are currently several (non-ppc) usb HC drivers
that differ only in platform-specific code at probe and remove time,
so I wanted to avoid that kind of code duplication in the ppc world.

The callback functions are unused today though.  I think we should
remove them.  We can always add them back if they are needed later.

No need to add asm-ppc/usb.h

Instead, apply the following patch.  I'll submit it to linux-usb-devel
tomorrow if no one here complains.

-Dale

This patch removes the reference to asm/usb.h and to the
usb_hcd_platform_data structure it contains.  This structure
is currently unused.  If we decide it's needed later, we can
add it back.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

--- linux-2.6/drivers/usb/host/ohci-ppc-soc.c.old	2005-08-09 10:46:37.000000000 -0700
+++ linux-2.6/drivers/usb/host/ohci-ppc-soc.c	2005-08-09 11:03:44.000000000 -0700
@@ -14,8 +14,6 @@
  * This file is licenced under the GPL.
  */
 
-#include <asm/usb.h>
-
 /* configure so an HC device and id are always provided */
 /* always called with process context; sleeping is OK */
 
@@ -23,9 +21,7 @@
  * usb_hcd_ppc_soc_probe - initialize On-Chip HCDs
  * Context: !in_interrupt()
  *
- * Allocates basic resources for this USB host controller, and
- * then invokes the start() method for the HCD associated with it
- * through the hotplug entry's driver_data.
+ * Allocates basic resources for this USB host controller.
  *
  * Store this function in the HCD's struct pci_driver as probe().
  */
@@ -37,7 +33,6 @@
 	struct ohci_hcd	*ohci;
 	struct resource *res;
 	int irq;
-	struct usb_hcd_platform_data *pd = pdev->dev.platform_data;
 
 	pr_debug("initializing PPC-SOC USB Controller\n");
 
@@ -73,9 +68,6 @@
 		goto err2;
 	}
 
-	if (pd->start && (retval = pd->start(pdev)))
-		goto err3;
-
 	ohci = hcd_to_ohci(hcd);
 	ohci->flags |= OHCI_BIG_ENDIAN;
 	ohci_hcd_init(ohci);
@@ -85,9 +77,7 @@
 		return retval;
 
 	pr_debug("Removing PPC-SOC USB Controller\n");
-	if (pd && pd->stop)
-		pd->stop(pdev);
- err3:
+
 	iounmap(hcd->regs);
  err2:
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
@@ -105,21 +95,17 @@
  * @pdev: USB Host Controller being removed
  * Context: !in_interrupt()
  *
- * Reverses the effect of usb_hcd_ppc_soc_probe(), first invoking
- * the HCD's stop() method.  It is always called from a thread
+ * Reverses the effect of usb_hcd_ppc_soc_probe().
+ * It is always called from a thread
  * context, normally "rmmod", "apmd", or something similar.
  *
  */
 static void usb_hcd_ppc_soc_remove(struct usb_hcd *hcd,
 		struct platform_device *pdev)
 {
-	struct usb_hcd_platform_data *pd = pdev->dev.platform_data;
-
 	usb_remove_hcd(hcd);
 
 	pr_debug("stopping PPC-SOC USB Controller\n");
-	if (pd && pd->stop)
-		pd->stop(pdev);
 
 	iounmap(hcd->regs);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
