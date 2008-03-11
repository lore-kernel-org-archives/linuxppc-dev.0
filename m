Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6B8F1DEC3C
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 04:24:31 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 610388810
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 22:24:43 +0400 (SAMT)
Date: Tue, 11 Mar 2008 20:24:29 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/8] [POWERPC] sysdev,qe_lib: implement FSL GTM support
Message-ID: <20080311172429.GF7727@localhost.localdomain>
References: <20080311172106.GA4766@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080311172106.GA4766@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

GTM stands for General-purpose Timers Module and able to generate
timer{1,2,3,4} interrupts.

There are several limitations in this support:
1. Cascaded (32 bit) timers unimplemented (1-2, 3-4).
   This is straightforward to implement when needed, two timers should
   be marked as "requested" and configured as appropriate.
2. Super-cascaded (64 bit) timers unimplemented (1-2-3-4).
   This is also straightforward to implement when needed, all timers
   should be marked as "requested" and configured as appropriate.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |   27 +++-
 arch/powerpc/Kconfig                         |    5 +
 arch/powerpc/sysdev/Makefile                 |    1 +
 arch/powerpc/sysdev/fsl_gtm.c                |  263 ++++++++++++++++++++++++++
 arch/powerpc/sysdev/qe_lib/Kconfig           |    5 +
 arch/powerpc/sysdev/qe_lib/Makefile          |    1 +
 arch/powerpc/sysdev/qe_lib/gtm.c             |   47 +++++
 include/asm-powerpc/fsl_gtm.h                |  138 ++++++++++++++
 8 files changed, 486 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/sysdev/fsl_gtm.c
 create mode 100644 arch/powerpc/sysdev/qe_lib/gtm.c
 create mode 100644 include/asm-powerpc/fsl_gtm.h

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 8ae57f2..b506245 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -57,7 +57,8 @@ Table of Contents
       n) 4xx/Axon EMAC ethernet nodes
       o) Xilinx IP cores
       p) Freescale Synchronous Serial Interface
-	  q) USB EHCI controllers
+      q) USB EHCI controllers
+      r) Freescale General-purpose Timers Module
 
   VII - Specifying interrupt information for devices
     1) interrupts property
@@ -2811,6 +2812,30 @@ platforms are moved over to use the flattened-device-tree model.
 		   big-endian;
 	   };
 
+    r) Freescale General-purpose Timers Module
+
+    Required properties:
+      - compatible : should be "fsl,gtm" ("fsl,qe-gtm" in addition for QE
+                     GTMs).
+      - reg : should contain gtm registers location and length (0x40).
+      - interrupts : should contain four interrupts.
+      - interrupt-parent : interrupt source phandle.
+
+    Example:
+
+    gtm@500 {
+    	compatible = "fsl,gtm";
+    	reg = <0x500 0x40>;
+    	interrupts = <90 8 78 8 84 8 72 8>;
+    	interrupt-parent = <&ipic>;
+    };
+
+    gtm@440 {
+    	compatible = "fsl,qe-gtm", "fsl,gtm";
+    	reg = <0x440 0x40>;
+    	interrupts = <12 13 14 15>;
+    	interrupt-parent = <&qeic>;
+    };
 
    More devices will be defined as this spec matures.
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9c68592..0b27cbd 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -496,6 +496,11 @@ config FSL_LBC
 	help
 	  Freescale Localbus support
 
+config FSL_GTM
+	bool
+	help
+	  Freescale General-purpose Timers support
+
 # Yes MCA RS/6000s exist but Linux-PPC does not currently support any
 config MCA
 	bool
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 62b6ef0..a7e8da4 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_FSL_PCI)		+= fsl_pci.o
 obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
+obj-$(CONFIG_FSL_GTM)		+= fsl_gtm.o
 obj-$(CONFIG_RAPIDIO)		+= fsl_rio.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
diff --git a/arch/powerpc/sysdev/fsl_gtm.c b/arch/powerpc/sysdev/fsl_gtm.c
new file mode 100644
index 0000000..975fe4e
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_gtm.c
@@ -0,0 +1,263 @@
+/*
+ * Freescale General-purpose Timers Module
+ *
+ * Copyright (c) Freescale Semicondutor, Inc. 2006.
+ *               Shlomi Gridish <gridish@freescale.com>
+ *               Jerry Huang <Chang-Ming.Huang@freescale.com>
+ * Copyright (c) MontaVista Software, Inc. 2008.
+ *               Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/spinlock.h>
+#include <asm/fsl_gtm.h>
+
+struct gtm_timer *gtm_get_timer(int width)
+{
+	struct device_node *np;
+	struct gtm *gtm = NULL;
+	int i;
+
+	if (width != 16)
+		return ERR_PTR(-ENOSYS);
+
+	for_each_compatible_node(np, NULL, "fsl,gtm") {
+		if (!np->data) {
+			WARN_ON(1);
+			continue;
+		}
+		gtm = np->data;
+
+		spin_lock_irq(&gtm->lock);
+
+		for (i = 0; i < ARRAY_SIZE(gtm->timers); i++) {
+			if (!gtm->timers[i].requested) {
+				gtm->timers[i].requested = true;
+				spin_unlock_irq(&gtm->lock);
+				of_node_put(np);
+				return &gtm->timers[i];
+			}
+		}
+
+		spin_unlock_irq(&gtm->lock);
+	}
+
+	if (gtm)
+		return ERR_PTR(-EBUSY);
+	return ERR_PTR(-ENODEV);
+}
+EXPORT_SYMBOL(gtm_get_timer);
+
+void gtm_put_timer(struct gtm_timer *tmr)
+{
+	spin_lock_irq(&tmr->gtm->lock);
+
+	tmr->requested = false;
+
+	spin_unlock_irq(&tmr->gtm->lock);
+}
+EXPORT_SYMBOL(gtm_put_timer);
+
+int gtm_reset_ref_timer_16(struct gtm_timer *tmr, unsigned int hz, u16 ref,
+			   bool ffr)
+{
+	struct gtm *gtm = tmr->gtm;
+	int num = tmr - &gtm->timers[0];
+	unsigned long flags;
+	unsigned int prescaler;
+	u8 iclk = GTMDR_ICLK_ICLK;
+	u8 psr;
+	u8 sps;
+
+	prescaler = gtm->clock / hz;
+
+	/*
+	 * We have two 8 bit prescalers -- primary and secondary (psr, sps),
+	 * plus "slow go" mode (clk / 16). So, total prescale value is
+	 * 16 * (psr + 1) * (sps + 1).
+	 */
+	if (prescaler > 256 * 256 * 16)
+		return -EINVAL;
+
+	if (prescaler > 256 * 256) {
+		iclk = GTMDR_ICLK_SLGO;
+		prescaler /= 16;
+	}
+
+	if (prescaler > 256) {
+		psr = 256 - 1;
+		sps = prescaler / 256 - 1;
+	} else {
+		psr = prescaler - 1;
+		sps = 1 - 1;
+	}
+
+	spin_lock_irqsave(&gtm->lock, flags);
+
+	/*
+	 * Properly reset timers: stop, reset, set up prescalers, reference
+	 * value and clear event register.
+	 */
+	clrsetbits_8(tmr->gtcfr, ~(GTCFR_STP(num) | GTCFR_RST(num)),
+				 GTCFR_STP(num) | GTCFR_RST(num));
+
+	setbits8(tmr->gtcfr, GTCFR_STP(num));
+
+	out_be16(tmr->gtpsr, psr);
+	clrsetbits_be16(tmr->gtmdr, 0xFFFF, iclk | GTMDR_SPS(sps) |
+			GTMDR_ORI | (ffr ? GTMDR_FFR : 0));
+	out_be16(tmr->gtcnr, 0);
+	out_be16(tmr->gtrfr, ref);
+	out_be16(tmr->gtevr, 0xFFFF);
+
+	/* Let it be. */
+	clrbits8(tmr->gtcfr, GTCFR_STP(num));
+
+	spin_unlock_irqrestore(&gtm->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(gtm_reset_ref_timer_16);
+
+void gtm_stop_timer_16(struct gtm_timer *tmr)
+{
+	struct gtm *gtm = tmr->gtm;
+	int num = tmr - &gtm->timers[0];
+	unsigned long flags;
+
+	spin_lock_irqsave(&gtm->lock, flags);
+
+	setbits8(tmr->gtcfr, GTCFR_STP(num));
+
+	spin_unlock_irqrestore(&gtm->lock, flags);
+}
+EXPORT_SYMBOL(gtm_stop_timer_16);
+
+static void __init gtm_set_shortcuts(struct gtm_timer *timers,
+				     struct gtm_timers_regs __iomem *regs)
+{
+	/*
+	 * Yeah, I don't like this either, but timers' registers a bit messed,
+	 * so we have to provide shortcuts to write timer independent code.
+	 * Alternative option is to create gt*() accessors, but that will be
+	 * even uglier and cryptic.
+	 */
+	timers[0].gtcfr = &regs->gtcfr1;
+	timers[0].gtmdr = &regs->gtmdr1;
+	timers[0].gtpsr = &regs->gtpsr1;
+	timers[0].gtcnr = &regs->gtcnr1;
+	timers[0].gtrfr = &regs->gtrfr1;
+	timers[0].gtevr = &regs->gtevr1;
+
+	timers[1].gtcfr = &regs->gtcfr1;
+	timers[1].gtmdr = &regs->gtmdr2;
+	timers[1].gtpsr = &regs->gtpsr2;
+	timers[1].gtcnr = &regs->gtcnr2;
+	timers[1].gtrfr = &regs->gtrfr2;
+	timers[1].gtevr = &regs->gtevr2;
+
+	timers[2].gtcfr = &regs->gtcfr2;
+	timers[2].gtmdr = &regs->gtmdr3;
+	timers[2].gtpsr = &regs->gtpsr3;
+	timers[2].gtcnr = &regs->gtcnr3;
+	timers[2].gtrfr = &regs->gtrfr3;
+	timers[2].gtevr = &regs->gtevr3;
+
+	timers[3].gtcfr = &regs->gtcfr2;
+	timers[3].gtmdr = &regs->gtmdr4;
+	timers[3].gtpsr = &regs->gtpsr4;
+	timers[3].gtcnr = &regs->gtcnr4;
+	timers[3].gtrfr = &regs->gtrfr4;
+	timers[3].gtevr = &regs->gtevr4;
+}
+
+static int __init gtm_get_clock(struct gtm *gtm, struct device_node *np)
+{
+	struct device_node *parent;
+	const u32 *clock;
+	int size;
+	int ret;
+
+	parent = of_get_parent(np);
+	if (!parent) {
+		pr_err("%s: no parent?\n", np->full_name);
+		return -EINVAL;
+	}
+
+	clock = of_get_property(parent, "clock-frequency", &size);
+	if (!clock || size != sizeof(*clock)) {
+		pr_err("%s: no clock-frequency for %s\n",
+		       np->full_name, parent->full_name);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = 0;
+	gtm->clock = *clock;
+err:
+	of_node_put(parent);
+	return ret;
+}
+
+static int __init gtm_init_gtm(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "fsl,gtm") {
+		int i;
+		struct gtm *gtm;
+
+		gtm = kzalloc(sizeof(*gtm), GFP_KERNEL);
+		if (!gtm) {
+			pr_err("%s: unable to allocate memory\n",
+				np->full_name);
+			continue;
+		}
+
+		spin_lock_init(&gtm->lock);
+
+		if (gtm_get_clock(gtm, np))
+			goto err;
+
+		for (i = 0; i < ARRAY_SIZE(gtm->timers); i++) {
+			int ret;
+			struct resource irq;
+
+			ret = of_irq_to_resource(np, i, &irq);
+			if (ret == NO_IRQ) {
+				pr_err("%s: not enough interrupts specified\n",
+				       np->full_name);
+				goto err;
+			}
+			gtm->timers[i].irq = irq.start;
+			gtm->timers[i].gtm = gtm;
+		}
+
+		gtm->regs = of_iomap(np, 0);
+		if (!gtm->regs) {
+			pr_err("%s: unable to iomap registers\n",
+			       np->full_name);
+			goto err;
+		}
+
+		gtm_set_shortcuts(gtm->timers, gtm->regs);
+
+		/* We don't want to lose the node and its ->data */
+		of_node_get(np);
+		np->data = gtm;
+
+		continue;
+err:
+		kfree(gtm);
+	}
+	return 0;
+}
+arch_initcall(gtm_init_gtm);
diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/sysdev/qe_lib/Kconfig
index adc6621..c1f2849 100644
--- a/arch/powerpc/sysdev/qe_lib/Kconfig
+++ b/arch/powerpc/sysdev/qe_lib/Kconfig
@@ -20,3 +20,8 @@ config UCC
 	bool
 	default y if UCC_FAST || UCC_SLOW
 
+config QE_GTM
+	bool
+	default y if FSL_GTM
+	help
+	  QE General-purpose Timers Module support
diff --git a/arch/powerpc/sysdev/qe_lib/Makefile b/arch/powerpc/sysdev/qe_lib/Makefile
index 874fe1a..3297a52 100644
--- a/arch/powerpc/sysdev/qe_lib/Makefile
+++ b/arch/powerpc/sysdev/qe_lib/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_QUICC_ENGINE)+= qe.o qe_ic.o qe_io.o
 obj-$(CONFIG_UCC)	+= ucc.o
 obj-$(CONFIG_UCC_SLOW)	+= ucc_slow.o
 obj-$(CONFIG_UCC_FAST)	+= ucc_fast.o
+obj-$(CONFIG_QE_GTM)	+= gtm.o
diff --git a/arch/powerpc/sysdev/qe_lib/gtm.c b/arch/powerpc/sysdev/qe_lib/gtm.c
new file mode 100644
index 0000000..2ce9c25
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/gtm.c
@@ -0,0 +1,47 @@
+/*
+ * QE General-purpose Timers Module
+ *
+ * Copyright (c) Freescale Semicondutor, Inc. 2006.
+ *               Shlomi Gridish <gridish@freescale.com>
+ *               Jerry Huang <Chang-Ming.Huang@freescale.com>
+ * Copyright (c) MontaVista Software, Inc. 2008.
+ *               Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <asm/qe.h>
+#include <asm/fsl_gtm.h>
+
+/*
+ * For now we just fixing up the clock -- it's brg-frequency for QE
+ * chips, generic code does not and should not know these details.
+ *
+ * Later we might want to set up BRGs, when QE will actually use
+ * them (there are TIMERCS bits in the CMXGCR register, but today
+ * these bits seem to be no-ops.
+ */
+static int __init qe_init_gtm(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "fsl,qe-gtm") {
+		struct gtm *gtm = np->data;
+
+		if (!gtm) {
+			/* fsl,qe-gtm without fsl,gtm compatible? */
+			WARN_ON(1);
+			continue;
+		}
+
+		gtm->clock = qe_get_brg_clk();
+	}
+
+	return 0;
+}
+arch_initcall(qe_init_gtm);
diff --git a/include/asm-powerpc/fsl_gtm.h b/include/asm-powerpc/fsl_gtm.h
new file mode 100644
index 0000000..bdb9d5a
--- /dev/null
+++ b/include/asm-powerpc/fsl_gtm.h
@@ -0,0 +1,138 @@
+/*
+ * Freescale General-purpose Timers Module
+ *
+ * Copyright (c) Freescale Semicondutor, Inc. 2006.
+ *               Shlomi Gridish <gridish@freescale.com>
+ *               Jerry Huang <Chang-Ming.Huang@freescale.com>
+ * Copyright (c) MontaVista Software, Inc. 2008.
+ *               Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_FSL_GTM_H
+#define __ASM_FSL_GTM_H
+
+#include <linux/types.h>
+#include <linux/spinlock.h>
+
+#define GTCFR_STP(x)		((x) & 1 ? 1 << 5 : 1 << 1)
+#define GTCFR_RST(x)		((x) & 1 ? 1 << 4 : 1 << 0)
+
+#define GTMDR_ICLK_MASK		(3 << 1)
+#define GTMDR_ICLK_ICAS		(0 << 1)
+#define GTMDR_ICLK_ICLK		(1 << 1)
+#define GTMDR_ICLK_SLGO		(2 << 1)
+#define GTMDR_FFR		(1 << 3)
+#define GTMDR_ORI		(1 << 4)
+#define GTMDR_SPS(x)		((x) << 8)
+
+struct gtm_timers_regs {
+	u8	gtcfr1;		/* Timer 1, Timer 2 global config register */
+	u8	res0[0x3];
+	u8	gtcfr2;		/* Timer 3, timer 4 global config register */
+	u8	res1[0xB];
+	__be16	gtmdr1;		/* Timer 1 mode register */
+	__be16	gtmdr2;		/* Timer 2 mode register */
+	__be16	gtrfr1;		/* Timer 1 reference register */
+	__be16	gtrfr2;		/* Timer 2 reference register */
+	__be16	gtcpr1;		/* Timer 1 capture register */
+	__be16	gtcpr2;		/* Timer 2 capture register */
+	__be16	gtcnr1;		/* Timer 1 counter */
+	__be16	gtcnr2;		/* Timer 2 counter */
+	__be16	gtmdr3;		/* Timer 3 mode register */
+	__be16	gtmdr4;		/* Timer 4 mode register */
+	__be16	gtrfr3;		/* Timer 3 reference register */
+	__be16	gtrfr4;		/* Timer 4 reference register */
+	__be16	gtcpr3;		/* Timer 3 capture register */
+	__be16	gtcpr4;		/* Timer 4 capture register */
+	__be16	gtcnr3;		/* Timer 3 counter */
+	__be16	gtcnr4;		/* Timer 4 counter */
+	__be16	gtevr1;		/* Timer 1 event register */
+	__be16	gtevr2;		/* Timer 2 event register */
+	__be16	gtevr3;		/* Timer 3 event register */
+	__be16	gtevr4;		/* Timer 4 event register */
+	__be16	gtpsr1;		/* Timer 1 prescale register */
+	__be16	gtpsr2;		/* Timer 2 prescale register */
+	__be16	gtpsr3;		/* Timer 3 prescale register */
+	__be16	gtpsr4;		/* Timer 4 prescale register */
+	u8 res2[0x40];
+} __attribute__ ((packed));
+
+struct gtm_timer {
+	unsigned int irq;
+
+	struct gtm *gtm;
+	bool requested;
+	u8 __iomem *gtcfr;
+	__be16 __iomem *gtmdr;
+	__be16 __iomem *gtpsr;
+	__be16 __iomem *gtcnr;
+	__be16 __iomem *gtrfr;
+	__be16 __iomem *gtevr;
+};
+
+struct gtm {
+	unsigned int clock;
+	struct gtm_timers_regs __iomem *regs;
+	struct gtm_timer timers[4];
+	spinlock_t lock;
+};
+
+/**
+ * gtm_get_timer - request GTM timer for use with the rest of GTM API
+ * @width:	timer width (only 16 bits wide timers implemented so far)
+ *
+ * This function reserves GTM timer for later use. It returns gtm_timer
+ * structure to use with the rest of GTM API, you should use timer->irq
+ * to manage timer interrupt.
+ */
+extern struct gtm_timer *gtm_get_timer(int width);
+
+/**
+ * gtm_put_timer - release GTM timer
+ * @width:	timer width (only 16 bits wide timers implemented so far)
+ *
+ * This function releases GTM timer sp others might request it.
+ */
+extern void gtm_put_timer(struct gtm_timer *tmr);
+
+/**
+ * gtm_reset_ref_timer_16 - (re)set single (16 bits) timer in reference mode
+ * @tmr:	pointer to the gtm_timer structure obtained from gtm_get_timer
+ * @hz:		timer rate in Hz
+ * @ref:	refernce value
+ * @ffr:	free run flag
+ *
+ * Thus function (re)sets GTM timer so it counts up to the reference value and
+ * fires the interrupt when the value is reached. If ffr flag is set, timer
+ * will also reset itself upon reference value, otherwise it continues to
+ * increment.
+ */
+extern int gtm_reset_ref_timer_16(struct gtm_timer *tmr, unsigned int hz,
+				  u16 ref, bool ffr);
+
+/**
+ * gtm_ack_ref_timer_16 - acknowledge timer event (free-run timers only)
+ * @tmr:	pointer to the gtm_timer structure obtained from gtm_get_timer
+ *
+ * Thus function used to acknowledge timer interrupt event, use it inside the
+ * interrupt handler.
+ */
+static inline void gtm_ack_ref_timer_16(struct gtm_timer *tmr)
+{
+	out_be16(tmr->gtevr, 0xFFFF);
+}
+
+/**
+ * gtm_stop_timer_16 - stop single timer
+ * @tmr:	pointer to the gtm_timer structure obtained from gtm_get_timer
+ *
+ * This function simply stops the GTM timer.
+ */
+extern void gtm_stop_timer_16(struct gtm_timer *tmr);
+
+#endif /* __ASM_FSL_GTM_H */
-- 
1.5.2.2
