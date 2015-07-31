Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0129.outbound.protection.outlook.com [65.55.169.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67D531A0725
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 23:08:05 +1000 (AEST)
From: Chenhui Zhao <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <Jason.Jin@freescale.com>
Subject: [PATCH 3/4] powerpc: pm: add EPU FSM configuration for deep sleep
Date: Fri, 31 Jul 2015 20:53:05 +0800
Message-ID: <1438347186-8462-3-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1438347186-8462-1-git-send-email-chenhui.zhao@freescale.com>
References: <1438347186-8462-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the last stage of deep sleep, software will trigger a Finite
State Machine (FSM) to control the hardware precedure, such as
board isolation, killing PLLs, removing power, and so on.

When the system is waked up by an interrupt, the FSM controls the
hardware to complete the early resume precedure.

This patch configure the EPU FSM preparing for deep sleep.

Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
---
 arch/powerpc/platforms/85xx/Makefile    |   2 +-
 arch/powerpc/platforms/85xx/sleep_fsm.c | 256 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/sleep_fsm.h | 104 +++++++++++++
 3 files changed, 361 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/85xx/sleep_fsm.c
 create mode 100644 arch/powerpc/platforms/85xx/sleep_fsm.h

diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index fdae28b..87fb847 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -3,7 +3,7 @@
 #
 obj-$(CONFIG_SMP) += smp.o
 obj-$(CONFIG_FSL_PMC)		  += mpc85xx_pm_ops.o
-obj-$(CONFIG_FSL_QORIQ_PM)	  += qoriq_pm.o
+obj-$(CONFIG_FSL_QORIQ_PM)	  += qoriq_pm.o sleep_fsm.o
 
 obj-y += common.o
 
diff --git a/arch/powerpc/platforms/85xx/sleep_fsm.c b/arch/powerpc/platforms/85xx/sleep_fsm.c
new file mode 100644
index 0000000..2e81d37
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/sleep_fsm.c
@@ -0,0 +1,256 @@
+/*
+ * Freescale deep sleep FSM (finite-state machine) configuration
+ *
+ * Copyright 2015 Freescale Semiconductor Inc.
+ *
+ * Author: Hongbo Zhang <hongbo.zhang@freescale.com>
+ *         Chenhui Zhao <chenhui.zhao@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/types.h>
+
+#include "sleep_fsm.h"
+/*
+ * These values are from chip's reference manual. For example,
+ * the values for T1040 can be found in "8.4.3.8 Programming
+ * supporting deep sleep mode" of Chapter 8 "Run Control and
+ * Power Management (RCPM)".
+ * The default value can be applied to T104x, LS1021.
+ */
+struct fsm_reg_vals epu_default_val[] = {
+	/* EPGCR (Event Processor Global Control Register) */
+	{EPGCR, 0},
+	/* EPECR (Event Processor Event Control Registers) */
+	{EPECR0 + EPECR_STRIDE * 0, 0},
+	{EPECR0 + EPECR_STRIDE * 1, 0},
+	{EPECR0 + EPECR_STRIDE * 2, 0xF0004004},
+	{EPECR0 + EPECR_STRIDE * 3, 0x80000084},
+	{EPECR0 + EPECR_STRIDE * 4, 0x20000084},
+	{EPECR0 + EPECR_STRIDE * 5, 0x08000004},
+	{EPECR0 + EPECR_STRIDE * 6, 0x80000084},
+	{EPECR0 + EPECR_STRIDE * 7, 0x80000084},
+	{EPECR0 + EPECR_STRIDE * 8, 0x60000084},
+	{EPECR0 + EPECR_STRIDE * 9, 0x08000084},
+	{EPECR0 + EPECR_STRIDE * 10, 0x42000084},
+	{EPECR0 + EPECR_STRIDE * 11, 0x90000084},
+	{EPECR0 + EPECR_STRIDE * 12, 0x80000084},
+	{EPECR0 + EPECR_STRIDE * 13, 0x08000084},
+	{EPECR0 + EPECR_STRIDE * 14, 0x02000084},
+	{EPECR0 + EPECR_STRIDE * 15, 0x00000004},
+	/*
+	 * EPEVTCR (Event Processor EVT Pin Control Registers)
+	 * SCU8 triger EVT2, and SCU11 triger EVT9
+	 */
+	{EPEVTCR0 + EPEVTCR_STRIDE * 0, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 1, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 2, 0x80000001},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 3, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 4, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 5, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 6, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 7, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 8, 0},
+	{EPEVTCR0 + EPEVTCR_STRIDE * 9, 0xB0000001},
+	/* EPCMPR (Event Processor Counter Compare Registers) */
+	{EPCMPR0 + EPCMPR_STRIDE * 0, 0},
+	{EPCMPR0 + EPCMPR_STRIDE * 1, 0},
+	{EPCMPR0 + EPCMPR_STRIDE * 2, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 3, 0},
+	{EPCMPR0 + EPCMPR_STRIDE * 4, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 5, 0x00000020},
+	{EPCMPR0 + EPCMPR_STRIDE * 6, 0},
+	{EPCMPR0 + EPCMPR_STRIDE * 7, 0},
+	{EPCMPR0 + EPCMPR_STRIDE * 8, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 9, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 10, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 11, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 12, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 13, 0},
+	{EPCMPR0 + EPCMPR_STRIDE * 14, 0x000000FF},
+	{EPCMPR0 + EPCMPR_STRIDE * 15, 0x000000FF},
+	/* EPCCR (Event Processor Counter Control Registers) */
+	{EPCCR0 + EPCCR_STRIDE * 0, 0},
+	{EPCCR0 + EPCCR_STRIDE * 1, 0},
+	{EPCCR0 + EPCCR_STRIDE * 2, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 3, 0},
+	{EPCCR0 + EPCCR_STRIDE * 4, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 5, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 6, 0},
+	{EPCCR0 + EPCCR_STRIDE * 7, 0},
+	{EPCCR0 + EPCCR_STRIDE * 8, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 9, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 10, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 11, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 12, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 13, 0},
+	{EPCCR0 + EPCCR_STRIDE * 14, 0x92840000},
+	{EPCCR0 + EPCCR_STRIDE * 15, 0x92840000},
+	/* EPSMCR (Event Processor SCU Mux Control Registers) */
+	{EPSMCR0 + EPSMCR_STRIDE * 0, 0},
+	{EPSMCR0 + EPSMCR_STRIDE * 1, 0},
+	{EPSMCR0 + EPSMCR_STRIDE * 2, 0x6C700000},
+	{EPSMCR0 + EPSMCR_STRIDE * 3, 0x2F000000},
+	{EPSMCR0 + EPSMCR_STRIDE * 4, 0x002F0000},
+	{EPSMCR0 + EPSMCR_STRIDE * 5, 0x00002E00},
+	{EPSMCR0 + EPSMCR_STRIDE * 6, 0x7C000000},
+	{EPSMCR0 + EPSMCR_STRIDE * 7, 0x30000000},
+	{EPSMCR0 + EPSMCR_STRIDE * 8, 0x64300000},
+	{EPSMCR0 + EPSMCR_STRIDE * 9, 0x00003000},
+	{EPSMCR0 + EPSMCR_STRIDE * 10, 0x65000030},
+	{EPSMCR0 + EPSMCR_STRIDE * 11, 0x31740000},
+	{EPSMCR0 + EPSMCR_STRIDE * 12, 0x7F000000},
+	{EPSMCR0 + EPSMCR_STRIDE * 13, 0x00003100},
+	{EPSMCR0 + EPSMCR_STRIDE * 14, 0x00000031},
+	{EPSMCR0 + EPSMCR_STRIDE * 15, 0x76000000},
+	/* EPACR (Event Processor Action Control Registers) */
+	{EPACR0 + EPACR_STRIDE * 0, 0},
+	{EPACR0 + EPACR_STRIDE * 1, 0},
+	{EPACR0 + EPACR_STRIDE * 2, 0},
+	{EPACR0 + EPACR_STRIDE * 3, 0x00000080},
+	{EPACR0 + EPACR_STRIDE * 4, 0},
+	{EPACR0 + EPACR_STRIDE * 5, 0x00000040},
+	{EPACR0 + EPACR_STRIDE * 6, 0},
+	{EPACR0 + EPACR_STRIDE * 7, 0},
+	{EPACR0 + EPACR_STRIDE * 8, 0},
+	{EPACR0 + EPACR_STRIDE * 9, 0x0000001C},
+	{EPACR0 + EPACR_STRIDE * 10, 0x00000020},
+	{EPACR0 + EPACR_STRIDE * 11, 0},
+	{EPACR0 + EPACR_STRIDE * 12, 0x00000003},
+	{EPACR0 + EPACR_STRIDE * 13, 0x06000000},
+	{EPACR0 + EPACR_STRIDE * 14, 0x04000000},
+	{EPACR0 + EPACR_STRIDE * 15, 0x02000000},
+	/* EPIMCR (Event Processor Input Mux Control Registers) */
+	{EPIMCR0 + EPIMCR_STRIDE * 0, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 1, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 2, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 3, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 4, 0x44000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 5, 0x40000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 6, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 7, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 8, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 9, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 10, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 11, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 12, 0x44000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 13, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 14, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 15, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 16, 0x6A000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 17, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 18, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 19, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 20, 0x48000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 21, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 22, 0x6C000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 23, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 24, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 25, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 26, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 27, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 28, 0x76000000},
+	{EPIMCR0 + EPIMCR_STRIDE * 29, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 30, 0},
+	{EPIMCR0 + EPIMCR_STRIDE * 31, 0x76000000},
+	/* EPXTRIGCR (Event Processor Crosstrigger Control Register) */
+	{EPXTRIGCR, 0x0000FFDF},
+	/* end */
+	{FSM_END_FLAG, 0},
+};
+
+struct fsm_reg_vals npc_default_val[] = {
+	/* NPC triggered Memory-Mapped Access Registers */
+	{NCR, 0x80000000},
+	{MCCR1, 0},
+	{MCSR1, 0},
+	{MMAR1LO, 0},
+	{MMAR1HI, 0},
+	{MMDR1, 0},
+	{MCSR2, 0},
+	{MMAR2LO, 0},
+	{MMAR2HI, 0},
+	{MMDR2, 0},
+	{MCSR3, 0x80000000},
+	{MMAR3LO, 0x000E2130},
+	{MMAR3HI, 0x00030000},
+	{MMDR3, 0x00020000},
+	/* end */
+	{FSM_END_FLAG, 0},
+};
+
+/**
+ * fsl_fsm_setup - Configure EPU's FSM registers
+ * @base: the base address of registers
+ * @val: Pointer to address-value pairs for FSM registers
+ */
+void fsl_fsm_setup(void __iomem *base, struct fsm_reg_vals *val)
+{
+	struct fsm_reg_vals *data = val;
+
+	BUG_ON(!base || !data);
+	while (data->offset != FSM_END_FLAG) {
+		iowrite32be(data->value, base + data->offset);
+		data++;
+	}
+}
+
+void fsl_epu_setup_default(void __iomem *epu_base)
+{
+	fsl_fsm_setup(epu_base, epu_default_val);
+}
+
+void fsl_npc_setup_default(void __iomem *npc_base)
+{
+	fsl_fsm_setup(npc_base, npc_default_val);
+}
+
+void fsl_epu_clean_default(void __iomem *epu_base)
+{
+	u32 offset;
+
+	/* follow the exact sequence to clear the registers */
+	/* Clear EPACRn */
+	for (offset = EPACR0; offset <= EPACR15; offset += EPACR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPEVTCRn */
+	for (offset = EPEVTCR0; offset <= EPEVTCR9; offset += EPEVTCR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPGCR */
+	iowrite32be(0, epu_base + EPGCR);
+
+	/* Clear EPSMCRn */
+	for (offset = EPSMCR0; offset <= EPSMCR15; offset += EPSMCR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPCCRn */
+	for (offset = EPCCR0; offset <= EPCCR31; offset += EPCCR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPCMPRn */
+	for (offset = EPCMPR0; offset <= EPCMPR31; offset += EPCMPR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPCTRn */
+	for (offset = EPCTR0; offset <= EPCTR31; offset += EPCTR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPIMCRn */
+	for (offset = EPIMCR0; offset <= EPIMCR31; offset += EPIMCR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+
+	/* Clear EPXTRIGCRn */
+	iowrite32be(0, epu_base + EPXTRIGCR);
+
+	/* Clear EPECRn */
+	for (offset = EPECR0; offset <= EPECR15; offset += EPECR_STRIDE)
+		iowrite32be(0, epu_base + offset);
+}
diff --git a/arch/powerpc/platforms/85xx/sleep_fsm.h b/arch/powerpc/platforms/85xx/sleep_fsm.h
new file mode 100644
index 0000000..2c60b40
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/sleep_fsm.h
@@ -0,0 +1,104 @@
+/*
+ * Freescale deep sleep FSM (finite-state machine) configuration
+ *
+ * Copyright 2015 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef _FSL_SLEEP_FSM_H
+#define _FSL_SLEEP_FSM_H
+
+#define FSL_STRIDE_4B	4
+#define FSL_STRIDE_8B	8
+
+/* End flag */
+#define FSM_END_FLAG		0xFFFFFFFFUL
+
+/* Block offsets */
+#define RCPM_BLOCK_OFFSET	0x00022000
+#define EPU_BLOCK_OFFSET	0x00000000
+#define NPC_BLOCK_OFFSET	0x00001000
+
+/* EPGCR (Event Processor Global Control Register) */
+#define EPGCR		0x000
+
+/* EPEVTCR0-9 (Event Processor EVT Pin Control Registers) */
+#define EPEVTCR0	0x050
+#define EPEVTCR9	0x074
+#define EPEVTCR_STRIDE	FSL_STRIDE_4B
+
+/* EPXTRIGCR (Event Processor Crosstrigger Control Register) */
+#define EPXTRIGCR	0x090
+
+/* EPIMCR0-31 (Event Processor Input Mux Control Registers) */
+#define EPIMCR0		0x100
+#define EPIMCR31	0x17C
+#define EPIMCR_STRIDE	FSL_STRIDE_4B
+
+/* EPSMCR0-15 (Event Processor SCU Mux Control Registers) */
+#define EPSMCR0		0x200
+#define EPSMCR15	0x278
+#define EPSMCR_STRIDE	FSL_STRIDE_8B
+
+/* EPECR0-15 (Event Processor Event Control Registers) */
+#define EPECR0		0x300
+#define EPECR15		0x33C
+#define EPECR_STRIDE	FSL_STRIDE_4B
+
+/* EPACR0-15 (Event Processor Action Control Registers) */
+#define EPACR0		0x400
+#define EPACR15		0x43C
+#define EPACR_STRIDE	FSL_STRIDE_4B
+
+/* EPCCRi0-15 (Event Processor Counter Control Registers) */
+#define EPCCR0		0x800
+#define EPCCR15		0x83C
+#define EPCCR31		0x87C
+#define EPCCR_STRIDE	FSL_STRIDE_4B
+
+/* EPCMPR0-15 (Event Processor Counter Compare Registers) */
+#define EPCMPR0		0x900
+#define EPCMPR15	0x93C
+#define EPCMPR31	0x97C
+#define EPCMPR_STRIDE	FSL_STRIDE_4B
+
+/* EPCTR0-31 (Event Processor Counter Register) */
+#define EPCTR0		0xA00
+#define EPCTR31		0xA7C
+#define EPCTR_STRIDE	FSL_STRIDE_4B
+
+/* NPC triggered Memory-Mapped Access Registers */
+#define NCR		0x000
+#define MCCR1		0x0CC
+#define MCSR1		0x0D0
+#define MMAR1LO		0x0D4
+#define MMAR1HI		0x0D8
+#define MMDR1		0x0DC
+#define MCSR2		0x0E0
+#define MMAR2LO		0x0E4
+#define MMAR2HI		0x0E8
+#define MMDR2		0x0EC
+#define MCSR3		0x0F0
+#define MMAR3LO		0x0F4
+#define MMAR3HI		0x0F8
+#define MMDR3		0x0FC
+
+/* RCPM Core State Action Control Register 0 */
+#define CSTTACR0	0xB00
+
+/* RCPM Core Group 1 Configuration Register 0 */
+#define CG1CR0		0x31C
+
+struct fsm_reg_vals {
+	u32 offset;
+	u32 value;
+};
+
+void fsl_epu_setup_default(void __iomem *epu_base);
+void fsl_npc_setup_default(void __iomem *npc_base);
+void fsl_epu_clean_default(void __iomem *epu_base);
+
+#endif /* _FSL_SLEEP_FSM_H */
-- 
1.9.1
