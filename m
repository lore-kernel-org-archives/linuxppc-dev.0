Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0035B1A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 16:30:19 +1000 (AEST)
Received: by pdrg1 with SMTP id g1so67934810pdr.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Aug 2015 23:30:17 -0700 (PDT)
Subject: Re: [PATCH v6 03/42] powerpc/powernv: Enable M64 on P7IOC
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-4-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com, panto@antoniou-consulting.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55C844F1.6060404@ozlabs.ru>
Date: Mon, 10 Aug 2015 16:30:09 +1000
MIME-Version: 1.0
In-Reply-To: <1438834307-26960-4-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/06/2015 02:11 PM, Gavin Shan wrote:
> The patch enables M64 window on P7IOC, which has been enabled on
> PHB3. Different from PHB3 where 16 M64 BARs are supported and each
> of them can be owned by one particular PE# exclusively or divided
> evenly to 256 segments, each P7IOC PHB has 16 M64 BARs and each
> of them are divided into 8 segments.

Is this a limitation of POWER7 chip or it is from IODA1?


> So each P7IOC PHB can support
> 128 M64 segments only. Also, P7IOC has M64DT, which helps mapping
> one particular M64 segment# to arbitrary PE#. PHB3 doesn't have
> M64DT, indicating that one M64 segment can only be pinned to the
> fixed PE#. In order to have similar logic to support M64 for PHB3
> and P7IOC, we just provide 128 M64 (16 BARs) segments and fixed
> mapping between PE# and M64 segment# on P7IOC. In turn, we just
> need different phb->init_m64() hooks for P7IOC and PHB3 to support
> M64.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 116 ++++++++++++++++++++++++++----
>   1 file changed, 104 insertions(+), 12 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 38b5405..e4ac703 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -172,6 +172,69 @@ static void pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
>   	clear_bit(pe, phb->ioda.pe_alloc);
>   }
>
> +static int pnv_ioda1_init_m64(struct pnv_phb *phb)
> +{
> +	struct resource *r;
> +	int seg;
> +
> +	/* There are as many M64 segments as the maximum number
> +	 * of PEs, which is 128.
> +	 */
> +	for (seg = 0; seg < phb->ioda.total_pe; seg += 8) {


This "8" is used a lot across the patch, please make it a macro 
(PNV_PHB_P7IOC_SEGNUM or PNV_PHB_IODA1_SEGNUM or whatever you think it is) 
with a short comment why it is "8". Or a pnv_phb member.


> +		unsigned long base;
> +		int64_t rc;
> +
> +		base = phb->ioda.m64_base + seg * phb->ioda.m64_segsize;
> +		rc = opal_pci_set_phb_mem_window(phb->opal_id,
> +						 OPAL_M64_WINDOW_TYPE,
> +						 seg / 8,
> +						 base,
> +						 0, /* unused */
> +						 8 * phb->ioda.m64_segsize);
> +		if (rc != OPAL_SUCCESS) {
> +			pr_warn("  Error %lld setting M64 PHB#%d-BAR#%d\n",
> +				rc, phb->hose->global_number, seg / 8);
> +			goto fail;
> +		}
> +
> +		rc = opal_pci_phb_mmio_enable(phb->opal_id,
> +					      OPAL_M64_WINDOW_TYPE,
> +					      seg / 8,
> +					      OPAL_ENABLE_M64_SPLIT);
> +		if (rc != OPAL_SUCCESS) {
> +			pr_warn("  Error %lld enabling M64 PHB#%d-BAR#%d\n",
> +				rc, phb->hose->global_number, seg / 8);
> +			goto fail;
> +		}
> +	}
> +
> +	/* Strip off the segment used by the reserved PE, which

What is this reserved PE on P7IOC? "Strip off" means "exclude" here?


> +	 * is expected to be 0 or last supported PE#. The PHB's
> +	 * first memory window traces the 32-bits MMIO range

s/traces/filters/ ? Or I did not understand this comment...


> +	 * while the second one traces the 64-bits prefetchable
> +	 * MMIO range that the PHB supports.

32/64 ranges comment seems irrelevant here.


> +	 */
> +	r = &phb->hose->mem_resources[1];
> +	if (phb->ioda.reserved_pe == 0)
> +		r->start += phb->ioda.m64_segsize;
> +	else if (phb->ioda.reserved_pe == (phb->ioda.total_pe - 1))
> +		r->end -= phb->ioda.m64_segsize;
> +	else
> +		pr_warn("  Cannot strip M64 segment for reserved PE#%d\n",
> +			phb->ioda.reserved_pe);
> +
> +	return 0;
> +
> +fail:
> +	for ( ; seg >= 0; seg -= 8)
> +		opal_pci_phb_mmio_enable(phb->opal_id,
> +					 OPAL_M64_WINDOW_TYPE,
> +					 seg / 8,
> +					 OPAL_DISABLE_M64);
> +
> +	return -EIO;
> +}
> +
>   /* The default M64 BAR is shared by all PEs */
>   static int pnv_ioda2_init_m64(struct pnv_phb *phb)
>   {
> @@ -256,9 +319,9 @@ static void pnv_ioda2_reserve_dev_m64_pe(struct pci_dev *pdev,
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
> @@ -266,12 +329,12 @@ static void pnv_ioda2_reserve_m64_pe(struct pci_bus *bus,
>   		pnv_ioda2_reserve_dev_m64_pe(pdev, pe_bitmap);
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
> @@ -293,7 +356,7 @@ static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
>   	}
>
>   	/* Figure out reserved PE numbers by the PE */
> -	pnv_ioda2_reserve_m64_pe(bus, pe_alloc, all);
> +	pnv_ioda_reserve_m64_pe(bus, pe_alloc, all);
>
>   	/*
>   	 * the current bus might not own M64 window and that's all
> @@ -324,6 +387,26 @@ static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
>   			pe->master = master_pe;
>   			list_add_tail(&pe->list, &master_pe->slaves);
>   		}
> +
> +		/* P7IOC supports M64DT, which helps mapping M64 segment
> +		 * to one particular PE#. However, PHB3 has fixed mapping
> +		 * between M64 segment and PE#. In order to have same logic
> +		 * for P7IOC and PHB3, we enforce fixed mapping between M64
> +		 * segment and PE# on P7IOC.
> +		 */
> +		if (phb->type == PNV_PHB_IODA1) {
> +			int64_t rc;
> +
> +			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
> +							 pe->pe_number,
> +							 OPAL_M64_WINDOW_TYPE,
> +							 pe->pe_number / 8,
> +							 pe->pe_number % 8);
> +			if (rc != OPAL_SUCCESS)
> +				pr_warn("%s: Error %lld mapping M64 for PHB#%d-PE#%d\n",
> +					__func__, rc, phb->hose->global_number,
> +					pe->pe_number);
> +		}
>   	}
>
>   	kfree(pe_alloc);
> @@ -338,8 +421,8 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>   	const u32 *r;
>   	u64 pci_addr;
>
> -	/* FIXME: Support M64 for P7IOC */
> -	if (phb->type != PNV_PHB_IODA2) {
> +	if (phb->type != PNV_PHB_IODA1 &&
> +	    phb->type != PNV_PHB_IODA2) {
>   		pr_info("  Not support M64 window\n");
>   		return;


You are adding P7IOC support so at least "fixme" should go. Also, 
pnv_ioda_parse_m64_window() is only called from pnv_pci_init_ioda_phb() 
which is called only with PNV_PHB_IODA1 and PNV_PHB_IODA2 (no other value 
is passed there a type) so the check above will never succeed, just remove it.



>   	}
> @@ -372,9 +455,18 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>
>   	/* Use last M64 BAR to cover M64 window */
>   	phb->ioda.m64_bar_idx = 15;
> -	phb->init_m64 = pnv_ioda2_init_m64;
> -	phb->reserve_m64_pe = pnv_ioda2_reserve_m64_pe;
> -	phb->pick_m64_pe = pnv_ioda2_pick_m64_pe;
> +	phb->reserve_m64_pe = pnv_ioda_reserve_m64_pe;
> +	phb->pick_m64_pe = pnv_ioda_pick_m64_pe;
> +	switch (phb->type) {
> +	case PNV_PHB_IODA1:
> +		phb->init_m64 = pnv_ioda1_init_m64;
> +		break;
> +	case PNV_PHB_IODA2:
> +		phb->init_m64 = pnv_ioda2_init_m64;
> +		break;
> +	default:
> +		pr_debug("   M64 not supported\n");
> +	}
>   }
>
>   static void pnv_ioda_freeze_pe(struct pnv_phb *phb, int pe_no)
>


-- 
Alexey
