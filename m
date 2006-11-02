Return-Path: <nd@bplan-gmbh.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id AFE9A67BFE
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 07:47:49 +1100 (EST)
Date: Thu, 2 Nov 2006 21:47:45 +0100 (MET)
Message-ID: <454A5952.6090801@bplan-gmbh.de>
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Nicolas DET <nd@bplan-gmbh.de>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
References: <454902F9.20206@bplan-gmbh.de>	<1162419138.25682.453.camel@localhost.localdomain>
	<454A1C37.5050208@bplan-gmbh.de>
In-Reply-To: <454A1C37.5050208@bplan-gmbh.de>
Content-Type: multipart/mixed; boundary="------------030209090101060204050209"
Cc: Sylvain Munaut <tnt@246tNt.com>, sl@bplan-gmbh.de,
	linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030209090101060204050209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nicolas DET wrote:
> Benjamin Herrenschmidt wrote:
> 
>> Now, in addition to that, we have another issue I haven't spotted
>> before, but it might be worth considering:
>>
>> Do we actually want the sdma interrupts handled there ? Because if you
>> look closely, the SDMA is basically a cascaded interrupt controller. It
>> hangs of per interrupt 0 :)
> 
> I know. I already spot this point (IRQ as far as I remenber and in 
> private mails) and I got no answer so I assumed it was ok like I did. 
> It's also really simplier and easier to add SDMA has another irq_chip.
> Keep is simple ;-)
> 
>> Thus we could simply remove the code for it from that driver and
>> implement it as as separate controller with a separate interrupt domain.
>> I know you won't like that idea because it means having a different
>> interrupt tree but it's worth having the discussion.
>>
> 
> The device tree won't change anyway...
> 
> I'll submit a new buch of patches pretty soon. Maybe the final version.
> 
> "On y est presque !" ;-)
> 

I attached the new Interrupt Controller patch. I have been very busy 
today. I hope I did not overlook anything.

RFC


--------------030209090101060204050209
Content-Type: text/plain;
 name="archpowerpc_mpc52x.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="archpowerpc_mpc52x.patch"

--- a/arch/powerpc/sysdev/mpc52xx_pic.c	1970-01-01 01:00:00.000000000 +0100
+++ b/arch/powerpc/sysdev/mpc52xx_pic.c	2006-11-02 17:56:10.000000000 +0100
@@ -0,0 +1,515 @@
+/*
+ *
+ * Programmable Interrupt Controller functions for the Freescale MPC52xx.
+ *
+ * Based on (well, mostly copied from) the code from the 2.4 kernel by
+ * Dale Farnsworth <dfarnsworth@mvista.com> and Kent Borg.
+ * 
+ * Copyright (C) 2004 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2003 Montavista Software, Inc
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ */
+
+#undef DEBUG
+
+#include <linux/stddef.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/stddef.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/hardirq.h>
+
+#include <asm/io.h>
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+#include <asm/mpc52xx.h>
+
+/*
+ *
+*/
+
+static struct mpc52xx_intr __iomem *intr;
+static struct mpc52xx_sdma __iomem *sdma;
+static struct irq_host *mpc52xx_irqhost = NULL;
+
+static unsigned char mpc52xx_map_senses[4] = {
+	IRQ_TYPE_LEVEL_HIGH,
+	IRQ_TYPE_EDGE_FALLING,
+	IRQ_TYPE_EDGE_RISING,
+	IRQ_TYPE_LEVEL_LOW,
+};
+
+/*
+ *
+*/
+
+static inline void io_be_setbit(u32 __iomem *addr, int bitno)
+{
+	out_be32(addr, in_be32(addr) | (1 << bitno) );
+}
+
+static inline void io_be_clrbit(u32 __iomem *addr, int bitno)
+{
+	out_be32(addr, in_be32(addr) & ~(1 << bitno));
+}
+
+static inline struct device_node *find_mpc52xx_picnode(void)
+{
+	return of_find_compatible_node(NULL, "interrupt-controller",
+				       "mpc5200-pic");
+}
+
+static inline struct device_node *find_mpc52xx_sdmanode(void)
+{
+	return of_find_compatible_node(NULL, "dma-controller",
+				       "mpc5200-bestcomm");
+}
+
+/*
+ * IRQ[0-3] interrupt irq_chip
+*/
+
+static void mpc52xx_extirq_mask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_clrbit(&intr->ctrl, 11 - l2irq);
+}
+
+static void mpc52xx_extirq_unmask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_setbit(&intr->ctrl, 11 - l2irq);
+}
+
+static void mpc52xx_extirq_ack(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_setbit(&intr->ctrl, 27-l2irq);
+}
+
+static struct irq_chip mpc52xx_extirq_irqchip = {
+	.typename = " MPC52xx IRQ[0-3] ",
+	.mask = mpc52xx_extirq_mask,
+	.unmask = mpc52xx_extirq_unmask,
+	.ack = mpc52xx_extirq_ack,
+};
+
+/*
+ * Main interrupt irq_chip
+*/
+
+static void mpc52xx_main_mask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_setbit(&intr->main_mask, 15 - l2irq);
+}
+
+static void mpc52xx_main_unmask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_clrbit(&intr->main_mask, 15 - l2irq);
+}
+
+static struct irq_chip mpc52xx_main_irqchip = {
+	.typename = "MPC52xx Main",
+	.mask = mpc52xx_main_mask,
+	.mask_ack = mpc52xx_main_mask,
+	.unmask = mpc52xx_main_unmask,
+};
+
+/*
+ * Peripherals interrupt irq_chip
+*/
+
+static void mpc52xx_periph_mask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_setbit(&intr->per_mask, 31 - l2irq);
+}
+
+static void mpc52xx_periph_unmask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_clrbit(&intr->per_mask, 31 - l2irq);
+}
+
+static struct irq_chip mpc52xx_periph_irqchip = {
+	.typename = "MPC52xx Peripherals",
+	.mask = mpc52xx_periph_mask,
+	.mask_ack = mpc52xx_periph_mask,
+	.unmask = mpc52xx_periph_unmask,
+};
+
+/*
+ * SDMA interrupt irq_chip
+*/
+
+static void mpc52xx_sdma_mask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_setbit(&sdma->IntMask, l2irq);
+}
+
+static void mpc52xx_sdma_unmask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_clrbit(&sdma->IntMask, l2irq);
+}
+
+static void mpc52xx_sdma_ack(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	out_be32(&sdma->IntPend, 1 << l2irq);
+}
+
+static struct irq_chip mpc52xx_sdma_irqchip = {
+	.typename = "MPC52xx SDMA",
+	.mask = mpc52xx_sdma_mask,
+	.unmask = mpc52xx_sdma_unmask,
+	.ack = mpc52xx_sdma_ack,
+};
+
+/*
+ * irq_host
+*/
+
+static int mpc52xx_irqhost_match(struct irq_host *h, struct device_node *node)
+{
+	pr_debug("%s: %p vs %p\n", __func__, find_mpc52xx_picnode(), node);
+	return mpc52xx_irqhost->host_data == node;
+}
+
+static int mpc52xx_irqhost_xlate(struct irq_host *h, struct device_node *ct,
+				 u32 * intspec, unsigned int intsize,
+				 irq_hw_number_t * out_hwirq,
+				 unsigned int *out_flags)
+{
+	int intrvect_l1;
+	int intrvect_l2;
+	int intrvect_type;
+	int intrvect_linux;
+
+	if (intsize != 3)
+		return -1;
+
+	intrvect_l1 = (int)intspec[0];
+	intrvect_l2 = (int)intspec[1];
+	intrvect_type = (int)intspec[2];
+
+	intrvect_linux =
+	    (intrvect_l1 << MPC52xx_IRQ_L1_OFFSET) & MPC52xx_IRQ_L1_MASK;
+	intrvect_linux |=
+	    (intrvect_l2 << MPC52xx_IRQ_L2_OFFSET) & MPC52xx_IRQ_L2_MASK;
+
+	pr_debug("return %x, l1=%d, l2=%d\n", intrvect_linux, intrvect_l1,
+		 intrvect_l2);
+
+	*out_hwirq = intrvect_linux;
+	*out_flags = mpc52xx_map_senses[intrvect_type];
+
+	return 0;
+}
+
+/*
+ * this function retrieves the correct IRQ type out
+ * of the MPC regs
+ * Only externals IRQs needs this
+*/
+static int mpc52xx_irqx_gettype(int irq)
+{
+	int type;
+	u32 ctrl_reg;
+
+	ctrl_reg = in_be32(&intr->ctrl);
+	type = (ctrl_reg >> (22 - irq * 2)) & 0x3;
+
+	return mpc52xx_map_senses[type];
+}
+
+static int mpc52xx_irqhost_map(struct irq_host *h, unsigned int virq,
+			       irq_hw_number_t irq)
+{
+	int l1irq;
+	int l2irq;
+	struct irq_chip *good_irqchip;
+	void *good_handle;
+	int type;
+
+	l1irq = (irq & MPC52xx_IRQ_L1_MASK) >> MPC52xx_IRQ_L1_OFFSET;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	/*
+	 * Most of ours IRQs will be level low
+	 * Only external IRQs on some platform may be others
+	 */
+	type = IRQ_TYPE_LEVEL_LOW;
+
+	switch (l1irq) {
+	case MPC52xx_IRQ_L1_CRIT:
+		pr_debug("%s: Critical. l2=%x\n", __func__, l2irq);
+
+		BUG_ON(l2irq != 0);
+
+		type = mpc52xx_irqx_gettype(l2irq);
+		good_irqchip = &mpc52xx_extirq_irqchip;
+		break;
+
+	case MPC52xx_IRQ_L1_MAIN:
+		pr_debug("%s: Main IRQ[1-3] l2=%x\n", __func__, l2irq);
+
+		if ((l2irq >= 1) && (l2irq <= 3)) {
+			type = mpc52xx_irqx_gettype(l2irq);
+			good_irqchip = &mpc52xx_extirq_irqchip;
+		} else {
+			good_irqchip = &mpc52xx_main_irqchip;
+		}
+		break;
+
+	case MPC52xx_IRQ_L1_PERP:
+		pr_debug("%s: Peripherals. l2=%x\n", __func__, l2irq);
+		good_irqchip = &mpc52xx_periph_irqchip;
+		break;
+
+	case MPC52xx_IRQ_L1_SDMA:
+		pr_debug("%s: SDMA. l2=%x\n", __func__, l2irq);
+		good_irqchip = &mpc52xx_sdma_irqchip;
+		break;
+
+	default:
+		pr_debug("%s: Error, unknown L1 IRQ (0x%x)\n", __func__, l1irq);
+		printk(KERN_ERR "Unknow IRQ!\n");
+		return -EINVAL;
+	}
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_FALLING:
+	case IRQ_TYPE_EDGE_RISING:
+		good_handle = handle_edge_irq;
+		break;
+	default:
+		good_handle = handle_level_irq;
+	}
+
+	set_irq_chip_and_handler(virq, good_irqchip, good_handle);
+
+	pr_debug("%s: virq=%x, hw=%x. type=%x\n", __func__, virq,
+		 (int)irq, type);
+
+	return 0;
+}
+
+static struct irq_host_ops mpc52xx_irqhost_ops = {
+	.match = mpc52xx_irqhost_match,
+	.xlate = mpc52xx_irqhost_xlate,
+	.map = mpc52xx_irqhost_map,
+};
+
+/*
+ * init (public)
+*/
+
+void __init mpc52xx_init_irq(void)
+{
+	struct device_node *picnode;
+	int picnode_regsize;
+	u32 picnode_regoffset;
+
+	struct device_node *sdmanode;
+	int sdmanode_regsize;
+	u32 sdmanode_regoffset;
+
+	u64 size64;
+	int flags;
+
+	u32 intr_ctrl;
+
+	picnode = find_mpc52xx_picnode();
+	sdmanode = find_mpc52xx_sdmanode();
+
+	if ( (picnode == NULL) || (sdmanode == NULL) )
+		return;
+
+	/* Retrieve PIC ressources */
+	picnode_regoffset = (u32) of_get_address(picnode, 0, &size64, &flags);
+	if (picnode_regoffset == 0)
+		return ;
+
+	picnode_regoffset = of_translate_address(picnode, (u32 *) picnode_regoffset);
+	picnode_regsize = (int)size64;	
+
+	/* Retrieve SDMA ressources */
+	sdmanode_regoffset = (u32) of_get_address(sdmanode, 0, &size64, &flags);
+	if (sdmanode_regoffset == 0)
+		return ;
+
+	sdmanode_regoffset = of_translate_address(sdmanode, (u32 *) sdmanode_regoffset);
+	sdmanode_regsize = (int)size64;
+
+	/* Remap the necessary zones */
+	intr = ioremap(picnode_regoffset, picnode_regsize);
+	sdma = ioremap(sdmanode_regoffset, sdmanode_regsize);
+
+	if ((intr == NULL) || (sdma == NULL))
+		panic("Can't ioremap PIC/SDMA register or init_irq !");
+
+	printk(KERN_INFO "Remapped MPC52xx PIC at 0x%8.8x\n", picnode_regoffset);
+	printk(KERN_INFO "Remapped MPC52xx SDMA at 0x%8.8x\n", sdmanode_regoffset);
+
+	of_node_put(picnode);
+	of_node_put(sdmanode);
+
+	/* Disable all interrupt sources. */
+	out_be32(&sdma->IntPend, 0xffffffff);	/* 1 means clear pending */
+	out_be32(&sdma->IntMask, 0xffffffff);	/* 1 means disabled */
+	out_be32(&intr->per_mask, 0x7ffffc00);	/* 1 means disabled */
+	out_be32(&intr->main_mask, 0x00010fff);	/* 1 means disabled */
+	intr_ctrl = in_be32(&intr->ctrl);
+	intr_ctrl &= 0x00ff0000;	/* Keeps IRQ[0-3] config */
+	intr_ctrl |= 0x0f000000 |	/* clear IRQ 0-3 */
+	    0x00001000 |	/* MEE master external enable */
+	    0x00000000 |	/* 0 means disable IRQ 0-3 */
+	    0x00000001;		/* CEb route critical normally */
+	out_be32(&intr->ctrl, intr_ctrl);
+
+	/* Zero a bunch of the priority settings.  */
+	out_be32(&intr->per_pri1, 0);
+	out_be32(&intr->per_pri2, 0);
+	out_be32(&intr->per_pri3, 0);
+	out_be32(&intr->main_pri1, 0);
+	out_be32(&intr->main_pri2, 0);
+
+	/*
+	 * As last step, add an irq host to translate the real
+	 * hw irq information provided by the ofw to linux virq
+	 */
+
+	mpc52xx_irqhost =
+	    irq_alloc_host(IRQ_HOST_MAP_LINEAR, MPC52xx_IRQ_HIGHTESTVIRQ,
+			   &mpc52xx_irqhost_ops, -1);
+
+	if (mpc52xx_irqhost)
+		mpc52xx_irqhost->host_data = picnode;
+}
+
+/*
+ * get_irq (public)
+*/
+unsigned int mpc52xx_get_irq(void)
+{
+	u32 status;
+	int irq = NO_IRQ_IGNORE;
+
+	status = in_be32(&intr->enc_status);
+	if (status & 0x00000400) {	/* critical */
+		irq = (status >> 8) & 0x3;
+		if (irq == 2)	/* high priority peripheral */
+			goto peripheral;
+		irq |=
+		    (MPC52xx_IRQ_L1_CRIT << MPC52xx_IRQ_L1_OFFSET) &
+		    MPC52xx_IRQ_L1_MASK;
+	} else if (status & 0x00200000) {	/* main */
+		irq = (status >> 16) & 0x1f;
+		if (irq == 4)	/* low priority peripheral */
+			goto peripheral;
+		irq |=
+		    (MPC52xx_IRQ_L1_MAIN << MPC52xx_IRQ_L1_OFFSET) &
+		    MPC52xx_IRQ_L1_MASK;
+	} else if (status & 0x20000000) {	/* peripheral */
+	      peripheral:
+		irq = (status >> 24) & 0x1f;
+		if (irq == 0) {	/* bestcomm */
+			status = in_be32(&sdma->IntPend);
+			irq = ffs(status) - 1;
+			irq |=
+			    (MPC52xx_IRQ_L1_SDMA << MPC52xx_IRQ_L1_OFFSET) &
+			    MPC52xx_IRQ_L1_MASK;
+		} else
+			irq |=
+			    (MPC52xx_IRQ_L1_PERP << MPC52xx_IRQ_L1_OFFSET) &
+			    MPC52xx_IRQ_L1_MASK;
+
+	}
+
+	pr_debug("%s: irq=%x. virq=%d\n", __func__, irq,
+		 irq_linear_revmap(mpc52xx_irqhost, irq));
+
+	return irq_linear_revmap(mpc52xx_irqhost, irq);
+}
--- a/arch/powerpc/sysdev/Makefile	2006-11-01 09:18:43.000000000 +0100
+++ b/arch/powerpc/sysdev/Makefile	2006-10-31 19:56:41.000000000 +0100
@@ -13,6 +13,7 @@ obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_PPC_TODC)		+= todc.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
+obj-$(CONFIG_PPC_MPC52xx_PIC)	+= mpc52xx_pic.o
 
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
--- a/include/asm-powerpc/mpc52xx.h	1970-01-01 01:00:00.000000000 +0100
+++ b/include/asm-powerpc/mpc52xx.h	2006-11-02 17:54:37.000000000 +0100
@@ -0,0 +1,319 @@
+/*
+ * 
+ * Prototypes, etc. for the Freescale MPC52xx embedded cpu chips
+ * May need to be cleaned as the port goes on ...
+ *
+ * Copyright (C) 2004-2005 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2003 MontaVista, Software, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __ASM_POWERPC_MPC52xx_H__
+#define __ASM_POWERPC_MPC52xx_H__
+
+#ifndef __ASSEMBLY__
+#include <asm/types.h>
+#include <asm/prom.h>
+
+#endif				/* __ASSEMBLY__ */
+
+/* ======================================================================== */
+/* Main registers/struct addresses                                          */
+/* ======================================================================== */
+
+/* Registers zone offset/size  */
+#define MPC52xx_MMAP_CTL_OFFSET		0x0000
+#define MPC52xx_MMAP_CTL_SIZE		0x068
+#define MPC52xx_SDRAM_OFFSET		0x0100
+#define MPC52xx_SDRAM_SIZE		0x010
+#define MPC52xx_CDM_OFFSET		0x0200
+#define MPC52xx_CDM_SIZE		0x038
+#define MPC52xx_INTR_OFFSET		0x0500
+#define MPC52xx_INTR_SIZE		0x04c
+#define MPC52xx_GPTx_OFFSET(x)		(0x0600 + ((x)<<4))
+#define MPC52xx_GPT_SIZE		0x010
+#define MPC52xx_RTC_OFFSET		0x0800
+#define MPC52xx_RTC_SIZE		0x024
+#define MPC52xx_GPIO_OFFSET		0x0b00
+#define MPC52xx_GPIO_SIZE		0x040
+#define MPC52xx_GPIO_WKUP_OFFSET	0x0c00
+#define MPC52xx_GPIO_WKUP_SIZE		0x028
+#define MPC52xx_PCI_OFFSET		0x0d00
+#define MPC52xx_PCI_SIZE		0x100
+#define MPC52xx_SDMA_OFFSET		0x1200
+#define MPC52xx_SDMA_SIZE		0x100
+#define MPC52xx_XLB_OFFSET		0x1f00
+#define MPC52xx_XLB_SIZE		0x100
+#define MPC52xx_PSCx_OFFSET(x)		(((x)!=6)?(0x1e00+((x)<<9)):0x2c00)
+#define MPC52xx_PSC_SIZE		0x0a0
+
+/* SRAM used for SDMA */
+#define MPC52xx_SRAM_OFFSET		0x8000
+#define MPC52xx_SRAM_SIZE		0x4000
+
+/* ======================================================================== */
+/* IRQ mapping                                                              */
+/* ======================================================================== */
+
+#define MPC52xx_IRQ_L1_CRIT	(0)
+#define MPC52xx_IRQ_L1_MAIN	(1)
+#define MPC52xx_IRQ_L1_PERP	(2)
+#define MPC52xx_IRQ_L1_SDMA	(3)
+
+#define MPC52xx_IRQ_L1_OFFSET   (6)
+#define MPC52xx_IRQ_L1_MASK     (0x00c0)
+
+#define MPC52xx_IRQ_L2_OFFSET   (0)
+#define MPC52xx_IRQ_L2_MASK     (0x003f)
+
+#define MPC52xx_IRQ_HIGHTESTVIRQ (0xd0)
+
+/* ======================================================================== */
+/* Structures mapping of some unit register set                             */
+/* ======================================================================== */
+
+#ifndef __ASSEMBLY__
+
+/* Memory Mapping Control */
+struct mpc52xx_mmap_ctl {
+	u32 mbar;		/* MMAP_CTRL + 0x00 */
+
+	u32 cs0_start;		/* MMAP_CTRL + 0x04 */
+	u32 cs0_stop;		/* MMAP_CTRL + 0x08 */
+	u32 cs1_start;		/* MMAP_CTRL + 0x0c */
+	u32 cs1_stop;		/* MMAP_CTRL + 0x10 */
+	u32 cs2_start;		/* MMAP_CTRL + 0x14 */
+	u32 cs2_stop;		/* MMAP_CTRL + 0x18 */
+	u32 cs3_start;		/* MMAP_CTRL + 0x1c */
+	u32 cs3_stop;		/* MMAP_CTRL + 0x20 */
+	u32 cs4_start;		/* MMAP_CTRL + 0x24 */
+	u32 cs4_stop;		/* MMAP_CTRL + 0x28 */
+	u32 cs5_start;		/* MMAP_CTRL + 0x2c */
+	u32 cs5_stop;		/* MMAP_CTRL + 0x30 */
+
+	u32 sdram0;		/* MMAP_CTRL + 0x34 */
+	u32 sdram1;		/* MMAP_CTRL + 0X38 */
+
+	u32 reserved[4];	/* MMAP_CTRL + 0x3c .. 0x48 */
+
+	u32 boot_start;		/* MMAP_CTRL + 0x4c */
+	u32 boot_stop;		/* MMAP_CTRL + 0x50 */
+
+	u32 ipbi_ws_ctrl;	/* MMAP_CTRL + 0x54 */
+
+	u32 cs6_start;		/* MMAP_CTRL + 0x58 */
+	u32 cs6_stop;		/* MMAP_CTRL + 0x5c */
+	u32 cs7_start;		/* MMAP_CTRL + 0x60 */
+	u32 cs7_stop;		/* MMAP_CTRL + 0x64 */
+};
+
+/* SDRAM control */
+struct mpc52xx_sdram {
+	u32 mode;		/* SDRAM + 0x00 */
+	u32 ctrl;		/* SDRAM + 0x04 */
+	u32 config1;		/* SDRAM + 0x08 */
+	u32 config2;		/* SDRAM + 0x0c */
+};
+
+/* Interrupt controller */
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
+/* SDMA */
+struct mpc52xx_sdma {
+	u32 taskBar;		/* SDMA + 0x00 */
+	u32 currentPointer;	/* SDMA + 0x04 */
+	u32 endPointer;		/* SDMA + 0x08 */
+	u32 variablePointer;	/* SDMA + 0x0c */
+
+	u8 IntVect1;		/* SDMA + 0x10 */
+	u8 IntVect2;		/* SDMA + 0x11 */
+	u16 PtdCntrl;		/* SDMA + 0x12 */
+
+	u32 IntPend;		/* SDMA + 0x14 */
+	u32 IntMask;		/* SDMA + 0x18 */
+
+	u16 tcr[16];		/* SDMA + 0x1c .. 0x3a */
+
+	u8 ipr[32];		/* SDMA + 0x3c .. 0x5b */
+
+	u32 cReqSelect;		/* SDMA + 0x5c */
+	u32 task_size0;		/* SDMA + 0x60 */
+	u32 task_size1;		/* SDMA + 0x64 */
+	u32 MDEDebug;		/* SDMA + 0x68 */
+	u32 ADSDebug;		/* SDMA + 0x6c */
+	u32 Value1;		/* SDMA + 0x70 */
+	u32 Value2;		/* SDMA + 0x74 */
+	u32 Control;		/* SDMA + 0x78 */
+	u32 Status;		/* SDMA + 0x7c */
+	u32 PTDDebug;		/* SDMA + 0x80 */
+};
+
+/* GPT */
+struct mpc52xx_gpt {
+	u32 mode;		/* GPTx + 0x00 */
+	u32 count;		/* GPTx + 0x04 */
+	u32 pwm;		/* GPTx + 0x08 */
+	u32 status;		/* GPTx + 0X0c */
+};
+
+/* GPIO */
+struct mpc52xx_gpio {
+	u32 port_config;	/* GPIO + 0x00 */
+	u32 simple_gpioe;	/* GPIO + 0x04 */
+	u32 simple_ode;		/* GPIO + 0x08 */
+	u32 simple_ddr;		/* GPIO + 0x0c */
+	u32 simple_dvo;		/* GPIO + 0x10 */
+	u32 simple_ival;	/* GPIO + 0x14 */
+	u8 outo_gpioe;		/* GPIO + 0x18 */
+	u8 reserved1[3];	/* GPIO + 0x19 */
+	u8 outo_dvo;		/* GPIO + 0x1c */
+	u8 reserved2[3];	/* GPIO + 0x1d */
+	u8 sint_gpioe;		/* GPIO + 0x20 */
+	u8 reserved3[3];	/* GPIO + 0x21 */
+	u8 sint_ode;		/* GPIO + 0x24 */
+	u8 reserved4[3];	/* GPIO + 0x25 */
+	u8 sint_ddr;		/* GPIO + 0x28 */
+	u8 reserved5[3];	/* GPIO + 0x29 */
+	u8 sint_dvo;		/* GPIO + 0x2c */
+	u8 reserved6[3];	/* GPIO + 0x2d */
+	u8 sint_inten;		/* GPIO + 0x30 */
+	u8 reserved7[3];	/* GPIO + 0x31 */
+	u16 sint_itype;		/* GPIO + 0x34 */
+	u16 reserved8;		/* GPIO + 0x36 */
+	u8 gpio_control;	/* GPIO + 0x38 */
+	u8 reserved9[3];	/* GPIO + 0x39 */
+	u8 sint_istat;		/* GPIO + 0x3c */
+	u8 sint_ival;		/* GPIO + 0x3d */
+	u8 bus_errs;		/* GPIO + 0x3e */
+	u8 reserved10;		/* GPIO + 0x3f */
+};
+
+#define MPC52xx_GPIO_PSC_CONFIG_UART_WITHOUT_CD	4
+#define MPC52xx_GPIO_PSC_CONFIG_UART_WITH_CD	5
+#define MPC52xx_GPIO_PCI_DIS			(1<<15)
+
+/* GPIO with WakeUp*/
+struct mpc52xx_gpio_wkup {
+	u8 wkup_gpioe;		/* GPIO_WKUP + 0x00 */
+	u8 reserved1[3];	/* GPIO_WKUP + 0x03 */
+	u8 wkup_ode;		/* GPIO_WKUP + 0x04 */
+	u8 reserved2[3];	/* GPIO_WKUP + 0x05 */
+	u8 wkup_ddr;		/* GPIO_WKUP + 0x08 */
+	u8 reserved3[3];	/* GPIO_WKUP + 0x09 */
+	u8 wkup_dvo;		/* GPIO_WKUP + 0x0C */
+	u8 reserved4[3];	/* GPIO_WKUP + 0x0D */
+	u8 wkup_inten;		/* GPIO_WKUP + 0x10 */
+	u8 reserved5[3];	/* GPIO_WKUP + 0x11 */
+	u8 wkup_iinten;		/* GPIO_WKUP + 0x14 */
+	u8 reserved6[3];	/* GPIO_WKUP + 0x15 */
+	u16 wkup_itype;		/* GPIO_WKUP + 0x18 */
+	u8 reserved7[2];	/* GPIO_WKUP + 0x1A */
+	u8 wkup_maste;		/* GPIO_WKUP + 0x1C */
+	u8 reserved8[3];	/* GPIO_WKUP + 0x1D */
+	u8 wkup_ival;		/* GPIO_WKUP + 0x20 */
+	u8 reserved9[3];	/* GPIO_WKUP + 0x21 */
+	u8 wkup_istat;		/* GPIO_WKUP + 0x24 */
+	u8 reserved10[3];	/* GPIO_WKUP + 0x25 */
+};
+
+/* XLB Bus control */
+struct mpc52xx_xlb {
+	u8 reserved[0x40];
+	u32 config;		/* XLB + 0x40 */
+	u32 version;		/* XLB + 0x44 */
+	u32 status;		/* XLB + 0x48 */
+	u32 int_enable;		/* XLB + 0x4c */
+	u32 addr_capture;	/* XLB + 0x50 */
+	u32 bus_sig_capture;	/* XLB + 0x54 */
+	u32 addr_timeout;	/* XLB + 0x58 */
+	u32 data_timeout;	/* XLB + 0x5c */
+	u32 bus_act_timeout;	/* XLB + 0x60 */
+	u32 master_pri_enable;	/* XLB + 0x64 */
+	u32 master_priority;	/* XLB + 0x68 */
+	u32 base_address;	/* XLB + 0x6c */
+	u32 snoop_window;	/* XLB + 0x70 */
+};
+
+#define MPC52xx_XLB_CFG_PLDIS		(1 << 31)
+#define MPC52xx_XLB_CFG_SNOOP		(1 << 15)
+
+/* Clock Distribution control */
+struct mpc52xx_cdm {
+	u32 jtag_id;		/* CDM + 0x00  reg0 read only */
+	u32 rstcfg;		/* CDM + 0x04  reg1 read only */
+	u32 breadcrumb;		/* CDM + 0x08  reg2 */
+
+	u8 mem_clk_sel;		/* CDM + 0x0c  reg3 byte0 */
+	u8 xlb_clk_sel;		/* CDM + 0x0d  reg3 byte1 read only */
+	u8 ipb_clk_sel;		/* CDM + 0x0e  reg3 byte2 */
+	u8 pci_clk_sel;		/* CDM + 0x0f  reg3 byte3 */
+
+	u8 ext_48mhz_en;	/* CDM + 0x10  reg4 byte0 */
+	u8 fd_enable;		/* CDM + 0x11  reg4 byte1 */
+	u16 fd_counters;	/* CDM + 0x12  reg4 byte2,3 */
+
+	u32 clk_enables;	/* CDM + 0x14  reg5 */
+
+	u8 osc_disable;		/* CDM + 0x18  reg6 byte0 */
+	u8 reserved0[3];	/* CDM + 0x19  reg6 byte1,2,3 */
+
+	u8 ccs_sleep_enable;	/* CDM + 0x1c  reg7 byte0 */
+	u8 osc_sleep_enable;	/* CDM + 0x1d  reg7 byte1 */
+	u8 reserved1;		/* CDM + 0x1e  reg7 byte2 */
+	u8 ccs_qreq_test;	/* CDM + 0x1f  reg7 byte3 */
+
+	u8 soft_reset;		/* CDM + 0x20  u8 byte0 */
+	u8 no_ckstp;		/* CDM + 0x21  u8 byte0 */
+	u8 reserved2[2];	/* CDM + 0x22  u8 byte1,2,3 */
+
+	u8 pll_lock;		/* CDM + 0x24  reg9 byte0 */
+	u8 pll_looselock;	/* CDM + 0x25  reg9 byte1 */
+	u8 pll_sm_lockwin;	/* CDM + 0x26  reg9 byte2 */
+	u8 reserved3;		/* CDM + 0x27  reg9 byte3 */
+
+	u16 reserved4;		/* CDM + 0x28  reg10 byte0,1 */
+	u16 mclken_div_psc1;	/* CDM + 0x2a  reg10 byte2,3 */
+
+	u16 reserved5;		/* CDM + 0x2c  reg11 byte0,1 */
+	u16 mclken_div_psc2;	/* CDM + 0x2e  reg11 byte2,3 */
+
+	u16 reserved6;		/* CDM + 0x30  reg12 byte0,1 */
+	u16 mclken_div_psc3;	/* CDM + 0x32  reg12 byte2,3 */
+
+	u16 reserved7;		/* CDM + 0x34  reg13 byte0,1 */
+	u16 mclken_div_psc6;	/* CDM + 0x36  reg13 byte2,3 */
+};
+
+#endif				/* __ASSEMBLY__ */
+
+/* ========================================================================= */
+/* Prototypes for MPC52xx syslib                                             */
+/* ========================================================================= */
+
+#ifndef __ASSEMBLY__
+
+extern void mpc52xx_init_irq(void);
+extern unsigned int mpc52xx_get_irq(void);
+
+#endif				/* __ASSEMBLY__ */
+
+#endif				/* _ASM_POWERPC_MPC52xx_H__ */
--- a/include/asm-ppc/io.h	2006-11-01 09:19:02.000000000 +0100
+++ b/include/asm-ppc/io.h	2006-11-02 18:01:17.000000000 +0100
@@ -26,7 +26,7 @@
 
 #if defined(CONFIG_4xx)
 #include <asm/ibm4xx.h>
-#elif defined(CONFIG_PPC_MPC52xx)
+#elif defined(CONFIG_PPC_MPC52xx) && !defined(CONFIG_PPC_MERGE)
 #include <asm/mpc52xx.h>
 #elif defined(CONFIG_8xx)
 #include <asm/mpc8xx.h>

--------------030209090101060204050209
Content-Type: text/x-vcard; charset=utf-8;
 name="nd.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nd.vcf"

begin:vcard
fn:Nicolas DET ( bplan GmbH )
n:DET;Nicolas
org:bplan GmbH
adr:;;;;;;Germany
email;internet:nd@bplan-gmbh.de
title:Software Entwicklung
tel;work:+49 6171 9187 - 31
x-mozilla-html:FALSE
url:http://www.bplan-gmbh.de
version:2.1
end:vcard


--------------030209090101060204050209--
