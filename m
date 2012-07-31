Return-Path: <varuns@nmglablinux27.zin33.ap.freescale.net>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 279CD2C0078
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 00:44:35 +1000 (EST)
Received: from mail60-tx2 (localhost [127.0.0.1])	by mail60-tx2-R.bigfish.com
 (Postfix) with ESMTP id 11A79340149	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 31 Jul 2012 14:44:31 +0000 (UTC)
Received: from TX2EHSMHS012.bigfish.com (unknown [10.9.14.236])	by
 mail60-tx2.bigfish.com (Postfix) with ESMTP id 23FC614004A	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 14:44:28 +0000 (UTC)
Received: from nmglablinux27.zin33.ap.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q6VEiPEd023184	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 07:44:26 -0700
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/3 v3] powerpc/mpic: FSL MPIC error interrupt support.
Date: Tue, 31 Jul 2012 20:12:44 +0530
Message-ID: <1343745764-3788-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bogdan Hamciuc <bogdan.hamciuc@freescale.com>,
 Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All SOC device error interrupts are muxed and delivered to the core as a single
MPIC error interrupt. Currently all the device drivers requiring access to device
errors have to register for the MPIC error interrupt as a shared interrupt.

With this patch we add interrupt demuxing capability in the mpic driver, allowing
device drivers to register for their individual error interrupts. This is achieved
by handling error interrupts in a cascaded fashion.

MPIC error interrupt is handled by the "error_int_handler", which subsequently demuxes
it using the EISR and delivers it to the respective drivers. 

The error interrupt capability is dependent on the MPIC EIMR register, which was
introduced in FSL MPIC version 4.1 (P4080 rev2). So, error interrupt demuxing capability
is dependent on the MPIC version and can be used for versions >= 4.1.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@freescale.com>
[In the initial version of the patch we were using handle_simple_irq
 as the handler for cascaded error interrupts, this resulted
 in issues in case of threaded isrs (with RT kernel). This issue was
 debugged by Bogdan and decision was taken to use the handle_level_irq
 handler]

---
 arch/powerpc/include/asm/mpic.h    |   13 +++
 arch/powerpc/sysdev/Makefile       |    2 +-
 arch/powerpc/sysdev/fsl_mpic_err.c |  152 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/mpic.c         |   41 ++++++++++-
 arch/powerpc/sysdev/mpic.h         |   22 +++++
 5 files changed, 228 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/sysdev/fsl_mpic_err.c

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index e14d35d..5cc8000 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -118,6 +118,9 @@
 #define MPIC_MAX_CPUS		32
 #define MPIC_MAX_ISU		32
 
+#define MPIC_MAX_ERR      32
+#define MPIC_FSL_ERR_INT  16
+
 /*
  * Tsi108 implementation of MPIC has many differences from the original one
  */
@@ -270,6 +273,7 @@ struct mpic
 	struct irq_chip		hc_ipi;
 #endif
 	struct irq_chip		hc_tm;
+	struct irq_chip		hc_err;
 	const char		*name;
 	/* Flags */
 	unsigned int		flags;
@@ -283,6 +287,8 @@ struct mpic
 	/* vector numbers used for internal sources (ipi/timers) */
 	unsigned int		ipi_vecs[4];
 	unsigned int		timer_vecs[8];
+	/* vector numbers used for FSL MPIC error interrupts */
+	unsigned int		err_int_vecs[MPIC_MAX_ERR];
 
 	/* Spurious vector to program into unused sources */
 	unsigned int		spurious_vec;
@@ -306,6 +312,11 @@ struct mpic
 	struct mpic_reg_bank	cpuregs[MPIC_MAX_CPUS];
 	struct mpic_reg_bank	isus[MPIC_MAX_ISU];
 
+	/* ioremap'ed base for error interrupt registers */
+	u32 __iomem	*err_regs;
+	/* error interrupt config */
+	u32			err_int_config_done;
+
 	/* Protected sources */
 	unsigned long		*protected;
 
@@ -370,6 +381,8 @@ struct mpic
 #define MPIC_NO_RESET			0x00004000
 /* Freescale MPIC (compatible includes "fsl,mpic") */
 #define MPIC_FSL			0x00008000
+/* Freescale MPIC supports EIMR (error interrupt mask register)*/
+#define MPIC_FSL_HAS_EIMR		0x00010000
 
 /* MPIC HW modification ID */
 #define MPIC_REGSET_MASK		0xf0000000
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 1bd7ecb..a57600b 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_PPC_DCR_NATIVE)	+= dcr-low.o
 obj-$(CONFIG_PPC_PMI)		+= pmi.o
 obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
-obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
+obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o fsl_mpic_err.o
 obj-$(CONFIG_FSL_PCI)		+= fsl_pci.o $(fsl-msi-obj-y)
 obj-$(CONFIG_FSL_PMC)		+= fsl_pmc.o
 obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
diff --git a/arch/powerpc/sysdev/fsl_mpic_err.c b/arch/powerpc/sysdev/fsl_mpic_err.c
new file mode 100644
index 0000000..1ebfa36
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_mpic_err.c
@@ -0,0 +1,152 @@
+/*
+ * Copyright (C) 2012 Freescale Semiconductor, Inc.
+ *
+ * Author: Varun Sethi <varun.sethi@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the
+ * License.
+ *
+ */
+
+#include <linux/irq.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/mpic.h>
+
+#include "mpic.h"
+
+#define MPIC_ERR_INT_BASE	0x3900
+#define MPIC_ERR_INT_EISR	0x0000
+#define MPIC_ERR_INT_EIMR	0x0010
+
+static inline u32 mpic_fsl_err_read(u32 __iomem *base, unsigned int err_reg)
+{
+	return in_be32(base + (err_reg >> 2));
+}
+
+static inline void mpic_fsl_err_write(u32 __iomem *base, u32 value)
+{
+	out_be32(base + (MPIC_ERR_INT_EIMR >> 2), value);
+}
+
+static void fsl_mpic_mask_err(struct irq_data *d)
+{
+	u32 eimr;
+	struct mpic *mpic = irq_data_get_irq_chip_data(d);
+	unsigned int src = virq_to_hw(d->irq) - mpic->err_int_vecs[0];
+
+	eimr = mpic_fsl_err_read(mpic->err_regs, MPIC_ERR_INT_EIMR);
+	eimr |= (1 << (31 - src));
+	mpic_fsl_err_write(mpic->err_regs, eimr);
+}
+
+static void fsl_mpic_unmask_err(struct irq_data *d)
+{
+	u32 eimr;
+	struct mpic *mpic = irq_data_get_irq_chip_data(d);
+	unsigned int src = virq_to_hw(d->irq) - mpic->err_int_vecs[0];
+
+	eimr = mpic_fsl_err_read(mpic->err_regs, MPIC_ERR_INT_EIMR);
+	eimr &= ~(1 << (31 - src));
+	mpic_fsl_err_write(mpic->err_regs, eimr);
+}
+
+static struct irq_chip fsl_mpic_err_chip = {
+	.irq_disable	= fsl_mpic_mask_err,
+	.irq_mask	= fsl_mpic_mask_err,
+	.irq_unmask	= fsl_mpic_unmask_err,
+};
+
+void mpic_setup_error_int(struct mpic *mpic, int intvec)
+{
+	int i;
+
+	mpic->err_regs = ioremap(mpic->paddr + MPIC_ERR_INT_BASE, 0x1000);
+	if (!mpic->err_regs) {
+		pr_err("could not map mpic error registers\n");
+		return;
+	}
+	mpic->hc_err = fsl_mpic_err_chip;
+	mpic->hc_err.name = mpic->name;
+	mpic->flags |= MPIC_FSL_HAS_EIMR;
+	/* allocate interrupt vectors for error interrupts */
+	for (i = MPIC_MAX_ERR - 1; i >= 0; i--)
+		mpic->err_int_vecs[i] = --intvec;
+
+}
+
+int mpic_map_error_int(struct mpic *mpic, unsigned int virq, irq_hw_number_t  hw)
+{
+	if ((mpic->flags & MPIC_FSL_HAS_EIMR) &&
+	    (hw >= mpic->err_int_vecs[0] &&
+	     hw <= mpic->err_int_vecs[MPIC_MAX_ERR - 1])) {
+		WARN_ON(mpic->flags & MPIC_SECONDARY);
+
+		pr_debug("mpic: mapping as Error Interrupt\n");
+		irq_set_chip_data(virq, mpic);
+		irq_set_chip_and_handler(virq, &mpic->hc_err,
+					 handle_level_irq);
+		return 1;
+	}
+
+	return 0;
+}
+
+static irqreturn_t fsl_error_int_handler(int irq, void *data)
+{
+	struct mpic *mpic = (struct mpic *) data;
+	u32 eisr, eimr;
+	int errint;
+	unsigned int cascade_irq;
+
+	eisr = mpic_fsl_err_read(mpic->err_regs, MPIC_ERR_INT_EISR);
+	eimr = mpic_fsl_err_read(mpic->err_regs, MPIC_ERR_INT_EIMR);
+
+	if (!(eisr & ~eimr))
+		return IRQ_NONE;
+
+	while (eisr) {
+		errint = __builtin_clz(eisr);
+		cascade_irq = irq_linear_revmap(mpic->irqhost,
+				 mpic->err_int_vecs[errint]);
+		WARN_ON(cascade_irq == NO_IRQ);
+		if (cascade_irq != NO_IRQ) {
+			generic_handle_irq(cascade_irq);
+		} else {
+			eimr |=  1 << (31 - errint);
+			mpic_fsl_err_write(mpic->err_regs, eimr);
+		}
+		eisr &= ~(1 << (31 - errint));
+	}
+
+	return IRQ_HANDLED;
+}
+
+int mpic_err_int_init(struct mpic *mpic, irq_hw_number_t irqnum)
+{
+	unsigned int virq;
+	int ret;
+
+	virq = irq_create_mapping(mpic->irqhost, irqnum);
+	if (virq == NO_IRQ) {
+		pr_err("Error interrupt setup failed\n");
+		return 0;
+	}
+
+	/* Mask all error interrupts */
+	mpic_fsl_err_write(mpic->err_regs, ~0);
+
+	ret = request_irq(virq, fsl_error_int_handler, IRQF_NO_THREAD,
+		    "mpic-error-int", mpic);
+	if (ret) {
+		pr_err("Failed to register error interrupt handler\n");
+		return 0;
+	}
+
+	return 1;
+}
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 7e32db7..2a0b632 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1026,6 +1026,9 @@ static int mpic_host_map(struct irq_domain *h, unsigned int virq,
 		return 0;
 	}
 
+	if (mpic_map_error_int(mpic, virq, hw))
+		return 0;
+
 	if (hw >= mpic->num_sources)
 		return -EINVAL;
 
@@ -1085,7 +1088,16 @@ static int mpic_host_xlate(struct irq_domain *h, struct device_node *ct,
 		 */
 		switch (intspec[2]) {
 		case 0:
-		case 1: /* no EISR/EIMR support for now, treat as shared IRQ */
+			break;
+		case 1:
+			if (!mpic->err_int_config_done)
+				break;
+
+			if (intspec[3] >= ARRAY_SIZE(mpic->err_int_vecs))
+				return -EINVAL;
+
+			*out_hwirq = mpic->err_int_vecs[intspec[3]];
+
 			break;
 		case 2:
 			if (intspec[0] >= ARRAY_SIZE(mpic->ipi_vecs))
@@ -1302,6 +1314,8 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	mpic_map(mpic, mpic->paddr, &mpic->tmregs, MPIC_INFO(TIMER_BASE), 0x1000);
 
 	if (mpic->flags & MPIC_FSL) {
+		u32 brr1, version;
+
 		/*
 		 * Yes, Freescale really did put global registers in the
 		 * magic per-cpu area -- and they don't even show up in the
@@ -1309,6 +1323,26 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 		 */
 		mpic_map(mpic, mpic->paddr, &mpic->thiscpuregs,
 			 MPIC_CPU_THISBASE, 0x1000);
+
+		brr1 = _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
+				MPIC_FSL_BRR1);
+		version = brr1 & MPIC_FSL_BRR1_VER;
+
+		/* Error interrupt mask register (EIMR) is required for
+		 * handling individual device error interrupts. EIMR
+		 * was added in MPIC version 4.1.
+		 *
+		 * Over here we reserve vector number space for error
+		 * interrupt vectors. This space is stolen from the
+		 * global vector number space, as in case of ipis
+		 * and timer interrupts.
+		 *
+		 * Available vector space = intvec_top - 12, where 12
+		 * is the number of vectors which have been consumed by
+		 * ipis and timer interrupts.
+		 */
+		if (version >= 0x401)
+			mpic_setup_error_int(mpic, intvec_top - 12);
 	}
 
 	/* Reset */
@@ -1474,6 +1508,11 @@ void __init mpic_init(struct mpic *mpic)
 			num_timers = 8;
 	}
 
+	/* FSL mpic error interrupt intialization */
+	if (mpic->flags & MPIC_FSL_HAS_EIMR)
+		mpic->err_int_config_done =
+			mpic_err_int_init(mpic, MPIC_FSL_ERR_INT);
+
 	/* Initialize timers to our reserved vectors and mask them for now */
 	for (i = 0; i < num_timers; i++) {
 		unsigned int offset = mpic_tm_offset(mpic, i);
diff --git a/arch/powerpc/sysdev/mpic.h b/arch/powerpc/sysdev/mpic.h
index 13f3e89..1a6995a 100644
--- a/arch/powerpc/sysdev/mpic.h
+++ b/arch/powerpc/sysdev/mpic.h
@@ -40,4 +40,26 @@ extern int mpic_set_affinity(struct irq_data *d,
 			     const struct cpumask *cpumask, bool force);
 extern void mpic_reset_core(int cpu);
 
+#ifdef CONFIG_FSL_SOC
+extern int mpic_map_error_int(struct mpic *mpic, unsigned int virq, irq_hw_number_t  hw);
+extern int mpic_err_int_init(struct mpic *mpic, irq_hw_number_t irqnum);
+extern void mpic_setup_error_int(struct mpic *mpic, int intvec);
+#else
+static inline int mpic_map_error_int(struct mpic *mpic, unsigned int virq, irq_hw_number_t  hw)
+{
+	return 0;
+}
+
+
+static inline int mpic_err_int_init(struct mpic *mpic, irq_hw_number_t irqnum)
+{
+	return -1;
+}
+
+static inline void mpic_setup_error_int(struct mpic *mpic, int intvec)
+{
+	return;
+}
+#endif
+
 #endif /* _POWERPC_SYSDEV_MPIC_H */
-- 
1.7.4.1
