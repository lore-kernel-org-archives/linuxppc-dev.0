Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CFD6EDDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Dec 2008 05:11:53 +1100 (EST)
Message-Id: <DE5232AE-281E-4A6E-9844-A69DF7C90034@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081229164038.GC8215@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 3/4] powerpc/fsl_pci: Add MPC83xx PCI-E controller RC mode
	support
Date: Mon, 29 Dec 2008 12:09:38 -0600
References: <20081229164038.GC8215@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Tony Li <tony.li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 29, 2008, at 10:40 AM, Anton Vorontsov wrote:

> This patch adds support for PCI-Express controllers as found on the
> newer MPC83xx chips.
>
> The work is losely based on the Tony Li's patch[1], but unlike the
> original patch, this patch implements sliding window for the Type 1
> configuration transactions, so we don't have to ioremap the whole
> PCI-E configuration space.
>
> Since we have to remap the config space in the atomic context, and
> as ioremap() function might sleep, we use the fixmap API. With fixmap
> we can map the page-sized areas in the atomic context. The approch
> is similar to the x86 implementation (arch/x86/pci/mmconfig_32.c).
>
> [1] http://ozlabs.org/pipermail/linuxppc-dev/2008-January/049028.html

thanks for looking at cleaning this up.  Have you looked at moving the  
outbound window as well?  Its not a critical issue but something I was  
thinking about.
>
>
> Signed-off-by: Tony Li <tony.li@freescale.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/include/asm/fixmap.h     |    4 +
> arch/powerpc/include/asm/pci-bridge.h |    1 +
> arch/powerpc/sysdev/fsl_pci.c         |  200 ++++++++++++++++++++++++ 
> ++++++++-
> include/linux/pci_ids.h               |    8 ++
> 4 files changed, 209 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/ 
> include/asm/fixmap.h
> index 8428b38..982b738 100644
> --- a/arch/powerpc/include/asm/fixmap.h
> +++ b/arch/powerpc/include/asm/fixmap.h
> @@ -48,6 +48,10 @@ enum fixed_addresses {
> 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
> 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
> #endif
> +#if (defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)) && \
> +		defined(CONFIG_PCI)
> +	FIX_MPC83XX_PCIE_CFG,
> +#endif

Just use FIX_PCIE_MCFG that was the purpose and no big reason to ifdef  
this.

>
> 	/* FIX_PCIE_MCFG, */
> 	__end_of_fixed_addresses
> };
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/ 
> include/asm/pci-bridge.h
> index 84007af..b4a9e68 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -132,6 +132,7 @@ struct pci_controller {
> #define PPC_INDIRECT_TYPE_NO_PCIE_LINK		0x00000008
> #define PPC_INDIRECT_TYPE_BIG_ENDIAN		0x00000010
> #define PPC_INDIRECT_TYPE_BROKEN_MRM		0x00000020
> +#define PPC_INDIRECT_TYPE_MPC83XX_PCIE		0x00000040
> 	u32 indirect_type;
> #endif	/* !CONFIG_PPC64 */
> 	/* Currently, we limit ourselves to 1 IO range and 3 mem
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/ 
> fsl_pci.c
> index f611d03..2b6c341 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -1,12 +1,16 @@
> /*
>  * MPC83xx/85xx/86xx PCI/PCIE support routing.
>  *
> - * Copyright 2007,2008 Freescale Semiconductor, Inc
> + * Copyright 2007-2009 Freescale Semiconductor, Inc.
> + * Copyright 2008-2009 MontaVista Software, Inc.
>  *
>  * Initial author: Xianghua Xiao <x.xiao@freescale.com>
>  * Recode: ZHANG WEI <wei.zhang@freescale.com>
>  * Rewrite the routing for Frescale PCI and PCI Express
>  * 	Roy Zang <tie-fei.zang@freescale.com>
> + * MPC83xx PCI-Express support:
> + * 	Tony Li <tony.li@freescale.com>
> + * 	Anton Vorontsov <avorontsov@ru.mvista.com>
>  *
>  * This program is free software; you can redistribute  it and/or  
> modify it
>  * under  the terms of  the GNU General  Public License as published  
> by the
> @@ -24,10 +28,10 @@
> #include <asm/prom.h>
> #include <asm/pci-bridge.h>
> #include <asm/machdep.h>
> +#include <asm/fixmap.h>
> #include <sysdev/fsl_soc.h>
> #include <sysdev/fsl_pci.h>
>
> -#if defined(CONFIG_PPC_85xx) || defined(CONFIG_PPC_86xx)
> /* atmu setup for fsl pci/pcie controller */
> static void __init setup_pci_atmu(struct pci_controller *hose,
> 				  struct resource *rsrc)
> @@ -228,6 +232,14 @@ int __init fsl_add_bridge(struct device_node  
> *dev, int is_primary)
> 	return 0;
> }
>
> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8314E,  
> quirk_fsl_pcie_header);
> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8314,  
> quirk_fsl_pcie_header);
> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8315E,  
> quirk_fsl_pcie_header);
> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8315,  
> quirk_fsl_pcie_header);
> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8377E,  
> quirk_fsl_pcie_header);
> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8377,  
> quirk_fsl_pcie_header);
> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8378E,  
> quirk_fsl_pcie_header);
> +DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8378,  
> quirk_fsl_pcie_header);
> DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8548E,  
> quirk_fsl_pcie_header);
> DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8548,  
> quirk_fsl_pcie_header);
> DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8543E,  
> quirk_fsl_pcie_header);
> @@ -250,9 +262,173 @@ DECLARE_PCI_FIXUP_HEADER(0x1957,  
> PCI_DEVICE_ID_MPC8536, quirk_fsl_pcie_header);
> DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8641,  
> quirk_fsl_pcie_header);
> DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8641D,  
> quirk_fsl_pcie_header);
> DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8610,  
> quirk_fsl_pcie_header);
> -#endif /* CONFIG_PPC_85xx || CONFIG_PPC_86xx */
>
> #if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)
> +struct mpc83xx_pcie {
> +	struct resource cfg_res;
> +	void __iomem *cfg_map;
> +	int mapped_bus;
> +	unsigned int mapped_devfn;
> +};
> +
> +/*
> + * With the convention of u-boot, the PCIE outbound window 0 serves
> + * as configuration transactions outbound.
> + */
> +#define PEX_OUTWIN0_TAL		0xCA8
> +#define PEX_OUTWIN0_TAH		0xCAC
> +
> +static int mpc83xx_pcie_exclude_device(struct pci_bus *bus,  
> unsigned int devfn)
> +{
> +	struct pci_controller *hose = bus->sysdata;
> +
> +	if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	/*
> +	 * Workaround for the HW bug: for Type 0 configure transactions the
> +	 * PCI-E controller does not check the device number bits and just
> +	 * assumes that the device number bits are 0.
> +	 */
> +	if (hose->indirect_type & PPC_INDIRECT_TYPE_MPC83XX_PCIE) {
> +		if (bus->number == hose->first_busno ||
> +				bus->primary == hose->first_busno) {
> +			if (devfn & 0xf8)
> +				return PCIBIOS_DEVICE_NOT_FOUND;
> +		}
> +	}
> +
> +	if (ppc_md.pci_exclude_device) {
> +		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static void __iomem *mpc83xx_pcie_remap_cfg(struct pci_bus *bus,
> +					    unsigned int devfn, int offset)
> +{
> +	struct pci_controller *hose = bus->sysdata;
> +	struct mpc83xx_pcie *pcie = hose->dn->data;
> +	u32 bus_no = bus->number - hose->first_busno;
> +	int ret;
> +
> +	ret = mpc83xx_pcie_exclude_device(bus, devfn);
> +	if (ret)
> +		return NULL;
> +
> +	offset &= 0xfff;
> +
> +	if (hose->indirect_type & PPC_INDIRECT_TYPE_MPC83XX_PCIE) {
> +		/* Type 0 */
> +		if (bus->number == hose->first_busno)
> +			return hose->cfg_data + offset;
> +	}
> +
> +	if (pcie->mapped_bus == bus_no && pcie->mapped_devfn == devfn)
> +		goto mapped;
> +
> +	clear_fixmap(FIX_MPC83XX_PCIE_CFG);
> +	set_fixmap_nocache(FIX_MPC83XX_PCIE_CFG,
> +			   pcie->cfg_res.start + (devfn << 16));
> +
> +	out_le32(hose->cfg_data + PEX_OUTWIN0_TAL, bus_no);
> +	out_le32(hose->cfg_data + PEX_OUTWIN0_TAH, 0);
> +
> +	pcie->mapped_devfn = devfn;
> +	pcie->mapped_bus = bus_no;
> +mapped:
> +	return pcie->cfg_map + offset;
> +}
> +
> +static int mpc83xx_pcie_read_config(struct pci_bus *bus, unsigned  
> int devfn,
> +				    int offset, int len, u32 *val)
> +{
> +	void __iomem *cfg_addr;
> +
> +	cfg_addr = mpc83xx_pcie_remap_cfg(bus, devfn, offset);
> +	if (!cfg_addr)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	switch (len) {
> +	case 1:
> +		*val = in_8(cfg_addr);
> +		break;
> +	case 2:
> +		*val = in_le16(cfg_addr);
> +		break;
> +	default:
> +		*val = in_le32(cfg_addr);
> +		break;
> +	}
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int mpc83xx_pcie_write_config(struct pci_bus *bus, unsigned  
> int devfn,
> +				     int offset, int len, u32 val)
> +{
> +	void __iomem *cfg_addr;
> +
> +	cfg_addr = mpc83xx_pcie_remap_cfg(bus, devfn, offset);
> +	if (!cfg_addr)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	switch (len) {
> +	case 1:
> +		out_8(cfg_addr, val);
> +		break;
> +	case 2:
> +		out_le16(cfg_addr, val);
> +		break;
> +	default:
> +		out_le32(cfg_addr, val);
> +		break;
> +	}
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static struct pci_ops mpc83xx_pcie_ops = {
> +	mpc83xx_pcie_read_config,
> +	mpc83xx_pcie_write_config,
> +};
> +
> +static int __init mpc83xx_pcie_setup(struct pci_controller *hose,
> +				     struct resource *reg,
> +				     struct resource *cfg)
> +{
> +	struct mpc83xx_pcie *pcie;
> +
> +	pcie = zalloc_maybe_bootmem(sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pcie->cfg_res = *cfg;
> +	pcie->cfg_map = (void __iomem *)fix_to_virt(FIX_MPC83XX_PCIE_CFG);
> +	pcie->mapped_devfn = ~0;
> +	pcie->mapped_bus = ~0;
> +
> +	WARN_ON(hose->dn->data);
> +	hose->dn->data = pcie;
> +
> +	hose->cfg_data = ioremap(reg->start, resource_size(reg));
> +	if (!hose->cfg_data)
> +		goto err;
> +
> +	hose->indirect_type |= PPC_INDIRECT_TYPE_MPC83XX_PCIE;
> +	hose->ops = &mpc83xx_pcie_ops;
> +
> +	if (fsl_pcie_check_link(hose))
> +		hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
> +
> +	return 0;
> +err:
> +	kfree(pcie);
> +	return -ENOMEM;
> +
> +}
> +
> int __init mpc83xx_add_bridge(struct device_node *dev)
> {
> 	int len;
> @@ -262,6 +438,10 @@ int __init mpc83xx_add_bridge(struct  
> device_node *dev)
> 	const int *bus_range;
> 	int primary;
>
> +	if (!of_device_is_available(dev)) {
> +		pr_warning("%s: disabled by the firmware.\n", dev->full_name);
> +		return -ENODEV;
> +	}
> 	pr_debug("Adding PCI host bridge %s\n", dev->full_name);
>
> 	/* Fetch host bridge registers address */
> @@ -309,7 +489,16 @@ int __init mpc83xx_add_bridge(struct  
> device_node *dev)
> 	hose->first_busno = bus_range ? bus_range[0] : 0;
> 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
>
> -	setup_indirect_pci(hose, rsrc_cfg.start, rsrc_cfg.start + 4, 0);
> +	if (of_device_is_compatible(dev, "fsl,mpc8314-pcie")) {
> +		int ret;
> +
> +		ret = mpc83xx_pcie_setup(hose, &rsrc_reg, &rsrc_cfg);
> +		if (ret)
> +			goto err;
> +	} else {
> +		setup_indirect_pci(hose, rsrc_cfg.start,
> +				   rsrc_cfg.start + 4, 0);
> +	}
>
> 	printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx. "
> 	       "Firmware bus number: %d->%d\n",
> @@ -324,5 +513,8 @@ int __init mpc83xx_add_bridge(struct device_node  
> *dev)
> 	pci_process_bridge_OF_ranges(hose, dev, primary);
>
> 	return 0;
> +err:
> +	pcibios_free_controller(hose);
> +	return -ENOMEM;
> }
> #endif /* CONFIG_PPC_83xx */
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 1800f1d..b30e28f 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2209,6 +2209,14 @@
> #define PCI_DEVICE_ID_TDI_EHCI          0x0101
>
> #define PCI_VENDOR_ID_FREESCALE		0x1957
> +#define PCI_DEVICE_ID_MPC8315E		0x00b4
> +#define PCI_DEVICE_ID_MPC8315		0x00b5
> +#define PCI_DEVICE_ID_MPC8314E		0x00b6
> +#define PCI_DEVICE_ID_MPC8314		0x00b7
> +#define PCI_DEVICE_ID_MPC8378E		0x00c4
> +#define PCI_DEVICE_ID_MPC8378		0x00c5
> +#define PCI_DEVICE_ID_MPC8377E		0x00c6
> +#define PCI_DEVICE_ID_MPC8377		0x00c7

Please make sure these get added to http://pci-ids.ucw.cz/
>
> #define PCI_DEVICE_ID_MPC8548E		0x0012
> #define PCI_DEVICE_ID_MPC8548		0x0013
> #define PCI_DEVICE_ID_MPC8543E		0x0014
> -- 
> 1.5.6.5
