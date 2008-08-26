Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8A527DECFB
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Aug 2008 08:24:09 +1000 (EST)
Date: Wed, 27 Aug 2008 02:23:51 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errata
Message-ID: <20080827022351.67e8a9b2@vitb-lp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stefan Roese <sr@denx.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linux-usb@vger.kernel.org, Mark Miesfeld <mmiesfeld@amcc.com>
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

The is a software workaround that uses 
Initial version of the software workaround was posted to linux-usb-devel:

http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg54019.html

and later available from amcc.com:
http://www.amcc.com/Embedded/Downloads/download.html?cat=1&family=15&ins=2

The patch below is generally based on the latter, but reworked to
powerpc/of_device USB drivers, and uses a few devicetree inquiries to get
rid of all the hardcoded defines and CONFIG_* stuff, in favor to
defining specific quirk. The latter required to add more accurate
description into compatible field of USB node for 'sequioia' board. 

Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
Signed-off-by: Stefan Roese <sr@denx.de>
---

 arch/powerpc/boot/dts/sequoia.dts |    2 +-
 drivers/usb/host/ehci-hub.c       |   10 +++++++-
 drivers/usb/host/ehci-ppc-of.c    |   48 +++++++++++++++++++++++++++++++++++--
 drivers/usb/host/ehci.h           |   24 +++++++++++++++++++
 drivers/usb/host/ohci-ppc-of.c    |   27 ++++++++++++++++++++-
 5 files changed, 106 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequoia.dts
index 53d322f..45a43a6 100644
--- a/arch/powerpc/boot/dts/sequoia.dts
+++ b/arch/powerpc/boot/dts/sequoia.dts
@@ -132,7 +132,7 @@
 		};
 
 		USB1: usb@e0000400 {
-			compatible = "ohci-be";
+			compatible = "ibm,usb-ohci-440epx", "ohci-be";
 			reg = <0 e0000400 60>;
 			interrupt-parent = <&UIC0>;
 			interrupts = <15 8>;
diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index 740835b..290b34d 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -396,6 +396,7 @@ static inline void remove_companion_file(struct ehci_hcd *ehci)
 
 /*-------------------------------------------------------------------------*/
 
+
 static int check_reset_complete (
 	struct ehci_hcd	*ehci,
 	int		index,
@@ -424,8 +425,15 @@ static int check_reset_complete (
 		port_status &= ~PORT_RWC_BITS;
 		ehci_writel(ehci, port_status, status_reg);
 
-	} else
+		/* ensure 440EPX ohci controller state is operational */
+		if (ehci->has_amcc_usb23)
+			set_ohci_hcfs(ehci, 1);
+	} else {
 		ehci_dbg (ehci, "port %d high speed\n", index + 1);
+		/* ensure 440EPx ohci controller state is suspended */
+		if (ehci->has_amcc_usb23)
+			set_ohci_hcfs(ehci, 0);
+	}
 
 	return port_status;
 }
diff --git a/drivers/usb/host/ehci-ppc-of.c b/drivers/usb/host/ehci-ppc-of.c
index b018dee..c3b265d 100644
--- a/drivers/usb/host/ehci-ppc-of.c
+++ b/drivers/usb/host/ehci-ppc-of.c
@@ -107,16 +107,17 @@ ehci_hcd_ppc_of_probe(struct of_device *op, const struct of_device_id *match)
 {
 	struct device_node *dn = op->node;
 	struct usb_hcd *hcd;
-	struct ehci_hcd	*ehci;
+	struct ehci_hcd	*ehci = NULL;
 	struct resource res;
 	int irq;
 	int rv;
 
+	struct device_node *np;
+
 	if (usb_disabled())
 		return -ENODEV;
 
 	dev_dbg(&op->dev, "initializing PPC-OF USB Controller\n");
-
 	rv = of_address_to_resource(dn, 0, &res);
 	if (rv)
 		return rv;
@@ -125,6 +126,7 @@ ehci_hcd_ppc_of_probe(struct of_device *op, const struct of_device_id *match)
 	if (!hcd)
 		return -ENOMEM;
 
+
 	hcd->rsrc_start = res.start;
 	hcd->rsrc_len = res.end - res.start + 1;
 
@@ -172,6 +174,21 @@ ehci_hcd_ppc_of_probe(struct of_device *op, const struct of_device_id *match)
 				rv ? "NOT ": "");
 	}
 
+	np = of_find_compatible_node(NULL, NULL, "ibm,usb-ohci-440epx");
+	if (np != NULL) {
+	/* claim we really affected by usb23 erratum */
+		ehci->has_amcc_usb23 = 1;
+		if (!of_address_to_resource(np, 0, &res))
+			ehci->ohci_hcctrl_reg = ioremap(res.start +
+					OHCI_HCCTRL_OFFSET, OHCI_HCCTRL_LEN);
+		else
+			pr_debug(__FILE__ ": no ohci offset in fdt\n");
+		if (!ehci->ohci_hcctrl_reg) {
+			pr_debug(__FILE__ ": ioremap for ohci hcctrl failed\n");
+			return -ENOMEM;
+		}
+	}
+
 	rv = usb_add_hcd(hcd, irq, 0);
 	if (rv == 0)
 		return 0;
@@ -182,6 +199,9 @@ err_ioremap:
 err_irq:
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 err_rmr:
+
+	if (ehci->has_amcc_usb23)
+		iounmap(ehci->ohci_hcctrl_reg);
 	usb_put_hcd(hcd);
 
 	return rv;
@@ -191,6 +211,11 @@ err_rmr:
 static int ehci_hcd_ppc_of_remove(struct of_device *op)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(&op->dev);
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+
+	struct device_node *np;
+	struct resource res;
+
 	dev_set_drvdata(&op->dev, NULL);
 
 	dev_dbg(&op->dev, "stopping PPC-OF USB Controller\n");
@@ -201,6 +226,25 @@ static int ehci_hcd_ppc_of_remove(struct of_device *op)
 	irq_dispose_mapping(hcd->irq);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 
+	/* use request_mem_region to test if the ohci driver is loaded.  if so
+	 * ensure the ohci core is operational.
+	 */
+	if (ehci->has_amcc_usb23) {
+		np = of_find_compatible_node(NULL, NULL, "ibm,usb-ohci-440epx");
+		if (np != NULL) {
+			if (!of_address_to_resource(np, 0, &res))
+				if (!request_mem_region(res.start,
+							    0x4, hcd_name))
+					set_ohci_hcfs(ehci, 1);
+				else
+					release_mem_region(res.start, 0x4);
+			else
+				pr_debug(__FILE__ ": no ohci offset in fdt\n");
+			of_node_put(np);
+		}
+
+		iounmap(ehci->ohci_hcctrl_reg);
+	}
 	usb_put_hcd(hcd);
 
 	return 0;
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 69ebb09..a4426d1 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -118,6 +118,16 @@ struct ehci_hcd {			/* one per controller */
 	unsigned		has_fsl_port_bug:1; /* FreeScale */
 	unsigned		big_endian_mmio:1;
 	unsigned		big_endian_desc:1;
+	unsigned		has_amcc_usb23:1;
+
+	/* required for usb32 quirk */
+	#define OHCI_CTRL_HCFS          (3 << 6)
+	#define OHCI_USB_OPER           (2 << 6)
+	#define OHCI_USB_SUSPEND        (3 << 6)
+
+	#define OHCI_HCCTRL_OFFSET      0x4
+	#define OHCI_HCCTRL_LEN         0x4
+	__hc32			*ohci_hcctrl_reg;
 
 	u8			sbrn;		/* packed release number */
 
@@ -809,6 +819,20 @@ static inline u32 hc32_to_cpup (const struct ehci_hcd *ehci, const __hc32 *x)
 		le32_to_cpup((__force __le32 *)x);
 }
 
+static inline void set_ohci_hcfs(struct ehci_hcd *ehci, int operational)
+{
+	u32 hc_control;
+
+	hc_control = (readl_be(ehci->ohci_hcctrl_reg) & ~OHCI_CTRL_HCFS);
+	if (operational)
+		hc_control |= OHCI_USB_OPER;
+	else
+		hc_control |= OHCI_USB_SUSPEND;
+
+	writel_be(hc_control, ehci->ohci_hcctrl_reg);
+	(void) readl_be(ehci->ohci_hcctrl_reg);
+}
+
 /*-------------------------------------------------------------------------*/
 
 #ifndef DEBUG
diff --git a/drivers/usb/host/ohci-ppc-of.c b/drivers/usb/host/ohci-ppc-of.c
index a672527..72c49bf 100644
--- a/drivers/usb/host/ohci-ppc-of.c
+++ b/drivers/usb/host/ohci-ppc-of.c
@@ -80,7 +80,6 @@ static const struct hc_driver ohci_ppc_of_hc_driver = {
 	.start_port_reset =	ohci_start_port_reset,
 };
 
-
 static int __devinit
 ohci_hcd_ppc_of_probe(struct of_device *op, const struct of_device_id *match)
 {
@@ -92,6 +91,7 @@ ohci_hcd_ppc_of_probe(struct of_device *op, const struct of_device_id *match)
 
 	int rv;
 	int is_bigendian;
+	struct device_node *np;
 
 	if (usb_disabled())
 		return -ENODEV;
@@ -148,6 +148,31 @@ ohci_hcd_ppc_of_probe(struct of_device *op, const struct of_device_id *match)
 	if (rv == 0)
 		return 0;
 
+	/* by now, 440epx is known to show usb_23 erratum */
+	np = of_find_compatible_node(NULL, NULL, "ibm,usb-ehci-440epx");
+
+	/* Work around - At this point ohci_run has executed, the
+	* controller is running, everything, the root ports, etc., is
+	* set up.  If the ehci driver is loaded, put the ohci core in
+	* the suspended state.  The ehci driver will bring it out of
+	* suspended state when / if a non-high speed USB device is
+	* attached to the USB Host port.  If the ehci driver is not
+	* loaded, do nothing. request_mem_region is used to test if
+	* the ehci driver is loaded.
+	*/
+	if (np !=  NULL) {
+		ohci->flags |= OHCI_QUIRK_AMCC_USB23;
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
+	}
 	iounmap(hcd->regs);
 err_ioremap:
 	irq_dispose_mapping(irq);
