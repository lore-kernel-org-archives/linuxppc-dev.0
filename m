Return-Path: <nd@bplan-gmbh.de>
Date: Thu, 2 Nov 2006 21:49:48 +0100 (MET)
Message-ID: <454A59CC.6070902@bplan-gmbh.de>
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Add of_platform support for	OHCI/Bigendian HC
References: <45490407.1010700@bplan-gmbh.de>	
	<1162419799.25682.466.camel@localhost.localdomain>
	<1162423628.25682.489.camel@localhost.localdomain>
In-Reply-To: <1162423628.25682.489.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------060602060408000809050805"
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060602060408000809050805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
> On Thu, 2006-11-02 at 09:23 +1100, Benjamin Herrenschmidt wrote:
> 
> And in english here too....
> 
>> On Wed, 2006-11-01 at 21:31 +0100, Nicolas DET wrote:
>>
>>> +/**+	ohci = hcd_to_ohci(hcd);
>>> +	ohci->flags |= OHCI_BIG_ENDIAN;
>>> +	ohci_hcd_init(ohci);
>> Bon, c'est pas mal. Le seul truc ici, c'est que je prefererais que
>> big-endian ne soit pas hard-code comme ca mais depende du device-tree.
>> Ce code doit pouvoir etre re-utilise pour des implementations
>> little-endian.
> 
> Ok, so it looks good. The only thing here is that I would prefer if the
> big-endian setting wasn't hard-coded, but set based on the device-tree,
> so that this code can be re-used for little-endian implementations.
> 
>>> +	retval = usb_add_hcd(hcd, irq, IRQF_DISABLED);
>>> +	if (retval == 0)
>>> +		return retval;
>> Pourquoi IRQF_DISABLED ?
> 
> Why IRQF_DISABLED ?
> 

It's like this in ofsoc-ppc. As I am not sure what it does exactly I 
left it like this. This module performs well here so far.



--------------060602060408000809050805
Content-Type: text/plain;
 name="archpowerpc_ohciof.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="archpowerpc_ohciof.patch"

--- a/drivers/usb/host/ohci-ppc-of.c	1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/usb/host/ohci-ppc-of.c	2006-11-02 18:06:02.000000000 +0100
@@ -0,0 +1,322 @@
+/*
+ * OHCI HCD (Host Controller Driver) for USB.
+ *
+ * (C) Copyright 1999 Roman Weissgaerber <weissg@vienna.at>
+ * (C) Copyright 2000-2002 David Brownell <dbrownell@users.sourceforge.net>
+ * (C) Copyright 2002 Hewlett-Packard Company
+ * (C) Copyright 2003-2005 MontaVista Software Inc.
+ * 
+ * Probe and init OHCI Big endian HC from OpenFirmware device tree
+ * Tested on Efika 5k2
+ *
+ * Modified by Dale Farnsworth <dale@farnsworth.org> from ohci-sa1111.c
+ *
+ * This file is licenced under the GPL.
+ */
+
+#include <linux/signal.h>
+
+#include <asm/of_device.h>
+#include <asm/prom.h>
+
+/* configure so an HC device and id are always provided */
+/* always called with process context; sleeping is OK */
+
+/*
+ * usb_hcd_ppc_of_probe - initialize On-Chip HCDs
+ * Context: !in_interrupt()
+ *
+ * Allocates basic resources for this USB host controller.
+ *
+ * Store this function in the HCD's struct pci_driver as probe().
+ */
+static int usb_hcd_ppc_of_probe(const struct hc_driver *driver,
+			  struct of_device *dev, int is_bigendian)
+{
+	int retval;
+	struct usb_hcd *hcd;
+	struct ohci_hcd	*ohci;
+	struct resource res;
+	int irq;
+	int ret;
+
+	pr_debug("initializing PPC-OF USB Controller\n");
+
+	if ((ret = of_address_to_resource(dev->node, 0, &res)) != 0)
+		return ret;
+
+	hcd = usb_create_hcd(driver, &dev->dev, "PPC-OF USB");
+	if (!hcd)
+		return -ENOMEM;
+	hcd->rsrc_start = res.start;
+	hcd->rsrc_len = res.end - res.start + 1;
+
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
+		pr_debug(__FILE__ ": request_mem_region failed\n");
+		retval = -EBUSY;
+		goto err1;
+	}
+
+	irq = irq_of_parse_and_map(dev->node, 0);
+	if (irq == NO_IRQ) {
+		retval = -EBUSY;
+		goto err2;
+	}
+
+	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		pr_debug(__FILE__ ": ioremap failed\n");
+		retval = -ENOMEM;
+		goto err2;
+	}
+
+	ohci = hcd_to_ohci(hcd);
+	if (is_bigendian)
+		ohci->flags |= OHCI_BIG_ENDIAN;
+	ohci_hcd_init(ohci);
+
+	retval = usb_add_hcd(hcd, irq, IRQF_DISABLED);
+	if (retval == 0)
+		return retval;
+
+	pr_debug("Removing PPC-OF USB Controller\n");
+
+	iounmap(hcd->regs);
+ err2:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+ err1:
+ 	usb_put_hcd(hcd);
+	return retval;
+}
+
+
+/* may be called without controller electrically present */
+/* may be called with controller, bus, and devices active */
+
+/*
+ * usb_hcd_ppc_of_remove - shutdown processing for On-Chip HCDs
+ * @pdev: USB Host Controller being removed
+ * Context: !in_interrupt()
+ *
+ * Reverses the effect of usb_hcd_ppc_of_probe().
+ * It is always called from a thread
+ * context, normally "rmmod", "apmd", or something similar.
+ *
+ */
+static void usb_hcd_ppc_of_remove(struct usb_hcd *hcd,
+		struct of_device *op)
+{
+	usb_remove_hcd(hcd);
+
+	pr_debug("stopping PPC-OF USB Controller\n");
+
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+}
+
+static int __devinit
+ohci_ppc_of_start(struct usb_hcd *hcd)
+{
+	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
+	int		ret;
+
+	if ((ret = ohci_init(ohci)) < 0)
+		return ret;
+
+	if ((ret = ohci_run(ohci)) < 0) {
+		err("can't start %s", ohci_to_hcd(ohci)->self.bus_name);
+		ohci_stop(hcd);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct hc_driver ohci_ppc_of_hc_driver = {
+	.description =		hcd_name,
+	.hcd_priv_size =	sizeof(struct ohci_hcd),
+
+	/*
+	 * generic hardware linkage
+	 */
+	.irq =			ohci_irq,
+	.flags =		HCD_USB11 | HCD_MEMORY,
+
+	/*
+	 * basic lifecycle operations
+	 */
+	.start =		ohci_ppc_of_start,
+	.stop =			ohci_stop,
+	.shutdown = 		ohci_shutdown,
+
+	/*
+	 * managing i/o requests and associated device resources
+	 */
+	.urb_enqueue =		ohci_urb_enqueue,
+	.urb_dequeue =		ohci_urb_dequeue,
+	.endpoint_disable =	ohci_endpoint_disable,
+
+	/*
+	 * scheduling support
+	 */
+	.get_frame_number =	ohci_get_frame,
+
+	/*
+	 * root hub support
+	 */
+	.hub_status_data =	ohci_hub_status_data,
+	.hub_control =		ohci_hub_control,
+	.hub_irq_enable =	ohci_rhsc_enable,
+#ifdef	CONFIG_PM
+	.bus_suspend =		ohci_bus_suspend,
+	.bus_resume =		ohci_bus_resume,
+#endif
+	.start_port_reset =	ohci_start_port_reset,
+};
+
+
+
+static int ohci_hcd_ppc_of_drv_remove(struct of_device *op)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(&op->dev);
+	dev_set_drvdata(&op->dev, NULL);
+
+	usb_hcd_ppc_of_remove(hcd, op);
+	return 0;
+}
+
+static int ohci_hcd_ppc_of_drv_shutdown(struct of_device *op)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(&op->dev);
+
+        if (hcd->driver->shutdown)
+                hcd->driver->shutdown(hcd);
+
+	return 0;
+}
+
+/*
+ *
+*/
+
+static struct of_device_id ohci_hcd_ppc_of_match_be[] = {
+	{
+		.name = "usb",
+		.compatible = "ohci-bigendian",
+	},
+	{
+		.name = "usb",
+		.compatible = "ohci-be",
+	},
+	{},
+};
+
+static int __devinit
+ohci_hcd_ppc_of_drv_probe_be(struct of_device *op, const struct of_device_id *match)
+{
+	int ret;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	ret = usb_hcd_ppc_of_probe(&ohci_ppc_of_hc_driver, op, 1);
+	return ret;
+}
+
+static struct of_platform_driver ohci_hcd_ppc_of_driver_be = {
+	.name	= "ppc-of-ohci-be",
+	.match_table	= ohci_hcd_ppc_of_match_be,
+	.probe		= ohci_hcd_ppc_of_drv_probe_be,
+	.remove		= ohci_hcd_ppc_of_drv_remove,
+	.shutdown 	= ohci_hcd_ppc_of_drv_shutdown,
+#ifdef	CONFIG_PM
+	/*.suspend	= ohci_hcd_ppc_soc_drv_suspend,*/
+	/*.resume	= ohci_hcd_ppc_soc_drv_resume,*/
+#endif
+	.driver		= {
+		.name	= "ppc-of-ohci-be",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init ohci_hcd_ppc_of_init_be(void)
+{
+	pr_debug(DRIVER_INFO " (PPC OF)\n");
+	pr_debug("block sizes: ed %d td %d\n", sizeof(struct ed),
+							sizeof(struct td));
+	
+	return of_register_driver(&ohci_hcd_ppc_of_driver_be);    
+}
+
+static void __exit ohci_hcd_ppc_of_cleanup_be(void)
+{
+	of_unregister_driver(&ohci_hcd_ppc_of_driver_be);
+}
+
+module_init(ohci_hcd_ppc_of_init_be);
+module_exit(ohci_hcd_ppc_of_cleanup_be);
+
+/*
+ *
+*/
+
+static struct of_device_id ohci_hcd_ppc_of_match_le[] = {
+	{
+		.name = "usb",
+		.compatible = "ohci-littledian",
+	},
+	{
+		.name = "usb",
+		.compatible = "ohci-le",
+	},
+	{},
+};
+
+static int __devinit
+ohci_hcd_ppc_of_drv_probe_le(struct of_device *op, const struct of_device_id *match)
+{
+	int ret;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	ret = usb_hcd_ppc_of_probe(&ohci_ppc_of_hc_driver, op, 0);
+	return ret;
+}
+
+
+static struct of_platform_driver ohci_hcd_ppc_of_driver_le = {
+	.name	= "ppc-of-ohci-le",
+	.match_table	= ohci_hcd_ppc_of_match_le,
+	.probe		= ohci_hcd_ppc_of_drv_probe_le,
+	.remove		= ohci_hcd_ppc_of_drv_remove,
+	.shutdown 	= ohci_hcd_ppc_of_drv_shutdown,
+#ifdef	CONFIG_PM
+	/*.suspend	= ohci_hcd_ppc_soc_drv_suspend,*/
+	/*.resume	= ohci_hcd_ppc_soc_drv_resume,*/
+#endif
+	.driver		= {
+		.name	= "ppc-of-ohci-le",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init ohci_hcd_ppc_of_init_le(void)
+{
+	pr_debug(DRIVER_INFO " (PPC OF)\n");
+	pr_debug("block sizes: ed %d td %d\n", sizeof(struct ed),
+							sizeof(struct td));
+	
+	return of_register_driver(&ohci_hcd_ppc_of_driver_le);    
+}
+
+static void __exit ohci_hcd_ppc_of_cleanup_le(void)
+{
+	of_unregister_driver(&ohci_hcd_ppc_of_driver_le);
+}
+
+
+module_init(ohci_hcd_ppc_of_init_le);
+module_exit(ohci_hcd_ppc_of_cleanup_le);
+
--- a/drivers/usb/host/Kconfig	2006-11-01 09:18:56.000000000 +0100
+++ b/drivers/usb/host/Kconfig	2006-11-02 17:54:37.000000000 +0100
@@ -106,6 +106,15 @@ config USB_OHCI_HCD_PPC_SOC
 	  Enables support for the USB controller on the MPC52xx or
 	  STB03xxx processor chip.  If unsure, say Y.
 
+config USB_OHCI_HCD_PPC_OF
+	bool "OHCI support for PPC USB controller for OpenFirmware platform"
+	depends on USB_OHCI_HCD && PPC_OF
+	default y
+	select USB_OHCI_BIG_ENDIAN
+	select USB_OHCI_LITTLE_ENDIAN
+	---help---
+	  Enables support for the USB controller PowerPC OpenFirmware platform
+
 config USB_OHCI_HCD_PCI
 	bool "OHCI support for PCI-bus USB controllers"
 	depends on USB_OHCI_HCD && PCI && (STB03xxx || PPC_MPC52xx)
--- a/drivers/usb/host/ohci-hcd.c	2006-11-01 09:18:56.000000000 +0100
+++ b/drivers/usb/host/ohci-hcd.c	2006-11-02 18:06:02.000000000 +0100
@@ -930,6 +930,12 @@ MODULE_LICENSE ("GPL");
 #include "ohci-ppc-soc.c"
 #endif
 
+#ifdef CONFIG_USB_OHCI_HCD_PPC_OF
+#include "ohci-ppc-of.c"
+#endif
+
+
+
 #if defined(CONFIG_ARCH_AT91RM9200) || defined(CONFIG_ARCH_AT91SAM9261)
 #include "ohci-at91.c"
 #endif

--------------060602060408000809050805
Content-Type: text/x-vcard; charset=utf-8;
 name="nd.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nd.vcf"

begin:vcard
fn:Nicolas DET ( bplan GmbH )
n:DET;Nicolas
org:bplan GmbH
adr:;;;;;;Germany
email;internet:nd@bplan-gmbh.de
title:Software Entwicklung
tel;work:+49 6171 9187 - 31
x-mozilla-html:FALSE
url:http://www.bplan-gmbh.de
version:2.1
end:vcard


--------------060602060408000809050805--
