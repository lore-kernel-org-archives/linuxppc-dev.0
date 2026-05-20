Return-Path: <linuxppc-dev+bounces-21253-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E52CD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 21:05:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLPFm3V3zz2xrC;
	Thu, 21 May 2026 07:05:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779311132;
	cv=none; b=h9zRHiTgsDTilsIZKRHdp8nYLA1sEOeIseYnPxUY7oP0xNWrZaUjHvOxNpePQiWgDVGBdjEe9dU0s6PF7vxzGljg6Hg61WGvNBYeY0N7DcvScDhTOI/vK4iPzPnhiD2/Hb0bJx4YYJS0HQrtokJHKO4pSz1q08x9rdJ7V5DXyK9J7NyjWzbIWQlbeTDmJR10IrOC+R9nYDxh4DFye6La5zCSlr2k15ALrpf2uMvgE4jWKwWK4gUL6VV+dBK4ysaGltRjwJo3Pok0pur8kAmAZfSdLt56UYysJdv0XCdufNTbbkH8i8LCz50n9PPUh67Cip6F3B9ZYKcwbkj0AEB6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779311132; c=relaxed/relaxed;
	bh=NoQFWNK7oWAD/wrjDNQs2N+Z55W1ZBNqkdyVcG17n+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANwZ4nUN5PFsBVakJQcRmU7fqJbHtX5A5dIDxSFI+9o7xCPtrySedAAjS5OqnJ6B4XCylTrMPbvCyLMSQq3ylPHQZegmw2JNCVbkDseHAegwveDo8AP2/7lMu0MTFrCq0I4QrmhHSDbJE+Fd2jTshfqqNTr05urKJ5j+pBtMgQaLaB6MEXLyPJnuCOFFaXLG9QbjrJchu/qNYww+FZc0852IWR/OI6csMfNsOprffo21baaxQ75vWAhkTD7fvK5l3ttr1XyC5HCivMkDINsGN0xasg+S77cIVNGkXvoHqibiHBX81VxqT18mWGvPH+0X0oPvuGVNqJVKtVB00IawPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=bR9HCAGS; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=bR9HCAGS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLPFc0xZxz2xHF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 07:05:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=NoQFWNK7oWAD/wrjDNQs2N+Z55W1ZBNqkdyVcG17n+A=; b=bR9HCAGSj3BuTqMtUE+DLlE2/V
	hbqFNHpAblQKp5tyrESGJToQyAt4gGSYt43sRu6JEbVNZTj0qvFZxTyoBxJ1wp0kQ5ZcRxN1nm3Rb
	gh32K03vbE/E7J0yrggnNOynCTcgltl9vPaiaVZXlPQBWE/JQgInR1dXcExZ8Iz6LVbgTlq8x52mX
	WL8vfh2Lyfw2a/Tpq2i/SXxctbJ1CzS4YgLicbHSvLU347BFYhk2464cXsmbdNSDNV+5du23ojl3E
	wPSEPslSUR5LG+Oc0B2L/jDVGsi3Or0fTJoXFl2vl9TX0JbwU5Szrew428V10FYaIsgWdHpxL5RaA
	8tHIsB1A==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPo5z-00000007aEX-3LBW;
	Wed, 20 May 2026 21:04:51 +0000
Date: Wed, 20 May 2026 22:04:51 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <baohua@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>, akpm@linux-foundation.org,
	linux-mm@kvack.org, david@kernel.org, vbabka@kernel.org,
	rppt@kernel.org, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de,
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com,
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	Nanzhe Zhao <nzzhao@126.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <ag4h87CBd-gph9zX@casper.infradead.org>
References: <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer>
 <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <CAGsJ_4zgeE3ebEJ+j7GJFzWVoVYHeiOn4dOoOsmWCLA6s=oECQ@mail.gmail.com>
 <5zdaa5uv5oj27q3taopl3amops57ouxgyfsdveudz4ovmbdw7z@6lwrlyvmhcp2>
 <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com>

On Wed, May 20, 2026 at 06:01:56AM +0800, Barry Song wrote:
> > implied is that the per-vma locking may stall mmap_lock writes for
> > longer than if the mmap_lock was taken in read mode?  Barry, is that
> > correct?
> 
> Not the case — the actual situation is (if we modify the
> current kernel to perform I/O without releasing VMA read locks):
> 
> thread 1 PF: lock vma1 read ----  IO ----- ;
> thread 2 PF: lock vma2 read ----- IO ----- ;
> thread 3 PF:  lock vma3 read ---- IO ----- ;
> thread 4 fork:  mmap_lock_write ---- lock vma1, vma2, vma3 write ;
> thread 5 :  take mmap_lock for any read/write reason
> 
> Now you can see that thread 4 has to wait for the I/O of
> VMA1, VMA2, and VMA3 to complete, and thread 5 then has to
> wait for thread 4 to release mmap_lock. Both thread 4 and
> thread 5 can become extremely slow, because I/O may be stuck
> anywhere in the bio/request queue or filesystem GC.
> 
> So now we have two choices:
> 
> 1. Change fork() to avoid taking the vma write lock for vma1/2/3 where possible;
> 2. Keep the current kernel behavior and drop the VMA lock before I/O:

Option 3: Say that this is a very silly thing to optimise for.  I have a
hard time believing that any application will care about the latency of
fork(), or the latency of page faults while it's in the middle of fork().
Multithreaded applications just don't fork that often!

