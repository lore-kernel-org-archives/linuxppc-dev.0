Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0fjT2YQxzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 12:58:03 +1000 (AEST)
Received: by mail-pa0-x233.google.com with SMTP id xk12so30983457pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 May 2016 19:58:03 -0700 (PDT)
Subject: Re: [PATCH v9 09/26] powerpc/powernv: IO and M32 mapping based on PCI
 device resources
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462254105-24128-10-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, alistair@popple.id.au
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <436233a7-a931-a0c7-a2eb-caca221e4cc0@ozlabs.ru>
Date: Thu, 5 May 2016 12:57:55 +1000
MIME-Version: 1.0
In-Reply-To: <1462254105-24128-10-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/03/2016 03:41 PM, Gavin Shan wrote:
> Currently, the IO and M32 segments are mapped to the corresponding
> PE based on the windows of the parent bridge of PE's primary bus.
> It's not going to work when the windows of root port or upstream
> port of the PCIe switch behind root port are extended to PHB's
> apertures in order to support hotplug in subsequent patch.
>
> This fixes the issue by mapping IO and M32 segments based on the
> resources of the PCI devices included in the PE, instead of the
> windows of the parent bridge of the PE's primary bus.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index b954fbc..904790b 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2993,7 +2993,7 @@ static void pnv_ioda_setup_pe_res(struct pnv_ioda_pe *pe,
>   */
>  static void pnv_ioda_setup_pe_seg(struct pnv_ioda_pe *pe)
>  {
> -	struct resource *res;
> +	struct pci_dev *pdev;
>  	int i;
>
>  	/*
> @@ -3003,8 +3003,21 @@ static void pnv_ioda_setup_pe_seg(struct pnv_ioda_pe *pe)
>  	 */
>  	BUG_ON(!(pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)));
>
> -	pci_bus_for_each_resource(pe->pbus, res, i)
> -		pnv_ioda_setup_pe_res(pe, res);
> +	list_for_each_entry(pdev, &pe->pbus->devices, bus_list) {
> +		for (i = 0; i <= PCI_ROM_RESOURCE; i++)
> +			pnv_ioda_setup_pe_res(pe, &pdev->resource[i]);
> +
> +		/*
> +		 * If the PE contains all subordinate PCI buses, the
> +		 * windows of the child bridges should be mapped to
> +		 * the PE as well.
> +		 */
> +		if (!(pe->flags & PNV_IODA_PE_BUS_ALL) || !pci_is_bridge(pdev))
> +			continue;
> +		for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++)
> +			pnv_ioda_setup_pe_res(pe,
> +				&pdev->resource[PCI_BRIDGE_RESOURCES + i]);
> +	}
>  }
>
>  static void pnv_pci_ioda_setup_seg(void)
>


-- 
Alexey
