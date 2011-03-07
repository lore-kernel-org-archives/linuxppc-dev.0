Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 729FAB7601
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 10:59:23 +1100 (EST)
Date: Tue, 8 Mar 2011 00:59:19 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/28] powerpc: platforms/85xx irq_data conversion.
Message-ID: <20110307235919.GJ16649@mail.wantstofly.org>
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
 arch/powerpc/platforms/85xx/ksi8560.c           |    3 +-
 arch/powerpc/platforms/85xx/mpc85xx_ads.c       |    3 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c        |    3 +-
 arch/powerpc/platforms/85xx/sbc8560.c           |    3 +-
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c |   40 +++++++++++-----------
 arch/powerpc/platforms/85xx/stx_gp3.c           |    3 +-
 arch/powerpc/platforms/85xx/tqm85xx.c           |    3 +-
 7 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
index f4d36b5..64447e4 100644
--- a/arch/powerpc/platforms/85xx/ksi8560.c
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -56,12 +56,13 @@ static void machine_restart(char *cmd)
 
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	int cascade_irq;
 
 	while ((cascade_irq = cpm2_get_irq()) >= 0)
 		generic_handle_irq(cascade_irq);
 
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 
 static void __init ksi8560_pic_init(void)
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 9438a89..1352d11 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -50,12 +50,13 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	int cascade_irq;
 
 	while ((cascade_irq = cpm2_get_irq()) >= 0)
 		generic_handle_irq(cascade_irq);
 
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 
 #endif /* CONFIG_CPM2 */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 8190bc2..793ead7 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -47,12 +47,13 @@
 #ifdef CONFIG_PPC_I8259
 static void mpc85xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
 
 	if (cascade_irq != NO_IRQ) {
 		generic_handle_irq(cascade_irq);
 	}
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 #endif	/* CONFIG_PPC_I8259 */
 
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index a5ad1c7..d7e28ec 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -41,12 +41,13 @@
 
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	int cascade_irq;
 
 	while ((cascade_irq = cpm2_get_irq()) >= 0)
 		generic_handle_irq(cascade_irq);
 
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 
 #endif /* CONFIG_CPM2 */
diff --git a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
index d48527f..79d85ac 100644
--- a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
+++ b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
@@ -93,6 +93,7 @@ static inline unsigned int socrates_fpga_pic_get_irq(unsigned int irq)
 
 void socrates_fpga_pic_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	unsigned int cascade_irq;
 
 	/*
@@ -103,17 +104,16 @@ void socrates_fpga_pic_cascade(unsigned int irq, struct irq_desc *desc)
 
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
-	desc->chip->eoi(irq);
-
+	chip->irq_eoi(&desc->irq_data);
 }
 
-static void socrates_fpga_pic_ack(unsigned int virq)
+static void socrates_fpga_pic_ack(struct irq_data *d)
 {
 	unsigned long flags;
 	unsigned int hwirq, irq_line;
 	uint32_t mask;
 
-	hwirq = socrates_fpga_irq_to_hw(virq);
+	hwirq = socrates_fpga_irq_to_hw(d->irq);
 
 	irq_line = fpga_irqs[hwirq].irq_line;
 	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
@@ -124,14 +124,14 @@ static void socrates_fpga_pic_ack(unsigned int virq)
 	raw_spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
 }
 
-static void socrates_fpga_pic_mask(unsigned int virq)
+static void socrates_fpga_pic_mask(struct irq_data *d)
 {
 	unsigned long flags;
 	unsigned int hwirq;
 	int irq_line;
 	u32 mask;
 
-	hwirq = socrates_fpga_irq_to_hw(virq);
+	hwirq = socrates_fpga_irq_to_hw(d->irq);
 
 	irq_line = fpga_irqs[hwirq].irq_line;
 	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
@@ -142,14 +142,14 @@ static void socrates_fpga_pic_mask(unsigned int virq)
 	raw_spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
 }
 
-static void socrates_fpga_pic_mask_ack(unsigned int virq)
+static void socrates_fpga_pic_mask_ack(struct irq_data *d)
 {
 	unsigned long flags;
 	unsigned int hwirq;
 	int irq_line;
 	u32 mask;
 
-	hwirq = socrates_fpga_irq_to_hw(virq);
+	hwirq = socrates_fpga_irq_to_hw(d->irq);
 
 	irq_line = fpga_irqs[hwirq].irq_line;
 	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
@@ -161,14 +161,14 @@ static void socrates_fpga_pic_mask_ack(unsigned int virq)
 	raw_spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
 }
 
-static void socrates_fpga_pic_unmask(unsigned int virq)
+static void socrates_fpga_pic_unmask(struct irq_data *d)
 {
 	unsigned long flags;
 	unsigned int hwirq;
 	int irq_line;
 	u32 mask;
 
-	hwirq = socrates_fpga_irq_to_hw(virq);
+	hwirq = socrates_fpga_irq_to_hw(d->irq);
 
 	irq_line = fpga_irqs[hwirq].irq_line;
 	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
@@ -179,14 +179,14 @@ static void socrates_fpga_pic_unmask(unsigned int virq)
 	raw_spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
 }
 
-static void socrates_fpga_pic_eoi(unsigned int virq)
+static void socrates_fpga_pic_eoi(struct irq_data *d)
 {
 	unsigned long flags;
 	unsigned int hwirq;
 	int irq_line;
 	u32 mask;
 
-	hwirq = socrates_fpga_irq_to_hw(virq);
+	hwirq = socrates_fpga_irq_to_hw(d->irq);
 
 	irq_line = fpga_irqs[hwirq].irq_line;
 	raw_spin_lock_irqsave(&socrates_fpga_pic_lock, flags);
@@ -197,7 +197,7 @@ static void socrates_fpga_pic_eoi(unsigned int virq)
 	raw_spin_unlock_irqrestore(&socrates_fpga_pic_lock, flags);
 }
 
-static int socrates_fpga_pic_set_type(unsigned int virq,
+static int socrates_fpga_pic_set_type(struct irq_data *d,
 		unsigned int flow_type)
 {
 	unsigned long flags;
@@ -205,7 +205,7 @@ static int socrates_fpga_pic_set_type(unsigned int virq,
 	int polarity;
 	u32 mask;
 
-	hwirq = socrates_fpga_irq_to_hw(virq);
+	hwirq = socrates_fpga_irq_to_hw(d->irq);
 
 	if (fpga_irqs[hwirq].type != IRQ_TYPE_NONE)
 		return -EINVAL;
@@ -233,12 +233,12 @@ static int socrates_fpga_pic_set_type(unsigned int virq,
 
 static struct irq_chip socrates_fpga_pic_chip = {
 	.name		= "FPGA-PIC",
-	.ack		= socrates_fpga_pic_ack,
-	.mask           = socrates_fpga_pic_mask,
-	.mask_ack       = socrates_fpga_pic_mask_ack,
-	.unmask         = socrates_fpga_pic_unmask,
-	.eoi		= socrates_fpga_pic_eoi,
-	.set_type	= socrates_fpga_pic_set_type,
+	.irq_ack	= socrates_fpga_pic_ack,
+	.irq_mask	= socrates_fpga_pic_mask,
+	.irq_mask_ack	= socrates_fpga_pic_mask_ack,
+	.irq_unmask	= socrates_fpga_pic_unmask,
+	.irq_eoi	= socrates_fpga_pic_eoi,
+	.irq_set_type	= socrates_fpga_pic_set_type,
 };
 
 static int socrates_fpga_pic_host_map(struct irq_host *h, unsigned int virq,
diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
index bc33d18..2b62b06 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -46,12 +46,13 @@
 
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	int cascade_irq;
 
 	while ((cascade_irq = cpm2_get_irq()) >= 0)
 		generic_handle_irq(cascade_irq);
 
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 #endif /* CONFIG_CPM2 */
 
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index 5e847d0..2265b68 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -44,12 +44,13 @@
 
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	int cascade_irq;
 
 	while ((cascade_irq = cpm2_get_irq()) >= 0)
 		generic_handle_irq(cascade_irq);
 
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 #endif /* CONFIG_CPM2 */
 
-- 
1.7.4
