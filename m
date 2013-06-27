Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 570B42C0330
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 09:16:59 +1000 (EST)
Date: Thu, 27 Jun 2013 18:16:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: Sergey Gerasimov <Sergey.Gerasimov@astrosoft-development.com>
Subject: Re: [1/1] MPC831x: fix PCI express probing
Message-ID: <20130627231647.GA15057@home.buserror.net>
References: <1363687105-24835-1-git-send-email-Sergey.Gerasimov@astrosoft-development.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1363687105-24835-1-git-send-email-Sergey.Gerasimov@astrosoft-development.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 19, 2013 at 10:58:25AM +0100, Sergey Gerasimov wrote:
> For MPC831x the bus probing function also needs the fixup to assign
> addresses to the PCI devices as it was for MPC85xx and MPC86xx.
> The fixup of the bridge vendor and device ID should be done early in
> PCI probing. Else the bridge is not detected as FIXUP_HEADER is called
> too late.
> 
> Signed-off-by: Sergey Gerasimov <Sergey.Gerasimov@astrosoft-development.com>
> 
> ---
> arch/powerpc/sysdev/fsl_pci.c | 67 +++++++++++++++++++------------------------
>  1 file changed, 30 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 682084d..b4f0873 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -64,6 +64,34 @@ static int __init fsl_pcie_check_link(struct pci_controller *hose)
>  	return 0;
>  }
>  
> +void fsl_pcibios_fixup_bus(struct pci_bus *bus)
> +{
> +	struct pci_controller *hose = (struct pci_controller *) bus->sysdata;
> +	int i;
> +
> +
> +	if ((bus->parent == hose->bus)
> +		&& ((fsl_pcie_bus_fixup
> +			&& pci_bus_find_capability(bus, 0, PCI_CAP_ID_EXP))
> +				|| (hose->indirect_type
> +					& PPC_INDIRECT_TYPE_NO_PCIE_LINK))) {
> +		for (i = 0; i < 4; ++i) {
[snip]
> -void fsl_pcibios_fixup_bus(struct pci_bus *bus)
> -{
> -	struct pci_controller *hose = pci_bus_to_host(bus);
> -	int i, is_pcie = 0, no_link;
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
> -		is_pcie = early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP);
> -	no_link = !!(hose->indirect_type & PPC_INDIRECT_TYPE_NO_PCIE_LINK);
> -
> -	if (bus->parent == hose->bus && (is_pcie || no_link)) {
> -		for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; ++i) {

It looks like you're reverting commit
13635dfdc6aa8d2890e02dc441decfcb4ae63e14 ("powerpc/fsl/pci: Fix PCIe
fixup regression"), presumably due to a bad merge conflict resolution.

> @@ -515,7 +507,8 @@ no_bridge:
>  }
>  #endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx */
>  
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_fsl_pcie_header);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,
> +	quirk_fsl_pcie_header);
>  
>  #if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)
>  struct mpc83xx_pcie_priv {

Ben/Kumar, any comments on this, or on needing to call
fsl_pcibios_fixup_bus on 83xx?

-Scott
