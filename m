Return-Path: <linuxppc-dev+bounces-19717-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915CCF531C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 18:50:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvc1W0h8wz2yv4;
	Tue, 14 Apr 2026 04:50:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776106255;
	cv=none; b=OI/7iSGScpHPHYwvlkGbRGICvHzKOSnKW4SyQ5S9dkYk0x+AGuJMfTmRyZlCT22iPg+LoVodeLO+nRHBdObSGGpY0v19jwYxWKDnqqpWg6GyLzQhNOpCfnCMYdLsHkKbq7Nlr8SQbfRfvDAgyBittOgSyf/QewcmQoxYVXgAaNrBoswHq5cjEV7SLAWyM9OBKz/nmZUBFbQHZ7Wom8tYfbtmAzJFRKakgRiTpsPbN1oNoM2ICJMZH5qkX8WfAfDSrXM/VjNZZHuostQeG8X2zlzflsk0QhieDbA0hIXlh5PVRdiel4oNgXEX/z9kuSOtBrH8oh6wz999cxvJgf8UQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776106255; c=relaxed/relaxed;
	bh=XX/0ECX0ZPlZ6DfabBEjQOgZGq9iZAHocSDbl5LU160=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCkFn09Spi+ZNRkKWBB8STP55HI4DgULndEKiwogcckX9+gffA9eySdvkhAjzsWG7qetbco+nfWBrUVdvIHfMNJkJZNU7gGMgHCJfdjd7e9f8Ap4FgnWRfA3vEhGBlFUWgygG3pM4GSQYqUwR51A3+6kxjdZsfWhxat1gtjHx3YmHsZ9eBUZkXcUanbLxjS0CAC8UvVzcgl1WxsNZ/dSc4jpQkaf4LAsNuaHb5y3XQMob8RqH72lTasKugKpEVomvz4SvV/jmZGtjfxgIwjPz0OOoyp54hstQJBSxL8S9HLZrS0YemnazVC4rq+6uhcfMA6nhMSaLUzJcnKZEcV/VQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DvdJDQe3; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DvdJDQe3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvc1V01VMz2yth
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 04:50:53 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E362B44279;
	Mon, 13 Apr 2026 18:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064A4C2BCAF;
	Mon, 13 Apr 2026 18:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776106251;
	bh=rdLqMR/Xr3fQS5U0jYUhu1Lu8JZHxK3+UfMlHMMb9T0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DvdJDQe3oCG/gfgbw4UZP+je/1tx9raBCi0Fx3sjPOET7NPzV8JEnJSl0ggGBjtI1
	 hBhIC6ExWdLs8tBHuLezEk1U12agU+VHQnpht/UuNiSCyU+8VXWnc13JwUGl5zgr2U
	 VjTV//cyB1Zcj0WObb4Osc+PRC81TE0WL/CE6EQvvb6fXUNa87P9GQiqBno6ZQmUFh
	 v/4GZWWXcklcBfhYTXXJwMRjgxAsdPh+UL8SeN9/4z4Aygv6OZo6dpRQ+xjCtfYG0Y
	 N3id4XvdsiushhArjrX8jdh1VCpQHVTLtkDeiAFmcATQBevco3PsThfZtGvxpi5yOj
	 GMABa9pVDUYVg==
Message-ID: <42ba7f13-846f-4150-8195-32a775bb6812@kernel.org>
Date: Mon, 13 Apr 2026 20:50:41 +0200
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/49] mm/mm_init: fix uninitialized pageblock migratetype
 for ZONE_DEVICE compound pages
To: Muchun Song <muchun.song@linux.dev>, Mike Rapoport <rppt@kernel.org>
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Liam R Howlett <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <adzvdRPrK55TutT6@kernel.org>
 <ADC5EFE8-454D-4B9D-8BB0-39FF671290F0@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <ADC5EFE8-454D-4B9D-8BB0-39FF671290F0@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/13/26 15:57, Muchun Song wrote:
> 
> 
>> On Apr 13, 2026, at 21:28, Mike Rapoport <rppt@kernel.org> wrote:
>>
>> ﻿On Mon, Apr 13, 2026 at 06:07:44PM +0800, Muchun Song wrote:
>>>
>>>
>>>
>>> Of course not.
>>>
>>>
>>> There are indeed many more cond_resched() than before, but I don’t have a
>>> concise way to write it, so I took the easy way out.
>>>
>>> How about:
>>>
>>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>>> index 2d680636b67a..d13a2577c4c3 100644
>>> --- a/mm/mm_init.c
>>> +++ b/mm/mm_init.c
>>> @@ -683,7 +683,8 @@ static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
>>>
>>>        for (pfn = pageblock_align(pfn); pfn < end; pfn += pageblock_nr_pages) {
>>>                init_pageblock_migratetype(pfn_to_page(pfn), migratetype, isolate);
>>> -               cond_resched();
>>> +               if ((pfn & (pageblock_nr_pages * 512 - 1)) == 0)
>>> +                       cond_resched();
>>
>> TBH, I don't know if 512 is the right number :)
> 
> I picked this number out of thin air. I’m not sure as well.
> 
>>
>> pageblock boundary was a convenient point to have cond_resched() along with
>> setting the migrate type.
>>
>> Here we might be able to squeeze more iterations between subsequent
>> cond_resched() calls.
> 
> Choosing an appropriate number is indeed difficult. We need to consider
> both unnecessary cond_resched() calls and scheduling latency, and the
> specific value also depends on the current CPU performance. At the very least,
> I find it hard to choose a correct value. Since we all agree it should be larger
> than 512, why not just pick 1024? I can't think of a good evaluation criterion
> or selection method either.

I think in some other code we just use section boundaries.

-- 
Cheers,

David

