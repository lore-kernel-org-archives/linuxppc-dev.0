Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 05040B76DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 11:00:00 +1100 (EST)
Date: Tue, 8 Mar 2011 00:59:56 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 18/28] powerpc: sysdev/i8259 irq_data conversion.
Message-ID: <20110307235956.GW16649@mail.wantstofly.org>
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
 arch/powerpc/sysdev/i8259.c |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index 6323e70..aeda4c8 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -78,19 +78,19 @@ unsigned int i8259_irq(void)
 	return irq;
 }
 
-static void i8259_mask_and_ack_irq(unsigned int irq_nr)
+static void i8259_mask_and_ack_irq(struct irq_data *d)
 {
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&i8259_lock, flags);
-	if (irq_nr > 7) {
-		cached_A1 |= 1 << (irq_nr-8);
+	if (d->irq > 7) {
+		cached_A1 |= 1 << (d->irq-8);
 		inb(0xA1); 	/* DUMMY */
 		outb(cached_A1, 0xA1);
 		outb(0x20, 0xA0);	/* Non-specific EOI */
 		outb(0x20, 0x20);	/* Non-specific EOI to cascade */
 	} else {
-		cached_21 |= 1 << irq_nr;
+		cached_21 |= 1 << d->irq;
 		inb(0x21); 	/* DUMMY */
 		outb(cached_21, 0x21);
 		outb(0x20, 0x20);	/* Non-specific EOI */
@@ -104,42 +104,42 @@ static void i8259_set_irq_mask(int irq_nr)
 	outb(cached_21,0x21);
 }
 
-static void i8259_mask_irq(unsigned int irq_nr)
+static void i8259_mask_irq(struct irq_data *d)
 {
 	unsigned long flags;
 
-	pr_debug("i8259_mask_irq(%d)\n", irq_nr);
+	pr_debug("i8259_mask_irq(%d)\n", d->irq);
 
 	raw_spin_lock_irqsave(&i8259_lock, flags);
-	if (irq_nr < 8)
-		cached_21 |= 1 << irq_nr;
+	if (d->irq < 8)
+		cached_21 |= 1 << d->irq;
 	else
-		cached_A1 |= 1 << (irq_nr-8);
-	i8259_set_irq_mask(irq_nr);
+		cached_A1 |= 1 << (d->irq-8);
+	i8259_set_irq_mask(d->irq);
 	raw_spin_unlock_irqrestore(&i8259_lock, flags);
 }
 
-static void i8259_unmask_irq(unsigned int irq_nr)
+static void i8259_unmask_irq(struct irq_data *d)
 {
 	unsigned long flags;
 
-	pr_debug("i8259_unmask_irq(%d)\n", irq_nr);
+	pr_debug("i8259_unmask_irq(%d)\n", d->irq);
 
 	raw_spin_lock_irqsave(&i8259_lock, flags);
-	if (irq_nr < 8)
-		cached_21 &= ~(1 << irq_nr);
+	if (d->irq < 8)
+		cached_21 &= ~(1 << d->irq);
 	else
-		cached_A1 &= ~(1 << (irq_nr-8));
-	i8259_set_irq_mask(irq_nr);
+		cached_A1 &= ~(1 << (d->irq-8));
+	i8259_set_irq_mask(d->irq);
 	raw_spin_unlock_irqrestore(&i8259_lock, flags);
 }
 
 static struct irq_chip i8259_pic = {
 	.name		= "i8259",
-	.mask		= i8259_mask_irq,
-	.disable	= i8259_mask_irq,
-	.unmask		= i8259_unmask_irq,
-	.mask_ack	= i8259_mask_and_ack_irq,
+	.irq_mask	= i8259_mask_irq,
+	.irq_disable	= i8259_mask_irq,
+	.irq_unmask	= i8259_unmask_irq,
+	.irq_mask_ack	= i8259_mask_and_ack_irq,
 };
 
 static struct resource pic1_iores = {
@@ -188,7 +188,7 @@ static int i8259_host_map(struct irq_host *h, unsigned int virq,
 static void i8259_host_unmap(struct irq_host *h, unsigned int virq)
 {
 	/* Make sure irq is masked in hardware */
-	i8259_mask_irq(virq);
+	i8259_mask_irq(irq_get_irq_data(virq));
 
 	/* remove chip and handler */
 	set_irq_chip_and_handler(virq, NULL, NULL);
-- 
1.7.4
