Return-Path: <jwboyer@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.225])
	by ozlabs.org (Postfix) with ESMTP id B5D0947ABE
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 01:46:16 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so11090wra.1
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Sep 2008 08:46:14 -0700 (PDT)
Date: Thu, 4 Sep 2008 11:45:34 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] powerpc/40x: Add cuboot wrapper for Acadia board
Message-ID: <20080904154534.GD2579@yoda.jdub.homelinux.org>
References: <cover.1220541399.git.jwboyer@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1220541399.git.jwboyer@linux.vnet.ibm.com>
Sender: Josh Boyer <jwboyer@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a cuboot wrapper for the AMCC PowerPC 405EZ Acadia board.  The
clocking code is derived from U-Boot, originally written by Stefan Roese.

Signed-off-by: Josh Boyer <jwboyer@linux.ibm.com>
---
 arch/powerpc/boot/Makefile        |    4 +-
 arch/powerpc/boot/cuboot-acadia.c |  198 +++++++++++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-acadia.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 14174aa..fb712a4 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -68,7 +68,8 @@ src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c
 		fixed-head.S ep88xc.c ep405.c cuboot-c2k.c \
 		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
 		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
-		virtex405-head.S virtex.c redboot-83xx.c cuboot-sam440ep.c
+		virtex405-head.S virtex.c redboot-83xx.c cuboot-sam440ep.c \
+		cuboot-acadia.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -211,6 +212,7 @@ image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 # Board ports in arch/powerpc/platform/40x/Kconfig
 image-$(CONFIG_EP405)			+= dtbImage.ep405
 image-$(CONFIG_WALNUT)			+= treeImage.walnut
+image-$(CONFIG_ACADIA)			+= cuImage.acadia
 
 # Board ports in arch/powerpc/platform/44x/Kconfig
 image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
diff --git a/arch/powerpc/boot/cuboot-acadia.c b/arch/powerpc/boot/cuboot-acadia.c
new file mode 100644
index 0000000..3818d47
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-acadia.c
@@ -0,0 +1,198 @@
+/*
+ * Old U-boot compatibility for Acadia
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
+#include "io.h"
+#include "dcr.h"
+#include "stdio.h"
+#include "4xx.h"
+#include "44x.h"
+#include "cuboot.h"
+
+#define TARGET_4xx
+#include "ppcboot.h"
+
+static bd_t bd;
+
+#define CPR_PERD0_SPIDV_MASK   0x000F0000     /* SPI Clock Divider */
+
+#define PLLC_SRC_MASK	       0x20000000     /* PLL feedback source */
+
+#define PLLD_FBDV_MASK	       0x1F000000     /* PLL feedback divider value */
+#define PLLD_FWDVA_MASK        0x000F0000     /* PLL forward divider A value */
+#define PLLD_FWDVB_MASK        0x00000700     /* PLL forward divider B value */
+
+#define PRIMAD_CPUDV_MASK      0x0F000000     /* CPU Clock Divisor Mask */
+#define PRIMAD_PLBDV_MASK      0x000F0000     /* PLB Clock Divisor Mask */
+#define PRIMAD_OPBDV_MASK      0x00000F00     /* OPB Clock Divisor Mask */
+#define PRIMAD_EBCDV_MASK      0x0000000F     /* EBC Clock Divisor Mask */
+
+#define PERD0_PWMDV_MASK       0xFF000000     /* PWM Divider Mask */
+#define PERD0_SPIDV_MASK       0x000F0000     /* SPI Divider Mask */
+#define PERD0_U0DV_MASK        0x0000FF00     /* UART 0 Divider Mask */
+#define PERD0_U1DV_MASK        0x000000FF     /* UART 1 Divider Mask */
+
+static void get_clocks(void)
+{
+	unsigned long sysclk;
+	unsigned long cpr_plld;
+	unsigned long cpr_pllc;
+	unsigned long cpr_primad;
+	unsigned long primad_cpudv;
+	unsigned long m;
+	unsigned long pllFwdDiv, pllFwdDivB, pllFbkDiv, pllPlbDiv, pllExtBusDiv;
+	unsigned long pllOpbDiv, freqVCOHz, freqProcessor, freqPLB, freqEBC, freqUART, freqOPB;
+	unsigned long div;		/* total divisor udiv * bdiv */
+	unsigned long umin;		/* minimum udiv	*/
+	unsigned short diff;		/* smallest diff */
+	unsigned long udiv;		/* best udiv */
+	unsigned short idiff;		/* current diff */
+	unsigned short ibdiv;		/* current bdiv */
+	unsigned long i;
+	unsigned long est;		/* current estimate */
+	unsigned long plloutb;
+
+	/* read the sysclk value from the CPLD */
+	sysclk = (in_8(0x80000000) == 0xc) ? 66666666 : 33333000;
+
+	/*
+	 * Read PLL Mode registers
+	 */
+	cpr_plld = CPR0_READ(DCRN_CPR0_PLLD);
+	cpr_pllc = CPR0_READ(DCRN_CPR0_PLLC);
+
+	/*
+	 * Determine forward divider A
+	 */
+	pllFwdDiv = ((cpr_plld & PLLD_FWDVA_MASK) >> 16);
+
+	/*
+	 * Determine forward divider B
+	 */
+	pllFwdDivB = ((cpr_plld & PLLD_FWDVB_MASK) >> 8);
+	if (pllFwdDivB == 0)
+		pllFwdDivB = 8;
+
+	/*
+	 * Determine FBK_DIV.
+	 */
+	pllFbkDiv = ((cpr_plld & PLLD_FBDV_MASK) >> 24);
+	if (pllFbkDiv == 0)
+		pllFbkDiv = 256;
+
+	/*
+	 * Read CPR_PRIMAD register
+	 */
+	cpr_primad = CPR0_READ(DCRN_CPR0_PRIMAD);
+
+	/*
+	 * Determine PLB_DIV.
+	 */
+	pllPlbDiv = ((cpr_primad & PRIMAD_PLBDV_MASK) >> 16);
+	if (pllPlbDiv == 0)
+		pllPlbDiv = 16;
+
+	/*
+	 * Determine EXTBUS_DIV.
+	 */
+	pllExtBusDiv = (cpr_primad & PRIMAD_EBCDV_MASK);
+	if (pllExtBusDiv == 0)
+		pllExtBusDiv = 16;
+
+	/*
+	 * Determine OPB_DIV.
+	 */
+	pllOpbDiv = ((cpr_primad & PRIMAD_OPBDV_MASK) >> 8);
+	if (pllOpbDiv == 0)
+		pllOpbDiv = 16;
+
+	/*
+	 * Determine the M factor
+	 */
+	if (cpr_pllc & PLLC_SRC_MASK)
+		m = pllFbkDiv * pllFwdDivB;
+	else
+		m = pllFbkDiv * pllFwdDiv;
+
+	/*
+	 * Determine VCO clock frequency
+	 */
+	freqVCOHz = sysclk * (m);
+
+	/*
+	 * Determine CPU clock frequency
+	 */
+	primad_cpudv = ((cpr_primad & PRIMAD_CPUDV_MASK) >> 24);
+	if (primad_cpudv == 0)
+		primad_cpudv = 16;
+
+	freqProcessor = (sysclk * m) / pllFwdDiv / primad_cpudv;
+
+	/*
+	 * Determine PLB clock frequency
+	 */
+	freqPLB = (sysclk * m) / pllFwdDiv / pllPlbDiv;
+
+	freqEBC = (sysclk * pllFbkDiv) / pllExtBusDiv;
+
+	freqOPB = (sysclk *pllFbkDiv) /pllOpbDiv;
+
+	plloutb = ((sysclk * ((cpr_pllc & PLLC_SRC_MASK) ?
+					   pllFwdDivB : pllFwdDiv) *
+		    pllFbkDiv) / pllFwdDivB);
+
+	udiv = 256;			/* Assume lowest possible serial clk */
+	div = plloutb / (16 * 115200); /* total divisor */
+	umin = (plloutb / freqOPB) << 1;	/* 2 x OPB divisor */
+	diff = 256;			/* highest possible */
+
+	/* i is the test udiv value -- start with the largest
+	 * possible (256) to minimize serial clock and constrain
+	 * search to umin.
+	 */
+	for (i = 256; i > umin; i--) {
+		ibdiv = div / i;
+		est = i * ibdiv;
+		idiff = (est > div) ? (est-div) : (div-est);
+		if (idiff == 0) {
+			udiv = i;
+			break;      /* can't do better */
+		} else if (idiff < diff) {
+			udiv = i;       /* best so far */
+			diff = idiff;   /* update lowest diff*/
+		}
+	}
+	freqUART = plloutb / udiv;
+
+	dt_fixup_cpu_clocks(freqProcessor, bd.bi_intfreq, freqPLB);
+	dt_fixup_clock("/plb/ebc", freqEBC);
+	dt_fixup_clock("/plb/opb", freqOPB);
+	dt_fixup_clock("/plb/opb/serial@ef600300", freqUART);
+	dt_fixup_clock("/plb/opb/serial@ef600400", freqUART);
+}
+
+static void acadia_fixups(void)
+{
+	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
+	get_clocks();
+	dt_fixup_mac_address_by_alias("ethernet0", bd.bi_enetaddr);
+}
+	
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+		unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+	platform_ops.fixups = acadia_fixups;
+	platform_ops.exit = ibm40x_dbcr_reset;
+	fdt_init(_dtb_start);
+	serial_console_init();
+}
-- 
1.5.5.1
