Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id A411DDE11D
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 07:22:48 +1100 (EST)
Message-ID: <47852D16.2070906@pikatech.com>
Date: Wed, 09 Jan 2008 15:22:46 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] Warp Base Platform
References: <47852C41.8000506@pikatech.com>
In-Reply-To: <47852C41.8000506@pikatech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Basically the powerpc/boot directory files.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/arch/powerpc/boot/44x.h b/arch/powerpc/boot/44x.h
index 0256344..9db0213 100644
--- a/arch/powerpc/boot/44x.h
+++ b/arch/powerpc/boot/44x.h
@@ -12,5 +12,6 @@
 
 void ebony_init(void *mac0, void *mac1);
 void bamboo_init(void *mac0, void *mac1);
+void warp_init(void *mac0, void *mac1);
 
 #endif /* _PPC_BOOT_44X_H_ */
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index d1e625c..df0ef6f 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -56,13 +56,13 @@ src-wlib := string.S crt0.S stdio.c main.c \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
 		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
 		cpm-serial.c stdlib.c mpc52xx-psc.c planetcore.c uartlite.c \
-		fsl-soc.c mpc8xx.c pq2.c
+		fsl-soc.c mpc8xx.c pq2.c warp.c
 src-plat := of.c cuboot-52xx.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
 		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-bamboo.c \
 		fixed-head.S ep88xc.c cuboot-hpc2.c ep405.c cuboot-taishan.c \
-		cuboot-katmai.c cuboot-rainier.c
+		cuboot-katmai.c cuboot-rainier.c cuboot-warp.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -206,6 +206,7 @@ image-$(CONFIG_RAINIER)			+= cuImage.rainier
 image-$(CONFIG_WALNUT)			+= treeImage.walnut
 image-$(CONFIG_TAISHAN)			+= cuImage.taishan
 image-$(CONFIG_KATMAI)			+= cuImage.katmai
+image-$(CONFIG_WARP)			+= cuImage.warp
 endif
 
 # For 32-bit powermacs, build the COFF and miboot images
--- /dev/null	2005-11-20 22:22:37.000000000 -0500
+++ arch/powerpc/boot/cuboot-warp.c	2008-01-08 12:09:39.000000000 -0500
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2008 PIKA Technologies
+ *   Sean MacLennan <smaclennan@pikatech.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "44x.h"
+#include "cuboot.h"
+
+#define TARGET_44x
+#include "ppcboot.h"
+
+static bd_t bd;
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+				   unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+
+	warp_init(&bd.bi_enetaddr, &bd.bi_enet1addr);
+}
--- /dev/null	2005-11-20 22:22:37.000000000 -0500
+++ arch/powerpc/boot/warp.c	2008-01-08 12:09:54.000000000 -0500
@@ -0,0 +1,33 @@
+/*
+ * Copyright (c) 2008 PIKA Technologies
+ *   Sean MacLennan <smaclennan@pikatech.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the License
+ */
+#include "ops.h"
+#include "4xx.h"
+#include "44x.h"
+
+static u8 *warp_mac0, *warp_mac1;
+
+static void warp_fixups(void)
+{
+	unsigned long sysclk = 66000000;
+
+	ibm440ep_fixup_clocks(sysclk, 11059200, 50000000);
+	ibm4xx_sdram_fixup_memsize();
+	ibm4xx_quiesce_eth((u32 *)0xef600e00, (u32 *)0xef600f00);
+	dt_fixup_mac_addresses(warp_mac0, warp_mac1);
+}
+
+void warp_init(void *mac0, void *mac1)
+{
+	platform_ops.fixups = warp_fixups;
+	platform_ops.exit = ibm44x_dbcr_reset;
+	warp_mac0 = mac0;
+	warp_mac1 = mac1;
+	fdt_init(_dtb_start);
+	serial_console_init();
+}
