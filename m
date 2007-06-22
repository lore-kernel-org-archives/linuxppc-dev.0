Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 830C0DDE1A
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 23:48:07 +1000 (EST)
In-Reply-To: <1180996203.9632.71.camel@ld0161-tx32>
References: <1180996203.9632.71.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6B5376FC-C0C8-4DB1-81A3-C886E8F817DF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 3/9] 8641HPCN: Add PCI-Express link training status
	check
Date: Fri, 22 Jun 2007 08:48:56 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 4, 2007, at 5:30 PM, Jon Loeliger wrote:

> From: Zhang Wei <wei.zhang@freescale.com>
>
> Avoid system halt while the link training is fault.
>
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> Acked-by: Roy Zang <tie-fei.zang@freescale.com>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> ---
>  arch/powerpc/platforms/86xx/pci.c |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/ 
> platforms/86xx/pci.c
> index 7efae7c..07ff52c 100644
> --- a/arch/powerpc/platforms/86xx/pci.c
> +++ b/arch/powerpc/platforms/86xx/pci.c
> @@ -122,7 +122,6 @@ static void __init
>  mpc86xx_setup_pcie(struct pci_controller *hose, u32 pcie_offset,  
> u32 pcie_size)
>  {
>  	u16 cmd;
> -	unsigned int temps;
>
>  	DBG("PCIE host controller register offset 0x%08x, size 0x%08x.\n",
>  			pcie_offset, pcie_size);
> @@ -140,6 +139,9 @@ int mpc86xx_exclude_device(u_char bus, u_char  
> devfn)
>  	return PCIBIOS_SUCCESSFUL;
>  }
>
> +#define PCIE_LTSSM	0x04000004	/* PCIe Link Training and Status */
> +#define PCIE_LTSSM_L0	0x16		/* L0 state */
> +
>  int __init add_bridge(struct device_node *dev)
>  {
>  	int len;
> @@ -148,12 +150,20 @@ int __init add_bridge(struct device_node *dev)
>  	const int *bus_range;
>  	int has_address = 0;
>  	int primary = 0;
> +	void *pcicfg_addr;
>
>  	DBG("Adding PCIE host bridge %s\n", dev->full_name);
>
>  	/* Fetch host bridge registers address */
>  	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
>
> +	/* Probe the hose link training status */
> +	pcicfg_addr = ioremap(rsrc.start, 0x1000);
> +	out_be32(pcicfg_addr, 0x80000000 | PCIE_LTSSM);
> +	if (in_le16(pcicfg_addr + 4) < PCIE_LTSSM_L0)
> +		return -ENXIO;
> +	iounmap(pcicfg_addr);

Is there a reason we don't do this with early_read_config_word, while  
it requires we alloc the hose, it seems cleaner.  If this fails, I  
think the memory wasted on the hose is a minor concern.  (assuming my  
other patch to support extended regs in pci indirect).

- k
