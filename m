Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id 5E72667E18
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 14:42:15 +1100 (EST)
Received: from mail2.sony.co.jp (localhost [127.0.0.1])
	by mail2.sony.co.jp (R8/Sony) with ESMTP id kAH3gEXG004784
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 12:42:14 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail2.sony.co.jp (R8/Sony) with SMTP id kAH3gEqY004767
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 12:42:14 +0900 (JST)
Message-ID: <455D2F8C.7010702@am.sony.com>
Date: Thu, 16 Nov 2006 19:42:04 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/16] cell: abstract spu management routines
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Subject: powerpc: abstract spu management routines

From: Geoff Levand <geoffrey.levand@am.sony.com>
This adds a platform specific spu management abstraction and the coresponding
routines to support the IBM Cell Blade.  It also removes the hypervisor only
resources that were included in struct spu.

Three new platform specific routines are introduced, spu_enumerate_spus(),
spu_create_spu() and spu_destroy_spu().  The underlining design uses a new
type, struct spu_management_ops, to hold function pointers that the platform
setup code is expected to initialize to instances appropriate to that platform.

For the IBM Cell Blade support, I put the hypervisor only resources that were
in struct spu into a platform specific data structure struct spu_pdata.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
 arch/powerpc/platforms/cell/cbe_thermal.c    |    5 
 arch/powerpc/platforms/cell/setup.c          |    3 
 arch/powerpc/platforms/cell/spu_base.c       |  334 +---------------------
 arch/powerpc/platforms/cell/spu_priv1_mmio.c |  399 +++++++++++++++++++++++++--
 arch/powerpc/platforms/cell/spu_priv1_mmio.h |   26 +
 include/asm-powerpc/spu.h                    |    5 
 include/asm-powerpc/spu_priv1.h              |   40 ++
 7 files changed, 465 insertions(+), 347 deletions(-)

Index: cell--common--6/arch/powerpc/platforms/cell/cbe_thermal.c
===================================================================
--- cell--common--6.orig/arch/powerpc/platforms/cell/cbe_thermal.c
+++ cell--common--6/arch/powerpc/platforms/cell/cbe_thermal.c
@@ -29,6 +29,7 @@
 #include <asm/prom.h>
 
 #include "cbe_regs.h"
+#include "spu_priv1_mmio.h"
 
 static struct cbe_pmd_regs __iomem *get_pmd_regs(struct sys_device *sysdev)
 {
@@ -36,7 +37,7 @@
 
 	spu = container_of(sysdev, struct spu, sysdev);
 
-	return cbe_get_pmd_regs(spu->devnode);
+	return cbe_get_pmd_regs(spu_devnode(spu));
 }
 
 /* returns the value for a given spu in a given register */
@@ -49,7 +50,7 @@
 	/* getting the id from the reg attribute will not work on future device-tree layouts
 	 * in future we should store the id to the spu struct and use it here */
 	spu = container_of(sysdev, struct spu, sysdev);
-	id = (unsigned int *)get_property(spu->devnode, "reg", NULL);
+	id = (unsigned int *)get_property(spu_devnode(spu), "reg", NULL);
 	value.val = in_be64(&reg->val);
 
 	return value.spe[*id];
Index: cell--common--6/arch/powerpc/platforms/cell/setup.c
===================================================================
--- cell--common--6.orig/arch/powerpc/platforms/cell/setup.c
+++ cell--common--6/arch/powerpc/platforms/cell/setup.c
@@ -145,7 +145,8 @@
 static void __init cell_setup_arch(void)
 {
 #ifdef CONFIG_SPU_BASE
-	spu_priv1_ops         = &spu_priv1_mmio_ops;
+	spu_priv1_ops = &spu_priv1_mmio_ops;
+	spu_management_ops = &spu_management_of_ops;
 #endif
 
 	cbe_regs_init();
Index: cell--common--6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- cell--common--6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ cell--common--6/arch/powerpc/platforms/cell/spu_base.c
@@ -25,23 +25,17 @@
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/module.h>
-#include <linux/pci.h>
-#include <linux/poll.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
-
-#include <asm/firmware.h>
-#include <asm/io.h>
-#include <asm/prom.h>
+#include <linux/mm.h>
+#include <linux/io.h>
 #include <linux/mutex.h>
 #include <asm/spu.h>
 #include <asm/spu_priv1.h>
-#include <asm/mmu_context.h>
 #include <asm/xmon.h>
 
-#include "interrupt.h"
-
+const struct spu_management_ops *spu_management_ops;
 const struct spu_priv1_ops *spu_priv1_ops;
 
 EXPORT_SYMBOL_GPL(spu_priv1_ops);
@@ -512,261 +506,6 @@
 	return ret;
 }
 
-static int __init find_spu_node_id(struct device_node *spe)
-{
-	const unsigned int *id;
-	struct device_node *cpu;
-	cpu = spe->parent->parent;
-	id = get_property(cpu, "node-id", NULL);
-	return id ? *id : 0;
-}
-
-static int __init cell_spuprop_present(struct spu *spu, struct device_node *spe,
-		const char *prop)
-{
-	static DEFINE_MUTEX(add_spumem_mutex);
-
-	const struct address_prop {
-		unsigned long address;
-		unsigned int len;
-	} __attribute__((packed)) *p;
-	int proplen;
-
-	unsigned long start_pfn, nr_pages;
-	struct pglist_data *pgdata;
-	struct zone *zone;
-	int ret;
-
-	p = get_property(spe, prop, &proplen);
-	WARN_ON(proplen != sizeof (*p));
-
-	start_pfn = p->address >> PAGE_SHIFT;
-	nr_pages = ((unsigned long)p->len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-
-	pgdata = NODE_DATA(spu->nid);
-	zone = pgdata->node_zones;
-
-	/* XXX rethink locking here */
-	mutex_lock(&add_spumem_mutex);
-	ret = __add_pages(zone, start_pfn, nr_pages);
-	mutex_unlock(&add_spumem_mutex);
-
-	return ret;
-}
-
-static void __iomem * __init map_spe_prop(struct spu *spu,
-		struct device_node *n, const char *name)
-{
-	const struct address_prop {
-		unsigned long address;
-		unsigned int len;
-	} __attribute__((packed)) *prop;
-
-	const void *p;
-	int proplen;
-	void __iomem *ret = NULL;
-	int err = 0;
-
-	p = get_property(n, name, &proplen);
-	if (proplen != sizeof (struct address_prop))
-		return NULL;
-
-	prop = p;
-
-	err = cell_spuprop_present(spu, n, name);
-	if (err && (err != -EEXIST))
-		goto out;
-
-	ret = ioremap(prop->address, prop->len);
-
- out:
-	return ret;
-}
-
-static void spu_unmap(struct spu *spu)
-{
-	iounmap(spu->priv2);
-	iounmap(spu->priv1);
-	iounmap(spu->problem);
-	iounmap((__force u8 __iomem *)spu->local_store);
-}
-
-/* This function shall be abstracted for HV platforms */
-static int __init spu_map_interrupts_old(struct spu *spu, struct device_node *np)
-{
-	unsigned int isrc;
-	const u32 *tmp;
-
-	/* Get the interrupt source unit from the device-tree */
-	tmp = get_property(np, "isrc", NULL);
-	if (!tmp)
-		return -ENODEV;
-	isrc = tmp[0];
-
-	/* Add the node number */
-	isrc |= spu->node << IIC_IRQ_NODE_SHIFT;
-
-	/* Now map interrupts of all 3 classes */
-	spu->irqs[0] = irq_create_mapping(NULL, IIC_IRQ_CLASS_0 | isrc);
-	spu->irqs[1] = irq_create_mapping(NULL, IIC_IRQ_CLASS_1 | isrc);
-	spu->irqs[2] = irq_create_mapping(NULL, IIC_IRQ_CLASS_2 | isrc);
-
-	/* Right now, we only fail if class 2 failed */
-	return spu->irqs[2] == NO_IRQ ? -EINVAL : 0;
-}
-
-static int __init spu_map_device_old(struct spu *spu, struct device_node *node)
-{
-	const char *prop;
-	int ret;
-
-	ret = -ENODEV;
-	spu->name = get_property(node, "name", NULL);
-	if (!spu->name)
-		goto out;
-
-	prop = get_property(node, "local-store", NULL);
-	if (!prop)
-		goto out;
-	spu->local_store_phys = *(unsigned long *)prop;
-
-	/* we use local store as ram, not io memory */
-	spu->local_store = (void __force *)
-		map_spe_prop(spu, node, "local-store");
-	if (!spu->local_store)
-		goto out;
-
-	prop = get_property(node, "problem", NULL);
-	if (!prop)
-		goto out_unmap;
-	spu->problem_phys = *(unsigned long *)prop;
-
-	spu->problem= map_spe_prop(spu, node, "problem");
-	if (!spu->problem)
-		goto out_unmap;
-
-	spu->priv1= map_spe_prop(spu, node, "priv1");
-	/* priv1 is not available on a hypervisor */
-
-	spu->priv2= map_spe_prop(spu, node, "priv2");
-	if (!spu->priv2)
-		goto out_unmap;
-	ret = 0;
-	goto out;
-
-out_unmap:
-	spu_unmap(spu);
-out:
-	return ret;
-}
-
-static int __init spu_map_interrupts(struct spu *spu, struct device_node *np)
-{
-	struct of_irq oirq;
-	int ret;
-	int i;
-
-	for (i=0; i < 3; i++) {
-		ret = of_irq_map_one(np, i, &oirq);
-		if (ret) {
-			pr_debug("spu_new: failed to get irq %d\n", i);
-			goto err;
-		}
-		ret = -EINVAL;
-		pr_debug("  irq %d no 0x%x on %s\n", i, oirq.specifier[0],
-			 oirq.controller->full_name);
-		spu->irqs[i] = irq_create_of_mapping(oirq.controller,
-					oirq.specifier, oirq.size);
-		if (spu->irqs[i] == NO_IRQ) {
-			pr_debug("spu_new: failed to map it !\n");
-			goto err;
-		}
-	}
-	return 0;
-
-err:
-	pr_debug("failed to map irq %x for spu %s\n", *oirq.specifier, spu->name);
-	for (; i >= 0; i--) {
-		if (spu->irqs[i] != NO_IRQ)
-			irq_dispose_mapping(spu->irqs[i]);
-	}
-	return ret;
-}
-
-static int spu_map_resource(struct device_node *node, int nr,
-		void __iomem** virt, unsigned long *phys)
-{
-	struct resource resource = { };
-	int ret;
-
-	ret = of_address_to_resource(node, nr, &resource);
-	if (ret)
-		goto out;
-
-	if (phys)
-		*phys = resource.start;
-	*virt = ioremap(resource.start, resource.end - resource.start);
-	if (!*virt)
-		ret = -EINVAL;
-
-out:
-	return ret;
-}
-
-static int __init spu_map_device(struct spu *spu, struct device_node *node)
-{
-	int ret = -ENODEV;
-	spu->name = get_property(node, "name", NULL);
-	if (!spu->name)
-		goto out;
-
-	ret = spu_map_resource(node, 0, (void __iomem**)&spu->local_store,
-					&spu->local_store_phys);
-	if (ret) {
-		pr_debug("spu_new: failed to map %s resource 0\n",
-			 node->full_name);
-		goto out;
-	}
-	ret = spu_map_resource(node, 1, (void __iomem**)&spu->problem,
-					&spu->problem_phys);
-	if (ret) {
-		pr_debug("spu_new: failed to map %s resource 1\n",
-			 node->full_name);
-		goto out_unmap;
-	}
-	ret = spu_map_resource(node, 2, (void __iomem**)&spu->priv2,
-					NULL);
-	if (ret) {
-		pr_debug("spu_new: failed to map %s resource 2\n",
-			 node->full_name);
-		goto out_unmap;
-	}
-
-	if (!firmware_has_feature(FW_FEATURE_LPAR))
-		ret = spu_map_resource(node, 3, (void __iomem**)&spu->priv1,
-					NULL);
-	if (ret) {
-		pr_debug("spu_new: failed to map %s resource 3\n",
-			 node->full_name);
-		goto out_unmap;
-	}
-	pr_debug("spu_new: %s maps:\n", node->full_name);
-	pr_debug("  local store   : 0x%016lx -> 0x%p\n",
-		 spu->local_store_phys, spu->local_store);
-	pr_debug("  problem state : 0x%016lx -> 0x%p\n",
-		 spu->problem_phys, spu->problem);
-	pr_debug("  priv2         :                       0x%p\n", spu->priv2);
-	pr_debug("  priv1         :                       0x%p\n", spu->priv1);
-
-	return 0;
-
-out_unmap:
-	spu_unmap(spu);
-out:
-	pr_debug("failed to map spe %s: %d\n", spu->name, ret);
-	return ret;
-}
-
 struct sysdev_class spu_sysdev_class = {
 	set_kset_name("spu")
 };
@@ -846,7 +585,7 @@
 	sysdev_unregister(&spu->sysdev);
 }
 
-static int __init create_spu(struct device_node *spe)
+static int __init create_spu(void *data)
 {
 	struct spu *spu;
 	int ret;
@@ -857,60 +596,37 @@
 	if (!spu)
 		goto out;
 
-	spu->node = find_spu_node_id(spe);
-	if (spu->node >= MAX_NUMNODES) {
-		printk(KERN_WARNING "SPE %s on node %d ignored,"
-		       " node number too big\n", spe->full_name, spu->node);
-		printk(KERN_WARNING "Check if CONFIG_NUMA is enabled.\n");
-		return -ENODEV;
-	}
-	spu->nid = of_node_to_nid(spe);
-	if (spu->nid == -1)
-		spu->nid = 0;
+	spin_lock_init(&spu->register_lock);
+	mutex_lock(&spu_mutex);
+	spu->number = number++;
+	mutex_unlock(&spu_mutex);
+
+	ret = spu_create_spu(spu, data);
 
-	ret = spu_map_device(spu, spe);
-	/* try old method */
-	if (ret)
-		ret = spu_map_device_old(spu, spe);
 	if (ret)
 		goto out_free;
 
-	ret = spu_map_interrupts(spu, spe);
-	if (ret)
-		ret = spu_map_interrupts_old(spu, spe);
-	if (ret)
-		goto out_unmap;
-	spin_lock_init(&spu->register_lock);
 	spu_mfc_sdr_setup(spu);
 	spu_mfc_sr1_set(spu, 0x33);
-	mutex_lock(&spu_mutex);
-
-	spu->number = number++;
 	ret = spu_request_irqs(spu);
 	if (ret)
-		goto out_unlock;
+		goto out_destroy;
 
 	ret = spu_create_sysdev(spu);
 	if (ret)
 		goto out_free_irqs;
 
+	mutex_lock(&spu_mutex);
 	list_add(&spu->list, &spu_list[spu->node]);
 	list_add(&spu->full_list, &spu_full_list);
-	spu->devnode = of_node_get(spe);
-
 	mutex_unlock(&spu_mutex);
 
-	pr_debug(KERN_DEBUG "Using SPE %s %p %p %p %p %d\n",
-		spu->name, spu->local_store,
-		spu->problem, spu->priv1, spu->priv2, spu->number);
 	goto out;
 
 out_free_irqs:
 	spu_free_irqs(spu);
-out_unlock:
-	mutex_unlock(&spu_mutex);
-out_unmap:
-	spu_unmap(spu);
+out_destroy:
+	spu_destroy_spu(spu);
 out_free:
 	kfree(spu);
 out:
@@ -922,11 +638,9 @@
 	list_del_init(&spu->list);
 	list_del_init(&spu->full_list);
 
-	of_node_put(spu->devnode);
-
 	spu_destroy_sysdev(spu);
 	spu_free_irqs(spu);
-	spu_unmap(spu);
+	spu_destroy_spu(spu);
 	kfree(spu);
 }
 
@@ -947,7 +661,6 @@
 
 static int __init init_spu_base(void)
 {
-	struct device_node *node;
 	int i, ret;
 
 	/* create sysdev class for spus */
@@ -958,16 +671,13 @@
 	for (i = 0; i < MAX_NUMNODES; i++)
 		INIT_LIST_HEAD(&spu_list[i]);
 
-	ret = -ENODEV;
-	for (node = of_find_node_by_type(NULL, "spe");
-			node; node = of_find_node_by_type(node, "spe")) {
-		ret = create_spu(node);
-		if (ret) {
-			printk(KERN_WARNING "%s: Error initializing %s\n",
-				__FUNCTION__, node->name);
-			cleanup_spu_base();
-			break;
-		}
+	ret = spu_enumerate_spus(create_spu);
+
+	if (ret) {
+		printk(KERN_WARNING "%s: Error initializing spus\n",
+			__FUNCTION__);
+		cleanup_spu_base();
+		return ret;
 	}
 
 	xmon_register_spus(&spu_full_list);
Index: cell--common--6/arch/powerpc/platforms/cell/spu_priv1_mmio.c
===================================================================
--- cell--common--6.orig/arch/powerpc/platforms/cell/spu_priv1_mmio.c
+++ cell--common--6/arch/powerpc/platforms/cell/spu_priv1_mmio.c
@@ -18,120 +18,473 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include <linux/interrupt.h>
+#include <linux/list.h>
 #include <linux/module.h>
+#include <linux/ptrace.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
 
-#include <asm/io.h>
 #include <asm/spu.h>
 #include <asm/spu_priv1.h>
+#include <asm/firmware.h>
+#include <asm/prom.h>
 
 #include "interrupt.h"
+#include "spu_priv1_mmio.h"
+
+struct spu_pdata {
+	int nid;
+	struct device_node *devnode;
+	struct spu_priv1 __iomem *priv1;
+};
+
+static struct spu_pdata *spu_get_pdata(struct spu *spu)
+{
+	BUG_ON(!spu->pdata);
+	return spu->pdata;
+}
+
+struct device_node *spu_devnode(struct spu *spu)
+{
+	return spu_get_pdata(spu)->devnode;
+}
+
+EXPORT_SYMBOL_GPL(spu_devnode);
+
+static int __init find_spu_node_id(struct device_node *spe)
+{
+	const unsigned int *id;
+	struct device_node *cpu;
+	cpu = spe->parent->parent;
+	id = get_property(cpu, "node-id", NULL);
+	return id ? *id : 0;
+}
+
+static int __init cell_spuprop_present(struct spu *spu, struct device_node *spe,
+		const char *prop)
+{
+	static DEFINE_MUTEX(add_spumem_mutex);
+
+	const struct address_prop {
+		unsigned long address;
+		unsigned int len;
+	} __attribute__((packed)) *p;
+	int proplen;
+
+	unsigned long start_pfn, nr_pages;
+	struct pglist_data *pgdata;
+	struct zone *zone;
+	int ret;
+
+	p = get_property(spe, prop, &proplen);
+	WARN_ON(proplen != sizeof (*p));
+
+	start_pfn = p->address >> PAGE_SHIFT;
+	nr_pages = ((unsigned long)p->len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	pgdata = NODE_DATA(spu_get_pdata(spu)->nid);
+	zone = pgdata->node_zones;
+
+	/* XXX rethink locking here */
+	mutex_lock(&add_spumem_mutex);
+	ret = __add_pages(zone, start_pfn, nr_pages);
+	mutex_unlock(&add_spumem_mutex);
+
+	return ret;
+}
+
+static void __iomem * __init map_spe_prop(struct spu *spu,
+		struct device_node *n, const char *name)
+{
+	const struct address_prop {
+		unsigned long address;
+		unsigned int len;
+	} __attribute__((packed)) *prop;
+
+	const void *p;
+	int proplen;
+	void __iomem *ret = NULL;
+	int err = 0;
+
+	p = get_property(n, name, &proplen);
+	if (proplen != sizeof (struct address_prop))
+		return NULL;
+
+	prop = p;
+
+	err = cell_spuprop_present(spu, n, name);
+	if (err && (err != -EEXIST))
+		goto out;
+
+	ret = ioremap(prop->address, prop->len);
+
+ out:
+	return ret;
+}
+
+static void spu_unmap(struct spu *spu)
+{
+	iounmap(spu->priv2);
+	iounmap(spu_get_pdata(spu)->priv1);
+	iounmap(spu->problem);
+	iounmap((__force u8 __iomem *)spu->local_store);
+}
+
+static int __init spu_map_interrupts_old(struct spu *spu,
+	struct device_node *np)
+{
+	unsigned int isrc;
+	const u32 *tmp;
+
+	/* Get the interrupt source unit from the device-tree */
+	tmp = get_property(np, "isrc", NULL);
+	if (!tmp)
+		return -ENODEV;
+	isrc = tmp[0];
+
+	/* Add the node number */
+	isrc |= spu->node << IIC_IRQ_NODE_SHIFT;
+
+	/* Now map interrupts of all 3 classes */
+	spu->irqs[0] = irq_create_mapping(NULL, IIC_IRQ_CLASS_0 | isrc);
+	spu->irqs[1] = irq_create_mapping(NULL, IIC_IRQ_CLASS_1 | isrc);
+	spu->irqs[2] = irq_create_mapping(NULL, IIC_IRQ_CLASS_2 | isrc);
+
+	/* Right now, we only fail if class 2 failed */
+	return spu->irqs[2] == NO_IRQ ? -EINVAL : 0;
+}
+
+static int __init spu_map_device_old(struct spu *spu, struct device_node *node)
+{
+	const char *prop;
+	int ret;
+
+	ret = -ENODEV;
+	spu->name = get_property(node, "name", NULL);
+	if (!spu->name)
+		goto out;
+
+	prop = get_property(node, "local-store", NULL);
+	if (!prop)
+		goto out;
+	spu->local_store_phys = *(unsigned long *)prop;
+
+	/* we use local store as ram, not io memory */
+	spu->local_store = (void __force *)
+		map_spe_prop(spu, node, "local-store");
+	if (!spu->local_store)
+		goto out;
+
+	prop = get_property(node, "problem", NULL);
+	if (!prop)
+		goto out_unmap;
+	spu->problem_phys = *(unsigned long *)prop;
+
+	spu->problem= map_spe_prop(spu, node, "problem");
+	if (!spu->problem)
+		goto out_unmap;
+
+	spu_get_pdata(spu)->priv1= map_spe_prop(spu, node, "priv1");
+
+	spu->priv2= map_spe_prop(spu, node, "priv2");
+	if (!spu->priv2)
+		goto out_unmap;
+	ret = 0;
+	goto out;
+
+out_unmap:
+	spu_unmap(spu);
+out:
+	return ret;
+}
+
+static int __init spu_map_interrupts(struct spu *spu, struct device_node *np)
+{
+	struct of_irq oirq;
+	int ret;
+	int i;
+
+	for (i=0; i < 3; i++) {
+		ret = of_irq_map_one(np, i, &oirq);
+		if (ret)
+			goto err;
+
+		ret = -EINVAL;
+		spu->irqs[i] = irq_create_of_mapping(oirq.controller,
+					oirq.specifier, oirq.size);
+		if (spu->irqs[i] == NO_IRQ)
+			goto err;
+	}
+	return 0;
+
+err:
+	pr_debug("failed to map irq %x for spu %s\n", *oirq.specifier,
+		spu->name);
+	for (; i >= 0; i--) {
+		if (spu->irqs[i] != NO_IRQ)
+			irq_dispose_mapping(spu->irqs[i]);
+	}
+	return ret;
+}
+
+static int spu_map_resource(struct device_node *node, int nr,
+		void __iomem** virt, unsigned long *phys)
+{
+	struct resource resource = { };
+	int ret;
+
+	ret = of_address_to_resource(node, 0, &resource);
+	if (ret)
+		goto out;
+
+	if (phys)
+		*phys = resource.start;
+	*virt = ioremap(resource.start, resource.end - resource.start);
+	if (!*virt)
+		ret = -EINVAL;
+
+out:
+	return ret;
+}
+
+static int __init spu_map_device(struct spu *spu, struct device_node *node)
+{
+	int ret = -ENODEV;
+	spu->name = get_property(node, "name", NULL);
+	if (!spu->name)
+		goto out;
+
+	ret = spu_map_resource(node, 0, (void __iomem**)&spu->local_store,
+					&spu->local_store_phys);
+	if (ret)
+		goto out;
+	ret = spu_map_resource(node, 1, (void __iomem**)&spu->problem,
+					&spu->problem_phys);
+	if (ret)
+		goto out_unmap;
+	ret = spu_map_resource(node, 2, (void __iomem**)&spu->priv2,
+					NULL);
+	if (ret)
+		goto out_unmap;
+
+	if (!firmware_has_feature(FW_FEATURE_LPAR))
+		ret = spu_map_resource(node, 3,
+			(void __iomem**)&spu_get_pdata(spu)->priv1, NULL);
+	if (ret)
+		goto out_unmap;
+	return 0;
+
+out_unmap:
+	spu_unmap(spu);
+out:
+	pr_debug("failed to map spe %s: %d\n", spu->name, ret);
+	return ret;
+}
+
+static int __init of_enumerate_spus(int (*fn)(void *data))
+{
+	int ret;
+	struct device_node *node;
+
+	ret = -ENODEV;
+	for (node = of_find_node_by_type(NULL, "spe");
+			node; node = of_find_node_by_type(node, "spe")) {
+		ret = fn(node);
+		if (ret) {
+			printk(KERN_WARNING "%s: Error initializing %s\n",
+				__FUNCTION__, node->name);
+			break;
+		}
+	}
+	return ret;
+}
+
+static int __init of_create_spu(struct spu *spu, void *data)
+{
+	int ret;
+	struct device_node *spe = (struct device_node *)data;
+
+	spu->pdata = kzalloc(sizeof(struct spu_pdata),
+		GFP_KERNEL);
+	if (!spu->pdata) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	spu->node = find_spu_node_id(spe);
+	if (spu->node >= MAX_NUMNODES) {
+		printk(KERN_WARNING "SPE %s on node %d ignored,"
+		       " node number too big\n", spe->full_name, spu->node);
+		printk(KERN_WARNING "Check if CONFIG_NUMA is enabled.\n");
+		ret = -ENODEV;
+		goto out_free;
+	}
+
+	spu_get_pdata(spu)->nid = of_node_to_nid(spe);
+	if (spu_get_pdata(spu)->nid == -1)
+		spu_get_pdata(spu)->nid = 0;
+
+	ret = spu_map_device(spu, spe);
+	/* try old method */
+	if (ret)
+		ret = spu_map_device_old(spu, spe);
+	if (ret)
+		goto out_free;
+
+	ret = spu_map_interrupts(spu, spe);
+	if (ret)
+		ret = spu_map_interrupts_old(spu, spe);
+	if (ret)
+		goto out_unmap;
+
+	spu_get_pdata(spu)->devnode = of_node_get(spe);
+
+	pr_debug(KERN_DEBUG "Using SPE %s %p %p %p %p %d\n", spu->name,
+		spu->local_store, spu->problem, spu_get_pdata(spu)->priv1,
+		spu->priv2, spu->number);
+	goto out;
+
+out_unmap:
+	spu_unmap(spu);
+out_free:
+	kfree(spu->pdata);
+	spu->pdata = NULL;
+out:
+	return ret;
+}
+
+static int of_destroy_spu(struct spu *spu)
+{
+	spu_unmap(spu);
+	of_node_put(spu_get_pdata(spu)->devnode);
+	kfree(spu->pdata);
+	spu->pdata = NULL;
+	return 0;
+}
+
+const struct spu_management_ops spu_management_of_ops = {
+	.enumerate_spus = of_enumerate_spus,
+	.create_spu = of_create_spu,
+	.destroy_spu = of_destroy_spu,
+};
 
 static void int_mask_and(struct spu *spu, int class, u64 mask)
 {
 	u64 old_mask;
 
-	old_mask = in_be64(&spu->priv1->int_mask_RW[class]);
-	out_be64(&spu->priv1->int_mask_RW[class], old_mask & mask);
+	old_mask = in_be64(&spu_get_pdata(spu)->priv1->int_mask_RW[class]);
+	out_be64(&spu_get_pdata(spu)->priv1->int_mask_RW[class],
+		old_mask & mask);
 }
 
 static void int_mask_or(struct spu *spu, int class, u64 mask)
 {
 	u64 old_mask;
 
-	old_mask = in_be64(&spu->priv1->int_mask_RW[class]);
-	out_be64(&spu->priv1->int_mask_RW[class], old_mask | mask);
+	old_mask = in_be64(&spu_get_pdata(spu)->priv1->int_mask_RW[class]);
+	out_be64(&spu_get_pdata(spu)->priv1->int_mask_RW[class],
+		old_mask | mask);
 }
 
 static void int_mask_set(struct spu *spu, int class, u64 mask)
 {
-	out_be64(&spu->priv1->int_mask_RW[class], mask);
+	out_be64(&spu_get_pdata(spu)->priv1->int_mask_RW[class], mask);
 }
 
 static u64 int_mask_get(struct spu *spu, int class)
 {
-	return in_be64(&spu->priv1->int_mask_RW[class]);
+	return in_be64(&spu_get_pdata(spu)->priv1->int_mask_RW[class]);
 }
 
 static void int_stat_clear(struct spu *spu, int class, u64 stat)
 {
-	out_be64(&spu->priv1->int_stat_RW[class], stat);
+	out_be64(&spu_get_pdata(spu)->priv1->int_stat_RW[class], stat);
 }
 
 static u64 int_stat_get(struct spu *spu, int class)
 {
-	return in_be64(&spu->priv1->int_stat_RW[class]);
+	return in_be64(&spu_get_pdata(spu)->priv1->int_stat_RW[class]);
 }
 
 static void cpu_affinity_set(struct spu *spu, int cpu)
 {
 	u64 target = iic_get_target_id(cpu);
 	u64 route = target << 48 | target << 32 | target << 16;
-	out_be64(&spu->priv1->int_route_RW, route);
+	out_be64(&spu_get_pdata(spu)->priv1->int_route_RW, route);
 }
 
 static u64 mfc_dar_get(struct spu *spu)
 {
-	return in_be64(&spu->priv1->mfc_dar_RW);
+	return in_be64(&spu_get_pdata(spu)->priv1->mfc_dar_RW);
 }
 
 static u64 mfc_dsisr_get(struct spu *spu)
 {
-	return in_be64(&spu->priv1->mfc_dsisr_RW);
+	return in_be64(&spu_get_pdata(spu)->priv1->mfc_dsisr_RW);
 }
 
 static void mfc_dsisr_set(struct spu *spu, u64 dsisr)
 {
-	out_be64(&spu->priv1->mfc_dsisr_RW, dsisr);
+	out_be64(&spu_get_pdata(spu)->priv1->mfc_dsisr_RW, dsisr);
 }
 
 static void mfc_sdr_setup(struct spu *spu)
 {
-	out_be64(&spu->priv1->mfc_sdr_RW, mfspr(SPRN_SDR1));
+	out_be64(&spu_get_pdata(spu)->priv1->mfc_sdr_RW, mfspr(SPRN_SDR1));
 }
 
 static void mfc_sr1_set(struct spu *spu, u64 sr1)
 {
-	out_be64(&spu->priv1->mfc_sr1_RW, sr1);
+	out_be64(&spu_get_pdata(spu)->priv1->mfc_sr1_RW, sr1);
 }
 
 static u64 mfc_sr1_get(struct spu *spu)
 {
-	return in_be64(&spu->priv1->mfc_sr1_RW);
+	return in_be64(&spu_get_pdata(spu)->priv1->mfc_sr1_RW);
 }
 
 static void mfc_tclass_id_set(struct spu *spu, u64 tclass_id)
 {
-	out_be64(&spu->priv1->mfc_tclass_id_RW, tclass_id);
+	out_be64(&spu_get_pdata(spu)->priv1->mfc_tclass_id_RW, tclass_id);
 }
 
 static u64 mfc_tclass_id_get(struct spu *spu)
 {
-	return in_be64(&spu->priv1->mfc_tclass_id_RW);
+	return in_be64(&spu_get_pdata(spu)->priv1->mfc_tclass_id_RW);
 }
 
 static void tlb_invalidate(struct spu *spu)
 {
-	out_be64(&spu->priv1->tlb_invalidate_entry_W, 0ul);
+	out_be64(&spu_get_pdata(spu)->priv1->tlb_invalidate_entry_W, 0ul);
 }
 
 static void resource_allocation_groupID_set(struct spu *spu, u64 id)
 {
-	out_be64(&spu->priv1->resource_allocation_groupID_RW, id);
+	out_be64(&spu_get_pdata(spu)->priv1->resource_allocation_groupID_RW,
+		id);
 }
 
 static u64 resource_allocation_groupID_get(struct spu *spu)
 {
-	return in_be64(&spu->priv1->resource_allocation_groupID_RW);
+	return in_be64(
+		&spu_get_pdata(spu)->priv1->resource_allocation_groupID_RW);
 }
 
 static void resource_allocation_enable_set(struct spu *spu, u64 enable)
 {
-	out_be64(&spu->priv1->resource_allocation_enable_RW, enable);
+	out_be64(&spu_get_pdata(spu)->priv1->resource_allocation_enable_RW,
+		enable);
 }
 
 static u64 resource_allocation_enable_get(struct spu *spu)
 {
-	return in_be64(&spu->priv1->resource_allocation_enable_RW);
+	return in_be64(
+		&spu_get_pdata(spu)->priv1->resource_allocation_enable_RW);
 }
 
 const struct spu_priv1_ops spu_priv1_mmio_ops =
Index: cell--common--6/arch/powerpc/platforms/cell/spu_priv1_mmio.h
===================================================================
--- /dev/null
+++ cell--common--6/arch/powerpc/platforms/cell/spu_priv1_mmio.h
@@ -0,0 +1,26 @@
+/*
+ * spu hypervisor abstraction for direct hardware access.
+ *
+ *  Copyright (C) 2006 Sony Computer Entertainment Inc.
+ *  Copyright 2006 Sony Corp.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef SPU_PRIV1_MMIO_H
+#define SPU_PRIV1_MMIO_H
+
+struct device_node *spu_devnode(struct spu *spu);
+
+#endif /* SPU_PRIV1_MMIO_H */
Index: cell--common--6/include/asm-powerpc/spu.h
===================================================================
--- cell--common--6.orig/include/asm-powerpc/spu.h
+++ cell--common--6/include/asm-powerpc/spu.h
@@ -111,13 +111,11 @@
 	u8 *local_store;
 	unsigned long problem_phys;
 	struct spu_problem __iomem *problem;
-	struct spu_priv1 __iomem *priv1;
 	struct spu_priv2 __iomem *priv2;
 	struct list_head list;
 	struct list_head sched_list;
 	struct list_head full_list;
 	int number;
-	int nid;
 	unsigned int irqs[3];
 	u32 node;
 	u64 flags;
@@ -144,8 +142,7 @@
 	char irq_c1[8];
 	char irq_c2[8];
 
-	struct device_node *devnode;
-
+	void* pdata; /* platform private data */
 	struct sys_device sysdev;
 };
 
Index: cell--common--6/include/asm-powerpc/spu_priv1.h
===================================================================
--- cell--common--6.orig/include/asm-powerpc/spu_priv1.h
+++ cell--common--6/include/asm-powerpc/spu_priv1.h
@@ -21,12 +21,13 @@
 #define _SPU_PRIV1_H
 #if defined(__KERNEL__)
 
+#include <linux/types.h>
+
 struct spu;
 
 /* access to priv1 registers */
 
-struct spu_priv1_ops
-{
+struct spu_priv1_ops {
 	void (*int_mask_and) (struct spu *spu, int class, u64 mask);
 	void (*int_mask_or) (struct spu *spu, int class, u64 mask);
 	void (*int_mask_set) (struct spu *spu, int class, u64 mask);
@@ -171,12 +172,41 @@
 	return spu_priv1_ops->resource_allocation_enable_get(spu);
 }
 
-/* The declarations folowing are put here for convenience
- * and only intended to be used by the platform setup code
- * for initializing spu_priv1_ops.
+/* spu management abstraction */
+
+struct spu_management_ops {
+	int (*enumerate_spus)(int (*fn)(void *data));
+	int (*create_spu)(struct spu *spu, void *data);
+	int (*destroy_spu)(struct spu *spu);
+};
+
+extern const struct spu_management_ops* spu_management_ops;
+
+static inline int
+spu_enumerate_spus (int (*fn)(void *data))
+{
+	return spu_management_ops->enumerate_spus(fn);
+}
+
+static inline int
+spu_create_spu (struct spu *spu, void *data)
+{
+	return spu_management_ops->create_spu(spu, data);
+}
+
+static inline int
+spu_destroy_spu (struct spu *spu)
+{
+	return spu_management_ops->destroy_spu(spu);
+}
+
+/*
+ * The declarations folowing are put here for convenience
+ * and only intended to be used by the platform setup code.
  */
 
 extern const struct spu_priv1_ops spu_priv1_mmio_ops;
+extern const struct spu_management_ops spu_management_of_ops;
 
 #endif /* __KERNEL__ */
 #endif
