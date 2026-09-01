Return-Path: <linuxppc-dev+bounces-26413-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EB2C624D3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 17:47:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZCwg3TPbz2xmh;
	Wed, 02 Sep 2026 03:46:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788284819;
	cv=none; b=TFzvpd9o75c9ToMFSYyxB3FNIHBhwhJmKH7OFUCkPZJWnoBY9EWcD5e9I9aqTp4AEJv/JgurYaCKuy2SDZSQZYfztcV0ZFR9C1iq7OY9SI48N5pMfCGl+JqVcMGBm75KyrkAhUrR5w//RXY3dLqOzUyIID5rnH6RLz1hBY6LS0/nk+PGdMIIIdmpQDCuVATB13ZuMgW4Z9vHFgp4IaVt3Jn+amXYzUUhqoHnNZBrEtSyFvEnM7IQZdfEBsgCkRIQg5eI3RxChdo9SpzNh/16G1oB5Jk492xWI5QTfh7i+5lCSSwNqTFHH1OCNE/HhW+h8spadJRU2bVWP6SKq4gdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788284819; c=relaxed/relaxed;
	bh=Di7QTynNdwrefgWArR8x/gWtyxCUPTHCJ3Ml9Ox/wmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK63NRNlpRr78z8r0uQz/niEyiSqeeXJ/0tCSqdWU/v0Wvrn43xaWLIKm2s0ndCBChv4+834LYHLMVu8F9DpLlIpauuN6JUIlfGJCPBIuwBXBIifJgbnJMeQ73oW4cFplxmW/KZKbO8aeYC7pVAwuIydgiPalfXUmfonimcYGT5AE8Bz12wrVeoL7fuS0H+GUlJnhmtof4Sp2rA7aFryxs2f5c9Lrb3qW6WJvFld3oQk+9F8ymDFKCM+sJdcD/EMZWb5OnyCj1bqd23uhauJbZCUSfh2H83vVCMp2mvgUiWjIOOjq/wDtxDwVPt2Z5BgG2Xgp8nusH4R7IrRZBS/lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MM8rdnOG; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MM8rdnOG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZCwZ74N0z2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 03:46:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9F7E940A39;
	Tue,  1 Sep 2026 17:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3001F00A3A;
	Tue,  1 Sep 2026 17:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788284812;
	bh=Di7QTynNdwrefgWArR8x/gWtyxCUPTHCJ3Ml9Ox/wmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MM8rdnOGJ8NlTTKLBF+ZWl4lOqzsu33URdTXUoJAJpM+r3LMdEnN32gB8oaIOp83P
	 z7fAnqDfQSf6tUhZgpY4nWuMOnOy7OfNzElYFAYlsMu2dcBVtpp2mqJUbXPsNkvPxV
	 11dRQjJ7g1neo95rCP6rPnh8KcRaPxitPJjADq9dyLpOgxG24g/VuDYURyR5Pqy8Eh
	 COgDziYII4r37BFKQYvTyK1UzqfV5hd2eo61ezLxLtw6eNo/8Hp7OJIVWxoGYK7+t9
	 7rtvqZ/IE+uWuuJPihziw49O8FbDUnDc5Ycrl6Ydu8kO3O5Kd29Z2yQnBOLRiTMiRZ
	 Mv+NLrts5eGrg==
Date: Tue, 1 Sep 2026 20:46:43 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Eli Billauer <eli.billauer@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Brad Warrum <bwarrum@linux.ibm.com>,
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
Message-ID: <apcPg_y-HsMki7we@kernel.org>
References: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
 <20260830-char-misc-v1-2-05e2ce44f291@kernel.org>
 <f6001085-9234-4025-ff34-6cc4a66c293a@outbound.gmail.com>
 <20260831123937.32255a49@pumpkin>
 <apaF1HUtJnstuUN4@kernel.org>
 <1729fb06-6beb-f8ef-3e71-47fc3f00345d@outbound.gmail.com>
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
In-Reply-To: <1729fb06-6beb-f8ef-3e71-47fc3f00345d@outbound.gmail.com>

Hi Eli,

Thanks for the detailed explanation!

On Tue, Sep 01, 2026 at 10:44:20AM +0200, Eli Billauer wrote:
> On 01/09/2026 9:59, Mike Rapoport wrote:
> > > Would it really make sense to allocate the four buffers separately?
> > > And/or use vmalloc().
> > My understanding is that the buffers don't need to be physically
> > contiguous and vmalloc()ing the entire fifo->mem in one go should work.
> 
> vmalloc() is an interesting point.
> 
> fifo_init(), fifo_write(), fifo_read() and fifo_mem_release() implement a
> FIFO in software that the XillyUSB driver uses internally.
> 
> The memory for this FIFO is allocated in fifo_init() by calling
> __get_free_pages() with requests for up to 64 kiB. With the maximal total
> buffer size of 256 MiB, we have a possibility of 4096 allocations into an
> array of buffers. And if __get_free_pages() fails, the size of each buffer
> is halved in the following attempt, which tries to allocate 8192 buffers,
> each 32 kiB, in this example. And so on.

With vmalloc() you'd get all 256 MiB in one go if there are indeed free 
256 MiB in the system. Unlike get_free_pages()/kmalloc(), vmalloc() does
not try to allocate physically contiguous chunks and it's not affected by
fragmentation.
 
> This mechanism with an array of buffers complicates the implementation of
> the other functions as well.
> 
> So why not replace this with a single call to vmalloc(), possibly asking for
> 256 MiB in one call? That would mean simplifying all four functions.
> 
> When I wrote this driver back in 2020, I avoided vmalloc() because Linus
> wrote "vmalloc() is NOT SOMETHING YOU SHOULD EVER USE!". (See [1]). He also
> noted that vmalloc() is a restricted resource. But that's from 2003, so
> maybe things have changed since?

I believe so, we have kvmalloc() that falls back from kmalloc() to
vmalloc() for larger allocations and we do have about 1k callers of
vmalloc() family.

In 2003 the majority of machines that ran Linux were 32 bit and those had
limited virtual address space. And yes, vmalloc() is slower than kmalloc()
or get_free_pages().
 
> Questions that arise in this context:
> 
> * Does vmalloc() guarantee that non-pageable physical RAM is allocated when
> it returns?

It's not pageable in the sense of demand paging. Some architectures lazily
synchronize vmalloc page tables and this can cause page faults that will
take care of the page table synchronization.

> * Can copy_to/from_user() be used with memory allocated with vmalloc().

Yes.

> * Is vmalloc() guaranteed to successfully allocate memory in the same
> situation that __get_free_pages() could have been used to obtain the same
> amount of memory (in smaller chunks, as with fifo_init() )? Maybe they
> allocate memory from separate memory pools?

The pools are the same in the end, vmalloc() allocates memory using page
allocator, just like __get_free_pages(). The difference is that vmalloc()
does not try to allocate physically contiguous chunks, but rather a
collection of assorted order-0 pages.

This is actually more likely to succeed than multiple large order
allocations.
 
> And most important: In what way, if at all, is memory obtained with
> vmalloc() practically different from memory allocated by __get_free_pages(),
> if it's never used for DMA?

The memory is not physically contiguous and cannot be used for DMA.
Some accesses may generate a fault to synchronize the kernel page tables.
The memory is there, but some processes may have not-yet-synced page
tables.
The allocation itself does more work and it is slower.
 
> Does the API offer clear answers to these questions?
 
Thanks for the detailed explanation

> Thanks in advance,
>    Eli
> 
> [1] https://lwn.net/Articles/57804/

-- 
Sincerely yours,
Mike.

