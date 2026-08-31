Return-Path: <linuxppc-dev+bounces-26287-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E649C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 11:33:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYRgf07Dzz2y2f;
	Mon, 31 Aug 2026 21:33:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788175981;
	cv=none; b=HleG+ZrNLSWh9aqgJUos4GEbUrNnv0Lk09OAT22+jPXac+2SjH0KEW+kq0Pwtk0CSKblKncvtoZSm2Gf/AxpFb7s38MZ+4IDmrdpTPsndwa7DKT51uKkGx8OIiGfjhQJ0nAl+HV5ad8EfJXtsFbfwfDbXf/3wsjokajJZbrk5hzaVokfi3tFB6OogUSubw33aSz6VGapFPgzEpO3cZ8JWAoJU04GWiijYL0vMRoIpG+bZO1KplI3rAWf3iCQQ10MfAgaiURf5leWzG5Xuyyqs6MyVWqcGz0MJ/mCet3LXag77pouCqktsnniL9UbwV+swU8LyMIczYtC7expylGoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788175981; c=relaxed/relaxed;
	bh=WH9GLRjSzyUmXP73YbT8GymaYDLOXQlGnVZRz7SJVBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cz5QGpo288ow6mg3Nc9CE9Z0sUt3vU/RuyjTIH4ImmsHcsALM6wc76Fp2PIVRZHGU+gNtuymwytwXxFzVPKdumawDstHX9hOZVG6n8JfDLaEib4/eG8aKbFXIlguHK1fLA8ebg1M2oWL8gG6QwPFnY/AN8qUSocIgQCHzw1wGGAiUChJPyWA0Sf4qDApRzm10ZU2y+A4pJGpgYg7F6y7XuRi+PKleJB1upEBdHi5L0uIDunhZjhSNnu+EtmYcxwvjY3Uvga1xcBqgtSPEiI3ZlmfZQcSojzqOHJYr05QaT71k6rKALHOqmdfig8/loTZl4aD/SG3wp8PHCKV2K7VIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZJyrgmM; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZJyrgmM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYRgd0l3Jz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 21:33:00 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3E41D60213;
	Mon, 31 Aug 2026 11:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E191F000E9;
	Mon, 31 Aug 2026 11:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788175978;
	bh=WH9GLRjSzyUmXP73YbT8GymaYDLOXQlGnVZRz7SJVBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AZJyrgmM8QADM/tQ3djTAeARnE0tu71LsYAnpmqOKEj9/Wtt3nwHniVayVY8E0Toa
	 yOc5jOJtEmC3bTWpfpt3zQGdo1fQ9ZleHcWHBaMU8ssVlG+Ke0eEyvGXlXmRFCnQaj
	 24DWfOWiKUIVTcMRoDf8GLwWworUIMllAjQPrMak3Uhn+2l8psqWw7Z70Ac7fmF9Mj
	 s5xWmHPx0ttQkWplwpmg38jECJ3umgKKp4Q9iMYLezRSHDeetagS7TrEN9nDaw0PxY
	 MWZfkVXytlJKkgMMAQ1j+jROPE42uPqSohV8GVbsUZvr6h+q88wozzSnTj8/xy/yXH
	 LgAp5GZKJQY0w==
Date: Mon, 31 Aug 2026 14:32:49 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Eli Billauer <eli.billauer@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Brad Warrum <bwarrum@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Ritu Agarwal <rituagar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/4] char: xillybus: replace __get_free_pages() with
 kmalloc()
Message-ID: <apVmYXlqsVr_p4Oc@kernel.org>
References: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
 <20260830-char-misc-v1-2-05e2ce44f291@kernel.org>
 <f6001085-9234-4025-ff34-6cc4a66c293a@outbound.gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6001085-9234-4025-ff34-6cc4a66c293a@outbound.gmail.com>

On Mon, Aug 31, 2026 at 12:13:08PM +0200, Eli Billauer wrote:
> On 30/08/2026 9:47, Mike Rapoport (Microsoft) wrote:
> > fifo_init() allocates the buffers backing the software FIFO and
> > endpoint_alloc() allocates the transfer buffers of a USB endpoint.
> > 
> > These buffers can be allocated with kmalloc() as there's nothing special
> > about them to go directly to the page allocator.
> 
> Except that they are a bit large.
> 
> fifo_init() may be requested to allocate up to 256 MB of buffer memory. This
> memory resource is split into an array of buffers (fifo->mem[i]), each 64
> kiB (or less, if there's trouble obtaining segments of this size).
> 
> Citing Documentation/core-api/memory-allocation.rst:
> 
> "The maximal size of a chunk that can be allocated with `kmalloc` is
> limited. The actual limit depends on the hardware and the kernel
> configuration, but it is a good practice to use `kmalloc` for objects
> smaller than page size."

For large sizes kmalloc falls back to page allocator anyway.

And the doc is out of date unfortunately.
 
> Regards,
>    Eli

-- 
Sincerely yours,
Mike.

