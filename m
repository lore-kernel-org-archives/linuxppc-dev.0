Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 877D3DDE43
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 04:19:31 +1000 (EST)
Date: Mon, 17 Sep 2007 22:18:15 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] usb: add device-tree-aware ehci driver
Message-ID: <20070917181815.GA1773@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917232809.1221acd9.sfr@canb.auug.org.au>
Cc: linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds ehci-ppc-of driver. The code is based on the
ehci-ppc-soc driver by Stefan Roese <sr@denx.de>.

Signed-off-by: Stefan Roese <sr@denx.de>
Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 drivers/usb/host/Kconfig       |    8 +
 drivers/usb/host/ehci-hcd.c    |   16 ++
 drivers/usb/host/ehci-ppc-of.c |  220 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/ehci.h        |    2 
 4 files changed, 244 insertions(+), 2 deletions(-)

diff -ruN linux-2.6.orig/drivers/usb/host/ehci.h linux-2.6/drivers/usb/host/ehci.h
--- linux-2.6.orig/drivers/usb/host/ehci.h	2007-09-15 14:28:42.000000000 +0400
+++ linux-2.6/drivers/usb/host/ehci.h	2007-09-15 15:12:04.000000000 +0400
@@ -725,7 +725,7 @@
  * definition below can die once the 4xx support is
  * finally ported over.
  */
-#if defined(CONFIG_PPC)
+#if defined(CONFIG_PPC) && !defined(CONFIG_PPC_MERGE)
 #define readl_be(addr)		in_be32((__force unsigned *)addr)
 #define writel_be(val, addr)	out_be32((__force unsigned *)addr, val)
 #endif
diff -ruN linux-2.6.orig/drivers/usb/host/ehci-hcd.c linux-2.6/drivers/usb/host/ehci-hcd.c
--- linux-2.6.orig/drivers/usb/host/ehci-hcd.c	2007-09-15 14:28:42.000000000 +0400
+++ linux-2.6/drivers/usb/host/ehci-hcd.c	2007-09-15 15:12:04.000000000 +0400
@@ -944,11 +944,16 @@
 #define	PS3_SYSTEM_BUS_DRIVER	ps3_ehci_driver
 #endif
 
-#ifdef CONFIG_440EPX
+#if defined(CONFIG_440EPX) && !defined(CONFIG_PPC_MERGE)
 #include "ehci-ppc-soc.c"
 #define	PLATFORM_DRIVER		ehci_ppc_soc_driver
 #endif
 
+#ifdef CONFIG_USB_EHCI_HCD_PPC_OF
+#include "ehci-ppc-of.c"
+#define OF_PLATFORM_DRIVER	ehci_hcd_ppc_of_driver
+#endif
+
 #if !defined(PCI_DRIVER) && !defined(PLATFORM_DRIVER) && \
     !defined(PS3_SYSTEM_BUS_DRIVER)
 #error "missing bus glue for ehci-hcd"
@@ -963,6 +968,12 @@
 		 sizeof(struct ehci_qh), sizeof(struct ehci_qtd),
 		 sizeof(struct ehci_itd), sizeof(struct ehci_sitd));
 
+#ifdef OF_PLATFORM_DRIVER
+	retval = of_register_platform_driver(&OF_PLATFORM_DRIVER);
+	if (retval < 0)
+		return retval;
+#endif
+
 #ifdef PLATFORM_DRIVER
 	retval = platform_driver_register(&PLATFORM_DRIVER);
 	if (retval < 0)
@@ -998,6 +1009,9 @@
 
 static void __exit ehci_hcd_cleanup(void)
 {
+#ifdef OF_PLATFORM_DRIVER
+	of_unregister_platform_driver(&OF_PLATFORM_DRIVER);
+#endif
 #ifdef PLATFORM_DRIVER
 	platform_driver_unregister(&PLATFORM_DRIVER);
 #endif
diff -ruN linux-2.6.orig/drivers/usb/host/ehci-ppc-of.c linux-2.6/drivers/usb/host/ehci-ppc-of.c
--- linux-2.6.orig/drivers/usb/host/ehci-ppc-of.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/usb/host/ehci-ppc-of.c	2007-09-15 16:12:56.000000000 +0400
@@ -0,0 +1,220 @@
+/*
+ * EHCI HCD (Host Controller Driver) for USB.
+ *
+ * Bus Glue for PPC On-Chip EHCI driver on the of_platform bus
+ * Tested on AMCC PPC 440EPx
+ *
+ * Valentine Barshak <vbarshak@ru.mvista.com>
+ *
+ * Based on "ehci-ppc-soc.c" by Stefan Roese <sr@denx.de>
+ * and "ohci-ppc-of.c" by Sylvain Munaut <tnt@246tNt.com>
+ *
+ * This file is licenced under the GPL.
+ */
+
+#include <linux/signal.h>
+
+#include <linux/of.h>
+#include <linux/of_platform.h>
+
+/* called during probe() after chip reset completes */
+static int ehci_ppc_of_setup(struct usb_hcd *hcd)
+{
+	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
+	int		retval;
+
+	retval = ehci_halt(ehci);
+	if (retval)
+		return retval;
+
+	retval = ehci_init(hcd);
+	if (retval)
+		return retval;
+
+	ehci->sbrn = 0x20;
+	return ehci_reset(ehci);
+}
+
+
+static const struct hc_driver ehci_ppc_of_hc_driver = {
+	.description = hcd_name,
+	.product_desc = "OF EHCI",
+	.hcd_priv_size = sizeof(struct ehci_hcd),
+
+	/*
+	 * generic hardware linkage
+	 */
+	.irq = ehci_irq,
+	.flags = HCD_MEMORY | HCD_USB2,
+
+	/*
+	 * basic lifecycle operations
+	 */
+	.reset = ehci_ppc_of_setup,
+	.start = ehci_run,
+	.stop = ehci_stop,
+	.shutdown = ehci_shutdown,
+
+	/*
+	 * managing i/o requests and associated device resources
+	 */
+	.urb_enqueue = ehci_urb_enqueue,
+	.urb_dequeue = ehci_urb_dequeue,
+	.endpoint_disable = ehci_endpoint_disable,
+
+	/*
+	 * scheduling support
+	 */
+	.get_frame_number = ehci_get_frame,
+
+	/*
+	 * root hub support
+	 */
+	.hub_status_data = ehci_hub_status_data,
+	.hub_control = ehci_hub_control,
+#ifdef	CONFIG_PM
+	.hub_suspend = ehci_hub_suspend,
+	.hub_resume = ehci_hub_resume,
+#endif
+};
+
+
+static int __devinit
+ehci_hcd_ppc_of_probe(struct of_device *op, const struct of_device_id *match)
+{
+	struct device_node *dn = op->node;
+	struct usb_hcd *hcd;
+	struct ehci_hcd	*ehci;
+	struct resource res;
+	int irq;
+	int rv;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	dev_dbg(&op->dev, "initializing PPC-OF USB Controller\n");
+
+	rv = of_address_to_resource(dn, 0, &res);
+	if (rv)
+		return rv;
+
+	hcd = usb_create_hcd(&ehci_ppc_of_hc_driver, &op->dev, "PPC-OF USB");
+	if (!hcd)
+		return -ENOMEM;
+
+	hcd->rsrc_start = res.start;
+	hcd->rsrc_len = res.end - res.start + 1;
+
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
+		printk(KERN_ERR __FILE__ ": request_mem_region failed\n");
+		rv = -EBUSY;
+		goto err_rmr;
+	}
+
+	irq = irq_of_parse_and_map(dn, 0);
+	if (irq == NO_IRQ) {
+		printk(KERN_ERR __FILE__ ": irq_of_parse_and_map failed\n");
+		rv = -EBUSY;
+		goto err_irq;
+	}
+
+	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		printk(KERN_ERR __FILE__ ": ioremap failed\n");
+		rv = -ENOMEM;
+		goto err_ioremap;
+	}
+
+	ehci = hcd_to_ehci(hcd);
+	if (of_device_is_compatible(dn, "ehci-be-desc"))
+		ehci->big_endian_desc = 1;
+	if (of_get_property(dn, "big-endian", NULL))
+		ehci->big_endian_mmio = 1;
+
+	ehci->caps = hcd->regs;
+	ehci->regs = hcd->regs + HC_LENGTH(ehci_readl(ehci, &ehci->caps->hc_capbase));
+
+	/* cache this readonly data; minimize chip reads */
+	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
+
+	if (of_device_is_compatible(dn, "ibm,ehci-440epx")) {
+		/*
+		 * 440EPx Errata USBH_3
+		 * Fix: Enable Break Memory Transfer (BMT) in INSNREG3
+		 */
+		out_be32((void *)((ulong)(&ehci->regs->command) + 0x8c), (1 << 0));
+		ehci_dbg(ehci, "Break Memory Transfer (BMT) has beed enabled!\n");
+	}
+
+	rv = usb_add_hcd(hcd, irq, 0);
+	if (rv == 0)
+		return 0;
+
+	iounmap(hcd->regs);
+err_ioremap:
+	irq_dispose_mapping(irq);
+err_irq:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+err_rmr:
+	usb_put_hcd(hcd);
+
+	return rv;
+}
+
+
+static int ehci_hcd_ppc_of_remove(struct of_device *op)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(&op->dev);
+	dev_set_drvdata(&op->dev, NULL);
+
+	dev_dbg(&op->dev, "stopping PPC-OF USB Controller\n");
+
+	usb_remove_hcd(hcd);
+
+	iounmap(hcd->regs);
+	irq_dispose_mapping(hcd->irq);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+
+	usb_put_hcd(hcd);
+
+	return 0;
+}
+
+
+static int ehci_hcd_ppc_of_shutdown(struct of_device *op)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(&op->dev);
+
+	if (hcd->driver->shutdown)
+		hcd->driver->shutdown(hcd);
+
+	return 0;
+}
+
+
+static struct of_device_id ehci_hcd_ppc_of_match[] = {
+	{
+		.type = "usb",
+		.compatible = "ehci",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ehci_hcd_ppc_of_match);
+
+
+static struct of_platform_driver ehci_hcd_ppc_of_driver = {
+	.name		= "ppc-of-ehci",
+	.match_table	= ehci_hcd_ppc_of_match,
+	.probe		= ehci_hcd_ppc_of_probe,
+	.remove		= ehci_hcd_ppc_of_remove,
+	.shutdown 	= ehci_hcd_ppc_of_shutdown,
+#ifdef CONFIG_PM
+	/*.suspend	= ehci_hcd_ppc_of_drv_suspend,*/
+	/*.resume	= ehci_hcd_ppc_of_drv_resume,*/
+#endif
+	.driver		= {
+		.name	= "ppc-of-ehci",
+		.owner	= THIS_MODULE,
+	},
+};
+
diff -ruN linux-2.6.orig/drivers/usb/host/Kconfig linux-2.6/drivers/usb/host/Kconfig
--- linux-2.6.orig/drivers/usb/host/Kconfig	2007-09-15 14:28:42.000000000 +0400
+++ linux-2.6/drivers/usb/host/Kconfig	2007-09-15 15:12:04.000000000 +0400
@@ -84,6 +84,14 @@
 	---help---
 	  Variation of ARC USB block used in some Freescale chips.
 
+config USB_EHCI_HCD_PPC_OF
+	bool "EHCI support for PPC USB controller on OF platform bus"
+	depends on USB_EHCI_HCD && PPC_OF
+	default y
+	---help---
+	  Enables support for the USB controller PowerPC present on the
+	  OpenFirmware platform bus.
+
 config USB_ISP116X_HCD
 	tristate "ISP116X HCD support"
 	depends on USB
