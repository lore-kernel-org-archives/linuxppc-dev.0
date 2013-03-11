Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 214D12C02A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 04:17:52 +1100 (EST)
Subject: Re: [PATCH] Make PCIe hotplug work with Freescale PCIe controllers
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <3989200.gO920IVs04@pcimr>
Date: Mon, 11 Mar 2013 12:17:42 -0500
Message-Id: <179EA411-594D-4774-903A-6C0445A01747@kernel.crashing.org>
References: <3989200.gO920IVs04@pcimr>
To: Rojhalat Ibrahim <imr@rtschenk.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 11, 2013, at 9:47 AM, Rojhalat Ibrahim wrote:

> Hi,
>=20
> this issue was brought up before.=20
> See this thread: =
https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-July/099529.html
>=20
> The following patch works for me.
> Hot-added devices appear after "echo 1 > /sys/bus/pci/rescan".
> I tested it with a P5020DS development system.
>=20
> Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>
> ---
> arch/powerpc/sysdev/indirect_pci.c |   53 =
++++++++++++++++++++++++++++++-------
> 1 file changed, 44 insertions(+), 9 deletions(-)

Rather than do it this way, we should do something like:

fsl_indirect_read_config() {
	link check
	if (link)
		indirect_read_config()
}

and just add fsl_indirect_{r,w}_config into fsl_pci.c

- k

>=20
> diff --git a/arch/powerpc/sysdev/indirect_pci.c =
b/arch/powerpc/sysdev/indirect_pci.c
> index 82fdad8..aa36009 100644
> --- a/arch/powerpc/sysdev/indirect_pci.c
> +++ b/arch/powerpc/sysdev/indirect_pci.c
> @@ -20,22 +20,19 @@
> #include <asm/pci-bridge.h>
> #include <asm/machdep.h>
>=20
> +#ifdef CONFIG_FSL_PCI
> +#include <sysdev/fsl_pci.h>
> +#endif
> +
> static int
> -indirect_read_config(struct pci_bus *bus, unsigned int devfn, int =
offset,
> -		     int len, u32 *val)
> +read_config_no_link_check(struct pci_bus *bus, unsigned int devfn, =
int offset,
> +			  int len, u32 *val)
> {
> 	struct pci_controller *hose =3D pci_bus_to_host(bus);
> 	volatile void __iomem *cfg_data;
> 	u8 cfg_type =3D 0;
> 	u32 bus_no, reg;
>=20
> -	if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK) {
> -		if (bus->number !=3D hose->first_busno)
> -			return PCIBIOS_DEVICE_NOT_FOUND;
> -		if (devfn !=3D 0)
> -			return PCIBIOS_DEVICE_NOT_FOUND;
> -	}
> -
> 	if (ppc_md.pci_exclude_device)
> 		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
> 			return PCIBIOS_DEVICE_NOT_FOUND;
> @@ -78,6 +75,44 @@ indirect_read_config(struct pci_bus *bus, unsigned =
int devfn, int offset,
> 	return PCIBIOS_SUCCESSFUL;
> }
>=20
> +#ifdef CONFIG_FSL_PCI
> +static int fsl_pcie_check_link(struct pci_bus *bus)
> +{
> +	struct pci_controller *hose =3D pci_bus_to_host(bus);
> +	u32 val =3D 0;
> +
> +	read_config_no_link_check(bus, 0, PCIE_LTSSM, 4, &val);
> +	if (val < PCIE_LTSSM_L0) {
> +		hose->indirect_type |=3D PPC_INDIRECT_TYPE_NO_PCIE_LINK;
> +		return 1;
> +	} else {
> +		hose->indirect_type &=3D =
~PPC_INDIRECT_TYPE_NO_PCIE_LINK;
> +		return 0;
> +	}
> +}
> +#endif
> +
> +static int
> +indirect_read_config(struct pci_bus *bus, unsigned int devfn, int =
offset,
> +		     int len, u32 *val)
> +{
> +	struct pci_controller *hose =3D pci_bus_to_host(bus);
> +
> +#ifdef CONFIG_FSL_PCI
> +	if ((bus->number =3D=3D hose->first_busno) && (devfn =3D=3D 0)) =
{
> +		fsl_pcie_check_link(bus);
> +	}
> +#endif
> +	if (hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK) {
> +		if (bus->number !=3D hose->first_busno)
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +		if (devfn !=3D 0)
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
> +	return read_config_no_link_check(bus, devfn, offset, len, val);
> +}
> +
> static int
> indirect_write_config(struct pci_bus *bus, unsigned int devfn, int =
offset,
> 		      int len, u32 val)
