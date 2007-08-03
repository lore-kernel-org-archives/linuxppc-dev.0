Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 11B5BDDE32
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 02:33:13 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l73GXATe004879
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 12:33:10 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l73GXArs207120
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 10:33:10 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l73GXAPf026317
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 10:33:10 -0600
Message-Id: <20070803161710.524454000@linux.vnet.ibm.com>>
References: <20070803160900.069522000@linux.vnet.ibm.com>>
Date: Fri, 03 Aug 2007 11:09:03 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [patch 03/10] Rename 44x bootwrapper
In-Reply-To: <20070803160900.069522000@linux.vnet.ibm.com>>
Content-Type: text/plain
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rename the 44x.c wrapper file to 4xx.c.  This will allow us to add common
functions in a single file that can be shared across all of 4xx.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/boot/44x.c    |   85 ---------------------------------------------
 arch/powerpc/boot/4xx.c    |   85 +++++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/Makefile |    4 +-
 3 files changed, 87 insertions(+), 87 deletions(-)

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
--- /dev/null
+++ linux-2.6/arch/powerpc/boot/4xx.c
@@ -0,0 +1,85 @@
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
+/* Read the 44x memory controller to get size of system memory. */
+void ibm44x_fixup_memsize(void)
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
+#define SPRN_DBCR0		0x134
+#define   DBCR0_RST_SYSTEM	0x30000000
+
+void ibm44x_dbcr_reset(void)
+{
+	unsigned long tmp;
+
+	asm volatile (
+		"mfspr	%0,%1\n"
+		"oris	%0,%0,%2@h\n"
+		"mtspr	%1,%0"
+		: "=&r"(tmp) : "i"(SPRN_DBCR0), "i"(DBCR0_RST_SYSTEM)
+		);
+
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

-- 
