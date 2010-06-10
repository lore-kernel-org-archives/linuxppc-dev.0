Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14E421009A7
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 16:39:11 +1000 (EST)
Subject: Re: [PATCH 4/5] of/irq: Merge of_irq_map_raw()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20100604212150.10552.3378.stgit@angua>
References: <20100604212134.10552.70717.stgit@angua>
	<20100604212150.10552.3378.stgit@angua>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Jun 2010 16:38:51 +1000
Message-ID: <1276151931.1962.54.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Simek <monstr@monstr.eu>,
	microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-06-04 at 15:21 -0600, Grant Likely wrote:
> Merge common code between PowerPC and Microblaze
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> CC: Michal Simek <monstr@monstr.eu>
> CC: Wolfram Sang <w.sang@pengutronix.de>
> CC: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by : Benjamin Herrenschmidt <benh@kernel.crashing.org>

I haven't double checked that the code was absolutely identical... if
you haven't, please do so :-)

Cheers,
Ben.

> CC: microblaze-uclinux@itee.uq.edu.au
> CC: linuxppc-dev@ozlabs.org
> CC: devicetree-discuss@lists.ozlabs.org
> ---
>  arch/microblaze/include/asm/prom.h  |   21 ----
>  arch/microblaze/kernel/prom_parse.c |  176 ---------------------------------
>  arch/powerpc/include/asm/prom.h     |   21 ----
>  arch/powerpc/kernel/prom_parse.c    |  171 --------------------------------
>  drivers/of/irq.c                    |  188 +++++++++++++++++++++++++++++++++++
>  include/linux/of_irq.h              |    2 
>  6 files changed, 190 insertions(+), 389 deletions(-)
> 
> diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
> index da7069c..89fca70 100644
> --- a/arch/microblaze/include/asm/prom.h
> +++ b/arch/microblaze/include/asm/prom.h
> @@ -94,27 +94,6 @@ extern const void *of_get_mac_address(struct device_node *np);
>   */
>  
>  /**
> - * of_irq_map_raw - Low level interrupt tree parsing
> - * @parent:	the device interrupt parent
> - * @intspec:	interrupt specifier ("interrupts" property of the device)
> - * @ointsize:	size of the passed in interrupt specifier
> - * @addr:	address specifier (start of "reg" property of the device)
> - * @out_irq:	structure of_irq filled by this function
> - *
> - * Returns 0 on success and a negative number on error
> - *
> - * This function is a low-level interrupt tree walking function. It
> - * can be used to do a partial walk with synthetized reg and interrupts
> - * properties, for example when resolving PCI interrupts when no device
> - * node exist for the parent.
> - *
> - */
> -
> -extern int of_irq_map_raw(struct device_node *parent, const u32 *intspec,
> -			u32 ointsize, const u32 *addr,
> -			struct of_irq *out_irq);
> -
> -/**
>   * of_irq_map_pci - Resolve the interrupt for a PCI device
>   * @pdev:	the device whose interrupt is to be resolved
>   * @out_irq:	structure of_irq filled by this function
> diff --git a/arch/microblaze/kernel/prom_parse.c b/arch/microblaze/kernel/prom_parse.c
> index 946f14d..02ec946 100644
> --- a/arch/microblaze/kernel/prom_parse.c
> +++ b/arch/microblaze/kernel/prom_parse.c
> @@ -653,182 +653,6 @@ struct device_node *of_irq_find_parent_by_phandle(phandle p)
>  	return of_find_node_by_phandle(p);
>  }
>  
> -int of_irq_map_raw(struct device_node *parent, const u32 *intspec, u32 ointsize,
> -		const u32 *addr, struct of_irq *out_irq)
> -{
> -	struct device_node *ipar, *tnode, *old = NULL, *newpar = NULL;
> -	const u32 *tmp, *imap, *imask;
> -	u32 intsize = 1, addrsize, newintsize = 0, newaddrsize = 0;
> -	int imaplen, match, i;
> -
> -	pr_debug("of_irq_map_raw: par=%s,intspec=[0x%08x 0x%08x...],"
> -		"ointsize=%d\n",
> -		parent->full_name, intspec[0], intspec[1], ointsize);
> -
> -	ipar = of_node_get(parent);
> -
> -	/* First get the #interrupt-cells property of the current cursor
> -	 * that tells us how to interpret the passed-in intspec. If there
> -	 * is none, we are nice and just walk up the tree
> -	 */
> -	do {
> -		tmp = of_get_property(ipar, "#interrupt-cells", NULL);
> -		if (tmp != NULL) {
> -			intsize = *tmp;
> -			break;
> -		}
> -		tnode = ipar;
> -		ipar = of_irq_find_parent(ipar);
> -		of_node_put(tnode);
> -	} while (ipar);
> -	if (ipar == NULL) {
> -		pr_debug(" -> no parent found !\n");
> -		goto fail;
> -	}
> -
> -	pr_debug("of_irq_map_raw: ipar=%s, size=%d\n",
> -			ipar->full_name, intsize);
> -
> -	if (ointsize != intsize)
> -		return -EINVAL;
> -
> -	/* Look for this #address-cells. We have to implement the old linux
> -	 * trick of looking for the parent here as some device-trees rely on it
> -	 */
> -	old = of_node_get(ipar);
> -	do {
> -		tmp = of_get_property(old, "#address-cells", NULL);
> -		tnode = of_get_parent(old);
> -		of_node_put(old);
> -		old = tnode;
> -	} while (old && tmp == NULL);
> -	of_node_put(old);
> -	old = NULL;
> -	addrsize = (tmp == NULL) ? 2 : *tmp;
> -
> -	pr_debug(" -> addrsize=%d\n", addrsize);
> -
> -	/* Now start the actual "proper" walk of the interrupt tree */
> -	while (ipar != NULL) {
> -		/* Now check if cursor is an interrupt-controller and if it is
> -		 * then we are done
> -		 */
> -		if (of_get_property(ipar, "interrupt-controller", NULL) !=
> -				NULL) {
> -			pr_debug(" -> got it !\n");
> -			memcpy(out_irq->specifier, intspec,
> -				intsize * sizeof(u32));
> -			out_irq->size = intsize;
> -			out_irq->controller = ipar;
> -			of_node_put(old);
> -			return 0;
> -		}
> -
> -		/* Now look for an interrupt-map */
> -		imap = of_get_property(ipar, "interrupt-map", &imaplen);
> -		/* No interrupt map, check for an interrupt parent */
> -		if (imap == NULL) {
> -			pr_debug(" -> no map, getting parent\n");
> -			newpar = of_irq_find_parent(ipar);
> -			goto skiplevel;
> -		}
> -		imaplen /= sizeof(u32);
> -
> -		/* Look for a mask */
> -		imask = of_get_property(ipar, "interrupt-map-mask", NULL);
> -
> -		/* If we were passed no "reg" property and we attempt to parse
> -		 * an interrupt-map, then #address-cells must be 0.
> -		 * Fail if it's not.
> -		 */
> -		if (addr == NULL && addrsize != 0) {
> -			pr_debug(" -> no reg passed in when needed !\n");
> -			goto fail;
> -		}
> -
> -		/* Parse interrupt-map */
> -		match = 0;
> -		while (imaplen > (addrsize + intsize + 1) && !match) {
> -			/* Compare specifiers */
> -			match = 1;
> -			for (i = 0; i < addrsize && match; ++i) {
> -				u32 mask = imask ? imask[i] : 0xffffffffu;
> -				match = ((addr[i] ^ imap[i]) & mask) == 0;
> -			}
> -			for (; i < (addrsize + intsize) && match; ++i) {
> -				u32 mask = imask ? imask[i] : 0xffffffffu;
> -				match =
> -					((intspec[i-addrsize] ^ imap[i])
> -						& mask) == 0;
> -			}
> -			imap += addrsize + intsize;
> -			imaplen -= addrsize + intsize;
> -
> -			pr_debug(" -> match=%d (imaplen=%d)\n", match, imaplen);
> -
> -			/* Get the interrupt parent */
> -			newpar = of_irq_find_parent_by_phandle((phandle)*imap);
> -			imap++;
> -			--imaplen;
> -
> -			/* Check if not found */
> -			if (newpar == NULL) {
> -				pr_debug(" -> imap parent not found !\n");
> -				goto fail;
> -			}
> -
> -			/* Get #interrupt-cells and #address-cells of new
> -			 * parent
> -			 */
> -			tmp = of_get_property(newpar, "#interrupt-cells", NULL);
> -			if (tmp == NULL) {
> -				pr_debug(" -> parent lacks "
> -						"#interrupt-cells!\n");
> -				goto fail;
> -			}
> -			newintsize = *tmp;
> -			tmp = of_get_property(newpar, "#address-cells", NULL);
> -			newaddrsize = (tmp == NULL) ? 0 : *tmp;
> -
> -			pr_debug(" -> newintsize=%d, newaddrsize=%d\n",
> -				newintsize, newaddrsize);
> -
> -			/* Check for malformed properties */
> -			if (imaplen < (newaddrsize + newintsize))
> -				goto fail;
> -
> -			imap += newaddrsize + newintsize;
> -			imaplen -= newaddrsize + newintsize;
> -
> -			pr_debug(" -> imaplen=%d\n", imaplen);
> -		}
> -		if (!match)
> -			goto fail;
> -
> -		of_node_put(old);
> -		old = of_node_get(newpar);
> -		addrsize = newaddrsize;
> -		intsize = newintsize;
> -		intspec = imap - intsize;
> -		addr = intspec - addrsize;
> -
> -skiplevel:
> -		/* Iterate again with new parent */
> -		pr_debug(" -> new parent: %s\n",
> -				newpar ? newpar->full_name : "<>");
> -		of_node_put(ipar);
> -		ipar = newpar;
> -		newpar = NULL;
> -	}
> -fail:
> -	of_node_put(ipar);
> -	of_node_put(old);
> -	of_node_put(newpar);
> -
> -	return -EINVAL;
> -}
> -EXPORT_SYMBOL_GPL(of_irq_map_raw);
> -
>  int of_irq_map_one(struct device_node *device,
>  			int index, struct of_irq *out_irq)
>  {
> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
> index 47d41b6..187ef4e 100644
> --- a/arch/powerpc/include/asm/prom.h
> +++ b/arch/powerpc/include/asm/prom.h
> @@ -123,27 +123,6 @@ extern const void *of_get_mac_address(struct device_node *np);
>  extern void of_irq_map_init(unsigned int flags);
>  
>  /**
> - * of_irq_map_raw - Low level interrupt tree parsing
> - * @parent:	the device interrupt parent
> - * @intspec:	interrupt specifier ("interrupts" property of the device)
> - * @ointsize:   size of the passed in interrupt specifier
> - * @addr:	address specifier (start of "reg" property of the device)
> - * @out_irq:	structure of_irq filled by this function
> - *
> - * Returns 0 on success and a negative number on error
> - *
> - * This function is a low-level interrupt tree walking function. It
> - * can be used to do a partial walk with synthetized reg and interrupts
> - * properties, for example when resolving PCI interrupts when no device
> - * node exist for the parent.
> - *
> - */
> -
> -extern int of_irq_map_raw(struct device_node *parent, const u32 *intspec,
> -			  u32 ointsize, const u32 *addr,
> -			  struct of_irq *out_irq);
> -
> -/**
>   * of_irq_map_pci - Resolve the interrupt for a PCI device
>   * @pdev:	the device whose interrupt is to be resolved
>   * @out_irq:	structure of_irq filled by this function
> diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
> index 39e977d..89ca7b3 100644
> --- a/arch/powerpc/kernel/prom_parse.c
> +++ b/arch/powerpc/kernel/prom_parse.c
> @@ -731,177 +731,6 @@ void of_irq_map_init(unsigned int flags)
>  
>  }
>  
> -int of_irq_map_raw(struct device_node *parent, const u32 *intspec, u32 ointsize,
> -		const u32 *addr, struct of_irq *out_irq)
> -{
> -	struct device_node *ipar, *tnode, *old = NULL, *newpar = NULL;
> -	const u32 *tmp, *imap, *imask;
> -	u32 intsize = 1, addrsize, newintsize = 0, newaddrsize = 0;
> -	int imaplen, match, i;
> -
> -	DBG("of_irq_map_raw: par=%s,intspec=[0x%08x 0x%08x...],ointsize=%d\n",
> -	    parent->full_name, intspec[0], intspec[1], ointsize);
> -
> -	ipar = of_node_get(parent);
> -
> -	/* First get the #interrupt-cells property of the current cursor
> -	 * that tells us how to interpret the passed-in intspec. If there
> -	 * is none, we are nice and just walk up the tree
> -	 */
> -	do {
> -		tmp = of_get_property(ipar, "#interrupt-cells", NULL);
> -		if (tmp != NULL) {
> -			intsize = *tmp;
> -			break;
> -		}
> -		tnode = ipar;
> -		ipar = of_irq_find_parent(ipar);
> -		of_node_put(tnode);
> -	} while (ipar);
> -	if (ipar == NULL) {
> -		DBG(" -> no parent found !\n");
> -		goto fail;
> -	}
> -
> -	DBG("of_irq_map_raw: ipar=%s, size=%d\n", ipar->full_name, intsize);
> -
> -	if (ointsize != intsize)
> -		return -EINVAL;
> -
> -	/* Look for this #address-cells. We have to implement the old linux
> -	 * trick of looking for the parent here as some device-trees rely on it
> -	 */
> -	old = of_node_get(ipar);
> -	do {
> -		tmp = of_get_property(old, "#address-cells", NULL);
> -		tnode = of_get_parent(old);
> -		of_node_put(old);
> -		old = tnode;
> -	} while(old && tmp == NULL);
> -	of_node_put(old);
> -	old = NULL;
> -	addrsize = (tmp == NULL) ? 2 : *tmp;
> -
> -	DBG(" -> addrsize=%d\n", addrsize);
> -
> -	/* Now start the actual "proper" walk of the interrupt tree */
> -	while (ipar != NULL) {
> -		/* Now check if cursor is an interrupt-controller and if it is
> -		 * then we are done
> -		 */
> -		if (of_get_property(ipar, "interrupt-controller", NULL) !=
> -				NULL) {
> -			DBG(" -> got it !\n");
> -			memcpy(out_irq->specifier, intspec,
> -			       intsize * sizeof(u32));
> -			out_irq->size = intsize;
> -			out_irq->controller = ipar;
> -			of_node_put(old);
> -			return 0;
> -		}
> -
> -		/* Now look for an interrupt-map */
> -		imap = of_get_property(ipar, "interrupt-map", &imaplen);
> -		/* No interrupt map, check for an interrupt parent */
> -		if (imap == NULL) {
> -			DBG(" -> no map, getting parent\n");
> -			newpar = of_irq_find_parent(ipar);
> -			goto skiplevel;
> -		}
> -		imaplen /= sizeof(u32);
> -
> -		/* Look for a mask */
> -		imask = of_get_property(ipar, "interrupt-map-mask", NULL);
> -
> -		/* If we were passed no "reg" property and we attempt to parse
> -		 * an interrupt-map, then #address-cells must be 0.
> -		 * Fail if it's not.
> -		 */
> -		if (addr == NULL && addrsize != 0) {
> -			DBG(" -> no reg passed in when needed !\n");
> -			goto fail;
> -		}
> -
> -		/* Parse interrupt-map */
> -		match = 0;
> -		while (imaplen > (addrsize + intsize + 1) && !match) {
> -			/* Compare specifiers */
> -			match = 1;
> -			for (i = 0; i < addrsize && match; ++i) {
> -				u32 mask = imask ? imask[i] : 0xffffffffu;
> -				match = ((addr[i] ^ imap[i]) & mask) == 0;
> -			}
> -			for (; i < (addrsize + intsize) && match; ++i) {
> -				u32 mask = imask ? imask[i] : 0xffffffffu;
> -				match =
> -				   ((intspec[i-addrsize] ^ imap[i]) & mask) == 0;
> -			}
> -			imap += addrsize + intsize;
> -			imaplen -= addrsize + intsize;
> -
> -			DBG(" -> match=%d (imaplen=%d)\n", match, imaplen);
> -
> -			/* Get the interrupt parent */
> -			newpar = of_irq_find_parent_by_phandle((phandle)*imap);
> -			imap++;
> -			--imaplen;
> -
> -			/* Check if not found */
> -			if (newpar == NULL) {
> -				DBG(" -> imap parent not found !\n");
> -				goto fail;
> -			}
> -
> -			/* Get #interrupt-cells and #address-cells of new
> -			 * parent
> -			 */
> -			tmp = of_get_property(newpar, "#interrupt-cells", NULL);
> -			if (tmp == NULL) {
> -				DBG(" -> parent lacks #interrupt-cells !\n");
> -				goto fail;
> -			}
> -			newintsize = *tmp;
> -			tmp = of_get_property(newpar, "#address-cells", NULL);
> -			newaddrsize = (tmp == NULL) ? 0 : *tmp;
> -
> -			DBG(" -> newintsize=%d, newaddrsize=%d\n",
> -			    newintsize, newaddrsize);
> -
> -			/* Check for malformed properties */
> -			if (imaplen < (newaddrsize + newintsize))
> -				goto fail;
> -
> -			imap += newaddrsize + newintsize;
> -			imaplen -= newaddrsize + newintsize;
> -
> -			DBG(" -> imaplen=%d\n", imaplen);
> -		}
> -		if (!match)
> -			goto fail;
> -
> -		of_node_put(old);
> -		old = of_node_get(newpar);
> -		addrsize = newaddrsize;
> -		intsize = newintsize;
> -		intspec = imap - intsize;
> -		addr = intspec - addrsize;
> -
> -	skiplevel:
> -		/* Iterate again with new parent */
> -		DBG(" -> new parent: %s\n", newpar ? newpar->full_name : "<>");
> -		of_node_put(ipar);
> -		ipar = newpar;
> -		newpar = NULL;
> -	}
> - fail:
> -	of_node_put(ipar);
> -	of_node_put(old);
> -	of_node_put(newpar);
> -
> -	return -EINVAL;
> -}
> -EXPORT_SYMBOL_GPL(of_irq_map_raw);
> -
>  #if defined(CONFIG_PPC_PMAC) && defined(CONFIG_PPC32)
>  static int of_irq_map_oldworld(struct device_node *device, int index,
>  			       struct of_irq *out_irq)
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index ad569ca..351c87a 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -52,6 +52,194 @@ struct device_node *of_irq_find_parent(struct device_node *child)
>  	return p;
>  }
>  
> +/**
> + * of_irq_map_raw - Low level interrupt tree parsing
> + * @parent:	the device interrupt parent
> + * @intspec:	interrupt specifier ("interrupts" property of the device)
> + * @ointsize:	size of the passed in interrupt specifier
> + * @addr:	address specifier (start of "reg" property of the device)
> + * @out_irq:	structure of_irq filled by this function
> + *
> + * Returns 0 on success and a negative number on error
> + *
> + * This function is a low-level interrupt tree walking function. It
> + * can be used to do a partial walk with synthetized reg and interrupts
> + * properties, for example when resolving PCI interrupts when no device
> + * node exist for the parent.
> + */
> +int of_irq_map_raw(struct device_node *parent, const u32 *intspec, u32 ointsize,
> +		const u32 *addr, struct of_irq *out_irq)
> +{
> +	struct device_node *ipar, *tnode, *old = NULL, *newpar = NULL;
> +	const u32 *tmp, *imap, *imask;
> +	u32 intsize = 1, addrsize, newintsize = 0, newaddrsize = 0;
> +	int imaplen, match, i;
> +
> +	pr_debug("of_irq_map_raw: par=%s,intspec=[0x%08x 0x%08x...],ointsize=%d\n",
> +		 parent->full_name, intspec[0], intspec[1], ointsize);
> +
> +	ipar = of_node_get(parent);
> +
> +	/* First get the #interrupt-cells property of the current cursor
> +	 * that tells us how to interpret the passed-in intspec. If there
> +	 * is none, we are nice and just walk up the tree
> +	 */
> +	do {
> +		tmp = of_get_property(ipar, "#interrupt-cells", NULL);
> +		if (tmp != NULL) {
> +			intsize = *tmp;
> +			break;
> +		}
> +		tnode = ipar;
> +		ipar = of_irq_find_parent(ipar);
> +		of_node_put(tnode);
> +	} while (ipar);
> +	if (ipar == NULL) {
> +		pr_debug(" -> no parent found !\n");
> +		goto fail;
> +	}
> +
> +	pr_debug("of_irq_map_raw: ipar=%s, size=%d\n",
> +		 ipar->full_name, intsize);
> +
> +	if (ointsize != intsize)
> +		return -EINVAL;
> +
> +	/* Look for this #address-cells. We have to implement the old linux
> +	 * trick of looking for the parent here as some device-trees rely on it
> +	 */
> +	old = of_node_get(ipar);
> +	do {
> +		tmp = of_get_property(old, "#address-cells", NULL);
> +		tnode = of_get_parent(old);
> +		of_node_put(old);
> +		old = tnode;
> +	} while (old && tmp == NULL);
> +	of_node_put(old);
> +	old = NULL;
> +	addrsize = (tmp == NULL) ? 2 : *tmp;
> +
> +	pr_debug(" -> addrsize=%d\n", addrsize);
> +
> +	/* Now start the actual "proper" walk of the interrupt tree */
> +	while (ipar != NULL) {
> +		/* Now check if cursor is an interrupt-controller and if it is
> +		 * then we are done
> +		 */
> +		if (of_get_property(ipar, "interrupt-controller", NULL) !=
> +				NULL) {
> +			pr_debug(" -> got it !\n");
> +			memcpy(out_irq->specifier, intspec,
> +			       intsize * sizeof(u32));
> +			out_irq->size = intsize;
> +			out_irq->controller = ipar;
> +			of_node_put(old);
> +			return 0;
> +		}
> +
> +		/* Now look for an interrupt-map */
> +		imap = of_get_property(ipar, "interrupt-map", &imaplen);
> +		/* No interrupt map, check for an interrupt parent */
> +		if (imap == NULL) {
> +			pr_debug(" -> no map, getting parent\n");
> +			newpar = of_irq_find_parent(ipar);
> +			goto skiplevel;
> +		}
> +		imaplen /= sizeof(u32);
> +
> +		/* Look for a mask */
> +		imask = of_get_property(ipar, "interrupt-map-mask", NULL);
> +
> +		/* If we were passed no "reg" property and we attempt to parse
> +		 * an interrupt-map, then #address-cells must be 0.
> +		 * Fail if it's not.
> +		 */
> +		if (addr == NULL && addrsize != 0) {
> +			pr_debug(" -> no reg passed in when needed !\n");
> +			goto fail;
> +		}
> +
> +		/* Parse interrupt-map */
> +		match = 0;
> +		while (imaplen > (addrsize + intsize + 1) && !match) {
> +			/* Compare specifiers */
> +			match = 1;
> +			for (i = 0; i < addrsize && match; ++i) {
> +				u32 mask = imask ? imask[i] : 0xffffffffu;
> +				match = ((addr[i] ^ imap[i]) & mask) == 0;
> +			}
> +			for (; i < (addrsize + intsize) && match; ++i) {
> +				u32 mask = imask ? imask[i] : 0xffffffffu;
> +				match =
> +				   ((intspec[i-addrsize] ^ imap[i]) & mask) == 0;
> +			}
> +			imap += addrsize + intsize;
> +			imaplen -= addrsize + intsize;
> +
> +			pr_debug(" -> match=%d (imaplen=%d)\n", match, imaplen);
> +
> +			/* Get the interrupt parent */
> +			newpar = of_irq_find_parent_by_phandle((phandle)*imap);
> +			imap++;
> +			--imaplen;
> +
> +			/* Check if not found */
> +			if (newpar == NULL) {
> +				pr_debug(" -> imap parent not found !\n");
> +				goto fail;
> +			}
> +
> +			/* Get #interrupt-cells and #address-cells of new
> +			 * parent
> +			 */
> +			tmp = of_get_property(newpar, "#interrupt-cells", NULL);
> +			if (tmp == NULL) {
> +				pr_debug(" -> parent lacks #interrupt-cells!\n");
> +				goto fail;
> +			}
> +			newintsize = *tmp;
> +			tmp = of_get_property(newpar, "#address-cells", NULL);
> +			newaddrsize = (tmp == NULL) ? 0 : *tmp;
> +
> +			pr_debug(" -> newintsize=%d, newaddrsize=%d\n",
> +			    newintsize, newaddrsize);
> +
> +			/* Check for malformed properties */
> +			if (imaplen < (newaddrsize + newintsize))
> +				goto fail;
> +
> +			imap += newaddrsize + newintsize;
> +			imaplen -= newaddrsize + newintsize;
> +
> +			pr_debug(" -> imaplen=%d\n", imaplen);
> +		}
> +		if (!match)
> +			goto fail;
> +
> +		of_node_put(old);
> +		old = of_node_get(newpar);
> +		addrsize = newaddrsize;
> +		intsize = newintsize;
> +		intspec = imap - intsize;
> +		addr = intspec - addrsize;
> +
> +	skiplevel:
> +		/* Iterate again with new parent */
> +		pr_debug(" -> new parent: %s\n",
> +			 newpar ? newpar->full_name : "<>");
> +		of_node_put(ipar);
> +		ipar = newpar;
> +		newpar = NULL;
> +	}
> + fail:
> +	of_node_put(ipar);
> +	of_node_put(old);
> +	of_node_put(newpar);
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(of_irq_map_raw);
> +
>  unsigned int irq_of_parse_and_map(struct device_node *dev, int index)
>  {
>  	struct of_irq oirq;
> diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
> index f98b27b..51c520b 100644
> --- a/include/linux/of_irq.h
> +++ b/include/linux/of_irq.h
> @@ -32,6 +32,8 @@ struct of_irq {
>  
>  extern struct device_node *of_irq_find_parent_by_phandle(phandle p);
>  extern struct device_node *of_irq_find_parent(struct device_node *child);
> +extern int of_irq_map_raw(struct device_node *parent, const u32 *intspec,
> +			 u32 ointsize, const u32 *addr, struct of_irq *out_irq);
>  extern int of_irq_map_one(struct device_node *device, int index,
>  			  struct of_irq *out_irq);
>  extern unsigned int irq_create_of_mapping(struct device_node *controller,
