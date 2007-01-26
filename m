Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD0FEDE01B
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 20:09:02 +1100 (EST)
Date: Fri, 26 Jan 2007 18:08:49 +0900 (JST)
Message-Id: <200701260908.l0Q98osN016778@toshiba.co.jp>
To: arnd@arndb.de
Subject: Re: [PATCH 14/19] powerpc: SPU support routines for Celleb
In-Reply-To: <200701260556.32058.arnd@arndb.de>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Friday 26 January 2007 03:10, Ishizaki Kou wrote:
> > Arnd-san,
> > 
> > Thank you for your comments.
> > 
> > > On Friday 12 January 2007 02:13, Ishizaki Kou wrote:
> > > > SPU support routines for Celleb platform.
> > > 
> > > Mostly looks good. I'm sorry I did reply to you when you asked
> > > for details about the new style device tree layout though.
> > > Your spu-manage.c file basically implements what the old
generation
> > > of IBM cell blades requires, which we're now trying to phase out.
> > 
> > We have a plan to change our DT to new-style. Our next patch will
> > support both styles.
> 
> Ok, good. I've already started doing the consolidation work, taking
> your patch and merging the code from platforms/cell into it.
> 
> This undoes part of Geoff's previous patch to make a clearer
abstraction
> between the platforms, but I think it's better to just consider
> celleb and native as the common case here and have ps3 as the
exception.
> 
> This code is entirely untested, I would normally have waited with
sending
> it out before I have verified that it does the right thing, but I want
> to avoid you duplicating that work.
> 
> Please try it out and see what you can do to make it work on celleb.

Thanks! We added some fixes and it works good on celleb.
We will post new patchset includes it, later.

Best regards,
Kou Ishizaki


> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> 
> Index: linux-cg/include/asm-powerpc/spu_priv1.h
> ===================================================================
> --- linux-cg.orig/include/asm-powerpc/spu_priv1.h
> +++ linux-cg/include/asm-powerpc/spu_priv1.h
> @@ -206,6 +206,8 @@ spu_destroy_spu (struct spu *spu)
>   */
>  
>  extern const struct spu_priv1_ops spu_priv1_mmio_ops;
> +extern const struct spu_priv1_ops spu_priv1_beat_ops;
> +
>  extern const struct spu_management_ops spu_management_of_ops;
>  
>  #endif /* __KERNEL__ */
> Index: linux-cg/arch/powerpc/platforms/celleb/spu_priv1.c
> ===================================================================
> --- /dev/null
> +++ linux-cg/arch/powerpc/platforms/celleb/spu_priv1.c
> @@ -0,0 +1,209 @@
> +/*
> + * spu hypervisor abstraction for Beat
> + *
> + * (C) Copyright 2006-2007 TOSHIBA CORPORATION
> + *
> + * This program is free software; you can redistribute it and/or
modify
> + * it under the terms of the GNU General Public License as published
by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
along
> + * with this program; if not, write to the Free Software Foundation,
Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <linux/module.h>
> +
> +#include <asm/spu.h>
> +#include <asm/spu_priv1.h>
> +
> +#include "beat_wrapper.h"
> +
> +static inline void _int_mask_set(struct spu *spu, int class, u64
mask)
> +{
> +	spu->shadow_int_mask_RW[class] = mask;
> +	beat_set_irq_mask_for_spe(spu->spe_id, class, mask);
> +}
> +
> +static inline u64 _int_mask_get(struct spu *spu, int class)
> +{
> +	return spu->shadow_int_mask_RW[class];
> +}
> +
> +static void int_mask_set(struct spu *spu, int class, u64 mask)
> +{
> +	_int_mask_set(spu, class, mask);
> +}
> +
> +static u64 int_mask_get(struct spu *spu, int class)
> +{
> +	return _int_mask_get(spu, class);
> +}
> +
> +static void int_mask_and(struct spu *spu, int class, u64 mask)
> +{
> +	u64 old_mask;
> +	old_mask = _int_mask_get(spu, class);
> +	_int_mask_set(spu, class, old_mask & mask);
> +}
> +
> +static void int_mask_or(struct spu *spu, int class, u64 mask)
> +{
> +	u64 old_mask;
> +	old_mask = _int_mask_get(spu, class);
> +	_int_mask_set(spu, class, old_mask | mask);
> +}
> +
> +static void int_stat_clear(struct spu *spu, int class, u64 stat)
> +{
> +	beat_clear_interrupt_status_of_spe(spu->spe_id,
> +					   class, stat);
> +}
> +
> +static u64 int_stat_get(struct spu *spu, int class)
> +{
> +	u64 int_stat;
> +	beat_get_interrupt_status_of_spe(spu->spe_id,
> +					 class, &int_stat);
> +	return int_stat;
> +}
> +
> +static void cpu_affinity_set(struct spu *spu, int cpu)
> +{
> +	return;
> +}
> +
> +static u64 mfc_dar_get(struct spu *spu)
> +{
> +	u64 dar;
> +	beat_get_spe_privileged_state_1_registers(
> +		spu->spe_id,
> +		offsetof(struct spu_priv1, mfc_dar_RW), &dar);
> +	return dar;
> +}
> +
> +static u64 mfc_dsisr_get(struct spu *spu)
> +{
> +	u64 dsisr;
> +	beat_get_spe_privileged_state_1_registers(
> +		spu->spe_id,
> +		offsetof(struct spu_priv1, mfc_dsisr_RW), &dsisr);
> +	return dsisr;
> +}
> +
> +static void mfc_dsisr_set(struct spu *spu, u64 dsisr)
> +{
> +	beat_set_spe_privileged_state_1_registers(
> +		spu->spe_id,
> +		offsetof(struct spu_priv1, mfc_dsisr_RW), dsisr);
> +}
> +
> +static void mfc_sdr_setup(struct spu *spu)
> +{
> +	return;
> +}
> +
> +static void mfc_sr1_set(struct spu *spu, u64 sr1)
> +{
> +	beat_set_spe_privileged_state_1_registers(
> +		spu->spe_id,
> +		offsetof(struct spu_priv1, mfc_sr1_RW), sr1);
> +}
> +
> +static u64 mfc_sr1_get(struct spu *spu)
> +{
> +	u64 sr1;
> +	beat_get_spe_privileged_state_1_registers(
> +		spu->spe_id,
> +		offsetof(struct spu_priv1, mfc_sr1_RW), &sr1);
> +	return sr1;
> +}
> +
> +static void mfc_tclass_id_set(struct spu *spu, u64 tclass_id)
> +{
> +	beat_set_spe_privileged_state_1_registers(
> +		spu->spe_id,
> +		offsetof(struct spu_priv1, mfc_tclass_id_RW),
tclass_id);
> +}
> +
> +static u64 mfc_tclass_id_get(struct spu *spu)
> +{
> +	u64 tclass_id;
> +	beat_get_spe_privileged_state_1_registers(
> +		spu->spe_id,
> +		offsetof(struct spu_priv1, mfc_tclass_id_RW),
&tclass_id);
> +	return tclass_id;
> +}
> +
> +static void tlb_invalidate(struct spu *spu)
> +{
> +	beat_set_spe_privileged_state_1_registers(
> +		spu->spe_id,
> +		offsetof(struct spu_priv1, tlb_invalidate_entry_W),
0ul);
> +}
> +
> +static void resource_allocation_groupID_set(struct spu *spu, u64 id)
> +{
> +	beat_set_spe_privileged_state_1_registers(
> +		spu->spe_id,
> +		offsetof(struct spu_priv1,
resource_allocation_groupID_RW),
> +		id);
> +}
> +
> +static u64 resource_allocation_groupID_get(struct spu *spu)
> +{
> +	u64 id;
> +	beat_get_spe_privileged_state_1_registers(
> +		spu->spe_id,
> +		offsetof(struct spu_priv1,
resource_allocation_groupID_RW),
> +		&id);
> +	return id;
> +}
> +
> +static void resource_allocation_enable_set(struct spu *spu, u64
enable)
> +{
> +	beat_set_spe_privileged_state_1_registers(
> +		spu->spe_id,
> +		offsetof(struct spu_priv1,
resource_allocation_enable_RW),
> +		enable);
> +}
> +
> +static u64 resource_allocation_enable_get(struct spu *spu)
> +{
> +	u64 enable;
> +	beat_get_spe_privileged_state_1_registers(
> +		spu->spe_id,
> +		offsetof(struct spu_priv1,
resource_allocation_enable_RW),
> +		&enable);
> +	return enable;
> +}
> +
> +const struct spu_priv1_ops spu_priv1_beat_ops =
> +{
> +	.int_mask_and = int_mask_and,
> +	.int_mask_or = int_mask_or,
> +	.int_mask_set = int_mask_set,
> +	.int_mask_get = int_mask_get,
> +	.int_stat_clear = int_stat_clear,
> +	.int_stat_get = int_stat_get,
> +	.cpu_affinity_set = cpu_affinity_set,
> +	.mfc_dar_get = mfc_dar_get,
> +	.mfc_dsisr_get = mfc_dsisr_get,
> +	.mfc_dsisr_set = mfc_dsisr_set,
> +	.mfc_sdr_setup = mfc_sdr_setup,
> +	.mfc_sr1_set = mfc_sr1_set,
> +	.mfc_sr1_get = mfc_sr1_get,
> +	.mfc_tclass_id_set = mfc_tclass_id_set,
> +	.mfc_tclass_id_get = mfc_tclass_id_get,
> +	.tlb_invalidate = tlb_invalidate,
> +	.resource_allocation_groupID_set =
resource_allocation_groupID_set,
> +	.resource_allocation_groupID_get =
resource_allocation_groupID_get,
> +	.resource_allocation_enable_set =
resource_allocation_enable_set,
> +	.resource_allocation_enable_get =
resource_allocation_enable_get,
> +};
> Index: linux-cg/arch/powerpc/platforms/cell/spu_manage.c
> ===================================================================
> --- /dev/null
> +++ linux-cg/arch/powerpc/platforms/cell/spu_manage.c
> @@ -0,0 +1,422 @@
> +/*
> + * spu management operations for Beat
> + *
> + * (C) Copyright 2006 TOSHIBA CORPORATION
> + *
> + * This code is based on
arch/powerpc/platforms/cell/spu_priv1_mmio.c:
> + *  (C) Copyright IBM Deutschland Entwicklung GmbH 2005
> + *  Copyright 2006 Sony Corp.
> + *
> + * This program is free software; you can redistribute it and/or
modify
> + * it under the terms of the GNU General Public License as published
by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
along
> + * with this program; if not, write to the Free Software Foundation,
Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/ptrace.h>
> +#include <linux/slab.h>
> +#include <linux/wait.h>
> +#include <linux/mm.h>
> +#include <linux/io.h>
> +#include <linux/mutex.h>
> +#include <linux/device.h>
> +
> +#include <asm/spu.h>
> +#include <asm/spu_priv1.h>
> +#include <asm/firmware.h>
> +#include <asm/prom.h>
> +
> +#include "spu.h"
> +
> +struct device_node *spu_devnode(struct spu *spu)
> +{
> +	return spu->devnode;
> +}
> +
> +EXPORT_SYMBOL_GPL(spu_devnode);
> +
> +static u64 __init find_spu_unit_number(struct device_node *spe)
> +{
> +	const unsigned int *prop;
> +	int proplen;
> +	prop = get_property(spe, "unit-id", &proplen);
> +	if (proplen == 4)
> +		return (u64)*prop;
> +
> +	prop = get_property(spe, "reg", &proplen);
> +	if (proplen == 4)
> +		return (u64)*prop;
> +
> +	return 0;
> +}
> +
> +static int __init cell_spuprop_present(struct spu *spu, struct
device_node *spe,
> +		const char *prop)
> +{
> +	const struct address_prop {
> +		unsigned long address;
> +		unsigned int len;
> +	} __attribute__((packed)) *p;
> +	int proplen;
> +
> +	unsigned long start_pfn, nr_pages;
> +	struct pglist_data *pgdata;
> +	struct zone *zone;
> +	int ret;
> +
> +	p = get_property(spe, prop, &proplen);
> +	WARN_ON(proplen != sizeof (*p));
> +
> +	start_pfn = p->address >> PAGE_SHIFT;
> +	nr_pages = ((unsigned long)p->len + PAGE_SIZE - 1) >>
PAGE_SHIFT;
> +
> +	pgdata = NODE_DATA(spu->node);
> +	zone = pgdata->node_zones;
> +
> +	ret = __add_pages(zone, start_pfn, nr_pages);
> +
> +	return ret;
> +}
> +
> +static void __iomem * __init map_spe_prop(struct spu *spu,
> +		struct device_node *n, const char *name)
> +{
> +	const struct address_prop {
> +		unsigned long address;
> +		unsigned int len;
> +	} __attribute__((packed)) *prop;
> +
> +	const void *p;
> +	int proplen;
> +	void __iomem *ret = NULL;
> +	int err = 0;
> +
> +	p = get_property(n, name, &proplen);
> +	if (proplen != sizeof (struct address_prop))
> +		return NULL;
> +
> +	prop = p;
> +
> +	err = cell_spuprop_present(spu, n, name);
> +	if (err && (err != -EEXIST))
> +		goto out;
> +
> +	ret = ioremap(prop->address, prop->len);
> +
> + out:
> +	return ret;
> +}
> +
> +static void spu_unmap(struct spu *spu)
> +{
> +	if (firmware_has_feature(FW_FEATURE_LPAR))
> +		iounmap(spu->priv1);
> +	iounmap(spu->priv2);
> +	iounmap(spu->problem);
> +	iounmap((__force u8 __iomem *)spu->local_store);
> +}
> +
> +static int __init spu_map_interrupts_old(struct spu *spu,
> +	struct device_node *np)
> +{
> +	unsigned int isrc;
> +	const u32 *tmp;
> +	int nid;
> +
> +	/* Get the interrupt source unit from the device-tree */
> +	tmp = get_property(np, "isrc", NULL);
> +	if (!tmp)
> +		return -ENODEV;
> +	isrc = tmp[0];
> +
> +	tmp = get_property(np->parent->parent, "node-id", NULL);
> +	if (!tmp) {
> +		printk(KERN_WARNING "%s: can't find node-id\n",
__FUNCTION__);
> +		nid = spu->node;
> +	} else
> +		nid = tmp[0];
> +
> +	/* Add the node number */
> +	isrc |= nid << IIC_IRQ_NODE_SHIFT;
> +
> +	/* Now map interrupts of all 3 classes */
> +	spu->irqs[0] = irq_create_mapping(NULL, IIC_IRQ_CLASS_0 | isrc);
> +	spu->irqs[1] = irq_create_mapping(NULL, IIC_IRQ_CLASS_1 | isrc);
> +	spu->irqs[2] = irq_create_mapping(NULL, IIC_IRQ_CLASS_2 | isrc);
> +
> +	/* Right now, we only fail if class 2 failed */
> +	return spu->irqs[2] == NO_IRQ ? -EINVAL : 0;
> +}
> +
> +static int __init spu_map_device_old(struct spu *spu)
> +{
> +	struct device_node *node = spu->devnode;
> +	const char *prop;
> +	int ret;
> +
> +	ret = -ENODEV;
> +	spu->name = get_property(node, "name", NULL);
> +	if (!spu->name)
> +		goto out;
> +
> +	prop = get_property(node, "local-store", NULL);
> +	if (!prop)
> +		goto out;
> +	spu->local_store_phys = *(unsigned long *)prop;
> +
> +	/* we use local store as ram, not io memory */
> +	spu->local_store = (void __force *)
> +		map_spe_prop(spu, node, "local-store");
> +	if (!spu->local_store)
> +		goto out;
> +
> +	prop = get_property(node, "problem", NULL);
> +	if (!prop)
> +		goto out_unmap;
> +	spu->problem_phys = *(unsigned long *)prop;
> +
> +	spu->problem = map_spe_prop(spu, node, "problem");
> +	if (!spu->problem)
> +		goto out_unmap;
> +
> +	spu->priv2 = map_spe_prop(spu, node, "priv2");
> +	if (!spu->priv2)
> +		goto out_unmap;
> +
> +	if (firmware_has_feature(FW_FEATURE_LPAR)) {
> +		spu->priv1 = map_spe_prop(spu, node, "priv1");
> +		if (!spu->priv1)
> +			goto out_unmap;
> +	}
> +
> +	ret = 0;
> +	goto out;
> +
> +out_unmap:
> +	spu_unmap(spu);
> +out:
> +	return ret;
> +}
> +
> +static int __init spu_map_interrupts(struct spu *spu, struct
device_node *np)
> +{
> +	struct of_irq oirq;
> +	int ret;
> +	int i;
> +
> +	for (i=0; i < 3; i++) {
> +		ret = of_irq_map_one(np, i, &oirq);
> +		if (ret) {
> +			pr_debug("spu_new: failed to get irq %d\n", i);
> +			goto err;
> +		}
> +		ret = -EINVAL;
> +		pr_debug("  irq %d no 0x%x on %s\n", i,
oirq.specifier[0],
> +			 oirq.controller->full_name);
> +		spu->irqs[i] = irq_create_of_mapping(oirq.controller,
> +					oirq.specifier, oirq.size);
> +		if (spu->irqs[i] == NO_IRQ) {
> +			pr_debug("spu_new: failed to map it !\n");
> +			goto err;
> +		}
> +	}
> +	return 0;
> +
> +err:
> +	pr_debug("failed to map irq %x for spu %s\n", *oirq.specifier,
> +		spu->name);
> +	for (; i >= 0; i--) {
> +		if (spu->irqs[i] != NO_IRQ)
> +			irq_dispose_mapping(spu->irqs[i]);
> +	}
> +	return ret;
> +}
> +
> +static int spu_map_resource(struct spu *spu, int nr,
> +			    void __iomem** virt, unsigned long *phys)
> +{
> +	struct device_node *np = spu->devnode;
> +	unsigned long start_pfn, nr_pages;
> +	struct pglist_data *pgdata;
> +	struct zone *zone;
> +	struct resource resource = { };
> +	unsigned long len;
> +	int ret;
> +
> +	ret = of_address_to_resource(np, nr, &resource);
> +	if (ret)
> +		goto out;
> +
> +	if (phys)
> +		*phys = resource.start;
> +	len = resource.end - resource.start + 1;
> +	*virt = ioremap(resource.start, len);
> +	if (!*virt)
> +		ret = -EINVAL;
> +
> +	start_pfn = resource.start >> PAGE_SHIFT;
> +	nr_pages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +
> +	pgdata = NODE_DATA(spu->node);
> +	zone = pgdata->node_zones;
> +
> +	ret = __add_pages(zone, start_pfn, nr_pages);
> +
> +out:
> +	return ret;
> +}
> +
> +static int __init spu_map_device(struct spu *spu)
> +{
> +	struct device_node *np = spu->devnode;
> +	int ret = -ENODEV;
> +
> +	spu->name = get_property(np, "name", NULL);
> +	if (!spu->name)
> +		goto out;
> +
> +	ret = spu_map_resource(spu, 0, (void
__iomem**)&spu->local_store,
> +			       &spu->local_store_phys);
> +	if (ret) {
> +		pr_debug("spu_new: failed to map %s resource 0\n",
> +			 np->full_name);
> +		goto out;
> +	}
> +	ret = spu_map_resource(spu, 1, (void __iomem**)&spu->problem,
> +			       &spu->problem_phys);
> +	if (ret) {
> +		pr_debug("spu_new: failed to map %s resource 1\n",
> +			 np->full_name);
> +		goto out_unmap;
> +	}
> +	ret = spu_map_resource(spu, 2, (void __iomem**)&spu->priv2,
NULL);
> +	if (ret) {
> +		pr_debug("spu_new: failed to map %s resource 2\n",
> +			 np->full_name);
> +		goto out_unmap;
> +	}
> +	if (!firmware_has_feature(FW_FEATURE_LPAR))
> +		ret = spu_map_resource(spu, 3,
> +			       (void __iomem**)&spu->priv1, NULL);
> +	if (ret) {
> +		pr_debug("spu_new: failed to map %s resource 3\n",
> +			 np->full_name);
> +		goto out_unmap;
> +	}
> +	pr_debug("spu_new: %s maps:\n", np->full_name);
> +	pr_debug("  local store   : 0x%016lx -> 0x%p\n",
> +		 spu->local_store_phys, spu->local_store);
> +	pr_debug("  problem state : 0x%016lx -> 0x%p\n",
> +		 spu->problem_phys, spu->problem);
> +	pr_debug("  priv2         :                       0x%p\n",
spu->priv2);
> +	pr_debug("  priv1         :                       0x%p\n",
spu->priv1);
> +
> +	return 0;
> +
> +out_unmap:
> +	spu_unmap(spu);
> +out:
> +	pr_debug("failed to map spe %s: %d\n", spu->name, ret);
> +	return ret;
> +}
> +
> +static int __init of_enumerate_spus(int (*fn)(void *data))
> +{
> +	int ret;
> +	struct device_node *node;
> +
> +	ret = -ENODEV;
> +	for (node = of_find_node_by_type(NULL, "spe");
> +			node; node = of_find_node_by_type(node, "spe"))
{
> +		ret = fn(node);
> +		if (ret) {
> +			printk(KERN_WARNING "%s: Error initializing
%s\n",
> +				__FUNCTION__, node->name);
> +			break;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int __init of_create_spu(struct spu *spu, void *data)
> +{
> +	int ret;
> +	struct device_node *spe = (struct device_node *)data;
> +	static int legacy_map = 0, legacy_irq = 0;
> +
> +	spu->devnode = of_node_get(spe);
> +	spu->spe_id = find_spu_unit_number(spe);
> +
> +	spu->node = of_node_to_nid(spe);
> +	if (spu->node >= MAX_NUMNODES) {
> +		printk(KERN_WARNING "SPE %s on node %d ignored,"
> +		       " node number too big\n", spe->full_name,
spu->node);
> +		printk(KERN_WARNING "Check if CONFIG_NUMA is
enabled.\n");
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	ret = spu_map_device(spu);
> +	if (ret) {
> +		if (!legacy_map) {
> +			legacy_map = 1;
> +			printk(KERN_WARNING "%s: Legacy device tree
found, "
> +				"trying to map old style\n",
__FUNCTION__);
> +		}
> +		ret = spu_map_device_old(spu);
> +		if (ret) {
> +			printk(KERN_ERR "Unable to map %s\n",
> +				spu->name);
> +			goto out;
> +		}
> +	}
> +
> +	ret = spu_map_interrupts(spu, spe);
> +	if (ret) {
> +		if (!legacy_irq) {
> +			legacy_irq = 1;
> +			printk(KERN_WARNING "%s: Legacy device tree
found, "
> +				"trying old style irq\n", __FUNCTION__);
> +		}
> +		ret = spu_map_interrupts_old(spu, spe);
> +		if (ret) {
> +			printk(KERN_ERR "%s: could not map interrupts",
> +				spu->name);
> +			goto out_unmap;
> +		}
> +	}
> +
> +	pr_debug("Using SPE %s %p %p %p %p %d\n", spu->name,
> +		spu->local_store, spu->problem, spu->priv1,
> +		spu->priv2, spu->number);
> +	goto out;
> +
> +out_unmap:
> +	spu_unmap(spu);
> +out:
> +	return ret;
> +}
> +
> +static int of_destroy_spu(struct spu *spu)
> +{
> +	spu_unmap(spu);
> +	of_node_put(spu->devnode);
> +	return 0;
> +}
> +
> +const struct spu_management_ops spu_management_of_ops = {
> +	.enumerate_spus = of_enumerate_spus,
> +	.create_spu = of_create_spu,
> +	.destroy_spu = of_destroy_spu,
> +};
> Index: linux-cg/arch/powerpc/platforms/cell/Makefile
> ===================================================================
> --- linux-cg.orig/arch/powerpc/platforms/cell/Makefile
> +++ linux-cg/arch/powerpc/platforms/cell/Makefile
> @@ -14,7 +14,12 @@ endif
>  spufs-modular-$(CONFIG_SPU_FS)		+= spu_syscalls.o
>  spu-priv1-$(CONFIG_PPC_CELL_NATIVE)	+= spu_priv1_mmio.o
>  
> +spu-manage-$(CONFIG_PPC_CELLEB)		+= spu_manage.o
> +spu-manage-$(CONFIG_PPC_CELL_NATIVE)	+= spu_manage.o
> +
>  obj-$(CONFIG_SPU_BASE)			+= spu_callbacks.o
spu_base.o \
>  					   spu_coredump.o \
>  					   $(spufs-modular-m) \
> -					   $(spu-priv1-y) spufs/
> +					   $(spu-priv1-y) \
> +					   $(spu-manage-y) \
> +					   spufs/
> Index: linux-cg/arch/powerpc/platforms/cell/spu_priv1_mmio.c
> ===================================================================
> --- linux-cg.orig/arch/powerpc/platforms/cell/spu_priv1_mmio.c
> +++ linux-cg/arch/powerpc/platforms/cell/spu_priv1_mmio.c
> @@ -37,378 +37,6 @@
>  #include "interrupt.h"
>  #include "spu_priv1_mmio.h"
>  
> -static DEFINE_MUTEX(add_spumem_mutex);
> -
> -struct spu_pdata {
> -	struct device_node *devnode;
> -	struct spu_priv1 __iomem *priv1;
> -};
> -
> -static struct spu_pdata *spu_get_pdata(struct spu *spu)
> -{
> -	BUG_ON(!spu->pdata);
> -	return spu->pdata;
> -}
> -
> -struct device_node *spu_devnode(struct spu *spu)
> -{
> -	return spu_get_pdata(spu)->devnode;
> -}
> -
> -EXPORT_SYMBOL_GPL(spu_devnode);
> -
> -static int __init cell_spuprop_present(struct spu *spu, struct
device_node *spe,
> -		const char *prop)
> -{
> -	const struct address_prop {
> -		unsigned long address;
> -		unsigned int len;
> -	} __attribute__((packed)) *p;
> -	int proplen;
> -
> -	unsigned long start_pfn, nr_pages;
> -	struct pglist_data *pgdata;
> -	struct zone *zone;
> -	int ret;
> -
> -	p = get_property(spe, prop, &proplen);
> -	WARN_ON(proplen != sizeof (*p));
> -
> -	start_pfn = p->address >> PAGE_SHIFT;
> -	nr_pages = ((unsigned long)p->len + PAGE_SIZE - 1) >>
PAGE_SHIFT;
> -
> -	pgdata = NODE_DATA(spu->node);
> -	zone = pgdata->node_zones;
> -
> -	/* XXX rethink locking here */
> -	mutex_lock(&add_spumem_mutex);
> -	ret = __add_pages(zone, start_pfn, nr_pages);
> -	mutex_unlock(&add_spumem_mutex);
> -
> -	return ret;
> -}
> -
> -static void __iomem * __init map_spe_prop(struct spu *spu,
> -		struct device_node *n, const char *name)
> -{
> -	const struct address_prop {
> -		unsigned long address;
> -		unsigned int len;
> -	} __attribute__((packed)) *prop;
> -
> -	const void *p;
> -	int proplen;
> -	void __iomem *ret = NULL;
> -	int err = 0;
> -
> -	p = get_property(n, name, &proplen);
> -	if (proplen != sizeof (struct address_prop))
> -		return NULL;
> -
> -	prop = p;
> -
> -	err = cell_spuprop_present(spu, n, name);
> -	if (err && (err != -EEXIST))
> -		goto out;
> -
> -	ret = ioremap(prop->address, prop->len);
> -
> - out:
> -	return ret;
> -}
> -
> -static void spu_unmap(struct spu *spu)
> -{
> -	iounmap(spu->priv2);
> -	iounmap(spu_get_pdata(spu)->priv1);
> -	iounmap(spu->problem);
> -	iounmap((__force u8 __iomem *)spu->local_store);
> -}
> -
> -static int __init spu_map_interrupts_old(struct spu *spu,
> -	struct device_node *np)
> -{
> -	unsigned int isrc;
> -	const u32 *tmp;
> -	int nid;
> -
> -	/* Get the interrupt source unit from the device-tree */
> -	tmp = get_property(np, "isrc", NULL);
> -	if (!tmp)
> -		return -ENODEV;
> -	isrc = tmp[0];
> -
> -	tmp = get_property(np->parent->parent, "node-id", NULL);
> -	if (!tmp) {
> -		printk(KERN_WARNING "%s: can't find node-id\n",
__FUNCTION__);
> -		nid = spu->node;
> -	} else
> -		nid = tmp[0];
> -
> -	/* Add the node number */
> -	isrc |= nid << IIC_IRQ_NODE_SHIFT;
> -
> -	/* Now map interrupts of all 3 classes */
> -	spu->irqs[0] = irq_create_mapping(NULL, IIC_IRQ_CLASS_0 | isrc);
> -	spu->irqs[1] = irq_create_mapping(NULL, IIC_IRQ_CLASS_1 | isrc);
> -	spu->irqs[2] = irq_create_mapping(NULL, IIC_IRQ_CLASS_2 | isrc);
> -
> -	/* Right now, we only fail if class 2 failed */
> -	return spu->irqs[2] == NO_IRQ ? -EINVAL : 0;
> -}
> -
> -static int __init spu_map_device_old(struct spu *spu, struct
device_node *node)
> -{
> -	const char *prop;
> -	int ret;
> -
> -	ret = -ENODEV;
> -	spu->name = get_property(node, "name", NULL);
> -	if (!spu->name)
> -		goto out;
> -
> -	prop = get_property(node, "local-store", NULL);
> -	if (!prop)
> -		goto out;
> -	spu->local_store_phys = *(unsigned long *)prop;
> -
> -	/* we use local store as ram, not io memory */
> -	spu->local_store = (void __force *)
> -		map_spe_prop(spu, node, "local-store");
> -	if (!spu->local_store)
> -		goto out;
> -
> -	prop = get_property(node, "problem", NULL);
> -	if (!prop)
> -		goto out_unmap;
> -	spu->problem_phys = *(unsigned long *)prop;
> -
> -	spu->problem= map_spe_prop(spu, node, "problem");
> -	if (!spu->problem)
> -		goto out_unmap;
> -
> -	spu_get_pdata(spu)->priv1= map_spe_prop(spu, node, "priv1");
> -
> -	spu->priv2= map_spe_prop(spu, node, "priv2");
> -	if (!spu->priv2)
> -		goto out_unmap;
> -	ret = 0;
> -	goto out;
> -
> -out_unmap:
> -	spu_unmap(spu);
> -out:
> -	return ret;
> -}
> -
> -static int __init spu_map_interrupts(struct spu *spu, struct
device_node *np)
> -{
> -	struct of_irq oirq;
> -	int ret;
> -	int i;
> -
> -	for (i=0; i < 3; i++) {
> -		ret = of_irq_map_one(np, i, &oirq);
> -		if (ret) {
> -			pr_debug("spu_new: failed to get irq %d\n", i);
> -			goto err;
> -		}
> -		ret = -EINVAL;
> -		pr_debug("  irq %d no 0x%x on %s\n", i,
oirq.specifier[0],
> -			 oirq.controller->full_name);
> -		spu->irqs[i] = irq_create_of_mapping(oirq.controller,
> -					oirq.specifier, oirq.size);
> -		if (spu->irqs[i] == NO_IRQ) {
> -			pr_debug("spu_new: failed to map it !\n");
> -			goto err;
> -		}
> -	}
> -	return 0;
> -
> -err:
> -	pr_debug("failed to map irq %x for spu %s\n", *oirq.specifier,
> -		spu->name);
> -	for (; i >= 0; i--) {
> -		if (spu->irqs[i] != NO_IRQ)
> -			irq_dispose_mapping(spu->irqs[i]);
> -	}
> -	return ret;
> -}
> -
> -static int spu_map_resource(struct spu *spu, int nr,
> -			    void __iomem** virt, unsigned long *phys)
> -{
> -	struct device_node *np = spu_get_pdata(spu)->devnode;
> -	unsigned long start_pfn, nr_pages;
> -	struct pglist_data *pgdata;
> -	struct zone *zone;
> -	struct resource resource = { };
> -	unsigned long len;
> -	int ret;
> -
> -	ret = of_address_to_resource(np, nr, &resource);
> -	if (ret)
> -		goto out;
> -
> -	if (phys)
> -		*phys = resource.start;
> -	len = resource.end - resource.start + 1;
> -	*virt = ioremap(resource.start, len);
> -	if (!*virt)
> -		ret = -EINVAL;
> -
> -	start_pfn = resource.start >> PAGE_SHIFT;
> -	nr_pages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> -
> -	pgdata = NODE_DATA(spu->node);
> -	zone = pgdata->node_zones;
> -
> -	/* XXX rethink locking here */
> -	mutex_lock(&add_spumem_mutex);
> -	ret = __add_pages(zone, start_pfn, nr_pages);
> -	mutex_unlock(&add_spumem_mutex);
> -
> -out:
> -	return ret;
> -}
> -
> -static int __init spu_map_device(struct spu *spu)
> -{
> -	struct device_node *np = spu_get_pdata(spu)->devnode;
> -	int ret = -ENODEV;
> -
> -	spu->name = get_property(np, "name", NULL);
> -	if (!spu->name)
> -		goto out;
> -
> -	ret = spu_map_resource(spu, 0, (void
__iomem**)&spu->local_store,
> -			       &spu->local_store_phys);
> -	if (ret) {
> -		pr_debug("spu_new: failed to map %s resource 0\n",
> -			 np->full_name);
> -		goto out;
> -	}
> -	ret = spu_map_resource(spu, 1, (void __iomem**)&spu->problem,
> -			       &spu->problem_phys);
> -	if (ret) {
> -		pr_debug("spu_new: failed to map %s resource 1\n",
> -			 np->full_name);
> -		goto out_unmap;
> -	}
> -	ret = spu_map_resource(spu, 2, (void __iomem**)&spu->priv2,
NULL);
> -	if (ret) {
> -		pr_debug("spu_new: failed to map %s resource 2\n",
> -			 np->full_name);
> -		goto out_unmap;
> -	}
> -	if (!firmware_has_feature(FW_FEATURE_LPAR))
> -		ret = spu_map_resource(spu, 3,
> -			       (void
__iomem**)&spu_get_pdata(spu)->priv1, NULL);
> -	if (ret) {
> -		pr_debug("spu_new: failed to map %s resource 3\n",
> -			 np->full_name);
> -		goto out_unmap;
> -	}
> -	pr_debug("spu_new: %s maps:\n", np->full_name);
> -	pr_debug("  local store   : 0x%016lx -> 0x%p\n",
> -		 spu->local_store_phys, spu->local_store);
> -	pr_debug("  problem state : 0x%016lx -> 0x%p\n",
> -		 spu->problem_phys, spu->problem);
> -	pr_debug("  priv2         :                       0x%p\n",
spu->priv2);
> -	pr_debug("  priv1         :                       0x%p\n",
> -		 spu_get_pdata(spu)->priv1);
> -
> -	return 0;
> -
> -out_unmap:
> -	spu_unmap(spu);
> -out:
> -	pr_debug("failed to map spe %s: %d\n", spu->name, ret);
> -	return ret;
> -}
> -
> -static int __init of_enumerate_spus(int (*fn)(void *data))
> -{
> -	int ret;
> -	struct device_node *node;
> -
> -	ret = -ENODEV;
> -	for (node = of_find_node_by_type(NULL, "spe");
> -			node; node = of_find_node_by_type(node, "spe"))
{
> -		ret = fn(node);
> -		if (ret) {
> -			printk(KERN_WARNING "%s: Error initializing
%s\n",
> -				__FUNCTION__, node->name);
> -			break;
> -		}
> -	}
> -	return ret;
> -}
> -
> -static int __init of_create_spu(struct spu *spu, void *data)
> -{
> -	int ret;
> -	struct device_node *spe = (struct device_node *)data;
> -
> -	spu->pdata = kzalloc(sizeof(struct spu_pdata),
> -		GFP_KERNEL);
> -	if (!spu->pdata) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -	spu_get_pdata(spu)->devnode = of_node_get(spe);
> -
> -	spu->node = of_node_to_nid(spe);
> -	if (spu->node >= MAX_NUMNODES) {
> -		printk(KERN_WARNING "SPE %s on node %d ignored,"
> -		       " node number too big\n", spe->full_name,
spu->node);
> -		printk(KERN_WARNING "Check if CONFIG_NUMA is
enabled.\n");
> -		ret = -ENODEV;
> -		goto out_free;
> -	}
> -
> -	ret = spu_map_device(spu);
> -	/* try old method */
> -	if (ret)
> -		ret = spu_map_device_old(spu, spe);
> -	if (ret)
> -		goto out_free;
> -
> -	ret = spu_map_interrupts(spu, spe);
> -	if (ret)
> -		ret = spu_map_interrupts_old(spu, spe);
> -	if (ret)
> -		goto out_unmap;
> -
> -	pr_debug(KERN_DEBUG "Using SPE %s %p %p %p %p %d\n", spu->name,
> -		spu->local_store, spu->problem,
spu_get_pdata(spu)->priv1,
> -		spu->priv2, spu->number);
> -	goto out;
> -
> -out_unmap:
> -	spu_unmap(spu);
> -out_free:
> -	kfree(spu->pdata);
> -	spu->pdata = NULL;
> -out:
> -	return ret;
> -}
> -
> -static int of_destroy_spu(struct spu *spu)
> -{
> -	spu_unmap(spu);
> -	of_node_put(spu_get_pdata(spu)->devnode);
> -	kfree(spu->pdata);
> -	spu->pdata = NULL;
> -	return 0;
> -}
> -
> -const struct spu_management_ops spu_management_of_ops = {
> -	.enumerate_spus = of_enumerate_spus,
> -	.create_spu = of_create_spu,
> -	.destroy_spu = of_destroy_spu,
> -};
> -
>  static void int_mask_and(struct spu *spu, int class, u64 mask)
>  {
>  	u64 old_mask;
> Index: linux-cg/include/asm-powerpc/spu.h
> ===================================================================
> --- linux-cg.orig/include/asm-powerpc/spu.h
> +++ linux-cg/include/asm-powerpc/spu.h
> @@ -104,6 +104,7 @@
>  
>  struct spu_context;
>  struct spu_runqueue;
> +struct device_node;
>  
>  struct spu {
>  	const char *name;
> @@ -142,7 +143,19 @@ struct spu {
>  	char irq_c1[8];
>  	char irq_c2[8];
>  
> +	u64 spe_id;
> +
>  	void* pdata; /* platform private data */
> +
> +	/* of based platforms only */
> +	struct device_node *devnode;
> +
> +	/* native only */
> +	struct spu_priv1 __iomem *priv1;
> +
> +	/* beat only */
> +	u64 shadow_int_mask_RW[3];
> +
>  	struct sys_device sysdev;
>  };
>  
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
