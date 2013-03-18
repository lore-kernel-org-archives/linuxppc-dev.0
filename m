Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2D41C2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 02:01:11 +1100 (EST)
Subject: Re: [PATCH 1/1] For MPC831x the bus probing function needs the fixup
 to assign addresses to the PCI devices as it was for MPC85xx and MPC86xx. The
 fixup of the bridge vendor and device ID should be done early in PCI probing.
 Else the bridge is not detected as FIXUP_HEADER is called too late.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1363614636-1142-1-git-send-email-Sergey.Gerasimov@astrosoft-development.com>
Date: Mon, 18 Mar 2013 09:58:34 -0500
Message-Id: <A5547E85-6DCA-4FE6-BF6D-F5256CEB92E3@kernel.crashing.org>
References: <1363614636-1142-1-git-send-email-Sergey.Gerasimov@astrosoft-development.com>
To: Sergey Gerasimov <Sergey.Gerasimov@astrosoft-development.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Timur Tabi <timur@freescale.com>,
 Jia Hongtao <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 18, 2013, at 8:50 AM, Sergey Gerasimov wrote:

> Signed-off-by: Sergey Gerasimov =
<Sergey.Gerasimov@astrosoft-development.com>
> ---
> arch/powerpc/sysdev/fsl_pci.c | 71 =
+++++++++++++++++++++----------------------
> 1 file changed, 34 insertions(+), 37 deletions(-)
>=20

Can you repost with subject and commit log fixed?  It appears your =
subject & commit message are merged.

> diff --git a/arch/powerpc/sysdev/fsl_pci.c =
b/arch/powerpc/sysdev/fsl_pci.c
> index 682084d..2e41a68 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -64,6 +64,34 @@ static int __init fsl_pcie_check_link(struct =
pci_controller *hose)
> 	return 0;
> }
>=20
> +void fsl_pcibios_fixup_bus(struct pci_bus *bus)
> +{
> +	struct pci_controller *hose =3D (struct pci_controller *) =
bus->sysdata;
> +	int i;
> +
> +
> +	if ((bus->parent =3D=3D hose->bus)
> +		&& ((fsl_pcie_bus_fixup
> +			&& pci_bus_find_capability(bus, 0, =
PCI_CAP_ID_EXP))
> +				|| (hose->indirect_type
> +					& =
PPC_INDIRECT_TYPE_NO_PCIE_LINK))) {
> +		for (i =3D 0; i < 4; ++i) {
> +			struct resource *res =3D bus->resource[i];
> +			struct resource *par =3D =
bus->parent->resource[i];
> +			if (res) {
> +				res->start =3D 0;
> +				res->end   =3D 0;
> +				res->flags =3D 0;
> +			}
> +			if (res && par) {
> +				res->start =3D par->start;
> +				res->end   =3D par->end;
> +				res->flags =3D par->flags;
> +			}
> +		}
> +	}
> +}
> +
> #if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
>=20
> #define MAX_PHYS_ADDR_BITS	40
> @@ -384,42 +412,6 @@ static void __init setup_pci_cmd(struct =
pci_controller *hose)
> 	}
> }
>=20
> -void fsl_pcibios_fixup_bus(struct pci_bus *bus)
> -{
> -	struct pci_controller *hose =3D pci_bus_to_host(bus);
> -	int i, is_pcie =3D 0, no_link;
> -
> -	/* The root complex bridge comes up with bogus resources,
> -	 * we copy the PHB ones in.
> -	 *
> -	 * With the current generic PCI code, the PHB bus no longer
> -	 * has bus->resource[0..4] set, so things are a bit more
> -	 * tricky.
> -	 */
> -
> -	if (fsl_pcie_bus_fixup)
> -		is_pcie =3D early_find_capability(hose, 0, 0, =
PCI_CAP_ID_EXP);
> -	no_link =3D !!(hose->indirect_type & =
PPC_INDIRECT_TYPE_NO_PCIE_LINK);
> -
> -	if (bus->parent =3D=3D hose->bus && (is_pcie || no_link)) {
> -		for (i =3D 0; i < PCI_BRIDGE_RESOURCE_NUM; ++i) {
> -			struct resource *res =3D bus->resource[i];
> -			struct resource *par;
> -
> -			if (!res)
> -				continue;
> -			if (i =3D=3D 0)
> -				par =3D &hose->io_resource;
> -			else if (i < 4)
> -				par =3D &hose->mem_resources[i-1];
> -			else par =3D NULL;
> -
> -			res->start =3D par ? par->start : 0;
> -			res->end   =3D par ? par->end   : 0;
> -			res->flags =3D par ? par->flags : 0;
> -		}
> -	}
> -}
>=20
> int __init fsl_add_bridge(struct platform_device *pdev, int =
is_primary)
> {
> @@ -515,7 +507,8 @@ no_bridge:
> }
> #endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx */
>=20
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, =
quirk_fsl_pcie_header);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,
> +	quirk_fsl_pcie_header);

why does this need to be done EARLY?

> #if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)
> struct mpc83xx_pcie_priv {
> @@ -813,6 +806,10 @@ u64 fsl_pci_immrbar_base(struct pci_controller =
*hose)
> 	}
> #endif
>=20
> +
> +
> +
> +

don't add extra whitespace

> #if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
> 	if (!is_mpc83xx_pci) {
> 		u32 base;
> --=20
> 1.7.11.7
