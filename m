Return-Path: <albert_herranz@yahoo.es>
Received: from smtp123.mail.ukl.yahoo.com (smtp123.mail.ukl.yahoo.com
	[77.238.184.54]) by ozlabs.org (Postfix) with SMTP id A2579B7E53
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Mar 2010 06:13:04 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 11/11] wii: hollywood ehci controller support
Date: Fri, 12 Mar 2010 20:12:46 +0100
Message-Id: <1268421166-4791-12-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1268421166-4791-1-git-send-email-albert_herranz@yahoo.es>
References: <1268421166-4791-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for the USB Enhanced Host Controller Interface included
in the "Hollywood" chipset of the Nintendo Wii video game console.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/platforms/embedded6xx/Kconfig |    1 +
 drivers/usb/host/Kconfig                   |    8 +
 drivers/usb/host/ehci-hcd.c                |    5 +
 drivers/usb/host/ehci-hlwd.c               |  233 ++++++++++++++++++++++++++++
 drivers/usb/host/ehci.h                    |   23 +++
 5 files changed, 270 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/host/ehci-hlwd.c

diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index f4fff0a..63bc708 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -121,6 +121,7 @@ config WII
 	select GAMECUBE_COMMON
 	select HAVE_GENERIC_DMA_COHERENT
 	select SWIOTLB
+	select USB_ARCH_HAS_EHCI
 	help
 	  Select WII if configuring for the Nintendo Wii.
 	  More information at: <http://gc-linux.sourceforge.net/>
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 2678a16..342954f 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -131,6 +131,14 @@ config USB_EHCI_HCD_PPC_OF
 	  Enables support for the USB controller present on the PowerPC
 	  OpenFirmware platform bus.
 
+config USB_EHCI_HCD_HLWD
+	bool "Nintendo Wii (Hollywood) EHCI USB controller support"
+	depends on USB_EHCI_HCD && WII
+	default y
+	---help---
+	  Say Y here to support the EHCI USB controller found in the
+	  Hollywood chipset of the Nintendo Wii video game console.
+
 config USB_W90X900_EHCI
 	bool "W90X900(W90P910) EHCI support"
 	depends on USB_EHCI_HCD && ARCH_W90X900
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 1ec3857..395c6a1 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1133,6 +1133,11 @@ MODULE_LICENSE ("GPL");
 #define OF_PLATFORM_DRIVER	ehci_hcd_ppc_of_driver
 #endif
 
+#ifdef CONFIG_USB_EHCI_HCD_HLWD
+#include "ehci-hlwd.c"
+#define OF_PLATFORM_DRIVER	ehci_hcd_hlwd_driver
+#endif
+
 #ifdef CONFIG_XPS_USB_HCD_XILINX
 #include "ehci-xilinx-of.c"
 #define OF_PLATFORM_DRIVER	ehci_hcd_xilinx_of_driver
diff --git a/drivers/usb/host/ehci-hlwd.c b/drivers/usb/host/ehci-hlwd.c
new file mode 100644
index 0000000..129e96b
--- /dev/null
+++ b/drivers/usb/host/ehci-hlwd.c
@@ -0,0 +1,233 @@
+/*
+ * drivers/usb/host/ehci-hlwd.c
+ *
+ * Nintendo Wii (Hollywood) USB Enhanced Host Controller Interface.
+ * Copyright (C) 2009-2010 The GameCube Linux Team
+ * Copyright (C) 2009,2010 Albert Herranz
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * Based on ehci-ppc-of.c
+ *
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
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <asm/wii.h>
+
+#define DRV_MODULE_NAME "ehci-hlwd"
+#define DRV_DESCRIPTION "Nintendo Wii EHCI Host Controller"
+#define DRV_AUTHOR      "Albert Herranz"
+
+/*
+ * Non-standard registers.
+ */
+#define HLWD_EHCI_CTL		0x00cc	/* Controller Control */
+#define HLWD_EHCI_CTL_INTE	(1<<15)	/* Notify EHCI interrupts */
+
+/* called during probe() after chip reset completes */
+static int ehci_hlwd_reset(struct usb_hcd *hcd)
+{
+	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
+	int error;
+
+	dbg_hcs_params(ehci, "reset");
+	dbg_hcc_params(ehci, "reset");
+
+	error = ehci_halt(ehci);
+	if (error)
+		goto out;
+
+	error = ehci_init(hcd);
+	if (error)
+		goto out;
+
+	/* enable notification of EHCI interrupts */
+	setbits32(hcd->regs + HLWD_EHCI_CTL, HLWD_EHCI_CTL_INTE);
+
+	ehci->sbrn = 0x20;
+	error = ehci_reset(ehci);
+	ehci_port_power(ehci, 0);
+out:
+	return error;
+}
+
+static const struct hc_driver ehci_hlwd_hc_driver = {
+	.description		= hcd_name,
+	.product_desc		= "Nintendo Wii EHCI Host Controller",
+	.hcd_priv_size		= sizeof(struct ehci_hcd),
+
+	/*
+	 * generic hardware linkage
+	 */
+	.irq			= ehci_irq,
+	.flags			= HCD_USB2 | HCD_NO_COHERENT_MEM,
+
+	/*
+	 * basic lifecycle operations
+	 */
+	.reset			= ehci_hlwd_reset,
+	.start			= ehci_run,
+	.stop			= ehci_stop,
+	.shutdown		= ehci_shutdown,
+
+	/*
+	 * managing i/o requests and associated device resources
+	 */
+	.urb_enqueue		= ehci_urb_enqueue,
+	.urb_dequeue		= ehci_urb_dequeue,
+	.endpoint_disable	= ehci_endpoint_disable,
+	.endpoint_reset		= ehci_endpoint_reset,
+
+	/*
+	 * scheduling support
+	 */
+	.get_frame_number	= ehci_get_frame,
+
+	/*
+	 * root hub support
+	 */
+	.hub_status_data	= ehci_hub_status_data,
+	.hub_control		= ehci_hub_control,
+#ifdef	CONFIG_PM
+	.bus_suspend		= ehci_bus_suspend,
+	.bus_resume		= ehci_bus_resume,
+#endif
+	.relinquish_port	= ehci_relinquish_port,
+	.port_handed_over	= ehci_port_handed_over,
+
+	.clear_tt_buffer_complete	= ehci_clear_tt_buffer_complete,
+};
+
+static int __devinit
+ehci_hcd_hlwd_probe(struct of_device *op, const struct of_device_id *match)
+{
+	struct device_node *dn = op->node;
+	struct usb_hcd *hcd;
+	struct ehci_hcd	*ehci = NULL;
+	struct resource res;
+	int irq;
+	int error = -ENODEV;
+
+	if (usb_disabled())
+		goto out;
+
+	dev_dbg(&op->dev, "initializing " DRV_MODULE_NAME " USB Controller\n");
+
+	error = of_address_to_resource(dn, 0, &res);
+	if (error)
+		goto out;
+
+	hcd = usb_create_hcd(&ehci_hlwd_hc_driver, &op->dev, DRV_MODULE_NAME);
+	if (!hcd) {
+		error = -ENOMEM;
+		goto out;
+	}
+
+	hcd->rsrc_start = res.start;
+	hcd->rsrc_len = resource_size(&res);
+
+	irq = irq_of_parse_and_map(dn, 0);
+	if (irq == NO_IRQ) {
+		printk(KERN_ERR __FILE__ ": irq_of_parse_and_map failed\n");
+		error = -EBUSY;
+		goto err_irq;
+	}
+
+	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		printk(KERN_ERR __FILE__ ": ioremap failed\n");
+		error = -EBUSY;
+		goto err_ioremap;
+	}
+
+	/* this device requires MEM2 DMA buffers */
+	error = wii_set_mem2_dma_constraints(&op->dev);
+	if (error)
+		goto err_mem2_constraints;
+
+	ehci = hcd_to_ehci(hcd);
+	ehci->caps = hcd->regs;
+	ehci->regs = hcd->regs +
+			HC_LENGTH(ehci_readl(ehci, &ehci->caps->hc_capbase));
+
+	/* cache this readonly data; minimize chip reads */
+	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
+
+	error = usb_add_hcd(hcd, irq, 0);
+	if (error == 0)
+		return 0;
+
+err_mem2_constraints:
+	iounmap(hcd->regs);
+err_ioremap:
+	irq_dispose_mapping(irq);
+err_irq:
+	usb_put_hcd(hcd);
+out:
+	return error;
+}
+
+
+static int ehci_hcd_hlwd_remove(struct of_device *op)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(&op->dev);
+
+	dev_set_drvdata(&op->dev, NULL);
+
+	dev_dbg(&op->dev, "stopping " DRV_MODULE_NAME " USB Controller\n");
+
+	usb_remove_hcd(hcd);
+	wii_clear_mem2_dma_constraints(&op->dev);
+	iounmap(hcd->regs);
+	irq_dispose_mapping(hcd->irq);
+	usb_put_hcd(hcd);
+
+	return 0;
+}
+
+
+static int ehci_hcd_hlwd_shutdown(struct of_device *op)
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
+static struct of_device_id ehci_hcd_hlwd_match[] = {
+	{ .compatible = "nintendo,hollywood-usb-ehci", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ehci_hcd_hlwd_match);
+
+static struct of_platform_driver ehci_hcd_hlwd_driver = {
+	.name		= DRV_MODULE_NAME,
+	.match_table	= ehci_hcd_hlwd_match,
+	.probe		= ehci_hcd_hlwd_probe,
+	.remove		= ehci_hcd_hlwd_remove,
+	.shutdown	= ehci_hcd_hlwd_shutdown,
+	.driver		= {
+		.name	= DRV_MODULE_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 2d85e21..8fb519b 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -599,6 +599,27 @@ ehci_port_speed(struct ehci_hcd *ehci, unsigned int portsc)
 #define ehci_big_endian_mmio(e)		0
 #endif
 
+#ifdef CONFIG_USB_EHCI_HCD_HLWD
+
+/*
+ * The Nintendo Wii video game console has no PCI hardware.
+ * The USB controllers are part of the "Hollywood" chipset and are
+ * accessed via the platform internal I/O accessors.
+ */
+static inline unsigned int ehci_readl(const struct ehci_hcd *ehci,
+				      __u32 __iomem *regs)
+{
+	return in_be32(regs);
+}
+
+static inline void ehci_writel(const struct ehci_hcd *ehci,
+			       const unsigned int val, __u32 __iomem *regs)
+{
+	out_be32(regs, val);
+}
+
+#else
+
 /*
  * Big-endian read/write functions are arch-specific.
  * Other arches can be added if/when they're needed.
@@ -632,6 +653,8 @@ static inline void ehci_writel(const struct ehci_hcd *ehci,
 #endif
 }
 
+#endif /* CONFIG_USB_EHCI_HCD_HLWD */
+
 /*
  * On certain ppc-44x SoC there is a HW issue, that could only worked around with
  * explicit suspend/operate of OHCI. This function hereby makes sense only on that arch.
-- 
1.6.3.3
