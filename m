Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0kWH6NqZzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 15:49:27 +1000 (AEST)
Received: by mail-pa0-x233.google.com with SMTP id bt5so32003427pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 May 2016 22:49:27 -0700 (PDT)
Subject: Re: [PATCH kernel v4 11/11] powerpc/powernv/npu: Enable NVLink pass
 through
To: Alistair Popple <alistair@popple.id.au>
References: <1461920124-21719-1-git-send-email-aik@ozlabs.ru>
 <1461920124-21719-12-git-send-email-aik@ozlabs.ru>
 <4423081.kICSik6V6M@new-mexico>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Daniel Axtens <dja@axtens.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Russell Currey <ruscur@russell.cc>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <6545e499-486f-c04d-a4f1-9a8781bc5eb2@ozlabs.ru>
Date: Thu, 5 May 2016 15:49:18 +1000
MIME-Version: 1.0
In-Reply-To: <4423081.kICSik6V6M@new-mexico>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/04/2016 12:08 AM, Alistair Popple wrote:
> Hi Alexey,
>
> On Fri, 29 Apr 2016 18:55:24 Alexey Kardashevskiy wrote:
>> IBM POWER8 NVlink systems come with Tesla K40-ish GPUs each of which
>> also has a couple of fast speed links (NVLink). The interface to links
>> is exposed as an emulated PCI bridge which is included into the same
>> IOMMU group as the corresponding GPU.
>>
>> In the kernel, NPUs get a separate PHB of the PNV_PHB_NPU type and a PE
>> which behave pretty much as the standard IODA2 PHB except NPU PHB has
>> just a single TVE in the hardware which means it can have either
>> 32bit window or 64bit window or DMA bypass but never two of these.
>>
>> In order to make these links work when GPU is passed to the guest,
>> these bridges need to be passed as well; otherwise performance will
>> degrade.
>>
>> This implements and exports API to manage NPU state in regard to VFIO;
>> it replicates iommu_table_group_ops.
>>
>> This defines a new pnv_pci_ioda2_npu_ops which is assigned to
>> the IODA2 bridge if there are NPUs for a GPU on the bridge.
>> The new callbacks call the default IODA2 callbacks plus new NPU API.
>> This adds a gpe_table_group_to_npe() helper to find NPU PE for the IODA2
>> table_group, it is not expected to fail as the helper is only called
>> from the pnv_pci_ioda2_npu_ops.
>>
>> This does not define NPU-specific .release_ownership() so after
>> VFIO is finished, DMA on NPU is disabled which is ok as the nvidia
>> driver sets DMA mask when probing which enable 32 or 64bit DMA on NPU.
>>
>> This adds a pnv_pci_npu_setup_iommu() helper which adds NPUs to
>> the GPU group if any found. The helper uses helpers to look for
>> the "ibm,gpu" property in the device tree which is a phandle of
>> the corresponding GPU.
>>
>> This adds an additional loop over PEs in pnv_ioda_setup_dma() as the main
>> loop skips NPU PEs as they do not have 32bit DMA segments.
>>
>> As pnv_npu_set_window() and pnv_npu_unset_window() are started being used
>> by the new IODA2-NPU IOMMU group, this makes the helpers public and
>> adds the DMA window number parameter.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v4:
>> * reused pnv_npu_set_window/pnv_npu_unset_window where possible
>> * added comments, changed commit log
>>
>> v3:
>> * moved NPU-to-GPU IOMMU grouping later after all PHBs are discovered
>> * removed hack to make iommu_add_device() work, iommu_group_add_device()
>> is used instead
>> * cleanup in gpe_table_group_to_npe_cb()
>>
>> v2:
>> * reimplemented to support NPU + GPU in the same group
>> * merged "powerpc/powernv/npu: Add NPU devices to IOMMU group" and
>> "powerpc/powernv/npu: Enable passing through via VFIO" into this patch
>> ---
>>  arch/powerpc/platforms/powernv/npu-dma.c  |  64 +++++++++++++++++--
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 102
> ++++++++++++++++++++++++++++++
>>  arch/powerpc/platforms/powernv/pci.h      |   6 ++
>>  3 files changed, 166 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c
> b/arch/powerpc/platforms/powernv/npu-dma.c
>> index cb2d1da..0459e10 100644
>> --- a/arch/powerpc/platforms/powernv/npu-dma.c
>> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/export.h>
>>  #include <linux/pci.h>
>>  #include <linux/memblock.h>
>> +#include <linux/iommu.h>
>>
>>  #include <asm/iommu.h>
>>  #include <asm/pnv-pci.h>
>> @@ -154,7 +155,7 @@ static struct pnv_ioda_pe *get_gpu_pci_dev_and_pe(struct
> pnv_ioda_pe *npe,
>>  	return pe;
>>  }
>>
>> -static long pnv_npu_set_window(struct pnv_ioda_pe *npe,
>> +long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
>>  		struct iommu_table *tbl)
>>  {
>>  	struct pnv_phb *phb = npe->phb;
>> @@ -182,13 +183,13 @@ static long pnv_npu_set_window(struct pnv_ioda_pe
> *npe,
>>  	pnv_pci_ioda2_tce_invalidate_entire(phb, false);
>>
>>  	/* Add the table to the list so its TCE cache will get invalidated */
>> -	pnv_pci_link_table_and_group(phb->hose->node, 0,
>> +	pnv_pci_link_table_and_group(phb->hose->node, num,
>>  			tbl, &npe->table_group);
>>
>>  	return 0;
>>  }
>>
>> -static long pnv_npu_unset_window(struct pnv_ioda_pe *npe)
>> +long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num)
>>  {
>>  	struct pnv_phb *phb = npe->phb;
>>  	int64_t rc;
>> @@ -205,7 +206,7 @@ static long pnv_npu_unset_window(struct pnv_ioda_pe
> *npe)
>>  	}
>>  	pnv_pci_ioda2_tce_invalidate_entire(phb, false);
>>
>> -	pnv_pci_unlink_table_and_group(npe->table_group.tables[0],
>> +	pnv_pci_unlink_table_and_group(npe->table_group.tables[num],
>>  			&npe->table_group);
>>
>>  	return 0;
>> @@ -231,7 +232,7 @@ static void pnv_npu_dma_set_32(struct pnv_ioda_pe *npe)
>>  	if (!gpe)
>>  		return;
>>
>> -	rc = pnv_npu_set_window(npe, gpe->table_group.tables[0]);
>> +	rc = pnv_npu_set_window(npe, 0, gpe->table_group.tables[0]);
>>
>>  	/*
>>  	 * We don't initialise npu_pe->tce32_table as we always use
>> @@ -255,7 +256,7 @@ static int pnv_npu_dma_set_bypass(struct pnv_ioda_pe
> *npe)
>>  	if (phb->type != PNV_PHB_NPU || !npe->pdev)
>>  		return -EINVAL;
>>
>> -	rc = pnv_npu_unset_window(npe);
>> +	rc = pnv_npu_unset_window(npe, 0);
>>  	if (rc != OPAL_SUCCESS)
>>  		return rc;
>>
>> @@ -307,3 +308,54 @@ void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev,
> bool bypass)
>>  		}
>>  	}
>>  }
>> +
>> +/* Switch ownership from platform code to external user (e.g. VFIO) */
>> +void pnv_npu_take_ownership(struct pnv_ioda_pe *npe)
>> +{
>> +	struct pnv_phb *phb = npe->phb;
>> +	int64_t rc;
>> +
>> +	/*
>> +	 * Note: NPU has just a single TVE in the hardware which means that
>> +	 * while used by the kernel, it can have either 32bit window or
>> +	 * DMA bypass but never both. So we deconfigure 32bit window only
>> +	 * if it was enabled at the moment of ownership change.
>> +	 */
>> +	if (npe->table_group.tables[0]) {
>> +		pnv_npu_unset_window(npe, 0);
>> +		return;
>> +	}
>> +
>> +	/* Disable bypass */
>> +	rc = opal_pci_map_pe_dma_window_real(phb->opal_id,
>> +			npe->pe_number, npe->pe_number,
>> +			0 /* bypass base */, 0);
>> +	if (rc) {
>> +		pe_err(npe, "Failed to disable bypass, err %lld\n", rc);
>> +		return;
>> +	}
>> +	pnv_pci_ioda2_tce_invalidate_entire(npe->phb, false);
>> +}
>> +
>> +struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
>> +{
>> +	struct pnv_phb *phb = npe->phb;
>> +	struct pci_bus *pbus = phb->hose->bus;
>> +	struct pci_dev *npdev, *gpdev = NULL, *gptmp;
>> +	struct pnv_ioda_pe *gpe = get_gpu_pci_dev_and_pe(npe, &gpdev);
>> +
>> +	if (!gpe || !gpdev)
>> +		return NULL;
>> +
>> +	list_for_each_entry(npdev, &pbus->devices, bus_list) {
>> +		gptmp = pnv_pci_get_gpu_dev(npdev);
>> +
>> +		if (gptmp != gpdev)
>> +			continue;
>
> If I'm not mistaken it looks like you are trying to find all the NPU PEs also
> attached to the same GPU on the same (firmware emulated) NPU PHB? I'm just
> curious - does this work if the GPU has say 2 NPU PE#s (ie. links) on
> different NPU PHB's?
>
>> +		pe_info(gpe, "Attached NPU %s\n", dev_name(&npdev->dev));
>> +		iommu_group_add_device(gpe->table_group.group, &npdev->dev);
>> +	}
>> +
>> +	return gpe;
>> +}
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c
> b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 922c74c..feabe50 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -2273,6 +2273,90 @@ static struct iommu_table_group_ops pnv_pci_ioda2_ops
> = {
>>  	.take_ownership = pnv_ioda2_take_ownership,
>>  	.release_ownership = pnv_ioda2_release_ownership,
>>  };
>> +
>> +static int gpe_table_group_to_npe_cb(struct device *dev, void *opaque)
>> +{
>> +	struct pci_controller *hose;
>> +	struct pnv_phb *phb;
>> +	struct pnv_ioda_pe **ptmppe = opaque;
>> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
>> +	struct pci_dn *pdn = pci_get_pdn(pdev);
>> +
>> +	if (!pdn || pdn->pe_number == IODA_INVALID_PE)
>> +		return 0;
>> +
>> +	hose = pci_bus_to_host(pdev->bus);
>> +	phb = hose->private_data;
>> +	if (phb->type != PNV_PHB_NPU)
>> +		return 0;
>> +
>> +	*ptmppe = &phb->ioda.pe_array[pdn->pe_number];
>> +
>> +	return 1;
>> +}
>> +
>> +/*
>> + * This returns PE of associated NPU.
>> + * This assumes that NPU is in the same IOMMU group with GPU and there is
>> + * no other PEs.
>> + */
>
> Which answers my above question as this doesn't look like it supports GPUs
> with multiple NPU PE#s attached. I don't think this is actually a problem
> though as no hardware I know of will ever do this, even though theoretically
> it's possible.


I believe when such a situation happens in the future, it will be different 
PVR, PHB4 (or 5 or whatever) and IODA3 (or 4, or...).

I could write code in assumption that there can be more NPU PEs per one GPU 
PE but it does not make much sense (to me) to design the hardware this way 
and when/if it will be designed this way, the details most likely will 
differ from what I can imagine today.



>
> It might be nice if we could warn if this configuration is detected but not
> really a big issue.
 >
> Everything else looks reasonable as far as I can tell
> (although again I'm no vfio iommu groups expert) so happy for you to add my
> reviewed-by:
>
> Reviewed-By: Alistair Popple <alistair@popple.id.au>


Thanks!

>
>> +static struct pnv_ioda_pe *gpe_table_group_to_npe(
>> +		struct iommu_table_group *table_group)
>> +{
>> +	struct pnv_ioda_pe *npe = NULL;
>> +	int ret = iommu_group_for_each_dev(table_group->group, &npe,
>> +			gpe_table_group_to_npe_cb);
>> +
>> +	BUG_ON(!ret || !npe);
>> +
>> +	return npe;
>> +}
>> +
>> +static long pnv_pci_ioda2_npu_set_window(struct iommu_table_group
> *table_group,
>> +		int num, struct iommu_table *tbl)
>> +{
>> +	long ret = pnv_pci_ioda2_set_window(table_group, num, tbl);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = pnv_npu_set_window(gpe_table_group_to_npe(table_group), num,
> tbl);
>> +	if (ret)
>> +		pnv_pci_ioda2_unset_window(table_group, num);
>> +
>> +	return ret;
>> +}
>> +
>> +static long pnv_pci_ioda2_npu_unset_window(
>> +		struct iommu_table_group *table_group,
>> +		int num)
>> +{
>> +	long ret = pnv_pci_ioda2_unset_window(table_group, num);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	return pnv_npu_unset_window(gpe_table_group_to_npe(table_group), num);
>> +}
>> +
>> +static void pnv_ioda2_npu_take_ownership(struct iommu_table_group
> *table_group)
>> +{
>> +	/*
>> +	 * Detach NPU first as pnv_ioda2_take_ownership() will destroy
>> +	 * the iommu_table if 32bit DMA is enabled.
>> +	 */
>> +	pnv_npu_take_ownership(gpe_table_group_to_npe(table_group));
>> +	pnv_ioda2_take_ownership(table_group);
>> +}
>> +
>> +static struct iommu_table_group_ops pnv_pci_ioda2_npu_ops = {
>> +	.get_table_size = pnv_pci_ioda2_get_table_size,
>> +	.create_table = pnv_pci_ioda2_create_table,
>> +	.set_window = pnv_pci_ioda2_npu_set_window,
>> +	.unset_window = pnv_pci_ioda2_npu_unset_window,
>> +	.take_ownership = pnv_ioda2_npu_take_ownership,
>> +	.release_ownership = pnv_ioda2_release_ownership,
>> +};
>>  #endif
>>
>>  static void pnv_pci_ioda_setup_opal_tce_kill(struct pnv_phb *phb)
>> @@ -3012,6 +3096,7 @@ static void pnv_pci_ioda_setup_DMA(void)
>>  {
>>  	struct pci_controller *hose, *tmp;
>>  	struct pnv_phb *phb;
>> +	struct pnv_ioda_pe *pe, *gpe;
>>
>>  	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>>  		pnv_ioda_setup_dma(hose->private_data);
>> @@ -3020,6 +3105,23 @@ static void pnv_pci_ioda_setup_DMA(void)
>>  		phb = hose->private_data;
>>  		phb->initialized = 1;
>>  	}
>> +
>> +	/*
>> +	 * Now we have all PHBs discovered, time to add NPU devices to
>> +	 * the corresponding IOMMU groups.
>> +	 */
>> +	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>> +		phb = hose->private_data;
>> +
>> +		if (phb->type != PNV_PHB_NPU)
>> +			continue;
>> +
>> +		list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
>> +			gpe = pnv_pci_npu_setup_iommu(pe);
>> +			if (gpe)
>> +				gpe->table_group.ops = &pnv_pci_ioda2_npu_ops;
>> +		}
>> +	}
>>  }
>>
>>  static void pnv_pci_ioda_create_dbgfs(void)
>> diff --git a/arch/powerpc/platforms/powernv/pci.h
> b/arch/powerpc/platforms/powernv/pci.h
>> index e117bd8..ebc6ee4 100644
>> --- a/arch/powerpc/platforms/powernv/pci.h
>> +++ b/arch/powerpc/platforms/powernv/pci.h
>> @@ -244,5 +244,11 @@ extern void pe_level_printk(const struct pnv_ioda_pe
> *pe, const char *level,
>>  /* Nvlink functions */
>>  extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass);
>>  extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool
> rm);
>> +extern struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe
> *npe);
>> +extern long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
>> +		struct iommu_table *tbl);
>> +extern long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num);
>> +extern void pnv_npu_take_ownership(struct pnv_ioda_pe *npe);
>> +extern void pnv_npu_release_ownership(struct pnv_ioda_pe *npe);
>>
>>  #endif /* __POWERNV_PCI_H */
>>
>


-- 
Alexey
