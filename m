Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5009AB7200
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 10:59:15 +1100 (EST)
Date: Tue, 8 Mar 2011 00:59:11 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 02/28] powerpc: platforms/512x irq_data conversion.
Message-ID: <20110307235911.GG16649@mail.wantstofly.org>
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
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
index 4ecf4cf..fde0ea5 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
@@ -59,9 +59,9 @@ irq_to_pic_bit(unsigned int irq)
 }
 
 static void
-cpld_mask_irq(unsigned int irq)
+cpld_mask_irq(struct irq_data *d)
 {
-	unsigned int cpld_irq = (unsigned int)irq_map[irq].hwirq;
+	unsigned int cpld_irq = (unsigned int)irq_map[d->irq].hwirq;
 	void __iomem *pic_mask = irq_to_pic_mask(cpld_irq);
 
 	out_8(pic_mask,
@@ -69,9 +69,9 @@ cpld_mask_irq(unsigned int irq)
 }
 
 static void
-cpld_unmask_irq(unsigned int irq)
+cpld_unmask_irq(struct irq_data *d)
 {
-	unsigned int cpld_irq = (unsigned int)irq_map[irq].hwirq;
+	unsigned int cpld_irq = (unsigned int)irq_map[d->irq].hwirq;
 	void __iomem *pic_mask = irq_to_pic_mask(cpld_irq);
 
 	out_8(pic_mask,
@@ -80,9 +80,9 @@ cpld_unmask_irq(unsigned int irq)
 
 static struct irq_chip cpld_pic = {
 	.name = "CPLD PIC",
-	.mask = cpld_mask_irq,
-	.ack = cpld_mask_irq,
-	.unmask = cpld_unmask_irq,
+	.irq_mask = cpld_mask_irq,
+	.irq_ack = cpld_mask_irq,
+	.irq_unmask = cpld_unmask_irq,
 };
 
 static int
-- 
1.7.4
