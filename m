Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7AA23DDDE6
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 18:04:36 +1100 (EST)
Date: Wed, 14 Feb 2007 16:04:17 +0900 (JST)
Message-Id: <200702140704.l1E74IqP013586@toshiba.co.jp>
Subject: [PATCH] ps3: don't call ps3_system_bus_driver_register on other
	platforms
To: dbrownell@users.sourceforge.net, greg@kroah.com,
	geoffrey.levand@am.sony.com
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ps3_system_bus_driver_register is PS3 platform specific function.
On other platforms, it triggers WARN_ON in kref_get.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/drivers/usb/host/ehci-hcd.c
diff -u linux-powerpc-git/drivers/usb/host/ehci-hcd.c:1.1.1.2 linux-powerpc-git/drivers/usb/host/ehci-hcd.c:1.4
--- linux-powerpc-git/drivers/usb/host/ehci-hcd.c:1.1.1.2	Fri Feb  9 13:44:37 2007
+++ linux-powerpc-git/drivers/usb/host/ehci-hcd.c	Wed Feb 14 12:30:56 2007
@@ -42,6 +42,9 @@
 #include <asm/irq.h>
 #include <asm/system.h>
 #include <asm/unaligned.h>
+#ifdef CONFIG_PPC_PS3
+#include <asm/firmware.h>
+#endif
 
 
 /*-------------------------------------------------------------------------*/
@@ -951,15 +954,18 @@
 #endif
 
 #ifdef PS3_SYSTEM_BUS_DRIVER
-	retval = ps3_system_bus_driver_register(&PS3_SYSTEM_BUS_DRIVER);
-	if (retval < 0) {
+	if (firmware_has_feature(FW_FEATURE_PS3_LV1)) {
+		retval = ps3_system_bus_driver_register(
+				&PS3_SYSTEM_BUS_DRIVER);
+		if (retval < 0) {
 #ifdef PLATFORM_DRIVER
-		platform_driver_unregister(&PLATFORM_DRIVER);
+			platform_driver_unregister(&PLATFORM_DRIVER);
 #endif
 #ifdef PCI_DRIVER
-		pci_unregister_driver(&PCI_DRIVER);
+			pci_unregister_driver(&PCI_DRIVER);
 #endif
-		return retval;
+			return retval;
+		}
 	}
 #endif
 
@@ -976,7 +982,8 @@
 	pci_unregister_driver(&PCI_DRIVER);
 #endif
 #ifdef PS3_SYSTEM_BUS_DRIVER
-	ps3_system_bus_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
+	if (firmware_has_feature(FW_FEATURE_PS3_LV1))
+		ps3_system_bus_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
 #endif
 }
 module_exit(ehci_hcd_cleanup);
Index: linux-powerpc-git/drivers/usb/host/ohci-hcd.c
diff -u linux-powerpc-git/drivers/usb/host/ohci-hcd.c:1.1.1.4 linux-powerpc-git/drivers/usb/host/ohci-hcd.c:1.2
--- linux-powerpc-git/drivers/usb/host/ohci-hcd.c:1.1.1.4	Fri Feb  9 13:44:37 2007
+++ linux-powerpc-git/drivers/usb/host/ohci-hcd.c	Wed Feb 14 12:30:56 2007
@@ -42,6 +42,9 @@
 #include <asm/system.h>
 #include <asm/unaligned.h>
 #include <asm/byteorder.h>
+#ifdef CONFIG_PPC_PS3
+#include <asm/firmware.h>
+#endif
 
 #include "../core/hcd.h"
 
@@ -944,9 +947,12 @@
 		sizeof (struct ed), sizeof (struct td));
 
 #ifdef PS3_SYSTEM_BUS_DRIVER
-	retval = ps3_system_bus_driver_register(&PS3_SYSTEM_BUS_DRIVER);
-	if (retval < 0)
-		goto error_ps3;
+	if (firmware_has_feature(FW_FEATURE_PS3_LV1)) {
+		retval = ps3_system_bus_driver_register(
+				&PS3_SYSTEM_BUS_DRIVER);
+		if (retval < 0)
+			goto error_ps3;
+	}
 #endif
 
 #ifdef PLATFORM_DRIVER
@@ -992,7 +998,8 @@
  error_platform:
 #endif
 #ifdef PS3_SYSTEM_BUS_DRIVER
-	ps3_system_bus_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
+	if (firmware_has_feature(FW_FEATURE_PS3_LV1))
+		ps3_system_bus_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
  error_ps3:
 #endif
 	return retval;
@@ -1014,7 +1021,8 @@
 	platform_driver_unregister(&PLATFORM_DRIVER);
 #endif
 #ifdef PS3_SYSTEM_BUS_DRIVER
-	ps3_system_bus_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
+	if (firmware_has_feature(FW_FEATURE_PS3_LV1))
+		ps3_system_bus_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
 #endif
 }
 module_exit(ohci_hcd_mod_exit);
