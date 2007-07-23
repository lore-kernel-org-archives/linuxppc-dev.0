Return-Path: <G.Chen@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6F76FDDE36
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 21:05:51 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l6NB5jdj016857
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 04:05:45 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l6NB5fFh008974
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 06:05:44 -0500 (CDT)
From: Chen Gong <g.chen@freescale.com>
To: paulus@samba.org, galak@kernel.crashing.org
Subject: [PATCH 2/3] Add irq host name for all powerpc interrupt controllors.
Date: Mon, 23 Jul 2007 19:13:49 +0800
Message-Id: <11851892322112-git-send-email-g.chen@freescale.com>
In-Reply-To: <11851892311178-git-send-email-g.chen@freescale.com>
References: <11851892302391-git-send-email-g.chen@freescale.com>
	<11851892311178-git-send-email-g.chen@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Chen Gong <g.chen@freescale.com>,
	Chen Gong <G.Chen@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If there is an OF-tree node for the interrupt controller, we will
use ofnode->full_name as the INT controller's name.
NULL is a proper choice if there is not binding OF-tree node
for the INT controller.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Chen Gong <G.Chen@freescale.com>
---
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    2 +-
 arch/powerpc/platforms/82xx/mpc82xx_ads.c |    2 +-
 arch/powerpc/platforms/cell/interrupt.c   |    2 +-
 arch/powerpc/platforms/cell/spider-pic.c  |    2 +-
 arch/powerpc/platforms/celleb/interrupt.c |    2 +-
 arch/powerpc/platforms/iseries/irq.c      |    2 +-
 arch/powerpc/platforms/powermac/pic.c     |    2 +-
 arch/powerpc/platforms/ps3/interrupt.c    |    2 +-
 arch/powerpc/platforms/pseries/xics.c     |    2 +-
 arch/powerpc/sysdev/commproc.c            |    3 ++-
 arch/powerpc/sysdev/cpm2_pic.c            |    2 +-
 arch/powerpc/sysdev/i8259.c               |    3 ++-
 arch/powerpc/sysdev/ipic.c                |    3 ++-
 arch/powerpc/sysdev/mpc8xx_pic.c          |    2 +-
 arch/powerpc/sysdev/mpic.c                |    3 ++-
 arch/powerpc/sysdev/mv64x60_pic.c         |    3 ++-
 arch/powerpc/sysdev/qe_lib/qe_ic.c        |    3 ++-
 arch/powerpc/sysdev/tsi108_pci.c          |    2 +-
 arch/powerpc/sysdev/uic.c                 |    2 +-
 19 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index fbfff95..d5efdbc 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -422,7 +422,7 @@ void __init mpc52xx_init_irq(void)
 
 	mpc52xx_irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR,
 	                                 MPC52xx_IRQ_HIGHTESTHWIRQ,
-	                                 &mpc52xx_irqhost_ops, -1);
+	                                 &mpc52xx_irqhost_ops, -1, picnode->full_name);
 
 	if (!mpc52xx_irqhost)
 		panic(__FILE__ ": Cannot allocate the IRQ host\n");
diff --git a/arch/powerpc/platforms/82xx/mpc82xx_ads.c b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
index da20832..3e27d3d 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -503,7 +503,7 @@ void m82xx_pci_init_irq(void)
 	iounmap(immap);
 	pci_pic_host =
 	    irq_alloc_host(IRQ_HOST_MAP_LINEAR, irq_max - irq_min + 1,
-			   &pci_pic_host_ops, irq_max + 1);
+			   &pci_pic_host_ops, irq_max + 1, NULL);
 	return;
 }
 
diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index 47264e7..9768ba2 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -382,7 +382,7 @@ void __init iic_init_IRQ(void)
 {
 	/* Setup an irq host data structure */
 	iic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, IIC_SOURCE_COUNT,
-				  &iic_host_ops, IIC_IRQ_INVALID);
+				  &iic_host_ops, IIC_IRQ_INVALID, NULL);
 	BUG_ON(iic_host == NULL);
 	irq_set_default_host(iic_host);
 
diff --git a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/platforms/cell/spider-pic.c
index 05f4b3d..79c8d4f 100644
--- a/arch/powerpc/platforms/cell/spider-pic.c
+++ b/arch/powerpc/platforms/cell/spider-pic.c
@@ -309,7 +309,7 @@ static void __init spider_init_one(struct device_node *of_node, int chip,
 
 	/* Allocate a host */
 	pic->host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, SPIDER_SRC_COUNT,
-				   &spider_host_ops, SPIDER_IRQ_INVALID);
+				   &spider_host_ops, SPIDER_IRQ_INVALID, of_node->full_name);
 	if (pic->host == NULL)
 		panic("spider_pic: can't allocate irq host !");
 	pic->host->host_data = pic;
diff --git a/arch/powerpc/platforms/celleb/interrupt.c b/arch/powerpc/platforms/celleb/interrupt.c
index 98e6665..0a08a99 100644
--- a/arch/powerpc/platforms/celleb/interrupt.c
+++ b/arch/powerpc/platforms/celleb/interrupt.c
@@ -244,7 +244,7 @@ void __init beatic_init_IRQ(void)
 	/* Allocate an irq host */
 	beatic_host = irq_alloc_host(IRQ_HOST_MAP_NOMAP, 0,
 					 &beatic_pic_host_ops,
-					 0);
+					 0, NULL);
 	BUG_ON(beatic_host == NULL);
 	irq_set_default_host(beatic_host);
 }
diff --git a/arch/powerpc/platforms/iseries/irq.c b/arch/powerpc/platforms/iseries/irq.c
index 63b3367..766f5d3 100644
--- a/arch/powerpc/platforms/iseries/irq.c
+++ b/arch/powerpc/platforms/iseries/irq.c
@@ -369,7 +369,7 @@ void __init iSeries_init_IRQ(void)
 	/* Create irq host. No need for a revmap since HV will give us
 	 * back our virtual irq number
 	 */
-	host = irq_alloc_host(IRQ_HOST_MAP_NOMAP, 0, &iseries_irq_host_ops, 0);
+	host = irq_alloc_host(IRQ_HOST_MAP_NOMAP, 0, &iseries_irq_host_ops, 0, NULL);
 	BUG_ON(host == NULL);
 	irq_set_default_host(host);
 
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 87cd680..9d4b3e1 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -386,7 +386,7 @@ static void __init pmac_pic_probe_oldstyle(void)
 	 */
 	pmac_pic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, max_irqs,
 				       &pmac_pic_host_ops,
-				       max_irqs);
+				       max_irqs, NULL);
 	BUG_ON(pmac_pic_host == NULL);
 	irq_set_default_host(pmac_pic_host);
 
diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index 67e32ec..2b56b81 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -727,7 +727,7 @@ void __init ps3_init_IRQ(void)
 	struct irq_host *host;
 
 	host = irq_alloc_host(IRQ_HOST_MAP_NOMAP, 0, &ps3_host_ops,
-		PS3_INVALID_OUTLET);
+		PS3_INVALID_OUTLET, NULL);
 	irq_set_default_host(host);
 	irq_set_virq_count(PS3_PLUG_MAX + 1);
 
diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index 5bd90a7..7f8a5c7 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -541,7 +541,7 @@ static void __init xics_init_host(void)
 	else
 		ops = &xics_host_direct_ops;
 	xics_host = irq_alloc_host(IRQ_HOST_MAP_TREE, 0, ops,
-				   XICS_IRQ_SPURIOUS);
+				   XICS_IRQ_SPURIOUS, NULL);
 	BUG_ON(xics_host == NULL);
 	irq_set_default_host(xics_host);
 }
diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index 4f67b89..91dc738 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -167,7 +167,8 @@ unsigned int cpm_pic_init(void)
 
 	cpm_pic_node = of_node_get(np);
 
-	cpm_pic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 64, &cpm_pic_host_ops, 64);
+	cpm_pic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 64, &cpm_pic_host_ops, 64,
+			cpm_pic_node->full_name);
 	if (cpm_pic_host == NULL) {
 		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
 		sirq = NO_IRQ;
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index eabfe06..1aaebf8 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -274,7 +274,7 @@ void cpm2_pic_init(struct device_node *node)
 
 	/* create a legacy host */
 	cpm2_pic_node = of_node_get(node);
-	cpm2_pic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 64, &cpm2_pic_host_ops, 64);
+	cpm2_pic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 64, &cpm2_pic_host_ops, 64, cpm2_pic_node->full_name);
 	if (cpm2_pic_host == NULL) {
 		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
 		return;
diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index ad87adc..e80c127 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -278,7 +278,8 @@ void i8259_init(struct device_node *node, unsigned long intack_addr)
 	/* create a legacy host */
 	if (node)
 		i8259_node = of_node_get(node);
-	i8259_host = irq_alloc_host(IRQ_HOST_MAP_LEGACY, 0, &i8259_host_ops, 0);
+	i8259_host = irq_alloc_host(IRQ_HOST_MAP_LEGACY, 0, &i8259_host_ops, 0,
+			(node) ? i8259_node->full_name : NULL);
 	if (i8259_host == NULL) {
 		printk(KERN_ERR "i8259: failed to allocate irq host !\n");
 		return;
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 473c415..4fe6770 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -572,7 +572,8 @@ struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
 
 	ipic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR,
 				       NR_IPIC_INTS,
-				       &ipic_host_ops, 0);
+				       &ipic_host_ops, 0,
+				       ipic->of_node->full_name);
 	if (ipic->irqhost == NULL) {
 		of_node_put(node);
 		return NULL;
diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_pic.c
index 2fc2bcd..c3eb805 100644
--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -187,7 +187,7 @@ int mpc8xx_pic_init(void)
 	if (siu_reg == NULL)
 		return -EINVAL;
 
-	mpc8xx_pic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 64, &mpc8xx_pic_host_ops, 64);
+	mpc8xx_pic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 64, &mpc8xx_pic_host_ops, 64, np->full_name);
 	if (mpc8xx_pic_host == NULL) {
 		printk(KERN_ERR "MPC8xx PIC: failed to allocate irq host!\n");
 		ret = -ENOMEM;
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 74c64c0..d71441e 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -989,7 +989,8 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 
 	mpic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR, isu_size,
 				       &mpic_host_ops,
-				       flags & MPIC_LARGE_VECTORS ? 2048 : 256);
+				       flags & MPIC_LARGE_VECTORS ? 2048 : 256,
+				       mpic->of_node->full_name);
 	if (mpic->irqhost == NULL) {
 		of_node_put(node);
 		return NULL;
diff --git a/arch/powerpc/sysdev/mv64x60_pic.c b/arch/powerpc/sysdev/mv64x60_pic.c
index 01d3162..2bb5b12 100644
--- a/arch/powerpc/sysdev/mv64x60_pic.c
+++ b/arch/powerpc/sysdev/mv64x60_pic.c
@@ -257,7 +257,8 @@ void __init mv64x60_init_irq(void)
 	mv64x60_irq_reg_base = ioremap(paddr, reg[1]);
 
 	mv64x60_irq_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, MV64x60_NUM_IRQS,
-					  &mv64x60_host_ops, MV64x60_NUM_IRQS);
+					  &mv64x60_host_ops, MV64x60_NUM_IRQS,
+					  np->full_name);
 
 	mv64x60_irq_host->host_data = np;
 
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 4d1dcb4..1e78a02 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -355,7 +355,8 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags)
 	qe_ic->of_node = of_node_get(node);
 
 	qe_ic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR,
-					NR_QE_IC_INTS, &qe_ic_host_ops, 0);
+					NR_QE_IC_INTS, &qe_ic_host_ops, 0,
+					qe_ic->of_node->full_name);
 	if (qe_ic->irqhost == NULL) {
 		of_node_put(node);
 		return;
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 90db8a7..84dc543 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -434,7 +434,7 @@ void __init tsi108_pci_int_init(struct device_node *node)
 	DBG("Tsi108_pci_int_init: initializing PCI interrupts\n");
 
 	pci_irq_node = of_node_get(node);
-	pci_irq_host = irq_alloc_host(IRQ_HOST_MAP_LEGACY, 0, &pci_irq_host_ops, 0);
+	pci_irq_host = irq_alloc_host(IRQ_HOST_MAP_LEGACY, 0, &pci_irq_host_ops, 0, pci_irq_node->full_name);
 	if (pci_irq_host == NULL) {
 		printk(KERN_ERR "pci_irq_host: failed to allocate irq host !\n");
 		return;
diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index 8905989..7705676 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -247,7 +247,7 @@ static struct uic * __init uic_init_one(struct device_node *node)
 	uic->dcrbase = *dcrreg;
 
 	uic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR, NR_UIC_INTS,
-				      &uic_host_ops, -1);
+				      &uic_host_ops, -1, node->full_name);
 	if (! uic->irqhost) {
 		of_node_put(node);
 		return NULL; /* FIXME: panic? */
-- 
1.5.1
