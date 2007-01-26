Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7467DDE2C
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 13:10:36 +1100 (EST)
Date: Fri, 26 Jan 2007 11:10:22 +0900 (JST)
Message-Id: <200701260210.l0Q2APnf029552@toshiba.co.jp>
To: arnd@arndb.de
Subject: Re: [PATCH 14/19] powerpc: SPU support routines for Celleb
In-Reply-To: <200701240808.14283.arnd@arndb.de>
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

Thank you for your comments.

> On Friday 12 January 2007 02:13, Ishizaki Kou wrote:
> > SPU support routines for Celleb platform.
> 
> Mostly looks good. I'm sorry I did reply to you when you asked
> for details about the new style device tree layout though.
> Your spu-manage.c file basically implements what the old generation
> of IBM cell blades requires, which we're now trying to phase out.

We have a plan to change our DT to new-style. Our next patch will
support both styles.


> My feeling is that we should try to consolidate this again into
> a common manage.c file for both celleb and ibm blades, as opposed
> to the ps3 platform that needs to do this in a completely different
> way.

We agree to try to consolidate. There are some differences between the
private data structures. We need abstraction to resolve them.


> I'll try to do a write a version that should run on both celleb
> and the blades, using either version of the device tree layout,
> so you can convert your device trees in future releases.
> 
> If you send a patch that leaves out manage.c in the meantime,
> I'll Ack that one.
> 
>	Arnd <><
> 
> > +static int __init find_spu_node_id(struct device_node *spe)
> > +{
> > +	const unsigned int *id;
> > +	struct device_node *cpu;
> > +	cpu = spe->parent->parent;
> > +	id = get_property(cpu, "node-id", NULL);
> > +	return id ? *id : 0;
> > +}
> 
> This breaks when the SPE is not a child of a child of a CPU
> node. The new model would put it into a /be node.
> 
> The right solution is to replace this function with a call to
> of_node_to_nid(), which does the right thing everywhere.

This is imported from *old* cell/spu_priv1_mmio.c. We will refresh it.


> > +static u64 __init find_spu_unit_number(struct device_node *spe)
> > +{
> > +	const unsigned int *reg;
> > +	reg = get_property(spe, "reg", NULL);
> > +	return reg ? (u64)*reg : 0ul;
> > +}
> 
> This is the bigger problem, since the "reg" property changed its meaning.
> It should probably check the "unit-id" property first, and only
> use the "reg" property if in backwards-compatible mode.

Yes. To support both styles, we will change to use "unit-id" first.


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
> 
> This should be the same as the other, existing, function of the 
> same name.

To consolidate easily, our patch uses same name on functions that are
imported and not changed.


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
> > +static void spu_unmap_beat(struct spu *spu)
> > +{
> > +	iounmap(spu->priv2);
> > +	iounmap(spu->problem);
> > +	iounmap((__force u8 __iomem *)spu->local_store);
> > +}
> > +
> > +static int __init spu_map_device_beat(struct spu *spu,
> > +						        struct device_node *node)
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
> > +	spu_unmap_beat(spu);
> > +out:
> > +	return ret;
> > +}
> 
> In the new model, the information comes from the 'reg' property,
> instead of individual ones. "priv1" is intentionally kept last in
> that list, so it can be left out for the hv case.
> 
>	Arnd <><

Best regards,
Kou Ishizaki
