Return-Path: <linuxppc-dev+bounces-20241-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A43BFF885D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 13:09:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4gkD6BpJz2xld;
	Tue, 28 Apr 2026 23:09:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777381748;
	cv=none; b=liNzI+2EBr6CZXN5c09dBB6j7EgyroOD9kWL6YGVZ+pfjy9I0glJM/ERnO8qvRLhEjbygyOK/WNjAf2p/GKCBV3KHRXPHZVZHcHnqO/ZWpbmeuyfHJP04VWXLaVDUP+Tyw+sPTGWA2YvHodAzuy+syd2LSv+yuwA7lwn7t8b0l20DSvZRq4JAUWOll39ZFtuUP4uH5nK/youN1xNXXkx4kD5OZp0evAiv1Yv4GvxlOZ1Vr4CFElB1X2mXb40FOCfspZwij6bfWvIXekZDOJJvy/g54ZkpSKAlcdBXG3/0619xBnFUFz1k0cP3O+yM8dvi7j3TRSLkD/JN7OA0PEgIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777381748; c=relaxed/relaxed;
	bh=4nqivCc2PRJMXKSuCzKBaD7+S/jHJk0M6k+CUV6NswQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LovJQBmTWPfHk6q9CuyLvYxPsQgY0yTPjvbysmpq3DbyEZsHM0pGWGDNAXPS5X7On1H510PliGH6ojZExZUeNCl3E7+D1q3rQqmv0xcgLfLNiwKbvcKJmdFyBIxlcYV1rhIP7Nfxp+vAfwVAjfa8acP66IjZCOVU0/KvpuZVBbwtN0DPgTf/9EgjbKpOEBn4r6YUsWih11fYmY1zwu/bLqKrraVEHWtb5tHfNusRRjfUpnFkU+Bym7LIQhz9RlvNIiStS2DGaXmx7EGe9AlteW5jTgWki5D+9zyOb3jZRwTT35Tq83agvUOIzftXa1Wii4Af9FM88u6Dhy88fXeVCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=e4JN5naQ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=e4JN5naQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4gkC4kWPz2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 23:09:07 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6AEB861119;
	Tue, 28 Apr 2026 13:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F66C2BCAF;
	Tue, 28 Apr 2026 13:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777381745;
	bh=y5Wj2Mshp/u7h62ACdtB57U1YInb0w7gkuhwEVUSYGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e4JN5naQJ+TlVk6mBeIiP5kBgPhrbIsfSTf/vPhjQnRELi7dpfbVtB7ACoelq3Jap
	 1zY46otM4NN1WLpNBlVPTdA1TzJh35tO9otOfRJTFL5s+h3VbR7VadwmoPQCR6XGDP
	 NgYZ1g8KA7kTtq1YHu3G1h0OjgQTnJnYjtx3FVNrvmuSvvNrcGXPeZQoBB292gh4Ie
	 hxyYVQSqY8X2a4YFRViC2EZb1IZyWUPFLf44FM8zPleXw3gUUQQ0msO05RFejgRbgY
	 9F6sK+FnOIcDgn5tr9dN6HAJhet4K1gOT/1BuGP0IGaTdVie8lwjqKQv4pqVuwZ/gB
	 l29nT7E3K7OXQ==
Date: Tue, 28 Apr 2026 15:08:55 +0200
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
Subject: Re: [PATCH 09/49] mm: panic on memory allocation failure in
 sparse_init_nid()
Message-ID: <afCxZ5vYDeAlzTK2@kernel.org>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-10-songmuchun@bytedance.com>
 <afBaMEBoR_35Fblc@kernel.org>
 <9FD13495-58E8-4183-AAC0-48E50A694ADE@linux.dev>
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
In-Reply-To: <9FD13495-58E8-4183-AAC0-48E50A694ADE@linux.dev>

Hi Muchun,

On Tue, Apr 28, 2026 at 08:13:05PM +0800, Muchun Song wrote:
> 
> > On Apr 28, 2026, at 14:56, Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > On Sun, Apr 05, 2026 at 08:52:00PM +0800, Muchun Song wrote:
> >> When vmemmap pages allocation or usemap allocation fails, sparse_init_nid()
> >> currently only marks the corresponding section as non-present. However,
> >> subsequent code like memmap_init() iterating over PFNs does not check for
> >> non-present sections, leading to invalid memory access (additional,
> >> subsection_map_init() accessing the unallocated usemap as well).
> >> 
> >> It is complex to audit and fix all boot-time PFN iterators to handle these
> >> partially initialized sections correctly. Since vmemmap and usemap allocation
> >> failures are extremely rare during early boot, the more appropriate approach
> >> is to expose the problem as early as possible.
> >> 
> >> Therefore, use BUG_ON() to panic immediately if allocation fails, instead of
> >> attempting a partial recovery that leads to obscure crashes later.
> >> 
> >> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > 
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > 
> >> ---
> >> mm/sparse.c | 37 ++++++++-----------------------------
> >> 1 file changed, 8 insertions(+), 29 deletions(-)
> >> 
> >> diff --git a/mm/sparse.c b/mm/sparse.c
> >> index effdac6b0ab1..5c12b979a618 100644
> >> --- a/mm/sparse.c
> >> +++ b/mm/sparse.c
> >> @@ -354,19 +354,15 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
> >>    unsigned long map_count)
> >> {
> >> 	unsigned long pnum;
> >> - 	struct page *map;
> >> - 	struct mem_section *ms;
> >> -
> >> - 	if (sparse_usage_init(nid, map_count)) {
> >> - 		pr_err("%s: node[%d] usemap allocation failed", __func__, nid);
> >> - 		goto failed;
> >> - 	}
> >> 
> >> + 	if (sparse_usage_init(nid, map_count))
> >> + 		panic("The node[%d] usemap allocation failed\n", nid);
> > 
> > Please consider using memblock_alloc_or_panic() in sparse_usage_init(), it
> > would simplify the code even more.
> 
> Hi Mike,
> 
> Should we add a new function like memblock_alloc_node_or_panic? Because
> we want to allocate vmemmap pages on the same node.

Heh, I missed the nid part :) 
There are a few _node_ or _nid_ allocation helpers in memblock, starting to
add _nopanic for them would be overkill. Let's keep panic()s at call sites.

> Thanks.
> 
> 

-- 
Sincerely yours,
Mike.

