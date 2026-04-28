Return-Path: <linuxppc-dev+bounces-20212-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CE4FF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 07:16:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4Wtp4B70z2xld;
	Tue, 28 Apr 2026 17:16:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777360562;
	cv=none; b=BcxHkQhip/yUlWyE3wrNjQrKNTk44qaF863De2GAccD4sPnWRbI5R+xuLQwraYjBaXXfjdGvCYoK0Up+lnqJlWzTU6TxU/h2LK1iTcyvu73ZGn/INgUcKwZmcyvU9Oy449koXlTowJYE5b2wRLoVT1dRdjn0+T7l2vdBRauE4YeoqXUw6qmJ+ldkrxj7kCSYvLmeUFbKGAHXvHBzZkjF3KT7kfk7UGTBP6cV6Y8G2RlDGvNhVLfPPhxD8FsvqYpNPBbKGCKrUrOxQg46n3jfrEhVu9K4WiOjuznXbHHSOAJcx5r+IYWuaKGSEKOq5/nmbrr3S0UosW4Kf8ciG487hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777360562; c=relaxed/relaxed;
	bh=b2nIdXZGtzZPRfGZ55biL1KoKrGDTk439ANvyPc2tGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOyKDSzGOReki+dO+nT0CB9QCyIrPODDROdGda+ebW0gDidvI9+Jircb4bnT/w0KgHxUc2MlhGyNYE66NYGeZAEZSm4HbhFCSRw4G7mDhmvMAdvLZXpc7VCZWMprOmNbvzCuSYQTvZPFKgd4PXMsDL3QiyV/Sp60Jr35s1+ADaJm0KZAyQAth8sVv4Tuk6AtmMCLjhplbl0+mPM0DEoy2qn0fqSLM2/WC6qCWlQCab5Bp3jYVOs44FyMnOwnn7z8obVma5MX3t+4EECNooASgOQAFkv9NHlboBRR6WqsQ8/CbC/4BaPhX/VhxV9NpIN3JXzQy8qxjJe8r49QqiKB4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=J7emyAvV; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=J7emyAvV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4Wtn437bz2xTh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 17:16:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6EF4660133;
	Tue, 28 Apr 2026 07:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B73C2BCAF;
	Tue, 28 Apr 2026 07:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360558;
	bh=YiFruMllP7Hsn3RHqR+ow3axxP/rEMVw7OY4f6H0hUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J7emyAvVkk5SF6YOCLb8Y6pqahYtojSzc7QFL7eGIX96o8UFPF7U8LVVpvE0x9Mk7
	 Ty0vbdH2dMMfYs2hMMMhiZn/zWghIbN4G3dIE0Jl6pW7My2PDE+h1b25J8vIHXxvGP
	 kfv7o1zD5vW7RJCpOIHOEMo49bkkt4KWfvYPK4a2u9AXIUAouI6uvxRYz1RxLIwebM
	 JUjL7+O8rG78bTKN6CjujeXTzjkKsEdbigh7zQz37K4Jcens/Wi4hegeBHcLeKudHj
	 7svjSLPqxKPID34kBHjSqsByE0hxRF2eFGqcsr+QIx6tzWdJ95jOHn8IGasqmiROzI
	 PCudJwjRJIc8g==
Date: Tue, 28 Apr 2026 09:15:48 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
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
Subject: Re: [PATCH 11/49] mm: defer sparse_init() until after zone
 initialization
Message-ID: <afBepGBqlKTyOFob@kernel.org>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-12-songmuchun@bytedance.com>
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
In-Reply-To: <20260405125240.2558577-12-songmuchun@bytedance.com>

On Sun, Apr 05, 2026 at 08:52:02PM +0800, Muchun Song wrote:
> According to the comment of free_area_init(), its main goal is to
> initialise all pg_data_t and zone data. However, sparse_init() and
> memmap_init() are aimed at allocating vmemmap pages and initializing
> struct page respectively, which differs from the goal of free_area_init().
> Therefore, it is reasonable to move them out of free_area_init().
> 
> Call sparse_init() after free_area_init() to guarantee that zone data
> structures are available when sparse_init() executes. This change is a
> prerequisite for integrating vmemmap initialization steps and allows
> sparse_init() to safely access zone information if needed (e.g. HVO case).
> 
> Also, move hugetlb reservation functions (hugetlb_cma_reserve() and
> hugetlb_bootmem_alloc()) to be after free_area_init(). This allows
> hugetlb reservation to access zone information to ensure that contiguous
> pages are not allocated across zone boundaries, which simplifies the
> hugetlb code. So this is a preparation for subsequent changes.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/mm_init.c | 15 ++++++++-------
>  mm/sparse.c  |  3 ---
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index c7f91dc2e5b5..5fe0a7e66775 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -406,9 +406,6 @@ void __init sparse_init(void)
>  	pnum_begin = first_present_section_nr();
>  	nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
>  
> -	/* Setup pageblock_order for HUGETLB_PAGE_SIZE_VARIABLE */
> -	set_pageblock_order();
> -

This does not seem related to this patch. Otherwise

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

>  	for_each_present_section_nr(pnum_begin + 1, pnum_end) {
>  		int nid = sparse_early_nid(__nr_to_section(pnum_end));
>  
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

