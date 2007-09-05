Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB223DDEC9
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 02:36:09 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l85Ga6Ra018394
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 12:36:06 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l85Ga5hL419060
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 10:36:05 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l85Ga51Y016955
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Sep 2007 10:36:05 -0600
Date: Wed, 5 Sep 2007 11:36:04 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 6/6] Walnut zImage wrapper
Message-ID: <20070905113604.746ee01c@weaponx.rchland.ibm.com>
In-Reply-To: <1188741519.3772.3.camel@localhost.localdomain>
References: <20070831200449.598781000@linux.vnet.ibm.com>
	<20070831200643.675381000@linux.vnet.ibm.com>
	<20070903011352.GF31499@localhost.localdomain>
	<1188741519.3772.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Updated patch below

Add zImage wrapper for walnut board

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/boot/Makefile          |    3 
 arch/powerpc/boot/dcr.h             |    5 +
 arch/powerpc/boot/treeboot-walnut.c |  131 ++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+), 1 deletion(-)

--- linux-2.6.orig/arch/powerpc/boot/Makefile
+++ linux-2.6/arch/powerpc/boot/Makefile
@@ -49,7 +49,7 @@ src-wlib := string.S crt0.S stdio.c main
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
-		cuboot-pq2.c cuboot-bamboo.c
+		cuboot-pq2.c cuboot-bamboo.c treeboot-walnut.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -147,6 +147,7 @@ image-$(CONFIG_PPC_83xx)		+= cuImage.83x
 image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
 image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
 image-$(CONFIG_BAMBOO)			+= treeImage.bamboo cuImage.bamboo
+image-$(CONFIG_WALNUT)			+= treeImage.walnut
 endif
 
 # For 32-bit powermacs, build the COFF and miboot images
--- /dev/null
+++ linux-2.6/arch/powerpc/boot/treeboot-walnut.c
@@ -0,0 +1,131 @@
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
+#include "io.h"
+
+BSS_STACK(4096);
+
+void ibm405gp_fixup_clocks(unsigned int sysclk, unsigned int ser_clk)
+{
+	u32 pllmr = mfdcr(DCRN_CPC0_PLLMR);
+	u32 cpc0_cr0 = mfdcr(DCRN_405_CPC0_CR0);
+	u32 cpc0_cr1 = mfdcr(DCRN_405_CPC0_CR1);
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
+	mtdcr(DCRN_CPC0_CR1, cpc0_cr1);
+	tb = cpu;
+
+	dt_fixup_cpu_clocks(cpu, tb, 0);
+	dt_fixup_clock("/plb", plb);
+	dt_fixup_clock("/plb/opb", opb);
+	dt_fixup_clock("/plb/ebc", ebc);
+	dt_fixup_clock("/plb/opb/serial@ef600300", uart0);
+	dt_fixup_clock("/plb/opb/serial@ef600400", uart1);
+}
+
+static void walnut_flashsel_fixup(void)
+{
+	void *devp, *sram;
+	u32 reg_flash[3] = {0x0, 0x0, 0x80000};
+	u32 reg_sram[3] = {0x0, 0x0, 0x80000};
+	u8 *fpga;
+	u8 fpga_brds1 = 0x0;
+
+	devp = finddevice("/plb/ebc/fpga");
+	if (!devp)
+		fatal("Couldn't locate FPGA node\n\r");
+
+	if (getprop(devp, "virtual-reg", &fpga, sizeof(fpga)) != sizeof(fpga))
+		fatal("no virtual-reg property\n\r");
+
+	fpga_brds1 = in_8(fpga);
+
+	devp = finddevice("/plb/ebc/flash");
+	if (!devp)
+		fatal("Couldn't locate flash node\n\r");
+
+	if (getprop(devp, "reg", reg_flash, sizeof(reg_flash)) != sizeof(reg_flash))
+		fatal("flash reg property has unexpected size\n\r");
+
+	sram = finddevice("/plb/ebc/sram");
+	if (!sram)
+		fatal("Couldn't locate sram node\n\r");
+
+	if (getprop(sram, "reg", reg_sram, sizeof(reg_sram)) != sizeof(reg_sram))
+		fatal("sram reg property has unexpected size\n\r");
+
+	if (fpga_brds1 & 0x1) {
+		reg_flash[1] ^= 0x80000;
+		reg_sram[1] ^= 0x80000;
+	}
+
+	setprop(devp, "reg", reg_flash, sizeof(reg_flash));
+	setprop(sram, "reg", reg_sram, sizeof(reg_sram));
+}
+
+static void walnut_fixups(void)
+{
+	ibm4xx_fixup_memsize();
+	ibm405gp_fixup_clocks(33330000, 0xa8c000);
+	ibm4xx_quiesce_eth((u32 *)0xef600800, NULL);
+	ibm4xx_fixup_ebc_ranges("/plb/ebc");
+	walnut_flashsel_fixup();
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
--- linux-2.6.orig/arch/powerpc/boot/dcr.h
+++ linux-2.6/arch/powerpc/boot/dcr.h
@@ -134,4 +134,9 @@ static const unsigned long sdram_bxcr[] 
 #define CPR0_SCPID	0x120
 #define CPR0_PLLC0	0x40
 
+/* 405GP Clocking/Power Management/Chip Control regs */
+#define DCRN_CPC0_PLLMR 0xb0
+#define DCRN_405_CPC0_CR0 0xb1
+#define DCRN_405_CPC0_CR1 0xb2
+
 #endif	/* _PPC_BOOT_DCR_H_ */
