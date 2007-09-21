Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E2297DDED3
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 09:03:32 +1000 (EST)
Date: Fri, 21 Sep 2007 18:03:24 -0500 (CDT)
Subject: [PATCH 1/15] boot: find initrd location from device-tree
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-8-01.miltonm@bga.com>
In-Reply-To: <boot-8-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>, Rob Landley <rob@landley.net>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some platforms have a boot agent that can create or modify properties in
the device-tree and load images into memory.  Provide a helper to set
loader_info used by prep_initrd().

Signed-off-by: Milton Miller <miltonm@bga.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
--- 
re 12168
rediffed types.h, offset in ops.h

Index: kernel/arch/powerpc/boot/ops.h
===================================================================
--- kernel.orig/arch/powerpc/boot/ops.h	2007-09-17 22:12:47.000000000 -0500
+++ kernel/arch/powerpc/boot/ops.h	2007-09-17 22:12:51.000000000 -0500
@@ -163,6 +163,7 @@ void dt_fixup_clock(const char *path, u3
 void __dt_fixup_mac_addresses(u32 startindex, ...);
 #define dt_fixup_mac_addresses(...) \
 	__dt_fixup_mac_addresses(0, __VA_ARGS__, NULL)
+void dt_find_initrd(void);
 
 
 static inline void *find_node_by_linuxphandle(const u32 linuxphandle)
Index: kernel/arch/powerpc/boot/types.h
===================================================================
--- kernel.orig/arch/powerpc/boot/types.h	2007-09-17 22:12:47.000000000 -0500
+++ kernel/arch/powerpc/boot/types.h	2007-09-17 22:12:51.000000000 -0500
@@ -12,6 +12,8 @@ typedef short			s16;
 typedef int			s32;
 typedef long long		s64;
 
+#define UINT_MAX	0xFFFFFFFF
+
 #define min(x,y) ({ \
 	typeof(x) _x = (x);	\
 	typeof(y) _y = (y);	\
Index: kernel/arch/powerpc/boot/devtree.c
===================================================================
--- kernel.orig/arch/powerpc/boot/devtree.c	2007-09-17 22:12:47.000000000 -0500
+++ kernel/arch/powerpc/boot/devtree.c	2007-09-17 22:12:51.000000000 -0500
@@ -1,6 +1,7 @@
 /*
  * devtree.c - convenience functions for device tree manipulation
  * Copyright 2007 David Gibson, IBM Corporation.
+ * Copyright 2007 Milton Miller, IBM Corporation.
  * Copyright (c) 2007 Freescale Semiconductor, Inc.
  *
  * Authors: David Gibson <david@gibson.dropbear.id.au>
@@ -333,3 +334,68 @@ int dt_is_compatible(void *node, const c
 
 	return 0;
 }
+
+/**
+ * dt_find_initrd - set loader initrd location based on existing properties
+ *
+ * finds the linux,initrd-start and linux,initrd-end properties in
+ * the /chosen node and sets the loader initrd fields accordingly.
+ *
+ * Use this if your loader sets the properties to allow other code to
+ * relocate the tree and/or cause r3 and r4 to be set on true OF
+ * platforms.
+ */
+void dt_find_initrd(void)
+{
+	int rc;
+	unsigned long long initrd_start, initrd_end;
+	void *devp;
+	static const char start_prop[] = "linux,initrd-start";
+	static const char end_prop[] = "linux,initrd-end";
+
+	devp = finddevice("/chosen");
+	if (! devp) {
+		return;
+	}
+
+	rc = getprop(devp, start_prop, &initrd_start, sizeof(initrd_start));
+	if (rc < 0)
+		return;				/* not found */
+	/* The properties had to be 8 bytes until 2.6.22 */
+	if (rc == sizeof(unsigned long)) {
+		unsigned long tmp;
+		memcpy(&tmp, &initrd_start, rc);
+		initrd_start = tmp;
+	} else if (rc != sizeof(initrd_start)) {	/* now they can be 4 */
+		printf("unexpected length of %s in /chosen!\n\r", start_prop);
+		return;
+	}
+
+	rc = getprop(devp, end_prop, &initrd_end, sizeof(initrd_end));
+	if (rc < 0) {
+		printf("chosen has %s but no %s!\n\r", start_prop, end_prop);
+		return;
+	}
+	if (rc == sizeof(unsigned long)) {
+		unsigned long tmp;
+		memcpy(&tmp, &initrd_end, rc);
+		initrd_end = tmp;
+	} else if (rc != sizeof(initrd_end)) {
+		printf("unexpected length of %s in /chosen!\n\r", end_prop);
+		return;
+	}
+
+	/* Check for presence, ignore if (partially) loaded above 32 bits */
+	if (initrd_start == initrd_end) {
+		printf("ignoring empty device-tree supplied initrd\n");
+	} else if (initrd_start > initrd_end) {
+		printf("ignoring device-tree supplied initrd: start 0x%llx"
+				" > end 0x%llx \n", initrd_start, initrd_end);
+	} else if (initrd_end > UINT_MAX) {
+		printf("ignoring device-tree supplied initrd:"
+				" end 0x%llx > 32 bits\n", initrd_end);
+	} else {
+		loader_info.initrd_addr = initrd_start;
+		loader_info.initrd_size  = initrd_end - initrd_start;
+	}
+}
