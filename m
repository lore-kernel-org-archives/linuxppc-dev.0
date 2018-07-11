Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41QZ1Z0rxwzDqx6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 19:45:20 +1000 (AEST)
Received: by mail-it0-x241.google.com with SMTP id p17-v6so2643299itc.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 02:45:20 -0700 (PDT)
Date: Wed, 11 Jul 2018 19:45:10 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Russell Currey
 <ruscur@russell.cc>, Alistair Popple <alistair@popple.id.au>, Balbir Singh
 <bsingharora@gmail.com>, Stewart Smith <stewart@linux.ibm.com>
Subject: Re: [PATCH kernel] powerpc/ioda/npu2: Call hot reset skiboot hook
 when disabling NPU
Message-ID: <20180711194510.0bc8dc39@aik.ozlabs.ibm.com>
In-Reply-To: <20180607070607.16037-1-aik@ozlabs.ru>
References: <20180607070607.16037-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu,  7 Jun 2018 17:06:07 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> This brings NPU2 in a safe mode when it does not throw HMI if GPU
> coherent memory is gone.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>


Anyone, ping?


> ---
> 
> The main aim for this is nvlink2 pass through, helps a lot.
> 
> 
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 66c2804..29f798c 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -3797,6 +3797,16 @@ static void pnv_pci_release_device(struct pci_dev *pdev)
>  		pnv_ioda_release_pe(pe);
>  }
>  
> +void pnv_npu_disable_device(struct pci_dev *pdev)
> +{
> +	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
> +	struct eeh_pe *eehpe = edev ? edev->pe : NULL;
> +
> +	if (eehpe && eeh_ops && eeh_ops->reset) {
> +		eeh_ops->reset(eehpe, EEH_RESET_HOT);
> +	}
> +}
> +
>  static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
>  {
>  	struct pnv_phb *phb = hose->private_data;
> @@ -3841,6 +3851,7 @@ static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
>  	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
>  	.dma_set_mask		= pnv_npu_dma_set_mask,
>  	.shutdown		= pnv_pci_ioda_shutdown,
> +	.disable_device		= pnv_npu_disable_device,
>  };
>  
>  static const struct pci_controller_ops pnv_npu_ocapi_ioda_controller_ops = {
> -- 
> 2.11.0
> 



--
Alexey
