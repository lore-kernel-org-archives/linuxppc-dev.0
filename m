Return-Path: <arnd@arndb.de>
Message-Id: <20061219143452.541267000@arndb.de>
References: <20061219143240.705255000@arndb.de>
Date: Tue, 19 Dec 2006 15:32:44 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 4/6] cell: Fix spufs with "new style" device-tree
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Some SPU code was a bit too convoluted and broke when adding support for
the new style device-tree, most notably the struct pages for SPEs no
longer get created. oops...

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spu_priv1_mmio.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_priv1_mmio.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_priv1_mmio.c
@@ -37,6 +37,8 @@
 #include "interrupt.h"
 #include "spu_priv1_mmio.h"
 
+static DEFINE_MUTEX(add_spumem_mutex);
+
 struct spu_pdata {
 	int nid;
 	struct device_node *devnode;
@@ -68,8 +70,6 @@ static int __init find_spu_node_id(struc
 static int __init cell_spuprop_present(struct spu *spu, struct device_node *spe,
 		const char *prop)
 {
-	static DEFINE_MUTEX(add_spumem_mutex);
-
 	const struct address_prop {
 		unsigned long address;
 		unsigned int len;
@@ -237,70 +237,88 @@ err:
 	return ret;
 }
 
-static int spu_map_resource(struct device_node *node, int nr,
-		void __iomem** virt, unsigned long *phys)
+static int spu_map_resource(struct spu *spu, int nr,
+			    void __iomem** virt, unsigned long *phys)
 {
+	struct device_node *np = spu_get_pdata(spu)->devnode;
+	unsigned long start_pfn, nr_pages;
+	struct pglist_data *pgdata;
+	struct zone *zone;
 	struct resource resource = { };
+	unsigned long len;
 	int ret;
 
-	ret = of_address_to_resource(node, nr, &resource);
+	ret = of_address_to_resource(np, nr, &resource);
 	if (ret)
 		goto out;
 
 	if (phys)
 		*phys = resource.start;
-	*virt = ioremap(resource.start, resource.end - resource.start);
+	len = resource.end - resource.start + 1;
+	*virt = ioremap(resource.start, len);
 	if (!*virt)
 		ret = -EINVAL;
 
+	start_pfn = resource.start >> PAGE_SHIFT;
+	nr_pages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	pgdata = NODE_DATA(spu_get_pdata(spu)->nid);
+	zone = pgdata->node_zones;
+
+	/* XXX rethink locking here */
+	mutex_lock(&add_spumem_mutex);
+	ret = __add_pages(zone, start_pfn, nr_pages);
+	mutex_unlock(&add_spumem_mutex);
+
 out:
 	return ret;
 }
 
-static int __init spu_map_device(struct spu *spu, struct device_node *node)
+static int __init spu_map_device(struct spu *spu)
 {
+	struct device_node *np = spu_get_pdata(spu)->devnode;
 	int ret = -ENODEV;
-	spu->name = get_property(node, "name", NULL);
+
+	spu->name = get_property(np, "name", NULL);
 	if (!spu->name)
 		goto out;
 
-	ret = spu_map_resource(node, 0, (void __iomem**)&spu->local_store,
-					&spu->local_store_phys);
+	ret = spu_map_resource(spu, 0, (void __iomem**)&spu->local_store,
+			       &spu->local_store_phys);
 	if (ret) {
 		pr_debug("spu_new: failed to map %s resource 0\n",
-			 node->full_name);
+			 np->full_name);
 		goto out;
 	}
-	ret = spu_map_resource(node, 1, (void __iomem**)&spu->problem,
-					&spu->problem_phys);
+	ret = spu_map_resource(spu, 1, (void __iomem**)&spu->problem,
+			       &spu->problem_phys);
 	if (ret) {
 		pr_debug("spu_new: failed to map %s resource 1\n",
-			 node->full_name);
+			 np->full_name);
 		goto out_unmap;
 	}
-	ret = spu_map_resource(node, 2, (void __iomem**)&spu->priv2,
-					NULL);
+	ret = spu_map_resource(spu, 2, (void __iomem**)&spu->priv2, NULL);
 	if (ret) {
 		pr_debug("spu_new: failed to map %s resource 2\n",
-			 node->full_name);
+			 np->full_name);
 		goto out_unmap;
 	}
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
-		ret = spu_map_resource(node, 3,
-			(void __iomem**)&spu_get_pdata(spu)->priv1, NULL);
+		ret = spu_map_resource(spu, 3,
+			       (void __iomem**)&spu_get_pdata(spu)->priv1, NULL);
 	if (ret) {
 		pr_debug("spu_new: failed to map %s resource 3\n",
-			 node->full_name);
+			 np->full_name);
 		goto out_unmap;
 	}
-	pr_debug("spu_new: %s maps:\n", node->full_name);
+	pr_debug("spu_new: %s maps:\n", np->full_name);
 	pr_debug("  local store   : 0x%016lx -> 0x%p\n",
 		 spu->local_store_phys, spu->local_store);
 	pr_debug("  problem state : 0x%016lx -> 0x%p\n",
 		 spu->problem_phys, spu->problem);
 	pr_debug("  priv2         :                       0x%p\n", spu->priv2);
 	pr_debug("  priv1         :                       0x%p\n",
-						spu_get_pdata(spu)->priv1);
+		 spu_get_pdata(spu)->priv1);
 
 	return 0;
 
@@ -340,6 +358,7 @@ static int __init of_create_spu(struct s
 		ret = -ENOMEM;
 		goto out;
 	}
+	spu_get_pdata(spu)->devnode = of_node_get(spe);
 
 	spu->node = find_spu_node_id(spe);
 	if (spu->node >= MAX_NUMNODES) {
@@ -354,7 +373,7 @@ static int __init of_create_spu(struct s
 	if (spu_get_pdata(spu)->nid == -1)
 		spu_get_pdata(spu)->nid = 0;
 
-	ret = spu_map_device(spu, spe);
+	ret = spu_map_device(spu);
 	/* try old method */
 	if (ret)
 		ret = spu_map_device_old(spu, spe);
@@ -367,8 +386,6 @@ static int __init of_create_spu(struct s
 	if (ret)
 		goto out_unmap;
 
-	spu_get_pdata(spu)->devnode = of_node_get(spe);
-
 	pr_debug(KERN_DEBUG "Using SPE %s %p %p %p %p %d\n", spu->name,
 		spu->local_store, spu->problem, spu_get_pdata(spu)->priv1,
 		spu->priv2, spu->number);

--
