Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 521C5DE1C5
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 09:11:40 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1NMBGWT022180
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 17:11:16 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1NMBb1K013202
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 15:11:37 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1NMBbZn027769
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 15:11:37 -0700
Received: from zod.rchland.ibm.com (wecm-9-67-149-29.wecm.ibm.com
	[9.67.149.29])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m1NMBbGm027752
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 15:11:37 -0700
Date: Sat, 23 Feb 2008 16:10:56 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3][POWERPC] 4xx: Add bootwrapper for AMCC Yosemite board
Message-ID: <20080223161056.50197c7c@zod.rchland.ibm.com>
In-Reply-To: <20080223160813.2f8d282b@zod.rchland.ibm.com>
References: <20080223160813.2f8d282b@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the cuboot wrapper for the AMCC 440EP Yosemite board

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/boot/Makefile          |    3 +-
 arch/powerpc/boot/cuboot-yosemite.c |   42 ++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

--- linux-2.6.orig/arch/powerpc/boot/Makefile
+++ linux-2.6/arch/powerpc/boot/Makefile
@@ -64,7 +64,7 @@ src-plat := of.c cuboot-52xx.c cuboot-82
 		cuboot-bamboo.c cuboot-mpc7448hpc2.c cuboot-taishan.c \
 		fixed-head.S ep88xc.c ep405.c \
 		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
-		cuboot-warp.c cuboot-85xx-cpm2.c
+		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -216,6 +216,7 @@ image-$(CONFIG_RAINIER)			+= cuImage.rai
 image-$(CONFIG_TAISHAN)			+= cuImage.taishan
 image-$(CONFIG_KATMAI)			+= cuImage.katmai
 image-$(CONFIG_WARP)			+= cuImage.warp
+image-$(CONFIG_YOSEMITE)		+= cuImage.yosemite
 
 # Board ports in arch/powerpc/platform/8xx/Kconfig
 image-$(CONFIG_PPC_MPC86XADS)		+= cuImage.mpc866ads
--- /dev/null
+++ linux-2.6/arch/powerpc/boot/cuboot-yosemite.c
@@ -0,0 +1,42 @@
+/*
+ * Old U-boot compatibility for Yosemite
+ *
+ * Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * Copyright 2008 IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "4xx.h"
+#include "44x.h"
+#include "cuboot.h"
+
+#define TARGET_44x
+#include "ppcboot.h"
+
+static bd_t bd;
+
+static void yosemite_fixups(void)
+{
+	unsigned long sysclk = 66666666;
+
+	ibm440ep_fixup_clocks(sysclk, 11059200, 50000000);
+	ibm4xx_sdram_fixup_memsize();
+	ibm4xx_quiesce_eth((u32 *)0xef600e00, (u32 *)0xef600f00);
+	dt_fixup_mac_addresses(&bd.bi_enetaddr, &bd.bi_enet1addr);
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+		unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+	platform_ops.fixups = yosemite_fixups;
+	platform_ops.exit = ibm44x_dbcr_reset;
+	fdt_init(_dtb_start);
+	serial_console_init();
+}
