Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id D8DB267B77
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 04:03:12 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k9JI3Bek010636
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 11:03:11 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k9JI39Bu007204
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 13:03:10 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	k9JHnRvR024122
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 12:49:28 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 6C20B4B92C
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 13:03:08 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	k9JI38hI024271
	for linuxppc-dev@ozlabs.org; Thu, 19 Oct 2006 13:03:08 -0500
Date: Thu, 19 Oct 2006 13:03:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] qe_ic: Do a sync when masking interrupts.
Message-ID: <20061019180308.GA24256@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch causes a sync do be done after masking a QE interrupt, to
ensure that the masking has completed before interrupts are enabled.
This allows the masking of the cascade IRQ to be removed without causing
spurious interrupts.

The mask_and_ack function is also removed and set to the mask function,
as the two are identical.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/qe_lib/qe_ic.c |   34 +++++++---------------------------
 1 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 6995f51..d96e48d 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -222,24 +222,12 @@ static void qe_ic_mask_irq(unsigned int 
 	temp = qe_ic_read(qe_ic->regs, qe_ic_info[src].mask_reg);
 	qe_ic_write(qe_ic->regs, qe_ic_info[src].mask_reg,
 		    temp & ~qe_ic_info[src].mask);
-
-	spin_unlock_irqrestore(&qe_ic_lock, flags);
-}
-
-static void qe_ic_mask_irq_and_ack(unsigned int virq)
-{
-	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
-	unsigned long flags;
-	u32 temp;
-
-	spin_lock_irqsave(&qe_ic_lock, flags);
-
-	temp = qe_ic_read(qe_ic->regs, qe_ic_info[src].mask_reg);
-	qe_ic_write(qe_ic->regs, qe_ic_info[src].mask_reg,
-		    temp & ~qe_ic_info[src].mask);
-
-	/* There is nothing to do for ack here, ack is handled in ISR */
+	
+	/* Flush the above write before enabling interrupts;
+	 * otherwise, spurious interrupts will sometimes
+	 * happen
+	 */
+	mb();
 
 	spin_unlock_irqrestore(&qe_ic_lock, flags);
 }
@@ -248,7 +236,7 @@ static struct irq_chip qe_ic_irq_chip = 
 	.typename = " QEIC  ",
 	.unmask = qe_ic_unmask_irq,
 	.mask = qe_ic_mask_irq,
-	.mask_ack = qe_ic_mask_irq_and_ack,
+	.mask_ack = qe_ic_mask_irq,
 };
 
 static int qe_ic_host_match(struct irq_host *h, struct device_node *node)
@@ -331,8 +319,6 @@ unsigned int qe_ic_get_high_irq(struct q
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
 
-/* FIXME: We mask all the QE Low interrupts while handling.  We should
- * let other interrupt come in, but BAD interrupts are generated */
 void fastcall qe_ic_cascade_low(unsigned int irq, struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = desc->handler_data;
@@ -340,14 +326,10 @@ void fastcall qe_ic_cascade_low(unsigned
 
 	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
 
-	chip->mask_ack(irq);
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
-	chip->unmask(irq);
 }
 
-/* FIXME: We mask all the QE High interrupts while handling.  We should
- * let other interrupt come in, but BAD interrupts are generated */
 void fastcall qe_ic_cascade_high(unsigned int irq, struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = desc->handler_data;
@@ -355,10 +337,8 @@ void fastcall qe_ic_cascade_high(unsigne
 
 	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
 
-	chip->mask_ack(irq);
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
-	chip->unmask(irq);
 }
 
 void __init qe_ic_init(struct device_node *node, unsigned int flags)
-- 
1.4.2.3
