Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5496EB6F6F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2011 10:50:16 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pBBNoBY7009594
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Dec 2011 17:50:12 -0600
Message-ID: <1323647409.19891.12.camel@pasglop>
Subject: [PATCH] powerpc/pmac: Simplify old pmac PIC interrupt handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 12 Dec 2011 10:50:09 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the old days, we treated all interrupts from the legacy Apple home made
interrupt controllers as level, with a trick reading the "level" register
along with the "event" register to work arounds bugs where it would
occasionally fail to latch some events.

Doing so appeared to work fine for both level and edge interrupts.

Later on, we discovered in Darwin source the magic masks that define which
interrupts are actually level and which are edge, and implemented a
different algorithm, more similar to what Apple does, that treats those
differently.

I recently discovered however that this caused problems (including loss
of interrupts) with an old Wallstreet PowerBook when trying to use the
internal modem (connected to a cascaded controller).

It looks like some interrupts are treated as edge while they are really
level and I'm starting to seriously doubt the correctness of the Darwin
code (which has other obvious bugs when you read it, so ...)

This patch reverts to our original behaviour of treating everything as
a level interrupt. It appears to solve the problems with the modem on
the Wallstreet and everything else seems to be working properly as well.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powermac/pic.c |   34 +++++---------------------------
 1 files changed, 6 insertions(+), 28 deletions(-)

Please test on anything pre-MPIC: all oldworld and very few newworld
such as the Lombard PowerBook (101) or the original iMac.

diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index d8aedf1..7761aab 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -52,13 +52,8 @@ struct device_node *of_irq_dflt_pic;
 /* Default addresses */
 static volatile struct pmac_irq_hw __iomem *pmac_irq_hw[4];
 
-#define GC_LEVEL_MASK		0x3ff00000
-#define OHARE_LEVEL_MASK	0x1ff00000
-#define HEATHROW_LEVEL_MASK	0x1ff00000
-
 static int max_irqs;
 static int max_real_irqs;
-static u32 level_mask[4];
 
 static DEFINE_RAW_SPINLOCK(pmac_pic_lock);
 
@@ -217,8 +212,7 @@ static irqreturn_t gatwick_action(int cpl, void *dev_id)
 	for (irq = max_irqs; (irq -= 32) >= max_real_irqs; ) {
 		int i = irq >> 5;
 		bits = in_le32(&pmac_irq_hw[i]->event) | ppc_lost_interrupts[i];
-		/* We must read level interrupts from the level register */
-		bits |= (in_le32(&pmac_irq_hw[i]->level) & level_mask[i]);
+		bits |= in_le32(&pmac_irq_hw[i]->level);
 		bits &= ppc_cached_irq_mask[i];
 		if (bits == 0)
 			continue;
@@ -248,8 +242,7 @@ static unsigned int pmac_pic_get_irq(void)
 	for (irq = max_real_irqs; (irq -= 32) >= 0; ) {
 		int i = irq >> 5;
 		bits = in_le32(&pmac_irq_hw[i]->event) | ppc_lost_interrupts[i];
-		/* We must read level interrupts from the level register */
-		bits |= (in_le32(&pmac_irq_hw[i]->level) & level_mask[i]);
+		bits |= in_le32(&pmac_irq_hw[i]->level);
 		bits &= ppc_cached_irq_mask[i];
 		if (bits == 0)
 			continue;
@@ -284,19 +277,14 @@ static int pmac_pic_host_match(struct irq_host *h, struct device_node *node)
 static int pmac_pic_host_map(struct irq_host *h, unsigned int virq,
 			     irq_hw_number_t hw)
 {
-	int level;
-
 	if (hw >= max_irqs)
 		return -EINVAL;
 
 	/* Mark level interrupts, set delayed disable for edge ones and set
 	 * handlers
 	 */
-	level = !!(level_mask[hw >> 5] & (1UL << (hw & 0x1f)));
-	if (level)
-		irq_set_status_flags(virq, IRQ_LEVEL);
-	irq_set_chip_and_handler(virq, &pmac_pic,
-				 level ? handle_level_irq : handle_edge_irq);
+	irq_set_status_flags(virq, IRQ_LEVEL);
+	irq_set_chip_and_handler(virq, &pmac_pic, handle_level_irq);
 	return 0;
 }
 
@@ -334,21 +322,14 @@ static void __init pmac_pic_probe_oldstyle(void)
 
 	if ((master = of_find_node_by_name(NULL, "gc")) != NULL) {
 		max_irqs = max_real_irqs = 32;
-		level_mask[0] = GC_LEVEL_MASK;
 	} else if ((master = of_find_node_by_name(NULL, "ohare")) != NULL) {
 		max_irqs = max_real_irqs = 32;
-		level_mask[0] = OHARE_LEVEL_MASK;
-
 		/* We might have a second cascaded ohare */
 		slave = of_find_node_by_name(NULL, "pci106b,7");
-		if (slave) {
+		if (slave)
 			max_irqs = 64;
-			level_mask[1] = OHARE_LEVEL_MASK;
-		}
 	} else if ((master = of_find_node_by_name(NULL, "mac-io")) != NULL) {
 		max_irqs = max_real_irqs = 64;
-		level_mask[0] = HEATHROW_LEVEL_MASK;
-		level_mask[1] = 0;
 
 		/* We might have a second cascaded heathrow */
 		slave = of_find_node_by_name(master, "mac-io");
@@ -363,11 +344,8 @@ static void __init pmac_pic_probe_oldstyle(void)
 		}
 
 		/* We found a slave */
-		if (slave) {
+		if (slave)
 			max_irqs = 128;
-			level_mask[2] = HEATHROW_LEVEL_MASK;
-			level_mask[3] = 0;
-		}
 	}
 	BUG_ON(master == NULL);
 
