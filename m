Return-Path: <wre@wolfgang-pc.public.xilinx.com>
Received: from outbound4-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174]) by ozlabs.org (Postfix) with SMTP id C6E85DDED7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 10:28:58 +1000 (EST)
Received: from outbound4-fra.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound4-fra-R.bigfish.com (Postfix) with ESMTP id 945C98D8013
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 00:28:56 +0000 (UTC)
Received: from mail31-fra-R.bigfish.com (unknown [10.4.252.3])
	by outbound4-fra.bigfish.com (Postfix) with ESMTP id 92B508500A6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 00:28:56 +0000 (UTC)
Received: from mail31-fra (localhost.localdomain [127.0.0.1])
	by mail31-fra-R.bigfish.com (Postfix) with ESMTP id 86145F042B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 00:28:56 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail31-fra.bigfish.com (Postfix) with ESMTP id 128BB8A807D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 00:28:56 +0000 (UTC)
Received: from unknown-38-66.xilinx.com
	([149.199.38.66] helo=xsj-smtp1.xilinx.com
	ident=[U2FsdGVkX1/XM4TcpXGSukTnunfzoRY2wuNwx3WdtaI=])
	by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <wre@wolfgang-pc.public.xilinx.com>)
	id 1INe5f-0005lk-Fh
	for linuxppc-embedded@ozlabs.org; Tue, 21 Aug 2007 17:28:55 -0700
From: Wolfgang Reissnegger <w.reissnegger@gmx.net>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 1/3] Add generic configuration option to enable all xilinx
	drivers.
Date: Tue, 21 Aug 2007 17:31:25 -0700
Message-Id: <20070822002856.128BB8A807D@mail31-fra.bigfish.com>
Cc: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

In the future, this will be used to provide similar configuration
for PowerPC and Microblaze.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Signed-off-by: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
---
 arch/ppc/platforms/4xx/Kconfig |    1 +
 drivers/misc/Kconfig           |   10 ++++++++++
 drivers/video/Kconfig          |    2 +-
 3 files changed, 12 insertions(+), 1 deletions(-)

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
index 518d5d3..e5bc9af 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -219,3 +219,13 @@ config THINKPAD_ACPI_INPUT_ENABLED
 
 
 endif # MISC_DEVICES
+endmenu
+
+
+#
+# Xilinx devices and common device driver infrastructure
+#
+
+config XILINX_DRIVERS
+  bool
+
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 5216c11..69e7240 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1824,7 +1824,7 @@ config FB_PS3_DEFAULT_SIZE_M
 
 config FB_XILINX
 	tristate "Xilinx frame buffer support"
-	depends on FB && XILINX_VIRTEX
+	depends on FB && XILINX_DRIVERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.5.2.1
