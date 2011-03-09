Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BA65F100AD3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 19:26:57 +1100 (EST)
Date: Wed, 9 Mar 2011 09:26:53 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 10/28] powerpc: platforms/embedded6xx irq_data conversion.
Message-ID: <20110309082653.GP16649@mail.wantstofly.org>
References: <cover.1299541392.git.buytenh@wantstofly.org>
	<20110307235933.GO16649@mail.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110307235933.GO16649@mail.wantstofly.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
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
v2: get_irq_chip_data(d->irq) => irq_data_get_irq_chip_data(d)

 arch/powerpc/platforms/embedded6xx/flipper-pic.c |   32 ++++++++--------
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c    |   41 +++++++++++----------
 2 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index c278bd3..0aca0e2 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -46,10 +46,10 @@
  *
  */
 
-static void flipper_pic_mask_and_ack(unsigned int virq)
+static void flipper_pic_mask_and_ack(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void __iomem *io_base = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 	u32 mask = 1 << irq;
 
 	clrbits32(io_base + FLIPPER_IMR, mask);
@@ -57,27 +57,27 @@ static void flipper_pic_mask_and_ack(unsigned int virq)
 	out_be32(io_base + FLIPPER_ICR, mask);
 }
 
-static void flipper_pic_ack(unsigned int virq)
+static void flipper_pic_ack(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void __iomem *io_base = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 
 	/* this is at least needed for RSW */
 	out_be32(io_base + FLIPPER_ICR, 1 << irq);
 }
 
-static void flipper_pic_mask(unsigned int virq)
+static void flipper_pic_mask(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void __iomem *io_base = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 
 	clrbits32(io_base + FLIPPER_IMR, 1 << irq);
 }
 
-static void flipper_pic_unmask(unsigned int virq)
+static void flipper_pic_unmask(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void __iomem *io_base = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 
 	setbits32(io_base + FLIPPER_IMR, 1 << irq);
 }
@@ -85,10 +85,10 @@ static void flipper_pic_unmask(unsigned int virq)
 
 static struct irq_chip flipper_pic = {
 	.name		= "flipper-pic",
-	.ack		= flipper_pic_ack,
-	.mask_ack	= flipper_pic_mask_and_ack,
-	.mask		= flipper_pic_mask,
-	.unmask		= flipper_pic_unmask,
+	.irq_ack	= flipper_pic_ack,
+	.irq_mask_ack	= flipper_pic_mask_and_ack,
+	.irq_mask	= flipper_pic_mask,
+	.irq_unmask	= flipper_pic_unmask,
 };
 
 /*
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index a771f91..35e448b 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -41,36 +41,36 @@
  *
  */
 
-static void hlwd_pic_mask_and_ack(unsigned int virq)
+static void hlwd_pic_mask_and_ack(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void __iomem *io_base = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 	u32 mask = 1 << irq;
 
 	clrbits32(io_base + HW_BROADWAY_IMR, mask);
 	out_be32(io_base + HW_BROADWAY_ICR, mask);
 }
 
-static void hlwd_pic_ack(unsigned int virq)
+static void hlwd_pic_ack(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void __iomem *io_base = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 
 	out_be32(io_base + HW_BROADWAY_ICR, 1 << irq);
 }
 
-static void hlwd_pic_mask(unsigned int virq)
+static void hlwd_pic_mask(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void __iomem *io_base = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 
 	clrbits32(io_base + HW_BROADWAY_IMR, 1 << irq);
 }
 
-static void hlwd_pic_unmask(unsigned int virq)
+static void hlwd_pic_unmask(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void __iomem *io_base = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 
 	setbits32(io_base + HW_BROADWAY_IMR, 1 << irq);
 }
@@ -78,10 +78,10 @@ static void hlwd_pic_unmask(unsigned int virq)
 
 static struct irq_chip hlwd_pic = {
 	.name		= "hlwd-pic",
-	.ack		= hlwd_pic_ack,
-	.mask_ack	= hlwd_pic_mask_and_ack,
-	.mask		= hlwd_pic_mask,
-	.unmask		= hlwd_pic_unmask,
+	.irq_ack	= hlwd_pic_ack,
+	.irq_mask_ack	= hlwd_pic_mask_and_ack,
+	.irq_mask	= hlwd_pic_mask,
+	.irq_unmask	= hlwd_pic_unmask,
 };
 
 /*
@@ -129,11 +129,12 @@ static unsigned int __hlwd_pic_get_irq(struct irq_host *h)
 static void hlwd_pic_irq_cascade(unsigned int cascade_virq,
 				      struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	struct irq_host *irq_host = get_irq_data(cascade_virq);
 	unsigned int virq;
 
 	raw_spin_lock(&desc->lock);
-	desc->chip->mask(cascade_virq); /* IRQ_LEVEL */
+	chip->irq_mask(&desc->irq_data); /* IRQ_LEVEL */
 	raw_spin_unlock(&desc->lock);
 
 	virq = __hlwd_pic_get_irq(irq_host);
@@ -143,9 +144,9 @@ static void hlwd_pic_irq_cascade(unsigned int cascade_virq,
 		pr_err("spurious interrupt!\n");
 
 	raw_spin_lock(&desc->lock);
-	desc->chip->ack(cascade_virq); /* IRQ_LEVEL */
-	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
-		desc->chip->unmask(cascade_virq);
+	chip->irq_ack(&desc->irq_data); /* IRQ_LEVEL */
+	if (!(desc->status & IRQ_DISABLED) && chip->irq_unmask)
+		chip->irq_unmask(&desc->irq_data);
 	raw_spin_unlock(&desc->lock);
 }
 
-- 
1.7.4
