Return-Path: <arnd@arndb.de>
Message-Id: <20061219143452.914688000@arndb.de>
References: <20061219143240.705255000@arndb.de>
Date: Tue, 19 Dec 2006 15:32:45 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 5/6] spufs: fix assignment of node numbers
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The difference between 'nid' and 'node' fields in an
spu structure was used incorrectly. The common 'node'
number now reflects the NUMA node, and it is used
in other places in the code as well.

The 'nid' value is meaningful only in one place, namely
the computation of the interrupt numbers based on the
physical location of an spu.  Consequently, we look it
up directly in the place where it is used now.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spu_priv1_mmio.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_priv1_mmio.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_priv1_mmio.c
@@ -40,7 +40,6 @@
 static DEFINE_MUTEX(add_spumem_mutex);
 
 struct spu_pdata {
-	int nid;
 	struct device_node *devnode;
 	struct spu_priv1 __iomem *priv1;
 };
@@ -58,15 +57,6 @@ struct device_node *spu_devnode(struct s
 
 EXPORT_SYMBOL_GPL(spu_devnode);
 
-static int __init find_spu_node_id(struct device_node *spe)
-{
-	const unsigned int *id;
-	struct device_node *cpu;
-	cpu = spe->parent->parent;
-	id = get_property(cpu, "node-id", NULL);
-	return id ? *id : 0;
-}
-
 static int __init cell_spuprop_present(struct spu *spu, struct device_node *spe,
 		const char *prop)
 {
@@ -87,7 +77,7 @@ static int __init cell_spuprop_present(s
 	start_pfn = p->address >> PAGE_SHIFT;
 	nr_pages = ((unsigned long)p->len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
-	pgdata = NODE_DATA(spu_get_pdata(spu)->nid);
+	pgdata = NODE_DATA(spu->node);
 	zone = pgdata->node_zones;
 
 	/* XXX rethink locking here */
@@ -140,6 +130,7 @@ static int __init spu_map_interrupts_old
 {
 	unsigned int isrc;
 	const u32 *tmp;
+	int nid;
 
 	/* Get the interrupt source unit from the device-tree */
 	tmp = get_property(np, "isrc", NULL);
@@ -147,8 +138,15 @@ static int __init spu_map_interrupts_old
 		return -ENODEV;
 	isrc = tmp[0];
 
+	tmp = get_property(np->parent->parent, "node-id", NULL);
+	if (!tmp) {
+		printk(KERN_WARNING "%s: can't find node-id\n", __FUNCTION__);
+		nid = spu->node;
+	} else
+		nid = tmp[0];
+
 	/* Add the node number */
-	isrc |= spu->node << IIC_IRQ_NODE_SHIFT;
+	isrc |= nid << IIC_IRQ_NODE_SHIFT;
 
 	/* Now map interrupts of all 3 classes */
 	spu->irqs[0] = irq_create_mapping(NULL, IIC_IRQ_CLASS_0 | isrc);
@@ -262,7 +260,7 @@ static int spu_map_resource(struct spu *
 	start_pfn = resource.start >> PAGE_SHIFT;
 	nr_pages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
-	pgdata = NODE_DATA(spu_get_pdata(spu)->nid);
+	pgdata = NODE_DATA(spu->node);
 	zone = pgdata->node_zones;
 
 	/* XXX rethink locking here */
@@ -360,7 +358,7 @@ static int __init of_create_spu(struct s
 	}
 	spu_get_pdata(spu)->devnode = of_node_get(spe);
 
-	spu->node = find_spu_node_id(spe);
+	spu->node = of_node_to_nid(spe);
 	if (spu->node >= MAX_NUMNODES) {
 		printk(KERN_WARNING "SPE %s on node %d ignored,"
 		       " node number too big\n", spe->full_name, spu->node);
@@ -369,10 +367,6 @@ static int __init of_create_spu(struct s
 		goto out_free;
 	}
 
-	spu_get_pdata(spu)->nid = of_node_to_nid(spe);
-	if (spu_get_pdata(spu)->nid == -1)
-		spu_get_pdata(spu)->nid = 0;
-
 	ret = spu_map_device(spu);
 	/* try old method */
 	if (ret)

--
