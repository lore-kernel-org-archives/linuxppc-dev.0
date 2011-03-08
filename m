Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 71180B738D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 11:00:10 +1100 (EST)
Date: Tue, 8 Mar 2011 01:00:06 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 22/28] powerpc: sysdev/mv64x60_pic irq_data conversion.
Message-ID: <20110308000006.GA16649@mail.wantstofly.org>
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
 arch/powerpc/sysdev/mv64x60_pic.c |   46 ++++++++++++++++++------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/sysdev/mv64x60_pic.c b/arch/powerpc/sysdev/mv64x60_pic.c
index 485b924..bc61ebb 100644
--- a/arch/powerpc/sysdev/mv64x60_pic.c
+++ b/arch/powerpc/sysdev/mv64x60_pic.c
@@ -76,9 +76,9 @@ static struct irq_host *mv64x60_irq_host;
  * mv64x60_chip_low functions
  */
 
-static void mv64x60_mask_low(unsigned int virq)
+static void mv64x60_mask_low(struct irq_data *d)
 {
-	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	int level2 = irq_map[d->irq].hwirq & MV64x60_LEVEL2_MASK;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mv64x60_lock, flags);
@@ -89,9 +89,9 @@ static void mv64x60_mask_low(unsigned int virq)
 	(void)in_le32(mv64x60_irq_reg_base + MV64X60_IC_CPU0_INTR_MASK_LO);
 }
 
-static void mv64x60_unmask_low(unsigned int virq)
+static void mv64x60_unmask_low(struct irq_data *d)
 {
-	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	int level2 = irq_map[d->irq].hwirq & MV64x60_LEVEL2_MASK;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mv64x60_lock, flags);
@@ -104,18 +104,18 @@ static void mv64x60_unmask_low(unsigned int virq)
 
 static struct irq_chip mv64x60_chip_low = {
 	.name		= "mv64x60_low",
-	.mask		= mv64x60_mask_low,
-	.mask_ack	= mv64x60_mask_low,
-	.unmask		= mv64x60_unmask_low,
+	.irq_mask	= mv64x60_mask_low,
+	.irq_mask_ack	= mv64x60_mask_low,
+	.irq_unmask	= mv64x60_unmask_low,
 };
 
 /*
  * mv64x60_chip_high functions
  */
 
-static void mv64x60_mask_high(unsigned int virq)
+static void mv64x60_mask_high(struct irq_data *d)
 {
-	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	int level2 = irq_map[d->irq].hwirq & MV64x60_LEVEL2_MASK;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mv64x60_lock, flags);
@@ -126,9 +126,9 @@ static void mv64x60_mask_high(unsigned int virq)
 	(void)in_le32(mv64x60_irq_reg_base + MV64X60_IC_CPU0_INTR_MASK_HI);
 }
 
-static void mv64x60_unmask_high(unsigned int virq)
+static void mv64x60_unmask_high(struct irq_data *d)
 {
-	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	int level2 = irq_map[d->irq].hwirq & MV64x60_LEVEL2_MASK;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mv64x60_lock, flags);
@@ -141,18 +141,18 @@ static void mv64x60_unmask_high(unsigned int virq)
 
 static struct irq_chip mv64x60_chip_high = {
 	.name		= "mv64x60_high",
-	.mask		= mv64x60_mask_high,
-	.mask_ack	= mv64x60_mask_high,
-	.unmask		= mv64x60_unmask_high,
+	.irq_mask	= mv64x60_mask_high,
+	.irq_mask_ack	= mv64x60_mask_high,
+	.irq_unmask	= mv64x60_unmask_high,
 };
 
 /*
  * mv64x60_chip_gpp functions
  */
 
-static void mv64x60_mask_gpp(unsigned int virq)
+static void mv64x60_mask_gpp(struct irq_data *d)
 {
-	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	int level2 = irq_map[d->irq].hwirq & MV64x60_LEVEL2_MASK;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mv64x60_lock, flags);
@@ -163,9 +163,9 @@ static void mv64x60_mask_gpp(unsigned int virq)
 	(void)in_le32(mv64x60_gpp_reg_base + MV64x60_GPP_INTR_MASK);
 }
 
-static void mv64x60_mask_ack_gpp(unsigned int virq)
+static void mv64x60_mask_ack_gpp(struct irq_data *d)
 {
-	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	int level2 = irq_map[d->irq].hwirq & MV64x60_LEVEL2_MASK;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mv64x60_lock, flags);
@@ -178,9 +178,9 @@ static void mv64x60_mask_ack_gpp(unsigned int virq)
 	(void)in_le32(mv64x60_gpp_reg_base + MV64x60_GPP_INTR_CAUSE);
 }
 
-static void mv64x60_unmask_gpp(unsigned int virq)
+static void mv64x60_unmask_gpp(struct irq_data *d)
 {
-	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	int level2 = irq_map[d->irq].hwirq & MV64x60_LEVEL2_MASK;
 	unsigned long flags;
 
 	spin_lock_irqsave(&mv64x60_lock, flags);
@@ -193,9 +193,9 @@ static void mv64x60_unmask_gpp(unsigned int virq)
 
 static struct irq_chip mv64x60_chip_gpp = {
 	.name		= "mv64x60_gpp",
-	.mask		= mv64x60_mask_gpp,
-	.mask_ack	= mv64x60_mask_ack_gpp,
-	.unmask		= mv64x60_unmask_gpp,
+	.irq_mask	= mv64x60_mask_gpp,
+	.irq_mask_ack	= mv64x60_mask_ack_gpp,
+	.irq_unmask	= mv64x60_unmask_gpp,
 };
 
 /*
-- 
1.7.4
