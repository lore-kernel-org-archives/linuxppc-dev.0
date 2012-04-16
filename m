Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
 [209.85.210.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A98EEB7025
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 06:13:23 +1000 (EST)
Received: by dang27 with SMTP id g27so8266190dan.15
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2012 13:13:21 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/8xx: Fix NR_IRQ bugs and refactor 8xx interrupt
 controller
Date: Mon, 16 Apr 2012 14:13:17 -0600
Message-Id: <1334607198-18694-1-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mpc8xx driver uses a reference to NR_IRQS that is buggy.  It uses
NR_IRQs for the array size of the ppc_cached_irq_mask bitmap, but
NR_IRQs could be smaller than the number of hardware irqs that
ppc_cached_irq_mask tracks.

Also, while fixing that problem, it became apparent that the interrupt
controller only supports 32 interrupt numbers, but it is written as if
it supports multiple register banks which is more complicated.

This patch pulls out the buggy reference to NR_IRQs and fixes the size
of the ppc_cached_irq_mask to match the number of HW irqs.  It also
drops the now-unnecessary code since ppc_cached_irq_mask is no longer
an array.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/mpc8xx_pic.c |   61 +++++++++++++-------------------------
 1 file changed, 21 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_pic.c
index d5f5416..91cade8 100644
--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -18,69 +18,47 @@
 extern int cpm_get_irq(struct pt_regs *regs);
 
 static struct irq_domain *mpc8xx_pic_host;
-#define NR_MASK_WORDS   ((NR_IRQS + 31) / 32)
-static unsigned long ppc_cached_irq_mask[NR_MASK_WORDS];
+static unsigned long ppc_cached_irq_mask;
 static sysconf8xx_t __iomem *siu_reg;
 
 int cpm_get_irq(struct pt_regs *regs);
 
-static void mpc8xx_unmask_irq(struct irq_data *d)
+static inline unsigned long mpc8xx_irqd_to_bit(struct irq_data *d)
 {
-	int	bit, word;
-	unsigned int irq_nr = (unsigned int)irqd_to_hwirq(d);
-
-	bit = irq_nr & 0x1f;
-	word = irq_nr >> 5;
+	return 0x80000000 >> irqd_to_hwirq(d);
+}
 
-	ppc_cached_irq_mask[word] |= (1 << (31-bit));
-	out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask[word]);
+static void mpc8xx_unmask_irq(struct irq_data *d)
+{
+	ppc_cached_irq_mask |= mpc8xx_irqd_to_bit(d);
+	out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask);
 }
 
 static void mpc8xx_mask_irq(struct irq_data *d)
 {
-	int	bit, word;
-	unsigned int irq_nr = (unsigned int)irqd_to_hwirq(d);
-
-	bit = irq_nr & 0x1f;
-	word = irq_nr >> 5;
-
-	ppc_cached_irq_mask[word] &= ~(1 << (31-bit));
-	out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask[word]);
+	ppc_cached_irq_mask &= ~mpc8xx_irqd_to_bit(d);
+	out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask);
 }
 
 static void mpc8xx_ack(struct irq_data *d)
 {
-	int	bit;
-	unsigned int irq_nr = (unsigned int)irqd_to_hwirq(d);
-
-	bit = irq_nr & 0x1f;
-	out_be32(&siu_reg->sc_sipend, 1 << (31-bit));
+	out_be32(&siu_reg->sc_sipend, mpc8xx_irqd_to_bit(d));
 }
 
 static void mpc8xx_end_irq(struct irq_data *d)
 {
-	int bit, word;
-	unsigned int irq_nr = (unsigned int)irqd_to_hwirq(d);
-
-	bit = irq_nr & 0x1f;
-	word = irq_nr >> 5;
-
-	ppc_cached_irq_mask[word] |= (1 << (31-bit));
-	out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask[word]);
+	ppc_cached_irq_mask |= mpc8xx_irqd_to_bit(d);
+	out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask);
 }
 
 static int mpc8xx_set_irq_type(struct irq_data *d, unsigned int flow_type)
 {
-	if (flow_type & IRQ_TYPE_EDGE_FALLING) {
-		irq_hw_number_t hw = (unsigned int)irqd_to_hwirq(d);
+	/* only external IRQ senses are programmable */
+	if ((flow_type & IRQ_TYPE_EDGE_FALLING) && !(irqd_to_hwirq(d) & 1)) {
 		unsigned int siel = in_be32(&siu_reg->sc_siel);
-
-		/* only external IRQ senses are programmable */
-		if ((hw & 1) == 0) {
-			siel |= (0x80000000 >> hw);
-			out_be32(&siu_reg->sc_siel, siel);
-			__irq_set_handler_locked(d->irq, handle_edge_irq);
-		}
+		siel |= mpc8xx_irqd_to_bit(d);
+		out_be32(&siu_reg->sc_siel, siel);
+		__irq_set_handler_locked(d->irq, handle_edge_irq);
 	}
 	return 0;
 }
@@ -132,6 +110,9 @@ static int mpc8xx_pic_host_xlate(struct irq_domain *h, struct device_node *ct,
 		IRQ_TYPE_EDGE_FALLING,
 	};
 
+	if (intspec[0] > 0x1f)
+		return 0;
+
 	*out_hwirq = intspec[0];
 	if (intsize > 1 && intspec[1] < 4)
 		*out_flags = map_pic_senses[intspec[1]];
-- 
1.7.9.5
