Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 48358DDF9E
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 22:52:34 +1000 (EST)
Date: Tue, 3 Apr 2007 22:35:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 07/17] [POWERPC] Rename get_property to of_get_property:
	arch/powerpc/platforms/cell
Message-Id: <20070403223535.dd6731d6.sfr@canb.auug.org.au>
In-Reply-To: <20070403223257.cb8c4d15.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403105401.1fcdee27.sfr@canb.auug.org.au>
	<20070403105539.7222cf2a.sfr@canb.auug.org.au>
	<20070403105650.204003b6.sfr@canb.auug.org.au>
	<20070403105748.769f156c.sfr@canb.auug.org.au>
	<20070403105852.7c7bfaa0.sfr@canb.auug.org.au>
	<20070403222406.cf39c459.sfr@canb.auug.org.au>
	<20070403222641.e93cb73b.sfr@canb.auug.org.au>
	<20070403222841.a2c6af1c.sfr@canb.auug.org.au>
	<20070403223000.5d44b2f1.sfr@canb.auug.org.au>
	<20070403223136.6ecdabbd.sfr@canb.auug.org.au>
	<20070403223257.cb8c4d15.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/cell/cbe_regs.c       |    7 +++----
 arch/powerpc/platforms/cell/cbe_thermal.c    |    4 ++--
 arch/powerpc/platforms/cell/interrupt.c      |    4 ++--
 arch/powerpc/platforms/cell/io-workarounds.c |    2 +-
 arch/powerpc/platforms/cell/iommu.c          |    8 ++++----
 arch/powerpc/platforms/cell/setup.c          |    2 +-
 arch/powerpc/platforms/cell/spider-pic.c     |    8 ++++----
 arch/powerpc/platforms/cell/spu_manage.c     |   18 +++++++++---------
 arch/powerpc/platforms/cell/spufs/inode.c    |    2 +-
 9 files changed, 27 insertions(+), 28 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/cell/cbe_regs.c b/arch/powerpc/platforms/cell/cbe_regs.c
index 9a0ee62..7c94af4 100644
--- a/arch/powerpc/platforms/cell/cbe_regs.c
+++ b/arch/powerpc/platforms/cell/cbe_regs.c
@@ -174,16 +174,15 @@ void __init cbe_regs_init(void)
 			if (cbe_thread_map[i].cpu_node == cpu)
 				cbe_thread_map[i].regs = map;
 
-		prop = get_property(cpu, "pervasive", NULL);
+		prop = of_get_property(cpu, "pervasive", NULL);
 		if (prop != NULL)
 			map->pmd_regs = ioremap(prop->address, prop->len);
 
-		prop = get_property(cpu, "iic", NULL);
+		prop = of_get_property(cpu, "iic", NULL);
 		if (prop != NULL)
 			map->iic_regs = ioremap(prop->address, prop->len);
 
-		prop = (struct address_prop *)get_property(cpu, "mic-tm",
-							   NULL);
+		prop = of_get_property(cpu, "mic-tm", NULL);
 		if (prop != NULL)
 			map->mic_tm_regs = ioremap(prop->address, prop->len);
 	}
diff --git a/arch/powerpc/platforms/cell/cbe_thermal.c b/arch/powerpc/platforms/cell/cbe_thermal.c
index 70e0d96..e8bcd2a 100644
--- a/arch/powerpc/platforms/cell/cbe_thermal.c
+++ b/arch/powerpc/platforms/cell/cbe_thermal.c
@@ -43,14 +43,14 @@ static struct cbe_pmd_regs __iomem *get_pmd_regs(struct sys_device *sysdev)
 /* returns the value for a given spu in a given register */
 static u8 spu_read_register_value(struct sys_device *sysdev, union spe_reg __iomem *reg)
 {
-	unsigned int *id;
+	const unsigned int *id;
 	union spe_reg value;
 	struct spu *spu;
 
 	/* getting the id from the reg attribute will not work on future device-tree layouts
 	 * in future we should store the id to the spu struct and use it here */
 	spu = container_of(sysdev, struct spu, sysdev);
-	id = (unsigned int *)get_property(spu_devnode(spu), "reg", NULL);
+	id = of_get_property(spu_devnode(spu), "reg", NULL);
 	value.val = in_be64(&reg->val);
 
 	return value.spe[*id];
diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index 6666d03..4fc4e92 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -261,7 +261,7 @@ static int iic_host_xlate(struct irq_host *h, struct device_node *ct,
 		return -ENODEV;
 	if (intsize != 1)
 		return -ENODEV;
-	val = get_property(ct, "#interrupt-cells", NULL);
+	val = of_get_property(ct, "#interrupt-cells", NULL);
 	if (val == NULL || *val != 1)
 		return -ENODEV;
 
@@ -327,7 +327,7 @@ static int __init setup_iic(void)
 		if (!device_is_compatible(dn,
 				     "IBM,CBEA-Internal-Interrupt-Controller"))
 			continue;
-		np = get_property(dn, "ibm,interrupt-server-ranges", NULL);
+		np = of_get_property(dn, "ibm,interrupt-server-ranges", NULL);
 		if (np == NULL) {
 			printk(KERN_WARNING "IIC: CPU association not found\n");
 			of_node_put(dn);
diff --git a/arch/powerpc/platforms/cell/io-workarounds.c b/arch/powerpc/platforms/cell/io-workarounds.c
index 7c73128..d68d920 100644
--- a/arch/powerpc/platforms/cell/io-workarounds.c
+++ b/arch/powerpc/platforms/cell/io-workarounds.c
@@ -318,7 +318,7 @@ static int __init spider_pci_workaround_init(void)
 	 */
 	list_for_each_entry(phb, &hose_list, list_node) {
 		struct device_node *np = phb->arch_data;
-		const char *model = get_property(np, "model", NULL);
+		const char *model = of_get_property(np, "model", NULL);
 
 		/* If no model property or name isn't exactly "pci", skip */
 		if (model == NULL || strcmp(np->name, "pci"))
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 7c953cc..760caa7 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -291,9 +291,9 @@ static int cell_iommu_find_ioc(int nid, unsigned long *base)
 		const unsigned int *nidp;
 		const unsigned long *tmp;
 
-		nidp = get_property(np, "node-id", NULL);
+		nidp = of_get_property(np, "node-id", NULL);
 		if (nidp && *nidp == nid) {
-			tmp = get_property(np, "ioc-translation", NULL);
+			tmp = of_get_property(np, "ioc-translation", NULL);
 			if (tmp) {
 				*base = *tmp;
 				of_node_put(np);
@@ -430,7 +430,7 @@ cell_iommu_setup_window(struct cbe_iommu *iommu, struct device_node *np,
 	struct iommu_window *window;
 	const unsigned int *ioid;
 
-	ioid = get_property(np, "ioid", NULL);
+	ioid = of_get_property(np, "ioid", NULL);
 	if (ioid == NULL)
 		printk(KERN_WARNING "iommu: missing ioid for %s using 0\n",
 		       np->full_name);
@@ -549,7 +549,7 @@ static int __init cell_iommu_get_window(struct device_node *np,
 	unsigned long index;
 
 	/* Use ibm,dma-window if available, else, hard code ! */
-	dma_window = get_property(np, "ibm,dma-window", NULL);
+	dma_window = of_get_property(np, "ibm,dma-window", NULL);
 	if (dma_window == NULL) {
 		*base = 0;
 		*size = 0x80000000u;
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index 36989c2..5c5fa34 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -71,7 +71,7 @@ static void cell_show_cpuinfo(struct seq_file *m)
 
 	root = of_find_node_by_path("/");
 	if (root)
-		model = get_property(root, "model", NULL);
+		model = of_get_property(root, "model", NULL);
 	seq_printf(m, "machine\t\t: CHRP %s\n", model);
 	of_node_put(root);
 }
diff --git a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/platforms/cell/spider-pic.c
index 21a9ebd..fb1f157 100644
--- a/arch/powerpc/platforms/cell/spider-pic.c
+++ b/arch/powerpc/platforms/cell/spider-pic.c
@@ -254,25 +254,25 @@ static unsigned int __init spider_find_cascade_and_node(struct spider_pic *pic)
 	}
 
 	/* Now do the horrible hacks */
-	tmp = get_property(pic->of_node, "#interrupt-cells", NULL);
+	tmp = of_get_property(pic->of_node, "#interrupt-cells", NULL);
 	if (tmp == NULL)
 		return NO_IRQ;
 	intsize = *tmp;
-	imap = get_property(pic->of_node, "interrupt-map", &imaplen);
+	imap = of_get_property(pic->of_node, "interrupt-map", &imaplen);
 	if (imap == NULL || imaplen < (intsize + 1))
 		return NO_IRQ;
 	iic = of_find_node_by_phandle(imap[intsize]);
 	if (iic == NULL)
 		return NO_IRQ;
 	imap += intsize + 1;
-	tmp = get_property(iic, "#interrupt-cells", NULL);
+	tmp = of_get_property(iic, "#interrupt-cells", NULL);
 	if (tmp == NULL)
 		return NO_IRQ;
 	intsize = *tmp;
 	/* Assume unit is last entry of interrupt specifier */
 	unit = imap[intsize - 1];
 	/* Ok, we have a unit, now let's try to get the node */
-	tmp = get_property(iic, "ibm,interrupt-server-ranges", NULL);
+	tmp = of_get_property(iic, "ibm,interrupt-server-ranges", NULL);
 	if (tmp == NULL) {
 		of_node_put(iic);
 		return NO_IRQ;
diff --git a/arch/powerpc/platforms/cell/spu_manage.c b/arch/powerpc/platforms/cell/spu_manage.c
index e34599f..1d4562a 100644
--- a/arch/powerpc/platforms/cell/spu_manage.c
+++ b/arch/powerpc/platforms/cell/spu_manage.c
@@ -48,11 +48,11 @@ static u64 __init find_spu_unit_number(struct device_node *spe)
 {
 	const unsigned int *prop;
 	int proplen;
-	prop = get_property(spe, "unit-id", &proplen);
+	prop = of_get_property(spe, "unit-id", &proplen);
 	if (proplen == 4)
 		return (u64)*prop;
 
-	prop = get_property(spe, "reg", &proplen);
+	prop = of_get_property(spe, "reg", &proplen);
 	if (proplen == 4)
 		return (u64)*prop;
 
@@ -76,12 +76,12 @@ static int __init spu_map_interrupts_old(struct spu *spu,
 	int nid;
 
 	/* Get the interrupt source unit from the device-tree */
-	tmp = get_property(np, "isrc", NULL);
+	tmp = of_get_property(np, "isrc", NULL);
 	if (!tmp)
 		return -ENODEV;
 	isrc = tmp[0];
 
-	tmp = get_property(np->parent->parent, "node-id", NULL);
+	tmp = of_get_property(np->parent->parent, "node-id", NULL);
 	if (!tmp) {
 		printk(KERN_WARNING "%s: can't find node-id\n", __FUNCTION__);
 		nid = spu->node;
@@ -110,7 +110,7 @@ static void __iomem * __init spu_map_prop_old(struct spu *spu,
 	} __attribute__((packed)) *prop;
 	int proplen;
 
-	prop = get_property(n, name, &proplen);
+	prop = of_get_property(n, name, &proplen);
 	if (prop == NULL || proplen != sizeof (struct address_prop))
 		return NULL;
 
@@ -124,11 +124,11 @@ static int __init spu_map_device_old(struct spu *spu)
 	int ret;
 
 	ret = -ENODEV;
-	spu->name = get_property(node, "name", NULL);
+	spu->name = of_get_property(node, "name", NULL);
 	if (!spu->name)
 		goto out;
 
-	prop = get_property(node, "local-store", NULL);
+	prop = of_get_property(node, "local-store", NULL);
 	if (!prop)
 		goto out;
 	spu->local_store_phys = *(unsigned long *)prop;
@@ -139,7 +139,7 @@ static int __init spu_map_device_old(struct spu *spu)
 	if (!spu->local_store)
 		goto out;
 
-	prop = get_property(node, "problem", NULL);
+	prop = of_get_property(node, "problem", NULL);
 	if (!prop)
 		goto out_unmap;
 	spu->problem_phys = *(unsigned long *)prop;
@@ -226,7 +226,7 @@ static int __init spu_map_device(struct spu *spu)
 	struct device_node *np = spu->devnode;
 	int ret = -ENODEV;
 
-	spu->name = get_property(np, "name", NULL);
+	spu->name = of_get_property(np, "name", NULL);
 	if (!spu->name)
 		goto out;
 
diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 8079983..e3f4ee9 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -571,7 +571,7 @@ spufs_init_isolated_loader(void)
 	if (!dn)
 		return;
 
-	loader = get_property(dn, "loader", &size);
+	loader = of_get_property(dn, "loader", &size);
 	if (!loader)
 		return;
 
-- 
1.5.0.3
