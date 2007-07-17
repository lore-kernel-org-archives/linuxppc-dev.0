Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EFAC0DDF23
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 04:33:07 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6HIX58i026023
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 14:33:05 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6HIX2qo263676
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:33:04 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6HIWqvN002642
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:32:52 -0600
Received: from [9.10.86.36] (weaponx.rchland.ibm.com [9.10.86.36])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l6HIWpRx002598
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:32:52 -0600
Message-Id: <20070717182622.261716000@linux.vnet.ibm.com>>
References: <20070717181547.310201000@linux.vnet.ibm.com>>
Date: Tue, 17 Jul 2007 13:15:58 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 11/14] Walnut zImage wrapper
In-Reply-To: <20070717181547.310201000@linux.vnet.ibm.com>>
Content-Type: text/plain
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add zImage wrapper for walnut board

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/boot/Makefile          |    3 -
 arch/powerpc/boot/treeboot-walnut.c |   92 ++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)

--- linux-2.6.orig/arch/powerpc/boot/Makefile
+++ linux-2.6/arch/powerpc/boot/Makefile
@@ -47,7 +47,7 @@ src-wlib := string.S crt0.S stdio.c main
 		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
-		ps3-head.S ps3-hvcall.S ps3.c
+		ps3-head.S ps3-hvcall.S ps3.c treeboot-walnut.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -142,6 +142,7 @@ ifneq ($(CONFIG_DEVICE_TREE),"")
 image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
 image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
 image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
+image-$(CONFIG_WALNUT)			+= treeImage.walnut
 endif
 
 # For 32-bit powermacs, build the COFF and miboot images
--- /dev/null
+++ linux-2.6/arch/powerpc/boot/treeboot-walnut.c
@@ -0,0 +1,92 @@
+/*
+ * Old U-boot compatibility for Walnut
+ *
+ * Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * Copyright 2007 IBM Corporation
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
+#include "dcr.h"
+#include "4xx.h"
+
+extern char _end[];
+extern char _dtb_start[];
+extern char _dtb_end[];
+
+BSS_STACK(4096);
+
+void ibm405gp_fixup_clocks(unsigned int sysclk, unsigned int ser_clk)
+{
+	u32 pllmr = mfdcr(0xb0);
+	u32 cpc0_cr0 = mfdcr(0xb1);
+	u32 cpc0_cr1 = mfdcr(0xb2);
+	u32 cpu, plb, opb, ebc, tb, uart0, uart1, m;
+	u32 fwdv, fbdv, cbdv, opdv, epdv, udiv;
+
+	fwdv = (8 - ((pllmr & 0xe0000000) >> 29));
+	fbdv = (pllmr & 0x1e000000) >> 25;
+	cbdv = ((pllmr & 0x00060000) >> 17) + 1;
+	opdv = ((pllmr & 0x00018000) >> 15) + 1;
+	epdv = ((pllmr & 0x00001800) >> 13) + 2;
+	udiv = ((cpc0_cr0 & 0x3e) >> 1) + 1;
+
+	m = fwdv * fbdv * cbdv;
+
+	cpu = sysclk * m / fwdv;
+	plb = cpu / cbdv;
+	opb = plb / opdv;
+	ebc = plb / epdv;
+
+	if (cpc0_cr0 & 0x80) {
+		/* uart0 uses the external clock */
+		uart0 = ser_clk;
+	} else {
+		uart0 = cpu / udiv;
+	}
+
+	if (cpc0_cr0 & 0x40) {
+		/* uart1 uses the external clock */
+		uart1 = ser_clk;
+	} else {
+		uart1 = cpu / udiv;
+	}
+
+	/* setup the timebase clock to tick at the cpu frequency */
+	cpc0_cr1 = cpc0_cr1 & ~ 0x00800000;
+	mtdcr(0xb2, cpc0_cr1);
+	tb = cpu;
+
+	dt_fixup_cpu_clocks(cpu, tb, 0);
+	dt_fixup_clock("/plb", plb);
+	dt_fixup_clock("/plb/opb", opb);
+	dt_fixup_clock("/plb/ebc", ebc);
+	dt_fixup_clock("/plb/opb/serial@300", uart0);
+	dt_fixup_clock("/plb/opb/serial@400", uart1);
+}
+
+static void walnut_fixups(void)
+{
+	ibm4xx_fixup_memsize();
+	ibm405gp_fixup_clocks(33330000, 0xa8c000);
+	ibm4xx_reset_eth((u32 *)0xef600800, NULL);
+}
+
+void platform_init(void)
+{
+	unsigned long end_of_ram = 0x2000000;
+	unsigned long avail_ram = end_of_ram - (unsigned long) _end;
+
+	simple_alloc_init(_end, avail_ram, 32, 32);
+	platform_ops.fixups = walnut_fixups;
+	platform_ops.exit = ibm40x_dbcr_reset;
+	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	serial_console_init();
+}

-- 
