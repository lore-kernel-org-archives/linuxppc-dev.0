Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 54F7E1A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:07:26 +1100 (AEDT)
Received: by padhx2 with SMTP id hx2so192375173pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 17:07:24 -0800 (PST)
Subject: Re: [PATCH v7 17/50] powerpc/powernv: Avoid calculating DMA32
 segments on PHB3
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-18-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <564A7DC5.5060702@ozlabs.ru>
Date: Tue, 17 Nov 2015 12:07:17 +1100
MIME-Version: 1.0
In-Reply-To: <1446642770-4681-18-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/05/2015 12:12 AM, Gavin Shan wrote:
> In pnv_ioda_setup_dma(), it's unnecessary to calculate the DMA32
> segments for PEs on PHB3 as the whole available DMA32 space can
> be assigned to one specific PE on PHB3.
>
> This splits pnv_ioda_setup_dma() to pnv_pci_ioda1_setup_dma() and
> pnv_pci_ioda2_setup_dma() in order to avoid calculating DMA32
> segments for PEs on PHB3. No logical changes introduced.


This patch is not needed as

[PATCH v7 20/50] powerpc/powernv: Improve DMA32 segment calculation

moves this calculation to another place (which already makes this patch 
unnecessary) and

[PATCH v7 26/50] powerpc/powernv: Create PEs at PCI hot plugging time

removes just introduced pnv_pci_ioda1_setup_dma() - if you remove it, then 
there is no point in fixing it in the first place.

>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 41 ++++++++++++++++++-------------
>   1 file changed, 24 insertions(+), 17 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 5a08e20..4c2e023 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2383,7 +2383,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>   		pnv_ioda_setup_bus_dma(pe, pe->pbus);
>   }
>
> -static void pnv_ioda_setup_dma(struct pnv_phb *phb)
> +static void pnv_pci_ioda1_setup_dma(struct pnv_phb *phb)
>   {
>   	struct pci_controller *hose = phb->hose;
>   	unsigned int residual, remaining, segs, tw, base;
> @@ -2428,26 +2428,30 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>   				segs = remaining;
>   		}
>
> -		/*
> -		 * For IODA2 compliant PHB3, we needn't care about the weight.
> -		 * The all available 32-bits DMA space will be assigned to
> -		 * the specific PE.
> -		 */
> -		if (phb->type == PNV_PHB_IODA1) {
> -			pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
> -				pe->dma_weight, segs);
> -			pnv_pci_ioda1_setup_dma_pe(phb, pe, base, segs);
> -		} else {
> -			pe_info(pe, "Assign DMA32 space\n");
> -			segs = 0;
> -			pnv_pci_ioda2_setup_dma_pe(phb, pe);
> -		}
> +		pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
> +			pe->dma_weight, segs);
> +		pnv_pci_ioda1_setup_dma_pe(phb, pe, base, segs);
>
>   		remaining -= segs;
>   		base += segs;
>   	}
>   }
>
> +static void pnv_pci_ioda2_setup_dma(struct pnv_phb *phb)
> +{
> +	struct pnv_ioda_pe *pe;
> +
> +	pnv_pci_ioda_setup_opal_tce_kill(phb);
> +
> +	list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
> +		if (!pe->dma_weight)
> +			continue;
> +
> +		pe_info(pe, "Assign DMA32 space\n");
> +		pnv_pci_ioda2_setup_dma_pe(phb, pe);
> +	}
> +}
> +
>   #ifdef CONFIG_PCI_MSI
>   static void pnv_ioda2_msi_eoi(struct irq_data *d)
>   {
> @@ -2931,10 +2935,13 @@ static void pnv_pci_ioda_setup_DMA(void)
>   	struct pnv_phb *phb;
>
>   	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
> -		pnv_ioda_setup_dma(hose->private_data);
> +		phb = hose->private_data;
> +		if (phb->type == PNV_PHB_IODA1)
> +			pnv_pci_ioda1_setup_dma(phb);
> +		else
> +			pnv_pci_ioda2_setup_dma(phb);
>
>   		/* Mark the PHB initialization done */
> -		phb = hose->private_data;
>   		phb->initialized = 1;
>   	}
>   }
>


-- 
Alexey
