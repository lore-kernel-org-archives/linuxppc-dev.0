Return-Path: <linuxppc-dev+bounces-26495-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99516C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 14:29:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbMRG6K9Jz2y71;
	Fri, 04 Sep 2026 00:28:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788445738;
	cv=none; b=U8nk80Uv0kRJdL/Rmx5ptZKZwpIjHwJPagtGS1/P6k+D7rL2yNKUg+qtMcZXtjKUA0X99pNqPoqblXDdQi+d2u9N1KZQKEHqhfb4qP0TZkPkWDR8n0QE9dl0sA2nat3H/+6rB7q/rv6gsgxrR+MnLTyvRUYW0CKqHZIa1dgN54C3hOtNjb0JC2/UOKM2b19551oQkkciOJWBwoJeeB2A5OMJiM/M99qIUuo7obNrFE5uDdeMNzTKoim8Ms2kbXxQcirN/1BzBshoTQ001HewwJj8BdoCSUjnRmtbmGw+GPArfZDaQBn5DyZ1qZ3P4ja4DAsfAwvHsjHyYwRv5huhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788445738; c=relaxed/relaxed;
	bh=TE2Me2Qaapw28vfR1oCk/7uMMKpbgxiAwR/j5we1CsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmDCub8N5uTJ8sBeG1NKpGkXYlqTgysy4kiwkHV7O+kKvnyfnojCCr6uL2L/dVIyqQ0arX6oQZds85OSjd/m3MXQkkZmd+1h7b2hnnOdgH4ClJ04O5jOw/i2y9YnbNidZncJYOnycYJ+mPwtfD0rFCOmzExN5unqIJqY2hBbzl/b3wYpMM9XoNA64kO4hn9oF42a/syw2yeLo+vooAdTnxCeIaJmCDkizLExWckFWnQuBf2lVZpAfmnGLRscC5h44pp3u1qVfIi/Qo2bUUgOBY9cEAHHasfjRqcjwmjKJ68T+zLSOD8kQ62fDS1CMGl4uebH9cBYp362GGA1chFHXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OE5hfAL3; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OE5hfAL3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbMRF3VZZz2y2R
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 00:28:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F219F4026E;
	Thu,  3 Sep 2026 14:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C921F00ACA;
	Thu,  3 Sep 2026 14:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788445732;
	bh=TE2Me2Qaapw28vfR1oCk/7uMMKpbgxiAwR/j5we1CsM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OE5hfAL3bZQXVLclfyoI0zNWbNdoHhR0Y9tgkTkLT4dgLH1aK20LS1exAyJ7QW8TX
	 zBYnmWVvbiVhEqGa+2UFTGrp+zYQ6x6WXAKG+heYjTEmhaywSP+24/clriu4Vg0lWB
	 loFTOURzIqqlCw4bdaKpTPRA9eMqFBX9uLomnhQtGsVZFde9XO15oo49ZveZ6PiQwf
	 qws563/lr7XaqPc++y9Qrg12M2EhRE/9E2U/EpiErsgFI1i+x03OucFkoU+cmoO2On
	 1EG5AGpXI0EMAh+RIKyLEW2ZBvVJ8LzcN0d9zvL6uIEm/3/YRvEU0soOPJN76a3PnT
	 flM3BixQBpQrA==
Message-ID: <3c19c24f-5036-4bbe-b3af-e5eae102f34a@kernel.org>
Date: Thu, 3 Sep 2026 16:28:48 +0200
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
Subject: Re: [PATCH 2/4] char: xillybus: replace __get_free_pages() with
 kmalloc()
Content-Language: en-US
To: Eli Billauer <eli.billauer@gmail.com>, Mike Rapoport <rppt@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, Arnd Bergmann
 <arnd@arndb.de>, Brad Warrum <bwarrum@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Simek <michal.simek@amd.com>, Ritu Agarwal <rituagar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
 <20260830-char-misc-v1-2-05e2ce44f291@kernel.org>
 <f6001085-9234-4025-ff34-6cc4a66c293a@outbound.gmail.com>
 <20260831123937.32255a49@pumpkin> <apaF1HUtJnstuUN4@kernel.org>
 <1729fb06-6beb-f8ef-3e71-47fc3f00345d@outbound.gmail.com>
 <apcPg_y-HsMki7we@kernel.org>
 <9a3d6a08-339c-3315-cc81-46907d0836ad@outbound.gmail.com>
 <apgSCyj-h2xVc2ss@kernel.org>
 <1d7f8806-f4a0-fda0-a361-a011460ef308@outbound.gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <1d7f8806-f4a0-fda0-a361-a011460ef308@outbound.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/26 14:30, Eli Billauer wrote:
> On 02/09/2026 14:09, Mike Rapoport wrote:
>>> So using vmalloc() may result in a malfunction in the data transport where
>>> the __get_free_pages() would have been successful. This outweighs the
>>> benefit of a somewhat higher probability of success in allocating very large
>>> buffers, and surely the improved aesthetics of the kernel code.
>> kmalloc() still works, just like __get_free_pages()
>>   
> 
> After these few days of discussion, this is what I make of this topic.
> 
> The memory allocation in fifo_init() is somewhat ugly, but this driver 
> has been out there for five years, and no complaints from users.
> 
> The vmalloc() option may be successful sometimes where the current 
> allocation will not. On the other hand, there is a possibility that it 
> will cause real trouble with page faults. Plus, a large allocation with 
> vmalloc() may be a weak spot on a platform to which the kernel is 
> partially or poorly ported.

vmalloc() has its limitations, yes...

> With __get_free_pages(), there is no doubt that usable memory is 
> allocated right away, and that it will work that way on every single 
> esoteric platform. vmalloc() leaves us with "we're pretty sure there is 
> probably no problem".
> 
> So I vote against vmalloc().
> 
> As for replacing __get_free_pages() with kmalloc(), it's a matter of 
> taste. I think that if you're after a buffer that has a power-of-two 
> number of pages, __get_free_pages() is the natural choice, and using it 
> makes it easier for the reader to understand what you're doing. 

If you are only after a buffer (that's physically contiguous and aligned)
and don't need the struct page itself, then kmalloc() is the natural choice.
This is where we are heading with the upcoming memdesc conversions etc.

> Replacing it with a kmalloc() is confusing in my opinion, and requires 
> that the reader is aware that kmalloc() falls back to __get_free_pages() 

Why? The reader has only to know that kmalloc() will provide such a buffer
(up to sizes that the page allocator would) and whether it falls back to the
page allocator or not is an implementation detail.
BTW, it's only at >2*PAGE_SIZE where it falls back. Which could change at
any point and nobody should care.

> in this case. So we actually want __get_free_pages(), but call kmalloc() 
> instead and let it fall back to __get_free_pages() so we don't have a 
> cast and don't need to save the order, and assume that everyone knows 
> that this is equivalent.

Oh right with __get_free_pages() you need to pass the order for freeing.
That's a real practical argument for kmalloc(). So I don't see why you'd
hold it against kmalloc().

> So I vote against the kmalloc() thing as well.
> 
> If this patch is part of a larger kernel cleanup, I suppose my votes 
> don't count for much. But for the record, this is my opinion.
> 
> Thanks and regards,
>     Eli


