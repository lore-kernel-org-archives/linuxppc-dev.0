Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3AE1E1A039F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 12:39:13 +1000 (AEST)
Received: by pacgr6 with SMTP id gr6so39622898pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 19:39:11 -0700 (PDT)
Subject: Re: [PATCH v6 10/42] powerpc/powernv: pnv_ioda_setup_dma() configure
 one PE only
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-11-git-send-email-gwshan@linux.vnet.ibm.com>
 <55C86F5F.70603@ozlabs.ru> <20150811002949.GA16482@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55C96046.90102@ozlabs.ru>
Date: Tue, 11 Aug 2015 12:39:02 +1000
MIME-Version: 1.0
In-Reply-To: <20150811002949.GA16482@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/11/2015 10:29 AM, Gavin Shan wrote:
> On Mon, Aug 10, 2015 at 07:31:11PM +1000, Alexey Kardashevskiy wrote:
>> On 08/06/2015 02:11 PM, Gavin Shan wrote:
>>> The original implementation of pnv_ioda_setup_dma() iterates the
>>> list of PEs and configures the DMA32 space for them one by one.
>>> The function was designed to be called during PHB fixup time.
>>> When configuring PE's DMA32 space in pcibios_setup_bridge(), in
>>> order to support PCI hotplug, we have to have the function PE
>>> oriented.
>>>
>>> This renames pnv_ioda_setup_dma() to pnv_ioda1_setup_dma() and
>>> adds one more argument "struct pnv_ioda_pe *pe" to it. The caller,
>>> pnv_pci_ioda_setup_DMA(), gets PE from the list and passes to it
>>> or pnv_pci_ioda2_setup_dma_pe(). The patch shouldn't cause behavioral
>>> changes.
>>>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> ---
>>>   arch/powerpc/platforms/powernv/pci-ioda.c | 75 +++++++++++++++----------------
>>>   1 file changed, 36 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>> index 8456f37..cd22002 100644
>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>> @@ -2443,52 +2443,29 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>>   		pnv_ioda_setup_bus_dma(pe, pe->pbus);
>>>   }
>>>
>>> -static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>>> +static unsigned int pnv_ioda1_setup_dma(struct pnv_phb *phb,
>>> +					struct pnv_ioda_pe *pe,
>>> +					unsigned int base)
>>>   {
>>>   	struct pci_controller *hose = phb->hose;
>>> -	struct pnv_ioda_pe *pe;
>>> -	unsigned int dma_weight;
>>> +	unsigned int dma_weight, segs;
>>>
>>>   	/* Calculate the PHB's DMA weight */
>>>   	dma_weight = pnv_ioda_phb_dma_weight(phb);
>>>   	pr_info("PCI%04x has %ld DMA32 segments, total weight %d\n",
>>>   		hose->global_number, phb->ioda.dma32_segcount, dma_weight);
>>>
>>> -	pnv_pci_ioda_setup_opal_tce_kill(phb);
>>> -
>>> -	/* Walk our PE list and configure their DMA segments, hand them
>>> -	 * out one base segment plus any residual segments based on
>>> -	 * weight
>>> -	 */
>>> -	list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
>>> -		if (!pe->dma32_weight)
>>> -			continue;
>>> -
>>> -		/*
>>> -		 * For IODA2 compliant PHB3, we needn't care about the weight.
>>> -		 * The all available 32-bits DMA space will be assigned to
>>> -		 * the specific PE.
>>> -		 */
>>> -		if (phb->type == PNV_PHB_IODA1) {
>>> -			unsigned int segs, base = 0;
>>> -
>>> -			if (pe->dma32_weight <
>>> -			    dma_weight / phb->ioda.dma32_segcount)
>>> -				segs = 1;
>>> -			else
>>> -				segs = (pe->dma32_weight *
>>> -					phb->ioda.dma32_segcount) / dma_weight;
>>> -
>>> -			pe_info(pe, "DMA32 weight %d, assigned %d segments\n",
>>> -				pe->dma32_weight, segs);
>>> -			pnv_pci_ioda_setup_dma_pe(phb, pe, base, segs);
>>> +	if (pe->dma32_weight <
>>> +	    dma_weight / phb->ioda.dma32_segcount)
>>
>> Can be one line now.
>>
>
> Indeed.
>
>>> +		segs = 1;
>>> +	else
>>> +		segs = (pe->dma32_weight *
>>> +			phb->ioda.dma32_segcount) / dma_weight;
>>> +	pe_info(pe, "DMA weight %d, assigned %d segments\n",
>>> +		pe->dma32_weight, segs);
>>> +	pnv_pci_ioda_setup_dma_pe(phb, pe, base, segs);
>>
>>
>> Why not to merge pnv_ioda1_setup_dma() to pnv_pci_ioda_setup_dma_pe()?
>>
>
> There're two reasons:
> - They're separate logically. One is calculating number of DMA32 segments required.
>    Another one is allocate TCE32 tables and configure devices with them.
> - In PCI hotplug path, I need pnv_ioda1_setup_dma() which has "pe" as parameter.


And hotplug path does not care about dma weight why?


>
>>>
>>> -			base += segs;
>>> -		} else {
>>> -			pe_info(pe, "Assign DMA32 space\n");
>>> -			pnv_pci_ioda2_setup_dma_pe(phb, pe);
>>> -		}
>>> -	}
>>> +	return segs;
>>>   }
>>>
>>>   #ifdef CONFIG_PCI_MSI
>>> @@ -2955,12 +2932,32 @@ static void pnv_pci_ioda_setup_DMA(void)
>>>   {
>>>   	struct pci_controller *hose, *tmp;
>>>   	struct pnv_phb *phb;
>>> +	struct pnv_ioda_pe *pe;
>>> +	unsigned int base;
>>>
>>>   	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>>> -		pnv_ioda_setup_dma(hose->private_data);
>>> +		phb = hose->private_data;
>>> +		pnv_pci_ioda_setup_opal_tce_kill(phb);
>>> +
>>> +		base = 0;
>>> +		list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
>>> +			if (!pe->dma32_weight)
>>> +				continue;
>>> +
>>> +			switch (phb->type) {
>>> +			case PNV_PHB_IODA1:
>>> +				base += pnv_ioda1_setup_dma(phb, pe, base);
>>
>>
>> This @base handling seems never be tested between 8..11 as "[PATCH v6 11/42]
>> powerpc/powernv: Trace DMA32 segments consumed by PE"
>> removes it and I suspect you only tested the final version. Which is ok for
>> the final result but not ok for bisectability.
>>
>> Looks like 8/42, 9/42, 10/42, 11/42 need to be rearranged or merged to remove
>> this multiple @base touching.
>>
>
> Why ?

You are touching this @base from 8/42 to 11/12 and in between it is very 
broken, you only get it fixed (by removing) in 11/42. Read my comment for 
8/42. After every single patch in any patchset the functionality should not 
break but it does in this patchset.


>
>>
>>> +				break;
>>> +			case PNV_PHB_IODA2:
>>> +				pnv_pci_ioda2_setup_dma_pe(phb, pe);
>>> +				break;
>>> +			default:
>>> +				pr_warn("%s: No DMA for PHB type %d\n",
>>> +					__func__, phb->type);
>>> +			}
>>> +		}
>>>
>>>   		/* Mark the PHB initialization done */
>>> -		phb = hose->private_data;
>>>   		phb->initialized = 1;
>>>   	}
>>>   }
>>>
>
> Thanks,
> Gavin
>


-- 
Alexey
