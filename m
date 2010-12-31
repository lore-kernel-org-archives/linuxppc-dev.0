Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id 035A11007D8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Dec 2010 18:46:26 +1100 (EST)
Received: by iye19 with SMTP id 19so11406874iye.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Dec 2010 23:46:24 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Fri, 31 Dec 2010 00:46:20 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Deepak Saxena <deepak_saxena@mentor.com>
Subject: Re: [PATCH 2/5] of/device: make for_each_node* check status properties
Message-ID: <20101231074620.GC4195@angua.secretlab.ca>
References: <cover.1291799069.git.deepak_saxena@mentor.com>
	<20101208192957.GF32473@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101208192957.GF32473@mentor.com>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 08, 2010 at 11:29:57AM -0800, Deepak Saxena wrote:
> Some early device drivers don't actually implement a struct of_platform_driver,
> and instead use the for_each_node* iterators to search for matching device
> nodes. Disabled device nodes will no longer be returned by these iterators.
> 
> Signed-off-by: Hollis Blanchard <hollis_blanchard@mentor.com>
> Signed-off-by: Deepak Saxena <deepak_saxena@mentor.com>

As already discussed, the generic device tree iterator and search
functions should not be filtering the results as done here.

g.

> ---
>  arch/powerpc/kernel/pci_of_scan.c         |    2 --
>  arch/powerpc/platforms/83xx/usb.c         |    2 +-
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c |   13 ++-----------
>  arch/powerpc/sysdev/fsl_pci.c             |    5 -----
>  arch/powerpc/sysdev/ppc4xx_pci.c          |   15 ---------------
>  drivers/of/base.c                         |   25 +++++++++++++++++++++++--
>  6 files changed, 26 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
> index e751506..fa4f719 100644
> --- a/arch/powerpc/kernel/pci_of_scan.c
> +++ b/arch/powerpc/kernel/pci_of_scan.c
> @@ -310,8 +310,6 @@ static void __devinit __of_scan_bus(struct device_node *node,
>  	/* Scan direct children */
>  	for_each_child_of_node(node, child) {
>  		pr_debug("  * %s\n", child->full_name);
> -		if (!of_device_is_available(child))
> -			continue;
>  		reg = of_get_property(child, "reg", &reglen);
>  		if (reg == NULL || reglen < 20)
>  			continue;
> diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
> index 3ba4bb7..749c70b 100644
> --- a/arch/powerpc/platforms/83xx/usb.c
> +++ b/arch/powerpc/platforms/83xx/usb.c
> @@ -211,7 +211,7 @@ int mpc837x_usb_cfg(void)
>  	int ret = 0;
>  
>  	np = of_find_compatible_node(NULL, NULL, "fsl-usb2-dr");
> -	if (!np || !of_device_is_available(np))
> +	if (!np)
>  		return -ENODEV;
>  	prop = of_get_property(np, "phy_type", NULL);
>  
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> index aa34cac..5d1a33f 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> @@ -170,10 +170,8 @@ static void __init mpc85xx_publish_qe_devices(void)
>  	struct device_node *np;
>  
>  	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
> -	if (!of_device_is_available(np)) {
> -		of_node_put(np);
> +	if (!np)
>  		return;
> -	}
>  
>  	of_platform_bus_probe(NULL, mpc85xx_qe_ids, NULL);
>  }
> @@ -267,11 +265,6 @@ static void __init mpc85xx_mds_qe_init(void)
>  			return;
>  	}
>  
> -	if (!of_device_is_available(np)) {
> -		of_node_put(np);
> -		return;
> -	}
> -
>  	qe_reset();
>  	of_node_put(np);
>  
> @@ -328,10 +321,8 @@ static void __init mpc85xx_mds_qeic_init(void)
>  	struct device_node *np;
>  
>  	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
> -	if (!of_device_is_available(np)) {
> -		of_node_put(np);
> +	if (!np)
>  		return;
> -	}
>  
>  	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
>  	if (!np) {
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 818f7c6..fba4ec7 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -623,11 +623,6 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
>  
>  	is_mpc83xx_pci = 1;
>  
> -	if (!of_device_is_available(dev)) {
> -		pr_warning("%s: disabled by the firmware.\n",
> -			   dev->full_name);
> -		return -ENODEV;
> -	}
>  	pr_debug("Adding PCI host bridge %s\n", dev->full_name);
>  
>  	/* Fetch host bridge registers address */
> diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
> index 156aa7d..cf2adec 100644
> --- a/arch/powerpc/sysdev/ppc4xx_pci.c
> +++ b/arch/powerpc/sysdev/ppc4xx_pci.c
> @@ -321,13 +321,6 @@ static void __init ppc4xx_probe_pci_bridge(struct device_node *np)
>  	const int *bus_range;
>  	int primary = 0;
>  
> -	/* Check if device is enabled */
> -	if (!of_device_is_available(np)) {
> -		printk(KERN_INFO "%s: Port disabled via device-tree\n",
> -		       np->full_name);
> -		return;
> -	}
> -
>  	/* Fetch config space registers address */
>  	if (of_address_to_resource(np, 0, &rsrc_cfg)) {
>  		printk(KERN_ERR "%s: Can't get PCI config register base !",
> @@ -1890,14 +1883,6 @@ static void __init ppc4xx_probe_pciex_bridge(struct device_node *np)
>  	port = &ppc4xx_pciex_ports[portno];
>  	port->index = portno;
>  
> -	/*
> -	 * Check if device is enabled
> -	 */
> -	if (!of_device_is_available(np)) {
> -		printk(KERN_INFO "PCIE%d: Port disabled via device-tree\n", port->index);
> -		return;
> -	}
> -
>  	port->node = of_node_get(np);
>  	pval = of_get_property(np, "sdr-base", NULL);
>  	if (pval == NULL) {
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 710b53b..5d269a4 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -344,6 +344,8 @@ EXPORT_SYMBOL(of_get_next_child);
>   *
>   *	Returns a node pointer with refcount incremented, use
>   *	of_node_put() on it when done.
> + *
> + *	Does not return nodes marked unavailable by a status property.
>   */
>  struct device_node *of_find_node_by_path(const char *path)
>  {
> @@ -352,6 +354,7 @@ struct device_node *of_find_node_by_path(const char *path)
>  	read_lock(&devtree_lock);
>  	for (; np; np = np->allnext) {
>  		if (np->full_name && (of_node_cmp(np->full_name, path) == 0)
> +			&& of_device_is_available(np)
>  		    && of_node_get(np))
>  			break;
>  	}
> @@ -370,6 +373,8 @@ EXPORT_SYMBOL(of_find_node_by_path);
>   *
>   *	Returns a node pointer with refcount incremented, use
>   *	of_node_put() on it when done.
> + *
> + *	Does not return nodes marked unavailable by a status property.
>   */
>  struct device_node *of_find_node_by_name(struct device_node *from,
>  	const char *name)
> @@ -380,6 +385,7 @@ struct device_node *of_find_node_by_name(struct device_node *from,
>  	np = from ? from->allnext : allnodes;
>  	for (; np; np = np->allnext)
>  		if (np->name && (of_node_cmp(np->name, name) == 0)
> +			&& of_device_is_available(np)
>  		    && of_node_get(np))
>  			break;
>  	of_node_put(from);
> @@ -399,6 +405,8 @@ EXPORT_SYMBOL(of_find_node_by_name);
>   *
>   *	Returns a node pointer with refcount incremented, use
>   *	of_node_put() on it when done.
> + *
> + *	Does not return nodes marked unavailable by a status property.
>   */
>  struct device_node *of_find_node_by_type(struct device_node *from,
>  	const char *type)
> @@ -409,6 +417,7 @@ struct device_node *of_find_node_by_type(struct device_node *from,
>  	np = from ? from->allnext : allnodes;
>  	for (; np; np = np->allnext)
>  		if (np->type && (of_node_cmp(np->type, type) == 0)
> +			&& of_device_is_available(np)
>  		    && of_node_get(np))
>  			break;
>  	of_node_put(from);
> @@ -430,6 +439,8 @@ EXPORT_SYMBOL(of_find_node_by_type);
>   *
>   *	Returns a node pointer with refcount incremented, use
>   *	of_node_put() on it when done.
> + *
> + *	Does not return nodes marked unavailable by a status property.
>   */
>  struct device_node *of_find_compatible_node(struct device_node *from,
>  	const char *type, const char *compatible)
> @@ -442,7 +453,9 @@ struct device_node *of_find_compatible_node(struct device_node *from,
>  		if (type
>  		    && !(np->type && (of_node_cmp(np->type, type) == 0)))
>  			continue;
> -		if (of_device_is_compatible(np, compatible) && of_node_get(np))
> +		if (of_device_is_compatible(np, compatible)
> +			&& of_device_is_available(np)
> +			&& of_node_get(np))
>  			break;
>  	}
>  	of_node_put(from);
> @@ -462,6 +475,8 @@ EXPORT_SYMBOL(of_find_compatible_node);
>   *
>   *	Returns a node pointer with refcount incremented, use
>   *	of_node_put() on it when done.
> + *
> + *	Does not return nodes marked unavailable by a status property.
>   */
>  struct device_node *of_find_node_with_property(struct device_node *from,
>  	const char *prop_name)
> @@ -472,6 +487,8 @@ struct device_node *of_find_node_with_property(struct device_node *from,
>  	read_lock(&devtree_lock);
>  	np = from ? from->allnext : allnodes;
>  	for (; np; np = np->allnext) {
> +		if (!of_device_is_available(np))
> +			continue;
>  		for (pp = np->properties; pp != 0; pp = pp->next) {
>  			if (of_prop_cmp(pp->name, prop_name) == 0) {
>  				of_node_get(np);
> @@ -526,6 +543,8 @@ EXPORT_SYMBOL(of_match_node);
>   *
>   *	Returns a node pointer with refcount incremented, use
>   *	of_node_put() on it when done.
> + *
> + *	Does not return nodes marked unavailable by a status property.
>   */
>  struct device_node *of_find_matching_node(struct device_node *from,
>  					  const struct of_device_id *matches)
> @@ -535,7 +554,9 @@ struct device_node *of_find_matching_node(struct device_node *from,
>  	read_lock(&devtree_lock);
>  	np = from ? from->allnext : allnodes;
>  	for (; np; np = np->allnext) {
> -		if (of_match_node(matches, np) && of_node_get(np))
> +		if (of_match_node(matches, np)
> +			&& of_device_is_available(np)
> +			&& of_node_get(np))
>  			break;
>  	}
>  	of_node_put(from);
> -- 
> 1.6.3.3
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
