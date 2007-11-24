Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id A2E33DE473
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 11:26:44 +1100 (EST)
Received: from pd4mr2so.prod.shaw.ca
	(pd4mr2so-qfe3.prod.shaw.ca [10.0.141.213]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JRZ006LFIHIV440@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 23 Nov 2007 17:24:54 -0700 (MST)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
	by pd4mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JRZ00DNYIHERQ40@pd4mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 23 Nov 2007 17:24:54 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JRZ00LAFIHEF940@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 23 Nov 2007 17:24:50 -0700 (MST)
Date: Fri, 23 Nov 2007 17:24:51 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 5/5] USB: Add Cypress c67x00 OTG controller driver to Kconfig
	and Makefiles
In-reply-to: <20071124001203.25361.99294.stgit@trillian.cg.shawcable.net>
To: linux-usb-devel@lists.sourceforge.net, akpm@osdl.org,
	dbrownell@users.sourceforge.net, gregkh@suse.de, linuxppc-dev@ozlabs.org
Message-id: <20071124002451.25361.90102.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071124001203.25361.99294.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

add c67x00 driver to build

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/usb/Kconfig         |    2 ++
 drivers/usb/Makefile        |    2 ++
 drivers/usb/c67x00/Kconfig  |   22 ++++++++++++++++++++++
 drivers/usb/c67x00/Makefile |   14 ++++++++++++++
 4 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 7580aa5..a497f96 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -91,6 +91,8 @@ source "drivers/usb/core/Kconfig"
 
 source "drivers/usb/host/Kconfig"
 
+source "drivers/usb/c67x00/Kconfig"
+
 source "drivers/usb/class/Kconfig"
 
 source "drivers/usb/storage/Kconfig"
diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 516a640..a1ae51d 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -17,6 +17,8 @@ obj-$(CONFIG_USB_SL811_HCD)	+= host/
 obj-$(CONFIG_USB_U132_HCD)	+= host/
 obj-$(CONFIG_USB_R8A66597_HCD)	+= host/
 
+obj-$(CONFIG_USB_C67X00_DRV)	+= c67x00/
+
 obj-$(CONFIG_USB_ACM)		+= class/
 obj-$(CONFIG_USB_PRINTER)	+= class/
 
diff --git a/drivers/usb/c67x00/Kconfig b/drivers/usb/c67x00/Kconfig
new file mode 100644
index 0000000..efd7923
--- /dev/null
+++ b/drivers/usb/c67x00/Kconfig
@@ -0,0 +1,22 @@
+#
+# Cypress C67x00 USB controller
+#
+config USB_C67X00_DRV
+	tristate "Cypress C67x00 support"
+	# only allowed to be =y if both USB!=m and USB_GADGET!=m
+	depends on (!USB && USB_GADGET) || (!USB_GADGET && USB) || (USB && USB_GADGET)
+	default n
+	help
+	  The Cypress C67x00 (EZ-Host/EZ-OTG) chips are dual-role
+	  host/peripheral USB controllers.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called c67x00.
+
+config USB_C67X00_HCD
+	bool "Cypress C67X00 Host support"
+	depends on USB_C67X00_DRV
+	depends on USB
+	default y
+	help
+	  This enables the host functionality of the Cypress C67X00.
diff --git a/drivers/usb/c67x00/Makefile b/drivers/usb/c67x00/Makefile
new file mode 100644
index 0000000..8ff5cd0
--- /dev/null
+++ b/drivers/usb/c67x00/Makefile
@@ -0,0 +1,14 @@
+#
+# Makefile for Cypress C67X00 USB Controller
+#
+
+ifeq ($(CONFIG_USB_DEBUG),y)
+	EXTRA_CFLAGS		+= -DDEBUG
+endif
+
+obj-$(CONFIG_USB_C67X00_DRV)	+= c67x00.o
+
+c67x00-y			+= c67x00-drv.o
+c67x00-y			+= c67x00-ll-hpi.o
+
+c67x00-$(CONFIG_USB_C67X00_HCD) += c67x00-hcd.o c67x00-sched.o
