Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6815606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Y0E4pc8T
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZCL468F0z2xlh;
	Wed, 25 Nov 2026 19:20:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::85"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795594844;
	cv=none; b=NuJbgQXJLcXt8Z+IiRoZAd17JJbMBf2Xw2x3gU5eoskipD/cMeYgVHXLWeOM7l19oz7ZvRgP2XAZmdbeF8fc1n7mRiojyCIV1bJU35aVTOus5NgDBFd2jnY6YYh/d/nrc3xiVd5xOIvbqcZ7ityYUaeS22VCAm0Z6SJbyhpPoSBpcRP72Vczcher87q2XCpBMz//Tn7lFVbN++fuL9PlG5o2ZdBsPOMuv9oyJkblJoPYNj4KetuqiFqkgDTWwZ6H+27OYN4WZXWzJKhhEDL7VGpXCxWOf4yvO5lqC5sQetNBTciedp+7piPGURoe2GaSq6jlNSjcUou00dTowpuvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795594844; c=relaxed/relaxed;
	bh=QfZ3lG2uOxeiODVkla0mMOvEHpv7y5P99cIsSRHzDec=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=l5nXqLVUh8I2tQ11OerYsq+JklNQ//KPd0cytyjZUOai1TWzV/Ol5lVFEj10Pwr34DOWlkdi40iMK2uSOZIv0j0Xb+9MlWzNCoCTHvvZfZm3d3oLqF0pXqb/L3lX5TvwPSgU2FCTO1qZmuJawvwqJ+A8NmgiB7mfLqf68t+jr+7Rz19VJO38wqMSOZK7MYcZWiSl4PEsPdof7JW6MZ3h+WMaEqZMjJ4amGh+h8CC/iYNQO5alqV6CoI3otim/umUiTzfMGjZ2BQfdJvwk3zXGMxQ/djmM85LnI5GiZM7Wvz5O9/NQTKzquBf0SVO4pFvavWqciRgx1DpAi+VlDxO2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Y0E4pc8T; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::85; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Y0E4pc8T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::85; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-133.mta0.migadu.com [IPv6:2001:41d0:1004:224b::85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZCL0544zz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 19:20:38 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=/919UxKRMyPlULBGJtfj9Q5QU8pqqMoGwH6XL9fnwpU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795594815; v=1; x=1796199615;
 b=Y0E4pc8THdsEx1zmo1BBP1WSc46ylAD4u0nTAgDtqG+t0su8WW+lI+cyTilfJ0oZVaOsXiaY
 b5OJVJM/YiiPlgPIP0OrTfAqBPxcc6ry8HEK+Wmd4iEoV3S+nb6+bpIjxtUnKalLAlQGtR0Kqm0
 UXj1DIgOXIPph2m4lvGVvtuc=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 523a68c985d1740f;
	Wed, 25 Nov 2026 08:20:11 +0000
X-Mizu-Trace-ID: 523a68c985d1740f
X-Migadu-Flow: FLOW_OUT
Message-ID: <b63bc354-0f29-49fb-84ec-313bf4283360@linux.dev>
Date: Wed, 25 Nov 2026 16:20:00 +0800
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/11] mm/kmsan: undo the shadow mapping when the
 origin mapping fails
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, stable@vger.kernel.org
References: <20261116071325.263682-1-hao.ge@linux.dev>
 <20261116071325.263682-3-hao.ge@linux.dev>
 <CAJuCfpHOZS6mp_no3wKmU3-S4HKspnbriUw8Mwtxf3nmw0-pfw@mail.gmail.com>
 <CAJuCfpFv=sCeib+SDWJNW6oqbNnhT+m3YjnfKh8jNkquzuYORg@mail.gmail.com>
 <793d63ff-c48b-431d-8a2a-4044feb45721@linux.dev>
 <81b05a10-1b20-4132-8cc6-c71b88f21414@linux.dev>
Content-Language: en-US
In-Reply-To: <81b05a10-1b20-4132-8cc6-c71b88f21414@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Suren


On 2026/11/23 18:15, Hao Ge wrote:
> 
> 
> On 2026/11/23 16:12, Hao Ge wrote:
>> Hi Suren
>>
>> On 2026/11/21 05:49, Suren Baghdasaryan wrote:
>>> On Fri, Nov 20, 2026 at 9:14 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>>>
>>>> On Mon, Nov 16, 2026 at 7:13 AM Hao Ge <hao.ge@linux.dev> wrote:
>>>>>
>>>>> kmsan_vmap_pages_range_noflush() first maps the shadow pages and then
>>>>> the origin pages. If the second mapping fails, the first one is left
>>>>> mapped, and the callers do not roll it back. The next vmap of the
>>>>> same metadata range hits the stale PTEs again and fails with a
>>>>> WARN_ON() and -EBUSY in vmap_pages_pte_range().
>>>>>
>>>>> Undo the shadow mapping on that error path, the same way
>>>>> kmsan_ioremap_page_range() cleans up after a partial failure.
>>>>> __vunmap_range_noflush() only clears the PTEs; nothing has touched
>>>>> the shadow mapping, so no TLB flush is needed.
>>>
>>> After a second thought, kmsan_ioremap_page_range() does not skip TLB
>>> flushing. __vunmap_range_noflush() comment at
>>> https://elixir.bootlin.com/linux/v7.4-rc1/source/mm/vmalloc.c#L497
>>> says:
>>>
>>> The caller is responsible for calling flush_cache_vmap() before
>>> calling this function, and flush_tlb_kernel_range after it has
>>> returned successfully ...". There are no mentions of guarantees that
>>> mapped PTEs require explicit access to be cached. Please double-check
>>> if this is safe.
>>
>> That's a subtle detail. I've looked up the relevant documentation.
>> You are right, and my "no TLB flush is needed" was wrong.
>>
>> The Arm "Learn the architecture" AArch64 memory management guide says it
>> in "TLBs and Changing translations":
>>
>> https://support.arm.com/documentation/101811/0106/TLBs-and-Changing-translations
>>
>> If you change a translation table entry, or the controls that affect how entries
>> are interpreted, then you need to invalidate the affected entries in the TLB. If
>> you do not invalidate those entries, then the processor might continue to use the
>> old translation.
>>
>> The undo changes the shadow PTEs, so the TLB has to be invalidated.
>>
>> I also checked the Arm Architecture Reference Manual:
>> https://support.arm.com/documentation/ddi0487/md/-Part-D-The-AArch64-System-Level-Architecture/-Chapter-D8-The-AArch64-Virtual-Memory-System-Architecture/-D8-16-Translation-Lookaside-Buffers
>> rule R SQBCS:
>>
>> If a stage of translation is enabled for a translation regime that is not out-of-context,
>> any translation table entry for that stage that does not cause a Translation fault,
>> an Address size fault, or an Access flag fault is permitted to be cached in a TLB or
>> intermediate TLB caching structure as the result of an explicit or speculative access.
>>
>> So it may already be cached by speculative access even if there was no explicit access.
>>
>> For the kernel side,  Documentation/core-api/cachetlb.rst
>> https://elixir.bootlin.com/linux/v7.4-rc1/source/Documentation/core-api/cachetlb.rst
>> says that The "TLB" is abstracted under Linux as something the cpu uses to cache
>> virtual-->physical address translations obtained from the software page tables.
>> Meaning that if the software page tables change, it is possible for stale translations
>> to exist in this "TLB" cache. Therefore when software page table changes occur, the kernel will
>> invoke one of the following flush methods _after_ the page table changes occur:
>>
>> The condition there is the page table change, not whether the range was accessed.
>>
>> Likewise, I believe flush_cache_vmap() is also required.
>> The sequence in cachetlb.rst is
>> flush_cache_range()
>> change_range_of_page_tables()
>> flush_tlb_range()
>> so the cache flush has to happen before the unmap.
>> This is exactly the contract that the __vunmap_range_noflush() comment you quoted spells out,
>> the caller is responsible for calling flush_cache_vmap() before the call and flush_tlb_kernel_range()
>> after it.
>>
>> The code will do:
>>
>> --- a/mm/kmsan/shadow.c
>> +++ b/mm/kmsan/shadow.c
>> @@ -258,6 +258,13 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
>>                                             o_pages, page_shift);
>>         kmsan_leave_runtime();
>>         if (mapped) {
>> +               /* Undo the shadow mapping set up above. */
>> +               flush_cache_vmap(shadow_start, shadow_end);
> 
> Sorry, this should be flush_cache_vunmap.
> 
>> +               kmsan_enter_runtime();
>> +               __vunmap_range_noflush(shadow_start, shadow_end,
>> +                                      gfpflags_allow_blocking(gfp_mask));
>> +               kmsan_leave_runtime();
>> +               flush_tlb_kernel_range(shadow_start, shadow_end);
>>                 err = mapped;
>>                 goto ret;
>>         }
>>
>> Thanks a lot for catching this, I learned quite a bit about the TLB
>> along the way. 
>>

Let's revisit this. Unless I'm missing something, the unmap counterpart,
kmsan_vunmap_range_noflush(), appears to be missing its TLB flush.

Taking vmalloc as the example:

vmalloc
    __vmalloc_area_node()
        vmap_pages_range()
            vmap_pages_range_noflush()
                kmsan_vmap_pages_range_noflush()
		    installs the shadow/origin and flushes
		    their TLB at the tail /* flushed */

vfree
    remove_vm_area
        free_unmap_vmap_area
            vunmap_range_noflush /*shadow/origin PTEs cleared,
				   no TLB flush */
            free_vmap_area_noflush() /* area -> lazy list

    ... later, when the lazy list is settled: 
    __purge_vmap_area_lazy
        flush_tlb_kernel_range(start, end);
        /* no shadow/origin tlb flush */

So unlike the normal paths, KMSAN performs the TLB flush when the range
is reused and re-mapped, rather than flushing it immediately after unmap.

I'm not sure this is safe. Reading the documentation, this should not be safe,
perhaps I have misinterpreted the documentation.
If this was intentional, maybe a TLB flush is not required here, but if so I would
expect it in the purge instead, together with the main range. After all, vmalloc is
frequently called, and lazy TLB flushing is an existing optimization for vmalloc.

Would you mind taking a look at this concern, or letting me know who I could ask?
This would be a good opportunity for me to brush up on my TLB knowledge, and I would
greatly appreciate your input.

Thanks
Best Regards
Hao

>> Thanks
>> Best Regards
>> Hao
>>>
>>>>>
>>>>> Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()")
>>>>> Cc: stable@vger.kernel.org
>>>>> Suggested-by: Suren Baghdasaryan <surenb@google.com>
>>>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>>>>
>>>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>>>>
>>>>> ---
>>>>>  mm/kmsan/shadow.c | 5 +++++
>>>>>  1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
>>>>> index 0c88d89bf0d6..212449db34a1 100644
>>>>> --- a/mm/kmsan/shadow.c
>>>>> +++ b/mm/kmsan/shadow.c
>>>>> @@ -258,6 +258,11 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
>>>>>                                             o_pages, page_shift);
>>>>>         kmsan_leave_runtime();
>>>>>         if (mapped) {
>>>>> +               /* Undo the shadow mapping set up above. */
>>>>> +               kmsan_enter_runtime();
>>>>> +               __vunmap_range_noflush(shadow_start, shadow_end,
>>>>> +                                      gfpflags_allow_blocking(gfp_mask));
>>>>> +               kmsan_leave_runtime();
>>>>>                 err = mapped;
>>>>>                 goto ret;
>>>>>         }
>>>>> --
>>>>> 2.25.1
>>>>>

