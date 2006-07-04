Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 9/20] [powerpc,cell] Constify & voidify get_property()
Message-ID: 1151993427.2210.10@pokey
Date: Tue,  4 Jul 2006 16:46:44 +1000 (EST)
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that get_property() returns a void *, there's no need to cast its
return value. Also, treat the return value as const, so we can
constify get_property later.

cell platform changes.

Built for cell_defconfig

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 arch/powerpc/platforms/cell/cbe_regs.c   |    8 +++-----
 arch/powerpc/platforms/cell/interrupt.c  |    5 ++---
 arch/powerpc/platforms/cell/iommu.c      |   22 ++++++++++++----------
 arch/powerpc/platforms/cell/spider-pic.c |   10 +++++-----
 arch/powerpc/platforms/cell/spu_base.c   |   18 +++++++++---------
 include/asm-powerpc/spu.h                |    2 +-
 6 files changed, 32 insertions(+), 33 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/cell/cbe_regs.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/cbe_regs.c
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_regs.c
@@ -97,7 +97,7 @@ void __init cbe_regs_init(void)
 		struct cbe_regs_map *map = &cbe_regs_maps[cbe_regs_map_count++];
 
 		/* That hack must die die die ! */
-		struct address_prop {
+		const struct address_prop {
 			unsigned long address;
 			unsigned int len;
 		} __attribute__((packed)) *prop;
@@ -114,13 +114,11 @@ void __init cbe_regs_init(void)
 			if (cbe_thread_map[i].cpu_node == cpu)
 				cbe_thread_map[i].regs = map;
 
-		prop = (struct address_prop *)get_property(cpu, "pervasive",
-							   NULL);
+		prop = get_property(cpu, "pervasive", NULL);
 		if (prop != NULL)
 			map->pmd_regs = ioremap(prop->address, prop->len);
 
-		prop = (struct address_prop *)get_property(cpu, "iic",
-							   NULL);
+		prop = get_property(cpu, "iic", NULL);
 		if (prop != NULL)
 			map->iic_regs = ioremap(prop->address, prop->len);
 	}
Index: linux-2.6/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/interrupt.c
+++ linux-2.6/arch/powerpc/platforms/cell/interrupt.c
@@ -250,15 +250,14 @@ static int __init setup_iic(void)
 	struct resource r0, r1;
 	struct irq_host *host;
 	int found = 0;
- 	u32 *np;
+ 	const u32 *np;
 
 	for (dn = NULL;
 	     (dn = of_find_node_by_name(dn,"interrupt-controller")) != NULL;) {
 		if (!device_is_compatible(dn,
 				     "IBM,CBEA-Internal-Interrupt-Controller"))
 			continue;
- 		np = (u32 *)get_property(dn, "ibm,interrupt-server-ranges",
-					 NULL);
+		np = get_property(dn, "ibm,interrupt-server-ranges", NULL);
  		if (np == NULL) {
 			printk(KERN_WARNING "IIC: CPU association not found\n");
 			of_node_put(dn);
Index: linux-2.6/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/iommu.c
+++ linux-2.6/arch/powerpc/platforms/cell/iommu.c
@@ -308,15 +308,16 @@ static void cell_do_map_iommu(struct cel
 
 static void iommu_devnode_setup(struct device_node *d)
 {
-	unsigned int *ioid;
-	unsigned long *dma_window, map_start, map_size, token;
+	const unsigned int *ioid;
+	unsigned long map_start, map_size, token;
+	const unsigned long *dma_window;
 	struct cell_iommu *iommu;
 
-	ioid = (unsigned int *)get_property(d, "ioid", NULL);
+	ioid = get_property(d, "ioid", NULL);
 	if (!ioid)
 		pr_debug("No ioid entry found !\n");
 
-	dma_window = (unsigned long *)get_property(d, "ibm,dma-window", NULL);
+	dma_window = get_property(d, "ibm,dma-window", NULL);
 	if (!dma_window)
 		pr_debug("No ibm,dma-window entry found !\n");
 
@@ -371,8 +372,9 @@ static int cell_map_iommu_hardcoded(int 
 
 static int cell_map_iommu(void)
 {
-	unsigned int num_nodes = 0, *node_id;
-	unsigned long *base, *mmio_base;
+	unsigned int num_nodes = 0;
+	const unsigned int *node_id;
+	const unsigned long *base, *mmio_base;
 	struct device_node *dn;
 	struct cell_iommu *iommu = NULL;
 
@@ -381,7 +383,7 @@ static int cell_map_iommu(void)
 	for(dn = of_find_node_by_type(NULL, "cpu");
 	    dn;
 	    dn = of_find_node_by_type(dn, "cpu")) {
-		node_id = (unsigned int *)get_property(dn, "node-id", NULL);
+		node_id = get_property(dn, "node-id", NULL);
 
 		if (num_nodes < *node_id)
 			num_nodes = *node_id;
@@ -396,9 +398,9 @@ static int cell_map_iommu(void)
 	    dn;
 	    dn = of_find_node_by_type(dn, "cpu")) {
 
-		node_id = (unsigned int *)get_property(dn, "node-id", NULL);
-		base = (unsigned long *)get_property(dn, "ioc-cache", NULL);
-		mmio_base = (unsigned long *)get_property(dn, "ioc-translation", NULL);
+		node_id = get_property(dn, "node-id", NULL);
+		base = get_property(dn, "ioc-cache", NULL);
+		mmio_base = get_property(dn, "ioc-translation", NULL);
 
 		if (!base || !mmio_base || !node_id)
 			return cell_map_iommu_hardcoded(num_nodes);
Index: linux-2.6/arch/powerpc/platforms/cell/spider-pic.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spider-pic.c
+++ linux-2.6/arch/powerpc/platforms/cell/spider-pic.c
@@ -230,7 +230,7 @@ static void spider_irq_cascade(unsigned 
 static unsigned int __init spider_find_cascade_and_node(struct spider_pic *pic)
 {
 	unsigned int virq;
-	u32 *imap, *tmp;
+	const u32 *imap, *tmp;
 	int imaplen, intsize, unit;
 	struct device_node *iic;
 	struct irq_host *iic_host;
@@ -248,25 +248,25 @@ static unsigned int __init spider_find_c
 #endif
 
 	/* Now do the horrible hacks */
-	tmp = (u32 *)get_property(pic->of_node, "#interrupt-cells", NULL);
+	tmp = get_property(pic->of_node, "#interrupt-cells", NULL);
 	if (tmp == NULL)
 		return NO_IRQ;
 	intsize = *tmp;
-	imap = (u32 *)get_property(pic->of_node, "interrupt-map", &imaplen);
+	imap = get_property(pic->of_node, "interrupt-map", &imaplen);
 	if (imap == NULL || imaplen < (intsize + 1))
 		return NO_IRQ;
 	iic = of_find_node_by_phandle(imap[intsize]);
 	if (iic == NULL)
 		return NO_IRQ;
 	imap += intsize + 1;
-	tmp = (u32 *)get_property(iic, "#interrupt-cells", NULL);
+	tmp = get_property(iic, "#interrupt-cells", NULL);
 	if (tmp == NULL)
 		return NO_IRQ;
 	intsize = *tmp;
 	/* Assume unit is last entry of interrupt specifier */
 	unit = imap[intsize - 1];
 	/* Ok, we have a unit, now let's try to get the node */
-	tmp = (u32 *)get_property(iic, "ibm,interrupt-server-ranges", NULL);
+	tmp = get_property(iic, "ibm,interrupt-server-ranges", NULL);
 	if (tmp == NULL) {
 		of_node_put(iic);
 		return NO_IRQ;
Index: linux-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -488,10 +488,10 @@ int spu_irq_class_1_bottom(struct spu *s
 
 static int __init find_spu_node_id(struct device_node *spe)
 {
-	unsigned int *id;
+	const unsigned int *id;
 	struct device_node *cpu;
 	cpu = spe->parent->parent;
-	id = (unsigned int *)get_property(cpu, "node-id", NULL);
+	id = get_property(cpu, "node-id", NULL);
 	return id ? *id : 0;
 }
 
@@ -500,7 +500,7 @@ static int __init cell_spuprop_present(s
 {
 	static DEFINE_MUTEX(add_spumem_mutex);
 
-	struct address_prop {
+	const struct address_prop {
 		unsigned long address;
 		unsigned int len;
 	} __attribute__((packed)) *p;
@@ -511,7 +511,7 @@ static int __init cell_spuprop_present(s
 	struct zone *zone;
 	int ret;
 
-	p = (void*)get_property(spe, prop, &proplen);
+	p = get_property(spe, prop, &proplen);
 	WARN_ON(proplen != sizeof (*p));
 
 	start_pfn = p->address >> PAGE_SHIFT;
@@ -531,12 +531,12 @@ static int __init cell_spuprop_present(s
 static void __iomem * __init map_spe_prop(struct spu *spu,
 		struct device_node *n, const char *name)
 {
-	struct address_prop {
+	const struct address_prop {
 		unsigned long address;
 		unsigned int len;
 	} __attribute__((packed)) *prop;
 
-	void *p;
+	const void *p;
 	int proplen;
 	void* ret = NULL;
 	int err = 0;
@@ -570,14 +570,14 @@ static int __init spu_map_interrupts(str
 {
 	struct irq_host *host;
 	unsigned int isrc;
-	u32 *tmp;
+	const u32 *tmp;
 
 	host = iic_get_irq_host(spu->node);
 	if (host == NULL)
 		return -ENODEV;
 
 	/* Get the interrupt source from the device-tree */
-	tmp = (u32 *)get_property(np, "isrc", NULL);
+	tmp = get_property(np, "isrc", NULL);
 	if (!tmp)
 		return -ENODEV;
 	spu->isrc = isrc = tmp[0];
@@ -593,7 +593,7 @@ static int __init spu_map_interrupts(str
 
 static int __init spu_map_device(struct spu *spu, struct device_node *node)
 {
-	char *prop;
+	const char *prop;
 	int ret;
 
 	ret = -ENODEV;
Index: linux-2.6/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/spu.h
+++ linux-2.6/include/asm-powerpc/spu.h
@@ -106,7 +106,7 @@ struct spu_context;
 struct spu_runqueue;
 
 struct spu {
-	char *name;
+	const char *name;
 	unsigned long local_store_phys;
 	u8 *local_store;
 	unsigned long problem_phys;
