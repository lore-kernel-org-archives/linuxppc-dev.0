Return-Path: <bsingharora@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMqK10rS4zDrLg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 20:33:07 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id i19so4138507qte.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 03:33:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87pocez3f8.fsf@linux.vnet.ibm.com>
References: <20170801112535.20765-1-bsingharora@gmail.com>
 <20170801112535.20765-2-bsingharora@gmail.com>
 <87pocez3f8.fsf@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 2 Aug 2017 20:33:04 +1000
Message-ID: <CAKTCnzkqN3j-cjuQrWHMe_4P1omCyyuFHA7yKFUZ_JUFSspmDA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] arch/powerpc/set_memory: Implement set_memory_xx
 routines
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 2, 2017 at 8:09 PM, Aneesh Kumar K.V
<aneesh.kumar@linux.vnet.ibm.com> wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
>
>> Add support for set_memory_xx routines. With the STRICT_KERNEL_RWX
>> feature support we got support for changing the page permissions
>> for pte ranges. This patch adds support for both radix and hash
>> so that we can change their permissions via set/clear masks.
>>
>> A new helper is required for hash (hash__change_memory_range()
>> is changed to hash__change_boot_memory_range() as it deals with
>> bolted PTE's).
>>
>> hash__change_memory_range() works with vmalloc'ed PAGE_SIZE requests
>> for permission changes. hash__change_memory_range() does not invoke
>> updatepp, instead it changes the software PTE and invalidates the PTE.
>>
>> For radix, radix__change_memory_range() is setup to do the right
>> thing for vmalloc'd addresses. It takes a new parameter to decide
>> what attributes to set.
>>
> ....
>
>> +int hash__change_memory_range(unsigned long start, unsigned long end,
>> +                             unsigned long set, unsigned long clear)
>> +{
>> +     unsigned long idx;
>> +     pgd_t *pgdp;
>> +     pud_t *pudp;
>> +     pmd_t *pmdp;
>> +     pte_t *ptep;
>> +
>> +     start = ALIGN_DOWN(start, PAGE_SIZE);
>> +     end = PAGE_ALIGN(end); // aligns up
>> +
>> +     /*
>> +      * Update the software PTE and flush the entry.
>> +      * This should cause a new fault with the right
>> +      * things setup in the hash page table
>> +      */
>> +     pr_debug("Changing flags on range %lx-%lx setting 0x%lx removing 0x%lx\n",
>> +              start, end, set, clear);
>> +
>> +     for (idx = start; idx < end; idx += PAGE_SIZE) {
>
>
>> +             pgdp = pgd_offset_k(idx);
>> +             pudp = pud_alloc(&init_mm, pgdp, idx);
>> +             if (!pudp)
>> +                     return -1;
>> +             pmdp = pmd_alloc(&init_mm, pudp, idx);
>> +             if (!pmdp)
>> +                     return -1;
>> +             ptep = pte_alloc_kernel(pmdp, idx);
>> +             if (!ptep)
>> +                     return -1;
>> +             hash__pte_update(&init_mm, idx, ptep, clear, set, 0);

I think this does the needful, if H_PAGE_HASHPTE is set, the flush
will happen

>> +             hash__flush_tlb_kernel_range(idx, idx + PAGE_SIZE);
>> +     }
>
> You can use find_linux_pte_or_hugepte. with my recent patch series
> find_init_mm_pte() ?
>

for pte_mkwrite and pte_wrprotect?

Balbir Singh.
