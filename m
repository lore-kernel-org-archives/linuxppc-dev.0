Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F9B606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wKO1e9JG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXzGS4vQSz2xyj;
	Mon, 23 Nov 2026 19:13:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::2a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795421600;
	cv=none; b=Ns8MnO3/JH4+mC0ZZNwsVNYw/dOFAxjHM0+XaAFnWxNVw9OWFfUZbreMTnWoDpdedgjzMQd7fd7ovhND3RvmAZTKS4g0bmC9/oBcSy7DUjdfyeRLSU6x/G6p/j5ZqkAQHvskhi264Szw0zIBtXSrnj7zov2BdydkS26zvncBJN0G2sw713WiUQ6Yc2cAx4vA9TjsTcJQonCRGyCyRQiLsmyTIY94I/Ep4F6jgM7ow0puefFNdaxhV6Ww05LHIrubSFEzTe2UKzSE8auIw1IwwvWASun3plosHysFHK+BgIo/EM7PSBC38qw5yY1uJ5r3iPtT1mofCSXIiCIg2ajbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795421600; c=relaxed/relaxed;
	bh=6jeN8jAJwq+1hUMXlRYrpD7AgdkVOgMUP5t8JmxUI2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsH/4vy31OsBOdtageylW7VQn6HeyZcowu0Izmtxkn4zKuawLNdaBpdwtKXW1viwf3drefneaorWVWEjJu62XnKF0GV/QybrjpopnHmbGczNnFT1xiJa/rrI4orQtmboCMTSMQ4xLkDgxImUFjsX4CD5Ge05tuNL9fxdP915PJS4MRIaK9MaQYUMUQrYKw3rS1JYFsPVNeMb81K41TSJLgeiFwC/aZcFrQMP5HNq0WnaP0V3RakJNcj4F6MyHRnabxHWaUoRfC0U6yrUIJLkRTLoi7XNyM+d9pquBJok/6Fj0sK2bBI1zeI9JUVzxB8YzRJXaHMnTiQCYl+FHTp67A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wKO1e9JG; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::2a; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wKO1e9JG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::2a; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-42.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXzGP1Mldz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 19:13:15 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=RvrR5l1dNK11b4mH1JIdE/igKyGnL+zkw54T9Nsh9yE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795421572; v=1; x=1796026372;
 b=wKO1e9JGDzqD1t9RdLopQR/RqknqWfCQZH7iLfbq3+9sW/3zLN/1OKhGvNlAldPf9OjKOINd
 AUr53HEskD/RGF9eQ0m+54cwpu5pMapeOWSD25o3PnoBUy91ZqKGJSdRNFZcNPOGKqZctK/bqCW
 wrPkSHtCJRpVb51ZLDpAz1ZM=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id d0f5c025c2c20c78;
	Mon, 23 Nov 2026 08:12:51 +0000
X-Mizu-Trace-ID: d0f5c025c2c20c78
X-Migadu-Flow: FLOW_OUT
Message-ID: <793d63ff-c48b-431d-8a2a-4044feb45721@linux.dev>
Date: Mon, 23 Nov 2026 16:12:46 +0800
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
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpFv=sCeib+SDWJNW6oqbNnhT+m3YjnfKh8jNkquzuYORg@mail.gmail.com>
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

On 2026/11/21 05:49, Suren Baghdasaryan wrote:
> On Fri, Nov 20, 2026 at 9:14 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>
>> On Mon, Nov 16, 2026 at 7:13 AM Hao Ge <hao.ge@linux.dev> wrote:
>>>
>>> kmsan_vmap_pages_range_noflush() first maps the shadow pages and then
>>> the origin pages. If the second mapping fails, the first one is left
>>> mapped, and the callers do not roll it back. The next vmap of the
>>> same metadata range hits the stale PTEs again and fails with a
>>> WARN_ON() and -EBUSY in vmap_pages_pte_range().
>>>
>>> Undo the shadow mapping on that error path, the same way
>>> kmsan_ioremap_page_range() cleans up after a partial failure.
>>> __vunmap_range_noflush() only clears the PTEs; nothing has touched
>>> the shadow mapping, so no TLB flush is needed.
> 
> After a second thought, kmsan_ioremap_page_range() does not skip TLB
> flushing. __vunmap_range_noflush() comment at
> https://elixir.bootlin.com/linux/v7.4-rc1/source/mm/vmalloc.c#L497
> says:
> 
> The caller is responsible for calling flush_cache_vmap() before
> calling this function, and flush_tlb_kernel_range after it has
> returned successfully ...". There are no mentions of guarantees that
> mapped PTEs require explicit access to be cached. Please double-check
> if this is safe.

That's a subtle detail. I've looked up the relevant documentation.
You are right, and my "no TLB flush is needed" was wrong.

The Arm "Learn the architecture" AArch64 memory management guide says it
in "TLBs and Changing translations":

https://support.arm.com/documentation/101811/0106/TLBs-and-Changing-translations

If you change a translation table entry, or the controls that affect how entries
are interpreted, then you need to invalidate the affected entries in the TLB. If
you do not invalidate those entries, then the processor might continue to use the
old translation.

The undo changes the shadow PTEs, so the TLB has to be invalidated.

I also checked the Arm Architecture Reference Manual:
https://support.arm.com/documentation/ddi0487/md/-Part-D-The-AArch64-System-Level-Architecture/-Chapter-D8-The-AArch64-Virtual-Memory-System-Architecture/-D8-16-Translation-Lookaside-Buffers
rule R SQBCS:

If a stage of translation is enabled for a translation regime that is not out-of-context,
any translation table entry for that stage that does not cause a Translation fault,
an Address size fault, or an Access flag fault is permitted to be cached in a TLB or
intermediate TLB caching structure as the result of an explicit or speculative access.

So it may already be cached by speculative access even if there was no explicit access.

For the kernel side,  Documentation/core-api/cachetlb.rst
https://elixir.bootlin.com/linux/v7.4-rc1/source/Documentation/core-api/cachetlb.rst
says that The "TLB" is abstracted under Linux as something the cpu uses to cache
virtual-->physical address translations obtained from the software page tables.
Meaning that if the software page tables change, it is possible for stale translations
to exist in this "TLB" cache. Therefore when software page table changes occur, the kernel will
invoke one of the following flush methods _after_ the page table changes occur:

The condition there is the page table change, not whether the range was accessed.

Likewise, I believe flush_cache_vmap() is also required.
The sequence in cachetlb.rst is
flush_cache_range()
change_range_of_page_tables()
flush_tlb_range()
so the cache flush has to happen before the unmap.
This is exactly the contract that the __vunmap_range_noflush() comment you quoted spells out,
the caller is responsible for calling flush_cache_vmap() before the call and flush_tlb_kernel_range()
after it.

The code will do:

--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -258,6 +258,13 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
                                            o_pages, page_shift);
        kmsan_leave_runtime();
        if (mapped) {
+               /* Undo the shadow mapping set up above. */
+               flush_cache_vmap(shadow_start, shadow_end);
+               kmsan_enter_runtime();
+               __vunmap_range_noflush(shadow_start, shadow_end,
+                                      gfpflags_allow_blocking(gfp_mask));
+               kmsan_leave_runtime();
+               flush_tlb_kernel_range(shadow_start, shadow_end);
                err = mapped;
                goto ret;
        }

Thanks a lot for catching this, I learned quite a bit about the TLB
along the way. 

Thanks
Best Regards
Hao
> 
>>>
>>> Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()")
>>> Cc: stable@vger.kernel.org
>>> Suggested-by: Suren Baghdasaryan <surenb@google.com>
>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>>
>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>>
>>> ---
>>>  mm/kmsan/shadow.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
>>> index 0c88d89bf0d6..212449db34a1 100644
>>> --- a/mm/kmsan/shadow.c
>>> +++ b/mm/kmsan/shadow.c
>>> @@ -258,6 +258,11 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
>>>                                             o_pages, page_shift);
>>>         kmsan_leave_runtime();
>>>         if (mapped) {
>>> +               /* Undo the shadow mapping set up above. */
>>> +               kmsan_enter_runtime();
>>> +               __vunmap_range_noflush(shadow_start, shadow_end,
>>> +                                      gfpflags_allow_blocking(gfp_mask));
>>> +               kmsan_leave_runtime();
>>>                 err = mapped;
>>>                 goto ret;
>>>         }
>>> --
>>> 2.25.1
>>>

