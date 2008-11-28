Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.233])
	by ozlabs.org (Postfix) with ESMTP id AD069DDDCA
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Nov 2008 07:50:47 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1492749rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 12:50:45 -0800 (PST)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc/mpc5200: Document and tidy irq driver
To: linuxppc-dev@ozlabs.org, steven@embeddedconsulting.ca,
	sylvain.lamontagne@novariant.com
Date: Fri, 28 Nov 2008 13:49:56 -0700
Message-ID: <20081128204956.7934.46021.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This patch adds documentation to the mpc5200 interrupt controller
driver and cleans up some minor coding conventions.  It also moves the
contents of mpc52xx_pic.h into the driver proper (except for a small
common bit that is moved to the common mpc52xx.h) because the
information encoded there is not required by any other part of kernel
code.  Finally for code readability sake, the L2_OFFSET shift value
is removed because the code using it resolves to a noop.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/include/asm/mpc52xx.h        |   19 ++
 arch/powerpc/platforms/52xx/lite5200_pm.c |    1 
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |  235 +++++++++++++++++++++--------
 arch/powerpc/platforms/52xx/mpc52xx_pic.h |   53 -------
 arch/powerpc/platforms/52xx/mpc52xx_pm.c  |    3 
 5 files changed, 189 insertions(+), 122 deletions(-)
 delete mode 100644 arch/powerpc/platforms/52xx/mpc52xx_pic.h


diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/mpc52xx.h
index 81ef10b..81a2393 100644
--- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -239,6 +239,25 @@ struct mpc52xx_cdm {
 	u16 mclken_div_psc6;	/* CDM + 0x36  reg13 byte2,3 */
 };
 
+/* Interrupt controller Register set */
+struct mpc52xx_intr {
+	u32 per_mask;		/* INTR + 0x00 */
+	u32 per_pri1;		/* INTR + 0x04 */
+	u32 per_pri2;		/* INTR + 0x08 */
+	u32 per_pri3;		/* INTR + 0x0c */
+	u32 ctrl;		/* INTR + 0x10 */
+	u32 main_mask;		/* INTR + 0x14 */
+	u32 main_pri1;		/* INTR + 0x18 */
+	u32 main_pri2;		/* INTR + 0x1c */
+	u32 reserved1;		/* INTR + 0x20 */
+	u32 enc_status;		/* INTR + 0x24 */
+	u32 crit_status;	/* INTR + 0x28 */
+	u32 main_status;	/* INTR + 0x2c */
+	u32 per_status;		/* INTR + 0x30 */
+	u32 reserved2;		/* INTR + 0x34 */
+	u32 per_error;		/* INTR + 0x38 */
+};
+
 #endif /* __ASSEMBLY__ */
 
 
diff --git a/arch/powerpc/platforms/52xx/lite5200_pm.c b/arch/powerpc/platforms/52xx/lite5200_pm.c
index fe92e65..b5c753d 100644
--- a/arch/powerpc/platforms/52xx/lite5200_pm.c
+++ b/arch/powerpc/platforms/52xx/lite5200_pm.c
@@ -3,7 +3,6 @@
 #include <asm/io.h>
 #include <asm/time.h>
 #include <asm/mpc52xx.h>
-#include "mpc52xx_pic.h"
 
 /* defined in lite5200_sleep.S and only used here */
 extern void lite5200_low_power(void __iomem *sram, void __iomem *mbar);
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 8479394..c2fa60e 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -2,20 +2,100 @@
  *
  * Programmable Interrupt Controller functions for the Freescale MPC52xx.
  *
+ * Copyright (C) 2008 Secret Lab Technologies Ltd.
  * Copyright (C) 2006 bplan GmbH
+ * Copyright (C) 2004 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2003 Montavista Software, Inc
  *
  * Based on the code from the 2.4 kernel by
  * Dale Farnsworth <dfarnsworth@mvista.com> and Kent Borg.
  *
- * Copyright (C) 2004 Sylvain Munaut <tnt@246tNt.com>
- * Copyright (C) 2003 Montavista Software, Inc
- *
  * This file is licensed under the terms of the GNU General Public License
  * version 2. This program is licensed "as is" without any warranty of any
  * kind, whether express or implied.
  *
  */
 
+/*
+ * This is the device driver for the MPC5200 interrupt controller.
+ *
+ * hardware overview
+ * -----------------
+ * The MPC5200 interrupt controller groups the all interrupt sources into
+ * three groups called 'critical', 'main', and 'peripheral'.  The critical
+ * group has 3 irqs, External IRQ0, slice timer 0 irq, and wake from deep
+ * sleep.  Main group include the other 3 external IRQs, slice timer 1, RTC,
+ * gpios, and the general purpose timers.  Peripheral group contains the
+ * remaining irq sources from all of the on-chip peripherals (PSCs, Ethernet,
+ * USB, DMA, etc).
+ *
+ * virqs
+ * -----
+ * The Linux IRQ subsystem requires that each irq source be assigned a
+ * system wide unique IRQ number starting at 1 (0 means no irq).  Since
+ * systems can have multiple interrupt controllers, the virtual IRQ (virq)
+ * infrastructure lets each interrupt controller to define a local set
+ * of IRQ numbers and the virq infrastructure maps those numbers into
+ * a unique range of the global IRQ# space.
+ *
+ * To define a range of virq numbers for this controller, this driver first
+ * assigns a number to each of the irq groups (called the level 1 or L1
+ * value).  Within each group individual irq sources are also assigned a
+ * number, as defined by the MPC5200 user guide, and refers to it as the
+ * level 2 or L2 value.  The virq number is determined by shifting up the
+ * L1 value by MPC52xx_IRQ_L1_OFFSET and ORing it with the L2 value.
+ *
+ * For example, the TMR0 interrupt is irq 9 in the main group.  The
+ * virq for TMR0 is calculated by ((1 << MPC52xx_IRQ_L1_OFFSET) | 9).
+ *
+ * The observant reader will also notice that this driver defines a 4th
+ * interrupt group called 'bestcomm'.  The bestcomm group isn't physically
+ * part of the MPC5200 interrupt controller, but it is used here to assign
+ * a separate virq number for each bestcomm task (since any of the 16
+ * bestcomm tasks can cause the bestcomm interrupt to be raised).  When a
+ * bestcomm interrupt occurs (peripheral group, irq 0) this driver determines
+ * which task needs servicing and returns the irq number for that task.  This
+ * allows drivers which use bestcomm to define their own interrupt handlers.
+ *
+ * irq_chip structures
+ * -------------------
+ * For actually manipulating IRQs (masking, enabling, clearing, etc) this
+ * driver defines four separate 'irq_chip' structures, one for the main
+ * group, one for the peripherals group, one for the bestcomm group and one
+ * for external interrupts.  The irq_chip structures provide the hooks needed
+ * to manipulate each IRQ source, and since each group is has a separate set
+ * of registers for controlling the irq, it makes sense to divide up the
+ * hooks along those lines.
+ *
+ * You'll notice that there is not an irq_chip for the critical group and
+ * you'll also notice that there is an irq_chip defined for external
+ * interrupts even though there is no external interrupt group.  The reason
+ * for this is that the four external interrupts are all managed with the same
+ * register even though one of the external IRQs is in the critical group and
+ * the other three are in the main group.  For this reason it makes sense for
+ * the 4 external irqs to be managed using a separate set of hooks.  The
+ * reason there is no crit irq_chip is that of the 3 irqs in the critical
+ * group, only external interrupt is actually support at this time by this
+ * driver and since external interrupt is the only one used, it can just
+ * be directed to make use of the external irq irq_chip.
+ *
+ * device tree bindings
+ * --------------------
+ * The device tree bindings for this controller reflect the two level
+ * organization of irqs in the device.  #interrupt-cells = <3> where the
+ * first cell is the group number [0..3], the second cell is the irq
+ * number in the group, and the third cell is the sense type (level/edge).
+ * For reference, the following is a list of the interrupt property values
+ * associated with external interrupt sources on the MPC5200 (just because
+ * it is non-obvious to determine what the interrupts property should be
+ * when reading the mpc5200 manual and it is a frequently asked question).
+ *
+ * External interrupts:
+ * <0 0 n>	external irq0, n is sense	(n=0: level high,
+ * <1 1 n>	external irq1, n is sense	 n=1: edge rising,
+ * <1 2 n>	external irq2, n is sense	 n=2: edge falling,
+ * <1 3 n>	external irq3, n is sense	 n=3: level low)
+ */
 #undef DEBUG
 
 #include <linux/interrupt.h>
@@ -24,11 +104,19 @@
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/mpc52xx.h>
-#include "mpc52xx_pic.h"
 
-/*
- *
-*/
+/* HW IRQ mapping */
+#define MPC52xx_IRQ_L1_CRIT	(0)
+#define MPC52xx_IRQ_L1_MAIN	(1)
+#define MPC52xx_IRQ_L1_PERP	(2)
+#define MPC52xx_IRQ_L1_SDMA	(3)
+
+#define MPC52xx_IRQ_L1_OFFSET	(6)
+#define MPC52xx_IRQ_L1_MASK	(0x00c0)
+#define MPC52xx_IRQ_L2_MASK	(0x003f)
+
+#define MPC52xx_IRQ_HIGHTESTHWIRQ (0xd0)
+
 
 /* MPC5200 device tree match tables */
 static struct of_device_id mpc52xx_pic_ids[] __initdata = {
@@ -53,10 +141,7 @@ static unsigned char mpc52xx_map_senses[4] = {
 	IRQ_TYPE_LEVEL_LOW,
 };
 
-/*
- *
-*/
-
+/* Utility functions */
 static inline void io_be_setbit(u32 __iomem *addr, int bitno)
 {
 	out_be32(addr, in_be32(addr) | (1 << bitno));
@@ -69,15 +154,14 @@ static inline void io_be_clrbit(u32 __iomem *addr, int bitno)
 
 /*
  * IRQ[0-3] interrupt irq_chip
-*/
-
+ */
 static void mpc52xx_extirq_mask(unsigned int virq)
 {
 	int irq;
 	int l2irq;
 
 	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
 
@@ -90,7 +174,7 @@ static void mpc52xx_extirq_unmask(unsigned int virq)
 	int l2irq;
 
 	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
 
@@ -103,7 +187,7 @@ static void mpc52xx_extirq_ack(unsigned int virq)
 	int l2irq;
 
 	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
 
@@ -117,7 +201,7 @@ static int mpc52xx_extirq_set_type(unsigned int virq, unsigned int flow_type)
 	int l2irq;
 
 	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	pr_debug("%s: irq=%x. l2=%d flow_type=%d\n", __func__, irq, l2irq, flow_type);
 
@@ -156,15 +240,14 @@ static struct irq_chip mpc52xx_extirq_irqchip = {
 
 /*
  * Main interrupt irq_chip
-*/
-
+ */
 static void mpc52xx_main_mask(unsigned int virq)
 {
 	int irq;
 	int l2irq;
 
 	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
 
@@ -177,7 +260,7 @@ static void mpc52xx_main_unmask(unsigned int virq)
 	int l2irq;
 
 	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
 
@@ -193,15 +276,14 @@ static struct irq_chip mpc52xx_main_irqchip = {
 
 /*
  * Peripherals interrupt irq_chip
-*/
-
+ */
 static void mpc52xx_periph_mask(unsigned int virq)
 {
 	int irq;
 	int l2irq;
 
 	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
 
@@ -214,7 +296,7 @@ static void mpc52xx_periph_unmask(unsigned int virq)
 	int l2irq;
 
 	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
 
@@ -230,15 +312,14 @@ static struct irq_chip mpc52xx_periph_irqchip = {
 
 /*
  * SDMA interrupt irq_chip
-*/
-
+ */
 static void mpc52xx_sdma_mask(unsigned int virq)
 {
 	int irq;
 	int l2irq;
 
 	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
 
@@ -251,7 +332,7 @@ static void mpc52xx_sdma_unmask(unsigned int virq)
 	int l2irq;
 
 	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
 
@@ -264,7 +345,7 @@ static void mpc52xx_sdma_ack(unsigned int virq)
 	int l2irq;
 
 	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
 
@@ -278,13 +359,12 @@ static struct irq_chip mpc52xx_sdma_irqchip = {
 	.ack = mpc52xx_sdma_ack,
 };
 
-/*
- * irq_host
-*/
-
+/**
+ * mpc52xx_irqhost_xlate - translate virq# from device tree interrupts property
+ */
 static int mpc52xx_irqhost_xlate(struct irq_host *h, struct device_node *ct,
-				 u32 * intspec, unsigned int intsize,
-				 irq_hw_number_t * out_hwirq,
+				 u32 *intspec, unsigned int intsize,
+				 irq_hw_number_t *out_hwirq,
 				 unsigned int *out_flags)
 {
 	int intrvect_l1;
@@ -299,10 +379,9 @@ static int mpc52xx_irqhost_xlate(struct irq_host *h, struct device_node *ct,
 	intrvect_l2 = (int)intspec[1];
 	intrvect_type = (int)intspec[2];
 
-	intrvect_linux =
-	    (intrvect_l1 << MPC52xx_IRQ_L1_OFFSET) & MPC52xx_IRQ_L1_MASK;
-	intrvect_linux |=
-	    (intrvect_l2 << MPC52xx_IRQ_L2_OFFSET) & MPC52xx_IRQ_L2_MASK;
+	intrvect_linux = (intrvect_l1 << MPC52xx_IRQ_L1_OFFSET) &
+			 MPC52xx_IRQ_L1_MASK;
+	intrvect_linux |= intrvect_l2 & MPC52xx_IRQ_L2_MASK;
 
 	pr_debug("return %x, l1=%d, l2=%d\n", intrvect_linux, intrvect_l1,
 		 intrvect_l2);
@@ -313,11 +392,11 @@ static int mpc52xx_irqhost_xlate(struct irq_host *h, struct device_node *ct,
 	return 0;
 }
 
-/*
- * this function retrieves the correct IRQ type out
- * of the MPC regs
- * Only externals IRQs needs this
-*/
+/**
+ * mpc52xx_irqx_gettype - determine the IRQ sense type (level/edge)
+ *
+ * Only external IRQs need this.
+ */
 static int mpc52xx_irqx_gettype(int irq)
 {
 	int type;
@@ -329,6 +408,9 @@ static int mpc52xx_irqx_gettype(int irq)
 	return mpc52xx_map_senses[type];
 }
 
+/**
+ * mpc52xx_irqhost_map - Hook to map from virq to an irq_chip structure
+ */
 static int mpc52xx_irqhost_map(struct irq_host *h, unsigned int virq,
 			       irq_hw_number_t irq)
 {
@@ -339,7 +421,7 @@ static int mpc52xx_irqhost_map(struct irq_host *h, unsigned int virq,
 	int type;
 
 	l1irq = (irq & MPC52xx_IRQ_L1_MASK) >> MPC52xx_IRQ_L1_OFFSET;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	/*
 	 * Most of ours IRQs will be level low
@@ -379,8 +461,7 @@ static int mpc52xx_irqhost_map(struct irq_host *h, unsigned int virq,
 		break;
 
 	default:
-		pr_debug("%s: Error, unknown L1 IRQ (0x%x)\n", __func__, l1irq);
-		printk(KERN_ERR "Unknow IRQ!\n");
+		pr_err("%s: invalid virq requested (0x%x)\n", __func__, virq);
 		return -EINVAL;
 	}
 
@@ -406,10 +487,15 @@ static struct irq_host_ops mpc52xx_irqhost_ops = {
 	.map = mpc52xx_irqhost_map,
 };
 
-/*
- * init (public)
-*/
-
+/**
+ * mpc52xx_init_irq - Initialize and register with the virq subsystem
+ *
+ * Hook for setting up IRQs on an mpc5200 system.  A pointer to this function
+ * is to be put into the machine definition structure.
+ *
+ * This function searches the device tree for an MPC5200 interrupt controller,
+ * initializes it, and registers it with the virq subsystem.
+ */
 void __init mpc52xx_init_irq(void)
 {
 	u32 intr_ctrl;
@@ -454,7 +540,6 @@ void __init mpc52xx_init_irq(void)
 	 * As last step, add an irq host to translate the real
 	 * hw irq information provided by the ofw to linux virq
 	 */
-
 	mpc52xx_irqhost = irq_alloc_host(picnode, IRQ_HOST_MAP_LINEAR,
 	                                 MPC52xx_IRQ_HIGHTESTHWIRQ,
 	                                 &mpc52xx_irqhost_ops, -1);
@@ -462,12 +547,36 @@ void __init mpc52xx_init_irq(void)
 	if (!mpc52xx_irqhost)
 		panic(__FILE__ ": Cannot allocate the IRQ host\n");
 
-	printk(KERN_INFO "MPC52xx PIC is up and running!\n");
+	pr_info("MPC52xx PIC is up and running!\n");
 }
 
-/*
- * get_irq (public)
-*/
+/**
+ * mpc52xx_get_irq - Get pending interrupt number hook function
+ *
+ * Called by the interupt handler to determine what IRQ handler needs to be
+ * executed.
+ *
+ * Status of pending interrupts is determined by reading the encoded status
+ * register.  The encoded status register has three fields; one for each of the
+ * types of interrupts defined by the controller - 'critical', 'main' and
+ * 'peripheral'.  This function reads the status register and returns the IRQ
+ * number associated with the highest priority pending interrupt.  'Critical'
+ * interrupts have the highest priority, followed by 'main' interrupts, and
+ * then 'peripheral'.
+ *
+ * The mpc5200 interrupt controller can be configured to boost the priority
+ * of individual 'peripheral' interrupts.  If this is the case then a special
+ * value will appear in either the crit or main fields indicating a high
+ * or medium priority peripheral irq has occurred.
+ *
+ * This function checks each of the 3 irq request fields and returns the
+ * first pending interrupt that it finds.
+ *
+ * This function also identifies a 4th type of interrupt; 'bestcomm'.  Each
+ * bestcomm DMA task can raise the bestcomm peripheral interrupt.  When this
+ * occurs at task-specific IRQ# is decoded so that each task can have its
+ * own IRQ handler.
+ */
 unsigned int mpc52xx_get_irq(void)
 {
 	u32 status;
@@ -478,25 +587,21 @@ unsigned int mpc52xx_get_irq(void)
 		irq = (status >> 8) & 0x3;
 		if (irq == 2)	/* high priority peripheral */
 			goto peripheral;
-		irq |=	(MPC52xx_IRQ_L1_CRIT << MPC52xx_IRQ_L1_OFFSET) &
-			MPC52xx_IRQ_L1_MASK;
+		irq |= (MPC52xx_IRQ_L1_CRIT << MPC52xx_IRQ_L1_OFFSET);
 	} else if (status & 0x00200000) {	/* main */
 		irq = (status >> 16) & 0x1f;
 		if (irq == 4)	/* low priority peripheral */
 			goto peripheral;
-		irq |=	(MPC52xx_IRQ_L1_MAIN << MPC52xx_IRQ_L1_OFFSET) &
-			MPC52xx_IRQ_L1_MASK;
+		irq |= (MPC52xx_IRQ_L1_MAIN << MPC52xx_IRQ_L1_OFFSET);
 	} else if (status & 0x20000000) {	/* peripheral */
 	      peripheral:
 		irq = (status >> 24) & 0x1f;
 		if (irq == 0) {	/* bestcomm */
 			status = in_be32(&sdma->IntPend);
 			irq = ffs(status) - 1;
-			irq |=	(MPC52xx_IRQ_L1_SDMA << MPC52xx_IRQ_L1_OFFSET) &
-				MPC52xx_IRQ_L1_MASK;
+			irq |= (MPC52xx_IRQ_L1_SDMA << MPC52xx_IRQ_L1_OFFSET);
 		} else {
-			irq |=	(MPC52xx_IRQ_L1_PERP << MPC52xx_IRQ_L1_OFFSET) &
-				MPC52xx_IRQ_L1_MASK;
+			irq |= (MPC52xx_IRQ_L1_PERP << MPC52xx_IRQ_L1_OFFSET);
 		}
 	}
 
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.h b/arch/powerpc/platforms/52xx/mpc52xx_pic.h
deleted file mode 100644
index 1a26bcd..0000000
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * Header file for Freescale MPC52xx Interrupt controller
- *
- * Copyright (C) 2004-2005 Sylvain Munaut <tnt@246tNt.com>
- * Copyright (C) 2003 MontaVista, Software, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-#ifndef __POWERPC_SYSDEV_MPC52xx_PIC_H__
-#define __POWERPC_SYSDEV_MPC52xx_PIC_H__
-
-#include <asm/types.h>
-
-
-/* HW IRQ mapping */
-#define MPC52xx_IRQ_L1_CRIT	(0)
-#define MPC52xx_IRQ_L1_MAIN	(1)
-#define MPC52xx_IRQ_L1_PERP	(2)
-#define MPC52xx_IRQ_L1_SDMA	(3)
-
-#define MPC52xx_IRQ_L1_OFFSET   (6)
-#define MPC52xx_IRQ_L1_MASK     (0x00c0)
-
-#define MPC52xx_IRQ_L2_OFFSET   (0)
-#define MPC52xx_IRQ_L2_MASK     (0x003f)
-
-#define MPC52xx_IRQ_HIGHTESTHWIRQ (0xd0)
-
-
-/* Interrupt controller Register set */
-struct mpc52xx_intr {
-	u32 per_mask;		/* INTR + 0x00 */
-	u32 per_pri1;		/* INTR + 0x04 */
-	u32 per_pri2;		/* INTR + 0x08 */
-	u32 per_pri3;		/* INTR + 0x0c */
-	u32 ctrl;		/* INTR + 0x10 */
-	u32 main_mask;		/* INTR + 0x14 */
-	u32 main_pri1;		/* INTR + 0x18 */
-	u32 main_pri2;		/* INTR + 0x1c */
-	u32 reserved1;		/* INTR + 0x20 */
-	u32 enc_status;		/* INTR + 0x24 */
-	u32 crit_status;	/* INTR + 0x28 */
-	u32 main_status;	/* INTR + 0x2c */
-	u32 per_status;		/* INTR + 0x30 */
-	u32 reserved2;		/* INTR + 0x34 */
-	u32 per_error;		/* INTR + 0x38 */
-};
-
-#endif /* __POWERPC_SYSDEV_MPC52xx_PIC_H__ */
-
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pm.c b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
index c72d330..a55b0b6 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pm.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
@@ -5,9 +5,6 @@
 #include <asm/cacheflush.h>
 #include <asm/mpc52xx.h>
 
-#include "mpc52xx_pic.h"
-
-
 /* these are defined in mpc52xx_sleep.S, and only used here */
 extern void mpc52xx_deep_sleep(void __iomem *sram, void __iomem *sdram_regs,
 		struct mpc52xx_cdm __iomem *, struct mpc52xx_intr __iomem*);
