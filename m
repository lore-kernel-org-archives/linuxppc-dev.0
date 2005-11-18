Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 27E72687B2
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2005 17:19:42 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Fri, 18 Nov 2005 17:18:15 +1100
Message-Id: <1132294696.20016.85.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Fix setting MPIC priority
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trying to set the priority would just disable the interrupt due to an
incorrect mask used. We rarely use that call, in fact, I think only in
the powermac code for the cmd-power key combo that triggers xmon. So it
got unnoticed for a while.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-work.orig/arch/powerpc/sysdev/mpic.c	2005-11-17 17:06:04.000000000 +1100
+++ linux-work/arch/powerpc/sysdev/mpic.c	2005-11-17 17:07:40.000000000 +1100
@@ -361,7 +361,8 @@
 	DBG("%p: %s: enable_irq: %d (src %d)\n", mpic, mpic->name, irq, src);
 
 	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
-		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & ~MPIC_VECPRI_MASK);
+		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) &
+		       ~MPIC_VECPRI_MASK);
 
 	/* make sure mask gets to controller before we return to user */
 	do {
@@ -381,7 +382,8 @@
 	DBG("%s: disable_irq: %d (src %d)\n", mpic->name, irq, src);
 
 	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
-		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) | MPIC_VECPRI_MASK);
+		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) |
+		       MPIC_VECPRI_MASK);
 
 	/* make sure mask gets to controller before we return to user */
 	do {
@@ -735,12 +737,13 @@
 
 	spin_lock_irqsave(&mpic_lock, flags);
 	if (is_ipi) {
-		reg = mpic_ipi_read(irq - mpic->ipi_offset) & MPIC_VECPRI_PRIORITY_MASK;
+		reg = mpic_ipi_read(irq - mpic->ipi_offset) &
+			~MPIC_VECPRI_PRIORITY_MASK;
 		mpic_ipi_write(irq - mpic->ipi_offset,
 			       reg | (pri << MPIC_VECPRI_PRIORITY_SHIFT));
 	} else {
-		reg = mpic_irq_read(irq - mpic->irq_offset, MPIC_IRQ_VECTOR_PRI)
-			& MPIC_VECPRI_PRIORITY_MASK;
+		reg = mpic_irq_read(irq - mpic->irq_offset,MPIC_IRQ_VECTOR_PRI)
+			& ~MPIC_VECPRI_PRIORITY_MASK;
 		mpic_irq_write(irq - mpic->irq_offset, MPIC_IRQ_VECTOR_PRI,
 			       reg | (pri << MPIC_VECPRI_PRIORITY_SHIFT));
 	}
