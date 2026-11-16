Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E213F606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 04:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=l5EctVU3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSZLg1nvLz2xnn;
	Mon, 16 Nov 2026 15:16:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794802603;
	cv=none; b=De6ov9VkArJ8OtxTDug7hD4ojaY6fYH775axPI8XwDXQlEaIIlIIoXqh0tNI8qFAGEOWofpjp5RjdYwLGNRH9LsfvD/BC3et/7ampz+wWxDv2+HHEP03PB92FN2YWtHGyMb5bBZ7RntjpWrZyhMNu/pOw/2tjv79Ez7r2oq1Z17a+TaKtDCnKD5LJOEhIxwxJmHZBkkS8k+UEWFvGEFmE0nkNnp1WxZctT9wncvhqiEXh1Hssr6rE1Mo58aJqK5kx/GpeIRcAnf3Y20VgfpFC+xBVbtKA38nq4AiUobegkjjBlf/Vx3NdmDvYgELivcrGfKihcvqNc7PLO5vWYUsNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794802603; c=relaxed/relaxed;
	bh=7gT2JuiYFAN6v3dLuKfgKvKI5F6TdDS5679fODV4+m0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FD2ZymQkZkBdbiMA6uDzjqT9qqLxqDlpSOlRsAJ+GjQuF5NAWwtpIBANOuvRYFrewQpLoqEjjnAmaNwVb+3oOf3ttUTH5/clul7g77pnPXVTtH2A/1sZu/NHyGtm7vo5k50o9lw4QZeCXzrqYMsSZH4Ehq7JGkfXmxzLCtYImBMC+8WYBJcDKAvBKnoxwSo76Prqyz/VnYELBYN/tpjuDd20zACuO8SaP2OmrNSCc3v6HhfZmGCq4jP3dA4JKHfjMpRx0DL79a/cyjnOdrQo/8QimkbKEyWDKgRqEohzfnI2M0r9XC2j3OTUpY0jylhPF1hX4nZOIW1lEd9AWAsX1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=l5EctVU3; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=l5EctVU3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSZLd1t4jz2xnS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 15:16:39 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1CFC1476;
	Sun, 15 Nov 2026 20:16:04 -0800 (PST)
Received: from [10.163.155.94] (unknown [10.163.155.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A34E73F632;
	Sun, 15 Nov 2026 20:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794802567; bh=07M/qatRqX8GlvVNpZ3BxRX/Cpixfubu9N9NgYkUMYc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l5EctVU3pqdnc7UTBpxl7faldAhr1+sj1M1TgRsDoWwuRaD2Ni+NCqfZXSPrBLEV9
	 nliJLVvf2ZoEHEcuVd2Fib4wJkUcAwjA1hb95cFt3SEwx8elzzBENTxWTjUGc1ZINv
	 yMczDVQGRVCg2Py6/j4qGFIHtEmai+BzkruYIMuQ=
Message-ID: <253a1587-0f76-4013-babc-f7c9c0295eee@arm.com>
Date: Mon, 16 Nov 2026 09:45:58 +0530
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
Subject: Re: [PATCH v4 5/9] mm/vmalloc: BUG_ON() on an unaligned range in
 __vunmap_range_noflush()
To: Hao Ge <hao.ge@linux.dev>, Uladzislau Rezki <urezki@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
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
 kasan-dev@googlegroups.com, linux-mm@kvack.org
References: <20261110112546.261415-1-hao.ge@linux.dev>
 <20261110112546.261415-6-hao.ge@linux.dev> <avWtxcH2mKw7dgbp@milan>
 <cea5d9af-435a-4708-a937-59c7cbcb169e@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <cea5d9af-435a-4708-a937-59c7cbcb169e@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 16/11/26 8:51 am, Hao Ge wrote:
> 
> 
> On 2026/11/12 20:15, Uladzislau Rezki wrote:
>> On Tue, Nov 10, 2026 at 07:25:42PM +0800, Hao Ge wrote:
>>> The PTE loop of the unmap path stops only at addr == end.  With an
>>> unaligned end addr never lands on end, so the loop walks past the
>>> range and keeps clearing.  With an unaligned start the loop begins
>>> in the page containing start, which extends below the range.  Either
>>> way the unmap clears the mappings adjacent to the range, and that is
>>> nearly impossible to debug afterwards.
>>>
>>> vmap only installs page-aligned, page-granular mappings, so an
>>> unaligned unmap request is never a legitimate teardown, and there is
>>> no way to tell which pages the caller meant.  Check addr and end at
>>> the entry of __vunmap_range_noflush() and bug out before any PTE is
>>> cleared.
>>>
>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>>> ---
>>>  mm/vmalloc.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>> index 86fbb1d2b27a..0565cbfe325c 100644
>>> --- a/mm/vmalloc.c
>>> +++ b/mm/vmalloc.c
>>> @@ -518,6 +518,8 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end)
>>>  	pgtbl_mod_mask mask = 0;
>>>  
>>>  	BUG_ON(addr >= end);
>>> +	BUG_ON(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end));
>>> +
>>>  	pgd = pgd_offset_k(addr);
>>>  	do {
>>>  		next = pgd_addr_end(addr, end);
>>> -- 
>>> 2.25.1
>>>
>> I am not sure this is good to stop machine at all. WARN_ON_ONCE()
>> and return?
> 
> Folks tend to dislike BUG_ON. Dev suggested switching to this when I sent out v3.
> That's fine. After all, nobody has hit this so far. I'll switch it to WARN_ON_ONCE
> for the next version.

To clarify I had suggested the actual check, not the BUG_ON, I thought it is a
well-known fact in mm now that BUG_ON is not to be used : )

> 
>>
>> --
>> Uladzislau Rezki


