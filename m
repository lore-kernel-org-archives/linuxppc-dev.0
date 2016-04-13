Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x229.google.com (mail-pf0-x229.google.com
 [IPv6:2607:f8b0:400e:c00::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlCdn6CPBzDqCQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 15:53:17 +1000 (AEST)
Received: by mail-pf0-x229.google.com with SMTP id 184so27966728pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 22:53:17 -0700 (PDT)
Subject: Re: [PATCH v8 05/45] powerpc/powernv: Drop phb->bdfn_to_pe()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-6-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <570DDEC5.308@ozlabs.ru>
Date: Wed, 13 Apr 2016 15:53:09 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-6-git-send-email-gwshan@linux.vnet.ibm.com>
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
> This drops struct pnv_phb::bdfn_to_pe() as nobody uses it.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>



> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 9 ---------
>   arch/powerpc/platforms/powernv/pci.h      | 1 -
>   2 files changed, 10 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 524c9c7..10ecd97 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -3195,12 +3195,6 @@ static bool pnv_pci_enable_device_hook(struct pci_dev *dev)
>   	return true;
>   }
>
> -static u32 pnv_ioda_bdfn_to_pe(struct pnv_phb *phb, struct pci_bus *bus,
> -			       u32 devfn)
> -{
> -	return phb->ioda.pe_rmap[(bus->number << 8) | devfn];
> -}
> -
>   static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
>   {
>   	struct pnv_phb *phb = hose->private_data;
> @@ -3377,9 +3371,6 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>   	phb->freeze_pe = pnv_ioda_freeze_pe;
>   	phb->unfreeze_pe = pnv_ioda_unfreeze_pe;
>
> -	/* Setup RID -> PE mapping function */
> -	phb->bdfn_to_pe = pnv_ioda_bdfn_to_pe;
> -
>   	/* Setup TCEs */
>   	phb->dma_dev_setup = pnv_pci_ioda_dma_dev_setup;
>
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 3f814f3..78f035e 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -110,7 +110,6 @@ struct pnv_phb {
>   			 unsigned int is_64, struct msi_msg *msg);
>   	void (*dma_dev_setup)(struct pnv_phb *phb, struct pci_dev *pdev);
>   	void (*fixup_phb)(struct pci_controller *hose);
> -	u32 (*bdfn_to_pe)(struct pnv_phb *phb, struct pci_bus *bus, u32 devfn);
>   	int (*init_m64)(struct pnv_phb *phb);
>   	void (*reserve_m64_pe)(struct pci_bus *bus,
>   			       unsigned long *pe_bitmap, bool all);
>


-- 
Alexey
