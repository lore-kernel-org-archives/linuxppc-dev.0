Return-Path: <nd@bplan-gmbh.de>
Received: from em-p07-ob.rzone.de (em-p07-ob.rzone.de [81.169.146.246])
	by ozlabs.org (Postfix) with ESMTP id 6BA5967DD8
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 21:41:10 +1100 (EST)
Date: Tue, 7 Nov 2006 11:40:40 +0100 (MET)
Message-Id: <200611071040.kA7Aeea6006482@post.webmailer.de>
To: linuxppc-dev@ozlabs.org
From: Nicolas DET<nd@bplan-gmbh.de>
Subject: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Cc: sven@genesi-usa.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch add MPC52xx Interrupt controller for ARCH=3Dpowerpc.

It includes the main code in arch/powerpc/sysdev/ ad well as an header file=
 in
include/asm-powerpc.

The header file has now distinct section for the struct and the IRQ mapping=
/enconding define

Signed-off-by: Nicolas DET <nd@bplan-gmbh.de>
---
--- a/arch/powerpc/sysdev/mpc52xx_pic.c=091970-01-01 01:00:00.000000000 +01=
00
+++ b/arch/powerpc/sysdev/mpc52xx_pic.c=092006-11-07 10:57:28.000000000 +01=
00
@@ -0,0 +1,527 @@
+/*
+ *
+ * Programmable Interrupt Controller functions for the Freescale MPC52xx.
+ *
+ * Copyright (C) 2006 bplan GmbH
+ *
+ * Based on (well, mostly copied from) the code from the 2.4 kernel by
+ * Dale Farnsworth <dfarnsworth@mvista.com> and Kent Borg.
+ *=20
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
+static struct irq_host *mpc52xx_irqhost =3D NULL;
+
+static unsigned char mpc52xx_map_senses[4] =3D {
+=09IRQ_TYPE_LEVEL_HIGH,
+=09IRQ_TYPE_EDGE_RISING,
+=09IRQ_TYPE_EDGE_FALLING,
+=09IRQ_TYPE_LEVEL_LOW,
+};
+
+/*
+ *
+*/
+
+static inline void io_be_setbit(u32 __iomem *addr, int bitno)
+{
+=09out_be32(addr, in_be32(addr) | (1 << bitno) );
+}
+
+static inline void io_be_clrbit(u32 __iomem *addr, int bitno)
+{
+=09out_be32(addr, in_be32(addr) & ~(1 << bitno));
+}
+
+/*
+ * IRQ[0-3] interrupt irq_chip
+*/
+
+static void mpc52xx_extirq_mask(unsigned int virq)
+{
+=09int irq;
+=09int l2irq;
+
+=09irq =3D irq_map[virq].hwirq;
+=09l2irq =3D (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+=09pr_debug("%s: irq=3D%x. l2=3D%dn", __func__, irq, l2irq);
+
+=09io_be_clrbit(&intr->ctrl, 11 - l2irq);
+}
+
+static void mpc52xx_extirq_unmask(unsigned int virq)
+{
+=09int irq;
+=09int l2irq;
+
+=09irq =3D irq_map[virq].hwirq;
+=09l2irq =3D (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+=09pr_debug("%s: irq=3D%x. l2=3D%dn", __func__, irq, l2irq);
+
+=09io_be_setbit(&intr->ctrl, 11 - l2irq);
+}
+
+static void mpc52xx_extirq_ack(unsigned int virq)
+{
+=09int irq;
+=09int l2irq;
+
+=09irq =3D irq_map[virq].hwirq;
+=09l2irq =3D (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+=09pr_debug("%s: irq=3D%x. l2=3D%dn", __func__, irq, l2irq);
+
+=09io_be_setbit(&intr->ctrl, 27-l2irq);
+}
+
+static struct irq_chip mpc52xx_extirq_irqchip =3D {
+=09.typename =3D " MPC52xx IRQ[0-3] ",
+=09.mask =3D mpc52xx_extirq_mask,
+=09.unmask =3D mpc52xx_extirq_unmask,
+=09.ack =3D mpc52xx_extirq_ack,
+};
+
+/*
+ * Main interrupt irq_chip
+*/
+
+static void mpc52xx_main_mask(unsigned int virq)
+{
+=09int irq;
+=09int l2irq;
+
+=09irq =3D irq_map[virq].hwirq;
+=09l2irq =3D (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+=09pr_debug("%s: irq=3D%x. l2=3D%dn", __func__, irq, l2irq);
+
+=09io_be_setbit(&intr->main_mask, 15 - l2irq);
+}
+
+static void mpc52xx_main_unmask(unsigned int virq)
+{
+=09int irq;
+=09int l2irq;
+
+=09irq =3D irq_map[virq].hwirq;
+=09l2irq =3D (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+=09pr_debug("%s: irq=3D%x. l2=3D%dn", __func__, irq, l2irq);
+
+=09io_be_clrbit(&intr->main_mask, 15 - l2irq);
+}
+
+static struct irq_chip mpc52xx_main_irqchip =3D {
+=09.typename =3D "MPC52xx Main",
+=09.mask =3D mpc52xx_main_mask,
+=09.mask_ack =3D mpc52xx_main_mask,
+=09.unmask =3D mpc52xx_main_unmask,
+};
+
+/*
+ * Peripherals interrupt irq_chip
+*/
+
+static void mpc52xx_periph_mask(unsigned int virq)
+{
+=09int irq;
+=09int l2irq;
+
+=09irq =3D irq_map[virq].hwirq;
+=09l2irq =3D (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+=09pr_debug("%s: irq=3D%x. l2=3D%dn", __func__, irq, l2irq);
+
+=09io_be_setbit(&intr->per_mask, 31 - l2irq);
+}
+
+static void mpc52xx_periph_unmask(unsigned int virq)
+{
+=09int irq;
+=09int l2irq;
+
+=09irq =3D irq_map[virq].hwirq;
+=09l2irq =3D (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+=09pr_debug("%s: irq=3D%x. l2=3D%dn", __func__, irq, l2irq);
+
+=09io_be_clrbit(&intr->per_mask, 31 - l2irq);
+}
+
+static struct irq_chip mpc52xx_periph_irqchip =3D {
+=09.typename =3D "MPC52xx Peripherals",
+=09.mask =3D mpc52xx_periph_mask,
+=09.mask_ack =3D mpc52xx_periph_mask,
+=09.unmask =3D mpc52xx_periph_unmask,
+};
+
+/*
+ * SDMA interrupt irq_chip
+*/
+
+static void mpc52xx_sdma_mask(unsigned int virq)
+{
+=09int irq;
+=09int l2irq;
+
+=09irq =3D irq_map[virq].hwirq;
+=09l2irq =3D (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+=09pr_debug("%s: irq=3D%x. l2=3D%dn", __func__, irq, l2irq);
+
+=09io_be_setbit(&sdma->IntMask, l2irq);
+}
+
+static void mpc52xx_sdma_unmask(unsigned int virq)
+{
+=09int irq;
+=09int l2irq;
+
+=09irq =3D irq_map[virq].hwirq;
+=09l2irq =3D (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+=09pr_debug("%s: irq=3D%x. l2=3D%dn", __func__, irq, l2irq);
+
+=09io_be_clrbit(&sdma->IntMask, l2irq);
+}
+
+static void mpc52xx_sdma_ack(unsigned int virq)
+{
+=09int irq;
+=09int l2irq;
+
+=09irq =3D irq_map[virq].hwirq;
+=09l2irq =3D (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+=09pr_debug("%s: irq=3D%x. l2=3D%dn", __func__, irq, l2irq);
+
+=09out_be32(&sdma->IntPend, 1 << l2irq);
+}
+
+static struct irq_chip mpc52xx_sdma_irqchip =3D {
+=09.typename =3D "MPC52xx SDMA",
+=09.mask =3D mpc52xx_sdma_mask,
+=09.unmask =3D mpc52xx_sdma_unmask,
+=09.ack =3D mpc52xx_sdma_ack,
+};
+
+/*
+ * irq_host
+*/
+
+static int mpc52xx_irqhost_match(struct irq_host *h, struct device_node *n=
ode)
+{
+=09pr_debug("%s: node=3D%pn", __func__, node);
+=09return mpc52xx_irqhost->host_data =3D=3D node;
+}
+
+static int mpc52xx_irqhost_xlate(struct irq_host *h, struct device_node *c=
t,
+=09=09=09=09 u32 * intspec, unsigned int intsize,
+=09=09=09=09 irq_hw_number_t * out_hwirq,
+=09=09=09=09 unsigned int *out_flags)
+{
+=09int intrvect_l1;
+=09int intrvect_l2;
+=09int intrvect_type;
+=09int intrvect_linux;
+
+=09if (intsize !=3D 3)
+=09=09return -1;
+
+=09intrvect_l1 =3D (int)intspec[0];
+=09intrvect_l2 =3D (int)intspec[1];
+=09intrvect_type =3D (int)intspec[2];
+
+=09intrvect_linux =3D
+=09    (intrvect_l1 << MPC52xx_IRQ_L1_OFFSET) & MPC52xx_IRQ_L1_MASK;
+=09intrvect_linux |=3D
+=09    (intrvect_l2 << MPC52xx_IRQ_L2_OFFSET) & MPC52xx_IRQ_L2_MASK;
+
+=09pr_debug("return %x, l1=3D%d, l2=3D%dn", intrvect_linux, intrvect_l1,
+=09=09 intrvect_l2);
+
+=09*out_hwirq =3D intrvect_linux;
+=09*out_flags =3D mpc52xx_map_senses[intrvect_type];
+
+=09return 0;
+}
+
+/*
+ * this function retrieves the correct IRQ type out
+ * of the MPC regs
+ * Only externals IRQs needs this
+*/
+static int mpc52xx_irqx_gettype(int irq)
+{
+=09int type;
+=09u32 ctrl_reg;
+
+=09ctrl_reg =3D in_be32(&intr->ctrl);
+=09type =3D (ctrl_reg >> (22 - irq * 2)) & 0x3;
+
+=09return mpc52xx_map_senses[type];
+}
+
+static int mpc52xx_irqhost_map(struct irq_host *h, unsigned int virq,
+=09=09=09       irq_hw_number_t irq)
+{
+=09int l1irq;
+=09int l2irq;
+=09struct irq_chip *good_irqchip;
+=09void *good_handle;
+=09int type;
+
+=09l1irq =3D (irq & MPC52xx_IRQ_L1_MASK) >> MPC52xx_IRQ_L1_OFFSET;
+=09l2irq =3D (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+=09/*
+=09 * Most of ours IRQs will be level low
+=09 * Only external IRQs on some platform may be others
+=09 */
+=09type =3D IRQ_TYPE_LEVEL_LOW;
+
+=09switch (l1irq) {
+=09case MPC52xx_IRQ_L1_CRIT:
+=09=09pr_debug("%s: Critical. l2=3D%xn", __func__, l2irq);
+
+=09=09BUG_ON(l2irq !=3D 0);
+
+=09=09type =3D mpc52xx_irqx_gettype(l2irq);
+=09=09good_irqchip =3D &mpc52xx_extirq_irqchip;
+=09=09break;
+
+=09case MPC52xx_IRQ_L1_MAIN:
+=09=09pr_debug("%s: Main IRQ[1-3] l2=3D%xn", __func__, l2irq);
+
+=09=09if ((l2irq >=3D 1) && (l2irq <=3D 3)) {
+=09=09=09type =3D mpc52xx_irqx_gettype(l2irq);
+=09=09=09good_irqchip =3D &mpc52xx_extirq_irqchip;
+=09=09} else {
+=09=09=09good_irqchip =3D &mpc52xx_main_irqchip;
+=09=09}
+=09=09break;
+
+=09case MPC52xx_IRQ_L1_PERP:
+=09=09pr_debug("%s: Peripherals. l2=3D%xn", __func__, l2irq);
+=09=09good_irqchip =3D &mpc52xx_periph_irqchip;
+=09=09break;
+
+=09case MPC52xx_IRQ_L1_SDMA:
+=09=09pr_debug("%s: SDMA. l2=3D%xn", __func__, l2irq);
+=09=09good_irqchip =3D &mpc52xx_sdma_irqchip;
+=09=09break;
+
+=09default:
+=09=09pr_debug("%s: Error, unknown L1 IRQ (0x%x)n", __func__, l1irq);
+=09=09printk(KERN_ERR "Unknow IRQ!n");
+=09=09return -EINVAL;
+=09}
+
+=09switch (type) {
+=09case IRQ_TYPE_EDGE_FALLING:
+=09case IRQ_TYPE_EDGE_RISING:
+=09=09good_handle =3D handle_edge_irq;
+=09=09break;
+=09default:
+=09=09good_handle =3D handle_level_irq;
+=09}
+
+=09set_irq_chip_and_handler(virq, good_irqchip, good_handle);
+
+=09pr_debug("%s: virq=3D%x, hw=3D%x. type=3D%xn", __func__, virq,
+=09=09 (int)irq, type);
+
+=09return 0;
+}
+
+static struct irq_host_ops mpc52xx_irqhost_ops =3D {
+=09.match =3D mpc52xx_irqhost_match,
+=09.xlate =3D mpc52xx_irqhost_xlate,
+=09.map =3D mpc52xx_irqhost_map,
+};
+
+/*
+ * init (public)
+*/
+
+void __init mpc52xx_init_irq(void)
+{
+=09struct device_node *picnode =3D NULL;
+=09int picnode_regsize;
+=09u32 picnode_regoffset;
+
+=09struct device_node *sdmanode =3D NULL;
+=09int sdmanode_regsize;
+=09u32 sdmanode_regoffset;
+
+=09u64 size64;
+=09int flags;
+
+=09u32 intr_ctrl;
+
+=09picnode =3D of_find_compatible_node(NULL, "interrupt-controller", "mpc5=
200-pic");
+=09if (picnode =3D=3D NULL) {
+=09=09printk(KERN_ERR "MPC52xx PIC: Unable to find the interrupt controlle=
r in the OpenFirmware device treen");
+=09=09goto end;
+=09}
+
+=09sdmanode =3D of_find_compatible_node(NULL, "dma-controller", "mpc5200-b=
estcomm");
+=09if (sdmanode =3D=3D NULL) {
+=09=09printk(KERN_ERR "MPC52xx PIC: Unable to find the Bestcomm DMA contro=
ller device in the OpenFirmware device treen");
+=09=09goto end;
+=09}
+
+=09/* Retrieve PIC ressources */
+=09picnode_regoffset =3D (u32) of_get_address(picnode, 0, &size64, &flags)=
;
+=09if (picnode_regoffset =3D=3D 0) {
+=09=09printk(KERN_ERR "MPC52xx PIC: Unable to get the interrupt controller=
 addressn");
+=09=09goto end;
+=09}
+
+=09picnode_regoffset =3D of_translate_address(picnode, (u32 *) picnode_reg=
offset);
+=09picnode_regsize =3D (int) size64;=09
+
+=09/* Retrieve SDMA ressources */
+=09sdmanode_regoffset =3D (u32) of_get_address(sdmanode, 0, &size64, &flag=
s);
+=09if (sdmanode_regoffset =3D=3D 0) {
+=09=09printk(KERN_ERR "MPC52xx PIC: Unable to get the Bestcomm DMA control=
ler addressn");
+=09=09goto end;
+=09}
+
+=09sdmanode_regoffset =3D of_translate_address(sdmanode, (u32 *) sdmanode_=
regoffset);
+=09sdmanode_regsize =3D (int) size64;
+
+=09/* Remap the necessary zones */
+=09intr =3D ioremap(picnode_regoffset, picnode_regsize);
+=09if (intr =3D=3D NULL) {
+=09=09printk(KERN_ERR "MPC52xx PIC: Unable to ioremap interrupt controller=
 registers!");
+=09=09goto end;
+=09}
+
+=09sdma =3D ioremap(sdmanode_regoffset, sdmanode_regsize);
+=09if (sdma =3D=3D NULL) {
+=09=09iounmap(intr);
+=09=09printk(KERN_ERR "MPC52xx PIC: Unable to ioremap Bestcomm DMA control=
ler registers!");
+=09=09goto end;
+=09}
+
+=09printk(KERN_INFO "MPC52xx PIC: MPC52xx PIC Remapped at 0x%8.8xn", picno=
de_regoffset);
+=09printk(KERN_INFO "MPC52xx PIC: MPC52xx SDMA Remapped at 0x%8.8xn", sdma=
node_regoffset);
+
+=09/* Disable all interrupt sources. */
+=09out_be32(&sdma->IntPend, 0xffffffff);=09/* 1 means clear pending */
+=09out_be32(&sdma->IntMask, 0xffffffff);=09/* 1 means disabled */
+=09out_be32(&intr->per_mask, 0x7ffffc00);=09/* 1 means disabled */
+=09out_be32(&intr->main_mask, 0x00010fff);=09/* 1 means disabled */
+=09intr_ctrl =3D in_be32(&intr->ctrl);
+=09intr_ctrl &=3D 0x00ff0000;=09/* Keeps IRQ[0-3] config */
+=09intr_ctrl |=3D 0x0f000000 |=09/* clear IRQ 0-3 */
+=09    0x00001000 |=09/* MEE master external enable */
+=09    0x00000000 |=09/* 0 means disable IRQ 0-3 */
+=09    0x00000001;=09=09/* CEb route critical normally */
+=09out_be32(&intr->ctrl, intr_ctrl);
+
+=09/* Zero a bunch of the priority settings.  */
+=09out_be32(&intr->per_pri1, 0);
+=09out_be32(&intr->per_pri2, 0);
+=09out_be32(&intr->per_pri3, 0);
+=09out_be32(&intr->main_pri1, 0);
+=09out_be32(&intr->main_pri2, 0);
+
+=09/*
+=09 * As last step, add an irq host to translate the real
+=09 * hw irq information provided by the ofw to linux virq
+=09 */
+
+=09mpc52xx_irqhost =3D
+=09    irq_alloc_host(IRQ_HOST_MAP_LINEAR, MPC52xx_IRQ_HIGHTESTHWIRQ,
+=09=09=09   &mpc52xx_irqhost_ops, -1);
+
+=09if (mpc52xx_irqhost) {
+=09=09mpc52xx_irqhost->host_data =3D picnode;
+=09=09printk(KERN_INFO "MPC52xx PIC is up and running!n");
+=09} else {
+=09=09printk(KERN_ERR "MPC52xx PIC: Unable to allocate the IRQ hostn");
+=09}
+
+end:
+=09of_node_put(picnode);
+=09of_node_put(sdmanode);
+}
+
+/*
+ * get_irq (public)
+*/
+unsigned int mpc52xx_get_irq(void)
+{
+=09u32 status;
+=09int irq =3D NO_IRQ_IGNORE;
+
+=09status =3D in_be32(&intr->enc_status);
+=09if (status & 0x00000400) {=09/* critical */
+=09=09irq =3D (status >> 8) & 0x3;
+=09=09if (irq =3D=3D 2)=09/* high priority peripheral */
+=09=09=09goto peripheral;
+=09=09irq |=3D
+=09=09    (MPC52xx_IRQ_L1_CRIT << MPC52xx_IRQ_L1_OFFSET) &
+=09=09    MPC52xx_IRQ_L1_MASK;
+=09} else if (status & 0x00200000) {=09/* main */
+=09=09irq =3D (status >> 16) & 0x1f;
+=09=09if (irq =3D=3D 4)=09/* low priority peripheral */
+=09=09=09goto peripheral;
+=09=09irq |=3D
+=09=09    (MPC52xx_IRQ_L1_MAIN << MPC52xx_IRQ_L1_OFFSET) &
+=09=09    MPC52xx_IRQ_L1_MASK;
+=09} else if (status & 0x20000000) {=09/* peripheral */
+=09      peripheral:
+=09=09irq =3D (status >> 24) & 0x1f;
+=09=09if (irq =3D=3D 0) {=09/* bestcomm */
+=09=09=09status =3D in_be32(&sdma->IntPend);
+=09=09=09irq =3D ffs(status) - 1;
+=09=09=09irq |=3D
+=09=09=09    (MPC52xx_IRQ_L1_SDMA << MPC52xx_IRQ_L1_OFFSET) &
+=09=09=09    MPC52xx_IRQ_L1_MASK;
+=09=09} else
+=09=09=09irq |=3D
+=09=09=09    (MPC52xx_IRQ_L1_PERP << MPC52xx_IRQ_L1_OFFSET) &
+=09=09=09    MPC52xx_IRQ_L1_MASK;
+
+=09}
+
+=09pr_debug("%s: irq=3D%x. virq=3D%dn", __func__, irq,
+=09=09 irq_linear_revmap(mpc52xx_irqhost, irq));
+
+=09return irq_linear_revmap(mpc52xx_irqhost, irq);
+}
--- a/arch/powerpc/sysdev/Makefile=092006-11-01 09:18:43.000000000 +0100
+++ b/arch/powerpc/sysdev/Makefile=092006-11-07 11:21:25.000000000 +0100
@@ -13,6 +13,7 @@ obj-$(CONFIG_FSL_SOC)=09=09+=3D fsl_soc.o
 obj-$(CONFIG_PPC_TODC)=09=09+=3D todc.o
 obj-$(CONFIG_TSI108_BRIDGE)=09+=3D tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)=09+=3D qe_lib/
+obj-$(CONFIG_PPC_MPC52xx)=09+=3D mpc52xx_pic.o
=20
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_I8259)=09=09+=3D i8259.o
--- a/include/asm-powerpc/mpc52xx.h=091970-01-01 01:00:00.000000000 +0100
+++ b/include/asm-powerpc/mpc52xx.h=092006-11-07 10:57:28.000000000 +0100
@@ -0,0 +1,285 @@
+/*
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
+#endif /* __ASSEMBLY__ */
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
+/* HW IRQ mapping                                                         =
  */
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
+
+#define MPC52xx_IRQ_L1_CRIT=09(0)
+#define MPC52xx_IRQ_L1_MAIN=09(1)
+#define MPC52xx_IRQ_L1_PERP=09(2)
+#define MPC52xx_IRQ_L1_SDMA=09(3)
+
+#define MPC52xx_IRQ_L1_OFFSET   (6)
+#define MPC52xx_IRQ_L1_MASK     (0xc0)
+
+#define MPC52xx_IRQ_L2_OFFSET   (0)
+#define MPC52xx_IRQ_L2_MASK     (0x3f)
+
+#define MPC52xx_IRQ_HIGHTESTHWIRQ (0xd0)
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
+/* Structures mapping of some unit register set                           =
  */
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
+
+#ifndef __ASSEMBLY__
+
+/* Interrupt controller Register set */
+struct mpc52xx_intr {
+=09u32 per_mask;=09=09/* INTR + 0x00 */
+=09u32 per_pri1;=09=09/* INTR + 0x04 */
+=09u32 per_pri2;=09=09/* INTR + 0x08 */
+=09u32 per_pri3;=09=09/* INTR + 0x0c */
+=09u32 ctrl;=09=09/* INTR + 0x10 */
+=09u32 main_mask;=09=09/* INTR + 0x14 */
+=09u32 main_pri1;=09=09/* INTR + 0x18 */
+=09u32 main_pri2;=09=09/* INTR + 0x1c */
+=09u32 reserved1;=09=09/* INTR + 0x20 */
+=09u32 enc_status;=09=09/* INTR + 0x24 */
+=09u32 crit_status;=09/* INTR + 0x28 */
+=09u32 main_status;=09/* INTR + 0x2c */
+=09u32 per_status;=09=09/* INTR + 0x30 */
+=09u32 reserved2;=09=09/* INTR + 0x34 */
+=09u32 per_error;=09=09/* INTR + 0x38 */
+};
+
+/* Memory Mapping Control */
+struct mpc52xx_mmap_ctl {
+=09u32 mbar;=09=09/* MMAP_CTRL + 0x00 */
+
+=09u32 cs0_start;=09=09/* MMAP_CTRL + 0x04 */
+=09u32 cs0_stop;=09=09/* MMAP_CTRL + 0x08 */
+=09u32 cs1_start;=09=09/* MMAP_CTRL + 0x0c */
+=09u32 cs1_stop;=09=09/* MMAP_CTRL + 0x10 */
+=09u32 cs2_start;=09=09/* MMAP_CTRL + 0x14 */
+=09u32 cs2_stop;=09=09/* MMAP_CTRL + 0x18 */
+=09u32 cs3_start;=09=09/* MMAP_CTRL + 0x1c */
+=09u32 cs3_stop;=09=09/* MMAP_CTRL + 0x20 */
+=09u32 cs4_start;=09=09/* MMAP_CTRL + 0x24 */
+=09u32 cs4_stop;=09=09/* MMAP_CTRL + 0x28 */
+=09u32 cs5_start;=09=09/* MMAP_CTRL + 0x2c */
+=09u32 cs5_stop;=09=09/* MMAP_CTRL + 0x30 */
+
+=09u32 sdram0;=09=09/* MMAP_CTRL + 0x34 */
+=09u32 sdram1;=09=09/* MMAP_CTRL + 0X38 */
+
+=09u32 reserved[4];=09/* MMAP_CTRL + 0x3c .. 0x48 */
+
+=09u32 boot_start;=09=09/* MMAP_CTRL + 0x4c */
+=09u32 boot_stop;=09=09/* MMAP_CTRL + 0x50 */
+
+=09u32 ipbi_ws_ctrl;=09/* MMAP_CTRL + 0x54 */
+
+=09u32 cs6_start;=09=09/* MMAP_CTRL + 0x58 */
+=09u32 cs6_stop;=09=09/* MMAP_CTRL + 0x5c */
+=09u32 cs7_start;=09=09/* MMAP_CTRL + 0x60 */
+=09u32 cs7_stop;=09=09/* MMAP_CTRL + 0x64 */
+};
+
+/* SDRAM control */
+struct mpc52xx_sdram {
+=09u32 mode;=09=09/* SDRAM + 0x00 */
+=09u32 ctrl;=09=09/* SDRAM + 0x04 */
+=09u32 config1;=09=09/* SDRAM + 0x08 */
+=09u32 config2;=09=09/* SDRAM + 0x0c */
+};
+
+/* SDMA */
+struct mpc52xx_sdma {
+=09u32 taskBar;=09=09/* SDMA + 0x00 */
+=09u32 currentPointer;=09/* SDMA + 0x04 */
+=09u32 endPointer;=09=09/* SDMA + 0x08 */
+=09u32 variablePointer;=09/* SDMA + 0x0c */
+
+=09u8 IntVect1;=09=09/* SDMA + 0x10 */
+=09u8 IntVect2;=09=09/* SDMA + 0x11 */
+=09u16 PtdCntrl;=09=09/* SDMA + 0x12 */
+
+=09u32 IntPend;=09=09/* SDMA + 0x14 */
+=09u32 IntMask;=09=09/* SDMA + 0x18 */
+
+=09u16 tcr[16];=09=09/* SDMA + 0x1c .. 0x3a */
+
+=09u8 ipr[32];=09=09/* SDMA + 0x3c .. 0x5b */
+
+=09u32 cReqSelect;=09=09/* SDMA + 0x5c */
+=09u32 task_size0;=09=09/* SDMA + 0x60 */
+=09u32 task_size1;=09=09/* SDMA + 0x64 */
+=09u32 MDEDebug;=09=09/* SDMA + 0x68 */
+=09u32 ADSDebug;=09=09/* SDMA + 0x6c */
+=09u32 Value1;=09=09/* SDMA + 0x70 */
+=09u32 Value2;=09=09/* SDMA + 0x74 */
+=09u32 Control;=09=09/* SDMA + 0x78 */
+=09u32 Status;=09=09/* SDMA + 0x7c */
+=09u32 PTDDebug;=09=09/* SDMA + 0x80 */
+};
+
+/* GPT */
+struct mpc52xx_gpt {
+=09u32 mode;=09=09/* GPTx + 0x00 */
+=09u32 count;=09=09/* GPTx + 0x04 */
+=09u32 pwm;=09=09/* GPTx + 0x08 */
+=09u32 status;=09=09/* GPTx + 0X0c */
+};
+
+/* GPIO */
+struct mpc52xx_gpio {
+=09u32 port_config;=09/* GPIO + 0x00 */
+=09u32 simple_gpioe;=09/* GPIO + 0x04 */
+=09u32 simple_ode;=09=09/* GPIO + 0x08 */
+=09u32 simple_ddr;=09=09/* GPIO + 0x0c */
+=09u32 simple_dvo;=09=09/* GPIO + 0x10 */
+=09u32 simple_ival;=09/* GPIO + 0x14 */
+=09u8 outo_gpioe;=09=09/* GPIO + 0x18 */
+=09u8 reserved1[3];=09/* GPIO + 0x19 */
+=09u8 outo_dvo;=09=09/* GPIO + 0x1c */
+=09u8 reserved2[3];=09/* GPIO + 0x1d */
+=09u8 sint_gpioe;=09=09/* GPIO + 0x20 */
+=09u8 reserved3[3];=09/* GPIO + 0x21 */
+=09u8 sint_ode;=09=09/* GPIO + 0x24 */
+=09u8 reserved4[3];=09/* GPIO + 0x25 */
+=09u8 sint_ddr;=09=09/* GPIO + 0x28 */
+=09u8 reserved5[3];=09/* GPIO + 0x29 */
+=09u8 sint_dvo;=09=09/* GPIO + 0x2c */
+=09u8 reserved6[3];=09/* GPIO + 0x2d */
+=09u8 sint_inten;=09=09/* GPIO + 0x30 */
+=09u8 reserved7[3];=09/* GPIO + 0x31 */
+=09u16 sint_itype;=09=09/* GPIO + 0x34 */
+=09u16 reserved8;=09=09/* GPIO + 0x36 */
+=09u8 gpio_control;=09/* GPIO + 0x38 */
+=09u8 reserved9[3];=09/* GPIO + 0x39 */
+=09u8 sint_istat;=09=09/* GPIO + 0x3c */
+=09u8 sint_ival;=09=09/* GPIO + 0x3d */
+=09u8 bus_errs;=09=09/* GPIO + 0x3e */
+=09u8 reserved10;=09=09/* GPIO + 0x3f */
+};
+
+#define MPC52xx_GPIO_PSC_CONFIG_UART_WITHOUT_CD=094
+#define MPC52xx_GPIO_PSC_CONFIG_UART_WITH_CD=095
+#define MPC52xx_GPIO_PCI_DIS=09=09=09(1<<15)
+
+/* GPIO with WakeUp*/
+struct mpc52xx_gpio_wkup {
+=09u8 wkup_gpioe;=09=09/* GPIO_WKUP + 0x00 */
+=09u8 reserved1[3];=09/* GPIO_WKUP + 0x03 */
+=09u8 wkup_ode;=09=09/* GPIO_WKUP + 0x04 */
+=09u8 reserved2[3];=09/* GPIO_WKUP + 0x05 */
+=09u8 wkup_ddr;=09=09/* GPIO_WKUP + 0x08 */
+=09u8 reserved3[3];=09/* GPIO_WKUP + 0x09 */
+=09u8 wkup_dvo;=09=09/* GPIO_WKUP + 0x0C */
+=09u8 reserved4[3];=09/* GPIO_WKUP + 0x0D */
+=09u8 wkup_inten;=09=09/* GPIO_WKUP + 0x10 */
+=09u8 reserved5[3];=09/* GPIO_WKUP + 0x11 */
+=09u8 wkup_iinten;=09=09/* GPIO_WKUP + 0x14 */
+=09u8 reserved6[3];=09/* GPIO_WKUP + 0x15 */
+=09u16 wkup_itype;=09=09/* GPIO_WKUP + 0x18 */
+=09u8 reserved7[2];=09/* GPIO_WKUP + 0x1A */
+=09u8 wkup_maste;=09=09/* GPIO_WKUP + 0x1C */
+=09u8 reserved8[3];=09/* GPIO_WKUP + 0x1D */
+=09u8 wkup_ival;=09=09/* GPIO_WKUP + 0x20 */
+=09u8 reserved9[3];=09/* GPIO_WKUP + 0x21 */
+=09u8 wkup_istat;=09=09/* GPIO_WKUP + 0x24 */
+=09u8 reserved10[3];=09/* GPIO_WKUP + 0x25 */
+};
+
+/* XLB Bus control */
+struct mpc52xx_xlb {
+=09u8 reserved[0x40];
+=09u32 config;=09=09/* XLB + 0x40 */
+=09u32 version;=09=09/* XLB + 0x44 */
+=09u32 status;=09=09/* XLB + 0x48 */
+=09u32 int_enable;=09=09/* XLB + 0x4c */
+=09u32 addr_capture;=09/* XLB + 0x50 */
+=09u32 bus_sig_capture;=09/* XLB + 0x54 */
+=09u32 addr_timeout;=09/* XLB + 0x58 */
+=09u32 data_timeout;=09/* XLB + 0x5c */
+=09u32 bus_act_timeout;=09/* XLB + 0x60 */
+=09u32 master_pri_enable;=09/* XLB + 0x64 */
+=09u32 master_priority;=09/* XLB + 0x68 */
+=09u32 base_address;=09/* XLB + 0x6c */
+=09u32 snoop_window;=09/* XLB + 0x70 */
+};
+
+#define MPC52xx_XLB_CFG_PLDIS=09=09(1 << 31)
+#define MPC52xx_XLB_CFG_SNOOP=09=09(1 << 15)
+
+/* Clock Distribution control */
+struct mpc52xx_cdm {
+=09u32 jtag_id;=09=09/* CDM + 0x00  reg0 read only */
+=09u32 rstcfg;=09=09/* CDM + 0x04  reg1 read only */
+=09u32 breadcrumb;=09=09/* CDM + 0x08  reg2 */
+
+=09u8 mem_clk_sel;=09=09/* CDM + 0x0c  reg3 byte0 */
+=09u8 xlb_clk_sel;=09=09/* CDM + 0x0d  reg3 byte1 read only */
+=09u8 ipb_clk_sel;=09=09/* CDM + 0x0e  reg3 byte2 */
+=09u8 pci_clk_sel;=09=09/* CDM + 0x0f  reg3 byte3 */
+
+=09u8 ext_48mhz_en;=09/* CDM + 0x10  reg4 byte0 */
+=09u8 fd_enable;=09=09/* CDM + 0x11  reg4 byte1 */
+=09u16 fd_counters;=09/* CDM + 0x12  reg4 byte2,3 */
+
+=09u32 clk_enables;=09/* CDM + 0x14  reg5 */
+
+=09u8 osc_disable;=09=09/* CDM + 0x18  reg6 byte0 */
+=09u8 reserved0[3];=09/* CDM + 0x19  reg6 byte1,2,3 */
+
+=09u8 ccs_sleep_enable;=09/* CDM + 0x1c  reg7 byte0 */
+=09u8 osc_sleep_enable;=09/* CDM + 0x1d  reg7 byte1 */
+=09u8 reserved1;=09=09/* CDM + 0x1e  reg7 byte2 */
+=09u8 ccs_qreq_test;=09/* CDM + 0x1f  reg7 byte3 */
+
+=09u8 soft_reset;=09=09/* CDM + 0x20  u8 byte0 */
+=09u8 no_ckstp;=09=09/* CDM + 0x21  u8 byte0 */
+=09u8 reserved2[2];=09/* CDM + 0x22  u8 byte1,2,3 */
+
+=09u8 pll_lock;=09=09/* CDM + 0x24  reg9 byte0 */
+=09u8 pll_looselock;=09/* CDM + 0x25  reg9 byte1 */
+=09u8 pll_sm_lockwin;=09/* CDM + 0x26  reg9 byte2 */
+=09u8 reserved3;=09=09/* CDM + 0x27  reg9 byte3 */
+
+=09u16 reserved4;=09=09/* CDM + 0x28  reg10 byte0,1 */
+=09u16 mclken_div_psc1;=09/* CDM + 0x2a  reg10 byte2,3 */
+
+=09u16 reserved5;=09=09/* CDM + 0x2c  reg11 byte0,1 */
+=09u16 mclken_div_psc2;=09/* CDM + 0x2e  reg11 byte2,3 */
+
+=09u16 reserved6;=09=09/* CDM + 0x30  reg12 byte0,1 */
+=09u16 mclken_div_psc3;=09/* CDM + 0x32  reg12 byte2,3 */
+
+=09u16 reserved7;=09=09/* CDM + 0x34  reg13 byte0,1 */
+=09u16 mclken_div_psc6;=09/* CDM + 0x36  reg13 byte2,3 */
+};
+
+#endif /* __ASSEMBLY__ */
+
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 */
+/* Prototypes for MPC52xx sysdev                                          =
   */
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 */
+
+#ifndef __ASSEMBLY__
+
+extern void mpc52xx_init_irq(void);
+extern unsigned int mpc52xx_get_irq(void);
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_POWERPC_MPC52xx_H__ */
+
