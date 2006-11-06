Return-Path: <nd@bplan-gmbh.de>
Date: Mon, 6 Nov 2006 11:35:55 +0100 (MET)
Message-Id: <200611061035.kA6AZtGZ018329@post.webmailer.de>
To: linuxppc-dev@ozlabs.org
From: "Nicolas DET"<nd@bplan-gmbh.de>
Subject: [PATCH] powerpc: Add of_platform support for OHCI/Bigendian HC
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "akpm@osdl.org" <akpm@osdl.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch use of_platform device to probe and install OHCI big endian HC.

PS: I did not success to properly inline the file using thrunderbird.

Signed-off-by: Nicolas DET <nd@bplan-gmbh.de>=20
---
--- a/drivers/usb/host/ohci-ppc-of.c=091970-01-01 01:00:00.000000000 +0100
+++ b/drivers/usb/host/ohci-ppc-of.c=092006-11-06 11:10:29.000000000 +0100
@@ -0,0 +1,283 @@
+/*
+ * OHCI HCD (Host Controller Driver) for USB.
+ *
+ * (C) Copyright 1999 Roman Weissgaerber <weissg@vienna.at>
+ * (C) Copyright 2000-2002 David Brownell <dbrownell@users.sourceforge.net=
>
+ * (C) Copyright 2002 Hewlett-Packard Company
+ * (C) Copyright 2003-2005 MontaVista Software Inc.
+ *=20
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
+=09=09=09  struct of_device *dev, int is_bigendian)
+{
+=09int retval;
+=09struct usb_hcd *hcd;
+=09struct ohci_hcd=09*ohci;
+=09struct resource res;
+=09int irq;
+=09int ret;
+
+=09pr_debug("initializing PPC-OF USB Controllern");
+
+=09if ((ret =3D of_address_to_resource(dev->node, 0, &res)) !=3D 0)
+=09=09return ret;
+
+=09hcd =3D usb_create_hcd(driver, &dev->dev, "PPC-OF USB");
+=09if (!hcd)
+=09=09return -ENOMEM;
+
+=09hcd->rsrc_start =3D res.start;
+=09hcd->rsrc_len =3D res.end - res.start + 1;
+
+=09if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
+=09=09pr_debug(__FILE__ ": request_mem_region failedn");
+=09=09retval =3D -EBUSY;
+=09=09goto err1;
+=09}
+
+=09irq =3D irq_of_parse_and_map(dev->node, 0);
+=09if (irq =3D=3D NO_IRQ) {
+=09=09retval =3D -EBUSY;
+=09=09goto err2;
+=09}
+
+=09hcd->regs =3D ioremap(hcd->rsrc_start, hcd->rsrc_len);
+=09if (!hcd->regs) {
+=09=09pr_debug(__FILE__ ": ioremap failedn");
+=09=09retval =3D -ENOMEM;
+=09=09goto err2;
+=09}
+
+=09ohci =3D hcd_to_ohci(hcd);
+=09if (is_bigendian)
+=09=09ohci->flags |=3D OHCI_BIG_ENDIAN;
+
+=09ohci_hcd_init(ohci);
+
+=09retval =3D usb_add_hcd(hcd, irq, 0);
+=09if (retval =3D=3D 0)
+=09=09return retval;
+
+=09pr_debug("Removing PPC-OF USB Controllern");
+
+=09iounmap(hcd->regs);
+ err2:
+=09release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+ err1:
+ =09usb_put_hcd(hcd);
+=09return retval;
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
+=09=09struct of_device *op)
+{
+=09usb_remove_hcd(hcd);
+
+=09pr_debug("stopping PPC-OF USB Controllern");
+
+=09iounmap(hcd->regs);
+=09release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+=09usb_put_hcd(hcd);
+}
+
+static int __devinit
+ohci_ppc_of_start(struct usb_hcd *hcd)
+{
+=09struct ohci_hcd=09*ohci =3D hcd_to_ohci(hcd);
+=09int=09=09ret;
+
+=09if ((ret =3D ohci_init(ohci)) < 0)
+=09=09return ret;
+
+=09if ((ret =3D ohci_run(ohci)) < 0) {
+=09=09err("can't start %s", ohci_to_hcd(ohci)->self.bus_name);
+=09=09ohci_stop(hcd);
+=09=09return ret;
+=09}
+
+=09return 0;
+}
+
+static const struct hc_driver ohci_ppc_of_hc_driver =3D {
+=09.description =3D=09=09hcd_name,
+=09.hcd_priv_size =3D=09sizeof(struct ohci_hcd),
+
+=09/*
+=09 * generic hardware linkage
+=09 */
+=09.irq =3D=09=09=09ohci_irq,
+=09.flags =3D=09=09HCD_USB11 | HCD_MEMORY,
+
+=09/*
+=09 * basic lifecycle operations
+=09 */
+=09.start =3D=09=09ohci_ppc_of_start,
+=09.stop =3D=09=09=09ohci_stop,
+=09.shutdown =3D =09=09ohci_shutdown,
+
+=09/*
+=09 * managing i/o requests and associated device resources
+=09 */
+=09.urb_enqueue =3D=09=09ohci_urb_enqueue,
+=09.urb_dequeue =3D=09=09ohci_urb_dequeue,
+=09.endpoint_disable =3D=09ohci_endpoint_disable,
+
+=09/*
+=09 * scheduling support
+=09 */
+=09.get_frame_number =3D=09ohci_get_frame,
+
+=09/*
+=09 * root hub support
+=09 */
+=09.hub_status_data =3D=09ohci_hub_status_data,
+=09.hub_control =3D=09=09ohci_hub_control,
+=09.hub_irq_enable =3D=09ohci_rhsc_enable,
+#ifdef=09CONFIG_PM
+=09.bus_suspend =3D=09=09ohci_bus_suspend,
+=09.bus_resume =3D=09=09ohci_bus_resume,
+#endif
+=09.start_port_reset =3D=09ohci_start_port_reset,
+};
+
+
+
+static int ohci_hcd_ppc_of_drv_remove(struct of_device *op)
+{
+=09struct usb_hcd *hcd =3D dev_get_drvdata(&op->dev);
+=09dev_set_drvdata(&op->dev, NULL);
+
+=09usb_hcd_ppc_of_remove(hcd, op);
+=09return 0;
+}
+
+static int ohci_hcd_ppc_of_drv_shutdown(struct of_device *op)
+{
+=09struct usb_hcd *hcd =3D dev_get_drvdata(&op->dev);
+
+        if (hcd->driver->shutdown)
+                hcd->driver->shutdown(hcd);
+
+=09return 0;
+}
+
+/*
+ *
+*/
+
+static struct of_device_id ohci_hcd_ppc_of_match[] =3D {
+#ifdef CONFIG_USB_OHCI_HCD_PPC_OF_BE
+=09{
+=09=09.name =3D "usb",
+=09=09.compatible =3D "ohci-bigendian",
+=09},
+=09{
+=09=09.name =3D "usb",
+=09=09.compatible =3D "ohci-be",
+=09},
+#endif
+#ifdef CONFIG_USB_OHCI_HCD_PPC_OF_LE
+=09{
+=09=09.name =3D "usb",
+=09=09.compatible =3D "ohci-littledian",
+=09},
+=09{
+=09=09.name =3D "usb",
+=09=09.compatible =3D "ohci-le",
+=09},
+#endif
+=09{},
+};
+
+static int __devinit
+ohci_hcd_ppc_of_drv_probe(struct of_device *op, const struct of_device_id =
*match)
+{
+=09struct device_node *dev;
+=09int ret;
+=09int is_bigendian;
+
+=09if (usb_disabled())
+=09=09return -ENODEV;
+
+=09dev =3D op->node;
+=09is_bigendian =3D 0;
+
+=09if ( device_is_compatible(dev, "ohci-bigendian") )
+=09=09is_bigendian =3D 1;
+
+=09if ( device_is_compatible(dev, "ohci-be") )
+=09=09is_bigendian =3D 1;=09
+
+=09ret =3D usb_hcd_ppc_of_probe(&ohci_ppc_of_hc_driver, op, is_bigendian);
+=09return ret;
+}
+
+static struct of_platform_driver ohci_hcd_ppc_of_driver =3D {
+=09.name=09=3D "ppc-of-ohci",
+=09.match_table=09=3D ohci_hcd_ppc_of_match,
+=09.probe=09=09=3D ohci_hcd_ppc_of_drv_probe,
+=09.remove=09=09=3D ohci_hcd_ppc_of_drv_remove,
+=09.shutdown =09=3D ohci_hcd_ppc_of_drv_shutdown,
+#ifdef=09CONFIG_PM
+=09/*.suspend=09=3D ohci_hcd_ppc_soc_drv_suspend,*/
+=09/*.resume=09=3D ohci_hcd_ppc_soc_drv_resume,*/
+#endif
+=09.driver=09=09=3D {
+=09=09.name=09=3D "ppc-of-ohci",
+=09=09.owner=09=3D THIS_MODULE,
+=09},
+};
+
+static int __init ohci_hcd_ppc_of_init(void)
+{
+=09pr_debug(DRIVER_INFO " (PPC OF)n");
+=09pr_debug("block sizes: ed %d td %dn", sizeof(struct ed),
+=09=09=09=09=09=09=09sizeof(struct td));
+=09
+=09return of_register_driver(&ohci_hcd_ppc_of_driver);   =20
+}
+
+static void __exit ohci_hcd_ppc_of_cleanup(void)
+{
+=09of_unregister_driver(&ohci_hcd_ppc_of_driver);
+}
+
+module_init(ohci_hcd_ppc_of_init);
+module_exit(ohci_hcd_ppc_of_cleanup);
--- a/drivers/usb/host/Kconfig=092006-11-01 09:18:56.000000000 +0100
+++ b/drivers/usb/host/Kconfig=092006-11-06 11:10:29.000000000 +0100
@@ -106,6 +106,25 @@ config USB_OHCI_HCD_PPC_SOC
 =09  Enables support for the USB controller on the MPC52xx or
 =09  STB03xxx processor chip.  If unsure, say Y.
=20
+config USB_OHCI_HCD_PPC_OF
+=09bool "OHCI support for PPC USB controller for OpenFirmware platform"
+=09depends on USB_OHCI_HCD && PPC_OF
+=09default y
+=09---help---
+=09  Enables support for the USB controller PowerPC OpenFirmware platform
+
+config USB_OHCI_HCD_PPC_OF_BE
+=09bool "Support big endian HC"
+=09depends on USB_OHCI_HCD_PPC_OF
+=09default y
+=09select USB_OHCI_BIG_ENDIAN
+
+config USB_OHCI_HCD_PPC_OF_LE
+=09bool "Support little endian HC"
+=09depends on USB_OHCI_HCD_PPC_OF
+=09default n
+=09select USB_OHCI_LITTLE_ENDIAN
+
 config USB_OHCI_HCD_PCI
 =09bool "OHCI support for PCI-bus USB controllers"
 =09depends on USB_OHCI_HCD && PCI && (STB03xxx || PPC_MPC52xx)
--- a/drivers/usb/host/ohci-hcd.c=092006-11-01 09:18:56.000000000 +0100
+++ b/drivers/usb/host/ohci-hcd.c=092006-11-06 11:10:29.000000000 +0100
@@ -930,6 +930,10 @@ MODULE_LICENSE ("GPL");
 #include "ohci-ppc-soc.c"
 #endif
=20
+#ifdef CONFIG_USB_OHCI_HCD_PPC_OF
+#include "ohci-ppc-of.c"
+#endif
+
 #if defined(CONFIG_ARCH_AT91RM9200) || defined(CONFIG_ARCH_AT91SAM9261)
 #include "ohci-at91.c"
 #endif
@@ -950,6 +954,8 @@ MODULE_LICENSE ("GPL");
       || defined (CONFIG_ARCH_AT91RM9200)=20
       || defined (CONFIG_ARCH_AT91SAM9261)=20
       || defined (CONFIG_ARCH_PNX4008)=20
+      || defined (CONFIG_USB_OHCI_HCD_PPC_OF_LE)=20
+      || defined (CONFIG_USB_OHCI_HCD_PPC_OF_BE)=20
 =09)
 #error "missing bus glue for ohci-hcd"
 #endif
