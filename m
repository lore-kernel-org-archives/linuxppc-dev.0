Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id A5238DE63D
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 05:28:27 +1000 (EST)
Subject: [PATCH] Fix pq2fads irq handling with PREEMPT_RT
To: <linuxppc-dev@ozlabs.org>
Message-Id: <20080520192857.3C3E95AF22@innovsys.com>
Date: Tue, 20 May 2008 14:28:57 -0500 (CDT)
From: runet@innovsys.com (Rune Torgersen)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix interrupt threading issue on pq2fads when running with CONFIG_PREEMPT_RT

Signed-off-by: Rune Torgersen <runet@innovsys.com>

diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
index a801381..9876d7e 100644
--- a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
+++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -109,7 +109,7 @@ static int pci_pic_host_map(struct irq_host *h, unsigned int virq,
 {
 	get_irq_desc(virq)->status |= IRQ_LEVEL;
 	set_irq_chip_data(virq, h->host_data);
-	set_irq_chip(virq, &pq2ads_pci_ic);
+	set_irq_chip_and_handler(virq, &pq2ads_pci_ic, handle_level_irq);
 	return 0;
 }
 
