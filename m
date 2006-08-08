Return-Path: <aris@cathedrallabs.org>
Received: from tinc.cathedrallabs.org (tinc.cathedrallabs.org [72.9.252.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 73F9167B59
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 02:10:17 +1000 (EST)
Received: from tate.cathedrallabs.org
	(201-25-167-1.ctame704.dsl.brasiltelecom.net.br [201.25.167.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tinc.cathedrallabs.org (Postfix) with ESMTP id C8B9B10009
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Aug 2006 11:45:47 -0400 (EDT)
Date: Tue, 8 Aug 2006 12:45:35 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] adb: create class devices for each handler
Message-ID: <20060808154535.GB3363@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch creates a class device for each registered ADB handler
(currently only adbhid) such as /sys/classes/adb/keyboard0/,
/sys/classes/adb/mouse0/. This is needed for the next patch, to create
a sysfs entry to make SYSRQ key configurable on ADB based machines.

Signed-off-by: Aristeu S. Rozanski F. <aris@cathedrallabs.org>
Acked-by: Michael Hanselmann <linux-kernel@hansmi.ch>

Index: ppc-2.6/drivers/macintosh/adb.c
===================================================================
--- ppc-2.6.orig/drivers/macintosh/adb.c	2006-08-03 23:51:35.000000000 -0300
+++ ppc-2.6/drivers/macintosh/adb.c	2006-08-03 23:56:00.000000000 -0300
@@ -102,11 +102,22 @@
 static void adbdev_init(void);
 static int try_handler_change(int, int);
 
+static char *adb_device_id_string[] = {
+	[ADB_DONGLE] = "dongle",
+	[ADB_KEYBOARD] = "keyboard",
+	[ADB_MOUSE] = "mouse",
+	[ADB_TABLET] = "tablet",
+	[ADB_MODEM] = "modem",
+	[ADB_MISC] = "misc",
+};
+
 static struct adb_handler {
 	void (*handler)(unsigned char *, int, struct pt_regs *, int);
 	int original_address;
 	int handler_id;
 	int busy;
+	char name[16];
+	struct class_device *device;
 } adb_handler[16];
 
 /*
@@ -541,6 +552,15 @@
 			write_lock_irq(&adb_handler_lock);
 			adb_handler[i].handler = handler;
 			write_unlock_irq(&adb_handler_lock);
+
+			snprintf(adb_handler[i].name,
+				sizeof(adb_handler[i].name), "%s%i",
+				adb_device_id_string[default_id], ids->nids);
+			adb_handler[i].device = class_device_create(
+							adb_dev_class, NULL,
+							MKDEV(0, 0), NULL,
+							adb_handler[i].name);
+			ids->device[ids->nids] = adb_handler[i].device;
 			ids->id[ids->nids++] = i;
 		}
 	}
@@ -563,6 +583,7 @@
 		}
 		ret = 0;
 		adb_handler[index].handler = NULL;
+		class_device_del(adb_handler[index].device);
 	}
 	write_unlock_irq(&adb_handler_lock);
 	up(&adb_handler_sem);
Index: ppc-2.6/include/linux/adb.h
===================================================================
--- ppc-2.6.orig/include/linux/adb.h	2006-08-03 23:51:35.000000000 -0300
+++ ppc-2.6/include/linux/adb.h	2006-08-03 23:57:56.000000000 -0300
@@ -3,6 +3,7 @@
  */
 #ifndef __ADB_H
 #define __ADB_H
+#include <linux/device.h>
 
 /* ADB commands */
 #define ADB_BUSRESET		0
@@ -58,6 +59,7 @@
 struct adb_ids {
 	int nids;
 	unsigned char id[16];
+	struct class_device *device[16];
 };
 
 /* Structure which encapsulates a low-level ADB driver */
