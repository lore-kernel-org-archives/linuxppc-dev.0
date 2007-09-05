Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2287DDE266
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 05:21:28 +1000 (EST)
Date: Wed, 5 Sep 2007 14:21:19 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 10/10] bootwrapper: Add fsl_get_immr() and 8xx/pq2 clock
	functions.
Message-ID: <20070905192119.GJ32113@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905192001.GA32049@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

fsl_get_immr() is equivalent to the kernel's get_immrbase() function.

mpc885_get_clock() transforms a crystal frequency into a system frequency
according to the PLL register settings.

pq2_get_clocks() does the same as the above for the PowerQUICC II,
except that it produces several different clocks.

The mpc8xx/pq2 set_clocks() functions modify common properties in
the device tree based on the given clock data.

The mpc885/pq2 fixup_clocks() functions call get_clocks(), and
pass the results to set_clocks().

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/Makefile  |    2 +-
 arch/powerpc/boot/fsl-soc.c |   47 ++++++++++++++++++++
 arch/powerpc/boot/fsl-soc.h |    8 +++
 arch/powerpc/boot/mpc8xx.c  |   82 ++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/mpc8xx.h  |   11 +++++
 arch/powerpc/boot/pq2.c     |  102 +++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/pq2.h     |   11 +++++
 7 files changed, 262 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/fsl-soc.c
 create mode 100644 arch/powerpc/boot/fsl-soc.h
 create mode 100644 arch/powerpc/boot/mpc8xx.c
 create mode 100644 arch/powerpc/boot/mpc8xx.h
 create mode 100644 arch/powerpc/boot/pq2.c
 create mode 100644 arch/powerpc/boot/pq2.h

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 2a6a4c6..e6bed21 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -45,7 +45,7 @@ src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
 		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
-		cpm-serial.c stdlib.c planetcore.c
+		cpm-serial.c stdlib.c planetcore.c fsl-soc.c mpc8xx.c pq2.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c \
diff --git a/arch/powerpc/boot/fsl-soc.c b/arch/powerpc/boot/fsl-soc.c
new file mode 100644
index 0000000..e86a1fa
--- /dev/null
+++ b/arch/powerpc/boot/fsl-soc.c
@@ -0,0 +1,47 @@
+/*
+ * Freescale SOC support functions
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "types.h"
+#include "fsl-soc.h"
+#include "stdio.h"
+
+static u32 prop_buf[MAX_PROP_LEN / 4];
+
+u32 *fsl_get_immr(void)
+{
+	void *soc;
+	unsigned long ret;
+
+	soc = find_node_by_devtype(NULL, "soc");
+	if (soc) {
+		int size;
+		u32 naddr;
+
+		size = getprop(soc, "#address-cells", prop_buf, MAX_PROP_LEN);
+		if (size == 4)
+			naddr = prop_buf[0];
+		else
+			naddr = 2;
+
+		size = getprop(soc, "ranges", prop_buf, MAX_PROP_LEN);
+		if (size >= 12) {
+			if (!dt_xlate_addr(soc, prop_buf + naddr, 8, &ret)) {
+				printf("fsl_get_immr: Can't xlate %x\r\n",
+				       prop_buf[naddr]);
+				ret = 0;
+			}
+		}
+	} else printf("fsl_get_immr: No SOC node\r\n");
+
+	return (u32 *)ret;
+}
diff --git a/arch/powerpc/boot/fsl-soc.h b/arch/powerpc/boot/fsl-soc.h
new file mode 100644
index 0000000..5da26fc
--- /dev/null
+++ b/arch/powerpc/boot/fsl-soc.h
@@ -0,0 +1,8 @@
+#ifndef _PPC_BOOT_FSL_SOC_H_
+#define _PPC_BOOT_FSL_SOC_H_
+
+#include "types.h"
+
+u32 *fsl_get_immr(void);
+
+#endif
diff --git a/arch/powerpc/boot/mpc8xx.c b/arch/powerpc/boot/mpc8xx.c
new file mode 100644
index 0000000..add55a7
--- /dev/null
+++ b/arch/powerpc/boot/mpc8xx.c
@@ -0,0 +1,82 @@
+/*
+ * MPC8xx support functions
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "types.h"
+#include "fsl-soc.h"
+#include "mpc8xx.h"
+#include "stdio.h"
+#include "io.h"
+
+#define MPC8XX_PLPRCR (0x284/4) /* PLL and Reset Control Register */
+
+/* Return system clock from crystal frequency */
+u32 mpc885_get_clock(u32 crystal)
+{
+	u32 *immr;
+	u32 plprcr;
+	int mfi, mfn, mfd, pdf, div;
+	u32 ret;
+
+	immr = fsl_get_immr();
+	if (!immr) {
+		printf("mpc885_get_clock: Couldn't get IMMR base.\r\n");
+		return 0;
+	}
+
+	plprcr = in_be32(&immr[MPC8XX_PLPRCR]);
+
+	mfi = (plprcr >> 16) & 15;
+	if (mfi < 5) {
+		printf("Warning: PLPRCR[MFI] value of %d out-of-bounds\r\n",
+		       mfi);
+		mfi = 5;
+	}
+
+	pdf = (plprcr >> 1) & 0xf;
+	div = (plprcr >> 20) & 3;
+	mfd = (plprcr >> 22) & 0x1f;
+	mfn = (plprcr >> 27) & 0x1f;
+
+	ret = crystal * mfi;
+
+	if (mfn != 0)
+		ret += crystal * mfn / (mfd + 1);
+
+	return ret / (pdf + 1);
+}
+
+/* Set common device tree fields based on the given clock frequencies. */
+void mpc8xx_set_clocks(u32 sysclk)
+{
+	void *node;
+
+	dt_fixup_cpu_clocks(sysclk, sysclk / 16, sysclk);
+
+	node = finddevice("/soc/cpm");
+	if (node)
+		setprop(node, "clock-frequency", &sysclk, 4);
+
+	node = finddevice("/soc/cpm/brg");
+	if (node)
+		setprop(node, "clock-frequency", &sysclk, 4);
+}
+
+int mpc885_fixup_clocks(u32 crystal)
+{
+	u32 sysclk = mpc885_get_clock(crystal);
+	if (!sysclk)
+		return 0;
+
+	mpc8xx_set_clocks(sysclk);
+	return 1;
+}
diff --git a/arch/powerpc/boot/mpc8xx.h b/arch/powerpc/boot/mpc8xx.h
new file mode 100644
index 0000000..3f59901
--- /dev/null
+++ b/arch/powerpc/boot/mpc8xx.h
@@ -0,0 +1,11 @@
+#ifndef _PPC_BOOT_MPC8xx_H_
+#define _PPC_BOOT_MPC8xx_H_
+
+#include "types.h"
+
+void mpc8xx_set_clocks(u32 sysclk);
+
+u32 mpc885_get_clock(u32 crystal);
+int mpc885_fixup_clocks(u32 crystal);
+
+#endif
diff --git a/arch/powerpc/boot/pq2.c b/arch/powerpc/boot/pq2.c
new file mode 100644
index 0000000..f6d1185
--- /dev/null
+++ b/arch/powerpc/boot/pq2.c
@@ -0,0 +1,102 @@
+/*
+ * PowerQUICC II support functions
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "types.h"
+#include "fsl-soc.h"
+#include "pq2.h"
+#include "stdio.h"
+#include "io.h"
+
+#define PQ2_SCCR (0x10c80/4) /* System Clock Configuration Register */
+#define PQ2_SCMR (0x10c88/4) /* System Clock Mode Register */
+
+static int pq2_corecnf_map[] = {
+	3, 2, 2, 2, 4, 4, 5, 9, 6, 11, 8, 10, 3, 12, 7, -1,
+	6, 5, 13, 2, 14, 4, 15, 9, 0, 11, 8, 10, 16, 12, 7, -1
+};
+
+/* Get various clocks from crystal frequency.
+ * Returns zero on failure and non-zero on success.
+ */
+int pq2_get_clocks(u32 crystal, u32 *sysfreq, u32 *corefreq,
+                   u32 *timebase, u32 *brgfreq)
+{
+	u32 *immr;
+	u32 sccr, scmr, mainclk, busclk;
+	int corecnf, busdf, plldf, pllmf, dfbrg;
+
+	immr = fsl_get_immr();
+	if (!immr) {
+		printf("pq2_get_clocks: Couldn't get IMMR base.\r\n");
+		return 0;
+	}
+
+	sccr = in_be32(&immr[PQ2_SCCR]);
+	scmr = in_be32(&immr[PQ2_SCMR]);
+
+	dfbrg = sccr & 3;
+	corecnf = (scmr >> 24) & 0x1f;
+	busdf = (scmr >> 20) & 0xf;
+	plldf = (scmr >> 12) & 1;
+	pllmf = scmr & 0xfff;
+
+	mainclk = crystal * (pllmf + 1) / (plldf + 1);
+	busclk = mainclk / (busdf + 1);
+
+	if (sysfreq)
+		*sysfreq = mainclk / 2;
+	if (timebase)
+		*timebase = busclk / 4;
+	if (brgfreq)
+		*brgfreq = mainclk / (1 << ((dfbrg + 1) * 2));
+
+	if (corefreq) {
+		int coremult = pq2_corecnf_map[corecnf];
+
+		if (coremult < 0)
+			*corefreq = mainclk / 2;
+		else if (coremult == 0)
+			return 0;
+		else
+			*corefreq = busclk * coremult / 2;
+	}
+
+	return 1;
+}
+
+/* Set common device tree fields based on the given clock frequencies. */
+void pq2_set_clocks(u32 sysfreq, u32 corefreq, u32 timebase, u32 brgfreq)
+{
+	void *node;
+
+	dt_fixup_cpu_clocks(corefreq, timebase, sysfreq);
+
+	node = finddevice("/soc/cpm");
+	if (node)
+		setprop(node, "clock-frequency", &sysfreq, 4);
+
+	node = finddevice("/soc/cpm/brg");
+	if (node)
+		setprop(node, "clock-frequency", &brgfreq, 4);
+}
+
+int pq2_fixup_clocks(u32 crystal)
+{
+	u32 sysfreq, corefreq, timebase, brgfreq;
+
+	if (!pq2_get_clocks(crystal, &sysfreq, &corefreq, &timebase, &brgfreq))
+		return 0;
+
+	pq2_set_clocks(sysfreq, corefreq, timebase, brgfreq);
+	return 1;
+}
diff --git a/arch/powerpc/boot/pq2.h b/arch/powerpc/boot/pq2.h
new file mode 100644
index 0000000..481698c
--- /dev/null
+++ b/arch/powerpc/boot/pq2.h
@@ -0,0 +1,11 @@
+#ifndef _PPC_BOOT_PQ2_H_
+#define _PPC_BOOT_PQ2_H_
+
+#include "types.h"
+
+int pq2_get_clocks(u32 crystal, u32 *sysfreq, u32 *corefreq,
+                   u32 *timebase, u32 *brgfreq);
+void pq2_set_clocks(u32 sysfreq, u32 corefreq, u32 timebase, u32 brgfreq);
+int pq2_fixup_clocks(u32 crystal);
+
+#endif
-- 
1.5.3
