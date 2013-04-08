Return-Path: <imr@rtschenk.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 76A082C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2013 18:21:06 +1000 (EST)
From: Rojhalat Ibrahim <imr@rtschenk.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC][PATCH 1/2] powerpc/fsl-pci: Keep PCI SoC controller
 registers in
Date: Mon, 08 Apr 2013 10:20:50 +0200
Message-ID: <5358275.FTQmJ7Es6N@pcimr>
In-Reply-To: <1363201636-7318-1-git-send-email-galak@kernel.crashing.org>
References: <1363201636-7318-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 13 March 2013 14:07:15 Kumar Gala wrote:
> Move to keeping the SoC registers that control and config the PCI
> controllers on FSL SoCs in the pci_controller struct.  This allows us to
> not need to ioremap() the registers in multiple different places that
> use them.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Rojhalat Ibrahim <imr@rtschenk.de>


> ---
>  arch/powerpc/include/asm/pci-bridge.h |    5 ++-
>  arch/powerpc/sysdev/fsl_pci.c         |   69
> ++++++++++++++------------------- 2 files changed, 34 insertions(+), 40
> deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pci-bridge.h
> b/arch/powerpc/include/asm/pci-bridge.h index 025a130..c0278f0 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -70,6 +70,8 @@ struct pci_controller {
>  	 *  BIG_ENDIAN - cfg_addr is a big endian register
>  	 *  BROKEN_MRM - the 440EPx/GRx chips have an errata that causes hangs on
>  	 *   the PLB4.  Effectively disable MRM commands by setting this.
> +	 *  FSL_CFG_REG_LINK - Freescale controller version in which the PCIe
> +	 *   link status is in a RC PCIe cfg register (vs being a SoC register)
>  	 */
>  #define PPC_INDIRECT_TYPE_SET_CFG_TYPE		0x00000001
>  #define PPC_INDIRECT_TYPE_EXT_REG		0x00000002
> @@ -77,6 +79,7 @@ struct pci_controller {
>  #define PPC_INDIRECT_TYPE_NO_PCIE_LINK		0x00000008
>  #define PPC_INDIRECT_TYPE_BIG_ENDIAN		0x00000010
>  #define PPC_INDIRECT_TYPE_BROKEN_MRM		0x00000020
> +#define PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK	0x00000040
>  	u32 indirect_type;
>  	/* Currently, we limit ourselves to 1 IO range and 3 mem
>  	 * ranges since the common pci_bus structure can't handle more
> @@ -90,9 +93,9 @@ struct pci_controller {
> 
>  #ifdef CONFIG_PPC64
>  	unsigned long buid;
> +#endif	/* CONFIG_PPC64 */
> 
>  	void *private_data;
> -#endif	/* CONFIG_PPC64 */
>  };
> 
>  /* These are used for config access before all the PCI probing
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 3271177..41bbcc4 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -54,34 +54,22 @@ static void quirk_fsl_pcie_header(struct pci_dev *dev)
>  	return;
>  }
> 
> -static int __init fsl_pcie_check_link(struct pci_controller *hose,
> -				  struct resource *rsrc)
> +static int __init fsl_pcie_check_link(struct pci_controller *hose)
>  {
> -	struct ccsr_pci __iomem *pci = NULL;
>  	u32 val;
> 
> -	/* for PCIe IP rev 3.0 or greater use CSR0 for link state */
> -	if (rsrc) {
> -		pr_debug("PCI memory map start 0x%016llx, size 0x%016llx\n",
> -		    (u64)rsrc->start, (u64)rsrc->end - (u64)rsrc->start + 1);
> -		pci = ioremap(rsrc->start, rsrc->end - rsrc->start + 1);
> -		if (!pci) {
> -			dev_err(hose->parent, "Unable to map PCIe registers\n");
> -			return -ENOMEM;
> -		}
> -		if (in_be32(&pci->block_rev1) >= PCIE_IP_REV_3_0) {
> -			val = (in_be32(&pci->pex_csr0) & PEX_CSR0_LTSSM_MASK)
> -					>> PEX_CSR0_LTSSM_SHIFT;
> -			if (val != PEX_CSR0_LTSSM_L0)
> -				return 1;
> -			iounmap(pci);
> -			return 0;
> -		}
> -		iounmap(pci);
> +	if (hose->indirect_type & PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK) {
> +		early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
> +		if (val < PCIE_LTSSM_L0)
> +			return 1;
> +	} else {
> +		struct ccsr_pci __iomem *pci = hose->private_data;
> +		/* for PCIe IP rev 3.0 or greater use CSR0 for link state */
> +		val = (in_be32(&pci->pex_csr0) & PEX_CSR0_LTSSM_MASK)
> +				>> PEX_CSR0_LTSSM_SHIFT;
> +		if (val != PEX_CSR0_LTSSM_L0)
> +			return 1;
>  	}
> -	early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
> -	if (val < PCIE_LTSSM_L0)
> -		return 1;
> 
>  	return 0;
>  }
> @@ -148,10 +136,9 @@ static int setup_one_atmu(struct ccsr_pci __iomem *pci,
> }
> 
>  /* atmu setup for fsl pci/pcie controller */
> -static void setup_pci_atmu(struct pci_controller *hose,
> -				  struct resource *rsrc)
> +static void setup_pci_atmu(struct pci_controller *hose)
>  {
> -	struct ccsr_pci __iomem *pci;
> +	struct ccsr_pci __iomem *pci = hose->private_data;
>  	int i, j, n, mem_log, win_idx = 3, start_idx = 1, end_idx = 4;
>  	u64 mem, sz, paddr_hi = 0;
>  	u64 paddr_lo = ULLONG_MAX;
> @@ -162,15 +149,6 @@ static void setup_pci_atmu(struct pci_controller *hose,
> const u64 *reg;
>  	int len;
> 
> -	pr_debug("PCI memory map start 0x%016llx, size 0x%016llx\n",
> -		 (u64)rsrc->start, (u64)resource_size(rsrc));
> -
> -	pci = ioremap(rsrc->start, resource_size(rsrc));
> -	if (!pci) {
> -	    dev_err(hose->parent, "Unable to map ATMU registers\n");
> -	    return;
> -	}
> -
>  	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
>  		if (in_be32(&pci->block_rev1) >= PCIE_IP_REV_2_2) {
>  			win_idx = 2;
> @@ -451,6 +429,7 @@ int __init fsl_add_bridge(struct platform_device *pdev,
> int is_primary) const int *bus_range;
>  	u8 hdr_type, progif;
>  	struct device_node *dev;
> +	struct ccsr_pci __iomem *pci;
> 
>  	dev = pdev->dev.of_node;
> 
> @@ -483,9 +462,19 @@ int __init fsl_add_bridge(struct platform_device *pdev,
> int is_primary) hose->first_busno = bus_range ? bus_range[0] : 0x0;
>  	hose->last_busno = bus_range ? bus_range[1] : 0xff;
> 
> +	pr_debug("PCI memory map start 0x%016llx, size 0x%016llx\n",
> +		 (u64)rsrc.start, (u64)resource_size(&rsrc));
> +
> +	pci = hose->private_data = ioremap(rsrc.start, resource_size(&rsrc));
> +	if (!hose->private_data)
> +		goto no_bridge;
> +
>  	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
>  		PPC_INDIRECT_TYPE_BIG_ENDIAN);
> 
> +	if (in_be32(&pci->block_rev1) < PCIE_IP_REV_3_0)
> +		hose->indirect_type |= PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK;
> +
>  	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
>  		/* For PCIE read HEADER_TYPE to identify controler mode */
>  		early_read_config_byte(hose, 0, 0, PCI_HEADER_TYPE, &hdr_type);
> @@ -505,7 +494,7 @@ int __init fsl_add_bridge(struct platform_device *pdev,
> int is_primary) if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
>  		hose->indirect_type |= PPC_INDIRECT_TYPE_EXT_REG |
>  			PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
> -		if (fsl_pcie_check_link(hose, &rsrc))
> +		if (fsl_pcie_check_link(hose))
>  			hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
>  	}
> 
> @@ -522,11 +511,12 @@ int __init fsl_add_bridge(struct platform_device
> *pdev, int is_primary) pci_process_bridge_OF_ranges(hose, dev, is_primary);
> 
>  	/* Setup PEX window registers */
> -	setup_pci_atmu(hose, &rsrc);
> +	setup_pci_atmu(hose);
> 
>  	return 0;
> 
>  no_bridge:
> +	iounmap(hose->private_data);
>  	/* unmap cfg_data & cfg_addr separately if not on same page */
>  	if (((unsigned long)hose->cfg_data & PAGE_MASK) !=
>  	    ((unsigned long)hose->cfg_addr & PAGE_MASK))
> @@ -703,11 +693,12 @@ static int __init mpc83xx_pcie_setup(struct
> pci_controller *hose, WARN_ON(hose->dn->data);
>  	hose->dn->data = pcie;
>  	hose->ops = &mpc83xx_pcie_ops;
> +	hose->indirect_type |= PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK;
> 
>  	out_le32(pcie->cfg_type0 + PEX_OUTWIN0_TAH, 0);
>  	out_le32(pcie->cfg_type0 + PEX_OUTWIN0_TAL, 0);
> 
> -	if (fsl_pcie_check_link(hose, NULL))
> +	if (fsl_pcie_check_link(hose))
>  		hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
> 
>  	return 0;
