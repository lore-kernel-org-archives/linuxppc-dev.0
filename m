Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id AABC91007EB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:34 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <72549d3e9897a80a25e83c873b970463d12e30f0.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:30:29 -0500
Subject: [PATCH 33/37] powerpc: spider-pic: get pic from chip_data instead of
	irq_map
Cc: Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Building on Grant's efforts to remove the irq_map array, this patch
moves spider-pics use of virq_to_host() to use irq_data_get_chip_data
and sets the irq chip data in the map call, like most other interrupt
controllers in powerpc.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
---
 arch/powerpc/platforms/cell/spider-pic.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/platforms/cell/spider-pic.c
index 34d2b99..442c28c 100644
--- a/arch/powerpc/platforms/cell/spider-pic.c
+++ b/arch/powerpc/platforms/cell/spider-pic.c
@@ -68,9 +68,9 @@ struct spider_pic {
 };
 static struct spider_pic spider_pics[SPIDER_CHIP_COUNT];
 
-static struct spider_pic *spider_virq_to_pic(unsigned int virq)
+static struct spider_pic *spider_irq_data_to_pic(struct irq_data *d)
 {
-	return virq_to_host(virq)->host_data;
+	return irq_data_get_irq_chip_data(d);
 }
 
 static void __iomem *spider_get_irq_config(struct spider_pic *pic,
@@ -81,7 +81,7 @@ static void __iomem *spider_get_irq_config(struct spider_pic *pic,
 
 static void spider_unmask_irq(struct irq_data *d)
 {
-	struct spider_pic *pic = spider_virq_to_pic(d->irq);
+	struct spider_pic *pic = spider_irq_data_to_pic(d);
 	void __iomem *cfg = spider_get_irq_config(pic, irqd_to_hwirq(d));
 
 	out_be32(cfg, in_be32(cfg) | 0x30000000u);
@@ -89,7 +89,7 @@ static void spider_unmask_irq(struct irq_data *d)
 
 static void spider_mask_irq(struct irq_data *d)
 {
-	struct spider_pic *pic = spider_virq_to_pic(d->irq);
+	struct spider_pic *pic = spider_irq_data_to_pic(d);
 	void __iomem *cfg = spider_get_irq_config(pic, irqd_to_hwirq(d));
 
 	out_be32(cfg, in_be32(cfg) & ~0x30000000u);
@@ -97,7 +97,7 @@ static void spider_mask_irq(struct irq_data *d)
 
 static void spider_ack_irq(struct irq_data *d)
 {
-	struct spider_pic *pic = spider_virq_to_pic(d->irq);
+	struct spider_pic *pic = spider_irq_data_to_pic(d);
 	unsigned int src = irqd_to_hwirq(d);
 
 	/* Reset edge detection logic if necessary
@@ -116,7 +116,7 @@ static void spider_ack_irq(struct irq_data *d)
 static int spider_set_irq_type(struct irq_data *d, unsigned int type)
 {
 	unsigned int sense = type & IRQ_TYPE_SENSE_MASK;
-	struct spider_pic *pic = spider_virq_to_pic(d->irq);
+	struct spider_pic *pic = spider_irq_data_to_pic(d);
 	unsigned int hw = irqd_to_hwirq(d);
 	void __iomem *cfg = spider_get_irq_config(pic, hw);
 	u32 old_mask;
@@ -171,6 +171,7 @@ static struct irq_chip spider_pic = {
 static int spider_host_map(struct irq_host *h, unsigned int virq,
 			irq_hw_number_t hw)
 {
+	irq_set_chip_data(virq, h->host_data);
 	irq_set_chip_and_handler(virq, &spider_pic, handle_level_irq);
 
 	/* Set default irq type */
-- 
1.7.0.4
