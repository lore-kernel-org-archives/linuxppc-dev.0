Return-Path: <wolfgang.reissnegger@xilinx.com>
Received: from outbound1-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CB0FBDDEC1
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Aug 2007 08:54:06 +1000 (EST)
Received: from outbound1-cpk.bigfish.com (localhost [127.0.0.1])
	by outbound1-cpk-R.bigfish.com (Postfix) with ESMTP id EE53D330181
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Aug 2007 22:54:03 +0000 (UTC)
Received: from mail33-cpk-R.bigfish.com (unknown [10.2.40.3])
	by outbound1-cpk.bigfish.com (Postfix) with ESMTP id EBF065A004B
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Aug 2007 22:54:03 +0000 (UTC)
Received: from mail33-cpk (localhost.localdomain [127.0.0.1])
	by mail33-cpk-R.bigfish.com (Postfix) with ESMTP id D6E3221812C
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Aug 2007 22:54:03 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail33-cpk.bigfish.com (Postfix) with ESMTP id B430E550060
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Aug 2007 22:54:03 +0000 (UTC)
Received: from unknown-38-66.xilinx.com
	([149.199.38.66] helo=xsj-smtp1.xilinx.com
	ident=[U2FsdGVkX18cVh0KsA1CZ0AiyGDXZR91yXllCjLNcCc=])
	by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <wolfgang.reissnegger@xilinx.com>) id 1IIBSd-0001WD-KK
	for linuxppc-embedded@ozlabs.org; Mon, 06 Aug 2007 15:54:03 -0700
Date: Mon, 06 Aug 2007 15:54:48 -0700
From: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] Generic configuration selector for Xilinx devices
Content-Type: multipart/mixed; boundary="------------030705030808030400090503"
Message-Id: <20070806225403.B430E550060@mail33-cpk.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030705030808030400090503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This is intended to make visible all device driver options for
both powerpc and microblaze systems.

Thanks,
   Wolfgang

--------------030705030808030400090503
Content-Type: text/plain;
 name*0="[PATCH] Generic configuration selector for Xilinx devices.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="[PATCH] Generic configuration selector for Xilinx devices.tx";
 filename*1="t"


Signed-off-by: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

---
 arch/ppc/platforms/4xx/Kconfig |    1 +
 drivers/misc/Kconfig           |    1 +
 drivers/misc/xilinx/Kconfig    |    9 +++++++++
 drivers/video/Kconfig          |    2 +-
 4 files changed, 12 insertions(+), 1 deletions(-)
 create mode 100644 drivers/misc/xilinx/Kconfig

diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index 76551b6..d7db7e4 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -228,6 +228,7 @@ config XILINX_VIRTEX_4_FX
 
 config XILINX_VIRTEX
 	bool
+	select XILINX_DRIVERS
 
 config STB03xxx
 	bool
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 2f2fbff..f8a504c 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -195,5 +195,6 @@ config BLINK
 	  output something to the screen like kexec kernels to give the user
 	  a visual indication that the kernel is doing something.
 
+source "drivers/misc/xilinx/Kconfig"
 
 endmenu
diff --git a/drivers/misc/xilinx/Kconfig b/drivers/misc/xilinx/Kconfig
new file mode 100644
index 0000000..93c41a7
--- /dev/null
+++ b/drivers/misc/xilinx/Kconfig
@@ -0,0 +1,9 @@
+#
+# Xilinx devices and common device driver infrastructure
+#
+
+config XILINX_DRIVERS
+  bool
+  help
+    Enable visibility of all Xilinx device drivers.
+
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 403dac7..13910a8 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1811,7 +1811,7 @@ config FB_PS3_DEFAULT_SIZE_M
 
 config FB_XILINX
 	tristate "Xilinx frame buffer support"
-	depends on FB && XILINX_VIRTEX
+	depends on FB && XILINX_DRIVERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.5.1


--------------030705030808030400090503--
