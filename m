Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A5921A074D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 11:18:56 +1100 (AEDT)
Received: by pabfh17 with SMTP id fh17so62767313pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 16:18:54 -0800 (PST)
Subject: Re: [PATCH v7 14/50] powerpc/powernv: M64 support on P7IOC
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-15-git-send-email-gwshan@linux.vnet.ibm.com>
 <56498D6A.7010905@ozlabs.ru> <20151117013713.GA31584@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <564D1566.5020708@ozlabs.ru>
Date: Thu, 19 Nov 2015 11:18:46 +1100
MIME-Version: 1.0
In-Reply-To: <20151117013713.GA31584@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/17/2015 12:37 PM, Gavin Shan wrote:
> On Mon, Nov 16, 2015 at 07:01:46PM +1100, Alexey Kardashevskiy wrote:
>> On 11/05/2015 12:12 AM, Gavin Shan wrote:
>>> This enables M64 window on P7IOC, which has been enabled on PHB3.
>>> Different from PHB3 where 16 M64 BARs are supported and each of
>>> them can be owned by one particular PE# exclusively or divided
>>> evenly to 256 segments, every P7IOC PHB has 16 M64 BARs and each
>>> of them are divided to 8 segments. So every P7IOC PHB supports
>>> 128 M64 segments in total. P7IOC has M64DT, which helps mapping
>>> one particular M64 segment# to arbitrary PE#. PHB3 doesn't have
>>> M64DT, indicating that one M64 segment can only be pinned to the
>>> fixed PE#. In order to have same code to support M64 on P7IOC and
>>> PHB3, we just provide 128 M64 segments on every P7IOC PHB and each
>>> of them is pinned to the fixed PE# by bypassing the function of
>>> M64DT. In turn, we just need different phb->init_m64() for P7IOC
>>> and PHB3 to support M64.
>>>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> ---
>>>   arch/powerpc/platforms/powernv/pci-ioda.c | 86 +++++++++++++++++++++++++++++--
>>>   arch/powerpc/platforms/powernv/pci.h      |  3 ++
>>>   2 files changed, 86 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>> index 1f7d985..bfe69f1 100644
>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>> @@ -256,6 +256,64 @@ static void pnv_ioda_reserve_dev_m64_pe(struct pci_dev *pdev,
>>>   	}
>>>   }
>>>
>>> +static int pnv_ioda1_init_m64(struct pnv_phb *phb)
>>> +{
>>> +	struct resource *r;
>>> +	int index;
>>> +
>>> +	/*
>>> +	 * There are 16 M64 BARs, each of which has 8 segments. So
>>> +	 * there are as many M64 segments as the maximum number of
>>> +	 * PEs, which is 128.
>>> +	 */
>>> +	for (index = 0; index < PNV_IODA1_M64_NUM; index++) {
>>> +		unsigned long base, segsz = phb->ioda.m64_segsize;
>>> +		int64_t rc;
>>> +
>>> +		base = phb->ioda.m64_base +
>>> +		       index * PNV_IODA1_M64_SEGS * segsz;
>>> +		rc = opal_pci_set_phb_mem_window(phb->opal_id,
>>> +				OPAL_M64_WINDOW_TYPE, index, base, 0,
>>> +				PNV_IODA1_M64_SEGS * segsz);
>>> +		if (rc != OPAL_SUCCESS) {
>>> +			pr_warn("  Error %lld setting M64 PHB#%d-BAR#%d\n",
>>> +				rc, phb->hose->global_number, index);
>>> +			goto fail;
>>> +		}
>>> +
>>> +		rc = opal_pci_phb_mmio_enable(phb->opal_id,
>>> +				OPAL_M64_WINDOW_TYPE, index,
>>> +				OPAL_ENABLE_M64_SPLIT);
>>> +		if (rc != OPAL_SUCCESS) {
>>> +			pr_warn("  Error %lld enabling M64 PHB#%d-BAR#%d\n",
>>> +				rc, phb->hose->global_number, index);
>>> +			goto fail;
>>> +		}
>>> +	}
>>> +
>>> +	/*
>>> +	 * Exclude the segment used by the reserved PE, which
>>> +	 * is expected to be 0 or last supported PE#.
>>> +	 */
>>> +	r = &phb->hose->mem_resources[1];
>>> +	if (phb->ioda.reserved_pe_idx == 0)
>>> +		r->start += phb->ioda.m64_segsize;
>>> +	else if (phb->ioda.reserved_pe_idx == (phb->ioda.total_pe_num - 1))
>>> +		r->end -= phb->ioda.m64_segsize;
>>> +	else
>>> +		pr_warn("  Cannot cut M64 segment for reserved PE#%d\n",
>>> +			phb->ioda.reserved_pe_idx);
>>> +
>>> +	return 0;
>>> +
>>> +fail:
>>> +	for ( ; index >= 0; index--)
>>> +		opal_pci_phb_mmio_enable(phb->opal_id,
>>> +			OPAL_M64_WINDOW_TYPE, index, OPAL_DISABLE_M64);
>>> +
>>> +	return -EIO;
>>> +}
>>> +
>>>   static void pnv_ioda_reserve_m64_pe(struct pci_bus *bus,
>>>   				    unsigned long *pe_bitmap,
>>>   				    bool all)
>>> @@ -325,6 +383,26 @@ static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>>>   			pe->master = master_pe;
>>>   			list_add_tail(&pe->list, &master_pe->slaves);
>>>   		}
>>> +
>>> +		/*
>>> +		 * P7IOC supports M64DT, which helps mapping M64 segment
>>> +		 * to one particular PE#. However, PHB3 has fixed mapping
>>> +		 * between M64 segment and PE#. In order to have same logic
>>> +		 * for P7IOC and PHB3, we enforce fixed mapping between M64
>>> +		 * segment and PE# on P7IOC.
>>> +		 */
>>> +		if (phb->type == PNV_PHB_IODA1) {
>>> +			int64_t rc;
>>> +
>>> +			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
>>> +					pe->pe_number, OPAL_M64_WINDOW_TYPE,
>>> +					pe->pe_number / PNV_IODA1_M64_SEGS,
>>> +					pe->pe_number % PNV_IODA1_M64_SEGS);
>>> +			if (rc != OPAL_SUCCESS)
>>> +				pr_warn("%s: Error %lld mapping M64 for PHB#%d-PE#%d\n",
>>> +					__func__, rc, phb->hose->global_number,
>>> +					pe->pe_number);
>>> +		}
>>>   	}
>>>
>>>   	kfree(pe_alloc);
>>> @@ -339,8 +417,7 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>>>   	const u32 *r;
>>>   	u64 pci_addr;
>>>
>>> -	/* FIXME: Support M64 for P7IOC */
>>> -	if (phb->type != PNV_PHB_IODA2) {
>>> +	if (phb->type != PNV_PHB_IODA1 && phb->type != PNV_PHB_IODA2) {
>>>   		pr_info("  Not support M64 window\n");
>>>   		return;
>>>   	}
>>> @@ -373,7 +450,10 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>>>
>>>   	/* Use last M64 BAR to cover M64 window */
>>>   	phb->ioda.m64_bar_idx = 15;
>>> -	phb->init_m64 = pnv_ioda2_init_m64;
>>> +	if (phb->type == PNV_PHB_IODA1)
>>> +		phb->init_m64 = pnv_ioda1_init_m64;
>>> +	else
>>> +		phb->init_m64 = pnv_ioda2_init_m64;
>>>   	phb->reserve_m64_pe = pnv_ioda_reserve_m64_pe;
>>>   	phb->pick_m64_pe = pnv_ioda_pick_m64_pe;
>>
>>
>> Nit: the callbacks initialization does not seem to relate to parsing any
>> window :) They could all go to where pnv_ioda_parse_m64_window() is called,
>> no separate patch is needed.
>>
>
> Well, what's the benifit for that? I personally prefer the way I had: initialize
> all callbacks in one place, not in separate places.

One place is good, agree. Which should have been a single phv_phb_ops 
instance as it is done everywhere else in the kernel. And the existing 
pnv_phb's callbacks are already initialized in various places, not a single 
one.


> However, if you have good
> reason to support your suggestion, I'll change accordingly for sure.

Nah, leave it as is for now, we will probably change this later.


>
>>
>>>   }
>>> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>> index 671fd13..c4019ac 100644
>>> --- a/arch/powerpc/platforms/powernv/pci.h
>>> +++ b/arch/powerpc/platforms/powernv/pci.h
>>> @@ -78,6 +78,9 @@ struct pnv_ioda_pe {
>>>   	struct list_head	list;
>>>   };
>>>
>>> +#define PNV_IODA1_M64_NUM	16	/* Number of M64 BARs   */
>>> +#define PNV_IODA1_M64_SEGS	8	/* Segments per M64 BAR */
>>> +
>>>   #define PNV_PHB_FLAG_EEH	(1 << 0)
>>>
>>>   struct pnv_phb {
>>>
>
> Thanks,
> Gavin
>


-- 
Alexey
