Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryZKT39N0zDqhN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 18:33:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH for-4.8 V2 03/10] powerpc/mm/radix: Add radix_set_pte to
 use in early init
In-Reply-To: <20160725162349.1bc9a9fe@roar.ozlabs.ibm.com>
References: <1469265163-1491-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1469265163-1491-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160725162349.1bc9a9fe@roar.ozlabs.ibm.com>
Date: Mon, 25 Jul 2016 18:33:41 +1000
Message-ID: <87vazuyv4q.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> On Sat, 23 Jul 2016 14:42:36 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>> @@ -102,7 +123,7 @@ int radix__map_kernel_page(unsigned long ea,
>> unsigned long pa, }
>>  
>>  set_the_pte:
>> -	set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
>> flags));
>> +	radix__set_pte(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
>> flags)); smp_wmb();
>
> What we have in existing code is set_pte_at() function that adds
> the _PAGE_PTE bit, then calls __set_pte_at(), which calls radix or hash
> version of __set_pte_at().
>
> Now we also have radix__set_pte(), which has the function of the
> set_pte_at(), which is starting to confuse the naming convention.
> The new function is a radix-only set_pte_at(), rather than the
> radix implementation that gets called via set_pte().
>
> set_pte_at_radix()? That kind of sucks too, though. It might be better
> if the radix/hash variants were called __radix__set_pte_at(), and this
> new function was called radix__set_pte_at().

I think Aneesh originally used set_pte_at_r() or maybe rset_pte_at()?

It was my idea to use radix__ and hash__ as prefixes for all the
radix/hash functions.

That was 1) to make it clear that it's not part of the name as such, ie.
it's a prefix, and 2) because it's ugly as hell and hopefully that would
motivate us to consolidate as many of them as possible.

I balked at adding __radix__set_pte_at(), and just went with
radix__set_pte_at(). But it does complicate things now.

In fact I think we need to rethink this whole series, and not actually
do it this way at all, meaning this naming problem will go away.

cheers
