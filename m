Return-Path: <fchen@apm.com>
Received: from denmail01.apm.COM (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D4EDB6EE8
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 04:49:51 +1000 (EST)
From: Fushen Chen <fchen@apm.com>
To: linux-usb@vger.kernel.org
Subject: [PATCH 1/2 v1.03] Add support for DWC OTG HCD function.
Date: Mon, 26 Jul 2010 11:49:41 -0700
Message-Id: <12801701823001-git-send-email-fchen@apm.com>
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de, Mark Miesfeld <mmiesfeld@apm.com>,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds support for the USB host controller on APM SoC using
Synopsys Designware IP.

Signed-off-by: Fushen Chen <fchen@apm.com>
Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
---
 drivers/Makefile                        |    1 +
 drivers/usb/Kconfig                     |    2 +
 drivers/usb/dwc_otg/Kconfig             |   96 +
 drivers/usb/dwc_otg/Makefile            |   19 +
 drivers/usb/dwc_otg/dwc_otg_apmppc.c    |  408 ++++
 drivers/usb/dwc_otg/dwc_otg_cil.c       |  903 +++++++++
 drivers/usb/dwc_otg/dwc_otg_cil.h       | 1194 +++++++++++
 drivers/usb/dwc_otg/dwc_otg_cil_intr.c  |  626 ++++++
 drivers/usb/dwc_otg/dwc_otg_driver.h    |   94 +
 drivers/usb/dwc_otg/dwc_otg_hcd.c       | 2408 +++++++++++++++++++++++
 drivers/usb/dwc_otg/dwc_otg_hcd.h       |  426 ++++
 drivers/usb/dwc_otg/dwc_otg_hcd_intr.c  | 1476 ++++++++++++++
 drivers/usb/dwc_otg/dwc_otg_hcd_queue.c |  708 +++++++
 drivers/usb/dwc_otg/dwc_otg_regs.h      | 3282 +++++++++++++++++++++++++++++++
 14 files changed, 11643 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/dwc_otg/Kconfig
 create mode 100644 drivers/usb/dwc_otg/Makefile
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_apmppc.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_cil.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_cil.h
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_cil_intr.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_driver.h
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_hcd.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_hcd.h
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_hcd_intr.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_hcd_queue.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_regs.h

diff --git a/drivers/Makefile b/drivers/Makefile
index 20dcced..f3fc7c7 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_UWB)		+= uwb/
 obj-$(CONFIG_USB_OTG_UTILS)	+= usb/otg/
 obj-$(CONFIG_USB)		+= usb/
 obj-$(CONFIG_USB_MUSB_HDRC)	+= usb/musb/
+obj-$(CONFIG_USB_DWC_OTG)	+= usb/dwc_otg/
 obj-$(CONFIG_PCI)		+= usb/
 obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
 obj-$(CONFIG_SERIO)		+= input/serio/
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 6a58cb1..f48920b 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -113,6 +113,8 @@ source "drivers/usb/host/Kconfig"
 
 source "drivers/usb/musb/Kconfig"
 
+source "drivers/usb/dwc_otg/Kconfig"
+
 source "drivers/usb/class/Kconfig"
 
 source "drivers/usb/storage/Kconfig"
diff --git a/drivers/usb/dwc_otg/Kconfig b/drivers/usb/dwc_otg/Kconfig
new file mode 100644
index 0000000..48da42b
--- /dev/null
+++ b/drivers/usb/dwc_otg/Kconfig
@@ -0,0 +1,96 @@
+#
+# USB Dual Role (OTG-ready) Controller Drivers
+# for silicon based on Synopsys DesignWare IP
+#
+
+comment "Enable Host or Gadget support for DesignWare OTG controller"
+	depends on !USB && USB_GADGET=n
+
+config USB_DWC_OTG
+	depends on (USB || USB_GADGET)
+	depends on 405EZ || 405EX || 460EX
+	select NOP_USB_XCEIV
+	select USB_OTG_UTILS
+	tristate "Synopsys DWC OTG Controller"
+	default USB_GADGET
+	help
+	  This driver provides USB Device Controller support for the
+	  Synopsys DesignWare USB OTG Core used on the AppliedMicro PowerPC SoC.
+
+config DWC_DEBUG
+	bool "Enable DWC Debugging"
+	depends on USB_DWC_OTG
+	default n
+	help
+	  Enable DWC driver debugging
+
+choice
+	prompt "DWC Mode Selection"
+	depends on USB_DWC_OTG
+	default DWC_OTG_MODE
+	help
+	  Select the DWC Core in OTG, Host only, or Device only mode.
+
+config DWC_OTG_MODE
+	bool "DWC OTG Mode" if 405EX || 460EX
+	select USB_GADGET_SELECTED
+
+config DWC_HOST_ONLY
+	bool "DWC Host Only Mode" if 405EX || 460EX
+
+config DWC_DEVICE_ONLY
+	bool "DWC Device Only Mode"
+	select USB_GADGET_SELECTED
+
+endchoice
+
+# enable peripheral support (including with OTG)
+config USB_GADGET_DWC_HDRC
+	bool
+	depends on USB_DWC_OTG && (DWC_DEVICE_ONLY || USB_DWC_OTG)
+
+choice
+	prompt "DWC DMA/SlaveMode Selection"
+	depends on USB_DWC_OTG
+	default DWC_DMA_MODE
+	help
+	  Select the DWC DMA or Slave Mode.
+	  DMA mode uses the DWC core internal DMA engines.
+	  Slave mode uses the processor PIO to tranfer data.
+	  In Slave mode, processor's DMA channels can be used if available.
+
+config DWC_SLAVE
+	bool "DWC Slave Mode" if 405EX || 460EX
+
+config DWC_DMA_MODE
+	bool "DWC DMA Mode" if 405EX || (460EX && \
+		(!USB_EHCI_HCD  || !USB_OHCI_HCD))
+
+endchoice
+
+config USB_OTG_WHITELIST
+	bool "Rely on OTG Targeted Peripherals List"
+	depends on !USB_SUSPEND
+	default n
+	help
+	  This is the same flag as in ../core/Kconfig.
+	  It is here for easy deselect.
+
+config DWC_OTG_REG_LE
+	depends on USB_DWC_OTG
+	bool "DWC Little Endian Register" if 405EX || 460EX
+	default y
+	help
+	  OTG core register access is Little-Endian.
+
+config DWC_OTG_FIFO_LE
+	depends on USB_DWC_OTG
+	bool "DWC FIFO Little Endian" if 405EZ
+	default n
+	help
+	  OTG core FIFO access is Little-Endian.
+
+config DWC_LIMITED_XFER_SIZE
+	depends on USB_DWC_OTG
+	bool "DWC Endpoint Limited Xfer Size" if 405EZ
+	default n
diff --git a/drivers/usb/dwc_otg/Makefile b/drivers/usb/dwc_otg/Makefile
new file mode 100644
index 0000000..31dd5e8
--- /dev/null
+++ b/drivers/usb/dwc_otg/Makefile
@@ -0,0 +1,19 @@
+#
+# OTG infrastructure and transceiver drivers
+#
+obj-$(CONFIG_USB_DWC_OTG)	+= dwc_otg.o
+
+dwc_otg-objs := dwc_otg_cil.o dwc_otg_cil_intr.o dwc_otg_param.o
+
+ifeq ($(CONFIG_4xx_SOC),y)
+dwc_otg-objs += dwc_otg_apmppc.o
+endif
+
+ifneq ($(CONFIG_DWC_DEVICE_ONLY),y)
+dwc_otg-objs += dwc_otg_hcd.o dwc_otg_hcd_intr.o \
+		dwc_otg_hcd_queue.o
+endif
+
+ifneq ($(CONFIG_DWC_HOST_ONLY),y)
+dwc_otg-objs += dwc_otg_pcd.o dwc_otg_pcd_intr.o
+endif
diff --git a/drivers/usb/dwc_otg/dwc_otg_apmppc.c b/drivers/usb/dwc_otg/dwc_otg_apmppc.c
new file mode 100644
index 0000000..5a70c91
--- /dev/null
+++ b/drivers/usb/dwc_otg/dwc_otg_apmppc.c
@@ -0,0 +1,408 @@
+/*
+ * DesignWare HS OTG controller driver
+ *
+ * Author: Mark Miesfeld <mmiesfeld@apm.com>
+ *
+ * Based on versions provided by APM and Synopsis which are:
+ *	Copyright (C) 2009-2010 AppliedMicro(www.apm.com)
+ * Modified by Stefan Roese <sr@denx.de>, DENX Software Engineering
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/*
+ * The dwc_otg module provides the initialization and cleanup entry
+ * points for the dwcotg driver. This module will be dynamically installed
+ * after Linux is booted using the insmod command. When the module is
+ * installed, the dwc_otg_driver_init function is called. When the module is
+ * removed (using rmmod), the dwc_otg_driver_cleanup function is called.
+ *
+ * This module also defines a data structure for the dwc_otg driver, which is
+ * used in conjunction with the standard device structure. These
+ * structures allow the OTG driver to comply with the standard Linux driver
+ * model in which devices and drivers are registered with a bus driver. This
+ * has the benefit that Linux can expose attributes of the driver and device
+ * in its special sysfs file system. Users can then read or write files in
+ * this file system to perform diagnostics on the driver components or the
+ * device.
+ */
+
+#include <linux/of_platform.h>
+
+#include "dwc_otg_driver.h"
+
+/* Based on Synopsys driver version 2.60a */
+#define DWC_DRIVER_VERSION		"1.03"
+#define DWC_DRIVER_DESC			"HS OTG USB Controller driver"
+static const char dwc_driver_name[] = "dwc_otg";
+
+/**
+ * This function is the top level interrupt handler for the Common
+ * (Device and host modes) interrupts.
+ */
+static irqreturn_t dwc_otg_common_irq(int _irq, void *dev)
+{
+	struct dwc_otg_device *dwc_dev = dev;
+	int retval = IRQ_NONE;
+
+	retval = dwc_otg_handle_common_intr(dwc_dev->core_if);
+	return IRQ_RETVAL(retval);
+}
+
+/**
+ * This function is the interrupt handler for the OverCurrent condition
+ * from the external charge pump (if enabled)
+ */
+static irqreturn_t dwc_otg_externalchgpump_irq(int _irq, void *dev)
+{
+	struct dwc_otg_device *dwc_dev = dev;
+
+	if (dwc_otg_is_host_mode(dwc_dev->core_if)) {
+		struct dwc_hcd *dwc_hcd;
+		union hprt0_data hprt0 = {.d32 = 0};
+
+		dwc_hcd = dwc_dev->hcd;
+		spin_lock(&dwc_hcd->lock);
+		dwc_hcd->flags.b.port_over_current_change = 1;
+
+		hprt0.b.prtpwr = 0;
+		dwc_write_reg32(dwc_dev->core_if->host_if->hprt0,
+				hprt0.d32);
+		spin_unlock(&dwc_hcd->lock);
+	} else {
+		/* Device mode - This int is n/a for device mode */
+		printk(KERN_ERR "DeviceMode: OTG OverCurrent Detected\n");
+	}
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * This function is called when a device is unregistered with the
+ * dwc_otg_driver. This happens, for example, when the rmmod command is
+ * executed. The device may or may not be electrically present. If it is
+ * present, the driver stops device processing. Any resources used on behalf
+ * of this device are freed.
+ */
+static int __devexit dwc_otg_driver_remove(struct of_device *ofdev)
+{
+	struct device *dev = &ofdev->dev;
+	struct dwc_otg_device *dwc_dev = dev_get_drvdata(dev);
+
+	/* Memory allocation for dwc_otg_device may have failed. */
+	if (!dwc_dev)
+		return 0;
+
+	usb_nop_xceiv_unregister();
+
+	/* Free the IRQ	*/
+	if (dwc_dev->common_irq_installed)
+		free_irq(dwc_dev->irq, dwc_dev);
+
+	if (!dwc_has_feature(dwc_dev->core_if, DWC_DEVICE_ONLY))
+		if (dwc_dev->hcd)
+			dwc_otg_hcd_remove(dev);
+
+	if (!dwc_has_feature(dwc_dev->core_if, DWC_HOST_ONLY))
+		if (dwc_dev->pcd)
+			dwc_otg_pcd_remove(dev);
+
+	if (dwc_dev->core_if)
+		dwc_otg_cil_remove(dwc_dev->core_if);
+
+	/* Return the memory. */
+	if (dwc_dev->base)
+		iounmap(dwc_dev->base);
+	if (dwc_dev->phys_addr)
+		release_mem_region(dwc_dev->phys_addr, dwc_dev->base_len);
+	kfree(dwc_dev);
+
+	/* Clear the drvdata pointer. */
+	dev_set_drvdata(dev, 0);
+	return 0;
+}
+
+/**
+ * This function is called when an device is bound to a
+ * dwc_otg_driver. It creates the driver components required to
+ * control the device (CIL, HCD, and PCD) and it initializes the
+ * device. The driver components are stored in a dwc_otg_device
+ * structure. A reference to the dwc_otg_device is saved in the
+ * device. This allows the driver to access the dwc_otg_device
+ * structure on subsequent calls to driver methods for this device.
+ */
+static int __devinit dwc_otg_driver_probe(struct of_device *ofdev,
+		const struct of_device_id *match)
+{
+	int retval = 0;
+	struct dwc_otg_device *dwc_dev;
+	struct device *dev = &ofdev->dev;
+	struct resource res;
+	u32 *gusbcfg_addr;
+	union gusbcfg_data usbcfg = {.d32 = 0};
+	u32 cp_irq;
+
+	dev_dbg(dev, "dwc_otg_driver_probe(%p)\n", dev);
+
+	dwc_dev = kzalloc(sizeof(*dwc_dev), GFP_KERNEL);
+	if (!dwc_dev) {
+		dev_err(dev, "kmalloc of dwc_otg_device failed\n");
+		retval = -ENOMEM;
+		goto fail;
+	}
+	dwc_dev->reg_offset = 0xFFFFFFFF;
+
+	/* Retrieve the memory and IRQ resources. */
+	dwc_dev->irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
+	if (dwc_dev->irq == NO_IRQ) {
+		dev_err(dev, "no device irq\n");
+		retval = -ENODEV;
+		goto fail;
+	}
+	dev_dbg(dev, "OTG - device irq: %d\n", dwc_dev->irq);
+
+	if (of_address_to_resource(ofdev->dev.of_node, 0, &res)) {
+		printk(KERN_ERR "%s: Can't get USB-OTG register address\n",
+			__func__);
+		retval = -ENOMEM;
+		goto fail;
+	}
+	dev_dbg(dev, "OTG - ioresource_mem start0x%08x: end:0x%08x\n",
+			(unsigned)res.start, (unsigned)res.end);
+
+	dwc_dev->phys_addr = res.start;
+	dwc_dev->base_len = res.end - res.start + 1;
+	if (!request_mem_region(dwc_dev->phys_addr,
+					dwc_dev->base_len,
+					dwc_driver_name)) {
+		dev_err(dev, "request_mem_region failed\n");
+		retval = -EBUSY;
+		goto fail;
+	}
+
+	/* Map the DWC_otg Core memory into virtual address space. */
+	dwc_dev->base = ioremap(dwc_dev->phys_addr,
+					dwc_dev->base_len);
+	if (!dwc_dev->base) {
+		dev_err(dev, "ioremap64() failed\n");
+		retval = -ENOMEM;
+		goto fail;
+	}
+	dev_dbg(dev, "mapped base=0x%08x\n", (unsigned)dwc_dev->base);
+
+	/*
+	 * Initialize driver data to point to the global DWC_otg
+	 * Device structure.
+	 */
+	dev_set_drvdata(dev, dwc_dev);
+
+	dev_dbg(dev, "dwc_dev=0x%p\n", dwc_dev);
+	dwc_dev->core_if =
+		dwc_otg_cil_init(dwc_dev->base, &dwc_otg_module_params);
+	if (!dwc_dev->core_if) {
+		dev_err(dev, "CIL initialization failed!\n");
+		retval = -ENOMEM;
+		goto fail;
+	}
+	usb_nop_xceiv_register();
+	dwc_dev->core_if->xceiv = otg_get_transceiver();
+	if (!dwc_dev->core_if->xceiv) {
+		retval = -ENODEV;
+		goto fail;
+	}
+	dwc_set_feature(dwc_dev->core_if);
+
+	gusbcfg_addr = &dwc_dev->core_if->core_global_regs->gusbcfg;
+
+	/*
+	 * Validate parameter values.
+	 */
+	if (check_parameters(dwc_dev->core_if)) {
+		retval = -EINVAL;
+		goto fail;
+	}
+
+	/* Added for PLB DMA phys virt mapping */
+	dwc_dev->core_if->phys_addr = dwc_dev->phys_addr;
+
+	/*
+	 * Disable the global interrupt until all the interrupt
+	 * handlers are installed.
+	 */
+	dwc_otg_disable_global_interrupts(dwc_dev->core_if);
+
+	/*
+	 * Install the interrupt handler for the common interrupts before
+	 * enabling common interrupts in core_init below.
+	 */
+	retval = request_irq(dwc_dev->irq, dwc_otg_common_irq,
+			IRQF_SHARED, "dwc_otg", dwc_dev);
+	if (retval) {
+		printk(KERN_ERR "request of irq%d failed retval: %d\n",
+				dwc_dev->irq, retval);
+		retval = -EBUSY;
+		goto fail;
+	} else {
+		dwc_dev->common_irq_installed = 1;
+	}
+
+	/* Initialize the DWC_otg core.	*/
+	dwc_otg_core_init(dwc_dev->core_if);
+
+	/* configure chargepump interrupt */
+	cp_irq = irq_of_parse_and_map(ofdev->dev.of_node, 3);
+	if (cp_irq) {
+		retval = request_irq(cp_irq, dwc_otg_externalchgpump_irq,
+				IRQF_SHARED, "dwc_otg_ext_chg_pump", dwc_dev);
+		if (retval) {
+			printk(KERN_ERR "request of irq failed retval: %d\n",
+				retval);
+			retval = -EBUSY;
+			goto fail;
+		} else {
+			printk(KERN_INFO "%s: ExtChgPump Detection "
+					"IRQ registered\n", dwc_driver_name);
+		}
+	}
+
+	if (!dwc_has_feature(dwc_dev->core_if, DWC_HOST_ONLY)) {
+		/* Initialize the PCD */
+		retval = dwc_otg_pcd_init(dev);
+		if (retval) {
+			printk(KERN_ERR "dwc_otg_pcd_init failed\n");
+			dwc_dev->pcd = NULL;
+			goto fail;
+		}
+	}
+
+	if (!dwc_has_feature(dwc_dev->core_if, DWC_DEVICE_ONLY)) {
+		/* Initialize the HCD and force_host_mode */
+		usbcfg.d32 = dwc_read_reg32(gusbcfg_addr);
+		usbcfg.b.force_host_mode = 1;
+		dwc_write_reg32(gusbcfg_addr, usbcfg.d32);
+
+		retval = dwc_otg_hcd_init(dev, dwc_dev);
+		if (retval) {
+			printk(KERN_ERR "dwc_otg_hcd_init failed\n");
+			dwc_dev->hcd = NULL;
+			goto fail;
+		}
+	}
+	/*
+	 * Enable the global interrupt after all the interrupt
+	 * handlers are installed.
+	 */
+	dwc_otg_enable_global_interrupts(dwc_dev->core_if);
+
+	usbcfg.d32 = dwc_read_reg32(gusbcfg_addr);
+	usbcfg.b.force_host_mode = 0;
+	dwc_write_reg32(gusbcfg_addr, usbcfg.d32);
+
+	return 0;
+
+fail:
+	dwc_otg_driver_remove(ofdev);
+	return retval;
+}
+
+/*
+ * This structure defines the methods to be called by a bus driver
+ * during the lifecycle of a device on that bus. Both drivers and
+ * devices are registered with a bus driver. The bus driver matches
+ * devices to drivers based on information in the device and driver
+ * structures.
+ *
+ * The probe function is called when the bus driver matches a device
+ * to this driver. The remove function is called when a device is
+ * unregistered with the bus driver.
+ */
+static const struct of_device_id dwc_otg_match[] = {
+	{ .compatible = "amcc,dwc-otg", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, dwc_otg_match);
+
+static struct of_platform_driver dwc_otg_driver = {
+	.probe = dwc_otg_driver_probe,
+	.remove = __devexit_p(dwc_otg_driver_remove),
+	.driver = {
+		.name = "dwc_otg",
+		.owner = THIS_MODULE,
+		.of_match_table = dwc_otg_match,
+	},
+};
+
+/**
+ * This function is called when the dwc_otg_driver is installed with the
+ * insmod command. It registers the dwc_otg_driver structure with the
+ * appropriate bus driver. This will cause the dwc_otg_driver_probe function
+ * to be called. In addition, the bus driver will automatically expose
+ * attributes defined for the device and driver in the special sysfs file
+ * system.
+ */
+static int  __init dwc_otg_driver_init(void)
+{
+	int retval = 0;
+	printk(KERN_INFO "%s: version %s\n", dwc_driver_name,
+			DWC_DRIVER_VERSION);
+	retval = of_register_platform_driver(&dwc_otg_driver);
+	if (retval < 0)
+		printk(KERN_ERR "%s registration failed. retval=%d\n",
+				dwc_driver_name, retval);
+	return retval;
+}
+module_init(dwc_otg_driver_init);
+
+/**
+ * This function is called when the driver is removed from the kernel
+ * with the rmmod command. The driver unregisters itself with its bus
+ * driver.
+ *
+ */
+static void __exit dwc_otg_driver_cleanup(void)
+{
+	of_unregister_platform_driver(&dwc_otg_driver);
+	printk(KERN_INFO "%s module removed\n", dwc_driver_name);
+}
+module_exit(dwc_otg_driver_cleanup);
+
+MODULE_DESCRIPTION(DWC_DRIVER_DESC);
+MODULE_AUTHOR("Mark Miesfeld <mmiesfeld@apm.com");
+MODULE_LICENSE("GPL");
diff --git a/drivers/usb/dwc_otg/dwc_otg_cil.c b/drivers/usb/dwc_otg/dwc_otg_cil.c
new file mode 100644
index 0000000..b889f4d
--- /dev/null
+++ b/drivers/usb/dwc_otg/dwc_otg_cil.c
@@ -0,0 +1,903 @@
+/*
+ * DesignWare HS OTG controller driver
+ *
+ * Author: Mark Miesfeld <mmiesfeld@apm.com>
+ *
+ * Based on versions provided by APM and Synopsis which are:
+ *	Copyright (C) 2009-2010 AppliedMicro(www.apm.com)
+ * Modified by Stefan Roese <sr@denx.de>, DENX Software Engineering
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/*
+ * The Core Interface Layer provides basic services for accessing and
+ * managing the DWC_otg hardware. These services are used by both the
+ * Host Controller Driver and the Peripheral Controller Driver.
+ *
+ * The CIL manages the memory map for the core so that the HCD and PCD
+ * don't have to do this separately. It also handles basic tasks like
+ * reading/writing the registers and data FIFOs in the controller.
+ * Some of the data access functions provide encapsulation of several
+ * operations required to perform a task, such as writing multiple
+ * registers to start a transfer. Finally, the CIL performs basic
+ * services that are not specific to either the host or device modes
+ * of operation. These services include management of the OTG Host
+ * Negotiation Protocol (HNP) and Session Request Protocol (SRP). A
+ * Diagnostic API is also provided to allow testing of the controller
+ * hardware.
+ *
+ * The Core Interface Layer has the following requirements:
+ * - Provides basic controller operations.
+ * - Minimal use of OS services.
+ * - The OS services used will be abstracted by using inline functions
+ *	 or macros.
+ */
+#include <linux/delay.h>
+
+#include "dwc_otg_cil.h"
+
+const char *op_state_str(enum usb_otg_state state)
+{
+	switch (state) {
+	case OTG_STATE_A_IDLE:		return "a_idle";
+	case OTG_STATE_A_WAIT_VRISE:	return "a_wait_vrise";
+	case OTG_STATE_A_WAIT_BCON:	return "a_wait_bcon";
+	case OTG_STATE_A_HOST:		return "a_host";
+	case OTG_STATE_A_SUSPEND:	return "a_suspend";
+	case OTG_STATE_A_PERIPHERAL:	return "a_peripheral";
+	case OTG_STATE_A_WAIT_VFALL:	return "a_wait_vfall";
+	case OTG_STATE_A_VBUS_ERR:	return "a_vbus_err";
+	case OTG_STATE_B_IDLE:		return "b_idle";
+	case OTG_STATE_B_SRP_INIT:	return "b_srp_init";
+	case OTG_STATE_B_PERIPHERAL:	return "b_peripheral";
+	case OTG_STATE_B_WAIT_ACON:	return "b_wait_acon";
+	case OTG_STATE_B_HOST:		return "b_host";
+	default:			return "UNDEFINED";
+	}
+}
+
+/**
+ * This function enables the controller's Global Interrupt in the AHB Config
+ * register.
+ */
+void dwc_otg_enable_global_interrupts(struct core_if *core_if)
+{
+	union gahbcfg_data ahbcfg = {.d32 = 0};
+	ahbcfg.b.glblintrmsk = 1;
+	dwc_modify_reg32(&core_if->core_global_regs->gahbcfg, 0, ahbcfg.d32);
+}
+
+/**
+ * This function disables the controller's Global Interrupt in the AHB Config
+ * register.
+ */
+void dwc_otg_disable_global_interrupts(struct core_if *core_if)
+{
+	union gahbcfg_data ahbcfg = {.d32 = 0};
+	ahbcfg.b.glblintrmsk = 1;
+	dwc_modify_reg32(&core_if->core_global_regs->gahbcfg, ahbcfg.d32, 0);
+}
+
+/**
+ * Tests if the current hardware is using a full speed phy.
+ */
+static inline int full_speed_phy(struct core_if *core_if)
+{
+	if ((core_if->hwcfg2.b.hs_phy_type == 2 &&
+			core_if->hwcfg2.b.fs_phy_type == 1 &&
+			core_if->core_params->ulpi_fs_ls) ||
+			core_if->core_params->phy_type ==
+			DWC_PHY_TYPE_PARAM_FS)
+		return 1;
+	return 0;
+}
+
+/**
+ * Initializes the FSLSPClkSel field of the HCFG register depending on the PHY
+ * type.
+ */
+void init_fslspclksel(struct core_if *core_if)
+{
+	u32 val;
+	union hcfg_data hcfg;
+
+	if (full_speed_phy(core_if))
+		val = DWC_HCFG_48_MHZ;
+	else
+		/* High speed PHY running at full speed or high speed */
+		val = DWC_HCFG_30_60_MHZ;
+
+	hcfg.d32 = dwc_read_reg32(&core_if->host_if->host_global_regs->hcfg);
+	hcfg.b.fslspclksel = val;
+	dwc_write_reg32(&core_if->host_if->host_global_regs->hcfg, hcfg.d32);
+}
+
+/**
+ * Initializes the DevSpd field of the DCFG register depending on the PHY type
+ * and the enumeration speed of the device.
+ */
+static void init_devspd(struct core_if *core_if)
+{
+	u32 val;
+	union  dcfg_data dcfg;
+
+	if (full_speed_phy(core_if))
+		val = 0x3;
+	else if (core_if->core_params->speed == DWC_SPEED_PARAM_FULL)
+		/* High speed PHY running at full speed */
+		val = 0x1;
+	else
+		/* High speed PHY running at high speed */
+		val = 0x0;
+
+	dcfg.d32 = dwc_read_reg32(&core_if->dev_if->dev_global_regs->dcfg);
+	dcfg.b.devspd = val;
+	dwc_write_reg32(&core_if->dev_if->dev_global_regs->dcfg, dcfg.d32);
+}
+
+/**
+ * This function calculates the number of IN EPS using GHWCFG1 and GHWCFG2
+ * registers values
+ */
+static u32 calc_num_in_eps(struct core_if *core_if)
+{
+	u32 num_in_eps = 0;
+	u32 num_eps = core_if->hwcfg2.b.num_dev_ep;
+	u32 hwcfg1 = core_if->hwcfg1.d32 >> 2;
+	u32 num_tx_fifos = core_if->hwcfg4.b.num_in_eps;
+	u32 i;
+
+	for (i = 0; i < num_eps; ++i) {
+		if (!(hwcfg1 & 0x1))
+			num_in_eps++;
+		hwcfg1 >>= 2;
+	}
+
+	if (core_if->hwcfg4.b.ded_fifo_en)
+		num_in_eps = num_in_eps > num_tx_fifos ?
+				num_tx_fifos : num_in_eps;
+
+	return num_in_eps;
+}
+
+/**
+ * This function calculates the number of OUT EPS using GHWCFG1 and GHWCFG2
+ * registers values
+ */
+static u32 calc_num_out_eps(struct core_if *core_if)
+{
+	u32 num_out_eps = 0;
+	u32 num_eps = core_if->hwcfg2.b.num_dev_ep;
+	u32 hwcfg1 = core_if->hwcfg1.d32 >> 2;
+	u32 i;
+
+	for (i = 0; i < num_eps; ++i) {
+		if (!(hwcfg1 & 0x2))
+			num_out_eps++;
+		hwcfg1 >>= 2;
+	}
+	return num_out_eps;
+}
+
+/**
+ * Do core a soft reset of the core.  Be careful with this because it
+ * resets all the internal state machines of the core.
+ */
+static void dwc_otg_core_reset(struct core_if *core_if)
+{
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+	union grstctl_data greset = {.d32 = 0};
+	int count = 0;
+
+	/* Wait for AHB master IDLE state. */
+	do {
+		udelay(10);
+		greset.d32 = dwc_read_reg32(&global_regs->grstctl);
+		if (++count > 100000) {
+			printk(KERN_WARNING
+				"%s() HANG! AHB Idle GRSTCTL=%0x\n",
+				__func__, greset.d32);
+			return;
+		}
+	} while (!greset.b.ahbidle);
+
+	/* Core Soft Reset */
+	count = 0;
+	greset.b.csftrst = 1;
+	dwc_write_reg32(&global_regs->grstctl, greset.d32);
+
+	do {
+		greset.d32 = dwc_read_reg32(&global_regs->grstctl);
+		if (++count > 10000) {
+			printk(KERN_WARNING "%s() HANG! Soft Reset "
+				"GRSTCTL=%0x\n", __func__, greset.d32);
+			break;
+		}
+		udelay(1);
+	} while (greset.b.csftrst);
+
+	/* Wait for 3 PHY Clocks */
+	msleep(100);
+}
+
+/**
+ * This function initializes the commmon interrupts, used in both
+ * device and host modes.
+ */
+void dwc_otg_enable_common_interrupts(struct core_if *core_if)
+{
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+	union gintmsk_data intr_mask = {.d32 = 0};
+
+	/* Clear any pending OTG Interrupts */
+	dwc_write_reg32(&global_regs->gotgint, 0xFFFFFFFF);
+
+	/* Clear any pending interrupts */
+	dwc_write_reg32(&global_regs->gintsts, 0xFFFFFFFF);
+
+	/* Enable the interrupts in the GINTMSK. */
+	intr_mask.b.modemismatch = 1;
+	intr_mask.b.otgintr = 1;
+	intr_mask.b.conidstschng = 1;
+	intr_mask.b.wkupintr = 1;
+	intr_mask.b.disconnect = 1;
+	intr_mask.b.usbsuspend = 1;
+	intr_mask.b.sessreqintr = 1;
+	if (!core_if->dma_enable)
+		intr_mask.b.rxstsqlvl = 1;
+	dwc_write_reg32(&global_regs->gintmsk, intr_mask.d32);
+}
+
+/**
+ * This function initializes the DWC_otg controller registers and prepares the
+ * core for device mode or host mode operation.
+ */
+void dwc_otg_core_init(struct core_if *core_if)
+{
+	u32 i;
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+	struct device_if *dev_if = core_if->dev_if;
+	union gahbcfg_data ahbcfg = {.d32 = 0};
+	union gusbcfg_data usbcfg = {.d32 = 0};
+	union gi2cctl_data i2cctl = {.d32 = 0};
+
+	/* Common Initialization */
+	usbcfg.d32 = dwc_read_reg32(&global_regs->gusbcfg);
+
+	/* Program the ULPI External VBUS bit if needed */
+	usbcfg.b.ulpi_ext_vbus_drv = 1;
+
+	/* Set external TS Dline pulsing */
+	usbcfg.b.term_sel_dl_pulse = core_if->core_params->ts_dline == 1 ?
+						1 : 0;
+	dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+
+	/* Reset the Controller */
+	dwc_otg_core_reset(core_if);
+
+	/* Initialize parameters from Hardware configuration registers. */
+	dev_if->num_in_eps = calc_num_in_eps(core_if);
+	dev_if->num_out_eps = calc_num_out_eps(core_if);
+
+	for (i = 0; i < core_if->hwcfg4.b.num_dev_perio_in_ep; i++) {
+		dev_if->perio_tx_fifo_size[i] =
+			dwc_read_reg32(&global_regs->dptxfsiz_dieptxf[i]) >> 16;
+	}
+	for (i = 0; i < core_if->hwcfg4.b.num_in_eps; i++) {
+		dev_if->tx_fifo_size[i] =
+			dwc_read_reg32(&global_regs->dptxfsiz_dieptxf[i]) >> 16;
+	}
+
+	core_if->total_fifo_size = core_if->hwcfg3.b.dfifo_depth;
+	core_if->rx_fifo_size = dwc_read_reg32(&global_regs->grxfsiz);
+	core_if->nperio_tx_fifo_size =
+			dwc_read_reg32(&global_regs->gnptxfsiz) >> 16;
+	/*
+	 * This programming sequence needs to happen in FS mode before any
+	 * other programming occurs
+	 */
+	if (core_if->core_params->speed == DWC_SPEED_PARAM_FULL &&
+			core_if->core_params->phy_type ==
+			DWC_PHY_TYPE_PARAM_FS) {
+		/*
+		 * core_init() is now called on every switch so only call the
+		 * following for the first time through.
+		 */
+		if (!core_if->phy_init_done) {
+			core_if->phy_init_done = 1;
+			usbcfg.d32 = dwc_read_reg32(&global_regs->gusbcfg);
+			usbcfg.b.physel = 1;
+			dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+
+			/* Reset after a PHY select */
+			dwc_otg_core_reset(core_if);
+		}
+
+		/*
+		 * Program DCFG.DevSpd or HCFG.FSLSPclkSel to 48Mhz in FS.
+		 * Also do this on HNP Dev/Host mode switches (done in dev_init
+		 * and host_init).
+		 */
+		if (dwc_otg_is_host_mode(core_if))
+			init_fslspclksel(core_if);
+		else
+			init_devspd(core_if);
+
+		if (core_if->core_params->i2c_enable) {
+			/* Program GUSBCFG.OtgUtmifsSel to I2C */
+			usbcfg.d32 = dwc_read_reg32(&global_regs->gusbcfg);
+			usbcfg.b.otgutmifssel = 1;
+			dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+
+			/* Program GI2CCTL.I2CEn */
+			i2cctl.d32 = dwc_read_reg32(&global_regs->gi2cctl);
+			i2cctl.b.i2cdevaddr = 1;
+			i2cctl.b.i2cen = 0;
+			dwc_write_reg32(&global_regs->gi2cctl, i2cctl.d32);
+			i2cctl.b.i2cen = 1;
+			dwc_write_reg32(&global_regs->gi2cctl, i2cctl.d32);
+		}
+	} else if (!core_if->phy_init_done) {
+		/*
+		 * High speed PHY. These parameters are preserved during soft
+		 * reset so only program them the first time. Do a soft reset
+		 * immediately after setting phyif.
+		 */
+		core_if->phy_init_done = 1;
+		usbcfg.b.ulpi_utmi_sel = core_if->core_params->phy_type;
+		if (usbcfg.b.ulpi_utmi_sel == 1) {
+			/* ULPI interface */
+			usbcfg.b.phyif = 0;
+			usbcfg.b.ddrsel = core_if->core_params->phy_ulpi_ddr;
+		} else {
+			/* UTMI+ interface */
+			if (core_if->core_params->phy_utmi_width == 16)
+				usbcfg.b.phyif = 1;
+			else
+				usbcfg.b.phyif = 0;
+		}
+		dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+
+		/* Reset after setting the PHY parameters */
+		dwc_otg_core_reset(core_if);
+	}
+
+	if (core_if->hwcfg2.b.hs_phy_type == 2 &&
+			core_if->hwcfg2.b.fs_phy_type == 1 &&
+			core_if->core_params->ulpi_fs_ls) {
+		usbcfg.d32 = dwc_read_reg32(&global_regs->gusbcfg);
+		usbcfg.b.ulpi_fsls = 1;
+		usbcfg.b.ulpi_clk_sus_m = 1;
+		dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+	} else {
+		usbcfg.d32 = dwc_read_reg32(&global_regs->gusbcfg);
+		usbcfg.b.ulpi_fsls = 0;
+		usbcfg.b.ulpi_clk_sus_m = 0;
+		dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+	}
+
+	/* Program the GAHBCFG Register. */
+	switch (core_if->hwcfg2.b.architecture) {
+	case DWC_SLAVE_ONLY_ARCH:
+		ahbcfg.b.nptxfemplvl_txfemplvl =
+			DWC_GAHBCFG_TXFEMPTYLVL_HALFEMPTY;
+		ahbcfg.b.ptxfemplvl = DWC_GAHBCFG_TXFEMPTYLVL_HALFEMPTY;
+		core_if->dma_enable = 0;
+		break;
+	case DWC_EXT_DMA_ARCH:
+		ahbcfg.b.hburstlen = core_if->core_params->dma_burst_size;
+		core_if->dma_enable = (core_if->core_params->dma_enable != 0);
+		break;
+	case DWC_INT_DMA_ARCH:
+		ahbcfg.b.hburstlen = DWC_GAHBCFG_INT_DMA_BURST_INCR;
+		core_if->dma_enable = (core_if->core_params->dma_enable != 0);
+		break;
+	}
+
+	ahbcfg.b.dmaenable = core_if->dma_enable;
+	dwc_write_reg32(&global_regs->gahbcfg, ahbcfg.d32);
+	core_if->en_multiple_tx_fifo = core_if->hwcfg4.b.ded_fifo_en;
+
+	/* Program the GUSBCFG register. */
+	usbcfg.d32 = dwc_read_reg32(&global_regs->gusbcfg);
+	switch (core_if->hwcfg2.b.op_mode) {
+	case DWC_MODE_HNP_SRP_CAPABLE:
+		usbcfg.b.hnpcap = (core_if->core_params->otg_cap ==
+			DWC_OTG_CAP_PARAM_HNP_SRP_CAPABLE);
+		usbcfg.b.srpcap = (core_if->core_params->otg_cap !=
+			DWC_OTG_CAP_PARAM_NO_HNP_SRP_CAPABLE);
+		break;
+	case DWC_MODE_SRP_ONLY_CAPABLE:
+		usbcfg.b.hnpcap = 0;
+		usbcfg.b.srpcap = (core_if->core_params->otg_cap !=
+			DWC_OTG_CAP_PARAM_NO_HNP_SRP_CAPABLE);
+		break;
+	case DWC_MODE_NO_HNP_SRP_CAPABLE:
+		usbcfg.b.hnpcap = 0;
+		usbcfg.b.srpcap = 0;
+		break;
+	case DWC_MODE_SRP_CAPABLE_DEVICE:
+		usbcfg.b.hnpcap = 0;
+		usbcfg.b.srpcap = (core_if->core_params->otg_cap !=
+			DWC_OTG_CAP_PARAM_NO_HNP_SRP_CAPABLE);
+		break;
+	case DWC_MODE_NO_SRP_CAPABLE_DEVICE:
+		usbcfg.b.hnpcap = 0;
+		usbcfg.b.srpcap = 0;
+		break;
+	case DWC_MODE_SRP_CAPABLE_HOST:
+		usbcfg.b.hnpcap = 0;
+		usbcfg.b.srpcap = (core_if->core_params->otg_cap !=
+			DWC_OTG_CAP_PARAM_NO_HNP_SRP_CAPABLE);
+		break;
+	case DWC_MODE_NO_SRP_CAPABLE_HOST:
+		usbcfg.b.hnpcap = 0;
+		usbcfg.b.srpcap = 0;
+		break;
+	}
+	dwc_write_reg32(&global_regs->gusbcfg, usbcfg.d32);
+
+	/* Enable common interrupts */
+	dwc_otg_enable_common_interrupts(core_if);
+
+	/*
+	 * Do device or host intialization based on mode during PCD
+	 * and HCD initialization
+	 */
+	if (dwc_otg_is_host_mode(core_if)) {
+		core_if->xceiv->state = OTG_STATE_A_HOST;
+	} else {
+		core_if->xceiv->state = OTG_STATE_B_PERIPHERAL;
+		if (dwc_has_feature(core_if, DWC_DEVICE_ONLY))
+			dwc_otg_core_dev_init(core_if);
+	}
+}
+
+/**
+ * This function enables the Device mode interrupts.
+ *
+ * Note that the bits in the Device IN endpoint mask register are laid out
+ * exactly the same as the Device IN endpoint interrupt register.
+ */
+static void dwc_otg_enable_device_interrupts(struct core_if *core_if)
+{
+	union gintmsk_data intr_mask = {.d32 = 0};
+	union diepint_data msk = {.d32 = 0};
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+
+	/* Disable all interrupts. */
+	dwc_write_reg32(&global_regs->gintmsk, 0);
+
+	/* Clear any pending interrupts */
+	dwc_write_reg32(&global_regs->gintsts, 0xFFFFFFFF);
+
+	/* Enable the common interrupts */
+	dwc_otg_enable_common_interrupts(core_if);
+
+	/* Enable interrupts */
+	intr_mask.b.usbreset = 1;
+	intr_mask.b.enumdone = 1;
+	intr_mask.b.inepintr = 1;
+	intr_mask.b.outepintr = 1;
+	intr_mask.b.erlysuspend = 1;
+	if (!core_if->en_multiple_tx_fifo)
+		intr_mask.b.epmismatch = 1;
+
+	/* Periodic EP */
+	intr_mask.b.isooutdrop = 1;
+	intr_mask.b.eopframe = 1;
+	intr_mask.b.incomplisoin = 1;
+	intr_mask.b.incomplisoout = 1;
+
+	dwc_modify_reg32(&global_regs->gintmsk, intr_mask.d32, intr_mask.d32);
+
+	msk.b.txfifoundrn = 1;
+	dwc_modify_reg32(&core_if->dev_if->dev_global_regs->diepmsk,
+				msk.d32, msk.d32);
+}
+
+/**
+ *  Configures the device data fifo sizes when dynamic sizing is enabled.
+ */
+static void config_dev_dynamic_fifos(struct core_if *core_if)
+{
+	u32 i;
+	struct core_global_regs *regs = core_if->core_global_regs;
+	struct core_params *params = core_if->core_params;
+	union fifosize_data txsize;
+	union fifosize_data nptxsize;
+	union fifosize_data ptxsize;
+
+	 /* Rx FIFO */
+	dwc_write_reg32(&regs->grxfsiz, params->dev_rx_fifo_size);
+
+	/* Set Periodic and Non-periodic Tx FIFO Mask bits to all 0 */
+	core_if->p_tx_msk = 0;
+	core_if->tx_msk = 0;
+
+	if (core_if->en_multiple_tx_fifo == 0) {
+		/* Non-periodic Tx FIFO */
+		nptxsize.b.depth = params->dev_nperio_tx_fifo_size;
+		nptxsize.b.startaddr = params->dev_rx_fifo_size;
+		dwc_write_reg32(&regs->gnptxfsiz, nptxsize.d32);
+
+		/*
+		 * Periodic Tx FIFOs These FIFOs are numbered from 1 to
+		 * 15. Indexes of the FIFO size module parameters in the
+		 * dev_perio_tx_fifo_size array and the FIFO size
+		 * registers in the dptxfsiz array run from 0 to 14.
+		 */
+		ptxsize.b.startaddr = nptxsize.b.startaddr + nptxsize.b.depth;
+		for (i = 0; i < core_if->hwcfg4.b.num_dev_perio_in_ep; i++) {
+			ptxsize.b.depth = params->dev_perio_tx_fifo_size[i];
+			dwc_write_reg32(&regs->dptxfsiz_dieptxf[i],
+						ptxsize.d32);
+			ptxsize.b.startaddr += ptxsize.b.depth;
+		}
+	} else {
+		/*
+		 * Non-periodic Tx FIFOs These FIFOs are numbered from
+		 * 1 to 15. Indexes of the FIFO size module parameters
+		 * in the dev_tx_fifo_size array and the FIFO size
+		 * registers in the dptxfsiz_dieptxf array run from 0 to
+		 * 14.
+		 */
+		nptxsize.b.depth = params->dev_nperio_tx_fifo_size;
+		nptxsize.b.startaddr = params->dev_rx_fifo_size;
+		dwc_write_reg32(&regs->gnptxfsiz, nptxsize.d32);
+
+		txsize.b.startaddr = nptxsize.b.startaddr + nptxsize.b.depth;
+		for (i = 1; i < core_if->hwcfg4.b.num_dev_perio_in_ep; i++) {
+			txsize.b.depth = params->dev_tx_fifo_size[i];
+			dwc_write_reg32(&regs->dptxfsiz_dieptxf[i - 1],
+						txsize.d32);
+			txsize.b.startaddr += txsize.b.depth;
+		}
+	}
+}
+
+/**
+ * This function initializes the DWC_otg controller registers for
+ * device mode.
+ */
+void dwc_otg_core_dev_init(struct core_if *c_if)
+{
+	u32 i;
+	struct device_if *d_if = c_if->dev_if;
+	struct core_params *params = c_if->core_params;
+	union dcfg_data dcfg = {.d32 = 0};
+	union grstctl_data resetctl = {.d32 = 0};
+	union dthrctl_data dthrctl;
+
+	/* Restart the Phy Clock */
+	dwc_write_reg32(c_if->pcgcctl, 0);
+
+	/* Device configuration register */
+	init_devspd(c_if);
+	dcfg.d32 = dwc_read_reg32(&d_if->dev_global_regs->dcfg);
+	dcfg.b.perfrint = DWC_DCFG_FRAME_INTERVAL_80;
+	dwc_write_reg32(&d_if->dev_global_regs->dcfg, dcfg.d32);
+
+	/* If needed configure data FIFO sizes */
+	if (c_if->hwcfg2.b.dynamic_fifo && params->enable_dynamic_fifo)
+		config_dev_dynamic_fifos(c_if);
+
+	/* Flush the FIFOs */
+	dwc_otg_flush_tx_fifo(c_if, DWC_GRSTCTL_TXFNUM_ALL);
+	dwc_otg_flush_rx_fifo(c_if);
+
+	/* Flush the Learning Queue. */
+	resetctl.b.intknqflsh = 1;
+	dwc_write_reg32(&c_if->core_global_regs->grstctl, resetctl.d32);
+
+	/* Clear all pending Device Interrupts */
+	dwc_write_reg32(&d_if->dev_global_regs->diepmsk, 0);
+	dwc_write_reg32(&d_if->dev_global_regs->doepmsk, 0);
+	dwc_write_reg32(&d_if->dev_global_regs->daint, 0xFFFFFFFF);
+	dwc_write_reg32(&d_if->dev_global_regs->daintmsk, 0);
+
+	for (i = 0; i <= d_if->num_in_eps; i++) {
+		union depctl_data depctl;
+
+		depctl.d32 = dwc_read_reg32(&d_if->in_ep_regs[i]->diepctl);
+		if (depctl.b.epena) {
+			depctl.d32 = 0;
+			depctl.b.epdis = 1;
+			depctl.b.snak = 1;
+		} else {
+			depctl.d32 = 0;
+		}
+
+		dwc_write_reg32(&d_if->in_ep_regs[i]->diepctl, depctl.d32);
+		dwc_write_reg32(&d_if->in_ep_regs[i]->dieptsiz, 0);
+		dwc_write_reg32(&d_if->in_ep_regs[i]->diepdma, 0);
+		dwc_write_reg32(&d_if->in_ep_regs[i]->diepint, 0xFF);
+	}
+
+	for (i = 0; i <= d_if->num_out_eps; i++) {
+		union depctl_data depctl;
+		depctl.d32 = dwc_read_reg32(&d_if->out_ep_regs[i]->doepctl);
+		if (depctl.b.epena) {
+			depctl.d32 = 0;
+			depctl.b.epdis = 1;
+			depctl.b.snak = 1;
+		} else {
+			depctl.d32 = 0;
+		}
+		dwc_write_reg32(&d_if->out_ep_regs[i]->doepctl, depctl.d32);
+		dwc_write_reg32(&d_if->out_ep_regs[i]->doeptsiz, 0);
+		dwc_write_reg32(&d_if->out_ep_regs[i]->doepdma, 0);
+		dwc_write_reg32(&d_if->out_ep_regs[i]->doepint, 0xFF);
+	}
+
+	if (c_if->en_multiple_tx_fifo && c_if->dma_enable) {
+		d_if->non_iso_tx_thr_en = c_if->core_params->thr_ctl & 0x1;
+		d_if->iso_tx_thr_en = (c_if->core_params->thr_ctl >> 1) & 0x1;
+		d_if->rx_thr_en = (c_if->core_params->thr_ctl >> 2) & 0x1;
+		d_if->rx_thr_length = c_if->core_params->rx_thr_length;
+		d_if->tx_thr_length = c_if->core_params->tx_thr_length;
+
+		dthrctl.d32 = 0;
+		dthrctl.b.non_iso_thr_en = d_if->non_iso_tx_thr_en;
+		dthrctl.b.iso_thr_en = d_if->iso_tx_thr_en;
+		dthrctl.b.tx_thr_len = d_if->tx_thr_length;
+		dthrctl.b.rx_thr_en = d_if->rx_thr_en;
+		dthrctl.b.rx_thr_len = d_if->rx_thr_length;
+		dwc_write_reg32(&d_if->dev_global_regs->dtknqr3_dthrctl,
+					dthrctl.d32);
+
+	}
+
+	dwc_otg_enable_device_interrupts(c_if);
+}
+
+/**
+ * This function reads a packet from the Rx FIFO into the destination buffer.
+ * To read SETUP data use dwc_otg_read_setup_packet.
+ */
+void dwc_otg_read_packet(struct core_if *core_if, u8 *dest,
+				u16 _bytes)
+{
+	u32 i;
+	int word_count = (_bytes + 3) / 4;
+	u32 *fifo = core_if->data_fifo[0];
+	u32 *data_buff = (u32 *) dest;
+
+	/*
+	 * This requires reading data from the FIFO into a u32 temp buffer,
+	 * then moving it into the data buffer.
+	 */
+	for (i = 0; i < word_count; i++, data_buff++)
+		*data_buff = dwc_read_datafifo32(fifo);
+}
+
+/**
+ * Flush a Tx FIFO.
+ */
+void dwc_otg_flush_tx_fifo(struct core_if *core_if, const int num)
+{
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+	union grstctl_data greset = {.d32 = 0 };
+	int count = 0;
+
+	greset.b.txfflsh = 1;
+	greset.b.txfnum = num;
+	dwc_write_reg32(&global_regs->grstctl, greset.d32);
+
+	do {
+		greset.d32 = dwc_read_reg32(&global_regs->grstctl);
+		if (++count > 10000) {
+			printk(KERN_WARNING "%s() HANG! GRSTCTL=%0x "
+				"GNPTXSTS=0x%08x\n", __func__, greset.d32,
+				dwc_read_reg32(&global_regs->gnptxsts));
+			break;
+		}
+		udelay(1);
+	} while (greset.b.txfflsh == 1);
+
+	/* Wait for 3 PHY Clocks */
+	udelay(1);
+}
+
+/**
+ * Flush Rx FIFO.
+ */
+void dwc_otg_flush_rx_fifo(struct core_if *core_if)
+{
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+	union grstctl_data greset = {.d32 = 0 };
+	int count = 0;
+
+	greset.b.rxfflsh = 1;
+	dwc_write_reg32(&global_regs->grstctl, greset.d32);
+
+	do {
+		greset.d32 = dwc_read_reg32(&global_regs->grstctl);
+		if (++count > 10000) {
+			printk(KERN_WARNING "%s() HANG! GRSTCTL=%0x\n",
+				__func__, greset.d32);
+			break;
+		}
+		udelay(1);
+	} while (greset.b.rxfflsh);
+
+	/* Wait for 3 PHY Clocks */
+	udelay(1);
+}
+
+/**
+ * Register HCD callbacks.
+ * The callbacks are used to start and stop the HCD for interrupt processing.
+ */
+void __devinit dwc_otg_cil_register_hcd_callbacks(struct core_if *c_if,
+				struct cil_callbacks *cb, void *p)
+{
+	c_if->hcd_cb = cb;
+	cb->p = p;
+}
+
+/**
+ * Register PCD callbacks.
+ * The callbacks are used to start and stop the PCD for interrupt processing.
+ */
+void __devinit dwc_otg_cil_register_pcd_callbacks(struct core_if *c_if,
+				struct cil_callbacks *cb, void *p)
+{
+	c_if->pcd_cb = cb;
+	cb->p = p;
+}
+
+/**
+ * This function is called to initialize the DWC_otg CSR data structures.
+ *
+ * The register addresses in the device and host structures are initialized from
+ * the base address supplied by the caller. The calling function must make the
+ * OS calls to get the base address of the DWC_otg controller registers.
+ *
+ * The params argument holds the parameters that specify how the core should be
+ * configured.
+ */
+struct core_if __devinit *dwc_otg_cil_init(const u32 *base,
+			struct core_params *params)
+{
+	struct core_if *core_if = NULL;
+	struct device_if *dev_if = NULL;
+	struct dwc_host_if *host_if = NULL;
+	u8 *reg_base = (u8 *) base;
+	u32 offset;
+	u32 i;
+
+	core_if = kzalloc(sizeof(*core_if), GFP_KERNEL);
+	if (!core_if)
+		return NULL;
+
+	core_if->core_params = params;
+	core_if->core_global_regs = (struct core_global_regs *) reg_base;
+
+	/* Allocate the Device Mode structures. */
+	dev_if = kmalloc(sizeof(*dev_if), GFP_KERNEL);
+	if (!dev_if) {
+		kfree(core_if);
+		return NULL;
+	}
+
+	dev_if->dev_global_regs = (struct device_global_regs *) (reg_base +
+					DWC_DEV_GLOBAL_REG_OFFSET);
+
+	for (i = 0; i < MAX_EPS_CHANNELS; i++) {
+		offset = i * DWC_EP_REG_OFFSET;
+
+		dev_if->in_ep_regs[i] = (struct device_in_ep_regs *)
+			(reg_base + DWC_DEV_IN_EP_REG_OFFSET + offset);
+
+		dev_if->out_ep_regs[i] = (struct device_out_ep_regs *)
+			(reg_base + DWC_DEV_OUT_EP_REG_OFFSET + offset);
+	}
+
+	dev_if->speed = 0;	/* unknown */
+	core_if->dev_if = dev_if;
+
+	/* Allocate the Host Mode structures. */
+	host_if = kmalloc(sizeof(*host_if), GFP_KERNEL);
+	if (!host_if) {
+		kfree(dev_if);
+		kfree(core_if);
+		return NULL;
+	}
+
+	host_if->host_global_regs = (struct host_global_regs *)
+	    (reg_base + DWC_OTG_HOST_GLOBAL_REG_OFFSET);
+
+	host_if->hprt0 = (u32 *) (reg_base + DWC_OTG_HOST_PORT_REGS_OFFSET);
+
+	for (i = 0; i < MAX_EPS_CHANNELS; i++) {
+		offset = i * DWC_OTG_CHAN_REGS_OFFSET;
+
+		host_if->hc_regs[i] = (struct dwc_hc_regs *)
+			(reg_base + DWC_OTG_HOST_CHAN_REGS_OFFSET + offset);
+	}
+
+	host_if->num_host_channels = MAX_EPS_CHANNELS;
+	core_if->host_if = host_if;
+	for (i = 0; i < MAX_EPS_CHANNELS; i++) {
+		core_if->data_fifo[i] =
+			(u32 *) (reg_base + DWC_OTG_DATA_FIFO_OFFSET +
+				(i * DWC_OTG_DATA_FIFO_SIZE));
+	}
+	core_if->pcgcctl = (u32 *) (reg_base + DWC_OTG_PCGCCTL_OFFSET);
+
+	/*
+	 * Store the contents of the hardware configuration registers here for
+	 * easy access later.
+	 */
+	core_if->hwcfg1.d32 =
+		dwc_read_reg32(&core_if->core_global_regs->ghwcfg1);
+	core_if->hwcfg2.d32 =
+		dwc_read_reg32(&core_if->core_global_regs->ghwcfg2);
+
+	core_if->hwcfg2.b.architecture = DWC_ARCH;
+
+	core_if->hwcfg3.d32 =
+		dwc_read_reg32(&core_if->core_global_regs->ghwcfg3);
+	core_if->hwcfg4.d32 =
+		dwc_read_reg32(&core_if->core_global_regs->ghwcfg4);
+
+	/* Set the SRP sucess bit for FS-I2c */
+	core_if->srp_success = 0;
+	core_if->srp_timer_started = 0;
+	return core_if;
+}
+
+/**
+ * This function frees the structures allocated by dwc_otg_cil_init().
+ */
+void dwc_otg_cil_remove(struct core_if *core_if)
+{
+	/* Disable all interrupts */
+	dwc_modify_reg32(&core_if->core_global_regs->gahbcfg, 1, 0);
+	dwc_write_reg32(&core_if->core_global_regs->gintmsk, 0);
+
+	if (core_if) {
+		kfree(core_if->dev_if);
+		kfree(core_if->host_if);
+	}
+	kfree(core_if);
+}
diff --git a/drivers/usb/dwc_otg/dwc_otg_cil.h b/drivers/usb/dwc_otg/dwc_otg_cil.h
new file mode 100644
index 0000000..46981a2
--- /dev/null
+++ b/drivers/usb/dwc_otg/dwc_otg_cil.h
@@ -0,0 +1,1194 @@
+/*
+ * DesignWare HS OTG controller driver
+ *
+ * Author: Mark Miesfeld <mmiesfeld@apm.com>
+ *
+ * Based on versions provided by APM and Synopsis which are:
+ *	Copyright (C) 2009-2010 AppliedMicro(www.apm.com)
+ * Modified by Stefan Roese <sr@denx.de>, DENX Software Engineering
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#if !defined(__DWC_CIL_H__)
+#define __DWC_CIL_H__
+#include <linux/io.h>
+#include <linux/usb/ch9.h>
+#include <linux/usb/gadget.h>
+#include <linux/interrupt.h>
+#include <linux/dmapool.h>
+#include <linux/spinlock.h>
+#include <linux/usb/otg.h>
+
+#include "dwc_otg_regs.h"
+
+#ifdef CONFIG_DWC_SLAVE
+#define DWC_ARCH DWC_SLAVE_ONLY_ARCH
+#else
+#define DWC_ARCH DWC_INT_DMA_ARCH
+#endif
+
+#ifdef CONFIG_DWC_DEBUG
+#define DEBUG
+#endif
+
+/**
+ * Reads the content of a register.
+ */
+static inline u32 dwc_read_reg32(u32 *reg)
+{
+#ifdef CONFIG_DWC_OTG_REG_LE
+	return in_le32(reg);
+#else
+	return in_be32(reg);
+#endif
+};
+
+/**
+ * Writes a register with a 32 bit value.
+ */
+static inline void dwc_write_reg32(u32 *reg, const u32 value)
+{
+#ifdef CONFIG_DWC_OTG_REG_LE
+	out_le32(reg, value);
+#else
+	out_be32(reg, value);
+#endif
+};
+
+/**
+ * This function modifies bit values in a register.  Using the
+ * algorithm: (reg_contents & ~clear_mask) | set_mask.
+ */
+static inline
+void dwc_modify_reg32(u32 *_reg, const u32 _clear_mask,
+			const u32 _set_mask)
+{
+#ifdef CONFIG_DWC_OTG_REG_LE
+	out_le32(_reg, (in_le32(_reg) & ~_clear_mask) | _set_mask);
+#else
+	out_be32(_reg, (in_be32(_reg) & ~_clear_mask) | _set_mask);
+#endif
+};
+
+static inline void dwc_write_datafifo32(u32 *reg, const u32 _value)
+{
+#ifdef CONFIG_DWC_OTG_FIFO_LE
+	out_le32(reg, _value);
+#else
+	out_be32(reg, _value);
+#endif
+};
+
+static inline u32 dwc_read_datafifo32(u32 *_reg)
+{
+#ifdef CONFIG_DWC_OTG_FIFO_LE
+	return in_le32(_reg);
+#else
+	return in_be32(_reg);
+#endif
+};
+
+/*
+ * Debugging support vanishes in non-debug builds.
+ */
+/* Display CIL Debug messages */
+#define dwc_dbg_cil		(0x2)
+
+/* Display CIL Verbose debug messages */
+#define dwc_dbg_cilv		(0x20)
+
+/* Display PCD (Device) debug messages */
+#define dwc_dbg_pcd		(0x4)
+
+/* Display PCD (Device) Verbose debug  messages */
+#define dwc_dbg_pcdv		(0x40)
+
+/* Display Host debug messages */
+#define dwc_dbg_hcd		(0x8)
+
+/* Display Verbose Host debug messages */
+#define dwc_dbg_hcdv		(0x80)
+
+/* Display enqueued URBs in host mode. */
+#define dwc_dbg_hcd_urb		(0x800)
+
+/* Display "special purpose" debug messages */
+#define dwc_dbg_sp		(0x400)
+
+/* Display all debug messages */
+#define dwc_dbg_any		(0xFF)
+
+/* All debug messages off */
+#define dwc_dbg_off		0
+
+/* Prefix string for DWC_DEBUG print macros. */
+#define usb_dwc "dwc_otg: "
+
+/*
+ * This file contains the interface to the Core Interface Layer.
+ */
+
+/*
+ * Added-sr: 2007-07-26
+ *
+ * Since the 405EZ (Ultra) only support 2047 bytes as
+ * max transfer size, we have to split up bigger transfers
+ * into multiple transfers of 1024 bytes sized messages.
+ * I happens often, that transfers of 4096 bytes are
+ * required (zero-gadget, file_storage-gadget).
+ *
+ * MAX_XFER_LEN is set to 1024 right now, but could be 2047,
+ * since the xfer-size field in the 405EZ USB device controller
+ * implementation has 11 bits. Using 1024 seems to work for now.
+ */
+#define MAX_XFER_LEN	1024
+
+/*
+ * The dwc_ep structure represents the state of a single endpoint when acting in
+ * device mode. It contains the data items needed for an endpoint to be
+ * activated and transfer packets.
+ */
+struct dwc_ep {
+	/* EP number used for register address lookup */
+	u8	 num;
+	/* EP direction 0 = OUT */
+	unsigned is_in:1;
+	/* EP active. */
+	unsigned active:1;
+
+	/*
+	 * Periodic Tx FIFO # for IN EPs For INTR EP set to 0 to use
+	 * non-periodic Tx FIFO If dedicated Tx FIFOs are enabled for all
+	 * IN Eps - Tx FIFO # FOR IN EPs
+	 */
+	unsigned tx_fifo_num:4;
+	/* EP type: 0 - Control, 1 - ISOC,	 2 - BULK,	3 - INTR */
+	unsigned type:2;
+#define DWC_OTG_EP_TYPE_CONTROL		0
+#define DWC_OTG_EP_TYPE_ISOC		1
+#define DWC_OTG_EP_TYPE_BULK		2
+#define DWC_OTG_EP_TYPE_INTR		3
+
+	/* DATA start PID for INTR and BULK EP */
+	unsigned data_pid_start:1;
+	/* Frame (even/odd) for ISOC EP */
+	unsigned even_odd_frame:1;
+	/* Max Packet bytes */
+	unsigned maxpacket:11;
+
+	u32 dma_addr;
+
+	/*
+	 * Pointer to the beginning of the transfer buffer -- do not modify
+	 * during transfer.
+	 */
+	u8 *start_xfer_buff;
+	/* pointer to the transfer buffer */
+	u8 *xfer_buff;
+	/* Number of bytes to transfer */
+	unsigned xfer_len:19;
+	/* Number of bytes transferred. */
+	unsigned xfer_count:19;
+	/* Sent ZLP */
+	unsigned sent_zlp:1;
+	/* Total len for control transfer */
+	unsigned total_len:19;
+
+	/* stall clear flag */
+	unsigned stall_clear_flag:1;
+
+	/*
+	 * Added-sr: 2007-07-26
+	 *
+	 * Since the 405EZ (Ultra) only support 2047 bytes as
+	 * max transfer size, we have to split up bigger transfers
+	 * into multiple transfers of 1024 bytes sized messages.
+	 * I happens often, that transfers of 4096 bytes are
+	 * required (zero-gadget, file_storage-gadget).
+	 *
+	 * "bytes_pending" will hold the amount of bytes that are
+	 * still pending to be send in further messages to complete
+	 * the bigger transfer.
+	 */
+	u32 bytes_pending;
+};
+
+
+/*
+ * States of EP0.
+ */
+enum ep0_state {
+	EP0_DISCONNECT = 0,     /* no host */
+	EP0_IDLE = 1,
+	EP0_IN_DATA_PHASE = 2,
+	EP0_OUT_DATA_PHASE = 3,
+	EP0_STATUS = 4,
+	EP0_STALL = 5,
+};
+
+/* Fordward declaration.*/
+struct dwc_pcd;
+
+/*
+ * This structure describes an EP, there is an array of EPs in the PCD
+ * structure.
+ */
+struct pcd_ep {
+	/* USB EP data */
+	struct usb_ep ep;
+	/* USB EP Descriptor */
+	const struct usb_endpoint_descriptor *desc;
+
+	/* queue of dwc_otg_pcd_requests. */
+	struct list_head queue;
+	unsigned stopped:1;
+	unsigned disabling:1;
+	unsigned dma:1;
+	unsigned queue_sof:1;
+
+	/* DWC_otg ep data. */
+	struct dwc_ep dwc_ep;
+
+	/* Pointer to PCD */
+	struct dwc_pcd *pcd;
+};
+
+/*
+ * DWC_otg PCD Structure.
+ * This structure encapsulates the data for the dwc_otg PCD.
+ */
+struct dwc_pcd {
+	/* USB gadget */
+	struct usb_gadget gadget;
+	/* USB gadget driver pointer*/
+	struct usb_gadget_driver *driver;
+	/* The DWC otg device pointer. */
+	struct dwc_otg_device *otg_dev;
+
+	/* State of EP0 */
+	enum ep0_state ep0state;
+	/* EP0 Request is pending */
+	unsigned ep0_pending:1;
+	/* Indicates when SET CONFIGURATION Request is in process */
+	unsigned request_config:1;
+	/* The state of the Remote Wakeup Enable. */
+	unsigned remote_wakeup_enable:1;
+	/* The state of the B-Device HNP Enable. */
+	unsigned b_hnp_enable:1;
+	/* The state of A-Device HNP Support. */
+	unsigned a_hnp_support:1;
+	/* The state of the A-Device Alt HNP support. */
+	unsigned a_alt_hnp_support:1;
+	/* Count of pending Requests */
+	unsigned request_pending;
+
+	/*
+	 * SETUP packet for EP0.  This structure is allocated as a DMA buffer on
+	 * PCD initialization with enough space for up to 3 setup packets.
+	 */
+	union {
+		struct usb_ctrlrequest req;
+		u32 d32[2];
+	} *setup_pkt;
+
+	struct dma_pool *dwc_pool;
+	dma_addr_t setup_pkt_dma_handle;
+
+	/* 2-byte dma buffer used to return status from GET_STATUS */
+	u16 *status_buf;
+	dma_addr_t status_buf_dma_handle;
+
+	/* Array of EPs. */
+	struct pcd_ep ep0;
+	/* Array of IN EPs. */
+	struct pcd_ep in_ep[MAX_EPS_CHANNELS - 1];
+	/* Array of OUT EPs. */
+	struct pcd_ep out_ep[MAX_EPS_CHANNELS - 1];
+	spinlock_t lock;
+	/*
+	 *  Timer for SRP.  If it expires before SRP is successful clear the
+	 *  SRP.
+	 */
+	struct timer_list srp_timer;
+
+	/*
+	 * Tasklet to defer starting of TEST mode transmissions until Status
+	 * Phase has been completed.
+	 */
+	struct tasklet_struct test_mode_tasklet;
+
+	/*  Tasklet to delay starting of xfer in DMA mode */
+	struct tasklet_struct *start_xfer_tasklet;
+
+	/* The test mode to enter when the tasklet is executed. */
+	unsigned test_mode;
+};
+
+/*
+ * This structure holds the state of the HCD, including the non-periodic and
+ * periodic schedules.
+ */
+struct dwc_hcd {
+	spinlock_t lock;
+
+	/* DWC OTG Core Interface Layer */
+	struct core_if *core_if;
+
+	/* Internal DWC HCD Flags */
+	union dwc_otg_hcd_internal_flags {
+		u32 d32;
+		struct {
+			unsigned port_connect_status_change:1;
+			unsigned port_connect_status:1;
+			unsigned port_reset_change:1;
+			unsigned port_enable_change:1;
+			unsigned port_suspend_change:1;
+			unsigned port_over_current_change:1;
+			unsigned reserved:27;
+		} b;
+	} flags;
+
+	/*
+	 * Inactive items in the non-periodic schedule. This is a list of
+	 * Queue Heads. Transfers associated with these Queue Heads are not
+	 * currently assigned to a host channel.
+	 */
+	struct list_head non_periodic_sched_inactive;
+
+	/*
+	 * Deferred items in the non-periodic schedule. This is a list of
+	 * Queue Heads. Transfers associated with these Queue Heads are not
+	 * currently assigned to a host channel.
+	 * When we get an NAK, the QH goes here.
+	 */
+	struct list_head non_periodic_sched_deferred;
+
+	/*
+	 * Active items in the non-periodic schedule. This is a list of
+	 * Queue Heads. Transfers associated with these Queue Heads are
+	 * currently assigned to a host channel.
+	 */
+	struct list_head non_periodic_sched_active;
+
+	/*
+	 * Pointer to the next Queue Head to process in the active
+	 * non-periodic schedule.
+	 */
+	struct list_head *non_periodic_qh_ptr;
+
+	/*
+	 * Inactive items in the periodic schedule. This is a list of QHs for
+	 * periodic transfers that are _not_ scheduled for the next frame.
+	 * Each QH in the list has an interval counter that determines when it
+	 * needs to be scheduled for execution. This scheduling mechanism
+	 * allows only a simple calculation for periodic bandwidth used (i.e.
+	 * must assume that all periodic transfers may need to execute in the
+	 * same frame). However, it greatly simplifies scheduling and should
+	 * be sufficient for the vast majority of OTG hosts, which need to
+	 * connect to a small number of peripherals at one time.
+	 *
+	 * Items move from this list to periodic_sched_ready when the QH
+	 * interval counter is 0 at SOF.
+	 */
+	struct list_head periodic_sched_inactive;
+
+	/*
+	 * List of periodic QHs that are ready for execution in the next
+	 * frame, but have not yet been assigned to host channels.
+	 *
+	 * Items move from this list to periodic_sched_assigned as host
+	 * channels become available during the current frame.
+	 */
+	struct list_head periodic_sched_ready;
+
+	/*
+	 * List of periodic QHs to be executed in the next frame that are
+	 * assigned to host channels.
+	 *
+	 * Items move from this list to periodic_sched_queued as the
+	 * transactions for the QH are queued to the DWC_otg controller.
+	 */
+	struct list_head periodic_sched_assigned;
+
+	/*
+	 * List of periodic QHs that have been queued for execution.
+	 *
+	 * Items move from this list to either periodic_sched_inactive or
+	 * periodic_sched_ready when the channel associated with the transfer
+	 * is released. If the interval for the QH is 1, the item moves to
+	 * periodic_sched_ready because it must be rescheduled for the next
+	 * frame. Otherwise, the item moves to periodic_sched_inactive.
+	 */
+	struct list_head periodic_sched_queued;
+
+	/*
+	 * Total bandwidth claimed so far for periodic transfers. This value
+	 * is in microseconds per (micro)frame. The assumption is that all
+	 * periodic transfers may occur in the same (micro)frame.
+	 */
+	u16 periodic_usecs;
+
+	/*
+	 * Total bandwidth claimed so far for all periodic transfers
+	 * in a frame.
+	 * This will include a mixture of HS and FS transfers.
+	 * Units are microseconds per (micro)frame.
+	 * We have a budget per frame and have to schedule
+	 * transactions accordingly.
+	 * Watch out for the fact that things are actually scheduled for the
+	 * "next frame".
+	 */
+	u16 frame_usecs[8];
+
+	/*
+	 * Frame number read from the core at SOF. The value ranges from 0 to
+	 * DWC_HFNUM_MAX_FRNUM.
+	 */
+	u16 frame_number;
+
+	/*
+	 * Free host channels in the controller. This is a list of
+	 * struct dwc_hc items.
+	 */
+	struct list_head free_hc_list;
+
+	/*
+	 * Number of available host channels.
+	 */
+	u32 available_host_channels;
+
+	/*
+	 * Array of pointers to the host channel descriptors. Allows accessing
+	 * a host channel descriptor given the host channel number. This is
+	 * useful in interrupt handlers.
+	 */
+	struct dwc_hc *hc_ptr_array[MAX_EPS_CHANNELS];
+
+	/*
+	 * Buffer to use for any data received during the status phase of a
+	 * control transfer. Normally no data is transferred during the status
+	 * phase. This buffer is used as a bit bucket.
+	 */
+	u8 *status_buf;
+
+	/*
+	 * DMA address for status_buf.
+	 */
+	dma_addr_t status_buf_dma;
+#define DWC_OTG_HCD_STATUS_BUF_SIZE		64
+
+	/*
+	 * Structure to allow starting the HCD in a non-interrupt context
+	 * during an OTG role change.
+	 */
+	struct work_struct start_work;
+	struct usb_hcd *_p;
+
+	/*
+	 * Connection timer. An OTG host must display a message if the device
+	 * does not connect. Started when the VBus power is turned on via
+	 * sysfs attribute "buspower".
+	 */
+	struct timer_list conn_timer;
+
+	/* workqueue for port wakeup */
+	struct work_struct usb_port_reset;
+};
+
+/*
+ * Reasons for halting a host channel.
+ */
+enum dwc_halt_status {
+	DWC_OTG_HC_XFER_NO_HALT_STATUS,
+	DWC_OTG_HC_XFER_COMPLETE,
+	DWC_OTG_HC_XFER_URB_COMPLETE,
+	DWC_OTG_HC_XFER_ACK,
+	DWC_OTG_HC_XFER_NAK,
+	DWC_OTG_HC_XFER_NYET,
+	DWC_OTG_HC_XFER_STALL,
+	DWC_OTG_HC_XFER_XACT_ERR,
+	DWC_OTG_HC_XFER_FRAME_OVERRUN,
+	DWC_OTG_HC_XFER_BABBLE_ERR,
+	DWC_OTG_HC_XFER_DATA_TOGGLE_ERR,
+	DWC_OTG_HC_XFER_AHB_ERR,
+	DWC_OTG_HC_XFER_PERIODIC_INCOMPLETE,
+	DWC_OTG_HC_XFER_URB_DEQUEUE
+};
+
+/*
+ * Host channel descriptor. This structure represents the state of a single
+ * host channel when acting in host mode. It contains the data items needed to
+ * transfer packets to an endpoint via a host channel.
+ */
+struct dwc_hc {
+	/* Host channel number used for register address lookup */
+	u8 hc_num;
+
+	/* Device to access */
+	unsigned dev_addr:7;
+
+	/* EP to access */
+	unsigned ep_num:4;
+
+	/* EP direction. 0: OUT, 1: IN */
+	unsigned ep_is_in:1;
+
+	/*
+	 * EP speed.
+	 * One of the following values:
+	 *	- DWC_OTG_EP_SPEED_LOW
+	 *	- DWC_OTG_EP_SPEED_FULL
+	 *	- DWC_OTG_EP_SPEED_HIGH
+	 */
+	unsigned speed:2;
+#define DWC_OTG_EP_SPEED_LOW		0
+#define DWC_OTG_EP_SPEED_FULL		1
+#define DWC_OTG_EP_SPEED_HIGH		2
+
+	/*
+	 * Endpoint type.
+	 * One of the following values:
+	 *	- DWC_OTG_EP_TYPE_CONTROL: 0
+	 *	- DWC_OTG_EP_TYPE_ISOC: 1
+	 *	- DWC_OTG_EP_TYPE_BULK: 2
+	 *	- DWC_OTG_EP_TYPE_INTR: 3
+	 */
+	unsigned ep_type:2;
+
+	/* Max packet size in bytes */
+	unsigned max_packet:11;
+
+	/*
+	 * PID for initial transaction.
+	 * 0: DATA0,
+	 * 1: DATA2,
+	 * 2: DATA1,
+	 * 3: MDATA (non-Control EP),
+	 *	SETUP (Control EP)
+	 */
+	unsigned data_pid_start:2;
+#define DWC_OTG_HC_PID_DATA0		0
+#define DWC_OTG_HC_PID_DATA2		1
+#define DWC_OTG_HC_PID_DATA1		2
+#define DWC_OTG_HC_PID_MDATA		3
+#define DWC_OTG_HC_PID_SETUP		3
+
+	/* Number of periodic transactions per (micro)frame */
+	unsigned multi_count:2;
+
+	/* Pointer to the current transfer buffer position. */
+	u8 *xfer_buff;
+	/* Total number of bytes to transfer. */
+	u32 xfer_len;
+	/* Number of bytes transferred so far. */
+	u32 xfer_count;
+	/* Packet count at start of transfer.*/
+	u16 start_pkt_count;
+
+	/*
+	 * Flag to indicate whether the transfer has been started. Set to 1 if
+	 * it has been started, 0 otherwise.
+	 */
+	u8 xfer_started;
+
+	/*
+	 * Set to 1 to indicate that a PING request should be issued on this
+	 * channel. If 0, process normally.
+	 */
+	u8 do_ping;
+
+	/*
+	 * Set to 1 to indicate that the error count for this transaction is
+	 * non-zero. Set to 0 if the error count is 0.
+	 */
+	u8 error_state;
+
+	/*
+	 * Set to 1 to indicate that this channel should be halted the next
+	 * time a request is queued for the channel. This is necessary in
+	 * slave mode if no request queue space is available when an attempt
+	 * is made to halt the channel.
+	 */
+	u8 halt_on_queue;
+
+	/*
+	 * Set to 1 if the host channel has been halted, but the core is not
+	 * finished flushing queued requests. Otherwise 0.
+	 */
+	u8 halt_pending;
+
+	/* Reason for halting the host channel. */
+	enum dwc_halt_status	halt_status;
+
+	/*  Split settings for the host channel	*/
+	u8 do_split;		/* Enable split for the channel */
+	u8 complete_split;		/* Enable complete split */
+	u8 hub_addr;		/* Address of high speed hub */
+	u8 port_addr;		/* Port of the low/full speed device */
+
+	/*
+	 * Split transaction position. One of the following values:
+	 *	- DWC_HCSPLIT_XACTPOS_MID
+	 *	- DWC_HCSPLIT_XACTPOS_BEGIN
+	 *	- DWC_HCSPLIT_XACTPOS_END
+	 *	- DWC_HCSPLIT_XACTPOS_ALL */
+	u8 xact_pos;
+
+	/* Set when the host channel does a short read. */
+	u8 short_read;
+
+	/*
+	 * Number of requests issued for this channel since it was assigned to
+	 * the current transfer (not counting PINGs).
+	 */
+	u8 requests;
+
+	/* Queue Head for the transfer being processed by this channel.	*/
+	struct dwc_qh *qh;
+
+	/* Entry in list of host channels. */
+	struct list_head	hc_list_entry;
+};
+
+/*
+ * The following parameters may be specified when starting the module. These
+ * parameters define how the DWC_otg controller should be configured.  Parameter
+ * values are passed to the CIL initialization function dwc_otg_cil_init.
+ */
+struct core_params {
+	int opt;
+#define dwc_param_opt_default				1
+
+	/*
+	 * Specifies the OTG capabilities. The driver will automatically
+	 * detect the value for this parameter if none is specified.
+	 * 0 - HNP and SRP capable (default)
+	 * 1 - SRP Only capable
+	 * 2 - No HNP/SRP capable
+	 */
+	int otg_cap;
+#define DWC_OTG_CAP_PARAM_HNP_SRP_CAPABLE		0
+#define DWC_OTG_CAP_PARAM_SRP_ONLY_CAPABLE		1
+#define DWC_OTG_CAP_PARAM_NO_HNP_SRP_CAPABLE		2
+
+#define dwc_param_otg_cap_default	DWC_OTG_CAP_PARAM_HNP_SRP_CAPABLE
+
+	/*
+	 * Specifies whether to use slave or DMA mode for accessing the data
+	 * FIFOs. The driver will automatically detect the value for this
+	 * parameter if none is specified.
+	 * 0 - Slave
+	 * 1 - DMA (default, if available)
+	 */
+	int dma_enable;
+#define dwc_param_dma_enable_default			1
+
+	/*
+	 * The DMA Burst size (applicable only for External DMA	Mode).
+	 * 1, 4, 8 16, 32, 64, 128, 256 (default 32)
+	 */
+	int dma_burst_size;		/* Translate this to GAHBCFG values */
+#define dwc_param_dma_burst_size_default		32
+
+	/*
+	 * Specifies the maximum speed of operation in host and device mode.
+	 * The actual speed depends on the speed of the attached device and
+	 * the value of phy_type. The actual speed depends on the speed of the
+	 * attached device.
+	 *	0 - High Speed (default)
+	 *	1 - Full Speed
+	 */
+	int speed;
+#define dwc_param_speed_default				0
+#define DWC_SPEED_PARAM_HIGH				0
+#define DWC_SPEED_PARAM_FULL				1
+
+	/*
+	 * Specifies whether low power mode is supported when attached to a Full
+	 * Speed or Low Speed device in host mode.
+	 *	0 - Don't support low power mode (default)
+	 *	1 - Support low power mode
+	 */
+	int host_support_fs_ls_low_power;
+#define dwc_param_host_support_fs_ls_low_power_default	0
+
+	/*
+	 * Specifies the PHY clock rate in low power mode when connected to a
+	 * Low Speed device in host mode. This parameter is applicable only if
+	 * HOST_SUPPORT_FS_LS_LOW_POWER is enabled. If PHY_TYPE is set to FS
+	 * then defaults to 6 MHZ otherwise 48 MHZ.
+	 *
+	 *	0 - 48 MHz
+	 *	1 - 6 MHz
+	 */
+	int host_ls_low_power_phy_clk;
+#define dwc_param_host_ls_low_power_phy_clk_default	0
+#define DWC_HOST_LS_LOW_POWER_PHY_CLK_PARAM_48MHZ	0
+#define DWC_HOST_LS_LOW_POWER_PHY_CLK_PARAM_6MHZ	1
+
+	/*
+	 * 0 - Use cC FIFO size parameters
+	 * 1 - Allow dynamic FIFO sizing (default)
+	 */
+	int enable_dynamic_fifo;
+#define dwc_param_enable_dynamic_fifo_default		1
+
+	/*
+	 * Total number of 4-byte words in the data FIFO memory. This
+	 * memory includes the Rx FIFO, non-periodic Tx FIFO, and periodic
+	 * Tx FIFOs.  32 to 32768 (default 8192)
+	 *
+	 * Note: The total FIFO memory depth in the FPGA configuration is 8192.
+	 */
+	int data_fifo_size;
+#define dwc_param_data_fifo_size_default		8192
+
+	/*
+	 * Number of 4-byte words in the Rx FIFO in device mode when dynamic
+	 * FIFO sizing is enabled.  16 to 32768 (default 1064)
+	 */
+	int dev_rx_fifo_size;
+#define dwc_param_dev_rx_fifo_size_default		1064
+
+	/*
+	 * Number of 4-byte words in the non-periodic Tx FIFO in device mode
+	 * when dynamic FIFO sizing is enabled.  16 to 32768 (default 1024)
+	 */
+	int dev_nperio_tx_fifo_size;
+#define dwc_param_dev_nperio_tx_fifo_size_default	1024
+
+	/*
+	 * Number of 4-byte words in each of the periodic Tx FIFOs in device
+	 * mode when dynamic FIFO sizing is enabled.  4 to 768 (default 256)
+	 */
+	u32 dev_perio_tx_fifo_size[MAX_PERIO_FIFOS];
+#define dwc_param_dev_perio_tx_fifo_size_default	256
+
+	/*
+	 * Number of 4-byte words in the Rx FIFO in host mode when dynamic
+	 * FIFO sizing is enabled.  16 to 32768 (default 1024)
+	 */
+	int host_rx_fifo_size;
+#define dwc_param_host_rx_fifo_size_default		1024
+
+	/*
+	 * Number of 4-byte words in the non-periodic Tx FIFO in host mode
+	 * when Dynamic FIFO sizing is enabled in the core.  16 to 32768
+	 * (default 1024)
+	 */
+	int host_nperio_tx_fifo_size;
+#define dwc_param_host_nperio_tx_fifo_size_default	1024
+
+	/*
+	   Number of 4-byte words in the host periodic Tx FIFO when dynamic
+	 * FIFO sizing is enabled.  16 to 32768 (default 1024)
+	 */
+	int host_perio_tx_fifo_size;
+#define dwc_param_host_perio_tx_fifo_size_default	1024
+
+	/*
+	 * The maximum transfer size supported in bytes. 2047 to 65,535
+	 * (default 65,535)
+	 */
+	int max_transfer_size;
+#define dwc_param_max_transfer_size_default		65535
+
+	/*
+	 * The maximum number of packets in a transfer. 15 to 511  (default 511)
+	 */
+	int max_packet_count;
+#define dwc_param_max_packet_count_default		511
+
+	/*
+	 * The number of host channel registers to use.
+	 * 1 to 16 (default 12)
+	 * Note: The FPGA configuration supports a maximum of 12 host channels.
+	 */
+	int host_channels;
+#define dwc_param_host_channels_default			12
+
+	/*
+	 * The number of endpoints in addition to EP0 available for device
+	 * mode operations.
+	 * 1 to 15 (default 6 IN and OUT)
+	 * Note: The FPGA configuration supports a maximum of 6 IN and OUT
+	 * endpoints in addition to EP0.
+	 */
+	int dev_endpoints;
+#define dwc_param_dev_endpoints_default			6
+
+	/*
+	 * Specifies the type of PHY interface to use. By default, the driver
+	 * will automatically detect the phy_type.
+	 *
+	 *	0 - Full Speed PHY
+	 *	1 - UTMI+ (default)
+	 *	2 - ULPI
+	 */
+	int phy_type;
+#define DWC_PHY_TYPE_PARAM_FS			0
+#define DWC_PHY_TYPE_PARAM_UTMI			1
+#define DWC_PHY_TYPE_PARAM_ULPI			2
+#define dwc_param_phy_type_default		DWC_PHY_TYPE_PARAM_UTMI
+
+	/*
+	 * Specifies the UTMI+ Data Width.  This parameter is applicable for a
+	 * PHY_TYPE of UTMI+ or ULPI. (For a ULPI PHY_TYPE, this parameter
+	 * indicates the data width between the MAC and the ULPI Wrapper.) Also,
+	 * this parameter is applicable only if the OTG_HSPHY_WIDTH cC parameter
+	 * was set to "8 and 16 bits", meaning that the core has been configured
+	 * to work at either data path width.
+	 *
+	 * 8 or 16 bits (default 16)
+	 */
+	int phy_utmi_width;
+#define dwc_param_phy_utmi_width_default	16
+
+	/*
+	 * Specifies whether the ULPI operates at double or single
+	 * data rate. This parameter is only applicable if PHY_TYPE is
+	 * ULPI.
+	 *
+	 *	0 - single data rate ULPI interface with 8 bit wide data
+	 *		bus (default)
+	 *	1 - double data rate ULPI interface with 4 bit wide data
+	 *		bus
+	 */
+	int phy_ulpi_ddr;
+#define dwc_param_phy_ulpi_ddr_default		0
+
+	/*
+	 * Specifies whether to use the internal or external supply to
+	 * drive the vbus with a ULPI phy.
+	 */
+	int phy_ulpi_ext_vbus;
+#define DWC_PHY_ULPI_INTERNAL_VBUS		0
+#define DWC_PHY_ULPI_EXTERNAL_VBUS		1
+#define dwc_param_phy_ulpi_ext_vbus_default	DWC_PHY_ULPI_INTERNAL_VBUS
+
+	/*
+	 * Specifies whether to use the I2Cinterface for full speed PHY. This
+	 * parameter is only applicable if PHY_TYPE is FS.
+	 *	0 - No (default)
+	 *	1 - Yes
+	 */
+	int i2c_enable;
+#define dwc_param_i2c_enable_default		0
+
+	int ulpi_fs_ls;
+#define dwc_param_ulpi_fs_ls_default		0
+
+	int ts_dline;
+#define dwc_param_ts_dline_default		0
+
+	/*
+	 * Specifies whether dedicated transmit FIFOs are enabled for non
+	 * periodic IN endpoints in device mode
+	 *	0 - No
+	 *	1 - Yes
+	 */
+	 int en_multiple_tx_fifo;
+#define dwc_param_en_multiple_tx_fifo_default	1
+
+	/*
+	 * Number of 4-byte words in each of the Tx FIFOs in device
+	 * mode when dynamic FIFO sizing is enabled. 4 to 768 (default 256)
+	 */
+	u32 dev_tx_fifo_size[MAX_TX_FIFOS];
+#define dwc_param_dev_tx_fifo_size_default	256
+
+	/*
+	 * Thresholding enable flag
+	 *	bit 0 - enable non-ISO Tx thresholding
+	 *	bit 1 - enable ISO Tx thresholding
+	 *	bit 2 - enable Rx thresholding
+	 */
+	u32 thr_ctl;
+#define dwc_param_thr_ctl_default		0
+
+	/* Thresholding length for Tx FIFOs in 32 bit DWORDs */
+	u32 tx_thr_length;
+#define dwc_param_tx_thr_length_default		64
+
+	/* Thresholding length for Rx FIFOs in 32 bit DWORDs */
+	u32 rx_thr_length;
+#define dwc_param_rx_thr_length_default		64
+
+};
+
+/*
+ * The core_if structure contains information needed to manage the
+ * DWC_otg controller acting in either host or device mode. It represents the
+ * programming view of the controller as a whole.
+ */
+struct core_if {
+	/* Parameters that define how the core should be configured.*/
+	struct core_params *core_params;
+
+	/* Core Global registers starting at offset 000h. */
+	struct core_global_regs *core_global_regs;
+
+	/* Device-specific information */
+	struct device_if *dev_if;
+	/* Host-specific information */
+	struct dwc_host_if *host_if;
+
+	/*
+	 * Set to 1 if the core PHY interface bits in USBCFG have been
+	 * initialized.
+	 */
+	u8 phy_init_done;
+
+	/*
+	 * SRP Success flag, set by srp success interrupt in FS I2C mode
+	 */
+	u8 srp_success;
+	u8 srp_timer_started;
+
+	/* Common configuration information */
+	/* Power and Clock Gating Control Register */
+	u32 *pcgcctl;
+#define DWC_OTG_PCGCCTL_OFFSET			0xE00
+
+	/* Push/pop addresses for endpoints or host channels.*/
+	u32 *data_fifo[MAX_EPS_CHANNELS];
+#define DWC_OTG_DATA_FIFO_OFFSET		0x1000
+#define DWC_OTG_DATA_FIFO_SIZE			0x1000
+
+	/* Total RAM for FIFOs (Bytes) */
+	u16 total_fifo_size;
+	/* Size of Rx FIFO (Bytes) */
+	u16 rx_fifo_size;
+	/* Size of Non-periodic Tx FIFO (Bytes) */
+	u16 nperio_tx_fifo_size;
+
+	/* 1 if DMA is enabled, 0 otherwise. */
+	u8 dma_enable;
+
+	/* 1 if dedicated Tx FIFOs are enabled, 0 otherwise. */
+	u8 en_multiple_tx_fifo;
+
+	/*
+	 *  Set to 1 if multiple packets of a high-bandwidth transfer is in
+	 * process of being queued
+	 */
+	u8 queuing_high_bandwidth;
+
+	/* Hardware Configuration -- stored here for convenience.*/
+	union hwcfg1_data hwcfg1;
+	union hwcfg2_data hwcfg2;
+	union hwcfg3_data hwcfg3;
+	union hwcfg4_data hwcfg4;
+
+	/* HCD callbacks */
+	/* include/linux/usb/otg.h */
+
+	/* HCD callbacks */
+	struct cil_callbacks *hcd_cb;
+	/* PCD callbacks */
+	struct cil_callbacks *pcd_cb;
+
+	/* Device mode Periodic Tx FIFO Mask */
+	u32 p_tx_msk;
+	/* Device mode Periodic Tx FIFO Mask */
+	u32 tx_msk;
+
+	/* Features of various DWC implementation */
+	u32 features;
+
+	/* Added to support PLB DMA : phys-virt mapping */
+	resource_size_t phys_addr;
+
+	struct delayed_work usb_port_wakeup;
+	struct work_struct usb_port_otg;
+	struct otg_transceiver *xceiv;
+};
+
+/*
+ * The following functions support initialization of the CIL driver component
+ * and the DWC_otg controller.
+ */
+extern void dwc_otg_core_init(struct core_if *core_if);
+extern void init_fslspclksel(struct core_if *core_if);
+extern void dwc_otg_core_dev_init(struct core_if *core_if);
+extern const char *op_state_str(enum usb_otg_state state);
+extern void dwc_otg_enable_global_interrupts(struct core_if *core_if);
+extern void dwc_otg_disable_global_interrupts(struct core_if *core_if);
+extern void dwc_otg_enable_common_interrupts(struct core_if *core_if);
+
+/**
+ * This function Reads HPRT0 in preparation to modify.  It keeps the WC bits 0
+ * so that if they are read as 1, they won't clear when you write it back
+ */
+static inline u32 dwc_otg_read_hprt0(struct core_if *core_if)
+{
+	union hprt0_data hprt0;
+	hprt0.d32 = dwc_read_reg32(core_if->host_if->hprt0);
+	hprt0.b.prtena = 0;
+	hprt0.b.prtconndet = 0;
+	hprt0.b.prtenchng = 0;
+	hprt0.b.prtovrcurrchng = 0;
+	return hprt0.d32;
+}
+
+/*
+ * The following functions support managing the DWC_otg controller in either
+ * device or host mode.
+ */
+extern void dwc_otg_read_packet(struct core_if *core_if, u8 *dest,
+		u16 bytes);
+extern void dwc_otg_flush_tx_fifo(struct core_if *core_if, const int _num);
+extern void dwc_otg_flush_rx_fifo(struct core_if *core_if);
+
+#define NP_TXFIFO_EMPTY			-1
+#define MAX_NP_TXREQUEST_Q_SLOTS	8
+
+/**
+ * This function returns the Core Interrupt register.
+ */
+static inline u32 dwc_otg_read_core_intr(struct core_if *core_if)
+{
+	return dwc_read_reg32(&core_if->core_global_regs->gintsts) &
+		dwc_read_reg32(&core_if->core_global_regs->gintmsk);
+}
+
+/**
+ * This function returns the mode of the operation, host or device.
+ */
+static inline u32 dwc_otg_mode(struct core_if *core_if)
+{
+	return dwc_read_reg32(&core_if->core_global_regs->gintsts) & 0x1;
+}
+
+static inline u8 dwc_otg_is_device_mode(struct core_if *core_if)
+{
+	return dwc_otg_mode(core_if) != DWC_HOST_MODE;
+}
+static inline u8 dwc_otg_is_host_mode(struct core_if *core_if)
+{
+	return dwc_otg_mode(core_if) == DWC_HOST_MODE;
+}
+
+extern int dwc_otg_handle_common_intr(struct core_if *core_if);
+
+/*
+ * DWC_otg CIL callback structure.  This structure allows the HCD and PCD to
+ * register functions used for starting and stopping the PCD and HCD for role
+ * change on for a DRD.
+ */
+struct cil_callbacks {
+	/* Start function for role change */
+	int (*start) (void *_p);
+	/* Stop Function for role change */
+	int (*stop) (void *_p);
+	/* Disconnect Function for role change */
+	int (*disconnect) (void *_p);
+	/* Resume/Remote wakeup Function */
+	int (*resume_wakeup) (void *_p);
+	/* Suspend function */
+	int (*suspend) (void *_p);
+	/* Session Start (SRP) */
+	int (*session_start) (void *_p);
+	/* Pointer passed to start() and stop() */
+	void *p;
+};
+
+extern void dwc_otg_cil_register_pcd_callbacks(struct core_if *core_if,
+			struct cil_callbacks *cb, void *p);
+extern void dwc_otg_cil_register_hcd_callbacks(struct core_if *core_if,
+			struct cil_callbacks *cb, void *p);
+
+#define DWC_LIMITED_XFER		0x00000000
+#define DWC_DEVICE_ONLY			0x00000000
+#define DWC_HOST_ONLY			0x00000000
+
+#ifdef CONFIG_DWC_LIMITED_XFER_SIZE
+#undef DWC_LIMITED_XFER
+#define DWC_LIMITED_XFER		0x00000001
+#endif
+
+#ifdef CONFIG_DWC_DEVICE_ONLY
+#undef DWC_DEVICE_ONLY
+#define DWC_DEVICE_ONLY			0x00000002
+static inline void dwc_otg_hcd_remove(struct device *dev)
+{
+}
+static inline int dwc_otg_hcd_init(struct device *_dev,
+			struct dwc_otg_device *dwc_dev)
+{
+	return 0;
+}
+#else
+extern int  __init dwc_otg_hcd_init(struct device *_dev,
+			struct dwc_otg_device *dwc_dev);
+extern void dwc_otg_hcd_remove(struct device *_dev);
+#endif
+
+#ifdef CONFIG_DWC_HOST_ONLY
+#undef DWC_HOST_ONLY
+#define DWC_HOST_ONLY			0x00000004
+static inline void dwc_otg_pcd_remove(struct device *dev)
+{
+}
+static inline int dwc_otg_pcd_init(struct device *dev)
+{
+	return 0;
+}
+#else
+extern void dwc_otg_pcd_remove(struct device *dev);
+extern int  __init dwc_otg_pcd_init(struct device *dev);
+#endif
+
+extern void dwc_otg_cil_remove(struct core_if *core_if);
+extern struct core_if __devinit *dwc_otg_cil_init(const u32 *base,
+			struct core_params *params);
+
+static inline void dwc_set_feature(struct core_if *core_if)
+{
+	core_if->features = DWC_LIMITED_XFER | DWC_DEVICE_ONLY | DWC_HOST_ONLY;
+}
+
+static inline int dwc_has_feature(struct core_if *core_if,
+		unsigned long feature)
+{
+	return core_if->features & feature;
+}
+#endif
diff --git a/drivers/usb/dwc_otg/dwc_otg_cil_intr.c b/drivers/usb/dwc_otg/dwc_otg_cil_intr.c
new file mode 100644
index 0000000..0ef94d2
--- /dev/null
+++ b/drivers/usb/dwc_otg/dwc_otg_cil_intr.c
@@ -0,0 +1,626 @@
+/*
+ * DesignWare HS OTG controller driver
+ *
+ * Author: Mark Miesfeld <mmiesfeld@apm.com>
+ *
+ * Based on versions provided by APM and Synopsis which are:
+ *	Copyright (C) 2009-2010 AppliedMicro(www.apm.com)
+ * Modified by Stefan Roese <sr@denx.de>, DENX Software Engineering
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/*
+ * The Core Interface Layer provides basic services for accessing and
+ * managing the DWC_otg hardware. These services are used by both the
+ * Host Controller Driver and the Peripheral Controller Driver.
+ *
+ * This file contains the Common Interrupt handlers.
+ */
+#include <linux/delay.h>
+
+#include "dwc_otg_cil.h"
+
+/**
+ *  This function will log a debug message
+ */
+static int dwc_otg_handle_mode_mismatch_intr(struct core_if *core_if)
+{
+	union gintsts_data gintsts;
+
+	printk(KERN_WARNING "Mode Mismatch Interrupt: currently in %s mode\n",
+		dwc_otg_mode(core_if) ? "Host" : "Device");
+
+	/* Clear interrupt */
+	gintsts.d32 = 0;
+	gintsts.b.modemismatch = 1;
+	dwc_write_reg32(&core_if->core_global_regs->gintsts, gintsts.d32);
+
+	return 1;
+}
+
+/**
+ *  Start the HCD.  Helper function for using the HCD callbacks.
+ */
+static inline void hcd_start(struct core_if *core_if)
+{
+	if (core_if->hcd_cb && core_if->hcd_cb->start)
+		core_if->hcd_cb->start(core_if->hcd_cb->p);
+}
+
+/**
+ *  Stop the HCD.  Helper function for using the HCD callbacks.
+ */
+static inline void hcd_stop(struct core_if *core_if)
+{
+	if (core_if->hcd_cb && core_if->hcd_cb->stop)
+		core_if->hcd_cb->stop(core_if->hcd_cb->p);
+}
+
+/**
+ *  Disconnect the HCD.  Helper function for using the HCD callbacks.
+ */
+static inline void hcd_disconnect(struct core_if *core_if)
+{
+	if (core_if->hcd_cb && core_if->hcd_cb->disconnect)
+		core_if->hcd_cb->disconnect(core_if->hcd_cb->p);
+}
+
+/**
+ *  Inform the HCD the a New Session has begun.  Helper function for using the
+ *  HCD callbacks.
+ */
+static inline void hcd_session_start(struct core_if *core_if)
+{
+	if (core_if->hcd_cb && core_if->hcd_cb->session_start)
+		core_if->hcd_cb->session_start(core_if->hcd_cb->p);
+}
+
+/**
+ *  Start the PCD.  Helper function for using the PCD callbacks.
+ */
+static inline void pcd_start(struct core_if *core_if)
+{
+	if (core_if->pcd_cb && core_if->pcd_cb->start) {
+		struct dwc_pcd *pcd;
+		pcd = (struct dwc_pcd *)core_if->pcd_cb->p;
+		spin_lock(&pcd->lock);
+		core_if->pcd_cb->start(core_if->pcd_cb->p);
+		spin_unlock(&pcd->lock);
+	}
+}
+
+/**
+ *  Stop the PCD.  Helper function for using the PCD callbacks.
+ */
+static inline void pcd_stop(struct core_if *core_if)
+{
+	if (core_if->pcd_cb && core_if->pcd_cb->stop) {
+		struct dwc_pcd *pcd;
+		pcd = (struct dwc_pcd *)core_if->pcd_cb->p;
+		spin_lock(&pcd->lock);
+		core_if->pcd_cb->stop(core_if->pcd_cb->p);
+		spin_unlock(&pcd->lock);
+	}
+}
+
+/**
+ *  Suspend the PCD.  Helper function for using the PCD callbacks.
+ */
+static inline void pcd_suspend(struct core_if *core_if)
+{
+	if (core_if->pcd_cb && core_if->pcd_cb->suspend) {
+		struct dwc_pcd *pcd;
+		pcd = (struct dwc_pcd *)core_if->pcd_cb->p;
+		spin_lock(&pcd->lock);
+		core_if->pcd_cb->suspend(core_if->pcd_cb->p);
+		spin_unlock(&pcd->lock);
+	}
+}
+
+/**
+ *  Resume the PCD.  Helper function for using the PCD callbacks.
+ */
+static inline void pcd_resume(struct core_if *core_if)
+{
+	if (core_if->pcd_cb && core_if->pcd_cb->resume_wakeup) {
+		struct dwc_pcd *pcd;
+		pcd = (struct dwc_pcd *)core_if->pcd_cb->p;
+		spin_lock(&pcd->lock);
+		core_if->pcd_cb->resume_wakeup(core_if->pcd_cb->p);
+		spin_unlock(&pcd->lock);
+	}
+}
+
+/**
+ * This function handles the OTG Interrupts. It reads the OTG
+ * Interrupt Register (GOTGINT) to determine what interrupt has
+ * occurred.
+ */
+static int dwc_otg_handle_otg_intr(struct core_if *core_if)
+{
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+	union gotgint_data gotgint;
+	union gotgctl_data gotgctl;
+	union gintmsk_data gintmsk;
+
+	gotgint.d32 = dwc_read_reg32(&global_regs->gotgint);
+	gotgctl.d32 = dwc_read_reg32(&global_regs->gotgctl);
+
+	if (gotgint.b.sesenddet) {
+		gotgctl.d32 = dwc_read_reg32(&global_regs->gotgctl);
+		if (core_if->xceiv->state == OTG_STATE_B_HOST) {
+			pcd_start(core_if);
+			core_if->xceiv->state = OTG_STATE_B_PERIPHERAL;
+		} else {
+			/*
+			 * If not B_HOST and Device HNP still set. HNP did not
+			 * succeed
+			 */
+			if (gotgctl.b.devhnpen)
+				printk(KERN_ERR "Device Not Connected / "
+					"Responding\n");
+			/*
+			 * If Session End Detected the B-Cable has been
+			 * disconnected.  Reset PCD and Gadget driver to a
+			 * clean state.
+			 */
+			pcd_stop(core_if);
+		}
+		gotgctl.d32 = 0;
+		gotgctl.b.devhnpen = 1;
+		dwc_modify_reg32(&global_regs->gotgctl, gotgctl.d32, 0);
+	}
+	if (gotgint.b.sesreqsucstschng) {
+		gotgctl.d32 = dwc_read_reg32(&global_regs->gotgctl);
+		if (gotgctl.b.sesreqscs) {
+			if (core_if->core_params->phy_type ==
+					DWC_PHY_TYPE_PARAM_FS &&
+					core_if->core_params->i2c_enable) {
+				core_if->srp_success = 1;
+			} else {
+				pcd_resume(core_if);
+
+				/* Clear Session Request */
+				gotgctl.d32 = 0;
+				gotgctl.b.sesreq = 1;
+				dwc_modify_reg32(&global_regs->gotgctl,
+							gotgctl.d32, 0);
+			}
+		}
+	}
+	if (gotgint.b.hstnegsucstschng) {
+		/*
+		 * Print statements during the HNP interrupt handling can cause
+		 * it to fail.
+		 */
+		gotgctl.d32 = dwc_read_reg32(&global_regs->gotgctl);
+		if (gotgctl.b.hstnegscs) {
+			if (dwc_otg_is_host_mode(core_if)) {
+				core_if->xceiv->state = OTG_STATE_B_HOST;
+				/*
+				 * Need to disable SOF interrupt immediately.
+				 * When switching from device to host, the PCD
+				 * interrupt handler won't handle the
+				 * interrupt if host mode is already set. The
+				 * HCD interrupt handler won't get called if
+				 * the HCD state is HALT. This means that the
+				 * interrupt does not get handled and Linux
+				 * complains loudly.
+				 */
+				gintmsk.d32 = 0;
+				gintmsk.b.sofintr = 1;
+				dwc_modify_reg32(&global_regs->gintmsk,
+						gintmsk.d32, 0);
+				pcd_stop(core_if);
+				/* Initialize the Core for Host mode. */
+				hcd_start(core_if);
+				core_if->xceiv->state = OTG_STATE_B_HOST;
+			}
+		} else {
+			gotgctl.d32 = 0;
+			gotgctl.b.hnpreq = 1;
+			gotgctl.b.devhnpen = 1;
+			dwc_modify_reg32(&global_regs->gotgctl, gotgctl.d32, 0);
+
+			printk(KERN_ERR "Device Not Connected / Responding\n");
+		}
+	}
+	if (gotgint.b.hstnegdet) {
+		/*
+		 * The disconnect interrupt is set at the same time as
+		 * Host Negotiation Detected.  During the mode
+		 * switch all interrupts are cleared so the disconnect
+		 * interrupt handler will not get executed.
+		 */
+		if (dwc_otg_is_device_mode(core_if)) {
+			hcd_disconnect(core_if);
+			pcd_start(core_if);
+			core_if->xceiv->state = OTG_STATE_A_PERIPHERAL;
+		} else {
+			/*
+			 * Need to disable SOF interrupt immediately. When
+			 * switching from device to host, the PCD interrupt
+			 * handler won't handle the interrupt if host mode is
+			 * already set. The HCD interrupt handler won't get
+			 * called if the HCD state is HALT. This means that
+			 * the interrupt does not get handled and Linux
+			 * complains loudly.
+			 */
+			gintmsk.d32 = 0;
+			gintmsk.b.sofintr = 1;
+			dwc_modify_reg32(&global_regs->gintmsk, gintmsk.d32, 0);
+			pcd_stop(core_if);
+			hcd_start(core_if);
+			core_if->xceiv->state = OTG_STATE_A_HOST;
+		}
+	}
+	if (gotgint.b.adevtoutchng)
+		printk(KERN_INFO  " ++OTG Interrupt: A-Device Timeout "
+				"Change++\n");
+	if (gotgint.b.debdone)
+		printk(KERN_INFO  " ++OTG Interrupt: Debounce Done++\n");
+
+	/* Clear GOTGINT */
+	dwc_write_reg32(&core_if->core_global_regs->gotgint, gotgint.d32);
+	return 1;
+}
+
+/*
+ * Wakeup Workqueue implementation
+ */
+static void port_otg_wqfunc(struct work_struct *work)
+{
+	struct core_if *core_if = container_of(work, struct core_if,
+			usb_port_otg);
+	u32 count = 0;
+	union gotgctl_data gotgctl = {.d32 = 0};
+
+	printk(KERN_INFO "%s\n", __func__);
+	gotgctl.d32 = dwc_read_reg32(&core_if->core_global_regs->gotgctl);
+	if (gotgctl.b.conidsts) {
+		/*
+		 * B-Device connector (device mode) wait for switch to device
+		 * mode.
+		 */
+		while (!dwc_otg_is_device_mode(core_if) && ++count <= 10000) {
+			printk(KERN_INFO "Waiting for Peripheral Mode, "
+				"Mode=%s\n", dwc_otg_is_host_mode(core_if) ?
+				"Host" : "Peripheral");
+			msleep(100);
+		}
+		BUG_ON(count > 10000);
+		core_if->xceiv->state = OTG_STATE_B_PERIPHERAL;
+		dwc_otg_core_init(core_if);
+		dwc_otg_enable_global_interrupts(core_if);
+		pcd_start(core_if);
+	} else {
+		/*
+		 * A-Device connector (host mode) wait for switch to host
+		 * mode.
+		 */
+		while (!dwc_otg_is_host_mode(core_if) && ++count <= 10000) {
+			printk(KERN_INFO "Waiting for Host Mode, Mode=%s\n",
+				dwc_otg_is_host_mode(core_if) ?
+				"Host" : "Peripheral");
+			msleep(100);
+		}
+		BUG_ON(count > 10000);
+		core_if->xceiv->state = OTG_STATE_A_HOST;
+		dwc_otg_core_init(core_if);
+		dwc_otg_enable_global_interrupts(core_if);
+		hcd_start(core_if);
+	}
+}
+
+/**
+ * This function handles the Connector ID Status Change Interrupt.  It
+ * reads the OTG Interrupt Register (GOTCTL) to determine whether this
+ * is a Device to Host Mode transition or a Host Mode to Device
+ * Transition.
+ *
+ * This only occurs when the cable is connected/removed from the PHY
+ * connector.
+ */
+static int dwc_otg_handle_conn_id_status_change_intr(struct core_if *core_if)
+{
+	union gintsts_data gintsts = {.d32 = 0};
+	union gintmsk_data gintmsk = {.d32 = 0};
+
+	/*
+	 * Need to disable SOF interrupt immediately. If switching from device
+	 * to host, the PCD interrupt handler won't handle the interrupt if
+	 * host mode is already set. The HCD interrupt handler won't get
+	 * called if the HCD state is HALT. This means that the interrupt does
+	 * not get handled and Linux complains loudly.
+	 */
+	gintmsk.b.sofintr = 1;
+	dwc_modify_reg32(&core_if->core_global_regs->gintmsk, gintmsk.d32, 0);
+
+	INIT_WORK(&core_if->usb_port_otg, port_otg_wqfunc);
+	schedule_work(&core_if->usb_port_otg);
+
+	/* Set flag and clear interrupt */
+	gintsts.b.conidstschng = 1;
+	dwc_write_reg32(&core_if->core_global_regs->gintsts, gintsts.d32);
+	return 1;
+}
+
+/**
+ * This interrupt indicates that a device is initiating the Session
+ * Request Protocol to request the host to turn on bus power so a new
+ * session can begin. The handler responds by turning on bus power. If
+ * the DWC_otg controller is in low power mode, the handler brings the
+ * controller out of low power mode before turning on bus power.
+ */
+static int dwc_otg_handle_session_req_intr(struct core_if *core_if)
+{
+	union gintsts_data gintsts;
+
+	if (!dwc_has_feature(core_if, DWC_HOST_ONLY)) {
+		union hprt0_data hprt0;
+
+		if (dwc_otg_is_device_mode(core_if)) {
+			printk(KERN_INFO "SRP: Device mode\n");
+		} else {
+			printk(KERN_INFO "SRP: Host mode\n");
+
+			/* Turn on the port power bit. */
+			hprt0.d32 = dwc_otg_read_hprt0(core_if);
+			hprt0.b.prtpwr = 1;
+			dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+
+			/*
+			 * Start the Connection timer.
+			 * A message can be displayed,
+			 * if connect does not occur within 10 seconds.
+			 */
+			hcd_session_start(core_if);
+		}
+	}
+	/* Clear interrupt */
+	gintsts.d32 = 0;
+	gintsts.b.sessreqintr = 1;
+	dwc_write_reg32(&core_if->core_global_regs->gintsts, gintsts.d32);
+	return 1;
+}
+
+/**
+ * This interrupt indicates that the DWC_otg controller has detected a
+ * resume or remote wakeup sequence. If the DWC_otg controller is in
+ * low power mode, the handler must brings the controller out of low
+ * power mode. The controller automatically begins resume
+ * signaling. The handler schedules a time to stop resume signaling.
+ */
+static int dwc_otg_handle_wakeup_detected_intr(struct core_if *core_if)
+{
+	union gintsts_data gintsts;
+	struct device_if *dev_if = core_if->dev_if;
+
+	if (dwc_otg_is_device_mode(core_if)) {
+		union dctl_data dctl = {.d32 = 0};
+
+		/* Clear the Remote Wakeup Signalling */
+		dctl.b.rmtwkupsig = 1;
+		dwc_modify_reg32(&dev_if->dev_global_regs->dctl, dctl.d32, 0);
+
+		if (core_if->pcd_cb && core_if->pcd_cb->resume_wakeup)
+			core_if->pcd_cb->resume_wakeup(core_if->pcd_cb->p);
+	} else {
+		union pcgcctl_data pcgcctl = {.d32 = 0};
+
+		/* Restart the Phy Clock */
+		pcgcctl.b.stoppclk = 1;
+		dwc_modify_reg32(core_if->pcgcctl, pcgcctl.d32, 0);
+		schedule_delayed_work(&core_if->usb_port_wakeup, 10);
+	}
+
+	/* Clear interrupt */
+	gintsts.d32 = 0;
+	gintsts.b.wkupintr = 1;
+	dwc_write_reg32(&core_if->core_global_regs->gintsts, gintsts.d32);
+	return 1;
+}
+
+/**
+ * This interrupt indicates that a device has been disconnected from
+ * the root port.
+ */
+static int dwc_otg_handle_disconnect_intr(struct core_if *core_if)
+{
+	union gintsts_data gintsts;
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+
+	if (!dwc_has_feature(core_if, DWC_HOST_ONLY)) {
+		if (core_if->xceiv->state == OTG_STATE_B_HOST) {
+			hcd_disconnect(core_if);
+			pcd_start(core_if);
+			core_if->xceiv->state = OTG_STATE_B_PERIPHERAL;
+		} else if (dwc_otg_is_device_mode(core_if)) {
+			union gotgctl_data gotgctl = {.d32 = 0};
+
+			gotgctl.d32 =
+				dwc_read_reg32(&global_regs->gotgctl);
+
+			/*
+			 * If HNP is in process, do nothing.
+			 * The OTG "Host Negotiation Detected"
+			 * interrupt will do the mode switch.
+			 * Otherwise, since we are in device mode,
+			 * disconnect and stop the HCD,
+			 * then start the PCD.
+			 */
+			if (!gotgctl.b.devhnpen) {
+				hcd_disconnect(core_if);
+				pcd_start(core_if);
+				core_if->xceiv->state = OTG_STATE_B_PERIPHERAL;
+			}
+		} else if (core_if->xceiv->state == OTG_STATE_A_HOST) {
+			/* A-Cable still connected but device disconnected. */
+			hcd_disconnect(core_if);
+		}
+	}
+	gintsts.d32 = 0;
+	gintsts.b.disconnect = 1;
+	dwc_write_reg32(&global_regs->gintsts, gintsts.d32);
+	return 1;
+}
+
+/**
+ * This interrupt indicates that SUSPEND state has been detected on
+ * the USB.
+ *
+ * For HNP the USB Suspend interrupt signals the change from
+ * "a_peripheral" to "a_host".
+ *
+ * When power management is enabled the core will be put in low power
+ * mode.
+ */
+static int dwc_otg_handle_usb_suspend_intr(struct core_if *core_if)
+{
+	union dsts_data dsts;
+	union gintsts_data gintsts;
+	struct device_if *dev_if = core_if->dev_if;
+
+	if (dwc_otg_is_device_mode(core_if)) {
+		struct dwc_pcd *pcd;
+		/*
+		 * Check the Device status register to determine if the Suspend
+		 * state is active.
+		 */
+		dsts.d32 = dwc_read_reg32(&dev_if->dev_global_regs->dsts);
+		/* PCD callback for suspend. */
+		pcd = (struct dwc_pcd *)core_if->pcd_cb->p;
+		pcd_suspend(core_if);
+	} else {
+		if (core_if->xceiv->state == OTG_STATE_A_PERIPHERAL) {
+			/* Clear the a_peripheral flag, back to a_host. */
+			pcd_stop(core_if);
+			hcd_start(core_if);
+			core_if->xceiv->state = OTG_STATE_A_HOST;
+		}
+	}
+
+	/* Clear interrupt */
+	gintsts.d32 = 0;
+	gintsts.b.usbsuspend = 1;
+	dwc_write_reg32(&core_if->core_global_regs->gintsts, gintsts.d32);
+	return 1;
+}
+
+/**
+ * This function returns the Core Interrupt register.
+ *
+ * Although the Host Port interrupt (portintr) is documented as host mode
+ * only, it appears to occur in device mode when Port Enable / Disable Changed
+ * bit in HPRT0 is set. The code in dwc_otg_handle_common_intr checks if in
+ * device mode and just clears the interrupt.
+ */
+static inline u32 dwc_otg_read_common_intr(struct core_if *core_if)
+{
+	union gintsts_data gintsts;
+	union gintmsk_data gintmsk;
+	union gintmsk_data gintmsk_common = {.d32 = 0};
+	gintmsk_common.b.wkupintr = 1;
+	gintmsk_common.b.sessreqintr = 1;
+	gintmsk_common.b.conidstschng = 1;
+	gintmsk_common.b.otgintr = 1;
+	gintmsk_common.b.modemismatch = 1;
+	gintmsk_common.b.disconnect = 1;
+	gintmsk_common.b.usbsuspend = 1;
+	gintmsk_common.b.portintr = 1;
+
+	gintsts.d32 = dwc_read_reg32(&core_if->core_global_regs->gintsts);
+	gintmsk.d32 = dwc_read_reg32(&core_if->core_global_regs->gintmsk);
+
+	return (gintsts.d32 & gintmsk.d32) & gintmsk_common.d32;
+}
+
+/**
+ * Common interrupt handler.
+ *
+ * The common interrupts are those that occur in both Host and Device mode.
+ * This handler handles the following interrupts:
+ * - Mode Mismatch Interrupt
+ * - Disconnect Interrupt
+ * - OTG Interrupt
+ * - Connector ID Status Change Interrupt
+ * - Session Request Interrupt.
+ * - Resume / Remote Wakeup Detected Interrupt.
+ *
+ * - Host Port Interrupt.  Although this interrupt is documented as only
+ *   occurring in Host mode, it also occurs in Device mode when Port Enable /
+ *   Disable Changed bit in HPRT0 is set. If it is seen here, while in Device
+ *   mode, the interrupt is just cleared.
+ *
+ */
+int dwc_otg_handle_common_intr(struct core_if *core_if)
+{
+	int retval = 0;
+	union gintsts_data gintsts;
+
+	gintsts.d32 = dwc_otg_read_common_intr(core_if);
+
+	if (gintsts.b.modemismatch)
+		retval |= dwc_otg_handle_mode_mismatch_intr(core_if);
+	if (gintsts.b.otgintr)
+		retval |= dwc_otg_handle_otg_intr(core_if);
+	if (gintsts.b.conidstschng)
+		retval |= dwc_otg_handle_conn_id_status_change_intr(core_if);
+	if (gintsts.b.disconnect)
+		retval |= dwc_otg_handle_disconnect_intr(core_if);
+	if (gintsts.b.sessreqintr)
+		retval |= dwc_otg_handle_session_req_intr(core_if);
+	if (gintsts.b.wkupintr)
+		retval |= dwc_otg_handle_wakeup_detected_intr(core_if);
+	if (gintsts.b.usbsuspend)
+		retval |= dwc_otg_handle_usb_suspend_intr(core_if);
+
+	if (gintsts.b.portintr && dwc_otg_is_device_mode(core_if)) {
+		gintsts.d32 = 0;
+		gintsts.b.portintr = 1;
+		dwc_write_reg32(&core_if->core_global_regs->gintsts,
+				gintsts.d32);
+		retval |= 1;
+		printk(KERN_INFO "RECEIVED PORTINT while in Device mode\n");
+	}
+
+	return retval;
+}
diff --git a/drivers/usb/dwc_otg/dwc_otg_driver.h b/drivers/usb/dwc_otg/dwc_otg_driver.h
new file mode 100644
index 0000000..65c7c87
--- /dev/null
+++ b/drivers/usb/dwc_otg/dwc_otg_driver.h
@@ -0,0 +1,94 @@
+/*
+ * DesignWare HS OTG controller driver
+ *
+ * Author: Mark Miesfeld <mmiesfeld@apm.com>
+ *
+ * Based on versions provided by APM and Synopsis which are:
+ *	Copyright (C) 2009-2010 AppliedMicro(www.apm.com)
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#if !defined(__DWC_OTG_DRIVER_H__)
+#define __DWC_OTG_DRIVER_H__
+
+/*
+ * This file contains the interface to the Linux driver.
+ */
+#include "dwc_otg_cil.h"
+
+/*
+ * This structure is a wrapper that encapsulates the driver components used to
+ * manage a single DWC_otg controller.
+ */
+struct dwc_otg_device {
+	/* Base address returned from ioremap() */
+	void *base;
+
+	/* Pointer to the core interface structure. */
+	struct core_if *core_if;
+
+	/* Register offset for Diagnostic API.*/
+	u32 reg_offset;
+
+	/* Pointer to the PCD structure. */
+	struct dwc_pcd *pcd;
+
+	/* Pointer to the HCD structure. */
+	struct dwc_hcd *hcd;
+
+	/* Flag to indicate whether the common IRQ handler is installed. */
+	u8 common_irq_installed;
+
+	/* Interrupt request number. */
+	unsigned int irq;
+
+	/*
+	 * Physical address of Control and Status registers, used by
+	 * release_mem_region().
+	 */
+	resource_size_t phys_addr;
+
+	/* Length of memory region, used by release_mem_region(). */
+	unsigned long base_len;
+};
+extern struct core_params dwc_otg_module_params;
+extern int __devinit check_parameters(struct core_if *core_if);
+#endif
diff --git a/drivers/usb/dwc_otg/dwc_otg_hcd.c b/drivers/usb/dwc_otg/dwc_otg_hcd.c
new file mode 100644
index 0000000..5c25522
--- /dev/null
+++ b/drivers/usb/dwc_otg/dwc_otg_hcd.c
@@ -0,0 +1,2408 @@
+/*
+ * DesignWare HS OTG controller driver
+ *
+ * Author: Mark Miesfeld <mmiesfeld@apm.com>
+ *
+ * Based on versions provided by APM and Synopsis which are:
+ *	Copyright (C) 2009-2010 AppliedMicro(www.apm.com)
+ * Modified by Stefan Roese <sr@denx.de>, DENX Software Engineering
+ * Modified by Chuck Meade <chuck@theptrgroup.com>
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/*
+ * This file contains the implementation of the HCD. In Linux, the HCD
+ * implements the hc_driver API.
+ */
+
+#include <asm/unaligned.h>
+#include <linux/dma-mapping.h>
+
+#include "dwc_otg_hcd.h"
+
+static const char dwc_otg_hcd_name[] = "dwc_otg_hcd";
+
+/**
+ * Clears the transfer state for a host channel. This function is normally
+ * called after a transfer is done and the host channel is being released. It
+ * clears the channel interrupt enables and any unhandled channel interrupt
+ * conditions.
+ */
+void dwc_otg_hc_cleanup(struct core_if *core_if, struct dwc_hc *hc)
+{
+	struct dwc_hc_regs *regs;
+	hc->xfer_started = 0;
+
+	regs = core_if->host_if->hc_regs[hc->hc_num];
+	dwc_write_reg32(&regs->hcintmsk, 0);
+	dwc_write_reg32(&regs->hcint, 0xFFFFFFFF);
+}
+
+/**
+ * This function enables the Host mode interrupts.
+ */
+static void dwc_otg_enable_host_interrupts(struct core_if *core_if)
+{
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+	union gintmsk_data intr_mask = {.d32 = 0};
+
+	/* Disable all interrupts. */
+	dwc_write_reg32(&global_regs->gintmsk, 0);
+
+	/* Clear any pending interrupts. */
+	dwc_write_reg32(&global_regs->gintsts, 0xFFFFFFFF);
+
+	/* Enable the common interrupts */
+	dwc_otg_enable_common_interrupts(core_if);
+
+	/*
+	 * Enable host mode interrupts without disturbing common
+	 * interrupts.
+	 */
+	intr_mask.b.sofintr = 1;
+	intr_mask.b.portintr = 1;
+	intr_mask.b.hcintr = 1;
+	dwc_modify_reg32(&global_regs->gintmsk, intr_mask.d32, intr_mask.d32);
+}
+
+/**
+ * This function initializes the DWC_otg controller registers for
+ * host mode.
+ *
+ * This function flushes the Tx and Rx FIFOs and it flushes any entries in the
+ * request queues. Host channels are reset to ensure that they are ready for
+ * performing transfers.
+ */
+static void dwc_otg_core_host_init(struct core_if *core_if)
+{
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+	struct dwc_host_if *host_if = core_if->host_if;
+	struct core_params *params = core_if->core_params;
+	union hprt0_data hprt0 = {.d32 = 0};
+	union fifosize_data nptxfifosize;
+	union fifosize_data ptxfifosize;
+	u32 i;
+	union hcchar_data hcchar;
+	union hcfg_data hcfg;
+	struct dwc_hc_regs *hc_regs;
+	int num_channels;
+	union gotgctl_data gotgctl = {.d32 = 0};
+
+	/* Restart the Phy Clock */
+	dwc_write_reg32(core_if->pcgcctl, 0);
+
+	/* Initialize Host Configuration Register */
+	init_fslspclksel(core_if);
+	if (core_if->core_params->speed == DWC_SPEED_PARAM_FULL) {
+		hcfg.d32 = dwc_read_reg32(&host_if->host_global_regs->hcfg);
+		hcfg.b.fslssupp = 1;
+		dwc_write_reg32(&host_if->host_global_regs->hcfg, hcfg.d32);
+	}
+
+	/* Configure data FIFO sizes */
+	if (core_if->hwcfg2.b.dynamic_fifo && params->enable_dynamic_fifo) {
+		/* Rx FIFO */
+		dwc_write_reg32(&global_regs->grxfsiz,
+			params->host_rx_fifo_size);
+
+		/* Non-periodic Tx FIFO */
+		nptxfifosize.b.depth = params->host_nperio_tx_fifo_size;
+		nptxfifosize.b.startaddr = params->host_rx_fifo_size;
+		dwc_write_reg32(&global_regs->gnptxfsiz, nptxfifosize.d32);
+
+		/* Periodic Tx FIFO */
+		ptxfifosize.b.depth = params->host_perio_tx_fifo_size;
+		ptxfifosize.b.startaddr = nptxfifosize.b.startaddr +
+				nptxfifosize.b.depth;
+		dwc_write_reg32(&global_regs->hptxfsiz, ptxfifosize.d32);
+	}
+
+	/* Clear Host Set HNP Enable in the OTG Control Register */
+	gotgctl.b.hstsethnpen = 1;
+	dwc_modify_reg32(&global_regs->gotgctl, gotgctl.d32, 0);
+
+	/* Make sure the FIFOs are flushed. */
+	dwc_otg_flush_tx_fifo(core_if, DWC_GRSTCTL_TXFNUM_ALL);
+	dwc_otg_flush_rx_fifo(core_if);
+
+	/* Flush out any leftover queued requests. */
+	num_channels = core_if->core_params->host_channels;
+	for (i = 0; i < num_channels; i++) {
+		hc_regs = core_if->host_if->hc_regs[i];
+		hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+		hcchar.b.chen = 0;
+		hcchar.b.chdis = 1;
+		hcchar.b.epdir = 0;
+		dwc_write_reg32(&hc_regs->hcchar, hcchar.d32);
+	}
+
+	/* Halt all channels to put them into a known state. */
+	for (i = 0; i < num_channels; i++) {
+		int count = 0;
+		hc_regs = core_if->host_if->hc_regs[i];
+		hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+		hcchar.b.chen = 1;
+		hcchar.b.chdis = 1;
+		hcchar.b.epdir = 0;
+		dwc_write_reg32(&hc_regs->hcchar, hcchar.d32);
+
+		do {
+			hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+			if (++count > 200) {
+				printk(KERN_ERR "%s: Unable to clear halt on "
+						"channel %d\n",	__func__, i);
+				break;
+			}
+			udelay(100);
+		} while (hcchar.b.chen);
+	}
+
+	/* Turn on the vbus power. */
+	printk(KERN_INFO "Init: Port Power? op_state=%s\n",
+			op_state_str(core_if->xceiv->state));
+
+	if (core_if->xceiv->state == OTG_STATE_A_HOST) {
+		hprt0.d32 = dwc_otg_read_hprt0(core_if);
+		printk(KERN_INFO "Init: Power Port (%d)\n", hprt0.b.prtpwr);
+		if (hprt0.b.prtpwr == 0) {
+			hprt0.b.prtpwr = 1;
+			dwc_write_reg32(host_if->hprt0, hprt0.d32);
+		}
+	}
+	dwc_otg_enable_host_interrupts(core_if);
+}
+
+/**
+ * Initializes dynamic portions of the DWC_otg HCD state.
+ */
+static void hcd_reinit(struct dwc_hcd *hcd)
+{
+	struct list_head *item;
+	int num_channels;
+	u32 i;
+	struct dwc_hc *channel;
+
+	hcd->flags.d32 = 0;
+	hcd->non_periodic_qh_ptr = &hcd->non_periodic_sched_active;
+	hcd->available_host_channels = hcd->core_if->core_params->host_channels;
+
+	/*
+	 * Put all channels in the free channel list and clean up channel
+	 * states.
+	 */
+	item = hcd->free_hc_list.next;
+	while (item != &hcd->free_hc_list) {
+		list_del(item);
+		item = hcd->free_hc_list.next;
+	}
+
+	num_channels = hcd->core_if->core_params->host_channels;
+	for (i = 0; i < num_channels; i++) {
+		channel = hcd->hc_ptr_array[i];
+		list_add_tail(&channel->hc_list_entry, &hcd->free_hc_list);
+		dwc_otg_hc_cleanup(hcd->core_if, channel);
+	}
+
+	/* Initialize the DWC core for host mode operation. */
+	dwc_otg_core_host_init(hcd->core_if);
+}
+
+/* Gets the dwc_hcd from a struct usb_hcd */
+static inline struct dwc_hcd *hcd_to_dwc_otg_hcd(struct usb_hcd *hcd)
+{
+	return (struct dwc_hcd *) hcd->hcd_priv;
+}
+
+/**
+ * Initializes the DWC_otg controller and its root hub and prepares it for host
+ * mode operation. Activates the root port. Returns 0 on success and a negative
+ * error code on failure.
+*/
+static int dwc_otg_hcd_start(struct usb_hcd *hcd)
+{
+	struct dwc_hcd *dwc_hcd = hcd_to_dwc_otg_hcd(hcd);
+	struct usb_bus *bus = hcd_to_bus(hcd);
+
+	hcd->state = HC_STATE_RUNNING;
+
+	/* Inform the HUB driver to resume. */
+	if (bus->root_hub)
+		usb_hcd_resume_root_hub(hcd);
+
+	hcd_reinit(dwc_hcd);
+	return 0;
+}
+
+/**
+ * Work queue function for starting the HCD when A-Cable is connected.
+ * The dwc_otg_hcd_start() must be called in a process context.
+ */
+static void hcd_start_func(struct work_struct *work)
+{
+	struct dwc_hcd *priv =
+		container_of(work, struct dwc_hcd, start_work);
+	struct usb_hcd *usb_hcd = (struct usb_hcd *) priv->_p;
+
+	if (usb_hcd)
+		dwc_otg_hcd_start(usb_hcd);
+}
+
+/**
+ * HCD Callback function for starting the HCD when A-Cable is
+ * connected.
+ */
+static int dwc_otg_hcd_start_cb(void *_p)
+{
+	struct dwc_hcd *dwc_hcd = hcd_to_dwc_otg_hcd(_p);
+	struct core_if *core_if = dwc_hcd->core_if;
+	union hprt0_data hprt0;
+
+	if (core_if->xceiv->state == OTG_STATE_B_HOST) {
+		/*
+		 * Reset the port.  During a HNP mode switch the reset
+		 * needs to occur within 1ms and have a duration of at
+		 * least 50ms.
+		 */
+		hprt0.d32 = dwc_otg_read_hprt0(core_if);
+		hprt0.b.prtrst = 1;
+		dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+		((struct usb_hcd *) _p)->self.is_b_host = 1;
+	} else {
+		((struct usb_hcd *) _p)->self.is_b_host = 0;
+	}
+
+	/* Need to start the HCD in a non-interrupt context. */
+	dwc_hcd->_p = _p;
+	schedule_work(&dwc_hcd->start_work);
+	return 1;
+}
+
+/**
+ * This function disables the Host Mode interrupts.
+ */
+static void dwc_otg_disable_host_interrupts(struct core_if *core_if)
+{
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+	union gintmsk_data intr_mask = {.d32 = 0};
+
+	/*
+	 * Disable host mode interrupts without disturbing common
+	 * interrupts.
+	*/
+	intr_mask.b.sofintr = 1;
+	intr_mask.b.portintr = 1;
+	intr_mask.b.hcintr = 1;
+	intr_mask.b.ptxfempty = 1;
+	intr_mask.b.nptxfempty = 1;
+	dwc_modify_reg32(&global_regs->gintmsk, intr_mask.d32, 0);
+}
+
+/**
+ * Halts the DWC_otg host mode operations in a clean manner. USB transfers are
+ * stopped.
+ */
+static void dwc_otg_hcd_stop(struct usb_hcd *hcd)
+{
+	struct dwc_hcd *dwc_hcd = hcd_to_dwc_otg_hcd(hcd);
+	union hprt0_data hprt0 = {.d32 = 0};
+
+	/* Turn off all host-specific interrupts. */
+	dwc_otg_disable_host_interrupts(dwc_hcd->core_if);
+
+	/*
+	 * The root hub should be disconnected before this function is called.
+	 * The disconnect will clear the QTD lists (via ..._hcd_urb_dequeue)
+	 * and the QH lists (via ..._hcd_endpoint_disable).
+	 */
+
+	/* Turn off the vbus power */
+	printk(KERN_INFO "PortPower off\n");
+	hprt0.b.prtpwr = 0;
+	dwc_write_reg32(dwc_hcd->core_if->host_if->hprt0, hprt0.d32);
+}
+
+/**
+ * HCD Callback function for stopping the HCD.
+ */
+static int dwc_otg_hcd_stop_cb(void *_p)
+{
+	struct usb_hcd *usb_hcd = (struct usb_hcd *) _p;
+
+	dwc_otg_hcd_stop(usb_hcd);
+	return 1;
+}
+
+static void del_timers(struct dwc_hcd *hcd)
+{
+	del_timer_sync(&hcd->conn_timer);
+}
+
+/**
+ * Processes all the URBs in a single list of QHs. Completes them with
+ * -ETIMEDOUT and frees the QTD.
+ */
+static void kill_urbs_in_qh_list(struct dwc_hcd *hcd, struct list_head *qh_list)
+{
+	struct list_head *qh_item, *q;
+
+	qh_item = qh_list->next;
+
+	list_for_each_safe(qh_item, q, qh_list) {
+		struct dwc_qh *qh;
+		struct list_head *qtd_item;
+		struct dwc_qtd *qtd;
+
+		qh = list_entry(qh_item, struct dwc_qh, qh_list_entry);
+		qtd_item = qh->qtd_list.next;
+		qtd = list_entry(qtd_item, struct dwc_qtd, qtd_list_entry);
+		if (qtd->urb != NULL) {
+			spin_lock(&hcd->lock);
+			dwc_otg_hcd_complete_urb(hcd, qtd->urb, -ETIMEDOUT);
+			dwc_otg_hcd_qtd_remove_and_free(qtd);
+			spin_unlock(&hcd->lock);
+		}
+	}
+}
+
+/**
+ * Responds with an error status of ETIMEDOUT to all URBs in the non-periodic
+ * and periodic schedules. The QTD associated with each URB is removed from
+ * the schedule and freed. This function may be called when a disconnect is
+ * detected or when the HCD is being stopped.
+ */
+static void kill_all_urbs(struct dwc_hcd *hcd)
+{
+	kill_urbs_in_qh_list(hcd, &hcd->non_periodic_sched_deferred);
+	kill_urbs_in_qh_list(hcd, &hcd->non_periodic_sched_inactive);
+	kill_urbs_in_qh_list(hcd, &hcd->non_periodic_sched_active);
+	kill_urbs_in_qh_list(hcd, &hcd->periodic_sched_inactive);
+	kill_urbs_in_qh_list(hcd, &hcd->periodic_sched_ready);
+	kill_urbs_in_qh_list(hcd, &hcd->periodic_sched_assigned);
+	kill_urbs_in_qh_list(hcd, &hcd->periodic_sched_queued);
+}
+
+/**
+ * HCD Callback function for disconnect of the HCD.
+ */
+static int dwc_otg_hcd_disconnect_cb(void *_p)
+{
+	union gintsts_data intr;
+	struct dwc_hcd *hcd = hcd_to_dwc_otg_hcd(_p);
+	struct core_if *core_if = hcd->core_if;
+
+	/* Set status flags for the hub driver. */
+	hcd->flags.b.port_connect_status_change = 1;
+	hcd->flags.b.port_connect_status = 0;
+
+	/*
+	 * Shutdown any transfers in process by clearing the Tx FIFO Empty
+	 * interrupt mask and status bits and disabling subsequent host
+	 * channel interrupts.
+	 */
+	intr.d32 = 0;
+	intr.b.nptxfempty = 1;
+	intr.b.ptxfempty = 1;
+	intr.b.hcintr = 1;
+	dwc_modify_reg32(gintmsk_reg(hcd), intr.d32, 0);
+	dwc_modify_reg32(gintsts_reg(hcd), intr.d32, 0);
+
+	del_timers(hcd);
+
+	/*
+	 * Turn off the vbus power only if the core has transitioned to device
+	 * mode. If still in host mode, need to keep power on to detect a
+	 * reconnection.
+	 */
+	if (dwc_otg_is_device_mode(core_if)) {
+		if (core_if->xceiv->state != OTG_STATE_A_SUSPEND) {
+			union hprt0_data hprt0 = {.d32 = 0};
+			printk(KERN_INFO "Disconnect: PortPower off\n");
+			hprt0.b.prtpwr = 0;
+			dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+		}
+		dwc_otg_disable_host_interrupts(core_if);
+	}
+
+	/* Respond with an error status to all URBs in the schedule. */
+	kill_all_urbs(hcd);
+	if (dwc_otg_is_host_mode(core_if)) {
+		/* Clean up any host channels that were in use. */
+		int num_channels;
+		u32 i;
+		struct dwc_hc *channel;
+		struct dwc_hc_regs *regs;
+		union hcchar_data hcchar;
+
+		num_channels = core_if->core_params->host_channels;
+		if (!core_if->dma_enable) {
+			/* Flush out any channel requests in slave mode. */
+			for (i = 0; i < num_channels; i++) {
+				channel = hcd->hc_ptr_array[i];
+				if (list_empty(&channel->hc_list_entry)) {
+					regs = core_if->host_if->hc_regs[i];
+					hcchar.d32 = dwc_read_reg32(
+							&regs->hcchar);
+
+					if (hcchar.b.chen) {
+						hcchar.b.chen = 0;
+						hcchar.b.chdis = 1;
+						hcchar.b.epdir = 0;
+						dwc_write_reg32(&regs->hcchar,
+								hcchar.d32);
+					}
+				}
+			}
+		}
+
+		for (i = 0; i < num_channels; i++) {
+			channel = hcd->hc_ptr_array[i];
+			if (list_empty(&channel->hc_list_entry)) {
+				regs = core_if->host_if->hc_regs[i];
+				hcchar.d32 = dwc_read_reg32(&regs->hcchar);
+
+				if (hcchar.b.chen) {
+					/* Halt the channel. */
+					hcchar.b.chdis = 1;
+					dwc_write_reg32(&regs->hcchar,
+							hcchar.d32);
+				}
+				dwc_otg_hc_cleanup(core_if, channel);
+				list_add_tail(&channel->hc_list_entry,
+						&hcd->free_hc_list);
+			}
+		}
+	}
+
+	/*
+	 * A disconnect will end the session so the B-Device is no
+	 * longer a B-host.
+	 */
+	((struct usb_hcd *) _p)->self.is_b_host = 0;
+	return 1;
+}
+
+/**
+ * Connection timeout function.  An OTG host is required to display a
+ * message if the device does not connect within 10 seconds.
+ */
+static void dwc_otg_hcd_connect_timeout(unsigned long _ptr)
+{
+	printk(KERN_INFO "Connect Timeout\n");
+	printk(KERN_ERR "Device Not Connected/Responding\n");
+}
+
+/**
+ * Start the connection timer.  An OTG host is required to display a
+ * message if the device does not connect within 10 seconds.  The
+ * timer is deleted if a port connect interrupt occurs before the
+ * timer expires.
+ */
+static void dwc_otg_hcd_start_connect_timer(struct dwc_hcd *hcd)
+{
+	init_timer(&hcd->conn_timer);
+	hcd->conn_timer.function = dwc_otg_hcd_connect_timeout;
+	hcd->conn_timer.data = (unsigned long)0;
+	hcd->conn_timer.expires = jiffies + (HZ * 10);
+	add_timer(&hcd->conn_timer);
+}
+
+/**
+ * HCD Callback function for disconnect of the HCD.
+ */
+static int dwc_otg_hcd_session_start_cb(void *_p)
+{
+	struct dwc_hcd *hcd = hcd_to_dwc_otg_hcd(_p);
+
+	dwc_otg_hcd_start_connect_timer(hcd);
+	return 1;
+}
+
+/* HCD Callback structure for handling mode switching. */
+static struct cil_callbacks hcd_cil_callbacks = {
+	.start = dwc_otg_hcd_start_cb,
+	.stop = dwc_otg_hcd_stop_cb,
+	.disconnect = dwc_otg_hcd_disconnect_cb,
+	.session_start = dwc_otg_hcd_session_start_cb,
+	.p = 0,
+};
+
+/*
+ * Reset Workqueue implementation
+ */
+static void port_reset_wqfunc(struct work_struct *work)
+{
+	struct dwc_hcd *hcd = container_of(work, struct dwc_hcd,
+				usb_port_reset);
+	struct core_if *core_if = hcd->core_if;
+	union hprt0_data hprt0;
+	unsigned long flags;
+
+	printk(KERN_INFO "%s\n", __func__);
+	spin_lock_irqsave(&hcd->lock, flags);
+	hprt0.d32 = dwc_otg_read_hprt0(core_if);
+	hprt0.b.prtrst = 1;
+	dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+	spin_unlock_irqrestore(&hcd->lock, flags);
+	msleep(60);
+	spin_lock_irqsave(&hcd->lock, flags);
+	hprt0.b.prtrst = 0;
+	dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+	hcd->flags.b.port_reset_change = 1;
+	spin_unlock_irqrestore(&hcd->lock, flags);
+}
+
+/*
+ * Wakeup Workqueue implementation
+ */
+static void port_wakeup_wqfunc(struct work_struct *work)
+{
+	struct core_if *core_if = container_of(to_delayed_work(work),
+			struct core_if, usb_port_wakeup);
+	union hprt0_data hprt0;
+
+	printk(KERN_INFO "%s\n", __func__);
+	/* Now wait for 70 ms. */
+	hprt0.d32 = dwc_otg_read_hprt0(core_if);
+	msleep(70);
+	hprt0.b.prtres = 0;	/* Resume */
+	dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+}
+
+/**
+ * Starts processing a USB transfer request specified by a USB Request Block
+ * (URB). mem_flags indicates the type of memory allocation to use while
+ * processing this URB.
+ */
+static int dwc_otg_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
+				gfp_t _mem_flags)
+{
+	int retval;
+	unsigned long flags;
+	struct dwc_hcd *dwc_hcd = hcd_to_dwc_otg_hcd(hcd);
+	struct dwc_qtd *qtd;
+
+	if (!dwc_hcd->flags.b.port_connect_status) {
+		/* No longer connected. */
+		retval = -ENODEV;
+		goto err_enq;
+	}
+
+	qtd = dwc_otg_hcd_qtd_create(urb, _mem_flags);
+	if (!qtd) {
+		printk(KERN_ERR "DWC OTG HCD URB Enqueue failed creating "
+					"QTD\n");
+		retval = -ENOMEM;
+		goto err_enq;
+	}
+
+	spin_lock_irqsave(&dwc_hcd->lock, flags);
+	retval = usb_hcd_link_urb_to_ep(hcd, urb);
+	if (unlikely(retval))
+		goto fail;
+
+	retval = dwc_otg_hcd_qtd_add(qtd, dwc_hcd);
+	if (retval < 0) {
+		printk(KERN_ERR "DWC OTG HCD URB Enqueue failed adding QTD. "
+				"Error status %d\n", retval);
+		usb_hcd_unlink_urb_from_ep(hcd, urb);
+		goto fail;
+	}
+
+fail:
+	if (retval)
+		dwc_otg_hcd_qtd_free(qtd);
+
+	spin_unlock_irqrestore(&dwc_hcd->lock, flags);
+err_enq:
+
+	return retval;
+}
+
+/**
+ * Attempts to halt a host channel. This function should only be called in
+ * Slave mode or to abort a transfer in either Slave mode or DMA mode. Under
+ * normal circumstances in DMA mode, the controller halts the channel when the
+ * transfer is complete or a condition occurs that requires application
+ * intervention.
+ *
+ * In slave mode, checks for a free request queue entry, then sets the Channel
+ * Enable and Channel Disable bits of the Host Channel Characteristics
+ * register of the specified channel to intiate the halt. If there is no free
+ * request queue entry, sets only the Channel Disable bit of the HCCHARn
+ * register to flush requests for this channel. In the latter case, sets a
+ * flag to indicate that the host channel needs to be halted when a request
+ * queue slot is open.
+ *
+ * In DMA mode, always sets the Channel Enable and Channel Disable bits of the
+ * HCCHARn register. The controller ensures there is space in the request
+ * queue before submitting the halt request.
+ *
+ * Some time may elapse before the core flushes any posted requests for this
+ * host channel and halts. The Channel Halted interrupt handler completes the
+ * deactivation of the host channel.
+ */
+void dwc_otg_hc_halt(struct core_if *core_if, struct dwc_hc *hc,
+			enum dwc_halt_status hlt_sts)
+{
+	union gnptxsts_data nptxsts;
+	union hptxsts_data hptxsts;
+	union hcchar_data hcchar;
+	struct dwc_hc_regs *hc_regs;
+	struct core_global_regs *global_regs;
+	struct host_global_regs *host_global_regs;
+
+	hc_regs = core_if->host_if->hc_regs[hc->hc_num];
+	global_regs = core_if->core_global_regs;
+	host_global_regs = core_if->host_if->host_global_regs;
+
+	WARN_ON(hlt_sts == DWC_OTG_HC_XFER_NO_HALT_STATUS);
+
+	if (hlt_sts == DWC_OTG_HC_XFER_URB_DEQUEUE ||
+			hlt_sts == DWC_OTG_HC_XFER_AHB_ERR) {
+		/*
+		 * Disable all channel interrupts except Ch Halted. The QTD
+		 * and QH state associated with this transfer has been cleared
+		 * (in the case of URB_DEQUEUE), so the channel needs to be
+		 * shut down carefully to prevent crashes.
+		 */
+		union hcintmsk_data hcintmsk;
+		hcintmsk.d32 = 0;
+		hcintmsk.b.chhltd = 1;
+		dwc_write_reg32(&hc_regs->hcintmsk, hcintmsk.d32);
+
+		/*
+		 * Make sure no other interrupts besides halt are currently
+		 * pending. Handling another interrupt could cause a crash due
+		 * to the QTD and QH state.
+		 */
+		dwc_write_reg32(&hc_regs->hcint, ~hcintmsk.d32);
+
+		/*
+		 * Make sure the halt status is set to URB_DEQUEUE or AHB_ERR
+		 * even if the channel was already halted for some other reason.
+		 */
+		hc->halt_status = hlt_sts;
+
+		/*
+		 * If the channel is not enabled, the channel is either already
+		 * halted or it hasn't started yet. In DMA mode, the transfer
+		 * may halt if it finishes normally or a condition occurs that
+		 * requires driver intervention. Don't want to halt the channel
+		 * again. In either Slave or DMA mode, it's possible that the
+		 * transfer has been assigned to a channel, but not started yet
+		 * when an URB is dequeued. Don't want to halt a channel that
+		 * hasn't started yet.
+		 */
+		hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+		if (!hcchar.b.chen)
+			return;
+	}
+
+	if (hc->halt_pending)
+		/*
+		 * A halt has already been issued for this channel. This might
+		 * happen when a transfer is aborted by a higher level in
+		 * the stack.
+		 */
+		return;
+
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+	hcchar.b.chen = 1;
+	hcchar.b.chdis = 1;
+	if (!core_if->dma_enable) {
+		/* Check for space in the request queue to issue the halt. */
+		if (hc->ep_type == DWC_OTG_EP_TYPE_CONTROL ||
+				hc->ep_type == DWC_OTG_EP_TYPE_BULK) {
+			nptxsts.d32 = dwc_read_reg32(&global_regs->gnptxsts);
+
+			if (!nptxsts.b.nptxqspcavail)
+				hcchar.b.chen = 0;
+		} else {
+			hptxsts.d32 =
+				dwc_read_reg32(&host_global_regs->hptxsts);
+
+			if (!hptxsts.b.ptxqspcavail ||
+					core_if->queuing_high_bandwidth)
+				hcchar.b.chen = 0;
+		}
+	}
+	dwc_write_reg32(&hc_regs->hcchar, hcchar.d32);
+
+	hc->halt_status = hlt_sts;
+	if (hcchar.b.chen) {
+		hc->halt_pending = 1;
+		hc->halt_on_queue = 0;
+	} else {
+		hc->halt_on_queue = 1;
+	}
+}
+
+/**
+ * Aborts/cancels a USB transfer request. Always returns 0 to indicate
+ * success.
+ */
+static int dwc_otg_hcd_urb_dequeue(struct usb_hcd *hcd, struct urb *urb,
+	int status)
+{
+	unsigned long flags;
+	struct dwc_hcd *dwc_hcd;
+	struct dwc_qtd *urb_qtd;
+	struct dwc_qh *qh;
+	int retval;
+
+	urb_qtd = (struct dwc_qtd *) urb->hcpriv;
+	if (!urb_qtd)
+		return -EINVAL;
+	qh = (struct dwc_qh *) urb_qtd->qtd_qh_ptr;
+	if (!qh)
+		return -EINVAL;
+
+	dwc_hcd = hcd_to_dwc_otg_hcd(hcd);
+	spin_lock_irqsave(&dwc_hcd->lock, flags);
+
+	retval = usb_hcd_check_unlink_urb(hcd, urb, status);
+	if (retval) {
+		spin_unlock_irqrestore(&dwc_hcd->lock, flags);
+		return retval;
+	}
+
+	if (urb_qtd == qh->qtd_in_process) {
+		/* The QTD is in process (it has been assigned to a channel). */
+		if (dwc_hcd->flags.b.port_connect_status) {
+			/*
+			 * If still connected (i.e. in host mode), halt the
+			 * channel so it can be used for other transfers. If
+			 * no longer connected, the host registers can't be
+			 * written to halt the channel since the core is in
+			 * device mode.
+			 */
+			dwc_otg_hc_halt(dwc_hcd->core_if, qh->channel,
+					DWC_OTG_HC_XFER_URB_DEQUEUE);
+		}
+	}
+
+	/*
+	 * Free the QTD and clean up the associated QH. Leave the QH in the
+	 * schedule if it has any remaining QTDs.
+	 */
+	dwc_otg_hcd_qtd_remove_and_free(urb_qtd);
+	if (qh && urb_qtd == qh->qtd_in_process) {
+		dwc_otg_hcd_qh_deactivate(dwc_hcd, qh, 0);
+		qh->channel = NULL;
+		qh->qtd_in_process = NULL;
+	} else if (qh && list_empty(&qh->qtd_list)) {
+		dwc_otg_hcd_qh_remove(dwc_hcd, qh);
+	}
+
+	urb->hcpriv = NULL;
+	usb_hcd_unlink_urb_from_ep(hcd, urb);
+	spin_unlock_irqrestore(&dwc_hcd->lock, flags);
+
+	/* Higher layer software sets URB status. */
+	usb_hcd_giveback_urb(hcd, urb, status);
+
+	return 0;
+}
+
+/* Remove and free a QH */
+static inline void dwc_otg_hcd_qh_remove_and_free(struct dwc_hcd *hcd,
+				struct dwc_qh *qh)
+{
+	dwc_otg_hcd_qh_remove(hcd, qh);
+	dwc_otg_hcd_qh_free(qh);
+}
+
+static void qh_list_free(struct dwc_hcd *hcd, struct list_head *_qh_list)
+{
+	struct list_head *item, *tmp;
+	struct dwc_qh *qh;
+
+	/* If the list hasn't been initialized yet, return. */
+	if (_qh_list->next == NULL)
+		return;
+
+	/* Ensure there are no QTDs or URBs left. */
+	kill_urbs_in_qh_list(hcd, _qh_list);
+
+	list_for_each_safe(item, tmp, _qh_list) {
+		qh = list_entry(item, struct dwc_qh, qh_list_entry);
+		dwc_otg_hcd_qh_remove_and_free(hcd, qh);
+	}
+}
+
+/**
+ * Frees resources in the DWC_otg controller related to a given endpoint. Also
+ * clears state in the HCD related to the endpoint. Any URBs for the endpoint
+ * must already be dequeued.
+ */
+static void dwc_otg_hcd_endpoint_disable(struct usb_hcd *hcd,
+		struct usb_host_endpoint *ep)
+{
+	struct dwc_qh *qh;
+	struct dwc_hcd *dwc_hcd = hcd_to_dwc_otg_hcd(hcd);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dwc_hcd->lock, flags);
+	qh = (struct dwc_qh *) ep->hcpriv;
+	if (qh) {
+		dwc_otg_hcd_qh_remove_and_free(dwc_hcd, qh);
+		ep->hcpriv = NULL;
+	}
+	spin_unlock_irqrestore(&dwc_hcd->lock, flags);
+}
+
+/**
+ * Creates Status Change bitmap for the root hub and root port. The bitmap is
+ * returned in buf. Bit 0 is the status change indicator for the root hub. Bit 1
+ * is the status change indicator for the single root port. Returns 1 if either
+ * change indicator is 1, otherwise returns 0.
+ */
+static int dwc_otg_hcd_hub_status_data(struct usb_hcd *_hcd, char *buf)
+{
+	struct dwc_hcd *hcd = hcd_to_dwc_otg_hcd(_hcd);
+	buf[0] = 0;
+	buf[0] |= (hcd->flags.b.port_connect_status_change
+			|| hcd->flags.b.port_reset_change
+			|| hcd->flags.b.port_enable_change
+			|| hcd->flags.b.port_suspend_change
+			|| hcd->flags.b.port_over_current_change) << 1;
+
+	return (buf[0] != 0);
+}
+
+/* Handles the hub class-specific ClearPortFeature request.*/
+static int do_clear_port_feature(struct dwc_hcd *hcd, u16 val)
+{
+	struct core_if *core_if = hcd->core_if;
+	union hprt0_data hprt0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hcd->lock, flags);
+	switch (val) {
+	case USB_PORT_FEAT_ENABLE:
+		hprt0.d32 = dwc_otg_read_hprt0(core_if);
+		hprt0.b.prtena = 1;
+		dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+		break;
+	case USB_PORT_FEAT_SUSPEND:
+		hprt0.d32 = dwc_otg_read_hprt0(core_if);
+		hprt0.b.prtres = 1;
+		dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+
+		/* Clear Resume bit */
+		spin_unlock_irqrestore(&hcd->lock, flags);
+		msleep(100);
+		spin_lock_irqsave(&hcd->lock, flags);
+		hprt0.b.prtres = 0;
+		dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+		break;
+	case USB_PORT_FEAT_POWER:
+		hprt0.d32 = dwc_otg_read_hprt0(core_if);
+		hprt0.b.prtpwr = 0;
+		dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+		break;
+	case USB_PORT_FEAT_INDICATOR:
+		/* Port inidicator not supported */
+		break;
+	case USB_PORT_FEAT_C_CONNECTION:
+		/* Clears drivers internal connect status change flag */
+		hcd->flags.b.port_connect_status_change = 0;
+		break;
+	case USB_PORT_FEAT_C_RESET:
+		/* Clears driver's internal Port Reset Change flag */
+		hcd->flags.b.port_reset_change = 0;
+		break;
+	case USB_PORT_FEAT_C_ENABLE:
+		/* Clears driver's internal Port Enable/Disable Change flag  */
+		hcd->flags.b.port_enable_change = 0;
+		break;
+	case USB_PORT_FEAT_C_SUSPEND:
+		/*
+		 * Clears the driver's internal Port Suspend
+		 * Change flag, which is set when resume signaling on
+		 * the host port is complete
+		 */
+		hcd->flags.b.port_suspend_change = 0;
+		break;
+	case USB_PORT_FEAT_C_OVER_CURRENT:
+		hcd->flags.b.port_over_current_change = 0;
+		break;
+	default:
+		printk(KERN_ERR "DWC OTG HCD - ClearPortFeature request %xh "
+			"unknown or unsupported\n", val);
+		spin_unlock_irqrestore(&hcd->lock, flags);
+		return -EINVAL;
+	}
+	spin_unlock_irqrestore(&hcd->lock, flags);
+	return 0;
+}
+
+/* Handles the hub class-specific SetPortFeature request.*/
+static int do_set_port_feature(struct usb_hcd *hcd, u16 val, u16 index)
+{
+	struct core_if *core_if = hcd_to_dwc_otg_hcd(hcd)->core_if;
+	union hprt0_data hprt0 = {.d32 = 0};
+	struct dwc_hcd *dwc_hcd = hcd_to_dwc_otg_hcd(hcd);
+	unsigned long flags;
+	union pcgcctl_data pcgcctl = {.d32 = 0};
+
+	spin_lock_irqsave(&dwc_hcd->lock, flags);
+
+	switch (val) {
+	case USB_PORT_FEAT_SUSPEND:
+		if (hcd->self.otg_port == index && hcd->self.b_hnp_enable) {
+			union gotgctl_data gotgctl = {.d32 = 0};
+			gotgctl.b.hstsethnpen = 1;
+			dwc_modify_reg32(&core_if->core_global_regs->gotgctl,
+						0, gotgctl.d32);
+			core_if->xceiv->state = OTG_STATE_A_SUSPEND;
+		}
+
+		hprt0.d32 = dwc_otg_read_hprt0(core_if);
+		hprt0.b.prtsusp = 1;
+		dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+
+		/* Suspend the Phy Clock */
+		pcgcctl.b.stoppclk = 1;
+		dwc_write_reg32(core_if->pcgcctl, pcgcctl.d32);
+
+		/* For HNP the bus must be suspended for at least 200ms. */
+		if (hcd->self.b_hnp_enable) {
+			spin_unlock_irqrestore(&dwc_hcd->lock, flags);
+			msleep(200);
+			spin_lock_irqsave(&dwc_hcd->lock, flags);
+		}
+		break;
+	case USB_PORT_FEAT_POWER:
+		hprt0.d32 = dwc_otg_read_hprt0(core_if);
+		hprt0.b.prtpwr = 1;
+		dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+		break;
+	case USB_PORT_FEAT_RESET:
+		hprt0.d32 = dwc_otg_read_hprt0(core_if);
+
+		/*
+		 * When B-Host the Port reset bit is set in the Start HCD
+		 * Callback function, so that the reset is started within 1ms
+		 * of the HNP success interrupt.
+		 */
+		if (!hcd->self.is_b_host) {
+			hprt0.b.prtrst = 1;
+			dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+		}
+
+		/* Clear reset bit in 10ms (FS/LS) or 50ms (HS) */
+		spin_unlock_irqrestore(&dwc_hcd->lock, flags);
+		msleep(60);
+		spin_lock_irqsave(&dwc_hcd->lock, flags);
+		hprt0.b.prtrst = 0;
+		dwc_write_reg32(core_if->host_if->hprt0, hprt0.d32);
+		break;
+	case USB_PORT_FEAT_INDICATOR:
+		/* Not supported */
+		break;
+	default:
+		printk(KERN_ERR "DWC OTG HCD - "
+				"SetPortFeature request %xh "
+				"unknown or unsupported\n", val);
+		spin_unlock_irqrestore(&dwc_hcd->lock, flags);
+		return -EINVAL;
+	}
+	spin_unlock_irqrestore(&dwc_hcd->lock, flags);
+	return 0;
+}
+
+/* Handles hub class-specific requests.*/
+static int dwc_otg_hcd_hub_control(struct usb_hcd *hcd, u16 req_type, u16 val,
+		u16 index, char *buf, u16 len)
+{
+	int retval = 0;
+	struct dwc_hcd *dwc_hcd = hcd_to_dwc_otg_hcd(hcd);
+	struct core_if *core_if = hcd_to_dwc_otg_hcd(hcd)->core_if;
+	struct usb_hub_descriptor *desc;
+	union hprt0_data hprt0 = {.d32 = 0};
+	u32 port_status;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dwc_hcd->lock, flags);
+	switch (req_type) {
+	case ClearHubFeature:
+		switch (val) {
+		case C_HUB_LOCAL_POWER:
+		case C_HUB_OVER_CURRENT:
+			/* Nothing required here */
+			break;
+		default:
+			retval = -EINVAL;
+			printk(KERN_ERR "DWC OTG HCD - ClearHubFeature request"
+					" %xh unknown\n", val);
+		}
+		break;
+	case ClearPortFeature:
+		if (!index || index > 1)
+			goto error;
+		spin_unlock_irqrestore(&dwc_hcd->lock, flags);
+		retval = do_clear_port_feature(dwc_hcd, val);
+		spin_lock_irqsave(&dwc_hcd->lock, flags);
+		break;
+	case GetHubDescriptor:
+		desc = (struct usb_hub_descriptor *) buf;
+		desc->bDescLength = 9;
+		desc->bDescriptorType = 0x29;
+		desc->bNbrPorts = 1;
+		desc->wHubCharacteristics = 0x08;
+		desc->bPwrOn2PwrGood = 1;
+		desc->bHubContrCurrent = 0;
+		desc->bitmap[0] = 0;
+		desc->bitmap[1] = 0xff;
+		break;
+	case GetHubStatus:
+		memset(buf, 0, 4);
+		break;
+	case GetPortStatus:
+		if (!index || index > 1)
+			goto error;
+
+		port_status = 0;
+		if (dwc_hcd->flags.b.port_connect_status_change)
+			port_status |= (1 << USB_PORT_FEAT_C_CONNECTION);
+		if (dwc_hcd->flags.b.port_enable_change)
+			port_status |= (1 << USB_PORT_FEAT_C_ENABLE);
+		if (dwc_hcd->flags.b.port_suspend_change)
+			port_status |= (1 << USB_PORT_FEAT_C_SUSPEND);
+		if (dwc_hcd->flags.b.port_reset_change)
+			port_status |= (1 << USB_PORT_FEAT_C_RESET);
+		if (dwc_hcd->flags.b.port_over_current_change) {
+			printk(KERN_ERR "Device Not Supported\n");
+			port_status |= (1 << USB_PORT_FEAT_C_OVER_CURRENT);
+		}
+		if (!dwc_hcd->flags.b.port_connect_status) {
+			/*
+			 * The port is disconnected, which means the core is
+			 * either in device mode or it soon will be. Just
+			 * return 0's for the remainder of the port status
+			 * since the port register can't be read if the core
+			 * is in device mode.
+			 */
+			*((__le32 *) buf) = cpu_to_le32(port_status);
+			break;
+		}
+
+		hprt0.d32 = dwc_read_reg32(core_if->host_if->hprt0);
+
+		if (hprt0.b.prtconnsts)
+			port_status |= USB_PORT_STAT_CONNECTION;
+		if (hprt0.b.prtena)
+			port_status |= USB_PORT_STAT_ENABLE;
+		if (hprt0.b.prtsusp)
+			port_status |= USB_PORT_STAT_SUSPEND;
+		if (hprt0.b.prtovrcurract)
+			port_status |= USB_PORT_STAT_OVERCURRENT;
+		if (hprt0.b.prtrst)
+			port_status |= USB_PORT_STAT_RESET;
+		if (hprt0.b.prtpwr)
+			port_status |= USB_PORT_STAT_POWER;
+
+		if (hprt0.b.prtspd == DWC_HPRT0_PRTSPD_HIGH_SPEED)
+			port_status |= USB_PORT_STAT_HIGH_SPEED;
+		else if (hprt0.b.prtspd == DWC_HPRT0_PRTSPD_LOW_SPEED)
+			port_status |= USB_PORT_STAT_LOW_SPEED;
+
+		if (hprt0.b.prttstctl)
+			port_status |= (1 << USB_PORT_FEAT_TEST);
+
+		/* USB_PORT_FEAT_INDICATOR unsupported always 0 */
+		*((__le32 *) buf) = cpu_to_le32(port_status);
+		break;
+	case SetHubFeature:
+		/* No HUB features supported */
+		break;
+	case SetPortFeature:
+		if (val != USB_PORT_FEAT_TEST && (!index || index > 1))
+			goto error;
+
+		if (!dwc_hcd->flags.b.port_connect_status) {
+			/*
+			 * The port is disconnected, which means the core is
+			 * either in device mode or it soon will be. Just
+			 * return without doing anything since the port
+			 * register can't be written if the core is in device
+			 * mode.
+			 */
+			break;
+		}
+		spin_unlock_irqrestore(&dwc_hcd->lock, flags);
+		retval = do_set_port_feature(hcd, val, index);
+		spin_lock_irqsave(&dwc_hcd->lock, flags);
+		break;
+	default:
+error:
+		retval = -EINVAL;
+		printk(KERN_WARNING "DWC OTG HCD - Unknown hub control request"
+			" type or invalid req_type: %xh index: %xh "
+			"val: %xh\n", req_type, index, val);
+		break;
+	}
+	spin_unlock_irqrestore(&dwc_hcd->lock, flags);
+	return retval;
+}
+
+/**
+ * Handles host mode interrupts for the DWC_otg controller. Returns IRQ_NONE if
+ * there was no interrupt to handle. Returns IRQ_HANDLED if there was a valid
+ * interrupt.
+ *
+ * This function is called by the USB core when an interrupt occurs
+ */
+static irqreturn_t dwc_otg_hcd_irq(struct usb_hcd *hcd)
+{
+	struct dwc_hcd *dwc_hcd = hcd_to_dwc_otg_hcd(hcd);
+	return IRQ_RETVAL(dwc_otg_hcd_handle_intr(dwc_hcd));
+}
+
+static const struct hc_driver dwc_otg_hc_driver = {
+	.description = dwc_otg_hcd_name,
+	.product_desc = "DWC OTG Controller",
+	.hcd_priv_size = sizeof(struct dwc_hcd),
+	.irq = dwc_otg_hcd_irq,
+	.flags = HCD_MEMORY | HCD_USB2,
+	.start = dwc_otg_hcd_start,
+	.stop = dwc_otg_hcd_stop,
+	.urb_enqueue = dwc_otg_hcd_urb_enqueue,
+	.urb_dequeue = dwc_otg_hcd_urb_dequeue,
+	.endpoint_disable = dwc_otg_hcd_endpoint_disable,
+	.get_frame_number = dwc_otg_hcd_get_frame_number,
+	.hub_status_data = dwc_otg_hcd_hub_status_data,
+	.hub_control = dwc_otg_hcd_hub_control,
+};
+
+/**
+ * Frees secondary storage associated with the dwc_hcd structure contained
+ * in the struct usb_hcd field.
+ */
+static void dwc_otg_hcd_free(struct usb_hcd *hcd)
+{
+	struct dwc_hcd *dwc_hcd = hcd_to_dwc_otg_hcd(hcd);
+	u32 i;
+
+	del_timers(dwc_hcd);
+
+	/* Free memory for QH/QTD lists */
+	qh_list_free(dwc_hcd, &dwc_hcd->non_periodic_sched_inactive);
+	qh_list_free(dwc_hcd, &dwc_hcd->non_periodic_sched_deferred);
+	qh_list_free(dwc_hcd, &dwc_hcd->non_periodic_sched_active);
+	qh_list_free(dwc_hcd, &dwc_hcd->periodic_sched_inactive);
+	qh_list_free(dwc_hcd, &dwc_hcd->periodic_sched_ready);
+	qh_list_free(dwc_hcd, &dwc_hcd->periodic_sched_assigned);
+	qh_list_free(dwc_hcd, &dwc_hcd->periodic_sched_queued);
+
+	/* Free memory for the host channels. */
+	for (i = 0; i < MAX_EPS_CHANNELS; i++) {
+		struct dwc_hc *hc = dwc_hcd->hc_ptr_array[i];
+
+		kfree(hc);
+	}
+	if (dwc_hcd->core_if->dma_enable) {
+		if (dwc_hcd->status_buf_dma)
+			dma_free_coherent(hcd->self.controller,
+				DWC_OTG_HCD_STATUS_BUF_SIZE,
+				dwc_hcd->status_buf, dwc_hcd->status_buf_dma);
+	} else {
+		kfree(dwc_hcd->status_buf);
+	}
+
+}
+
+/**
+ * Initializes the HCD. This function allocates memory for and initializes the
+ * static parts of the usb_hcd and dwc_hcd structures. It also registers the
+ * USB bus with the core and calls the hc_driver->start() function. It returns
+ * a negative error on failure.
+ */
+int __devinit dwc_otg_hcd_init(struct device *_dev,
+		struct dwc_otg_device *dwc_otg_device)
+{
+	struct usb_hcd *hcd = NULL;
+	struct dwc_hcd *dwc_hcd = NULL;
+	struct dwc_otg_device *otg_dev = dev_get_drvdata(_dev);
+	int num_channels;
+	u32 i;
+	struct dwc_hc *channel;
+	int retval = 0;
+
+	/*
+	 * Allocate memory for the base HCD plus the DWC OTG HCD.
+	 * Initialize the base HCD.
+	 */
+	hcd = usb_create_hcd(&dwc_otg_hc_driver, _dev, dwc_otg_hcd_name);
+	if (!hcd) {
+		retval = -ENOMEM;
+		goto error1;
+	}
+	dev_set_drvdata(_dev, dwc_otg_device);
+	hcd->regs = otg_dev->base;
+	hcd->self.otg_port = 1;
+
+	/* Initialize the DWC OTG HCD. */
+	dwc_hcd = hcd_to_dwc_otg_hcd(hcd);
+	dwc_hcd->core_if = otg_dev->core_if;
+	spin_lock_init(&dwc_hcd->lock);
+	otg_dev->hcd = dwc_hcd;
+
+	/* Register the HCD CIL Callbacks */
+	dwc_otg_cil_register_hcd_callbacks(otg_dev->core_if, &hcd_cil_callbacks,
+						hcd);
+
+	/* Initialize the non-periodic schedule. */
+	INIT_LIST_HEAD(&dwc_hcd->non_periodic_sched_inactive);
+	INIT_LIST_HEAD(&dwc_hcd->non_periodic_sched_active);
+	INIT_LIST_HEAD(&dwc_hcd->non_periodic_sched_deferred);
+
+	/* Initialize the periodic schedule. */
+	INIT_LIST_HEAD(&dwc_hcd->periodic_sched_inactive);
+	INIT_LIST_HEAD(&dwc_hcd->periodic_sched_ready);
+	INIT_LIST_HEAD(&dwc_hcd->periodic_sched_assigned);
+	INIT_LIST_HEAD(&dwc_hcd->periodic_sched_queued);
+
+	/*
+	 * Create a host channel descriptor for each host channel implemented
+	 * in the controller. Initialize the channel descriptor array.
+	 */
+	INIT_LIST_HEAD(&dwc_hcd->free_hc_list);
+	num_channels = dwc_hcd->core_if->core_params->host_channels;
+
+	for (i = 0; i < num_channels; i++) {
+		channel = kzalloc(sizeof(struct dwc_hc), GFP_KERNEL);
+		if (!channel) {
+			retval = -ENOMEM;
+			printk(KERN_ERR "%s: host channel allocation failed\n",
+				__func__);
+			goto error2;
+		}
+
+		channel->hc_num = i;
+		dwc_hcd->hc_ptr_array[i] = channel;
+	}
+
+	/* Initialize the Connection timeout timer. */
+	init_timer(&dwc_hcd->conn_timer);
+
+	/* Initialize workqueue */
+	INIT_WORK(&dwc_hcd->usb_port_reset, port_reset_wqfunc);
+	INIT_WORK(&dwc_hcd->start_work, hcd_start_func);
+	INIT_WORK(&dwc_hcd->core_if->usb_port_otg, NULL);
+	INIT_DELAYED_WORK(&dwc_hcd->core_if->usb_port_wakeup,
+		port_wakeup_wqfunc);
+
+	/* Set device flags indicating whether the HCD supports DMA. */
+	if (otg_dev->core_if->dma_enable) {
+		static u64 dummy_mask = DMA_BIT_MASK(32);
+		printk(KERN_INFO "Using DMA mode\n");
+		_dev->dma_mask = (void *) &dummy_mask;
+		_dev->coherent_dma_mask = ~0;
+	} else {
+		printk(KERN_INFO "Using Slave mode\n");
+		_dev->dma_mask = (void *) 0;
+		_dev->coherent_dma_mask = 0;
+	}
+
+	init_hcd_usecs(dwc_hcd);
+	/*
+	 * Finish generic HCD initialization and start the HCD. This function
+	 * allocates the DMA buffer pool, registers the USB bus, requests the
+	 * IRQ line, and calls dwc_otg_hcd_start method.
+	 */
+	retval = usb_add_hcd(hcd, otg_dev->irq, IRQF_SHARED);
+	if (retval < 0)
+		goto error2;
+
+	/*
+	 * Allocate space for storing data on status transactions. Normally no
+	 * data is sent, but this space acts as a bit bucket. This must be
+	 * done after usb_add_hcd since that function allocates the DMA buffer
+	 * pool.
+	 */
+	if (otg_dev->core_if->dma_enable) {
+		dwc_hcd->status_buf =
+			dma_alloc_coherent(_dev, DWC_OTG_HCD_STATUS_BUF_SIZE,
+						&dwc_hcd->status_buf_dma,
+						GFP_KERNEL | GFP_DMA);
+	} else {
+		dwc_hcd->status_buf = kmalloc(DWC_OTG_HCD_STATUS_BUF_SIZE,
+							GFP_KERNEL);
+	}
+	if (!dwc_hcd->status_buf) {
+		retval = -ENOMEM;
+		printk(KERN_ERR "%s: status_buf allocation failed\n", __func__);
+		goto error3;
+	}
+	return 0;
+
+error3:
+	usb_remove_hcd(hcd);
+error2:
+	dwc_otg_hcd_free(hcd);
+	usb_put_hcd(hcd);
+error1:
+	return retval;
+}
+
+/**
+ * Removes the HCD.
+ * Frees memory and resources associated with the HCD and deregisters the bus.
+ */
+void __devexit dwc_otg_hcd_remove(struct device *_dev)
+{
+	struct dwc_otg_device *otg_dev = dev_get_drvdata(_dev);
+	struct dwc_hcd *dwc_hcd = otg_dev->hcd;
+	struct usb_hcd *hcd = dwc_otg_hcd_to_hcd(dwc_hcd);
+
+	/* Turn off all interrupts */
+	dwc_write_reg32(gintmsk_reg(dwc_hcd), 0);
+	dwc_modify_reg32(gahbcfg_reg(dwc_hcd), 1, 0);
+
+	cancel_work_sync(&dwc_hcd->start_work);
+	cancel_work_sync(&dwc_hcd->usb_port_reset);
+	cancel_work_sync(&dwc_hcd->core_if->usb_port_otg);
+	cancel_rearming_delayed_work(&dwc_hcd->core_if->usb_port_wakeup);
+
+	usb_remove_hcd(hcd);
+	dwc_otg_hcd_free(hcd);
+	usb_put_hcd(hcd);
+}
+
+/** Returns the current frame number. */
+int dwc_otg_hcd_get_frame_number(struct usb_hcd *hcd)
+{
+	struct dwc_hcd *dwc_hcd = hcd_to_dwc_otg_hcd(hcd);
+	union hfnum_data hfnum;
+
+	hfnum.d32 = dwc_read_reg32(&dwc_hcd->core_if->host_if->
+					host_global_regs->hfnum);
+
+	return hfnum.b.frnum;
+}
+
+/**
+ * Prepares a host channel for transferring packets to/from a specific
+ * endpoint. The HCCHARn register is set up with the characteristics specified
+ * in _hc. Host channel interrupts that may need to be serviced while this
+ * transfer is in progress are enabled.
+ */
+static void dwc_otg_hc_init(struct core_if *core_if, struct dwc_hc *hc)
+{
+	u32 intr_enable;
+	union hcintmsk_data hc_intr_mask;
+	union gintmsk_data gintmsk = {.d32 = 0};
+	union hcchar_data hcchar;
+	union hcsplt_data hcsplt;
+	u8 hc_num = hc->hc_num;
+	struct dwc_host_if *host_if = core_if->host_if;
+	struct dwc_hc_regs *hc_regs = host_if->hc_regs[hc_num];
+
+	/* Clear old interrupt conditions for this host channel. */
+	hc_intr_mask.d32 = 0xFFFFFFFF;
+	hc_intr_mask.b.reserved = 0;
+	dwc_write_reg32(&hc_regs->hcint, hc_intr_mask.d32);
+
+	/* Enable channel interrupts required for this transfer. */
+	hc_intr_mask.d32 = 0;
+	hc_intr_mask.b.chhltd = 1;
+	if (core_if->dma_enable) {
+		hc_intr_mask.b.ahberr = 1;
+
+		if (hc->error_state && !hc->do_split &&
+				 hc->ep_type != DWC_OTG_EP_TYPE_ISOC) {
+			hc_intr_mask.b.ack = 1;
+			if (hc->ep_is_in) {
+				hc_intr_mask.b.datatglerr = 1;
+				if (hc->ep_type != DWC_OTG_EP_TYPE_INTR)
+					hc_intr_mask.b.nak = 1;
+			}
+		}
+	} else {
+		switch (hc->ep_type) {
+		case DWC_OTG_EP_TYPE_CONTROL:
+		case DWC_OTG_EP_TYPE_BULK:
+			hc_intr_mask.b.xfercompl = 1;
+			hc_intr_mask.b.stall = 1;
+			hc_intr_mask.b.xacterr = 1;
+			hc_intr_mask.b.datatglerr = 1;
+
+			if (hc->ep_is_in) {
+				hc_intr_mask.b.bblerr = 1;
+			} else {
+				hc_intr_mask.b.nak = 1;
+				hc_intr_mask.b.nyet = 1;
+				if (hc->do_ping)
+					hc_intr_mask.b.ack = 1;
+			}
+
+			if (hc->do_split) {
+				hc_intr_mask.b.nak = 1;
+				if (hc->complete_split)
+					hc_intr_mask.b.nyet = 1;
+				else
+					hc_intr_mask.b.ack = 1;
+			}
+
+			if (hc->error_state)
+				hc_intr_mask.b.ack = 1;
+			break;
+		case DWC_OTG_EP_TYPE_INTR:
+			hc_intr_mask.b.xfercompl = 1;
+			hc_intr_mask.b.nak = 1;
+			hc_intr_mask.b.stall = 1;
+			hc_intr_mask.b.xacterr = 1;
+			hc_intr_mask.b.datatglerr = 1;
+			hc_intr_mask.b.frmovrun = 1;
+
+			if (hc->ep_is_in)
+				hc_intr_mask.b.bblerr = 1;
+			if (hc->error_state)
+				hc_intr_mask.b.ack = 1;
+
+			if (hc->do_split) {
+				if (hc->complete_split)
+					hc_intr_mask.b.nyet = 1;
+				else
+					hc_intr_mask.b.ack = 1;
+			}
+			break;
+		case DWC_OTG_EP_TYPE_ISOC:
+			hc_intr_mask.b.xfercompl = 1;
+			hc_intr_mask.b.frmovrun = 1;
+			hc_intr_mask.b.ack = 1;
+
+			if (hc->ep_is_in) {
+				hc_intr_mask.b.xacterr = 1;
+				hc_intr_mask.b.bblerr = 1;
+			}
+			break;
+		}
+	}
+	dwc_write_reg32(&hc_regs->hcintmsk, hc_intr_mask.d32);
+
+	/* Enable the top level host channel interrupt. */
+	intr_enable = (1 << hc_num);
+	dwc_modify_reg32(&host_if->host_global_regs->haintmsk, 0, intr_enable);
+
+	/* Make sure host channel interrupts are enabled. */
+	gintmsk.b.hcintr = 1;
+	dwc_modify_reg32(&core_if->core_global_regs->gintmsk, 0, gintmsk.d32);
+
+	/*
+	 * Program the HCCHARn register with the endpoint characteristics for
+	 * the current transfer.
+	 */
+	hcchar.d32 = 0;
+	hcchar.b.devaddr = hc->dev_addr;
+	hcchar.b.epnum = hc->ep_num;
+	hcchar.b.epdir = hc->ep_is_in;
+	hcchar.b.lspddev = (hc->speed == DWC_OTG_EP_SPEED_LOW);
+	hcchar.b.eptype = hc->ep_type;
+	hcchar.b.mps = hc->max_packet;
+	dwc_write_reg32(&host_if->hc_regs[hc_num]->hcchar, hcchar.d32);
+
+	/* Program the HCSPLIT register for SPLITs */
+	hcsplt.d32 = 0;
+	if (hc->do_split) {
+		hcsplt.b.compsplt = hc->complete_split;
+		hcsplt.b.xactpos = hc->xact_pos;
+		hcsplt.b.hubaddr = hc->hub_addr;
+		hcsplt.b.prtaddr = hc->port_addr;
+	}
+	dwc_write_reg32(&host_if->hc_regs[hc_num]->hcsplt, hcsplt.d32);
+}
+
+/**
+ * Assigns transactions from a QTD to a free host channel and initializes the
+ * host channel to perform the transactions. The host channel is removed from
+ * the free list.
+ */
+static void assign_and_init_hc(struct dwc_hcd *hcd, struct dwc_qh * qh)
+{
+	struct dwc_hc *hc;
+	struct dwc_qtd *qtd;
+	struct urb *urb;
+	struct usb_iso_packet_descriptor *frame_desc;
+
+	hc = list_entry(hcd->free_hc_list.next, struct dwc_hc, hc_list_entry);
+
+	/* Remove the host channel from the free list. */
+	list_del_init(&hc->hc_list_entry);
+	qtd = list_entry(qh->qtd_list.next, struct dwc_qtd, qtd_list_entry);
+	urb = qtd->urb;
+	qh->channel = hc;
+	qh->qtd_in_process = qtd;
+
+	/*
+	 * Use usb_pipedevice to determine device address. This address is
+	 * 0 before the SET_ADDRESS command and the correct address afterward.
+	 */
+	hc->dev_addr = usb_pipedevice(urb->pipe);
+	hc->ep_num = usb_pipeendpoint(urb->pipe);
+
+	if (urb->dev->speed == USB_SPEED_LOW)
+		hc->speed = DWC_OTG_EP_SPEED_LOW;
+	else if (urb->dev->speed == USB_SPEED_FULL)
+		hc->speed = DWC_OTG_EP_SPEED_FULL;
+	else
+		hc->speed = DWC_OTG_EP_SPEED_HIGH;
+
+	hc->max_packet = dwc_max_packet(qh->maxp);
+	hc->xfer_started = 0;
+	hc->halt_status = DWC_OTG_HC_XFER_NO_HALT_STATUS;
+	hc->error_state = (qtd->error_count > 0);
+	hc->halt_on_queue = 0;
+	hc->halt_pending = 0;
+	hc->requests = 0;
+
+	/*
+	 * The following values may be modified in the transfer type section
+	 * below. The xfer_len value may be reduced when the transfer is
+	 * started to accommodate the max widths of the XferSize and PktCnt
+	 * fields in the HCTSIZn register.
+	 */
+	hc->do_ping = qh->ping_state;
+	hc->ep_is_in = (usb_pipein(urb->pipe) != 0);
+	hc->data_pid_start = qh->data_toggle;
+	hc->multi_count = 1;
+
+	if (hcd->core_if->dma_enable)
+		hc->xfer_buff = (u8 *) urb->transfer_dma +
+			urb->actual_length;
+	else
+		hc->xfer_buff = (u8 *) urb->transfer_buffer +
+			urb->actual_length;
+
+	hc->xfer_len = urb->transfer_buffer_length - urb->actual_length;
+	hc->xfer_count = 0;
+
+	/*
+	 * Set the split attributes
+	 */
+	hc->do_split = 0;
+	if (qh->do_split) {
+		hc->do_split = 1;
+		hc->xact_pos = qtd->isoc_split_pos;
+		hc->complete_split = qtd->complete_split;
+		hc->hub_addr = urb->dev->tt->hub->devnum;
+		hc->port_addr = urb->dev->ttport;
+	}
+
+	switch (usb_pipetype(urb->pipe)) {
+	case PIPE_CONTROL:
+		hc->ep_type = DWC_OTG_EP_TYPE_CONTROL;
+
+		switch (qtd->control_phase) {
+		case DWC_OTG_CONTROL_SETUP:
+			hc->do_ping = 0;
+			hc->ep_is_in = 0;
+			hc->data_pid_start = DWC_OTG_HC_PID_SETUP;
+
+			if (hcd->core_if->dma_enable)
+				hc->xfer_buff = (u8 *) urb->setup_dma;
+			else
+				hc->xfer_buff = (u8 *) urb->setup_packet;
+
+			hc->xfer_len = 8;
+			break;
+		case DWC_OTG_CONTROL_DATA:
+			hc->data_pid_start = qtd->data_toggle;
+			break;
+		case DWC_OTG_CONTROL_STATUS:
+			/*
+			 * Direction is opposite of data direction or IN if no
+			 * data.
+			 */
+			if (urb->transfer_buffer_length == 0)
+				hc->ep_is_in = 1;
+			else
+				hc->ep_is_in = (usb_pipein(urb->pipe) !=
+							USB_DIR_IN);
+
+			if (hc->ep_is_in)
+				hc->do_ping = 0;
+
+			hc->data_pid_start = DWC_OTG_HC_PID_DATA1;
+			hc->xfer_len = 0;
+			if (hcd->core_if->dma_enable)
+				hc->xfer_buff = (u8 *) hcd->status_buf_dma;
+			else
+				hc->xfer_buff = (u8 *) hcd->status_buf;
+			break;
+		}
+		break;
+	case PIPE_BULK:
+		hc->ep_type = DWC_OTG_EP_TYPE_BULK;
+		break;
+	case PIPE_INTERRUPT:
+		hc->ep_type = DWC_OTG_EP_TYPE_INTR;
+		break;
+	case PIPE_ISOCHRONOUS:
+		frame_desc = &urb->iso_frame_desc[qtd->isoc_frame_index];
+		hc->ep_type = DWC_OTG_EP_TYPE_ISOC;
+
+		if (hcd->core_if->dma_enable)
+			hc->xfer_buff = (u8 *) urb->transfer_dma;
+		else
+			hc->xfer_buff = (u8 *) urb->transfer_buffer;
+
+		hc->xfer_buff += frame_desc->offset + qtd->isoc_split_offset;
+		hc->xfer_len = frame_desc->length - qtd->isoc_split_offset;
+
+		if (hc->xact_pos == DWC_HCSPLIT_XACTPOS_ALL) {
+			if (hc->xfer_len <= 188)
+				hc->xact_pos = DWC_HCSPLIT_XACTPOS_ALL;
+			else
+				hc->xact_pos = DWC_HCSPLIT_XACTPOS_BEGIN;
+		}
+		break;
+	}
+
+	if (hc->ep_type == DWC_OTG_EP_TYPE_INTR ||
+			hc->ep_type == DWC_OTG_EP_TYPE_ISOC)
+		/*
+		 * This value may be modified when the transfer is started to
+		 * reflect the actual transfer length.
+		 */
+		hc->multi_count = dwc_hb_mult(qh->maxp);
+
+	dwc_otg_hc_init(hcd->core_if, hc);
+	hc->qh = qh;
+}
+
+/**
+ * This function selects transactions from the HCD transfer schedule and
+ * assigns them to available host channels. It is called from HCD interrupt
+ * handler functions.
+ */
+enum dwc_transaction_type dwc_otg_hcd_select_transactions(struct dwc_hcd *hcd)
+{
+	struct list_head *qh_ptr;
+	struct dwc_qh *qh;
+	int num_channels;
+	enum dwc_transaction_type ret_val = DWC_OTG_TRANSACTION_NONE;
+
+	/* Process entries in the periodic ready list. */
+	num_channels = hcd->core_if->core_params->host_channels;
+	qh_ptr = hcd->periodic_sched_ready.next;
+	while (qh_ptr != &hcd->periodic_sched_ready &&
+	       !list_empty(&hcd->free_hc_list)) {
+		/* Leave one channel for non periodic transactions. */
+		if (hcd->available_host_channels <= 1)
+			break;
+		hcd->available_host_channels--;
+		qh = list_entry(qh_ptr, struct dwc_qh, qh_list_entry);
+		assign_and_init_hc(hcd, qh);
+		/*
+		 * Move the QH from the periodic ready schedule to the
+		 * periodic assigned schedule.
+		 */
+		qh_ptr = qh_ptr->next;
+		list_move(&qh->qh_list_entry, &hcd->periodic_sched_assigned);
+		ret_val = DWC_OTG_TRANSACTION_PERIODIC;
+	}
+
+	/*
+	 * Process entries in the deferred portion of the non-periodic list.
+	 * A NAK put them here and, at the right time, they need to be
+	 * placed on the sched_inactive list.
+	 */
+	qh_ptr = hcd->non_periodic_sched_deferred.next;
+	while (qh_ptr != &hcd->non_periodic_sched_deferred) {
+		u16 frame_number =
+			dwc_otg_hcd_get_frame_number(dwc_otg_hcd_to_hcd(hcd));
+		qh = list_entry(qh_ptr, struct dwc_qh, qh_list_entry);
+		qh_ptr = qh_ptr->next;
+
+		if (dwc_frame_num_le(qh->sched_frame, frame_number))
+			/*
+			 * Move the QH from the non periodic deferred schedule
+			 * to the non periodic inactive schedule.
+			 */
+			list_move(&qh->qh_list_entry,
+				&hcd->non_periodic_sched_inactive);
+	}
+
+	/*
+	 * Process entries in the inactive portion of the non-periodic
+	 * schedule. Some free host channels may not be used if they are
+	 * reserved for periodic transfers.
+	 */
+	qh_ptr = hcd->non_periodic_sched_inactive.next;
+	num_channels = hcd->core_if->core_params->host_channels;
+
+	while (qh_ptr != &hcd->non_periodic_sched_inactive
+			&& !list_empty(&hcd->free_hc_list)) {
+		if (hcd->available_host_channels < 1)
+			break;
+		hcd->available_host_channels--;
+		qh = list_entry(qh_ptr, struct dwc_qh, qh_list_entry);
+		assign_and_init_hc(hcd, qh);
+		/*
+		 * Move the QH from the non-periodic inactive schedule to the
+		 * non-periodic active schedule.
+		 */
+		qh_ptr = qh_ptr->next;
+		list_move(&qh->qh_list_entry, &hcd->non_periodic_sched_active);
+		if (ret_val == DWC_OTG_TRANSACTION_NONE)
+			ret_val = DWC_OTG_TRANSACTION_NON_PERIODIC;
+		else
+			ret_val = DWC_OTG_TRANSACTION_ALL;
+
+	}
+	return ret_val;
+}
+
+/**
+ * Sets the channel property that indicates in which frame a periodic transfer
+ * should occur. This is always set to the _next_ frame. This function has no
+ * effect on non-periodic transfers.
+ */
+static inline void hc_set_even_odd_frame(struct core_if *core_if,
+			struct dwc_hc *hc, union hcchar_data *hcchar)
+{
+	if (hc->ep_type == DWC_OTG_EP_TYPE_INTR ||
+			hc->ep_type == DWC_OTG_EP_TYPE_ISOC) {
+		union hfnum_data hfnum;
+		hfnum.d32 = dwc_read_reg32(
+			&core_if->host_if->host_global_regs->hfnum);
+
+		/* 1 if _next_ frame is odd, 0 if it's even */
+		hcchar->b.oddfrm = (hfnum.b.frnum & 0x1) ? 0 : 1;
+	}
+}
+
+static void set_initial_xfer_pid(struct dwc_hc *hc)
+{
+	if (hc->speed == DWC_OTG_EP_SPEED_HIGH) {
+		if (hc->ep_is_in) {
+			if (hc->multi_count == 1)
+				hc->data_pid_start = DWC_OTG_HC_PID_DATA0;
+			else if (hc->multi_count == 2)
+				hc->data_pid_start = DWC_OTG_HC_PID_DATA1;
+			else
+				hc->data_pid_start = DWC_OTG_HC_PID_DATA2;
+		} else {
+			if (hc->multi_count == 1)
+				hc->data_pid_start = DWC_OTG_HC_PID_DATA0;
+			else
+				hc->data_pid_start = DWC_OTG_HC_PID_MDATA;
+		}
+	} else {
+		hc->data_pid_start = DWC_OTG_HC_PID_DATA0;
+	}
+}
+
+/**
+ * Starts a PING transfer. This function should only be called in Slave mode.
+ * The Do Ping bit is set in the HCTSIZ register, then the channel is enabled.
+ */
+void dwc_otg_hc_do_ping(struct core_if *core_if, struct dwc_hc *hc)
+{
+	union hcchar_data hcchar;
+	union hctsiz_data hctsiz;
+	struct dwc_hc_regs *hc_regs = core_if->host_if->hc_regs[hc->hc_num];
+
+	hctsiz.d32 = 0;
+	hctsiz.b.dopng = 1;
+	hctsiz.b.pktcnt = 1;
+	dwc_write_reg32(&hc_regs->hctsiz, hctsiz.d32);
+
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+	hcchar.b.chen = 1;
+	hcchar.b.chdis = 0;
+	dwc_write_reg32(&hc_regs->hcchar, hcchar.d32);
+}
+
+/**
+ * This function writes a packet into the Tx FIFO associated with the Host
+ * Channel. For a channel associated with a non-periodic EP, the non-periodic
+ * Tx FIFO is written. For a channel associated with a periodic EP, the
+ * periodic Tx FIFO is written. This function should only be called in Slave
+ * mode.
+ *
+ * Upon return the xfer_buff and xfer_count fields in hc are incremented by
+ * then number of bytes written to the Tx FIFO.
+ */
+static void dwc_otg_hc_write_packet(struct core_if *core_if, struct dwc_hc *hc)
+{
+	u32 i;
+	u32 remaining_count;
+	u32 byte_count;
+	u32 dword_count;
+	u32 *data_buff = (u32 *) (hc->xfer_buff);
+	u32 *data_fifo = core_if->data_fifo[hc->hc_num];
+
+	remaining_count = hc->xfer_len - hc->xfer_count;
+	if (remaining_count > hc->max_packet)
+		byte_count = hc->max_packet;
+	 else
+		byte_count = remaining_count;
+
+	dword_count = (byte_count + 3) / 4;
+
+	if (((unsigned long)data_buff) & 0x3)
+		/* xfer_buff is not DWORD aligned. */
+		for (i = 0; i < dword_count; i++, data_buff++)
+			dwc_write_datafifo32(data_fifo,
+				get_unaligned(data_buff));
+	else
+		/* xfer_buff is DWORD aligned. */
+		for (i = 0; i < dword_count; i++, data_buff++)
+			dwc_write_datafifo32(data_fifo, *data_buff);
+
+	hc->xfer_count += byte_count;
+	hc->xfer_buff += byte_count;
+}
+
+/**
+ * This function does the setup for a data transfer for a host channel and
+ * starts the transfer. May be called in either Slave mode or DMA mode. In
+ * Slave mode, the caller must ensure that there is sufficient space in the
+ * request queue and Tx Data FIFO.
+ *
+ * For an OUT transfer in Slave mode, it loads a data packet into the
+ * appropriate FIFO. If necessary, additional data packets will be loaded in
+ * the Host ISR.
+ *
+ * For an IN transfer in Slave mode, a data packet is requested. The data
+ * packets are unloaded from the Rx FIFO in the Host ISR. If necessary,
+ * additional data packets are requested in the Host ISR.
+ *
+ * For a PING transfer in Slave mode, the Do Ping bit is set in the HCTSIZ
+ * register along with a packet count of 1 and the channel is enabled. This
+ * causes a single PING transaction to occur. Other fields in HCTSIZ are
+ * simply set to 0 since no data transfer occurs in this case.
+ *
+ * For a PING transfer in DMA mode, the HCTSIZ register is initialized with
+ * all the information required to perform the subsequent data transfer. In
+ * addition, the Do Ping bit is set in the HCTSIZ register. In this case, the
+ * controller performs the entire PING protocol, then starts the data
+ * transfer.
+ */
+static void dwc_otg_hc_start_transfer(struct core_if *core_if,
+	struct dwc_hc *hc)
+{
+	union hcchar_data hcchar;
+	union hctsiz_data hctsiz;
+	u16 num_packets;
+	u32 max_hc_xfer_size = core_if->core_params->max_transfer_size;
+	u16 max_hc_pkt_count = core_if->core_params->max_packet_count;
+	struct dwc_hc_regs *hc_regs = core_if->host_if->hc_regs[hc->hc_num];
+	hctsiz.d32 = 0;
+
+	if (hc->do_ping) {
+		if (!core_if->dma_enable) {
+			dwc_otg_hc_do_ping(core_if, hc);
+			hc->xfer_started = 1;
+			return;
+		} else {
+			hctsiz.b.dopng = 1;
+		}
+	}
+
+	if (hc->do_split) {
+		num_packets = 1;
+
+		if (hc->complete_split && !hc->ep_is_in)
+			/*
+			 * For CSPLIT OUT Transfer, set the size to 0 so the
+			 * core doesn't expect any data written to the FIFO
+			 */
+			hc->xfer_len = 0;
+		else if (hc->ep_is_in || (hc->xfer_len > hc->max_packet))
+			hc->xfer_len = hc->max_packet;
+		else if (!hc->ep_is_in && (hc->xfer_len > 188))
+			hc->xfer_len = 188;
+
+		hctsiz.b.xfersize = hc->xfer_len;
+	} else {
+		/*
+		 * Ensure that the transfer length and packet count will fit
+		 * in the widths allocated for them in the HCTSIZn register.
+		 */
+		if (hc->ep_type == DWC_OTG_EP_TYPE_INTR ||
+				hc->ep_type == DWC_OTG_EP_TYPE_ISOC) {
+			u32 max_len = hc->multi_count * hc->max_packet;
+
+			/*
+			 * Make sure the transfer size is no larger than one
+			 * (micro)frame's worth of data. (A check was done
+			 * when the periodic transfer was accepted to ensure
+			 * that a (micro)frame's worth of data can be
+			 * programmed into a channel.)
+			 */
+			if (hc->xfer_len > max_len)
+				hc->xfer_len = max_len;
+		} else if (hc->xfer_len > max_hc_xfer_size) {
+			/*
+			 * Make sure that xfer_len is a multiple of max packet
+			 * size.
+			 */
+			hc->xfer_len = max_hc_xfer_size - hc->max_packet + 1;
+		}
+		if (hc->xfer_len > 0) {
+			num_packets = (hc->xfer_len + hc->max_packet - 1) /
+				hc->max_packet;
+			if (num_packets > max_hc_pkt_count) {
+				num_packets = max_hc_pkt_count;
+				hc->xfer_len = num_packets * hc->max_packet;
+			}
+		} else {
+			/* Need 1 packet for transfer length of 0. */
+			num_packets = 1;
+		}
+
+		if (hc->ep_is_in)
+			/*
+			 * Always program an integral # of max packets for IN
+			 * transfers.
+			 */
+			hc->xfer_len = num_packets * hc->max_packet;
+
+		if (hc->ep_type == DWC_OTG_EP_TYPE_INTR ||
+				hc->ep_type == DWC_OTG_EP_TYPE_ISOC)
+			/*
+			 * Make sure that the multi_count field matches the
+			 * actual transfer length.
+			 */
+			hc->multi_count = num_packets;
+
+		/* Set up the initial PID for the transfer. */
+		if (hc->ep_type == DWC_OTG_EP_TYPE_ISOC)
+			set_initial_xfer_pid(hc);
+
+		hctsiz.b.xfersize = hc->xfer_len;
+	}
+
+	hc->start_pkt_count = num_packets;
+	hctsiz.b.pktcnt = num_packets;
+	hctsiz.b.pid = hc->data_pid_start;
+	dwc_write_reg32(&hc_regs->hctsiz, hctsiz.d32);
+
+	if (core_if->dma_enable)
+		dwc_write_reg32(&hc_regs->hcdma, (u32) hc->xfer_buff);
+
+	/* Start the split */
+	if (hc->do_split) {
+		union hcsplt_data hcsplt;
+		hcsplt.d32 = dwc_read_reg32(&hc_regs->hcsplt);
+		hcsplt.b.spltena = 1;
+		dwc_write_reg32(&hc_regs->hcsplt, hcsplt.d32);
+	}
+
+	hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+	hcchar.b.multicnt = hc->multi_count;
+	hc_set_even_odd_frame(core_if, hc, &hcchar);
+
+	/* Set host channel enable after all other setup is complete. */
+	hcchar.b.chen = 1;
+	hcchar.b.chdis = 0;
+	dwc_write_reg32(&hc_regs->hcchar, hcchar.d32);
+
+	hc->xfer_started = 1;
+	hc->requests++;
+	if (!core_if->dma_enable && !hc->ep_is_in && hc->xfer_len > 0)
+		/* Load OUT packet into the appropriate Tx FIFO. */
+		dwc_otg_hc_write_packet(core_if, hc);
+}
+
+/**
+ * This function continues a data transfer that was started by previous call
+ * to dwc_otg_hc_start_transfer</code>. The caller must ensure there is
+ * sufficient space in the request queue and Tx Data FIFO. This function
+ * should only be called in Slave mode. In DMA mode, the controller acts
+ * autonomously to complete transfers programmed to a host channel.
+ *
+ * For an OUT transfer, a new data packet is loaded into the appropriate FIFO
+ * if there is any data remaining to be queued. For an IN transfer, another
+ * data packet is always requested. For the SETUP phase of a control transfer,
+ * this function does nothing.
+ */
+static int dwc_otg_hc_continue_transfer(struct core_if *core_if,
+	struct dwc_hc *hc)
+{
+	if (hc->do_split) {
+		/* SPLITs always queue just once per channel */
+		return 0;
+	} else if (hc->data_pid_start == DWC_OTG_HC_PID_SETUP) {
+		/* SETUPs are queued only once since they can't be NAKed. */
+		return 0;
+	} else if (hc->ep_is_in) {
+		/*
+		  * Always queue another request for other IN transfers. If
+		  * back-to-back INs are issued and NAKs are received for both,
+		  * the driver may still be processing the first NAK when the
+		  * second NAK is received. When the interrupt handler clears
+		  * the NAK interrupt for the first NAK, the second NAK will
+		  * not be seen. So we can't depend on the NAK interrupt
+		  * handler to requeue a NAKed request. Instead, IN requests
+		  * are issued each time this function is called. When the
+		  * transfer completes, the extra requests for the channel will
+		  * be flushed.
+		  */
+		union hcchar_data hcchar;
+		struct dwc_hc_regs *hc_regs =
+			core_if->host_if->hc_regs[hc->hc_num];
+
+		hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+		hc_set_even_odd_frame(core_if, hc, &hcchar);
+
+		hcchar.b.chen = 1;
+		hcchar.b.chdis = 0;
+		dwc_write_reg32(&hc_regs->hcchar, hcchar.d32);
+
+		hc->requests++;
+		return 1;
+	} else {
+		/* OUT transfers. */
+		if (hc->xfer_count < hc->xfer_len) {
+			if (hc->ep_type == DWC_OTG_EP_TYPE_INTR ||
+					hc->ep_type == DWC_OTG_EP_TYPE_ISOC) {
+				union hcchar_data hcchar;
+				struct dwc_hc_regs *hc_regs;
+
+				hc_regs = core_if->host_if->hc_regs[hc->hc_num];
+				hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
+				hc_set_even_odd_frame(core_if, hc, &hcchar);
+			}
+
+			/* Load OUT packet into the appropriate Tx FIFO. */
+			dwc_otg_hc_write_packet(core_if, hc);
+			hc->requests++;
+			return 1;
+		} else  {
+			return 0;
+		}
+	}
+}
+
+/**
+ * This function writes a packet into the Tx FIFO associated with the Host
+ * Channel. For a channel associated with a non-periodic EP, the non-periodic
+ * Tx FIFO is written. For a channel associated with a periodic EP, the
+ * periodic Tx FIFO is written. This function should only be called in Slave
+ * mode.
+ *
+ * Upon return the xfer_buff and xfer_count fields in hc are incremented by
+ * then number of bytes written to the Tx FIFO.
+ */
+
+/**
+ * Attempts to queue a single transaction request for a host channel
+ * associated with either a periodic or non-periodic transfer. This function
+ * assumes that there is space available in the appropriate request queue. For
+ * an OUT transfer or SETUP transaction in Slave mode, it checks whether space
+ * is available in the appropriate Tx FIFO.
+ */
+static int queue_transaction(struct dwc_hcd *hcd, struct dwc_hc *hc,
+			u16 _fifo_dwords_avail)
+{
+	int retval;
+
+	if (hcd->core_if->dma_enable) {
+		if (!hc->xfer_started) {
+			dwc_otg_hc_start_transfer(hcd->core_if, hc);
+			hc->qh->ping_state = 0;
+		}
+		retval = 0;
+	} else if (hc->halt_pending) {
+		/* Don't queue a request if the channel has been halted. */
+		retval = 0;
+	} else if (hc->halt_on_queue) {
+		dwc_otg_hc_halt(hcd->core_if, hc, hc->halt_status);
+		retval = 0;
+	} else if (hc->do_ping) {
+		if (!hc->xfer_started)
+			dwc_otg_hc_start_transfer(hcd->core_if, hc);
+		retval = 0;
+	} else if (!hc->ep_is_in ||
+			hc->data_pid_start == DWC_OTG_HC_PID_SETUP) {
+		if ((_fifo_dwords_avail * 4) >= hc->max_packet) {
+			if (!hc->xfer_started) {
+				dwc_otg_hc_start_transfer(hcd->core_if, hc);
+				retval = 1;
+			} else {
+				retval = dwc_otg_hc_continue_transfer(
+						hcd->core_if, hc);
+			}
+		} else {
+			retval = -1;
+		}
+	} else {
+		if (!hc->xfer_started) {
+			dwc_otg_hc_start_transfer(hcd->core_if, hc);
+			retval = 1;
+		} else {
+			retval = dwc_otg_hc_continue_transfer(hcd->core_if, hc);
+		}
+	}
+	return retval;
+}
+
+/**
+ * Processes active non-periodic channels and queues transactions for these
+ * channels to the DWC_otg controller. After queueing transactions, the NP Tx
+ * FIFO Empty interrupt is enabled if there are more transactions to queue as
+ * NP Tx FIFO or request queue space becomes available. Otherwise, the NP Tx
+ * FIFO Empty interrupt is disabled.
+ */
+static void process_non_periodic_channels(struct dwc_hcd *hcd)
+{
+	union gnptxsts_data tx_status;
+	struct list_head *orig_qh_ptr;
+	struct dwc_qh *qh;
+	int status;
+	int no_queue_space = 0;
+	int no_fifo_space = 0;
+	int more_to_do = 0;
+	struct core_global_regs *regs = hcd->core_if->core_global_regs;
+
+	/*
+	 * Keep track of the starting point. Skip over the start-of-list
+	 * entry.
+	 */
+	if (hcd->non_periodic_qh_ptr == &hcd->non_periodic_sched_active)
+		hcd->non_periodic_qh_ptr = hcd->non_periodic_qh_ptr->next;
+	orig_qh_ptr = hcd->non_periodic_qh_ptr;
+
+	/*
+	 * Process once through the active list or until no more space is
+	 * available in the request queue or the Tx FIFO.
+	 */
+	do {
+		tx_status.d32 = dwc_read_reg32(&regs->gnptxsts);
+		if (!hcd->core_if->dma_enable &&
+				tx_status.b.nptxqspcavail == 0) {
+			no_queue_space = 1;
+			break;
+		}
+
+		qh = list_entry(hcd->non_periodic_qh_ptr, struct dwc_qh,
+					qh_list_entry);
+		status = queue_transaction(hcd, qh->channel,
+					tx_status.b.nptxfspcavail);
+
+		if (status > 0) {
+			more_to_do = 1;
+		} else if (status < 0) {
+			no_fifo_space = 1;
+			break;
+		}
+
+		/* Advance to next QH, skipping start-of-list entry. */
+		hcd->non_periodic_qh_ptr = hcd->non_periodic_qh_ptr->next;
+		if (hcd->non_periodic_qh_ptr == &hcd->non_periodic_sched_active)
+			hcd->non_periodic_qh_ptr =
+				hcd->non_periodic_qh_ptr->next;
+	} while (hcd->non_periodic_qh_ptr != orig_qh_ptr);
+
+	if (!hcd->core_if->dma_enable) {
+		union gintmsk_data intr_mask = {.d32 = 0};
+
+		intr_mask.b.nptxfempty = 1;
+
+		if (more_to_do || no_queue_space || no_fifo_space) {
+			/*
+			 * May need to queue more transactions as the request
+			 * queue or Tx FIFO empties. Enable the non-periodic
+			 * Tx FIFO empty interrupt. (Always use the half-empty
+			 * level to ensure that new requests are loaded as
+			 * soon as possible.)
+			 */
+			dwc_modify_reg32(gintmsk_reg(hcd), 0, intr_mask.d32);
+		} else {
+			/*
+			 * Disable the Tx FIFO empty interrupt since there are
+			 * no more transactions that need to be queued right
+			 * now. This function is called from interrupt
+			 * handlers to queue more transactions as transfer
+			 * states change.
+			 */
+			dwc_modify_reg32(gintmsk_reg(hcd), intr_mask.d32, 0);
+		}
+	}
+}
+
+/**
+ * Processes periodic channels for the next frame and queues transactions for
+ * these channels to the DWC_otg controller. After queueing transactions, the
+ * Periodic Tx FIFO Empty interrupt is enabled if there are more transactions
+ * to queue as Periodic Tx FIFO or request queue space becomes available.
+ * Otherwise, the Periodic Tx FIFO Empty interrupt is disabled.
+ */
+static void process_periodic_channels(struct dwc_hcd *hcd)
+{
+	union hptxsts_data tx_status;
+	struct list_head *qh_ptr;
+	struct dwc_qh *qh;
+	int status;
+	int no_queue_space = 0;
+	int no_fifo_space = 0;
+	struct host_global_regs *host_regs;
+
+	host_regs = hcd->core_if->host_if->host_global_regs;
+
+	qh_ptr = hcd->periodic_sched_assigned.next;
+	while (qh_ptr != &hcd->periodic_sched_assigned) {
+		tx_status.d32 = dwc_read_reg32(&host_regs->hptxsts);
+		if (tx_status.b.ptxqspcavail == 0) {
+			no_queue_space = 1;
+			break;
+		}
+
+		qh = list_entry(qh_ptr, struct dwc_qh, qh_list_entry);
+
+		/*
+		 * Set a flag if we're queuing high-bandwidth in slave mode.
+		 * The flag prevents any halts to get into the request queue in
+		 * the middle of multiple high-bandwidth packets getting queued.
+		 */
+		if (!hcd->core_if->dma_enable && qh->channel->multi_count > 1)
+			hcd->core_if->queuing_high_bandwidth = 1;
+
+		status = queue_transaction(hcd, qh->channel,
+				tx_status.b.ptxfspcavail);
+		if (status < 0) {
+			no_fifo_space = 1;
+			break;
+		}
+
+		/*
+		 * In Slave mode, stay on the current transfer until there is
+		 * nothing more to do or the high-bandwidth request count is
+		 * reached. In DMA mode, only need to queue one request. The
+		 * controller automatically handles multiple packets for
+		 * high-bandwidth transfers.
+		 */
+		if (hcd->core_if->dma_enable || (status == 0 ||
+				qh->channel->requests ==
+				qh->channel->multi_count)) {
+			qh_ptr = qh_ptr->next;
+
+			/*
+			 * Move the QH from the periodic assigned schedule to
+			 * the periodic queued schedule.
+			 */
+			list_move(&qh->qh_list_entry,
+				  &hcd->periodic_sched_queued);
+
+			/* done queuing high bandwidth */
+			hcd->core_if->queuing_high_bandwidth = 0;
+		}
+	}
+
+	if (!hcd->core_if->dma_enable) {
+		union gintmsk_data intr_mask = {.d32 = 0};
+
+		intr_mask.b.ptxfempty = 1;
+
+		if (!list_empty(&hcd->periodic_sched_assigned) ||
+				no_queue_space || no_fifo_space)
+			/*
+			 * May need to queue more transactions as the request
+			 * queue or Tx FIFO empties. Enable the periodic Tx
+			 * FIFO empty interrupt. (Always use the half-empty
+			 * level to ensure that new requests are loaded as
+			 * soon as possible.)
+			 */
+			dwc_modify_reg32(gintmsk_reg(hcd), 0, intr_mask.d32);
+		else
+			/*
+			 * Disable the Tx FIFO empty interrupt since there are
+			 * no more transactions that need to be queued right
+			 * now. This function is called from interrupt
+			 * handlers to queue more transactions as transfer
+			 * states change.
+			 */
+			dwc_modify_reg32(gintmsk_reg(hcd), intr_mask.d32, 0);
+	}
+}
+
+/**
+ * This function processes the currently active host channels and queues
+ * transactions for these channels to the DWC_otg controller. It is called
+ * from HCD interrupt handler functions.
+ */
+void dwc_otg_hcd_queue_transactions(struct dwc_hcd *hcd,
+		enum dwc_transaction_type tr_type)
+{
+	/* Process host channels associated with periodic transfers. */
+	if ((tr_type == DWC_OTG_TRANSACTION_PERIODIC ||
+			tr_type == DWC_OTG_TRANSACTION_ALL) &&
+			!list_empty(&hcd->periodic_sched_assigned))
+		process_periodic_channels(hcd);
+
+	/* Process host channels associated with non-periodic transfers. */
+	if (tr_type == DWC_OTG_TRANSACTION_NON_PERIODIC ||
+			tr_type == DWC_OTG_TRANSACTION_ALL) {
+		if (!list_empty(&hcd->non_periodic_sched_active)) {
+			process_non_periodic_channels(hcd);
+		} else {
+			/*
+			 * Ensure NP Tx FIFO empty interrupt is disabled when
+			 * there are no non-periodic transfers to process.
+			 */
+			union gintmsk_data gintmsk = {.d32 = 0};
+			gintmsk.b.nptxfempty = 1;
+			dwc_modify_reg32(gintmsk_reg(hcd), gintmsk.d32, 0);
+		}
+	}
+}
+
+/**
+ * Sets the final status of an URB and returns it to the device driver. Any
+ * required cleanup of the URB is performed.
+ */
+void dwc_otg_hcd_complete_urb(struct dwc_hcd *hcd, struct urb *urb, int status)
+__releases(hcd->lock)
+__acquires(hcd->lock)
+{
+	urb->hcpriv = NULL;
+	usb_hcd_unlink_urb_from_ep(dwc_otg_hcd_to_hcd(hcd), urb);
+
+	spin_unlock(&hcd->lock);
+	usb_hcd_giveback_urb(dwc_otg_hcd_to_hcd(hcd), urb, status);
+	spin_lock(&hcd->lock);
+}
diff --git a/drivers/usb/dwc_otg/dwc_otg_hcd.h b/drivers/usb/dwc_otg/dwc_otg_hcd.h
new file mode 100644
index 0000000..dfe165e
--- /dev/null
+++ b/drivers/usb/dwc_otg/dwc_otg_hcd.h
@@ -0,0 +1,426 @@
+/*
+ * DesignWare HS OTG controller driver
+ *
+ * Author: Mark Miesfeld <mmiesfeld@apm.com>
+ *
+ * Based on versions provided by APM and Synopsis which are:
+ *	Copyright (C) 2009-2010 AppliedMicro(www.apm.com)
+ * Modified by Stefan Roese <sr@denx.de>, DENX Software Engineering
+ * Modified by Chuck Meade <chuck@theptrgroup.com>
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#if !defined(__DWC_HCD_H__)
+#define __DWC_HCD_H__
+
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#include "dwc_otg_driver.h"
+
+/*
+ * This file contains the structures, constants, and interfaces for
+ * the Host Contoller Driver (HCD).
+ *
+ * The Host Controller Driver (HCD) is responsible for translating requests
+ * from the USB Driver into the appropriate actions on the DWC_otg controller.
+ * It isolates the USBD from the specifics of the controller by providing an
+ * API to the USBD.
+ */
+
+/* Phases for control transfers. */
+enum dwc_control_phase {
+	DWC_OTG_CONTROL_SETUP,
+	DWC_OTG_CONTROL_DATA,
+	DWC_OTG_CONTROL_STATUS
+};
+
+/* Transaction types. */
+enum dwc_transaction_type {
+	DWC_OTG_TRANSACTION_NONE,
+	DWC_OTG_TRANSACTION_PERIODIC,
+	DWC_OTG_TRANSACTION_NON_PERIODIC,
+	DWC_OTG_TRANSACTION_ALL
+};
+
+/*
+ * A Queue Transfer Descriptor (QTD) holds the state of a bulk, control,
+ * interrupt, or isochronous transfer. A single QTD is created for each URB
+ * (of one of these types) submitted to the HCD. The transfer associated with
+ * a QTD may require one or multiple transactions.
+ *
+ * A QTD is linked to a Queue Head, which is entered in either the
+ * non-periodic or periodic schedule for execution. When a QTD is chosen for
+ * execution, some or all of its transactions may be executed. After
+ * execution, the state of the QTD is updated. The QTD may be retired if all
+ * its transactions are complete or if an error occurred. Otherwise, it
+ * remains in the schedule so more transactions can be executed later.
+ */
+struct dwc_qtd {
+	/*
+	 * Determines the PID of the next data packet for the data phase of
+	 * control transfers. Ignored for other transfer types.
+	 * One of the following values:
+	 *	- DWC_OTG_HC_PID_DATA0
+	 *	- DWC_OTG_HC_PID_DATA1
+	 */
+	u8 data_toggle;
+
+	/* Current phase for control transfers (Setup, Data, or Status). */
+	enum dwc_control_phase control_phase;
+
+	/*
+	 * Keep track of the current split type
+	 * for FS/LS endpoints on a HS Hub
+	 */
+	u8 complete_split;
+
+	/* How many bytes transferred during SSPLIT OUT */
+	u32 ssplit_out_xfer_count;
+
+	/*
+	 * Holds the number of bus errors that have occurred for a transaction
+	 * within this transfer.
+	 */
+	u8 error_count;
+
+	/*
+	 * Index of the next frame descriptor for an isochronous transfer. A
+	 * frame descriptor describes the buffer position and length of the
+	 * data to be transferred in the next scheduled (micro)frame of an
+	 * isochronous transfer. It also holds status for that transaction.
+	 * The frame index starts at 0.
+	 */
+	int isoc_frame_index;
+
+	/* Position of the ISOC split on full/low speed */
+	u8 isoc_split_pos;
+
+	/* Position of the ISOC split in the buffer for the current frame */
+	u16 isoc_split_offset;
+
+	/* URB for this transfer */
+	struct urb *urb;
+
+	/* This list of QTDs */
+	struct list_head qtd_list_entry;
+
+	/* Field to track the qh pointer */
+	struct dwc_qh *qtd_qh_ptr;
+};
+
+/*
+ * A Queue Head (QH) holds the static characteristics of an endpoint and
+ * maintains a list of transfers (QTDs) for that endpoint. A QH structure may
+ * be entered in either the non-periodic or periodic schedule.
+ */
+struct dwc_qh {
+	/*
+	 * Endpoint type.
+	 * One of the following values:
+	 *	- USB_ENDPOINT_XFER_CONTROL
+	 *	- USB_ENDPOINT_XFER_ISOC
+	 *	- USB_ENDPOINT_XFER_BULK
+	 *	- USB_ENDPOINT_XFER_INT
+	 */
+	u8 ep_type;
+	u8 ep_is_in;
+
+	/* wMaxPacketSize Field of Endpoint Descriptor. */
+	u16 maxp;
+
+	/*
+	 * Determines the PID of the next data packet for non-control
+	 * transfers. Ignored for control transfers.
+	 * One of the following values:
+	 *	- DWC_OTG_HC_PID_DATA0
+	 *	- DWC_OTG_HC_PID_DATA1
+	 */
+	u8 data_toggle;
+
+	/* Ping state if 1. */
+	u8 ping_state;
+
+	/* List of QTDs for this QH. */
+	struct list_head qtd_list;
+
+	/* Host channel currently processing transfers for this QH. */
+	struct dwc_hc *channel;
+
+	/* QTD currently assigned to a host channel for this QH. */
+	struct dwc_qtd *qtd_in_process;
+
+	/* Full/low speed endpoint on high-speed hub requires split. */
+	u8 do_split;
+
+	/* Periodic schedule information */
+
+	/* Bandwidth in microseconds per (micro)frame. */
+	u8 usecs;
+
+	/* Interval between transfers in (micro)frames. */
+	u16 interval;
+
+	/*
+	 * (micro)frame to initialize a periodic transfer. The transfer
+	 * executes in the following (micro)frame.
+	 */
+	u16 sched_frame;
+
+	/* (micro)frame at which last start split was initialized. */
+	u16 start_split_frame;
+
+	u16 speed;
+	u16 frame_usecs[8];
+
+	/* Entry for QH in either the periodic or non-periodic schedule. */
+	struct list_head qh_list_entry;
+};
+
+/* Gets the struct usb_hcd that contains a struct dwc_hcd. */
+static inline struct usb_hcd *dwc_otg_hcd_to_hcd(struct dwc_hcd *dwc_hcd)
+{
+	return container_of((void *)dwc_hcd, struct usb_hcd, hcd_priv);
+}
+
+/* HCD Create/Destroy Functions */
+extern int  __init dwc_otg_hcd_init(struct device *_dev,
+			struct dwc_otg_device *dwc_dev);
+extern void dwc_otg_hcd_remove(struct device *_dev);
+
+/*
+ * The following functions support managing the DWC_otg controller in host
+ * mode.
+ */
+extern int dwc_otg_hcd_get_frame_number(struct usb_hcd *hcd);
+extern void dwc_otg_hc_cleanup(struct core_if *core_if, struct dwc_hc *hc);
+extern void dwc_otg_hc_halt(struct core_if *core_if, struct dwc_hc *hc,
+				enum dwc_halt_status _halt_status);
+
+/* Transaction Execution Functions */
+extern enum dwc_transaction_type dwc_otg_hcd_select_transactions(
+				struct dwc_hcd *hcd);
+extern void dwc_otg_hcd_queue_transactions(struct dwc_hcd *hcd,
+			enum dwc_transaction_type tr_type);
+extern void dwc_otg_hcd_complete_urb(struct dwc_hcd *_hcd, struct urb *urb,
+				int status);
+
+/* Interrupt Handler Functions */
+extern int dwc_otg_hcd_handle_intr(struct dwc_hcd *hcd);
+
+/* Schedule Queue Functions */
+extern int init_hcd_usecs(struct dwc_hcd *hcd);
+extern void dwc_otg_hcd_qh_free(struct dwc_qh *qh);
+extern void dwc_otg_hcd_qh_remove(struct dwc_hcd *hcd, struct dwc_qh *qh);
+extern void dwc_otg_hcd_qh_deactivate(struct dwc_hcd *hcd, struct dwc_qh *qh,
+				int sched_csplit);
+extern int dwc_otg_hcd_qh_deferr(struct dwc_hcd *hcd, struct dwc_qh *qh,
+				int delay);
+extern struct dwc_qtd *dwc_otg_hcd_qtd_create(struct urb *urb,
+				gfp_t _mem_flags);
+extern int dwc_otg_hcd_qtd_add(struct dwc_qtd *qtd, struct dwc_hcd *dwc_hcd);
+
+/*
+ * Frees the memory for a QTD structure.  QTD should already be removed from
+ * list.
+ */
+static inline void dwc_otg_hcd_qtd_free(struct dwc_qtd *_qtd)
+{
+	kfree(_qtd);
+}
+
+/* Removes a QTD from list. */
+static inline void dwc_otg_hcd_qtd_remove(struct dwc_qtd *_qtd)
+{
+	list_del(&_qtd->qtd_list_entry);
+}
+
+/* Remove and free a QTD */
+static inline void dwc_otg_hcd_qtd_remove_and_free(struct dwc_qtd *_qtd)
+{
+	dwc_otg_hcd_qtd_remove(_qtd);
+	dwc_otg_hcd_qtd_free(_qtd);
+}
+
+struct dwc_qh *dwc_urb_to_qh(struct urb *_urb);
+
+/* Gets the usb_host_endpoint associated with an URB. */
+static inline struct usb_host_endpoint *dwc_urb_to_endpoint(struct urb *_urb)
+{
+	struct usb_device *dev = _urb->dev;
+	int ep_num = usb_pipeendpoint(_urb->pipe);
+
+	if (usb_pipein(_urb->pipe))
+		return dev->ep_in[ep_num];
+	else
+		return dev->ep_out[ep_num];
+}
+
+/*
+ * Gets the endpoint number from a _bEndpointAddress argument. The endpoint is
+ * qualified with its direction (possible 32 endpoints per device).
+ */
+#define dwc_ep_addr_to_endpoint(_bEndpointAddress_) \
+		((_bEndpointAddress_ & USB_ENDPOINT_NUMBER_MASK) | \
+		((_bEndpointAddress_ & USB_DIR_IN) != 0) << 4)
+
+/* Gets the QH that contains the list_head */
+#define dwc_list_to_qh(_list_head_ptr_) \
+		(container_of(_list_head_ptr_, struct dwc_qh, qh_list_entry))
+
+/* Gets the QTD that contains the list_head */
+#define dwc_list_to_qtd(_list_head_ptr_) \
+		(container_of(_list_head_ptr_, struct dwc_qtd, qtd_list_entry))
+
+/* Check if QH is non-periodic  */
+#define dwc_qh_is_non_per(_qh_ptr_) \
+		((_qh_ptr_->ep_type == USB_ENDPOINT_XFER_BULK) || \
+		(_qh_ptr_->ep_type == USB_ENDPOINT_XFER_CONTROL))
+
+/* High bandwidth multiplier as encoded in highspeed endpoint descriptors */
+#define dwc_hb_mult(wMaxPacketSize)	(1 + (((wMaxPacketSize) >> 11) & 0x03))
+
+/* Packet size for any kind of endpoint descriptor */
+#define dwc_max_packet(wMaxPacketSize)	((wMaxPacketSize) & 0x07ff)
+
+/*
+ * Returns true if _frame1 is less than or equal to _frame2. The comparison is
+ * done modulo DWC_HFNUM_MAX_FRNUM. This accounts for the rollover of the
+ * frame number when the max frame number is reached.
+ */
+static inline int dwc_frame_num_le(u16 _frame1, u16 _frame2)
+{
+	return ((_frame2 - _frame1) & DWC_HFNUM_MAX_FRNUM) <=
+			(DWC_HFNUM_MAX_FRNUM >> 1);
+}
+
+/*
+ * Returns true if _frame1 is greater than _frame2. The comparison is done
+ * modulo DWC_HFNUM_MAX_FRNUM. This accounts for the rollover of the frame
+ * number when the max frame number is reached.
+ */
+static inline int dwc_frame_num_gt(u16 _frame1, u16 _frame2)
+{
+	return (_frame1 != _frame2) &&
+			(((_frame1 - _frame2) &
+			DWC_HFNUM_MAX_FRNUM) < (DWC_HFNUM_MAX_FRNUM >> 1));
+}
+
+/*
+ * Increments _frame by the amount specified by _inc. The addition is done
+ * modulo DWC_HFNUM_MAX_FRNUM. Returns the incremented value.
+ */
+static inline u16 dwc_frame_num_inc(u16 _frame, u16 _inc)
+{
+	return (_frame + _inc) & DWC_HFNUM_MAX_FRNUM;
+}
+
+static inline u16 dwc_full_frame_num(u16 _frame)
+{
+	return ((_frame) & DWC_HFNUM_MAX_FRNUM) >> 3;
+}
+
+static inline u16 dwc_micro_frame_num(u16 _frame)
+{
+	return (_frame) & 0x7;
+}
+
+static inline u32 *gintsts_reg(struct dwc_hcd *hcd)
+{
+	return (u32 *) &hcd->core_if->core_global_regs->gintsts;
+}
+
+static inline u32 *gintmsk_reg(struct dwc_hcd *hcd)
+{
+	return (u32 *) &hcd->core_if->core_global_regs->gintmsk;
+}
+
+static inline u32 *gahbcfg_reg(struct dwc_hcd *hcd)
+{
+	return (u32 *) &hcd->core_if->core_global_regs->gahbcfg;
+}
+
+static inline const char *pipetype_str(unsigned int pipe)
+{
+	switch (usb_pipetype(pipe)) {
+	case PIPE_CONTROL:
+		return "control";
+	case PIPE_BULK:
+		return "bulk";
+	case PIPE_INTERRUPT:
+		return "interrupt";
+	case PIPE_ISOCHRONOUS:
+		return "isochronous";
+	default:
+		return "unknown";
+	}
+}
+
+static inline const char *dev_speed_str(enum usb_device_speed speed)
+{
+	switch (speed) {
+	case USB_SPEED_HIGH:
+		return "high";
+	case USB_SPEED_FULL:
+		return "full";
+	case USB_SPEED_LOW:
+		return "low";
+	default:
+		return "unknown";
+	}
+}
+
+static inline const char *ep_type_str(u8 type)
+{
+	switch (type) {
+	case USB_ENDPOINT_XFER_ISOC:
+		return "isochronous";
+	case USB_ENDPOINT_XFER_INT:
+		return "interrupt";
+	case USB_ENDPOINT_XFER_CONTROL:
+		return "control";
+	case USB_ENDPOINT_XFER_BULK:
+		return "bulk";
+	default:
+		return "?";
+	}
+}
+#endif
diff --git a/drivers/usb/dwc_otg/dwc_otg_hcd_intr.c b/drivers/usb/dwc_otg/dwc_otg_hcd_intr.c
new file mode 100644
index 0000000..9d86000
--- /dev/null
+++ b/drivers/usb/dwc_otg/dwc_otg_hcd_intr.c
@@ -0,0 +1,1476 @@
+/*
+ * DesignWare HS OTG controller driver
+ *
+ * Author: Mark Miesfeld <mmiesfeld@apm.com>
+ *
+ * Based on versions provided by APM and Synopsis which are:
+ *	Copyright (C) 2009-2010 AppliedMicro(www.apm.com)
+ * Modified by Stefan Roese <sr@denx.de>, DENX Software Engineering
+ * Modified by Chuck Meade <chuck@theptrgroup.com>
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include "dwc_otg_hcd.h"
+
+/* This file contains the implementation of the HCD Interrupt handlers.	*/
+static const int erratum_usb09_patched;
+static const int deferral_on = 1;
+static const int nak_deferral_delay = 8;
+static const int nyet_deferral_delay = 1;
+
+/**
+ * Handles the start-of-frame interrupt in host mode. Non-periodic
+ * transactions may be queued to the DWC_otg controller for the current
+ * (micro)frame. Periodic transactions may be queued to the controller for the
+ * next (micro)frame.
+ */
+static int dwc_otg_hcd_handle_sof_intr(struct dwc_hcd *hcd)
+{
+	union hfnum_data hfnum;
+	struct list_head *qh_entry;
+	struct dwc_qh *qh;
+	enum dwc_transaction_type tr_type;
+	union gintsts_data gintsts = {.d32 = 0};
+
+	hfnum.d32 =
+		dwc_read_reg32(&hcd->core_if->host_if->host_global_regs->hfnum);
+
+	hcd->frame_number = hfnum.b.frnum;
+
+	/* Determine whether any periodic QHs should be executed. */
+	qh_entry = hcd->periodic_sched_inactive.next;
+	while (qh_entry != &hcd->periodic_sched_inactive) {
+		qh = list_entry(qh_entry, struct dwc_qh, qh_list_entry);
+		qh_entry = qh_entry->next;
+
+		/*
+		 * If needed, move QH to the ready list to be executed next
+		 * (micro)frame.
+		 */
+		if (dwc_frame_num_le(qh->sched_frame, hcd->frame_number))
+			list_move(&qh->qh_list_entry,
+				&hcd->periodic_sched_ready);
+	}
+
+	tr_type = dwc_otg_hcd_select_transactions(hcd);
+	if (tr_type != DWC_OTG_TRANSACTION_NONE)
+		dwc_otg_hcd_queue_transactions(hcd, tr_type);
+
+	/* Clear interrupt */
+	gintsts.b.sofintr = 1;
+	dwc_write_reg32(gintsts_reg(hcd), gintsts.d32);
+	return 1;
+}
+
+/**
+ * Handles the Rx Status Queue Level Interrupt, which indicates that there is at
+ * least one packet in the Rx FIFO.  The packets are moved from the FIFO to
+ * memory if the DWC_otg controller is operating in Slave mode.
+ */
+static int dwc_otg_hcd_handle_rx_status_q_level_intr(struct dwc_hcd *hcd)
+{
+	union host_grxsts_data grxsts;
+	struct dwc_hc *hc = NULL;
+
+	grxsts.d32 = dwc_read_reg32(&hcd->core_if->core_global_regs->grxstsp);
+	hc = hcd->hc_ptr_array[grxsts.b.chnum];
+
+	/* Packet Status */
+	switch (grxsts.b.pktsts) {
+	case DWC_GRXSTS_PKTSTS_IN:
+		/* Read the data into the host buffer. */
+		if (grxsts.b.bcnt > 0) {
+			dwc_otg_read_packet(hcd->core_if, hc->xfer_buff,
+						grxsts.b.bcnt);
+			/* Update the HC fields for the next packet received. */
+			hc->xfer_count += grxsts.b.bcnt;
+			hc->xfer_buff += grxsts.b.bcnt;
+		}
+	case DWC_GRXSTS_PKTSTS_IN_XFER_COMP:
+	case DWC_GRXSTS_PKTSTS_DATA_TOGGLE_ERR:
+	case DWC_GRXSTS_PKTSTS_CH_HALTED:
+		/* Handled in interrupt, just ignore data */
+		break;
+	default:
+		printk(KERN_ERR "RX_STS_Q Interrupt: Unknown status %d\n",
+					grxsts.b.pktsts);
+		break;
+	}
+	return 1;
+}
+
+/**
+ * This interrupt occurs when the non-periodic Tx FIFO is half-empty. More
+ * data packets may be written to the FIFO for OUT transfers. More requests
+ * may be written to the non-periodic request queue for IN transfers. This
+ * interrupt is enabled only in Slave mode.
+ */
+static int dwc_otg_hcd_handle_np_tx_fifo_empty_intr(struct dwc_hcd *hcd)
+{
+	dwc_otg_hcd_queue_transactions(hcd, DWC_OTG_TRANSACTION_NON_PERIODIC);
+	return 1;
+}
+
+/**
+ * This interrupt occurs when the periodic Tx FIFO is half-empty. More data
+ * packets may be written to the FIFO for OUT transfers. More requests may be
+ * written to the periodic request queue for IN transfers. This interrupt is
+ * enabled only in Slave mode.
+ */
+static int dwc_otg_hcd_handle_perio_tx_fifo_empty_intr(struct dwc_hcd *hcd)
+{
+	dwc_otg_hcd_queue_transactions(hcd, DWC_OTG_TRANSACTION_PERIODIC);
+	return 1;
+}
+
+/**
+ * When the port changes to enabled it may be necessary to adjust the phy clock
+ * speed.
+ */
+static int adjusted_phy_clock_speed(struct dwc_hcd *hcd, union hprt0_data hprt0)
+{
+	int adjusted = 0;
+	union gusbcfg_data usbcfg;
+	struct core_params *params = hcd->core_if->core_params;
+	struct core_global_regs *g_regs = hcd->core_if->core_global_regs;
+	struct host_global_regs *h_regs =
+		hcd->core_if->host_if->host_global_regs;
+
+	usbcfg.d32 = dwc_read_reg32(&g_regs->gusbcfg);
+
+	if (hprt0.b.prtspd == DWC_HPRT0_PRTSPD_LOW_SPEED ||
+		hprt0.b.prtspd == DWC_HPRT0_PRTSPD_FULL_SPEED) {
+		/* Low power */
+		union hcfg_data hcfg;
+
+		if (usbcfg.b.phylpwrclksel == 0) {
+			/* Set PHY low power clock select for FS/LS devices */
+			usbcfg.b.phylpwrclksel = 1;
+			dwc_write_reg32(&g_regs->gusbcfg, usbcfg.d32);
+			adjusted = 1;
+		}
+
+		hcfg.d32 = dwc_read_reg32(&h_regs->hcfg);
+		if (hprt0.b.prtspd == DWC_HPRT0_PRTSPD_LOW_SPEED &&
+				params->host_ls_low_power_phy_clk ==
+				DWC_HOST_LS_LOW_POWER_PHY_CLK_PARAM_6MHZ) {
+			/* 6 MHZ, check for 6 MHZ clock select */
+			if (hcfg.b.fslspclksel != DWC_HCFG_6_MHZ) {
+				hcfg.b.fslspclksel = DWC_HCFG_6_MHZ;
+				dwc_write_reg32(&h_regs->hcfg, hcfg.d32);
+				adjusted = 1;
+			}
+		} else if (hcfg.b.fslspclksel != DWC_HCFG_48_MHZ) {
+			/* 48 MHZ and clock select is not 48 MHZ */
+			hcfg.b.fslspclksel = DWC_HCFG_48_MHZ;
+			dwc_write_reg32(&h_regs->hcfg, hcfg.d32);
+			adjusted = 1;
+		}
+	} else if (usbcfg.b.phylpwrclksel == 1) {
+		usbcfg.b.phylpwrclksel = 0;
+		dwc_write_reg32(&g_regs->gusbcfg, usbcfg.d32);
+		adjusted = 1;
+	}
+	if (adjusted)
+		schedule_work(&hcd->usb_port_reset);
+
+	return adjusted;
+}
+
+/**
+ * Helper function to handle the port enable changed interrupt when the port
+ * becomes enabled.  Checks if we need to adjust the PHY clock speed for low
+ * power and  adjusts it if needed.
+ */
+static void port_enabled(struct dwc_hcd *hcd, union hprt0_data hprt0)
+{
+	if (hcd->core_if->core_params->host_support_fs_ls_low_power)
+		if (!adjusted_phy_clock_speed(hcd, hprt0))
+			hcd->flags.b.port_reset_change = 1;
+}
+
+/**
+ * There are multiple conditions that can cause a port interrupt. This function
+ * determines which interrupt conditions have occurred and handles them
+ * appropriately.
+ */
+static int dwc_otg_hcd_handle_port_intr(struct dwc_hcd *hcd)
+{
+	int retval = 0;
+	union hprt0_data hprt0;
+	union hprt0_data hprt0_modify;
+	hprt0.d32 = dwc_read_reg32(hcd->core_if->host_if->hprt0);
+	hprt0_modify.d32 = dwc_read_reg32(hcd->core_if->host_if->hprt0);
+
+	/*
+	 * Clear appropriate bits in HPRT0 to clear the interrupt bit in
+	 * GINTSTS
+	 */
+	hprt0_modify.b.prtena = 0;
+	hprt0_modify.b.prtconndet = 0;
+	hprt0_modify.b.prtenchng = 0;
+	hprt0_modify.b.prtovrcurrchng = 0;
+
+	/* Port connect detected interrupt */
+	if (hprt0.b.prtconndet) {
+		/* Set the status flags and clear interrupt*/
+		hcd->flags.b.port_connect_status_change = 1;
+		hcd->flags.b.port_connect_status = 1;
+		hprt0_modify.b.prtconndet = 1;
+
+		/* B-Device has connected, Delete the connection timer. */
+		del_timer_sync(&hcd->conn_timer);
+
+		/*
+		 * The Hub driver asserts a reset when it sees port connect
+		 * status change flag
+		 */
+		retval |= 1;
+	}
+
+	/* Port enable changed interrupt */
+	if (hprt0.b.prtenchng) {
+		/* Set the internal flag if the port was disabled */
+		if (hprt0.b.prtena)
+			port_enabled(hcd, hprt0);
+		else
+			hcd->flags.b.port_enable_change = 1;
+
+		/* Clear the interrupt */
+		hprt0_modify.b.prtenchng = 1;
+		retval |= 1;
+	}
+
+	/* Overcurrent change interrupt	*/
+	if (hprt0.b.prtovrcurrchng) {
+		hcd->flags.b.port_over_current_change = 1;
+		hprt0_modify.b.prtovrcurrchng = 1;
+		retval |= 1;
+	}
+
+	/* Clear the port interrupts */
+	dwc_write_reg32(hcd->core_if->host_if->hprt0, hprt0_modify.d32);
+	return retval;
+}
+
+/**
+ * Gets the actual length of a transfer after the transfer halts. halt_status
+ * holds the reason for the halt.
+ *
+ * For IN transfers where halt_status is DWC_OTG_HC_XFER_COMPLETE, _short_read
+ * is set to 1 upon return if less than the requested number of bytes were
+ * transferred. Otherwise, _short_read is set to 0 upon return. _short_read may
+ * also be NULL on entry, in which case it remains unchanged.
+ */
+static u32 get_actual_xfer_length(struct dwc_hc *hc, struct dwc_hc_regs *regs,
+			struct dwc_qtd *qtd, enum dwc_halt_status halt_status,
+			int *_short_read)
+{
+	union hctsiz_data hctsiz;
+	u32 length;
+
+	if (_short_read)
+		*_short_read = 0;
+
+	hctsiz.d32 = dwc_read_reg32(&regs->hctsiz);
+	if (halt_status == DWC_OTG_HC_XFER_COMPLETE) {
+		if (hc->ep_is_in) {
+			length = hc->xfer_len - hctsiz.b.xfersize;
+			if (_short_read)
+				*_short_read = (hctsiz.b.xfersize != 0);
+		} else if (hc->qh->do_split) {
+			length = qtd->ssplit_out_xfer_count;
+		} else {
+			length = hc->xfer_len;
+		}
+	} else {
+		/*
+		 * Must use the hctsiz.pktcnt field to determine how much data
+		 * has been transferred. This field reflects the number of
+		 * packets that have been transferred via the USB. This is
+		 * always an integral number of packets if the transfer was
+		 * halted before its normal completion. (Can't use the
+		 * hctsiz.xfersize field because that reflects the number of
+		 * bytes transferred via the AHB, not the USB).
+		 */
+		length = (hc->start_pkt_count - hctsiz.b.pktcnt) *
+				hc->max_packet;
+	}
+	return length;
+}
+
+/**
+ * Updates the state of the URB after a Transfer Complete interrupt on the
+ * host channel. Updates the actual_length field of the URB based on the
+ * number of bytes transferred via the host channel. Sets the URB status
+ * if the data transfer is finished.
+ */
+static int update_urb_state_xfer_comp(struct dwc_hc *hc,
+			struct dwc_hc_regs *regs, struct urb *urb,
+			struct dwc_qtd *qtd, int *status)
+{
+	int xfer_done = 0;
+	int short_read = 0;
+
+	urb->actual_length += get_actual_xfer_length(hc, regs, qtd,
+			DWC_OTG_HC_XFER_COMPLETE, &short_read);
+
+	if (short_read || urb->actual_length == urb->transfer_buffer_length) {
+		xfer_done = 1;
+		if (short_read && (urb->transfer_flags & URB_SHORT_NOT_OK))
+			*status = -EREMOTEIO;
+		else
+			*status = 0;
+	}
+	return xfer_done;
+}
+
+/*
+ * Save the starting data toggle for the next transfer. The data toggle is
+ * saved in the QH for non-control transfers and it's saved in the QTD for
+ * control transfers.
+ */
+static void save_data_toggle(struct dwc_hc *hc, struct dwc_hc_regs *regs,
+				struct dwc_qtd *qtd)
+{
+	union hctsiz_data hctsiz;
+	hctsiz.d32 = dwc_read_reg32(&regs->hctsiz);
+
+	if (hc->ep_type != DWC_OTG_EP_TYPE_CONTROL) {
+		struct dwc_qh *qh = hc->qh;
+		if (hctsiz.b.pid == DWC_HCTSIZ_DATA0)
+			qh->data_toggle = DWC_OTG_HC_PID_DATA0;
+		else
+			qh->data_toggle = DWC_OTG_HC_PID_DATA1;
+	} else {
+		if (hctsiz.b.pid == DWC_HCTSIZ_DATA0)
+			qtd->data_toggle = DWC_OTG_HC_PID_DATA0;
+		else
+			qtd->data_toggle = DWC_OTG_HC_PID_DATA1;
+	}
+}
+
+/**
+ * Frees the first QTD in the QH's list if free_qtd is 1. For non-periodic
+ * QHs, removes the QH from the active non-periodic schedule. If any QTDs are
+ * still linked to the QH, the QH is added to the end of the inactive
+ * non-periodic schedule. For periodic QHs, removes the QH from the periodic
+ * schedule if no more QTDs are linked to the QH.
+ */
+static void deactivate_qh(struct dwc_hcd *hcd, struct dwc_qh *qh, int free_qtd)
+{
+	int continue_split = 0;
+	struct dwc_qtd *qtd;
+
+	qtd = list_entry(qh->qtd_list.next, struct dwc_qtd, qtd_list_entry);
+	if (qtd->complete_split)
+		continue_split = 1;
+	else if (qtd->isoc_split_pos == DWC_HCSPLIT_XACTPOS_MID ||
+			qtd->isoc_split_pos == DWC_HCSPLIT_XACTPOS_END)
+		continue_split = 1;
+
+	if (free_qtd) {
+		dwc_otg_hcd_qtd_remove(qtd);
+		continue_split = 0;
+	}
+
+	qh->channel = NULL;
+	qh->qtd_in_process = NULL;
+	dwc_otg_hcd_qh_deactivate(hcd, qh, continue_split);
+}
+
+/**
+ * Updates the state of an Isochronous URB when the transfer is stopped for
+ * any reason. The fields of the current entry in the frame descriptor array
+ * are set based on the transfer state and the input status. Completes the
+ * Isochronous URB if all the URB frames have been completed.
+ */
+static enum dwc_halt_status update_isoc_urb_state(struct dwc_hcd *hcd,
+		struct dwc_hc *hc, struct dwc_hc_regs *regs,
+		struct dwc_qtd *qtd, enum dwc_halt_status status)
+{
+	struct urb *urb = qtd->urb;
+	enum dwc_halt_status ret_val = status;
+	struct usb_iso_packet_descriptor *frame_desc;
+	frame_desc = &urb->iso_frame_desc[qtd->isoc_frame_index];
+
+	switch (status) {
+	case DWC_OTG_HC_XFER_COMPLETE:
+		frame_desc->status = 0;
+		frame_desc->actual_length =
+			get_actual_xfer_length(hc, regs, qtd, status, NULL);
+		break;
+	case DWC_OTG_HC_XFER_FRAME_OVERRUN:
+		urb->error_count++;
+		if (hc->ep_is_in)
+			frame_desc->status = -ENOSR;
+		else
+			frame_desc->status = -ECOMM;
+
+		frame_desc->actual_length = 0;
+		break;
+	case DWC_OTG_HC_XFER_BABBLE_ERR:
+		/* Don't need to update actual_length in this case. */
+		urb->error_count++;
+		frame_desc->status = -EOVERFLOW;
+		break;
+	case DWC_OTG_HC_XFER_XACT_ERR:
+		urb->error_count++;
+		frame_desc->status = -EPROTO;
+		frame_desc->actual_length =
+			get_actual_xfer_length(hc, regs, qtd, status, NULL);
+	default:
+		printk(KERN_ERR "%s: Unhandled halt_status (%d)\n", __func__,
+				status);
+		BUG();
+		break;
+	}
+
+	if (++qtd->isoc_frame_index == urb->number_of_packets) {
+		/*
+		 * urb->status is not used for isoc transfers.
+		 * The individual frame_desc statuses are used instead.
+		 */
+		dwc_otg_hcd_complete_urb(hcd, urb, 0);
+		ret_val = DWC_OTG_HC_XFER_URB_COMPLETE;
+	} else {
+		ret_val = DWC_OTG_HC_XFER_COMPLETE;
+	}
+	return ret_val;
+}
+
+/**
+ * Releases a host channel for use by other transfers. Attempts to select and
+ * queue more transactions since at least one host channel is available.
+ */
+static void release_channel(struct dwc_hcd *hcd, struct dwc_hc *hc,
+			struct dwc_qtd *qtd, enum dwc_halt_status halt_status,
+			int *must_free)
+{
+	enum dwc_transaction_type tr_type;
+	int free_qtd;
+	int deact = 1;
+	struct dwc_qh *qh;
+	int retry_delay = 1;
+
+	switch (halt_status) {
+	case DWC_OTG_HC_XFER_NYET:
+	case DWC_OTG_HC_XFER_NAK:
+		if (halt_status == DWC_OTG_HC_XFER_NYET)
+			retry_delay = nyet_deferral_delay;
+		else
+			retry_delay = nak_deferral_delay;
+		free_qtd = 0;
+		if (deferral_on && hc->do_split) {
+			qh = hc->qh;
+			if (qh)
+				deact = dwc_otg_hcd_qh_deferr(hcd, qh,
+						retry_delay);
+		}
+		break;
+	case DWC_OTG_HC_XFER_URB_COMPLETE:
+		free_qtd = 1;
+		break;
+	case DWC_OTG_HC_XFER_AHB_ERR:
+	case DWC_OTG_HC_XFER_STALL:
+	case DWC_OTG_HC_XFER_BABBLE_ERR:
+		free_qtd = 1;
+		break;
+	case DWC_OTG_HC_XFER_XACT_ERR:
+		if (qtd->error_count >= 3) {
+			free_qtd = 1;
+			dwc_otg_hcd_complete_urb(hcd, qtd->urb, -EPROTO);
+		} else {
+			free_qtd = 0;
+		}
+		break;
+	case DWC_OTG_HC_XFER_URB_DEQUEUE:
+		/*
+		 * The QTD has already been removed and the QH has been
+		 * deactivated. Don't want to do anything except release the
+		 * host channel and try to queue more transfers.
+		 */
+		goto cleanup;
+	case DWC_OTG_HC_XFER_NO_HALT_STATUS:
+		printk(KERN_ERR "%s: No halt_status, channel %d\n", __func__,
+				hc->hc_num);
+		free_qtd = 0;
+		break;
+	default:
+		free_qtd = 0;
+		break;
+	}
+	if (free_qtd)
+		/* must_free pre-initialized to zero */
+		*must_free = 1;
+	if (deact)
+		deactivate_qh(hcd, hc->qh, free_qtd);
+
+cleanup:
+	/*
+	 * Release the host channel for use by other transfers. The cleanup
+	 * function clears the channel interrupt enables and conditions, so
+	 * there's no need to clear the Channel Halted interrupt separately.
+	 */
+	dwc_otg_hc_cleanup(hcd->core_if, hc);
+	list_add_tail(&hc->hc_list_entry, &hcd->free_hc_list);
+	hcd->available_host_channels++;
+	/* Try to queue more transfers now that there's a free channel. */
+	if (!erratum_usb09_patched) {
+		tr_type = dwc_otg_hcd_select_transactions(hcd);
+		if (tr_type != DWC_OTG_TRANSACTION_NONE)
+			dwc_otg_hcd_queue_transactions(hcd, tr_type);
+	}
+}
+
+/**
+ * Halts a host channel. If the channel cannot be halted immediately because
+ * the request queue is full, this function ensures that the FIFO empty
+ * interrupt for the appropriate queue is enabled so that the halt request can
+ * be queued when there is space in the request queue.
+ *
+ * This function may also be called in DMA mode. In that case, the channel is
+ * simply released since the core always halts the channel automatically in
+ * DMA mode.
+ */
+static void halt_channel(struct dwc_hcd *hcd, struct dwc_hc *hc,
+	 struct dwc_qtd *qtd, enum dwc_halt_status halt_status, int *must_free)
+{
+	if (hcd->core_if->dma_enable) {
+		release_channel(hcd, hc, qtd, halt_status, must_free);
+		return;
+	}
+
+	/* Slave mode processing... */
+	dwc_otg_hc_halt(hcd->core_if, hc, halt_status);
+	if (hc->halt_on_queue) {
+		union gintmsk_data gintmsk = {.d32 = 0};
+
+		if (hc->ep_type == DWC_OTG_EP_TYPE_CONTROL ||
+				hc->ep_type == DWC_OTG_EP_TYPE_BULK) {
+			/*
+			 * Make sure the Non-periodic Tx FIFO empty interrupt
+			 * is enabled so that the non-periodic schedule will
+			 * be processed.
+			 */
+			gintmsk.b.nptxfempty = 1;
+			dwc_modify_reg32(gintmsk_reg(hcd), 0, gintmsk.d32);
+		} else {
+			/*
+			 * Move the QH from the periodic queued schedule to
+			 * the periodic assigned schedule. This allows the
+			 * halt to be queued when the periodic schedule is
+			 * processed.
+			 */
+			list_move(&hc->qh->qh_list_entry,
+				&hcd->periodic_sched_assigned);
+
+			/*
+			 * Make sure the Periodic Tx FIFO Empty interrupt is
+			 * enabled so that the periodic schedule will be
+			 * processed.
+			 */
+			gintmsk.b.ptxfempty = 1;
+			dwc_modify_reg32(gintmsk_reg(hcd), 0, gintmsk.d32);
+		}
+	}
+}
+
+/**
+ * Performs common cleanup for non-periodic transfers after a Transfer
+ * Complete interrupt. This function should be called after any endpoint type
+ * specific handling is finished to release the host channel.
+ */
+static void complete_non_periodic_xfer(struct dwc_hcd *hcd, struct dwc_hc *hc,
+			struct dwc_hc_regs *regs, struct dwc_qtd *qtd,
+			enum dwc_halt_status halt_status, int *must_free)
+{
+	union hcint_data hcint;
+
+	qtd->error_count = 0;
+	hcint.d32 = dwc_read_reg32(&regs->hcint);
+	if (hcint.b.nyet) {
+		union hcint_data hcint_clear = { .d32 = 0};
+		hcint_clear.b.nyet = 1;
+
+		/*
+		 * Got a NYET on the last transaction of the transfer. This
+		 * means that the endpoint should be in the PING state at the
+		 * beginning of the next transfer.
+		 */
+		hc->qh->ping_state = 1;
+		dwc_write_reg32(&(regs->hcint), hcint_clear.d32);
+	}
+
+	/*
+	 * Always halt and release the host channel to make it available for
+	 * more transfers. There may still be more phases for a control
+	 * transfer or more data packets for a bulk transfer at this point,
+	 * but the host channel is still halted. A channel will be reassigned
+	 * to the transfer when the non-periodic schedule is processed after
+	 * the channel is released. This allows transactions to be queued
+	 * properly via dwc_otg_hcd_queue_transactions, which also enables the
+	 * Tx FIFO Empty interrupt if necessary.
+	 *
+	 * IN transfers in Slave mode require an explicit disable to
+	 * halt the channel. (In DMA mode, this call simply releases
+	 * the channel.)
+	 *
+	 * The channel is automatically disabled by the core for OUT
+	 * transfers in Slave mode.
+	 */
+	if (hc->ep_is_in)
+		halt_channel(hcd, hc, qtd, halt_status, must_free);
+	else
+		release_channel(hcd, hc, qtd, halt_status, must_free);
+}
+
+/**
+ * Performs common cleanup for periodic transfers after a Transfer Complete
+ * interrupt. This function should be called after any endpoint type specific
+ * handling is finished to release the host channel.
+ */
+static void complete_periodic_xfer(struct dwc_hcd *hcd, struct dwc_hc *hc,
+		struct dwc_hc_regs *regs, struct dwc_qtd *qtd,
+		enum dwc_halt_status halt_status, int *must_free)
+{
+	union hctsiz_data hctsiz;
+
+	hctsiz.d32 = dwc_read_reg32(&regs->hctsiz);
+	qtd->error_count = 0;
+
+	/*
+	 * For OUT transfers and 0 packet count, the Core halts the channel,
+	 * otherwise, Flush any outstanding requests from the Tx queue.
+	 */
+	if (!hc->ep_is_in || hctsiz.b.pktcnt == 0)
+		release_channel(hcd, hc, qtd, halt_status, must_free);
+	else
+		halt_channel(hcd, hc, qtd, halt_status, must_free);
+}
+
+/**
+ * Handles a host channel Transfer Complete interrupt. This handler may be
+ * called in either DMA mode or Slave mode.
+ */
+static int handle_hc_xfercomp_intr(struct dwc_hcd *hcd, struct dwc_hc *hc,
+		struct dwc_hc_regs *regs, struct dwc_qtd *qtd, int  *must_free)
+{
+	int urb_xfer_done;
+	enum dwc_halt_status halt_status = DWC_OTG_HC_XFER_COMPLETE;
+	struct urb *urb = qtd->urb;
+	int pipe_type = usb_pipetype(urb->pipe);
+	int status = -EINPROGRESS;
+	union hcintmsk_data hcintmsk = {.d32 = 0};
+
+	/* Handle xfer complete on CSPLIT. */
+	if (hc->qh->do_split)
+		qtd->complete_split = 0;
+
+	/* Update the QTD and URB states. */
+	switch (pipe_type) {
+	case PIPE_CONTROL:
+		switch (qtd->control_phase) {
+		case DWC_OTG_CONTROL_SETUP:
+			if (urb->transfer_buffer_length > 0)
+				qtd->control_phase = DWC_OTG_CONTROL_DATA;
+			else
+				qtd->control_phase = DWC_OTG_CONTROL_STATUS;
+			halt_status = DWC_OTG_HC_XFER_COMPLETE;
+			break;
+		case DWC_OTG_CONTROL_DATA:
+			urb_xfer_done = update_urb_state_xfer_comp(hc, regs,
+							urb, qtd, &status);
+			if (urb_xfer_done)
+				qtd->control_phase = DWC_OTG_CONTROL_STATUS;
+			else
+				save_data_toggle(hc, regs, qtd);
+			halt_status = DWC_OTG_HC_XFER_COMPLETE;
+			break;
+		case DWC_OTG_CONTROL_STATUS:
+			if (status == -EINPROGRESS)
+				status = 0;
+			dwc_otg_hcd_complete_urb(hcd, urb, status);
+			halt_status = DWC_OTG_HC_XFER_URB_COMPLETE;
+			break;
+		}
+		complete_non_periodic_xfer(hcd, hc, regs, qtd,
+			halt_status, must_free);
+		break;
+	case PIPE_BULK:
+		urb_xfer_done = update_urb_state_xfer_comp(hc, regs, urb, qtd,
+								&status);
+		if (urb_xfer_done) {
+			dwc_otg_hcd_complete_urb(hcd, urb, status);
+			halt_status = DWC_OTG_HC_XFER_URB_COMPLETE;
+		} else {
+			halt_status = DWC_OTG_HC_XFER_COMPLETE;
+		}
+
+		save_data_toggle(hc, regs, qtd);
+		complete_non_periodic_xfer(hcd, hc, regs, qtd,
+			halt_status, must_free);
+		break;
+	case PIPE_INTERRUPT:
+		update_urb_state_xfer_comp(hc, regs, urb, qtd, &status);
+		/*
+		 * Interrupt URB is done on the first transfer complete
+		 * interrupt.
+		 */
+		dwc_otg_hcd_complete_urb(hcd, urb, status);
+		save_data_toggle(hc, regs, qtd);
+		complete_periodic_xfer(hcd, hc, regs, qtd,
+			DWC_OTG_HC_XFER_URB_COMPLETE, must_free);
+		break;
+	case PIPE_ISOCHRONOUS:
+		if (qtd->isoc_split_pos == DWC_HCSPLIT_XACTPOS_ALL) {
+			halt_status = update_isoc_urb_state(hcd, hc, regs, qtd,
+					DWC_OTG_HC_XFER_COMPLETE);
+		}
+		complete_periodic_xfer(hcd, hc, regs, qtd,
+			halt_status, must_free);
+		break;
+	}
+
+	/* disable xfercompl */
+	hcintmsk.b.xfercompl = 1;
+	dwc_modify_reg32(&regs->hcintmsk, hcintmsk.d32, 0);
+
+	return 1;
+}
+
+/**
+ * Handles a host channel STALL interrupt. This handler may be called in
+ * either DMA mode or Slave mode.
+ */
+static int handle_hc_stall_intr(struct dwc_hcd *hcd, struct dwc_hc *hc,
+		struct dwc_hc_regs *regs, struct dwc_qtd *qtd, int *must_free)
+{
+	struct urb *urb = qtd->urb;
+	int pipe_type = usb_pipetype(urb->pipe);
+	union hcintmsk_data hcintmsk = {.d32 = 0};
+
+	if (pipe_type == PIPE_CONTROL)
+		dwc_otg_hcd_complete_urb(hcd, qtd->urb, -EPIPE);
+
+	if (pipe_type == PIPE_BULK || pipe_type == PIPE_INTERRUPT) {
+		dwc_otg_hcd_complete_urb(hcd, qtd->urb, -EPIPE);
+		/*
+		 * USB protocol requires resetting the data toggle for bulk
+		 * and interrupt endpoints when a CLEAR_FEATURE(ENDPOINT_HALT)
+		 * setup command is issued to the endpoint. Anticipate the
+		 * CLEAR_FEATURE command since a STALL has occurred and reset
+		 * the data toggle now.
+		 */
+		hc->qh->data_toggle = 0;
+	}
+
+	halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_STALL, must_free);
+	/* disable stall */
+	hcintmsk.b.stall = 1;
+	dwc_modify_reg32(&regs->hcintmsk, hcintmsk.d32, 0);
+
+	return 1;
+}
+
+/**
+ * Updates the state of the URB when a transfer has been stopped due to an
+ * abnormal condition before the transfer completes. Modifies the
+ * actual_length field of the URB to reflect the number of bytes that have
+ * actually been transferred via the host channel.
+ */
+static void update_urb_state_xfer_intr(struct dwc_hc *hc,
+		 struct dwc_hc_regs *regs, struct urb *urb, struct dwc_qtd *qtd,
+		enum dwc_halt_status sts)
+{
+	u32 xfr_len = get_actual_xfer_length(hc, regs, qtd, sts, NULL);
+	urb->actual_length += xfr_len;
+}
+
+/**
+ * Handles a host channel NAK interrupt. This handler may be called in either
+ * DMA mode or Slave mode.
+ */
+static int handle_hc_nak_intr(struct dwc_hcd *hcd, struct dwc_hc *hc,
+		struct dwc_hc_regs *regs, struct dwc_qtd *qtd, int *must_free)
+{
+	union hcintmsk_data hcintmsk = {.d32 = 0};
+	/*
+	 * Handle NAK for IN/OUT SSPLIT/CSPLIT transfers, bulk, control, and
+	 * interrupt.  Re-start the SSPLIT transfer.
+	 */
+	if (hc->do_split) {
+		if (hc->complete_split)
+			qtd->error_count = 0;
+
+		qtd->complete_split = 0;
+		halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_NAK, must_free);
+		goto handle_nak_done;
+	}
+	switch (usb_pipetype(qtd->urb->pipe)) {
+	case PIPE_CONTROL:
+	case PIPE_BULK:
+		if (hcd->core_if->dma_enable && hc->ep_is_in) {
+			/*
+			 * NAK interrupts are enabled on bulk/control IN
+			 * transfers in DMA mode for the sole purpose of
+			 * resetting the error count after a transaction error
+			 * occurs. The core will continue transferring data.
+			 */
+			qtd->error_count = 0;
+			goto handle_nak_done;
+		}
+
+		/*
+		 * NAK interrupts normally occur during OUT transfers in DMA
+		 * or Slave mode. For IN transfers, more requests will be
+		 * queued as request queue space is available.
+		 */
+		qtd->error_count = 0;
+		if (!hc->qh->ping_state) {
+			update_urb_state_xfer_intr(hc, regs, qtd->urb, qtd,
+							DWC_OTG_HC_XFER_NAK);
+
+			save_data_toggle(hc, regs, qtd);
+			if (qtd->urb->dev->speed == USB_SPEED_HIGH)
+				hc->qh->ping_state = 1;
+		}
+
+		/*
+		 * Halt the channel so the transfer can be re-started from
+		 * the appropriate point or the PING protocol will
+		 * start/continue.
+		 */
+		halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_NAK, must_free);
+		break;
+	case PIPE_INTERRUPT:
+		qtd->error_count = 0;
+		halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_NAK, must_free);
+		break;
+	case PIPE_ISOCHRONOUS:
+		/* Should never get called for isochronous transfers. */
+		BUG();
+		break;
+	}
+
+handle_nak_done:
+	/* disable nak */
+	hcintmsk.b.nak = 1;
+	dwc_modify_reg32(&regs->hcintmsk, hcintmsk.d32, 0);
+
+	return 1;
+}
+
+/**
+ * Helper function for handle_hc_ack_intr().  Sets the split values for an ACK
+ * on SSPLIT for ISOC OUT.
+ */
+static void set_isoc_out_vals(struct dwc_hc *hc, struct dwc_qtd *qtd)
+{
+	struct usb_iso_packet_descriptor *frame_desc;
+
+	switch (hc->xact_pos) {
+	case DWC_HCSPLIT_XACTPOS_ALL:
+		break;
+	case DWC_HCSPLIT_XACTPOS_END:
+		qtd->isoc_split_pos = DWC_HCSPLIT_XACTPOS_ALL;
+		qtd->isoc_split_offset = 0;
+		break;
+	case DWC_HCSPLIT_XACTPOS_BEGIN:
+	case DWC_HCSPLIT_XACTPOS_MID:
+		/*
+		 * For BEGIN or MID, calculate the length for the next
+		 * microframe to determine the correct SSPLIT token, either MID
+		 * or END.
+		 */
+		frame_desc = &qtd->urb->iso_frame_desc[qtd->isoc_frame_index];
+		qtd->isoc_split_offset += 188;
+
+		if ((frame_desc->length - qtd->isoc_split_offset) <= 188)
+			qtd->isoc_split_pos = DWC_HCSPLIT_XACTPOS_END;
+		else
+			qtd->isoc_split_pos = DWC_HCSPLIT_XACTPOS_MID;
+
+		break;
+	}
+}
+
+/**
+ * Handles a host channel ACK interrupt. This interrupt is enabled when
+ * performing the PING protocol in Slave mode, when errors occur during
+ * either Slave mode or DMA mode, and during Start Split transactions.
+ */
+static int handle_hc_ack_intr(struct dwc_hcd *hcd, struct dwc_hc *hc,
+			struct dwc_hc_regs *regs, struct dwc_qtd *qtd,
+			int *must_free)
+{
+	union hcintmsk_data hcintmsk = {.d32 = 0};
+
+	if (hc->do_split) {
+		/* Handle ACK on SSPLIT. ACK should not occur in CSPLIT. */
+		if (!hc->ep_is_in && hc->data_pid_start != DWC_OTG_HC_PID_SETUP)
+			qtd->ssplit_out_xfer_count = hc->xfer_len;
+
+		/* Don't need complete for isochronous out transfers. */
+		if (!(hc->ep_type == DWC_OTG_EP_TYPE_ISOC && !hc->ep_is_in))
+			qtd->complete_split = 1;
+
+		if (hc->ep_type == DWC_OTG_EP_TYPE_ISOC && !hc->ep_is_in)
+			set_isoc_out_vals(hc, qtd);
+		else
+			halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_ACK,
+				must_free);
+	} else {
+		qtd->error_count = 0;
+		if (hc->qh->ping_state) {
+			hc->qh->ping_state = 0;
+
+			/*
+			 * Halt the channel so the transfer can be re-started
+			 * from the appropriate point. This only happens in
+			 * Slave mode. In DMA mode, the ping_state is cleared
+			 * when the transfer is started because the core
+			 * automatically executes the PING, then the transfer.
+			 */
+			halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_ACK,
+				must_free);
+		}
+	}
+
+	/*
+	 * If the ACK occurred when _not_ in the PING state, let the channel
+	 * continue transferring data after clearing the error count.
+	 */
+	/* disable ack */
+	hcintmsk.b.ack = 1;
+	dwc_modify_reg32(&regs->hcintmsk, hcintmsk.d32, 0);
+
+	return 1;
+}
+
+/**
+ * Handles a host channel NYET interrupt. This interrupt should only occur on
+ * Bulk and Control OUT endpoints and for complete split transactions. If a
+ * NYET occurs at the same time as a Transfer Complete interrupt, it is
+ * handled in the xfercomp interrupt handler, not here. This handler may be
+ * called in either DMA mode or Slave mode.
+ */
+static int handle_hc_nyet_intr(struct dwc_hcd *hcd, struct dwc_hc *hc,
+		struct dwc_hc_regs *regs, struct dwc_qtd *qtd, int *must_free)
+{
+	union hcintmsk_data hcintmsk = {.d32 = 0};
+	union hcint_data hcint_clear = {.d32 = 0};
+
+	/*
+	 * NYET on CSPLIT
+	 * re-do the CSPLIT immediately on non-periodic
+	 */
+	if (hc->do_split && hc->complete_split) {
+		if (hc->ep_type == DWC_OTG_EP_TYPE_INTR ||
+				hc->ep_type == DWC_OTG_EP_TYPE_ISOC) {
+			int frnum = dwc_otg_hcd_get_frame_number(
+					dwc_otg_hcd_to_hcd(hcd));
+			if (dwc_full_frame_num(frnum) !=
+				dwc_full_frame_num(hc->qh->sched_frame)) {
+				qtd->complete_split = 0;
+				halt_channel(hcd, hc, qtd,
+					DWC_OTG_HC_XFER_XACT_ERR, must_free);
+				goto handle_nyet_done;
+			}
+		}
+		halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_NYET, must_free);
+		goto handle_nyet_done;
+	}
+	hc->qh->ping_state = 1;
+	qtd->error_count = 0;
+	update_urb_state_xfer_intr(hc, regs, qtd->urb, qtd,
+				DWC_OTG_HC_XFER_NYET);
+	save_data_toggle(hc, regs, qtd);
+	/*
+	 * Halt the channel and re-start the transfer so the PING
+	 * protocol will start.
+	 */
+	halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_NYET, must_free);
+
+handle_nyet_done:
+	/* disable nyet */
+	hcintmsk.b.nyet = 1;
+	dwc_modify_reg32(&regs->hcintmsk, hcintmsk.d32, 0);
+	/* clear nyet */
+	hcint_clear.b.nyet = 1;
+	dwc_write_reg32(&(regs->hcint), hcint_clear.d32);
+	return 1;
+}
+
+/**
+ * Handles a host channel babble interrupt. This handler may be called in
+ * either DMA mode or Slave mode.
+ */
+static int handle_hc_babble_intr(struct dwc_hcd *hcd, struct dwc_hc *hc,
+		struct dwc_hc_regs *regs, struct dwc_qtd *qtd, int *must_free)
+{
+	union hcintmsk_data hcintmsk = {.d32 = 0};
+
+	if (hc->ep_type != DWC_OTG_EP_TYPE_ISOC) {
+		dwc_otg_hcd_complete_urb(hcd, qtd->urb, -EOVERFLOW);
+		halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_BABBLE_ERR,
+			must_free);
+	} else {
+		enum dwc_halt_status halt_status;
+		halt_status = update_isoc_urb_state(hcd, hc, regs, qtd,
+				DWC_OTG_HC_XFER_BABBLE_ERR);
+		halt_channel(hcd, hc, qtd, halt_status, must_free);
+	}
+	/* disable bblerr */
+	hcintmsk.b.bblerr = 1;
+	dwc_modify_reg32(&regs->hcintmsk, hcintmsk.d32, 0);
+	return 1;
+}
+
+/**
+ * Handles a host channel AHB error interrupt. This handler is only called in
+ * DMA mode.
+ */
+static int handle_hc_ahberr_intr(struct dwc_hcd *hcd, struct dwc_hc *hc,
+			struct dwc_hc_regs *regs, struct dwc_qtd *qtd)
+{
+	union hcchar_data hcchar;
+	union hcsplt_data hcsplt;
+	union hctsiz_data hctsiz;
+	u32 hcdma;
+	struct urb *urb = qtd->urb;
+	union hcintmsk_data hcintmsk = {.d32 = 0};
+
+	hcchar.d32 = dwc_read_reg32(&regs->hcchar);
+	hcsplt.d32 = dwc_read_reg32(&regs->hcsplt);
+	hctsiz.d32 = dwc_read_reg32(&regs->hctsiz);
+	hcdma = dwc_read_reg32(&regs->hcdma);
+
+	printk(KERN_ERR "AHB ERROR, Channel %d\n", hc->hc_num);
+	printk(KERN_ERR "  hcchar 0x%08x, hcsplt 0x%08x\n", hcchar.d32,
+				hcsplt.d32);
+	printk(KERN_ERR "  hctsiz 0x%08x, hcdma 0x%08x\n", hctsiz.d32, hcdma);
+
+	printk(KERN_ERR "  Device address: %d\n", usb_pipedevice(urb->pipe));
+	printk(KERN_ERR "  Endpoint: %d, %s\n", usb_pipeendpoint(urb->pipe),
+			(usb_pipein(urb->pipe) ? "IN" : "OUT"));
+
+	printk(KERN_ERR "  Endpoint type: %s\n", pipetype_str(urb->pipe));
+	printk(KERN_ERR "  Speed: %s\n", dev_speed_str(urb->dev->speed));
+	printk(KERN_ERR "  Max packet size: %d\n",
+		usb_maxpacket(urb->dev, urb->pipe, usb_pipeout(urb->pipe)));
+	printk(KERN_ERR "  Data buffer length: %d\n",
+		urb->transfer_buffer_length);
+	printk(KERN_ERR "  Transfer buffer: %p, Transfer DMA: %p\n",
+		urb->transfer_buffer, (void *) urb->transfer_dma);
+	printk(KERN_ERR "  Setup buffer: %p, Setup DMA: %p\n",
+		urb->setup_packet, (void *) urb->setup_dma);
+	printk(KERN_ERR "  Interval: %d\n", urb->interval);
+
+	dwc_otg_hcd_complete_urb(hcd, urb, -EIO);
+
+	/*
+	 * Force a channel halt. Don't call halt_channel because that won't
+	 * write to the HCCHARn register in DMA mode to force the halt.
+	 */
+	dwc_otg_hc_halt(hcd->core_if, hc, DWC_OTG_HC_XFER_AHB_ERR);
+	/* disable ahberr */
+	hcintmsk.b.ahberr = 1;
+	dwc_modify_reg32(&regs->hcintmsk, hcintmsk.d32, 0);
+
+	return 1;
+}
+
+/**
+ * Handles a host channel transaction error interrupt. This handler may be
+ * called in either DMA mode or Slave mode.
+ */
+static int handle_hc_xacterr_intr(struct dwc_hcd *hcd, struct dwc_hc *hc,
+		struct dwc_hc_regs *regs, struct dwc_qtd *qtd, int *must_free)
+{
+	enum dwc_halt_status status = DWC_OTG_HC_XFER_XACT_ERR;
+	union hcintmsk_data hcintmsk = {.d32 = 0};
+
+	switch (usb_pipetype(qtd->urb->pipe)) {
+	case PIPE_CONTROL:
+	case PIPE_BULK:
+		qtd->error_count++;
+		if (!hc->qh->ping_state) {
+			update_urb_state_xfer_intr(hc, regs, qtd->urb, qtd,
+							status);
+			save_data_toggle(hc, regs, qtd);
+
+			if (!hc->ep_is_in && qtd->urb->dev->speed ==
+					USB_SPEED_HIGH)
+				hc->qh->ping_state = 1;
+		}
+		/*
+		 * Halt the channel so the transfer can be re-started from
+		 * the appropriate point or the PING protocol will start.
+		 */
+		halt_channel(hcd, hc, qtd, status, must_free);
+		break;
+	case PIPE_INTERRUPT:
+		qtd->error_count++;
+		if (hc->do_split && hc->complete_split)
+			qtd->complete_split = 0;
+
+		halt_channel(hcd, hc, qtd, status, must_free);
+		break;
+	case PIPE_ISOCHRONOUS:
+		status = update_isoc_urb_state(hcd, hc, regs, qtd, status);
+		halt_channel(hcd, hc, qtd, status, must_free);
+		break;
+	}
+	/* Disable xacterr */
+	hcintmsk.b.xacterr = 1;
+	dwc_modify_reg32(&regs->hcintmsk, hcintmsk.d32, 0);
+
+	return 1;
+}
+
+/**
+ * Handles a host channel frame overrun interrupt. This handler may be called
+ * in either DMA mode or Slave mode.
+ */
+static int handle_hc_frmovrun_intr(struct dwc_hcd *hcd, struct dwc_hc *hc,
+		struct dwc_hc_regs *regs, struct dwc_qtd *qtd, int *must_free)
+{
+	enum dwc_halt_status status = DWC_OTG_HC_XFER_FRAME_OVERRUN;
+	union hcintmsk_data hcintmsk = {.d32 = 0};
+
+	switch (usb_pipetype(qtd->urb->pipe)) {
+	case PIPE_CONTROL:
+	case PIPE_BULK:
+		break;
+	case PIPE_INTERRUPT:
+		halt_channel(hcd, hc, qtd, status, must_free);
+		break;
+	case PIPE_ISOCHRONOUS:
+		status = update_isoc_urb_state(hcd, hc, regs, qtd, status);
+		halt_channel(hcd, hc, qtd, status, must_free);
+		break;
+	}
+	/* Disable frmovrun */
+	hcintmsk.b.frmovrun = 1;
+	dwc_modify_reg32(&regs->hcintmsk, hcintmsk.d32, 0);
+
+	return 1;
+}
+
+/**
+ * Handles a host channel data toggle error interrupt. This handler may be
+ * called in either DMA mode or Slave mode.
+ */
+static int handle_hc_datatglerr_intr(struct dwc_hcd *hcd, struct dwc_hc *hc,
+			struct dwc_hc_regs *regs, struct dwc_qtd *qtd)
+{
+	union hcintmsk_data hcintmsk = {.d32 = 0};
+
+	if (hc->ep_is_in)
+		qtd->error_count = 0;
+	else
+		printk(KERN_ERR "Data Toggle Error on OUT transfer, channel "
+				"%d\n", hc->hc_num);
+
+	/* disable datatglerr */
+	hcintmsk.b.datatglerr = 1;
+	dwc_modify_reg32(&regs->hcintmsk, hcintmsk.d32, 0);
+
+	return 1;
+}
+
+/**
+ * Handles a host Channel Halted interrupt in DMA mode. This handler
+ * determines the reason the channel halted and proceeds accordingly.
+ */
+static void handle_hc_chhltd_intr_dma(struct dwc_hcd *hcd, struct dwc_hc *hc,
+		struct dwc_hc_regs *regs, struct dwc_qtd *qtd, int *must_free)
+{
+	union hcint_data hcint;
+	union hcintmsk_data hcintmsk;
+
+	if (hc->halt_status == DWC_OTG_HC_XFER_URB_DEQUEUE ||
+			hc->halt_status == DWC_OTG_HC_XFER_AHB_ERR) {
+		/*
+		 * Just release the channel. A dequeue can happen on a
+		 * transfer timeout. In the case of an AHB Error, the channel
+		 * was forced to halt because there's no way to gracefully
+		 * recover.
+		 */
+		release_channel(hcd, hc, qtd, hc->halt_status, must_free);
+		return;
+	}
+
+	/* Read the HCINTn register to determine the cause for the halt. */
+	hcint.d32 = dwc_read_reg32(&regs->hcint);
+	hcintmsk.d32 = dwc_read_reg32(&regs->hcintmsk);
+	if (hcint.b.xfercomp) {
+		/*
+		 * This is here because of a possible hardware bug.  Spec
+		 * says that on SPLIT-ISOC OUT transfers in DMA mode that a HALT
+		 * interrupt w/ACK bit set should occur, but I only see the
+		 * XFERCOMP bit, even with it masked out.  This is a workaround
+		 * for that behavior.  Should fix this when hardware is fixed.
+		 */
+		if (hc->ep_type == DWC_OTG_EP_TYPE_ISOC && !hc->ep_is_in)
+			handle_hc_ack_intr(hcd, hc, regs, qtd, must_free);
+
+		handle_hc_xfercomp_intr(hcd, hc, regs, qtd, must_free);
+	} else if (hcint.b.stall) {
+		handle_hc_stall_intr(hcd, hc, regs, qtd, must_free);
+	} else if (hcint.b.xacterr) {
+		/*
+		 * Must handle xacterr before nak or ack. Could get a xacterr
+		 * at the same time as either of these on a BULK/CONTROL OUT
+		 * that started with a PING. The xacterr takes precedence.
+		 */
+		handle_hc_xacterr_intr(hcd, hc, regs, qtd, must_free);
+	} else if (hcint.b.nyet) {
+		/*
+		 * Must handle nyet before nak or ack. Could get a nyet at the
+		 * same time as either of those on a BULK/CONTROL OUT that
+		 * started with a PING. The nyet takes precedence.
+		 */
+		handle_hc_nyet_intr(hcd, hc, regs, qtd, must_free);
+	} else if (hcint.b.bblerr) {
+		handle_hc_babble_intr(hcd, hc, regs, qtd, must_free);
+	} else if (hcint.b.frmovrun) {
+		handle_hc_frmovrun_intr(hcd, hc, regs, qtd, must_free);
+	} else if (hcint.b.datatglerr) {
+		handle_hc_datatglerr_intr(hcd, hc, regs, qtd);
+		hc->qh->data_toggle = 0;
+		halt_channel(hcd, hc, qtd, hc->halt_status, must_free);
+	} else if (hcint.b.nak && !hcintmsk.b.nak) {
+		/*
+		 * If nak is not masked, it's because a non-split IN transfer
+		 * is in an error state. In that case, the nak is handled by
+		 * the nak interrupt handler, not here. Handle nak here for
+		 * BULK/CONTROL OUT transfers, which halt on a NAK to allow
+		 * rewinding the buffer pointer.
+		 */
+		handle_hc_nak_intr(hcd, hc, regs, qtd, must_free);
+	} else if (hcint.b.ack && !hcintmsk.b.ack) {
+		/*
+		 * If ack is not masked, it's because a non-split IN transfer
+		 * is in an error state. In that case, the ack is handled by
+		 * the ack interrupt handler, not here. Handle ack here for
+		 * split transfers. Start splits halt on ACK.
+		 */
+		handle_hc_ack_intr(hcd, hc, regs, qtd, must_free);
+	} else {
+		if (hc->ep_type == DWC_OTG_EP_TYPE_INTR ||
+				hc->ep_type == DWC_OTG_EP_TYPE_ISOC) {
+			/*
+			 * A periodic transfer halted with no other channel
+			 * interrupts set. Assume it was halted by the core
+			 * because it could not be completed in its scheduled
+			 * (micro)frame.
+			 */
+			halt_channel(hcd, hc, qtd,
+				DWC_OTG_HC_XFER_PERIODIC_INCOMPLETE,
+				must_free);
+		} else {
+			printk(KERN_ERR "%s: Channel %d, DMA Mode -- ChHltd "
+				"set, but reason for halting is unknown, "
+				"hcint 0x%08x, intsts 0x%08x\n",
+				__func__, hc->hc_num, hcint.d32,
+				dwc_read_reg32(gintsts_reg(hcd)));
+		}
+	}
+}
+
+/**
+ * Handles a host channel Channel Halted interrupt.
+ *
+ * In slave mode, this handler is called only when the driver specifically
+ * requests a halt. This occurs during handling other host channel interrupts
+ * (e.g. nak, xacterr, stall, nyet, etc.).
+ *
+ * In DMA mode, this is the interrupt that occurs when the core has finished
+ * processing a transfer on a channel. Other host channel interrupts (except
+ * ahberr) are disabled in DMA mode.
+ */
+static int handle_hc_chhltd_intr(struct dwc_hcd *hcd, struct dwc_hc *hc,
+		struct dwc_hc_regs *regs, struct dwc_qtd *qtd, int *must_free)
+{
+	if (hcd->core_if->dma_enable)
+		handle_hc_chhltd_intr_dma(hcd, hc, regs, qtd, must_free);
+	else
+		release_channel(hcd, hc, qtd, hc->halt_status, must_free);
+
+	return 1;
+}
+
+/* Handles interrupt for a specific Host Channel */
+static int dwc_otg_hcd_handle_hc_n_intr(struct dwc_hcd *hcd, u32 num)
+{
+	int must_free = 0;
+	int retval = 0;
+	union hcint_data hcint;
+	union hcintmsk_data hcintmsk;
+	struct dwc_hc *hc;
+	struct dwc_hc_regs *hc_regs;
+	struct dwc_qtd *qtd;
+
+	hc = hcd->hc_ptr_array[num];
+	hc_regs = hcd->core_if->host_if->hc_regs[num];
+	qtd = list_entry(hc->qh->qtd_list.next, struct dwc_qtd, qtd_list_entry);
+
+	hcint.d32 = dwc_read_reg32(&hc_regs->hcint);
+	hcintmsk.d32 = dwc_read_reg32(&hc_regs->hcintmsk);
+
+	hcint.d32 = hcint.d32 & hcintmsk.d32;
+	if (!hcd->core_if->dma_enable && hcint.b.chhltd && hcint.d32 != 0x2)
+		hcint.b.chhltd = 0;
+
+	if (hcint.b.xfercomp) {
+		retval |= handle_hc_xfercomp_intr(hcd, hc, hc_regs,
+			qtd, &must_free);
+		/*
+		 * If NYET occurred at same time as Xfer Complete, the NYET is
+		 * handled by the Xfer Complete interrupt handler. Don't want
+		 * to call the NYET interrupt handler in this case.
+		 */
+		hcint.b.nyet = 0;
+	}
+
+	if (hcint.b.chhltd)
+		retval |= handle_hc_chhltd_intr(hcd, hc, hc_regs,
+			qtd, &must_free);
+	if (hcint.b.ahberr)
+		retval |= handle_hc_ahberr_intr(hcd, hc, hc_regs, qtd);
+	if (hcint.b.stall)
+		retval |= handle_hc_stall_intr(hcd, hc, hc_regs,
+			qtd, &must_free);
+	if (hcint.b.nak)
+		retval |= handle_hc_nak_intr(hcd, hc, hc_regs,
+			qtd, &must_free);
+	if (hcint.b.ack)
+		retval |= handle_hc_ack_intr(hcd, hc, hc_regs,
+			qtd, &must_free);
+	if (hcint.b.nyet)
+		retval |= handle_hc_nyet_intr(hcd, hc, hc_regs,
+			qtd, &must_free);
+	if (hcint.b.xacterr)
+		retval |= handle_hc_xacterr_intr(hcd, hc, hc_regs,
+			qtd, &must_free);
+	if (hcint.b.bblerr)
+		retval |= handle_hc_babble_intr(hcd, hc, hc_regs,
+			qtd, &must_free);
+	if (hcint.b.frmovrun)
+		retval |= handle_hc_frmovrun_intr(hcd, hc, hc_regs,
+			qtd, &must_free);
+	if (hcint.b.datatglerr)
+		retval |= handle_hc_datatglerr_intr(hcd, hc, hc_regs, qtd);
+
+	if (must_free)
+		/* Free the qtd here now that we are done using it. */
+		dwc_otg_hcd_qtd_free(qtd);
+	return retval;
+}
+
+/**
+ * This function returns the Host All Channel Interrupt register
+ */
+static inline u32 dwc_otg_read_host_all_channels_intr(struct core_if
+						*core_if)
+{
+	return dwc_read_reg32(&core_if->host_if->host_global_regs->haint);
+}
+
+/**
+ * This interrupt indicates that one or more host channels has a pending
+ * interrupt. There are multiple conditions that can cause each host channel
+ * interrupt. This function determines which conditions have occurred for each
+ * host channel interrupt and handles them appropriately.
+ */
+static int dwc_otg_hcd_handle_hc_intr(struct dwc_hcd *hcd)
+{
+	u32 i;
+	int retval = 0;
+	union haint_data haint;
+
+	/*
+	 * Clear appropriate bits in HCINTn to clear the interrupt bit in
+	 *  GINTSTS
+	 */
+	haint.d32 = dwc_otg_read_host_all_channels_intr(hcd->core_if);
+	for (i = 0; i < hcd->core_if->core_params->host_channels; i++)
+		if (haint.b2.chint & (1 << i))
+			retval |= dwc_otg_hcd_handle_hc_n_intr(hcd, i);
+
+	return retval;
+}
+
+/* This function handles interrupts for the HCD.*/
+int dwc_otg_hcd_handle_intr(struct dwc_hcd *hcd)
+{
+	int ret = 0;
+	struct core_if *core_if = hcd->core_if;
+	union gintsts_data gintsts;
+
+	/* Check if HOST Mode */
+	if (dwc_otg_is_host_mode(core_if)) {
+		spin_lock(&hcd->lock);
+		gintsts.d32 = dwc_otg_read_core_intr(core_if);
+		if (!gintsts.d32) {
+			spin_unlock(&hcd->lock);
+			return IRQ_NONE;
+		}
+
+		if (gintsts.b.sofintr)
+			ret |= dwc_otg_hcd_handle_sof_intr(hcd);
+		if (gintsts.b.rxstsqlvl)
+			ret |= dwc_otg_hcd_handle_rx_status_q_level_intr(hcd);
+		if (gintsts.b.nptxfempty)
+			ret |= dwc_otg_hcd_handle_np_tx_fifo_empty_intr(hcd);
+		if (gintsts.b.portintr)
+			ret |= dwc_otg_hcd_handle_port_intr(hcd);
+		if (gintsts.b.hcintr)
+			ret |= dwc_otg_hcd_handle_hc_intr(hcd);
+		if (gintsts.b.ptxfempty)
+			ret |= dwc_otg_hcd_handle_perio_tx_fifo_empty_intr(hcd);
+
+		spin_unlock(&hcd->lock);
+	}
+	return ret;
+}
diff --git a/drivers/usb/dwc_otg/dwc_otg_hcd_queue.c b/drivers/usb/dwc_otg/dwc_otg_hcd_queue.c
new file mode 100644
index 0000000..737a1f6
--- /dev/null
+++ b/drivers/usb/dwc_otg/dwc_otg_hcd_queue.c
@@ -0,0 +1,708 @@
+/*
+ * DesignWare HS OTG controller driver
+ *
+ * Author: Mark Miesfeld <mmiesfeld@apm.com>
+ *
+ * Based on versions provided by APM and Synopsis which are:
+ *	Copyright (C) 2009-2010 AppliedMicro(www.apm.com)
+ * Modified by Stefan Roese <sr@denx.de>, DENX Software Engineering
+ * Modified by Chuck Meade <chuck@theptrgroup.com>
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/*
+ * This file contains the functions to manage Queue Heads and Queue
+ * Transfer Descriptors.
+ */
+
+#include "dwc_otg_hcd.h"
+
+static inline int is_fs_ls(enum usb_device_speed speed)
+{
+	return speed == USB_SPEED_FULL || speed == USB_SPEED_LOW;
+}
+
+/* Allocates memory for a QH structure. */
+static inline struct dwc_qh *dwc_otg_hcd_qh_alloc(void)
+{
+	return kmalloc(sizeof(struct dwc_qh), GFP_ATOMIC);
+}
+
+/**
+ * Initializes a QH structure to initialize the QH.
+ */
+#define SCHEDULE_SLOP 10
+static void dwc_otg_hcd_qh_init(struct dwc_hcd *hcd, struct dwc_qh *qh,
+	struct urb *urb)
+{
+	memset(qh, 0, sizeof(struct dwc_qh));
+
+	/* Initialize QH */
+	switch (usb_pipetype(urb->pipe)) {
+	case PIPE_CONTROL:
+		qh->ep_type = USB_ENDPOINT_XFER_CONTROL;
+		break;
+	case PIPE_BULK:
+		qh->ep_type = USB_ENDPOINT_XFER_BULK;
+		break;
+	case PIPE_ISOCHRONOUS:
+		qh->ep_type = USB_ENDPOINT_XFER_ISOC;
+		break;
+	case PIPE_INTERRUPT:
+		qh->ep_type = USB_ENDPOINT_XFER_INT;
+		break;
+	}
+
+	qh->ep_is_in = usb_pipein(urb->pipe) ? 1 : 0;
+	qh->data_toggle = DWC_OTG_HC_PID_DATA0;
+	qh->maxp = usb_maxpacket(urb->dev, urb->pipe, !(usb_pipein(urb->pipe)));
+
+	INIT_LIST_HEAD(&qh->qtd_list);
+	INIT_LIST_HEAD(&qh->qh_list_entry);
+
+	qh->channel = NULL;
+	qh->speed = urb->dev->speed;
+
+	/*
+	 * FS/LS Enpoint on HS Hub NOT virtual root hub
+	 */
+	qh->do_split = 0;
+	if (is_fs_ls(urb->dev->speed) && urb->dev->tt && urb->dev->tt->hub &&
+			urb->dev->tt->hub->devnum != 1)
+		qh->do_split = 1;
+
+	if (qh->ep_type == USB_ENDPOINT_XFER_INT ||
+	    qh->ep_type == USB_ENDPOINT_XFER_ISOC) {
+		/* Compute scheduling parameters once and save them. */
+		union hprt0_data hprt;
+		int bytecount = dwc_hb_mult(qh->maxp) *
+			dwc_max_packet(qh->maxp);
+
+		qh->usecs = NS_TO_US(usb_calc_bus_time(urb->dev->speed,
+				usb_pipein(urb->pipe),
+				(qh->ep_type == USB_ENDPOINT_XFER_ISOC),
+				bytecount));
+
+		/* Start in a slightly future (micro)frame. */
+		qh->sched_frame = dwc_frame_num_inc(hcd->frame_number,
+							SCHEDULE_SLOP);
+		qh->interval = urb->interval;
+
+		hprt.d32 = dwc_read_reg32(hcd->core_if->host_if->hprt0);
+		if (hprt.b.prtspd == DWC_HPRT0_PRTSPD_HIGH_SPEED &&
+		    is_fs_ls(urb->dev->speed)) {
+			qh->interval *= 8;
+			qh->sched_frame |= 0x7;
+			qh->start_split_frame = qh->sched_frame;
+		}
+	}
+}
+
+/**
+ * This function allocates and initializes a QH.
+ */
+static struct dwc_qh *dwc_otg_hcd_qh_create(struct dwc_hcd *hcd,
+		struct urb *urb)
+{
+	struct dwc_qh *qh;
+
+	/* Allocate memory */
+	qh = dwc_otg_hcd_qh_alloc();
+	if (qh == NULL)
+		return NULL;
+
+	dwc_otg_hcd_qh_init(hcd, qh, urb);
+	return qh;
+}
+
+/**
+ * Free each QTD in the QH's QTD-list then free the QH.  QH should already be
+ * removed from a list.  QTD list should already be empty if called from URB
+ * Dequeue.
+ */
+void dwc_otg_hcd_qh_free(struct dwc_qh *qh)
+{
+	struct dwc_qtd *qtd;
+	struct list_head *pos, *temp;
+	/* Free each QTD in the QTD list */
+	list_for_each_safe(pos, temp, &qh->qtd_list) {
+		list_del(pos);
+		qtd = dwc_list_to_qtd(pos);
+		dwc_otg_hcd_qtd_free(qtd);
+	}
+	kfree(qh);
+}
+
+/**
+ * Microframe scheduler
+ * track the total use in hcd->frame_usecs
+ * keep each qh use in qh->frame_usecs
+ * when surrendering the qh then donate the time back
+ */
+static const u16 max_uframe_usecs[] = {100, 100, 100, 100, 100, 100, 30, 0};
+
+/*
+ * called from dwc_otg_hcd.c:dwc_otg_hcd_init
+ */
+int init_hcd_usecs(struct dwc_hcd *hcd)
+{
+	int i;
+
+	for (i = 0; i < 8; i++)
+		hcd->frame_usecs[i] = max_uframe_usecs[i];
+
+	return 0;
+}
+
+static int find_single_uframe(struct dwc_hcd *hcd, struct dwc_qh *qh)
+{
+	int i;
+	u16 utime;
+	int t_left;
+	int ret;
+	int done;
+
+	ret = -1;
+	utime = qh->usecs;
+	t_left = utime;
+	i = 0;
+	done = 0;
+	while (done == 0) {
+		/* At the start hcd->frame_usecs[i] = max_uframe_usecs[i]; */
+		if (utime <= hcd->frame_usecs[i]) {
+			hcd->frame_usecs[i] -= utime;
+			qh->frame_usecs[i] += utime;
+			t_left -= utime;
+			ret = i;
+			done = 1;
+			return ret;
+		} else {
+			i++;
+			if (i == 8) {
+				done = 1;
+				ret = -1;
+			}
+		}
+	}
+	return ret;
+}
+
+/*
+ * use this for FS apps that can span multiple uframes
+ */
+static int find_multi_uframe(struct dwc_hcd *hcd, struct dwc_qh *qh)
+{
+	int i;
+	int j;
+	u16  utime;
+	int t_left;
+	int ret;
+	int done;
+	u16 xtime;
+
+	ret = -1;
+	utime = qh->usecs;
+	t_left = utime;
+	i = 0;
+	done = 0;
+loop:
+	while (done == 0) {
+		if (hcd->frame_usecs[i] <= 0) {
+			i++;
+			if (i == 8) {
+				done = 1;
+				ret = -1;
+			}
+			goto loop;
+		}
+
+		/*
+		 * We need n consequtive slots so use j as a start slot.
+		 * j plus j+1 must be enough time (for now)
+		 */
+		xtime = hcd->frame_usecs[i];
+		for (j = i + 1; j < 8; j++) {
+			/*
+			 * if we add this frame remaining time to xtime we may
+			 * be OK, if not we need to test j for a complete frame.
+			 */
+			if ((xtime+hcd->frame_usecs[j]) < utime) {
+				if (hcd->frame_usecs[j] < max_uframe_usecs[j]) {
+					j = 8;
+					ret = -1;
+					continue;
+				}
+			}
+			if (xtime >= utime) {
+				ret = i;
+				j = 8;  /* stop loop with a good value ret */
+				continue;
+			}
+			/* add the frame time to x time */
+			xtime += hcd->frame_usecs[j];
+			/* we must have a fully available next frame or break */
+			if ((xtime < utime) &&
+				(hcd->frame_usecs[j] == max_uframe_usecs[j])) {
+				ret = -1;
+				j = 8;  /* stop loop with a bad value ret */
+				continue;
+			}
+		}
+		if (ret >= 0) {
+			t_left = utime;
+			for (j = i; (t_left > 0) && (j < 8); j++) {
+				t_left -= hcd->frame_usecs[j];
+				if (t_left <= 0) {
+					qh->frame_usecs[j] +=
+						hcd->frame_usecs[j] + t_left;
+					hcd->frame_usecs[j] = -t_left;
+					ret = i;
+					done = 1;
+				} else {
+					qh->frame_usecs[j] +=
+						hcd->frame_usecs[j];
+					hcd->frame_usecs[j] = 0;
+				}
+			}
+		} else {
+			i++;
+			if (i == 8) {
+				done = 1;
+				ret = -1;
+			}
+		}
+	}
+	return ret;
+}
+
+static int find_uframe(struct dwc_hcd *hcd, struct dwc_qh *qh)
+{
+	int ret = -1;
+
+	if (qh->speed == USB_SPEED_HIGH)
+		/* if this is a hs transaction we need a full frame */
+		ret = find_single_uframe(hcd, qh);
+	else
+		/* FS transaction may need a sequence of frames */
+		ret = find_multi_uframe(hcd, qh);
+
+	return ret;
+}
+
+/**
+ * Checks that the max transfer size allowed in a host channel is large enough
+ * to handle the maximum data transfer in a single (micro)frame for a periodic
+ * transfer.
+ */
+static int check_max_xfer_size(struct dwc_hcd *hcd, struct dwc_qh *qh)
+{
+	int status = 0;
+	u32 max_xfer_size;
+	u32 max_channel_xfer_size;
+
+	max_xfer_size = dwc_max_packet(qh->maxp) * dwc_hb_mult(qh->maxp);
+	max_channel_xfer_size = hcd->core_if->core_params->max_transfer_size;
+
+	if (max_xfer_size > max_channel_xfer_size) {
+		printk(KERN_NOTICE "%s: Periodic xfer length %d > max xfer "
+			"length for channel %d\n", __func__, max_xfer_size,
+			max_channel_xfer_size);
+		status = -ENOSPC;
+	}
+
+	return status;
+}
+
+/**
+ * Schedules an interrupt or isochronous transfer in the periodic schedule.
+ */
+static int schedule_periodic(struct dwc_hcd *hcd, struct dwc_qh *qh)
+{
+	int status;
+	struct usb_bus *bus = hcd_to_bus(dwc_otg_hcd_to_hcd(hcd));
+	int frame;
+
+	status = find_uframe(hcd, qh);
+	frame = -1;
+	if (status == 0) {
+		frame = 7;
+	} else {
+		if (status > 0)
+			frame = status-1;
+	}
+	/* Set the new frame up */
+	if (frame > -1) {
+		qh->sched_frame &= ~0x7;
+		qh->sched_frame |= (frame & 7);
+	}
+	if (status != -1)
+		status = 0;
+	if (status) {
+		printk(KERN_NOTICE "%s: Insufficient periodic bandwidth for "
+			"periodic transfer.\n", __func__);
+		return status;
+	}
+	status = check_max_xfer_size(hcd, qh);
+	if (status) {
+		printk(KERN_NOTICE "%s: Channel max transfer size too small "
+			"for periodic transfer.\n", __func__);
+		return status;
+	}
+	/* Always start in the inactive schedule. */
+	list_add_tail(&qh->qh_list_entry, &hcd->periodic_sched_inactive);
+
+	/* Update claimed usecs per (micro)frame. */
+	hcd->periodic_usecs += qh->usecs;
+
+	/*
+	 * Update average periodic bandwidth claimed and # periodic reqs for
+	 * usbfs.
+	 */
+	bus->bandwidth_allocated += qh->usecs / qh->interval;
+
+	if (qh->ep_type == USB_ENDPOINT_XFER_INT)
+		bus->bandwidth_int_reqs++;
+	else
+		bus->bandwidth_isoc_reqs++;
+
+	return status;
+}
+
+/**
+ * This function adds a QH to either the non periodic or periodic schedule if
+ * it is not already in the schedule. If the QH is already in the schedule, no
+ * action is taken.
+ */
+static int dwc_otg_hcd_qh_add(struct dwc_hcd *hcd, struct dwc_qh *qh)
+{
+	int status = 0;
+
+	/* QH may already be in a schedule. */
+	if (!list_empty(&qh->qh_list_entry))
+		goto done;
+	/*
+	 * Add the new QH to the appropriate schedule. For non-periodic, always
+	 * start in the inactive schedule.
+	 */
+	if (dwc_qh_is_non_per(qh))
+		list_add_tail(&qh->qh_list_entry,
+			&hcd->non_periodic_sched_inactive);
+	else
+		status = schedule_periodic(hcd, qh);
+
+done:
+	return status;
+}
+
+/**
+ * This function adds a QH to the non periodic deferred schedule.
+ *
+ * @return 0 if successful, negative error code otherwise.
+ */
+int dwc_otg_hcd_qh_add_deferred(struct dwc_hcd *hcd, struct dwc_qh *qh)
+{
+	if (!list_empty(&qh->qh_list_entry))
+		/* QH already in a schedule. */
+		goto done;
+
+	/* Add the new QH to the non periodic deferred schedule */
+	if (dwc_qh_is_non_per(qh))
+		list_add_tail(&qh->qh_list_entry,
+			&hcd->non_periodic_sched_deferred);
+done:
+	return 0;
+}
+
+
+/**
+ * Removes an interrupt or isochronous transfer from the periodic schedule.
+ */
+static void deschedule_periodic(struct dwc_hcd *hcd, struct dwc_qh *qh)
+{
+	struct usb_bus *bus = hcd_to_bus(dwc_otg_hcd_to_hcd(hcd));
+	int i;
+
+	list_del_init(&qh->qh_list_entry);
+	/* Update claimed usecs per (micro)frame. */
+	hcd->periodic_usecs -= qh->usecs;
+	for (i = 0; i < 8; i++) {
+		hcd->frame_usecs[i] += qh->frame_usecs[i];
+		qh->frame_usecs[i] = 0;
+	}
+	/*
+	 * Update average periodic bandwidth claimed and # periodic reqs for
+	 * usbfs.
+	 */
+	bus->bandwidth_allocated -= qh->usecs / qh->interval;
+
+	if (qh->ep_type == USB_ENDPOINT_XFER_INT)
+		bus->bandwidth_int_reqs--;
+	else
+		bus->bandwidth_isoc_reqs--;
+}
+
+/**
+ * Removes a QH from either the non-periodic or periodic schedule.  Memory is
+ * not freed.
+ */
+void dwc_otg_hcd_qh_remove(struct dwc_hcd *hcd, struct dwc_qh *qh)
+{
+	/* Do nothing if QH is not in a	schedule */
+	if (list_empty(&qh->qh_list_entry))
+		return;
+
+	if (dwc_qh_is_non_per(qh)) {
+		if (hcd->non_periodic_qh_ptr == &qh->qh_list_entry)
+			hcd->non_periodic_qh_ptr =
+				hcd->non_periodic_qh_ptr->next;
+		list_del_init(&qh->qh_list_entry);
+	} else {
+		deschedule_periodic(hcd, qh);
+	}
+}
+
+/**
+ * Defers a QH. For non-periodic QHs, removes the QH from the active
+ * non-periodic schedule. The QH is added to the deferred non-periodic
+ * schedule if any QTDs are still attached to the QH.
+ */
+int dwc_otg_hcd_qh_deferr(struct dwc_hcd *hcd, struct dwc_qh *qh, int delay)
+{
+	int deact = 1;
+	if (dwc_qh_is_non_per(qh)) {
+		qh->sched_frame =
+			dwc_frame_num_inc(hcd->frame_number,
+				delay);
+		qh->channel = NULL;
+		qh->qtd_in_process = NULL;
+		deact = 0;
+		dwc_otg_hcd_qh_remove(hcd, qh);
+		if (!list_empty(&qh->qtd_list))
+			/* Add back to deferred non-periodic schedule. */
+			dwc_otg_hcd_qh_add_deferred(hcd, qh);
+	}
+	return deact;
+}
+
+/**
+ *  Schedule the next continuing periodic split transfer
+ */
+static void sched_next_per_split_xfr(struct dwc_qh *qh, u16 fr_num,
+					int sched_split)
+{
+	if (sched_split) {
+		qh->sched_frame = fr_num;
+		if (dwc_frame_num_le(fr_num,
+				dwc_frame_num_inc(qh->start_split_frame, 1))) {
+			/*
+			 * Allow one frame to elapse after start split
+			 * microframe before scheduling complete split, but DONT
+			 * if we are doing the next start split in the
+			 * same frame for an ISOC out.
+			 */
+			if (qh->ep_type != USB_ENDPOINT_XFER_ISOC ||
+					qh->ep_is_in)
+				qh->sched_frame = dwc_frame_num_inc(
+					qh->sched_frame, 1);
+		}
+	} else {
+		qh->sched_frame = dwc_frame_num_inc(qh->start_split_frame,
+						qh->interval);
+
+		if (dwc_frame_num_le(qh->sched_frame, fr_num))
+			qh->sched_frame = fr_num;
+		qh->sched_frame |= 0x7;
+		qh->start_split_frame = qh->sched_frame;
+	}
+}
+
+/**
+ * Deactivates a periodic QH.  The QH is removed from the periodic queued
+ * schedule. If there are any QTDs still attached to the QH, the QH is added to
+ * either the periodic inactive schedule or the periodic ready schedule and its
+ * next scheduled frame is calculated. The QH is placed in the ready schedule if
+ * the scheduled frame has been reached already. Otherwise it's placed in the
+ * inactive schedule. If there are no QTDs attached to the QH, the QH is
+ * completely removed from the periodic schedule.
+ */
+static void deactivate_periodic_qh(struct dwc_hcd *hcd, struct dwc_qh *qh,
+			int sched_next_split)
+{
+	/* unsigned long flags; */
+	u16 fr_num = dwc_otg_hcd_get_frame_number(dwc_otg_hcd_to_hcd(hcd));
+
+	if (qh->do_split) {
+		sched_next_per_split_xfr(qh, fr_num, sched_next_split);
+	} else {
+		qh->sched_frame = dwc_frame_num_inc(qh->sched_frame,
+						qh->interval);
+		if (dwc_frame_num_le(qh->sched_frame, fr_num))
+			qh->sched_frame = fr_num;
+	}
+
+	if (list_empty(&qh->qtd_list)) {
+		dwc_otg_hcd_qh_remove(hcd, qh);
+	} else {
+		/*
+		 * Remove from periodic_sched_queued and move to appropriate
+		 * queue.
+		 */
+		if (qh->sched_frame == fr_num)
+			list_move(&qh->qh_list_entry,
+				&hcd->periodic_sched_ready);
+		else
+			list_move(&qh->qh_list_entry,
+				&hcd->periodic_sched_inactive);
+	}
+}
+
+/**
+ * Deactivates a non-periodic QH.  Removes the QH from the active non-periodic
+ * schedule. The QH is added to the inactive non-periodic schedule if any QTDs
+ * are still attached to the QH.
+ */
+static void deactivate_non_periodic_qh(struct dwc_hcd *hcd, struct dwc_qh *qh)
+{
+	dwc_otg_hcd_qh_remove(hcd, qh);
+	if (!list_empty(&qh->qtd_list))
+		dwc_otg_hcd_qh_add(hcd, qh);
+}
+
+/**
+ * Deactivates a QH.  Determines if the QH is periodic or non-periodic and takes
+ * the appropriate action.
+ */
+void dwc_otg_hcd_qh_deactivate(struct dwc_hcd *hcd, struct dwc_qh *qh,
+		int sched_next_periodic_split)
+{
+	if (dwc_qh_is_non_per(qh))
+		deactivate_non_periodic_qh(hcd, qh);
+	else
+		deactivate_periodic_qh(hcd, qh, sched_next_periodic_split);
+}
+
+/**
+ * Initializes a QTD structure.
+ */
+static void dwc_otg_hcd_qtd_init(struct dwc_qtd *qtd, struct urb *urb)
+{
+	memset(qtd, 0, sizeof(struct dwc_qtd));
+	qtd->urb = urb;
+
+	if (usb_pipecontrol(urb->pipe)) {
+		/*
+		 * The only time the QTD data toggle is used is on the data
+		 * phase of control transfers. This phase always starts with
+		 * DATA1.
+		 */
+		qtd->data_toggle = DWC_OTG_HC_PID_DATA1;
+		qtd->control_phase = DWC_OTG_CONTROL_SETUP;
+	}
+
+	/* start split */
+	qtd->complete_split = 0;
+	qtd->isoc_split_pos = DWC_HCSPLIT_XACTPOS_ALL;
+	qtd->isoc_split_offset = 0;
+
+	/* Store the qtd ptr in the urb to reference what QTD. */
+	urb->hcpriv = qtd;
+
+	INIT_LIST_HEAD(&qtd->qtd_list_entry);
+	return;
+}
+
+/* Allocates memory for a QTD structure. */
+static inline struct dwc_qtd *dwc_otg_hcd_qtd_alloc(gfp_t _mem_flags)
+{
+	return kmalloc(sizeof(struct dwc_qtd), _mem_flags);
+}
+
+/**
+ * This function allocates and initializes a QTD.
+ */
+struct dwc_qtd *dwc_otg_hcd_qtd_create(struct urb *urb,  gfp_t _mem_flags)
+{
+	struct dwc_qtd *qtd = dwc_otg_hcd_qtd_alloc(_mem_flags);
+
+	if (!qtd)
+		return NULL;
+
+	dwc_otg_hcd_qtd_init(qtd, urb);
+	return qtd;
+}
+
+/**
+ * This function adds a QTD to the QTD-list of a QH.  It will find the correct
+ * QH to place the QTD into.  If it does not find a QH, then it will create a
+ * new QH. If the QH to which the QTD is added is not currently scheduled, it
+ * is placed into the proper schedule based on its EP type.
+ *
+ */
+int dwc_otg_hcd_qtd_add(struct dwc_qtd *qtd,  struct dwc_hcd *hcd)
+{
+	struct usb_host_endpoint *ep;
+	struct dwc_qh *qh;
+	int retval = 0;
+	struct urb *urb = qtd->urb;
+
+	/*
+	 * Get the QH which holds the QTD-list to insert to. Create QH if it
+	 * doesn't exist.
+	 */
+	ep = dwc_urb_to_endpoint(urb);
+
+	qh = (struct dwc_qh *) ep->hcpriv;
+	if (!qh) {
+		qh = dwc_otg_hcd_qh_create(hcd, urb);
+		if (!qh) {
+			retval = -1;
+			goto done;
+		}
+		ep->hcpriv = qh;
+	}
+	qtd->qtd_qh_ptr = qh;
+	retval = dwc_otg_hcd_qh_add(hcd, qh);
+	if (!retval)
+		list_add_tail(&qtd->qtd_list_entry, &qh->qtd_list);
+
+done:
+	return retval;
+}
diff --git a/drivers/usb/dwc_otg/dwc_otg_regs.h b/drivers/usb/dwc_otg/dwc_otg_regs.h
new file mode 100644
index 0000000..ba2b1d8
--- /dev/null
+++ b/drivers/usb/dwc_otg/dwc_otg_regs.h
@@ -0,0 +1,3282 @@
+/*
+ * DesignWare HS OTG controller driver
+ *
+ * Author: Mark Miesfeld <mmiesfeld@apm.com>
+ *
+ * Based on versions provided by APM and Synopsis which are:
+ *	Copyright (C) 2009-2010 AppliedMicro(www.apm.com)
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __DWC_OTG_REGS_H__
+#define __DWC_OTG_REGS_H__
+
+#include <linux/types.h>
+
+/*
+ * This file contains the data structures for accessing the DWC_otg core
+ * registers.
+ *
+ * The application interfaces with the HS OTG core by reading from and
+ * writing to the Control and Status Register (CSR) space through the
+ * AHB Slave interface. These registers are 32 bits wide, and the
+ * addresses are 32-bit-block aligned.
+ * CSRs are classified as follows:
+ * - Core Global Registers
+ * - Device Mode Registers
+ * - Device Global Registers
+ * - Device Endpoint Specific Registers
+ * - Host Mode Registers
+ * - Host Global Registers
+ * - Host Port CSRs
+ * - Host Channel Specific Registers
+ *
+ * Only the Core Global registers can be accessed in both Device and
+ * Host modes. When the HS OTG core is operating in one mode, either
+ * Device or Host, the application must not access registers from the
+ * other mode. When the core switches from one mode to another, the
+ * registers in the new mode of operation must be reprogrammed as they
+ * would be after a power-on reset.
+ */
+
+/*
+ * DWC_otg Core registers.  The core_global_regs structure defines the
+ * size and relative field offsets for the Core Global registers.
+ */
+struct core_global_regs {
+	/* OTG Control and Status Register.		Offset: 000h */
+	u32 gotgctl;
+	/* OTG Interrupt Register.			Offset: 004h */
+	u32 gotgint;
+	/* Core AHB Configuration Register.		Offset: 008h */
+	u32 gahbcfg;
+
+#define DWC_GLBINTRMASK				0x0001
+#define DWC_DMAENABLE				0x0020
+#define DWC_NPTXEMPTYLVL_EMPTY			0x0080
+#define DWC_NPTXEMPTYLVL_HALFEMPTY		0x0000
+#define DWC_PTXEMPTYLVL_EMPTY			0x0100
+#define DWC_PTXEMPTYLVL_HALFEMPTY		0x0000
+
+	/* Core USB Configuration Register.		Offset: 00Ch */
+	u32 gusbcfg;
+	/* Core Reset Register.				Offset: 010h */
+	u32 grstctl;
+	/* Core Interrupt Register.			Offset: 014h */
+	u32 gintsts;
+	/* Core Interrupt Mask Register.		Offset: 018h */
+	u32 gintmsk;
+	/*
+	 * Receive Status Queue Read Register
+	 * (Read Only)					Offset: 01Ch
+	 */
+	u32 grxstsr;
+	/*
+	 * Receive Status Queue Read & POP Register
+	 * (Read Only)					Offset: 020h
+	 */
+	u32 grxstsp;
+	/* Receive FIFO Size Register.			Offset: 024h */
+	u32 grxfsiz;
+	/* Non Periodic Transmit FIFO Size Register.	Offset: 028h */
+	u32 gnptxfsiz;
+	/*
+	 * Non Periodic Transmit FIFO/Queue Status Register
+	 * (Read Only).					Offset: 02Ch
+	 */
+	u32 gnptxsts;
+	/* I2C Access Register.				Offset: 030h */
+	u32 gi2cctl;
+	/* PHY Vendor Control Register.			Offset: 034h */
+	u32 gpvndctl;
+	/* General Purpose Input/Output Register.	Offset: 038h */
+	u32 ggpio;
+	/* User ID Register.				Offset: 03Ch */
+	u32 guid;
+	/* Synopsys ID Register (Read Only).		Offset: 040h */
+	u32 gsnpsid;
+	/* User HW Config1 Register (Read Only).	Offset: 044h */
+	u32 ghwcfg1;
+	/* User HW Config2 Register (Read Only).	Offset: 048h */
+	u32 ghwcfg2;
+#define DWC_SLAVE_ONLY_ARCH			0
+#define DWC_EXT_DMA_ARCH			1
+#define DWC_INT_DMA_ARCH			2
+
+#define DWC_MODE_HNP_SRP_CAPABLE		0
+#define DWC_MODE_SRP_ONLY_CAPABLE		1
+#define DWC_MODE_NO_HNP_SRP_CAPABLE		2
+#define DWC_MODE_SRP_CAPABLE_DEVICE		3
+#define DWC_MODE_NO_SRP_CAPABLE_DEVICE		4
+#define DWC_MODE_SRP_CAPABLE_HOST		5
+#define DWC_MODE_NO_SRP_CAPABLE_HOST		6
+
+	/* User HW Config3 Register (Read Only).	Offset: 04Ch */
+	u32 ghwcfg3;
+	/* User HW Config4 Register (Read Only).	Offset: 050h */
+	u32 ghwcfg4;
+	/*  Reserved					Offset: 054h-0FFh */
+	u32 reserved[43];
+	/*  Host Periodic Transmit FIFO Size Register.	Offset: 100h */
+	u32 hptxfsiz;
+
+	/*
+	 * Device Periodic Transmit FIFO#n Register, if dedicated fifos are
+	 * disabled.  Otherwise Device Transmit FIFO#n Register.
+	 *
+	 * Offset: 104h + (FIFO_Number-1)*04h, 1 <= FIFO Number <= 15 (1<=n<=15)
+	 */
+	u32 dptxfsiz_dieptxf[15];
+};
+
+
+#if defined(CONFIG_DWC_OTG_REG_LE)
+/*
+ * This union represents the bit fields of the Core OTG Controland Status
+ * Register (GOTGCTL).  Set the bits using the bit fields then write the d32
+ * value to the register.
+ */
+union gotgctl_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned reserved31_21:11;
+		unsigned currmod:1;
+		unsigned bsesvld:1;
+		unsigned asesvld:1;
+		unsigned reserved17:1;
+		unsigned conidsts:1;
+		unsigned reserved1_12:4;
+		unsigned devhnpen:1;
+		unsigned hstsethnpen:1;
+		unsigned hnpreq:1;
+		unsigned hstnegscs:1;
+		unsigned reserved07_02:6;
+		unsigned sesreq:1;
+		unsigned sesreqscs:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields of the Core OTG Interrupt Register
+ * (GOTGINT).  Set/clear the bits using the bit fields then write the d32
+ * value to the register.
+ */
+union gotgint_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		/* Current Mode */
+		unsigned reserved31_20:12;
+		/* Debounce Done */
+		unsigned debdone:1;
+		/* A-Device Timeout Change */
+		unsigned adevtoutchng:1;
+		/* Host Negotiation Detected */
+		unsigned hstnegdet:1;
+		unsigned reserver16_10:7;
+		/* Host Negotiation Success Status Change */
+		unsigned hstnegsucstschng:1;
+		/* Session Request Success Status Change */
+		unsigned sesreqsucstschng:1;
+		unsigned reserved3_7:5;
+		/* Session End Detected */
+		unsigned sesenddet:1;
+		unsigned reserved01_00:2;
+	} b;
+};
+
+/*
+ * This union represents the bit fields of the Core AHB Configuration Register
+ * (GAHBCFG).  Set/clear the bits using the bit fields then write the d32 value
+ * to the register.
+ */
+union gahbcfg_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned reserved9_31:23;
+		unsigned ptxfemplvl:1;
+#define DWC_GAHBCFG_TXFEMPTYLVL_EMPTY		1
+#define DWC_GAHBCFG_TXFEMPTYLVL_HALFEMPTY	0
+
+		unsigned nptxfemplvl_txfemplvl:1;
+		unsigned reserved:1;
+		unsigned dmaenable:1;
+#define DWC_GAHBCFG_DMAENABLE			1
+
+		unsigned hburstlen:4;
+#define DWC_GAHBCFG_INT_DMA_BURST_SINGLE	0
+#define DWC_GAHBCFG_INT_DMA_BURST_INCR		1
+#define DWC_GAHBCFG_INT_DMA_BURST_INCR4		3
+#define DWC_GAHBCFG_INT_DMA_BURST_INCR8		5
+#define DWC_GAHBCFG_INT_DMA_BURST_INCR16	7
+
+		unsigned glblintrmsk:1;
+#define DWC_GAHBCFG_GLBINT_ENABLE		1
+	} b;
+};
+
+/*
+ * This union represents the bit fields of the Core USB Configuration Register
+ * (GUSBCFG).  Set the bits using the bit fields then write the d32 value to the
+ * register.
+ */
+union gusbcfg_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned corrupt_tx_packet:1;
+		unsigned force_device_mode:1;
+		unsigned force_host_mode:1;
+		unsigned reserved23_28:6;
+		unsigned term_sel_dl_pulse:1;
+		unsigned ulpi_int_vbus_indicator:1;
+		unsigned ulpi_ext_vbus_drv:1;
+		unsigned ulpi_clk_sus_m:1;
+		unsigned ulpi_auto_res:1;
+		unsigned ulpi_fsls:1;
+
+		unsigned otgutmifssel:1;
+		unsigned phylpwrclksel:1;
+		unsigned nptxfrwnden:1;
+		unsigned usbtrdtim:4;
+		unsigned hnpcap:1;
+		unsigned srpcap:1;
+		unsigned ddrsel:1;
+		unsigned physel:1;
+		unsigned fsintf:1;
+		unsigned ulpi_utmi_sel:1;
+		unsigned phyif:1;
+		unsigned toutcal:3;
+	} b;
+};
+
+/*
+ * This union represents the bit fields of the Core Reset Register (GRSTCTL).
+ * Set/clear the bits using the bit fields then write the d32 value to the
+ * register.
+ */
+union grstctl_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		/*
+		 *  AHB Master Idle.  Indicates the AHB Master State Machine is
+		 *  in IDLE condition.
+		 */
+		unsigned ahbidle:1;
+
+		/*
+		 * DMA Request Signal.  Indicated DMA request is in probress.
+		   Used for debug purpose.
+		 */
+		unsigned dmareq:1;
+
+		/* Reserved */
+		unsigned reserved29_11:19;
+
+		/*
+		 * TxFIFO Number (TxFNum) (Device and Host).
+		 *
+		 * This is the FIFO number which needs to be flushed,
+		 * using the TxFIFO Flush bit. This field should not
+		 * be changed until the TxFIFO Flush bit is cleared by
+		 * the core.
+		 *   - 0x0:Non Periodic TxFIFO Flush
+		 *   - 0x1 : Periodic TxFIFO #1 Flush in device mode
+		 *     or Periodic TxFIFO in host mode
+		 *   - 0x2 : Periodic TxFIFO #2 Flush in device mode.
+		 *   - ...
+		 *   - 0xF : Periodic TxFIFO #15 Flush in device mode
+		 *   - 0x10: Flush all the Transmit NonPeriodic and
+		 *     Transmit Periodic FIFOs in the core
+		 */
+		unsigned txfnum:5;
+#define DWC_GRSTCTL_TXFNUM_ALL			0x10
+
+		/*
+		 * TxFIFO Flush (TxFFlsh) (Device and Host).
+		 *
+		 * This bit is used to selectively flush a single or all
+		 * transmit FIFOs.  The application must first ensure that the
+		 * core is not in the middle of a transaction.
+		 *
+		 * The application should write into this bit, only after
+		 * making sure that neither the DMA engine is writing into the
+		 * TxFIFO nor the MAC is reading the data out of the FIFO.
+		 *
+		 * The application should wait until the core clears this bit,
+		 * before performing any operations. This bit will takes 8
+		 * clocks (slowest of PHY or AHB clock) to clear.
+		 */
+		unsigned txfflsh:1;
+
+		/*
+		 * RxFIFO Flush (RxFFlsh) (Device and Host)
+		 *
+		 * The application can flush the entire Receive FIFO using this
+		 * bit.
+		 *
+		 * The application must first ensure that the core is not in the
+		 * middle of a transaction.
+		 *
+		 * The application should write into this bit, only after making
+		 * sure that neither the DMA engine is reading from the RxFIFO
+		 * nor the MAC is writing the data in to the FIFO.
+		 *
+		 * The application should wait until the bit is cleared before
+		 * performing any other operations. This bit will takes 8 clocks
+		 * (slowest of PHY or AHB clock) to clear.
+		 */
+		unsigned rxfflsh:1;
+
+		/*
+		 * In Token Sequence Learning Queue Flush
+		 * (INTknQFlsh) (Device Only)
+		 */
+		unsigned intknqflsh:1;
+
+		/*
+		 * Host Frame Counter Reset (Host Only)<br>
+		 *
+		 * The application can reset the (micro)frame number
+		 * counter inside the core, using this bit. When the
+		 * (micro)frame counter is reset, the subsequent SOF
+		 * sent out by the core, will have a (micro)frame
+		 * number of 0.
+		 */
+		unsigned hstfrm:1;
+
+		/*
+		 * Hclk Soft Reset
+		 *
+		 * The application uses this bit to reset the control logic in
+		 * the AHB clock domain. Only AHB clock domain pipelines are
+		 * reset.
+		 */
+		unsigned hsftrst:1;
+
+		/*
+		 * Core Soft Reset (CSftRst) (Device and Host)
+		 *
+		 * The application can flush the control logic in the
+		 * entire core using this bit. This bit resets the
+		 * pipelines in the AHB Clock domain as well as the
+		 * PHY Clock domain.
+		 *
+		 * The state machines are reset to an IDLE state, the
+		 * control bits in the CSRs are cleared, all the
+		 * transmit FIFOs and the receive FIFO are flushed.
+		 *
+		 * The status mask bits that control the generation of
+		 * the interrupt, are cleared, to clear the
+		 * interrupt. The interrupt status bits are not
+		 * cleared, so the application can get the status of
+		 * any events that occurred in the core after it has
+		 * set this bit.
+		 *
+		 * Any transactions on the AHB are terminated as soon
+		 * as possible following the protocol. Any
+		 * transactions on the USB are terminated immediately.
+		 *
+		 * The configuration settings in the CSRs are
+		 * unchanged, so the software doesn't have to
+		 * reprogram these registers (Device
+		 * Configuration/Host Configuration/Core System
+		 * Configuration/Core PHY Configuration).
+		 *
+		 * The application can write to this bit, any time it
+		 * wants to reset the core. This is a self clearing
+		 * bit and the core clears this bit after all the
+		 * necessary logic is reset in the core, which may
+		 * take several clocks, depending on the current state
+		 * of the core.
+		 */
+		unsigned csftrst:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields of the Core Interrupt Mask Register
+ * (GINTMSK).  Set/clear the bits using the bit fields then write the d32 value
+ * to the register.
+ */
+union gintmsk_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned wkupintr:1;
+		unsigned sessreqintr:1;
+		unsigned disconnect:1;
+		unsigned conidstschng:1;
+		unsigned reserved27:1;
+		unsigned ptxfempty:1;
+		unsigned hcintr:1;
+		unsigned portintr:1;
+		unsigned reserved23_22:2;
+		unsigned incomplisoout:1;
+		unsigned incomplisoin:1;
+		unsigned outepintr:1;
+		unsigned inepintr:1;
+		unsigned epmismatch:1;
+		unsigned reserved16:1;
+		unsigned eopframe:1;
+		unsigned isooutdrop:1;
+		unsigned enumdone:1;
+		unsigned usbreset:1;
+		unsigned usbsuspend:1;
+		unsigned erlysuspend:1;
+		unsigned i2cintr:1;
+		unsigned reserved08:1;
+		unsigned goutnakeff:1;
+		unsigned ginnakeff:1;
+		unsigned nptxfempty:1;
+		unsigned rxstsqlvl:1;
+		unsigned sofintr:1;
+		unsigned otgintr:1;
+		unsigned modemismatch:1;
+		unsigned reserved00:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields of the Core Interrupt Register
+ * (GINTSTS).  Set/clear the bits using the bit fields then write the d32 value
+ * to the register.
+ */
+union gintsts_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+#define DWC_SOF_INTR_MASK			0x0008
+	struct {
+#define DWC_HOST_MODE				1
+		unsigned wkupintr:1;
+		unsigned sessreqintr:1;
+		unsigned disconnect:1;
+		unsigned conidstschng:1;
+		unsigned reserved27:1;
+		unsigned ptxfempty:1;
+		unsigned hcintr:1;
+		unsigned portintr:1;
+		unsigned reserved22_23:2;
+		unsigned incomplisoout:1;
+		unsigned incomplisoin:1;
+		unsigned outepintr:1;
+		unsigned inepint:1;
+		unsigned epmismatch:1;
+		unsigned intokenrx:1;
+		unsigned eopframe:1;
+		unsigned isooutdrop:1;
+		unsigned enumdone:1;
+		unsigned usbreset:1;
+		unsigned usbsuspend:1;
+		unsigned erlysuspend:1;
+		unsigned i2cintr:1;
+		unsigned reserved8:1;
+		unsigned goutnakeff:1;
+		unsigned ginnakeff:1;
+		unsigned nptxfempty:1;
+		unsigned rxstsqlvl:1;
+		unsigned sofintr:1;
+		unsigned otgintr:1;
+		unsigned modemismatch:1;
+		unsigned curmode:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device Receive Status Read and
+ * Pop Registers (GRXSTSR, GRXSTSP) Read the register into the d32
+ * element then read out the bits using the bit elements.
+ */
+union device_grxsts_data {			/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned reserved:7;
+		unsigned fn:4;
+		unsigned pktsts:4;
+#define DWC_STS_DATA_UPDT		0x2  /* OUT Data Packet */
+#define DWC_STS_XFER_COMP		0x3  /* OUT Data Transfer Complete */
+#define DWC_DSTS_GOUT_NAK		0x1  /* Global OUT NAK */
+#define DWC_DSTS_SETUP_COMP		0x4  /* Setup Phase Complete */
+#define DWC_DSTS_SETUP_UPDT		0x6  /* SETUP Packet */
+
+		unsigned dpid:2;
+		unsigned bcnt:11;
+		unsigned epnum:4;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Host Receive Status Read and
+ * Pop Registers (GRXSTSR, GRXSTSP) Read the register into the d32
+ * element then read out the bits using the bit elements.
+ */
+union host_grxsts_data {			/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned reserved31_21:11;
+		unsigned pktsts:4;
+#define DWC_GRXSTS_PKTSTS_IN			0x2
+#define DWC_GRXSTS_PKTSTS_IN_XFER_COMP		0x3
+#define DWC_GRXSTS_PKTSTS_DATA_TOGGLE_ERR	0x5
+#define DWC_GRXSTS_PKTSTS_CH_HALTED		0x7
+
+		unsigned dpid:2;
+		unsigned bcnt:11;
+		unsigned chnum:4;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the FIFO Size Registers (HPTXFSIZ,
+ * GNPTXFSIZ, DPTXFSIZn). Read the register into the d32 element then
+ * read out the bits using the bit elements.
+ */
+union fifosize_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned depth:16;
+		unsigned startaddr:16;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Non-Periodic Transmit FIFO/Queue
+ * Status Register (GNPTXSTS). Read the register into the d32 element then read
+ * out the bits using the bit elements.
+ */
+union gnptxsts_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned reserved:1;
+		/* Top of the Non-Periodic Transmit Request Queue
+		 *  - bits 30:27 - Channel/EP Number
+		 *  - bits 26:25 - Token Type
+		 *    - 2'b00 - IN/OUT
+		 *    - 2'b01 - Zero Length OUT
+		 *    - 2'b10 - PING/Complete Split
+		 *    - 2'b11 - Channel Halt
+		 *  - bit 24 - Terminate (Last entry for the selected
+		 *    channel/EP)
+		 */
+		unsigned nptxqtop_chnep:4;
+		unsigned nptxqtop_token:2;
+		unsigned nptxqtop_terminate:1;
+		unsigned nptxqspcavail:8;
+		unsigned nptxfspcavail:16;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Transmit	FIFO Status Register
+ * (DTXFSTS). Read the register into the d32 element then read out the bits
+ * using the bit elements.
+ */
+union dtxfsts_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned reserved:16;
+		unsigned txfspcavail:16;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the I2C Control Register (I2CCTL).
+ * Read the register into the d32 element then read out the bits using the bit
+ * elements.
+ */
+union gi2cctl_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned bsydne:1;
+		unsigned rw:1;
+		unsigned reserved:2;
+		unsigned i2cdevaddr:2;
+		unsigned i2csuspctl:1;
+		unsigned ack:1;
+		unsigned i2cen:1;
+		unsigned addr:7;
+		unsigned regaddr:8;
+		unsigned rwdata:8;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the User HW Config1 Register.  Read
+ * the register into the d32 element then read out the bits using the bit
+ * elements.
+ */
+union hwcfg1_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned ep_dir15:2;
+		unsigned ep_dir14:2;
+		unsigned ep_dir13:2;
+		unsigned ep_dir12:2;
+		unsigned ep_dir11:2;
+		unsigned ep_dir10:2;
+		unsigned ep_dir9:2;
+		unsigned ep_dir8:2;
+		unsigned ep_dir7:2;
+		unsigned ep_dir6:2;
+		unsigned ep_dir5:2;
+		unsigned ep_dir4:2;
+		unsigned ep_dir3:2;
+		unsigned ep_dir2:2;
+		unsigned ep_dir1:2;
+		unsigned ep_dir0:2;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the User HW Config2 Register.  Read
+ * the register into the d32 element then read out the bits using the bit
+ * elements.
+ */
+union hwcfg2_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		/* GHWCFG2 */
+		unsigned reserved31:1;
+		unsigned dev_token_q_depth:5;
+		unsigned host_perio_tx_q_depth:2;
+		unsigned nonperio_tx_q_depth:2;
+		unsigned rx_status_q_depth:2;
+		unsigned dynamic_fifo:1;
+		unsigned perio_ep_supported:1;
+		unsigned num_host_chan:4;
+		unsigned num_dev_ep:4;
+		unsigned fs_phy_type:2;
+		unsigned hs_phy_type:2;
+#define DWC_HWCFG2_HS_PHY_TYPE_NOT_SUPPORTED		0
+#define DWC_HWCFG2_HS_PHY_TYPE_UTMI			1
+#define DWC_HWCFG2_HS_PHY_TYPE_ULPI			2
+#define DWC_HWCFG2_HS_PHY_TYPE_UTMI_ULPI		3
+
+		unsigned point2point:1;
+		unsigned architecture:2;
+		unsigned op_mode:3;
+#define DWC_HWCFG2_OP_MODE_HNP_SRP_CAPABLE_OTG		0
+#define DWC_HWCFG2_OP_MODE_SRP_ONLY_CAPABLE_OTG		1
+#define DWC_HWCFG2_OP_MODE_NO_HNP_SRP_CAPABLE_OTG	2
+#define DWC_HWCFG2_OP_MODE_SRP_CAPABLE_DEVICE		3
+#define DWC_HWCFG2_OP_MODE_NO_SRP_CAPABLE_DEVICE	4
+#define DWC_HWCFG2_OP_MODE_SRP_CAPABLE_HOST		5
+#define DWC_HWCFG2_OP_MODE_NO_SRP_CAPABLE_HOST		6
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the User HW Config3 Register.  Read
+ * the register into the d32 element then read out the bits using the bit
+ * elements.
+ */
+union hwcfg3_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		/* GHWCFG3 */
+		unsigned dfifo_depth:16;
+		unsigned reserved15_13:3;
+		unsigned ahb_phy_clock_synch:1;
+		unsigned synch_reset_type:1;
+		unsigned optional_features:1;
+		unsigned vendor_ctrl_if:1;
+		unsigned i2c:1;
+		unsigned otg_func:1;
+		unsigned packet_size_cntr_width:3;
+		unsigned xfer_size_cntr_width:4;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the User HW Config4 Register.  Read
+ * the register into the d32 element then read out the bits using the bit
+ * elements.
+ */
+union hwcfg4_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned reserved31_30:2;
+		unsigned num_in_eps:4;
+		unsigned ded_fifo_en:1;
+
+		unsigned session_end_filt_en:1;
+		unsigned b_valid_filt_en:1;
+		unsigned a_valid_filt_en:1;
+		unsigned vbus_valid_filt_en:1;
+		unsigned iddig_filt_en:1;
+		unsigned num_dev_mode_ctrl_ep:4;
+		unsigned utmi_phy_data_width:2;
+		unsigned min_ahb_freq:9;
+		unsigned power_optimiz:1;
+		unsigned num_dev_perio_in_ep:4;
+	} b;
+};
+
+/*
+ * Device Global Registers. Offsets 800h-BFFh
+ *
+ * The following structures define the size and relative field offsets for the
+ * Device Mode Registers.
+ *
+ * These registers are visible only in Device mode and must not be accessed in
+ * Host mode, as the results are unknown.
+ */
+struct device_global_regs {		/* CONFIG_DWC_OTG_REG_LE */
+	/* Device Configuration Register.			Offset: 800h */
+	u32 dcfg;
+	/* Device Control Register.				Offset: 804h */
+	u32 dctl;
+	/* Device Status Register (Read Only).			Offset: 808h */
+	u32 dsts;
+	/* Reserved.						Offset: 80Ch */
+	u32 unused;
+	/* Device IN Endpoint Common Interrupt Mask Register.	Offset: 810h */
+	u32 diepmsk;
+	/* Device OUT Endpoint Common Interrupt Mask Register.	Offset: 814h */
+	u32 doepmsk;
+	/* Device All Endpoints Interrupt Register.		Offset: 818h */
+	u32 daint;
+	/* Device All Endpoints Interrupt Mask Register.	Offset: 81Ch */
+	u32 daintmsk;
+	/* Device IN Token Queue Read Register-1 (Read Only).	Offset: 820h */
+	u32 dtknqr1;
+	/* Device IN Token Queue Read Register-2 (Read Only).	Offset: 824h */
+	u32 dtknqr2;
+	/* Device VBUS  discharge Register.			Offset: 828h */
+	u32 dvbusdis;
+	/* Device VBUS Pulse Register.				Offset: 82Ch */
+	u32 dvbuspulse;
+	/* Device IN Token Queue Read Register-3 (Read Only).	Offset: 830h */
+	u32 dtknqr3_dthrctl;
+	/* Device IN Token Queue Read Register-4 (Read Only).	Offset: 834h */
+	u32 dtknqr4_fifoemptymsk;
+};
+
+/*
+ * This union represents the bit fields in the Device Configuration
+ * Register.  Read the register into the d32 member then
+ * set/clear the bits using the bit elements.  Write the
+ * d32 member to the dcfg register.
+ */
+union dcfg_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned reserved0_8:9;
+		unsigned epmscnt:5;
+		/* In Endpoint Mis-match count */
+		unsigned reserved17_13:5;
+		/* Periodic Frame Interval */
+		unsigned perfrint:2;
+#define DWC_DCFG_FRAME_INTERVAL_80		0
+#define DWC_DCFG_FRAME_INTERVAL_85		1
+#define DWC_DCFG_FRAME_INTERVAL_90		2
+#define DWC_DCFG_FRAME_INTERVAL_95		3
+
+		/* Device Addresses */
+		unsigned devaddr:7;
+		unsigned reserved3:1;
+		/* Non Zero Length Status OUT Handshake */
+		unsigned nzstsouthshk:1;
+#define DWC_DCFG_SEND_STALL			1
+
+		/* Device Speed */
+		unsigned devspd:2;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device Control Register.  Read
+ * the register into the d32 member then set/clear the bits using the bit
+ * elements.
+ */
+union dctl_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned reserved31_12:21;
+		/* Clear Global OUT NAK */
+		unsigned cgoutnak:1;
+		/* Set Global OUT NAK */
+		unsigned sgoutnak:1;
+		/* Clear Global Non-Periodic IN NAK */
+		unsigned cgnpinnak:1;
+		/* Set Global Non-Periodic IN NAK */
+		unsigned sgnpinnak:1;
+		/* Test Control */
+		unsigned tstctl:3;
+		/* Global OUT NAK Status */
+		unsigned goutnaksts:1;
+		/* Global Non-Periodic IN NAK Status */
+		unsigned gnpinnaksts:1;
+		/* Soft Disconnect */
+		unsigned sftdiscon:1;
+		/* Remote Wakeup */
+		unsigned rmtwkupsig:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device Status Register.  Read the
+ * register into the d32 member then set/clear the bits using the bit elements.
+ */
+union dsts_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned reserved31_22:10;
+		/* Frame or Microframe Number of the received SOF */
+		unsigned soffn:14;
+		unsigned reserved07_04:4;
+		/* Erratic Error */
+		unsigned errticerr:1;
+		/* Enumerated Speed */
+		unsigned enumspd:2;
+#define DWC_DSTS_ENUMSPD_HS_PHY_30MHZ_OR_60MHZ		0
+#define DWC_DSTS_ENUMSPD_FS_PHY_30MHZ_OR_60MHZ		1
+#define DWC_DSTS_ENUMSPD_LS_PHY_6MHZ			2
+#define DWC_DSTS_ENUMSPD_FS_PHY_48MHZ			3
+		/* Suspend Status */
+		unsigned suspsts:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device IN EP Interrupt Register
+ * and the Device IN EP Common Mask Register.
+ *
+ * Read the register into the d32 member then set/clear the bits using the bit
+ * elements.
+ */
+union diepint_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned reserved31_08:23;
+		unsigned txfifoundrn:1;
+		/* IN Endpoint HAK Effective mask */
+		unsigned emptyintr:1;
+		/* IN Endpoint NAK Effective mask */
+		unsigned inepnakeff:1;
+		/* IN Token Received with EP mismatch mask */
+		unsigned intknepmis:1;
+		/* IN Token received with TxF Empty mask */
+		unsigned intktxfemp:1;
+		/* TimeOUT Handshake mask (non-ISOC EPs) */
+		unsigned timeout:1;
+		/* AHB Error mask */
+		unsigned ahberr:1;
+		/* Endpoint disable mask */
+		unsigned epdisabled:1;
+		/* Transfer complete mask */
+		unsigned xfercompl:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device OUT EP Interrupt Register
+ * and Device OUT EP Common Interrupt Mask Register.
+ *
+ * Read the register into the d32 member then set/clear the bits using the bit
+ * elements.
+ */
+union doepint_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned reserved31_04:28; /* Docs say reserved is 27 bits */
+
+		/* There is 1 bit missing here, not used? */
+
+		/* Setup Phase Done (control EPs) */
+		unsigned setup:1;
+		/* AHB Error */
+		unsigned ahberr:1;
+		/* Endpoint disable  */
+		unsigned epdisabled:1;
+		/* Transfer complete */
+		unsigned xfercompl:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device All EP Interrupt and Mask
+ * Registers.  Read the register into the d32 member then set/clear the bits
+ * using the bit elements.
+ */
+union daint_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		/* OUT Endpoint bits */
+		unsigned out:16;
+		/* IN Endpoint bits */
+		unsigned in:16;
+	} ep;
+	struct {
+		/* OUT Endpoint bits */
+		unsigned outep15:1;
+		unsigned outep14:1;
+		unsigned outep13:1;
+		unsigned outep12:1;
+		unsigned outep11:1;
+		unsigned outep10:1;
+		unsigned outep9:1;
+		unsigned outep8:1;
+		unsigned outep7:1;
+		unsigned outep6:1;
+		unsigned outep5:1;
+		unsigned outep4:1;
+		unsigned outep3:1;
+		unsigned outep2:1;
+		unsigned outep1:1;
+		unsigned outep0:1;
+		/* IN Endpoint bits */
+		unsigned inep15:1;
+		unsigned inep14:1;
+		unsigned inep13:1;
+		unsigned inep12:1;
+		unsigned inep11:1;
+		unsigned inep10:1;
+		unsigned inep9:1;
+		unsigned inep8:1;
+		unsigned inep7:1;
+		unsigned inep6:1;
+		unsigned inep5:1;
+		unsigned inep4:1;
+		unsigned inep3:1;
+		unsigned inep2:1;
+		unsigned inep1:1;
+		unsigned inep0:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device IN Token Queue Read
+ * Registers.  Read the register into the d32 member. READ-ONLY Register
+ */
+union dtknq1_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		/* EP Numbers of IN Tokens 0 ... 4 */
+		unsigned epnums0_5:24;
+		/* write pointer has wrapped. */
+		unsigned wrap_bit:1;
+		/* Reserved */
+		unsigned reserved05_06:2;
+		/* In Token Queue Write Pointer */
+		unsigned intknwptr:5;
+	} b;
+};
+
+/*
+ * This union represents Threshold control Register. Read and write the register
+ * into the d32 member.  READ-WRITABLE Register
+ */
+union dthrctl_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		/* Reserved */
+		unsigned reserved26_31:6;
+		/* Rx Thr. Length */
+		unsigned rx_thr_len:9;
+		/* Rx Thr. Enable */
+		unsigned rx_thr_en:1;
+		/* Reserved */
+		unsigned reserved11_15:5;
+		/* Tx Thr. Length */
+		unsigned tx_thr_len:9;
+		/* ISO Tx Thr. Enable */
+		unsigned iso_thr_en:1;
+		/* non ISO Tx Thr. Enable */
+		unsigned non_iso_thr_en:1;
+	} b;
+};
+
+/*
+ * Device Logical IN Endpoint-Specific Registers. Offsets 900h-AFCh
+ *
+ * There will be one set of endpoint registers per logical endpoint implemented.
+ *
+ * These registers are visible only in Device mode and must not be accessed in
+ * Host mode, as the results are unknown.
+ */
+ struct device_in_ep_regs {
+	/*
+	 * Device IN Endpoint Control Register.
+	 * Offset:900h + (ep_num * 20h) + 00h
+	 */
+	u32 diepctl;
+	/* Reserved. Offset:900h + (ep_num * 20h) + 04h */
+	u32 reserved04;
+	/*
+	 * Device IN Endpoint Interrupt Register.
+	 * Offset:900h + (ep_num * 20h) + 08h
+	 */
+	u32 diepint;
+	/* Reserved. Offset:900h + (ep_num * 20h) + 0Ch */
+	u32 reserved0C;
+	/* Device IN Endpoint Transfer Size Register.
+	 * Offset:900h + (ep_num * 20h) + 10h
+	 */
+	u32 dieptsiz;
+	/*
+	 * Device IN Endpoint DMA Address Register.
+	 * Offset:900h + (ep_num * 20h) + 14h
+	 */
+	u32 diepdma;
+	/* Reserved.
+	 * Offset:900h + (ep_num * 20h) + 18h - 900h + (ep_num * 20h) + 1Ch
+	 */
+	u32 dtxfsts;
+	/*
+	 * Reserved.
+	 * Offset:900h + (ep_num * 20h) + 1Ch - 900h + (ep_num * 20h) + 1Ch
+	 */
+	u32 reserved18;
+};
+
+/*
+ * Device Logical OUT Endpoint-Specific Registers. Offsets: B00h-CFCh
+ *
+ * There will be one set of endpoint registers per logical endpoint implemented.
+ *
+ * These registers are visible only in Device mode and must not be accessed in
+ * Host mode, as the results are unknown.
+ */
+struct device_out_ep_regs {
+	/*
+	 * Device OUT Endpoint Control Register.
+	 * Offset:B00h + (ep_num * 20h) + 00h
+	 */
+	u32 doepctl;
+	/*
+	 * Device OUT Endpoint Frame number Register.
+	 * Offset: B00h + (ep_num * 20h) + 04h
+	 */
+	u32 doepfn;
+	/*
+	 * Device OUT Endpoint Interrupt Register.
+	 * Offset:B00h + (ep_num * 20h) + 08h
+	 */
+	u32 doepint;
+	/* Reserved. Offset:B00h + (ep_num * 20h) + 0Ch */
+	u32 reserved0C;
+	/*
+	 * Device OUT Endpoint Transfer Size Register.
+	 * Offset: B00h + (ep_num * 20h) + 10h
+	 */
+	u32 doeptsiz;
+	/*
+	 * Device OUT Endpoint DMA Address Register.
+	 * Offset:B00h + (ep_num * 20h) + 14h
+	 */
+	u32 doepdma;
+	/*
+	 * Reserved.
+	 * Offset:B00h + (ep_num * 20h) + 18h - B00h + (ep_num * 20h) + 1Ch
+	 */
+	u32 unused[2];
+};
+
+/*
+ * This union represents the bit fields in the Device EP Control Register.  Read
+ * the register into the d32 member then set/clear the bits using the bit
+ * elements.
+ */
+union depctl_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		/* Endpoint Enable */
+		unsigned epena:1;
+		/* Endpoint Disable */
+		unsigned epdis:1;
+
+		/*
+		 * Set DATA1 PID (INTR/Bulk IN and OUT endpoints) Writing to
+		 * this field sets the Endpoint DPID (DPID) field in this
+		 * register to DATA1 Set Odd (micro)frame (SetOddFr) (ISO IN and
+		 * OUT Endpoints) Writing to this field sets the Even/Odd
+		 * (micro)frame (EO_FrNum) field to odd (micro) frame.
+		 */
+		unsigned setd1pid:1;
+		/*
+		 * Set DATA0 PID (INTR/Bulk IN and OUT endpoints)  Writing to
+		 * this field sets the Endpoint DPID (DPID) field in this
+		 * register to DATA0. Set Even (micro)frame (SetEvenFr) (ISO IN
+		 * and OUT Endpoints) Writing to this field sets the Even/Odd
+		 * (micro)frame (EO_FrNum) field to even (micro) frame.
+		 */
+		unsigned setd0pid:1;
+
+		/* Set NAK */
+		unsigned snak:1;
+		/* Clear NAK */
+		unsigned cnak:1;
+
+		/*
+		 * Tx Fifo Number
+		 * IN EPn/IN EP0
+		 * OUT EPn/OUT EP0 - reserved
+		 */
+		unsigned txfnum:4;
+
+		/* Stall Handshake */
+		unsigned stall:1;
+
+		/* Snoop Mode
+		 * OUT EPn/OUT EP0
+		 * IN EPn/IN EP0 - reserved
+		 */
+		unsigned snp:1;
+
+		/* Endpoint Type
+		 *  2'b00: Control
+		 *  2'b01: Isochronous
+		 *  2'b10: Bulk
+		 *  2'b11: Interrupt
+		 */
+		unsigned eptype:2;
+
+		/* NAK Status */
+		unsigned naksts:1;
+
+		/*
+		 * Endpoint DPID (INTR/Bulk IN and OUT endpoints) This field
+		 * contains the PID of the packet going to be received or
+		 * transmitted on this endpoint. The application should program
+		 * the PID of the first packet going to be received or
+		 * transmitted on this endpoint, after the endpoint is
+		 * activated. Applications use the SetD1PID and SetD0PID fields
+		 * of this register to program either D0 or D1 PID.
+		 *
+		 * The encoding for this field is
+		 *   - 0: D0
+		 *   - 1: D1
+		 */
+		unsigned dpid:1;
+
+		/* USB Active Endpoint */
+		unsigned usbactep:1;
+
+		/*
+		 * Next Endpoint
+		 * IN EPn/IN EP0
+		 * OUT EPn/OUT EP0 - reserved
+		 */
+		unsigned nextep:4;
+
+		/*
+		 * Maximum Packet Size
+		 * IN/OUT EPn
+		 * IN/OUT EP0 - 2 bits
+		 *   2'b00: 64 Bytes
+		 *   2'b01: 32
+		 *   2'b10: 16
+		 *   2'b11: 8
+		 */
+		unsigned mps:11;
+#define DWC_DEP0CTL_MPS_64			0
+#define DWC_DEP0CTL_MPS_32			1
+#define DWC_DEP0CTL_MPS_16			2
+#define DWC_DEP0CTL_MPS_8			3
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device EP Transfer Size Register.
+ * Read the register into the d32 member then set/clear the bits using the bit
+ * elements.
+ */
+union deptsiz_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+
+	/*
+	 * Added-sr: 2007-07-26
+	 *
+	 * Correct ther register layout for the 405EZ Ultra
+	 * USB device implementation.
+	 */
+#ifdef CONFIG_DWC_LIMITED_XFER_SIZE
+	struct {
+		unsigned reserved:1;
+		/* Multi Count - Periodic IN endpoints */
+		unsigned mc:2;
+		unsigned reserved1:5;
+		/* Packet Count */
+		unsigned pktcnt:5;
+		unsigned reserved2:8;
+		/* Transfer size */
+		unsigned xfersize:11;
+	} b;
+#else
+	struct {
+		unsigned reserved:1;
+		/* Multi Count - Periodic IN endpoints */
+		unsigned mc:2;
+		/* Packet Count */
+		unsigned pktcnt:10;
+		/* Transfer size */
+		unsigned xfersize:19;
+	} b;
+#endif
+};
+
+/*
+ * This union represents the bit fields in the Device EP 0 Transfer Size
+ * Register.  Read the register into the d32 member then set/clear the bits
+ * using the bit elements.
+ */
+union deptsiz0_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned reserved31:1; /* device*/
+		/*Setup Packet Count (DOEPTSIZ0 Only) */
+		unsigned supcnt:2;
+		/* Reserved */
+		unsigned reserved28_20:9;
+		/* Packet Count */
+		unsigned pktcnt:1;
+		/* Reserved */
+		unsigned reserved18_7:12;
+		/* Transfer size */
+		unsigned xfersize:7;
+	} b;
+};
+
+#define MAX_PERIO_FIFOS			15	/* Max periodic FIFOs */
+#define MAX_TX_FIFOS			15	/* Max non-periodic FIFOs */
+
+/* Maximum number of Endpoints/HostChannels */
+#if defined(CONFIG_460EX)
+#define MAX_EPS_CHANNELS 12
+#else
+#define MAX_EPS_CHANNELS 4
+#endif
+
+/*
+ * The device_if structure contains information needed to manage the DWC_otg
+ * controller acting in device mode. It represents the programming view of the
+ * device-specific aspects of the controller.
+ */
+struct device_if {
+	/* Device Global Registers starting at offset 800h */
+	struct device_global_regs *dev_global_regs;
+#define DWC_DEV_GLOBAL_REG_OFFSET		0x800
+
+	/* Device Logical IN Endpoint-Specific Registers 900h-AFCh */
+	struct device_in_ep_regs *in_ep_regs[MAX_EPS_CHANNELS];
+#define DWC_DEV_IN_EP_REG_OFFSET		0x900
+#define DWC_EP_REG_OFFSET			0x20
+
+	/* Device Logical OUT Endpoint-Specific Registers B00h-CFCh */
+	struct device_out_ep_regs *out_ep_regs[MAX_EPS_CHANNELS];
+#define DWC_DEV_OUT_EP_REG_OFFSET		0xB00
+
+	/* Device configuration information */
+	/* Device Speed  0: Unknown, 1: LS, 2:FS, 3: HS */
+	u8  speed;
+	/*  Number # of Tx EP range: 0-15 exept ep0 */
+	u8  num_in_eps;
+	/*  Number # of Rx EP range: 0-15 exept ep 0*/
+	u8  num_out_eps;
+
+	/* Size of periodic FIFOs (Bytes) */
+	u16 perio_tx_fifo_size[MAX_PERIO_FIFOS];
+
+	/* Size of Tx FIFOs (Bytes) */
+	u16 tx_fifo_size[MAX_TX_FIFOS];
+
+	/* Thresholding enable flags and length varaiables */
+	u16 rx_thr_en;
+	u16 iso_tx_thr_en;
+	u16 non_iso_tx_thr_en;
+	u16 rx_thr_length;
+	u16 tx_thr_length;
+};
+
+/*
+ * This union represents the bit fields in the Power and Clock Gating Control
+ * Register. Read the register into the d32 member then set/clear the
+ * bits using the bit elements.
+ */
+union pcgcctl_data {
+	u32 d32;
+	struct {
+		unsigned reserved31_05:27;
+		/* PHY Suspended */
+		unsigned physuspended:1;
+		/* Reset Power Down Modules */
+		unsigned rstpdwnmodule:1;
+		/* Power Clamp */
+		unsigned pwrclmp:1;
+		/* Gate Hclk */
+		unsigned gatehclk:1;
+		/* Stop Pclk */
+		unsigned stoppclk:1;
+	} b;
+};
+
+/*
+ * Host Mode Register Structures
+ */
+
+/*
+ * The Host Global Registers structure defines the size and relative field
+ * offsets for the Host Mode Global Registers.  Host Global Registers offsets
+ * 400h-7FFh.
+*/
+struct host_global_regs {
+	/* Host Configuration Register.				Offset: 400h */
+	u32 hcfg;
+	/* Host Frame Interval Register.			Offset: 404h */
+	u32 hfir;
+	/* Host Frame Number / Frame Remaining Register.	Offset: 408h */
+	u32 hfnum;
+	/* Reserved.						Offset: 40Ch */
+	u32 reserved40C;
+	/* Host Periodic Transmit FIFO/ Queue Status Register.	Offset: 410h */
+	u32 hptxsts;
+	/* Host All Channels Interrupt Register.		Offset: 414h */
+	u32 haint;
+	/* Host All Channels Interrupt Mask Register.		Offset: 418h */
+	u32 haintmsk;
+};
+
+/*
+ * This union represents the bit fields in the Host Configuration Register. Read
+ * the register into the d32 member then set/clear the bits using the bit
+ * elements. Write the d32 member to the hcfg register.
+ */
+union hcfg_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+#define DWC_HCFG_30_60_MHZ			0
+#define DWC_HCFG_48_MHZ				1
+#define DWC_HCFG_6_MHZ				2
+		/* FS/LS Only Support */
+		unsigned fslssupp:1;
+		/* FS/LS Phy Clock Select */
+		unsigned fslspclksel:2;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Host Frame Remaing/Number
+ * Register.
+ */
+union hfir_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned reserved:16;
+		unsigned frint:16;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Host Frame Remaing/Number
+ * Register.
+ */
+union hfnum_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+#define DWC_HFNUM_MAX_FRNUM			0x3FFF
+		unsigned frrem:16;
+		unsigned frnum:16;
+	} b;
+};
+
+union hptxsts_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned ptxqtop_odd:1;
+		unsigned ptxqtop_chnum:4;
+		unsigned ptxqtop_token:2;
+		unsigned ptxqtop_terminate:1;
+		unsigned ptxqspcavail:8;
+		unsigned ptxfspcavail:16;
+		/*
+		 * Top of the Periodic Transmit Request Queue
+		 *  - bit 24 - Terminate (last entry for the selected channel)
+		 *  - bits 26:25 - Token Type
+		 *    - 2'b00 - Zero length
+		 *    - 2'b01 - Ping
+		 *    - 2'b10 - Disable
+		 *  - bits 30:27 - Channel Number
+		 *  - bit 31 - Odd/even microframe
+		 */
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Host Port Control and Status
+ * Register. Read the register into the d32 member then set/clear the bits using
+ * the bit elements. Write the d32 member to the hprt0 register.
+ */
+union hprt0_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+#define DWC_HPRT0_PRTSPD_HIGH_SPEED		0
+#define DWC_HPRT0_PRTSPD_FULL_SPEED		1
+#define DWC_HPRT0_PRTSPD_LOW_SPEED		2
+		unsigned reserved19_31:13;
+		unsigned prtspd:2;
+		unsigned prttstctl:4;
+		unsigned prtpwr:1;
+		unsigned prtlnsts:2;
+		unsigned reserved9:1;
+		unsigned prtrst:1;
+		unsigned prtsusp:1;
+		unsigned prtres:1;
+		unsigned prtovrcurrchng:1;
+		unsigned prtovrcurract:1;
+		unsigned prtenchng:1;
+		unsigned prtena:1;
+		unsigned prtconndet:1;
+		unsigned prtconnsts:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Host All Interrupt Register.
+ */
+union haint_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned reserved:16;
+		unsigned ch15:1;
+		unsigned ch14:1;
+		unsigned ch13:1;
+		unsigned ch12:1;
+		unsigned ch11:1;
+		unsigned ch10:1;
+		unsigned ch9:1;
+		unsigned ch8:1;
+		unsigned ch7:1;
+		unsigned ch6:1;
+		unsigned ch5:1;
+		unsigned ch4:1;
+		unsigned ch3:1;
+		unsigned ch2:1;
+		unsigned ch1:1;
+		unsigned ch0:1;
+	} b;
+	struct {
+		unsigned reserved:16;
+		unsigned chint:16;
+	} b2;
+};
+
+/*
+ * This union represents the bit fields in the Host All Interrupt Register.
+ */
+union haintmsk_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned reserved:16;
+		unsigned ch15:1;
+		unsigned ch14:1;
+		unsigned ch13:1;
+		unsigned ch12:1;
+		unsigned ch11:1;
+		unsigned ch10:1;
+		unsigned ch9:1;
+		unsigned ch8:1;
+		unsigned ch7:1;
+		unsigned ch6:1;
+		unsigned ch5:1;
+		unsigned ch4:1;
+		unsigned ch3:1;
+		unsigned ch2:1;
+		unsigned ch1:1;
+		unsigned ch0:1;
+	} b;
+	struct {
+		unsigned reserved:16;
+		unsigned chint:16;
+	} b2;
+};
+
+/*
+ * Host Channel Specific Registers. 500h-5FCh
+ */
+struct dwc_hc_regs {			/* CONFIG_DWC_OTG_REG_LE */
+	/*
+	 * Host Channel 0 Characteristic Register.
+	 * Offset: 500h + (chan_num * 20h) + 00h
+	 */
+	u32 hcchar;
+	/*
+	 * Host Channel 0 Split Control Register.
+	 * Offset: 500h + (chan_num * 20h) + 04h
+	 */
+	u32 hcsplt;
+	/*
+	 * Host Channel 0 Interrupt Register.
+	 * Offset: 500h + (chan_num * 20h) + 08h
+	 */
+	u32 hcint;
+	/*
+	 * Host Channel 0 Interrupt Mask Register.
+	 * Offset: 500h + (chan_num * 20h) + 0Ch
+	 */
+	u32 hcintmsk;
+	/*
+	 * Host Channel 0 Transfer Size Register.
+	 * Offset: 500h + (chan_num * 20h) + 10h
+	 */
+	u32 hctsiz;
+	/*
+	 * Host Channel 0 DMA Address Register.
+	 * Offset: 500h + (chan_num * 20h) + 14h
+	 */
+	u32 hcdma;
+	/*
+	 * Reserved.
+	 * Offset: 500h + (chan_num * 20h) + 18h - 500h + (chan_num * 20h) + 1Ch
+	  */
+	u32 reserved[2];
+};
+
+/*
+ * This union represents the bit fields in the Host Channel Characteristics
+ * Register. Read the register into the d32 member then set/clear the bits using
+ * the bit elements. Write the d32 member to the hcchar register.
+ */
+union hcchar_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		/* Channel enable */
+		unsigned chen:1;
+		/* Channel disable */
+		unsigned chdis:1;
+		/*
+		 * Frame to transmit periodic transaction.
+		 * 0: even, 1: odd
+		 */
+		unsigned oddfrm:1;
+		/* Device address */
+		unsigned devaddr:7;
+		/* Packets per frame for periodic transfers. 0 is reserved. */
+		unsigned multicnt:2;
+		/* 0: Control, 1: Isoc, 2: Bulk, 3: Intr */
+		unsigned eptype:2;
+		/* 0: Full/high speed device, 1: Low speed device */
+		unsigned lspddev:1;
+		unsigned reserved:1;
+		/* 0: OUT, 1: IN */
+		unsigned epdir:1;
+		/* Endpoint number */
+		unsigned epnum:4;
+		/* Maximum packet size in bytes */
+		unsigned mps:11;
+	} b;
+};
+
+union hcsplt_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		/* Split Enble */
+		unsigned spltena:1;
+		/* Reserved */
+		unsigned reserved:14;
+		/* Do Complete Split */
+		unsigned compsplt:1;
+		/* Transaction Position */
+		unsigned xactpos:2;
+#define DWC_HCSPLIT_XACTPOS_MID			0
+#define DWC_HCSPLIT_XACTPOS_END			1
+#define DWC_HCSPLIT_XACTPOS_BEGIN		2
+#define DWC_HCSPLIT_XACTPOS_ALL			3
+
+		/* Hub Address */
+		unsigned hubaddr:7;
+		/* Port Address */
+		unsigned prtaddr:7;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Host All Interrupt
+ * Register.
+ */
+union hcint_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		/* Reserved */
+		unsigned reserved:21;
+		/* Data Toggle Error */
+		unsigned datatglerr:1;
+		/* Frame Overrun */
+		unsigned frmovrun:1;
+		/* Babble Error */
+		unsigned bblerr:1;
+		/* Transaction Err */
+		unsigned xacterr:1;
+		/* NYET Response Received */
+		unsigned nyet:1;
+		/* ACK Response Received */
+		unsigned ack:1;
+		/* NAK Response Received */
+		unsigned nak:1;
+		/* STALL Response Received */
+		unsigned stall:1;
+		/* AHB Error */
+		unsigned ahberr:1;
+		/* Channel Halted */
+		unsigned chhltd:1;
+		/* Transfer Complete */
+		unsigned xfercomp:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Host Channel Transfer Size
+ * Register. Read the register into the d32 member then set/clear the  bits
+ * using the bit elements. Write the d32 member to the hcchar register.
+ */
+union hctsiz_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+#define DWC_HCTSIZ_DATA0			0
+#define DWC_HCTSIZ_DATA1			2
+#define DWC_HCTSIZ_DATA2			1
+#define DWC_HCTSIZ_MDATA			3
+#define DWC_HCTSIZ_SETUP			3
+
+		/* Do PING protocol when 1 */
+		unsigned dopng:1;
+		/*
+		 * Packet ID for next data packet
+		 * 0: DATA0
+		 * 1: DATA2
+		 * 2: DATA1
+		 * 3: MDATA (non-Control), SETUP (Control)
+		 */
+		unsigned pid:2;
+		/* Data packets to transfer */
+		unsigned pktcnt:10;
+		/* Total transfer size in bytes */
+		unsigned xfersize:19;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Host Channel Interrupt Mask
+ * Register. Read the register into the d32 member then set/clear the bits using
+ * the bit elements. Write the d32 member to the hcintmsk register.
+ */
+union hcintmsk_data {				/* CONFIG_DWC_OTG_REG_LE */
+	u32 d32;
+	struct {
+		unsigned reserved:21;
+		unsigned datatglerr:1;
+		unsigned frmovrun:1;
+		unsigned bblerr:1;
+		unsigned xacterr:1;
+		unsigned nyet:1;
+		unsigned ack:1;
+		unsigned nak:1;
+		unsigned stall:1;
+		unsigned ahberr:1;
+		unsigned chhltd:1;
+		unsigned xfercompl:1;
+	} b;
+};
+
+/*
+ * OTG Host Interface Structure.
+ *
+ * The OTG Host Interface Structure structure contains information needed to
+ * manage the DWC_otg controller acting in host mode. It represents the
+ * programming view of the host-specific aspects of the controller.
+ */
+struct dwc_host_if {			/* CONFIG_DWC_OTG_REG_LE */
+	/* Host Global Registers starting at offset 400h.*/
+	struct host_global_regs *host_global_regs;
+#define DWC_OTG_HOST_GLOBAL_REG_OFFSET		0x400
+
+	/* Host Port 0 Control and Status Register */
+	u32 *hprt0;
+#define DWC_OTG_HOST_PORT_REGS_OFFSET		0x440
+
+	/* Host Channel Specific Registers at offsets 500h-5FCh. */
+	struct dwc_hc_regs *hc_regs[MAX_EPS_CHANNELS];
+#define DWC_OTG_HOST_CHAN_REGS_OFFSET		0x500
+#define DWC_OTG_CHAN_REGS_OFFSET		0x20
+
+	/* Host configuration information */
+	/* Number of Host Channels (range: 1-16) */
+	u8  num_host_channels;
+	/* Periodic EPs supported (0: no, 1: yes) */
+	u8  perio_eps_supported;
+	/* Periodic Tx FIFO Size (Only 1 host periodic Tx FIFO) */
+	u16 perio_tx_fifo_size;
+};
+
+#else  /* CONFIG_DWC_OTG_REG_LE not defined */
+
+/*
+ * This union represents the bit fields of the Core OTG Control
+ * and Status Register (GOTGCTL).  Set the bits using the bit
+ * fields then write the d32 value to the register.
+ */
+union gotgctl_data {
+	u32 d32;
+	struct {
+		unsigned sesreqscs:1;
+		unsigned sesreq:1;
+		unsigned reserved2_7:6;
+		unsigned hstnegscs:1;
+		unsigned hnpreq:1;
+		unsigned hstsethnpen:1;
+		unsigned devhnpen:1;
+		unsigned reserved12_15:4;
+		unsigned conidsts:1;
+		unsigned reserved17:1;
+		unsigned asesvld:1;
+		unsigned bsesvld:1;
+		unsigned currmod:1;
+		unsigned reserved21_31:11;
+	} b;
+};
+
+/*
+ * This union represents the bit fields of the Core OTG Interrupt Register
+ * (GOTGINT).  Set/clear the bits using the bit fields then write the d32
+ * value to the register.
+ */
+union gotgint_data {
+	u32 d32;
+	struct {
+		/* Current Mode */
+		unsigned reserved0_1:2;
+
+		/* Session End Detected */
+		unsigned sesenddet:1;
+
+		unsigned reserved3_7:5;
+
+		/* Session Request Success Status Change */
+		unsigned sesreqsucstschng:1;
+		/* Host Negotiation Success Status Change */
+		unsigned hstnegsucstschng:1;
+
+		unsigned reserver10_16:7;
+
+		/* Host Negotiation Detected */
+		unsigned hstnegdet:1;
+		/* A-Device Timeout Change */
+		unsigned adevtoutchng:1;
+		/* Debounce Done */
+		unsigned debdone:1;
+
+		unsigned reserved31_20:12;
+
+	} b;
+};
+
+/*
+ * This union represents the bit fields of the Core AHB Configuration Register
+ * (GAHBCFG).  Set/clear the bits using the bit fields then write the d32 value
+ * to the register.
+ */
+union gahbcfg_data {
+	u32 d32;
+	struct {
+		unsigned glblintrmsk:1;
+#define DWC_GAHBCFG_GLBINT_ENABLE		1
+
+		unsigned hburstlen:4;
+#define DWC_GAHBCFG_INT_DMA_BURST_SINGLE	0
+#define DWC_GAHBCFG_INT_DMA_BURST_INCR		1
+#define DWC_GAHBCFG_INT_DMA_BURST_INCR4		3
+#define DWC_GAHBCFG_INT_DMA_BURST_INCR8		5
+#define DWC_GAHBCFG_INT_DMA_BURST_INCR16	7
+
+		unsigned dmaenable:1;
+#define DWC_GAHBCFG_DMAENABLE			1
+		unsigned reserved:1;
+		unsigned nptxfemplvl_txfemplvl:1;
+		unsigned ptxfemplvl:1;
+#define DWC_GAHBCFG_TXFEMPTYLVL_EMPTY		1
+#define DWC_GAHBCFG_TXFEMPTYLVL_HALFEMPTY	0
+		unsigned reserved9_31:23;
+	} b;
+};
+
+/*
+ * This union represents the bit fields of the Core USB Configuration Register
+ * (GUSBCFG).  Set the bits using the bit fields then write the d32 value to
+ * the register.
+ */
+union gusbcfg_data {
+	u32 d32;
+	struct {
+		unsigned toutcal:3;
+		unsigned phyif:1;
+		unsigned ulpi_utmi_sel:1;
+		unsigned fsintf:1;
+		unsigned physel:1;
+		unsigned ddrsel:1;
+		unsigned srpcap:1;
+		unsigned hnpcap:1;
+		unsigned usbtrdtim:4;
+		unsigned nptxfrwnden:1;
+		unsigned phylpwrclksel:1;
+		unsigned otgutmifssel:1;
+		unsigned ulpi_fsls:1;
+		unsigned ulpi_auto_res:1;
+		unsigned ulpi_clk_sus_m:1;
+		unsigned ulpi_ext_vbus_drv:1;
+		unsigned ulpi_int_vbus_indicator:1;
+		unsigned term_sel_dl_pulse:1;
+		unsigned reserved23_28:6;
+		unsigned force_host_mode:1;
+		unsigned force_device_mode:1;
+		unsigned corrupt_tx_packet:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields of the Core Reset Register (GRSTCTL).
+ * Set/clear the bits using the bit fields then write the d32 value to the
+ * register.
+ */
+union grstctl_data {
+	u32 d32;
+	struct {
+		/*
+		 * Core Soft Reset (CSftRst) (Device and Host)
+		 *
+		 * The application can flush the control logic in the entire
+		 * core using this bit. This bit resets the pipelines in the AHB
+		 * Clock domain as well as the PHY Clock domain.
+		 *
+		 * The state machines are reset to an IDLE state, the control
+		 * bits in the CSRs are cleared, all the transmit FIFOs and the
+		 * receive FIFO are flushed.
+		 *
+		 * The status mask bits that control the generation of the
+		 * interrupt, are cleared, to clear the interrupt. The interrupt
+		 * status bits are not cleared, so the application can get the
+		 * status of any events that occurred in the core after it has
+		 * set this bit.
+		 *
+		 * Any transactions on the AHB are terminated as soon as
+		 * possible following the protocol. Any transactions on the USB
+		 * are terminated immediately.
+		 *
+		 * The configuration settings in the CSRs are unchanged, so the
+		 * software doesn't have to reprogram these registers (Device
+		 * Configuration/Host Configuration/Core System
+		 * Configuration/Core PHY Configuration).
+		 *
+		 * The application can write to this bit, any time it wants to
+		 * reset the core. This is a self clearing bit and the core
+		 * clears this bit after all the necessary logic is reset in the
+		 * core, which may take several clocks, depending on the current
+		 * state of the core.
+		 */
+		unsigned csftrst:1;
+		/*
+		 * Hclk Soft Reset
+		 *
+		 * The application uses this bit to reset the control logic in
+		 * the AHB clock domain. Only AHB clock domain pipelines are
+		 * reset.
+		 */
+		unsigned hsftrst:1;
+		/*
+		 * Host Frame Counter Reset (Host Only)<br>
+		 *
+		 * The application can reset the (micro)frame number counter
+		 * inside the core, using this bit. When the (micro)frame
+		 * counter is reset, the subsequent SOF sent out by the core,
+		 * will have a (micro)frame number of 0.
+		 */
+		unsigned hstfrm:1;
+		/*
+		 * In Token Sequence Learning Queue Flush (INTknQFlsh) (Device
+		 * Only)
+		 */
+		unsigned intknqflsh:1;
+		/*
+		 * RxFIFO Flush (RxFFlsh) (Device and Host)
+		 *
+		 * The application can flush the entire Receive FIFO using this
+		 * bit.
+		 *
+		 * The application must first ensure that the core is not in the
+		 * middle of a transaction.
+		 *
+		 * The application should write into this bit, only after making
+		 * sure that neither the DMA engine is reading from the RxFIFO
+		 * nor the MAC is writing the data in to the FIFO.
+		 *
+		 * The application should wait until the bit is cleared before
+		 * performing any other operations. This bit will takes 8 clocks
+		 * (slowest of PHY or AHB clock) to clear.
+		 */
+		unsigned rxfflsh:1;
+		/*
+		 * TxFIFO Flush (TxFFlsh) (Device and Host).
+		 *
+		 * This bit is used to selectively flush a single or all
+		 * transmit FIFOs.  The application must first ensure that the
+		 * core is not in the middle of a transaction.
+		 *
+		 * The application should write into this bit, only after making
+		 * sure that neither the DMA engine is writing into the TxFIFO
+		 * nor the MAC is reading the data out of the FIFO.
+		 *
+		 * The application should wait until the core clears this bit,
+		 * before performing any operations. This bit will takes 8
+		 * clocks (slowest of PHY or AHB clock) to clear.
+		 */
+		unsigned txfflsh:1;
+
+		/*
+		 * TxFIFO Number (TxFNum) (Device and Host).
+		 *
+		 * This is the FIFO number which needs to be flushed, using the
+		 * TxFIFO Flush bit. This field should not be changed until the
+		 * TxFIFO Flush bit is cleared by the core.
+		 *	 - 0x0 : Non Periodic TxFIFO Flush
+		 *	 - 0x1 : Periodic TxFIFO #1 Flush in device mode
+		 *	   or Periodic TxFIFO in host mode
+		 *	 - 0x2 : Periodic TxFIFO #2 Flush in device mode.
+		 *	 - ...
+		 *	 - 0xF : Periodic TxFIFO #15 Flush in device mode
+		 *	 - 0x10: Flush all the Transmit NonPeriodic and
+		 *	   Transmit Periodic FIFOs in the core
+		 */
+		unsigned txfnum:5;
+#define DWC_GRSTCTL_TXFNUM_ALL			0x10
+
+		/* Reserved */
+		unsigned reserved11_29:19;
+		/*
+		 * DMA Request Signal.  Indicated DMA request is in progress.
+		 * Used for debug purpose.
+		 */
+		unsigned dmareq:1;
+		/*
+		 * AHB Master Idle.  Indicates the AHB Master State Machine is
+		 * in IDLE condition.
+		 */
+		unsigned ahbidle:1;
+	} b;
+};
+
+
+/*
+ * This union represents the bit fields of the Core Interrupt Mask Register
+ * (GINTMSK). Set/clear the bits using the bit fields then write the d32 value
+ * to the register.
+ */
+union gintmsk_data {
+	u32 d32;
+	struct {
+		unsigned reserved0:1;
+		unsigned modemismatch:1;
+		unsigned otgintr:1;
+		unsigned sofintr:1;
+		unsigned rxstsqlvl:1;
+		unsigned nptxfempty:1;
+		unsigned ginnakeff:1;
+		unsigned goutnakeff:1;
+		unsigned reserved8:1;
+		unsigned i2cintr:1;
+		unsigned erlysuspend:1;
+		unsigned usbsuspend:1;
+		unsigned usbreset:1;
+		unsigned enumdone:1;
+		unsigned isooutdrop:1;
+		unsigned eopframe:1;
+		unsigned reserved16:1;
+		unsigned epmismatch:1;
+		unsigned inepintr:1;
+		unsigned outepintr:1;
+		unsigned incomplisoin:1;
+		unsigned incomplisoout:1;
+		unsigned reserved22_23:2;
+		unsigned portintr:1;
+		unsigned hcintr:1;
+		unsigned ptxfempty:1;
+		unsigned reserved27:1;
+		unsigned conidstschng:1;
+		unsigned disconnect:1;
+		unsigned sessreqintr:1;
+		unsigned wkupintr:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields of the Core Interrupt Register
+ * (GINTSTS).  Set/clear the bits using the bit fields then write the d32 value
+ * to the register.
+ */
+union gintsts_data {
+	u32 d32;
+#define DWC_SOF_INTR_MASK			0x0008
+
+	struct {
+#define DWC_HOST_MODE 1
+		unsigned curmode:1;
+		unsigned modemismatch:1;
+		unsigned otgintr:1;
+		unsigned sofintr:1;
+		unsigned rxstsqlvl:1;
+		unsigned nptxfempty:1;
+		unsigned ginnakeff:1;
+		unsigned goutnakeff:1;
+		unsigned reserved8:1;
+		unsigned i2cintr:1;
+		unsigned erlysuspend:1;
+		unsigned usbsuspend:1;
+		unsigned usbreset:1;
+		unsigned enumdone:1;
+		unsigned isooutdrop:1;
+		unsigned eopframe:1;
+		unsigned intokenrx:1;
+		unsigned epmismatch:1;
+		unsigned inepint:1;
+		unsigned outepintr:1;
+		unsigned incomplisoin:1;
+		unsigned incomplisoout:1;
+		unsigned reserved22_23:2;
+		unsigned portintr:1;
+		unsigned hcintr:1;
+		unsigned ptxfempty:1;
+		unsigned reserved27:1;
+		unsigned conidstschng:1;
+		unsigned disconnect:1;
+		unsigned sessreqintr:1;
+		unsigned wkupintr:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device Receive Status Read and
+ * Pop Registers (GRXSTSR, GRXSTSP) Read the register into the d32 element then
+ * read out the bits using the bit elements.
+ */
+union device_grxsts_data {
+	u32 d32;
+	struct {
+		unsigned epnum:4;
+		unsigned bcnt:11;
+		unsigned dpid:2;
+
+#define DWC_STS_DATA_UPDT		0x2	/* OUT Data Packet */
+#define DWC_STS_XFER_COMP		0x3	/* OUT Data Transfer Complete */
+#define DWC_DSTS_GOUT_NAK		0x1	/* Global OUT NAK */
+#define DWC_DSTS_SETUP_COMP		0x4	/* Setup Phase Complete */
+#define DWC_DSTS_SETUP_UPDT		0x6	/* SETUP Packet */
+		unsigned pktsts:4;
+		unsigned fn:4;
+		unsigned reserved:7;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Host Receive Status Read and
+ * Pop Registers (GRXSTSR, GRXSTSP) Read the register into the d32 element then
+ * read out the bits using the bit elements.
+ */
+union host_grxsts_data {
+	u32 d32;
+	struct {
+		unsigned chnum:4;
+		unsigned bcnt:11;
+		unsigned dpid:2;
+
+		unsigned pktsts:4;
+#define DWC_GRXSTS_PKTSTS_IN			0x2
+#define DWC_GRXSTS_PKTSTS_IN_XFER_COMP		0x3
+#define DWC_GRXSTS_PKTSTS_DATA_TOGGLE_ERR	0x5
+#define DWC_GRXSTS_PKTSTS_CH_HALTED		0x7
+
+		unsigned reserved:11;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the FIFO Size Registers (HPTXFSIZ,
+ * GNPTXFSIZ, DPTXFSIZn, DIEPTXFn). Read the register into the d32 element then
+ * read out the bits using the bit elements.
+ */
+union fifosize_data {
+	u32 d32;
+	struct {
+		unsigned startaddr:16;
+		unsigned depth:16;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Non-Periodic Transmit FIFO/Queue
+ * Status Register (GNPTXSTS). Read the register into the d32 element then read
+ * out the bits using the bit elements.
+ */
+union gnptxsts_data {
+	u32 d32;
+	struct {
+		unsigned nptxfspcavail:16;
+		unsigned nptxqspcavail:8;
+		/*
+		 * Top of the Non-Periodic Transmit Request Queue
+		 *	- bit 24 - Terminate (Last entry for the selected
+		 *	  channel/EP)
+		 *	- bits 26:25 - Token Type
+		 *	  - 2'b00 - IN/OUT
+		 *	  - 2'b01 - Zero Length OUT
+		 *	  - 2'b10 - PING/Complete Split
+		 *	  - 2'b11 - Channel Halt
+		 *	- bits 30:27 - Channel/EP Number
+		 */
+		unsigned nptxqtop_terminate:1;
+		unsigned nptxqtop_token:2;
+		unsigned nptxqtop_chnep:4;
+		unsigned reserved:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Transmit	FIFO Status Register
+ * (DTXFSTS). Read the register into the d32 element then read out the bits
+ * using the bit elements.
+ */
+union dtxfsts_data {
+	u32 d32;
+	struct {
+		unsigned txfspcavail:16;
+		unsigned reserved:16;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the I2C Control Register (I2CCTL).
+ * Read the register into the d32 element then read out the bits using the bit
+ * elements.
+ */
+union gi2cctl_data {
+	u32 d32;
+	struct {
+		unsigned rwdata:8;
+		unsigned regaddr:8;
+		unsigned addr:7;
+		unsigned i2cen:1;
+		unsigned ack:1;
+		unsigned i2csuspctl:1;
+		unsigned i2cdevaddr:2;
+		unsigned reserved:2;
+		unsigned rw:1;
+		unsigned bsydne:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the User HW Config1 Register.  Read
+ * the register into the d32 element then read out the bits using the bit
+ * elements.
+ */
+union hwcfg1_data {
+	u32 d32;
+	struct {
+		unsigned ep_dir0:2;
+		unsigned ep_dir1:2;
+		unsigned ep_dir2:2;
+		unsigned ep_dir3:2;
+		unsigned ep_dir4:2;
+		unsigned ep_dir5:2;
+		unsigned ep_dir6:2;
+		unsigned ep_dir7:2;
+		unsigned ep_dir8:2;
+		unsigned ep_dir9:2;
+		unsigned ep_dir10:2;
+		unsigned ep_dir11:2;
+		unsigned ep_dir12:2;
+		unsigned ep_dir13:2;
+		unsigned ep_dir14:2;
+		unsigned ep_dir15:2;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the User HW Config2 Register.  Read
+ * the register into the d32 element then read out the bits using the bit
+ * elements.
+ */
+union hwcfg2_data {
+	u32 d32;
+	struct {
+		/* GHWCFG2 */
+		unsigned op_mode:3;
+#define DWC_HWCFG2_OP_MODE_HNP_SRP_CAPABLE_OTG		0
+#define DWC_HWCFG2_OP_MODE_SRP_ONLY_CAPABLE_OTG		1
+#define DWC_HWCFG2_OP_MODE_NO_HNP_SRP_CAPABLE_OTG	2
+#define DWC_HWCFG2_OP_MODE_SRP_CAPABLE_DEVICE		3
+#define DWC_HWCFG2_OP_MODE_NO_SRP_CAPABLE_DEVICE	4
+#define DWC_HWCFG2_OP_MODE_SRP_CAPABLE_HOST		5
+#define DWC_HWCFG2_OP_MODE_NO_SRP_CAPABLE_HOST		6
+
+		unsigned architecture:2;
+		unsigned point2point:1;
+		unsigned hs_phy_type:2;
+#define DWC_HWCFG2_HS_PHY_TYPE_NOT_SUPPORTED		0
+#define DWC_HWCFG2_HS_PHY_TYPE_UTMI			1
+#define DWC_HWCFG2_HS_PHY_TYPE_ULPI			2
+#define DWC_HWCFG2_HS_PHY_TYPE_UTMI_ULPI		3
+
+		unsigned fs_phy_type:2;
+		unsigned num_dev_ep:4;
+		unsigned num_host_chan:4;
+		unsigned perio_ep_supported:1;
+		unsigned dynamic_fifo:1;
+		unsigned rx_status_q_depth:2;
+		unsigned nonperio_tx_q_depth:2;
+		unsigned host_perio_tx_q_depth:2;
+		unsigned dev_token_q_depth:5;
+		unsigned reserved31:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the User HW Config3 Register.  Read
+ * the register into the d32 element then read out the bits using the bit
+ * elements.
+ */
+union hwcfg3_data {
+	u32 d32;
+	struct {
+		/* GHWCFG3 */
+		unsigned xfer_size_cntr_width:4;
+		unsigned packet_size_cntr_width:3;
+		unsigned otg_func:1;
+		unsigned i2c:1;
+		unsigned vendor_ctrl_if:1;
+		unsigned optional_features:1;
+		unsigned synch_reset_type:1;
+		unsigned reserved15_12:4;
+		unsigned dfifo_depth:16;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the User HW Config4 Register.  Read
+ * the register into the d32 element then read out the bits using the bit
+ * elements.
+ */
+union hwcfg4_data {
+	u32 d32;
+	struct {
+		unsigned num_dev_perio_in_ep:4;
+		unsigned power_optimiz:1;
+		unsigned min_ahb_freq:9;
+		unsigned utmi_phy_data_width:2;
+		unsigned num_dev_mode_ctrl_ep:4;
+		unsigned iddig_filt_en:1;
+		unsigned vbus_valid_filt_en:1;
+		unsigned a_valid_filt_en:1;
+		unsigned b_valid_filt_en:1;
+		unsigned session_end_filt_en:1;
+		unsigned ded_fifo_en:1;
+		unsigned num_in_eps:4;
+		unsigned reserved31_30:2;
+	} b;
+};
+
+/*
+ * Device Global Registers. Offsets 800h-BFFh
+ *
+ * The following structures define the size and relative field offsets for the
+ * Device Mode Registers.
+ *
+ * These registers are visible only in Device mode and must not be accessed in
+ * Host mode, as the results are unknown.
+ */
+struct device_global_regs {
+	/* Device Configuration Register.			Offset 800h */
+	u32 dcfg;
+	/* Device Control Register.				Offset: 804h */
+	u32 dctl;
+	/* Device Status Register (Read Only).			Offset: 808h */
+	u32 dsts;
+	/* Reserved.						Offset: 80Ch */
+	u32 unused;
+	/* Device IN Endpoint Common Interrupt Mask Register.	Offset: 810h */
+	u32 diepmsk;
+	/* Device OUT Endpoint Common Interrupt MaskRegister.	Offset: 814h */
+	u32 doepmsk;
+	/* Device All Endpoints Interrupt Register.		Offset: 818h */
+	u32 daint;
+	/* Device All Endpoints Interrupt Mask Register.	Offset:	81Ch */
+	u32 daintmsk;
+	/* Device IN Token Queue Read Register-1 (Read Only).	Offset: 820h */
+	u32 dtknqr1;
+	/* Device IN Token Queue Read Register-2 (Read Only).	Offset: 824h */
+	u32 dtknqr2;
+	/* Device VBUS	 discharge Register.			Offset: 828h */
+	u32 dvbusdis;
+	/* Device VBUS Pulse Register.				Offset: 82Ch */
+	u32 dvbuspulse;
+	/*
+	 * Device IN Token Queue Read Register-3 (Read Only).
+	 * Device Thresholding control register (Read/Write)
+	 *							Offset: 830h
+	 */
+	u32 dtknqr3_dthrctl;
+	/*
+	 * Device IN Token Queue Read Register-4 (Read Only).
+	 * Device IN EPs empty Inr. Mask Register (Read/Write)
+	 *							Offset: 834h
+	 */
+	u32 dtknqr4_fifoemptymsk;
+};
+
+/*
+ * This union represents the bit fields in the Device Configuration Register.
+ * Read the register into the d32 member then  set/clear the bits using the bit
+ * elements.  Write the d32 member to the dcfg register.
+ */
+union dcfg_data {
+	u32 d32;
+	struct {
+		/* Device Speed */
+		unsigned devspd:2;
+		/* Non Zero Length Status OUT Handshake */
+		unsigned nzstsouthshk:1;
+#define DWC_DCFG_SEND_STALL			1
+
+		unsigned reserved3:1;
+		/* Device Addresses */
+		unsigned devaddr:7;
+		/* Periodic Frame Interval */
+		unsigned perfrint:2;
+#define DWC_DCFG_FRAME_INTERVAL_80		0
+#define DWC_DCFG_FRAME_INTERVAL_85		1
+#define DWC_DCFG_FRAME_INTERVAL_90		2
+#define DWC_DCFG_FRAME_INTERVAL_95		3
+
+		unsigned reserved13_17:5;
+		/* In Endpoint Mis-match count */
+		unsigned epmscnt:4;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device Control Register.  Read
+ * the register into the d32 member then set/clear the bits using the bit
+ * elements.
+ */
+union dctl_data {
+	u32 d32;
+	struct {
+		/* Remote Wakeup */
+		unsigned rmtwkupsig:1;
+		/* Soft Disconnect */
+		unsigned sftdiscon:1;
+		/* Global Non-Periodic IN NAK Status */
+		unsigned gnpinnaksts:1;
+		/* Global OUT NAK Status */
+		unsigned goutnaksts:1;
+		/* Test Control */
+		unsigned tstctl:3;
+		/* Set Global Non-Periodic IN NAK */
+		unsigned sgnpinnak:1;
+		/* Clear Global Non-Periodic IN NAK */
+		unsigned cgnpinnak:1;
+		/* Set Global OUT NAK */
+		unsigned sgoutnak:1;
+		/* Clear Global OUT NAK */
+		unsigned cgoutnak:1;
+		unsigned reserved:21;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device Status Register.  Read the
+ * register into the d32 member then set/clear the bits using the bit elements.
+ */
+union dsts_data	{
+	u32 d32;
+	struct {
+		/* Suspend Status */
+		unsigned suspsts:1;
+		/* Enumerated Speed */
+		unsigned enumspd:2;
+#define DWC_DSTS_ENUMSPD_HS_PHY_30MHZ_OR_60MHZ		0
+#define DWC_DSTS_ENUMSPD_FS_PHY_30MHZ_OR_60MHZ		1
+#define DWC_DSTS_ENUMSPD_LS_PHY_6MHZ			2
+#define DWC_DSTS_ENUMSPD_FS_PHY_48MHZ			3
+
+		/* Erratic Error */
+		unsigned errticerr:1;
+		unsigned reserved4_7:4;
+		/* Frame or Microframe Number of the received SOF */
+		unsigned soffn:14;
+		unsigned reserved22_31:10;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device IN EP Interrupt Register
+ * and the Device IN EP Common Mask Register. Read the register into the d32
+ * member then set/clear the bits using the bit elements.
+ */
+union diepint_data {
+	u32 d32;
+	struct {
+		/* Transfer complete mask */
+		unsigned xfercompl:1;
+		/* Endpoint disable mask */
+		unsigned epdisabled:1;
+		/* AHB Error mask */
+		unsigned ahberr:1;
+		/* TimeOUT Handshake mask (non-ISOC EPs) */
+		unsigned timeout:1;
+		/* IN Token received with TxF Empty mask */
+		unsigned intktxfemp:1;
+		/* IN Token Received with EP mismatch mask */
+		unsigned intknepmis:1;
+		/* IN Endpoint HAK Effective mask */
+		unsigned inepnakeff:1;
+		/* IN Endpoint HAK Effective mask */
+		unsigned emptyintr:1;
+		unsigned txfifoundrn:1;
+		unsigned reserved08_31:23;
+		} b;
+};
+
+/*
+ * This union represents the bit fields in the Device OUT EP Interrupt
+ * Registerand Device OUT EP Common Interrupt Mask Register.  Read the register
+ * into the d32 member then set/clear the  bits using the bit elements.
+ */
+union doepint_data {
+	u32 d32;
+	struct {
+		/* Transfer complete */
+		unsigned xfercompl:1;
+		/* Endpoint disable  */
+		unsigned epdisabled:1;
+		/* AHB Error */
+		unsigned ahberr:1;
+		/* Setup Phase Done (contorl EPs) */
+		unsigned setup:1;
+		unsigned reserved04_31:28;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device All EP Interrupt and Mask
+ * Registers.  Read the register into the d32 member then set/clear the bits
+ * using the bit elements.
+ */
+union daint_data {
+	u32 d32;
+	struct {
+		/* IN Endpoint bits */
+		unsigned in:16;
+		/* OUT Endpoint bits */
+		unsigned out:16;
+	} ep;
+	struct {
+		/* IN Endpoint bits */
+		unsigned inep0:1;
+		unsigned inep1:1;
+		unsigned inep2:1;
+		unsigned inep3:1;
+		unsigned inep4:1;
+		unsigned inep5:1;
+		unsigned inep6:1;
+		unsigned inep7:1;
+		unsigned inep8:1;
+		unsigned inep9:1;
+		unsigned inep10:1;
+		unsigned inep11:1;
+		unsigned inep12:1;
+		unsigned inep13:1;
+		unsigned inep14:1;
+		unsigned inep15:1;
+		/* OUT Endpoint bits */
+		unsigned outep0:1;
+		unsigned outep1:1;
+		unsigned outep2:1;
+		unsigned outep3:1;
+		unsigned outep4:1;
+		unsigned outep5:1;
+		unsigned outep6:1;
+		unsigned outep7:1;
+		unsigned outep8:1;
+		unsigned outep9:1;
+		unsigned outep10:1;
+		unsigned outep11:1;
+		unsigned outep12:1;
+		unsigned outep13:1;
+		unsigned outep14:1;
+		unsigned outep15:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device IN Token Queue Read
+ * Registers.  Read the register into the d32 member.  READ-ONLY Register
+ */
+union dtknq1_data {
+	u32 d32;
+	struct {
+		/* In Token Queue Write Pointer */
+		unsigned intknwptr:5;
+		/* Reserved */
+		unsigned reserved05_06:2;
+		/* write pointer has wrapped. */
+		unsigned wrap_bit:1;
+		/* EP Numbers of IN Tokens 0 ... 4 */
+		unsigned epnums0_5:24;
+	} b;
+};
+
+/*
+ * This union represents Threshold control Register Read and write the register
+ * into the d32 member.  READ-WRITABLE Register
+ */
+union dthrctl_data {
+	u32 d32;
+	struct {
+		/* non ISO Tx Thr. Enable */
+		unsigned non_iso_thr_en:1;
+		/* ISO Tx Thr. Enable */
+		unsigned iso_thr_en:1;
+		/* Tx Thr. Length */
+		unsigned tx_thr_len:9;
+		/* Reserved */
+		unsigned reserved11_15:5;
+		/* Rx Thr. Enable */
+		unsigned rx_thr_en:1;
+		/* Rx Thr. Length */
+		unsigned rx_thr_len:9;
+		/* Reserved */
+		unsigned reserved26_31:6;
+	} b;
+};
+
+/*
+ * Device Logical IN Endpoint-Specific Registers. Offsets 900h-AFCh
+ *
+ * There will be one set of endpoint registers per logical endpoint implemented.
+ *
+ * These registers are visible only in Device mode and must not be accessed in
+ * Host mode, as the results are unknown.
+ */
+struct device_in_ep_regs {
+	/*
+	 * Device IN Endpoint Control Register.
+	 * Offset: 900h + (ep_num * 20h) + 00h
+	 */
+	u32 diepctl;
+	/* Reserved. Offset:900h + (ep_num * 20h) + 04h */
+	u32 reserved04;
+	/*
+	 * Device IN Endpoint Interrupt Register.
+	 * Offset: 900h + (ep_num * 20h) + 08h
+	 */
+	u32 diepint;
+	/* Reserved. Offset:900h + (ep_num * 20h) + 0Ch */
+	u32 reserved0C;
+	/*
+	 * Device IN Endpoint Transfer Size Register.
+	 * Offset: 900h + (ep_num * 20h) + 10h
+	 */
+	u32 dieptsiz;
+	/*
+	 * Device IN Endpoint DMA Address Register.
+	 * Offset: 900h + (ep_num * 20h) + 14h
+	 */
+	u32 diepdma;
+	/*
+	 * Device IN Endpoint Transmit FIFO Status Register.
+	 * Offset: 900h + (ep_num * 20h) + 18h
+	 */
+	u32 dtxfsts;
+	/*
+	 * Reserved.
+	 * Offset: 900h + (ep_num * 20h) + 1Ch - 900h + (ep_num * 20h) + 1Ch
+	 */
+	u32 reserved18;
+};
+
+/*
+ * Device Logical OUT Endpoint-Specific Registers. Offsets: B00h-CFCh
+ *
+ * There will be one set of endpoint registers per logical endpoint implemented.
+ *
+ * These registers are visible only in Device mode and must not be accessed in
+ * Host mode, as the results are unknown.
+ */
+struct device_out_ep_regs {
+	/*
+	 * Device OUT Endpoint Control Register.
+	 * Offset: B00h + (ep_num * 20h) + 00h
+	 */
+	u32 doepctl;
+	/*
+	 * Device OUT Endpoint Frame number Register.
+	 * Offset: B00h + (ep_num * 20h) + 04h
+	 */
+	u32 doepfn;
+	/*
+	 * Device OUT Endpoint Interrupt Register.
+	 * Offset: B00h + (ep_num * 20h) + 08h
+	 */
+	u32 doepint;
+	/* Reserved. Offset:B00h + (ep_num * 20h) + 0Ch */
+	u32 reserved0C;
+	/*
+	 * Device OUT Endpoint Transfer Size Register.
+	 * Offset: B00h + (ep_num * 20h) + 10h
+	 */
+	u32 doeptsiz;
+	/*
+	 * Device OUT Endpoint DMA Address Register.
+	 * Offset: B00h + (ep_num * 20h) + 14h
+	 */
+	u32 doepdma;
+	/*
+	 * Reserved.
+	 * Offset:B00h + (ep_num * 20h) + 18h - B00h + (ep_num * 20h) + 1Ch
+	 */
+	u32 unused[2];
+};
+
+/*
+ * This union represents the bit fields in the Device EP Control Register.  Read
+ * the register into the d32 member then set/clear the bits using the bit
+ * elements.
+ */
+union depctl_data {
+	u32 d32;
+	struct {
+		/* Maximum Packet Size
+		 * IN/OUT EPn
+		 * IN/OUT EP0 - 2 bits
+		 *	 2'b00: 64 Bytes
+		 *	 2'b01: 32
+		 *	 2'b10: 16
+		 *	 2'b11: 8
+		 */
+		unsigned mps:11;
+#define DWC_DEP0CTL_MPS_64			0
+#define DWC_DEP0CTL_MPS_32			1
+#define DWC_DEP0CTL_MPS_16			2
+#define DWC_DEP0CTL_MPS_8			3
+
+		/*
+		 * Next Endpoint
+		 * IN EPn/IN EP0
+		 * OUT EPn/OUT EP0 - reserved
+		 */
+		unsigned nextep:4;
+		/* USB Active Endpoint */
+		unsigned usbactep:1;
+		/*
+		 * Endpoint DPID (INTR/Bulk IN and OUT endpoints) This field
+		 * contains the PID of the packet going to be received or
+		 * transmitted on this endpoint. The application should program
+		 * the PID of the first packet going to be received or
+		 * transmitted on this endpoint , after the endpoint is
+		 * activated. Application use the SetD1PID and SetD0PID fields
+		 * of this register to program either D0 or D1 PID.
+		 *
+		 * The encoding for this field is
+		 *	 - 0: D0
+		 *	 - 1: D1
+		 */
+		unsigned dpid:1;
+		/* NAK Status */
+		unsigned naksts:1;
+		/* Endpoint Type
+		 *	2'b00: Control
+		 *	2'b01: Isochronous
+		 *	2'b10: Bulk
+		 *	2'b11: Interrupt
+		 */
+		unsigned eptype:2;
+		/*
+		 * Snoop Mode
+		 * OUT EPn/OUT EP0
+		 * IN EPn/IN EP0 - reserved
+		 */
+		unsigned snp:1;
+		/* Stall Handshake */
+		unsigned stall:1;
+		/*
+		 * Tx Fifo Number
+		 * IN EPn/IN EP0
+		 * OUT EPn/OUT EP0 - reserved
+		 */
+		unsigned txfnum:4;
+		/* Clear NAK */
+		unsigned cnak:1;
+		/* Set NAK */
+		unsigned snak:1;
+		/*
+		 * Set DATA0 PID (INTR/Bulk IN and OUT endpoints)
+		 *
+		 * Writing to this field sets the Endpoint DPID (DPID) field in
+		 * this register to DATA0. Set Even (micro)frame (SetEvenFr)
+		 * (ISO IN and OUT Endpoints)
+		 *
+		 * Writing to this field sets the Even/Odd (micro)frame
+		 * (EO_FrNum) field to even (micro) frame.
+		 */
+		unsigned setd0pid:1;
+		/*
+		 * Set DATA1 PID (INTR/Bulk IN and OUT endpoints)
+		 *
+		 * Writing to this field sets the Endpoint DPID (DPID) field in
+		 * this register to DATA1 Set Odd (micro)frame (SetOddFr) (ISO
+		 * IN and OUT Endpoints)
+		 *
+		 * Writing to this field sets the Even/Odd (micro)frame
+		 * (EO_FrNum) field to odd (micro) frame.
+		 */
+		unsigned setd1pid:1;
+		/* Endpoint Disable */
+		unsigned epdis:1;
+		/* Endpoint Enable */
+		unsigned epena:1;
+		} b;
+};
+
+/*
+ * This union represents the bit fields in the Device EP Transfer Size Register.
+ * Read the register into the d32 member then set/clear the bits using the bit
+ * elements.
+ */
+union deptsiz_data {
+	u32 d32;
+	struct {
+		/* Transfer size */
+		unsigned xfersize:19;
+		/* Packet Count */
+		unsigned pktcnt:10;
+		/* Multi Count - Periodic IN endpoints */
+		unsigned mc:2;
+		unsigned reserved:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Device EP 0 Transfer Size
+ * Register.  Read the register into the d32 member then set/clear the bits
+ * using the bit elements.
+ */
+union deptsiz0_data {
+	u32 d32;
+	struct {
+		/* Transfer size */
+		unsigned xfersize:7;
+		/* Reserved */
+		unsigned reserved7_18:12;
+		/* Packet Count */
+		unsigned pktcnt:2;
+		/* Reserved */
+		unsigned reserved21_28:9;
+		/* Setup Packet Count (DOEPTSIZ0 Only) */
+		unsigned supcnt:2;
+		unsigned reserved31;
+	} b;
+};
+
+#define MAX_PERIO_FIFOS			15	/* Max periodic FIFOs */
+#define MAX_TX_FIFOS			15	/* Max non-periodic FIFOs */
+#define MAX_EPS_CHANNELS		4	/* Max Endpoints/HostChannels */
+
+/*
+ * The device_if structure contains information needed to manage the
+ * DWC_otg controller acting in device mode. It represents the programming view
+ * of the device-specific aspects of the controller.
+ */
+struct device_if {
+	/* Device Global Registers starting at offset 800h */
+	struct device_global_regs *dev_global_regs;
+#define DWC_DEV_GLOBAL_REG_OFFSET		0x800
+
+	/* Device Logical IN Endpoint-Specific Registers 900h-AFCh */
+	struct device_in_ep_regs *in_ep_regs[MAX_EPS_CHANNELS/2];
+#define DWC_DEV_IN_EP_REG_OFFSET		0x900
+#define DWC_EP_REG_OFFSET			0x20
+
+	/* Device Logical OUT Endpoint-Specific Registers B00h-CFCh */
+	struct device_out_ep_regs *out_ep_regs[MAX_EPS_CHANNELS/2];
+#define DWC_DEV_OUT_EP_REG_OFFSET		0xB00
+
+	/* Device Speed		0: Unknown, 1: LS, 2:FS, 3: HS */
+	u8 speed;
+	/* Number # of Tx EP range: 0-15 exept ep0 */
+	u8 num_in_eps;
+	/* Number # of Rx EP range: 0-15 exept ep0 */
+	u8 num_out_eps;
+
+	/* Size of periodic FIFOs (Bytes) */
+	u16 perio_tx_fifo_size[MAX_PERIO_FIFOS];
+
+	/* Size of Tx FIFOs (Bytes) */
+	u16 tx_fifo_size[MAX_TX_FIFOS];
+
+	/* Thresholding enable flags and length varaiables */
+	u16 rx_thr_en;
+	u16 iso_tx_thr_en;
+	u16 non_iso_tx_thr_en;
+	u16 rx_thr_length;
+	u16 tx_thr_length;
+};
+
+/*
+ * The Host Global Registers structure defines the size and relative
+ * field offsets for the Host Mode Global Registers.  Host Global
+ * Registers offsets 400h-7FFh.
+*/
+struct host_global_regs {
+	/* Host Configuration Register.   Offset: 400h */
+	u32 hcfg;
+	/* Host Frame Interval Register.	Offset: 404h */
+	u32 hfir;
+	/* Host Frame Number / Frame Remaining Register. Offset: 408h */
+	u32 hfnum;
+       /* Reserved.	Offset: 40Ch */
+	u32 reserved40C;
+	/* Host Periodic Transmit FIFO/ Queue Status Register. Offset: 410h */
+	u32 hptxsts;
+	/* Host All Channels Interrupt Register. Offset: 414h */
+	u32 haint;
+	/* Host All Channels Interrupt Mask Register. Offset: 418h */
+	u32 haintmsk;
+};
+
+/*
+ * This union represents the bit fields in the Host Configuration Register.
+ * Read the register into the d32 member then set/clear the bits using
+ * the bit elements. Write the d32 member to the hcfg register.
+ */
+union hcfg_data {
+	u32 d32;
+	struct {
+		/* FS/LS Phy Clock Select */
+		unsigned fslspclksel:2;
+#define DWC_HCFG_30_60_MHZ			0
+#define DWC_HCFG_48_MHZ				1
+#define DWC_HCFG_6_MHZ				2
+
+		/* FS/LS Only Support */
+		unsigned fslssupp:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Host Frame Remaing/Number
+ * Register.
+ */
+union hfir_data {
+	u32 d32;
+	struct {
+		unsigned frint:16;
+		unsigned reserved:16;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Host Frame Remaing/Number
+ * Register.
+ */
+union hfnum_data {
+	u32 d32;
+	struct {
+		unsigned frnum:16;
+#define DWC_HFNUM_MAX_FRNUM			0x3FFF
+		unsigned frrem:16;
+	} b;
+};
+
+union hptxsts_data {
+	u32 d32;
+	struct {
+		unsigned ptxfspcavail:16;
+		unsigned ptxqspcavail:8;
+		/*
+		 * Top of the Periodic Transmit Request Queue
+		 *	- bit 24 - Terminate (last entry of selected channel)
+		 *	- bits 26:25 - Token Type
+		 *	  - 2'b00 - Zero length
+		 *	  - 2'b01 - Ping
+		 *	  - 2'b10 - Disable
+		 *	- bits 30:27 - Channel Number
+		 *	- bit 31 - Odd/even microframe
+		 */
+		unsigned ptxqtop_terminate:1;
+		unsigned ptxqtop_token:2;
+		unsigned ptxqtop_chnum:4;
+		unsigned ptxqtop_odd:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Host Port Control and Status
+ * Register. Read the register into the d32 member then set/clear the bits using
+ * the bit elements. Write the d32 member to the hprt0 register.
+ */
+union hprt0_data {
+	u32 d32;
+	struct {
+		unsigned prtconnsts:1;
+		unsigned prtconndet:1;
+		unsigned prtena:1;
+		unsigned prtenchng:1;
+		unsigned prtovrcurract:1;
+		unsigned prtovrcurrchng:1;
+		unsigned prtres:1;
+		unsigned prtsusp:1;
+		unsigned prtrst:1;
+		unsigned reserved9:1;
+		unsigned prtlnsts:2;
+		unsigned prtpwr:1;
+		unsigned prttstctl:4;
+		unsigned prtspd:2;
+#define DWC_HPRT0_PRTSPD_HIGH_SPEED		0
+#define DWC_HPRT0_PRTSPD_FULL_SPEED		1
+#define DWC_HPRT0_PRTSPD_LOW_SPEED		2
+		unsigned reserved19_31:13;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Host All Interrupt Register.
+ */
+union haint_data {
+	u32 d32;
+	struct {
+		unsigned ch0:1;
+		unsigned ch1:1;
+		unsigned ch2:1;
+		unsigned ch3:1;
+		unsigned ch4:1;
+		unsigned ch5:1;
+		unsigned ch6:1;
+		unsigned ch7:1;
+		unsigned ch8:1;
+		unsigned ch9:1;
+		unsigned ch10:1;
+		unsigned ch11:1;
+		unsigned ch12:1;
+		unsigned ch13:1;
+		unsigned ch14:1;
+		unsigned ch15:1;
+		unsigned reserved:16;
+	} b;
+
+	struct {
+		unsigned chint:16;
+		unsigned reserved:16;
+	} b2;
+};
+
+/*
+ * This union represents the bit fields in the Host All Interrupt Register.
+ */
+union haintmsk_data {
+	u32 d32;
+	struct {
+		unsigned ch0:1;
+		unsigned ch1:1;
+		unsigned ch2:1;
+		unsigned ch3:1;
+		unsigned ch4:1;
+		unsigned ch5:1;
+		unsigned ch6:1;
+		unsigned ch7:1;
+		unsigned ch8:1;
+		unsigned ch9:1;
+		unsigned ch10:1;
+		unsigned ch11:1;
+		unsigned ch12:1;
+		unsigned ch13:1;
+		unsigned ch14:1;
+		unsigned ch15:1;
+		unsigned reserved:16;
+	} b;
+
+	struct {
+		unsigned chint:16;
+		unsigned reserved:16;
+	} b2;
+};
+
+/*
+ * Host Channel Specific Registers. 500h-5FCh
+ */
+struct dwc_hc_regs {
+	/*
+	 * Host Channel 0 Characteristic Register.
+	 * Offset: 500h + (chan_num * 20h) + 00h
+	 */
+	u32 hcchar;
+	/*
+	 * Host Channel 0 Split Control Register.
+	 * Offset: 500h + (chan_num * 20h) + 04h
+	 */
+	u32 hcsplt;
+	/*
+	 * Host Channel 0 Interrupt Register.
+	 * Offset: 500h + (chan_num * 20h) + 08h
+	 */
+	u32 hcint;
+	/*
+	 * Host Channel 0 Interrupt Mask Register.
+	 * Offset: 500h + (chan_num * 20h) + 0Ch
+	 */
+	u32 hcintmsk;
+	/*
+	 * Host Channel 0 Transfer Size Register.
+	 * Offset: 500h + (chan_num * 20h) + 10h
+	 */
+	u32 hctsiz;
+	/*
+	 * Host Channel 0 DMA Address Register.
+	 * Offset: 500h + (chan_num * 20h) + 14h
+	 */
+	u32 hcdma;
+	/* Reserved.
+	 * Offset: 500h + (chan_num * 20h) + 18h - 500h + (chan_num * 20h) + 1Ch
+	 */
+	u32 reserved[2];
+};
+
+/*
+ * This union represents the bit fields in the Host Channel Characteristics
+ * Register. Read the register into the d32 member then set/clear the bits using
+ * the bit elements. Write the d32 member to the hcchar register.
+ */
+union hcchar_data {
+	u32 d32;
+	struct {
+		/* Maximum packet size in bytes */
+		unsigned mps:11;
+		/* Endpoint number */
+		unsigned epnum:4;
+		/* 0: OUT, 1: IN */
+		unsigned epdir:1;
+		unsigned reserved:1;
+		/* 0: Full/high speed device, 1: Low speed device */
+		unsigned lspddev:1;
+		/* 0: Control, 1: Isoc, 2: Bulk, 3: Intr */
+		unsigned eptype:2;
+		/* Packets per frame for periodic transfers. 0 is reserved. */
+		unsigned multicnt:2;
+		/* Device address */
+		unsigned devaddr:7;
+		/*
+		 * Frame to transmit periodic transaction.
+		 * 0: even, 1: odd
+		 */
+		unsigned oddfrm:1;
+		/* Channel disable */
+		unsigned chdis:1;
+		/* Channel enable */
+		unsigned chen:1;
+	} b;
+};
+
+union hcsplt_data {
+	u32 d32;
+	struct {
+		/* Port Address */
+		unsigned prtaddr:7;
+		/* Hub Address */
+		unsigned hubaddr:7;
+		/* Transaction Position */
+		unsigned xactpos:2;
+#define DWC_HCSPLIT_XACTPOS_MID			0
+#define DWC_HCSPLIT_XACTPOS_END			1
+#define DWC_HCSPLIT_XACTPOS_BEGIN		2
+#define DWC_HCSPLIT_XACTPOS_ALL			3
+
+		/* Do Complete Split */
+		unsigned compsplt:1;
+		/* Reserved */
+		unsigned reserved:14;
+		/* Split Enble */
+		unsigned spltena:1;
+	} b;
+};
+
+
+/*
+ * This union represents the bit fields in the Host All Interrupt Register.
+ */
+union hcint_data {
+	u32 d32;
+	struct {
+		/* Transfer Complete */
+		unsigned xfercomp:1;
+		/* Channel Halted */
+		unsigned chhltd:1;
+		/* AHB Error */
+		unsigned ahberr:1;
+		/* STALL Response Received */
+		unsigned stall:1;
+		/* NAK Response Received */
+		unsigned nak:1;
+		/* ACK Response Received */
+		unsigned ack:1;
+		/* NYET Response Received */
+		unsigned nyet:1;
+		/* Transaction Err */
+		unsigned xacterr:1;
+		/* Babble Error */
+		unsigned bblerr:1;
+		/* Frame Overrun */
+		unsigned frmovrun:1;
+		/* Data Toggle Error */
+		unsigned datatglerr:1;
+		/* Reserved */
+		unsigned reserved:21;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Host Channel Transfer Size
+ * Register. Read the register into the d32 member then set/clear the bits using
+ * the bit elements. Write the d32 member to the hcchar register.
+ */
+union hctsiz_data {
+	u32 d32;
+	struct {
+		/* Total transfer size in bytes */
+		unsigned xfersize:19;
+		/* Data packets to transfer */
+		unsigned pktcnt:10;
+		/*
+		 * Packet ID for next data packet
+		 * 0: DATA0
+		 * 1: DATA2
+		 * 2: DATA1
+		 * 3: MDATA (non-Control), SETUP (Control)
+		 */
+		unsigned pid:2;
+#define DWC_HCTSIZ_DATA0			0
+#define DWC_HCTSIZ_DATA1			2
+#define DWC_HCTSIZ_DATA2			1
+#define DWC_HCTSIZ_MDATA			3
+#define DWC_HCTSIZ_SETUP			3
+
+		/* Do PING protocol when 1 */
+		unsigned dopng:1;
+	} b;
+};
+
+/*
+ * This union represents the bit fields in the Host Channel Interrupt Mask
+ * Register. Read the register into the d32 member then set/clear the bits using
+ * the bit elements. Write the d32 member to the hcintmsk register.
+ */
+union hcintmsk_data {
+	u32 d32;
+	struct {
+		unsigned xfercompl:1;
+		unsigned chhltd:1;
+		unsigned ahberr:1;
+		unsigned stall:1;
+		unsigned nak:1;
+		unsigned ack:1;
+		unsigned nyet:1;
+		unsigned xacterr:1;
+		unsigned bblerr:1;
+		unsigned frmovrun:1;
+		unsigned datatglerr:1;
+		unsigned reserved:21;
+	} b;
+};
+
+/* OTG Host Interface Structure.
+ *
+ * The OTG Host Interface Structure structure contains information needed to
+ * manage the DWC_otg controller acting in host mode. It represents the
+ * programming view of the host-specific aspects of the controller.
+ */
+struct dwc_host_if {
+	/* Host Global Registers starting at offset 400h.*/
+	struct host_global_regs *host_global_regs;
+#define DWC_OTG_HOST_GLOBAL_REG_OFFSET			0x400
+
+	/* Host Port 0 Control and Status Register */
+	u32 *hprt0;
+#define DWC_OTG_HOST_PORT_REGS_OFFSET			0x440
+
+	/* Host Channel Specific Registers at offsets 500h-5FCh. */
+	struct dwc_hc_regs *hc_regs[MAX_EPS_CHANNELS];
+#define DWC_OTG_HOST_CHAN_REGS_OFFSET			0x500
+#define DWC_OTG_CHAN_REGS_OFFSET			0x20
+
+	/* Host configuration information */
+	/* Number of Host Channels (range: 1-16) */
+	u8 num_host_channels;
+	/* Periodic EPs supported (0: no, 1: yes) */
+	u8 perio_eps_supported;
+	/* Periodic Tx FIFO Size (Only 1 host periodic Tx FIFO) */
+	u16 perio_tx_fifo_size;
+};
+
+/*
+ * This union represents the bit fields in the Power and Clock Gating Control
+ * Register. Read the register into the d32 member then set/clear the bits using
+ * the bit elements.
+ */
+union pcgcctl_data {
+	u32 d32;
+	struct {
+		/* Stop Pclk */
+		unsigned stoppclk:1;
+		/* Gate Hclk */
+		unsigned gatehclk:1;
+		/* Power Clamp */
+		unsigned pwrclmp:1;
+		/* Reset Power Down Modules */
+		unsigned rstpdwnmodule:1;
+		/* PHY Suspended */
+		unsigned physuspended:1;
+		unsigned reserved:27;
+	} b;
+};
+#endif /* CONFIG_DWC_OTG_REG_LE */
+#endif
-- 
1.7.1
