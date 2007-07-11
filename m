Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 72C9BDDE49
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 23:55:17 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l6BDnjIN026392
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 09:49:45 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6BDtDwG230354
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 07:55:13 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6BDtCC3027971
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 07:55:13 -0600
Subject: [RFC][PATCH 2/8] 4xx boot wrapper reworks
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 11 Jul 2007 08:55:12 -0500
Message-Id: <1184162112.32199.56.camel@weaponx.rchland.ibm.com>
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

Rename the 44x.c wrapper file to 4xx.c and make the fixup_memsize function
common for all of 4xx.  Also adds a common function to reset ethernet and a
40x reset function.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/boot/44x.c    |   85 ----------------------------------
 arch/powerpc/boot/44x.h    |    4 -
 arch/powerpc/boot/4xx.c    |  111 +++++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/4xx.h    |   20 ++++++++
 arch/powerpc/boot/Makefile |    4 -
 arch/powerpc/boot/dcr.h    |    2 
 arch/powerpc/boot/ebony.c  |    3 -
 7 files changed, 137 insertions(+), 92 deletions(-)

--- linux-2.6.orig/arch/powerpc/boot/44x.h
+++ linux-2.6/arch/powerpc/boot/44x.h
@@ -10,10 +10,6 @@
 #ifndef _PPC_BOOT_44X_H_
 #define _PPC_BOOT_44X_H_
 
-void ibm44x_fixup_memsize(void);
-void ibm4xx_fixup_ebc_ranges(const char *ebc);
-
-void ibm44x_dbcr_reset(void);
 void ebony_init(void *mac0, void *mac1);
 
 #endif /* _PPC_BOOT_44X_H_ */
--- /dev/null
+++ linux-2.6/arch/powerpc/boot/4xx.c
@@ -0,0 +1,111 @@
+/*
+ * Copyright 2007 David Gibson, IBM Corporation.
+ *
+ * Based on earlier code:
+ *   Matt Porter <mporter@kernel.crashing.org>
+ *   Copyright 2002-2005 MontaVista Software Inc.
+ *
+ *   Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ *   Copyright (c) 2003, 2004 Zultys Technologies
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <stddef.h>
+#include "types.h"
+#include "string.h"
+#include "stdio.h"
+#include "ops.h"
+#include "reg.h"
+#include "dcr.h"
+
+/* Read the 4xx SDRAM controller to get size of system memory. */
+void ibm4xx_fixup_memsize(void)
+{
+	int i;
+	unsigned long memsize, bank_config;
+
+	memsize = 0;
+	for (i = 0; i < ARRAY_SIZE(sdram_bxcr); i++) {
+		mtdcr(DCRN_SDRAM0_CFGADDR, sdram_bxcr[i]);
+		bank_config = mfdcr(DCRN_SDRAM0_CFGDATA);
+
+		if (bank_config & SDRAM_CONFIG_BANK_ENABLE)
+			memsize += SDRAM_CONFIG_BANK_SIZE(bank_config);
+	}
+
+	dt_fixup_memory(0, memsize);
+}
+
+#define DBCR0_RST_SYSTEM 0x30000000
+
+void ibm44x_dbcr_reset(void)
+{
+	unsigned long tmp;
+
+	/* DBCR0 on 44x is SPRN 0x134 */
+	asm volatile (
+		"mfspr	%0,%1\n"
+		"oris	%0,%0,%2@h\n"
+		"mtspr	%1,%0"
+		: "=&r"(tmp) : "i"(0x134), "i"(DBCR0_RST_SYSTEM)
+		);
+
+}
+
+void ibm40x_dbcr_reset(void)
+{
+	unsigned long tmp;
+
+	/* DBCR0 on 4xx is SPRN 0x3F2 */
+	asm volatile (
+		"mfspr	%0,%1\n"
+		"oris	%0,%0,%2@h\n"
+		"mtspr	%1,%0"
+		: "=&r"(tmp) : "i"(0x3F2), "i"(DBCR0_RST_SYSTEM)
+		);
+}
+
+#define EMAC_RESET 0x20000000
+#define MAL_RESET 0x80000000
+void ibm4xx_reset_eth(u32 *emac0, u32 *emac1)
+{
+	/* Reset the MAL and EMAC(s) since PIBS/OpenBIOS don't do this for us */
+	if (emac0)
+		*emac0 = EMAC_RESET;
+	if (emac1)
+		*emac1 = EMAC_RESET;
+
+	mtdcr(DCRN_MAL0_CFG, MAL_RESET);
+}
+
+/* Read 4xx EBC bus bridge registers to get mappings of the peripheral
+ * banks into the OPB address space */
+void ibm4xx_fixup_ebc_ranges(const char *ebc)
+{
+	void *devp;
+	u32 bxcr;
+	u32 ranges[EBC_NUM_BANKS*4];
+	u32 *p = ranges;
+	int i;
+
+	for (i = 0; i < EBC_NUM_BANKS; i++) {
+		mtdcr(DCRN_EBC0_CFGADDR, EBC_BXCR(i));
+		bxcr = mfdcr(DCRN_EBC0_CFGDATA);
+
+		if ((bxcr & EBC_BXCR_BU) != EBC_BXCR_BU_OFF) {
+			*p++ = i;
+			*p++ = 0;
+			*p++ = bxcr & EBC_BXCR_BAS;
+			*p++ = EBC_BXCR_BANK_SIZE(bxcr);
+		}
+	}
+
+	devp = finddevice(ebc);
+	if (! devp)
+		fatal("Couldn't locate EBC node %s\n\r", ebc);
+
+	setprop(devp, "ranges", ranges, (p - ranges) * sizeof(u32));
+}
--- /dev/null
+++ linux-2.6/arch/powerpc/boot/4xx.h
@@ -0,0 +1,20 @@
+/*
+ * PowerPC 4xx related functions
+ *
+ * Copyright 2007 IBM Corporation.
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#ifndef _POWERPC_BOOT_4XX_H_
+#define _POWERPC_BOOT_4XX_H_
+
+void ibm4xx_fixup_memsize(void);
+void ibm44x_dbcr_reset(void);
+void ibm40x_dbcr_reset(void);
+void ibm4xx_reset_eth(u32 *emac0, u32 *emac1);
+void ibm4xx_fixup_ebc_ranges(const char *ebc);
+
+#endif /* _POWERPC_BOOT_4XX_H_ */
--- linux-2.6.orig/arch/powerpc/boot/dcr.h
+++ linux-2.6/arch/powerpc/boot/dcr.h
@@ -121,4 +121,6 @@ static const unsigned long sdram_bxcr[] 
 #define DCRN_CPC0_MIRQ1					0x0ed
 #define DCRN_CPC0_JTAGID				0x0ef
 
+#define DCRN_MAL0_CFG					0x180
+
 #endif	/* _PPC_BOOT_DCR_H_ */
--- linux-2.6.orig/arch/powerpc/boot/ebony.c
+++ linux-2.6/arch/powerpc/boot/ebony.c
@@ -25,6 +25,7 @@
 #include "ops.h"
 #include "reg.h"
 #include "dcr.h"
+#include "4xx.h"
 #include "44x.h"
 
 extern char _dtb_start[];
@@ -98,7 +99,7 @@ static void ebony_fixups(void)
 	unsigned long sysclk = 33000000;
 
 	ibm440gp_fixup_clocks(sysclk, 6 * 1843200);
-	ibm44x_fixup_memsize();
+	ibm4xx_fixup_memsize();
 	dt_fixup_mac_addresses(ebony_mac0, ebony_mac1);
 	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
 }
--- linux-2.6.orig/arch/powerpc/boot/Makefile
+++ linux-2.6/arch/powerpc/boot/Makefile
@@ -31,7 +31,7 @@ endif
 
 BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
 
-$(obj)/44x.o: BOOTCFLAGS += -mcpu=440
+$(obj)/4xx.o: BOOTCFLAGS += -mcpu=440
 $(obj)/ebony.o: BOOTCFLAGS += -mcpu=440
 
 zlib       := inffast.c inflate.c inftrees.c
@@ -44,7 +44,7 @@ $(addprefix $(obj)/,$(zlib) gunzip_util.
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
-		44x.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c
+		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c
--- linux-2.6.orig/arch/powerpc/boot/44x.c
+++ /dev/null
@@ -1,85 +0,0 @@
-/*
- * Copyright 2007 David Gibson, IBM Corporation.
- *
- * Based on earlier code:
- *   Matt Porter <mporter@kernel.crashing.org>
- *   Copyright 2002-2005 MontaVista Software Inc.
- *
- *   Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
- *   Copyright (c) 2003, 2004 Zultys Technologies
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#include <stddef.h>
-#include "types.h"
-#include "string.h"
-#include "stdio.h"
-#include "ops.h"
-#include "reg.h"
-#include "dcr.h"
-
-/* Read the 44x memory controller to get size of system memory. */
-void ibm44x_fixup_memsize(void)
-{
-	int i;
-	unsigned long memsize, bank_config;
-
-	memsize = 0;
-	for (i = 0; i < ARRAY_SIZE(sdram_bxcr); i++) {
-		mtdcr(DCRN_SDRAM0_CFGADDR, sdram_bxcr[i]);
-		bank_config = mfdcr(DCRN_SDRAM0_CFGDATA);
-
-		if (bank_config & SDRAM_CONFIG_BANK_ENABLE)
-			memsize += SDRAM_CONFIG_BANK_SIZE(bank_config);
-	}
-
-	dt_fixup_memory(0, memsize);
-}
-
-#define SPRN_DBCR0		0x134
-#define   DBCR0_RST_SYSTEM	0x30000000
-
-void ibm44x_dbcr_reset(void)
-{
-	unsigned long tmp;
-
-	asm volatile (
-		"mfspr	%0,%1\n"
-		"oris	%0,%0,%2@h\n"
-		"mtspr	%1,%0"
-		: "=&r"(tmp) : "i"(SPRN_DBCR0), "i"(DBCR0_RST_SYSTEM)
-		);
-
-}
-
-/* Read 4xx EBC bus bridge registers to get mappings of the peripheral
- * banks into the OPB address space */
-void ibm4xx_fixup_ebc_ranges(const char *ebc)
-{
-	void *devp;
-	u32 bxcr;
-	u32 ranges[EBC_NUM_BANKS*4];
-	u32 *p = ranges;
-	int i;
-
-	for (i = 0; i < EBC_NUM_BANKS; i++) {
-		mtdcr(DCRN_EBC0_CFGADDR, EBC_BXCR(i));
-		bxcr = mfdcr(DCRN_EBC0_CFGDATA);
-
-		if ((bxcr & EBC_BXCR_BU) != EBC_BXCR_BU_OFF) {
-			*p++ = i;
-			*p++ = 0;
-			*p++ = bxcr & EBC_BXCR_BAS;
-			*p++ = EBC_BXCR_BANK_SIZE(bxcr);
-		}
-	}
-
-	devp = finddevice(ebc);
-	if (! devp)
-		fatal("Couldn't locate EBC node %s\n\r", ebc);
-
-	setprop(devp, "ranges", ranges, (p - ranges) * sizeof(u32));
-}
