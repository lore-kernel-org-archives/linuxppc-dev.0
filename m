Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 985571A0B66
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 13:30:55 +1100 (AEDT)
Received: by pactp5 with SMTP id tp5so69789452pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2015 19:30:54 -0700 (PDT)
Message-ID: <551CA9D7.2060804@ozlabs.ru>
Date: Thu, 02 Apr 2015 13:30:47 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel v7 04/31] vfio: powerpc/spapr: Use it_page_size
References: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>	
 <1427468115-2224-5-git-send-email-aik@ozlabs.ru>
 <1427924904.5567.303.camel@redhat.com>
In-Reply-To: <1427924904.5567.303.camel@redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/02/2015 08:48 AM, Alex Williamson wrote:
> On Sat, 2015-03-28 at 01:54 +1100, Alexey Kardashevskiy wrote:
>> This makes use of the it_page_size from the iommu_table struct
>> as page size can differ.
>>
>> This replaces missing IOMMU_PAGE_SHIFT macro in commented debug code
>> as recently introduced IOMMU_PAGE_XXX macros do not include
>> IOMMU_PAGE_SHIFT.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>   drivers/vfio/vfio_iommu_spapr_tce.c | 26 +++++++++++++-------------
>>   1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>> index f835e63..8bbee22 100644
>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>> @@ -91,7 +91,7 @@ static int tce_iommu_enable(struct tce_container *container)
>>   	 * enforcing the limit based on the max that the guest can map.
>>   	 */
>>   	down_write(&current->mm->mmap_sem);
>> -	npages = (tbl->it_size << IOMMU_PAGE_SHIFT_4K) >> PAGE_SHIFT;
>> +	npages = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
>>   	locked = current->mm->locked_vm + npages;
>>   	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>>   	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
>> @@ -120,7 +120,7 @@ static void tce_iommu_disable(struct tce_container *container)
>>
>>   	down_write(&current->mm->mmap_sem);
>>   	current->mm->locked_vm -= (container->tbl->it_size <<
>> -			IOMMU_PAGE_SHIFT_4K) >> PAGE_SHIFT;
>> +			container->tbl->it_page_shift) >> PAGE_SHIFT;
>>   	up_write(&current->mm->mmap_sem);
>>   }
>>
>> @@ -222,7 +222,7 @@ static long tce_iommu_build(struct tce_container *container,
>>   					tce, ret);
>>   			break;
>>   		}
>> -		tce += IOMMU_PAGE_SIZE_4K;
>> +		tce += IOMMU_PAGE_SIZE(tbl);
>
>
> Is PAGE_SIZE ever smaller than IOMMU_PAGE_SIZE(tbl)?  IOW, can the page
> we got from get_user_pages_fast() ever not completely fill the tce
> entry?


Yes. IOMMU_PAGE_SIZE is 4K/64K/16M (16M is with huge pages enabled in QEMU 
with -mempath), PAGE_SIZE is 4K/64K (normally 64K).


> (Have I asked this before?  Sorry if so)


:)



-- 
Alexey
