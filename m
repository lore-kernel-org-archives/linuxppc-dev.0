Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <dabdb53ffc73aa86b0432118bf07f2fc9ce72f6f.1210220561.git.michael@ellerman.id.au>
In-Reply-To: <3c91644d7ab701f99ec7f621fc5c16d23e75c71a.1210220561.git.michael@ellerman.id.au>
References: <3c91644d7ab701f99ec7f621fc5c16d23e75c71a.1210220561.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/2] Fix irq_alloc_host() reference counting and callers
Date: Thu,  8 May 2008 14:23:11 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When I changed irq_alloc_host() to take an of_node
(52964f87c64e6c6ea671b5bf3030fb1494090a48: "Add an
optional device_node pointer to the irq_host"),
I botched the reference counting semantics.

Stephen pointed out that it's irq_alloc_host()'s
business if it needs to take an additional reference
to the device_node, the caller shouldn't need to care.
To make that clean we also need a free routine, so
the caller doesn't have to deal with dropping the
reference.

Luckily we now have an irq_free_host() where we can
drop the reference - so we can make the reference
counting internal to irq_alloc_host()/irq_free_host().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c                |    4 +++-
 arch/powerpc/platforms/cell/axon_msi.c   |    4 ++--
 arch/powerpc/platforms/cell/spider-pic.c |    2 +-
 arch/powerpc/sysdev/cpm1.c               |    2 +-
 arch/powerpc/sysdev/cpm2_pic.c           |    2 +-
 arch/powerpc/sysdev/i8259.c              |    2 +-
 arch/powerpc/sysdev/ipic.c               |    8 +++-----
 arch/powerpc/sysdev/mpic.c               |    6 ++----
 arch/powerpc/sysdev/qe_lib/qe_ic.c       |    6 ++----
 arch/powerpc/sysdev/tsi108_pci.c         |    3 +--
 arch/powerpc/sysdev/uic.c                |    6 ++----
 11 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 8ba8fbf..0cb2cf3 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -444,6 +444,8 @@ static int default_irq_host_match(struct irq_host *h, struct device_node *np)
 
 void irq_free_host(struct irq_host *host)
 {
+	of_node_put(host->of_node);
+
 	/* If it's still very early in boot we can't free, oh well. */
 	if (mem_init_done)
 		kfree(host);
@@ -472,7 +474,7 @@ struct irq_host *irq_alloc_host(struct device_node *of_node,
 	host->revmap_type = revmap_type;
 	host->inval_irq = inval_irq;
 	host->ops = ops;
-	host->of_node = of_node;
+	host->of_node = of_node_get(of_node);
 
 	if (host->ops->match == NULL)
 		host->ops->match = default_irq_host_match;
diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 8b055bc..45bddbc 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -358,7 +358,7 @@ static int axon_msi_probe(struct of_device *device,
 		goto out_free_msic;
 	}
 
-	msic->irq_host = irq_alloc_host(of_node_get(dn), IRQ_HOST_MAP_NOMAP,
+	msic->irq_host = irq_alloc_host(dn, IRQ_HOST_MAP_NOMAP,
 					NR_IRQS, &msic_host_ops, 0);
 	if (!msic->irq_host) {
 		printk(KERN_ERR "axon_msi: couldn't allocate irq_host for %s\n",
@@ -400,7 +400,7 @@ static int axon_msi_probe(struct of_device *device,
 	return 0;
 
 out_free_host:
-	kfree(msic->irq_host);
+	irq_free_host(msic->irq_host);
 out_free_fifo:
 	dma_free_coherent(&device->dev, MSIC_FIFO_SIZE_BYTES, msic->fifo_virt,
 			  msic->fifo_phys);
diff --git a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/platforms/cell/spider-pic.c
index 3f4b4ae..4e56556 100644
--- a/arch/powerpc/platforms/cell/spider-pic.c
+++ b/arch/powerpc/platforms/cell/spider-pic.c
@@ -300,7 +300,7 @@ static void __init spider_init_one(struct device_node *of_node, int chip,
 		panic("spider_pic: can't map registers !");
 
 	/* Allocate a host */
-	pic->host = irq_alloc_host(of_node_get(of_node), IRQ_HOST_MAP_LINEAR,
+	pic->host = irq_alloc_host(of_node, IRQ_HOST_MAP_LINEAR,
 				   SPIDER_SRC_COUNT, &spider_host_ops,
 				   SPIDER_IRQ_INVALID);
 	if (pic->host == NULL)
diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
index 58292a0..661df42 100644
--- a/arch/powerpc/sysdev/cpm1.c
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -159,7 +159,7 @@ unsigned int cpm_pic_init(void)
 
 	out_be32(&cpic_reg->cpic_cimr, 0);
 
-	cpm_pic_host = irq_alloc_host(of_node_get(np), IRQ_HOST_MAP_LINEAR,
+	cpm_pic_host = irq_alloc_host(np, IRQ_HOST_MAP_LINEAR,
 				      64, &cpm_pic_host_ops, 64);
 	if (cpm_pic_host == NULL) {
 		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index 5fe65b2..b16ca3e 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -266,7 +266,7 @@ void cpm2_pic_init(struct device_node *node)
 	out_be32(&cpm2_intctl->ic_scprrl, 0x05309770);
 
 	/* create a legacy host */
-	cpm2_pic_host = irq_alloc_host(of_node_get(node), IRQ_HOST_MAP_LINEAR,
+	cpm2_pic_host = irq_alloc_host(node, IRQ_HOST_MAP_LINEAR,
 				       64, &cpm2_pic_host_ops, 64);
 	if (cpm2_pic_host == NULL) {
 		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index 216c0f5..a96584a 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -276,7 +276,7 @@ void i8259_init(struct device_node *node, unsigned long intack_addr)
 	spin_unlock_irqrestore(&i8259_lock, flags);
 
 	/* create a legacy host */
-	i8259_host = irq_alloc_host(of_node_get(node), IRQ_HOST_MAP_LEGACY,
+	i8259_host = irq_alloc_host(node, IRQ_HOST_MAP_LEGACY,
 				    0, &i8259_host_ops, 0);
 	if (i8259_host == NULL) {
 		printk(KERN_ERR "i8259: failed to allocate irq host !\n");
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 0f2dfb0..80ebba3 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -731,17 +731,15 @@ struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
 
 	memset(ipic, 0, sizeof(struct ipic));
 
-	ipic->irqhost = irq_alloc_host(of_node_get(node), IRQ_HOST_MAP_LINEAR,
+	ipic->irqhost = irq_alloc_host(node, IRQ_HOST_MAP_LINEAR,
 				       NR_IPIC_INTS,
 				       &ipic_host_ops, 0);
-	if (ipic->irqhost == NULL) {
-		of_node_put(node);
+	if (ipic->irqhost == NULL)
 		return NULL;
-	}
 
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret) {
-		of_node_put(node);
+		irq_free_host(ipic->irqhost);
 		return NULL;
 	}
 
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 8619f2a..7df0252 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1016,13 +1016,11 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	memset(mpic, 0, sizeof(struct mpic));
 	mpic->name = name;
 
-	mpic->irqhost = irq_alloc_host(of_node_get(node), IRQ_HOST_MAP_LINEAR,
+	mpic->irqhost = irq_alloc_host(node, IRQ_HOST_MAP_LINEAR,
 				       isu_size, &mpic_host_ops,
 				       flags & MPIC_LARGE_VECTORS ? 2048 : 256);
-	if (mpic->irqhost == NULL) {
-		of_node_put(node);
+	if (mpic->irqhost == NULL)
 		return NULL;
-	}
 
 	mpic->irqhost->host_data = mpic;
 	mpic->hc_irq = mpic_irq_chip;
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index f59444d..b6f3d1c 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -335,12 +335,10 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 
 	memset(qe_ic, 0, sizeof(struct qe_ic));
 
-	qe_ic->irqhost = irq_alloc_host(of_node_get(node), IRQ_HOST_MAP_LINEAR,
+	qe_ic->irqhost = irq_alloc_host(node, IRQ_HOST_MAP_LINEAR,
 					NR_QE_IC_INTS, &qe_ic_host_ops, 0);
-	if (qe_ic->irqhost == NULL) {
-		of_node_put(node);
+	if (qe_ic->irqhost == NULL)
 		return;
-	}
 
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret)
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index ac1a72d..24e1f5a 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -426,11 +426,10 @@ void __init tsi108_pci_int_init(struct device_node *node)
 {
 	DBG("Tsi108_pci_int_init: initializing PCI interrupts\n");
 
-	pci_irq_host = irq_alloc_host(of_node_get(node), IRQ_HOST_MAP_LEGACY,
+	pci_irq_host = irq_alloc_host(node, IRQ_HOST_MAP_LEGACY,
 				      0, &pci_irq_host_ops, 0);
 	if (pci_irq_host == NULL) {
 		printk(KERN_ERR "pci_irq_host: failed to allocate irq host !\n");
-		of_node_put(node);
 		return;
 	}
 
diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index 625b275..d35405c 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -280,12 +280,10 @@ static struct uic * __init uic_init_one(struct device_node *node)
 	}
 	uic->dcrbase = *dcrreg;
 
-	uic->irqhost = irq_alloc_host(of_node_get(node), IRQ_HOST_MAP_LINEAR,
+	uic->irqhost = irq_alloc_host(node, IRQ_HOST_MAP_LINEAR,
 				      NR_UIC_INTS, &uic_host_ops, -1);
-	if (! uic->irqhost) {
-		of_node_put(node);
+	if (! uic->irqhost)
 		return NULL; /* FIXME: panic? */
-	}
 
 	uic->irqhost->host_data = uic;
 
-- 
1.5.5
