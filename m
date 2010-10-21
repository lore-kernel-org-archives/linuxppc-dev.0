Return-Path: <fchen@apm.com>
Received: from denmail01.apm.COM (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0464FB7108
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Oct 2010 11:59:35 +1100 (EST)
From: Fushen Chen <fchen@apm.com>
To: linux-usb@vger.kernel.org
Subject: [PATCH V5 9/9] Add Synopsys DesignWare HS USB OTG driver kernel
	configuration and Makefile.
Date: Wed, 20 Oct 2010 17:42:52 -0700
Message-Id: <1287621776656-git-send-email-fchen@apm.com>
In-Reply-To: <1287621776919-git-send-email-fchen@apm.com>
References: <12876217721253-git-send-email-fchen@apm.com>
	<1287621773567-git-send-email-fchen@apm.com>
	<1287621774425-git-send-email-fchen@apm.com>
	<12876217742179-git-send-email-fchen@apm.com>
	<1287621774191-git-send-email-fchen@apm.com>
	<12876217753881-git-send-email-fchen@apm.com>
	<12876217751349-git-send-email-fchen@apm.com>
	<12876217752399-git-send-email-fchen@apm.com>
	<1287621776919-git-send-email-fchen@apm.com>
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


Signed-off-by: Fushen Chen <fchen@apm.com>
Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
---
 drivers/Makefile             |    1 +
 drivers/usb/Kconfig          |    2 +
 drivers/usb/dwc_otg/Kconfig  |   99 ++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc_otg/Makefile |   19 ++++++++
 4 files changed, 121 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/dwc_otg/Kconfig
 create mode 100644 drivers/usb/dwc_otg/Makefile

diff --git a/drivers/Makefile b/drivers/Makefile
index a2aea53..36cb201 100644
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
index 4aa00e6..bbb8b2c 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -114,6 +114,8 @@ source "drivers/usb/host/Kconfig"
 
 source "drivers/usb/musb/Kconfig"
 
+source "drivers/usb/dwc_otg/Kconfig"
+
 source "drivers/usb/class/Kconfig"
 
 source "drivers/usb/storage/Kconfig"
diff --git a/drivers/usb/dwc_otg/Kconfig b/drivers/usb/dwc_otg/Kconfig
new file mode 100644
index 0000000..174141d
--- /dev/null
+++ b/drivers/usb/dwc_otg/Kconfig
@@ -0,0 +1,99 @@
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
+	default DWC_HOST_ONLY
+	help
+	  Select the DWC Core in OTG, Host only, or Device only mode.
+
+config DWC_HOST_ONLY
+	bool "DWC Host Only Mode" if 405EX || 460EX
+
+config DWC_OTG_MODE
+	bool "DWC OTG Mode" if 405EX || 460EX
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
+	depends on !USB_SUSPEND && USB_DWC_OTG
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
+	depends on USB_GADGET_DWC_HDRC
+	bool "DWC Endpoint Limited Xfer Size" if 405EZ || 405EX || 460EX
+	default n if 460EX || 405EX
+	default y if 405EZ
+	help
+	  Bit fields in the Device EP Transfer Size Register is 11 bits.
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
-- 
1.7.3
