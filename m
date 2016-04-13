Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x22a.google.com (mail-pf0-x22a.google.com
 [IPv6:2607:f8b0:400e:c00::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlDpP5w84zDqHZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 16:45:49 +1000 (AEST)
Received: by mail-pf0-x22a.google.com with SMTP id n1so28636560pfn.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 23:45:49 -0700 (PDT)
Subject: Re: [PATCH v8 09/45] powerpc/powernv: Simplify pnv_ioda_setup_pe_seg()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-10-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <570DEB13.10906@ozlabs.ru>
Date: Wed, 13 Apr 2016 16:45:39 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-10-git-send-email-gwshan@linux.vnet.ibm.com>
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
> The original implementation of pnv_ioda_setup_pe_seg() configures
> IO and M32 segments by separate logics, which can be merged by
> by caching @segmap, @seg_size, @win in advance. This shouldn't
> cause any behavioural changes.
 >
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 62 ++++++++++++++-----------------
>   1 file changed, 28 insertions(+), 34 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 44cc5f3..fd7d382 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2940,8 +2940,10 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>   	struct pnv_phb *phb = hose->private_data;
>   	struct pci_bus_region region;
>   	struct resource *res;
> -	int i, index;
> -	int rc;
> +	unsigned int segsize;
> +	int *segmap, index, i;
> +	uint16_t win;
> +	int64_t rc;
>
>   	/*
>   	 * NOTE: We only care PCI bus based PE for now. For PCI
> @@ -2958,23 +2960,9 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>   		if (res->flags & IORESOURCE_IO) {
>   			region.start = res->start - phb->ioda.io_pci_base;
>   			region.end   = res->end - phb->ioda.io_pci_base;
> -			index = region.start / phb->ioda.io_segsize;
> -
> -			while (index < phb->ioda.total_pe_num &&
> -			       region.start <= region.end) {
> -				phb->ioda.io_segmap[index] = pe->pe_number;
> -				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
> -					pe->pe_number, OPAL_IO_WINDOW_TYPE, 0, index);
> -				if (rc != OPAL_SUCCESS) {
> -					pr_err("%s: OPAL error %d when mapping IO "
> -					       "segment #%d to PE#%d\n",
> -					       __func__, rc, index, pe->pe_number);
> -					break;
> -				}
> -
> -				region.start += phb->ioda.io_segsize;
> -				index++;
> -			}
> +			segsize      = phb->ioda.io_segsize;
> +			segmap       = phb->ioda.io_segmap;
> +			win          = OPAL_IO_WINDOW_TYPE;
>   		} else if ((res->flags & IORESOURCE_MEM) &&
>   			   !pnv_pci_is_mem_pref_64(res->flags)) {
>   			region.start = res->start -
> @@ -2983,23 +2971,29 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>   			region.end   = res->end -
>   				       hose->mem_offset[0] -
>   				       phb->ioda.m32_pci_base;
> -			index = region.start / phb->ioda.m32_segsize;
> -
> -			while (index < phb->ioda.total_pe_num &&
> -			       region.start <= region.end) {
> -				phb->ioda.m32_segmap[index] = pe->pe_number;
> -				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
> -					pe->pe_number, OPAL_M32_WINDOW_TYPE, 0, index);
> -				if (rc != OPAL_SUCCESS) {
> -					pr_err("%s: OPAL error %d when mapping M32 "
> -					       "segment#%d to PE#%d",
> -					       __func__, rc, index, pe->pe_number);
> -					break;
> -				}
> +			segsize      = phb->ioda.m32_segsize;
> +			segmap       = phb->ioda.m32_segmap;
> +			win          = OPAL_M32_WINDOW_TYPE;
> +		} else {
> +			continue;
> +		}
>
> -				region.start += phb->ioda.m32_segsize;
> -				index++;
> +		index = region.start / segsize;
> +		while (index < phb->ioda.total_pe_num &&
> +		       region.start <= region.end) {
> +			segmap[index] = pe->pe_number;
> +			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
> +					pe->pe_number, win, 0, index);
> +			if (rc != OPAL_SUCCESS) {
> +				pr_warn("%s: Error %lld mapping (%d) seg#%d to PHB#%d-PE#%d\n",
> +					__func__, rc, win, index,
> +					pe->phb->hose->global_number,
> +					pe->pe_number);
> +				break;

Please move this loop to a helper and stop caching segsize/segmap/win; this 
will make the code easier to read and the next patch will look much cleaner 
as it will not have to move this exact loop.


>   			}
> +
> +			region.start += segsize;
> +			index++;
>   		}
>   	}
>   }
>


-- 
Alexey
