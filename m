Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7A1667C94
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 18:02:51 +1000 (EST)
Subject: Re: [PATCH 3/7] [POWERPC] modify PCI code for a merged kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20060926133651.897ad602.sfr@canb.auug.org.au>
References: <20060926133413.8ca8142e.sfr@canb.auug.org.au>
	<20060926133548.43afd711.sfr@canb.auug.org.au>
	<20060926133651.897ad602.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 18:02:37 +1000
Message-Id: <1159948957.13323.80.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-09-26 at 13:36 +1000, Stephen Rothwell wrote:
> -#ifndef CONFIG_PPC_ISERIES
>  void __devinit pcibios_claim_one_bus(struct pci_bus *b)
>  {
>  	struct pci_dev *dev;
> @@ -238,10 +238,12 @@ static void __init pcibios_claim_of_setu
>  {
>  	struct pci_bus *b;
>  
> +	if (firmware_has_feature(FW_FEATURE_ISERIES))
> +		return;
> +
>  	list_for_each_entry(b, &pci_root_buses, node)
>  		pcibios_claim_one_bus(b);
>  }
> -#endif

Is the above actually needed ? That is, what kind of problem iseries
would expect if pcibios_claim_one_bus() was called ?

>  #ifdef CONFIG_PPC_MULTIPLATFORM
>  static u32 get_int_prop(struct device_node *np, const char *name, u32 def)
> @@ -554,9 +556,8 @@ static int __init pcibios_init(void)
>  	 */
>  	ppc_md.phys_mem_access_prot = pci_phys_mem_access_prot;
>  
> -#ifdef CONFIG_PPC_ISERIES
> -	iSeries_pcibios_init(); 
> -#endif
> +	if (firmware_has_feature(FW_FEATURE_ISERIES))
> +		iSeries_pcibios_init();

Why not do like all other platforms and allocate create the PHBs
setup_arch ? That would avoid an iSeries specific call in generic code.

>  	printk(KERN_DEBUG "PCI: Probing PCI hardware\n");
>  
> @@ -566,15 +567,15 @@ #endif
>  		pci_bus_add_devices(hose->bus);
>  	}
>  
> -#ifndef CONFIG_PPC_ISERIES
> -	if (pci_probe_only)
> -		pcibios_claim_of_setup();
> -	else
> -		/* FIXME: `else' will be removed when
> -		   pci_assign_unassigned_resources() is able to work
> -		   correctly with [partially] allocated PCI tree. */
> -		pci_assign_unassigned_resources();
> -#endif /* !CONFIG_PPC_ISERIES */
> +	if (!firmware_has_feature(FW_FEATURE_ISERIES)) {
> +		if (pci_probe_only)
> +			pcibios_claim_of_setup();
> +		else
> +			/* FIXME: `else' will be removed when
> +			   pci_assign_unassigned_resources() is able to work
> +			   correctly with [partially] allocated PCI tree. */
> +			pci_assign_unassigned_resources();
> +	}

What happens if you don't do the above and set pci_probe_only to 1 ?

>  	/* Call machine dependent final fixup */
>  	if (ppc_md.pcibios_fixup)
> @@ -586,8 +587,9 @@ #endif /* !CONFIG_PPC_ISERIES */
>  		printk(KERN_DEBUG "ISA bridge at %s\n", pci_name(ppc64_isabridge_dev));
>  
>  #ifdef CONFIG_PPC_MULTIPLATFORM
> -	/* map in PCI I/O space */
> -	phbs_remap_io();
> +	if (!firmware_has_feature(FW_FEATURE_ISERIES))
> +		/* map in PCI I/O space */
> +		phbs_remap_io();
>  #endif

IO space mapping is dodgy with iSeries... I suppose that is correct for
now though we might want to do something a bit nastier like actually
mapping it to unaccessible memory and SEGV'ing on access or stuff like
that if IO is really not supported....

>  	printk(KERN_DEBUG "PCI: Probing PCI hardware done\n");
> @@ -637,13 +639,13 @@ int pcibios_enable_device(struct pci_dev
>   */
>  int pci_domain_nr(struct pci_bus *bus)
>  {
> -#ifdef CONFIG_PPC_ISERIES
> -	return 0;
> -#else
> -	struct pci_controller *hose = pci_bus_to_host(bus);
> +	if (firmware_has_feature(FW_FEATURE_ISERIES))
> +		return 0;
> +	else {
> +		struct pci_controller *hose = pci_bus_to_host(bus);
>  
> -	return hose->global_number;
> -#endif
> +		return hose->global_number;
> +	}
>  }

Any reason why the above is useful at all ? Especially since it seems
you -can- have multiple busses and thus -want- the domain numbers to be
exposed.
 
>  EXPORT_SYMBOL(pci_domain_nr);
> @@ -651,12 +653,12 @@ EXPORT_SYMBOL(pci_domain_nr);
>  /* Decide whether to display the domain number in /proc */
>  int pci_proc_domain(struct pci_bus *bus)
>  {
> -#ifdef CONFIG_PPC_ISERIES
> -	return 0;
> -#else
> -	struct pci_controller *hose = pci_bus_to_host(bus);
> -	return hose->buid;
> -#endif
> +	if (firmware_has_feature(FW_FEATURE_ISERIES))
> +		return 0;
> +	else {
> +		struct pci_controller *hose = pci_bus_to_host(bus);
> +		return hose->buid;
> +	}
>  }

Same question. Why do that at all ?
 
Cheers,
Ben.
