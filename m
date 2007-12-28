Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id E4876DDDF4
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 10:53:51 +1100 (EST)
Received: from pd3mr5so.prod.shaw.ca (pd3mr5so-qfe3.prod.shaw.ca [10.0.141.12])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JTS00COQAC4PYA0@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Dec 2007 16:52:52 -0700 (MST)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
	by pd3mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JTS003JSAC4ID10@pd3mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 28 Dec 2007 16:52:53 -0700 (MST)
Received: from trillian.cg.shawcable.net ([70.72.177.167])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JTS00KP6AC3J830@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Dec 2007 16:52:51 -0700 (MST)
Date: Fri, 28 Dec 2007 16:52:46 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 4/4] USB: add Cypress c67x00 OTG controller driver to
	Kconfig and Makefiles
In-reply-to: <20071228234537.16003.56035.stgit@trillian.secretlab.ca>
To: linux-usb-devel@lists.sourceforge.net, akpm@osdl.org,
	dbrownell@users.sourceforge.net, gregkh@suse.de, linuxppc-dev@ozlabs.org,
	jacmet@sunsite.dk, stern@rowland.harvard.edu
Message-id: <20071228235246.16003.63193.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071228234537.16003.56035.stgit@trillian.secretlab.ca>
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

 drivers/usb/Makefile        |    2 ++
 drivers/usb/c67x00/Makefile |   11 +++++++++++
 drivers/usb/host/Kconfig    |   12 ++++++++++++
 3 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 516a640..a419c42 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -17,6 +17,8 @@ obj-$(CONFIG_USB_SL811_HCD)	+= host/
 obj-$(CONFIG_USB_U132_HCD)	+= host/
 obj-$(CONFIG_USB_R8A66597_HCD)	+= host/
 
+obj-$(CONFIG_USB_C67X00_HCD)	+= c67x00/
+
 obj-$(CONFIG_USB_ACM)		+= class/
 obj-$(CONFIG_USB_PRINTER)	+= class/
 
diff --git a/drivers/usb/c67x00/Makefile b/drivers/usb/c67x00/Makefile
new file mode 100644
index 0000000..7e6eb0b
--- /dev/null
+++ b/drivers/usb/c67x00/Makefile
@@ -0,0 +1,11 @@
+#
+# Makefile for Cypress C67X00 USB Controller
+#
+
+ifeq ($(CONFIG_USB_DEBUG),y)
+	EXTRA_CFLAGS		+= -DDEBUG
+endif
+
+obj-$(CONFIG_USB_C67X00_HCD)	+= c67x00.o
+
+c67x00-objs := c67x00-drv.o c67x00-ll-hpi.o c67x00-hcd.o c67x00-sched.o
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 49a91c5..49521d1 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -261,3 +261,15 @@ config USB_R8A66597_HCD
 	  To compile this driver as a module, choose M here: the
 	  module will be called r8a66597-hcd.
 
+config USB_C67X00_HCD
+	tristate "Cypress C67x00 HCD support"
+	depends on USB
+	help
+	  The Cypress C67x00 (EZ-Host/EZ-OTG) chips are dual-role
+	  host/peripheral/OTG USB controllers.
+
+	  Enable this option to support this chip in host controller mode.
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called c67x00.
