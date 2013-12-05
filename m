Return-Path: <kernelfans@gmail.com>
Received: from mail-qe0-x236.google.com (mail-qe0-x236.google.com
 [IPv6:2607:f8b0:400d:c02::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0A0FD2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Dec 2013 00:27:08 +1100 (EST)
Received: by mail-qe0-f54.google.com with SMTP id cy11so15828434qeb.27
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Dec 2013 05:27:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <877gbjva24.fsf@linux.vnet.ibm.com>
References: <1386140348-7854-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1386140348-7854-4-git-send-email-pingfank@linux.vnet.ibm.com>
 <877gbjva24.fsf@linux.vnet.ibm.com>
Date: Thu, 5 Dec 2013 21:27:02 +0800
Message-ID: <CAFgQCTsj1ssvnbY0K36H+bjyeoxkbZsV3voTLqO3t0D5fZ2sPw@mail.gmail.com>
Subject: Re: [PATCH 3/3] powerpc: mm: optimize for the correctly placed page
From: Liu ping fan <kernelfans@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 5, 2013 at 6:58 PM, Aneesh Kumar K.V
<aneesh.kumar@linux.vnet.ibm.com> wrote:
> Liu Ping Fan <kernelfans@gmail.com> writes:
>
>> The period check of _PAGE_NUMA can probably trigger the check on
>> the correctly placed page. For this case, we can just insert hpte and
>> do fast exception return.
>
> I still don't understand why we need to handle numa faults in hash
> page ? Are you trying to optimize the code path ? If so can you explain
> the benefits ? Some numbers showing it is helping  ?
>
When return from hash_page(), we will take fast_exc_return_irq, while
from do_page_fault(), we take ret_from_except.
As the "fast" implies that there are more complicated logic to sync
the interrupt states in ret_from_except, which cost much.
Do you think so?

>>
>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/mm/hash_utils_64.c | 34 +++++++++++++++++++++++++++++++++-
>>  1 file changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
>> index 9bf1195..735678c 100644
>> --- a/arch/powerpc/mm/hash_utils_64.c
>> +++ b/arch/powerpc/mm/hash_utils_64.c
>> @@ -965,6 +965,10 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
>>       const struct cpumask *tmp;
>>       int rc, user_region = 0, local = 0;
>>       int psize, ssize;
>> +     pte_t old, new;
>> +     struct vm_area_struct *vma;
>> +     int page_nid, target_nid;
>> +     struct page *test_page;
>>
>>       DBG_LOW("hash_page(ea=%016lx, access=%lx, trap=%lx\n",
>>               ea, access, trap);
>> @@ -1033,12 +1037,40 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
>>
>>       /* Get PTE and page size from page tables */
>>       ptep = find_linux_pte_or_hugepte(pgdir, ea, &hugeshift);
>> -     if (ptep == NULL || !pte_present(*ptep) || pte_numa(*ptep)) {
>> +     if (ptep == NULL || !pte_present(*ptep)) {
>>               DBG_LOW(" no PTE !\n");
>>               rc = 1;
>>               goto bail;
>>       }
>>
>> +     old = pte_val(*ptep);
>> +     if (pte_numa(old)) {
>> +             /* If fail to lock, let do_page_fault() to handle it */
>> +             if (down_read_trylock(&mm->mmap_sem)) {
>
> hmm is that something we want to do in hash_page ?
>
Yes, the function has no relation with hash. But I think it depends on
whether it is worth to optimize or not.

Thanks and regards,
Pingfan
>> +                     vma = find_vma(mm, ea);
>> +                     up_read(&mm->mmap_sem);
>> +                     test_page = pte_page(old);
>> +                     page_nid = page_to_nid(test_page);
>> +                     target_nid = numa_migrate_prep(test_page, vma, ea,
>> +                                             page_nid);
>> +                     if (target_nid < 0) {
>> +                             new = pte_mknonnuma(old);
>> +                             /* If ptep is modified under us,
>> +                              * just retry the access
>> +                              */
>> +                             if (unlikely(cmpxchg(ptep, old, new) != old)) {
>> +                                     put_page(test_page);
>> +                                     return 0;
>> +                             }
>> +                             put_page(test_page);
>> +                     }
>> +             } else {
>> +                             put_page(test_page);
>> +                             rc = 1;
>> +                             goto bail;
>> +             }
>> +     }
>> +
>>       /* Add _PAGE_PRESENT to the required access perm */
>>       access |= _PAGE_PRESENT;
>>
>
> -aneesh
>
