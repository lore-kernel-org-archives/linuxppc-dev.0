Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47BBA1A2AC4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Sep 2015 13:41:30 +1000 (AEST)
Received: by pacwi10 with SMTP id wi10so10571370pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2015 20:41:28 -0700 (PDT)
Subject: Re: [PATCH v2] powerpc/powernv/pci-ioda: fix 32-bit TCE table init in
 kdump kernel
To: Michael Ellerman <mpe@ellerman.id.au>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
References: <20150902011123.GA47557@linux.vnet.ibm.com>
 <55E6BAAF.9090502@ozlabs.ru> <20150902153928.GB47557@linux.vnet.ibm.com>
 <1441274333.26379.4.camel@ellerman.id.au>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Ben Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, David Gibson
 <david@gibson.dropbear.id.au>, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55E912E0.1000602@ozlabs.ru>
Date: Fri, 4 Sep 2015 13:41:20 +1000
MIME-Version: 1.0
In-Reply-To: <1441274333.26379.4.camel@ellerman.id.au>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/03/2015 07:58 PM, Michael Ellerman wrote:
> On Wed, 2015-09-02 at 08:39 -0700, Nishanth Aravamudan wrote:
>> On 02.09.2015 [19:00:31 +1000], Alexey Kardashevskiy wrote:
>>> On 09/02/2015 11:11 AM, Nishanth Aravamudan wrote:
>>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>> index 85cbc96eff6c..0d7967e31169 100644
>>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>> @@ -2077,10 +2077,17 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
>>>>   {
>>>>   	struct iommu_table *tbl = NULL;
>>>>   	long rc;
>>>> +	/*
>>>> +	 * In memory constrained environments, e.g. kdump kernel, the
>>>> +	 * DMA window can be larger than available memory, which will
>>>> +	 * cause errors later.
>>>> +	 */
>>>> +	__u64 window_size =
>>>
>>> I asked for "const __u64" ;)
>>
>> I knew I'd forget something!
>
> Nish! In future please send a reply with the above comment, and then the v2 as
> a separate mail, otherwise I have to manually edit out your comment when
> applying.
>
>> When attempting to kdump with the 4.2 kernel, we see for each PCI
>> device:
>>
>>   pci 0003:01     : [PE# 000] Assign DMA32 space
>>   pci 0003:01     : [PE# 000] Setting up 32-bit TCE table at 0..80000000
>>   pci 0003:01     : [PE# 000] Failed to create 32-bit TCE table, err -22
>>   PCI: Domain 0004 has 8 available 32-bit DMA segments
>>   PCI: 4 PE# for a total weight of 70
>>   pci 0004:01     : [PE# 002] Assign DMA32 space
>>   pci 0004:01     : [PE# 002] Setting up 32-bit TCE table at 0..80000000
>>   pci 0004:01     : [PE# 002] Failed to create 32-bit TCE table, err -22
>>   pci 0004:0d     : [PE# 005] Assign DMA32 space
>>   pci 0004:0d     : [PE# 005] Setting up 32-bit TCE table at 0..80000000
>>   pci 0004:0d     : [PE# 005] Failed to create 32-bit TCE table, err -22
>>   pci 0004:0e     : [PE# 006] Assign DMA32 space
>>   pci 0004:0e     : [PE# 006] Setting up 32-bit TCE table at 0..80000000
>>   pci 0004:0e     : [PE# 006] Failed to create 32-bit TCE table, err -22
>>   pci 0004:10     : [PE# 008] Assign DMA32 space
>>   pci 0004:10     : [PE# 008] Setting up 32-bit TCE table at 0..80000000
>>   pci 0004:10     : [PE# 008] Failed to create 32-bit TCE table, err -22
>>
>> and eventually the kdump kernel fails to boot as none of the PCI devices
>> (including the disk controller) are successfully initialized.
>>
>> The EINVAL response is because the DMA window (the 2GB base window) is
>> larger than the kdump kernel's reserved memory (crashkernel=, in this
>> case specified to be 1024M). The check in question,
>>
>>   if ((window_size > memory_hotplug_max()) || !is_power_of_2(window_size))
>>
>> is a valid sanity check for pnv_pci_ioda2_table_alloc_pages(), so adjust
>> the caller to pass in a smaller window size if our maximum memory value
>> is smaller than the DMA window.
>>
>> After this change, the PCI devices successfully set up the 32-bit TCE
>> table and kdump succeeds.
>>
>> The problem was seen on a Firestone machine originally.
>>
>> Fixes: aca6913f5551 ("powerpc/powernv/ioda2: Introduce helpers to allocate TCE pages")
>
> That went into 4.2, so should this have a:
>
> Cc: stable@vger.kernel.org # 4.2
>
> ?
>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 85cbc96eff6c..e51aff01a218 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -2077,10 +2077,17 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
>>   {
>>   	struct iommu_table *tbl = NULL;
>>   	long rc;
>> +	/*
>> +	 * In memory constrained environments, e.g. kdump kernel, the
>> +	 * DMA window can be larger than available memory, which will
>> +	 * cause errors later.
>> +	 */
>> +	const __u64 window_size =
>
> Why is this using __u64 and not u64, it's not exported to userspace.
>
> It looks like pnv_pci_ioda2_create_table() uses __u64, but there's no reason
> for that AFAICS either. And yes I did commit it so it's my fault :)


There is VFIO_IOMMU_SPAPR_TCE_CREATE ioctl which receives 
vfio_iommu_spapr_tce_create struct from the user space and there is "__u64 
window_size" which is passed across:
tce_iommu_create_window()
tce_iommu_create_table()
pnv_pci_ioda2_create_table (via table_group->ops->create_table())

At what point should __u64 have become u64?

Thanks.

>
> I'll fix this up to use u64.
>
> cheers
>
>
>


-- 
Alexey
