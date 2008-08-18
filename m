Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C52E1DE09F
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 08:12:17 +1000 (EST)
Date: Tue, 19 Aug 2008 02:10:40 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errrata
Message-ID: <20080819021040.27ce7dbe@vitb-lp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stefan Roese <sr@denx.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Mark Miesfeld <mmiesfeld@amcc.com>, "linux-usb-devel@lists.sourceforge.net"
	<linux-usb-devel@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A published errata for ppc440epx states, that when running Linux with both
EHCI and OHCI modules loaded, the EHCI module experiences a fatal error 
when a high-speed device is connected to the USB2.0, and functions normally
if OHCI module is not loaded. 

Quote from original descriprion:

The 440EPx USB 2.0 Host controller is an EHCI compliant controller.  In USB
2.0 Host controllers, each EHCI controller has one or more companion
controllers, which may be OHCI or UHCI.  An USB 2.0 Host controller will
contain one or more ports.  For each port, only one of the controllers is
connected at any one time. In the 440EPx, there is only one OHCI companion controller, 
and only one USB 2.0 Host port.
All ports on an USB 2.0 controller default to the companion controller.  If
you load only an ohci driver, it will have control of the ports and any
deviceplugged in will operate, although high speed devices will be forced to
operate at full speed.  When an ehci driver is loaded, it explicitly takes control
of the ports.  If there is a device connected, and / or every time there is a
new device connected, the ehci driver determines if the device is high speed or
not.  If it is high speed, the driver retains control of the port.  If it
is not, the driver explicitly gives the companion controller control of the
port.

There is a software workaround that uses a trick to detect if full-speed interface 
is enabled from the hi-speed driver(and vice versa), and use suspend control for ohci
to enable/disable it appropriately.
 
Initial version of the software workaround was posted to linux-usb-devel:

http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg54019.html

and later were made available from amcc.com:
http://www.amcc.com/Embedded/Downloads/download.html?cat=1&family=15&ins=2

The patch below is generally based on the latter, but reworked to
powerpc/of_device USB drivers, and uses a few devicetree inquiries to get
rid of (some) hardcoded defines.

Cc: Mark Miesfeld <mmiesfeld@amcc.com>
Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
Signed-off-by: Stefan Roese <sr@denx.de>
---

 drivers/usb/host/Kconfig       |   16 +++++++++
 drivers/usb/host/ehci-hub.c    |   15 ++++++++
 drivers/usb/host/ehci-ppc-of.c |   72 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/ohci-ppc-of.c |   30 +++++++++++++++++
 4 files changed, 132 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index c74de1a..de9a415 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -71,6 +71,22 @@ config USB_EHCI_TT_NEWSCHED
 
 	  If unsure, say N.
 
+config  USB_PPC440EPX_USBH_23_ERRATA
+	bool "PPC440EPX USBH_23 ERRATA EHCI and OHCI contention"
+	depends on USB_EHCI_HCD && 440EPX
+	default y
+	---help---
+	  Allows the EHCI and OHCI drivers to be loaded together when using
+	  the USB Host controller on the 440EPX processor. This is necessary
+	  when both high speed or full speed devices may be connected to the
+	  USB Host port.
+
+	  The option is not needed if the USB Host port is only used with
+	  USB 2.0 high speed devices and the OHCI driver is never loaded.
+
+	  Say N when the OHCI driver for the 440EPX will never be loaded.  If
+	  unsure, say Y.
+
 config USB_EHCI_BIG_ENDIAN_MMIO
 	bool
 	depends on USB_EHCI_HCD && (PPC_CELLEB || PPC_PS3 || 440EPX || ARCH_IXP4XX)
diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index 740835b..f012f05 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -396,6 +396,10 @@ static inline void remove_companion_file(struct ehci_hcd *ehci)
 
 /*-------------------------------------------------------------------------*/
 
+#ifdef CONFIG_USB_PPC440EPX_USBH_23_ERRATA
+static void set_ohci_hcfs(int);
+#endif
+
 static int check_reset_complete (
 	struct ehci_hcd	*ehci,
 	int		index,
@@ -424,8 +428,17 @@ static int check_reset_complete (
 		port_status &= ~PORT_RWC_BITS;
 		ehci_writel(ehci, port_status, status_reg);
 
-	} else
+#ifdef CONFIG_USB_PPC440EPX_USBH_23_ERRATA
+		/* ensure 440EPX ohci controller state is operational */
+		set_ohci_hcfs(1);
+#endif
+	} else {
 		ehci_dbg (ehci, "port %d high speed\n", index + 1);
+#ifdef CONFIG_USB_PPC440EPX_USBH_23_ERRATA
+		/* ensure 440EPx ohci controller state is suspended */
+		set_ohci_hcfs(0);
+#endif
+	}
 
 	return port_status;
 }
diff --git a/drivers/usb/host/ehci-ppc-of.c b/drivers/usb/host/ehci-ppc-of.c
index b018dee..90810f6 100644
--- a/drivers/usb/host/ehci-ppc-of.c
+++ b/drivers/usb/host/ehci-ppc-of.c
@@ -17,6 +17,32 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 
+#ifdef CONFIG_USB_PPC440EPX_USBH_23_ERRATA
+static u32 __iomem *ohci_hcctrl_reg;
+
+#define OHCI_CTRL_HCFS		(3 << 6)
+#define OHCI_USB_OPER		(2 << 6)
+#define OHCI_USB_SUSPEND	(3 << 6)
+
+#define OHCI_HCCTRL_OFFSET	0x4
+#define OHCI_HCCTRL_LEN		0x4
+
+static void set_ohci_hcfs(int operational)
+{
+	u32 hc_control;
+
+	hc_control = (readl_be(ohci_hcctrl_reg) & ~OHCI_CTRL_HCFS);
+	if (operational)
+		hc_control |= OHCI_USB_OPER;
+	else
+		hc_control |= OHCI_USB_SUSPEND;
+
+	writel_be(hc_control, ohci_hcctrl_reg);
+	(void) readl_be(ohci_hcctrl_reg);
+}
+#endif
+
+
 /* called during probe() after chip reset completes */
 static int ehci_ppc_of_setup(struct usb_hcd *hcd)
 {
@@ -111,12 +137,29 @@ ehci_hcd_ppc_of_probe(struct of_device *op, const struct of_device_id *match)
 	struct resource res;
 	int irq;
 	int rv;
+#ifdef CONFIG_USB_PPC440EPX_USBH_23_ERRATA
+	struct device_node *np;
+#endif
 
 	if (usb_disabled())
 		return -ENODEV;
 
 	dev_dbg(&op->dev, "initializing PPC-OF USB Controller\n");
 
+#ifdef CONFIG_USB_PPC440EPX_USBH_23_ERRATA
+	np = of_find_compatible_node(NULL, NULL, "ohci-be");
+	if (np != NULL) {
+		if (!of_address_to_resource(np, 0, &res))
+			ohci_hcctrl_reg = ioremap(res.start +
+					OHCI_HCCTRL_OFFSET, OHCI_HCCTRL_LEN);
+		else
+			pr_debug(__FILE__ ": no ohci offset in fdt\n");
+	}
+	if (!ohci_hcctrl_reg) {
+		pr_debug(__FILE__ ": ioremap for ohci hcctrl failed\n");
+		return -ENOMEM;
+	}
+#endif
 	rv = of_address_to_resource(dn, 0, &res);
 	if (rv)
 		return rv;
@@ -182,6 +225,10 @@ err_ioremap:
 err_irq:
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 err_rmr:
+
+#ifdef CONFIG_USB_PPC440EPX_USBH_23_ERRATA
+	iounmap(ohci_hcctrl_reg);
+#endif
 	usb_put_hcd(hcd);
 
 	return rv;
@@ -191,6 +238,11 @@ err_rmr:
 static int ehci_hcd_ppc_of_remove(struct of_device *op)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(&op->dev);
+
+#ifdef CONFIG_USB_PPC440EPX_USBH_23_ERRATA
+	struct device_node *np;
+	struct resource res;
+#endif
 	dev_set_drvdata(&op->dev, NULL);
 
 	dev_dbg(&op->dev, "stopping PPC-OF USB Controller\n");
@@ -201,6 +253,26 @@ static int ehci_hcd_ppc_of_remove(struct of_device *op)
 	irq_dispose_mapping(hcd->irq);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 
+#ifdef CONFIG_USB_PPC440EPX_USBH_23_ERRATA
+	/* use request_mem_region to test if the ohci driver is loaded.  if so
+	 * ensure the ohci core is operational.
+	 */
+
+	np = of_find_compatible_node(NULL, NULL, "ohci-be");
+	if (np != NULL) {
+		if (!of_address_to_resource(np, 0, &res))
+			if (!request_mem_region(res.start, 0x4, hcd_name))
+				set_ohci_hcfs(1);
+			else
+				release_mem_region(res.start, 0x4);
+		else
+			pr_debug(__FILE__ ": no ohci offset in fdt\n");
+		of_node_put(np);
+	} else
+		pr_debug(__FILE__ ": ohci not found in device tree \n");
+
+	iounmap(ohci_hcctrl_reg);
+#endif
 	usb_put_hcd(hcd);
 
 	return 0;
diff --git a/drivers/usb/host/ohci-ppc-of.c b/drivers/usb/host/ohci-ppc-of.c
index a672527..59ba26c 100644
--- a/drivers/usb/host/ohci-ppc-of.c
+++ b/drivers/usb/host/ohci-ppc-of.c
@@ -92,6 +92,9 @@ ohci_hcd_ppc_of_probe(struct of_device *op, const struct of_device_id *match)
 
 	int rv;
 	int is_bigendian;
+#ifdef CONFIG_USB_PPC440EPX_USBH_23_ERRATA
+	struct device_node *np;
+#endif
 
 	if (usb_disabled())
 		return -ENODEV;
@@ -148,6 +151,33 @@ ohci_hcd_ppc_of_probe(struct of_device *op, const struct of_device_id *match)
 	if (rv == 0)
 		return 0;
 
+#ifdef CONFIG_USB_PPC440EPX_USBH_23_ERRATA
+	/* Work around - At this point ohci_run has executed, the
+	* controller is running, everything, the root ports, etc., is
+	* set up.  If the ehci driver is loaded, put the ohci core in
+	* the suspended state.  The ehci driver will bring it out of
+	* suspended state when / if a non-high speed USB device is
+	* attached to the USB Host port.  If the ehci driver is not
+	* loaded, do nothing. request_mem_region is used to test if
+	* the ehci driver is loaded.
+	*/
+	np = of_find_compatible_node(NULL, NULL, "ibm,usb-ehci-440epx");
+	if (np !=  NULL)
+		if (!of_address_to_resource(np, 0, &res))
+			if (!request_mem_region(res.start, 0x4, hcd_name)) {
+				writel_be((readl_be(&ohci->regs->control) |
+				    OHCI_USB_SUSPEND), &ohci->regs->control);
+				    (void) readl_be(&ohci->regs->control);
+			} else  {
+				release_mem_region(res.start, 0x4);
+			}
+		else
+		    pr_debug(__FILE__ ": cannot get ehci offset from fdt\n");
+	else
+		pr_debug(__FILE__ ": ehci not found in device tree \n");
+
+	spin_unlock_irq(&ohci->lock);
+#endif
 	iounmap(hcd->regs);
 err_ioremap:
 	irq_dispose_mapping(irq);
