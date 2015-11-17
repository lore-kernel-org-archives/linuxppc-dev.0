Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 918E01A06CE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 10:59:19 +1100 (AEDT)
Received: by pacdm15 with SMTP id dm15so24023222pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 15:59:17 -0800 (PST)
Subject: Re: [PATCH v7 17/50] powerpc/powernv: Avoid calculating DMA32
 segments on PHB3
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-18-git-send-email-gwshan@linux.vnet.ibm.com>
 <564A7DC5.5060702@ozlabs.ru> <20151117084815.GB16586@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <564BBF4E.9070705@ozlabs.ru>
Date: Wed, 18 Nov 2015 10:59:10 +1100
MIME-Version: 1.0
In-Reply-To: <20151117084815.GB16586@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/17/2015 07:48 PM, Gavin Shan wrote:
> On Tue, Nov 17, 2015 at 12:07:17PM +1100, Alexey Kardashevskiy wrote:
>> On 11/05/2015 12:12 AM, Gavin Shan wrote:
>>> In pnv_ioda_setup_dma(), it's unnecessary to calculate the DMA32
>>> segments for PEs on PHB3 as the whole available DMA32 space can
>>> be assigned to one specific PE on PHB3.
>>>
>>> This splits pnv_ioda_setup_dma() to pnv_pci_ioda1_setup_dma() and
>>> pnv_pci_ioda2_setup_dma() in order to avoid calculating DMA32
>>> segments for PEs on PHB3. No logical changes introduced.
>>
>>
>> This patch is not needed as
>>
>> [PATCH v7 20/50] powerpc/powernv: Improve DMA32 segment calculation
>>
>> moves this calculation to another place (which already makes this patch
>> unnecessary) and
>>
>
> I don't follow your comments, can you tell me how to split/merge the patches?


Remove this patch, it is useless. Just do git rebase, remove this one and 
resolve conflicts in the next ones. I would suggest merging it into 26/50 
but I think you'll have conflicts between 17/50 and 26/50 anyway.



>> [PATCH v7 26/50] powerpc/powernv: Create PEs at PCI hot plugging time
>>
>> removes just introduced pnv_pci_ioda1_setup_dma() - if you remove it, then
>> there is no point in fixing it in the first place.
>>
>
> This function isn't removed in 26/50, could you double check?


Sure:

[PATCH v7 26/50] powerpc/powernv: Create PEs at PCI hot plugging time

@@ -2424,33 +2415,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct 
pnv_phb *phb,
  		pnv_ioda_setup_bus_dma(pe, pe->pbus);
  }

-static void pnv_pci_ioda1_setup_dma(struct pnv_phb *phb)
-{
-	struct pnv_ioda_pe *pe;
-
-	pnv_pci_ioda_setup_opal_tce_kill(phb);
-
-	list_for_each_entry(pe, &phb->ioda.pe_list, list)
-		pnv_pci_ioda1_setup_dma_pe(phb, pe);
-}




>
>>>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> ---
>>>   arch/powerpc/platforms/powernv/pci-ioda.c | 41 ++++++++++++++++++-------------
>>>   1 file changed, 24 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>> index 5a08e20..4c2e023 100644
>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>> @@ -2383,7 +2383,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>>   		pnv_ioda_setup_bus_dma(pe, pe->pbus);
>>>   }
>>>
>>> -static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>>> +static void pnv_pci_ioda1_setup_dma(struct pnv_phb *phb)
>>>   {
>>>   	struct pci_controller *hose = phb->hose;
>>>   	unsigned int residual, remaining, segs, tw, base;
>>> @@ -2428,26 +2428,30 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>>>   				segs = remaining;
>>>   		}
>>>
>>> -		/*
>>> -		 * For IODA2 compliant PHB3, we needn't care about the weight.
>>> -		 * The all available 32-bits DMA space will be assigned to
>>> -		 * the specific PE.
>>> -		 */
>>> -		if (phb->type == PNV_PHB_IODA1) {
>>> -			pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
>>> -				pe->dma_weight, segs);
>>> -			pnv_pci_ioda1_setup_dma_pe(phb, pe, base, segs);
>>> -		} else {
>>> -			pe_info(pe, "Assign DMA32 space\n");
>>> -			segs = 0;
>>> -			pnv_pci_ioda2_setup_dma_pe(phb, pe);
>>> -		}
>>> +		pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
>>> +			pe->dma_weight, segs);
>>> +		pnv_pci_ioda1_setup_dma_pe(phb, pe, base, segs);
>>>
>>>   		remaining -= segs;
>>>   		base += segs;
>>>   	}
>>>   }
>>>
>>> +static void pnv_pci_ioda2_setup_dma(struct pnv_phb *phb)
>>> +{
>>> +	struct pnv_ioda_pe *pe;
>>> +
>>> +	pnv_pci_ioda_setup_opal_tce_kill(phb);
>>> +
>>> +	list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
>>> +		if (!pe->dma_weight)
>>> +			continue;
>>> +
>>> +		pe_info(pe, "Assign DMA32 space\n");
>>> +		pnv_pci_ioda2_setup_dma_pe(phb, pe);
>>> +	}
>>> +}
>>> +
>>>   #ifdef CONFIG_PCI_MSI
>>>   static void pnv_ioda2_msi_eoi(struct irq_data *d)
>>>   {
>>> @@ -2931,10 +2935,13 @@ static void pnv_pci_ioda_setup_DMA(void)
>>>   	struct pnv_phb *phb;
>>>
>>>   	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>>> -		pnv_ioda_setup_dma(hose->private_data);
>>> +		phb = hose->private_data;
>>> +		if (phb->type == PNV_PHB_IODA1)
>>> +			pnv_pci_ioda1_setup_dma(phb);
>>> +		else
>>> +			pnv_pci_ioda2_setup_dma(phb);
>>>
>>>   		/* Mark the PHB initialization done */
>>> -		phb = hose->private_data;
>>>   		phb->initialized = 1;
>>>   	}
>>>   }
>>>
>>
>>
>> --
>> Alexey
>>
>


-- 
Alexey
