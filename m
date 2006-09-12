Return-Path: <olof@lixom.net>
Date: Tue, 12 Sep 2006 14:54:38 -0500
From: Olof Johansson <olof@lixom.net>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH] powerpc: allow PHBs anywhere in the device tree
Message-ID: <20060912145438.30b6bf80@localhost.localdomain>
In-Reply-To: <200609121952.04779.arnd.bergmann@de.ibm.com>
References: <200609121952.04779.arnd.bergmann@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Looks good. Two very minor nitpicks below.


-Olof

On Tue, 12 Sep 2006 19:52:04 +0200 Arnd Bergmann <arnd.bergmann@de.ibm.com> wrote:

> The rtas_pci code currently restricts pci host bridges to
> locations directly under the device tree root. In order to
> correctly model a north bridge that has multiple PCI buses,
> that restriction needs to be relaxed.
> 
> The new definition is a device node of type "pci" whose
> parent is of a different type, so we don't treat pci-to-pci
> bridges as host bridges.
> It also accepts any device type of "pci", "pcie", "ht" and
> "pciex" in order to match anything that is currently in use.
> 
> I have added a new helper "of_find_phb_node" to prom.c so
> that pci implementations of non-rtas platforms can use this
> as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Index: linux-2.6/arch/powerpc/kernel/prom.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/kernel/prom.c
> +++ linux-2.6/arch/powerpc/kernel/prom.c
> @@ -1325,6 +1325,72 @@ struct device_node *of_get_next_child(co
>  EXPORT_SYMBOL(of_get_next_child);
>  
>  /**
> + *	of_node_is_pci - Test if a node a pci host
> + *	@node: node to compare
> + *
> + *	returns 1 for PCI hosts and 0 for anything else
> + *
> + *	This function is meant to be called from
> + *	of_find_phb_node as a helper. We compare both
> + *	the compatible and the device_type properties
> + *	to known strings used to indicate PCI hosts.
> + */
> +static int of_node_is_pci(struct device_node *node)
> +{
> +	if (!node->type)
> +		return 0;
> +
> +	if (strcasecmp(node->type, "pci")   == 0 ||
> +	    strcasecmp(node->type, "ht")    == 0 ||
> +	    strcasecmp(node->type, "pciex") == 0 ||
> +	    strcasecmp(node->type, "pcie")  == 0)

!strcasecmp(...) instead?
Do they ever exist in non-lowercase versions? Old code just did
strcmp().

> +		return 1;
> +
> +	if (device_is_compatible(node, "pci")	||
> +	    device_is_compatible(node, "ht")	||
> +	    device_is_compatible(node, "pciex") ||
> +	    device_is_compatible(node, "pcie"))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +/**
> + *
> + *	of_find_phb_node - Iterate all PCI host bridge device nodes
> + *
> + *	@from:	The node to start searching from or NULL, the node
> + *		you pass will not be searched, only the next one
> + *		will; typically, you pass what the previous call
> + *		returned. of_node_put() will be called on it

Convention seems to be to call this "prev", not "from"?

> + *
> + *	Returns a node pointer with refcount incremented, use
> + *	of_node_put() on it when done.
> + *
> + *	since we only want to return host bridges, not pci-pci
> + *	bridges, check if the parent is not also a pci host.
> + */
> +struct device_node *of_find_phb_node(struct device_node *from)
> +{
> +	struct device_node *np;
> +
> +	read_lock(&devtree_lock);
> +	np = from ? from->allnext : allnodes;
> +	for (; np; np = np->allnext) {
> +		if (of_node_is_pci(np) &&
> +		    np->parent &&
> +		    !of_node_is_pci(np->parent))
> +			break;
> +	}
> +	if (np)
> +		of_node_get(np);
> +	if (from)
> +		of_node_put(from);
> +	read_unlock(&devtree_lock);
> +	return np;
> +}
> +
> +/**
>   *	of_node_get - Increment refcount of a node
>   *	@node:	Node to inc refcount, NULL is supported to
>   *		simplify writing of callers
> Index: linux-2.6/arch/powerpc/kernel/rtas_pci.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/kernel/rtas_pci.c
> +++ linux-2.6/arch/powerpc/kernel/rtas_pci.c
> @@ -240,13 +240,6 @@ unsigned long __devinit get_phb_buid (st
>  
>  	if (ibm_read_pci_config == -1) return 0;
>  
> -	/* PHB's will always be children of the root node,
> -	 * or so it is promised by the current firmware. */
> -	if (phb->parent == NULL)
> -		return 0;
> -	if (phb->parent->parent)
> -		return 0;
> -
>  	buid_vals = (unsigned int *) get_property(phb, "reg", &len);
>  	if (buid_vals == NULL)
>  		return 0;
> @@ -297,17 +290,10 @@ unsigned long __init find_and_init_phbs(
>  	struct device_node *node;
>  	struct pci_controller *phb;
>  	unsigned int index;
> -	struct device_node *root = of_find_node_by_path("/");
>  
> +	node = NULL;
>  	index = 0;
> -	for (node = of_get_next_child(root, NULL);
> -	     node != NULL;
> -	     node = of_get_next_child(root, node)) {
> -
> -		if (node->type == NULL || (strcmp(node->type, "pci") != 0 &&
> -					   strcmp(node->type, "pciex") != 0))
> -			continue;
> -
> +	while ((node = of_find_phb_node(node))) {
>  		phb = pcibios_alloc_controller(node);
>  		if (!phb)
>  			continue;
> @@ -316,8 +302,6 @@ unsigned long __init find_and_init_phbs(
>  		pci_setup_phb_io(phb, index == 0);
>  		index++;
>  	}
> -
> -	of_node_put(root);
>  	pci_devs_phb_init();
>  
>  	/*
> Index: linux-2.6/include/asm-powerpc/prom.h
> ===================================================================
> --- linux-2.6.orig/include/asm-powerpc/prom.h
> +++ linux-2.6/include/asm-powerpc/prom.h
> @@ -131,6 +131,7 @@ extern struct device_node *of_find_compa
>  extern struct device_node *of_find_node_by_path(const char *path);
>  extern struct device_node *of_find_node_by_phandle(phandle handle);
>  extern struct device_node *of_find_all_nodes(struct device_node *prev);
> +extern struct device_node *of_find_phb_node(struct device_node *from);
>  extern struct device_node *of_get_parent(const struct device_node *node);
>  extern struct device_node *of_get_next_child(const struct device_node *node,
>  					     struct device_node *prev);
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
