Return-Path: <linuxppc-dev+bounces-22610-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8A5CD98C5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Jun 2026 09:55:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gdTBz1QKmz2yFc;
	Sun, 14 Jun 2026 19:55:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781430923;
	cv=none; b=PTgw/zFctWvCb0ASYDdLdG4jtfOlZkQrzvJjBHXMw3Bfus34Ahk39fJ5TvQv9DobT+C6VE8em7ps5cOgqVCdsMERysU5NVjPFiZA2Wad9472V5qWQEtAUEjiZjvWxhvaw4eWWRx8VZFu9A8vlKuWxKG0ceYajx1zaLL3Pd6pEmXTG0LZpzkBcQ3LIMXG6ngOAwmJPT7qZf2HJ9RDxLdlpb++s0jZZh8KPU8NiYGG+nzXRB/wnbQqXMqjsuzg8v1YrKrEBy2Ihc29Ejgh5j7h0tyfPSZyRuLoU0QAY1XdayOY+6vfCLlCelFe/MViGOMolTdjioZ4XfgQl1ZgVgU1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781430923; c=relaxed/relaxed;
	bh=l+rYKnQxSik6h20p9v/FXlfKzLNE3EJSxpZIHMtaCF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juDwwkEe/VK8lDD11S0IOh4ztfjY1j4Kpw7IM74x4JaU4tDgHozVi14rVGHkMyAtkw/1Zgy6fqjjNDF7kFdJYG5kmQs2Odr7cdZHK3Wvwl6gTzoo2MGUJCcMDPITHvUUmYH7ELjO7Da7d87lnyyl7nazWk7I8m1T0W2s0eXO5QxnLZD1sVRe4NVSTrXpWwKUSomZvl4KZkLjA5eYZGJiM6okVSS47L6I3RY1orkUJcUSYgfys2n3QW9AbFpkJ0sCp7tzlFfgBCX2eQ16uJOWAQR2X6MwFdu1L4l0zIu0SOXaGglLQOeKyA4cT3Zka+PLl1ldGhOQa0k4+FWk+WCmNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P70k8Eds; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P70k8Eds;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gdTBy3Whnz2xtC
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jun 2026 19:55:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1B5816008A;
	Sun, 14 Jun 2026 09:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55211F000E9;
	Sun, 14 Jun 2026 09:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781430919;
	bh=l+rYKnQxSik6h20p9v/FXlfKzLNE3EJSxpZIHMtaCF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P70k8Edshz2WvKYbe98e+4xLaHZggUaZdsdYpyRf3z41TpiGJEgcwxn42JUi9MOZ4
	 wbbxm7AQkQw5Yu8ryL7XbUtPFNnrnlYtSC//PnfMNJ9UwUuJ8lVCtqHA4HVQZRocvc
	 obPyuILakMsOZLjjgL7dbVLjrT8t3xFBZrb+tdl/eviRDBI84WhRs/eLjuT0n93XD5
	 7lwLh5RTs2QTcPZN4KeNOoBFM5f7zKS3ubJSWxBWlphEjJMC7kuKt1v1Nx7lXmzVY2
	 zHTUJ3mg1alCBZGJ/rhPEFvXmjVkMUbjvLfP57yOnTiAjivMFltddHWoFk5RO58JYW
	 C1RHQPavfL2Ig==
Date: Sun, 14 Jun 2026 12:55:11 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, rppt@kernel.org
Subject: Re: [PATCH v3 14/19] mm/hugetlb: Free cross-zone bootmem gigantic
 pages after allocation
Message-ID: <ai56f5AxGJQ5SiGp@kernel.org>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
 <20260602101039.1867613-15-songmuchun@bytedance.com>
 <178041489395.457517.12727427621570734471.b4-review@b4>
 <1ABCD934-CA2C-4541-9B76-32FAEFD398FF@linux.dev>
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
In-Reply-To: <1ABCD934-CA2C-4541-9B76-32FAEFD398FF@linux.dev>

On Wed, Jun 03, 2026 at 10:53:04AM +0800, Muchun Song wrote:
> > On Tue, 02 Jun 2026 18:10:34 +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> >> 
> >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >> index 5e557c05d80a..218fb1ca45f4 100644
> >> --- a/mm/hugetlb.c
> >> +++ b/mm/hugetlb.c
> >> @@ -3073,22 +3076,38 @@ static bool __init alloc_bootmem_huge_page(struct hstate *h, int nid)
> >> [ ... skip 26 lines ... ]
> >> + 	* pages belonging to the requested node.
> >> + 	*/
> >> + 	if (WARN_ON_ONCE(nid_request != NUMA_NO_NODE && nid != nid_request))
> >> + 		list_add(&m->list, &huge_boot_pages[nid_request]);
> >> + 	else
> >> + 		list_add(&m->list, &huge_boot_pages[nid]);
> > 
> > Can we just memblock_free() the page that intersects zones here?
> 
> I had previously considered doing this, but then I realized that if we free the
> allocated cross-zone memory here, memblock is very likely to select the exact
> same block for the next allocation. This means we'd just end up with this
> cross-zone memory again, degrading allocation efficiency. Unless there is a way
> to mark the block so memblock avoids reallocating it, I ultimately chose to
> defer the release to prevent this issue from happening.

You are right, there's no simple way to avoid memblock using the same
range.

The comment at hugetlb_hstate_alloc_pages() hints that we might want to
split allocation of gigantic pages to be more explicit as a followup
rework and then freeing of cross-zone pages would be cleaner as well.
 
> Thanks.

-- 
Sincerely yours,
Mike.

