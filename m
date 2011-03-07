Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 68C31B74BC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 10:59:40 +1100 (EST)
Date: Tue, 8 Mar 2011 00:59:36 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 11/28] powerpc: platforms/iseries irq_data conversion.
Message-ID: <20110307235936.GP16649@mail.wantstofly.org>
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
 arch/powerpc/platforms/iseries/irq.c |   43 +++++++++++++++++++---------------
 1 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/irq.c b/arch/powerpc/platforms/iseries/irq.c
index ba446bf..4fb96f0 100644
--- a/arch/powerpc/platforms/iseries/irq.c
+++ b/arch/powerpc/platforms/iseries/irq.c
@@ -167,11 +167,11 @@ static void pci_event_handler(struct HvLpEvent *event)
  * This will be called by device drivers (via enable_IRQ)
  * to enable INTA in the bridge interrupt status register.
  */
-static void iseries_enable_IRQ(unsigned int irq)
+static void iseries_enable_IRQ(struct irq_data *d)
 {
 	u32 bus, dev_id, function, mask;
 	const u32 sub_bus = 0;
-	unsigned int rirq = (unsigned int)irq_map[irq].hwirq;
+	unsigned int rirq = (unsigned int)irq_map[d->irq].hwirq;
 
 	/* The IRQ has already been locked by the caller */
 	bus = REAL_IRQ_TO_BUS(rirq);
@@ -184,23 +184,23 @@ static void iseries_enable_IRQ(unsigned int irq)
 }
 
 /* This is called by iseries_activate_IRQs */
-static unsigned int iseries_startup_IRQ(unsigned int irq)
+static unsigned int iseries_startup_IRQ(struct irq_data *d)
 {
 	u32 bus, dev_id, function, mask;
 	const u32 sub_bus = 0;
-	unsigned int rirq = (unsigned int)irq_map[irq].hwirq;
+	unsigned int rirq = (unsigned int)irq_map[d->irq].hwirq;
 
 	bus = REAL_IRQ_TO_BUS(rirq);
 	function = REAL_IRQ_TO_FUNC(rirq);
 	dev_id = (REAL_IRQ_TO_IDSEL(rirq) << 4) + function;
 
 	/* Link the IRQ number to the bridge */
-	HvCallXm_connectBusUnit(bus, sub_bus, dev_id, irq);
+	HvCallXm_connectBusUnit(bus, sub_bus, dev_id, d->irq);
 
 	/* Unmask bridge interrupts in the FISR */
 	mask = 0x01010000 << function;
 	HvCallPci_unmaskFisr(bus, sub_bus, dev_id, mask);
-	iseries_enable_IRQ(irq);
+	iseries_enable_IRQ(d);
 	return 0;
 }
 
@@ -215,21 +215,26 @@ void __init iSeries_activate_IRQs()
 
 	for_each_irq (irq) {
 		struct irq_desc *desc = irq_to_desc(irq);
+		struct irq_chip *chip;
 
-		if (desc && desc->chip && desc->chip->startup) {
+		if (!desc)
+			continue;
+
+		chip = get_irq_desc_chip(desc);
+		if (chip && chip->irq_startup) {
 			raw_spin_lock_irqsave(&desc->lock, flags);
-			desc->chip->startup(irq);
+			chip->irq_startup(&desc->irq_data);
 			raw_spin_unlock_irqrestore(&desc->lock, flags);
 		}
 	}
 }
 
 /*  this is not called anywhere currently */
-static void iseries_shutdown_IRQ(unsigned int irq)
+static void iseries_shutdown_IRQ(struct irq_data *d)
 {
 	u32 bus, dev_id, function, mask;
 	const u32 sub_bus = 0;
-	unsigned int rirq = (unsigned int)irq_map[irq].hwirq;
+	unsigned int rirq = (unsigned int)irq_map[d->irq].hwirq;
 
 	/* irq should be locked by the caller */
 	bus = REAL_IRQ_TO_BUS(rirq);
@@ -248,11 +253,11 @@ static void iseries_shutdown_IRQ(unsigned int irq)
  * This will be called by device drivers (via disable_IRQ)
  * to disable INTA in the bridge interrupt status register.
  */
-static void iseries_disable_IRQ(unsigned int irq)
+static void iseries_disable_IRQ(struct irq_data *d)
 {
 	u32 bus, dev_id, function, mask;
 	const u32 sub_bus = 0;
-	unsigned int rirq = (unsigned int)irq_map[irq].hwirq;
+	unsigned int rirq = (unsigned int)irq_map[d->irq].hwirq;
 
 	/* The IRQ has already been locked by the caller */
 	bus = REAL_IRQ_TO_BUS(rirq);
@@ -264,9 +269,9 @@ static void iseries_disable_IRQ(unsigned int irq)
 	HvCallPci_maskInterrupts(bus, sub_bus, dev_id, mask);
 }
 
-static void iseries_end_IRQ(unsigned int irq)
+static void iseries_end_IRQ(struct irq_data *d)
 {
-	unsigned int rirq = (unsigned int)irq_map[irq].hwirq;
+	unsigned int rirq = (unsigned int)irq_map[d->irq].hwirq;
 
 	HvCallPci_eoi(REAL_IRQ_TO_BUS(rirq), REAL_IRQ_TO_SUBBUS(rirq),
 		(REAL_IRQ_TO_IDSEL(rirq) << 4) + REAL_IRQ_TO_FUNC(rirq));
@@ -274,11 +279,11 @@ static void iseries_end_IRQ(unsigned int irq)
 
 static struct irq_chip iseries_pic = {
 	.name		= "iSeries",
-	.startup	= iseries_startup_IRQ,
-	.shutdown	= iseries_shutdown_IRQ,
-	.unmask		= iseries_enable_IRQ,
-	.mask		= iseries_disable_IRQ,
-	.eoi		= iseries_end_IRQ
+	.irq_startup	= iseries_startup_IRQ,
+	.irq_shutdown	= iseries_shutdown_IRQ,
+	.irq_unmask	= iseries_enable_IRQ,
+	.irq_mask	= iseries_disable_IRQ,
+	.irq_eoi	= iseries_end_IRQ
 };
 
 /*
-- 
1.7.4
