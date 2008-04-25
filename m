Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id BC7C6DDE06
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 03:01:02 +1000 (EST)
Date: Fri, 25 Apr 2008 21:01:00 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/6] [POWERPC] sysdev: implement FSL GTM support
Message-ID: <20080425170100.GA12154@polina.dev.rtsoft.ru>
References: <20080425170014.GA11669@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080425170014.GA11669@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

GTM stands for General-purpose Timers Module and able to generate
timer{1,2,3,4} interrupts. These timers are used by the drivers that
need time precise interrupts (like for USB transactions scheduling for
the Freescale USB Host controller as found in some QE and CPM chips),
or these timers could be used as wakeup events from the CPU deep-sleep
mode.

Things unimplemented:
1. Cascaded (32 bit) timers (1-2, 3-4).
   This is straightforward to implement when needed, two timers should
   be marked as "requested" and configured as appropriate.
2. Super-cascaded (64 bit) timers (1-2-3-4).
   This is also straightforward to implement when needed, all timers
   should be marked as "requested" and configured as appropriate.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |   34 ++-
 arch/powerpc/Kconfig                         |    5 +
 arch/powerpc/sysdev/Makefile                 |    1 +
 arch/powerpc/sysdev/fsl_gtm.c                |  437 ++++++++++++++++++++++++++
 include/asm-powerpc/fsl_gtm.h                |   34 ++
 5 files changed, 510 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/sysdev/fsl_gtm.c
 create mode 100644 include/asm-powerpc/fsl_gtm.h

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 4cc7800..0f3738e 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -57,7 +57,8 @@ Table of Contents
       n) 4xx/Axon EMAC ethernet nodes
       o) Xilinx IP cores
       p) Freescale Synchronous Serial Interface
-	  q) USB EHCI controllers
+      q) USB EHCI controllers
+      r) Freescale General-purpose Timers Module
 
   VII - Marvell Discovery mv64[345]6x System Controller chips
     1) The /system-controller node
@@ -2825,6 +2826,37 @@ platforms are moved over to use the flattened-device-tree model.
 		   big-endian;
 	   };
 
+    r) Freescale General-purpose Timers Module
+
+    Required properties:
+      - compatible : should be
+        "fsl,<chip>-gtm", "fsl,gtm" for SOC GTMs
+        "fsl,<chip>-qe-gtm", "fsl,qe-gtm", "fsl,gtm" for QE GTMs
+        "fsl,<chip>-cpm2-gtm", "fsl,cpm2-gtm", "fsl,gtm" for CPM2 GTMs
+      - reg : should contain gtm registers location and length (0x40).
+      - interrupts : should contain four interrupts.
+      - interrupt-parent : interrupt source phandle.
+      - clock-frequency : specifies the frequency driving the timer.
+
+    Example:
+
+    timer@500 {
+    	compatible = "fsl,mpc8360-gtm", "fsl,gtm";
+    	reg = <0x500 0x40>;
+    	interrupts = <90 8 78 8 84 8 72 8>;
+    	interrupt-parent = <&ipic>;
+    	/* filled by u-boot */
+    	clock-frequency = <0>;
+    };
+
+    timer@440 {
+    	compatible = "fsl,mpc8360-qe-gtm", "fsl,qe-gtm", "fsl,gtm";
+    	reg = <0x440 0x40>;
+    	interrupts = <12 13 14 15>;
+    	interrupt-parent = <&qeic>;
+    	/* filled by u-boot */
+    	clock-frequency = <0>;
+    };
 
 VII - Marvell Discovery mv64[345]6x System Controller chips
 ===========================================================
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7f2f126..ad874e4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -525,6 +525,11 @@ config FSL_LBC
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
index 6d386d0..9d3ddd2 100644
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
index 0000000..ada2b0e
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_gtm.c
@@ -0,0 +1,437 @@
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
+#include <linux/list.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/spinlock.h>
+#include <linux/bitops.h>
+#include <asm/fsl_gtm.h>
+
+#define GTCFR_STP(x)		((x) & 1 ? 1 << 5 : 1 << 1)
+#define GTCFR_RST(x)		((x) & 1 ? 1 << 4 : 1 << 0)
+
+#define GTMDR_ICLK_MASK		(3 << 1)
+#define GTMDR_ICLK_ICAS		(0 << 1)
+#define GTMDR_ICLK_ICLK		(1 << 1)
+#define GTMDR_ICLK_SLGO		(2 << 1)
+#define GTMDR_FRR		(1 << 3)
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
+	struct list_head list_node;
+};
+
+static LIST_HEAD(gtms);
+
+/**
+ * gtm_get_timer - request GTM timer to use it with the rest of GTM API
+ * @width:	timer width (only 16 bits wide timers implemented so far)
+ *
+ * This function reserves GTM timer for later use. It returns gtm_timer
+ * structure to use with the rest of GTM API, you should use timer->irq
+ * to manage timer interrupt.
+ */
+struct gtm_timer *gtm_get_timer(int width)
+{
+	struct gtm *gtm = NULL;
+	int i;
+
+	if (width != 16)
+		return ERR_PTR(-ENOSYS);
+
+	list_for_each_entry(gtm, &gtms, list_node) {
+		spin_lock_irq(&gtm->lock);
+
+		for (i = 0; i < ARRAY_SIZE(gtm->timers); i++) {
+			if (!gtm->timers[i].requested) {
+				gtm->timers[i].requested = true;
+				spin_unlock_irq(&gtm->lock);
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
+/**
+ * gtm_get_specific_timer - request specific GTM timer
+ * @gtm:	specific GTM, pass here GTM's device_node->data
+ * @timer:	specific timer number, Timer1 is 0.
+ * @width:	timer width (only 16 bits wide timers implemented so far)
+ *
+ * This function reserves GTM timer for later use. It returns gtm_timer
+ * structure to use with the rest of GTM API, you should use timer->irq
+ * to manage timer interrupt.
+ */
+struct gtm_timer *gtm_get_specific_timer(struct gtm *gtm, int timer, int width)
+{
+	struct gtm_timer *ret = ERR_PTR(-EBUSY);
+
+	if (width != 16)
+		return ERR_PTR(-ENOSYS);
+
+	spin_lock_irq(&gtm->lock);
+
+	if (gtm->timers[timer].requested)
+		goto out;
+
+	ret = &gtm->timers[timer];
+	ret->requested = true;
+
+out:
+	spin_unlock_irq(&gtm->lock);
+	return ret;
+}
+EXPORT_SYMBOL(gtm_get_specific_timer);
+
+/**
+ * gtm_put_timer - release GTM timer
+ * @width:	timer width (only 16 bits wide timers implemented so far)
+ *
+ * This function releases GTM timer so others may request it.
+ */
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
+/*
+ * This is back-end for the exported functions, it's used to reset single
+ * timer in reference mode.
+ */
+static int gtm_reset_ref_timer16(struct gtm_timer *tmr, int frequency,
+				 int reference_value, bool free_run)
+{
+	struct gtm *gtm = tmr->gtm;
+	int num = tmr - &gtm->timers[0];
+	unsigned int prescaler;
+	u8 iclk = GTMDR_ICLK_ICLK;
+	u8 psr;
+	u8 sps;
+	unsigned long flags;
+	int max_prescaler = 256 * 256 * 16;
+
+	/* CPM2 doesn't have primary prescaler */
+	if (!tmr->gtpsr)
+		max_prescaler /= 256;
+
+	prescaler = gtm->clock / frequency;
+	/*
+	 * We have two 8 bit prescalers -- primary and secondary (psr, sps),
+	 * plus "slow go" mode (clk / 16). So, total prescale value is
+	 * 16 * (psr + 1) * (sps + 1). Though, for CPM2 GTMs we losing psr.
+	 */
+	if (prescaler > max_prescaler)
+		return -EINVAL;
+
+	if (prescaler > max_prescaler / 16) {
+		iclk = GTMDR_ICLK_SLGO;
+		prescaler /= 16;
+	}
+
+	if (prescaler <= 256) {
+		psr = 0;
+		sps = prescaler - 1;
+	} else {
+		psr = 256 - 1;
+		sps = prescaler / 256 - 1;
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
+	if (tmr->gtpsr)
+		out_be16(tmr->gtpsr, psr);
+	clrsetbits_be16(tmr->gtmdr, 0xFFFF, iclk | GTMDR_SPS(sps) |
+			GTMDR_ORI | (free_run ? GTMDR_FRR : 0));
+	out_be16(tmr->gtcnr, 0);
+	out_be16(tmr->gtrfr, reference_value);
+	out_be16(tmr->gtevr, 0xFFFF);
+
+	/* Let it be. */
+	clrbits8(tmr->gtcfr, GTCFR_STP(num));
+
+	spin_unlock_irqrestore(&gtm->lock, flags);
+
+	return 0;
+}
+/**
+ * gtm_reset_timer16 - reset 16 bit timer with arbitrary precision
+ * @tmr:	pointer to the gtm_timer structure obtained from gtm_get_timer
+ * @usec:	timer interval in microseconds
+ * @reload:	if set, the timer will reset upon expiry rather than
+ *         	continue running free.
+ *
+ * This function (re)sets the GTM timer so that it counts up to the requested
+ * interval value, and fires the interrupt when the value is reached. This
+ * function will reduce the precision of the timer as needed in order for the
+ * requested timeout to fit in a 16-bit register.
+ */
+int gtm_reset_timer16(struct gtm_timer *tmr, unsigned long usec, bool reload)
+{
+	/* quite obvious, frequency which is enough for µSec precision */
+	int freq = 1000000;
+	unsigned int bit;
+
+	bit = fls_long(usec);
+	if (bit > 15) {
+		freq >>= bit - 15;
+		usec >>= bit - 15;
+	}
+
+	if (!freq)
+		return -EINVAL;
+
+	return gtm_reset_ref_timer16(tmr, freq, usec, reload);
+}
+EXPORT_SYMBOL(gtm_reset_timer16);
+
+/**
+ * gtm_reset_utimer16 - reset 16 bits timer
+ * @tmr:	pointer to the gtm_timer structure obtained from gtm_get_timer
+ * @usec:	timer interval in microseconds
+ * @reload:	if set, the timer will reset upon expiry rather than
+ *         	continue running free.
+ *
+ * This function (re)sets GTM timer so that it counts up to the requested
+ * interval value, and fires the interrupt when the value is reached. If reload
+ * flag was set, timer will also reset itself upon reference value, otherwise
+ * it continues to increment.
+ */
+int gtm_reset_utimer16(struct gtm_timer *tmr, u16 usec, bool reload)
+{
+	/* quite obvious, frequency which is enough for µSec precision */
+	const int freq = 1000000;
+
+	/*
+	 * We can lower the frequency (and probably power consumption) by
+	 * dividing both frequency and usec by 2 until there is no remainder.
+	 * But we won't bother with this unless savings are measured, so just
+	 * run the timer as is.
+	 */
+
+	return gtm_reset_ref_timer16(tmr, freq, usec, reload);
+}
+EXPORT_SYMBOL(gtm_reset_utimer16);
+
+/**
+ * gtm_stop_timer16 - stop single timer
+ * @tmr:	pointer to the gtm_timer structure obtained from gtm_get_timer
+ *
+ * This function simply stops the GTM timer.
+ */
+void gtm_stop_timer16(struct gtm_timer *tmr)
+{
+	struct gtm *gtm = tmr->gtm;
+	int num = tmr - &gtm->timers[0];
+	unsigned long flags;
+
+	spin_lock_irqsave(&gtm->lock, flags);
+
+	setbits8(tmr->gtcfr, GTCFR_STP(num));
+	out_be16(tmr->gtevr, 0xFFFF);
+
+	spin_unlock_irqrestore(&gtm->lock, flags);
+}
+EXPORT_SYMBOL(gtm_stop_timer16);
+
+/**
+ * gtm_ack_timer16 - acknowledge timer event (free-run timers only)
+ * @tmr:	pointer to the gtm_timer structure obtained from gtm_get_timer
+ * @events:	events mask to ack
+ *
+ * Thus function used to acknowledge timer interrupt event, use it inside the
+ * interrupt handler.
+ */
+void gtm_ack_timer16(struct gtm_timer *tmr, u16 events)
+{
+	out_be16(tmr->gtevr, events);
+}
+EXPORT_SYMBOL(gtm_ack_timer16);
+
+static void __init gtm_set_shortcuts(struct device_node *np,
+				     struct gtm_timer *timers,
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
+	timers[0].gtcnr = &regs->gtcnr1;
+	timers[0].gtrfr = &regs->gtrfr1;
+	timers[0].gtevr = &regs->gtevr1;
+
+	timers[1].gtcfr = &regs->gtcfr1;
+	timers[1].gtmdr = &regs->gtmdr2;
+	timers[1].gtcnr = &regs->gtcnr2;
+	timers[1].gtrfr = &regs->gtrfr2;
+	timers[1].gtevr = &regs->gtevr2;
+
+	timers[2].gtcfr = &regs->gtcfr2;
+	timers[2].gtmdr = &regs->gtmdr3;
+	timers[2].gtcnr = &regs->gtcnr3;
+	timers[2].gtrfr = &regs->gtrfr3;
+	timers[2].gtevr = &regs->gtevr3;
+
+	timers[3].gtcfr = &regs->gtcfr2;
+	timers[3].gtmdr = &regs->gtmdr4;
+	timers[3].gtcnr = &regs->gtcnr4;
+	timers[3].gtrfr = &regs->gtrfr4;
+	timers[3].gtevr = &regs->gtevr4;
+
+	/* CPM2 doesn't have primary prescaler */
+	if (!of_device_is_compatible(np, "fsl,cpm2-gtm")) {
+		timers[0].gtpsr = &regs->gtpsr1;
+		timers[1].gtpsr = &regs->gtpsr2;
+		timers[2].gtpsr = &regs->gtpsr3;
+		timers[3].gtpsr = &regs->gtpsr4;
+	}
+}
+
+void __init fsl_gtm_init(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "fsl,gtm") {
+		int i;
+		struct gtm *gtm;
+		const u32 *clock;
+		int size;
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
+		clock = of_get_property(np, "clock-frequency", &size);
+		if (!clock || size != sizeof(*clock)) {
+			pr_err("%s: no clock-frequency\n", np->full_name);
+			goto err;
+		}
+		gtm->clock = *clock;
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
+		gtm_set_shortcuts(np, gtm->timers, gtm->regs);
+		list_add(&gtm->list_node, &gtms);
+
+		/* We don't want to lose the node and its ->data */
+		np->data = gtm;
+		of_node_get(np);
+
+		continue;
+err:
+		kfree(gtm);
+	}
+}
diff --git a/include/asm-powerpc/fsl_gtm.h b/include/asm-powerpc/fsl_gtm.h
new file mode 100644
index 0000000..f17c8e3
--- /dev/null
+++ b/include/asm-powerpc/fsl_gtm.h
@@ -0,0 +1,34 @@
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
+
+struct gtm;
+
+extern void __init fsl_gtm_init(void);
+extern struct gtm_timer *gtm_get_timer(int width);
+extern struct gtm_timer *gtm_get_specific_timer(struct gtm *gtm, int timer,
+						int width);
+extern void gtm_put_timer(struct gtm_timer *tmr);
+extern int gtm_reset_timer16(struct gtm_timer *tmr, unsigned long usec,
+			     bool reload);
+extern int gtm_reset_utimer16(struct gtm_timer *tmr, u16 usec, bool reload);
+extern void gtm_stop_timer16(struct gtm_timer *tmr);
+extern void gtm_ack_timer16(struct gtm_timer *tmr, u16 events);
+
+#endif /* __ASM_FSL_GTM_H */
-- 
1.5.5.1
