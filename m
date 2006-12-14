Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 385F167E3C
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 13:44:14 +1100 (EST)
Date: Thu, 14 Dec 2006 11:44:04 +0900 (JST)
Message-Id: <200612140244.kBE2i6xa026617@toshiba.co.jp>
Subject: [PATCH 14/19] powerpc: SPU support routines for Celleb
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

SPU support routines for Celleb platform.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/include/asm-powerpc/spu_priv1.h
diff -u linux-powerpc-git/include/asm-powerpc/spu_priv1.h:1.1.1.1 linux-powerpc-git/include/asm-powerpc/spu_priv1.h:1.2
--- linux-powerpc-git/include/asm-powerpc/spu_priv1.h:1.1.1.1	Wed Dec  6 08:24:04 2006
+++ linux-powerpc-git/include/asm-powerpc/spu_priv1.h	Wed Dec  6 08:43:16 2006
@@ -207,6 +207,8 @@
 
 extern const struct spu_priv1_ops spu_priv1_mmio_ops;
 extern const struct spu_management_ops spu_management_of_ops;
+extern const struct spu_priv1_ops spu_priv1_beat_ops;
+extern const struct spu_management_ops spu_management_beat_ops;
 
 #endif /* __KERNEL__ */
 #endif
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/spu.h
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/spu.h:1.4
--- /dev/null	Wed Dec 13 21:32:04 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/spu.h	Wed Dec 13 18:13:44 2006
@@ -0,0 +1,39 @@
+/*
+ * spu hypervisor abstraction for Beat
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef _CELLEB_SPU_H
+#define _CELLEB_SPU_H
+
+#include <asm/types.h>
+#include <asm/spu.h>
+
+struct spu_pdata {
+	int nid;
+	u64 spe_id;
+	u64 shadow_int_mask_RW[3];
+};
+
+static inline struct spu_pdata *spu_get_pdata(struct spu *spu)
+{
+	BUG_ON(!spu->pdata);
+	return spu->pdata;
+}
+
+#endif /* _CELLEB_SPU_H */
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/spu_manage.c
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/spu_manage.c:1.5
--- /dev/null	Wed Dec 13 21:32:04 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/spu_manage.c	Wed Dec 13 14:57:24 2006
@@ -0,0 +1,282 @@
+/*
+ * spu management operations for Beat
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
+ *
+ * This code is based on arch/powerpc/platforms/cell/spu_priv1_mmio.c:
+ *  (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ *  Copyright 2006 Sony Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/ptrace.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+
+#include <asm/spu.h>
+#include <asm/spu_priv1.h>
+#include <asm/firmware.h>
+#include <asm/prom.h>
+
+#include "spu.h"
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
+static u64 __init find_spu_unit_number(struct device_node *spe)
+{
+	const unsigned int *reg;
+	reg = get_property(spe, "reg", NULL);
+	return reg ? (u64)*reg : 0ul;
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
+	iounmap(spu->problem);
+	iounmap((__force u8 __iomem *)spu->local_store);
+}
+
+static int __init spu_map_device(struct spu *spu, struct device_node *node)
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
+		if (ret) {
+			pr_debug("spu_new: failed to get irq %d\n", i);
+			goto err;
+		}
+		ret = -EINVAL;
+		pr_debug("  irq %d no 0x%x on %s\n", i, oirq.specifier[0],
+			 oirq.controller->full_name);
+		spu->irqs[i] = irq_create_of_mapping(oirq.controller,
+					oirq.specifier, oirq.size);
+		if (spu->irqs[i] == NO_IRQ) {
+			pr_debug("spu_new: failed to map it !\n");
+			goto err;
+		}
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
+static int __init beat_create_spu(struct spu *spu, void *data)
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
+	spu_get_pdata(spu)->spe_id = find_spu_unit_number(spe);
+
+	ret = spu_map_device(spu, spe);
+	if (ret)
+		goto out_free;
+
+	ret = spu_map_interrupts(spu, spe);
+	if (ret)
+		goto out_unmap;
+
+	pr_debug(KERN_DEBUG "Using SPE %s %p %p %p %d\n", spu->name,
+		spu->local_store, spu->problem, spu->priv2, spu->number);
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
+static int beat_destroy_spu(struct spu *spu)
+{
+	spu_unmap(spu);
+	kfree(spu->pdata);
+	spu->pdata = NULL;
+	return 0;
+}
+
+const struct spu_management_ops spu_management_beat_ops = {
+	.enumerate_spus = of_enumerate_spus,
+	.create_spu = beat_create_spu,
+	.destroy_spu = beat_destroy_spu,
+};
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/spu_priv1.c
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/spu_priv1.c:1.3
--- /dev/null	Wed Dec 13 21:32:05 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/spu_priv1.c	Wed Dec 13 14:57:24 2006
@@ -0,0 +1,210 @@
+/*
+ * spu hypervisor abstraction for Beat
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/module.h>
+
+#include <asm/spu.h>
+#include <asm/spu_priv1.h>
+
+#include "beat.h"
+#include "spu.h"
+
+static inline void _int_mask_set(struct spu *spu, int class, u64 mask)
+{
+	spu_get_pdata(spu)->shadow_int_mask_RW[class] = mask;
+	beat_set_irq_mask_for_spe(spu_get_pdata(spu)->spe_id, class, mask);
+}
+
+static inline u64 _int_mask_get(struct spu *spu, int class)
+{
+	return spu_get_pdata(spu)->shadow_int_mask_RW[class];
+}
+
+static void int_mask_set(struct spu *spu, int class, u64 mask)
+{
+	_int_mask_set(spu, class, mask);
+}
+
+static u64 int_mask_get(struct spu *spu, int class)
+{
+	return _int_mask_get(spu, class);
+}
+
+static void int_mask_and(struct spu *spu, int class, u64 mask)
+{
+	u64 old_mask;
+	old_mask = _int_mask_get(spu, class);
+	_int_mask_set(spu, class, old_mask & mask);
+}
+
+static void int_mask_or(struct spu *spu, int class, u64 mask)
+{
+	u64 old_mask;
+	old_mask = _int_mask_get(spu, class);
+	_int_mask_set(spu, class, old_mask | mask);
+}
+
+static void int_stat_clear(struct spu *spu, int class, u64 stat)
+{
+	beat_clear_interrupt_status_of_spe(spu_get_pdata(spu)->spe_id,
+					   class, stat);
+}
+
+static u64 int_stat_get(struct spu *spu, int class)
+{
+	u64 int_stat;
+	beat_get_interrupt_status_of_spe(spu_get_pdata(spu)->spe_id,
+					 class, &int_stat);
+	return int_stat;
+}
+
+static void cpu_affinity_set(struct spu *spu, int cpu)
+{
+	return;
+}
+
+static u64 mfc_dar_get(struct spu *spu)
+{
+	u64 dar;
+	beat_get_spe_privileged_state_1_registers(
+		spu_get_pdata(spu)->spe_id,
+		offsetof(struct spu_priv1, mfc_dar_RW), &dar);
+	return dar;
+}
+
+static u64 mfc_dsisr_get(struct spu *spu)
+{
+	u64 dsisr;
+	beat_get_spe_privileged_state_1_registers(
+		spu_get_pdata(spu)->spe_id,
+		offsetof(struct spu_priv1, mfc_dsisr_RW), &dsisr);
+	return dsisr;
+}
+
+static void mfc_dsisr_set(struct spu *spu, u64 dsisr)
+{
+	beat_set_spe_privileged_state_1_registers(
+		spu_get_pdata(spu)->spe_id,
+		offsetof(struct spu_priv1, mfc_dsisr_RW), dsisr);
+}
+
+static void mfc_sdr_setup(struct spu *spu)
+{
+	return;
+}
+
+static void mfc_sr1_set(struct spu *spu, u64 sr1)
+{
+	beat_set_spe_privileged_state_1_registers(
+		spu_get_pdata(spu)->spe_id,
+		offsetof(struct spu_priv1, mfc_sr1_RW), sr1);
+}
+
+static u64 mfc_sr1_get(struct spu *spu)
+{
+	u64 sr1;
+	beat_get_spe_privileged_state_1_registers(
+		spu_get_pdata(spu)->spe_id,
+		offsetof(struct spu_priv1, mfc_sr1_RW), &sr1);
+	return sr1;
+}
+
+static void mfc_tclass_id_set(struct spu *spu, u64 tclass_id)
+{
+	beat_set_spe_privileged_state_1_registers(
+		spu_get_pdata(spu)->spe_id,
+		offsetof(struct spu_priv1, mfc_tclass_id_RW), tclass_id);
+}
+
+static u64 mfc_tclass_id_get(struct spu *spu)
+{
+	u64 tclass_id;
+	beat_get_spe_privileged_state_1_registers(
+		spu_get_pdata(spu)->spe_id,
+		offsetof(struct spu_priv1, mfc_tclass_id_RW), &tclass_id);
+	return tclass_id;
+}
+
+static void tlb_invalidate(struct spu *spu)
+{
+	beat_set_spe_privileged_state_1_registers(
+		spu_get_pdata(spu)->spe_id,
+		offsetof(struct spu_priv1, tlb_invalidate_entry_W), 0ul);
+}
+
+static void resource_allocation_groupID_set(struct spu *spu, u64 id)
+{
+	beat_set_spe_privileged_state_1_registers(
+		spu_get_pdata(spu)->spe_id,
+		offsetof(struct spu_priv1, resource_allocation_groupID_RW),
+		id);
+}
+
+static u64 resource_allocation_groupID_get(struct spu *spu)
+{
+	u64 id;
+	beat_get_spe_privileged_state_1_registers(
+		spu_get_pdata(spu)->spe_id,
+		offsetof(struct spu_priv1, resource_allocation_groupID_RW),
+		&id);
+	return id;
+}
+
+static void resource_allocation_enable_set(struct spu *spu, u64 enable)
+{
+	beat_set_spe_privileged_state_1_registers(
+		spu_get_pdata(spu)->spe_id,
+		offsetof(struct spu_priv1, resource_allocation_enable_RW),
+		enable);
+}
+
+static u64 resource_allocation_enable_get(struct spu *spu)
+{
+	u64 enable;
+	beat_get_spe_privileged_state_1_registers(
+		spu_get_pdata(spu)->spe_id,
+		offsetof(struct spu_priv1, resource_allocation_enable_RW),
+		&enable);
+	return enable;
+}
+
+const struct spu_priv1_ops spu_priv1_beat_ops =
+{
+	.int_mask_and = int_mask_and,
+	.int_mask_or = int_mask_or,
+	.int_mask_set = int_mask_set,
+	.int_mask_get = int_mask_get,
+	.int_stat_clear = int_stat_clear,
+	.int_stat_get = int_stat_get,
+	.cpu_affinity_set = cpu_affinity_set,
+	.mfc_dar_get = mfc_dar_get,
+	.mfc_dsisr_get = mfc_dsisr_get,
+	.mfc_dsisr_set = mfc_dsisr_set,
+	.mfc_sdr_setup = mfc_sdr_setup,
+	.mfc_sr1_set = mfc_sr1_set,
+	.mfc_sr1_get = mfc_sr1_get,
+	.mfc_tclass_id_set = mfc_tclass_id_set,
+	.mfc_tclass_id_get = mfc_tclass_id_get,
+	.tlb_invalidate = tlb_invalidate,
+	.resource_allocation_groupID_set = resource_allocation_groupID_set,
+	.resource_allocation_groupID_get = resource_allocation_groupID_get,
+	.resource_allocation_enable_set = resource_allocation_enable_set,
+	.resource_allocation_enable_get = resource_allocation_enable_get,
+};
