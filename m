Return-Path: <linuxppc-dev+bounces-20261-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28115FF8867
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 06:53:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g57LW5GMdz2ySf;
	Wed, 29 Apr 2026 16:53:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777445619;
	cv=none; b=i+0ullLvvsYF6ih5J/zbIGqyp6U/a+Jwb+4+RZf3bLMi6p6QGoRTYQ6Uxt/GClsQ4IhGtBBoPqxfrBfYPmkxjJK/XMVlCtO+Y8hBjgB1FuAdZyFgCuoPwCOp54DaOip3emahLGLfP1VEIIt6afalhe6ODTglOekpU8Y44NzJ2ZDA6dWhN2lkpe0CQEN3PqUfxBj6bxFIWqbHSjZnEAs4Y/1WloQj6bSkrn3Q4/CQj4dZ4ywadT/mXtnViGEsrED1LH+1NB7aDZztOSHuobsFRX37n0ocHnBFOk1csj9tE+hEwVn8cc36W1b7Ct+6ZyarLEvbc6X30ILOliLG7rrbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777445619; c=relaxed/relaxed;
	bh=mwtMkfT+6sltnF7j1cEJxZhmiEFv2uzDyIODaaF3YcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQLL++MrwYX9RJROcdIaDIy+N7Wt/ZfeRngnQvsg1ypWm/E+froHoEKRGYvBV+ZA7cI01tSiGTB0rwo56eu81RA0hVKkVDlVtks47McMWVi05+kyPxIxBjSkEK+Y6/Ik6K+yNCZ+zp6vmODAB7T3xz1OqIjO2iQcRSXT+Oq6MPGz+jZq+ADO8KM4sLxKQSqNKmCrBPNkwiXKiQJA5WGk9Rs/XSQGhexqHnL/TpH+rIML9OUxQYWUt0Ea6mc/8Ectf7d3v+hmlfOrCLGOSow8IOxcR57yMqZfKYLLCZCuz5IkJhcKTNBx0mm6IKtnB2Qybe7c4IYdWwIF5djujiVf9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=B6o7uOCV; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=B6o7uOCV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g57LV5sYhz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 16:53:38 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EF7E043E6A;
	Wed, 29 Apr 2026 06:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ACCC19425;
	Wed, 29 Apr 2026 06:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777445615;
	bh=ry4QTtQg8gXjbztYVBm6zJYokjTwMcboL55Qdm43+vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B6o7uOCVUGVofvTMhOIRKEpYQrDDYTS40KrJjZi1lZcjCMWOmBvECYESWQWo2FVEm
	 CHgBOcMLdJr+CPQ9pEgOcUNxvZ0eJonTtXQ1ivm9OO4VTt9xQrU7ffBl3GntJgk9jJ
	 N6zPTFijjshuRS327HvfZssZt7OhHRanMs8zr0NXFlTvbmDSz/8t+Oyw/dxAIS5XBl
	 WQz2fBkof+CazOSWappmrULhQbSwMfZfv4+C0djEyjZDHCHzmVU5jlOMGG2ggTX8jD
	 evzy9JnKbuFXrAYVJ/RJPq6+lbLGkAdZW//k3DqHjytTypZiqpjWUR78XvjEllPR6y
	 XUBdn9/v7X7gA==
Date: Wed, 29 Apr 2026 08:53:25 +0200
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
Message-ID: <afGq5Qa21NOumdwp@kernel.org>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-10-songmuchun@bytedance.com>
 <afBaMEBoR_35Fblc@kernel.org>
 <9FD13495-58E8-4183-AAC0-48E50A694ADE@linux.dev>
 <afCxZ5vYDeAlzTK2@kernel.org>
 <408EDCB4-7F65-4595-BE44-E23300FBD397@linux.dev>
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
In-Reply-To: <408EDCB4-7F65-4595-BE44-E23300FBD397@linux.dev>

On Wed, Apr 29, 2026 at 11:14:14AM +0800, Muchun Song wrote:
> > On Apr 28, 2026, at 21:08, Mike Rapoport <rppt@kernel.org> wrote:
> >>>> 
> >>>> +  if (sparse_usage_init(nid, map_count))
> >>>> +  panic("The node[%d] usemap allocation failed\n", nid);
> >>> 
> >>> Please consider using memblock_alloc_or_panic() in sparse_usage_init(), it
> >>> would simplify the code even more.
> >> 
> >> Hi Mike,
> >> 
> >> Should we add a new function like memblock_alloc_node_or_panic? Because
> >> we want to allocate vmemmap pages on the same node.
> > 
> > Heh, I missed the nid part :) 
> > There are a few _node_ or _nid_ allocation helpers in memblock, starting to
> > add _nopanic for them would be overkill. Let's keep panic()s at call sites.
> 
> We can add a panic inside memmap_alloc() because it is used specifically for
> memmap allocation. To some extent, this also reduces the number of places where
> callers need to add a panic. What do you think?

Right, with sparse_buffer_alloc() and with this change memmap_alloc() can
panic(). I like the idea.
 
> Thanks.

-- 
Sincerely yours,
Mike.

