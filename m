Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-2.online-age.net (ext-cn0ut-2.online-age.net
	[63.210.253.231])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 95376DE0CB
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 01:33:44 +1000 (EST)
Received: from int-cn0ut-6.online-age.net (int-cn0ut-6.online-age.net
	[3.159.252.75])
	by ext-cn0ut-2.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m8UFXXsE029863
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 11:33:33 -0400
Received: from cinmlip01.e2k.ad.ge.com (int-cn0ut-6.online-age.net
	[3.159.252.75])
	by int-cn0ut-6.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m8UFXXYS032163
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 11:33:33 -0400
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH v2] powerpc: GE Fanuc's FPGA based PIC controller on the SBC610
To: linuxppc-dev@ozlabs.org
Date: Tue, 30 Sep 2008 16:34:56 +0100
Message-ID: <20080930153058.29602.28885.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Support for the SBC610 VPX Single Board Computer from GE Fanuc (PowerPC MPC8641D).

A number of MPC8641D based route interrupts for on-board interrupts through
a FPGA based interrupt controller, which is chained with the
MPC8641D's mpic. This patch provides a basic driver to allow basic routing
of interrupts to the mpic.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

Kumar: Thank you for you fast response.

Change for version 2:
 * Driver moved from sysdev to platform/86xx

 arch/powerpc/boot/dts/gef_sbc610.dts     |   38 ++++
 arch/powerpc/platforms/86xx/Makefile     |    2 
 arch/powerpc/platforms/86xx/gef_pic.c    |  258 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/86xx/gef_pic.h    |   11 +
 arch/powerpc/platforms/86xx/gef_sbc610.c |   25 +++
 5 files changed, 328 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
index 80b79e4..d7a591b 100644
--- a/arch/powerpc/boot/dts/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/gef_sbc610.dts
@@ -67,6 +67,36 @@
 		reg = <0x0 0x40000000>;	// set by uboot
 	};
 
+	localbus@fef05000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8641-localbus", "simple-bus";
+		reg = <0xf8005000 0x1000>;
+		interrupts = <19 2>;
+		interrupt-parent = <&mpic>;
+
+		ranges = <0 0 0xff000000 0x01000000     // 16MB Boot flash
+			  1 0 0xe8000000 0x08000000     // Paged Flash 0
+			  2 0 0xe0000000 0x08000000     // Paged Flash 1
+			  3 0 0xfc100000 0x00020000     // NVRAM
+			  4 0 0xfc000000 0x00008000     // FPGA
+			  5 0 0xfc008000 0x00008000     // AFIX FPGA
+			  6 0 0xfd000000 0x00800000     // IO FPGA (8-bit)
+			  7 0 0xfd800000 0x00800000>;   // IO FPGA (32-bit)
+
+		gef_pic: pic@4,4000 {
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			device_type = "interrupt-controller";
+			compatible = "gef,fpga-pic";
+			reg = <0x4 0x4000 0x20>;
+			interrupts = <0x8 0x1
+				      0x9 0x1>;
+			interrupt-parent = <&mpic>;
+
+		};
+	};
+
 	soc@fef00000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -150,13 +180,13 @@
 			reg = <0x24520 0x20>;
 
 			phy0: ethernet-phy@0 {
-				interrupt-parent = <&mpic>;
-				interrupts = <0x0 0x1>;
+				interrupt-parent = <&gef_pic>;
+				interrupts = <0x9 0x4>;
 				reg = <1>;
 			};
 			phy2: ethernet-phy@2 {
-				interrupt-parent = <&mpic>;
-				interrupts = <0x0 0x1>;
+				interrupt-parent = <&gef_pic>;
+				interrupts = <0x8 0x4>;
 				reg = <3>;
 			};
 		};
diff --git a/arch/powerpc/platforms/86xx/Makefile b/arch/powerpc/platforms/86xx/Makefile
index cb9fc8f..4a56ff6 100644
--- a/arch/powerpc/platforms/86xx/Makefile
+++ b/arch/powerpc/platforms/86xx/Makefile
@@ -7,4 +7,4 @@ obj-$(CONFIG_SMP)		+= mpc86xx_smp.o
 obj-$(CONFIG_MPC8641_HPCN)	+= mpc86xx_hpcn.o
 obj-$(CONFIG_SBC8641D)		+= sbc8641d.o
 obj-$(CONFIG_MPC8610_HPCD)	+= mpc8610_hpcd.o
-obj-$(CONFIG_GEF_SBC610)	+= gef_sbc610.o
+obj-$(CONFIG_GEF_SBC610)	+= gef_sbc610.o gef_pic.o
diff --git a/arch/powerpc/platforms/86xx/gef_pic.c b/arch/powerpc/platforms/86xx/gef_pic.c
new file mode 100644
index 0000000..50d0a2b
--- /dev/null
+++ b/arch/powerpc/platforms/86xx/gef_pic.c
@@ -0,0 +1,258 @@
+/*
+ * Interrupt handling for GE Fanuc's FPGA based PIC
+ *
+ * Author: Martyn Welch <martyn.welch@gefanuc.com>
+ *
+ * 2008 (c) GE Fanuc Intelligent Platforms Embedded Systems, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+
+#include <asm/byteorder.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/irq.h>
+
+#include "gef_pic.h"
+
+#define DEBUG
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(fmt...) do { printk(KERN_DEBUG "gef_pic: " fmt); } while (0)
+#else
+#define DBG(fmt...) do { } while (0)
+#endif
+
+#define GEF_PIC_NUM_IRQS	32
+
+/* Interrupt Controller Interface Registers */
+#define GEF_PIC_INTR_STATUS	0x0000
+
+#define GEF_PIC_INTR_MASK(cpu)	(0x0010 + (0x4 * cpu))
+#define GEF_PIC_CPU0_INTR_MASK	GEF_PIC_INTR_MASK(0)
+#define GEF_PIC_CPU1_INTR_MASK	GEF_PIC_INTR_MASK(1)
+
+#define GEF_PIC_MCP_MASK(cpu)	(0x0018 + (0x4 * cpu))
+#define GEF_PIC_CPU0_MCP_MASK	GEF_PIC_MCP_MASK(0)
+#define GEF_PIC_CPU1_MCP_MASK	GEF_PIC_MCP_MASK(1)
+
+#define gef_irq_to_hw(virq)    ((unsigned int)irq_map[virq].hwirq)
+
+
+static DEFINE_SPINLOCK(gef_pic_lock);
+
+static void __iomem *gef_pic_irq_reg_base;
+static struct irq_host *gef_pic_irq_host;
+static int gef_pic_cascade_irq;
+
+/*
+ * Interrupt Controller Handling
+ *
+ * The interrupt controller handles interrupts for most on board interrupts,
+ * apart from PCI interrupts. For example on SBC610:
+ *
+ * 17:31 RO Reserved
+ * 16    RO PCI Express Doorbell 3 Status
+ * 15    RO PCI Express Doorbell 2 Status
+ * 14    RO PCI Express Doorbell 1 Status
+ * 13    RO PCI Express Doorbell 0 Status
+ * 12    RO Real Time Clock Interrupt Status
+ * 11    RO Temperature Interrupt Status
+ * 10    RO Temperature Critical Interrupt Status
+ * 9     RO Ethernet PHY1 Interrupt Status
+ * 8     RO Ethernet PHY3 Interrupt Status
+ * 7     RO PEX8548 Interrupt Status
+ * 6     RO Reserved
+ * 5     RO Watchdog 0 Interrupt Status
+ * 4     RO Watchdog 1 Interrupt Status
+ * 3     RO AXIS Message FIFO A Interrupt Status
+ * 2     RO AXIS Message FIFO B Interrupt Status
+ * 1     RO AXIS Message FIFO C Interrupt Status
+ * 0     RO AXIS Message FIFO D Interrupt Status
+ *
+ * Interrupts can be forwarded to one of two output lines. Nothing
+ * clever is done, so if the masks are incorrectly set, a single input
+ * interrupt could generate interrupts on both output lines!
+ *
+ * The dual lines are there to allow the chained interrupts to be easily
+ * passed into two different cores. We currently do not use this functionality
+ * in this driver.
+ *
+ * Controller can also be configured to generate Machine checks (MCP), again on
+ * two lines, to be attached to two different cores. It is suggested that these
+ * should be masked out.
+ */
+
+void gef_pic_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned int cascade_irq;
+
+	/*
+	 * See if we actually have an interrupt, call generic handling code if
+	 * we do.
+	 */
+	cascade_irq = gef_pic_get_irq();
+
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq);
+
+	desc->chip->eoi(irq);
+
+}
+
+static void gef_pic_mask(unsigned int virq)
+{
+	unsigned long flags;
+	unsigned int hwirq;
+	u32 mask;
+
+	hwirq = gef_irq_to_hw(virq);
+
+	spin_lock_irqsave(&gef_pic_lock, flags);
+	mask = in_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_MASK(0));
+	mask &= ~(1 << hwirq);
+	out_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_MASK(0), mask);
+	spin_unlock_irqrestore(&gef_pic_lock, flags);
+}
+
+static void gef_pic_mask_ack(unsigned int virq)
+{
+	/* Don't think we actually have to do anything to ack an interrupt,
+	 * we just need to clear down the devices interrupt and it will go away
+	 */
+	gef_pic_mask(virq);
+}
+
+static void gef_pic_unmask(unsigned int virq)
+{
+	unsigned long flags;
+	unsigned int hwirq;
+	u32 mask;
+
+	hwirq = gef_irq_to_hw(virq);
+
+	spin_lock_irqsave(&gef_pic_lock, flags);
+	mask = in_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_MASK(0));
+	mask |= (1 << hwirq);
+	out_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_MASK(0), mask);
+	spin_unlock_irqrestore(&gef_pic_lock, flags);
+}
+
+static struct irq_chip gef_pic_chip = {
+	.typename	= "gefp",
+	.mask		= gef_pic_mask,
+	.mask_ack	= gef_pic_mask_ack,
+	.unmask		= gef_pic_unmask,
+};
+
+
+/* When an interrupt is being configured, this call allows some flexibilty
+ * in deciding which irq_chip structure is used
+ */
+static int gef_pic_host_map(struct irq_host *h, unsigned int virq,
+			  irq_hw_number_t hwirq)
+{
+	/* All interrupts are LEVEL sensitive */
+	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	set_irq_chip_and_handler(virq, &gef_pic_chip, handle_level_irq);
+
+	return 0;
+}
+
+static int gef_pic_host_xlate(struct irq_host *h, struct device_node *ct,
+			    u32 *intspec, unsigned int intsize,
+			    irq_hw_number_t *out_hwirq, unsigned int *out_flags)
+{
+
+	*out_hwirq = intspec[0];
+	if (intsize > 1)
+		*out_flags = intspec[1];
+	else
+		*out_flags = IRQ_TYPE_LEVEL_HIGH;
+
+	return 0;
+}
+
+static struct irq_host_ops gef_pic_host_ops = {
+	.map	= gef_pic_host_map,
+	.xlate	= gef_pic_host_xlate,
+};
+
+
+/*
+ * Initialisation of PIC, this should be called in BSP
+ */
+void __init gef_pic_init(struct device_node *np)
+{
+	unsigned long flags;
+
+	/* Map the devices registers into memory */
+	gef_pic_irq_reg_base = of_iomap(np, 0);
+
+	spin_lock_irqsave(&gef_pic_lock, flags);
+
+	/* Initialise everything as masked. */
+	out_be32(gef_pic_irq_reg_base + GEF_PIC_CPU0_INTR_MASK, 0);
+	out_be32(gef_pic_irq_reg_base + GEF_PIC_CPU1_INTR_MASK, 0);
+
+	out_be32(gef_pic_irq_reg_base + GEF_PIC_CPU0_MCP_MASK, 0);
+	out_be32(gef_pic_irq_reg_base + GEF_PIC_CPU1_MCP_MASK, 0);
+
+	spin_unlock_irqrestore(&gef_pic_lock, flags);
+
+	/* Map controller */
+	gef_pic_cascade_irq = irq_of_parse_and_map(np, 0);
+	if (gef_pic_cascade_irq == NO_IRQ) {
+		printk(KERN_ERR "SBC610: failed to map cascade interrupt");
+		return;
+	}
+
+	/* Setup an irq_host structure */
+	gef_pic_irq_host = irq_alloc_host(np, IRQ_HOST_MAP_LINEAR,
+					  GEF_PIC_NUM_IRQS,
+					  &gef_pic_host_ops, NO_IRQ);
+	if (gef_pic_irq_host == NULL)
+		return;
+
+	/* Chain with parent controller */
+	set_irq_chained_handler(gef_pic_cascade_irq, gef_pic_cascade);
+}
+
+/*
+ * This is called when we receive an interrupt with apparently comes from this
+ * chip - check, returning the highest interrupt generated or return NO_IRQ
+ */
+unsigned int gef_pic_get_irq(void)
+{
+	u32 cause, mask, active;
+	unsigned int virq = NO_IRQ;
+	int hwirq;
+
+	cause = in_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_STATUS);
+
+	mask = in_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_MASK(0));
+
+	active = cause & mask;
+
+	if (active) {
+		for (hwirq = GEF_PIC_NUM_IRQS - 1; hwirq > -1; hwirq--) {
+			if (active & (0x1 << hwirq))
+				break;
+		}
+		virq = irq_linear_revmap(gef_pic_irq_host,
+			(irq_hw_number_t)hwirq);
+	}
+
+	return virq;
+}
+
diff --git a/arch/powerpc/platforms/86xx/gef_pic.h b/arch/powerpc/platforms/86xx/gef_pic.h
new file mode 100644
index 0000000..6149916
--- /dev/null
+++ b/arch/powerpc/platforms/86xx/gef_pic.h
@@ -0,0 +1,11 @@
+#ifndef __GEF_PIC_H__
+#define __GEF_PIC_H__
+
+#include <linux/init.h>
+
+void gef_pic_cascade(unsigned int, struct irq_desc *);
+unsigned int gef_pic_get_irq(void);
+void gef_pic_init(struct device_node *);
+
+#endif /* __GEF_PIC_H__ */
+
diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
index 605678c..6bc63a9 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc610.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -39,6 +39,7 @@
 #include <sysdev/fsl_soc.h>
 
 #include "mpc86xx.h"
+#include "gef_pic.h"
 
 #undef DEBUG
 
@@ -48,6 +49,28 @@
 #define DBG (fmt...) do { } while (0)
 #endif
 
+void __iomem *sbc610_regs;
+
+static void __init gef_sbc610_init_irq(void)
+{
+	struct device_node *cascade_node = NULL;
+
+	mpc86xx_init_irq();
+
+	/*
+	 * There is a simple interrupt handler in the main FPGA, this needs
+	 * to be cascaded into the MPIC
+	 */
+	cascade_node = of_find_compatible_node(NULL, NULL, "gef,fpga-pic");
+	if (!cascade_node) {
+		printk(KERN_WARNING "SBC610: No FPGA PIC\n");
+		return;
+	}
+
+	gef_pic_init(cascade_node);
+	of_node_put(cascade_node);
+}
+
 static void __init gef_sbc610_setup_arch(void)
 {
 #ifdef CONFIG_PCI
@@ -153,7 +176,7 @@ define_machine(gef_sbc610) {
 	.name			= "GE Fanuc SBC610",
 	.probe			= gef_sbc610_probe,
 	.setup_arch		= gef_sbc610_setup_arch,
-	.init_IRQ		= mpc86xx_init_irq,
+	.init_IRQ		= gef_sbc610_init_irq,
 	.show_cpuinfo		= gef_sbc610_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
 	.restart		= fsl_rstcr_restart,
