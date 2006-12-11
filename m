Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-44-175.msk.skylink.ru
	[83.217.44.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80C2C67D19
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 10:21:12 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 1/4] [POWERPC] cpm2: Updates for CPM2 pic
Date: Tue, 12 Dec 2006 01:36:59 +0300
Message-Id: <20061211223659.20169.50415.stgit@localhost.localdomain>
In-Reply-To: <20061212012641.5ef493f7@localhost.localdomain>
References: <20061212012641.5ef493f7@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
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
IC-related IO accesses to the IO accessors.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/powerpc/boot/dts/mpc8560ads.dts |    8 ++-
 arch/powerpc/sysdev/cpm2_pic.c       |   78 ++++++++++++----------------------
 2 files changed, 31 insertions(+), 55 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 2b16848..3c1e44a 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -250,7 +250,7 @@
 				rx-clock = <1>;
 				tx-clock = <1>;
 				current-speed = <1c200>;
-				interrupts = <64 1>;
+				interrupts = <28 1>;
 				interrupt-parent = <90c00>;
 			};
 
@@ -264,7 +264,7 @@
 				rx-clock = <2>;
 				tx-clock = <2>;
 				current-speed = <1c200>;
-				interrupts = <65 1>;
+				interrupts = <29 1>;
 				interrupt-parent = <90c00>;
 			};
 
@@ -278,7 +278,7 @@
 				clock-setup = <ff00ffff 250000>;
 				rx-clock = <15>;
 				tx-clock = <16>;
-				interrupts = <5d 1>;
+				interrupts = <21 1>;
 				interrupt-parent = <90c00>;
 				phy-handle = <2452002>;
 			};
@@ -293,7 +293,7 @@
 				clock-setup = <ffff00ff 3700>;
 				rx-clock = <17>;
 				tx-clock = <18>;
-				interrupts = <5e 1>;
+				interrupts = <22 1>;
 				interrupt-parent = <90c00>;
 				phy-handle = <2452003>;
 			};
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index 767ee66..46fb0a2 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -68,68 +68,55 @@ static const u_char irq_to_siubit[] = {
 	24, 25, 26, 27, 28, 29, 30, 31,
 };
 
-static void cpm2_mask_irq(unsigned int irq_nr)
+static void cpm2_mask_irq(unsigned int irq)
 {
 	int	bit, word;
-	volatile uint	*simr;
-
-	irq_nr -= CPM_IRQ_OFFSET;
+	unsigned int irq_nr = (unsigned int)irq_map[irq].hwirq;
 
 	bit = irq_to_siubit[irq_nr];
 	word = irq_to_siureg[irq_nr];
 
-	simr = &(cpm2_intctl->ic_simrh);
 	ppc_cached_irq_mask[word] &= ~(1 << bit);
-	simr[word] = ppc_cached_irq_mask[word];
+	out_be32(&cpm2_intctl->ic_simrh + word, ppc_cached_irq_mask[word]);
 }
 
-static void cpm2_unmask_irq(unsigned int irq_nr)
+static void cpm2_unmask_irq(unsigned int irq)
 {
 	int	bit, word;
-	volatile uint	*simr;
-
-	irq_nr -= CPM_IRQ_OFFSET;
+	unsigned int irq_nr = (unsigned int)irq_map[irq].hwirq;
 
 	bit = irq_to_siubit[irq_nr];
 	word = irq_to_siureg[irq_nr];
 
-	simr = &(cpm2_intctl->ic_simrh);
 	ppc_cached_irq_mask[word] |= 1 << bit;
-	simr[word] = ppc_cached_irq_mask[word];
+	out_be32(&cpm2_intctl->ic_simrh + word, ppc_cached_irq_mask[word]);
 }
 
-static void cpm2_mask_and_ack(unsigned int irq_nr)
+static void cpm2_ack(unsigned int irq)
 {
 	int	bit, word;
-	volatile uint	*simr, *sipnr;
-
-	irq_nr -= CPM_IRQ_OFFSET;
+	unsigned int irq_nr = (unsigned int)irq_map[irq].hwirq;
 
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
+static void cpm2_end_irq(unsigned int irq)
 {
 	int	bit, word;
-	volatile uint	*simr;
+	unsigned int irq_nr = (unsigned int)irq_map[irq].hwirq;
 
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
@@ -140,11 +127,10 @@ static void cpm2_end_irq(unsigned int ir
 
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
 };
 
 unsigned int cpm2_get_irq(void)
@@ -154,17 +140,17 @@ unsigned int cpm2_get_irq(void)
 
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
@@ -177,15 +163,6 @@ static int cpm2_pic_host_map(struct irq_
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
@@ -209,7 +186,6 @@ static int cpm2_pic_host_xlate(struct ir
 static struct irq_host_ops cpm2_pic_host_ops = {
 	.match = cpm2_pic_host_match,
 	.map = cpm2_pic_host_map,
-	.unmap = cpm2_host_unmap,
 	.xlate = cpm2_pic_host_xlate,
 };
 
@@ -223,26 +199,26 @@ void cpm2_pic_init(struct device_node *n
 
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
 	if (node)
