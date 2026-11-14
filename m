Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347C8606A329
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 06:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=f/TuyCvz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRPvt4pvnz2xKx;
	Sat, 14 Nov 2026 17:52:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794639178;
	cv=none; b=Fn2ANGmbWNkZO8tVgIjHe/Vlyb4iQfgVYI4obscCwo55u5iOtgL6JLE2blo4SDT3NAgUYRlSBtzvjKoZnusdVGv0Uiqke94Q3HPEUJHRyPgAIrITzYinJYKkvfQyY/+FQw5JXd7XfVYGG8ye/PVg4+/gGdIzwci56YrEsu257iS6g/30TesXZN5B7BN3DZRCwWZPuxk6aWq3+DTqhedvOjrUxLq2EBcDxggXQbjx3wMIj+Kz60OFnhHLr060jNtAAXMNK9E1tO8w7yZctvdT7MIUWqhLs/a2r7i4oO5vUEQB6XoSqWDFMTlqhktPZNDmBJSDuEfocB1cSVSHbtqtAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794639178; c=relaxed/relaxed;
	bh=Kr6uumd8dZOWTXDkFndJlR1ttlboBxrC9NzsnPYAVyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODirlNL8B8X294Wuv9rv6RyUB05zxzMWRUEGjqZUgsCCd/3vNV2hJ/bJ9MCg9qbCpPQBdsXuUwpshHauteW6y8Q6OIJhV4sm3PX3spDn3i0NnOfezR0/gnAbBNcUMBOMLFZPdZGkXD09hYuFhDoWDnlm9vap1H0/MMCm6zycMm+T9XmXC36Sm3uy+SZcox7vaqJ2GOjRl2D8fhvpkLcOkWgMSMB7hsDE7gZ9CFnW0xSeaZJkVzPB4cnypNDYFYD8yJjS070F7Hsf6/NdcMH48iysov16cjDIYNVyMFxOVzwO/g18bmB6KjTbGsZCQsMMbbFiv6JYpDJczZ/kZm4RpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=f/TuyCvz; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=f/TuyCvz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRPvr1gssz2xKv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 17:52:54 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81F191516;
	Fri, 13 Nov 2026 22:52:18 -0800 (PST)
Received: from [10.163.154.162] (unknown [10.163.154.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5D393F632;
	Fri, 13 Nov 2026 22:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794639141; bh=W8qZfT5oF3Z3OszzVIIAvjlZBFk4CgT7p0JvaMolklc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f/TuyCvzT91xJJ3zuUEj6cboGIJ/7A2DW7rRLO6fBDEGcmUdfQ6632WQyzFMupBSa
	 tezFVLM2HDABsgEG/fWc9VrLN4siR2Py8/m35sPeLrLSXjMQBYOWLnjeqJVTfpaWkD
	 uRgIYWMaRoVJXir/ypqZkK8h6sjV1cGLApguMz2w=
Message-ID: <91baeed5-c432-445b-a2db-7bc20c8921b0@arm.com>
Date: Sat, 14 Nov 2026 12:22:11 +0530
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
Subject: Re: [PATCH v3 03/10] mm/vmalloc: clamp an unaligned range in
 vunmap_pte_range()
To: Hao Ge <hao.ge@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 Sashiko <sashiko-bot@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 Uladzislau Rezki <urezki@gmail.com>, Suren Baghdasaryan <surenb@google.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
References: <20261026080329.140244-1-hao.ge@linux.dev>
 <20261026080329.140244-4-hao.ge@linux.dev>
 <99f529e8-06f7-4a20-a60b-0330c5d3d91c@arm.com>
 <5452d555-82f9-45a6-b443-ee732b1874ba@linux.dev>
 <e8a2a42d-e424-4366-8a68-e39167f62276@arm.com>
 <72d1b1d7-2fb6-402f-a557-0eaa767d6f86@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <72d1b1d7-2fb6-402f-a557-0eaa767d6f86@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 02/11/26 11:37 am, Hao Ge wrote:
> 
> 
> On 2026/10/30 22:20, Dev Jain wrote:
>>
>>
>> On 30/10/26 2:00 pm, Hao Ge wrote:
>>> Hi Dev
>>>
>>> Thanks for your review.
>>>
>>> On 2026/10/30 15:14, Dev Jain wrote:
>>>>
>>>>
>>>> On 26/10/26 1:33 pm, Hao Ge wrote:
>>>>> commit a739e6b557af ("mm: vmalloc: WARN_ON if mapping size is not
>>>>> PAGE_SIZE aligned") made vmap_pte_range() warn and bail out when the
>>>>> size is not a multiple of PAGE_SIZE. That loop steps in page
>>>>
>>>> Why are we checking the alignment so late into vmap_pte_range? Why not
>>>> simply do
>>>>
>>>> if (!IS_ALIGNED(addr, PAGE_SIZE) || !IS_ALIGNED(end, PAGE_SIZE))
>>>> 	return; (or return -EINVAL);
>>>>
>>>> at the start of vmap_range_noflush and vunmap_range_noflush?
>>>
>>> I think adding that check at the entry of vunmap_range_noflush()
>>> goes against its design intent. Its job is to tear down the mappings
>>> of the given VA range, so even when the caller passes a size that is
>>> not page-aligned, we still have to unmap whatever is mapped within
>>> that range.
>>>
>>> So the patch clamps end down to the last full page and keeps
>>> clearing. A buggy caller still gets its mapping torn down as far as
>>> it goes, and nothing is left behind. The check here is just for
>>> protection. 
>>>
>>> This is just my preliminary understanding; I may be mistaken.
>>
>> Hmm I get you, but this is very ugly. We are trying to tolerate
>> a blatant bug in the caller with not-so-nice code. But see below.
>>>
>>> Thanks
>>> Best Regards
>>> Hao
>>>
>>>
>>> But that's just my understanding, happy to be corrected.
>>>
>>>
>>>>
>>>>
>>>>> multiples and stops only at addr == end; with an unaligned size addr
>>>>> never lands on end, so the loop cannot terminate and walks off the
>>>>> end of the page table.
>>>>>
>>>>> vunmap_pte_range() has the same loop without any guard, so an
>>>>> unaligned range would clear PTEs past end without ever stopping,
>>>>> walking off the end of the page table.
>>>>>
>>>>> Add the check there too. The range is clamped down to the last full
>>>>> page rather than dropped, and the loop is skipped when nothing is
>>>>> left, so a buggy caller still gets its PTEs cleared as far as they
>>>>> go.
>>>>>
>>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>>>>> ---
>>>>>  mm/vmalloc.c | 5 +++++
>>>>>  1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>>>> index 44e0eb32708f..7131f60d1a8e 100644
>>>>> --- a/mm/vmalloc.c
>>>>> +++ b/mm/vmalloc.c
>>>>> @@ -393,6 +393,11 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>>>>>  	pte_t ptent;
>>>>>  	unsigned long size = PAGE_SIZE;
>>>>>  
>>>>> +	if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
>>>>> +		end = addr + PAGE_ALIGN_DOWN(end - addr);
>>
>> For simplicity assume PAGE_SIZE is 4, start is 3, end is 10.
>> With your code we will get
>>
>> addr = 3, end = 3 + ALIGN_DOWN(10 - 3) = 3 + 4 = 7.
>> So the range becomes [3, 7) clearing only two ptes, the one covering
>> [0, 3], the second covering [4, 7]. I feel we should rather make
>> the range from [3, 10] to [0, 11], clearing three ptes.
>>
> 
> Thanks for the example. Looks like I nearly introduced a new bug while
> guarding against the old one, good thing you caught it.
> 
>> So, at the start of vunmap_range_noflush we could basically
>> WARN_ON on non-alignment, and then clamp the start down, and clamp
>> the end up to PAGE_SIZE.
> 
> I'm wondering whether we should simply BUG_ON for non-aligned ranges here.
> Because the unmap could silently clear mappings at adjacent addresses, which
> may not even belong to the caller, and this kind of problem is really hard to
> track down afterwards. Say [0, 3) is in use by someone else, with PAGE_SIZE=4
> an unmap starting at 3 still begins with the pte covering [0, 4), since the loop
> clears page by page, so that owner loses his mapping without doing anything wrong,
> and only sees the damage much later when he touches it again.
> 
> WDYT?
> 
>>
>> And with this also throw in a patch to bring the -EINVAL bailout
>> in vmap_pte_range to the top, in vmap_range_noflush and check
>> both start and end alignment.
> 
> For the vmap_range_noflush() check, fully agreed.  The current check
> is indeed too late, the range is only found to be bad after part of
> it has already been mapped. 
> 
> Looking forward to your valuable comments.

I was on vacation, I'll review the next version soon.


> 
> Thanks
> Best Regards
> Hao
>>
>>>>> +	if (end == addr)
>>>>> +		return;
>>>>> +
>>>>>  	pte = pte_offset_kernel(pmd, addr);
>>>>>  	lazy_mmu_mode_enable();
>>>>>  
>>>>
>>


