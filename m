Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1CAD5100AE5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 10:59:56 +1100 (EST)
Date: Tue, 8 Mar 2011 00:59:51 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 16/28] powerpc: sysdev/cpm2_pic irq_data conversion.
Message-ID: <20110307235951.GU16649@mail.wantstofly.org>
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
 arch/powerpc/sysdev/cpm2_pic.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index fcea4ff..4730325 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -78,10 +78,10 @@ static const u_char irq_to_siubit[] = {
 	24, 25, 26, 27, 28, 29, 30, 31,
 };
 
-static void cpm2_mask_irq(unsigned int virq)
+static void cpm2_mask_irq(struct irq_data *d)
 {
 	int	bit, word;
-	unsigned int irq_nr = virq_to_hw(virq);
+	unsigned int irq_nr = virq_to_hw(d->irq);
 
 	bit = irq_to_siubit[irq_nr];
 	word = irq_to_siureg[irq_nr];
@@ -90,10 +90,10 @@ static void cpm2_mask_irq(unsigned int virq)
 	out_be32(&cpm2_intctl->ic_simrh + word, ppc_cached_irq_mask[word]);
 }
 
-static void cpm2_unmask_irq(unsigned int virq)
+static void cpm2_unmask_irq(struct irq_data *d)
 {
 	int	bit, word;
-	unsigned int irq_nr = virq_to_hw(virq);
+	unsigned int irq_nr = virq_to_hw(d->irq);
 
 	bit = irq_to_siubit[irq_nr];
 	word = irq_to_siureg[irq_nr];
@@ -102,10 +102,10 @@ static void cpm2_unmask_irq(unsigned int virq)
 	out_be32(&cpm2_intctl->ic_simrh + word, ppc_cached_irq_mask[word]);
 }
 
-static void cpm2_ack(unsigned int virq)
+static void cpm2_ack(struct irq_data *d)
 {
 	int	bit, word;
-	unsigned int irq_nr = virq_to_hw(virq);
+	unsigned int irq_nr = virq_to_hw(d->irq);
 
 	bit = irq_to_siubit[irq_nr];
 	word = irq_to_siureg[irq_nr];
@@ -113,11 +113,11 @@ static void cpm2_ack(unsigned int virq)
 	out_be32(&cpm2_intctl->ic_sipnrh + word, 1 << bit);
 }
 
-static void cpm2_end_irq(unsigned int virq)
+static void cpm2_end_irq(struct irq_data *d)
 {
 	struct irq_desc *desc;
 	int	bit, word;
-	unsigned int irq_nr = virq_to_hw(virq);
+	unsigned int irq_nr = virq_to_hw(d->irq);
 
 	desc = irq_to_desc(irq_nr);
 	if (!(desc->status & (IRQ_DISABLED|IRQ_INPROGRESS))
@@ -137,10 +137,10 @@ static void cpm2_end_irq(unsigned int virq)
 	}
 }
 
-static int cpm2_set_irq_type(unsigned int virq, unsigned int flow_type)
+static int cpm2_set_irq_type(struct irq_data *d, unsigned int flow_type)
 {
-	unsigned int src = virq_to_hw(virq);
-	struct irq_desc *desc = irq_to_desc(virq);
+	unsigned int src = virq_to_hw(d->irq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
 	unsigned int vold, vnew, edibit;
 
 	/* Port C interrupts are either IRQ_TYPE_EDGE_FALLING or
@@ -199,11 +199,11 @@ err_sense:
 
 static struct irq_chip cpm2_pic = {
 	.name = "CPM2 SIU",
-	.mask = cpm2_mask_irq,
-	.unmask = cpm2_unmask_irq,
-	.ack = cpm2_ack,
-	.eoi = cpm2_end_irq,
-	.set_type = cpm2_set_irq_type,
+	.irq_mask = cpm2_mask_irq,
+	.irq_unmask = cpm2_unmask_irq,
+	.irq_ack = cpm2_ack,
+	.irq_eoi = cpm2_end_irq,
+	.irq_set_type = cpm2_set_irq_type,
 };
 
 unsigned int cpm2_get_irq(void)
-- 
1.7.4
