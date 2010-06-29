Return-Path: <fchen@apm.com>
Received: from denmail01.apm.COM (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0981D1008D3
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 08:22:27 +1000 (EST)
From: Fushen Chen <fchen@apm.com>
To: linux-usb@vger.kernel.org
Subject: [PATCH 1/9] Add Synopsys DesignWare HS USB OTG Controller driver.
Date: Tue, 29 Jun 2010 14:26:54 -0700
Message-Id: <12778468223309-git-send-email-fchen@apm.com>
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

The DWC OTG driver module provides the initialization and cleanup
entry points for the DWC OTG USB driver.

Signed-off-by: Fushen Chen <fchen@apm.com>
Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
---
 arch/powerpc/boot/dts/kilauea.dts |   15 +
 drivers/usb/gadget/Kconfig        |    8 +-
 drivers/usb/gadget/gadget_chips.h |    7 +
 drivers/usb/otg/Kconfig           |   87 +++
 drivers/usb/otg/Makefile          |   10 +
 drivers/usb/otg/dwc_otg_driver.c  | 1236 +++++++++++++++++++++++++++++++++++++
 drivers/usb/otg/dwc_otg_driver.h  |   97 +++
 7 files changed, 1457 insertions(+), 3 deletions(-)
 create mode 100644 drivers/usb/otg/dwc_otg_driver.c
 create mode 100644 drivers/usb/otg/dwc_otg_driver.h

diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilauea.dts
index 083e68e..1a141b8 100644
--- a/arch/powerpc/boot/dts/kilauea.dts
+++ b/arch/powerpc/boot/dts/kilauea.dts
@@ -394,5 +394,20 @@
 				0x0 0x0 0x0 0x3 &UIC2 0xd 0x4 /* swizzled int C */
 				0x0 0x0 0x0 0x4 &UIC2 0xe 0x4 /* swizzled int D */>;
 		};
+
+		USBOTG0: usbotg@ef6c0000 {
+			compatible = "amcc,dwc-otg";
+			reg = <0xef6c0000 0x10000>;
+			interrupt-parent = <&USBOTG0>;
+			interrupts = <0x0 0x1 0x2>;
+			#interrupt-cells = <0x1>;
+			#address-cells = <0x0>;
+			#size-cells = <0x0>;
+			interrupt-map = <
+				0x0 &UIC2 0x1e 0x4 /* USB-OTG */
+				0x1 &UIC1 0x1a 0x8 /* HIGH-POWER */
+				0x2 &UIC0 0xc 0x4  /* DMA */ >;
+			interrupt-map-mask = <0xffffffff>;
+		};
 	};
 };
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 591ae9f..130626a 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -109,8 +109,8 @@ config	USB_GADGET_SELECTED
 #   - discrete ones (including all PCI-only controllers)
 #   - debug/dummy gadget+hcd is last.
 #
-choice
-	prompt "USB Peripheral Controller"
+menuconfig USB_PERIPHERAL_CONTROLLER
+	bool "USB Peripheral Controller"
 	depends on USB_GADGET
 	help
 	   A USB device uses a controller to talk to its host.
@@ -122,6 +122,8 @@ choice
 # Integrated controllers
 #
 
+if USB_PERIPHERAL_CONTROLLER
+
 config USB_GADGET_AT91
 	boolean "Atmel AT91 USB Device Port"
 	depends on ARCH_AT91 && !ARCH_AT91SAM9RL && !ARCH_AT91CAP9 && !ARCH_AT91SAM9G45
@@ -542,7 +544,7 @@ config USB_DUMMY_HCD
 # NOTE:  Please keep dummy_hcd LAST so that "real hardware" appears
 # first and will be selected by default.
 
-endchoice
+endif # USB_PERIPHERAL_CONTROLLER
 
 config USB_GADGET_DUALSPEED
 	bool
diff --git a/drivers/usb/gadget/gadget_chips.h b/drivers/usb/gadget/gadget_chips.h
index e511fec..3d5c136 100644
--- a/drivers/usb/gadget/gadget_chips.h
+++ b/drivers/usb/gadget/gadget_chips.h
@@ -142,6 +142,11 @@
 #define gadget_is_s3c_hsotg(g)    0
 #endif
 
+#if defined(CONFIG_USB_DWC_OTG) || defined(CONFIG_DWC_DEVICE_ONLY)
+#define	gadget_is_dwc_otg_pcd(g)	(!strcmp("dwc_otg_pcd", (g)->name))
+#else
+#define	gadget_is_dwc_otg_pcd(g)	0
+#endif
 
 /**
  * usb_gadget_controller_number - support bcdDevice id convention
@@ -200,6 +205,8 @@ static inline int usb_gadget_controller_number(struct usb_gadget *gadget)
 		return 0x25;
 	else if (gadget_is_s3c_hsotg(gadget))
 		return 0x26;
+	else if (gadget_is_dwc_otg_pcd(gadget))
+		return 0x27;
 	return -ENOENT;
 }
 
diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index 3d2d3e5..745bac2 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -69,4 +69,91 @@ config NOP_USB_XCEIV
 	 built-in with usb ip or which are autonomous and doesn't require any
 	 phy programming such as ISP1x04 etc.
 
+config USB_DWC_OTG
+	depends on (USB || USB_GADGET)
+	depends on 405EZ || 405EX || 460EX
+	select USB_OTG_UTILS
+	tristate "Synopsys DWC OTG Controller"
+	default USB_GADGET
+	help
+	  This driver provides USB Device Controller support for the
+	  Synopsys DesignWare USB OTG Core used on the AMCC 405EZ/405EX/
+	  460EX.
+
+	  Note that on the 405EZ, this Core provides USB Device Controller
+	  function only.  It does not act as a true OTG device, and the
+	  'OTG' is slightly misleading.
+
+config DWC_LEGACY_405EX
+	bool "Enable 405EX Legacy Support (lower performance)"
+	default n
+	depends on USB_DWC_OTG && 405EX
+	select DWC_SLAVE
+	help
+	  Enable Legacy 405EX Chip support (Rev 1.0) where DWC DMA is broken
+	  Selecting this option will cause lower performance
+	  Don't select this unless you want to support Rev 1.0 405EX chips (obsolete)
+
+config DWC_DEBUG
+	bool "Enable DWC Debugging"
+	depends on USB_DWC_OTG
+	default n
+	help
+	 Enable DWC driver debugging
+
+choice
+	prompt "DWC Mode Selection"
+	depends on USB_DWC_OTG
+	default DWC_OTG_MODE
+	help
+	  Select the DWC Core in OTG, Host only, or Device only mode
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
+choice
+	prompt "DWC DMA/SlaveMode Selection"
+	depends on USB_DWC_OTG
+	default DWC_DMA_MODE
+	help
+	  Select the DWC DMA or Slave Mode
+	  DMA mode uses the DWC DMA engines
+	  Slave mode uses the processor to tranfer data
+	  In Slave mode, processor DMA channels can be used if available
+
+config DWC_SLAVE
+	bool "DWC Slave Mode" if 405EX || 460EX
+
+config DWC_DMA_MODE
+	bool "DWC DMA Mode" if 405EX || (460EX && (!USB_EHCI_HCD  || !USB_OHCI_HCD))
+
+endchoice
+
+config DWC_OTG_REG_LE
+	depends on USB_DWC_OTG
+	bool "DWC Big Endian Register" if 405EX || 460EX
+	default y
+
+config DWC_OTG_FIFO_LE
+	depends on USB_DWC_OTG
+	bool "DWC FIFO Little Endian" if 405EZ
+	default n
+
+config DWC_LIMITED_XFER_SIZE
+	depends on USB_DWC_OTG
+	bool "DWC Endpoint Limited Xfer Size" if 405EZ
+	default n
+
+
+
 endif # USB || OTG
diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
index aeb49a8..d5dc51f 100644
--- a/drivers/usb/otg/Makefile
+++ b/drivers/usb/otg/Makefile
@@ -15,3 +15,13 @@ obj-$(CONFIG_USB_ULPI)		+= ulpi.o
 ccflags-$(CONFIG_USB_DEBUG)	+= -DDEBUG
 ccflags-$(CONFIG_USB_GADGET_DEBUG) += -DDEBUG
 
+obj-$(CONFIG_USB_DWC_OTG)	+= dwc_otg.o
+
+dwc_otg-objs := dwc_otg_driver.o dwc_otg_cil.o dwc_otg_cil_intr.o
+ifneq ($(CONFIG_DWC_DEVICE_ONLY),y)
+dwc_otg-objs += dwc_otg_hcd.o dwc_otg_hcd_intr.o \
+		dwc_otg_hcd_queue.o
+endif
+ifneq ($(CONFIG_DWC_HOST_ONLY),y)
+dwc_otg-objs += dwc_otg_pcd.o dwc_otg_pcd_intr.o
+endif
diff --git a/drivers/usb/otg/dwc_otg_driver.c b/drivers/usb/otg/dwc_otg_driver.c
new file mode 100644
index 0000000..fe022fd
--- /dev/null
+++ b/drivers/usb/otg/dwc_otg_driver.c
@@ -0,0 +1,1236 @@
+/*
+ * DesignWare HS OTG controller driver
+ *
+ * Author: Mark Miesfeld <mmiesfeld@apm.com>
+ *
+ * Based on versions provided by AMCC and Synopsis which are:
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
+/*
+ * The dwc_otg_driver module provides the initialization and cleanup entry
+ * points for the DWC_otg driver. This module will be dynamically installed
+ * after Linux is booted using the insmod command. When the module is
+ * installed, the dwc_otg_driver_init function is called. When the module is
+ * removed (using rmmod), the dwc_otg_driver_cleanup function is called.
+ *
+ * This module also defines a data structure for the dwc_otg_driver, which is
+ * used in conjunction with the standard device structure. These
+ * structures allow the OTG driver to comply with the standard Linux driver
+ * model in which devices and drivers are registered with a bus driver. This
+ * has the benefit that Linux can expose attributes of the driver and device
+ * in its special sysfs file system. Users can then read or write files in
+ * this file system to perform diagnostics on the driver components or the
+ * device.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/stat.h>	 /* permission constants */
+#include <linux/of_platform.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include "dwc_otg_driver.h"
+#include "dwc_otg_cil.h"
+#include "dwc_otg_pcd.h"
+#include "dwc_otg_hcd.h"
+
+#define DWC_DRIVER_VERSION		"1.0"
+#define DWC_DRIVER_DESC			"HS OTG USB Controller driver"
+static const char dwc_driver_name[] =	"dwc_otg";
+
+/*
+ * Encapsulate the module parameter settings
+ */
+static struct core_params dwc_otg_module_params = {
+	.opt = -1,
+	.otg_cap = -1,
+	.dma_enable = -1,
+	.dma_burst_size = -1,
+	.speed = -1,
+	.host_support_fs_ls_low_power = -1,
+	.host_ls_low_power_phy_clk = -1,
+	.enable_dynamic_fifo = -1,
+	.data_fifo_size = -1,
+	.dev_rx_fifo_size = -1,
+	.dev_nperio_tx_fifo_size = -1,
+	.dev_perio_tx_fifo_size = {
+		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
+	}, /* 15 */
+	.host_rx_fifo_size = -1,
+	.host_nperio_tx_fifo_size = -1,
+	.host_perio_tx_fifo_size = -1,
+	.max_transfer_size = -1,
+	.max_packet_count = -1,
+	.host_channels = -1,
+	.dev_endpoints = -1,
+	.phy_type = -1,
+	.phy_utmi_width = -1,
+	.phy_ulpi_ddr = -1,
+	.phy_ulpi_ext_vbus = -1,
+	.i2c_enable = -1,
+	.ulpi_fs_ls = -1,
+	.ts_dline = -1,
+	.en_multiple_tx_fifo = -1,
+	.dev_tx_fifo_size = {
+		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
+	}, /* 15 */
+	.thr_ctl = -1,
+	.tx_thr_length = -1,
+	.rx_thr_length = -1,
+};
+
+/* Global Debug Level Mask. */
+u32 g_dbg_lvl = 0x0;	/* OFF */
+
+/**
+ * Determines if the OTG capability parameter is valid under the current
+ * hardware configuration.
+ */
+static int is_valid_otg_cap(struct core_if *core_if)
+{
+	int valid = 1;
+
+	switch (dwc_otg_module_params.otg_cap) {
+	case DWC_OTG_CAP_PARAM_HNP_SRP_CAPABLE:
+		if (core_if->hwcfg2.b.op_mode !=
+				DWC_HWCFG2_OP_MODE_HNP_SRP_CAPABLE_OTG)
+			valid = 0;
+		break;
+	case DWC_OTG_CAP_PARAM_SRP_ONLY_CAPABLE:
+		if (core_if->hwcfg2.b.op_mode !=
+				DWC_HWCFG2_OP_MODE_HNP_SRP_CAPABLE_OTG &&
+				core_if->hwcfg2.b.op_mode !=
+				DWC_HWCFG2_OP_MODE_SRP_ONLY_CAPABLE_OTG &&
+				core_if->hwcfg2.b.op_mode !=
+				DWC_HWCFG2_OP_MODE_SRP_CAPABLE_DEVICE &&
+				core_if->hwcfg2.b.op_mode !=
+				DWC_HWCFG2_OP_MODE_SRP_CAPABLE_HOST)
+			valid = 0;
+		break;
+	case DWC_OTG_CAP_PARAM_NO_HNP_SRP_CAPABLE:
+		/* always valid */
+		break;
+	}
+	return valid;
+}
+
+/**
+ * Returns a valid OTG capability setting for the current hardware
+ * configuration.
+ */
+static int get_valid_otg_cap(struct core_if *core_if)
+{
+	if (core_if->hwcfg2.b.op_mode ==
+			DWC_HWCFG2_OP_MODE_HNP_SRP_CAPABLE_OTG ||
+			core_if->hwcfg2.b.op_mode ==
+			DWC_HWCFG2_OP_MODE_SRP_ONLY_CAPABLE_OTG ||
+			core_if->hwcfg2.b.op_mode ==
+			DWC_HWCFG2_OP_MODE_SRP_CAPABLE_DEVICE ||
+			core_if->hwcfg2.b.op_mode ==
+			DWC_HWCFG2_OP_MODE_SRP_CAPABLE_HOST)
+		return DWC_OTG_CAP_PARAM_SRP_ONLY_CAPABLE;
+	else
+		return DWC_OTG_CAP_PARAM_NO_HNP_SRP_CAPABLE;
+}
+
+/**
+ * Checks that, if the user set a periodic Tx FIFO size parameter, the size is
+ * within the valid range.  If not, the parameter is set to the default.
+ */
+static int chk_param_perio_tx_fifo_sizes(int retval)
+{
+	u32 *s = &dwc_otg_module_params.dev_perio_tx_fifo_size[0];
+	u32 i;
+
+	for (i = 0; i < MAX_PERIO_FIFOS; i++, s++) {
+		if (*s != -1 && (*s < 4 || *s > 768)) {
+			printk(KERN_ERR "`%d' invalid for parameter "
+				"`dev_perio_tx_fifo_size_%d'\n", *s, i);
+
+			*s = dwc_param_dev_perio_tx_fifo_size_default;
+			retval++;
+		}
+	}
+	return retval;
+}
+
+/**
+ * Checks that, if the user set a Tx FIFO size parameter, the size is within the
+ * valid range.  If not, the parameter is set to the default.
+ */
+static int chk_param_tx_fifo_sizes(int retval)
+{
+	u32 *s = &dwc_otg_module_params.dev_tx_fifo_size[0];
+	u32 i;
+
+	for (i = 0; i < MAX_TX_FIFOS; i++, s++) {
+		if (*s != -1 && (*s < 4 || *s > 768)) {
+			printk(KERN_ERR "`%d' invalid for parameter "
+				"`dev_perio_tx_fifo_size_%d'\n", *s, i);
+
+			*s = dwc_param_dev_tx_fifo_size_default;
+			retval++;
+		}
+	}
+	return retval;
+}
+
+/**
+ * Checks that parameter settings for the periodic Tx FIFO sizes are correct
+ * according to the hardware configuration. Sets the size to the hardware
+ * configuration if an incorrect size is detected.
+ */
+static int chk_valid_perio_tx_fifo_sizes(struct core_if *core_if, int retval)
+{
+	struct core_global_regs *regs = core_if->core_global_regs;
+	u32 *param_size = &dwc_otg_module_params.dev_perio_tx_fifo_size[0];
+	u32 i;
+
+	for (i = 0; i < MAX_PERIO_FIFOS; i++, param_size++) {
+		int changed = 1;
+		int error = 0;
+		u32 size;
+
+		if (*param_size == -1) {
+			changed = 0;
+			*param_size = dwc_param_dev_perio_tx_fifo_size_default;
+		}
+
+		size = dwc_read_reg32(&regs->dptxfsiz_dieptxf[i]);
+		if (*param_size > size) {
+			if (changed) {
+				printk(KERN_ERR "%d' invalid for parameter "
+					"`dev_perio_tx_fifo_size_%d'. Check HW "
+					"configuration.\n", *param_size, i);
+				error = 1;
+			}
+			*param_size = size;
+		}
+		retval += error;
+	}
+	return retval;
+}
+
+/**
+ * Checks that parameter settings for the Tx FIFO sizes are correct according to
+ * the hardware configuration.  Sets the size to the hardware configuration if
+ * an incorrect size is detected.
+ */
+static int chk_valid_tx_fifo_sizes(struct core_if *core_if, int retval)
+{
+	struct core_global_regs *regs = core_if->core_global_regs;
+	u32 *param_size = &dwc_otg_module_params.dev_tx_fifo_size[0];
+	u32 i;
+
+	for (i = 0; i < MAX_TX_FIFOS; i++, param_size) {
+		int changed = 1;
+		int error = 0;
+		u32 size;
+
+		if (*param_size == -1) {
+			changed = 0;
+			*param_size = dwc_param_dev_tx_fifo_size_default;
+		}
+
+		size = dwc_read_reg32(&regs->dptxfsiz_dieptxf[i]);
+		if (*param_size > size) {
+			if (changed) {
+				printk(KERN_ERR "%d' invalid for parameter "
+					"`dev_tx_fifo_size_%d'. Check HW "
+					"configuration.\n", *param_size, i);
+				error = 1;
+			}
+			*param_size = size;
+		}
+		retval += error;
+	}
+	return retval;
+}
+
+/**
+ * This function is called during module intialization to verify that
+ * the module parameters are in a valid state.
+ */
+static int __devinit check_parameters(struct core_if *core_if)
+{
+	int retval = 0;
+
+	/* Checks if the parameter is outside of its valid range of values */
+#define DWC_OTG_PARAM_TEST(_param_, _low_, _high_) \
+	((dwc_otg_module_params._param_ < (_low_)) || \
+	 (dwc_otg_module_params._param_ > (_high_)))
+
+	/*
+	 * If the parameter has been set by the user, check that the parameter
+	 * value is within the value range of values.  If not, report a module
+	 * error.
+	 */
+#define DWC_OTG_PARAM_ERR(_param_, _low_, _high_, _string_) \
+	do { \
+		if (dwc_otg_module_params._param_ != -1) { \
+			if (DWC_OTG_PARAM_TEST(_param_, (_low_), (_high_))) { \
+				printk(KERN_ERR "`%d' invalid for parameter " \
+						"`%s'\n", \
+						dwc_otg_module_params._param_, \
+						_string_); \
+				dwc_otg_module_params._param_ = \
+					dwc_param_##_param_##_default; \
+				retval++; \
+			} \
+		} \
+	} while (0)
+
+	DWC_OTG_PARAM_ERR(opt, 0, 1, "opt");
+	DWC_OTG_PARAM_ERR(otg_cap, 0, 2, "otg_cap");
+	DWC_OTG_PARAM_ERR(dma_enable, 0, 1, "dma_enable");
+	DWC_OTG_PARAM_ERR(speed, 0, 1, "speed");
+
+	DWC_OTG_PARAM_ERR(host_support_fs_ls_low_power, 0, 1,
+				"host_support_fs_ls_low_power");
+	DWC_OTG_PARAM_ERR(host_ls_low_power_phy_clk, 0, 1,
+				"host_ls_low_power_phy_clk");
+
+	DWC_OTG_PARAM_ERR(enable_dynamic_fifo, 0, 1, "enable_dynamic_fifo");
+	DWC_OTG_PARAM_ERR(data_fifo_size, 32, 32768, "data_fifo_size");
+	DWC_OTG_PARAM_ERR(dev_rx_fifo_size, 16, 32768, "dev_rx_fifo_size");
+	DWC_OTG_PARAM_ERR(dev_nperio_tx_fifo_size, 16, 32768,
+				"dev_nperio_tx_fifo_size");
+	DWC_OTG_PARAM_ERR(host_rx_fifo_size, 16, 32768, "host_rx_fifo_size");
+	DWC_OTG_PARAM_ERR(host_nperio_tx_fifo_size, 16, 32768,
+				"host_nperio_tx_fifo_size");
+	DWC_OTG_PARAM_ERR(host_perio_tx_fifo_size, 16, 32768,
+				"host_perio_tx_fifo_size");
+
+	DWC_OTG_PARAM_ERR(max_transfer_size, 2047, 524288,
+				"max_transfer_size");
+	DWC_OTG_PARAM_ERR(max_packet_count, 15, 511, "max_packet_count");
+
+	DWC_OTG_PARAM_ERR(host_channels, 1, 16, "host_channels");
+	DWC_OTG_PARAM_ERR(dev_endpoints, 1, 15, "dev_endpoints");
+
+	DWC_OTG_PARAM_ERR(phy_type, 0, 2, "phy_type");
+	DWC_OTG_PARAM_ERR(phy_ulpi_ddr, 0, 1, "phy_ulpi_ddr");
+	DWC_OTG_PARAM_ERR(phy_ulpi_ext_vbus, 0, 1, "phy_ulpi_ext_vbus");
+	DWC_OTG_PARAM_ERR(i2c_enable, 0, 1, "i2c_enable");
+	DWC_OTG_PARAM_ERR(ulpi_fs_ls, 0, 1, "ulpi_fs_ls");
+	DWC_OTG_PARAM_ERR(ts_dline, 0, 1, "ts_dline");
+
+	if (dwc_otg_module_params.dma_burst_size != -1) {
+		if (DWC_OTG_PARAM_TEST(dma_burst_size, 1, 1) &&
+				DWC_OTG_PARAM_TEST(dma_burst_size, 4, 4) &&
+				DWC_OTG_PARAM_TEST(dma_burst_size, 8, 8) &&
+				DWC_OTG_PARAM_TEST(dma_burst_size, 16, 16) &&
+				DWC_OTG_PARAM_TEST(dma_burst_size, 32, 32) &&
+				DWC_OTG_PARAM_TEST(dma_burst_size, 64, 64) &&
+				DWC_OTG_PARAM_TEST(dma_burst_size, 128, 128) &&
+				DWC_OTG_PARAM_TEST(dma_burst_size, 256, 256)) {
+			printk(KERN_ERR "`%d' invalid for parameter "
+					"`dma_burst_size'\n",
+					dwc_otg_module_params.dma_burst_size);
+			dwc_otg_module_params.dma_burst_size = 32;
+			retval++;
+		}
+	}
+
+	if (dwc_otg_module_params.phy_utmi_width != -1) {
+		if (DWC_OTG_PARAM_TEST(phy_utmi_width, 8, 8) &&
+				DWC_OTG_PARAM_TEST(phy_utmi_width, 16, 16)) {
+			printk(KERN_ERR "`%d'invalid for parameter "
+					"`phy_utmi_width'\n",
+					dwc_otg_module_params.phy_utmi_width);
+			dwc_otg_module_params.phy_utmi_width = 8;
+			retval++;
+		}
+	}
+
+	DWC_OTG_PARAM_ERR(en_multiple_tx_fifo, 0, 1, "en_multiple_tx_fifo");
+	retval += chk_param_perio_tx_fifo_sizes(retval);
+	retval += chk_param_tx_fifo_sizes(retval);
+
+	DWC_OTG_PARAM_ERR(thr_ctl, 0, 7, "thr_ctl");
+	DWC_OTG_PARAM_ERR(tx_thr_length, 8, 128, "tx_thr_length");
+	DWC_OTG_PARAM_ERR(rx_thr_length, 8, 128, "rx_thr_length");
+
+	/*
+	 * At this point, all module parameters that have been set by the user
+	 * are valid, and those that have not are left unset.  Now set their
+	 * default values and/or check the parameters against the hardware
+	 * configurations of the OTG core.
+	 */
+
+	/*
+	 * This sets the parameter to the default value if it has not been set
+	 * by the user
+	 */
+#define DWC_OTG_PARAM_SET_DEFAULT(_param_) ({ \
+		int changed = 1; \
+		if (dwc_otg_module_params._param_ == -1) { \
+			changed = 0; \
+			dwc_otg_module_params._param_ = \
+				dwc_param_##_param_##_default; \
+		} \
+		changed; \
+	 })
+
+	/*
+	 * This checks the macro against the hardware configuration to see if it
+	 * is valid.  It is possible that the default value could be invalid.
+	 * In this case, it will report a module error if the user touched the
+	 * parameter. Otherwise it will adjust the value without any error.
+	 */
+#define DWC_OTG_PARAM_CHECK_VALID(_param_, _str_, _is_valid_ , _set_valid_) ({ \
+		int changed = DWC_OTG_PARAM_SET_DEFAULT(_param_); \
+		int error = 0; \
+		if (!(_is_valid_)) { \
+			if (changed) { \
+				printk(KERN_ERR "`%d' invalid for parameter " \
+					"`%s' Check HW configuration.\n", \
+					dwc_otg_module_params._param_, \
+					_str_); \
+				error = 1; \
+			} \
+			dwc_otg_module_params._param_ = (_set_valid_); \
+		} \
+		error; \
+	})
+
+	/* OTG Cap */
+	retval += DWC_OTG_PARAM_CHECK_VALID(otg_cap, "otg_cap",
+			is_valid_otg_cap(core_if), get_valid_otg_cap(core_if));
+
+	retval += DWC_OTG_PARAM_CHECK_VALID(dma_enable, "dma_enable",
+			((dwc_otg_module_params.dma_enable == 1) &&
+			 (core_if->hwcfg2.b.architecture == 0)) ? 0 : 1, 0);
+	retval += DWC_OTG_PARAM_CHECK_VALID(opt, "opt", 1, 0);
+	DWC_OTG_PARAM_SET_DEFAULT(dma_burst_size);
+	retval += DWC_OTG_PARAM_CHECK_VALID(host_support_fs_ls_low_power,
+			"host_support_fs_ls_low_power", 1, 0);
+	retval += DWC_OTG_PARAM_CHECK_VALID(enable_dynamic_fifo,
+			"enable_dynamic_fifo",
+			((dwc_otg_module_params.enable_dynamic_fifo == 0) ||
+			 (core_if->hwcfg2.b.dynamic_fifo == 1)), 0);
+	retval += DWC_OTG_PARAM_CHECK_VALID(data_fifo_size, "data_fifo_size",
+			(dwc_otg_module_params.data_fifo_size <=
+			 core_if->hwcfg3.b.dfifo_depth),
+			core_if->hwcfg3.b.dfifo_depth);
+	retval += DWC_OTG_PARAM_CHECK_VALID(dev_rx_fifo_size,
+			"dev_rx_fifo_size",
+			(dwc_otg_module_params.dev_rx_fifo_size <=
+			 dwc_read_reg32(&core_if->core_global_regs->grxfsiz)),
+			dwc_read_reg32(&core_if->core_global_regs->grxfsiz));
+	retval += DWC_OTG_PARAM_CHECK_VALID(dev_nperio_tx_fifo_size,
+			"dev_nperio_tx_fifo_size",
+			(dwc_otg_module_params.dev_nperio_tx_fifo_size <=
+			(dwc_read_reg32(&core_if->core_global_regs->gnptxfsiz)
+				>> 16)),
+			(dwc_read_reg32(&core_if->core_global_regs->gnptxfsiz)
+				>> 16));
+	retval += DWC_OTG_PARAM_CHECK_VALID(host_rx_fifo_size,
+			"host_rx_fifo_size",
+			(dwc_otg_module_params.host_rx_fifo_size <=
+			dwc_read_reg32(&core_if->core_global_regs->grxfsiz)),
+			dwc_read_reg32(&core_if->core_global_regs->grxfsiz));
+	retval += DWC_OTG_PARAM_CHECK_VALID(host_nperio_tx_fifo_size,
+			"host_nperio_tx_fifo_size",
+			(dwc_otg_module_params.host_nperio_tx_fifo_size <=
+			(dwc_read_reg32(&core_if->core_global_regs->gnptxfsiz)
+					>> 16)),
+			(dwc_read_reg32(&core_if->core_global_regs->gnptxfsiz)
+					>> 16));
+	retval += DWC_OTG_PARAM_CHECK_VALID(host_perio_tx_fifo_size,
+			"host_perio_tx_fifo_size",
+			(dwc_otg_module_params.host_perio_tx_fifo_size <=
+			((dwc_read_reg32(&core_if->core_global_regs->hptxfsiz)
+					>> 16))),
+			((dwc_read_reg32(&core_if->core_global_regs->hptxfsiz)
+					>> 16)));
+	retval += DWC_OTG_PARAM_CHECK_VALID(max_transfer_size,
+			"max_transfer_size",
+			(dwc_otg_module_params.max_transfer_size <
+			(1 << (core_if->hwcfg3.b.xfer_size_cntr_width + 11))),
+			((1 << (core_if->hwcfg3.b.xfer_size_cntr_width + 11))
+					- 1));
+	retval += DWC_OTG_PARAM_CHECK_VALID(max_packet_count,
+			"max_packet_count",
+			(dwc_otg_module_params.max_packet_count <
+			(1 << (core_if->hwcfg3.b.packet_size_cntr_width + 4))),
+			((1 << (core_if->hwcfg3.b.packet_size_cntr_width + 4))
+					- 1));
+	retval += DWC_OTG_PARAM_CHECK_VALID(host_channels, "host_channels",
+			(dwc_otg_module_params.host_channels <=
+			(core_if->hwcfg2.b.num_host_chan + 1)),
+			(core_if->hwcfg2.b.num_host_chan + 1));
+	retval += DWC_OTG_PARAM_CHECK_VALID(dev_endpoints, "dev_endpoints",
+			(dwc_otg_module_params.dev_endpoints <=
+			(core_if->hwcfg2.b.num_dev_ep)),
+			core_if->hwcfg2.b.num_dev_ep);
+
+	retval += DWC_OTG_PARAM_CHECK_VALID(phy_type, "phy_type", 1, 0);
+	retval += DWC_OTG_PARAM_CHECK_VALID(speed, "speed",
+			(dwc_otg_module_params.speed == 0) &&
+			(dwc_otg_module_params.phy_type ==
+			 DWC_PHY_TYPE_PARAM_FS) ? 0 : 1,
+			dwc_otg_module_params.phy_type ==
+			DWC_PHY_TYPE_PARAM_FS ? 1 : 0);
+	retval += DWC_OTG_PARAM_CHECK_VALID(host_ls_low_power_phy_clk,
+			"host_ls_low_power_phy_clk",
+			((dwc_otg_module_params.host_ls_low_power_phy_clk ==
+			DWC_HOST_LS_LOW_POWER_PHY_CLK_PARAM_48MHZ) &&
+			(dwc_otg_module_params.phy_type ==
+				DWC_PHY_TYPE_PARAM_FS) ? 0 : 1),
+			((dwc_otg_module_params.phy_type ==
+				DWC_PHY_TYPE_PARAM_FS) ?
+				DWC_HOST_LS_LOW_POWER_PHY_CLK_PARAM_6MHZ :
+				DWC_HOST_LS_LOW_POWER_PHY_CLK_PARAM_48MHZ));
+
+	DWC_OTG_PARAM_SET_DEFAULT(phy_ulpi_ddr);
+	DWC_OTG_PARAM_SET_DEFAULT(phy_ulpi_ext_vbus);
+	DWC_OTG_PARAM_SET_DEFAULT(phy_utmi_width);
+	DWC_OTG_PARAM_SET_DEFAULT(ulpi_fs_ls);
+	DWC_OTG_PARAM_SET_DEFAULT(ts_dline);
+
+	retval += DWC_OTG_PARAM_CHECK_VALID(i2c_enable, "i2c_enable", 1, 0);
+
+	retval += DWC_OTG_PARAM_CHECK_VALID(en_multiple_tx_fifo,
+			"en_multiple_tx_fifo",
+			((dwc_otg_module_params.en_multiple_tx_fifo == 1) &&
+			(core_if->hwcfg4.b.ded_fifo_en == 0)) ? 0 : 1, 0);
+
+	retval += chk_valid_perio_tx_fifo_sizes(core_if, retval);
+	retval += chk_valid_tx_fifo_sizes(core_if, retval);
+
+	DWC_OTG_PARAM_SET_DEFAULT(thr_ctl);
+	DWC_OTG_PARAM_SET_DEFAULT(tx_thr_length);
+	DWC_OTG_PARAM_SET_DEFAULT(rx_thr_length);
+
+	return retval;
+}
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
+static struct core_if __devinit *dwc_otg_cil_init(const u32 *base,
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
+
+
+/**
+ * This function frees the structures allocated by dwc_otg_cil_init().
+ */
+static void dwc_otg_cil_remove(struct core_if *core_if)
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
+ * This function disables the controller's Global Interrupt in the AHB Config
+ * register.
+ */
+static void dwc_otg_disable_global_interrupts(struct core_if *core_if)
+{
+	union gahbcfg_data ahbcfg = {.d32 = 0};
+	ahbcfg.b.glblintrmsk = 1;
+	dwc_modify_reg32(&core_if->core_global_regs->gahbcfg, ahbcfg.d32, 0);
+}
+
+
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
+
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
+
+module_param_named(otg_cap, dwc_otg_module_params.otg_cap, int, 0444);
+MODULE_PARM_DESC(otg_cap, "OTG Capabilities 0=HNP&SRP 1=SRP Only 2=None");
+module_param_named(opt, dwc_otg_module_params.opt, int, 0444);
+MODULE_PARM_DESC(opt, "OPT Mode");
+module_param_named(dma_enable, dwc_otg_module_params.dma_enable, int, 0444);
+MODULE_PARM_DESC(dma_enable, "DMA Mode 0=Slave 1=DMA enabled");
+module_param_named(dma_burst_size, dwc_otg_module_params.dma_burst_size,
+			int, 0444);
+MODULE_PARM_DESC(dma_burst_size, "DMA Burst Size 1, 4, 8, 16, 32, 64, "
+				"128, 256");
+module_param_named(speed, dwc_otg_module_params.speed, int, 0444);
+MODULE_PARM_DESC(speed, "Speed 0=High Speed 1=Full Speed");
+module_param_named(host_support_fs_ls_low_power,
+			dwc_otg_module_params.host_support_fs_ls_low_power,
+			int, 0444);
+MODULE_PARM_DESC(host_support_fs_ls_low_power, "Support Low Power w/FS or LS "
+				"0=Support 1=Don't Support");
+module_param_named(host_ls_low_power_phy_clk,
+			dwc_otg_module_params.host_ls_low_power_phy_clk,
+			int, 0444);
+MODULE_PARM_DESC(host_ls_low_power_phy_clk, "Low Speed Low Power Clock "
+				"0=48Mhz 1=6Mhz");
+module_param_named(enable_dynamic_fifo,
+			dwc_otg_module_params.enable_dynamic_fifo, int, 0444);
+MODULE_PARM_DESC(enable_dynamic_fifo, "0=cC Setting 1=Allow Dynamic Sizing");
+module_param_named(data_fifo_size,
+			dwc_otg_module_params.data_fifo_size, int, 0444);
+MODULE_PARM_DESC(data_fifo_size, "Total number of words in the data FIFO "
+				"memory 32-32768");
+module_param_named(dev_rx_fifo_size, dwc_otg_module_params.dev_rx_fifo_size,
+			int, 0444);
+MODULE_PARM_DESC(dev_rx_fifo_size, "Number of words in the Rx FIFO 16-32768");
+module_param_named(dev_nperio_tx_fifo_size,
+			dwc_otg_module_params.dev_nperio_tx_fifo_size,
+			int, 0444);
+MODULE_PARM_DESC(dev_nperio_tx_fifo_size, "Number of words in the non-periodic "
+				"Tx FIFO 16-32768");
+module_param_named(dev_perio_tx_fifo_size_1,
+			dwc_otg_module_params.dev_perio_tx_fifo_size[0],
+			int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_1, "Number of words in the periodic "
+				"Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_2,
+			dwc_otg_module_params.dev_perio_tx_fifo_size[1],
+			int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_2, "Number of words in the periodic "
+				"Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_3,
+			dwc_otg_module_params.dev_perio_tx_fifo_size[2],
+			int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_3, "Number of words in the periodic "
+				"Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_4,
+			dwc_otg_module_params.dev_perio_tx_fifo_size[3],
+			int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_4, "Number of words in the periodic "
+				"Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_5,
+			dwc_otg_module_params.dev_perio_tx_fifo_size[4],
+			int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_5, "Number of words in the periodic "
+				"Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_6,
+			dwc_otg_module_params.dev_perio_tx_fifo_size[5],
+			int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_6, "Number of words in the periodic "
+				"Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_7,
+			dwc_otg_module_params.dev_perio_tx_fifo_size[6],
+			int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_7, "Number of words in the periodic "
+				"Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_8,
+			dwc_otg_module_params.dev_perio_tx_fifo_size[7],
+			int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_8, "Number of words in the periodic "
+				"Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_9,
+			dwc_otg_module_params.dev_perio_tx_fifo_size[8],
+			int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_9, "Number of words in the periodic "
+				"Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_10,
+			dwc_otg_module_params.dev_perio_tx_fifo_size[9],
+			int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_10, "Number of words in the periodic "
+				"Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_11,
+			dwc_otg_module_params.dev_perio_tx_fifo_size[10],
+			int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_11, "Number of words in the periodic "
+			"Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_12,
+			dwc_otg_module_params.dev_perio_tx_fifo_size[11],
+			int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_12, "Number of words in the periodic "
+			"Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_13,
+			dwc_otg_module_params.dev_perio_tx_fifo_size[12],
+			int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_13, "Number of words in the periodic "
+			"Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_14,
+			dwc_otg_module_params.dev_perio_tx_fifo_size[13],
+			int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_14, "Number of words in the periodic "
+			"Tx FIFO 4-768");
+module_param_named(dev_perio_tx_fifo_size_15,
+			dwc_otg_module_params.dev_perio_tx_fifo_size[14],
+			int, 0444);
+MODULE_PARM_DESC(dev_perio_tx_fifo_size_15, "Number of words in the periodic "
+			"Tx FIFO 4-768");
+module_param_named(host_rx_fifo_size, dwc_otg_module_params.host_rx_fifo_size,
+			int, 0444);
+MODULE_PARM_DESC(host_rx_fifo_size, "Number of words in the Rx FIFO 16-32768");
+module_param_named(host_nperio_tx_fifo_size,
+			dwc_otg_module_params.host_nperio_tx_fifo_size,
+			int, 0444);
+MODULE_PARM_DESC(host_nperio_tx_fifo_size, "Number of words in the "
+			"non-periodic Tx FIFO 16-32768");
+module_param_named(host_perio_tx_fifo_size,
+			dwc_otg_module_params.host_perio_tx_fifo_size,
+			int, 0444);
+MODULE_PARM_DESC(host_perio_tx_fifo_size, "Number of words in the host "
+			"periodic Tx FIFO 16-32768");
+module_param_named(max_transfer_size, dwc_otg_module_params.max_transfer_size,
+			int, 0444);
+
+MODULE_PARM_DESC(max_transfer_size, "The maximum transfer size supported in "
+			"bytes 2047-65535");
+module_param_named(max_packet_count, dwc_otg_module_params.max_packet_count,
+			int, 0444);
+MODULE_PARM_DESC(max_packet_count, "The maximum number of packets in a "
+			"transfer 15-511");
+module_param_named(host_channels, dwc_otg_module_params.host_channels,
+			int, 0444);
+MODULE_PARM_DESC(host_channels,	"The number of host channel registers to "
+			"use 1-16");
+module_param_named(dev_endpoints, dwc_otg_module_params.dev_endpoints,
+			int, 0444);
+MODULE_PARM_DESC(dev_endpoints,	"The number of endpoints in addition to EP0 "
+			"available for device mode 1-15");
+module_param_named(phy_type, dwc_otg_module_params.phy_type, int, 0444);
+MODULE_PARM_DESC(phy_type, "0=Reserved 1=UTMI+ 2=ULPI");
+module_param_named(phy_utmi_width, dwc_otg_module_params.phy_utmi_width,
+			int, 0444);
+MODULE_PARM_DESC(phy_utmi_width, "Specifies the UTMI+ Data Width 8 or 16 bits");
+module_param_named(phy_ulpi_ddr, dwc_otg_module_params.phy_ulpi_ddr,
+			int, 0444);
+MODULE_PARM_DESC(phy_ulpi_ddr, "0");
+module_param_named(phy_ulpi_ext_vbus, dwc_otg_module_params.phy_ulpi_ext_vbus,
+			int, 0444);
+MODULE_PARM_DESC(phy_ulpi_ext_vbus,
+		  "ULPI PHY using internal or external vbus 0=Internal");
+module_param_named(i2c_enable, dwc_otg_module_params.i2c_enable, int, 0444);
+MODULE_PARM_DESC(i2c_enable, "FS PHY Interface");
+module_param_named(ulpi_fs_ls, dwc_otg_module_params.ulpi_fs_ls, int, 0444);
+MODULE_PARM_DESC(ulpi_fs_ls, "ULPI PHY FS/LS mode only");
+module_param_named(ts_dline, dwc_otg_module_params.ts_dline, int, 0444);
+MODULE_PARM_DESC(ts_dline, "Term select Dline pulsing for all PHYs");
+module_param_named(debug, g_dbg_lvl, int, 0444);
+MODULE_PARM_DESC(debug, "0");
+module_param_named(en_multiple_tx_fifo,
+			dwc_otg_module_params.en_multiple_tx_fifo, int, 0444);
+MODULE_PARM_DESC(en_multiple_tx_fifo, "Dedicated Non Periodic Tx FIFOs "
+			"0=disabled 1=enabled");
+module_param_named(dev_tx_fifo_size_1,
+		    dwc_otg_module_params.dev_tx_fifo_size[0], int, 0444);
+MODULE_PARM_DESC(dev_tx_fifo_size_1, "Number of words in the Tx FIFO 4-768");
+module_param_named(dev_tx_fifo_size_2,
+			dwc_otg_module_params.dev_tx_fifo_size[1], int, 0444);
+MODULE_PARM_DESC(dev_tx_fifo_size_2, "Number of words in the Tx FIFO 4-768");
+module_param_named(dev_tx_fifo_size_3,
+			dwc_otg_module_params.dev_tx_fifo_size[2], int, 0444);
+MODULE_PARM_DESC(dev_tx_fifo_size_3, "Number of words in the Tx FIFO 4-768");
+module_param_named(dev_tx_fifo_size_4,
+			dwc_otg_module_params.dev_tx_fifo_size[3], int, 0444);
+MODULE_PARM_DESC(dev_tx_fifo_size_4, "Number of words in the Tx FIFO 4-768");
+module_param_named(dev_tx_fifo_size_5,
+			dwc_otg_module_params.dev_tx_fifo_size[4], int, 0444);
+MODULE_PARM_DESC(dev_tx_fifo_size_5, "Number of words in the Tx FIFO 4-768");
+module_param_named(dev_tx_fifo_size_6,
+			dwc_otg_module_params.dev_tx_fifo_size[5], int, 0444);
+MODULE_PARM_DESC(dev_tx_fifo_size_6, "Number of words in the Tx FIFO 4-768");
+module_param_named(dev_tx_fifo_size_7,
+			dwc_otg_module_params.dev_tx_fifo_size[6], int, 0444);
+MODULE_PARM_DESC(dev_tx_fifo_size_7, "Number of words in the Tx FIFO 4-768");
+module_param_named(dev_tx_fifo_size_8,
+			dwc_otg_module_params.dev_tx_fifo_size[7], int, 0444);
+MODULE_PARM_DESC(dev_tx_fifo_size_8, "Number of words in the Tx FIFO 4-768");
+module_param_named(dev_tx_fifo_size_9,
+			dwc_otg_module_params.dev_tx_fifo_size[8], int, 0444);
+MODULE_PARM_DESC(dev_tx_fifo_size_9, "Number of words in the Tx FIFO 4-768");
+module_param_named(dev_tx_fifo_size_10,
+			dwc_otg_module_params.dev_tx_fifo_size[9], int, 0444);
+MODULE_PARM_DESC(dev_tx_fifo_size_10, "Number of words in the Tx FIFO 4-768");
+module_param_named(dev_tx_fifo_size_11,
+			dwc_otg_module_params.dev_tx_fifo_size[10], int, 0444);
+MODULE_PARM_DESC(dev_tx_fifo_size_11, "Number of words in the Tx FIFO 4-768");
+module_param_named(dev_tx_fifo_size_12,
+			dwc_otg_module_params.dev_tx_fifo_size[11], int, 0444);
+MODULE_PARM_DESC(dev_tx_fifo_size_12, "Number of words in the Tx FIFO 4-768");
+module_param_named(dev_tx_fifo_size_13,
+			dwc_otg_module_params.dev_tx_fifo_size[12], int, 0444);
+MODULE_PARM_DESC(dev_tx_fifo_size_13, "Number of words in the Tx FIFO 4-768");
+module_param_named(dev_tx_fifo_size_14,
+			dwc_otg_module_params.dev_tx_fifo_size[13], int, 0444);
+MODULE_PARM_DESC(dev_tx_fifo_size_14, "Number of words in the Tx FIFO 4-768");
+module_param_named(dev_tx_fifo_size_15,
+			dwc_otg_module_params.dev_tx_fifo_size[14], int, 0444);
+MODULE_PARM_DESC(dev_tx_fifo_size_15, "Number of words in the Tx FIFO 4-768");
+module_param_named(thr_ctl, dwc_otg_module_params.thr_ctl, int, 0444);
+MODULE_PARM_DESC(thr_ctl, "Thresholding enable flag bit 0 - non ISO Tx thr., "
+			"1 - ISO Tx thr., 2 - Rx thr.- bit "
+			"0=disabled 1=enabled");
+module_param_named(tx_thr_length, dwc_otg_module_params.tx_thr_length,
+			int, 0444);
+MODULE_PARM_DESC(tx_thr_length, "Tx Threshold length in 32 bit DWORDs");
+module_param_named(rx_thr_length, dwc_otg_module_params.rx_thr_length,
+			int, 0444);
+MODULE_PARM_DESC(rx_thr_length, "Rx Threshold length in 32 bit DWORDs");
+
diff --git a/drivers/usb/otg/dwc_otg_driver.h b/drivers/usb/otg/dwc_otg_driver.h
new file mode 100644
index 0000000..2d7d759
--- /dev/null
+++ b/drivers/usb/otg/dwc_otg_driver.h
@@ -0,0 +1,97 @@
+/*
+ * DesignWare HS OTG controller driver
+ *
+ * Author: Mark Miesfeld <mmiesfeld@apm.com>
+ *
+ * Based on versions provided by AMCC and Synopsis which are:
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
+/* Type declarations */
+struct dwc_pcd;
+struct dwc_hcd;
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
+
+#endif
-- 
1.6.0.1
