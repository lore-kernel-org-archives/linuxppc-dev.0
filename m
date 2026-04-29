Return-Path: <linuxppc-dev+bounces-20262-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E42FF8864
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 06:54:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g57MR0459z2ySf;
	Wed, 29 Apr 2026 16:54:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777445666;
	cv=none; b=Dv5vLkvENPzlmRIlB5X7UuDUSo/g8ElHJZ6Y7o1ZY26Rr5/e7TCufNNOw7//Zrq3jBth+Kqt3X9kodnRJYWLHruCHkxHdgtx8LmWPqIwVxSUopcrlH8DO/KBUfsSGMTaR8GMf7YybijQuEGOHYiDp2fCMinPbQbkSK3H15+Zv8UtiqZcDZKTK0xQNUypiUmiaGpa7Vuspf/AMwg2dM0SIpJ9+8WihhoDu1xJ6BqXTWs+gM6oGMg3+wJdUYrUeNDYFq0D7CfrlXz+jwp3PAfh1Glv3f+csRBi9bgrdbzPqCRz5PdfGAR8dUDj4QSF5MThfCTakXe1E9C/y2iZUXWqTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777445666; c=relaxed/relaxed;
	bh=+WbTYahkZU0z2sUJhpTIXGrpScOFWXUM7R/pGUhO8u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnrtnT+KF/7AM9GLpisIPvMmCmt7E48cIzV6D2S8op7pe1TXXxp/L12RH3RlG+Gd/1kiTYK0IQNr+4yJJAXHI8deWNa/aY5hHOvkjZZCHpay2P/SGTiBvJoAJOekgDhiT0TLcCGLsxAh2tUvyvYTqstAht5jRrJGS7G71z0PK3xnOBOR8p1K9A4f/FDwKaVfYtqOPl1CDWUhoWYNjFW/Esrb8eCQjw7sXwnOX2SLRs4Dt0hNwjzsClW8c7ZVJUqxWIs3tt8c1u7EAvrYitjgRoqqZXARiiPT7GU+mmegVZOf0QgsZXRFdhRD/qB7fKDOk1dA3cyKiya2+KgzZ5cPcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QjYezp2W; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QjYezp2W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g57MQ2bZNz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 16:54:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 89DAF60583;
	Wed, 29 Apr 2026 06:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC19C19425;
	Wed, 29 Apr 2026 06:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777445663;
	bh=VZhtBpxtU8HwWnxxe7mElHzRTUbl86uTSwoh/+EFdzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QjYezp2WABk/jL3hRnX8uE/19RtCgpxR/18bX0qbACdrN/vPKi9wmghBVgVkeuWT/
	 otyKR5y0W7LUENnkCNaLS0Q5nP+qdpr2oHThPhrcsIwdPc813ychE4gYb8ty6jTyOj
	 377di99Rd/I+crzDzejN9wS+Xb8qJvJXFBxigPqEpPhR5VfsksF43m6a7TQXKsH9Ji
	 3/906mdHOKcTMJDMgTKF8SjUVa3IUg5+1/lecu5Cel1eiMVkfoc4DEOJMAJTgF9TvD
	 TDEnySeBIEbY9lUAbCWopWghVONqeUtpXbkvfE8+MpJl626rRTUpPPSIWzDdzwxzNj
	 KaxcWyxQWLGCA==
Date: Wed, 29 Apr 2026 08:54:13 +0200
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
Subject: Re: [PATCH 10/49] mm: move subsection_map_init() into sparse_init()
Message-ID: <afGrFUXRRONMhFgB@kernel.org>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-11-songmuchun@bytedance.com>
 <afBcckUTQt-7xPPN@kernel.org>
 <DFB372BA-A262-4507-9280-7C0072280CC4@linux.dev>
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
In-Reply-To: <DFB372BA-A262-4507-9280-7C0072280CC4@linux.dev>

On Wed, Apr 29, 2026 at 11:06:15AM +0800, Muchun Song wrote:
> 
> 
> > On Apr 28, 2026, at 15:06, Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > On Sun, Apr 05, 2026 at 08:52:01PM +0800, Muchun Song wrote:
> >> Move the initialization of the subsection map from free_area_init()
> >> into sparse_init(). This encapsulates the logic within the sparse
> >> memory initialization code.
> >> 
> >> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > 
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> Thanks.
> 
> > 
> >> ---
> >> mm/internal.h       |  5 ++---
> >> mm/mm_init.c        | 10 ++--------
> >> mm/sparse-vmemmap.c | 11 ++++++++++-
> >> mm/sparse.c         |  1 +
> >> 4 files changed, 15 insertions(+), 12 deletions(-)
> >> 
> >> diff --git a/mm/internal.h b/mm/internal.h
> >> index edb1c04d0617..d70075d0e788 100644
> >> --- a/mm/internal.h
> >> +++ b/mm/internal.h
> >> @@ -1004,10 +1004,9 @@ static inline void sparse_init(void) {}
> >>  * mm/sparse-vmemmap.c
> >>  */
> >> #ifdef CONFIG_SPARSEMEM_VMEMMAP
> >> -void sparse_init_subsection_map(unsigned long pfn, unsigned long nr_pages);
> >> +void sparse_init_subsection_map(void);
> >> #else
> >> -static inline void sparse_init_subsection_map(unsigned long pfn,
> >> - 	unsigned long nr_pages)
> >> +static inline void sparse_init_subsection_map(void)
> >> {
> >> }
> >> #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> > 
> > I side note: we might want to split out mm/sparse.h and also move some
> > declarations from include/linux/mmzone.h there.
> 
> I think we can do that in a separate series for cleanup only.

Sure, that's what I meant too.
 
> Thanks.
> 
> 

-- 
Sincerely yours,
Mike.

