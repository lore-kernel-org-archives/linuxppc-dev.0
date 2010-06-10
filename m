Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 531D31007DE
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 16:43:52 +1000 (EST)
Subject: Re: [PATCH 3/5] of/address: Merge all of the bus translation code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20100608141008.25879.2050.stgit@angua>
References: <20100608140917.25879.67745.stgit@angua>
	<20100608141008.25879.2050.stgit@angua>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Jun 2010 16:43:32 +1000
Message-ID: <1276152212.1962.59.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-06-08 at 08:10 -0600, Grant Likely wrote:
> Microblaze and PowerPC share a large chunk of code for translating
> OF device tree data into usable addresses.  There aren't many differences
                                                           ^^^^
Care to comment on these differences ?

> between the two, so merge the codebase wholesale rather than trying to
> work out the independent bits.

Well, I don't see ifdef's in the resulting code (but I'm a bit blind),
so what did you do with the differences ?

This is complex and fragile code, so any change to it must be very
carefully scrutinized.

Cheers,
Ben.

> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> CC: Michal Simek <monstr@monstr.eu>
> CC: Wolfram Sang <w.sang@pengutronix.de>
> CC: Stephen Rothwell <sfr@canb.auug.org.au>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: microblaze-uclinux@itee.uq.edu.au
> CC: linuxppc-dev@ozlabs.org
> ---
>  arch/microblaze/include/asm/prom.h  |    4 
>  arch/microblaze/kernel/prom_parse.c |  489 ---------------------------------
>  arch/powerpc/include/asm/prom.h     |    4 
>  arch/powerpc/kernel/prom_parse.c    |  515 -----------------------------------
>  drivers/of/address.c                |  517 +++++++++++++++++++++++++++++++++++
>  include/linux/of_address.h          |    4 
>  6 files changed, 515 insertions(+), 1018 deletions(-)
> 
> diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
> index 644fa32..35cb3de 100644
> --- a/arch/microblaze/include/asm/prom.h
> +++ b/arch/microblaze/include/asm/prom.h
> @@ -52,10 +52,6 @@ extern void pci_create_OF_bus_map(void);
>   * OF address retreival & translation
>   */
>  
> -/* Translate an OF address block into a CPU physical address
> - */
> -extern u64 of_translate_address(struct device_node *np, const u32 *addr);
> -
>  /* Extract an address from a device, returns the region size and
>   * the address space flags too. The PCI version uses a BAR number
>   * instead of an absolute index
> diff --git a/arch/microblaze/kernel/prom_parse.c b/arch/microblaze/kernel/prom_parse.c
> index 7cb5a98..1d610e6 100644
> --- a/arch/microblaze/kernel/prom_parse.c
> +++ b/arch/microblaze/kernel/prom_parse.c
> @@ -10,213 +10,7 @@
>  #include <asm/prom.h>
>  #include <asm/pci-bridge.h>
>  
> -#define PRu64	"%llx"
> -
> -/* Max address size we deal with */
> -#define OF_MAX_ADDR_CELLS	4
> -#define OF_CHECK_COUNTS(na, ns)	((na) > 0 && (na) <= OF_MAX_ADDR_CELLS && \
> -			(ns) > 0)
> -
> -static struct of_bus *of_match_bus(struct device_node *np);
> -
> -/* Debug utility */
> -#ifdef DEBUG
> -static void of_dump_addr(const char *s, const u32 *addr, int na)
> -{
> -	printk(KERN_INFO "%s", s);
> -	while (na--)
> -		printk(KERN_INFO " %08x", *(addr++));
> -	printk(KERN_INFO "\n");
> -}
> -#else
> -static void of_dump_addr(const char *s, const u32 *addr, int na) { }
> -#endif
> -
> -/* Callbacks for bus specific translators */
> -struct of_bus {
> -	const char	*name;
> -	const char	*addresses;
> -	int		(*match)(struct device_node *parent);
> -	void		(*count_cells)(struct device_node *child,
> -					int *addrc, int *sizec);
> -	u64		(*map)(u32 *addr, const u32 *range,
> -				int na, int ns, int pna);
> -	int		(*translate)(u32 *addr, u64 offset, int na);
> -	unsigned int	(*get_flags)(const u32 *addr);
> -};
> -
> -/*
> - * Default translator (generic bus)
> - */
> -
> -static void of_bus_default_count_cells(struct device_node *dev,
> -					int *addrc, int *sizec)
> -{
> -	if (addrc)
> -		*addrc = of_n_addr_cells(dev);
> -	if (sizec)
> -		*sizec = of_n_size_cells(dev);
> -}
> -
> -static u64 of_bus_default_map(u32 *addr, const u32 *range,
> -		int na, int ns, int pna)
> -{
> -	u64 cp, s, da;
> -
> -	cp = of_read_number(range, na);
> -	s  = of_read_number(range + na + pna, ns);
> -	da = of_read_number(addr, na);
> -
> -	pr_debug("OF: default map, cp="PRu64", s="PRu64", da="PRu64"\n",
> -		cp, s, da);
> -
> -	if (da < cp || da >= (cp + s))
> -		return OF_BAD_ADDR;
> -	return da - cp;
> -}
> -
> -static int of_bus_default_translate(u32 *addr, u64 offset, int na)
> -{
> -	u64 a = of_read_number(addr, na);
> -	memset(addr, 0, na * 4);
> -	a += offset;
> -	if (na > 1)
> -		addr[na - 2] = a >> 32;
> -	addr[na - 1] = a & 0xffffffffu;
> -
> -	return 0;
> -}
> -
> -static unsigned int of_bus_default_get_flags(const u32 *addr)
> -{
> -	return IORESOURCE_MEM;
> -}
> -
>  #ifdef CONFIG_PCI
> -/*
> - * PCI bus specific translator
> - */
> -
> -static int of_bus_pci_match(struct device_node *np)
> -{
> -	/* "vci" is for the /chaos bridge on 1st-gen PCI powermacs */
> -	return !strcmp(np->type, "pci") || !strcmp(np->type, "vci");
> -}
> -
> -static void of_bus_pci_count_cells(struct device_node *np,
> -				int *addrc, int *sizec)
> -{
> -	if (addrc)
> -		*addrc = 3;
> -	if (sizec)
> -		*sizec = 2;
> -}
> -
> -static u64 of_bus_pci_map(u32 *addr, const u32 *range, int na, int ns, int pna)
> -{
> -	u64 cp, s, da;
> -
> -	/* Check address type match */
> -	if ((addr[0] ^ range[0]) & 0x03000000)
> -		return OF_BAD_ADDR;
> -
> -	/* Read address values, skipping high cell */
> -	cp = of_read_number(range + 1, na - 1);
> -	s  = of_read_number(range + na + pna, ns);
> -	da = of_read_number(addr + 1, na - 1);
> -
> -	pr_debug("OF: PCI map, cp="PRu64", s="PRu64", da="PRu64"\n", cp, s, da);
> -
> -	if (da < cp || da >= (cp + s))
> -		return OF_BAD_ADDR;
> -	return da - cp;
> -}
> -
> -static int of_bus_pci_translate(u32 *addr, u64 offset, int na)
> -{
> -	return of_bus_default_translate(addr + 1, offset, na - 1);
> -}
> -
> -static unsigned int of_bus_pci_get_flags(const u32 *addr)
> -{
> -	unsigned int flags = 0;
> -	u32 w = addr[0];
> -
> -	switch ((w >> 24) & 0x03) {
> -	case 0x01:
> -		flags |= IORESOURCE_IO;
> -		break;
> -	case 0x02: /* 32 bits */
> -	case 0x03: /* 64 bits */
> -		flags |= IORESOURCE_MEM;
> -		break;
> -	}
> -	if (w & 0x40000000)
> -		flags |= IORESOURCE_PREFETCH;
> -	return flags;
> -}
> -
> -const u32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 *size,
> -			unsigned int *flags)
> -{
> -	const u32 *prop;
> -	unsigned int psize;
> -	struct device_node *parent;
> -	struct of_bus *bus;
> -	int onesize, i, na, ns;
> -
> -	/* Get parent & match bus type */
> -	parent = of_get_parent(dev);
> -	if (parent == NULL)
> -		return NULL;
> -	bus = of_match_bus(parent);
> -	if (strcmp(bus->name, "pci")) {
> -		of_node_put(parent);
> -		return NULL;
> -	}
> -	bus->count_cells(dev, &na, &ns);
> -	of_node_put(parent);
> -	if (!OF_CHECK_COUNTS(na, ns))
> -		return NULL;
> -
> -	/* Get "reg" or "assigned-addresses" property */
> -	prop = of_get_property(dev, bus->addresses, &psize);
> -	if (prop == NULL)
> -		return NULL;
> -	psize /= 4;
> -
> -	onesize = na + ns;
> -	for (i = 0; psize >= onesize; psize -= onesize, prop += onesize, i++)
> -		if ((prop[0] & 0xff) == ((bar_no * 4) + PCI_BASE_ADDRESS_0)) {
> -			if (size)
> -				*size = of_read_number(prop + na, ns);
> -			if (flags)
> -				*flags = bus->get_flags(prop);
> -			return prop;
> -		}
> -	return NULL;
> -}
> -EXPORT_SYMBOL(of_get_pci_address);
> -
> -int of_pci_address_to_resource(struct device_node *dev, int bar,
> -				struct resource *r)
> -{
> -	const u32	*addrp;
> -	u64		size;
> -	unsigned int	flags;
> -
> -	addrp = of_get_pci_address(dev, bar, &size, &flags);
> -	if (addrp == NULL)
> -		return -EINVAL;
> -	return __of_address_to_resource(dev, addrp, size, flags, r);
> -}
> -EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
> -
> -static u8 of_irq_pci_swizzle(u8 slot, u8 pin)
> -{
> -	return (((pin - 1) + slot) % 4) + 1;
> -}
> -
>  int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
>  {
>  	struct device_node *dn, *ppnode;
> @@ -291,289 +85,6 @@ int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
>  EXPORT_SYMBOL_GPL(of_irq_map_pci);
>  #endif /* CONFIG_PCI */
>  
> -/*
> - * ISA bus specific translator
> - */
> -
> -static int of_bus_isa_match(struct device_node *np)
> -{
> -	return !strcmp(np->name, "isa");
> -}
> -
> -static void of_bus_isa_count_cells(struct device_node *child,
> -				int *addrc, int *sizec)
> -{
> -	if (addrc)
> -		*addrc = 2;
> -	if (sizec)
> -		*sizec = 1;
> -}
> -
> -static u64 of_bus_isa_map(u32 *addr, const u32 *range, int na, int ns, int pna)
> -{
> -	u64 cp, s, da;
> -
> -	/* Check address type match */
> -	if ((addr[0] ^ range[0]) & 0x00000001)
> -		return OF_BAD_ADDR;
> -
> -	/* Read address values, skipping high cell */
> -	cp = of_read_number(range + 1, na - 1);
> -	s  = of_read_number(range + na + pna, ns);
> -	da = of_read_number(addr + 1, na - 1);
> -
> -	pr_debug("OF: ISA map, cp="PRu64", s="PRu64", da="PRu64"\n", cp, s, da);
> -
> -	if (da < cp || da >= (cp + s))
> -		return OF_BAD_ADDR;
> -	return da - cp;
> -}
> -
> -static int of_bus_isa_translate(u32 *addr, u64 offset, int na)
> -{
> -	return of_bus_default_translate(addr + 1, offset, na - 1);
> -}
> -
> -static unsigned int of_bus_isa_get_flags(const u32 *addr)
> -{
> -	unsigned int flags = 0;
> -	u32 w = addr[0];
> -
> -	if (w & 1)
> -		flags |= IORESOURCE_IO;
> -	else
> -		flags |= IORESOURCE_MEM;
> -	return flags;
> -}
> -
> -/*
> - * Array of bus specific translators
> - */
> -
> -static struct of_bus of_busses[] = {
> -#ifdef CONFIG_PCI
> -	/* PCI */
> -	{
> -		.name = "pci",
> -		.addresses = "assigned-addresses",
> -		.match = of_bus_pci_match,
> -		.count_cells = of_bus_pci_count_cells,
> -		.map = of_bus_pci_map,
> -		.translate = of_bus_pci_translate,
> -		.get_flags = of_bus_pci_get_flags,
> -	},
> -#endif /* CONFIG_PCI */
> -	/* ISA */
> -	{
> -		.name = "isa",
> -		.addresses = "reg",
> -		.match = of_bus_isa_match,
> -		.count_cells = of_bus_isa_count_cells,
> -		.map = of_bus_isa_map,
> -		.translate = of_bus_isa_translate,
> -		.get_flags = of_bus_isa_get_flags,
> -	},
> -	/* Default */
> -	{
> -		.name = "default",
> -		.addresses = "reg",
> -		.match = NULL,
> -		.count_cells = of_bus_default_count_cells,
> -		.map = of_bus_default_map,
> -		.translate = of_bus_default_translate,
> -		.get_flags = of_bus_default_get_flags,
> -	},
> -};
> -
> -static struct of_bus *of_match_bus(struct device_node *np)
> -{
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(of_busses); i++)
> -		if (!of_busses[i].match || of_busses[i].match(np))
> -			return &of_busses[i];
> -	BUG();
> -	return NULL;
> -}
> -
> -static int of_translate_one(struct device_node *parent, struct of_bus *bus,
> -			struct of_bus *pbus, u32 *addr,
> -			int na, int ns, int pna)
> -{
> -	const u32 *ranges;
> -	unsigned int rlen;
> -	int rone;
> -	u64 offset = OF_BAD_ADDR;
> -
> -	/* Normally, an absence of a "ranges" property means we are
> -	 * crossing a non-translatable boundary, and thus the addresses
> -	 * below the current not cannot be converted to CPU physical ones.
> -	 * Unfortunately, while this is very clear in the spec, it's not
> -	 * what Apple understood, and they do have things like /uni-n or
> -	 * /ht nodes with no "ranges" property and a lot of perfectly
> -	 * useable mapped devices below them. Thus we treat the absence of
> -	 * "ranges" as equivalent to an empty "ranges" property which means
> -	 * a 1:1 translation at that level. It's up to the caller not to try
> -	 * to translate addresses that aren't supposed to be translated in
> -	 * the first place. --BenH.
> -	 */
> -	ranges = of_get_property(parent, "ranges", (int *) &rlen);
> -	if (ranges == NULL || rlen == 0) {
> -		offset = of_read_number(addr, na);
> -		memset(addr, 0, pna * 4);
> -		pr_debug("OF: no ranges, 1:1 translation\n");
> -		goto finish;
> -	}
> -
> -	pr_debug("OF: walking ranges...\n");
> -
> -	/* Now walk through the ranges */
> -	rlen /= 4;
> -	rone = na + pna + ns;
> -	for (; rlen >= rone; rlen -= rone, ranges += rone) {
> -		offset = bus->map(addr, ranges, na, ns, pna);
> -		if (offset != OF_BAD_ADDR)
> -			break;
> -	}
> -	if (offset == OF_BAD_ADDR) {
> -		pr_debug("OF: not found !\n");
> -		return 1;
> -	}
> -	memcpy(addr, ranges + na, 4 * pna);
> -
> - finish:
> -	of_dump_addr("OF: parent translation for:", addr, pna);
> -	pr_debug("OF: with offset: "PRu64"\n", offset);
> -
> -	/* Translate it into parent bus space */
> -	return pbus->translate(addr, offset, pna);
> -}
> -
> -/*
> - * Translate an address from the device-tree into a CPU physical address,
> - * this walks up the tree and applies the various bus mappings on the
> - * way.
> - *
> - * Note: We consider that crossing any level with #size-cells == 0 to mean
> - * that translation is impossible (that is we are not dealing with a value
> - * that can be mapped to a cpu physical address). This is not really specified
> - * that way, but this is traditionally the way IBM at least do things
> - */
> -u64 of_translate_address(struct device_node *dev, const u32 *in_addr)
> -{
> -	struct device_node *parent = NULL;
> -	struct of_bus *bus, *pbus;
> -	u32 addr[OF_MAX_ADDR_CELLS];
> -	int na, ns, pna, pns;
> -	u64 result = OF_BAD_ADDR;
> -
> -	pr_debug("OF: ** translation for device %s **\n", dev->full_name);
> -
> -	/* Increase refcount at current level */
> -	of_node_get(dev);
> -
> -	/* Get parent & match bus type */
> -	parent = of_get_parent(dev);
> -	if (parent == NULL)
> -		goto bail;
> -	bus = of_match_bus(parent);
> -
> -	/* Cound address cells & copy address locally */
> -	bus->count_cells(dev, &na, &ns);
> -	if (!OF_CHECK_COUNTS(na, ns)) {
> -		printk(KERN_ERR "prom_parse: Bad cell count for %s\n",
> -			dev->full_name);
> -		goto bail;
> -	}
> -	memcpy(addr, in_addr, na * 4);
> -
> -	pr_debug("OF: bus is %s (na=%d, ns=%d) on %s\n",
> -		bus->name, na, ns, parent->full_name);
> -	of_dump_addr("OF: translating address:", addr, na);
> -
> -	/* Translate */
> -	for (;;) {
> -		/* Switch to parent bus */
> -		of_node_put(dev);
> -		dev = parent;
> -		parent = of_get_parent(dev);
> -
> -		/* If root, we have finished */
> -		if (parent == NULL) {
> -			pr_debug("OF: reached root node\n");
> -			result = of_read_number(addr, na);
> -			break;
> -		}
> -
> -		/* Get new parent bus and counts */
> -		pbus = of_match_bus(parent);
> -		pbus->count_cells(dev, &pna, &pns);
> -		if (!OF_CHECK_COUNTS(pna, pns)) {
> -			printk(KERN_ERR "prom_parse: Bad cell count for %s\n",
> -				dev->full_name);
> -			break;
> -		}
> -
> -		pr_debug("OF: parent bus is %s (na=%d, ns=%d) on %s\n",
> -			pbus->name, pna, pns, parent->full_name);
> -
> -		/* Apply bus translation */
> -		if (of_translate_one(dev, bus, pbus, addr, na, ns, pna))
> -			break;
> -
> -		/* Complete the move up one level */
> -		na = pna;
> -		ns = pns;
> -		bus = pbus;
> -
> -		of_dump_addr("OF: one level translation:", addr, na);
> -	}
> - bail:
> -	of_node_put(parent);
> -	of_node_put(dev);
> -
> -	return result;
> -}
> -EXPORT_SYMBOL(of_translate_address);
> -
> -const u32 *of_get_address(struct device_node *dev, int index, u64 *size,
> -			unsigned int *flags)
> -{
> -	const u32 *prop;
> -	unsigned int psize;
> -	struct device_node *parent;
> -	struct of_bus *bus;
> -	int onesize, i, na, ns;
> -
> -	/* Get parent & match bus type */
> -	parent = of_get_parent(dev);
> -	if (parent == NULL)
> -		return NULL;
> -	bus = of_match_bus(parent);
> -	bus->count_cells(dev, &na, &ns);
> -	of_node_put(parent);
> -	if (!OF_CHECK_COUNTS(na, ns))
> -		return NULL;
> -
> -	/* Get "reg" or "assigned-addresses" property */
> -	prop = of_get_property(dev, bus->addresses, (int *) &psize);
> -	if (prop == NULL)
> -		return NULL;
> -	psize /= 4;
> -
> -	onesize = na + ns;
> -	for (i = 0; psize >= onesize; psize -= onesize, prop += onesize, i++)
> -		if (i == index) {
> -			if (size)
> -				*size = of_read_number(prop + na, ns);
> -			if (flags)
> -				*flags = bus->get_flags(prop);
> -			return prop;
> -		}
> -	return NULL;
> -}
> -EXPORT_SYMBOL(of_get_address);
> -
>  void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
>  		unsigned long *busno, unsigned long *phys, unsigned long *size)
>  {
> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
> index e1c1bdd..8e1d0fe 100644
> --- a/arch/powerpc/include/asm/prom.h
> +++ b/arch/powerpc/include/asm/prom.h
> @@ -45,10 +45,6 @@ extern void pci_create_OF_bus_map(void);
>   * OF address retreival & translation
>   */
>  
> -/* Translate an OF address block into a CPU physical address
> - */
> -extern u64 of_translate_address(struct device_node *np, const u32 *addr);
> -
>  /* Translate a DMA address from device space to CPU space */
>  extern u64 of_translate_dma_address(struct device_node *dev,
>  				    const u32 *in_addr);
> diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
> index a2ef129..64f2606 100644
> --- a/arch/powerpc/kernel/prom_parse.c
> +++ b/arch/powerpc/kernel/prom_parse.c
> @@ -10,225 +10,7 @@
>  #include <asm/prom.h>
>  #include <asm/pci-bridge.h>
>  
> -#ifdef DEBUG
> -#define DBG(fmt...) do { printk(fmt); } while(0)
> -#else
> -#define DBG(fmt...) do { } while(0)
> -#endif
> -
> -#ifdef CONFIG_PPC64
> -#define PRu64	"%lx"
> -#else
> -#define PRu64	"%llx"
> -#endif
> -
> -/* Max address size we deal with */
> -#define OF_MAX_ADDR_CELLS	4
> -#define OF_CHECK_COUNTS(na, ns)	((na) > 0 && (na) <= OF_MAX_ADDR_CELLS && \
> -			(ns) > 0)
> -
> -static struct of_bus *of_match_bus(struct device_node *np);
> -
> -/* Debug utility */
> -#ifdef DEBUG
> -static void of_dump_addr(const char *s, const u32 *addr, int na)
> -{
> -	printk("%s", s);
> -	while(na--)
> -		printk(" %08x", *(addr++));
> -	printk("\n");
> -}
> -#else
> -static void of_dump_addr(const char *s, const u32 *addr, int na) { }
> -#endif
> -
> -
> -/* Callbacks for bus specific translators */
> -struct of_bus {
> -	const char	*name;
> -	const char	*addresses;
> -	int		(*match)(struct device_node *parent);
> -	void		(*count_cells)(struct device_node *child,
> -				       int *addrc, int *sizec);
> -	u64		(*map)(u32 *addr, const u32 *range,
> -				int na, int ns, int pna);
> -	int		(*translate)(u32 *addr, u64 offset, int na);
> -	unsigned int	(*get_flags)(const u32 *addr);
> -};
> -
> -
> -/*
> - * Default translator (generic bus)
> - */
> -
> -static void of_bus_default_count_cells(struct device_node *dev,
> -				       int *addrc, int *sizec)
> -{
> -	if (addrc)
> -		*addrc = of_n_addr_cells(dev);
> -	if (sizec)
> -		*sizec = of_n_size_cells(dev);
> -}
> -
> -static u64 of_bus_default_map(u32 *addr, const u32 *range,
> -		int na, int ns, int pna)
> -{
> -	u64 cp, s, da;
> -
> -	cp = of_read_number(range, na);
> -	s  = of_read_number(range + na + pna, ns);
> -	da = of_read_number(addr, na);
> -
> -	DBG("OF: default map, cp="PRu64", s="PRu64", da="PRu64"\n",
> -	    cp, s, da);
> -
> -	if (da < cp || da >= (cp + s))
> -		return OF_BAD_ADDR;
> -	return da - cp;
> -}
> -
> -static int of_bus_default_translate(u32 *addr, u64 offset, int na)
> -{
> -	u64 a = of_read_number(addr, na);
> -	memset(addr, 0, na * 4);
> -	a += offset;
> -	if (na > 1)
> -		addr[na - 2] = a >> 32;
> -	addr[na - 1] = a & 0xffffffffu;
> -
> -	return 0;
> -}
> -
> -static unsigned int of_bus_default_get_flags(const u32 *addr)
> -{
> -	return IORESOURCE_MEM;
> -}
> -
> -
>  #ifdef CONFIG_PCI
> -/*
> - * PCI bus specific translator
> - */
> -
> -static int of_bus_pci_match(struct device_node *np)
> -{
> -	/* "vci" is for the /chaos bridge on 1st-gen PCI powermacs */
> -	return !strcmp(np->type, "pci") || !strcmp(np->type, "vci");
> -}
> -
> -static void of_bus_pci_count_cells(struct device_node *np,
> -				   int *addrc, int *sizec)
> -{
> -	if (addrc)
> -		*addrc = 3;
> -	if (sizec)
> -		*sizec = 2;
> -}
> -
> -static unsigned int of_bus_pci_get_flags(const u32 *addr)
> -{
> -	unsigned int flags = 0;
> -	u32 w = addr[0];
> -
> -	switch((w >> 24) & 0x03) {
> -	case 0x01:
> -		flags |= IORESOURCE_IO;
> -		break;
> -	case 0x02: /* 32 bits */
> -	case 0x03: /* 64 bits */
> -		flags |= IORESOURCE_MEM;
> -		break;
> -	}
> -	if (w & 0x40000000)
> -		flags |= IORESOURCE_PREFETCH;
> -	return flags;
> -}
> -
> -static u64 of_bus_pci_map(u32 *addr, const u32 *range, int na, int ns, int pna)
> -{
> -	u64 cp, s, da;
> -	unsigned int af, rf;
> -
> -	af = of_bus_pci_get_flags(addr);
> -	rf = of_bus_pci_get_flags(range);
> -
> -	/* Check address type match */
> -	if ((af ^ rf) & (IORESOURCE_MEM | IORESOURCE_IO))
> -		return OF_BAD_ADDR;
> -
> -	/* Read address values, skipping high cell */
> -	cp = of_read_number(range + 1, na - 1);
> -	s  = of_read_number(range + na + pna, ns);
> -	da = of_read_number(addr + 1, na - 1);
> -
> -	DBG("OF: PCI map, cp="PRu64", s="PRu64", da="PRu64"\n", cp, s, da);
> -
> -	if (da < cp || da >= (cp + s))
> -		return OF_BAD_ADDR;
> -	return da - cp;
> -}
> -
> -static int of_bus_pci_translate(u32 *addr, u64 offset, int na)
> -{
> -	return of_bus_default_translate(addr + 1, offset, na - 1);
> -}
> -
> -const u32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 *size,
> -			unsigned int *flags)
> -{
> -	const u32 *prop;
> -	unsigned int psize;
> -	struct device_node *parent;
> -	struct of_bus *bus;
> -	int onesize, i, na, ns;
> -
> -	/* Get parent & match bus type */
> -	parent = of_get_parent(dev);
> -	if (parent == NULL)
> -		return NULL;
> -	bus = of_match_bus(parent);
> -	if (strcmp(bus->name, "pci")) {
> -		of_node_put(parent);
> -		return NULL;
> -	}
> -	bus->count_cells(dev, &na, &ns);
> -	of_node_put(parent);
> -	if (!OF_CHECK_COUNTS(na, ns))
> -		return NULL;
> -
> -	/* Get "reg" or "assigned-addresses" property */
> -	prop = of_get_property(dev, bus->addresses, &psize);
> -	if (prop == NULL)
> -		return NULL;
> -	psize /= 4;
> -
> -	onesize = na + ns;
> -	for (i = 0; psize >= onesize; psize -= onesize, prop += onesize, i++)
> -		if ((prop[0] & 0xff) == ((bar_no * 4) + PCI_BASE_ADDRESS_0)) {
> -			if (size)
> -				*size = of_read_number(prop + na, ns);
> -			if (flags)
> -				*flags = bus->get_flags(prop);
> -			return prop;
> -		}
> -	return NULL;
> -}
> -EXPORT_SYMBOL(of_get_pci_address);
> -
> -int of_pci_address_to_resource(struct device_node *dev, int bar,
> -			       struct resource *r)
> -{
> -	const u32	*addrp;
> -	u64		size;
> -	unsigned int	flags;
> -
> -	addrp = of_get_pci_address(dev, bar, &size, &flags);
> -	if (addrp == NULL)
> -		return -EINVAL;
> -	return __of_address_to_resource(dev, addrp, size, flags, r);
> -}
> -EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
> -
>  int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
>  {
>  	struct device_node *dn, *ppnode;
> @@ -310,303 +92,6 @@ int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
>  EXPORT_SYMBOL_GPL(of_irq_map_pci);
>  #endif /* CONFIG_PCI */
>  
> -/*
> - * ISA bus specific translator
> - */
> -
> -static int of_bus_isa_match(struct device_node *np)
> -{
> -	return !strcmp(np->name, "isa");
> -}
> -
> -static void of_bus_isa_count_cells(struct device_node *child,
> -				   int *addrc, int *sizec)
> -{
> -	if (addrc)
> -		*addrc = 2;
> -	if (sizec)
> -		*sizec = 1;
> -}
> -
> -static u64 of_bus_isa_map(u32 *addr, const u32 *range, int na, int ns, int pna)
> -{
> -	u64 cp, s, da;
> -
> -	/* Check address type match */
> -	if ((addr[0] ^ range[0]) & 0x00000001)
> -		return OF_BAD_ADDR;
> -
> -	/* Read address values, skipping high cell */
> -	cp = of_read_number(range + 1, na - 1);
> -	s  = of_read_number(range + na + pna, ns);
> -	da = of_read_number(addr + 1, na - 1);
> -
> -	DBG("OF: ISA map, cp="PRu64", s="PRu64", da="PRu64"\n", cp, s, da);
> -
> -	if (da < cp || da >= (cp + s))
> -		return OF_BAD_ADDR;
> -	return da - cp;
> -}
> -
> -static int of_bus_isa_translate(u32 *addr, u64 offset, int na)
> -{
> -	return of_bus_default_translate(addr + 1, offset, na - 1);
> -}
> -
> -static unsigned int of_bus_isa_get_flags(const u32 *addr)
> -{
> -	unsigned int flags = 0;
> -	u32 w = addr[0];
> -
> -	if (w & 1)
> -		flags |= IORESOURCE_IO;
> -	else
> -		flags |= IORESOURCE_MEM;
> -	return flags;
> -}
> -
> -
> -/*
> - * Array of bus specific translators
> - */
> -
> -static struct of_bus of_busses[] = {
> -#ifdef CONFIG_PCI
> -	/* PCI */
> -	{
> -		.name = "pci",
> -		.addresses = "assigned-addresses",
> -		.match = of_bus_pci_match,
> -		.count_cells = of_bus_pci_count_cells,
> -		.map = of_bus_pci_map,
> -		.translate = of_bus_pci_translate,
> -		.get_flags = of_bus_pci_get_flags,
> -	},
> -#endif /* CONFIG_PCI */
> -	/* ISA */
> -	{
> -		.name = "isa",
> -		.addresses = "reg",
> -		.match = of_bus_isa_match,
> -		.count_cells = of_bus_isa_count_cells,
> -		.map = of_bus_isa_map,
> -		.translate = of_bus_isa_translate,
> -		.get_flags = of_bus_isa_get_flags,
> -	},
> -	/* Default */
> -	{
> -		.name = "default",
> -		.addresses = "reg",
> -		.match = NULL,
> -		.count_cells = of_bus_default_count_cells,
> -		.map = of_bus_default_map,
> -		.translate = of_bus_default_translate,
> -		.get_flags = of_bus_default_get_flags,
> -	},
> -};
> -
> -static struct of_bus *of_match_bus(struct device_node *np)
> -{
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(of_busses); i ++)
> -		if (!of_busses[i].match || of_busses[i].match(np))
> -			return &of_busses[i];
> -	BUG();
> -	return NULL;
> -}
> -
> -static int of_translate_one(struct device_node *parent, struct of_bus *bus,
> -			    struct of_bus *pbus, u32 *addr,
> -			    int na, int ns, int pna, const char *rprop)
> -{
> -	const u32 *ranges;
> -	unsigned int rlen;
> -	int rone;
> -	u64 offset = OF_BAD_ADDR;
> -
> -	/* Normally, an absence of a "ranges" property means we are
> -	 * crossing a non-translatable boundary, and thus the addresses
> -	 * below the current not cannot be converted to CPU physical ones.
> -	 * Unfortunately, while this is very clear in the spec, it's not
> -	 * what Apple understood, and they do have things like /uni-n or
> -	 * /ht nodes with no "ranges" property and a lot of perfectly
> -	 * useable mapped devices below them. Thus we treat the absence of
> -	 * "ranges" as equivalent to an empty "ranges" property which means
> -	 * a 1:1 translation at that level. It's up to the caller not to try
> -	 * to translate addresses that aren't supposed to be translated in
> -	 * the first place. --BenH.
> -	 */
> -	ranges = of_get_property(parent, rprop, &rlen);
> -	if (ranges == NULL || rlen == 0) {
> -		offset = of_read_number(addr, na);
> -		memset(addr, 0, pna * 4);
> -		DBG("OF: no ranges, 1:1 translation\n");
> -		goto finish;
> -	}
> -
> -	DBG("OF: walking ranges...\n");
> -
> -	/* Now walk through the ranges */
> -	rlen /= 4;
> -	rone = na + pna + ns;
> -	for (; rlen >= rone; rlen -= rone, ranges += rone) {
> -		offset = bus->map(addr, ranges, na, ns, pna);
> -		if (offset != OF_BAD_ADDR)
> -			break;
> -	}
> -	if (offset == OF_BAD_ADDR) {
> -		DBG("OF: not found !\n");
> -		return 1;
> -	}
> -	memcpy(addr, ranges + na, 4 * pna);
> -
> - finish:
> -	of_dump_addr("OF: parent translation for:", addr, pna);
> -	DBG("OF: with offset: "PRu64"\n", offset);
> -
> -	/* Translate it into parent bus space */
> -	return pbus->translate(addr, offset, pna);
> -}
> -
> -
> -/*
> - * Translate an address from the device-tree into a CPU physical address,
> - * this walks up the tree and applies the various bus mappings on the
> - * way.
> - *
> - * Note: We consider that crossing any level with #size-cells == 0 to mean
> - * that translation is impossible (that is we are not dealing with a value
> - * that can be mapped to a cpu physical address). This is not really specified
> - * that way, but this is traditionally the way IBM at least do things
> - */
> -u64 __of_translate_address(struct device_node *dev, const u32 *in_addr,
> -			   const char *rprop)
> -{
> -	struct device_node *parent = NULL;
> -	struct of_bus *bus, *pbus;
> -	u32 addr[OF_MAX_ADDR_CELLS];
> -	int na, ns, pna, pns;
> -	u64 result = OF_BAD_ADDR;
> -
> -	DBG("OF: ** translation for device %s **\n", dev->full_name);
> -
> -	/* Increase refcount at current level */
> -	of_node_get(dev);
> -
> -	/* Get parent & match bus type */
> -	parent = of_get_parent(dev);
> -	if (parent == NULL)
> -		goto bail;
> -	bus = of_match_bus(parent);
> -
> -	/* Cound address cells & copy address locally */
> -	bus->count_cells(dev, &na, &ns);
> -	if (!OF_CHECK_COUNTS(na, ns)) {
> -		printk(KERN_ERR "prom_parse: Bad cell count for %s\n",
> -		       dev->full_name);
> -		goto bail;
> -	}
> -	memcpy(addr, in_addr, na * 4);
> -
> -	DBG("OF: bus is %s (na=%d, ns=%d) on %s\n",
> -	    bus->name, na, ns, parent->full_name);
> -	of_dump_addr("OF: translating address:", addr, na);
> -
> -	/* Translate */
> -	for (;;) {
> -		/* Switch to parent bus */
> -		of_node_put(dev);
> -		dev = parent;
> -		parent = of_get_parent(dev);
> -
> -		/* If root, we have finished */
> -		if (parent == NULL) {
> -			DBG("OF: reached root node\n");
> -			result = of_read_number(addr, na);
> -			break;
> -		}
> -
> -		/* Get new parent bus and counts */
> -		pbus = of_match_bus(parent);
> -		pbus->count_cells(dev, &pna, &pns);
> -		if (!OF_CHECK_COUNTS(pna, pns)) {
> -			printk(KERN_ERR "prom_parse: Bad cell count for %s\n",
> -			       dev->full_name);
> -			break;
> -		}
> -
> -		DBG("OF: parent bus is %s (na=%d, ns=%d) on %s\n",
> -		    pbus->name, pna, pns, parent->full_name);
> -
> -		/* Apply bus translation */
> -		if (of_translate_one(dev, bus, pbus, addr, na, ns, pna, rprop))
> -			break;
> -
> -		/* Complete the move up one level */
> -		na = pna;
> -		ns = pns;
> -		bus = pbus;
> -
> -		of_dump_addr("OF: one level translation:", addr, na);
> -	}
> - bail:
> -	of_node_put(parent);
> -	of_node_put(dev);
> -
> -	return result;
> -}
> -
> -u64 of_translate_address(struct device_node *dev, const u32 *in_addr)
> -{
> -	return __of_translate_address(dev, in_addr, "ranges");
> -}
> -EXPORT_SYMBOL(of_translate_address);
> -
> -u64 of_translate_dma_address(struct device_node *dev, const u32 *in_addr)
> -{
> -	return __of_translate_address(dev, in_addr, "dma-ranges");
> -}
> -EXPORT_SYMBOL(of_translate_dma_address);
> -
> -const u32 *of_get_address(struct device_node *dev, int index, u64 *size,
> -		    unsigned int *flags)
> -{
> -	const u32 *prop;
> -	unsigned int psize;
> -	struct device_node *parent;
> -	struct of_bus *bus;
> -	int onesize, i, na, ns;
> -
> -	/* Get parent & match bus type */
> -	parent = of_get_parent(dev);
> -	if (parent == NULL)
> -		return NULL;
> -	bus = of_match_bus(parent);
> -	bus->count_cells(dev, &na, &ns);
> -	of_node_put(parent);
> -	if (!OF_CHECK_COUNTS(na, ns))
> -		return NULL;
> -
> -	/* Get "reg" or "assigned-addresses" property */
> -	prop = of_get_property(dev, bus->addresses, &psize);
> -	if (prop == NULL)
> -		return NULL;
> -	psize /= 4;
> -
> -	onesize = na + ns;
> -	for (i = 0; psize >= onesize; psize -= onesize, prop += onesize, i++)
> -		if (i == index) {
> -			if (size)
> -				*size = of_read_number(prop + na, ns);
> -			if (flags)
> -				*flags = bus->get_flags(prop);
> -			return prop;
> -		}
> -	return NULL;
> -}
> -EXPORT_SYMBOL(of_get_address);
> -
>  void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
>  		unsigned long *busno, unsigned long *phys, unsigned long *size)
>  {
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index c381955..2a905d5 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -1,11 +1,522 @@
>  
>  #include <linux/io.h>
>  #include <linux/ioport.h>
> +#include <linux/module.h>
>  #include <linux/of_address.h>
> +#include <linux/pci_regs.h>
> +#include <linux/string.h>
>  
> -int __of_address_to_resource(struct device_node *dev, const u32 *addrp,
> -			     u64 size, unsigned int flags,
> -			     struct resource *r)
> +/* Max address size we deal with */
> +#define OF_MAX_ADDR_CELLS	4
> +#define OF_CHECK_COUNTS(na, ns)	((na) > 0 && (na) <= OF_MAX_ADDR_CELLS && \
> +			(ns) > 0)
> +
> +static struct of_bus *of_match_bus(struct device_node *np);
> +static int __of_address_to_resource(struct device_node *dev, const u32 *addrp,
> +				    u64 size, unsigned int flags,
> +				    struct resource *r);
> +
> +/* Debug utility */
> +#ifdef DEBUG
> +static void of_dump_addr(const char *s, const u32 *addr, int na)
> +{
> +	printk(KERN_DEBUG "%s", s);
> +	while (na--)
> +		printk(" %08x", *(addr++));
> +	printk("\n");
> +}
> +#else
> +static void of_dump_addr(const char *s, const u32 *addr, int na) { }
> +#endif
> +
> +/* Callbacks for bus specific translators */
> +struct of_bus {
> +	const char	*name;
> +	const char	*addresses;
> +	int		(*match)(struct device_node *parent);
> +	void		(*count_cells)(struct device_node *child,
> +				       int *addrc, int *sizec);
> +	u64		(*map)(u32 *addr, const u32 *range,
> +				int na, int ns, int pna);
> +	int		(*translate)(u32 *addr, u64 offset, int na);
> +	unsigned int	(*get_flags)(const u32 *addr);
> +};
> +
> +/*
> + * Default translator (generic bus)
> + */
> +
> +static void of_bus_default_count_cells(struct device_node *dev,
> +				       int *addrc, int *sizec)
> +{
> +	if (addrc)
> +		*addrc = of_n_addr_cells(dev);
> +	if (sizec)
> +		*sizec = of_n_size_cells(dev);
> +}
> +
> +static u64 of_bus_default_map(u32 *addr, const u32 *range,
> +		int na, int ns, int pna)
> +{
> +	u64 cp, s, da;
> +
> +	cp = of_read_number(range, na);
> +	s  = of_read_number(range + na + pna, ns);
> +	da = of_read_number(addr, na);
> +
> +	pr_debug("OF: default map, cp=%llx, s=%llx, da=%llx\n",
> +		 (unsigned long long)cp, (unsigned long long)s,
> +		 (unsigned long long)da);
> +
> +	if (da < cp || da >= (cp + s))
> +		return OF_BAD_ADDR;
> +	return da - cp;
> +}
> +
> +static int of_bus_default_translate(u32 *addr, u64 offset, int na)
> +{
> +	u64 a = of_read_number(addr, na);
> +	memset(addr, 0, na * 4);
> +	a += offset;
> +	if (na > 1)
> +		addr[na - 2] = a >> 32;
> +	addr[na - 1] = a & 0xffffffffu;
> +
> +	return 0;
> +}
> +
> +static unsigned int of_bus_default_get_flags(const u32 *addr)
> +{
> +	return IORESOURCE_MEM;
> +}
> +
> +#ifdef CONFIG_PCI
> +/*
> + * PCI bus specific translator
> + */
> +
> +static int of_bus_pci_match(struct device_node *np)
> +{
> +	/* "vci" is for the /chaos bridge on 1st-gen PCI powermacs */
> +	return !strcmp(np->type, "pci") || !strcmp(np->type, "vci");
> +}
> +
> +static void of_bus_pci_count_cells(struct device_node *np,
> +				   int *addrc, int *sizec)
> +{
> +	if (addrc)
> +		*addrc = 3;
> +	if (sizec)
> +		*sizec = 2;
> +}
> +
> +static unsigned int of_bus_pci_get_flags(const u32 *addr)
> +{
> +	unsigned int flags = 0;
> +	u32 w = addr[0];
> +
> +	switch((w >> 24) & 0x03) {
> +	case 0x01:
> +		flags |= IORESOURCE_IO;
> +		break;
> +	case 0x02: /* 32 bits */
> +	case 0x03: /* 64 bits */
> +		flags |= IORESOURCE_MEM;
> +		break;
> +	}
> +	if (w & 0x40000000)
> +		flags |= IORESOURCE_PREFETCH;
> +	return flags;
> +}
> +
> +static u64 of_bus_pci_map(u32 *addr, const u32 *range, int na, int ns, int pna)
> +{
> +	u64 cp, s, da;
> +	unsigned int af, rf;
> +
> +	af = of_bus_pci_get_flags(addr);
> +	rf = of_bus_pci_get_flags(range);
> +
> +	/* Check address type match */
> +	if ((af ^ rf) & (IORESOURCE_MEM | IORESOURCE_IO))
> +		return OF_BAD_ADDR;
> +
> +	/* Read address values, skipping high cell */
> +	cp = of_read_number(range + 1, na - 1);
> +	s  = of_read_number(range + na + pna, ns);
> +	da = of_read_number(addr + 1, na - 1);
> +
> +	pr_debug("OF: PCI map, cp=%llx, s=%llx, da=%llx\n",
> +		 (unsigned long long)cp, (unsigned long long)s,
> +		 (unsigned long long)da);
> +
> +	if (da < cp || da >= (cp + s))
> +		return OF_BAD_ADDR;
> +	return da - cp;
> +}
> +
> +static int of_bus_pci_translate(u32 *addr, u64 offset, int na)
> +{
> +	return of_bus_default_translate(addr + 1, offset, na - 1);
> +}
> +
> +const u32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 *size,
> +			unsigned int *flags)
> +{
> +	const u32 *prop;
> +	unsigned int psize;
> +	struct device_node *parent;
> +	struct of_bus *bus;
> +	int onesize, i, na, ns;
> +
> +	/* Get parent & match bus type */
> +	parent = of_get_parent(dev);
> +	if (parent == NULL)
> +		return NULL;
> +	bus = of_match_bus(parent);
> +	if (strcmp(bus->name, "pci")) {
> +		of_node_put(parent);
> +		return NULL;
> +	}
> +	bus->count_cells(dev, &na, &ns);
> +	of_node_put(parent);
> +	if (!OF_CHECK_COUNTS(na, ns))
> +		return NULL;
> +
> +	/* Get "reg" or "assigned-addresses" property */
> +	prop = of_get_property(dev, bus->addresses, &psize);
> +	if (prop == NULL)
> +		return NULL;
> +	psize /= 4;
> +
> +	onesize = na + ns;
> +	for (i = 0; psize >= onesize; psize -= onesize, prop += onesize, i++)
> +		if ((prop[0] & 0xff) == ((bar_no * 4) + PCI_BASE_ADDRESS_0)) {
> +			if (size)
> +				*size = of_read_number(prop + na, ns);
> +			if (flags)
> +				*flags = bus->get_flags(prop);
> +			return prop;
> +		}
> +	return NULL;
> +}
> +EXPORT_SYMBOL(of_get_pci_address);
> +
> +int of_pci_address_to_resource(struct device_node *dev, int bar,
> +			       struct resource *r)
> +{
> +	const u32	*addrp;
> +	u64		size;
> +	unsigned int	flags;
> +
> +	addrp = of_get_pci_address(dev, bar, &size, &flags);
> +	if (addrp == NULL)
> +		return -EINVAL;
> +	return __of_address_to_resource(dev, addrp, size, flags, r);
> +}
> +EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
> +#endif /* CONFIG_PCI */
> +
> +/*
> + * ISA bus specific translator
> + */
> +
> +static int of_bus_isa_match(struct device_node *np)
> +{
> +	return !strcmp(np->name, "isa");
> +}
> +
> +static void of_bus_isa_count_cells(struct device_node *child,
> +				   int *addrc, int *sizec)
> +{
> +	if (addrc)
> +		*addrc = 2;
> +	if (sizec)
> +		*sizec = 1;
> +}
> +
> +static u64 of_bus_isa_map(u32 *addr, const u32 *range, int na, int ns, int pna)
> +{
> +	u64 cp, s, da;
> +
> +	/* Check address type match */
> +	if ((addr[0] ^ range[0]) & 0x00000001)
> +		return OF_BAD_ADDR;
> +
> +	/* Read address values, skipping high cell */
> +	cp = of_read_number(range + 1, na - 1);
> +	s  = of_read_number(range + na + pna, ns);
> +	da = of_read_number(addr + 1, na - 1);
> +
> +	pr_debug("OF: ISA map, cp=%llx, s=%llx, da=%llx\n",
> +		 (unsigned long long)cp, (unsigned long long)s,
> +		 (unsigned long long)da);
> +
> +	if (da < cp || da >= (cp + s))
> +		return OF_BAD_ADDR;
> +	return da - cp;
> +}
> +
> +static int of_bus_isa_translate(u32 *addr, u64 offset, int na)
> +{
> +	return of_bus_default_translate(addr + 1, offset, na - 1);
> +}
> +
> +static unsigned int of_bus_isa_get_flags(const u32 *addr)
> +{
> +	unsigned int flags = 0;
> +	u32 w = addr[0];
> +
> +	if (w & 1)
> +		flags |= IORESOURCE_IO;
> +	else
> +		flags |= IORESOURCE_MEM;
> +	return flags;
> +}
> +
> +/*
> + * Array of bus specific translators
> + */
> +
> +static struct of_bus of_busses[] = {
> +#ifdef CONFIG_PCI
> +	/* PCI */
> +	{
> +		.name = "pci",
> +		.addresses = "assigned-addresses",
> +		.match = of_bus_pci_match,
> +		.count_cells = of_bus_pci_count_cells,
> +		.map = of_bus_pci_map,
> +		.translate = of_bus_pci_translate,
> +		.get_flags = of_bus_pci_get_flags,
> +	},
> +#endif /* CONFIG_PCI */
> +	/* ISA */
> +	{
> +		.name = "isa",
> +		.addresses = "reg",
> +		.match = of_bus_isa_match,
> +		.count_cells = of_bus_isa_count_cells,
> +		.map = of_bus_isa_map,
> +		.translate = of_bus_isa_translate,
> +		.get_flags = of_bus_isa_get_flags,
> +	},
> +	/* Default */
> +	{
> +		.name = "default",
> +		.addresses = "reg",
> +		.match = NULL,
> +		.count_cells = of_bus_default_count_cells,
> +		.map = of_bus_default_map,
> +		.translate = of_bus_default_translate,
> +		.get_flags = of_bus_default_get_flags,
> +	},
> +};
> +
> +static struct of_bus *of_match_bus(struct device_node *np)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(of_busses); i++)
> +		if (!of_busses[i].match || of_busses[i].match(np))
> +			return &of_busses[i];
> +	BUG();
> +	return NULL;
> +}
> +
> +static int of_translate_one(struct device_node *parent, struct of_bus *bus,
> +			    struct of_bus *pbus, u32 *addr,
> +			    int na, int ns, int pna, const char *rprop)
> +{
> +	const u32 *ranges;
> +	unsigned int rlen;
> +	int rone;
> +	u64 offset = OF_BAD_ADDR;
> +
> +	/* Normally, an absence of a "ranges" property means we are
> +	 * crossing a non-translatable boundary, and thus the addresses
> +	 * below the current not cannot be converted to CPU physical ones.
> +	 * Unfortunately, while this is very clear in the spec, it's not
> +	 * what Apple understood, and they do have things like /uni-n or
> +	 * /ht nodes with no "ranges" property and a lot of perfectly
> +	 * useable mapped devices below them. Thus we treat the absence of
> +	 * "ranges" as equivalent to an empty "ranges" property which means
> +	 * a 1:1 translation at that level. It's up to the caller not to try
> +	 * to translate addresses that aren't supposed to be translated in
> +	 * the first place. --BenH.
> +	 */
> +	ranges = of_get_property(parent, rprop, &rlen);
> +	if (ranges == NULL || rlen == 0) {
> +		offset = of_read_number(addr, na);
> +		memset(addr, 0, pna * 4);
> +		pr_debug("OF: no ranges, 1:1 translation\n");
> +		goto finish;
> +	}
> +
> +	pr_debug("OF: walking ranges...\n");
> +
> +	/* Now walk through the ranges */
> +	rlen /= 4;
> +	rone = na + pna + ns;
> +	for (; rlen >= rone; rlen -= rone, ranges += rone) {
> +		offset = bus->map(addr, ranges, na, ns, pna);
> +		if (offset != OF_BAD_ADDR)
> +			break;
> +	}
> +	if (offset == OF_BAD_ADDR) {
> +		pr_debug("OF: not found !\n");
> +		return 1;
> +	}
> +	memcpy(addr, ranges + na, 4 * pna);
> +
> + finish:
> +	of_dump_addr("OF: parent translation for:", addr, pna);
> +	pr_debug("OF: with offset: %llx\n", (unsigned long long)offset);
> +
> +	/* Translate it into parent bus space */
> +	return pbus->translate(addr, offset, pna);
> +}
> +
> +/*
> + * Translate an address from the device-tree into a CPU physical address,
> + * this walks up the tree and applies the various bus mappings on the
> + * way.
> + *
> + * Note: We consider that crossing any level with #size-cells == 0 to mean
> + * that translation is impossible (that is we are not dealing with a value
> + * that can be mapped to a cpu physical address). This is not really specified
> + * that way, but this is traditionally the way IBM at least do things
> + */
> +u64 __of_translate_address(struct device_node *dev, const u32 *in_addr,
> +			   const char *rprop)
> +{
> +	struct device_node *parent = NULL;
> +	struct of_bus *bus, *pbus;
> +	u32 addr[OF_MAX_ADDR_CELLS];
> +	int na, ns, pna, pns;
> +	u64 result = OF_BAD_ADDR;
> +
> +	pr_debug("OF: ** translation for device %s **\n", dev->full_name);
> +
> +	/* Increase refcount at current level */
> +	of_node_get(dev);
> +
> +	/* Get parent & match bus type */
> +	parent = of_get_parent(dev);
> +	if (parent == NULL)
> +		goto bail;
> +	bus = of_match_bus(parent);
> +
> +	/* Cound address cells & copy address locally */
> +	bus->count_cells(dev, &na, &ns);
> +	if (!OF_CHECK_COUNTS(na, ns)) {
> +		printk(KERN_ERR "prom_parse: Bad cell count for %s\n",
> +		       dev->full_name);
> +		goto bail;
> +	}
> +	memcpy(addr, in_addr, na * 4);
> +
> +	pr_debug("OF: bus is %s (na=%d, ns=%d) on %s\n",
> +	    bus->name, na, ns, parent->full_name);
> +	of_dump_addr("OF: translating address:", addr, na);
> +
> +	/* Translate */
> +	for (;;) {
> +		/* Switch to parent bus */
> +		of_node_put(dev);
> +		dev = parent;
> +		parent = of_get_parent(dev);
> +
> +		/* If root, we have finished */
> +		if (parent == NULL) {
> +			pr_debug("OF: reached root node\n");
> +			result = of_read_number(addr, na);
> +			break;
> +		}
> +
> +		/* Get new parent bus and counts */
> +		pbus = of_match_bus(parent);
> +		pbus->count_cells(dev, &pna, &pns);
> +		if (!OF_CHECK_COUNTS(pna, pns)) {
> +			printk(KERN_ERR "prom_parse: Bad cell count for %s\n",
> +			       dev->full_name);
> +			break;
> +		}
> +
> +		pr_debug("OF: parent bus is %s (na=%d, ns=%d) on %s\n",
> +		    pbus->name, pna, pns, parent->full_name);
> +
> +		/* Apply bus translation */
> +		if (of_translate_one(dev, bus, pbus, addr, na, ns, pna, rprop))
> +			break;
> +
> +		/* Complete the move up one level */
> +		na = pna;
> +		ns = pns;
> +		bus = pbus;
> +
> +		of_dump_addr("OF: one level translation:", addr, na);
> +	}
> + bail:
> +	of_node_put(parent);
> +	of_node_put(dev);
> +
> +	return result;
> +}
> +
> +u64 of_translate_address(struct device_node *dev, const u32 *in_addr)
> +{
> +	return __of_translate_address(dev, in_addr, "ranges");
> +}
> +EXPORT_SYMBOL(of_translate_address);
> +
> +u64 of_translate_dma_address(struct device_node *dev, const u32 *in_addr)
> +{
> +	return __of_translate_address(dev, in_addr, "dma-ranges");
> +}
> +EXPORT_SYMBOL(of_translate_dma_address);
> +
> +const u32 *of_get_address(struct device_node *dev, int index, u64 *size,
> +		    unsigned int *flags)
> +{
> +	const u32 *prop;
> +	unsigned int psize;
> +	struct device_node *parent;
> +	struct of_bus *bus;
> +	int onesize, i, na, ns;
> +
> +	/* Get parent & match bus type */
> +	parent = of_get_parent(dev);
> +	if (parent == NULL)
> +		return NULL;
> +	bus = of_match_bus(parent);
> +	bus->count_cells(dev, &na, &ns);
> +	of_node_put(parent);
> +	if (!OF_CHECK_COUNTS(na, ns))
> +		return NULL;
> +
> +	/* Get "reg" or "assigned-addresses" property */
> +	prop = of_get_property(dev, bus->addresses, &psize);
> +	if (prop == NULL)
> +		return NULL;
> +	psize /= 4;
> +
> +	onesize = na + ns;
> +	for (i = 0; psize >= onesize; psize -= onesize, prop += onesize, i++)
> +		if (i == index) {
> +			if (size)
> +				*size = of_read_number(prop + na, ns);
> +			if (flags)
> +				*flags = bus->get_flags(prop);
> +			return prop;
> +		}
> +	return NULL;
> +}
> +EXPORT_SYMBOL(of_get_address);
> +
> +static int __of_address_to_resource(struct device_node *dev, const u32 *addrp,
> +				    u64 size, unsigned int flags,
> +				    struct resource *r)
>  {
>  	u64 taddr;
>  
> diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> index 474b794..cc567df 100644
> --- a/include/linux/of_address.h
> +++ b/include/linux/of_address.h
> @@ -3,9 +3,7 @@
>  #include <linux/ioport.h>
>  #include <linux/of.h>
>  
> -extern int __of_address_to_resource(struct device_node *dev, const u32 *addrp,
> -				    u64 size, unsigned int flags,
> -				    struct resource *r);
> +extern u64 of_translate_address(struct device_node *np, const u32 *addr);
>  extern int of_address_to_resource(struct device_node *dev, int index,
>  				  struct resource *r);
>  extern void __iomem *of_iomap(struct device_node *device, int index);
