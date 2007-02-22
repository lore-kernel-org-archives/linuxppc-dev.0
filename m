Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id E80C5DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 02:43:14 +1100 (EST)
Date: Thu, 22 Feb 2007 16:43:12 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoffrey.levand@am.sony.com>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH] ps3: always make sure we're running on a PS3
Message-ID: <Pine.LNX.4.62.0702221641560.25977@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add missing checks to PS3 specific drivers ps3av and sys-manager to verify that
we are actually running on a PS3 (pointed out by Arnd).

Correct existing checks in other subsystems/drivers to return -ENODEV instead
of zero.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 arch/powerpc/platforms/ps3/mm.c         |    2 +-
 arch/powerpc/platforms/ps3/system-bus.c |    2 +-
 drivers/ps3/ps3av.c                     |    9 ++++++++-
 drivers/ps3/sys-manager.c               |    6 ++++++
 drivers/ps3/vuart.c                     |    2 +-
 5 files changed, 17 insertions(+), 4 deletions(-)

--- ps3-linux-2.6.21-rc1.orig/arch/powerpc/platforms/ps3/mm.c
+++ ps3-linux-2.6.21-rc1/arch/powerpc/platforms/ps3/mm.c
@@ -294,7 +294,7 @@ static int __init ps3_mm_add_memory(void
 	unsigned long nr_pages;
 
 	if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
-		return 0;
+		return -ENODEV;
 
 	BUG_ON(!mem_init_done);
 
--- ps3-linux-2.6.21-rc1.orig/arch/powerpc/platforms/ps3/system-bus.c
+++ ps3-linux-2.6.21-rc1/arch/powerpc/platforms/ps3/system-bus.c
@@ -172,7 +172,7 @@ int __init ps3_system_bus_init(void)
 	int result;
 
 	if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
-		return 0;
+		return -ENODEV;
 
 	result = bus_register(&ps3_system_bus_type);
 	BUG_ON(result);
--- ps3-linux-2.6.21-rc1.orig/drivers/ps3/ps3av.c
+++ ps3-linux-2.6.21-rc1/drivers/ps3/ps3av.c
@@ -24,6 +24,8 @@
 #include <linux/reboot.h>
 #include <linux/kernel.h>
 #include <linux/ioctl.h>
+
+#include <asm/firmware.h>
 #include <asm/lv1call.h>
 #include <asm/ps3av.h>
 #include <asm/ps3.h>
@@ -947,7 +949,12 @@ static struct ps3_vuart_port_driver ps3a
 
 static int ps3av_module_init(void)
 {
-	int error = ps3_vuart_port_driver_register(&ps3av_driver);
+	int error;
+
+	if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
+		return -ENODEV;
+
+	error = ps3_vuart_port_driver_register(&ps3av_driver);
 	if (error) {
 		printk(KERN_ERR
 		       "%s: ps3_vuart_port_driver_register failed %d\n",
--- ps3-linux-2.6.21-rc1.orig/drivers/ps3/sys-manager.c
+++ ps3-linux-2.6.21-rc1/drivers/ps3/sys-manager.c
@@ -22,7 +22,10 @@
 #include <linux/module.h>
 #include <linux/workqueue.h>
 #include <linux/reboot.h>
+
+#include <asm/firmware.h>
 #include <asm/ps3.h>
+
 #include "vuart.h"
 
 MODULE_AUTHOR("Sony Corporation");
@@ -598,6 +601,9 @@ static struct ps3_vuart_port_driver ps3_
 
 static int __init ps3_sys_manager_init(void)
 {
+	if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
+		return -ENODEV;
+
 	return ps3_vuart_port_driver_register(&ps3_sys_manager);
 }
 
--- ps3-linux-2.6.21-rc1.orig/drivers/ps3/vuart.c
+++ ps3-linux-2.6.21-rc1/drivers/ps3/vuart.c
@@ -1031,7 +1031,7 @@ int __init ps3_vuart_bus_init(void)
 	pr_debug("%s:%d:\n", __func__, __LINE__);
 
 	if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
-		return 0;
+		return -ENODEV;
 
 	init_MUTEX(&vuart_bus_priv.probe_mutex);
 	result = bus_register(&ps3_vuart_bus);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
