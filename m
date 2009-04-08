Return-Path: <tony@thor.ozlabs.ibm.com>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 52A78DE0C3
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 14:26:55 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <8a6c1abce00c6f85d9714269d11bc3fac73a5402.1239164732.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH] mpic_find() was overloaded to do two things introduce
	mpic_is_ipi() and simplify mpic_find()
Date: Wed,  8 Apr 2009 14:26:54 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Also silences the warning:
arch/powerpc/sysdev/mpic.c: In function 'mpic_irq_set_priority':
arch/powerpc/sysdev/mpic.c:1382: warning: 'is_ipi' may be used uninitialized in this function

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
Only compile tested.

 arch/powerpc/sysdev/mpic.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 21b9567..a09eaf9 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -613,23 +613,23 @@ static int irq_choose_cpu(unsigned int virt_irq)
 #define mpic_irq_to_hw(virq)	((unsigned int)irq_map[virq].hwirq)
 
 /* Find an mpic associated with a given linux interrupt */
-static struct mpic *mpic_find(unsigned int irq, unsigned int *is_ipi)
+static struct mpic *mpic_find(unsigned int irq)
 {
-	unsigned int src = mpic_irq_to_hw(irq);
-	struct mpic *mpic;
-
 	if (irq < NUM_ISA_INTERRUPTS)
 		return NULL;
 
-	mpic = irq_desc[irq].chip_data;
+	return irq_desc[irq].chip_data;
+}
 
-	if (is_ipi)
-		*is_ipi = (src >= mpic->ipi_vecs[0] &&
-			   src <= mpic->ipi_vecs[3]);
+/* Determine if the linux irq is an IPI */
+static unsigned int mpic_is_ipi(struct mpic *mpic, unsigned int irq)
+{
+	unsigned int src = mpic_irq_to_hw(irq);
 
-	return mpic;
+	return (src >= mpic->ipi_vecs[0] && src <= mpic->ipi_vecs[3]);
 }
 
+
 /* Convert a cpu mask from logical to physical cpu numbers. */
 static inline u32 mpic_physmask(u32 cpumask)
 {
@@ -1379,8 +1379,7 @@ void __init mpic_set_serial_int(struct mpic *mpic, int enable)
 
 void mpic_irq_set_priority(unsigned int irq, unsigned int pri)
 {
-	unsigned int is_ipi;
-	struct mpic *mpic = mpic_find(irq, &is_ipi);
+	struct mpic *mpic = mpic_find(irq);
 	unsigned int src = mpic_irq_to_hw(irq);
 	unsigned long flags;
 	u32 reg;
@@ -1389,7 +1388,7 @@ void mpic_irq_set_priority(unsigned int irq, unsigned int pri)
 		return;
 
 	spin_lock_irqsave(&mpic_lock, flags);
-	if (is_ipi) {
+	if (mpic_is_ipi(mpic, irq)) {
 		reg = mpic_ipi_read(src - mpic->ipi_vecs[0]) &
 			~MPIC_VECPRI_PRIORITY_MASK;
 		mpic_ipi_write(src - mpic->ipi_vecs[0],
-- 
1.6.0.6
