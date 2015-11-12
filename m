Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BDD7C1A03F5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 15:56:29 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 12 Nov 2015 14:56:28 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 99804357804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 15:56:23 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAC4uFAH58327158
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 15:56:23 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAC4toQL016860
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 15:55:51 +1100
Date: Thu, 12 Nov 2015 15:55:25 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 11/50] powerpc/powernv: IO and M32 mapping based on
 PCI device resources
Message-ID: <20151112045525.GA6174@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-12-git-send-email-gwshan@linux.vnet.ibm.com>
 <87lha3j3n0.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87lha3j3n0.fsf@gamma.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 12, 2015 at 02:30:27PM +1100, Daniel Axtens wrote:
>Hi Gavin,
>
>Sorry to have taken so long to resume these reviews!
>

Thanks for your review, Daniel!

>> Currently, the IO and M32 segments are mapped to the corresponding
>> PE based on the windows of the parent bridge of PE's primary bus.
>> It's not going to work when the windows of root port or upstream
>> port of the PCIe switch behind root port are extended to PHB's
>> aperatuses in order to support hotplug in subsequent patch.
>I'm not _entirely_ sure I understand this.
>
>I *think* you mean PHB's apertures (i.e. s/aperatuses/apertures/)?
>

I'll fix the typo in next revision.

>> This fixes the issue by mapping IO and M32 segments based on the
>> resources of the PCI devices included in the PE, instead of the
>> windows of the parent bridge of the PE's primary bus.
>
>This solution seems to make a lot of sense, but I don't have a very good
>understanding of PCI yet: why was it done that way and not this way
>originally? Looking at the code, it looks like the old way was simple
>but didn't support SR-IOV?
>

It's not related to SRIOV. Originally, the IO or M32 segments are mapped
according to the bridge's windows. The bridge windows on root port or the
upstream port of the switch behind that will be extended to PHB's apertures.
If we still use bridge's windows, all IO and M32 resources are mapped/assigned
to the PE corresponding to PCI bus#1 or PCI bus#2. That's not correct any more.
So the correct way is to do the mapping based on IO or M32 BARs of the devices
included in the PE.

>There are a few comments inline as well.
>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 553d3f3..4ab93f8 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -2741,71 +2741,90 @@ truncate_iov:
>>  }
>>  #endif /* CONFIG_PCI_IOV */
>>  
>> -/*
>> - * This function is supposed to be called on basis of PE from top
>> - * to bottom style. So the the I/O or MMIO segment assigned to
>> - * parent PE could be overrided by its child PEs if necessary.
>> - */
>> -static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>> -				  struct pnv_ioda_pe *pe)
>> +static int pnv_ioda_setup_one_res(struct pnv_ioda_pe *pe,
>> +				  struct resource *res)
>>  {
>> -	struct pnv_phb *phb = hose->private_data;
>> +	struct pnv_phb *phb = pe->phb;
>>  	struct pci_bus_region region;
>> -	struct resource *res;
>> -	unsigned int segsize;
>> -	int *segmap, index, i;
>> +	unsigned int index, segsize;
>> +	int *segmap;
>>  	uint16_t win;
>>  	int64_t rc;
>
>s/int64_t/s64/;
>I think we might also want to change the uint16_t as well.
>

As I explained before, I changed it from s64 to int64_t and I won't change it
back since both of them are fine. Same situation to uint16 here. If we really
want to clean it all at once, I can do that later, but not in this patchset.

>> -	/*
>> -	 * NOTE: We only care PCI bus based PE for now. For PCI
>> -	 * device based PE, for example SRIOV sensitive VF should
>> -	 * be figured out later.
>> -	 */
>> -	BUG_ON(!(pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)));
>> +	if (!res->parent || !res->flags || res->start > res->end)
>> +		return 0;
>>  
>> -	pci_bus_for_each_resource(pe->pbus, res, i) {
>> -		if (!res || !res->flags ||
>> -		    res->start > res->end)
>> -			continue;
>> +	if (res->flags & IORESOURCE_IO) {
>> +		region.start = res->start - phb->ioda.io_pci_base;
>> +		region.end   = res->end - phb->ioda.io_pci_base;
>> +		segsize      = phb->ioda.io_segsize;
>> +		segmap       = phb->ioda.io_segmap;
>> +		win          = OPAL_IO_WINDOW_TYPE;
>> +	} else if ((res->flags & IORESOURCE_MEM) &&
>> +		   !pnv_pci_is_mem_pref_64(res->flags)) {
>> +		region.start = res->start -
>> +			       phb->hose->mem_offset[0] -
>> +			       phb->ioda.m32_pci_base;
>> +		region.end   = res->end -
>> +			       phb->hose->mem_offset[0] -
>> +			       phb->ioda.m32_pci_base;
>> +		segsize      = phb->ioda.m32_segsize;
>> +		segmap       = phb->ioda.m32_segmap;
>> +		win          = OPAL_M32_WINDOW_TYPE;
>> +	} else {
>> +		return 0;
>The return codes are currently unused, but should this get a more
>informative return code? Are there any invalid ones that should be
>flagged, or is it just safe to ignore stuff we don't recognise?
>

It's safe to ignore M64 (64-bits prefetchable BARs) whose mapping is
done in different path.

>> +	}
>
>
>> +static void pnv_ioda_setup_pe_seg(struct pnv_ioda_pe *pe)
>> +{
>> +	struct pci_dev *pdev;
>> +	struct resource *res;
>> +	int i;
>> +
>> +	/* This function only works for bus dependent PE */
>> +	WARN_ON(!(pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)));
>> +
>> +	list_for_each_entry(pdev, &pe->pbus->devices, bus_list) {
>> +		for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
>> +			res = &pdev->resource[i];
>> +			if (pnv_ioda_setup_one_res(pe, res))
>> +				return;
>As I mentioned earlier, setup_one_res can potentially return -EIO:
>should we be trying to propagate that up?

I think it's a good idea. I'll do in next revision.

>> +		}
>> +
>> +		/*
>> +		 * If the PE contains all subordinate PCI buses, the
>> +		 * windows of the child bridges should be mapped to
>> +		 * the PE as well.
>> +		 */
>> +		if (!(pe->flags & PNV_IODA_PE_BUS_ALL && pci_is_bridge(pdev)))
>> +			continue;
>>  
>> -			region.start += segsize;
>> -			index++;
>> +		for (i = 0; i <= PCI_BRIDGE_RESOURCE_NUM; i++) {
>> +			res = &pdev->resource[PCI_BRIDGE_RESOURCES + i];
>> +			if (pnv_ioda_setup_one_res(pe, res))
>> +				return;
>>  		}
>>  	}
>>  }
>

Thanks,
Gavin
