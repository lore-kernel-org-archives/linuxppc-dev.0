Return-Path: <henk.stegeman@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6CA9BB70EB
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2011 21:27:03 +1100 (EST)
Received: by eyf5 with SMTP id 5so4185089eyf.15
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2011 02:26:58 -0800 (PST)
From: Henk Stegeman <henk.stegeman@gmail.com>
To: linuxppc-dev@ozlabs.org grant.likely@secretlab.ca
Subject: [PATCH] Fix masking of interrupts for 52xx GPT IRQ.
Date: Sat, 15 Jan 2011 02:28:04 +0100
Message-Id: <1295054884-18540-1-git-send-email-henk.stegeman@gmail.com>
In-Reply-To: <fa686aa41003181102i2a702c61h8ecfe05568c2a42e@mail.gmail.com>
References: <fa686aa41003181102i2a702c61h8ecfe05568c2a42e@mail.gmail.com>
Cc: Henk Stegeman <henk.stegeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When using the GPT as interrupt controller interupts were missing.
It turned out the IrqEn bit of the GPT is not a mask bit, but it also
disables interrupt generation. This modification masks interrupt one
level down the cascade. Note that masking one level down the cascade
is only valid here because the GPT as interrupt ontroller only serves
one IRQ.

Signed-off-by: Henk Stegeman <henk.stegeman@gmail.com>
---
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index 6f8ebe1..9ae2045 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -91,7 +91,7 @@ struct mpc52xx_gpt_priv {
 	struct irq_host *irqhost;
 	u32 ipb_freq;
 	u8 wdt_mode;
-
+	int cascade_virq;
 #if defined(CONFIG_GPIOLIB)
 	struct of_gpio_chip of_gc;
 #endif
@@ -136,18 +136,35 @@ DEFINE_MUTEX(mpc52xx_gpt_list_mutex);
 static void mpc52xx_gpt_irq_unmask(unsigned int virq)
 {
 	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(virq);
+
+	enable_irq(gpt->cascade_virq);
+
+}
+
+static void mpc52xx_gpt_irq_mask(unsigned int virq)
+{
+	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(virq);
+
+	disable_irq(gpt->cascade_virq);
+}
+
+static void mpc52xx_gpt_irq_enable(unsigned int virq)
+{
+	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(virq);
 	unsigned long flags;
 
+	dev_dbg(gpt->dev, "%s %d\n", __func__, virq);
 	spin_lock_irqsave(&gpt->lock, flags);
 	setbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_IRQ_EN);
 	spin_unlock_irqrestore(&gpt->lock, flags);
 }
 
-static void mpc52xx_gpt_irq_mask(unsigned int virq)
+static void mpc52xx_gpt_irq_disable(unsigned int virq)
 {
 	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(virq);
 	unsigned long flags;
 
+	dev_dbg(gpt->dev, "%s %d\n", __func__, virq);
 	spin_lock_irqsave(&gpt->lock, flags);
 	clrbits32(&gpt->regs->mode, MPC52xx_GPT_MODE_IRQ_EN);
 	spin_unlock_irqrestore(&gpt->lock, flags);
@@ -184,6 +201,8 @@ static struct irq_chip mpc52xx_gpt_irq_chip = {
 	.name = "MPC52xx GPT",
 	.unmask = mpc52xx_gpt_irq_unmask,
 	.mask = mpc52xx_gpt_irq_mask,
+	.enable = mpc52xx_gpt_irq_enable,
+	.disable = mpc52xx_gpt_irq_disable,
 	.ack = mpc52xx_gpt_irq_ack,
 	.set_type = mpc52xx_gpt_irq_set_type,
 };
@@ -268,7 +287,7 @@ mpc52xx_gpt_irq_setup(struct mpc52xx_gpt_priv *gpt, struct device_node *node)
 	if ((mode & MPC52xx_GPT_MODE_MS_MASK) == 0)
 		out_be32(&gpt->regs->mode, mode | MPC52xx_GPT_MODE_MS_IC);
 	spin_unlock_irqrestore(&gpt->lock, flags);
-
+	gpt->cascade_virq = cascade_virq;
 	dev_dbg(gpt->dev, "%s() complete. virq=%i\n", __func__, cascade_virq);
 }
 
-- 
1.5.4.3
