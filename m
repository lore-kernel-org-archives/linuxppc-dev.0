Return-Path: <prvs=0631f3177a=fbarrat@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40FvwB0ZKVzF1xq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 02:40:25 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w33GaVGY066750
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Apr 2018 12:40:22 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h4ajm1std-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2018 12:40:22 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Tue, 3 Apr 2018 17:40:19 +0100
Subject: Re: [PATCH] cxl: Fix possible deadlock when processing page faults
 from cxllib
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: ldufour@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, vaibhav@linux.vnet.ibm.com
References: <20180403094311.331-1-fbarrat@linux.vnet.ibm.com>
 <606e7509-5c37-b38e-9b6c-a60a5694c652@linux.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Tue, 3 Apr 2018 18:40:15 +0200
MIME-Version: 1.0
In-Reply-To: <606e7509-5c37-b38e-9b6c-a60a5694c652@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <4893c7a6-b8d8-14e9-21e9-e9a059477613@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 03/04/2018 à 16:40, Aneesh Kumar K.V a écrit :
> On 04/03/2018 03:13 PM, Frederic Barrat wrote:
>> cxllib_handle_fault() is called by an external driver when it needs to
>> have the host process page faults for a buffer which may cover several
>> pages. Currently the function holds the mm->mmap_sem semaphore with
>> read access while iterating over the buffer, since it could spawn
>> several VMAs. When calling a lower-level function to handle the page
>> fault for a single page, the semaphore is accessed again in read
>> mode. That is wrong and can lead to deadlocks if a writer tries to
>> sneak in while a buffer of several pages is being processed.
>>
>> The fix is to release the semaphore once cxllib_handle_fault() got the
>> information it needs from the current vma. The address space/VMAs
>> could evolve while we iterate over the full buffer, but in the
>> unlikely case where we miss a page, the driver will raise a new page
>> fault when retrying.
>>
>> Fixes: 3ced8d730063 ("cxl: Export library to support IBM XSL")
>> Cc: stable@vger.kernel.org # 4.13+
>> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>> ---
>>   drivers/misc/cxl/cxllib.c | 85 
>> ++++++++++++++++++++++++++++++-----------------
>>   1 file changed, 55 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/misc/cxl/cxllib.c b/drivers/misc/cxl/cxllib.c
>> index 30ccba436b3b..55cd35d1a9cc 100644
>> --- a/drivers/misc/cxl/cxllib.c
>> +++ b/drivers/misc/cxl/cxllib.c
>> @@ -208,49 +208,74 @@ int cxllib_get_PE_attributes(struct task_struct 
>> *task,
>>   }
>>   EXPORT_SYMBOL_GPL(cxllib_get_PE_attributes);
>> -int cxllib_handle_fault(struct mm_struct *mm, u64 addr, u64 size, u64 
>> flags)
>> +static int get_vma_info(struct mm_struct *mm, u64 addr,
>> +            u64 *vma_start, u64 *vma_end,
>> +            unsigned long *page_size)
>>   {
>> -    int rc;
>> -    u64 dar;
>>       struct vm_area_struct *vma = NULL;
>> -    unsigned long page_size;
>> -
>> -    if (mm == NULL)
>> -        return -EFAULT;
>> +    int rc = 0;
>>       down_read(&mm->mmap_sem);
>>       vma = find_vma(mm, addr);
>>       if (!vma) {
>> -        pr_err("Can't find vma for addr %016llx\n", addr);
>>           rc = -EFAULT;
>>           goto out;
>>       }
>> -    /* get the size of the pages allocated */
>> -    page_size = vma_kernel_pagesize(vma);
>> -
>> -    for (dar = (addr & ~(page_size - 1)); dar < (addr + size); dar += 
>> page_size) {
>> -        if (dar < vma->vm_start || dar >= vma->vm_end) {
>> -            vma = find_vma(mm, addr);
>> -            if (!vma) {
>> -                pr_err("Can't find vma for addr %016llx\n", addr);
>> -                rc = -EFAULT;
>> -                goto out;
>> -            }
>> -            /* get the size of the pages allocated */
>> -            page_size = vma_kernel_pagesize(vma);
>> +    *page_size = vma_kernel_pagesize(vma);
>> +    *vma_start = vma->vm_start;
>> +    *vma_end = vma->vm_end;
>> +out:
>> +    up_read(&mm->mmap_sem);
>> +    return rc;
>> +}
>> +
>> +int cxllib_handle_fault(struct mm_struct *mm, u64 addr, u64 size, u64 
>> flags)
>> +{
>> +    int rc;
>> +    u64 dar, vma_start, vma_end;
>> +    unsigned long page_size;
>> +
>> +    if (mm == NULL)
>> +        return -EFAULT;
>> +
>> +    /*
>> +     * The buffer we have to process can extend over several pages
>> +     * and may also cover several VMAs.
>> +     * We iterate over all the pages. The page size could vary
>> +     * between VMAs.
>> +     */
>> +    rc = get_vma_info(mm, addr, &vma_start, &vma_end, &page_size);
>> +    if (rc)
>> +        return rc;
>> +
>> +    for (dar = (addr & ~(page_size - 1)); dar < (addr + size);
>> +         dar += page_size) {
>> +        if (dar < vma_start || dar >= vma_end) {
> 
> 
> IIUC, we are fetching the vma to get just the page_size with which it is 
> mapped? Can't we iterate with PAGE_SIZE? Considering hugetlb page size 
> will be larger than PAGE_SIZE, we might call into cxl_handle_mm_fault 
> multiple times for a hugetlb page. Does that cause any issue? Also can 
> cxl be used with hugetlb mappings?

I discussed it with Aneesh, but for the record:
- huge pages could be used, cxl has no control over it.
- incrementing the loop with PAGE_SIZE if it's a huge page would be a 
waste, as only the first call to cxl_handle_mm_fault() would be useful.
- having to account for several VMAs and potentially page sizes make it 
more complicated. An idea is to check with Mellanox if we can reduce the 
scope, in case the caller can rule out some cases. It's too late for 
coral, but something we can look into for the future/upstream.

   Fred



>> +            /*
>> +             * We don't hold the mm->mmap_sem semaphore
>> +             * while iterating, since the semaphore is
>> +             * required by one of the lower-level page
>> +             * fault processing functions and it could
>> +             * create a deadlock.
>> +             *
>> +             * It means the VMAs can be altered between 2
>> +             * loop iterations and we could theoretically
>> +             * miss a page (however unlikely). But that's
>> +             * not really a problem, as the driver will
>> +             * retry access, get another page fault on the
>> +             * missing page and call us again.
>> +             */
>> +            rc = get_vma_info(mm, dar, &vma_start, &vma_end,
>> +                    &page_size);
>> +            if (rc)
>> +                return rc;
>>           }
>>           rc = cxl_handle_mm_fault(mm, flags, dar);
>> -        if (rc) {
>> -            pr_err("cxl_handle_mm_fault failed %d", rc);
>> -            rc = -EFAULT;
>> -            goto out;
>> -        }
>> +        if (rc)
>> +            return -EFAULT;
>>       }
>> -    rc = 0;
>> -out:
>> -    up_read(&mm->mmap_sem);
>> -    return rc;
>> +    return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(cxllib_handle_fault);
>>
> 
> -aneesh
> 
