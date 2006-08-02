Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 02 Aug 2006 10:48:50 +1000
Subject: [PATCH] Fix loop logic in irq_alloc_virt()
Message-Id: <20060802004852.C66FB67B7F@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's a bug in irq_alloc_virt() if it's asked for more than 1 interrupt,
if it can't find a slot it might look past the end of the irq_map.

I think this is a fix. No one in the kernel actually calls this with
count > 1, so it's not critical.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/irq.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

Index: to-merge/arch/powerpc/kernel/irq.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/irq.c
+++ to-merge/arch/powerpc/kernel/irq.c
@@ -728,7 +728,6 @@ unsigned int irq_alloc_virt(struct irq_h
 {
 	unsigned long flags;
 	unsigned int i, j, found = NO_IRQ;
-	unsigned int limit = irq_virq_count - count;
 
 	if (count == 0 || count > (irq_virq_count - NUM_ISA_INTERRUPTS))
 		return NO_IRQ;
@@ -745,14 +744,16 @@ unsigned int irq_alloc_virt(struct irq_h
 	/* Look for count consecutive numbers in the allocatable
 	 * (non-legacy) space
 	 */
-	for (i = NUM_ISA_INTERRUPTS; i <= limit; ) {
-		for (j = i; j < (i + count); j++)
-			if (irq_map[j].host != NULL) {
-				i = j + 1;
-				continue;
-			}
-		found = i;
-		break;
+	for (i = NUM_ISA_INTERRUPTS, j = 0; i < irq_virq_count; i++) {
+		if (irq_map[i].host != NULL)
+			j = 0;
+		else
+			j++;
+
+		if (j == count) {
+			found = i - count + 1;
+			break;
+		}
 	}
 	if (found == NO_IRQ) {
 		spin_unlock_irqrestore(&irq_big_lock, flags);
