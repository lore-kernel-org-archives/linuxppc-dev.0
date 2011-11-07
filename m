Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D3AB61007D4
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Nov 2011 16:01:51 +1100 (EST)
Message-ID: <1320642102.2779.13.camel@pasglop>
Subject: Re: [PATCH 2/5] powerpc/pci: Change how re-assigning resouces work
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Mon, 07 Nov 2011 16:01:42 +1100
In-Reply-To: <1320641761-4028-2-git-send-email-benh@kernel.crashing.org>
References: <1320641761-4028-1-git-send-email-benh@kernel.crashing.org>
 <1320641761-4028-2-git-send-email-benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-11-07 at 15:55 +1100, Benjamin Herrenschmidt wrote:
> When PCI_REASSIGN_ALL_RSRC is set, we used to clear all bus resources
> at the beginning of survey and re-allocate them later.
> 
> This changes it so instead, during early fixup, we mark all resources
> as IORESOURCE_UNSET and move them down to be 0-based.
> 
> Later, if bus resources are still unset at the beginning of the survey,
> then we clear them.
> 
> This shouldn't impact the re-assignment case on 4xx, but will enable
> us to have the platform do some custom resource assignment before the
> survey, by clearing individual resources IORESOURCE_UNSET bit.
> 
> Also limits the clutter in the kernel log from fixup when re-assigning
> since we don't care about the offset applied to the BAR values in this
> case.

Hi guys !

This one could be invasive to FSL and 4xx if you use
PCI_REASSIGN_ALL_RSRC. I very much want to merge it for 3.3, so any
chance you can give it a beating and see if everything is still
allright ?

Cheers,
Ben.

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/pci-common.c |   66 ++++++++++++++++++++-----------------
>  1 files changed, 36 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 855969f..d34ba7e 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -920,18 +920,22 @@ static void __devinit pcibios_fixup_resources(struct pci_dev *dev)
>  		struct resource *res = dev->resource + i;
>  		if (!res->flags)
>  			continue;
> -		/* On platforms that have PCI_PROBE_ONLY set, we don't
> -		 * consider 0 as an unassigned BAR value. It's technically
> -		 * a valid value, but linux doesn't like it... so when we can
> -		 * re-assign things, we do so, but if we can't, we keep it
> -		 * around and hope for the best...
> +
> +		/* If we're going to re-assign everything, we mark all resources
> +		 * as unset (and 0-base them). In addition, we mark BARs starting
> +		 * at 0 as unset as well, except if PCI_PROBE_ONLY is also set
> +		 * since in that case, we don't want to re-assign anything
>  		 */
> -		if (res->start == 0 && !pci_has_flag(PCI_PROBE_ONLY)) {
> -			pr_debug("PCI:%s Resource %d %016llx-%016llx [%x] is unassigned\n",
> -				 pci_name(dev), i,
> -				 (unsigned long long)res->start,
> -				 (unsigned long long)res->end,
> -				 (unsigned int)res->flags);
> +		if (pci_has_flag(PCI_REASSIGN_ALL_RSRC) ||
> +		    (res->start == 0 && !pci_has_flag(PCI_PROBE_ONLY))) {
> +			/* Only print message if not re-assigning */
> +			if (!pci_has_flag(PCI_REASSIGN_ALL_RSRC))
> +				pr_debug("PCI:%s Resource %d %016llx-%016llx [%x] "
> +					 "is unassigned\n",
> +					 pci_name(dev), i,
> +					 (unsigned long long)res->start,
> +					 (unsigned long long)res->end,
> +					 (unsigned int)res->flags);
>  			res->end -= res->start;
>  			res->start = 0;
>  			res->flags |= IORESOURCE_UNSET;
> @@ -1041,6 +1045,16 @@ static void __devinit pcibios_fixup_bridge(struct pci_bus *bus)
>  		if (i >= 3 && bus->self->transparent)
>  			continue;
>  
> +		/* If we are going to re-assign everything, mark the resource
> +		 * as unset and move it down to 0
> +		 */
> +		if (pci_has_flag(PCI_REASSIGN_ALL_RSRC)) {
> +			res->flags |= IORESOURCE_UNSET;
> +			res->end -= res->start;
> +			res->start = 0;
> +			continue;
> +		}
> +
>  		pr_debug("PCI:%s Bus rsrc %d %016llx-%016llx [%x] fixup...\n",
>  			 pci_name(dev), i,
>  			 (unsigned long long)res->start,\
> @@ -1261,18 +1275,15 @@ void pcibios_allocate_bus_resources(struct pci_bus *bus)
>  	pci_bus_for_each_resource(bus, res, i) {
>  		if (!res || !res->flags || res->start > res->end || res->parent)
>  			continue;
> +
> +		/* If the resource was left unset at this point, we clear it */
> +		if (res->flags & IORESOURCE_UNSET)
> +			goto clear_resource;
> +
>  		if (bus->parent == NULL)
>  			pr = (res->flags & IORESOURCE_IO) ?
>  				&ioport_resource : &iomem_resource;
>  		else {
> -			/* Don't bother with non-root busses when
> -			 * re-assigning all resources. We clear the
> -			 * resource flags as if they were colliding
> -			 * and as such ensure proper re-allocation
> -			 * later.
> -			 */
> -			if (pci_has_flag(PCI_REASSIGN_ALL_RSRC))
> -				goto clear_resource;
>  			pr = pci_find_parent_resource(bus->self, res);
>  			if (pr == res) {
>  				/* this happens when the generic PCI
> @@ -1303,9 +1314,9 @@ void pcibios_allocate_bus_resources(struct pci_bus *bus)
>  			if (reparent_resources(pr, res) == 0)
>  				continue;
>  		}
> -		printk(KERN_WARNING "PCI: Cannot allocate resource region "
> -		       "%d of PCI bridge %d, will remap\n", i, bus->number);
> -clear_resource:
> +		pr_warning("PCI: Cannot allocate resource region "
> +			   "%d of PCI bridge %d, will remap\n", i, bus->number);
> +	clear_resource:
>  		res->start = res->end = 0;
>  		res->flags = 0;
>  	}
> @@ -1450,16 +1461,11 @@ void __init pcibios_resource_survey(void)
>  {
>  	struct pci_bus *b;
>  
> -	/* Allocate and assign resources. If we re-assign everything, then
> -	 * we skip the allocate phase
> -	 */
> +	/* Allocate and assign resources */
>  	list_for_each_entry(b, &pci_root_buses, node)
>  		pcibios_allocate_bus_resources(b);
> -
> -	if (!pci_has_flag(PCI_REASSIGN_ALL_RSRC)) {
> -		pcibios_allocate_resources(0);
> -		pcibios_allocate_resources(1);
> -	}
> +	pcibios_allocate_resources(0);
> +	pcibios_allocate_resources(1);
>  
>  	/* Before we start assigning unassigned resource, we try to reserve
>  	 * the low IO area and the VGA memory area if they intersect the
