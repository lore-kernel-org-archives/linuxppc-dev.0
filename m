Return-Path: <tmarri@amcc.com>
Received: from denmail01.apm.com (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8DDA41008C8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Apr 2011 06:05:44 +1100 (EST)
From: tmarri@apm.com
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v11 09/10] USB ppc4xx: Add Synopsys DWC OTG driver kernel
	configuration and Makefile
Date: Fri,  1 Apr 2011 12:05:36 -0700
Message-Id: <1301684736-17647-1-git-send-email-tmarri@apm.com>
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
 drivers/Makefile             |    1 +
 drivers/usb/Kconfig          |    2 +
 drivers/usb/otg/dwc/Kconfig  |   88 ++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/otg/dwc/Makefile |   19 +++++++++
 4 files changed, 110 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/otg/dwc/Kconfig
 create mode 100644 drivers/usb/otg/dwc/Makefile

diff --git a/drivers/Makefile b/drivers/Makefile
index a125e0b..500e08f 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_PARIDE) 		+= block/paride/
 obj-$(CONFIG_TC)		+= tc/
 obj-$(CONFIG_UWB)		+= uwb/
 obj-$(CONFIG_USB_OTG_UTILS)	+= usb/otg/
+obj-$(CONFIG_USB_DWC_OTG)	+= usb/otg/dwc/
 obj-$(CONFIG_USB)		+= usb/
 obj-$(CONFIG_USB_MUSB_HDRC)	+= usb/musb/
 obj-$(CONFIG_PCI)		+= usb/
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 41b6e51..28b4c54 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -115,6 +115,8 @@ source "drivers/usb/host/Kconfig"
 
 source "drivers/usb/musb/Kconfig"
 
+source "drivers/usb/otg/dwc/Kconfig"
+
 source "drivers/usb/class/Kconfig"
 
 source "drivers/usb/storage/Kconfig"
diff --git a/drivers/usb/otg/dwc/Kconfig b/drivers/usb/otg/dwc/Kconfig
new file mode 100644
index 0000000..a8f22cb
--- /dev/null
+++ b/drivers/usb/otg/dwc/Kconfig
@@ -0,0 +1,88 @@
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
diff --git a/drivers/usb/otg/dwc/Makefile b/drivers/usb/otg/dwc/Makefile
new file mode 100644
index 0000000..4102add
--- /dev/null
+++ b/drivers/usb/otg/dwc/Makefile
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
