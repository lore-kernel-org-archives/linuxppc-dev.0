Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F07672C02B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 02:23:08 +1100 (EST)
In-Reply-To: <3989200.gO920IVs04@pcimr>
References: <3989200.gO920IVs04@pcimr>
To: Rojhalat Ibrahim <imr@rtschenk.de>
MIME-Version: 1.0
Subject: Re: [PATCH] Make PCIe hotplug work with Freescale PCIe controllers
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <OF22E9DC45.43C40B0F-ONC1257B2B.0053CF4D-C1257B2B.0053F7FF@transmode.se>
Date: Mon, 11 Mar 2013 16:17:10 +0100
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rojhalat Ibrahim <imr@rtschenk.de> wrote on 2013/03/11 15:47:30:
> 
> Hi,
> 
> this issue was brought up before. 
> See this thread: 
https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-July/099529.html
> 
> The following patch works for me.
> Hot-added devices appear after "echo 1 > /sys/bus/pci/rescan".
> I tested it with a P5020DS development system.
> 
> Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>

Nice! This LOOKS ok to me(cannot test ATM as I am lagging behind)

 Jocke

> ---
>  arch/powerpc/sysdev/indirect_pci.c |   53 
++++++++++++++++++++++++++++++-------
>  1 file changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/indirect_pci.c 
b/arch/powerpc/sysdev/indirect_pci.c
> index 82fdad8..aa36009 100644
> --- a/arch/powerpc/sysdev/indirect_pci.c
> +++ b/arch/powerpc/sysdev/indirect_pci.c
> @@ -20,22 +20,19 @@
>  #include <asm/pci-bridge.h>
>  #include <asm/machdep.h>
> 
> +#ifdef CONFIG_FSL_PCI
> +#include <sysdev/fsl_pci.h>
> +#endif
> +
>  static int
> -indirect_read_config(struct pci_bus *bus, unsigned int devfn, int 
offset,
> -           int len, u32 *val)
> +read_config_no_link_check(struct pci_bus *bus, unsigned int devfn, int 
offset,
> +           int len, u32 *val)
>  {
>     struct pci_controller *hose = pci_bus_to_host(bus);
>     volatile void __iomem *cfg_data;
>     u8 cfg_type = 0;
>     u32 bus_no, reg;
> 
> -   if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK) {
> -      if (bus->number != hose->first_busno)
> -         return PCIBIOS_DEVICE_NOT_FOUND;
> -      if (devfn != 0)
> -         return PCIBIOS_DEVICE_NOT_FOUND;
> -   }
> -
>     if (ppc_md.pci_exclude_device)
>        if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
>           return PCIBIOS_DEVICE_NOT_FOUND;
> @@ -78,6 +75,44 @@ indirect_read_config(struct pci_bus *bus, unsigned 
int 
> devfn, int offset,
>     return PCIBIOS_SUCCESSFUL;
>  }
> 
> +#ifdef CONFIG_FSL_PCI
> +static int fsl_pcie_check_link(struct pci_bus *bus)
> +{
> +   struct pci_controller *hose = pci_bus_to_host(bus);
> +   u32 val = 0;
> +
> +   read_config_no_link_check(bus, 0, PCIE_LTSSM, 4, &val);
> +   if (val < PCIE_LTSSM_L0) {
> +      hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
> +      return 1;
> +   } else {
> +      hose->indirect_type &= ~PPC_INDIRECT_TYPE_NO_PCIE_LINK;
> +      return 0;
> +   }
> +}
> +#endif
> +
> +static int
> +indirect_read_config(struct pci_bus *bus, unsigned int devfn, int 
offset,
> +           int len, u32 *val)
> +{
> +   struct pci_controller *hose = pci_bus_to_host(bus);
> +
> +#ifdef CONFIG_FSL_PCI
> +   if ((bus->number == hose->first_busno) && (devfn == 0)) {
> +      fsl_pcie_check_link(bus);
> +   }
> +#endif
> +   if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK) {
> +      if (bus->number != hose->first_busno)
> +         return PCIBIOS_DEVICE_NOT_FOUND;
> +      if (devfn != 0)
> +         return PCIBIOS_DEVICE_NOT_FOUND;
> +   }
> +
> +   return read_config_no_link_check(bus, devfn, offset, len, val);
> +}
> +
>  static int
>  indirect_write_config(struct pci_bus *bus, unsigned int devfn, int 
offset,
>              int len, u32 val)
> 
