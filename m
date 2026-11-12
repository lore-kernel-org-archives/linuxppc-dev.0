Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F226606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=owLrm7cB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQBB246fLz2yKn;
	Thu, 12 Nov 2026 18:00:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.30
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794466858;
	cv=none; b=ZzMf0X+DJyYkSbqzH+lNZxiYfLpeOC5IEmBY2e05uGQ5JQxoHa3M9K5Fo1twgEQIQLUhtZBrBAUSyHpRB1Jwn9nt9HaI0FJ4Xc3c4sem885LQUA5E+llxoEjwJ/SexbW4pF7ezsh3InzvI0Ct7Pom4eVigRia4pEu7s4xk7TgKLTeeFIbVuYm3uM+jLNYlmLCuY77a1iUsxFCKma8MRr5cRWW9JxL+MFiRxF/8GbZaV5HT3P85jEzV4j8bWiW2PB9aV5fb9WwbLvrilJfyS6pF2vmEUjU4wpw1dDXVbriLfKg/b/akEk/Ze+OuxPu2xOu48txAljLywLkNzUmTT8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794466858; c=relaxed/relaxed;
	bh=J4xIggD0g8SlhhtdOwMFrAXrBVevW/MmjFyooXoSNeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jt7btISvHTRoWHP9poT9RPeOWQH8zaF6XzdxV+ks2hxjMChGK5221gf+h31lUIgQ3K8WX1iSiUXfWODMssa3tfKaLvocLRY37TyUcKplXPlqrADGUgA8+foFBgoU04fGMGpBHsNxIv28c4PBK7YIFiQWDXcXjISJE4/tz0iqZswI5M6Ex6XC5nYRDC4iFKjkBdA+iv4Mes01A/pT+uvWHQEYmIovqOG7vDivQYWNTDf+Gx2oa3WMAXA8c2CiPhdmqINzeXnO+/H9jGcQnD2otZ0JpMjwLaQq70T7yk4tfg6K8qWne7NumdN50/aFIaUkzz/M4knZOOjxVAj28J+dmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=owLrm7cB; dkim-atps=neutral; spf=pass (client-ip=95.215.58.30; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=owLrm7cB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.30; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQB9z5y7lz2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 18:00:54 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=IWVkZhORY9imY5FneS+keJKgSYCeTxoJHysJ7YNaF+Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794466836; v=1; x=1795071636;
 b=owLrm7cBfzN1UV7R16E1C54SoQ6uEbb9iF8oE9Q5nwcgoWHQirDw5gp7jkGwGjeLafzaGCP1
 Te46sEi7bhxP9cwDDRW2wHBKzqLnYx5iq1pmrfxW0YYJxKqEKpde6mzEEQo7PWPyTvt+znR0GhH
 xNDE2eDuB7safnAL4u5eo6JM=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 5f9d5e168c7f5611;
	Thu, 12 Nov 2026 07:00:23 +0000
X-Mizu-Trace-ID: 5f9d5e168c7f5611
X-Migadu-Flow: FLOW_OUT
Message-ID: <4ad546a2-66c5-4b74-a221-d9e8c1006c73@linux.dev>
Date: Thu, 12 Nov 2026 15:01:48 +0800
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
Subject: Re: [PATCH v4 6/9] mm/vmalloc: only flush the cache after the vmap
 succeeded
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
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20261110112546.261415-1-hao.ge@linux.dev>
 <20261110112546.261415-7-hao.ge@linux.dev>
 <CAJuCfpHReBDoXj_U3Dy2hksj63KyHNBm4gS+wtR_ywidyJ8mfw@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpHReBDoXj_U3Dy2hksj63KyHNBm4gS+wtR_ywidyJ8mfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/11/12 08:30, Suren Baghdasaryan wrote:
> On Tue, Nov 10, 2026 at 11:25 AM Hao Ge <hao.ge@linux.dev> wrote:
>>
>> vmap_page_range() and __vmap_pages_range() call flush_cache_vmap()
> 
> New vmap_pages_range_batched() function has the same issue, so needs fixing too.

Ack. will do next version.

> 
>> before they even look at the error code. A failed mapping is never
>> used, so the flush is pointless at best.
>>
>> According to the Sashiko review it is worse than pointless on UML:
>> flush_cache_vmap() there is flush_tlb_kernel_range(), which syncs the
>> PTEs into the host OS. Flushing a half-installed mapping therefore
>> leaves host mappings behind for a range that was just freed again.
>>
>> Only flush when the mapping, and for vmap_page_range() also the KMSAN
>> metadata, is fully set up.
>>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  mm/vmalloc.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 0565cbfe325c..3f98056f8c7e 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -369,10 +369,12 @@ int vmap_page_range(unsigned long addr, unsigned long end,
>>
>>         err = vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
>>                                  ioremap_max_page_shift);
>> -       flush_cache_vmap(addr, end);
>>         if (!err)
>>                 err = kmsan_ioremap_page_range(addr, end, phys_addr, prot,
>>                                                ioremap_max_page_shift);
>> +       if (!err)
>> +               flush_cache_vmap(addr, end);
>> +
>>         return err;
>>  }
>>
>> @@ -758,7 +760,9 @@ static int __vmap_pages_range(unsigned long addr, unsigned long end,
>>         int err;
>>
>>         err = vmap_pages_range_noflush(addr, end, prot, pages, page_shift, gfp_mask);
>> -       flush_cache_vmap(addr, end);
>> +       if (!err)
>> +               flush_cache_vmap(addr, end);
>> +
>>         return err;
>>  }
>>
>> --
>> 2.25.1
>>

