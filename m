Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA576606A31E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 10:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Tp8Y+6DM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY2081B5Wz2xwP;
	Mon, 23 Nov 2026 21:16:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::1b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795428968;
	cv=none; b=d5AQgE/npm/MK18Km1fH6geHi8510SeHP1sIeFKNFtV++wkU7tJFVjNa4wvnpcoCGKGtgOrnZtYls6qGolQODWcwNh1IDCXBpkygQH43mmjipJpwsffqfpVq91VjGV6pNgCR9WMjYxyLNbqW7+rwVUZ8Is4MfwQeXwzCWjHNyGkN30ZYHXRaxZOUAlZj95TZotbmB6ZhvZTVsyAbohHQUX7XoV/kdPdnPuWqCjR5hC8nRnAIgdyIdTO3E1K5nJZCcMdD2Ty4zgFBHSkVW/epqpYEbhI5PaYdQV3IVixdaHRrBkSMeS14ka2jGc5/PNOpDKGJ1nhqavFJuhwGKjQjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795428968; c=relaxed/relaxed;
	bh=5VZam8o1y0qDbPb40lL86ri5OnzIJLEYJQ5jktXiFv0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IiggV1FxnzheRFqPa2BgrDMFbJtRvW+DtlW2cF/5WKKJOV/pbmSgixt45f3paW0VKpB0AAv0AK/51cV4trxJ0JcY+IOZs7/5NO1cljeh8rMfNgy7eNrwiRWsV3QsSEoZ4gTQ8LTBSx9vGrR1SoFAm67AyA/oVkNFZtie3gPXQoFd6W0wYnJpGPcM/q74SojovVIWKDDcIxcp8CkgtARkMOiNxDEi/8rkq4vh6+t4o0sPqn9B2KJusgr59N4ukvV/7wI/R457INvriPxse7hZl3jyyMB0XxVSyiF5V/5WxYuhrDcbsW9bzOxXFKGdNRgCbDHxnAO7WienMjSYnUA/dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Tp8Y+6DM; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::1b; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Tp8Y+6DM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::1b; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-27.mta1.migadu.com [IPv6:2001:41d0:203:375::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY2030X93z2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 21:16:00 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=JunA8M01hnMz3RMuM3CcwD3rgeX5dq0GUnfQcSCgCqU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795428942; v=1; x=1796033742;
 b=Tp8Y+6DMuRHYwvurMY48qyDWbd0vw0TdktcTwlx10+Xqft7yl2FVn9qY0rDgNlLWbF0XNToB
 GBhGZchj5OMfOz2RTBBzVPpi9wsdgt9b4V7ZM4Q6v6ZhHgYUJg4+jYEmGnUrFy87utwC32ikWLn
 ZtgoR+mE8u5I1g4F9/UpnX4M=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 8cf77738964f3f07;
	Mon, 23 Nov 2026 10:15:35 +0000
X-Mizu-Trace-ID: 8cf77738964f3f07
X-Migadu-Flow: FLOW_OUT
Message-ID: <81b05a10-1b20-4132-8cc6-c71b88f21414@linux.dev>
Date: Mon, 23 Nov 2026 18:15:29 +0800
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
Content-Language: en-US
In-Reply-To: <793d63ff-c48b-431d-8a2a-4044feb45721@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/11/23 16:12, Hao Ge wrote:
> Hi Suren
> 
> On 2026/11/21 05:49, Suren Baghdasaryan wrote:
>> On Fri, Nov 20, 2026 at 9:14 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>>
>>> On Mon, Nov 16, 2026 at 7:13 AM Hao Ge <hao.ge@linux.dev> wrote:
>>>>
>>>> kmsan_vmap_pages_range_noflush() first maps the shadow pages and then
>>>> the origin pages. If the second mapping fails, the first one is left
>>>> mapped, and the callers do not roll it back. The next vmap of the
>>>> same metadata range hits the stale PTEs again and fails with a
>>>> WARN_ON() and -EBUSY in vmap_pages_pte_range().
>>>>
>>>> Undo the shadow mapping on that error path, the same way
>>>> kmsan_ioremap_page_range() cleans up after a partial failure.
>>>> __vunmap_range_noflush() only clears the PTEs; nothing has touched
>>>> the shadow mapping, so no TLB flush is needed.
>>
>> After a second thought, kmsan_ioremap_page_range() does not skip TLB
>> flushing. __vunmap_range_noflush() comment at
>> https://elixir.bootlin.com/linux/v7.4-rc1/source/mm/vmalloc.c#L497
>> says:
>>
>> The caller is responsible for calling flush_cache_vmap() before
>> calling this function, and flush_tlb_kernel_range after it has
>> returned successfully ...". There are no mentions of guarantees that
>> mapped PTEs require explicit access to be cached. Please double-check
>> if this is safe.
> 
> That's a subtle detail. I've looked up the relevant documentation.
> You are right, and my "no TLB flush is needed" was wrong.
> 
> The Arm "Learn the architecture" AArch64 memory management guide says it
> in "TLBs and Changing translations":
> 
> https://support.arm.com/documentation/101811/0106/TLBs-and-Changing-translations
> 
> If you change a translation table entry, or the controls that affect how entries
> are interpreted, then you need to invalidate the affected entries in the TLB. If
> you do not invalidate those entries, then the processor might continue to use the
> old translation.
> 
> The undo changes the shadow PTEs, so the TLB has to be invalidated.
> 
> I also checked the Arm Architecture Reference Manual:
> https://support.arm.com/documentation/ddi0487/md/-Part-D-The-AArch64-System-Level-Architecture/-Chapter-D8-The-AArch64-Virtual-Memory-System-Architecture/-D8-16-Translation-Lookaside-Buffers
> rule R SQBCS:
> 
> If a stage of translation is enabled for a translation regime that is not out-of-context,
> any translation table entry for that stage that does not cause a Translation fault,
> an Address size fault, or an Access flag fault is permitted to be cached in a TLB or
> intermediate TLB caching structure as the result of an explicit or speculative access.
> 
> So it may already be cached by speculative access even if there was no explicit access.
> 
> For the kernel side,  Documentation/core-api/cachetlb.rst
> https://elixir.bootlin.com/linux/v7.4-rc1/source/Documentation/core-api/cachetlb.rst
> says that The "TLB" is abstracted under Linux as something the cpu uses to cache
> virtual-->physical address translations obtained from the software page tables.
> Meaning that if the software page tables change, it is possible for stale translations
> to exist in this "TLB" cache. Therefore when software page table changes occur, the kernel will
> invoke one of the following flush methods _after_ the page table changes occur:
> 
> The condition there is the page table change, not whether the range was accessed.
> 
> Likewise, I believe flush_cache_vmap() is also required.
> The sequence in cachetlb.rst is
> flush_cache_range()
> change_range_of_page_tables()
> flush_tlb_range()
> so the cache flush has to happen before the unmap.
> This is exactly the contract that the __vunmap_range_noflush() comment you quoted spells out,
> the caller is responsible for calling flush_cache_vmap() before the call and flush_tlb_kernel_range()
> after it.
> 
> The code will do:
> 
> --- a/mm/kmsan/shadow.c
> +++ b/mm/kmsan/shadow.c
> @@ -258,6 +258,13 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
>                                             o_pages, page_shift);
>         kmsan_leave_runtime();
>         if (mapped) {
> +               /* Undo the shadow mapping set up above. */
> +               flush_cache_vmap(shadow_start, shadow_end);

Sorry, this should be flush_cache_vunmap.

> +               kmsan_enter_runtime();
> +               __vunmap_range_noflush(shadow_start, shadow_end,
> +                                      gfpflags_allow_blocking(gfp_mask));
> +               kmsan_leave_runtime();
> +               flush_tlb_kernel_range(shadow_start, shadow_end);
>                 err = mapped;
>                 goto ret;
>         }
>
> Thanks a lot for catching this, I learned quite a bit about the TLB
> along the way. 
> 
> Thanks
> Best Regards
> Hao
>>
>>>>
>>>> Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()")
>>>> Cc: stable@vger.kernel.org
>>>> Suggested-by: Suren Baghdasaryan <surenb@google.com>
>>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>>>
>>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>>>
>>>> ---
>>>>  mm/kmsan/shadow.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
>>>> index 0c88d89bf0d6..212449db34a1 100644
>>>> --- a/mm/kmsan/shadow.c
>>>> +++ b/mm/kmsan/shadow.c
>>>> @@ -258,6 +258,11 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
>>>>                                             o_pages, page_shift);
>>>>         kmsan_leave_runtime();
>>>>         if (mapped) {
>>>> +               /* Undo the shadow mapping set up above. */
>>>> +               kmsan_enter_runtime();
>>>> +               __vunmap_range_noflush(shadow_start, shadow_end,
>>>> +                                      gfpflags_allow_blocking(gfp_mask));
>>>> +               kmsan_leave_runtime();
>>>>                 err = mapped;
>>>>                 goto ret;
>>>>         }
>>>> --
>>>> 2.25.1
>>>>

