Return-Path: <qiang.zhao@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0059.outbound.protection.outlook.com [104.47.36.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNGR86gX0zDrJr
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 13:55:00 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <tglx@linutronix.de>
CC: <oss@buserror.net>, <xiaobo.xie@nxp.com>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH v9 1/4] irqchip/qeic: move qeic driver from drivers/soc/fsl/qe
Date: Thu, 3 Aug 2017 11:38:07 +0800
Message-ID: <1501731490-34402-2-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1501731490-34402-1-git-send-email-qiang.zhao@nxp.com>
References: <1501731490-34402-1-git-send-email-qiang.zhao@nxp.com>
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

move the driver from drivers/soc/fsl/qe to drivers/irqchip,
merge qe_ic.h and qe_ic.c into irq-qeic.c.

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 MAINTAINERS                                        |   6 ++
 drivers/irqchip/Makefile                           |   1 +
 drivers/{soc/fsl/qe/qe_ic.c => irqchip/irq-qeic.c} |  95 ++++++++++++++++++-
 drivers/soc/fsl/qe/Makefile                        |   2 +-
 drivers/soc/fsl/qe/qe_ic.h                         | 103 ---------------------
 5 files changed, 100 insertions(+), 107 deletions(-)
 rename drivers/{soc/fsl/qe/qe_ic.c => irqchip/irq-qeic.c} (85%)
 delete mode 100644 drivers/soc/fsl/qe/qe_ic.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 567343b..1288329 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5462,6 +5462,12 @@ F:	drivers/soc/fsl/qe/
 F:	include/soc/fsl/*qe*.h
 F:	include/soc/fsl/*ucc*.h
 
+FREESCALE QEIC DRIVERS
+M:	Qiang Zhao <qiang.zhao@nxp.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/irqchip/irq-qeic.c
+
 FREESCALE QUICC ENGINE UCC ETHERNET DRIVER
 M:	Li Yang <leoyang.li@nxp.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e88d856..b8eae87 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -78,3 +78,4 @@ obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
+obj-$(CONFIG_QUICC_ENGINE)		+= irq-qeic.o
diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/irqchip/irq-qeic.c
similarity index 85%
rename from drivers/soc/fsl/qe/qe_ic.c
rename to drivers/irqchip/irq-qeic.c
index ec2ca86..9b4660c 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/irqchip/irq-qeic.c
@@ -1,7 +1,7 @@
 /*
- * arch/powerpc/sysdev/qe_lib/qe_ic.c
+ * drivers/irqchip/irq-qeic.c
  *
- * Copyright (C) 2006 Freescale Semiconductor, Inc.  All rights reserved.
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.  All rights reserved.
  *
  * Author: Li Yang <leoli@freescale.com>
  * Based on code from Shlomi Gridish <gridish@freescale.com>
@@ -30,7 +30,96 @@
 #include <asm/io.h>
 #include <soc/fsl/qe/qe_ic.h>
 
-#include "qe_ic.h"
+#define NR_QE_IC_INTS		64
+
+/* QE IC registers offset */
+#define QEIC_CICR		0x00
+#define QEIC_CIVEC		0x04
+#define QEIC_CRIPNR		0x08
+#define QEIC_CIPNR		0x0c
+#define QEIC_CIPXCC		0x10
+#define QEIC_CIPYCC		0x14
+#define QEIC_CIPWCC		0x18
+#define QEIC_CIPZCC		0x1c
+#define QEIC_CIMR		0x20
+#define QEIC_CRIMR		0x24
+#define QEIC_CICNR		0x28
+#define QEIC_CIPRTA		0x30
+#define QEIC_CIPRTB		0x34
+#define QEIC_CRICR		0x3c
+#define QEIC_CHIVEC		0x60
+
+/* Interrupt priority registers */
+#define CIPCC_SHIFT_PRI0	29
+#define CIPCC_SHIFT_PRI1	26
+#define CIPCC_SHIFT_PRI2	23
+#define CIPCC_SHIFT_PRI3	20
+#define CIPCC_SHIFT_PRI4	13
+#define CIPCC_SHIFT_PRI5	10
+#define CIPCC_SHIFT_PRI6	7
+#define CIPCC_SHIFT_PRI7	4
+
+/* CICR priority modes */
+#define CICR_GWCC		0x00040000
+#define CICR_GXCC		0x00020000
+#define CICR_GYCC		0x00010000
+#define CICR_GZCC		0x00080000
+#define CICR_GRTA		0x00200000
+#define CICR_GRTB		0x00400000
+#define CICR_HPIT_SHIFT		8
+#define CICR_HPIT_MASK		0x00000300
+#define CICR_HP_SHIFT		24
+#define CICR_HP_MASK		0x3f000000
+
+/* CICNR */
+#define CICNR_WCC1T_SHIFT	20
+#define CICNR_ZCC1T_SHIFT	28
+#define CICNR_YCC1T_SHIFT	12
+#define CICNR_XCC1T_SHIFT	4
+
+/* CRICR */
+#define CRICR_RTA1T_SHIFT	20
+#define CRICR_RTB1T_SHIFT	28
+
+/* Signal indicator */
+#define SIGNAL_MASK		3
+#define SIGNAL_HIGH		2
+#define SIGNAL_LOW		0
+
+struct qe_ic {
+	/* Control registers offset */
+	u32 __iomem *regs;
+
+	/* The remapper for this QEIC */
+	struct irq_domain *irqhost;
+
+	/* The "linux" controller struct */
+	struct irq_chip hc_irq;
+
+	/* VIRQ numbers of QE high/low irqs */
+	unsigned int virq_high;
+	unsigned int virq_low;
+};
+
+/*
+ * QE interrupt controller internal structure
+ */
+struct qe_ic_info {
+	/* location of this source at the QIMR register. */
+	u32	mask;
+
+	/* Mask register offset */
+	u32	mask_reg;
+
+	/*
+	 * for grouped interrupts sources - the interrupt
+	 * code as appears at the group priority register
+	 */
+	u8	pri_code;
+
+	/* Group priority register offset */
+	u32	pri_reg;
+};
 
 static DEFINE_RAW_SPINLOCK(qe_ic_lock);
 
diff --git a/drivers/soc/fsl/qe/Makefile b/drivers/soc/fsl/qe/Makefile
index 2031d38..51e4726 100644
--- a/drivers/soc/fsl/qe/Makefile
+++ b/drivers/soc/fsl/qe/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for the linux ppc-specific parts of QE
 #
-obj-$(CONFIG_QUICC_ENGINE)+= qe.o qe_common.o qe_ic.o qe_io.o
+obj-$(CONFIG_QUICC_ENGINE)+= qe.o qe_common.o qe_io.o
 obj-$(CONFIG_CPM)	+= qe_common.o
 obj-$(CONFIG_UCC)	+= ucc.o
 obj-$(CONFIG_UCC_SLOW)	+= ucc_slow.o
diff --git a/drivers/soc/fsl/qe/qe_ic.h b/drivers/soc/fsl/qe/qe_ic.h
deleted file mode 100644
index 926a2ed..0000000
--- a/drivers/soc/fsl/qe/qe_ic.h
+++ /dev/null
@@ -1,103 +0,0 @@
-/*
- * drivers/soc/fsl/qe/qe_ic.h
- *
- * QUICC ENGINE Interrupt Controller Header
- *
- * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
- *
- * Author: Li Yang <leoli@freescale.com>
- * Based on code from Shlomi Gridish <gridish@freescale.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-#ifndef _POWERPC_SYSDEV_QE_IC_H
-#define _POWERPC_SYSDEV_QE_IC_H
-
-#include <soc/fsl/qe/qe_ic.h>
-
-#define NR_QE_IC_INTS		64
-
-/* QE IC registers offset */
-#define QEIC_CICR		0x00
-#define QEIC_CIVEC		0x04
-#define QEIC_CRIPNR		0x08
-#define QEIC_CIPNR		0x0c
-#define QEIC_CIPXCC		0x10
-#define QEIC_CIPYCC		0x14
-#define QEIC_CIPWCC		0x18
-#define QEIC_CIPZCC		0x1c
-#define QEIC_CIMR		0x20
-#define QEIC_CRIMR		0x24
-#define QEIC_CICNR		0x28
-#define QEIC_CIPRTA		0x30
-#define QEIC_CIPRTB		0x34
-#define QEIC_CRICR		0x3c
-#define QEIC_CHIVEC		0x60
-
-/* Interrupt priority registers */
-#define CIPCC_SHIFT_PRI0	29
-#define CIPCC_SHIFT_PRI1	26
-#define CIPCC_SHIFT_PRI2	23
-#define CIPCC_SHIFT_PRI3	20
-#define CIPCC_SHIFT_PRI4	13
-#define CIPCC_SHIFT_PRI5	10
-#define CIPCC_SHIFT_PRI6	7
-#define CIPCC_SHIFT_PRI7	4
-
-/* CICR priority modes */
-#define CICR_GWCC		0x00040000
-#define CICR_GXCC		0x00020000
-#define CICR_GYCC		0x00010000
-#define CICR_GZCC		0x00080000
-#define CICR_GRTA		0x00200000
-#define CICR_GRTB		0x00400000
-#define CICR_HPIT_SHIFT		8
-#define CICR_HPIT_MASK		0x00000300
-#define CICR_HP_SHIFT		24
-#define CICR_HP_MASK		0x3f000000
-
-/* CICNR */
-#define CICNR_WCC1T_SHIFT	20
-#define CICNR_ZCC1T_SHIFT	28
-#define CICNR_YCC1T_SHIFT	12
-#define CICNR_XCC1T_SHIFT	4
-
-/* CRICR */
-#define CRICR_RTA1T_SHIFT	20
-#define CRICR_RTB1T_SHIFT	28
-
-/* Signal indicator */
-#define SIGNAL_MASK		3
-#define SIGNAL_HIGH		2
-#define SIGNAL_LOW		0
-
-struct qe_ic {
-	/* Control registers offset */
-	volatile u32 __iomem *regs;
-
-	/* The remapper for this QEIC */
-	struct irq_domain *irqhost;
-
-	/* The "linux" controller struct */
-	struct irq_chip hc_irq;
-
-	/* VIRQ numbers of QE high/low irqs */
-	unsigned int virq_high;
-	unsigned int virq_low;
-};
-
-/*
- * QE interrupt controller internal structure
- */
-struct qe_ic_info {
-	u32	mask;	  /* location of this source at the QIMR register. */
-	u32	mask_reg; /* Mask register offset */
-	u8	pri_code; /* for grouped interrupts sources - the interrupt
-			     code as appears at the group priority register */
-	u32	pri_reg;  /* Group priority register offset */
-};
-
-#endif /* _POWERPC_SYSDEV_QE_IC_H */
-- 
2.1.0.27.g96db324
