Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EFD3ADDEBB
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 11:39:46 +1000 (EST)
Subject: Re: [PATCH 04/25] [POWERPC] Added indirect quirk to handle PCIe
	PHB that have issue w/no link
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1185223818821-git-send-email-galak@kernel.crashing.org>
References: <11852238122538-git-send-email-galak@kernel.crashing.org>
	<1185223813693-git-send-email-galak@kernel.crashing.org>
	<11852238151983-git-send-email-galak@kernel.crashing.org>
	<11852238161546-git-send-email-galak@kernel.crashing.org>
	<1185223818821-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 24 Jul 2007 11:39:39 +1000
Message-Id: <1185241179.5439.185.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-07-23 at 15:49 -0500, Kumar Gala wrote:
> Added PPC_INDIRECT_TYPE_NO_PCIE_LINK flag to the indirect pci handling
> code to ensure that we don't talk to any device other than the PHB
> if we don't have PCIe link.  Some controllers will lockup if they try
> to do a config cycle to any device on the bus except the PHB.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

I would name the quirk a bit more generically, something like
"ACCESS_PHB_ONLY" maybe ? If you don't want to change it, that's fair.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Ben.

>  arch/powerpc/sysdev/indirect_pci.c |   16 +++++++++++++++-
>  include/asm-powerpc/pci-bridge.h   |    5 +++++
>  2 files changed, 20 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
> index c7e6e85..bc5b4e2 100644
> --- a/arch/powerpc/sysdev/indirect_pci.c
> +++ b/arch/powerpc/sysdev/indirect_pci.c
> @@ -35,10 +35,17 @@ indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
>  	u8 cfg_type = 0;
>  	u32 bus_no, reg;
>  
> +	if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK) {
> +		if (bus->number != hose->first_busno)
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +		if (devfn != 0)
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
>  	if (ppc_md.pci_exclude_device)
>  		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
>  			return PCIBIOS_DEVICE_NOT_FOUND;
> -	
> +
>  	if (hose->indirect_type & PPC_INDIRECT_TYPE_SET_CFG_TYPE)
>  		if (bus->number != hose->first_busno)
>  			cfg_type = 1;
> @@ -83,6 +90,13 @@ indirect_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
>  	u8 cfg_type = 0;
>  	u32 bus_no, reg;
>  
> +	if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK) {
> +		if (bus->number != hose->first_busno)
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +		if (devfn != 0)
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
>  	if (ppc_md.pci_exclude_device)
>  		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
>  			return PCIBIOS_DEVICE_NOT_FOUND;
> diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
> index 7a00b8e..9754357 100644
> --- a/include/asm-powerpc/pci-bridge.h
> +++ b/include/asm-powerpc/pci-bridge.h
> @@ -45,10 +45,15 @@ struct pci_controller {
>  	 *   on Freescale PCI-e controllers since they used the PCI_PRIMARY_BUS
>  	 *   to determine which bus number to match on when generating type0
>  	 *   config cycles
> +	 *  NO_PCIE_LINK - the Freescale PCI-e controllers have issues with
> +	 *   hanging if we don't have link and try to do config cycles to
> +	 *   anything but the PHB.  Only allow talking to the PHB if this is
> +	 *   set.
>  	 */
>  #define PPC_INDIRECT_TYPE_SET_CFG_TYPE		(0x00000001)
>  #define PPC_INDIRECT_TYPE_EXT_REG		(0x00000002)
>  #define PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS	(0x00000004)
> +#define PPC_INDIRECT_TYPE_NO_PCIE_LINK		(0x00000008)
>  	u32 indirect_type;
>  
>  	/* Currently, we limit ourselves to 1 IO range and 3 mem
