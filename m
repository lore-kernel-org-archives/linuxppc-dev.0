Return-Path: <jchapman@katalix.com>
Received: from ptb-relay03.plus.net (ptb-relay03.plus.net [212.159.14.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2BA067A85
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Feb 2005 20:36:52 +1100 (EST)
Message-ID: <421DA02E.1000309@katalix.com>
Date: Thu, 24 Feb 2005 09:36:46 +0000
From: James Chapman <jchapman@katalix.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <421CED8F.6040300@katalix.com>
In-Reply-To: <421CED8F.6040300@katalix.com>
Content-Type: multipart/mixed; boundary="------------030708080005090108040900"
Subject: Re: PATCH: fix mv64360 pic code to handle non-zero mv64x60_irq_base
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030708080005090108040900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Resubmitting mv64360_pic patch with fixed whitespace in my 
mv64x60_defs.h change.

James Chapman wrote:

> New version of patch addressing Mark Greer's comments.
> 
> - Fix mv64360 pic code to handle non-zero mv64x60_irq_base
> - Cleanup mv64360 entries in /proc/interrupts
> 
> Signed-off-by: James Chapman <jchapman@katalix.com>
> 

--------------030708080005090108040900
Content-Type: text/plain;
 name="mv64360_pic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mv64360_pic.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/23 16:01:12+00:00 jchapman@katalix.com 
#   Fix mv64360 pic to handle non-zero IRQ offset.
#   Cleanup /proc/interrupts.
# 
# include/asm-ppc/mv64x60_defs.h
#   2005/02/23 16:01:02+00:00 jchapman@katalix.com +1 -0
#   Add #define for doorbell interrupt bit value (28).
# 
# arch/ppc/syslib/mv64360_pic.c
#   2005/02/23 16:01:02+00:00 jchapman@katalix.com +17 -12
#   Cleanup /proc/interrupts output to make mv64360 entries line up.
#   Use #define for dorrbell interrupt bit (28).
#   Fix several bugs to do with non-zero mv64360_irq_base.
# 
diff -Nru a/arch/ppc/syslib/mv64360_pic.c b/arch/ppc/syslib/mv64360_pic.c
--- a/arch/ppc/syslib/mv64360_pic.c	2005-02-23 16:07:02 +00:00
+++ b/arch/ppc/syslib/mv64360_pic.c	2005-02-23 16:07:02 +00:00
@@ -64,7 +64,7 @@
 /* ========================== local declarations =========================== */
 
 struct hw_interrupt_type mv64360_pic = {
-	.typename = " mv64360_pic ",
+	.typename = " mv64360  ",
 	.enable   = mv64360_unmask_irq,
 	.disable  = mv64360_mask_irq,
 	.ack      = mv64360_mask_irq,
@@ -155,9 +155,10 @@
 	 */
 	int cpu_nr = smp_processor_id();
 	if (cpu_nr == 1) {
-		if (!(mv64x60_read(&bh, MV64360_IC_MAIN_CAUSE_LO) & (1 << 28)))
+		if (!(mv64x60_read(&bh, MV64360_IC_MAIN_CAUSE_LO) & 
+		      (1 << MV64x60_IRQ_DOORBELL)))
 			return -1;
-		return 28;
+		return mv64360_irq_base + MV64x60_IRQ_DOORBELL;
 	}
 #endif
 
@@ -171,7 +172,7 @@
 		if (irq == -1)
 			irq = -2; /* bogus interrupt, should never happen */
 		else {
-			if ((irq >= 24) && (irq < 28)) {
+			if ((irq >= 24) && (irq < MV64x60_IRQ_DOORBELL)) {
 				irq_gpp = mv64x60_read(&bh,
 					MV64x60_GPP_INTR_CAUSE);
 				irq_gpp = __ilog2(irq_gpp &
@@ -217,8 +218,9 @@
 {
 #ifdef CONFIG_SMP
 	/* second CPU gets only doorbell interrupts */
-	if ((irq - mv64360_irq_base) == 28) {
-		mv64x60_set_bits(&bh, MV64360_IC_CPU1_INTR_MASK_LO, (1 << 28));
+	if ((irq - mv64360_irq_base) == MV64x60_IRQ_DOORBELL) {
+		mv64x60_set_bits(&bh, MV64360_IC_CPU1_INTR_MASK_LO, 
+				 (1 << MV64x60_IRQ_DOORBELL));
 		return;
 	}
 #endif
@@ -257,8 +259,9 @@
 mv64360_mask_irq(unsigned int irq)
 {
 #ifdef CONFIG_SMP
-	if ((irq - mv64360_irq_base) == 28) {
-		mv64x60_clr_bits(&bh, MV64360_IC_CPU1_INTR_MASK_LO, (1 << 28));
+	if ((irq - mv64360_irq_base) == MV64x60_IRQ_DOORBELL) {
+		mv64x60_clr_bits(&bh, MV64360_IC_CPU1_INTR_MASK_LO, 
+				 (1 << MV64x60_IRQ_DOORBELL));
 		return;
 	}
 #endif
@@ -371,7 +374,7 @@
 
 	/* Clear old errors and register CPU interface error intr handler */
 	mv64x60_write(&bh, MV64x60_CPU_ERR_CAUSE, 0);
-	if ((rc = request_irq(MV64x60_IRQ_CPU_ERR,
+	if ((rc = request_irq(MV64x60_IRQ_CPU_ERR + mv64360_irq_base,
 		mv64360_cpu_error_int_handler, SA_INTERRUPT, CPU_INTR_STR, 0)))
 		printk(KERN_WARNING "Can't register cpu error handler: %d", rc);
 
@@ -380,7 +383,7 @@
 
 	/* Clear old errors and register internal SRAM error intr handler */
 	mv64x60_write(&bh, MV64360_SRAM_ERR_CAUSE, 0);
-	if ((rc = request_irq(MV64360_IRQ_SRAM_PAR_ERR,
+	if ((rc = request_irq(MV64360_IRQ_SRAM_PAR_ERR + mv64360_irq_base,
 		mv64360_sram_error_int_handler,SA_INTERRUPT,SRAM_INTR_STR, 0)))
 		printk(KERN_WARNING "Can't register SRAM error handler: %d",rc);
 
@@ -397,7 +400,8 @@
 
 	/* Clear old errors and register PCI 0 error intr handler */
 	mv64x60_write(&bh, MV64x60_PCI0_ERR_CAUSE, 0);
-	if ((rc = request_irq(MV64360_IRQ_PCI0, mv64360_pci_error_int_handler,
+	if ((rc = request_irq(MV64360_IRQ_PCI0 + mv64360_irq_base, 
+			mv64360_pci_error_int_handler,
 			SA_INTERRUPT, PCI0_INTR_STR, (void *)0)))
 		printk(KERN_WARNING "Can't register pci 0 error handler: %d",
 			rc);
@@ -407,7 +411,8 @@
 
 	/* Clear old errors and register PCI 1 error intr handler */
 	mv64x60_write(&bh, MV64x60_PCI1_ERR_CAUSE, 0);
-	if ((rc = request_irq(MV64360_IRQ_PCI1, mv64360_pci_error_int_handler,
+	if ((rc = request_irq(MV64360_IRQ_PCI1 + mv64360_irq_base, 
+			mv64360_pci_error_int_handler,
 			SA_INTERRUPT, PCI1_INTR_STR, (void *)1)))
 		printk(KERN_WARNING "Can't register pci 1 error handler: %d",
 			rc);
diff -Nru a/include/asm-ppc/mv64x60_defs.h b/include/asm-ppc/mv64x60_defs.h
--- a/include/asm-ppc/mv64x60_defs.h	2005-02-23 16:07:02 +00:00
+++ b/include/asm-ppc/mv64x60_defs.h	2005-02-23 16:07:02 +00:00
@@ -43,6 +43,7 @@
 #define	MV64x60_IRQ_TIMER_2_3			9
 #define	MV64x60_IRQ_TIMER_4_5			10
 #define	MV64x60_IRQ_TIMER_6_7			11
+#define	MV64x60_IRQ_DOORBELL			28
 #define	MV64x60_IRQ_ETH_0			32
 #define	MV64x60_IRQ_ETH_1			33
 #define	MV64x60_IRQ_ETH_2			34

--------------030708080005090108040900--
