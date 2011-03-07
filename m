Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E17C5B7B13
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 10:59:44 +1100 (EST)
Date: Tue, 8 Mar 2011 00:59:40 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/28] powerpc: platforms/powermac irq_data conversion.
Message-ID: <20110307235940.GQ16649@mail.wantstofly.org>
References: <cover.1299541392.git.buytenh@wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1299541392.git.buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/powerpc/platforms/powermac/pic.c |   48 +++++++++++++++++---------------
 1 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 890d5f7..c55812b 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -82,9 +82,9 @@ static void __pmac_retrigger(unsigned int irq_nr)
 	}
 }
 
-static void pmac_mask_and_ack_irq(unsigned int virq)
+static void pmac_mask_and_ack_irq(struct irq_data *d)
 {
-	unsigned int src = irq_map[virq].hwirq;
+	unsigned int src = irq_map[d->irq].hwirq;
         unsigned long bit = 1UL << (src & 0x1f);
         int i = src >> 5;
         unsigned long flags;
@@ -104,9 +104,9 @@ static void pmac_mask_and_ack_irq(unsigned int virq)
 	raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 }
 
-static void pmac_ack_irq(unsigned int virq)
+static void pmac_ack_irq(struct irq_data *d)
 {
-	unsigned int src = irq_map[virq].hwirq;
+	unsigned int src = irq_map[d->irq].hwirq;
         unsigned long bit = 1UL << (src & 0x1f);
         int i = src >> 5;
         unsigned long flags;
@@ -149,15 +149,15 @@ static void __pmac_set_irq_mask(unsigned int irq_nr, int nokicklost)
 /* When an irq gets requested for the first client, if it's an
  * edge interrupt, we clear any previous one on the controller
  */
-static unsigned int pmac_startup_irq(unsigned int virq)
+static unsigned int pmac_startup_irq(struct irq_data *d)
 {
 	unsigned long flags;
-	unsigned int src = irq_map[virq].hwirq;
+	unsigned int src = irq_map[d->irq].hwirq;
         unsigned long bit = 1UL << (src & 0x1f);
         int i = src >> 5;
 
 	raw_spin_lock_irqsave(&pmac_pic_lock, flags);
-	if ((irq_to_desc(virq)->status & IRQ_LEVEL) == 0)
+	if ((irq_to_desc(d->irq)->status & IRQ_LEVEL) == 0)
 		out_le32(&pmac_irq_hw[i]->ack, bit);
         __set_bit(src, ppc_cached_irq_mask);
         __pmac_set_irq_mask(src, 0);
@@ -166,10 +166,10 @@ static unsigned int pmac_startup_irq(unsigned int virq)
 	return 0;
 }
 
-static void pmac_mask_irq(unsigned int virq)
+static void pmac_mask_irq(struct irq_data *d)
 {
 	unsigned long flags;
-	unsigned int src = irq_map[virq].hwirq;
+	unsigned int src = irq_map[d->irq].hwirq;
 
 	raw_spin_lock_irqsave(&pmac_pic_lock, flags);
         __clear_bit(src, ppc_cached_irq_mask);
@@ -177,10 +177,10 @@ static void pmac_mask_irq(unsigned int virq)
 	raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 }
 
-static void pmac_unmask_irq(unsigned int virq)
+static void pmac_unmask_irq(struct irq_data *d)
 {
 	unsigned long flags;
-	unsigned int src = irq_map[virq].hwirq;
+	unsigned int src = irq_map[d->irq].hwirq;
 
 	raw_spin_lock_irqsave(&pmac_pic_lock, flags);
 	__set_bit(src, ppc_cached_irq_mask);
@@ -188,24 +188,24 @@ static void pmac_unmask_irq(unsigned int virq)
 	raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 }
 
-static int pmac_retrigger(unsigned int virq)
+static int pmac_retrigger(struct irq_data *d)
 {
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&pmac_pic_lock, flags);
-	__pmac_retrigger(irq_map[virq].hwirq);
+	__pmac_retrigger(irq_map[d->irq].hwirq);
 	raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 	return 1;
 }
 
 static struct irq_chip pmac_pic = {
 	.name		= "PMAC-PIC",
-	.startup	= pmac_startup_irq,
-	.mask		= pmac_mask_irq,
-	.ack		= pmac_ack_irq,
-	.mask_ack	= pmac_mask_and_ack_irq,
-	.unmask		= pmac_unmask_irq,
-	.retrigger	= pmac_retrigger,
+	.irq_startup	= pmac_startup_irq,
+	.irq_mask	= pmac_mask_irq,
+	.irq_ack	= pmac_ack_irq,
+	.irq_mask_ack	= pmac_mask_and_ack_irq,
+	.irq_unmask	= pmac_unmask_irq,
+	.irq_retrigger	= pmac_retrigger,
 };
 
 static irqreturn_t gatwick_action(int cpl, void *dev_id)
@@ -472,12 +472,14 @@ int of_irq_map_oldworld(struct device_node *device, int index,
 
 static void pmac_u3_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct mpic *mpic = desc->handler_data;
-
+	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct mpic *mpic = get_irq_desc_data(desc);
 	unsigned int cascade_irq = mpic_get_one_irq(mpic);
+
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
-	desc->chip->eoi(irq);
+
+	chip->irq_eoi(&desc->irq_data);
 }
 
 static void __init pmac_pic_setup_mpic_nmi(struct mpic *mpic)
@@ -707,7 +709,7 @@ static int pmacpic_resume(struct sys_device *sysdev)
 	mb();
 	for (i = 0; i < max_real_irqs; ++i)
 		if (test_bit(i, sleep_save_mask))
-			pmac_unmask_irq(i);
+			pmac_unmask_irq(irq_get_irq_data(i));
 
 	return 0;
 }
-- 
1.7.4
