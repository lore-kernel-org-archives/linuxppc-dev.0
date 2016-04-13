Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlFb76HpXzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 17:21:07 +1000 (AEST)
Received: by mail-pa0-x230.google.com with SMTP id er2so82255pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 00:21:07 -0700 (PDT)
Subject: Re: [PATCH v8 12/45] powerpc/powernv: Rename M64 related functions
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-13-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <570DF35A.1010101@ozlabs.ru>
Date: Wed, 13 Apr 2016 17:20:58 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-13-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2016 02:43 PM, Gavin Shan wrote:
> This renames those functions picking PE number based on consumed
> M64 segments, mapping M64 segments to PEs as those functions are
> going to be shared by IODA1/IODA2 in next patch. No logical changes
> introduced.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>




> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index fc0374a..1dc663a 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -219,7 +219,7 @@ fail:
>   	return -EIO;
>   }
>
> -static void pnv_ioda2_reserve_dev_m64_pe(struct pci_dev *pdev,
> +static void pnv_ioda_reserve_dev_m64_pe(struct pci_dev *pdev,
>   					 unsigned long *pe_bitmap)
>   {
>   	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> @@ -246,22 +246,22 @@ static void pnv_ioda2_reserve_dev_m64_pe(struct pci_dev *pdev,
>   	}
>   }
>
> -static void pnv_ioda2_reserve_m64_pe(struct pci_bus *bus,
> -				     unsigned long *pe_bitmap,
> -				     bool all)
> +static void pnv_ioda_reserve_m64_pe(struct pci_bus *bus,
> +				    unsigned long *pe_bitmap,
> +				    bool all)
>   {
>   	struct pci_dev *pdev;
>
>   	list_for_each_entry(pdev, &bus->devices, bus_list) {
> -		pnv_ioda2_reserve_dev_m64_pe(pdev, pe_bitmap);
> +		pnv_ioda_reserve_dev_m64_pe(pdev, pe_bitmap);
>
>   		if (all && pdev->subordinate)
> -			pnv_ioda2_reserve_m64_pe(pdev->subordinate,
> -						 pe_bitmap, all);
> +			pnv_ioda_reserve_m64_pe(pdev->subordinate,
> +						pe_bitmap, all);
>   	}
>   }
>
> -static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
> +static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>   {
>   	struct pci_controller *hose = pci_bus_to_host(bus);
>   	struct pnv_phb *phb = hose->private_data;
> @@ -283,7 +283,7 @@ static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
>   	}
>
>   	/* Figure out reserved PE numbers by the PE */
> -	pnv_ioda2_reserve_m64_pe(bus, pe_alloc, all);
> +	pnv_ioda_reserve_m64_pe(bus, pe_alloc, all);
>
>   	/*
>   	 * the current bus might not own M64 window and that's all
> @@ -365,8 +365,8 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>   	/* Use last M64 BAR to cover M64 window */
>   	phb->ioda.m64_bar_idx = 15;
>   	phb->init_m64 = pnv_ioda2_init_m64;
> -	phb->reserve_m64_pe = pnv_ioda2_reserve_m64_pe;
> -	phb->pick_m64_pe = pnv_ioda2_pick_m64_pe;
> +	phb->reserve_m64_pe = pnv_ioda_reserve_m64_pe;
> +	phb->pick_m64_pe = pnv_ioda_pick_m64_pe;
>   }
>
>   static void pnv_ioda_freeze_pe(struct pnv_phb *phb, int pe_no)
>


-- 
Alexey
