Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 823D0DDEEA
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 05:01:23 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8EJ1K4B003854
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 15:01:20 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8EJ17Zi383150
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 13:01:07 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8EJ16WP017541
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 13:01:06 -0600
Message-Id: <20070914185648.698807000@linux.vnet.ibm.com>>
References: <20070914185410.387074000@linux.vnet.ibm.com>>
Date: Fri, 14 Sep 2007 13:54:11 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 1/4] cuimage for Bamboo board
In-Reply-To: <20070914185410.387074000@linux.vnet.ibm.com>>
Content-Type: text/plain
Mime-Version: 1.0
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a cuboot wrapper for the Bamboo board.  This also removes some obsoleted
linker declarations that have been moved into ops.h

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/boot/44x.h             |    2 +-
 arch/powerpc/boot/Makefile          |    4 ++--
 arch/powerpc/boot/bamboo.c          |    8 +++++---
 arch/powerpc/boot/cuboot-bamboo.c   |   30 ++++++++++++++++++++++++++++++
 arch/powerpc/boot/treeboot-bamboo.c |   22 +++++++++++++++++++---
 5 files changed, 57 insertions(+), 9 deletions(-)

--- linux-2.6.orig/arch/powerpc/boot/Makefile
+++ linux-2.6/arch/powerpc/boot/Makefile
@@ -49,7 +49,7 @@ src-wlib := string.S crt0.S stdio.c main
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
-		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c
+		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-bamboo.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -146,7 +146,7 @@ image-$(CONFIG_8260)			+= cuImage.pq2
 image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
 image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
 image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
-image-$(CONFIG_BAMBOO)			+= treeImage.bamboo
+image-$(CONFIG_BAMBOO)			+= treeImage.bamboo cuImage.bamboo
 image-$(CONFIG_SEQUOIA)			+= cuImage.sequoia
 image-$(CONFIG_WALNUT)			+= treeImage.walnut
 endif
--- /dev/null
+++ linux-2.6/arch/powerpc/boot/cuboot-bamboo.c
@@ -0,0 +1,30 @@
+/*
+ * Old U-boot compatibility for Ebony
+ *
+ * Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * Copyright 2007 IBM Corporation
+ *
+ * Based on cuboot-ebony.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "44x.h"
+#include "cuboot.h"
+
+#define TARGET_44x
+#include "ppcboot.h"
+
+static bd_t bd;
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+		unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+	bamboo_init(&bd.bi_enetaddr, &bd.bi_enet1addr);
+}
--- linux-2.6.orig/arch/powerpc/boot/44x.h
+++ linux-2.6/arch/powerpc/boot/44x.h
@@ -11,6 +11,6 @@
 #define _PPC_BOOT_44X_H_
 
 void ebony_init(void *mac0, void *mac1);
-void bamboo_init(void);
+void bamboo_init(void *mac0, void *mac1);
 
 #endif /* _PPC_BOOT_44X_H_ */
--- linux-2.6.orig/arch/powerpc/boot/bamboo.c
+++ linux-2.6/arch/powerpc/boot/bamboo.c
@@ -24,8 +24,7 @@
 #include "4xx.h"
 #include "44x.h"
 
-extern char _dtb_start[];
-extern char _dtb_end[];
+static u8 *bamboo_mac0, *bamboo_mac1;
 
 static void bamboo_fixups(void)
 {
@@ -34,12 +33,15 @@ static void bamboo_fixups(void)
 	ibm440ep_fixup_clocks(sysclk, 11059200);
 	ibm4xx_fixup_memsize();
 	ibm4xx_quiesce_eth((u32 *)0xef600e00, (u32 *)0xef600f00);
+	dt_fixup_mac_addresses(bamboo_mac0, bamboo_mac1);
 }
 
-void bamboo_init(void)
+void bamboo_init(void *mac0, void *mac1)
 {
 	platform_ops.fixups = bamboo_fixups;
 	platform_ops.exit = ibm44x_dbcr_reset;
+	bamboo_mac0 = mac0;
+	bamboo_mac1 = mac1;
 	ft_init(_dtb_start, 0, 32);
 	serial_console_init();
 }
--- linux-2.6.orig/arch/powerpc/boot/treeboot-bamboo.c
+++ linux-2.6/arch/powerpc/boot/treeboot-bamboo.c
@@ -12,16 +12,32 @@
 #include "ops.h"
 #include "stdio.h"
 #include "44x.h"
-
-extern char _end[];
+#include "stdlib.h"
 
 BSS_STACK(4096);
 
+#define PIBS_MAC0 0xfffc0400
+#define PIBS_MAC1 0xfffc0500
+char pibs_mac0[6];
+char pibs_mac1[6];
+
+static void read_pibs_mac(void)
+{
+	unsigned long long mac64;
+
+	mac64 = strtoull((char *)PIBS_MAC0, 0, 16);
+	memcpy(&pibs_mac0, (char *)&mac64+2, 6);
+
+	mac64 = strtoull((char *)PIBS_MAC1, 0, 16);
+	memcpy(&pibs_mac1, (char *)&mac64+2, 6);
+}
+
 void platform_init(void)
 {
 	unsigned long end_of_ram = 0x8000000;
 	unsigned long avail_ram = end_of_ram - (unsigned long)_end;
 
 	simple_alloc_init(_end, avail_ram, 32, 64);
-	bamboo_init();
+	read_pibs_mac();
+	bamboo_init((u8 *)&pibs_mac0, (u8 *)&pibs_mac1);
 }

-- 
