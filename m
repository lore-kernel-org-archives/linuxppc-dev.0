Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 020661A0017
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 12:52:02 +1000 (AEST)
Received: by pacwv17 with SMTP id wv17so69417788pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 19:52:00 -0700 (PDT)
Message-ID: <55540DC9.6040901@ozlabs.ru>
Date: Thu, 14 May 2015 12:51:53 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH kernel v10 13/34] powerpc/powernv: Do not set "read" flag
 if direction==DMA_NONE
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-14-git-send-email-aik@ozlabs.ru>
 <20150514000048.GA13216@gwshan>
In-Reply-To: <20150514000048.GA13216@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/14/2015 10:00 AM, Gavin Shan wrote:
> On Tue, May 12, 2015 at 01:39:02AM +1000, Alexey Kardashevskiy wrote:
>> Normally a bitmap from the iommu_table is used to track what TCE entry
>> is in use. Since we are going to use iommu_table without its locks and
>> do xchg() instead, it becomes essential not to put bits which are not
>> implied in the direction flag as the old TCE value (more precisely -
>> the permission bits) will be used to decide whether to put the page or not.
>>
>> This adds iommu_direction_to_tce_perm() (its counterpart is there already)
>> and uses it for powernv's pnv_tce_build().
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>> ---
>> Changes:
>> v9:
>> * added comment why we must put only valid permission bits
>> ---
>> arch/powerpc/include/asm/iommu.h     |  1 +
>> arch/powerpc/kernel/iommu.c          | 15 +++++++++++++++
>> arch/powerpc/platforms/powernv/pci.c |  7 +------
>> 3 files changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>> index e94a5e3..d91bd69 100644
>> --- a/arch/powerpc/include/asm/iommu.h
>> +++ b/arch/powerpc/include/asm/iommu.h
>> @@ -200,6 +200,7 @@ extern int iommu_take_ownership(struct iommu_table *tbl);
>> extern void iommu_release_ownership(struct iommu_table *tbl);
>>
>> extern enum dma_data_direction iommu_tce_direction(unsigned long tce);
>> +extern unsigned long iommu_direction_to_tce_perm(enum dma_data_direction dir);
>>
>> #endif /* __KERNEL__ */
>> #endif /* _ASM_IOMMU_H */
>> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>> index 8673c94..31319f8 100644
>> --- a/arch/powerpc/kernel/iommu.c
>> +++ b/arch/powerpc/kernel/iommu.c
>> @@ -863,6 +863,21 @@ void iommu_free_coherent(struct iommu_table *tbl, size_t size,
>> 	}
>> }
>>
>> +unsigned long iommu_direction_to_tce_perm(enum dma_data_direction dir)
>> +{
>> +	switch (dir) {
>> +	case DMA_BIDIRECTIONAL:
>> +		return TCE_PCI_READ | TCE_PCI_WRITE;
>> +	case DMA_FROM_DEVICE:
>> +		return TCE_PCI_WRITE;
>> +	case DMA_TO_DEVICE:
>> +		return TCE_PCI_READ;
>> +	default:
>> +		return 0;
>
> It might be nice to have a WARN_ON() or log for the default case. If the TCE
> entry is going to be updated without permission bits by ppc_md.tce_build().

If this is happening in pnv_tce_build() (which is for the host DMA only) - 
it is quite late to trace anything, we are totally screwed by then.

If you are talking about VFIO (pnv_tce_xchg()), we calculate 
enum_dma_data_direction from the VFIO permission bits so wrong value won't 
be passed here at all.


> The DMA operation covered by this TCE entry will cause EEH error. More
> logs would be helpful to locate the root cause of the EEH error :-)
>
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_direction_to_tce_perm);
>> +
>
> The function converts generic permission flags to PCI specific flags as
> the names (TCE_PCI_{READ,WRITE}) indicates. I'm not sure if it's reasonable
> to have function name iommu_direction_to_pci_tce_perm(). Platform devices
> who have DMA capability might have different flags other than TCE_PCI_{READ,WRITE}
> and possibly use iommu.c to manage platform specific TCE table. We might
> not have the use case for now, so I'm not sure it makes sense to have a
> more specific function name.

"tce" is for SPAPR TCE protocol so the function does pretty certain thing.

It might not be the best place for this function (powernv/pci.c seems to be 
better) but I use this function from POWERNV and KVM and I have either 
duplicate these helpers in POWERNV and KVM or put in some common place and 
where it is now is this place.

And its counterpart - iommu_tce_direction - is there already. We may move 
these somewhere else later if we want.


> Thanks,
> Gavin
>
>> #ifdef CONFIG_IOMMU_API
>> /*
>>   * SPAPR TCE API
>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>> index bca2aeb..b7ea245 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -576,15 +576,10 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
>> 			 unsigned long uaddr, enum dma_data_direction direction,
>> 			 struct dma_attrs *attrs, bool rm)
>> {
>> -	u64 proto_tce;
>> +	u64 proto_tce = iommu_direction_to_tce_perm(direction);
>> 	__be64 *tcep, *tces;
>> 	u64 rpn;
>>
>> -	proto_tce = TCE_PCI_READ; // Read allowed
>> -
>> -	if (direction != DMA_TO_DEVICE)
>> -		proto_tce |= TCE_PCI_WRITE;
>> -
>> 	tces = tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
>> 	rpn = __pa(uaddr) >> tbl->it_page_shift;
>>
>> --
>> 2.4.0.rc3.8.gfb3e7d5
>>
>


-- 
Alexey
