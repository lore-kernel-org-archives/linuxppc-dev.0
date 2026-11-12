Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75A6606A331
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PPAe8EdV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQCGH3f7Bz2yKn;
	Thu, 12 Nov 2026 18:49:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::c9"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794469783;
	cv=none; b=VH8QrpXBbmGfbRnNGwmtKN13enNL3wny6uEe+y7UOQYB1WwakjzgxlxsjXMwqZ6RKTlE2Uw0KJMi9FCf6qqVwSsfENbqB2KEHaI9skm1LmLdODQIT0BZD+/ROJFJoHu+W2ldDPRnIKWVSrT2nXsoA5Xihe9w5qe+KJO465M6GHQHePm3UPFSm9Sc5wiypgquzO3iSDVc6QCEYa9Y24rNCcnf+LOu0EtYTf1SQjI5bh9g/+Vj0Ct7GzLIxen7Kp92JzdZ6EZX8v6j0gHTdreeKdu0mQqKL0QPCNmxD8QXfkB/x3Rr+WW4Mfx5upbWzhqDQPEaZcBe2Wng+EQ7zWpvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794469783; c=relaxed/relaxed;
	bh=8u/Jrpuu2JVC6hI1ixrRZTm2BiUfBKSvznSfyHT+Io0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/rDwhkFUnTf7nC3zeMHVGKJaKPnPGm/63/7cbpPUPU/OyZZeLaHbH5mrBYlJe292jS+J9qDmOzQyUJmWPmUP+KVZt9tn9NePFrfFf2EQ6zsMgTwM43cWpBOpurhyOBDt2IUbvO0uzTyIOjeSw7a9BMksM9Qb/YiUrxD30GA+v/OtHGPOjgF5htcGaHwpsVqUCSyov1kdth7iAWlfdeGM6wXJ1Xgp8UXTV6pSVxsOwJVbHido8S/3TWbWcYzBrfQYAaZynv31HfUZvU3TJSDAGsfRKEJo3ZOO3jnzI50HD1xGFkmAKW8Quy35lHduh1gfJQUcgZzpdmnX5duqTJ+Jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PPAe8EdV; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::c9; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PPAe8EdV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::c9; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-201.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQCGD2rvgz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 18:49:38 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=6ulO7dBVIsFkGmxrkgfFgMkcM8Ux5PUXeXdSsWBAiK4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794469758; v=1; x=1795074558;
 b=PPAe8EdVUr72L9MGbfhyRw9G4D4unnmsjA498ARd/6RbCMsWGRLoLvlXtjuP9IkcW7hDaooB
 0hdlu8PV6u07HSSZHdNp1JDqC6JDZ4ixJAa0hNFvE2LGrLMKnhtbWnZBPg5m1lyD5mBzOibkhUj
 OprpzXrLWQWLBxp/O1vDUgxQ=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id fbff19d345a9f3e7;
	Thu, 12 Nov 2026 07:49:18 +0000
X-Mizu-Trace-ID: fbff19d345a9f3e7
X-Migadu-Flow: FLOW_OUT
Message-ID: <aa6caf61-a4a1-4c51-aae7-ebb767f3430c@linux.dev>
Date: Thu, 12 Nov 2026 15:50:41 +0800
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
Subject: Re: [PATCH v4 1/9] mm/kmsan: undo the shadow mapping when the origin
 mapping fails
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
References: <20261110112546.261415-1-hao.ge@linux.dev>
 <20261110112546.261415-2-hao.ge@linux.dev>
 <CAJuCfpHjSZhPPpRudAdrDPzz8dGK=Mx62CYCNoO4MC9OhnGd=A@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpHjSZhPPpRudAdrDPzz8dGK=Mx62CYCNoO4MC9OhnGd=A@mail.gmail.com>
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

On 2026/11/12 05:03, Suren Baghdasaryan wrote:
> On Tue, Nov 10, 2026 at 11:24 AM Hao Ge <hao.ge@linux.dev> wrote:
>>
>> kmsan_vmap_pages_range_noflush() first maps the shadow pages and then
>> the origin pages. If the second mapping fails, the first one is left
>> mapped, and the callers do not roll it back. The next vmap of the
>> same metadata range hits the stale PTEs again and fails with a
>> WARN_ON() and -EBUSY in vmap_pages_pte_range().
>>
>> Undo the shadow mapping on that error path, the same way
>> kmsan_ioremap_page_range() cleans up after a partial failure.
>> __vunmap_range_noflush() only clears the PTEs; nothing has touched
>> the shadow mapping, so no TLB flush is needed.
>>
>> Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>> Reviewed-by: Dev Jain <dev.jain@arm.com>
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  mm/kmsan/shadow.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
>> index 0c88d89bf0d6..2166086d3dc3 100644
>> --- a/mm/kmsan/shadow.c
>> +++ b/mm/kmsan/shadow.c
>> @@ -258,6 +258,10 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
>>                                             o_pages, page_shift);
>>         kmsan_leave_runtime();
>>         if (mapped) {
>> +               /* Undo the shadow mapping set up above. */
>> +               kmsan_enter_runtime();
>> +               __vunmap_range_noflush(shadow_start, shadow_end);
> 
> Sorry, there is a problem here. You introduce "can_resched" check to
> avoid calling cond_resched() later in the series (in patch #7), but at
> this point __vunmap_range_noflush() can be called with GFP flags which
> do not allow blocking. Before recent Ulad's change called "kmsan:
> remove hard-coded GFP_KERNEL flags" this function was called only with
> GPF_KERNEL but now that's not the case. I think you can move
> introduction of can_resched flag into this patch.

Agree. I just went back and looked at Ulad's b186a94227b7 ("kmsan:
remove hard-coded GFP_KERNEL flags").

So will do next version. But perhaps it is better to make it a separate
prep patch in the same series? Because besides this call site, the other
places that call __vunmap_range_noflush() need to be changed as well.

Thanks
Best Regards
Hao

> 
>> +               kmsan_leave_runtime();
>>                 err = mapped;
>>                 goto ret;
>>         }
>> --
>> 2.25.1
>>

