Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD818B70D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Dec 2010 10:15:28 +1100 (EST)
Subject: Re: [PATCH] of/address: use propper endianess in get_flags
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
In-Reply-To: <20101201095446.GA26877@www.tglx.de>
References: <20101201095446.GA26877@www.tglx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 02 Dec 2010 10:15:12 +1100
Message-ID: <1291245312.32570.411.camel@pasglop>
Mime-Version: 1.0
Cc: sodaville@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-12-01 at 10:54 +0100, Sebastian Andrzej Siewior wrote:
> This patch changes u32 to __be32 for all "ranges", "prop" and "addr" and
> such. Those variables are pointing to the device tree which containts
> intergers in big endian format.
> Most functions are doing it right because of_read_number() is doing the
> right thing for them. of_bus_isa_get_flags(), of_bus_pci_get_flags() and
> of_bus_isa_map() were accessing the data directly and were doing it wrong.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

> ---
>  arch/powerpc/include/asm/prom.h |    2 +-
>  drivers/of/address.c            |   54 ++++++++++++++++++++------------------
>  include/linux/of_address.h      |    6 ++--
>  3 files changed, 32 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
> index ae26f2e..ab34f60 100644
> --- a/arch/powerpc/include/asm/prom.h
> +++ b/arch/powerpc/include/asm/prom.h
> @@ -42,7 +42,7 @@ extern void pci_create_OF_bus_map(void);
>  
>  /* Translate a DMA address from device space to CPU space */
>  extern u64 of_translate_dma_address(struct device_node *dev,
> -				    const u32 *in_addr);
> +				    const __be32 *in_addr);
>  
>  #ifdef CONFIG_PCI
>  extern unsigned long pci_address_to_pio(phys_addr_t address);
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 3a1c7e7..b4559c5 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -12,13 +12,13 @@
>  			(ns) > 0)
>  
>  static struct of_bus *of_match_bus(struct device_node *np);
> -static int __of_address_to_resource(struct device_node *dev, const u32 *addrp,
> -				    u64 size, unsigned int flags,
> +static int __of_address_to_resource(struct device_node *dev,
> +		const __be32 *addrp, u64 size, unsigned int flags,
>  				    struct resource *r);
>  
>  /* Debug utility */
>  #ifdef DEBUG
> -static void of_dump_addr(const char *s, const u32 *addr, int na)
> +static void of_dump_addr(const char *s, const __be32 *addr, int na)
>  {
>  	printk(KERN_DEBUG "%s", s);
>  	while (na--)
> @@ -26,7 +26,7 @@ static void of_dump_addr(const char *s, const u32 *addr, int na)
>  	printk("\n");
>  }
>  #else
> -static void of_dump_addr(const char *s, const u32 *addr, int na) { }
> +static void of_dump_addr(const char *s, const __be32 *addr, int na) { }
>  #endif
>  
>  /* Callbacks for bus specific translators */
> @@ -36,10 +36,10 @@ struct of_bus {
>  	int		(*match)(struct device_node *parent);
>  	void		(*count_cells)(struct device_node *child,
>  				       int *addrc, int *sizec);
> -	u64		(*map)(u32 *addr, const u32 *range,
> +	u64		(*map)(u32 *addr, const __be32 *range,
>  				int na, int ns, int pna);
>  	int		(*translate)(u32 *addr, u64 offset, int na);
> -	unsigned int	(*get_flags)(const u32 *addr);
> +	unsigned int	(*get_flags)(const __be32 *addr);
>  };
>  
>  /*
> @@ -55,7 +55,7 @@ static void of_bus_default_count_cells(struct device_node *dev,
>  		*sizec = of_n_size_cells(dev);
>  }
>  
> -static u64 of_bus_default_map(u32 *addr, const u32 *range,
> +static u64 of_bus_default_map(u32 *addr, const __be32 *range,
>  		int na, int ns, int pna)
>  {
>  	u64 cp, s, da;
> @@ -85,7 +85,7 @@ static int of_bus_default_translate(u32 *addr, u64 offset, int na)
>  	return 0;
>  }
>  
> -static unsigned int of_bus_default_get_flags(const u32 *addr)
> +static unsigned int of_bus_default_get_flags(const __be32 *addr)
>  {
>  	return IORESOURCE_MEM;
>  }
> @@ -110,10 +110,10 @@ static void of_bus_pci_count_cells(struct device_node *np,
>  		*sizec = 2;
>  }
>  
> -static unsigned int of_bus_pci_get_flags(const u32 *addr)
> +static unsigned int of_bus_pci_get_flags(const __be32 *addr)
>  {
>  	unsigned int flags = 0;
> -	u32 w = addr[0];
> +	u32 w = be32_to_cpup(addr);
>  
>  	switch((w >> 24) & 0x03) {
>  	case 0x01:
> @@ -129,7 +129,8 @@ static unsigned int of_bus_pci_get_flags(const u32 *addr)
>  	return flags;
>  }
>  
> -static u64 of_bus_pci_map(u32 *addr, const u32 *range, int na, int ns, int pna)
> +static u64 of_bus_pci_map(u32 *addr, const __be32 *range, int na, int ns,
> +		int pna)
>  {
>  	u64 cp, s, da;
>  	unsigned int af, rf;
> @@ -160,7 +161,7 @@ static int of_bus_pci_translate(u32 *addr, u64 offset, int na)
>  	return of_bus_default_translate(addr + 1, offset, na - 1);
>  }
>  
> -const u32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 *size,
> +const __be32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 *size,
>  			unsigned int *flags)
>  {
>  	const __be32 *prop;
> @@ -207,7 +208,7 @@ EXPORT_SYMBOL(of_get_pci_address);
>  int of_pci_address_to_resource(struct device_node *dev, int bar,
>  			       struct resource *r)
>  {
> -	const u32	*addrp;
> +	const __be32	*addrp;
>  	u64		size;
>  	unsigned int	flags;
>  
> @@ -237,12 +238,13 @@ static void of_bus_isa_count_cells(struct device_node *child,
>  		*sizec = 1;
>  }
>  
> -static u64 of_bus_isa_map(u32 *addr, const u32 *range, int na, int ns, int pna)
> +static u64 of_bus_isa_map(u32 *addr, const __be32 *range, int na, int ns,
> +		int pna)
>  {
>  	u64 cp, s, da;
>  
>  	/* Check address type match */
> -	if ((addr[0] ^ range[0]) & 0x00000001)
> +	if ((addr[0] ^ range[0]) & cpu_to_be32(1))
>  		return OF_BAD_ADDR;
>  
>  	/* Read address values, skipping high cell */
> @@ -264,10 +266,10 @@ static int of_bus_isa_translate(u32 *addr, u64 offset, int na)
>  	return of_bus_default_translate(addr + 1, offset, na - 1);
>  }
>  
> -static unsigned int of_bus_isa_get_flags(const u32 *addr)
> +static unsigned int of_bus_isa_get_flags(const __be32 *addr)
>  {
>  	unsigned int flags = 0;
> -	u32 w = addr[0];
> +	u32 w = be32_to_cpup(addr);
>  
>  	if (w & 1)
>  		flags |= IORESOURCE_IO;
> @@ -330,7 +332,7 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
>  			    struct of_bus *pbus, u32 *addr,
>  			    int na, int ns, int pna, const char *rprop)
>  {
> -	const u32 *ranges;
> +	const __be32 *ranges;
>  	unsigned int rlen;
>  	int rone;
>  	u64 offset = OF_BAD_ADDR;
> @@ -398,7 +400,7 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
>   * that can be mapped to a cpu physical address). This is not really specified
>   * that way, but this is traditionally the way IBM at least do things
>   */
> -u64 __of_translate_address(struct device_node *dev, const u32 *in_addr,
> +u64 __of_translate_address(struct device_node *dev, const __be32 *in_addr,
>  			   const char *rprop)
>  {
>  	struct device_node *parent = NULL;
> @@ -475,22 +477,22 @@ u64 __of_translate_address(struct device_node *dev, const u32 *in_addr,
>  	return result;
>  }
>  
> -u64 of_translate_address(struct device_node *dev, const u32 *in_addr)
> +u64 of_translate_address(struct device_node *dev, const __be32 *in_addr)
>  {
>  	return __of_translate_address(dev, in_addr, "ranges");
>  }
>  EXPORT_SYMBOL(of_translate_address);
>  
> -u64 of_translate_dma_address(struct device_node *dev, const u32 *in_addr)
> +u64 of_translate_dma_address(struct device_node *dev, const __be32 *in_addr)
>  {
>  	return __of_translate_address(dev, in_addr, "dma-ranges");
>  }
>  EXPORT_SYMBOL(of_translate_dma_address);
>  
> -const u32 *of_get_address(struct device_node *dev, int index, u64 *size,
> +const __be32 *of_get_address(struct device_node *dev, int index, u64 *size,
>  		    unsigned int *flags)
>  {
> -	const u32 *prop;
> +	const __be32 *prop;
>  	unsigned int psize;
>  	struct device_node *parent;
>  	struct of_bus *bus;
> @@ -525,8 +527,8 @@ const u32 *of_get_address(struct device_node *dev, int index, u64 *size,
>  }
>  EXPORT_SYMBOL(of_get_address);
>  
> -static int __of_address_to_resource(struct device_node *dev, const u32 *addrp,
> -				    u64 size, unsigned int flags,
> +static int __of_address_to_resource(struct device_node *dev,
> +		const __be32 *addrp, u64 size, unsigned int flags,
>  				    struct resource *r)
>  {
>  	u64 taddr;
> @@ -564,7 +566,7 @@ static int __of_address_to_resource(struct device_node *dev, const u32 *addrp,
>  int of_address_to_resource(struct device_node *dev, int index,
>  			   struct resource *r)
>  {
> -	const u32	*addrp;
> +	const __be32	*addrp;
>  	u64		size;
>  	unsigned int	flags;
>  
> diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> index 8aea06f..2feda6e 100644
> --- a/include/linux/of_address.h
> +++ b/include/linux/of_address.h
> @@ -3,7 +3,7 @@
>  #include <linux/ioport.h>
>  #include <linux/of.h>
>  
> -extern u64 of_translate_address(struct device_node *np, const u32 *addr);
> +extern u64 of_translate_address(struct device_node *np, const __be32 *addr);
>  extern int of_address_to_resource(struct device_node *dev, int index,
>  				  struct resource *r);
>  extern void __iomem *of_iomap(struct device_node *device, int index);
> @@ -21,7 +21,7 @@ static inline unsigned long pci_address_to_pio(phys_addr_t addr) { return -1; }
>  #endif
>  
>  #ifdef CONFIG_PCI
> -extern const u32 *of_get_pci_address(struct device_node *dev, int bar_no,
> +extern const __be32 *of_get_pci_address(struct device_node *dev, int bar_no,
>  			       u64 *size, unsigned int *flags);
>  extern int of_pci_address_to_resource(struct device_node *dev, int bar,
>  				      struct resource *r);
> @@ -32,7 +32,7 @@ static inline int of_pci_address_to_resource(struct device_node *dev, int bar,
>  	return -ENOSYS;
>  }
>  
> -static inline const u32 *of_get_pci_address(struct device_node *dev,
> +static inline const __be32 *of_get_pci_address(struct device_node *dev,
>  		int bar_no, u64 *size, unsigned int *flags)
>  {
>  	return NULL;
