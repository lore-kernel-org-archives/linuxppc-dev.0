Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
 [150.101.137.145])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wwxQz72QVzDr0c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 14:48:59 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
Subject: Re: [PATCH 1/2] powerpc/powernv/pci: Add helper to check if a PE has
 a single vendor
Date: Mon, 26 Jun 2017 14:48:25 +1000
Message-ID: <1719039.1i4epCekVU@new-mexico>
In-Reply-To: <20170621071804.11660-1-ruscur@russell.cc>
References: <20170621071804.11660-1-ruscur@russell.cc>
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

You may need some kind of temporary unused annotation to shut the
compiler/kbuild robot up but the patch itself looks fine.

Reviewed-by: Alistair Popple <alistair@popple.id.au>

On Wed, 21 Jun 2017 05:18:03 PM Russell Currey wrote:
> Add a helper that determines if all the devices contained in a given PE
> are all from the same vendor or not.  This can be useful in determining
> if it's okay to make PE-wide changes that may be suitable for some
> devices but not for others.
> 
> This is used later in the series.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 283caf1070c9..13835ac30795 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1718,6 +1718,31 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
>  	 */
>  }
>  
> +static bool pnv_pci_ioda_pe_single_vendor(struct pnv_ioda_pe *pe)
> +{
> +	unsigned short vendor = 0;
> +	struct pci_dev *pdev;
> +
> +	if (pe->device_count == 1)
> +		return true;
> +
> +	/* pe->pdev should be set if it's a single device, pe->pbus if not */
> +	if (!pe->pbus)
> +		return true;
> +
> +	list_for_each_entry(pdev, &pe->pbus->devices, bus_list) {
> +		if (!vendor) {
> +			vendor = pdev->vendor;
> +			continue;
> +		}
> +
> +		if (pdev->vendor != vendor)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
>  {
>  	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> 
