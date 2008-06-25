Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D0C8DE19F
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 03:17:35 +1000 (EST)
Message-Id: <EC00E92B-9156-41B3-B85E-9D50E0227999@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: John Rigby <jrigby@freescale.com>
In-Reply-To: <1214342672-23536-7-git-send-email-jrigby@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 6/8][Version 2] powerpc: Move mpc83xx_add_bridge to
	fsl_pci.c
Date: Wed, 25 Jun 2008 12:17:25 -0500
References: <1214342672-23536-1-git-send-email-jrigby@freescale.com>
	<1214342672-23536-2-git-send-email-jrigby@freescale.com>
	<1214342672-23536-3-git-send-email-jrigby@freescale.com>
	<1214342672-23536-4-git-send-email-jrigby@freescale.com>
	<1214342672-23536-5-git-send-email-jrigby@freescale.com>
	<1214342672-23536-6-git-send-email-jrigby@freescale.com>
	<1214342672-23536-7-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 24, 2008, at 4:24 PM, John Rigby wrote:

> This allows other platforms with the same pci
> block like MPC5121 to use it.
>
> Signed-off-by: John Rigby <jrigby@freescale.com>
> ---

Can you break the PCI patches out into their own patch set.
>
> arch/powerpc/platforms/83xx/Kconfig       |    2 +-
> arch/powerpc/platforms/83xx/Makefile      |    1 -
> arch/powerpc/platforms/83xx/mpc831x_rdb.c |    1 +
> arch/powerpc/platforms/83xx/mpc832x_mds.c |    1 +
> arch/powerpc/platforms/83xx/mpc832x_rdb.c |    1 +
> arch/powerpc/platforms/83xx/mpc834x_itx.c |    1 +
> arch/powerpc/platforms/83xx/mpc834x_mds.c |    1 +
> arch/powerpc/platforms/83xx/mpc836x_mds.c |    1 +
> arch/powerpc/platforms/83xx/mpc837x_mds.c |    1 +
> arch/powerpc/platforms/83xx/mpc837x_rdb.c |    1 +
> arch/powerpc/platforms/83xx/mpc83xx.h     |    1 -
> arch/powerpc/platforms/83xx/pci.c         |   91  
> -----------------------------
> arch/powerpc/platforms/83xx/sbc834x.c     |    1 +
> arch/powerpc/sysdev/fsl_pci.c             |   61 +++++++++++++++++++
> arch/powerpc/sysdev/fsl_pci.h             |    1 +
> 15 files changed, 72 insertions(+), 94 deletions(-)
> delete mode 100644 arch/powerpc/platforms/83xx/pci.c
>

>
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/ 
> fsl_pci.c
> index 489ca5a..6e6688f 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -27,6 +27,7 @@
> #include <sysdev/fsl_soc.h>
> #include <sysdev/fsl_pci.h>
>
> +#if defined(PPC_85xx) || defined(PPC_86xx)

this is wrong.  you are missing CONFIG_

>
> /* atmu setup for fsl pci/pcie controller */
> void __init setup_pci_atmu(struct pci_controller *hose, struct  
> resource *rsrc)
> {
> @@ -246,3 +247,63 @@ DECLARE_PCI_FIXUP_HEADER(0x1957,  
> PCI_DEVICE_ID_MPC8572, quirk_fsl_pcie_header);
> DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8641,  
> quirk_fsl_pcie_header);
> DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8641D,  
> quirk_fsl_pcie_header);
> DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8610,  
> quirk_fsl_pcie_header);
> +#endif /* CONFIG_PPC_85xx || CONFIG_PPC_86xx */
> +
> +#if defined(CONFIG_PPC_83xx)
> +int __init mpc83xx_add_bridge(struct device_node *dev)
> +{
> +	int len;
> +	struct pci_controller *hose;
> +	struct resource rsrc;
> +	const int *bus_range;
> +	int primary = 1, has_address = 0;
> +	phys_addr_t immr = get_immrbase();
> +
> +	pr_debug("Adding PCI host bridge %s\n", dev->full_name);
> +
> +	/* Fetch host bridge registers address */
> +	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
> +
> +	/* Get bus range if any */
> +	bus_range = of_get_property(dev, "bus-range", &len);
> +	if (bus_range == NULL || len < 2 * sizeof(int)) {
> +		printk(KERN_WARNING "Can't get bus-range for %s, assume"
> +		       " bus 0\n", dev->full_name);
> +	}
> +
> +	ppc_pci_flags |= PPC_PCI_REASSIGN_ALL_BUS;
> +	hose = pcibios_alloc_controller(dev);
> +	if (!hose)
> +		return -ENOMEM;
> +
> +	hose->first_busno = bus_range ? bus_range[0] : 0;
> +	hose->last_busno = bus_range ? bus_range[1] : 0xff;
> +
> +	/* MPC83xx supports up to two host controllers one at 0x8500 from  
> immrbar
> +	 * the other at 0x8600, we consider the 0x8500 the primary  
> controller
> +	 */
> +	/* PCI 1 */
> +	if ((rsrc.start & 0xfffff) == 0x8500) {
> +		setup_indirect_pci(hose, immr + 0x8300, immr + 0x8304, 0);
> +	}
> +	/* PCI 2 */
> +	if ((rsrc.start & 0xfffff) == 0x8600) {
> +		setup_indirect_pci(hose, immr + 0x8380, immr + 0x8384, 0);
> +		primary = 0;
> +	}
> +
> +	printk(KERN_INFO "Found MPC83xx PCI host bridge at 0x%016llx. "
> +	       "Firmware bus number: %d->%d\n",
> +	       (unsigned long long)rsrc.start, hose->first_busno,
> +	       hose->last_busno);
> +
> +	pr_debug(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
> +	    hose, hose->cfg_addr, hose->cfg_data);
> +
> +	/* Interpret the "ranges" property */
> +	/* This also maps the I/O region and sets isa_io/mem_base */
> +	pci_process_bridge_OF_ranges(hose, dev, primary);
> +
> +	return 0;
> +}
> +#endif /* CONFIG_PPC_83xx */
> diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/ 
> fsl_pci.h
> index 37b04ad..13f30c2 100644
> --- a/arch/powerpc/sysdev/fsl_pci.h
> +++ b/arch/powerpc/sysdev/fsl_pci.h
> @@ -83,6 +83,7 @@ struct ccsr_pci {
>
> extern int fsl_add_bridge(struct device_node *dev, int is_primary);
> extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
> +extern int mpc83xx_add_bridge(struct device_node *dev);
>
> #endif /* __POWERPC_FSL_PCI_H */
> #endif /* __KERNEL__ */
> -- 
> 1.5.6.rc0.46.gd2b3
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
