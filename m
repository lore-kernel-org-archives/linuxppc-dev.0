Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNt2X6VhtzDqG5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 13:39:16 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v743clUn005911
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Aug 2017 23:39:14 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c4aeqfmuq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Aug 2017 23:39:13 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 4 Aug 2017 13:39:10 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v743d6ts12910714
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Aug 2017 13:39:06 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v743d6Is015326
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Aug 2017 13:39:06 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 1/3] arch/powerpc/set_memory: Implement set_memory_xx
 routines
In-Reply-To: <CAKTCnzkqN3j-cjuQrWHMe_4P1omCyyuFHA7yKFUZ_JUFSspmDA@mail.gmail.com>
References: <20170801112535.20765-1-bsingharora@gmail.com>
 <20170801112535.20765-2-bsingharora@gmail.com>
 <87pocez3f8.fsf@linux.vnet.ibm.com>
 <CAKTCnzkqN3j-cjuQrWHMe_4P1omCyyuFHA7yKFUZ_JUFSspmDA@mail.gmail.com>
Date: Fri, 04 Aug 2017 09:08:53 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87zibgngs2.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> On Wed, Aug 2, 2017 at 8:09 PM, Aneesh Kumar K.V
> <aneesh.kumar@linux.vnet.ibm.com> wrote:
>> Balbir Singh <bsingharora@gmail.com> writes:
>>
>>> Add support for set_memory_xx routines. With the STRICT_KERNEL_RWX
>>> feature support we got support for changing the page permissions
>>> for pte ranges. This patch adds support for both radix and hash
>>> so that we can change their permissions via set/clear masks.
>>>
>>> A new helper is required for hash (hash__change_memory_range()
>>> is changed to hash__change_boot_memory_range() as it deals with
>>> bolted PTE's).
>>>
>>> hash__change_memory_range() works with vmalloc'ed PAGE_SIZE requests
>>> for permission changes. hash__change_memory_range() does not invoke
>>> updatepp, instead it changes the software PTE and invalidates the PTE.
>>>
>>> For radix, radix__change_memory_range() is setup to do the right
>>> thing for vmalloc'd addresses. It takes a new parameter to decide
>>> what attributes to set.
>>>
>> ....
>>
>>> +int hash__change_memory_range(unsigned long start, unsigned long end,
>>> +                             unsigned long set, unsigned long clear)
>>> +{
>>> +     unsigned long idx;
>>> +     pgd_t *pgdp;
>>> +     pud_t *pudp;
>>> +     pmd_t *pmdp;
>>> +     pte_t *ptep;
>>> +
>>> +     start = ALIGN_DOWN(start, PAGE_SIZE);
>>> +     end = PAGE_ALIGN(end); // aligns up
>>> +
>>> +     /*
>>> +      * Update the software PTE and flush the entry.
>>> +      * This should cause a new fault with the right
>>> +      * things setup in the hash page table
>>> +      */
>>> +     pr_debug("Changing flags on range %lx-%lx setting 0x%lx removing 0x%lx\n",
>>> +              start, end, set, clear);
>>> +
>>> +     for (idx = start; idx < end; idx += PAGE_SIZE) {
>>
>>
>>> +             pgdp = pgd_offset_k(idx);
>>> +             pudp = pud_alloc(&init_mm, pgdp, idx);
>>> +             if (!pudp)
>>> +                     return -1;
>>> +             pmdp = pmd_alloc(&init_mm, pudp, idx);
>>> +             if (!pmdp)
>>> +                     return -1;
>>> +             ptep = pte_alloc_kernel(pmdp, idx);
>>> +             if (!ptep)
>>> +                     return -1;
>>> +             hash__pte_update(&init_mm, idx, ptep, clear, set, 0);
>
> I think this does the needful, if H_PAGE_HASHPTE is set, the flush
> will happen
>
>>> +             hash__flush_tlb_kernel_range(idx, idx + PAGE_SIZE);
>>> +     }
>>
>> You can use find_linux_pte_or_hugepte. with my recent patch series
>> find_init_mm_pte() ?
>>
>
> for pte_mkwrite and pte_wrprotect?

For walking page table. I am not sure you really want to allocate page
table in that function. If you do, then what will be the initial value
of PTE ? We are requesting to set an clear from and existing PTE entry
right ? If you find a none page table entry you should handle it via a
fault ?


-aneesh
