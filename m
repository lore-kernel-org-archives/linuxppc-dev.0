Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com
 [IPv6:2607:f8b0:400e:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1MVr22hhzDqGM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 16:36:20 +1000 (AEST)
Received: by mail-pf0-x22c.google.com with SMTP id 206so46680240pfu.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 May 2016 23:36:20 -0700 (PDT)
Subject: Re: [PATCH v9 03/22] powerpc/powernv: Move
 pnv_pci_ioda_setup_opal_tce_kill() around
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462281773-26438-4-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 robherring2@gmail.com, dja@axtens.net, alistair@popple.id.au
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <fa00763e-c425-cd49-b606-70ad0ce61fce@ozlabs.ru>
Date: Fri, 6 May 2016 16:36:11 +1000
MIME-Version: 1.0
In-Reply-To: <1462281773-26438-4-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/03/2016 11:22 PM, Gavin Shan wrote:
> pnv_pci_ioda_setup_opal_tce_kill() called by pnv_ioda_setup_dma()
> to remap the TCE kill regiter. What's done in pnv_ioda_setup_dma()
> will be covered in pcibios_setup_bridge() which is invoked on each
> PCI bridge. It means we will possibly remap the TCE kill register
> for multiple times and it's unnecessary.
>
> This moves pnv_pci_ioda_setup_opal_tce_kill() to where the PHB is
> initialized (pnv_pci_init_ioda_phb()) to avoid above issue.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 5ee8a57..cbd4c0b 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2599,8 +2599,6 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>  	pr_info("PCI: Domain %04x has %d available 32-bit DMA segments\n",
>  		hose->global_number, phb->ioda.dma32_count);
>
> -	pnv_pci_ioda_setup_opal_tce_kill(phb);
> -
>  	/* Walk our PE list and configure their DMA segments */
>  	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
>  		weight = pnv_pci_ioda_pe_dma_weight(pe);
> @@ -3396,6 +3394,9 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>  	if (phb->regs == NULL)
>  		pr_err("  Failed to map registers !\n");
>
> +	/* Initialize TCE kill register */
> +	pnv_pci_ioda_setup_opal_tce_kill(phb);
> +
>  	/* Initialize more IODA stuff */
>  	phb->ioda.total_pe_num = 1;
>  	prop32 = of_get_property(np, "ibm,opal-num-pes", NULL);
>


-- 
Alexey
