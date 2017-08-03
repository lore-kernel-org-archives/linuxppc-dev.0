Return-Path: <qiang.zhao@nxp.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0080.outbound.protection.outlook.com [104.47.33.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNGRN1tbKzDr2n
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 13:55:12 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <tglx@linutronix.de>
CC: <oss@buserror.net>, <xiaobo.xie@nxp.com>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH v9 4/4] irqchip/qeic: remove PPCisms for QEIC
Date: Thu, 3 Aug 2017 11:38:10 +0800
Message-ID: <1501731490-34402-5-git-send-email-qiang.zhao@nxp.com>
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

QEIC was supported on PowerPC, and dependent on PPC,
Now it is supported on other platforms, so remove PPCisms.

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 arch/powerpc/platforms/83xx/km83xx.c          |   1 -
 arch/powerpc/platforms/83xx/misc.c            |   1 -
 arch/powerpc/platforms/83xx/mpc832x_mds.c     |   1 -
 arch/powerpc/platforms/83xx/mpc832x_rdb.c     |   1 -
 arch/powerpc/platforms/83xx/mpc836x_mds.c     |   1 -
 arch/powerpc/platforms/83xx/mpc836x_rdk.c     |   1 -
 arch/powerpc/platforms/85xx/corenet_generic.c |   1 -
 arch/powerpc/platforms/85xx/mpc85xx_mds.c     |   1 -
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |   1 -
 arch/powerpc/platforms/85xx/twr_p102x.c       |   1 -
 drivers/irqchip/irq-qeic.c                    | 219 +++++++++++++-------------
 include/soc/fsl/qe/qe_ic.h                    | 132 ----------------
 12 files changed, 111 insertions(+), 250 deletions(-)
 delete mode 100644 include/soc/fsl/qe/qe_ic.h

diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index d8642a4..b1cef0a 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -38,7 +38,6 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index c09a135..07a0e61 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -17,7 +17,6 @@
 #include <asm/io.h>
 #include <asm/hw_irq.h>
 #include <asm/ipic.h>
-#include <soc/fsl/qe/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index bb7b25a..a1cadf4 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -37,7 +37,6 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index d7c9b18..6c66527 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -26,7 +26,6 @@
 #include <asm/ipic.h>
 #include <asm/udbg.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 4fc3051..9234d63 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -45,7 +45,6 @@
 #include <sysdev/fsl_pci.h>
 #include <sysdev/simple_gpio.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
index 93f024f..82fa344 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -21,7 +21,6 @@
 #include <asm/ipic.h>
 #include <asm/udbg.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 1b385ac..9ca27b1 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -27,7 +27,6 @@
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <asm/ehv_pic.h>
-#include <soc/fsl/qe/qe_ic.h>
 
 #include <linux/of_platform.h>
 #include <sysdev/fsl_soc.h>
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 06f34a9..8102e5f 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -49,7 +49,6 @@
 #include <sysdev/fsl_pci.h>
 #include <sysdev/simple_gpio.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 #include <asm/mpic.h>
 #include <asm/swiotlb.h>
 #include "smp.h"
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 000d385..f806b6b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -27,7 +27,6 @@
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
index 6be9b33..4f620f2 100644
--- a/arch/powerpc/platforms/85xx/twr_p102x.c
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -23,7 +23,6 @@
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
diff --git a/drivers/irqchip/irq-qeic.c b/drivers/irqchip/irq-qeic.c
index a2d8084..21e3b43 100644
--- a/drivers/irqchip/irq-qeic.c
+++ b/drivers/irqchip/irq-qeic.c
@@ -18,8 +18,11 @@
 #include <linux/of_address.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/irqdomain.h>
 #include <linux/irqchip.h>
 #include <linux/errno.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
@@ -27,9 +30,8 @@
 #include <linux/signal.h>
 #include <linux/device.h>
 #include <linux/spinlock.h>
-#include <asm/irq.h>
+#include <linux/irq.h>
 #include <asm/io.h>
-#include <soc/fsl/qe/qe_ic.h>
 
 #define NR_QE_IC_INTS		64
 
@@ -87,6 +89,43 @@
 #define SIGNAL_HIGH		2
 #define SIGNAL_LOW		0
 
+#define NUM_OF_QE_IC_GROUPS	6
+
+/* Flags when we init the QE IC */
+#define QE_IC_SPREADMODE_GRP_W			0x00000001
+#define QE_IC_SPREADMODE_GRP_X			0x00000002
+#define QE_IC_SPREADMODE_GRP_Y			0x00000004
+#define QE_IC_SPREADMODE_GRP_Z			0x00000008
+#define QE_IC_SPREADMODE_GRP_RISCA		0x00000010
+#define QE_IC_SPREADMODE_GRP_RISCB		0x00000020
+
+#define QE_IC_LOW_SIGNAL			0x00000100
+#define QE_IC_HIGH_SIGNAL			0x00000200
+
+#define QE_IC_GRP_W_PRI0_DEST_SIGNAL_HIGH	0x00001000
+#define QE_IC_GRP_W_PRI1_DEST_SIGNAL_HIGH	0x00002000
+#define QE_IC_GRP_X_PRI0_DEST_SIGNAL_HIGH	0x00004000
+#define QE_IC_GRP_X_PRI1_DEST_SIGNAL_HIGH	0x00008000
+#define QE_IC_GRP_Y_PRI0_DEST_SIGNAL_HIGH	0x00010000
+#define QE_IC_GRP_Y_PRI1_DEST_SIGNAL_HIGH	0x00020000
+#define QE_IC_GRP_Z_PRI0_DEST_SIGNAL_HIGH	0x00040000
+#define QE_IC_GRP_Z_PRI1_DEST_SIGNAL_HIGH	0x00080000
+#define QE_IC_GRP_RISCA_PRI0_DEST_SIGNAL_HIGH	0x00100000
+#define QE_IC_GRP_RISCA_PRI1_DEST_SIGNAL_HIGH	0x00200000
+#define QE_IC_GRP_RISCB_PRI0_DEST_SIGNAL_HIGH	0x00400000
+#define QE_IC_GRP_RISCB_PRI1_DEST_SIGNAL_HIGH	0x00800000
+#define QE_IC_GRP_W_DEST_SIGNAL_SHIFT		(12)
+
+/* QE interrupt sources groups */
+enum qe_ic_grp_id {
+	QE_IC_GRP_W = 0,	/* QE interrupt controller group W */
+	QE_IC_GRP_X,		/* QE interrupt controller group X */
+	QE_IC_GRP_Y,		/* QE interrupt controller group Y */
+	QE_IC_GRP_Z,		/* QE interrupt controller group Z */
+	QE_IC_GRP_RISCA,	/* QE interrupt controller RISC group A */
+	QE_IC_GRP_RISCB		/* QE interrupt controller RISC group B */
+};
+
 struct qe_ic {
 	/* Control registers offset */
 	u32 __iomem *regs;
@@ -265,15 +304,15 @@ static struct qe_ic_info qe_ic_info[] = {
 		},
 };
 
-static inline u32 qe_ic_read(volatile __be32  __iomem * base, unsigned int reg)
+static inline u32 qe_ic_read(__be32  __iomem *base, unsigned int reg)
 {
-	return in_be32(base + (reg >> 2));
+	return ioread32be(base + (reg >> 2));
 }
 
-static inline void qe_ic_write(volatile __be32  __iomem * base, unsigned int reg,
+static inline void qe_ic_write(__be32  __iomem *base, unsigned int reg,
 			       u32 value)
 {
-	out_be32(base + (reg >> 2), value);
+	iowrite32be(value, base + (reg >> 2));
 }
 
 static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
@@ -375,8 +414,8 @@ static const struct irq_domain_ops qe_ic_host_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
-unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
+/* Return an interrupt vector or 0 if no interrupt is pending. */
+static unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 {
 	int irq;
 
@@ -386,13 +425,13 @@ unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 	irq = qe_ic_read(qe_ic->regs, QEIC_CIVEC) >> 26;
 
 	if (irq == 0)
-		return NO_IRQ;
+		return 0;
 
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
 
-/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
-unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
+/* Return an interrupt vector or 0 if no interrupt is pending. */
+static unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 {
 	int irq;
 
@@ -402,11 +441,69 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 	irq = qe_ic_read(qe_ic->regs, QEIC_CHIVEC) >> 26;
 
 	if (irq == 0)
-		return NO_IRQ;
+		return 0;
 
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
 
+static inline void qe_ic_cascade_low_ipic(struct irq_desc *desc)
+{
+	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
+	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
+
+	if (cascade_irq != 0)
+		generic_handle_irq(cascade_irq);
+}
+
+static inline void qe_ic_cascade_high_ipic(struct irq_desc *desc)
+{
+	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
+	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
+
+	if (cascade_irq != 0)
+		generic_handle_irq(cascade_irq);
+}
+
+static inline void qe_ic_cascade_low_mpic(struct irq_desc *desc)
+{
+	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
+	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	if (cascade_irq != 0)
+		generic_handle_irq(cascade_irq);
+
+	chip->irq_eoi(&desc->irq_data);
+}
+
+static inline void qe_ic_cascade_high_mpic(struct irq_desc *desc)
+{
+	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
+	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	if (cascade_irq != 0)
+		generic_handle_irq(cascade_irq);
+
+	chip->irq_eoi(&desc->irq_data);
+}
+
+static inline void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
+{
+	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
+	unsigned int cascade_irq;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	cascade_irq = qe_ic_get_high_irq(qe_ic);
+	if (cascade_irq == 0)
+		cascade_irq = qe_ic_get_low_irq(qe_ic);
+
+	if (cascade_irq != 0)
+		generic_handle_irq(cascade_irq);
+
+	chip->irq_eoi(&desc->irq_data);
+}
+
 static int __init qe_ic_init(struct device_node *node, unsigned int flags)
 {
 	struct qe_ic *qe_ic;
@@ -443,7 +540,7 @@ static int __init qe_ic_init(struct device_node *node, unsigned int flags)
 	qe_ic->virq_high = irq_of_parse_and_map(node, 0);
 	qe_ic->virq_low = irq_of_parse_and_map(node, 1);
 
-	if (qe_ic->virq_low == NO_IRQ) {
+	if (qe_ic->virq_low == 0) {
 		pr_err("Failed to map QE_IC low IRQ\n");
 		ret = -ENOMEM;
 		goto err_domain_remove;
@@ -475,7 +572,7 @@ static int __init qe_ic_init(struct device_node *node, unsigned int flags)
 	irq_set_handler_data(qe_ic->virq_low, qe_ic);
 	irq_set_chained_handler(qe_ic->virq_low, qe_ic_cascade_low_mpic);
 
-	if (qe_ic->virq_high != NO_IRQ &&
+	if (qe_ic->virq_high != 0 &&
 			qe_ic->virq_high != qe_ic->virq_low) {
 		irq_set_handler_data(qe_ic->virq_high, qe_ic);
 		irq_set_chained_handler(qe_ic->virq_high,
@@ -493,100 +590,6 @@ static int __init qe_ic_init(struct device_node *node, unsigned int flags)
 	return ret;
 }
 
-void qe_ic_set_highest_priority(unsigned int virq, int high)
-{
-	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
-	u32 temp = 0;
-
-	temp = qe_ic_read(qe_ic->regs, QEIC_CICR);
-
-	temp &= ~CICR_HP_MASK;
-	temp |= src << CICR_HP_SHIFT;
-
-	temp &= ~CICR_HPIT_MASK;
-	temp |= (high ? SIGNAL_HIGH : SIGNAL_LOW) << CICR_HPIT_SHIFT;
-
-	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
-}
-
-/* Set Priority level within its group, from 1 to 8 */
-int qe_ic_set_priority(unsigned int virq, unsigned int priority)
-{
-	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
-	u32 temp;
-
-	if (priority > 8 || priority == 0)
-		return -EINVAL;
-	if (WARN_ONCE(src >= ARRAY_SIZE(qe_ic_info),
-		      "%s: Invalid hw irq number for QEIC\n", __func__))
-		return -EINVAL;
-	if (qe_ic_info[src].pri_reg == 0)
-		return -EINVAL;
-
-	temp = qe_ic_read(qe_ic->regs, qe_ic_info[src].pri_reg);
-
-	if (priority < 4) {
-		temp &= ~(0x7 << (32 - priority * 3));
-		temp |= qe_ic_info[src].pri_code << (32 - priority * 3);
-	} else {
-		temp &= ~(0x7 << (24 - priority * 3));
-		temp |= qe_ic_info[src].pri_code << (24 - priority * 3);
-	}
-
-	qe_ic_write(qe_ic->regs, qe_ic_info[src].pri_reg, temp);
-
-	return 0;
-}
-
-/* Set a QE priority to use high irq, only priority 1~2 can use high irq */
-int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high)
-{
-	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
-	u32 temp, control_reg = QEIC_CICNR, shift = 0;
-
-	if (priority > 2 || priority == 0)
-		return -EINVAL;
-	if (WARN_ONCE(src >= ARRAY_SIZE(qe_ic_info),
-		      "%s: Invalid hw irq number for QEIC\n", __func__))
-		return -EINVAL;
-
-	switch (qe_ic_info[src].pri_reg) {
-	case QEIC_CIPZCC:
-		shift = CICNR_ZCC1T_SHIFT;
-		break;
-	case QEIC_CIPWCC:
-		shift = CICNR_WCC1T_SHIFT;
-		break;
-	case QEIC_CIPYCC:
-		shift = CICNR_YCC1T_SHIFT;
-		break;
-	case QEIC_CIPXCC:
-		shift = CICNR_XCC1T_SHIFT;
-		break;
-	case QEIC_CIPRTA:
-		shift = CRICR_RTA1T_SHIFT;
-		control_reg = QEIC_CRICR;
-		break;
-	case QEIC_CIPRTB:
-		shift = CRICR_RTB1T_SHIFT;
-		control_reg = QEIC_CRICR;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	shift += (2 - priority) * 2;
-	temp = qe_ic_read(qe_ic->regs, control_reg);
-	temp &= ~(SIGNAL_MASK << shift);
-	temp |= (high ? SIGNAL_HIGH : SIGNAL_LOW) << shift;
-	qe_ic_write(qe_ic->regs, control_reg, temp);
-
-	return 0;
-}
-
 static int __init init_qe_ic(struct device_node *node,
 			     struct device_node *parent)
 {
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
deleted file mode 100644
index 6113699..0000000
--- a/include/soc/fsl/qe/qe_ic.h
+++ /dev/null
@@ -1,132 +0,0 @@
-/*
- * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
- *
- * Authors: 	Shlomi Gridish <gridish@freescale.com>
- * 		Li Yang <leoli@freescale.com>
- *
- * Description:
- * QE IC external definitions and structure.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-#ifndef _ASM_POWERPC_QE_IC_H
-#define _ASM_POWERPC_QE_IC_H
-
-#include <linux/irq.h>
-
-struct device_node;
-struct qe_ic;
-
-#define NUM_OF_QE_IC_GROUPS	6
-
-/* Flags when we init the QE IC */
-#define QE_IC_SPREADMODE_GRP_W			0x00000001
-#define QE_IC_SPREADMODE_GRP_X			0x00000002
-#define QE_IC_SPREADMODE_GRP_Y			0x00000004
-#define QE_IC_SPREADMODE_GRP_Z			0x00000008
-#define QE_IC_SPREADMODE_GRP_RISCA		0x00000010
-#define QE_IC_SPREADMODE_GRP_RISCB		0x00000020
-
-#define QE_IC_LOW_SIGNAL			0x00000100
-#define QE_IC_HIGH_SIGNAL			0x00000200
-
-#define QE_IC_GRP_W_PRI0_DEST_SIGNAL_HIGH	0x00001000
-#define QE_IC_GRP_W_PRI1_DEST_SIGNAL_HIGH	0x00002000
-#define QE_IC_GRP_X_PRI0_DEST_SIGNAL_HIGH	0x00004000
-#define QE_IC_GRP_X_PRI1_DEST_SIGNAL_HIGH	0x00008000
-#define QE_IC_GRP_Y_PRI0_DEST_SIGNAL_HIGH	0x00010000
-#define QE_IC_GRP_Y_PRI1_DEST_SIGNAL_HIGH	0x00020000
-#define QE_IC_GRP_Z_PRI0_DEST_SIGNAL_HIGH	0x00040000
-#define QE_IC_GRP_Z_PRI1_DEST_SIGNAL_HIGH	0x00080000
-#define QE_IC_GRP_RISCA_PRI0_DEST_SIGNAL_HIGH	0x00100000
-#define QE_IC_GRP_RISCA_PRI1_DEST_SIGNAL_HIGH	0x00200000
-#define QE_IC_GRP_RISCB_PRI0_DEST_SIGNAL_HIGH	0x00400000
-#define QE_IC_GRP_RISCB_PRI1_DEST_SIGNAL_HIGH	0x00800000
-#define QE_IC_GRP_W_DEST_SIGNAL_SHIFT		(12)
-
-/* QE interrupt sources groups */
-enum qe_ic_grp_id {
-	QE_IC_GRP_W = 0,	/* QE interrupt controller group W */
-	QE_IC_GRP_X,		/* QE interrupt controller group X */
-	QE_IC_GRP_Y,		/* QE interrupt controller group Y */
-	QE_IC_GRP_Z,		/* QE interrupt controller group Z */
-	QE_IC_GRP_RISCA,	/* QE interrupt controller RISC group A */
-	QE_IC_GRP_RISCB		/* QE interrupt controller RISC group B */
-};
-
-#ifdef CONFIG_QUICC_ENGINE
-unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic);
-unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic);
-#else
-static inline unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
-{ return 0; }
-static inline unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
-{ return 0; }
-#endif /* CONFIG_QUICC_ENGINE */
-
-void qe_ic_set_highest_priority(unsigned int virq, int high);
-int qe_ic_set_priority(unsigned int virq, unsigned int priority);
-int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
-
-static inline void qe_ic_cascade_low_ipic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-}
-
-static inline void qe_ic_cascade_high_ipic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-}
-
-static inline void qe_ic_cascade_low_mpic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-
-	chip->irq_eoi(&desc->irq_data);
-}
-
-static inline void qe_ic_cascade_high_mpic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-
-	chip->irq_eoi(&desc->irq_data);
-}
-
-static inline void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq;
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-
-	cascade_irq = qe_ic_get_high_irq(qe_ic);
-	if (cascade_irq == NO_IRQ)
-		cascade_irq = qe_ic_get_low_irq(qe_ic);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-
-	chip->irq_eoi(&desc->irq_data);
-}
-
-#endif /* _ASM_POWERPC_QE_IC_H */
-- 
2.1.0.27.g96db324
