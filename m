Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 73A55DDF3D
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 04:54:59 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l7EIrtTD012511
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 22:53:55 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l7EIrtus012508
	for linuxppc-dev@ozlabs.org; Tue, 14 Aug 2007 22:53:55 +0400
Date: Tue, 14 Aug 2007 22:53:55 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] PowerPC 440EPx: Sequoia bootwrapper
Message-ID: <20070814185355.GA12472@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070814184107.GA6696@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bootwrapper code for AMCC 440EPx Sequoia board.
The DDR2 Denali controller support has been moved to
 arch/powerpc/boot/4xx.c
The code also uses 440EP clocking fixups
initially provided for 440EP Bamboo.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/boot/44x.h            |    1 
 arch/powerpc/boot/4xx.c            |  108 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/4xx.h            |    1 
 arch/powerpc/boot/Makefile         |    6 +-
 arch/powerpc/boot/cuboot-sequoia.c |   31 ++++++++++
 arch/powerpc/boot/sequoia.c        |   48 ++++++++++++++++
 6 files changed, 193 insertions(+), 2 deletions(-)

diff -ruN linux-2.6.orig/arch/powerpc/boot/44x.h linux-2.6/arch/powerpc/boot/44x.h
--- linux-2.6.orig/arch/powerpc/boot/44x.h	2007-08-14 17:11:16.000000000 +0400
+++ linux-2.6/arch/powerpc/boot/44x.h	2007-08-14 17:25:37.000000000 +0400
@@ -12,5 +12,6 @@
 
 void ebony_init(void *mac0, void *mac1);
 void bamboo_init(void);
+void sequoia_init(void *mac0, void *mac1);
 
 #endif /* _PPC_BOOT_44X_H_ */
diff -ruN linux-2.6.orig/arch/powerpc/boot/4xx.c linux-2.6/arch/powerpc/boot/4xx.c
--- linux-2.6.orig/arch/powerpc/boot/4xx.c	2007-08-14 17:11:16.000000000 +0400
+++ linux-2.6/arch/powerpc/boot/4xx.c	2007-08-14 20:16:57.000000000 +0400
@@ -39,6 +39,114 @@
 	dt_fixup_memory(0, memsize);
 }
 
+/* 4xx DDR1/2 Denali memory controller support */
+/* DDR0 registers */
+#define DDR0_02			2
+#define DDR0_08			8
+#define DDR0_10			10
+#define DDR0_14			14
+#define DDR0_42			42
+#define DDR0_43			43
+
+/* DDR0_02 */
+#define DDR_START		0x1
+#define DDR_START_SHIFT		0
+#define DDR_MAX_CS_REG		0x3
+#define DDR_MAX_CS_REG_SHIFT	24
+#define DDR_MAX_COL_REG		0xf
+#define DDR_MAX_COL_REG_SHIFT	16
+#define DDR_MAX_ROW_REG		0xf
+#define DDR_MAX_ROW_REG_SHIFT	8
+/* DDR0_08 */
+#define DDR_DDR2_MODE		0x1
+#define DDR_DDR2_MODE_SHIFT	0
+/* DDR0_10 */
+#define DDR_CS_MAP		0x3
+#define DDR_CS_MAP_SHIFT	8
+/* DDR0_14 */
+#define DDR_REDUC		0x1
+#define DDR_REDUC_SHIFT		16
+/* DDR0_42 */
+#define DDR_APIN		0x7
+#define DDR_APIN_SHIFT		24
+/* DDR0_43 */
+#define DDR_COL_SZ		0x7
+#define DDR_COL_SZ_SHIFT	8
+#define DDR_BANK8		0x1
+#define DDR_BANK8_SHIFT		0
+
+#define DDR_GET_VAL(val, mask, shift)	(((val) >> (shift)) & (mask))
+
+static inline u32 mfdcr_sdram0(u32 reg)
+{
+        mtdcr(DCRN_SDRAM0_CFGADDR, reg);
+        return mfdcr(DCRN_SDRAM0_CFGDATA);
+}
+
+void ibm4xx_denali_fixup_memsize(void)
+{
+	u32 val, max_cs, max_col, max_row;
+	u32 cs, col, row, bank, dpath;
+	unsigned long memsize;
+
+	val = mfdcr_sdram0(DDR0_02);
+	if (!DDR_GET_VAL(val, DDR_START, DDR_START_SHIFT))
+		fatal("DDR controller is not initialized\n");
+
+	/* get maximum cs col and row values */
+	max_cs  = DDR_GET_VAL(val, DDR_MAX_CS_REG, DDR_MAX_CS_REG_SHIFT);
+	max_col = DDR_GET_VAL(val, DDR_MAX_COL_REG, DDR_MAX_COL_REG_SHIFT);
+	max_row = DDR_GET_VAL(val, DDR_MAX_ROW_REG, DDR_MAX_ROW_REG_SHIFT);
+
+	/* get CS value */
+	val = mfdcr_sdram0(DDR0_10);
+
+	val = DDR_GET_VAL(val, DDR_CS_MAP, DDR_CS_MAP_SHIFT);
+	cs = 0;
+	while (val) {
+		if (val && 0x1)
+			cs++;
+		val = val >> 1;
+	}
+
+	if (!cs)
+		fatal("No memory installed\n");
+	if (cs > max_cs)
+		fatal("DDR wrong CS configuration\n");
+
+	/* get data path bytes */
+	val = mfdcr_sdram0(DDR0_14);
+
+	if (DDR_GET_VAL(val, DDR_REDUC, DDR_REDUC_SHIFT))
+		dpath = 8; /* 64 bits */
+	else
+		dpath = 4; /* 32 bits */
+
+	/* get adress pins (rows) */
+	val = mfdcr_sdram0(DDR0_42);
+
+	row = DDR_GET_VAL(val, DDR_APIN, DDR_APIN_SHIFT);
+	if (row > max_row)
+		fatal("DDR wrong APIN configuration\n");
+	row = max_row - row;
+
+	/* get collomn size and banks */
+	val = mfdcr_sdram0(DDR0_43);
+
+	col = DDR_GET_VAL(val, DDR_COL_SZ, DDR_COL_SZ_SHIFT);
+	if (col > max_col)
+		fatal("DDR wrong COL configuration\n");
+	col = max_col - col;
+
+	if (DDR_GET_VAL(val, DDR_BANK8, DDR_BANK8_SHIFT))
+		bank = 8; /* 8 banks */
+	else
+		bank = 4; /* 4 banks */
+
+	memsize = cs * (1 << (col+row)) * bank * dpath;
+	dt_fixup_memory(0, memsize);
+}
+
 #define DBCR0_RST_SYSTEM 0x30000000
 
 void ibm44x_dbcr_reset(void)
diff -ruN linux-2.6.orig/arch/powerpc/boot/4xx.h linux-2.6/arch/powerpc/boot/4xx.h
--- linux-2.6.orig/arch/powerpc/boot/4xx.h	2007-08-14 17:11:16.000000000 +0400
+++ linux-2.6/arch/powerpc/boot/4xx.h	2007-08-14 20:24:22.000000000 +0400
@@ -12,6 +12,7 @@
 #define _POWERPC_BOOT_4XX_H_
 
 void ibm4xx_fixup_memsize(void);
+void ibm4xx_denali_fixup_memsize(void);
 void ibm44x_dbcr_reset(void);
 void ibm40x_dbcr_reset(void);
 void ibm4xx_quiesce_eth(u32 *emac0, u32 *emac1);
diff -ruN linux-2.6.orig/arch/powerpc/boot/cuboot-sequoia.c linux-2.6/arch/powerpc/boot/cuboot-sequoia.c
--- linux-2.6.orig/arch/powerpc/boot/cuboot-sequoia.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/arch/powerpc/boot/cuboot-sequoia.c	2007-08-14 17:25:37.000000000 +0400
@@ -0,0 +1,31 @@
+/*
+ * Old U-boot compatibility for Sequoia
+ *
+ * Based on Ebony code by David Gibson <david@gibson.dropbear.id.au>
+ *
+ * Copyright 2007 David Gibson, IBM Corporatio.
+ *   Based on cuboot-83xx.c, which is:
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
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
+#define TARGET_4xx
+#define TARGET_44x
+#include "ppcboot.h"
+
+static bd_t bd;
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                   unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+	sequoia_init(&bd.bi_enetaddr, &bd.bi_enet1addr);
+}
diff -ruN linux-2.6.orig/arch/powerpc/boot/Makefile linux-2.6/arch/powerpc/boot/Makefile
--- linux-2.6.orig/arch/powerpc/boot/Makefile	2007-08-14 17:11:16.000000000 +0400
+++ linux-2.6/arch/powerpc/boot/Makefile	2007-08-14 17:25:38.000000000 +0400
@@ -44,10 +44,11 @@
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
-		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c
+		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
+		sequoia.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
-		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c
+		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-sequoia.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -143,6 +144,7 @@
 image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
 image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
 image-$(CONFIG_BAMBOO)			+= treeImage.bamboo
+image-$(CONFIG_SEQUOIA)			+= cuImage.sequoia
 endif
 
 # For 32-bit powermacs, build the COFF and miboot images
diff -ruN linux-2.6.orig/arch/powerpc/boot/sequoia.c linux-2.6/arch/powerpc/boot/sequoia.c
--- linux-2.6.orig/arch/powerpc/boot/sequoia.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/arch/powerpc/boot/sequoia.c	2007-08-14 20:52:10.000000000 +0400
@@ -0,0 +1,48 @@
+/*
+ * Valentine Barshak <vbarshak@ru.mvista.com>
+ * Copyright 2007 MontaVista Software, Inc
+ *
+ * Based on Bamboo code by Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ * Copyright IBM Corporation, 2007
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the License
+ */
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "elf.h"
+#include "string.h"
+#include "stdio.h"
+#include "page.h"
+#include "ops.h"
+#include "dcr.h"
+#include "4xx.h"
+#include "44x.h"
+
+extern char _dtb_start[];
+extern char _dtb_end[];
+
+static u8 *sequoia_mac0, *sequoia_mac1;
+
+
+static void sequoia_fixups(void)
+{
+	unsigned long sysclk = 33333333;
+
+	ibm440ep_fixup_clocks(sysclk, 11059200);
+	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
+	ibm4xx_denali_fixup_memsize();
+	dt_fixup_mac_addresses(sequoia_mac0, sequoia_mac1);
+}
+
+void sequoia_init(void *mac0, void *mac1)
+{
+	platform_ops.fixups = sequoia_fixups;
+	platform_ops.exit = ibm44x_dbcr_reset;
+	sequoia_mac0 = mac0;
+	sequoia_mac1 = mac1;
+	ft_init(_dtb_start, 0, 32);
+	serial_console_init();
+}
