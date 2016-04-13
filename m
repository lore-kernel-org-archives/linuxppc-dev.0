Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x236.google.com (mail-pf0-x236.google.com
 [IPv6:2607:f8b0:400e:c00::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlFww4cBGzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 17:36:32 +1000 (AEST)
Received: by mail-pf0-x236.google.com with SMTP id 184so29514497pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 00:36:32 -0700 (PDT)
Subject: Re: [PATCH v8 14/45] powerpc/powernv/ioda1: Rename
 pnv_pci_ioda_setup_dma_pe()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-15-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <570DF6F7.4010701@ozlabs.ru>
Date: Wed, 13 Apr 2016 17:36:23 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-15-git-send-email-gwshan@linux.vnet.ibm.com>
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
> This renames pnv_pci_ioda_setup_dma_pe() to pnv_pci_ioda1_setup_dma_pe()
> as it's the counter-part of IODA2's pnv_pci_ioda2_setup_dma_pe().
> No logical changes introduced.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>



> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 8488238..d18b95e 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2026,9 +2026,10 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops = {
>   	.free = pnv_ioda2_table_free,
>   };
>
> -static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
> -				      struct pnv_ioda_pe *pe, unsigned int base,
> -				      unsigned int segs)
> +static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
> +				       struct pnv_ioda_pe *pe,
> +				       unsigned int base,
> +				       unsigned int segs)
>   {
>
>   	struct page *tce_mem = NULL;
> @@ -2616,7 +2617,7 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>   		if (phb->type == PNV_PHB_IODA1) {
>   			pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
>   				pe->dma_weight, segs);
> -			pnv_pci_ioda_setup_dma_pe(phb, pe, base, segs);
> +			pnv_pci_ioda1_setup_dma_pe(phb, pe, base, segs);
>   		} else if (phb->type == PNV_PHB_IODA2) {
>   			pe_info(pe, "Assign DMA32 space\n");
>   			segs = 0;
>


-- 
Alexey
