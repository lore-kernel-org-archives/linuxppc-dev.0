Return-Path: <Zubair.Kakakhel@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tHTvs48FwzDvLb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:14:01 +1100 (AEDT)
From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To: <monstr@monstr.eu>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
 <marc.zyngier@arm.com>
CC: <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
 <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>,
 <Zubair.Kakakhel@imgtec.com>
Subject: [Patch v7 2/7] irqchip: xilinx: clean up print messages
Date: Mon, 14 Nov 2016 12:13:46 +0000
Message-ID: <20161114121351.10924-3-Zubair.Kakakhel@imgtec.com>
In-Reply-To: <20161114121351.10924-1-Zubair.Kakakhel@imgtec.com>
References: <20161114121351.10924-1-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove __func__ and prefix irq-xilinx in various debug prints

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V6 -> V7
New patch
This diff was squashed into another patch. Split it up for cleanliness
---
 drivers/irqchip/irq-xilinx-intc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 90bec7d..096c1ed 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -58,7 +58,7 @@ static void intc_enable_or_unmask(struct irq_data *d)
 {
 	unsigned long mask = 1 << d->hwirq;
 
-	pr_debug("enable_or_unmask: %ld\n", d->hwirq);
+	pr_debug("irq-xilinx: enable_or_unmask: %ld\n", d->hwirq);
 
 	/* ack level irqs because they can't be acked during
 	 * ack function since the handle_level_irq function
@@ -72,13 +72,13 @@ static void intc_enable_or_unmask(struct irq_data *d)
 
 static void intc_disable_or_mask(struct irq_data *d)
 {
-	pr_debug("disable: %ld\n", d->hwirq);
+	pr_debug("irq-xilinx: disable: %ld\n", d->hwirq);
 	write_fn(1 << d->hwirq, intc_baseaddr + CIE);
 }
 
 static void intc_ack(struct irq_data *d)
 {
-	pr_debug("ack: %ld\n", d->hwirq);
+	pr_debug("irq-xilinx: ack: %ld\n", d->hwirq);
 	write_fn(1 << d->hwirq, intc_baseaddr + IAR);
 }
 
@@ -86,7 +86,7 @@ static void intc_mask_ack(struct irq_data *d)
 {
 	unsigned long mask = 1 << d->hwirq;
 
-	pr_debug("disable_and_ack: %ld\n", d->hwirq);
+	pr_debug("irq-xilinx: disable_and_ack: %ld\n", d->hwirq);
 	write_fn(mask, intc_baseaddr + CIE);
 	write_fn(mask, intc_baseaddr + IAR);
 }
@@ -109,7 +109,7 @@ unsigned int get_irq(void)
 	if (hwirq != -1U)
 		irq = irq_find_mapping(root_domain, hwirq);
 
-	pr_debug("get_irq: hwirq=%d, irq=%d\n", hwirq, irq);
+	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
 
 	return irq;
 }
@@ -146,20 +146,20 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 
 	ret = of_property_read_u32(intc, "xlnx,num-intr-inputs", &nr_irq);
 	if (ret < 0) {
-		pr_err("%s: unable to read xlnx,num-intr-inputs\n", __func__);
+		pr_err("irq-xilinx: unable to read xlnx,num-intr-inputs\n");
 		return ret;
 	}
 
 	ret = of_property_read_u32(intc, "xlnx,kind-of-intr", &intr_mask);
 	if (ret < 0) {
-		pr_err("%s: unable to read xlnx,kind-of-intr\n", __func__);
+		pr_err("irq-xilinx: unable to read xlnx,kind-of-intr\n");
 		return ret;
 	}
 
 	if (intr_mask >> nr_irq)
-		pr_warn("%s: mismatch in kind-of-intr param\n", __func__);
+		pr_warn("irq-xilinx: mismatch in kind-of-intr param\n");
 
-	pr_info("%s: num_irq=%d, edge=0x%x\n",
+	pr_info("irq-xilinx: %s: num_irq=%d, edge=0x%x\n",
 		intc->full_name, nr_irq, intr_mask);
 
 	write_fn = intc_write32;
-- 
2.10.2
