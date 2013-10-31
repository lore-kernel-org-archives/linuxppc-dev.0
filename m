Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D3D4D2C03C3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 16:20:59 +1100 (EST)
Message-ID: <1383196834.28909.7.camel@pasglop>
Subject: Re: [PATCH 2/2] of: move definition of of_find_next_cache_node into
 common code.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Date: Thu, 31 Oct 2013 16:20:34 +1100
In-Reply-To: <1379501585-12532-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1379501585-12532-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1379501585-12532-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-18 at 11:53 +0100, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Since the definition of_find_next_cache_node is architecture independent,
> the existing definition in powerpc can be moved to driver/of/base.c
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

I've seen no follow up on that, I'm happy to stick it in powerpc-next
with some other late stuff.

Cheers,
Ben.

> ---
>  arch/powerpc/include/asm/prom.h |  3 ---
>  arch/powerpc/kernel/prom.c      | 31 -------------------------------
>  drivers/of/base.c               | 31 +++++++++++++++++++++++++++++++
>  include/linux/of.h              |  2 ++
>  4 files changed, 33 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
> index 7d0c7f3..bf09e5a 100644
> --- a/arch/powerpc/include/asm/prom.h
> +++ b/arch/powerpc/include/asm/prom.h
> @@ -44,9 +44,6 @@ void of_parse_dma_window(struct device_node *dn, const __be32 *dma_window,
>  
>  extern void kdump_move_device_tree(void);
>  
> -/* cache lookup */
> -struct device_node *of_find_next_cache_node(struct device_node *np);
> -
>  #ifdef CONFIG_NUMA
>  extern int of_node_to_nid(struct device_node *device);
>  #else
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 09be275..4432fd8 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -761,37 +761,6 @@ void __init early_init_devtree(void *params)
>   *******/
>  
>  /**
> - *	of_find_next_cache_node - Find a node's subsidiary cache
> - *	@np:	node of type "cpu" or "cache"
> - *
> - *	Returns a node pointer with refcount incremented, use
> - *	of_node_put() on it when done.  Caller should hold a reference
> - *	to np.
> - */
> -struct device_node *of_find_next_cache_node(struct device_node *np)
> -{
> -	struct device_node *child;
> -	const phandle *handle;
> -
> -	handle = of_get_property(np, "l2-cache", NULL);
> -	if (!handle)
> -		handle = of_get_property(np, "next-level-cache", NULL);
> -
> -	if (handle)
> -		return of_find_node_by_phandle(be32_to_cpup(handle));
> -
> -	/* OF on pmac has nodes instead of properties named "l2-cache"
> -	 * beneath CPU nodes.
> -	 */
> -	if (!strcmp(np->type, "cpu"))
> -		for_each_child_of_node(np, child)
> -			if (!strcmp(child->type, "cache"))
> -				return child;
> -
> -	return NULL;
> -}
> -
> -/**
>   * of_get_ibm_chip_id - Returns the IBM "chip-id" of a device
>   * @np: device node of the device
>   *
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 865d3f6..b2cee3d 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1884,3 +1884,34 @@ int of_device_is_stdout_path(struct device_node *dn)
>  	return of_stdout == dn;
>  }
>  EXPORT_SYMBOL_GPL(of_device_is_stdout_path);
> +
> +/**
> + *	of_find_next_cache_node - Find a node's subsidiary cache
> + *	@np:	node of type "cpu" or "cache"
> + *
> + *	Returns a node pointer with refcount incremented, use
> + *	of_node_put() on it when done.  Caller should hold a reference
> + *	to np.
> + */
> +struct device_node *of_find_next_cache_node(const struct device_node *np)
> +{
> +	struct device_node *child;
> +	const phandle *handle;
> +
> +	handle = of_get_property(np, "l2-cache", NULL);
> +	if (!handle)
> +		handle = of_get_property(np, "next-level-cache", NULL);
> +
> +	if (handle)
> +		return of_find_node_by_phandle(be32_to_cpup(handle));
> +
> +	/* OF on pmac has nodes instead of properties named "l2-cache"
> +	 * beneath CPU nodes.
> +	 */
> +	if (!strcmp(np->type, "cpu"))
> +		for_each_child_of_node(np, child)
> +			if (!strcmp(child->type, "cache"))
> +				return child;
> +
> +	return NULL;
> +}
> diff --git a/include/linux/of.h b/include/linux/of.h
> index f95aee3..c08c07e 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -226,6 +226,8 @@ static inline int of_get_child_count(const struct device_node *np)
>  	return num;
>  }
>  
> +/* cache lookup */
> +extern struct device_node *of_find_next_cache_node(const struct device_node *);
>  extern struct device_node *of_find_node_with_property(
>  	struct device_node *from, const char *prop_name);
>  #define for_each_node_with_property(dn, prop_name) \
