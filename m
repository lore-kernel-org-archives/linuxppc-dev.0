Return-Path: <linuxppc-dev+bounces-26361-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EACC61DD6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 07:59:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYytl6DC3z2y2S;
	Tue, 01 Sep 2026 17:59:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788249567;
	cv=none; b=Io409dYZghrMlJ7wht6ys8k3n3Ptv3eMGgf2Kks6+uLIkEm329eFZk53QkuYKx28aopKYGib9B9hHGPO7zWeQcehCM2GVSy0PHVFsyDZfmZS4HjYxAlVztLT/XY/7F4Wp3uuwCRBzAF3kgaRl6fwiAR8QevFb0w+QdkZC7iq9JLWdOC88ygEgI9ENvyJBR1b3F4NGeXjYlYm+7t5Yfe6IWU54Y07gvATMopaORMEF6llh+CeTu1dMVIMlHs6Yj591h59212MwO4LqUTgyi+ZSi/TtStva2oFuqcLzPp35JDAgGO4N4suJmndIhG9KgJwPBnEyNt5q2z7+c7D6TIN4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788249567; c=relaxed/relaxed;
	bh=iJv/WiakOodAqFIubQ5HTmHL0TDtf9MpNqrzEXUw2fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFq4geuwL7uMpEgtptgELmL2fygdz9dpqclmGY6rW7qQLf+pI/LYtCMR7aCOQxy4GKKf6CQ7U4E8JwCkXe1snJ9scl6Damz6W8b1JF+376koM0fQBdKvq4xdVDiuZRdgt/ZLmcNCuDycvNA1U9dl28NlPE3ozG6V5d8tpwFFfFgvBoP1n7rh0p5VNu/Gk8Wmp2N9rl4CPS0aNj+YUzyZhVirVak4YNTpqaOOn0nMllWErRAxNhLh84G16nhmG0Yd07TzR65zJE0XSFVpgXIU1zjRJ+sEKk0LQ2SKjIr5VsMWlp2/XkVXgzxG6XzlXPClrrckXan6ggTIuYiCgH4fHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7SEFFP8; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7SEFFP8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYytk70vGz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 17:59:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A0667601DB;
	Tue,  1 Sep 2026 07:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201A81F000E9;
	Tue,  1 Sep 2026 07:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788249564;
	bh=iJv/WiakOodAqFIubQ5HTmHL0TDtf9MpNqrzEXUw2fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P7SEFFP8puwZXZp/YRq5bm12kLhga+lgh99B8rQeYLWPKvjGgDXAgg7amgbvop6gs
	 KnFbcm9PWiLs6fpRX3X9ZFziRD/tbsK3eH/C4U9q+apMvreDXnEx9yuMWrWXaAlfn9
	 RfE+EypR5zdZI4scQXJRBlRBhEahbdQVPKXgYGzRzl4sArWd1u++y7ARbEBAYmsoti
	 qa/YYnJeh63FtQSZKwP6986LY6PCjMAcEQlpM6IXvbI4ROaA1SfUtvjcxi9CnB5UZH
	 Nk9IDitG/j2LUr0suo0oUruy11Tq+byoKby/mpiq0sCo0dpWi4sYmz38BnnJLGVmE9
	 9mRRThkgaqcJA==
Date: Tue, 1 Sep 2026 10:59:16 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Eli Billauer <eli.billauer@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Brad Warrum <bwarrum@linux.ibm.com>,
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
Message-ID: <apaF1HUtJnstuUN4@kernel.org>
References: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
 <20260830-char-misc-v1-2-05e2ce44f291@kernel.org>
 <f6001085-9234-4025-ff34-6cc4a66c293a@outbound.gmail.com>
 <20260831123937.32255a49@pumpkin>
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
In-Reply-To: <20260831123937.32255a49@pumpkin>

On Mon, Aug 31, 2026 at 12:39:37PM +0100, David Laight wrote:
> On Mon, 31 Aug 2026 12:13:08 +0200
> Eli Billauer <eli.billauer@gmail.com> wrote:
> 
> > On 30/08/2026 9:47, Mike Rapoport (Microsoft) wrote:
> > > fifo_init() allocates the buffers backing the software FIFO and
> > > endpoint_alloc() allocates the transfer buffers of a USB endpoint.
> > > 
> > > These buffers can be allocated with kmalloc() as there's nothing special
> > > about them to go directly to the page allocator.  
> > 
> > Except that they are a bit large.
> > 
> > fifo_init() may be requested to allocate up to 256 MB of buffer memory. 
> > This memory resource is split into an array of buffers (fifo->mem[i]), 
> > each 64 kiB (or less, if there's trouble obtaining segments of this size).
>
> Would it really make sense to allocate the four buffers separately?
> And/or use vmalloc().

My understanding is that the buffers don't need to be physically
contiguous and vmalloc()ing the entire fifo->mem in one go should work.

Eli, what do you think?
 
> David

-- 
Sincerely yours,
Mike.

