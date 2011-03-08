Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0C503B715A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 11:00:04 +1100 (EST)
Date: Tue, 8 Mar 2011 01:00:00 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 20/28] powerpc: sysdev/mpc8xx_pic irq_data conversion.
Message-ID: <20110308000000.GY16649@mail.wantstofly.org>
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
 arch/powerpc/sysdev/mpc8xx_pic.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_pic.c
index 8c27d26..1a75a7f 100644
--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -25,10 +25,10 @@ static sysconf8xx_t __iomem *siu_reg;
 
 int cpm_get_irq(struct pt_regs *regs);
 
-static void mpc8xx_unmask_irq(unsigned int virq)
+static void mpc8xx_unmask_irq(struct irq_data *d)
 {
 	int	bit, word;
-	unsigned int irq_nr = (unsigned int)irq_map[virq].hwirq;
+	unsigned int irq_nr = (unsigned int)irq_map[d->irq].hwirq;
 
 	bit = irq_nr & 0x1f;
 	word = irq_nr >> 5;
@@ -37,10 +37,10 @@ static void mpc8xx_unmask_irq(unsigned int virq)
 	out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask[word]);
 }
 
-static void mpc8xx_mask_irq(unsigned int virq)
+static void mpc8xx_mask_irq(struct irq_data *d)
 {
 	int	bit, word;
-	unsigned int irq_nr = (unsigned int)irq_map[virq].hwirq;
+	unsigned int irq_nr = (unsigned int)irq_map[d->irq].hwirq;
 
 	bit = irq_nr & 0x1f;
 	word = irq_nr >> 5;
@@ -49,19 +49,19 @@ static void mpc8xx_mask_irq(unsigned int virq)
 	out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask[word]);
 }
 
-static void mpc8xx_ack(unsigned int virq)
+static void mpc8xx_ack(struct irq_data *d)
 {
 	int	bit;
-	unsigned int irq_nr = (unsigned int)irq_map[virq].hwirq;
+	unsigned int irq_nr = (unsigned int)irq_map[d->irq].hwirq;
 
 	bit = irq_nr & 0x1f;
 	out_be32(&siu_reg->sc_sipend, 1 << (31-bit));
 }
 
-static void mpc8xx_end_irq(unsigned int virq)
+static void mpc8xx_end_irq(struct irq_data *d)
 {
 	int bit, word;
-	unsigned int irq_nr = (unsigned int)irq_map[virq].hwirq;
+	unsigned int irq_nr = (unsigned int)irq_map[d->irq].hwirq;
 
 	bit = irq_nr & 0x1f;
 	word = irq_nr >> 5;
@@ -70,9 +70,9 @@ static void mpc8xx_end_irq(unsigned int virq)
 	out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask[word]);
 }
 
-static int mpc8xx_set_irq_type(unsigned int virq, unsigned int flow_type)
+static int mpc8xx_set_irq_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct irq_desc *desc = irq_to_desc(virq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
 
 	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
 	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
@@ -80,7 +80,7 @@ static int mpc8xx_set_irq_type(unsigned int virq, unsigned int flow_type)
 		desc->status |= IRQ_LEVEL;
 
 	if (flow_type & IRQ_TYPE_EDGE_FALLING) {
-		irq_hw_number_t hw = (unsigned int)irq_map[virq].hwirq;
+		irq_hw_number_t hw = (unsigned int)irq_map[d->irq].hwirq;
 		unsigned int siel = in_be32(&siu_reg->sc_siel);
 
 		/* only external IRQ senses are programmable */
@@ -95,11 +95,11 @@ static int mpc8xx_set_irq_type(unsigned int virq, unsigned int flow_type)
 
 static struct irq_chip mpc8xx_pic = {
 	.name = "MPC8XX SIU",
-	.unmask = mpc8xx_unmask_irq,
-	.mask = mpc8xx_mask_irq,
-	.ack = mpc8xx_ack,
-	.eoi = mpc8xx_end_irq,
-	.set_type = mpc8xx_set_irq_type,
+	.irq_unmask = mpc8xx_unmask_irq,
+	.irq_mask = mpc8xx_mask_irq,
+	.irq_ack = mpc8xx_ack,
+	.irq_eoi = mpc8xx_end_irq,
+	.irq_set_type = mpc8xx_set_irq_type,
 };
 
 unsigned int mpc8xx_get_irq(void)
-- 
1.7.4
