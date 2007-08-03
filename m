Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 00A57DDEBE
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 02:33:18 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l73GXGSa004927
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 12:33:16 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l73GXFpJ261704
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 10:33:15 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l73GXFuR026638
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 10:33:15 -0600
Message-Id: <20070803161711.457497000@linux.vnet.ibm.com>>
References: <20070803160900.069522000@linux.vnet.ibm.com>>
Date: Fri, 03 Aug 2007 11:09:10 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [patch 10/10] Bamboo zImage wrapper
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

Add a bootwrapper for the AMCC 440EP Bamboo Eval board.  This also adds a
common fixup_clock function for all 440EP(x) chips.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/boot/44x.h             |    1 
 arch/powerpc/boot/4xx.c             |   82 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/4xx.h             |    1 
 arch/powerpc/boot/Makefile          |    5 +-
 arch/powerpc/boot/bamboo.c          |   45 +++++++++++++++++++
 arch/powerpc/boot/dcr.h             |   10 ++++
 arch/powerpc/boot/treeboot-bamboo.c |   27 +++++++++++
 7 files changed, 169 insertions(+), 2 deletions(-)

--- linux-2.6.orig/arch/powerpc/boot/44x.h
+++ linux-2.6/arch/powerpc/boot/44x.h
@@ -11,5 +11,6 @@
 #define _PPC_BOOT_44X_H_
 
 void ebony_init(void *mac0, void *mac1);
+void bamboo_init(void);
 
 #endif /* _PPC_BOOT_44X_H_ */
--- linux-2.6.orig/arch/powerpc/boot/4xx.c
+++ linux-2.6/arch/powerpc/boot/4xx.c
@@ -109,3 +109,85 @@ void ibm4xx_fixup_ebc_ranges(const char 
 
 	setprop(devp, "ranges", ranges, (p - ranges) * sizeof(u32));
 }
+
+#define SPRN_CCR1 0x378
+void ibm440ep_fixup_clocks(unsigned int sysclk, unsigned int ser_clk)
+{
+	u32 cpu, plb, opb, ebc, tb, uart0, m, vco;
+	u32 reg;
+	u32 fwdva, fwdvb, fbdv, lfbdv, opbdv0, perdv0, spcid0, prbdv0, tmp;
+
+	mtdcr(DCRN_CPR0_ADDR, CPR0_PLLD0);
+	reg = mfdcr(DCRN_CPR0_DATA);
+	tmp = (reg & 0x000F0000) >> 16;
+	fwdva = tmp ? tmp : 16;
+	tmp = (reg & 0x00000700) >> 8;
+	fwdvb = tmp ? tmp : 8;
+	tmp = (reg & 0x1F000000) >> 24;
+	fbdv = tmp ? tmp : 32;
+	lfbdv = (reg & 0x0000007F);
+
+	mtdcr(DCRN_CPR0_ADDR, CPR0_OPBD0);
+	reg = mfdcr(DCRN_CPR0_DATA);
+	tmp = (reg & 0x03000000) >> 24;
+	opbdv0 = tmp ? tmp : 4;
+
+	mtdcr(DCRN_CPR0_ADDR, CPR0_PERD0);
+	reg = mfdcr(DCRN_CPR0_DATA);
+	tmp = (reg & 0x07000000) >> 24;
+	perdv0 = tmp ? tmp : 8;
+
+	mtdcr(DCRN_CPR0_ADDR, CPR0_PRIMBD0);
+	reg = mfdcr(DCRN_CPR0_DATA);
+	tmp = (reg & 0x07000000) >> 24;
+	prbdv0 = tmp ? tmp : 8;
+
+	mtdcr(DCRN_CPR0_ADDR, CPR0_SCPID);
+	reg = mfdcr(DCRN_CPR0_DATA);
+	tmp = (reg & 0x03000000) >> 24;
+	spcid0 = tmp ? tmp : 4;
+
+	/* Calculate M */
+	mtdcr(DCRN_CPR0_ADDR, CPR0_PLLC0);
+	reg = mfdcr(DCRN_CPR0_DATA);
+	tmp = (reg & 0x03000000) >> 24;
+	if (tmp == 0) { /* PLL output */
+		tmp = (reg & 0x20000000) >> 29;
+		if (!tmp) /* PLLOUTA */
+			m = fbdv * lfbdv * fwdva;
+		else
+			m = fbdv * lfbdv * fwdvb;
+	}
+	else if (tmp == 1) /* CPU output */
+		m = fbdv * fwdva;
+	else
+		m = perdv0 * opbdv0 * fwdvb;
+
+	vco = (m * sysclk) + (m >> 1);
+	cpu = vco / fwdva;
+	plb = vco / fwdvb / prbdv0;
+	opb = plb / opbdv0;
+	ebc = plb / perdv0;
+
+	/* FIXME */
+	uart0 = ser_clk;
+
+	/* Figure out timebase.  Either CPU or default TmrClk */
+	asm volatile (
+			"mfspr	%0,%1\n"
+			:
+			"=&r"(reg) : "i"(SPRN_CCR1));
+	if (reg & 0x0080)
+		tb = 25000000; /* TmrClk is 25MHz */
+	else
+		tb = cpu;
+
+	dt_fixup_cpu_clocks(cpu, tb, 0);
+	dt_fixup_clock("/plb", plb);
+	dt_fixup_clock("/plb/opb", opb);
+	dt_fixup_clock("/plb/opb/ebc", ebc);
+	dt_fixup_clock("/plb/opb/serial@ef600300", uart0);
+	dt_fixup_clock("/plb/opb/serial@ef600400", uart0);
+	dt_fixup_clock("/plb/opb/serial@ef600500", uart0);
+	dt_fixup_clock("/plb/opb/serial@ef600600", uart0);
+}
--- linux-2.6.orig/arch/powerpc/boot/4xx.h
+++ linux-2.6/arch/powerpc/boot/4xx.h
@@ -16,5 +16,6 @@ void ibm44x_dbcr_reset(void);
 void ibm40x_dbcr_reset(void);
 void ibm4xx_quiesce_eth(u32 *emac0, u32 *emac1);
 void ibm4xx_fixup_ebc_ranges(const char *ebc);
+void ibm440ep_fixup_clocks(unsigned int sysclk, unsigned int ser_clk);
 
 #endif /* _POWERPC_BOOT_4XX_H_ */
--- linux-2.6.orig/arch/powerpc/boot/Makefile
+++ linux-2.6/arch/powerpc/boot/Makefile
@@ -44,10 +44,10 @@ $(addprefix $(obj)/,$(zlib) gunzip_util.
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
-		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c
+		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
-		ps3-head.S ps3-hvcall.S ps3.c
+		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -142,6 +142,7 @@ ifneq ($(CONFIG_DEVICE_TREE),"")
 image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
 image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
 image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
+image-$(CONFIG_BAMBOO)			+= treeImage.bamboo
 endif
 
 # For 32-bit powermacs, build the COFF and miboot images
--- /dev/null
+++ linux-2.6/arch/powerpc/boot/bamboo.c
@@ -0,0 +1,45 @@
+/*
+ * Copyright IBM Corporation, 2007
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * Based on ebony wrapper:
+ * Copyright 2007 David Gibson, IBM Corporation.
+ *
+ * Clocking code based on code by:
+ * Stefan Roese <sr@denx.de>
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
+static void bamboo_fixups(void)
+{
+	unsigned long sysclk = 33333333;
+
+	ibm440ep_fixup_clocks(sysclk, 11059200);
+	ibm4xx_fixup_memsize();
+	ibm4xx_quiesce_eth((u32 *)0xef600e00, (u32 *)0xef600f00);
+}
+
+void bamboo_init(void)
+{
+	platform_ops.fixups = bamboo_fixups;
+	platform_ops.exit = ibm44x_dbcr_reset;
+	ft_init(_dtb_start, 0, 32);
+	serial_console_init();
+}
--- linux-2.6.orig/arch/powerpc/boot/dcr.h
+++ linux-2.6/arch/powerpc/boot/dcr.h
@@ -123,4 +123,14 @@ static const unsigned long sdram_bxcr[] 
 
 #define DCRN_MAL0_CFG					0x180
 
+/* 440EP Clock/Power-on Reset regs */
+#define DCRN_CPR0_ADDR	0xc
+#define DCRN_CPR0_DATA	0xd
+#define CPR0_PLLD0	0x60
+#define CPR0_OPBD0	0xc0
+#define CPR0_PERD0	0xe0
+#define CPR0_PRIMBD0	0xa0
+#define CPR0_SCPID	0x120
+#define CPR0_PLLC0	0x40
+
 #endif	/* _PPC_BOOT_DCR_H_ */
--- /dev/null
+++ linux-2.6/arch/powerpc/boot/treeboot-bamboo.c
@@ -0,0 +1,27 @@
+/*
+ * Copyright IBM Corporation, 2007
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * Based on ebony wrapper:
+ * Copyright 2007 David Gibson, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the License
+ */
+#include "ops.h"
+#include "stdio.h"
+#include "44x.h"
+
+extern char _end[];
+
+BSS_STACK(4096);
+
+void platform_init(void)
+{
+	unsigned long end_of_ram = 0x8000000;
+	unsigned long avail_ram = end_of_ram - (unsigned long)_end;
+
+	simple_alloc_init(_end, avail_ram, 32, 64);
+	bamboo_init();
+}

-- 
