Return-Path: <linuxppc-dev+bounces-28962-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731FACA5FFC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 10:52:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzY4P6YDTz2yjw;
	Tue, 06 Oct 2026 21:52:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791283957;
	cv=none; b=KYtS2MwOOTkXT2PK2hxbGp0D7WepaYwpKcKUQvcTkDn+jFAlO7PNXy1gORqvFXJpPKTW8xHH5eickVYS+G96TaPtDk0q7FsUSU/EeiffkgmTNZtCXFX4E/9s5PNgA+W/xQhCOOkgYxItG814nk+9Ew9uN3w/OlyHSlOhX4I8/B6smf+8AcPaMVY1zKquLX8R9QhwBj77vz4QCLNjGZbIRXSQ8YRGN6us5uHt/WhVav/f+ZgUeXKbZma/1A1bgv8b0RRQ7y600Jv/iZUWiKRoO2SbhbyUi3Ra88KdQbERos7EeBGBoh19Qq0Sj1qJFYDdiazudbqWmziaB90M+/NjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791283957; c=relaxed/relaxed;
	bh=Sb1SBwuGuPt1qP7ui7PIRFwQF/QwxhK7LWahurK/UGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gx5gElbiP2tzGWSCCWnysmFyezeDDgcBwEKHCWnlLOCQ+4DHI0rhVFt2EKzM4WheN/0NHScfGWz+Z31R5gBmcVl+HqAMA4GgSNOODHY+/WS2bP5jY7jONg+uI3DS1CeLllEpw+XpCLh9dHMkpzh87B5IBOqaiP94n/NK3Iaqbs8JXXKj2fXEH3nx0oGpgMYh+wmbMKyTXjegpXc6mrUpGncxVhYtV2PUM0MHdWOKWfvts9QI+ImfnjAD4zmJSg/2QmAs0KAZHJSq1zbyT4VopAducfLkJQoSw94luxWRbrAnHf3uZZz4Zuki84D78JWOKECABZTyqSNyfwvrJX8NNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPDc2rpr; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPDc2rpr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzY4N2B3hz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 21:52:36 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1198E6022C;
	Tue,  6 Oct 2026 10:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0891F000FF;
	Tue,  6 Oct 2026 10:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791283952;
	bh=Sb1SBwuGuPt1qP7ui7PIRFwQF/QwxhK7LWahurK/UGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UPDc2rprdWWklNjxtl84opXyR87sbol/pJaC9vtqX6Sxn4rnOqdifPu2HwdV1iQ+O
	 u38O2miOTA5MnBFfEQq8L9YSpRWEYQpuWbZy6RYRA3f99TiWUQzS0KLiqV19rOFHqh
	 fY5N0qs4goUW6KgL7eEj8lkxXZ5yVeeS3YQR0YFVOeGp3ao3Sx/h42dRjBQoER7W5Z
	 xOUwp+ofq5vwtBjlRohMtRDAwPCJzDzRZT1QX7gpltGi3uewvT6Ys4uhTuU705Q7fP
	 WnbobxKCz5yU2Z/9lGB/XJi/Ctpvap2cJHMiAGQ+iR9zPjPpYSOUSHu1pif14dCz9F
	 GHd5d5QVErTLw==
Date: Tue, 6 Oct 2026 12:52:24 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Qi Zheng <qi.zheng@linux.dev>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 6/6] mm/mm_init: add zone mismatch warning during page
 init
Message-ID: <asTS6OtxPMVshuIO@kernel.org>
References: <20260929053231.66085-1-songmuchun@bytedance.com>
 <20260929053231.66085-7-songmuchun@bytedance.com>
 <ar5xbQsUpSQZg0wO@kernel.org>
 <78D5D6AA-BE36-432C-B0F7-453F93DF18C0@linux.dev>
 <ar9p39Y9SmlxvbA_@kernel.org>
 <85941AA4-7E50-4AAE-BC05-0F443B21BE8B@linux.dev>
 <ar_0GLYM6KsIH6tQ@kernel.org>
 <D91CEA1E-6B79-434D-AF49-16C62C0FD095@linux.dev>
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
In-Reply-To: <D91CEA1E-6B79-434D-AF49-16C62C0FD095@linux.dev>

On Mon, Oct 05, 2026 at 06:27:52PM +0200, Muchun Song wrote:
> > On Oct 2, 2026, at 20:12, Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > On Fri, Oct 02, 2026 at 05:56:40PM +0800, Muchun Song wrote:
> >>> On Oct 2, 2026, at 16:22, Mike Rapoport <rppt@kernel.org> wrote:
> >> 
> >>>>>> diff --git a/mm/mm_init.c b/mm/mm_init.c
> >>>>>> index 1650d6bc1211..bd02e8d06965 100644
> >>>>>> --- a/mm/mm_init.c
> >>>>>> +++ b/mm/mm_init.c
> >>>>>> @@ -609,6 +609,9 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
> >>>>>> if (!is_highmem_idx(zone))
> >>>>>> set_page_address(page, __va(pfn << PAGE_SHIFT));
> >>>>>> #endif
> >>>>>> + VM_WARN_ON_ONCE(vmemmap_optimizable_order(pfn_to_section_compound_order(pfn)) &&
> >>>>>> + page_zone_id(page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) !=
> >>>>>> + page_zone_id(page));
> >>>>> 
> >>>>> Hmm, page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES is initialized a tad later
> >>>>> than page so it'll have stale data in the page->flags, won't it?
> >>>> 
> >>>> Lance is right. The shared tail struct pages are already initialized by
> >>>> vmemmap_shared_tail_page() during vmemmap population, so they're not stale.
> >>>> The head 64 struct pages are initialized later — right here, after vmemmap
> >>>> population.
> >>> 
> >>> Still it looks out of place here, can this check be done in sparse-vmemmap
> >>> somehow?
> >> 
> >> The struct page entries of a vmemmap-optimizable compound page
> >> are currently initialized in two stages. During vmemmap
> >> population, the shared tail entries are initialized first. The
> >> retained head area—normally 64—is initialized later through
> >> __init_single_page().
> >> 
> >> This warning connects the two stages: while initializing the
> >> retained entries in the second stage, it verifies that their zone
> >> information is consistent with the shared entries initialized in
> >> the first stage. Therefore, the same check cannot be performed
> >> during vmemmap population.
> >> 
> >> I am planning to first unify the HugeTLB and Device DAX
> >> compound-page initialization through a common helper [1]. Once that
> >> work is complete, maybe it will be easy to move the initialization
> >> of the retained head area into vmemmap population. With both the
> >> retained and shared entries initialized in the same stage, there
> >> will be no cross-stage inconsistency to check, and this warning
> >> can be removed.
> >> 
> >> Would keeping the check here for now and removing it as part of
> >> that follow-up sound reasonable to you?
> > 
> > While it feels really out of place in __init_single_page(), but having it
> > memmap_init_range() close to the if that skips shared tail pages makes
> > sense.
> > 
> > What do you say?
> 
> Sorry for the late reply because of traveling to LPC.
> 
> Putting the check in memmap_init_range() would validate the
> invariant for the shared-tail range skipped there. It would
> not, however, cover all vmemmap-optimized initialization
> paths: optimized Device DAX bypasses memmap_init_range()
> when there is no altmap, and deferred boot-time HugeTLB
> initialization may also initialize retained entries
> elsewhere.
> 
> If the intention is to validate only the skip in
> memmap_init_range(), moving it there makes sense. If we want
> the warning to cover both HugeTLB and Device DAX generally,
> it still needs to remain in __init_single_page() or be
> called from the individual initialization paths.

Yeah, putting this into all the callers sucks too :(

With all the callers,__init_single_page() is the right place for this
check, but I think we can add a static inline in sparse.h, like e.g.

vmemmap_optimization_verify_zone(page, pfn)

to make it a bit nicer.
 
> Thanks,
> Muchun
> 
> > 
> >> [1] https://lore.kernel.org/20260513132044.41690-18-songmuchun@bytedance.com/
> >> 
> >> Thanks,
> >> Muchun
> > 
> > -- 
> > Sincerely yours,
> > Mike.
> 

-- 
Sincerely yours,
Mike.

