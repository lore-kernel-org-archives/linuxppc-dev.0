Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <41400bb89c154723f795e998d5ac777345eb9ebc.1185366282.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/5] Add an optional device_node pointer to the irq_host
Date: Wed, 25 Jul 2007 22:24:53 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The majority of irq_host implementations (3 out of 4) are associated
with a device_node, and need to stash it somewhere. Rather than having
it somewhere different for each host, add an optional device_node pointer
to the irq_host structure.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c                 |    4 +++-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    5 ++---
 arch/powerpc/platforms/82xx/mpc82xx_ads.c |    7 ++-----
 arch/powerpc/platforms/cell/axon_msi.c    |   14 +++++---------
 arch/powerpc/platforms/cell/interrupt.c   |    2 +-
 arch/powerpc/platforms/cell/spider-pic.c  |   18 +++++++-----------
 arch/powerpc/platforms/celleb/interrupt.c |    2 +-
 arch/powerpc/platforms/iseries/irq.c      |    3 ++-
 arch/powerpc/platforms/powermac/pic.c     |    2 +-
 arch/powerpc/platforms/ps3/interrupt.c    |    2 +-
 arch/powerpc/platforms/pseries/xics.c     |    2 +-
 arch/powerpc/sysdev/commproc.c            |    8 +++-----
 arch/powerpc/sysdev/cpm2_pic.c            |    7 +++----
 arch/powerpc/sysdev/i8259.c               |    8 +++-----
 arch/powerpc/sysdev/ipic.c                |    7 ++-----
 arch/powerpc/sysdev/ipic.h                |    3 ---
 arch/powerpc/sysdev/mpc8xx_pic.c          |   19 ++++++++++---------
 arch/powerpc/sysdev/mpic.c                |   11 ++++-------
 arch/powerpc/sysdev/mpic_msi.c            |    7 ++++---
 arch/powerpc/sysdev/mv64x60_pic.c         |    8 +++-----
 arch/powerpc/sysdev/qe_lib/qe_ic.c        |    7 ++-----
 arch/powerpc/sysdev/qe_lib/qe_ic.h        |    3 ---
 arch/powerpc/sysdev/tsi108_pci.c          |    8 ++++----
 arch/powerpc/sysdev/uic.c                 |   11 +++--------
 include/asm-powerpc/irq.h                 |    8 ++++++--
 include/asm-powerpc/mpic.h                |    3 ---
 26 files changed, 73 insertions(+), 106 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 2fc8786..31d1de7 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -418,7 +418,8 @@ irq_hw_number_t virq_to_hw(unsigned int virq)
 }
 EXPORT_SYMBOL_GPL(virq_to_hw);
 
-struct irq_host *irq_alloc_host(unsigned int revmap_type,
+struct irq_host *irq_alloc_host(struct device_node *of_node,
+				unsigned int revmap_type,
 				unsigned int revmap_arg,
 				struct irq_host_ops *ops,
 				irq_hw_number_t inval_irq)
@@ -446,6 +447,7 @@ struct irq_host *irq_alloc_host(unsigned int revmap_type,
 	host->revmap_type = revmap_type;
 	host->inval_irq = inval_irq;
 	host->ops = ops;
+	host->of_node = of_node;
 
 	spin_lock_irqsave(&irq_big_lock, flags);
 
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index fbfff95..6332940 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -245,7 +245,7 @@ static struct irq_chip mpc52xx_sdma_irqchip = {
 static int mpc52xx_irqhost_match(struct irq_host *h, struct device_node *node)
 {
 	pr_debug("%s: node=%p\n", __func__, node);
-	return mpc52xx_irqhost->host_data == node;
+	return h->of_node == node;
 }
 
 static int mpc52xx_irqhost_xlate(struct irq_host *h, struct device_node *ct,
@@ -420,14 +420,13 @@ void __init mpc52xx_init_irq(void)
 	 * hw irq information provided by the ofw to linux virq
 	 */
 
-	mpc52xx_irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR,
+	mpc52xx_irqhost = irq_alloc_host(picnode, IRQ_HOST_MAP_LINEAR,
 	                                 MPC52xx_IRQ_HIGHTESTHWIRQ,
 	                                 &mpc52xx_irqhost_ops, -1);
 
 	if (!mpc52xx_irqhost)
 		panic(__FILE__ ": Cannot allocate the IRQ host\n");
 
-	mpc52xx_irqhost->host_data = picnode;
 	printk(KERN_INFO "MPC52xx PIC is up and running!\n");
 }
 
diff --git a/arch/powerpc/platforms/82xx/mpc82xx_ads.c b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
index da20832..65721bf 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -62,7 +62,6 @@ static struct {
 
 static unsigned long pci_int_base;
 static struct irq_host *pci_pic_host;
-static struct device_node *pci_pic_node;
 #endif
 
 static void __init mpc82xx_ads_pic_init(void)
@@ -402,7 +401,7 @@ m82xx_pci_irq_demux(unsigned int irq, struct irq_desc *desc)
 
 static int pci_pic_host_match(struct irq_host *h, struct device_node *node)
 {
-	return node == pci_pic_node;
+	return h->of_node == node;
 }
 
 static int pci_pic_host_map(struct irq_host *h, unsigned int virq,
@@ -479,7 +478,6 @@ void m82xx_pci_init_irq(void)
 		iounmap(immap);
 		return;
 	}
-	pci_pic_node = of_node_get(np);
 	/* PCI interrupt controller registers: status and mask */
 	regs = of_get_property(np, "reg", &size);
 	if ((!regs) || (size <= 2)) {
@@ -491,7 +489,6 @@ void m82xx_pci_init_irq(void)
 	    ioremap(regs[0], sizeof(*pci_regs.pci_int_stat_reg));
 	pci_regs.pci_int_mask_reg =
 	    ioremap(regs[1], sizeof(*pci_regs.pci_int_mask_reg));
-	of_node_put(np);
 	/* configure chip select for PCI interrupt controller */
 	immap->im_memctl.memc_br3 = regs[0] | 0x00001801;
 	immap->im_memctl.memc_or3 = 0xffff8010;
@@ -502,7 +499,7 @@ void m82xx_pci_init_irq(void)
 	*pci_regs.pci_int_mask_reg |= 0xfff00000;
 	iounmap(immap);
 	pci_pic_host =
-	    irq_alloc_host(IRQ_HOST_MAP_LINEAR, irq_max - irq_min + 1,
+	    irq_alloc_host(np, IRQ_HOST_MAP_LINEAR, irq_max - irq_min + 1,
 			   &pci_pic_host_ops, irq_max + 1);
 	return;
 }
diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 4c9ab5b..bdd97bb 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -64,7 +64,6 @@
 
 
 struct axon_msic {
-	struct device_node *dn;
 	struct irq_host *irq_host;
 	__le32 *fifo;
 	dcr_host_t dcr_host;
@@ -297,9 +296,7 @@ static int msic_host_map(struct irq_host *h, unsigned int virq,
 
 static int msic_host_match(struct irq_host *host, struct device_node *dn)
 {
-	struct axon_msic *msic = host->host_data;
-
-	return msic->dn == dn;
+	return host->of_node == dn;
 }
 
 static struct irq_host_ops msic_host_ops = {
@@ -314,7 +311,8 @@ static int axon_msi_notify_reboot(struct notifier_block *nb,
 	u32 tmp;
 
 	list_for_each_entry(msic, &axon_msic_list, list) {
-		pr_debug("axon_msi: disabling %s\n", msic->dn->full_name);
+		pr_debug("axon_msi: disabling %s\n",
+			  msic->irq_host->of_node->full_name);
 		tmp  = msic_dcr_read(msic, MSIC_CTRL_REG);
 		tmp &= ~MSIC_CTRL_ENABLE & ~MSIC_CTRL_IRQ_ENABLE;
 		msic_dcr_write(msic, MSIC_CTRL_REG, tmp);
@@ -370,8 +368,8 @@ static int axon_msi_setup_one(struct device_node *dn)
 
 	msic->fifo = page_address(page);
 
-	msic->irq_host = irq_alloc_host(IRQ_HOST_MAP_NOMAP, NR_IRQS,
-					&msic_host_ops, 0);
+	msic->irq_host = irq_alloc_host(of_node_get(dn), IRQ_HOST_MAP_NOMAP,
+					NR_IRQS, &msic_host_ops, 0);
 	if (!msic->irq_host) {
 		printk(KERN_ERR "axon_msi: couldn't allocate irq_host for %s\n",
 		       dn->full_name);
@@ -387,8 +385,6 @@ static int axon_msi_setup_one(struct device_node *dn)
 		goto out_free_host;
 	}
 
-	msic->dn = of_node_get(dn);
-
 	set_irq_data(virq, msic);
 	set_irq_chained_handler(virq, axon_msi_cascade);
 	pr_debug("axon_msi: irq 0x%x setup for axon_msi\n", virq);
diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index 47264e7..c29e634 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -381,7 +381,7 @@ static int __init setup_iic(void)
 void __init iic_init_IRQ(void)
 {
 	/* Setup an irq host data structure */
-	iic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, IIC_SOURCE_COUNT,
+	iic_host = irq_alloc_host(NULL, IRQ_HOST_MAP_LINEAR, IIC_SOURCE_COUNT,
 				  &iic_host_ops, IIC_IRQ_INVALID);
 	BUG_ON(iic_host == NULL);
 	irq_set_default_host(iic_host);
diff --git a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/platforms/cell/spider-pic.c
index 05f4b3d..4309c2c 100644
--- a/arch/powerpc/platforms/cell/spider-pic.c
+++ b/arch/powerpc/platforms/cell/spider-pic.c
@@ -63,7 +63,6 @@ enum {
 
 struct spider_pic {
 	struct irq_host		*host;
-	struct device_node	*of_node;
 	void __iomem		*regs;
 	unsigned int		node_id;
 };
@@ -178,8 +177,7 @@ static struct irq_chip spider_pic = {
 
 static int spider_host_match(struct irq_host *h, struct device_node *node)
 {
-	struct spider_pic *pic = h->host_data;
-	return node == pic->of_node;
+	return h->of_node == node;
 }
 
 static int spider_host_map(struct irq_host *h, unsigned int virq,
@@ -247,18 +245,18 @@ static unsigned int __init spider_find_cascade_and_node(struct spider_pic *pic)
 	 * tree in case the device-tree is ever fixed
 	 */
 	struct of_irq oirq;
-	if (of_irq_map_one(pic->of_node, 0, &oirq) == 0) {
+	if (of_irq_map_one(pic->host->of_node, 0, &oirq) == 0) {
 		virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
 					     oirq.size);
 		return virq;
 	}
 
 	/* Now do the horrible hacks */
-	tmp = of_get_property(pic->of_node, "#interrupt-cells", NULL);
+	tmp = of_get_property(pic->host->of_node, "#interrupt-cells", NULL);
 	if (tmp == NULL)
 		return NO_IRQ;
 	intsize = *tmp;
-	imap = of_get_property(pic->of_node, "interrupt-map", &imaplen);
+	imap = of_get_property(pic->host->of_node, "interrupt-map", &imaplen);
 	if (imap == NULL || imaplen < (intsize + 1))
 		return NO_IRQ;
 	iic = of_find_node_by_phandle(imap[intsize]);
@@ -308,15 +306,13 @@ static void __init spider_init_one(struct device_node *of_node, int chip,
 		panic("spider_pic: can't map registers !");
 
 	/* Allocate a host */
-	pic->host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, SPIDER_SRC_COUNT,
-				   &spider_host_ops, SPIDER_IRQ_INVALID);
+	pic->host = irq_alloc_host(of_node_get(of_node), IRQ_HOST_MAP_LINEAR,
+				   SPIDER_SRC_COUNT, &spider_host_ops,
+				   SPIDER_IRQ_INVALID);
 	if (pic->host == NULL)
 		panic("spider_pic: can't allocate irq host !");
 	pic->host->host_data = pic;
 
-	/* Fill out other bits */
-	pic->of_node = of_node_get(of_node);
-
 	/* Go through all sources and disable them */
 	for (i = 0; i < SPIDER_SRC_COUNT; i++) {
 		void __iomem *cfg = pic->regs + TIR_CFGA + 8 * i;
diff --git a/arch/powerpc/platforms/celleb/interrupt.c b/arch/powerpc/platforms/celleb/interrupt.c
index 98e6665..4ecdf06 100644
--- a/arch/powerpc/platforms/celleb/interrupt.c
+++ b/arch/powerpc/platforms/celleb/interrupt.c
@@ -242,7 +242,7 @@ void __init beatic_init_IRQ(void)
 	ppc_md.get_irq = beatic_get_irq;
 
 	/* Allocate an irq host */
-	beatic_host = irq_alloc_host(IRQ_HOST_MAP_NOMAP, 0,
+	beatic_host = irq_alloc_host(NULL, IRQ_HOST_MAP_NOMAP, 0,
 					 &beatic_pic_host_ops,
 					 0);
 	BUG_ON(beatic_host == NULL);
diff --git a/arch/powerpc/platforms/iseries/irq.c b/arch/powerpc/platforms/iseries/irq.c
index 63b3367..3666746 100644
--- a/arch/powerpc/platforms/iseries/irq.c
+++ b/arch/powerpc/platforms/iseries/irq.c
@@ -369,7 +369,8 @@ void __init iSeries_init_IRQ(void)
 	/* Create irq host. No need for a revmap since HV will give us
 	 * back our virtual irq number
 	 */
-	host = irq_alloc_host(IRQ_HOST_MAP_NOMAP, 0, &iseries_irq_host_ops, 0);
+	host = irq_alloc_host(NULL, IRQ_HOST_MAP_NOMAP, 0,
+			      &iseries_irq_host_ops, 0);
 	BUG_ON(host == NULL);
 	irq_set_default_host(host);
 
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 87cd680..999f5e1 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -384,7 +384,7 @@ static void __init pmac_pic_probe_oldstyle(void)
 	/*
 	 * Allocate an irq host
 	 */
-	pmac_pic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, max_irqs,
+	pmac_pic_host = irq_alloc_host(master, IRQ_HOST_MAP_LINEAR, max_irqs,
 				       &pmac_pic_host_ops,
 				       max_irqs);
 	BUG_ON(pmac_pic_host == NULL);
diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index 67e32ec..30b9f4c 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -726,7 +726,7 @@ void __init ps3_init_IRQ(void)
 	unsigned cpu;
 	struct irq_host *host;
 
-	host = irq_alloc_host(IRQ_HOST_MAP_NOMAP, 0, &ps3_host_ops,
+	host = irq_alloc_host(NULL, IRQ_HOST_MAP_NOMAP, 0, &ps3_host_ops,
 		PS3_INVALID_OUTLET);
 	irq_set_default_host(host);
 	irq_set_virq_count(PS3_PLUG_MAX + 1);
diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index 5bd90a7..5ddb025 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -540,7 +540,7 @@ static void __init xics_init_host(void)
 		ops = &xics_host_lpar_ops;
 	else
 		ops = &xics_host_direct_ops;
-	xics_host = irq_alloc_host(IRQ_HOST_MAP_TREE, 0, ops,
+	xics_host = irq_alloc_host(NULL, IRQ_HOST_MAP_TREE, 0, ops,
 				   XICS_IRQ_SPURIOUS);
 	BUG_ON(xics_host == NULL);
 	irq_set_default_host(xics_host);
diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index 4f67b89..ed5f77a 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -50,7 +50,6 @@ static	uint	host_end;	/* end + 1 */
 cpm8xx_t	*cpmp;		/* Pointer to comm processor space */
 cpic8xx_t	*cpic_reg;
 
-static struct device_node *cpm_pic_node;
 static struct irq_host *cpm_pic_host;
 
 static void cpm_mask_irq(unsigned int irq)
@@ -97,7 +96,7 @@ int cpm_get_irq(void)
 
 static int cpm_pic_host_match(struct irq_host *h, struct device_node *node)
 {
-	return cpm_pic_node == node;
+	return h->of_node == node;
 }
 
 static int cpm_pic_host_map(struct irq_host *h, unsigned int virq,
@@ -165,9 +164,8 @@ unsigned int cpm_pic_init(void)
 
 	out_be32(&cpic_reg->cpic_cimr, 0);
 
-	cpm_pic_node = of_node_get(np);
-
-	cpm_pic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 64, &cpm_pic_host_ops, 64);
+	cpm_pic_host = irq_alloc_host(of_node_get(np), IRQ_HOST_MAP_LINEAR,
+				      64, &cpm_pic_host_ops, 64);
 	if (cpm_pic_host == NULL) {
 		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
 		sirq = NO_IRQ;
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index eabfe06..d9ab30c 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -50,7 +50,6 @@
 
 static intctl_cpm2_t *cpm2_intctl;
 
-static struct device_node *cpm2_pic_node;
 static struct irq_host *cpm2_pic_host;
 #define NR_MASK_WORDS   ((NR_IRQS + 31) / 32)
 static unsigned long ppc_cached_irq_mask[NR_MASK_WORDS];
@@ -208,7 +207,7 @@ unsigned int cpm2_get_irq(void)
 
 static int cpm2_pic_host_match(struct irq_host *h, struct device_node *node)
 {
-	return cpm2_pic_node == node;
+	return h->of_node == node;
 }
 
 static int cpm2_pic_host_map(struct irq_host *h, unsigned int virq,
@@ -273,8 +272,8 @@ void cpm2_pic_init(struct device_node *node)
 	out_be32(&cpm2_intctl->ic_scprrl, 0x05309770);
 
 	/* create a legacy host */
-	cpm2_pic_node = of_node_get(node);
-	cpm2_pic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 64, &cpm2_pic_host_ops, 64);
+	cpm2_pic_host = irq_alloc_host(of_node_get(node), IRQ_HOST_MAP_LINEAR,
+				       64, &cpm2_pic_host_ops, 64);
 	if (cpm2_pic_host == NULL) {
 		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
 		return;
diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index ad87adc..7c1b27a 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -25,7 +25,6 @@ static unsigned char cached_8259[2] = { 0xff, 0xff };
 
 static DEFINE_SPINLOCK(i8259_lock);
 
-static struct device_node *i8259_node;
 static struct irq_host *i8259_host;
 
 /*
@@ -165,7 +164,7 @@ static struct resource pic_edgectrl_iores = {
 
 static int i8259_host_match(struct irq_host *h, struct device_node *node)
 {
-	return i8259_node == NULL || i8259_node == node;
+	return h->of_node == NULL || h->of_node == node;
 }
 
 static int i8259_host_map(struct irq_host *h, unsigned int virq,
@@ -276,9 +275,8 @@ void i8259_init(struct device_node *node, unsigned long intack_addr)
 	spin_unlock_irqrestore(&i8259_lock, flags);
 
 	/* create a legacy host */
-	if (node)
-		i8259_node = of_node_get(node);
-	i8259_host = irq_alloc_host(IRQ_HOST_MAP_LEGACY, 0, &i8259_host_ops, 0);
+	i8259_host = irq_alloc_host(of_node_get(node), IRQ_HOST_MAP_LEGACY,
+				    0, &i8259_host_ops, 0);
 	if (i8259_host == NULL) {
 		printk(KERN_ERR "i8259: failed to allocate irq host !\n");
 		return;
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 473c415..05a56e5 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -511,10 +511,8 @@ static struct irq_chip ipic_irq_chip = {
 
 static int ipic_host_match(struct irq_host *h, struct device_node *node)
 {
-	struct ipic *ipic = h->host_data;
-
 	/* Exact match, unless ipic node is NULL */
-	return ipic->of_node == NULL || ipic->of_node == node;
+	return h->of_node == NULL || h->of_node == node;
 }
 
 static int ipic_host_map(struct irq_host *h, unsigned int virq,
@@ -568,9 +566,8 @@ struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
 		return NULL;
 
 	memset(ipic, 0, sizeof(struct ipic));
-	ipic->of_node = of_node_get(node);
 
-	ipic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR,
+	ipic->irqhost = irq_alloc_host(of_node_get(node), IRQ_HOST_MAP_LINEAR,
 				       NR_IPIC_INTS,
 				       &ipic_host_ops, 0);
 	if (ipic->irqhost == NULL) {
diff --git a/arch/powerpc/sysdev/ipic.h b/arch/powerpc/sysdev/ipic.h
index c28e589..bb309a5 100644
--- a/arch/powerpc/sysdev/ipic.h
+++ b/arch/powerpc/sysdev/ipic.h
@@ -48,9 +48,6 @@ struct ipic {
 
 	/* The "linux" controller struct */
 	struct irq_chip		hc_irq;
-
-	/* The device node of the interrupt controller */
-	struct device_node	*of_node;
 };
 
 struct ipic_info {
diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_pic.c
index 2fc2bcd..f20a4d4 100644
--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -19,7 +19,6 @@
 
 extern int cpm_get_irq(struct pt_regs *regs);
 
-static struct device_node *mpc8xx_pic_node;
 static struct irq_host *mpc8xx_pic_host;
 #define NR_MASK_WORDS   ((NR_IRQS + 31) / 32)
 static unsigned long ppc_cached_irq_mask[NR_MASK_WORDS];
@@ -122,7 +121,7 @@ unsigned int mpc8xx_get_irq(void)
 
 static int mpc8xx_pic_host_match(struct irq_host *h, struct device_node *node)
 {
-	return mpc8xx_pic_node == node;
+	return h->of_node == node;
 }
 
 static int mpc8xx_pic_host_map(struct irq_host *h, unsigned int virq,
@@ -176,22 +175,24 @@ int mpc8xx_pic_init(void)
 		return -ENOMEM;
 	}
 
-	mpc8xx_pic_node = of_node_get(np);
-
 	ret = of_address_to_resource(np, 0, &res);
-	of_node_put(np);
 	if (ret)
-		return ret;
+		goto out;
 
 	siu_reg = (void *)ioremap(res.start, res.end - res.start + 1);
-	if (siu_reg == NULL)
-		return -EINVAL;
+	if (siu_reg == NULL) {
+		ret = -EINVAL;
+		goto out;
+	}
 
-	mpc8xx_pic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 64, &mpc8xx_pic_host_ops, 64);
+	mpc8xx_pic_host = irq_alloc_host(of_node_get(np), IRQ_HOST_MAP_LINEAR,
+					 64, &mpc8xx_pic_host_ops, 64);
 	if (mpc8xx_pic_host == NULL) {
 		printk(KERN_ERR "MPC8xx PIC: failed to allocate irq host!\n");
 		ret = -ENOMEM;
 	}
 
+out:
+	of_node_put(np);
 	return ret;
 }
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 74c64c0..25a81f7 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -271,7 +271,7 @@ static void _mpic_map_dcr(struct mpic *mpic, struct mpic_reg_bank *rb,
 {
 	rb->dbase = mpic->dcr_base;
 	rb->doff = offset;
-	rb->dhost = dcr_map(mpic->of_node, rb->dbase + rb->doff, size);
+	rb->dhost = dcr_map(mpic->irqhost->of_node, rb->dbase + rb->doff, size);
 	BUG_ON(!DCR_MAP_OK(rb->dhost));
 }
 
@@ -861,10 +861,8 @@ static struct irq_chip mpic_irq_ht_chip = {
 
 static int mpic_host_match(struct irq_host *h, struct device_node *node)
 {
-	struct mpic *mpic = h->host_data;
-
 	/* Exact match, unless mpic node is NULL */
-	return mpic->of_node == NULL || mpic->of_node == node;
+	return h->of_node == NULL || h->of_node == node;
 }
 
 static int mpic_host_map(struct irq_host *h, unsigned int virq,
@@ -985,10 +983,9 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	
 	memset(mpic, 0, sizeof(struct mpic));
 	mpic->name = name;
-	mpic->of_node = of_node_get(node);
 
-	mpic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR, isu_size,
-				       &mpic_host_ops,
+	mpic->irqhost = irq_alloc_host(of_node_get(node), IRQ_HOST_MAP_LINEAR,
+				       isu_size, &mpic_host_ops,
 				       flags & MPIC_LARGE_VECTORS ? 2048 : 256);
 	if (mpic->irqhost == NULL) {
 		of_node_put(node);
diff --git a/arch/powerpc/sysdev/mpic_msi.c b/arch/powerpc/sysdev/mpic_msi.c
index b076793..9ca4d8f 100644
--- a/arch/powerpc/sysdev/mpic_msi.c
+++ b/arch/powerpc/sysdev/mpic_msi.c
@@ -117,16 +117,17 @@ static int mpic_msi_reserve_dt_hwirqs(struct mpic *mpic)
 	int i, len;
 	const u32 *p;
 
-	p = of_get_property(mpic->of_node, "msi-available-ranges", &len);
+	p = of_get_property(mpic->irqhost->of_node,
+			    "msi-available-ranges", &len);
 	if (!p) {
 		pr_debug("mpic: no msi-available-ranges property found on %s\n",
-			  mpic->of_node->full_name);
+			  mpic->irqhost->of_node->full_name);
 		return -ENODEV;
 	}
 
 	if (len % 8 != 0) {
 		printk(KERN_WARNING "mpic: Malformed msi-available-ranges "
-		       "property on %s\n", mpic->of_node->full_name);
+		       "property on %s\n", mpic->irqhost->of_node->full_name);
 		return -EINVAL;
 	}
 
diff --git a/arch/powerpc/sysdev/mv64x60_pic.c b/arch/powerpc/sysdev/mv64x60_pic.c
index 01d3162..a145bfd 100644
--- a/arch/powerpc/sysdev/mv64x60_pic.c
+++ b/arch/powerpc/sysdev/mv64x60_pic.c
@@ -204,7 +204,7 @@ static struct irq_chip mv64x60_chip_gpp = {
 
 static int mv64x60_host_match(struct irq_host *h, struct device_node *np)
 {
-	return mv64x60_irq_host->host_data == np;
+	return h->of_node == np;
 }
 
 static struct irq_chip *mv64x60_chips[] = {
@@ -253,14 +253,12 @@ void __init mv64x60_init_irq(void)
 	np = of_find_compatible_node(NULL, NULL, "marvell,mv64x60-pic");
 	reg = of_get_property(np, "reg", &size);
 	paddr = of_translate_address(np, reg);
-	of_node_put(np);
 	mv64x60_irq_reg_base = ioremap(paddr, reg[1]);
 
-	mv64x60_irq_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, MV64x60_NUM_IRQS,
+	mv64x60_irq_host = irq_alloc_host(np, IRQ_HOST_MAP_LINEAR,
+					  MV64x60_NUM_IRQS,
 					  &mv64x60_host_ops, MV64x60_NUM_IRQS);
 
-	mv64x60_irq_host->host_data = np;
-
 	spin_lock_irqsave(&mv64x60_lock, flags);
 	out_le32(mv64x60_gpp_reg_base + MV64x60_GPP_INTR_MASK,
 		 mv64x60_cached_gpp_mask);
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 4d1dcb4..55e6f39 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -245,10 +245,8 @@ static struct irq_chip qe_ic_irq_chip = {
 
 static int qe_ic_host_match(struct irq_host *h, struct device_node *node)
 {
-	struct qe_ic *qe_ic = h->host_data;
-
 	/* Exact match, unless qe_ic node is NULL */
-	return qe_ic->of_node == NULL || qe_ic->of_node == node;
+	return h->of_node == NULL || h->of_node == node;
 }
 
 static int qe_ic_host_map(struct irq_host *h, unsigned int virq,
@@ -352,9 +350,8 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags)
 		return;
 
 	memset(qe_ic, 0, sizeof(struct qe_ic));
-	qe_ic->of_node = of_node_get(node);
 
-	qe_ic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR,
+	qe_ic->irqhost = irq_alloc_host(of_node_get(node), IRQ_HOST_MAP_LINEAR,
 					NR_QE_IC_INTS, &qe_ic_host_ops, 0);
 	if (qe_ic->irqhost == NULL) {
 		of_node_put(node);
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.h b/arch/powerpc/sysdev/qe_lib/qe_ic.h
index 9a631ad..c1361d0 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.h
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.h
@@ -84,9 +84,6 @@ struct qe_ic {
 	/* The "linux" controller struct */
 	struct irq_chip hc_irq;
 
-	/* The device node of the interrupt controller */
-	struct device_node *of_node;
-
 	/* VIRQ numbers of QE high/low irqs */
 	unsigned int virq_high;
 	unsigned int virq_low;
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 90db8a7..f57dc0f 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -52,7 +52,6 @@
 u32 tsi108_pci_cfg_base;
 static u32 tsi108_pci_cfg_phys;
 u32 tsi108_csr_vir_base;
-static struct device_node *pci_irq_node;
 static struct irq_host *pci_irq_host;
 
 extern u32 get_vir_csrbase(void);
@@ -407,7 +406,7 @@ static int pci_irq_host_map(struct irq_host *h, unsigned int virq,
 
 static int pci_irq_host_match(struct irq_host *h, struct device_node *node)
 {
-	return pci_irq_node == node;
+	return h->of_node == node;
 }
 
 static struct irq_host_ops pci_irq_host_ops = {
@@ -433,10 +432,11 @@ void __init tsi108_pci_int_init(struct device_node *node)
 {
 	DBG("Tsi108_pci_int_init: initializing PCI interrupts\n");
 
-	pci_irq_node = of_node_get(node);
-	pci_irq_host = irq_alloc_host(IRQ_HOST_MAP_LEGACY, 0, &pci_irq_host_ops, 0);
+	pci_irq_host = irq_alloc_host(of_node_get(node), IRQ_HOST_MAP_LEGACY,
+				      0, &pci_irq_host_ops, 0);
 	if (pci_irq_host == NULL) {
 		printk(KERN_ERR "pci_irq_host: failed to allocate irq host !\n");
+		of_node_put(node);
 		return;
 	}
 
diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index 8905989..3d8ebc7 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -55,9 +55,6 @@ struct uic {
 
 	/* For secondary UICs, the cascade interrupt's irqaction */
 	struct irqaction cascade;
-
-	/* The device node of the interrupt controller */
-	struct device_node *of_node;
 };
 
 static void uic_unmask_irq(unsigned int virq)
@@ -161,8 +158,7 @@ static struct irq_chip uic_irq_chip = {
 
 static int uic_host_match(struct irq_host *h, struct device_node *node)
 {
-	struct uic *uic = h->host_data;
-	return uic->of_node == node;
+	return h->of_node == node;
 }
 
 static int uic_host_map(struct irq_host *h, unsigned int virq,
@@ -229,7 +225,6 @@ static struct uic * __init uic_init_one(struct device_node *node)
 
 	memset(uic, 0, sizeof(*uic));
 	spin_lock_init(&uic->lock);
-	uic->of_node = of_node_get(node);
 	indexp = of_get_property(node, "cell-index", &len);
 	if (!indexp || (len != sizeof(u32))) {
 		printk(KERN_ERR "uic: Device node %s has missing or invalid "
@@ -246,8 +241,8 @@ static struct uic * __init uic_init_one(struct device_node *node)
 	}
 	uic->dcrbase = *dcrreg;
 
-	uic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR, NR_UIC_INTS,
-				      &uic_host_ops, -1);
+	uic->irqhost = irq_alloc_host(of_node_get(node), IRQ_HOST_MAP_LINEAR,
+				      NR_UIC_INTS, &uic_host_ops, -1);
 	if (! uic->irqhost) {
 		of_node_put(node);
 		return NULL; /* FIXME: panic? */
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index 0485c53..1392db4 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -124,6 +124,9 @@ struct irq_host {
 	struct irq_host_ops	*ops;
 	void			*host_data;
 	irq_hw_number_t		inval_irq;
+
+	/* Optional device node pointer */
+	struct device_node	*of_node;
 };
 
 /* The main irq map itself is an array of NR_IRQ entries containing the
@@ -142,7 +145,7 @@ extern irq_hw_number_t virq_to_hw(unsigned int virq);
 
 /**
  * irq_alloc_host - Allocate a new irq_host data structure
- * @node: device-tree node of the interrupt controller
+ * @of_node: optional device-tree node of the interrupt controller
  * @revmap_type: type of reverse mapping to use
  * @revmap_arg: for IRQ_HOST_MAP_LINEAR linear only: size of the map
  * @ops: map/unmap host callbacks
@@ -156,7 +159,8 @@ extern irq_hw_number_t virq_to_hw(unsigned int virq);
  * later during boot automatically (the reverse mapping will use the slow path
  * until that happens).
  */
-extern struct irq_host *irq_alloc_host(unsigned int revmap_type,
+extern struct irq_host *irq_alloc_host(struct device_node *of_node,
+				       unsigned int revmap_type,
 				       unsigned int revmap_arg,
 				       struct irq_host_ops *ops,
 				       irq_hw_number_t inval_irq);
diff --git a/include/asm-powerpc/mpic.h b/include/asm-powerpc/mpic.h
index 262db6b..0eb3ab9 100644
--- a/include/asm-powerpc/mpic.h
+++ b/include/asm-powerpc/mpic.h
@@ -240,9 +240,6 @@ struct mpic_irq_save {
 /* The instance data of a given MPIC */
 struct mpic
 {
-	/* The device node of the interrupt controller */
-	struct device_node	*of_node;
-
 	/* The remapper for this MPIC */
 	struct irq_host		*irqhost;
 
-- 
1.5.1.3.g7a33b
