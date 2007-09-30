Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id F13BDDDEBA
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 07:47:08 +1000 (EST)
Received: from pd4mr4so.prod.shaw.ca
	(pd4mr4so-qfe3.prod.shaw.ca [10.0.141.215]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP700MX1B6IC820@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 15:47:06 -0600 (MDT)
Received: from pn2ml8so.prod.shaw.ca ([10.0.121.152])
	by pd4mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP700CBFB6HY510@pd4mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sun, 30 Sep 2007 15:47:06 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP700BPMB6BIONA@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 15:47:00 -0600 (MDT)
Date: Sun, 30 Sep 2007 15:47:00 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/3] XilinxFB: Move xilinxfb_platform_data definition to a
	shared header file
In-reply-to: <20070930214140.31899.55951.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com
Message-id: <20070930214700.31899.14581.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20070930214140.31899.55951.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

XilnixFB can be used by more than just arch/ppc.  Move the data structure
definition into include/linux/xilinxfb.h so it can be used by microblaze
and arch/powerpc

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/ppc/syslib/virtex_devices.h |    8 +-------
 drivers/video/xilinxfb.c         |    2 +-
 include/linux/xilinxfb.h         |   23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/ppc/syslib/virtex_devices.h b/arch/ppc/syslib/virtex_devices.h
index 9f38d92..6ebd9b4 100644
--- a/arch/ppc/syslib/virtex_devices.h
+++ b/arch/ppc/syslib/virtex_devices.h
@@ -12,13 +12,7 @@
 #define __ASM_VIRTEX_DEVICES_H__
 
 #include <linux/platform_device.h>
-
-/* ML300/403 reference design framebuffer driver platform data struct */
-struct xilinxfb_platform_data {
-	u32 rotate_screen;
-	u32 screen_height_mm;
-	u32 screen_width_mm;
-};
+#include <linux/xilinxfb.h>
 
 void __init virtex_early_serial_map(void);
 
diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 6ef9733..4bc67ab 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -30,7 +30,7 @@
 #include <linux/platform_device.h>
 
 #include <asm/io.h>
-#include <syslib/virtex_devices.h>
+#include <linux/xilinxfb.h>
 
 #define DRIVER_NAME		"xilinxfb"
 #define DRIVER_DESCRIPTION	"Xilinx TFT LCD frame buffer driver"
diff --git a/include/linux/xilinxfb.h b/include/linux/xilinxfb.h
new file mode 100644
index 0000000..9ad984d
--- /dev/null
+++ b/include/linux/xilinxfb.h
@@ -0,0 +1,23 @@
+/*
+ * Platform device data for Xilinx Framebuffer device
+ *
+ * Copyright 2007 Secret Lab Technologies Ltd.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __XILINXFB_H__
+#define __XILINXFB_H__
+
+#include <linux/types.h>
+
+/* ML300/403 reference design framebuffer driver platform data struct */
+struct xilinxfb_platform_data {
+	u32 rotate_screen;
+	u32 screen_height_mm;
+	u32 screen_width_mm;
+};
+
+#endif  /* __XILINXFB_H__ */
