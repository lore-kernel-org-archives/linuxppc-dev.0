Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (unknown [85.94.3.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 68241DDF95
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 15:50:57 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 1/3] POWERPC] cpm2: CPM2 interrupt controller fix
Date: Wed, 31 Jan 2007 07:50:39 +0300
Message-ID: <20070131045038.22890.5108.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This contains important fixes for the CPM2 PIC code. Eliminated
CPM_IRQ_OFFSET, pulling the respective interrupt numbers from the interrupt
mapping. Updated devicetree files to reflect that. Changed direct
IC-related IO accesses to the IO accessors. Fixed all the sense values to
keep coherency with ipic. In the current code, CPM2 stuff will have no IRQs
and hence could be hardly usable.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/powerpc/boot/dts/mpc8272ads.dts |   40 +++++----
 arch/powerpc/boot/dts/mpc8560ads.dts |   10 +-
 arch/powerpc/sysdev/cpm2_pic.c       |  150 ++++++++++++++++++++--------------
 arch/powerpc/sysdev/cpm2_pic.h       |    2 
 include/asm-powerpc/mpc8260.h        |   24 +++++
 5 files changed, 138 insertions(+), 88 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 34efdd0..8bbc8fa 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -71,7 +71,7 @@
                        ethernet-phy@0 {
                                linux,phandle = <2452000>;
                                interrupt-parent = <10c00>;
-                               interrupts = <19 1>;
+                               interrupts = <17 4>;
                                reg = <0>;
                                bitbang = [ 12 12 13 02 02 01 ];
                                device_type = "ethernet-phy";
@@ -79,7 +79,7 @@
                        ethernet-phy@1 {
                                linux,phandle = <2452001>;
                                interrupt-parent = <10c00>;
-                               interrupts = <19 1>;
+                               interrupts = <17 4>;
                                bitbang = [ 12 12 13 02 02 01 ];
                                reg = <3>;
                                device_type = "ethernet-phy";
@@ -90,7 +90,7 @@
                        #address-cells = <1>;
                        #size-cells = <0>;
                        device_type = "network";
-                       device-id = <2>;
+                       device-id = <1>;
                        compatible = "fs_enet";
                        model = "FCC";
                        reg = <11300 20 8400 100 11380 30>;
@@ -104,7 +104,7 @@
 
                ethernet@25000 {
                        device_type = "network";
-                       device-id = <3>;
+                       device-id = <2>;
                        compatible = "fs_enet";
                        model = "FCC";
                        reg = <11320 20 8500 100 113b0 30>;
@@ -133,7 +133,7 @@
                                device_type = "serial";
                                compatible = "cpm_uart";
                                model = "SCC";
-                               device-id = <2>;
+                               device-id = <1>;
                                reg = <11a00 20 8000 100>;
                                current-speed = <1c200>;
                                interrupts = <28 2>;
@@ -147,7 +147,7 @@
                                device_type = "serial";
                                compatible = "cpm_uart";
                                model = "SCC";
-                               device-id = <5>;
+                               device-id = <4>;
                                reg = <11a60 20 8300 100>;
                                current-speed = <1c200>;
                                interrupts = <2b 2>;
@@ -181,24 +181,24 @@
                        interrupt-map = <
 
                                        /* IDSEL 0x16 */
-                                        b000 0 0 1 f8200000 40 0
-                                        b000 0 0 2 f8200000 41 0
-                                        b000 0 0 3 f8200000 42 0
-                                        b000 0 0 4 f8200000 43 0
+                                        b000 0 0 1 f8200000 40 8
+                                        b000 0 0 2 f8200000 41 8
+                                        b000 0 0 3 f8200000 42 8
+                                        b000 0 0 4 f8200000 43 8
 
                                        /* IDSEL 0x17 */
-                                        b800 0 0 1 f8200000 43 0
-                                        b800 0 0 2 f8200000 40 0
-                                        b800 0 0 3 f8200000 41 0
-                                        b800 0 0 4 f8200000 42 0
+                                        b800 0 0 1 f8200000 43 8
+                                        b800 0 0 2 f8200000 40 8
+                                        b800 0 0 3 f8200000 41 8
+                                        b800 0 0 4 f8200000 42 8
 
                                        /* IDSEL 0x18 */
-                                        c000 0 0 1 f8200000 42 0
-                                        c000 0 0 2 f8200000 43 0
-                                        c000 0 0 3 f8200000 40 0
-                                        c000 0 0 4 f8200000 41 0>;
+                                        c000 0 0 1 f8200000 42 8
+                                        c000 0 0 2 f8200000 43 8
+                                        c000 0 0 3 f8200000 40 8
+                                        c000 0 0 4 f8200000 41 8>;
                        interrupt-parent = <10c00>;
-                       interrupts = <14 3>;
+                       interrupts = <14 8>;
                        bus-range = <0 0>;
                        ranges = <02000000 0 80000000 80000000 0 40000000
                                  01000000 0 00000000 f6000000 0 02000000>;
@@ -210,7 +210,7 @@
                        model = "SEC2";
                        compatible = "talitos";
                        reg = <30000 10000>;
-                       interrupts = <b 0>;
+                       interrupts = <b 2>;
                        interrupt-parent = <10c00>;
                        num-channels = <4>;
                        channel-fifo-len = <18>;
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 2b16848..119bd5d 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -200,7 +200,7 @@
 					 a800 0 0 4 40000 31 1>;
 
 			interrupt-parent = <40000>;
-			interrupts = <42 0>;
+			interrupts = <8 0>;
 			bus-range = <0 0>;
 			ranges = <02000000 0 80000000 80000000 0 20000000
 				  01000000 0 00000000 e2000000 0 01000000>;
@@ -250,7 +250,7 @@
 				rx-clock = <1>;
 				tx-clock = <1>;
 				current-speed = <1c200>;
-				interrupts = <64 1>;
+				interrupts = <28 8>;
 				interrupt-parent = <90c00>;
 			};
 
@@ -264,7 +264,7 @@
 				rx-clock = <2>;
 				tx-clock = <2>;
 				current-speed = <1c200>;
-				interrupts = <65 1>;
+				interrupts = <29 8>;
 				interrupt-parent = <90c00>;
 			};
 
@@ -278,7 +278,7 @@
 				clock-setup = <ff00ffff 250000>;
 				rx-clock = <15>;
 				tx-clock = <16>;
-				interrupts = <5d 1>;
+				interrupts = <21 8>;
 				interrupt-parent = <90c00>;
 				phy-handle = <2452002>;
 			};
@@ -293,7 +293,7 @@
 				clock-setup = <ffff00ff 3700>;
 				rx-clock = <17>;
 				tx-clock = <18>;
-				interrupts = <5e 1>;
+				interrupts = <22 8>;
 				interrupt-parent = <90c00>;
 				phy-handle = <2452003>;
 			};
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index e2739eb..bac7573 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -36,9 +36,20 @@
 #include <asm/mpc8260.h>
 #include <asm/io.h>
 #include <asm/prom.h>
+#include <asm/fs_pd.h>
 
 #include "cpm2_pic.h"
 
+/* External IRQS */
+#define CPM2_IRQ_EXT1		19
+#define CPM2_IRQ_EXT7		25
+
+/* Port C IRQS */
+#define CPM2_IRQ_PORTC15	48
+#define CPM2_IRQ_PORTC0		63
+
+static intctl_cpm2_t *cpm2_intctl;
+
 static struct device_node *cpm2_pic_node;
 static struct irq_host *cpm2_pic_host;
 #define NR_MASK_WORDS   ((NR_IRQS + 31) / 32)
@@ -68,68 +79,55 @@ static const u_char irq_to_siubit[] = {
 	24, 25, 26, 27, 28, 29, 30, 31,
 };
 
-static void cpm2_mask_irq(unsigned int irq_nr)
+static void cpm2_mask_irq(unsigned int virq)
 {
 	int	bit, word;
-	volatile uint	*simr;
-
-	irq_nr -= CPM_IRQ_OFFSET;
+	unsigned int irq_nr = virq_to_hw(virq);
 
 	bit = irq_to_siubit[irq_nr];
 	word = irq_to_siureg[irq_nr];
 
-	simr = &(cpm2_intctl->ic_simrh);
 	ppc_cached_irq_mask[word] &= ~(1 << bit);
-	simr[word] = ppc_cached_irq_mask[word];
+	out_be32(&cpm2_intctl->ic_simrh + word, ppc_cached_irq_mask[word]);
 }
 
-static void cpm2_unmask_irq(unsigned int irq_nr)
+static void cpm2_unmask_irq(unsigned int virq)
 {
 	int	bit, word;
-	volatile uint	*simr;
-
-	irq_nr -= CPM_IRQ_OFFSET;
+	unsigned int irq_nr = virq_to_hw(virq);
 
 	bit = irq_to_siubit[irq_nr];
 	word = irq_to_siureg[irq_nr];
 
-	simr = &(cpm2_intctl->ic_simrh);
 	ppc_cached_irq_mask[word] |= 1 << bit;
-	simr[word] = ppc_cached_irq_mask[word];
+	out_be32(&cpm2_intctl->ic_simrh + word, ppc_cached_irq_mask[word]);
 }
 
-static void cpm2_mask_and_ack(unsigned int irq_nr)
+static void cpm2_ack(unsigned int virq)
 {
 	int	bit, word;
-	volatile uint	*simr, *sipnr;
-
-	irq_nr -= CPM_IRQ_OFFSET;
+	unsigned int irq_nr = virq_to_hw(virq);
 
 	bit = irq_to_siubit[irq_nr];
 	word = irq_to_siureg[irq_nr];
 
-	simr = &(cpm2_intctl->ic_simrh);
-	sipnr = &(cpm2_intctl->ic_sipnrh);
-	ppc_cached_irq_mask[word] &= ~(1 << bit);
-	simr[word] = ppc_cached_irq_mask[word];
-	sipnr[word] = 1 << bit;
+	out_be32(&cpm2_intctl->ic_sipnrh + word, 1 << bit);
 }
 
-static void cpm2_end_irq(unsigned int irq_nr)
+static void cpm2_end_irq(unsigned int virq)
 {
 	int	bit, word;
-	volatile uint	*simr;
+	unsigned int irq_nr = virq_to_hw(virq);
 
 	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
 			&& irq_desc[irq_nr].action) {
 
-		irq_nr -= CPM_IRQ_OFFSET;
 		bit = irq_to_siubit[irq_nr];
 		word = irq_to_siureg[irq_nr];
 
-		simr = &(cpm2_intctl->ic_simrh);
 		ppc_cached_irq_mask[word] |= 1 << bit;
-		simr[word] = ppc_cached_irq_mask[word];
+		out_be32(&cpm2_intctl->ic_simrh + word, ppc_cached_irq_mask[word]);
+
 		/*
 		 * Work around large numbers of spurious IRQs on PowerPC 82xx
 		 * systems.
@@ -138,13 +136,59 @@ static void cpm2_end_irq(unsigned int irq_nr)
 	}
 }
 
+static int cpm2_set_irq_type(unsigned int virq, unsigned int flow_type)
+{
+	unsigned int src = virq_to_hw(virq);
+	struct irq_desc *desc = get_irq_desc(virq);
+	unsigned int vold, vnew, edibit;
+
+	if (flow_type == IRQ_TYPE_NONE)
+		flow_type = IRQ_TYPE_LEVEL_LOW;
+
+	if (flow_type & IRQ_TYPE_EDGE_RISING) {
+		printk(KERN_ERR "CPM2 PIC: sense type 0x%x not supported\n",
+			flow_type);
+		return -EINVAL;
+	}
+
+	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
+	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
+	if (flow_type & IRQ_TYPE_LEVEL_LOW)  {
+		desc->status |= IRQ_LEVEL;
+		desc->handle_irq = handle_level_irq;
+	} else
+		desc->handle_irq = handle_edge_irq;
+
+	/* internal IRQ senses are LEVEL_LOW
+	 * EXT IRQ and Port C IRQ senses are programmable
+	 */
+	if (src >= CPM2_IRQ_EXT1 && src <= CPM2_IRQ_EXT7)
+			edibit = (14 - (src - CPM2_IRQ_EXT1));
+	else
+		if (src >= CPM2_IRQ_PORTC15 && src <= CPM2_IRQ_PORTC0)
+			edibit = (31 - (src - CPM2_IRQ_PORTC15));
+		else
+			return (flow_type & IRQ_TYPE_LEVEL_LOW) ? 0 : -EINVAL;
+
+	vold = in_be32(&cpm2_intctl->ic_siexr);
+
+	if ((flow_type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_FALLING)
+		vnew = vold | (1 << edibit);
+	else
+		vnew = vold & ~(1 << edibit);
+
+	if (vold != vnew)
+		out_be32(&cpm2_intctl->ic_siexr, vnew);
+	return 0;
+}
+
 static struct irq_chip cpm2_pic = {
 	.typename = " CPM2 SIU ",
-	.enable = cpm2_unmask_irq,
-	.disable = cpm2_mask_irq,
+	.mask = cpm2_mask_irq,
 	.unmask = cpm2_unmask_irq,
-	.mask_ack = cpm2_mask_and_ack,
-	.end = cpm2_end_irq,
+	.ack = cpm2_ack,
+	.eoi = cpm2_end_irq,
+	.set_type = cpm2_set_irq_type,
 };
 
 unsigned int cpm2_get_irq(void)
@@ -154,17 +198,17 @@ unsigned int cpm2_get_irq(void)
 
        /* For CPM2, read the SIVEC register and shift the bits down
          * to get the irq number.         */
-        bits = cpm2_intctl->ic_sivec;
+        bits = in_be32(&cpm2_intctl->ic_sivec);
         irq = bits >> 26;
 
 	if (irq == 0)
 		return(-1);
-	return irq+CPM_IRQ_OFFSET;
+	return irq_linear_revmap(cpm2_pic_host, irq);
 }
 
 static int cpm2_pic_host_match(struct irq_host *h, struct device_node *node)
 {
-	return cpm2_pic_node == NULL || cpm2_pic_node == node;
+	return cpm2_pic_node == node;
 }
 
 static int cpm2_pic_host_map(struct irq_host *h, unsigned int virq,
@@ -177,45 +221,29 @@ static int cpm2_pic_host_map(struct irq_host *h, unsigned int virq,
 	return 0;
 }
 
-static void cpm2_host_unmap(struct irq_host *h, unsigned int virq)
-{
-	/* Make sure irq is masked in hardware */
-	cpm2_mask_irq(virq);
-
-	/* remove chip and handler */
-	set_irq_chip_and_handler(virq, NULL, NULL);
-}
-
 static int cpm2_pic_host_xlate(struct irq_host *h, struct device_node *ct,
 			    u32 *intspec, unsigned int intsize,
 			    irq_hw_number_t *out_hwirq, unsigned int *out_flags)
 {
-	static const unsigned char map_cpm2_senses[4] = {
-		IRQ_TYPE_LEVEL_LOW,
-		IRQ_TYPE_LEVEL_HIGH,
-		IRQ_TYPE_EDGE_FALLING,
-		IRQ_TYPE_EDGE_RISING,
-	};
-
 	*out_hwirq = intspec[0];
-	if (intsize > 1 && intspec[1] < 4)
-		*out_flags = map_cpm2_senses[intspec[1]];
+	if (intsize > 1)
+		*out_flags = intspec[1];
 	else
 		*out_flags = IRQ_TYPE_NONE;
-
 	return 0;
 }
 
 static struct irq_host_ops cpm2_pic_host_ops = {
 	.match = cpm2_pic_host_match,
 	.map = cpm2_pic_host_map,
-	.unmap = cpm2_host_unmap,
 	.xlate = cpm2_pic_host_xlate,
 };
 
 void cpm2_pic_init(struct device_node *node)
 {
 	int i;
+	
+	cpm2_intctl = cpm2_map(im_intctl);
 
 	/* Clear the CPM IRQ controller, in case it has any bits set
 	 * from the bootloader
@@ -223,26 +251,26 @@ void cpm2_pic_init(struct device_node *node)
 
 	/* Mask out everything */
 
-	cpm2_intctl->ic_simrh = 0x00000000;
-	cpm2_intctl->ic_simrl = 0x00000000;
+	out_be32(&cpm2_intctl->ic_simrh, 0x00000000);
+	out_be32(&cpm2_intctl->ic_simrl, 0x00000000);
 
 	wmb();
 
 	/* Ack everything */
-	cpm2_intctl->ic_sipnrh = 0xffffffff;
-	cpm2_intctl->ic_sipnrl = 0xffffffff;
+	out_be32(&cpm2_intctl->ic_sipnrh, 0xffffffff);
+	out_be32(&cpm2_intctl->ic_sipnrl, 0xffffffff);
 	wmb();
 
 	/* Dummy read of the vector */
-	i = cpm2_intctl->ic_sivec;
+	i = in_be32(&cpm2_intctl->ic_sivec);
 	rmb();
 
 	/* Initialize the default interrupt mapping priorities,
 	 * in case the boot rom changed something on us.
 	 */
-	cpm2_intctl->ic_sicr = 0;
-	cpm2_intctl->ic_scprrh = 0x05309770;
-	cpm2_intctl->ic_scprrl = 0x05309770;
+	out_be16(&cpm2_intctl->ic_sicr, 0);
+	out_be32(&cpm2_intctl->ic_scprrh, 0x05309770);
+	out_be32(&cpm2_intctl->ic_scprrl, 0x05309770);
 
 	/* create a legacy host */
 	cpm2_pic_node = of_node_get(node);
diff --git a/arch/powerpc/sysdev/cpm2_pic.h b/arch/powerpc/sysdev/cpm2_pic.h
index 2840616..30e5828 100644
--- a/arch/powerpc/sysdev/cpm2_pic.h
+++ b/arch/powerpc/sysdev/cpm2_pic.h
@@ -1,8 +1,6 @@
 #ifndef _PPC_KERNEL_CPM2_H
 #define _PPC_KERNEL_CPM2_H
 
-extern intctl_cpm2_t *cpm2_intctl;
-
 extern unsigned int cpm2_get_irq(void);
 
 extern void cpm2_pic_init(struct device_node*);
diff --git a/include/asm-powerpc/mpc8260.h b/include/asm-powerpc/mpc8260.h
new file mode 100644
index 0000000..f1b83b0
--- /dev/null
+++ b/include/asm-powerpc/mpc8260.h
@@ -0,0 +1,24 @@
+/*
+ * Since there are many different boards and no standard configuration,
+ * we have a unique include file for each.  Rather than change every
+ * file that has to include MPC8260 configuration, they all include
+ * this one and the configuration switching is done here.
+ */
+#ifdef __KERNEL__
+#ifndef __ASM_PPC_MPC8260_H__
+#define __ASM_PPC_MPC8260_H__
+
+
+#ifdef CONFIG_8260
+
+#if defined(CONFIG_PQ2ADS) || defined (CONFIG_PQ2FADS)
+#include <platforms/82xx/pq2ads.h>
+#endif
+
+#ifdef CONFIG_PCI_8260
+#include <platforms/82xx/m82xx_pci.h>
+#endif
+
+#endif /* CONFIG_8260 */
+#endif /* !__ASM_PPC_MPC8260_H__ */
+#endif /* __KERNEL__ */
