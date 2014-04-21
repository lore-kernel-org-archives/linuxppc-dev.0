Return-Path: <benh@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7C0B914008D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 13:37:38 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 21 Apr 2014 13:37:37 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1E2022BB004A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 13:37:34 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3L3bJlS10879286
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 13:37:19 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3L3bX7J023708
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 13:37:33 +1000
Message-ID: <1398051452.19682.15.camel@pasglop>
Subject: Re: [PATCH 2/2] powerpc/powernc: revert part of commit
 d905c5df(PPC: POWERNV: move iommu_add_device earlier)
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Date: Mon, 21 Apr 2014 13:37:32 +1000
In-Reply-To: <1398047119-6861-2-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1398047119-6861-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1398047119-6861-2-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@au1.ibm.com, linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-04-21 at 10:25 +0800, Wei Yang wrote:
> Here is a draft call flow:
> 
> pci_device_add
>    pcibios_add_device
>       pci_dma_dev_setup
>          pnv_pci_dma_dev_setup
>             pnv_pci_ioda_dma_dev_setup
>                set_iommu_table_base_and_group <--- here
> device_add
> 
> When set_iommu_table_base_and_group() is invoked int
> pnv_pci_ioda_dma_dev_setup(), the dev->kobj->sd is not initialized. The
> dev->kobj->sd is initialized in device_add().
> 
> After applying this patch, the error
>     iommu_tce: 0003:05:00.0 has not been added, ret=-14
> is cleared.
> 
> This patch revert the change for pnv_pci_ioda_dma_dev_setup() from commit
> d905c5df(PPC: POWERNV: move iommu_add_device earlier).

But in that case, is the group still set ?

Alexey, is that correct ?

Cheers,
Ben.

> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index fc4edda..b5d8f73 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1425,7 +1425,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
>  
>  	pe = &phb->ioda.pe_array[pdn->pe_number];
>  	WARN_ON(get_dma_ops(&pdev->dev) != &dma_iommu_ops);
> -	set_iommu_table_base_and_group(&pdev->dev, &pe->tce32_table);
> +	set_iommu_table_base(&pdev->dev, &pe->tce32_table);
>  }
>  
>  static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
