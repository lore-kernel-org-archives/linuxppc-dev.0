Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cFlH2TZ9zF2Vj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 23:06:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Darren Stevens <darren@stevens-zone.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: chzigotzky@xenosoft.de
Subject: Re: [PATCH NEXT 1/4] powerpc/pasemi: Add PCI initialisation for Nemo
 board.
In-Reply-To: <4b3d1ee02c7.3de0aa2c@auth.smtp.1and1.co.uk>
References: <4b3d1ee02c7.3de0aa2c@auth.smtp.1and1.co.uk>
Date: Thu, 03 May 2018 23:06:17 +1000
Message-ID: <87k1skanxy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Darren,

Thanks for the patch, sorry it's taken so long to get merged.

Darren Stevens <darren@stevens-zone.net> writes:
>     The A-Eon Amigaone X1000's Nemo motherboard has an AMD SB600
>     connected to one of the PCI-e root ports on its PaSemi
>     Pwrficient 1628M SoC. Normally the SB600 southbridge would be
>     connected to a hidden PCI-e port on the system's northbridge,
>     and as a result doesn't fully comply with the PCI-e spec.
>     
>     Add code to relax the PCI-e detection in both the root port
>     and the Linux kernel allowing on board devices to be detected.
>     
>     Signed-off-by: Darren Stevens <Darren@stevens-zone.net>

This should not be indented.

> diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
> index 329d2a6..8900dee 100644
> --- a/arch/powerpc/platforms/pasemi/pasemi.h
> +++ b/arch/powerpc/platforms/pasemi/pasemi.h
> @@ -3,6 +3,9 @@
>  #define _PASEMI_PASEMI_H
>  
>  extern unsigned long pas_get_boot_time(void);
> +#ifdef CONFIG_PPC_PASEMI_NEMO
> +extern void nemo_pci_init(void);
> +#endif

We don't need an #ifdef around this thanks.

> diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
> index 5ff6108..cb0ac87 100644
> --- a/arch/powerpc/platforms/pasemi/pci.c
> +++ b/arch/powerpc/platforms/pasemi/pci.c
> @@ -108,6 +109,92 @@ static int workaround_5945(struct pci_bus *bus, unsigned int devfn,
>  	return 1;
>  }
>  
> +#ifdef CONFIG_PPC_PASEMI_NEMO
> +static int sb600_bus = 5;

That's only used once so could just be a #define, or even a literal in
the code.

> +static void __iomem *iob_mapbase = NULL;

That's only used in sb6000_set_flag() so should be in there shouldn't it?

> +static void sb600_set_flag(int bus)
> +{
> +	struct resource res;
> +	struct device_node *dn;
> +	int err;
> +
> +	if (iob_mapbase == NULL) {
> +		dn = of_find_compatible_node(NULL, "isa", "pasemi,1682m-iob");
> +		if (!dn) {
> +			printk(KERN_CRIT "NEMO SB600 missing iob node\n");

I'm not sure CRIT is really necessary, we tend to use ERR, but I don't
mind that much.

But can you use pr_err()/pr_crit() please.

> +			return;
> +		}
> +
> +		err = of_address_to_resource(dn, 0, &res);
> +		of_node_put(dn);
> +
> +		if (err) {
> +			printk(KERN_CRIT "NEMO SB600 missing resource\n");
> +			return;
> +		}
> +
> +		printk(KERN_CRIT "NEMO SB600 IOB base %08lx\n",res.start);

That's INFO or even DEBUG.

> +
> +		iob_mapbase = ioremap(res.start + 0x100, 0x94);

0x94 ?

It's going to map you at least one page anyway.

> +	}
> +
> +	if (iob_mapbase != NULL) {
> +		if (bus == sb600_bus) {
> +			/*
> +			 * This is the SB600's bus, tell the PCI-e root port
> +			 * to allow non-zero devices to enumerate.
> +			 */
> +			out_le32(iob_mapbase + 4, in_le32(iob_mapbase + 4) | 0x800);

Does reg #4 have a name?
Or 0x800 ?

> +		} else {
> +			/*
> +			 * Only scan device 0 on other busses
> +			 */
> +			out_le32(iob_mapbase + 4, in_le32(iob_mapbase + 4) & ~0x800);
> +		}
> +	}
> +}
> +
> +static int nemo_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
> +			      int offset, int len, u32 *val)
> +{
> +	struct pci_controller *hose;

Can we call them host or controller or something in new code?

> +	void volatile __iomem *addr;

Does that need to be volatile?

> +	hose = pci_bus_to_host(bus);
> +	if (!hose)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	if (!pa_pxp_offset_valid(bus->number, devfn, offset))
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +	if (workaround_5945(bus, devfn, offset, len, val))
> +		return PCIBIOS_SUCCESSFUL;
> +
> +	addr = pa_pxp_cfg_addr(hose, bus->number, devfn, offset);
> +
> +	sb600_set_flag(bus->number);
> +
> +	/*
> +	 * Note: the caller has already checked that offset is
> +	 * suitably aligned and that len is 1, 2 or 4.
> +	 */
> +	switch (len) {
> +	case 1:
> +		*val = in_8(addr);
> +		break;
> +	case 2:
> +		*val = in_le16(addr);
> +		break;
> +	default:
> +		*val = in_le32(addr);
> +		break;
> +	}
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +#endif
> +
>  static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
>  			      int offset, int len, u32 *val)
>  {
> @@ -178,6 +265,20 @@ static int pa_pxp_write_config(struct pci_bus *bus, unsigned int devfn,
>  	return PCIBIOS_SUCCESSFUL;
>  }
>  
> +#ifdef CONFIG_PPC_PASEMI_NEMO
> +static struct pci_ops nemo_pxp_ops = {
> +	.read = nemo_pxp_read_config,
> +	.write = pa_pxp_write_config,
> +};
> +
> +static void __init setup_nemo_pxp(struct pci_controller *hose)
> +{
> +	hose->ops = &nemo_pxp_ops;
> +	hose->cfg_data = ioremap(0xe0000000, 0x10000000);
> +}

Could these go in one of the ifdef block below? Just to reduce the
number of times we ifdef NEMO.
> @@ -213,6 +343,28 @@ static int __init pas_add_bridge(struct device_node *dev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PPC_PASEMI_NEMO
> +void __init nemo_pci_init(void)
> +{
> +	struct device_node *np, *root;
> +
> +	root = of_find_node_by_path("/");
> +	if (!root) {
> +		printk(KERN_CRIT "pas_pci_init: can't find root "
> +			"of device tree\n");

TBH that can't really happen, or if it does we're not going to boot
elsewhere.

So the printk() is probably overkill.

> +		return;
> +	}
> +
> +	pci_set_flags(PCI_SCAN_ALL_PCIE_DEVS);
> +
> +	for (np = NULL; (np = of_get_next_child(root, np)) != NULL;)

Does the pxp node not have a compatible property? (I may have asked that
before).

Normally you'd search by compatible, not name.

If you have to search by name then of_get_child_by_name() should work.

> +		if (np->name && !strcmp(np->name, "pxp") && !nemo_add_bridge(np))
> +			of_node_get(np);

Why are we of_node_get()'ing here?

If nemo_add_bridge() wants to keep a reference it should do that itself.

> +
> +	of_node_put(root);
> +}
> +#endif
> +
>  void __init pas_pci_init(void)
>  {
>  	struct device_node *np, *root;


cheers
