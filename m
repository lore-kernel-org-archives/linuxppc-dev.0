Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F1C6A67C41
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 12:48:17 +1100 (EST)
Date: Thu, 14 Dec 2006 10:48:07 +0900 (JST)
Message-Id: <200612140148.kBE1m8Bp008592@toshiba.co.jp>
To: arnd@arndb.de
Subject: Re: [PATCH 10/15] celleb: SPU support routines
In-Reply-To: <200612121359.14660.arnd@arndb.de>
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

Arnd-san,

Thank you for your comment.

> On Tuesday 12 December 2006 04:49, Ishizaki Kou wrote:
> 
> > +static int __init find_spu_node_id(struct device_node *spe)
> > +{
> > +	const unsigned int *id;
> > +	struct device_node *cpu;
> > +	cpu = spe->parent->parent;
> > +	id = get_property(cpu, "node-id", NULL);
> > +	return id ? *id : 0;
> > +}
> > +
> > +static u64 __init find_spu_unit_number(struct device_node *spe)
> > +{
> > +	const unsigned int *reg;
> > +	reg = get_property(spe, "reg", NULL);
> > +	return reg ? (u64)*reg : 0ul;
> > +}
> > +
> > +static int __init cell_spuprop_present(struct spu *spu, struct device_node *spe,
> > +		const char *prop)
> > +{
> > +	static DEFINE_MUTEX(add_spumem_mutex);
> > +
> > +	const struct address_prop {
> > +	      unsigned long address;
> > +		       unsigned int len;
> > +		       } __attribute__((packed)) *p;
> > +		       int proplen;
> > +
> > +	unsigned long start_pfn, nr_pages;
> > +	struct pglist_data *pgdata;
> > +	struct zone *zone;
> > +	int ret;
> > +
> > +	p = get_property(spe, prop, &proplen);
> > +	WARN_ON(proplen != sizeof (*p));
> > +
> > +	start_pfn = p->address >> PAGE_SHIFT;
> > +	nr_pages = ((unsigned long)p->len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > +
> > +	pgdata = NODE_DATA(spu_get_pdata(spu)->nid);
> > +	zone = pgdata->node_zones;
> > +
> > +	/* XXX rethink locking here */
> > +	mutex_lock(&add_spumem_mutex);
> > +	ret = __add_pages(zone, start_pfn, nr_pages);
> > +	mutex_unlock(&add_spumem_mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +static void __iomem * __init map_spe_prop(struct spu *spu,
> > +		 struct device_node *n, const char *name)
> > +{
> > +	const struct address_prop {
> > +	      unsigned long address;
> > +		       unsigned int len;
> > +		       } __attribute__((packed)) *prop;
> > +
> > +	const void *p;
> > +	int proplen;
> > +	void __iomem *ret = NULL;
> > +	int err = 0;
> > +
> > +	p = get_property(n, name, &proplen);
> > +	if (proplen != sizeof (struct address_prop))
> > +	   return NULL;
> > +
> > +	prop = p;
> > +
> > +	err = cell_spuprop_present(spu, n, name);
> > +	if (err && (err != -EEXIST))
> > +	   goto out;
> > +
> > +	ret = ioremap(prop->address, prop->len);
> > +
> > + out:
> > + return ret;
> > +}
> > +
> > +static void spu_unmap(struct spu *spu)
> > +{
> > +	iounmap(spu->priv2);
> > +	iounmap(spu->problem);
> > +	iounmap((__force u8 __iomem *)spu->local_store);
> > +}
> > +
> > +static int __init spu_map_device(struct spu *spu, struct device_node *node)
> > +{
> > +	const char *prop;
> > +	int ret;
> > +
> > +	ret = -ENODEV;
> > +	spu->name = get_property(node, "name", NULL);
> > +	if (!spu->name)
> > +	   goto out;
> > +
> > +	prop = get_property(node, "local-store", NULL);
> > +	if (!prop)
> > +	   goto out;
> > +	   spu->local_store_phys = *(unsigned long *)prop;
> > +
> > +	/* we use local store as ram, not io memory */
> > +	spu->local_store = (void __force *)
> > +			 map_spe_prop(spu, node, "local-store");
> > +			 if (!spu->local_store)
> > +			    goto out;
> > +
> > +	prop = get_property(node, "problem", NULL);
> > +	if (!prop)
> > +	   goto out_unmap;
> > +	   spu->problem_phys = *(unsigned long *)prop;
> > +
> > +	spu->problem= map_spe_prop(spu, node, "problem");
> > +	if (!spu->problem)
> > +	   goto out_unmap;
> > +
> > +	spu->priv2= map_spe_prop(spu, node, "priv2");
> > +	if (!spu->priv2)
> > +	   goto out_unmap;
> > +	   ret = 0;
> > +	   goto out;
> > +
> > +out_unmap:
> > +	spu_unmap(spu);
> > +out:
> > +	return ret;
> > +}
> > +
> > +static int __init spu_map_interrupts(struct spu *spu, struct device_node *np)
> > +{
> > +	struct of_irq oirq;
> > +	int ret;
> > +	int i;
> > +
> > +	for (i=0; i < 3; i++) {
> > +	    ret = of_irq_map_one(np, i, &oirq);
> > +		if (ret) {
> > +			 pr_debug("spu_new: failed to get irq %d\n", i);
> > +						   goto err;
> > +							}
> > +								ret = -EINVAL;
> > +								    pr_debug("  irq %d no 0x%x on %s\n", i, oirq.specifier[0],
> > +										     oirq.controller->full_name);
> > +											spu->irqs[i] = irq_create_of_mapping(oirq.controller,
> > +														oirq.specifier, oirq.size);
> > +																if (spu->irqs[i] == NO_IRQ) {
> > +																		 pr_debug("spu_new: failed to map it !\n");
> > +																					   goto err;
> > +																						}
> > +																						}
> > +																						return 0;
> > +
> > +err:
> > +	pr_debug("failed to map irq %x for spu %s\n", *oirq.specifier,
> > +			 spu->name);
> > +			 for (; i >= 0; i--) {
> > +			     if (spu->irqs[i] != NO_IRQ)
> > +					      irq_dispose_mapping(spu->irqs[i]);
> > +					      }
> > +					      return ret;
> > +}
> > +
> > +static int __init of_enumerate_spus(int (*fn)(void *data))
> > +{
> > +	int ret;
> > +	struct device_node *node;
> > +
> > +	ret = -ENODEV;
> > +	for (node = of_find_node_by_type(NULL, "spe");
> > +		  node; node = of_find_node_by_type(node, "spe")) {
> > +			ret = fn(node);
> > +			    if (ret) {
> > +				     printk(KERN_WARNING "%s: Error initializing %s\n",
> > +								    __FUNCTION__, node->name);
> > +											break;
> > +												}
> > +												}
> > +												return ret;
> > +}
> > +> > +static int __init beat_create_spu(struct spu *spu, void *data)
> > +{
> > +	int ret;
> > +	struct device_node *spe = (struct device_node *)data;
> > +
> > +	spu->pdata = kzalloc(sizeof(struct spu_pdata),
> > +		   GFP_KERNEL);
> > +		   if (!spu->pdata) {
> > +		      ret = -ENOMEM;
> > +			  goto out;
> > +			  }
> > +
> > +	spu->node = find_spu_node_id(spe);
> > +	if (spu->node >= MAX_NUMNODES) {
> > +	   printk(KERN_WARNING "SPE %s on node %d ignored,"
> > +			              " node number too big\n", spe->full_name, spu->node);
> > +					printk(KERN_WARNING "Check if CONFIG_NUMA is enabled.\n");
> > +							    ret = -ENODEV;
> > +								goto out_free;
> > +								}
> > +
> > +	spu_get_pdata(spu)->nid = of_node_to_nid(spe);
> > +	if (spu_get_pdata(spu)->nid == -1)
> > +	   spu_get_pdata(spu)->nid = 0;
> > +
> > +	spu_get_pdata(spu)->unit_number = find_spu_unit_number(spe);
> > +
> > +	ret = spu_map_device(spu, spe);
> > +	if (ret)
> > +	   goto out_free;
> > +
> > +	ret = spu_map_interrupts(spu, spe);
> > +	if (ret)
> > +	   goto out_unmap;
> > +
> > +	pr_debug(KERN_DEBUG "Using SPE %s %p %p %p %d\n", spu->name,
> > +			    spu->local_store, spu->problem, spu->priv2, spu->number);
> > +			    goto out;
> > +
> > +out_unmap:
> > +	spu_unmap(spu);
> > +out_free:
> > +	kfree(spu->pdata);
> > +	spu->pdata = NULL;
> > +out:
> > +	return ret;
> > +}
> > +
> 
> All this code is just the same as the one from 
> platforms/cell/spu_priv1_mmio.c, right? I guess it should really be a separate
> file then that is used by both platforms in that case, in particular since
> I have a few bug fixes for it that may easily get out of sync. I should
> have probably noticed that when Geoff moved this code around in the ps3
> merge, but it looks like we need to move it again.

Most of our SPU management routines are imported from
platforms/cell/spu_priv1_mmio.c and some functions are modified for
Beat.

There are two differences with Cell Blade.

 - platform private data
  Beat requires some private members and initailizing.

 - device-tree
  Standard binding doesn't exist. Our DT is similar to 'old' style of
  Cell Blade but not identical.

We think the integration of codes is preferable, but this is our first code
for public and we need time to modify them. So, this time we hope they are
merged into as it is. We'd like to discuss and modify our codes toward
integrated codes after this first merge.  


Best regards,
Kou Ishizaki
Toshiba
