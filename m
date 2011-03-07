Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A1D6E100A03
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 10:59:53 +1100 (EST)
Date: Tue, 8 Mar 2011 00:59:49 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 15/28] powerpc: sysdev/cpm1 irq_data conversion.
Message-ID: <20110307235949.GT16649@mail.wantstofly.org>
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
 arch/powerpc/sysdev/cpm1.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
index 0085212..0476bcc 100644
--- a/arch/powerpc/sysdev/cpm1.c
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -56,32 +56,32 @@ static cpic8xx_t __iomem *cpic_reg;
 
 static struct irq_host *cpm_pic_host;
 
-static void cpm_mask_irq(unsigned int irq)
+static void cpm_mask_irq(struct irq_data *d)
 {
-	unsigned int cpm_vec = (unsigned int)irq_map[irq].hwirq;
+	unsigned int cpm_vec = (unsigned int)irq_map[d->irq].hwirq;
 
 	clrbits32(&cpic_reg->cpic_cimr, (1 << cpm_vec));
 }
 
-static void cpm_unmask_irq(unsigned int irq)
+static void cpm_unmask_irq(struct irq_data *d)
 {
-	unsigned int cpm_vec = (unsigned int)irq_map[irq].hwirq;
+	unsigned int cpm_vec = (unsigned int)irq_map[d->irq].hwirq;
 
 	setbits32(&cpic_reg->cpic_cimr, (1 << cpm_vec));
 }
 
-static void cpm_end_irq(unsigned int irq)
+static void cpm_end_irq(struct irq_data *d)
 {
-	unsigned int cpm_vec = (unsigned int)irq_map[irq].hwirq;
+	unsigned int cpm_vec = (unsigned int)irq_map[d->irq].hwirq;
 
 	out_be32(&cpic_reg->cpic_cisr, (1 << cpm_vec));
 }
 
 static struct irq_chip cpm_pic = {
 	.name = "CPM PIC",
-	.mask = cpm_mask_irq,
-	.unmask = cpm_unmask_irq,
-	.eoi = cpm_end_irq,
+	.irq_mask = cpm_mask_irq,
+	.irq_unmask = cpm_unmask_irq,
+	.irq_eoi = cpm_end_irq,
 };
 
 int cpm_get_irq(void)
-- 
1.7.4
