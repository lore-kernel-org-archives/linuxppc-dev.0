Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6EB4E100C86
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 11:00:02 +1100 (EST)
Date: Tue, 8 Mar 2011 00:59:58 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 19/28] powerpc: sysdev/ipic irq_data conversion.
Message-ID: <20110307235958.GX16649@mail.wantstofly.org>
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
 arch/powerpc/sysdev/ipic.c |   54 ++++++++++++++++++++++----------------------
 1 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index d7b9b9c..497047d 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -523,10 +523,10 @@ static inline struct ipic * ipic_from_irq(unsigned int virq)
 
 #define ipic_irq_to_hw(virq)	((unsigned int)irq_map[virq].hwirq)
 
-static void ipic_unmask_irq(unsigned int virq)
+static void ipic_unmask_irq(struct irq_data *d)
 {
-	struct ipic *ipic = ipic_from_irq(virq);
-	unsigned int src = ipic_irq_to_hw(virq);
+	struct ipic *ipic = ipic_from_irq(d->irq);
+	unsigned int src = ipic_irq_to_hw(d->irq);
 	unsigned long flags;
 	u32 temp;
 
@@ -539,10 +539,10 @@ static void ipic_unmask_irq(unsigned int virq)
 	raw_spin_unlock_irqrestore(&ipic_lock, flags);
 }
 
-static void ipic_mask_irq(unsigned int virq)
+static void ipic_mask_irq(struct irq_data *d)
 {
-	struct ipic *ipic = ipic_from_irq(virq);
-	unsigned int src = ipic_irq_to_hw(virq);
+	struct ipic *ipic = ipic_from_irq(d->irq);
+	unsigned int src = ipic_irq_to_hw(d->irq);
 	unsigned long flags;
 	u32 temp;
 
@@ -559,10 +559,10 @@ static void ipic_mask_irq(unsigned int virq)
 	raw_spin_unlock_irqrestore(&ipic_lock, flags);
 }
 
-static void ipic_ack_irq(unsigned int virq)
+static void ipic_ack_irq(struct irq_data *d)
 {
-	struct ipic *ipic = ipic_from_irq(virq);
-	unsigned int src = ipic_irq_to_hw(virq);
+	struct ipic *ipic = ipic_from_irq(d->irq);
+	unsigned int src = ipic_irq_to_hw(d->irq);
 	unsigned long flags;
 	u32 temp;
 
@@ -578,10 +578,10 @@ static void ipic_ack_irq(unsigned int virq)
 	raw_spin_unlock_irqrestore(&ipic_lock, flags);
 }
 
-static void ipic_mask_irq_and_ack(unsigned int virq)
+static void ipic_mask_irq_and_ack(struct irq_data *d)
 {
-	struct ipic *ipic = ipic_from_irq(virq);
-	unsigned int src = ipic_irq_to_hw(virq);
+	struct ipic *ipic = ipic_from_irq(d->irq);
+	unsigned int src = ipic_irq_to_hw(d->irq);
 	unsigned long flags;
 	u32 temp;
 
@@ -601,11 +601,11 @@ static void ipic_mask_irq_and_ack(unsigned int virq)
 	raw_spin_unlock_irqrestore(&ipic_lock, flags);
 }
 
-static int ipic_set_irq_type(unsigned int virq, unsigned int flow_type)
+static int ipic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct ipic *ipic = ipic_from_irq(virq);
-	unsigned int src = ipic_irq_to_hw(virq);
-	struct irq_desc *desc = irq_to_desc(virq);
+	struct ipic *ipic = ipic_from_irq(d->irq);
+	unsigned int src = ipic_irq_to_hw(d->irq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
 	unsigned int vold, vnew, edibit;
 
 	if (flow_type == IRQ_TYPE_NONE)
@@ -630,10 +630,10 @@ static int ipic_set_irq_type(unsigned int virq, unsigned int flow_type)
 	if (flow_type & IRQ_TYPE_LEVEL_LOW)  {
 		desc->status |= IRQ_LEVEL;
 		desc->handle_irq = handle_level_irq;
-		desc->chip = &ipic_level_irq_chip;
+		desc->irq_data.chip = &ipic_level_irq_chip;
 	} else {
 		desc->handle_irq = handle_edge_irq;
-		desc->chip = &ipic_edge_irq_chip;
+		desc->irq_data.chip = &ipic_edge_irq_chip;
 	}
 
 	/* only EXT IRQ senses are programmable on ipic
@@ -661,19 +661,19 @@ static int ipic_set_irq_type(unsigned int virq, unsigned int flow_type)
 /* level interrupts and edge interrupts have different ack operations */
 static struct irq_chip ipic_level_irq_chip = {
 	.name		= "IPIC",
-	.unmask		= ipic_unmask_irq,
-	.mask		= ipic_mask_irq,
-	.mask_ack	= ipic_mask_irq,
-	.set_type	= ipic_set_irq_type,
+	.irq_unmask	= ipic_unmask_irq,
+	.irq_mask	= ipic_mask_irq,
+	.irq_mask_ack	= ipic_mask_irq,
+	.irq_set_type	= ipic_set_irq_type,
 };
 
 static struct irq_chip ipic_edge_irq_chip = {
 	.name		= "IPIC",
-	.unmask		= ipic_unmask_irq,
-	.mask		= ipic_mask_irq,
-	.mask_ack	= ipic_mask_irq_and_ack,
-	.ack		= ipic_ack_irq,
-	.set_type	= ipic_set_irq_type,
+	.irq_unmask	= ipic_unmask_irq,
+	.irq_mask	= ipic_mask_irq,
+	.irq_mask_ack	= ipic_mask_irq_and_ack,
+	.irq_ack	= ipic_ack_irq,
+	.irq_set_type	= ipic_set_irq_type,
 };
 
 static int ipic_host_match(struct irq_host *h, struct device_node *node)
-- 
1.7.4
