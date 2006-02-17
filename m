Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 9A11F679EA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Feb 2006 06:00:37 +1100 (EST)
Date: Fri, 17 Feb 2006 14:00:34 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 2.6.16rc2] SBC82xx - replace NR_SIU_INTS with NR_CPM_INTS
Message-ID: <20060217190033.GB30822@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: p_gortmaker@yahoo.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


The SBC82xx was left out of the removal/replacement of NR_SIU_INTS.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>



diff -ur orig/linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.c linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.c
--- orig/linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.c	2006-02-07 16:22:28.000000000 -0500
@@ -74,7 +74,7 @@
 {
 	unsigned long flags;
 
-	irq_nr -= NR_SIU_INTS;
+	irq_nr -= NR_CPM_INTS;
 
 	spin_lock_irqsave(&sbc82xx_i8259_lock, flags);
 	sbc82xx_i8259_mask |= 1 << irq_nr;
@@ -88,7 +88,7 @@
 {
 	unsigned long flags;
 
-	irq_nr -= NR_SIU_INTS;
+	irq_nr -= NR_CPM_INTS;
 
 	spin_lock_irqsave(&sbc82xx_i8259_lock, flags);
 	sbc82xx_i8259_mask |= 1 << irq_nr;
@@ -100,7 +100,7 @@
 {
 	unsigned long flags;
 
-	irq_nr -= NR_SIU_INTS;
+	irq_nr -= NR_CPM_INTS;
 
 	spin_lock_irqsave(&sbc82xx_i8259_lock, flags);
 	sbc82xx_i8259_mask &= ~(1 << irq_nr);
@@ -142,7 +142,7 @@
 			return IRQ_HANDLED;
 		}
 	}
-	__do_IRQ(NR_SIU_INTS + irq, regs);
+	__do_IRQ(NR_CPM_INTS + irq, regs);
 	return IRQ_HANDLED;
 }
 
@@ -173,7 +173,7 @@
 	}
 	
 	/* Set up the interrupt handlers for the i8259 IRQs */
-	for (i = NR_SIU_INTS; i < NR_SIU_INTS + 8; i++) {
+	for (i = NR_CPM_INTS; i < NR_CPM_INTS + 8; i++) {
                 irq_desc[i].handler = &sbc82xx_i8259_ic;
 		irq_desc[i].status |= IRQ_LEVEL;
 	}
diff -ur orig/linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.h linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.h
--- orig/linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.h	2006-02-07 14:48:03.000000000 -0500
@@ -24,13 +24,14 @@
 
 #define BOOTROM_RESTART_ADDR      ((uint)0x40000104)
 
-#define SBC82xx_PC_IRQA (NR_SIU_INTS+0)
-#define SBC82xx_PC_IRQB (NR_SIU_INTS+1)
-#define SBC82xx_MPC185_IRQ (NR_SIU_INTS+2)
-#define SBC82xx_ATM_IRQ (NR_SIU_INTS+3)
-#define SBC82xx_PIRQA (NR_SIU_INTS+4)
-#define SBC82xx_PIRQB (NR_SIU_INTS+5)
-#define SBC82xx_PIRQC (NR_SIU_INTS+6)
-#define SBC82xx_PIRQD (NR_SIU_INTS+7)
+#define SBC82xx_PC_IRQA		(NR_CPM_INTS+0)
+#define SBC82xx_PC_IRQB		(NR_CPM_INTS+1)
+#define SBC82xx_MPC185_IRQ	(NR_CPM_INTS+2)
+#define SBC82xx_ATM_IRQ		(NR_CPM_INTS+3)
+
+#define SBC82xx_PIRQA		(NR_CPM_INTS+4)
+#define SBC82xx_PIRQB		(NR_CPM_INTS+5)
+#define SBC82xx_PIRQC		(NR_CPM_INTS+6)
+#define SBC82xx_PIRQD		(NR_CPM_INTS+7)
 
 #endif /* __PPC_SBC82xx_H__ */
