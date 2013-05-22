Return-Path: <michael@ellerman.id.au>
Date: Wed, 22 May 2013 14:36:42 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] powerpc: Force 32 bit MSIs on systems lacking
 firmware support
Message-ID: <20130522043641.GB18345@concordia>
References: <201305212154.r4LLs4Zu026123@d01av03.pok.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201305212154.r4LLs4Zu026123@d01av03.pok.ibm.com>
Cc: klebers@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 21, 2013 at 04:54:04PM -0500, Brian King wrote:
> 
> Recent commit e61133dda480062d221f09e4fc18f66763f8ecd0 added support
> for a new firmware feature to force an adapter to use 32 bit MSIs.
> However, this firmware is not available for all systems. The hack below
> allows devices needing 32 bit MSIs to work on these systems as well.
> It is careful to only enable this on Gen2 slots, which should limit
> this to configurations where this hack is needed and tested to work.

Sorry I know you've already sent this to me once, but I didn't get time
to reply.

> diff -puN arch/powerpc/platforms/pseries/msi.c~powerpc_32bit_msi_hack_on_papr arch/powerpc/platforms/pseries/msi.c
> --- linux/arch/powerpc/platforms/pseries/msi.c~powerpc_32bit_msi_hack_on_papr	2013-05-15 10:44:46.000000000 -0500
> +++ linux-bjking1/arch/powerpc/platforms/pseries/msi.c	2013-05-20 15:24:52.000000000 -0500
> @@ -397,10 +397,11 @@ static int check_msix_entries(struct pci
>  static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec_in, int type)
>  {
>  	struct pci_dn *pdn;
> -	int hwirq, virq, i, rc;
> +	int hwirq, virq, i, rc = -1;

I'd rather you didn't do a catch-all initialisation like this, it's too
easy to miss a return path.

>  	struct msi_desc *entry;
>  	struct msi_msg msg;
>  	int nvec = nvec_in;
> +	int use_32bit_msi_hack = 0;
>  
>  	pdn = get_pdn(pdev);
>  	if (!pdn)
> @@ -428,15 +429,37 @@ static int rtas_setup_msi_irqs(struct pc
>  	 */
>  again:
>  	if (type == PCI_CAP_ID_MSI) {
> -		if (pdn->force_32bit_msi)
> +		if (pdn->force_32bit_msi) {
>  			rc = rtas_change_msi(pdn, RTAS_CHANGE_32MSI_FN, nvec);
> -		else
> +			if (rc < 0) {
> +				/* We only want to run the 32 bit MSI hack below if
> +				 the max bus speed is Gen2 speed. */
> +				if (pdev->bus->max_bus_speed != PCIE_SPEED_5_0GT)
> +					return rc;
> +
> +				use_32bit_msi_hack = 1;
> +			}
> +		}
> +
> +		if (rc < 0)
>  			rc = rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, nvec);
>  
> -		if (rc < 0 && !pdn->force_32bit_msi) {
> +		if (rc < 0) {
>  			pr_debug("rtas_msi: trying the old firmware call.\n");
>  			rc = rtas_change_msi(pdn, RTAS_CHANGE_FN, nvec);
>  		}
> +
> +		if (use_32bit_msi_hack && rc > 0) {
> +			int pos;
> +			u32 addr_hi, addr_lo;
> +
> +			dev_info(&pdev->dev, "rtas_msi: No 32 bit MSI firmware support, forcing 32 bit MSI\n");
> +			pos = pci_find_capability(pdev, PCI_CAP_ID_MSI);
> +			pci_read_config_dword(pdev, pos + PCI_MSI_ADDRESS_HI, &addr_hi);
> +			addr_lo = 0xffff0000 | ((addr_hi >> (48 - 32)) << 4);
> +			pci_write_config_dword(pdev, pos + PCI_MSI_ADDRESS_LO, addr_lo);
> +			pci_write_config_dword(pdev, pos + PCI_MSI_ADDRESS_HI, 0);

This is basically baking knowledge of phyp's address layout into the
kernel right? Which is OK, but it needs a big fat comment describing
exactly what it's doing and why it's safe.

cheers
