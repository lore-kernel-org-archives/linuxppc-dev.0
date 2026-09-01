Return-Path: <linuxppc-dev+bounces-26397-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26D0C624D6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 14:41:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ7pw0frPz2xmh;
	Wed, 02 Sep 2026 00:41:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788273704;
	cv=none; b=eHAp3GNhLJn6K/HIL0DSxMaWMTgEX4vBxVTiERItfz3PHRa0XjEOgmvqktPo0MNIdCoRakkwy2EuXRK4Tl0Hzg+UYCtFNCWmnfsIETbGtLRPvv7L5k4vUHD4nn/P7un+pGwXtDL5w3g18dKr/nvn5CSXi7WYJHvPD4BR7DbrAx6/8gjCcLWV0YEziKiCkpG7BaPzx5EECVN4apov/7GU1m0HaRtWi6sNrPyhc3oOxTMkEP0zOPV5AJTI3EV11JS6eez9nfKtOwGRlm/acegOb9Z7chDetZz042Ac5RYenFbmcRGE1g/eWpaMMH+r8Y3W0R7pQPamrQFOdby27pYIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788273704; c=relaxed/relaxed;
	bh=aD1aeCXoZUTVkYkw8DYLgpTcX29H0YL7tFV55GqLOUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHFRU/O73vbaI/G/clBeuDRmzLNh1wQeV/zADgyK5PyIMgVdEImGzutVhtPR3goucSFv+SoYTTUdExML51BSrRD+8hFh9XJG7id1aVu5l+i4jTEyO1P3BwX078oyz2zuIYlWDm52lkdEIEB7XIMs360qvc+MGomry/mn7NKTi5Dr3XM7gqOmdYa7MnJy6DtXWz4FeMXZptwdLmy3oz2ZFcGqmBqvUb942UMb7XRsfviOBAlDVFhoJbk/E1x4xeVkx3FrMJIkKbYhTWqjjnw1NrQk5Tnl/QxGIM0a68xWQsP6U3g1qpyWGw4vcgd9ZiJoko82hms5FSyf0YT3GUc0PA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCkYCgJH; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCkYCgJH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ7pv1BTvz2xGt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 00:41:43 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EEA18602BE;
	Tue,  1 Sep 2026 14:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A26C1F000E9;
	Tue,  1 Sep 2026 14:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788273700;
	bh=aD1aeCXoZUTVkYkw8DYLgpTcX29H0YL7tFV55GqLOUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DCkYCgJHTMeXpcfI011IFyZWluRGgMafgbwW8u29qgQBVZ9Dxsno0gDXnl7hHZ0m+
	 lkqnWV4wHDwKSWKnoQda11OIQ06fvWLfa32Ye05qYmX1Z7boJPT6aJZEl4EVv8r+G6
	 Q8c5h5Eq9o8u4IVkNkDvCB17dlRL52JTqjsLsbOVCb03G2bti6Yh9u4sRvw0rWJ1Ca
	 qwHtYbfIXyVj5uLcNFlMoaGF0xHllKs6NACCcVCPrJufvl5Fed3xFkkaUWs7j7W7ZV
	 siJKVu6dFavxSGvLfYUXvuVBZcE7zllPLV8WeZFb1IHv1rO4zZ/Mqb/Gua1p6L6cXY
	 pVvsocfBPnW+w==
Date: Tue, 1 Sep 2026 15:41:17 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kiryl Shutsemau <kas@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Simon Schuster <schuster.simon@siemens-energy.com>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Russell King <linux@armlinux.org.uk>, 
	Vineet Gupta <vgupta@kernel.org>, Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, 
	Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 01/12] mm/huge_memory: zap deposited page tables after an
 RCU grace period
Message-ID: <apbiB51hjm-9pRzf@gremlin>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-1-5456a81c8212@kernel.org>
 <apbOlyF77yDCV4cF@thinkstation>
 <apbcoMTVlL42G5tg@gremlin>
 <20260901142408.GA56830@ziepe.ca>
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
In-Reply-To: <20260901142408.GA56830@ziepe.ca>

On Tue, Sep 01, 2026 at 11:24:08AM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 01, 2026 at 03:12:45PM +0100, Lorenzo Stoakes (ARM) wrote:
>
> > It won't be costly at the time of the calls obviously as its deferred. Maybe
> > increase some time spent in softirq but again is 512x that big of a deal?
> >
> > I'm not sure how you'd both defer the free and somehow utilise mmu_gather here
> > either really, certainly not without it becoming extremely messy.
>
> The less costly version is to thread the page to be freed onto the
> mmu_gather through a linked list in the struct page memory. This is
> super cheap since it is just a singly linked list operation.
>
> Then when the mmu_gather is flushed it does a single call_rcu using
> the rcu head of the struct page of the head of the list. The callback
> clears the entire linked list of pages.
>
> Since you have to tlb flush anyhow, it makes sense to always use the
> mmu_gather. For example the design I ended up with for iommupt
> accumulates all the invalidations and all the free-able memory into a
> gather then invalidates and frees.
>
> This allows maximizing the tlbi efficiency too. You can't do call_srcu
> until you flush the tlb and if you call once per table then you are
> also tlb flushing once per table too.
>
> So if the kernel really does want to clear out 512 leaf tables the
> optimal implementation is one range tlbi for 512 entries followed by
> one call_rcu to free the memory. Hence the gather..

I think there's some confusion here.

This isn't the path in which a page table is being freed, the _deposited_
table is zapped, in zap_deposited_table().

That is, the page table kept in reserve for THP split, that is not
currently mapped.

It amounts to a __free_pages() call.

The TLB operations are in e.g. zap_huge_pmd() etc. and nobody has
complained about inefficiencies there.

So, unless I'm missing something here, TLB flushes play no role in this
whatsoever.

The issue Kiryl raised was that instead of immediately freeing page tables,
they are now batched up individually by call_rcu().

I personally find it difficult to imagine the numbers here would be
problematic or certainly cause anything observable beyond what is
observable now.

So I'm going to have to say, unless it can be clearly demonstrated this is
problematic, I don't think there's any reason to add additional complexity
here.

>
> Jason

--
Cheers, Lorenzo

