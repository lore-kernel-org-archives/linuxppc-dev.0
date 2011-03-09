Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EFDE4100A63
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 19:26:54 +1100 (EST)
Date: Wed, 9 Mar 2011 09:26:50 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 04/28] powerpc: platforms/82xx irq_data conversion.
Message-ID: <20110309082650.GO16649@mail.wantstofly.org>
References: <cover.1299541392.git.buytenh@wantstofly.org>
	<20110307235917.GI16649@mail.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110307235917.GI16649@mail.wantstofly.org>
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

 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c |   27 ++++++++++++-------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
index 5a55d87..926dfda 100644
--- a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
+++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -39,10 +39,10 @@ struct pq2ads_pci_pic {
 
 #define NUM_IRQS 32
 
-static void pq2ads_pci_mask_irq(unsigned int virq)
+static void pq2ads_pci_mask_irq(struct irq_data *d)
 {
-	struct pq2ads_pci_pic *priv = get_irq_chip_data(virq);
-	int irq = NUM_IRQS - virq_to_hw(virq) - 1;
+	struct pq2ads_pci_pic *priv = irq_data_get_irq_chip_data(d);
+	int irq = NUM_IRQS - virq_to_hw(d->irq) - 1;
 
 	if (irq != -1) {
 		unsigned long flags;
@@ -55,10 +55,10 @@ static void pq2ads_pci_mask_irq(unsigned int virq)
 	}
 }
 
-static void pq2ads_pci_unmask_irq(unsigned int virq)
+static void pq2ads_pci_unmask_irq(struct irq_data *d)
 {
-	struct pq2ads_pci_pic *priv = get_irq_chip_data(virq);
-	int irq = NUM_IRQS - virq_to_hw(virq) - 1;
+	struct pq2ads_pci_pic *priv = irq_data_get_irq_chip_data(d);
+	int irq = NUM_IRQS - virq_to_hw(d->irq) - 1;
 
 	if (irq != -1) {
 		unsigned long flags;
@@ -71,18 +71,17 @@ static void pq2ads_pci_unmask_irq(unsigned int virq)
 
 static struct irq_chip pq2ads_pci_ic = {
 	.name = "PQ2 ADS PCI",
-	.end = pq2ads_pci_unmask_irq,
-	.mask = pq2ads_pci_mask_irq,
-	.mask_ack = pq2ads_pci_mask_irq,
-	.ack = pq2ads_pci_mask_irq,
-	.unmask = pq2ads_pci_unmask_irq,
-	.enable = pq2ads_pci_unmask_irq,
-	.disable = pq2ads_pci_mask_irq
+	.irq_mask = pq2ads_pci_mask_irq,
+	.irq_mask_ack = pq2ads_pci_mask_irq,
+	.irq_ack = pq2ads_pci_mask_irq,
+	.irq_unmask = pq2ads_pci_unmask_irq,
+	.irq_enable = pq2ads_pci_unmask_irq,
+	.irq_disable = pq2ads_pci_mask_irq
 };
 
 static void pq2ads_pci_irq_demux(unsigned int irq, struct irq_desc *desc)
 {
-	struct pq2ads_pci_pic *priv = desc->handler_data;
+	struct pq2ads_pci_pic *priv = get_irq_desc_data(desc);
 	u32 stat, mask, pend;
 	int bit;
 
-- 
1.7.4
