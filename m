Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id AA5F91007EA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:34 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <62878c10aef005f102ed1bd1daeef80fc6e7bfb7.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:30:33 -0500
Subject: [PATCH 34/37] powerpc: axon_msi: validate msi irq via chip_data
Cc: Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of checking for rogue msi numbers via the irq_map host field
set the chip_data to h.host_data (which is the msic struct pointer)
at map and compare it in get_irq.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
---
 arch/powerpc/platforms/cell/axon_msi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 1e3329e..ac06903 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -113,7 +113,7 @@ static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
 		pr_devel("axon_msi: woff %x roff %x msi %x\n",
 			  write_offset, msic->read_offset, msi);
 
-		if (msi < NR_IRQS && virq_to_host(msi) == msic->irq_host) {
+		if (msi < NR_IRQS && irq_get_chip_data(msi) == msic) {
 			generic_handle_irq(msi);
 			msic->fifo_virt[idx] = cpu_to_le32(0xffffffff);
 		} else {
@@ -320,6 +320,7 @@ static struct irq_chip msic_irq_chip = {
 static int msic_host_map(struct irq_host *h, unsigned int virq,
 			 irq_hw_number_t hw)
 {
+	irq_set_chip_data(virq, h->host_data);
 	irq_set_chip_and_handler(virq, &msic_irq_chip, handle_simple_irq);
 
 	return 0;
-- 
1.7.0.4
