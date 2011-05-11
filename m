Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id B170B1009A0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:39 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <6ea83fba12e333c40117c273082730df930bf258.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:30:00 -0500
Subject: [PATCH 25/37] powerpc: remove trival irq_host_ops.unmap
Cc: Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These all just clear chip or chipdata fields, which will be done
by the generic code when we call irq_free_descs.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c     |    8 --------
 arch/powerpc/platforms/embedded6xx/flipper-pic.c |    7 -------
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c    |    7 -------
 arch/powerpc/platforms/ps3/interrupt.c           |    6 ------
 4 files changed, 0 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
index 5d6c34c..8ccf9ed 100644
--- a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
+++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -112,16 +112,8 @@ static int pci_pic_host_map(struct irq_host *h, unsigned int virq,
 	return 0;
 }
 
-static void pci_host_unmap(struct irq_host *h, unsigned int virq)
-{
-	/* remove chip and handler */
-	irq_set_chip_data(virq, NULL);
-	irq_set_chip(virq, NULL);
-}
-
 static struct irq_host_ops pci_pic_host_ops = {
 	.map = pci_pic_host_map,
-	.unmap = pci_host_unmap,
 };
 
 int __init pq2ads_pci_init_irq(void)
diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index 77cbe4c..f61a2dd 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -107,12 +107,6 @@ static int flipper_pic_map(struct irq_host *h, unsigned int virq,
 	return 0;
 }
 
-static void flipper_pic_unmap(struct irq_host *h, unsigned int irq)
-{
-	irq_set_chip_data(irq, NULL);
-	irq_set_chip(irq, NULL);
-}
-
 static int flipper_pic_match(struct irq_host *h, struct device_node *np)
 {
 	return 1;
@@ -121,7 +115,6 @@ static int flipper_pic_match(struct irq_host *h, struct device_node *np)
 
 static struct irq_host_ops flipper_irq_host_ops = {
 	.map = flipper_pic_map,
-	.unmap = flipper_pic_unmap,
 	.match = flipper_pic_match,
 };
 
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index 44b398b..e491917 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -100,15 +100,8 @@ static int hlwd_pic_map(struct irq_host *h, unsigned int virq,
 	return 0;
 }
 
-static void hlwd_pic_unmap(struct irq_host *h, unsigned int irq)
-{
-	irq_set_chip_data(irq, NULL);
-	irq_set_chip(irq, NULL);
-}
-
 static struct irq_host_ops hlwd_irq_host_ops = {
 	.map = hlwd_pic_map,
-	.unmap = hlwd_pic_unmap,
 };
 
 static unsigned int __hlwd_pic_get_irq(struct irq_host *h)
diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index 523bd0d..600ed2c 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -659,11 +659,6 @@ static void __maybe_unused _dump_mask(struct ps3_private *pd,
 static void dump_bmp(struct ps3_private* pd) {};
 #endif /* defined(DEBUG) */
 
-static void ps3_host_unmap(struct irq_host *h, unsigned int virq)
-{
-	irq_set_chip_data(virq, NULL);
-}
-
 static int ps3_host_map(struct irq_host *h, unsigned int virq,
 	irq_hw_number_t hwirq)
 {
@@ -683,7 +678,6 @@ static int ps3_host_match(struct irq_host *h, struct device_node *np)
 
 static struct irq_host_ops ps3_host_ops = {
 	.map = ps3_host_map,
-	.unmap = ps3_host_unmap,
 	.match = ps3_host_match,
 };
 
-- 
1.7.0.4
