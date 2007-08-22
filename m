Return-Path: <wre@wolfgang-pc.public.xilinx.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7A214DDED0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 10:50:53 +1000 (EST)
Received: from outbound2-blu.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound2-blu-R.bigfish.com (Postfix) with ESMTP id 515B314EA369
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 00:50:49 +0000 (UTC)
Received: from mail60-blu-R.bigfish.com (unknown [10.1.252.3])
	by outbound2-blu.bigfish.com (Postfix) with ESMTP id 396151A88067
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 00:50:49 +0000 (UTC)
Received: from mail60-blu (localhost.localdomain [127.0.0.1])
	by mail60-blu-R.bigfish.com (Postfix) with ESMTP id E70BDD70123
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 00:50:48 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail60-blu.bigfish.com (Postfix) with ESMTP id BD4E4D800B8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 00:50:48 +0000 (UTC)
Received: from unknown-38-66.xilinx.com
	([149.199.38.66] helo=xsj-smtp1.xilinx.com
	ident=[U2FsdGVkX19jtGG+XRhdvypxM7Zd3ddLU2yPXtuxa8I=])
	by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <wre@wolfgang-pc.public.xilinx.com>)
	id 1INeQq-0006zX-Fu
	for linuxppc-embedded@ozlabs.org; Tue, 21 Aug 2007 17:50:48 -0700
From: wolfgang.reissnegger@xilinx.com
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 1/3] Add generic configuration option to enable all xilinx
	drivers.
Date: Tue, 21 Aug 2007 17:53:11 -0700
Message-Id: <20070822005048.BD4E4D800B8@mail60-blu.bigfish.com>
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
