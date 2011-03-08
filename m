Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 61F1CB78BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 11:00:16 +1100 (EST)
Date: Tue, 8 Mar 2011 01:00:12 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 24/28] powerpc: sysdev/tsi108_pci irq_data conversion.
Message-ID: <20110308000012.GC16649@mail.wantstofly.org>
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
 arch/powerpc/sysdev/tsi108_pci.c |   41 +++++++++++++++++--------------------
 1 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 0ab9281..02c91db 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -343,24 +343,9 @@ static inline unsigned int get_pci_source(void)
  * Linux descriptor level callbacks
  */
 
-static void tsi108_pci_irq_enable(u_int irq)
+static void tsi108_pci_irq_unmask(struct irq_data *d)
 {
-	tsi108_pci_int_unmask(irq);
-}
-
-static void tsi108_pci_irq_disable(u_int irq)
-{
-	tsi108_pci_int_mask(irq);
-}
-
-static void tsi108_pci_irq_ack(u_int irq)
-{
-	tsi108_pci_int_mask(irq);
-}
-
-static void tsi108_pci_irq_end(u_int irq)
-{
-	tsi108_pci_int_unmask(irq);
+	tsi108_pci_int_unmask(d->irq);
 
 	/* Enable interrupts from PCI block */
 	tsi108_write_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_ENABLE,
@@ -370,16 +355,25 @@ static void tsi108_pci_irq_end(u_int irq)
 	mb();
 }
 
+static void tsi108_pci_irq_mask(struct irq_data *d)
+{
+	tsi108_pci_int_mask(d->irq);
+}
+
+static void tsi108_pci_irq_ack(struct irq_data *d)
+{
+	tsi108_pci_int_mask(d->irq);
+}
+
 /*
  * Interrupt controller descriptor for cascaded PCI interrupt controller.
  */
 
 static struct irq_chip tsi108_pci_irq = {
 	.name = "tsi108_PCI_int",
-	.mask = tsi108_pci_irq_disable,
-	.ack = tsi108_pci_irq_ack,
-	.end = tsi108_pci_irq_end,
-	.unmask = tsi108_pci_irq_enable,
+	.irq_mask = tsi108_pci_irq_mask,
+	.irq_ack = tsi108_pci_irq_ack,
+	.irq_unmask = tsi108_pci_irq_unmask,
 };
 
 static int pci_irq_host_xlate(struct irq_host *h, struct device_node *ct,
@@ -437,8 +431,11 @@ void __init tsi108_pci_int_init(struct device_node *node)
 
 void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	unsigned int cascade_irq = get_pci_source();
+
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
-	desc->chip->eoi(irq);
+
+	chip->irq_eoi(&desc->irq_data);
 }
-- 
1.7.4
