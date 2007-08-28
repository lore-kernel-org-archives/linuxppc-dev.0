Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <d8c0833001b7afa8af03e28ff571692776e0c852.1188290811.git.michael@ellerman.id.au>
In-Reply-To: <460e86e8b5a08c23dcbedb5d4bd484a519246dd3.1188290811.git.michael@ellerman.id.au>
References: <460e86e8b5a08c23dcbedb5d4bd484a519246dd3.1188290811.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/5] Provide a default irq_host match,
	which matches on an exact of_node
Date: Tue, 28 Aug 2007 18:47:55 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The most common match semantic is an exact match based on the device node.
So provide a default implementation that does this, and hook it up if no
match routine is specified.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c                 |   10 +++++++++-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    7 -------
 arch/powerpc/platforms/82xx/mpc82xx_ads.c |    6 ------
 arch/powerpc/platforms/cell/axon_msi.c    |    6 ------
 arch/powerpc/platforms/cell/spider-pic.c  |    6 ------
 arch/powerpc/sysdev/commproc.c            |    6 ------
 arch/powerpc/sysdev/cpm2_pic.c            |    6 ------
 arch/powerpc/sysdev/mpc8xx_pic.c          |    6 ------
 arch/powerpc/sysdev/mv64x60_pic.c         |    6 ------
 arch/powerpc/sysdev/tsi108_pci.c          |    6 ------
 arch/powerpc/sysdev/uic.c                 |    6 ------
 11 files changed, 9 insertions(+), 62 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 30fb8e2..d5c7e4c 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -418,6 +418,11 @@ irq_hw_number_t virq_to_hw(unsigned int virq)
 }
 EXPORT_SYMBOL_GPL(virq_to_hw);
 
+static int default_irq_host_match(struct irq_host *h, struct device_node *np)
+{
+	return h->of_node != NULL && h->of_node == np;
+}
+
 __init_refok struct irq_host *irq_alloc_host(struct device_node *of_node,
 				unsigned int revmap_type,
 				unsigned int revmap_arg,
@@ -449,6 +454,9 @@ __init_refok struct irq_host *irq_alloc_host(struct device_node *of_node,
 	host->ops = ops;
 	host->of_node = of_node;
 
+	if (host->ops->match == NULL)
+		host->ops->match = default_irq_host_match;
+
 	spin_lock_irqsave(&irq_big_lock, flags);
 
 	/* If it's a legacy controller, check for duplicates and
@@ -523,7 +531,7 @@ struct irq_host *irq_find_host(struct device_node *node)
 	 */
 	spin_lock_irqsave(&irq_big_lock, flags);
 	list_for_each_entry(h, &irq_hosts, link)
-		if (h->ops->match != NULL && h->ops->match(h, node)) {
+		if (h->ops->match(h, node)) {
 			found = h;
 			break;
 		}
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 1d793e4..0f4ca8a 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -241,12 +241,6 @@ static struct irq_chip mpc52xx_sdma_irqchip = {
  * irq_host
 */
 
-static int mpc52xx_irqhost_match(struct irq_host *h, struct device_node *node)
-{
-	pr_debug("%s: node=%p\n", __func__, node);
-	return h->of_node == node;
-}
-
 static int mpc52xx_irqhost_xlate(struct irq_host *h, struct device_node *ct,
 				 u32 * intspec, unsigned int intsize,
 				 irq_hw_number_t * out_hwirq,
@@ -367,7 +361,6 @@ static int mpc52xx_irqhost_map(struct irq_host *h, unsigned int virq,
 }
 
 static struct irq_host_ops mpc52xx_irqhost_ops = {
-	.match = mpc52xx_irqhost_match,
 	.xlate = mpc52xx_irqhost_xlate,
 	.map = mpc52xx_irqhost_map,
 };
diff --git a/arch/powerpc/platforms/82xx/mpc82xx_ads.c b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
index 91ddbd2..4008795 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -398,11 +398,6 @@ m82xx_pci_irq_demux(unsigned int irq, struct irq_desc *desc)
 	}
 }
 
-static int pci_pic_host_match(struct irq_host *h, struct device_node *node)
-{
-	return h->of_node == node;
-}
-
 static int pci_pic_host_map(struct irq_host *h, unsigned int virq,
 			    irq_hw_number_t hw)
 {
@@ -418,7 +413,6 @@ static void pci_host_unmap(struct irq_host *h, unsigned int virq)
 }
 
 static struct irq_host_ops pci_pic_host_ops = {
-	.match = pci_pic_host_match,
 	.map = pci_pic_host_map,
 	.unmap = pci_host_unmap,
 };
diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index bdd97bb..74407af 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -294,13 +294,7 @@ static int msic_host_map(struct irq_host *h, unsigned int virq,
 	return 0;
 }
 
-static int msic_host_match(struct irq_host *host, struct device_node *dn)
-{
-	return host->of_node == dn;
-}
-
 static struct irq_host_ops msic_host_ops = {
-	.match	= msic_host_match,
 	.map	= msic_host_map,
 };
 
diff --git a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/platforms/cell/spider-pic.c
index 4309c2c..3f4b4ae 100644
--- a/arch/powerpc/platforms/cell/spider-pic.c
+++ b/arch/powerpc/platforms/cell/spider-pic.c
@@ -175,11 +175,6 @@ static struct irq_chip spider_pic = {
 	.set_type = spider_set_irq_type,
 };
 
-static int spider_host_match(struct irq_host *h, struct device_node *node)
-{
-	return h->of_node == node;
-}
-
 static int spider_host_map(struct irq_host *h, unsigned int virq,
 			irq_hw_number_t hw)
 {
@@ -206,7 +201,6 @@ static int spider_host_xlate(struct irq_host *h, struct device_node *ct,
 }
 
 static struct irq_host_ops spider_host_ops = {
-	.match = spider_host_match,
 	.map = spider_host_map,
 	.xlate = spider_host_xlate,
 };
diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index 05dc30b..b562afc 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -94,11 +94,6 @@ int cpm_get_irq(void)
 	return irq_linear_revmap(cpm_pic_host, cpm_vec);
 }
 
-static int cpm_pic_host_match(struct irq_host *h, struct device_node *node)
-{
-	return h->of_node == node;
-}
-
 static int cpm_pic_host_map(struct irq_host *h, unsigned int virq,
 			  irq_hw_number_t hw)
 {
@@ -126,7 +121,6 @@ static struct irqaction cpm_error_irqaction = {
 };
 
 static struct irq_host_ops cpm_pic_host_ops = {
-	.match = cpm_pic_host_match,
 	.map = cpm_pic_host_map,
 };
 
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index d9ab30c..d5b36e0 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -205,11 +205,6 @@ unsigned int cpm2_get_irq(void)
 	return irq_linear_revmap(cpm2_pic_host, irq);
 }
 
-static int cpm2_pic_host_match(struct irq_host *h, struct device_node *node)
-{
-	return h->of_node == node;
-}
-
 static int cpm2_pic_host_map(struct irq_host *h, unsigned int virq,
 			  irq_hw_number_t hw)
 {
@@ -233,7 +228,6 @@ static int cpm2_pic_host_xlate(struct irq_host *h, struct device_node *ct,
 }
 
 static struct irq_host_ops cpm2_pic_host_ops = {
-	.match = cpm2_pic_host_match,
 	.map = cpm2_pic_host_map,
 	.xlate = cpm2_pic_host_xlate,
 };
diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_pic.c
index f20a4d4..565156a 100644
--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -119,11 +119,6 @@ unsigned int mpc8xx_get_irq(void)
 
 }
 
-static int mpc8xx_pic_host_match(struct irq_host *h, struct device_node *node)
-{
-	return h->of_node == node;
-}
-
 static int mpc8xx_pic_host_map(struct irq_host *h, unsigned int virq,
 			  irq_hw_number_t hw)
 {
@@ -157,7 +152,6 @@ static int mpc8xx_pic_host_xlate(struct irq_host *h, struct device_node *ct,
 
 
 static struct irq_host_ops mpc8xx_pic_host_ops = {
-	.match = mpc8xx_pic_host_match,
 	.map = mpc8xx_pic_host_map,
 	.xlate = mpc8xx_pic_host_xlate,
 };
diff --git a/arch/powerpc/sysdev/mv64x60_pic.c b/arch/powerpc/sysdev/mv64x60_pic.c
index a145bfd..19e6ef2 100644
--- a/arch/powerpc/sysdev/mv64x60_pic.c
+++ b/arch/powerpc/sysdev/mv64x60_pic.c
@@ -202,11 +202,6 @@ static struct irq_chip mv64x60_chip_gpp = {
  * mv64x60_host_ops functions
  */
 
-static int mv64x60_host_match(struct irq_host *h, struct device_node *np)
-{
-	return h->of_node == np;
-}
-
 static struct irq_chip *mv64x60_chips[] = {
 	[MV64x60_LEVEL1_LOW]  = &mv64x60_chip_low,
 	[MV64x60_LEVEL1_HIGH] = &mv64x60_chip_high,
@@ -228,7 +223,6 @@ static int mv64x60_host_map(struct irq_host *h, unsigned int virq,
 }
 
 static struct irq_host_ops mv64x60_host_ops = {
-	.match = mv64x60_host_match,
 	.map   = mv64x60_host_map,
 };
 
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index b41492a..31d3d33 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -404,13 +404,7 @@ static int pci_irq_host_map(struct irq_host *h, unsigned int virq,
 	return 0;
 }
 
-static int pci_irq_host_match(struct irq_host *h, struct device_node *node)
-{
-	return h->of_node == node;
-}
-
 static struct irq_host_ops pci_irq_host_ops = {
-	.match = pci_irq_host_match,
 	.map = pci_irq_host_map,
 	.xlate = pci_irq_host_xlate,
 };
diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index bf37667..5149716 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -215,11 +215,6 @@ out_unlock:
 	spin_unlock(&desc->lock);
 }
 
-static int uic_host_match(struct irq_host *h, struct device_node *node)
-{
-	return h->of_node == node;
-}
-
 static int uic_host_map(struct irq_host *h, unsigned int virq,
 			irq_hw_number_t hw)
 {
@@ -249,7 +244,6 @@ static int uic_host_xlate(struct irq_host *h, struct device_node *ct,
 }
 
 static struct irq_host_ops uic_host_ops = {
-	.match	= uic_host_match,
 	.map	= uic_host_map,
 	.xlate	= uic_host_xlate,
 };
-- 
1.5.1.3.g7a33b
