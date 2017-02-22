Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSj0f2ZqjzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 14:05:22 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 1so14128836pgz.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 19:05:22 -0800 (PST)
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Update iommu table base on
 ownership change
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20170221024131.47753-1-aik@ozlabs.ru>
 <20170221232844.GA8704@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson
 <david@gibson.dropbear.id.au>, Russell Currey <ruscur@russell.cc>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <766ce18c-e155-75df-7afe-f5a37cbb69a4@ozlabs.ru>
Date: Wed, 22 Feb 2017 14:05:15 +1100
MIME-Version: 1.0
In-Reply-To: <20170221232844.GA8704@gwshan>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/02/17 10:28, Gavin Shan wrote:
> On Tue, Feb 21, 2017 at 01:41:31PM +1100, Alexey Kardashevskiy wrote:
>> On POWERNV platform, in order to do DMA via IOMMU (i.e. 32bit DMA in
>> our case), a device needs an iommu_table pointer set via
>> set_iommu_table_base().
>>
>> The codeflow is:
>> - pnv_pci_ioda2_setup_dma_pe()
>> 	- pnv_pci_ioda2_setup_default_config()
>> 	- pnv_ioda_setup_bus_dma() [1]
>>
>> pnv_pci_ioda2_setup_dma_pe() creates IOMMU groups,
>> pnv_pci_ioda2_setup_default_config() does default DMA setup,
>> pnv_ioda_setup_bus_dma() takes a bus PE (on IODA2, all physical function
>> PEs as bus PEs except NPU), walks through all underlying buses and
>> devices, adds all devices to an IOMMU group and sets iommu_table.
>>
>> On IODA2, when VFIO is used, it takes ownership over a PE which means it
>> removes all tables and creates new ones (with a possibility of sharing
>> them among PEs). So when the ownership is returned from VFIO to
>> the kernel, the iommu_table pointer written to a device at [1] is
>> stale and needs an update.
>>
>> This adds an "add_to_group" parameter to pnv_ioda_setup_bus_dma()
>> (in fact re-adds as it used to be there a while ago for different
>> reasons) to tell the helper if a device needs to be added to
>> an IOMMU group with an iommu_table update or just the latter.
>>
>> This calls pnv_ioda_setup_bus_dma(..., false) from
>> pnv_ioda2_release_ownership() so when the ownership is restored,
>> 32bit DMA can work again for a device. This does the same thing
>> on obtaining ownership as the iommu_table point is stale at this point
>> anyway and it is safer to have NULL there.
>>
>> We did not hit this earlier as all tested devices in recent years were
>> only using 64bit DMA; the rare exception for this is MPT3 SAS adapter
>> which uses both 32bit and 64bit DMA access and it has not been tested
>> with VFIO much.
>>
>> Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks!

> One thing would be improved in future, which isn't relevant to
> this patch if my understanding is correct enough: The TCE table for
> DMA32 space created during system boot is destroyed when VFIO takes
> the ownership. The same TCE table (same level, page size, window size
> etc) is created and associated to the PE again. Some CPU cycles would
> be saved if the original table is picked up without creating a new one.

It is not necessary same levels or window size, could be something
different. Also carrying a table will just make code bit more complicated
and it is complicated enough already - we need to consider very possible
case of IOMMU tables sharing.


> The involved function is pnv_pci_ioda2_create_table(). Its primary work
> is to allocate pages from buddy.

It allocates pages via alloc_pages_node(), not buddy.

> It's usually fast if there are enough
> free pages. Otherwise, it would be relatively slow. It also has the risk
> to fail the allocation. I guess it's not bad to save CPU cycles in this
> critical (maybe hot?) path.

It is not a critical path - it happens on a guest (re)boot only.


-- 
Alexey
