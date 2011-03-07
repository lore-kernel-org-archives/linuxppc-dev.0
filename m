Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4FA38B7654
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 10:59:58 +1100 (EST)
Date: Tue, 8 Mar 2011 00:59:54 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 17/28] powerpc: sysdev/fsl_msi irq_data conversion.
Message-ID: <20110307235954.GV16649@mail.wantstofly.org>
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
 arch/powerpc/sysdev/fsl_msi.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 108d76f..f6051d7 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -47,14 +47,14 @@ static inline u32 fsl_msi_read(u32 __iomem *base, unsigned int reg)
  * We do not need this actually. The MSIR register has been read once
  * in the cascade interrupt. So, this MSI interrupt has been acked
 */
-static void fsl_msi_end_irq(unsigned int virq)
+static void fsl_msi_end_irq(struct irq_data *d)
 {
 }
 
 static struct irq_chip fsl_msi_chip = {
 	.irq_mask	= mask_msi_irq,
 	.irq_unmask	= unmask_msi_irq,
-	.ack		= fsl_msi_end_irq,
+	.irq_ack	= fsl_msi_end_irq,
 	.name		= "FSL-MSI",
 };
 
@@ -183,6 +183,7 @@ out_free:
 
 static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	unsigned int cascade_irq;
 	struct fsl_msi *msi_data;
 	int msir_index = -1;
@@ -196,11 +197,11 @@ static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 
 	raw_spin_lock(&desc->lock);
 	if ((msi_data->feature &  FSL_PIC_IP_MASK) == FSL_PIC_IP_IPIC) {
-		if (desc->chip->mask_ack)
-			desc->chip->mask_ack(irq);
+		if (chip->irq_mask_ack)
+			chip->irq_mask_ack(&desc->irq_data);
 		else {
-			desc->chip->mask(irq);
-			desc->chip->ack(irq);
+			chip->irq_mask(&desc->irq_data);
+			chip->irq_ack(&desc->irq_data);
 		}
 	}
 
@@ -238,11 +239,11 @@ static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 
 	switch (msi_data->feature & FSL_PIC_IP_MASK) {
 	case FSL_PIC_IP_MPIC:
-		desc->chip->eoi(irq);
+		chip->irq_eoi(&desc->irq_data);
 		break;
 	case FSL_PIC_IP_IPIC:
-		if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
-			desc->chip->unmask(irq);
+		if (!(desc->status & IRQ_DISABLED) && chip->irq_unmask)
+			chip->irq_unmask(&desc->irq_data);
 		break;
 	}
 unlock:
-- 
1.7.4
