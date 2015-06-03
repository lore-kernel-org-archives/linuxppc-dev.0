Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B47771A023C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 21:11:19 +1000 (AEST)
Received: by padjw17 with SMTP id jw17so5099459pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2015 04:11:17 -0700 (PDT)
Message-ID: <556EE0CD.1030508@ozlabs.ru>
Date: Wed, 03 Jun 2015 21:11:09 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 09/34] vfio: powerpc/spapr: Move locked_vm
 accounting to helpers
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-10-git-send-email-aik@ozlabs.ru>
 <20150601042814.GH22789@voom.redhat.com>
In-Reply-To: <20150601042814.GH22789@voom.redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/01/2015 02:28 PM, David Gibson wrote:
> On Fri, May 29, 2015 at 06:44:33PM +1000, Alexey Kardashevskiy wrote:
>> There moves locked pages accounting to helpers.
>> Later they will be reused for Dynamic DMA windows (DDW).
>>
>> This reworks debug messages to show the current value and the limit.
>>
>> This stores the locked pages number in the container so when unlocking
>> the iommu table pointer won't be needed. This does not have an effect
>> now but it will with the multiple tables per container as then we will
>> allow attaching/detaching groups on fly and we may end up having
>> a container with no group attached but with the counter incremented.
>>
>> While we are here, update the comment explaining why RLIMIT_MEMLOCK
>> might be required to be bigger than the guest RAM. This also prints
>> pid of the current process in pr_warn/pr_debug.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> [aw: for the vfio related changes]
>> Acked-by: Alex Williamson <alex.williamson@redhat.com>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>> Changes:
>> v4:
>> * new helpers do nothing if @npages == 0
>> * tce_iommu_disable() now can decrement the counter if the group was
>> detached (not possible now but will be in the future)
>> ---
>>   drivers/vfio/vfio_iommu_spapr_tce.c | 82 ++++++++++++++++++++++++++++---------
>>   1 file changed, 63 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>> index 64300cc..40583f9 100644
>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>> @@ -29,6 +29,51 @@
>>   static void tce_iommu_detach_group(void *iommu_data,
>>   		struct iommu_group *iommu_group);
>>
>> +static long try_increment_locked_vm(long npages)
>> +{
>> +	long ret = 0, locked, lock_limit;
>> +
>> +	if (!current || !current->mm)
>> +		return -ESRCH; /* process exited */
>> +
>> +	if (!npages)
>> +		return 0;
>> +
>> +	down_write(&current->mm->mmap_sem);
>> +	locked = current->mm->locked_vm + npages;
>
> Is there a possibility of userspace triggering an integer overflow
> here, if npages is really huge?


I do not see how. I just do not accept npages bigger than the host RAM size 
in pages. And it is "long". For (lets say) 128GB host, the number of 4KB 
pages is (128<<30)/4096=33554432.


>
>> +	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>> +	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
>> +		ret = -ENOMEM;
>> +	else
>> +		current->mm->locked_vm += npages;
>> +
>> +	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%ld%s\n", current->pid,
>> +			npages << PAGE_SHIFT,
>> +			current->mm->locked_vm << PAGE_SHIFT,
>> +			rlimit(RLIMIT_MEMLOCK),
>> +			ret ? " - exceeded" : "");
>> +
>> +	up_write(&current->mm->mmap_sem);
>> +
>> +	return ret;
>> +}
>> +
>> +static void decrement_locked_vm(long npages)
>> +{
>> +	if (!current || !current->mm || !npages)
>> +		return; /* process exited */
>> +
>> +	down_write(&current->mm->mmap_sem);
>> +	if (npages > current->mm->locked_vm)
>> +		npages = current->mm->locked_vm;
>
> Can this case ever occur (without there being a leak bug somewhere
> else in the code)?


It should not. Safety measure. Having a warning here might make sense but I 
believe if this happens, there will be many, many warnings in other places :)



>> +	current->mm->locked_vm -= npages;
>> +	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%ld\n", current->pid,
>> +			npages << PAGE_SHIFT,
>> +			current->mm->locked_vm << PAGE_SHIFT,
>> +			rlimit(RLIMIT_MEMLOCK));
>> +	up_write(&current->mm->mmap_sem);
>> +}
>> +
>>   /*
>>    * VFIO IOMMU fd for SPAPR_TCE IOMMU implementation
>>    *
>> @@ -45,6 +90,7 @@ struct tce_container {
>>   	struct mutex lock;
>>   	struct iommu_table *tbl;
>>   	bool enabled;
>> +	unsigned long locked_pages;
>>   };
>>
>>   static bool tce_page_is_contained(struct page *page, unsigned page_shift)
>> @@ -60,7 +106,7 @@ static bool tce_page_is_contained(struct page *page, unsigned page_shift)
>>   static int tce_iommu_enable(struct tce_container *container)
>>   {
>>   	int ret = 0;
>> -	unsigned long locked, lock_limit, npages;
>> +	unsigned long locked;
>>   	struct iommu_table *tbl = container->tbl;
>>
>>   	if (!container->tbl)
>> @@ -89,21 +135,22 @@ static int tce_iommu_enable(struct tce_container *container)
>>   	 * Also we don't have a nice way to fail on H_PUT_TCE due to ulimits,
>>   	 * that would effectively kill the guest at random points, much better
>>   	 * enforcing the limit based on the max that the guest can map.
>> +	 *
>> +	 * Unfortunately at the moment it counts whole tables, no matter how
>> +	 * much memory the guest has. I.e. for 4GB guest and 4 IOMMU groups
>> +	 * each with 2GB DMA window, 8GB will be counted here. The reason for
>> +	 * this is that we cannot tell here the amount of RAM used by the guest
>> +	 * as this information is only available from KVM and VFIO is
>> +	 * KVM agnostic.
>>   	 */
>> -	down_write(&current->mm->mmap_sem);
>> -	npages = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
>> -	locked = current->mm->locked_vm + npages;
>> -	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>> -	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
>> -		pr_warn("RLIMIT_MEMLOCK (%ld) exceeded\n",
>> -				rlimit(RLIMIT_MEMLOCK));
>> -		ret = -ENOMEM;
>> -	} else {
>> +	locked = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
>> +	ret = try_increment_locked_vm(locked);
>> +	if (ret)
>> +		return ret;
>>
>> -		current->mm->locked_vm += npages;
>> -		container->enabled = true;
>> -	}
>> -	up_write(&current->mm->mmap_sem);
>> +	container->locked_pages = locked;
>> +
>> +	container->enabled = true;
>>
>>   	return ret;
>>   }
>> @@ -115,13 +162,10 @@ static void tce_iommu_disable(struct tce_container *container)
>>
>>   	container->enabled = false;
>>
>> -	if (!container->tbl || !current->mm)
>> +	if (!current->mm)
>>   		return;
>>
>> -	down_write(&current->mm->mmap_sem);
>> -	current->mm->locked_vm -= (container->tbl->it_size <<
>> -			container->tbl->it_page_shift) >> PAGE_SHIFT;
>> -	up_write(&current->mm->mmap_sem);
>> +	decrement_locked_vm(container->locked_pages);
>>   }
>>
>>   static void *tce_iommu_open(unsigned long arg)
>


-- 
Alexey
