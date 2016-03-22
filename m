Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qTbFd2Wf1zDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 12:48:37 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id q129so33539511pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 18:48:37 -0700 (PDT)
Subject: Re: [PATCH kernel 08/10] powerpc/powernv/npu: Add NPU devices to
 IOMMU group
To: David Gibson <david@gibson.dropbear.id.au>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
 <1457504946-40649-9-git-send-email-aik@ozlabs.ru>
 <20160321044810.GG23586@voom.redhat.com> <56EFAFF3.5090404@ozlabs.ru>
 <20160322002550.GR23586@voom.redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56F0A46B.3040400@ozlabs.ru>
Date: Tue, 22 Mar 2016 12:48:27 +1100
MIME-Version: 1.0
In-Reply-To: <20160322002550.GR23586@voom.redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/22/2016 11:25 AM, David Gibson wrote:
> On Mon, Mar 21, 2016 at 07:25:23PM +1100, Alexey Kardashevskiy wrote:
>> On 03/21/2016 03:48 PM, David Gibson wrote:
>>> On Wed, Mar 09, 2016 at 05:29:04PM +1100, Alexey Kardashevskiy wrote:
>>>> NPU devices have their own TVT which means they are isolated and can be
>>>> passed to the userspace via VFIO. The first step is to create an IOMMU
>>>> group and attach devices there so does the patch.
>>>>
>>>> This adds a helper to npu-dma.c which gets GPU from the NPU's pdev and
>>>> then walks through all devices on the same bus to determine which NPUs
>>>> belong to the same GPU.
>>>>
>>>> This adds an additional loop over PEs in pnv_ioda_setup_dma() as the main
>>>> loop skips NPU PEs as they do not have 32bit DMA segments.
>>>>
>>>> This uses get_gpu_pci_dev_and_pe() to get @gpdev rather than
>>>> pnv_pci_get_gpu_dev() as the following patch will use @gpe as well.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>
>>> I'm not entirely clear on how these devices are assigned to groups.
>>> Do they each get their own groups, or is the NPU device in the same
>>> group as its corresponding GPU (I would have thought the latter makes
>>> sense).
>>
>>
>> I am putting them to a separate group as they have their own TCE table
>> pointer even though they are expected to share it with GPU.
>
> Hmm.. is this safe?  If the GPU and NPU got assigned to different
> owners, what would happen?  Could the interfere with each other?


I suppose GPU from guest1 could trigger DMA from NPU to guest2 memory. 
Which puts a constrain to management tools not to pass NPU without their 
GPU counterparts.

The host can be affected as bypass is not disabled on NPU when GPU is taken 
by VFIO, I'll fix this.


>> If I put them to the same group as GPUs, I would have to have
>> IODA2-linked-to-NPU bridge type with different iommu_table_group_ops  or
>> have multiple hacks everywhere in IODA2 to enable/disable bypass,
>> etc.
>
> Well.. I suspect it would mean no longer having a 1:1 correspondance
> between user-visible IOMMU groups and the internal iommu_table.

Right.

Right now each GPU is sitting on a separate PHB and has its own PE. And all 
NPUs sit on a separate PHB and each couple of NPUs (2 links of the same 
GPU) gets a PE.

So we have separate PEs (struct pnv_ioda_pe) already, each has its own 
iommu_table_group_ops with all these VFIO IOMMU callbacks. So to make this 
all appear as one IOMMU group in sysfs, I will need to stop embedding 
iommu_table_group into pnv_ioda_pe but make it a pointer with reference 
counting, etc. Quite a massive change...




>>>> ---
>>>>   arch/powerpc/platforms/powernv/npu-dma.c  | 40 +++++++++++++++++++++++++++++++
>>>>   arch/powerpc/platforms/powernv/pci-ioda.c |  8 +++++++
>>>>   arch/powerpc/platforms/powernv/pci.h      |  1 +
>>>>   3 files changed, 49 insertions(+)
>>>>
>>>> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
>>>> index 866d3d3..e5a5feb 100644
>>>> --- a/arch/powerpc/platforms/powernv/npu-dma.c
>>>> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
>>>> @@ -263,3 +263,43 @@ void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass)
>>>>   		}
>>>>   	}
>>>>   }
>>>> +
>>>> +void pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
>>>> +{
>>>> +	struct iommu_table *tbl;
>>>> +	struct pnv_phb *phb = npe->phb;
>>>> +	struct pci_bus *pbus = phb->hose->bus;
>>>> +	struct pci_dev *npdev, *gpdev = NULL, *gptmp;
>>>> +	struct pnv_ioda_pe *gpe = get_gpu_pci_dev_and_pe(npe, &gpdev);
>>>> +
>>>> +	if (!gpe || !gpdev)
>>>> +		return;
>>>> +
>>>> +	iommu_register_group(&npe->table_group, phb->hose->global_number,
>>>> +			npe->pe_number);
>>>> +
>>>> +	tbl = pnv_pci_table_alloc(phb->hose->node);
>>>> +
>>>> +	list_for_each_entry(npdev, &pbus->devices, bus_list) {
>>>> +		gptmp = pnv_pci_get_gpu_dev(npdev);
>>>> +
>>>> +		if (gptmp != gpdev)
>>>> +			continue;
>>>> +
>>>> +		/*
>>>> +		 * The iommu_add_device() picks an IOMMU group from
>>>> +		 * the first IOMMU group attached to the iommu_table
>>>> +		 * so we need to pretend that there is a table so
>>>> +		 * iommu_add_device() can complete the job.
>>>> +		 * We unlink the tempopary table from the group afterwards.
>>>> +		 */
>>>> +		pnv_pci_link_table_and_group(phb->hose->node, 0,
>>>> +				tbl, &npe->table_group);
>>>> +		set_iommu_table_base(&npdev->dev, tbl);
>>>> +		iommu_add_device(&npdev->dev);
>>>> +		set_iommu_table_base(&npdev->dev, NULL);
>>>> +		pnv_pci_unlink_table_and_group(tbl, &npe->table_group);
>>>> +	}
>>>> +
>>>> +	iommu_free_table(tbl, "");
>>>> +}
>>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>> index 5a6cf2e..becd168 100644
>>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>> @@ -2570,6 +2570,14 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>>>>   		remaining -= segs;
>>>>   		base += segs;
>>>>   	}
>>>> +	/*
>>>> +	 * Create an IOMMU group and add devices to it.
>>>> +	 * DMA setup is to be done via GPU's dma_set_mask().
>>>> +	 */
>>>> +	if (phb->type == PNV_PHB_NPU) {
>>>> +		list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link)
>>>> +			pnv_pci_npu_setup_iommu(pe);
>>>> +	}
>>>>   }
>>>>
>>>>   #ifdef CONFIG_PCI_MSI
>>>> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>>> index 06405fd..0c0083a 100644
>>>> --- a/arch/powerpc/platforms/powernv/pci.h
>>>> +++ b/arch/powerpc/platforms/powernv/pci.h
>>>> @@ -235,5 +235,6 @@ extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
>>>>   /* Nvlink functions */
>>>>   extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass);
>>>>   extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm);
>>>> +extern void pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe);
>>>>
>>>>   #endif /* __POWERNV_PCI_H */
>>>
>>
>>
>


-- 
Alexey
