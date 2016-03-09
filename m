Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 490361A0060
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 19:46:55 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id x188so2952075pfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Mar 2016 00:46:55 -0800 (PST)
Subject: Re: [PATCH kernel 8/9] KVM: PPC: Add in-kernel handling for VFIO
To: David Gibson <david@gibson.dropbear.id.au>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-9-git-send-email-aik@ozlabs.ru>
 <20160308110812.GC22546@voom.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56DFE2F7.80300@ozlabs.ru>
Date: Wed, 9 Mar 2016 19:46:47 +1100
MIME-Version: 1.0
In-Reply-To: <20160308110812.GC22546@voom.fritz.box>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/08/2016 10:08 PM, David Gibson wrote:
> On Mon, Mar 07, 2016 at 02:41:16PM +1100, Alexey Kardashevskiy wrote:
>> This allows the host kernel to handle H_PUT_TCE, H_PUT_TCE_INDIRECT
>> and H_STUFF_TCE requests targeted an IOMMU TCE table used for VFIO
>> without passing them to user space which saves time on switching
>> to user space and back.
>>
>> Both real and virtual modes are supported. The kernel tries to
>> handle a TCE request in the real mode, if fails it passes the request
>> to the virtual mode to complete the operation. If it a virtual mode
>> handler fails, the request is passed to user space; this is not expected
>> to happen ever though.
>
> Well... not expect to happen with a qemu which uses this.  Presumably
> it will fall back to userspace routinely if you have an old qemu that
> doesn't add the liobn mappings.


Ah. Ok, thanks, I'll add this to the commit log.


>> The first user of this is VFIO on POWER. Trampolines to the VFIO external
>> user API functions are required for this patch.
>
> I'm not sure what you mean by "trampoline" here.

For example, look at kvm_vfio_group_get_external_user. It calls 
symbol_get(vfio_group_get_external_user) and then calls a function via the 
returned pointer.

Is there a better word for this?


>> This uses a VFIO KVM device to associate a logical bus number (LIOBN)
>> with an VFIO IOMMU group fd and enable in-kernel handling of map/unmap
>> requests.
>
> Group fd?  Or container fd?  The group fd wouldn't make a lot of
> sense.


Group. KVM has no idea about containers.


>> To make use of the feature, the user space has to create a guest view
>> of the TCE table via KVM_CAP_SPAPR_TCE/KVM_CAP_SPAPR_TCE_64 and
>> then associate a LIOBN with this table via VFIO KVM device,
>> a KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN property (which is added in
>> the next patch).
>>
>> Tests show that this patch increases transmission speed from 220MB/s
>> to 750..1020MB/s on 10Gb network (Chelsea CXGB3 10Gb ethernet card).
>
> Is that with or without DDW (i.e. with or without a 64-bit DMA window)?


Without DDW, I should have mentioned this. The patch is from the times when 
there was no DDW :(



>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   arch/powerpc/kvm/book3s_64_vio.c    | 184 +++++++++++++++++++++++++++++++++++
>>   arch/powerpc/kvm/book3s_64_vio_hv.c | 186 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 370 insertions(+)
>>
>> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
>> index 7965fc7..9417d12 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio.c
>> @@ -33,6 +33,7 @@
>>   #include <asm/kvm_ppc.h>
>>   #include <asm/kvm_book3s.h>
>>   #include <asm/mmu-hash64.h>
>> +#include <asm/mmu_context.h>
>>   #include <asm/hvcall.h>
>>   #include <asm/synch.h>
>>   #include <asm/ppc-opcode.h>
>> @@ -317,11 +318,161 @@ fail:
>>   	return ret;
>>   }
>>
>> +static long kvmppc_tce_iommu_mapped_dec(struct iommu_table *tbl,
>> +		unsigned long entry)
>> +{
>> +	struct mm_iommu_table_group_mem_t *mem = NULL;
>> +	const unsigned long pgsize = 1ULL << tbl->it_page_shift;
>> +	unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
>> +
>> +	if (!pua)
>> +		return H_HARDWARE;
>> +
>> +	mem = mm_iommu_lookup(*pua, pgsize);
>> +	if (!mem)
>> +		return H_HARDWARE;
>> +
>> +	mm_iommu_mapped_dec(mem);
>> +
>> +	*pua = 0;
>> +
>> +	return H_SUCCESS;
>> +}
>> +
>> +static long kvmppc_tce_iommu_unmap(struct iommu_table *tbl,
>> +		unsigned long entry)
>> +{
>> +	enum dma_data_direction dir = DMA_NONE;
>> +	unsigned long hpa = 0;
>> +
>> +	if (iommu_tce_xchg(tbl, entry, &hpa, &dir))
>> +		return H_HARDWARE;
>> +
>> +	if (dir == DMA_NONE)
>> +		return H_SUCCESS;
>> +
>> +	return kvmppc_tce_iommu_mapped_dec(tbl, entry);
>> +}
>> +
>> +long kvmppc_tce_iommu_map(struct kvm *kvm, struct iommu_table *tbl,
>> +		unsigned long entry, unsigned long gpa,
>> +		enum dma_data_direction dir)
>> +{
>> +	long ret;
>> +	unsigned long hpa, ua, *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
>> +	struct mm_iommu_table_group_mem_t *mem;
>> +
>> +	if (!pua)
>> +		return H_HARDWARE;
>
> H_HARDWARE?  Or H_PARAMETER?  This essentially means the guest has
> supplied a bad physical address, doesn't it?

Well, may be. I'll change. If it not H_TOO_HARD, it does not make any 
difference after all :)



>> +	if (kvmppc_gpa_to_ua(kvm, gpa, &ua, NULL))
>> +		return H_HARDWARE;
>> +
>> +	mem = mm_iommu_lookup(ua, 1ULL << tbl->it_page_shift);
>> +	if (!mem)
>> +		return H_HARDWARE;
>> +
>> +	if (mm_iommu_ua_to_hpa(mem, ua, &hpa))
>> +		return H_HARDWARE;
>> +
>> +	if (mm_iommu_mapped_inc(mem))
>> +		return H_HARDWARE;
>> +
>> +	ret = iommu_tce_xchg(tbl, entry, &hpa, &dir);
>> +	if (ret) {
>> +		mm_iommu_mapped_dec(mem);
>> +		return H_TOO_HARD;
>> +	}
>> +
>> +	if (dir != DMA_NONE)
>> +		kvmppc_tce_iommu_mapped_dec(tbl, entry);
>> +
>> +	*pua = ua;
>
> IIUC this means you have a copy of the UA for every group attached to
> the TCE table, but they'll all be the same. Any way to avoid that
> duplication?

It is for every container, not a group. On P8, I allow multiple groups to 
go to the same container, that means that a container has one or two 
iommu_table, and each iommu_table has this "ua" list but since tables are 
different (window size, page size, content), these "ua" arrays are also 
different.





-- 
Alexey
