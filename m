Return-Path: <linuxppc-dev+bounces-19693-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069EBF34C52
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 13:28:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvSsY4GQBz2ydn;
	Mon, 13 Apr 2026 23:28:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776086913;
	cv=none; b=FRXO/pn4G0FBo6EnXRkKptiHPE2I30dFKrg1i6QHamzu8RJpHXyTwTygHBzkJ+ImDBBSx826wDIo/+BNZt0lLFEkfkjRdB9HeXoEx298B8NxFv2qUsYZyhDgqlvE0MlgYG/BjQ/JIHvs1BUBbOSdo7inrZxK4qL2qC0aAQwHeMGxcsPHpXkr5OCp0mssXnjlJRHTi78tB9DZoz+AU3AaMa4vywLMSNznviYpCAcRtVT3L8Q7s/OWf7ywhvAXJd/39RBCY5ROH0Nv+RErFi1ILerHu0z9H3AgYZP8yyI8Oksi2V0tEFqPF4jw+Adelvx3JKXEjkZqvNh7dVRNaYnP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776086913; c=relaxed/relaxed;
	bh=MCOqS5Qt7DUErLD1sGM2NitPZa1Tc1bVbjZ/Obd/mdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BX5GDqGYgJHdatuKA0X6iL2MM15PunVRetQ9/E9zH8reYvnZc/bu78SfFBVb+yuaeyt3/1k3kyQV/fZMZlkqT0Y5jClPfUk07D+FhsrQw7t916UZfCpRY436vLdJTX0nGPYrZwTNJ2CM52+onJhO40Bc9ghzb0IzSDqrZdaUJsGSM7mqdQZilMhe0PB32bQascL32veTK8NOLARv4nNSfObown7q/eGAO8Aw9M18BcghQ8ux16U6l4S5CotEg1k3yJASL7wZQdQbEzWq6cBtFezvpGfuCKjWPApKxfFGO+rJuMHH1frlG3uK3vVO8hacus9R2dEZYfTOjF7AWWHq5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mQZFa8uj; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mQZFa8uj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvSsX3gv0z2yS9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 23:28:32 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 24FA5435E2;
	Mon, 13 Apr 2026 13:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF49C2BCAF;
	Mon, 13 Apr 2026 13:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776086910;
	bh=7VByJTwrbtmSQuR7FvCes1Iak+N/IKd4uFjkgcO39ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQZFa8ujuVe81yE8vcLgLxhVVWJzt+swKGWZ2ofKQXeOaAczk3K7ksXwrVlaJ+hYw
	 yVXg5XiKV2rDDSHGmZ1cHQ+6AGEE+yBrBY8Yi+AJDfc5p1i4llszFa2XXvV01sTTec
	 G5SA0gcFv2AQ1usMg1UopmrqtMVJnc6aLQ9KCriHB4Wjq3rdjlaeimKxzpGP4Tcub0
	 Hpe1GUFInfON7xos/qUF6Ek0JOQtQ+M2Mm8BtjbuE4GPPPko8pTQjSqAPoaHfBPtIj
	 Zk8VEGEOVMkuyQZ4NDKGfZm/7c5eMmPrWTp1byTgwQsPAwlXcKcEJE+KRr1I5UgG+L
	 OZ747izg6AIcw==
Date: Mon, 13 Apr 2026 16:28:21 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/49] mm/mm_init: fix uninitialized pageblock
 migratetype for ZONE_DEVICE compound pages
Message-ID: <adzvdRPrK55TutT6@kernel.org>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-7-songmuchun@bytedance.com>
 <ady4LBppz-na5lM5@kernel.org>
 <5910791C-9893-4710-9002-76534DBFBFBD@linux.dev>
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
In-Reply-To: <5910791C-9893-4710-9002-76534DBFBFBD@linux.dev>

On Mon, Apr 13, 2026 at 06:07:44PM +0800, Muchun Song wrote:
> 
> 
> > On Apr 13, 2026, at 17:32, Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > On Sun, Apr 05, 2026 at 08:51:57PM +0800, Muchun Song wrote:
> >> Previously, memmap_init_zone_device() only initialized the migratetype
> >> of the first pageblock of a compound page. If the compound page size
> >> exceeds pageblock_nr_pages (e.g., 1GB hugepages with 2MB pageblocks),
> >> subsequent pageblocks in the compound page would remain uninitialized.
> >> 
> >> This patch moves the migratetype initialization out of
> >> __init_zone_device_page() and into a separate function
> >> pageblock_migratetype_init_range(). This function iterates over the
> >> entire PFN range of the memory, ensuring that all pageblocks are correctly
> >> initialized.
> >> 
> >> Fixes: c4386bd8ee3a ("mm/memremap: add ZONE_DEVICE support for compound pages")
> >> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >> ---
> >> mm/mm_init.c | 41 ++++++++++++++++++++++++++---------------
> >> 1 file changed, 26 insertions(+), 15 deletions(-)
> >> 
> >> diff --git a/mm/mm_init.c b/mm/mm_init.c
> >> index 9a44e8458fed..4936ca78966c 100644
> >> --- a/mm/mm_init.c
> >> +++ b/mm/mm_init.c
> >> @@ -674,6 +674,18 @@ static inline void fixup_hashdist(void)
> >> static inline void fixup_hashdist(void) {}
> >> #endif /* CONFIG_NUMA */
> >> 
> >> +static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
> >> +        unsigned long nr_pages,
> >> +        int migratetype)
> >> +{
> >> + unsigned long end = pfn + nr_pages;
> >> +
> >> + for (pfn = pageblock_align(pfn); pfn < end; pfn += pageblock_nr_pages) {
> >> + init_pageblock_migratetype(pfn_to_page(pfn), migratetype, false);
> >> + cond_resched();
> > 
> > Do we need to call cond_resched() every iteration here?
> 
> Of course not.
> 
> > 
> >> + }
> >> +}
> >> +
> >> /*
> >>  * Initialize a reserved page unconditionally, finding its zone first.
> >>  */
> >> @@ -1011,21 +1023,6 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
> >> page_folio(page)->pgmap = pgmap;
> >> page->zone_device_data = NULL;
> >> 
> >> - /*
> >> -  * Mark the block movable so that blocks are reserved for
> >> -  * movable at startup. This will force kernel allocations
> >> -  * to reserve their blocks rather than leaking throughout
> >> -  * the address space during boot when many long-lived
> >> -  * kernel allocations are made.
> >> -  *
> >> -  * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
> >> -  * because this is done early in section_activate()
> >> -  */
> >> - if (pageblock_aligned(pfn)) {
> >> - init_pageblock_migratetype(page, MIGRATE_MOVABLE, false);
> >> - cond_resched();
> >> - }
> >> -
> >> /*
> >>  * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
> >>  * directly to the driver page allocator which will set the page count
> >> @@ -1122,6 +1119,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
> >> 
> >> __init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
> >> 
> >> + cond_resched();
> > 
> > Originally we called cond_resched() once per pageblock, now it's called
> > once per page plus for every pageblock in the tight loop that sets the
> > migrate type. Isn't it too much?
> 
> There are indeed many more cond_resched() than before, but I don’t have a
> concise way to write it, so I took the easy way out.
> 
> How about:
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 2d680636b67a..d13a2577c4c3 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -683,7 +683,8 @@ static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
> 
>         for (pfn = pageblock_align(pfn); pfn < end; pfn += pageblock_nr_pages) {
>                 init_pageblock_migratetype(pfn_to_page(pfn), migratetype, isolate);
> -               cond_resched();
> +               if ((pfn & (pageblock_nr_pages * 512 - 1)) == 0)
> +                       cond_resched();

TBH, I don't know if 512 is the right number :)

pageblock boundary was a convenient point to have cond_resched() along with
setting the migrate type.

Here we might be able to squeeze more iterations between subsequent
cond_resched() calls.

-- 
Sincerely yours,
Mike.

