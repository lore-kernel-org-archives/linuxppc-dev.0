Return-Path: <tmarri@amcc.com>
Received: from denmail01.apm.com (denmail01-v4020.amcc.com [192.195.68.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1E123B74A3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Oct 2011 09:09:22 +1100 (EST)
From: tmarri@apm.com
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v15 09/10] USB ppc4xx: Add Synopsys DWC OTG driver kernel
 configuration and Makefile
Date: Fri, 14 Oct 2011 15:09:16 -0700
Message-Id: <1318630156-14425-1-git-send-email-tmarri@apm.com>
Cc: tmarri@apm.com, greg@kroah.com, Mark Miesfeld <mmiesfeld@apm.com>,
 Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tirumala Marri <tmarri@apm.com>

Add Synopsys DesignWare HS USB OTG driver kernel configuration.
Synopsys OTG driver may operate in  host only, device only, or OTG mode.
The driver also allows user configure the core to use its internal DMA
or Slave (PIO) mode.

Signed-off-by: Tirumala R Marri <tmarri@apm.com>
Signed-off-by: Fushen Chen <fchen@apm.com>
Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
---
 drivers/usb/Kconfig      |    2 +
 drivers/usb/Makefile     |    1 +
 drivers/usb/dwc/Kconfig  |   84 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc/Makefile |   19 ++++++++++
 4 files changed, 106 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/dwc/Kconfig
 create mode 100644 drivers/usb/dwc/Makefile

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 48f1781..a584cec 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -120,6 +120,8 @@ source "drivers/usb/musb/Kconfig"
 
 source "drivers/usb/renesas_usbhs/Kconfig"
 
+source "drivers/usb/dwc/Kconfig"
+
 source "drivers/usb/class/Kconfig"
 
 source "drivers/usb/storage/Kconfig"
diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 30ddf8d..a2daf43 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -50,4 +50,5 @@ obj-$(CONFIG_USB_SPEEDTOUCH)	+= atm/
 obj-$(CONFIG_USB_MUSB_HDRC)	+= musb/
 obj-$(CONFIG_USB_RENESAS_USBHS)	+= renesas_usbhs/
 obj-$(CONFIG_USB_OTG_UTILS)	+= otg/
+obj-$(CONFIG_USB_DWC_OTG)	+= dwc/
 obj-$(CONFIG_USB_GADGET)	+= gadget/
diff --git a/drivers/usb/dwc/Kconfig b/drivers/usb/dwc/Kconfig
new file mode 100644
index 0000000..eafc5ed
--- /dev/null
+++ b/drivers/usb/dwc/Kconfig
@@ -0,0 +1,84 @@
+#
+# USB Dual Role (OTG-ready) Controller Drivers
+# for silicon based on Synopsys DesignWare IP
+#
+
+comment "Enable Host or Gadget support for DesignWare OTG controller"
+	depends on !USB && USB_GADGET=n
+
+config USB_DWC_OTG
+	tristate "Synopsys DWC OTG Controller"
+	depends on USB || USB_GADGET
+	select NOP_USB_XCEIV
+	select USB_OTG_UTILS
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
+	default DWC_HOST_ONLY
+	help
+	  Select the DWC Core in OTG, Host only, or Device only mode.
+
+config DWC_HOST_ONLY
+	bool "DWC Host Only Mode"
+
+config DWC_OTG_MODE
+	bool "DWC OTG Mode"
+	select USB_GADGET_SELECTED
+
+config DWC_DEVICE_ONLY
+	bool "DWC Device Only Mode"
+	select USB_GADGET_SELECTED
+
+endchoice
+
+# enable peripheral support (including with OTG)
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
+	bool "DWC Slave Mode"
+
+config DWC_DMA_MODE
+	bool "DWC DMA Mode"
+
+endchoice
+
+config DWC_OTG_REG_LE
+	bool "DWC Little Endian Register"
+	depends on USB_DWC_OTG
+	default y
+	help
+	  OTG core register access is Little-Endian.
+
+config DWC_OTG_FIFO_LE
+	bool "DWC FIFO Little Endian"
+	depends on USB_DWC_OTG
+	default n
+	help
+	  OTG core FIFO access is Little-Endian.
+
+config DWC_LIMITED_XFER_SIZE
+	bool "DWC Endpoint Limited Xfer Size"
+	depends on USB_GADGET_DWC_HDRC
+	default n
+	help
+	  Bit fields in the Device EP Transfer Size Register is 11 bits.
diff --git a/drivers/usb/dwc/Makefile b/drivers/usb/dwc/Makefile
new file mode 100644
index 0000000..4102add
--- /dev/null
+++ b/drivers/usb/dwc/Makefile
@@ -0,0 +1,19 @@
+#
+# OTG infrastructure and transceiver drivers
+#
+obj-$(CONFIG_USB_DWC_OTG)	+= dwc.o
+
+dwc-objs := cil.o cil_intr.o param.o
+
+ifeq ($(CONFIG_4xx_SOC),y)
+dwc-objs += apmppc.o
+endif
+
+ifneq ($(CONFIG_DWC_DEVICE_ONLY),y)
+dwc-objs += hcd.o hcd_intr.o \
+		hcd_queue.o
+endif
+
+ifneq ($(CONFIG_DWC_HOST_ONLY),y)
+dwc-objs += pcd.o pcd_intr.o
+endif
-- 
1.6.1.rc3
