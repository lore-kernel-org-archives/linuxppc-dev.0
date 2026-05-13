Return-Path: <linuxppc-dev+bounces-20837-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCC0CD37B6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 08:32:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFmsl1K7dz2xpt;
	Wed, 13 May 2026 18:32:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778661131;
	cv=none; b=Elysn7I5ddlgd25FzKG5eTkTYLj2hR80zrk6mgT1cB4sHndsNE2r2tOxqIUtqgQNYVHK8PSj9uAS8+i5hO1Ku9AdS6NR5rKOUqnjLC2R++uq7kiakc34GdMNrkSUm6C3yR9PQ6m0H/qRij8NK5CWMAYBlUW1W3ldn41bhb5jYCkB1Py5bX+i9yHTu/PWAzW2+eLG0EzOmr3K47mhBdCZDCsg7U5dXqMEwPi9Leplvz0AjCrTOrWjRIDwETQjQiw+6+ej+aKvjCXxsg+RjP647ryUgxhynnTq03IAFewv4fxLOJgsVwuBJgtgv9zpEPh39/VdTn8Byq2BPvKJVsPGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778661131; c=relaxed/relaxed;
	bh=TBvkYb4fjv0CWfmKlG/834qQuk5hekjk3h3U46rjKpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWDbEDGAPJcVHGP65pCAZ/echolp+gJSyUv60DFnQlxhNSrjYdQHA8oGdsaesJQp/+Wtb1SHtJ0Ra1dvV5QkB8nHmqFc5J3w0mjiLY8+hLQVgOEex7SE6Z3q8lJtNMQ3RcJqpCeN09b4w5brPz+T+wycFXcadwQ+vUX8DTvqHWPEusRi4psgrbfuZqdHO7JIdysmnWiKHPI65KeEWOKAaYzD7kLzERdmevdwgPL9udvNVarfoXupQ8XqQ9ofQa5GqIMEmoi8vCLov8t6V+lCLB6P1IfbXbTcBRgF2P2vBXmQXY2ekeZOcI3p+XRbMugbdBRVW+l2a2EAMDq4w0o9Ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b4S1fRzs; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b4S1fRzs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFmsk37zgz2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 18:32:10 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B1F9142D83;
	Wed, 13 May 2026 08:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5E9C2BCB7;
	Wed, 13 May 2026 08:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778661128;
	bh=qp/Kvrjw7Oq7hxqDPSczPb7gzSG1XTgAYGfhyvfkbpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4S1fRzs+BpoYpyi2lzBeRnk/n/Eutkx1iJx4JcHlOEVAgOQyZ5NnR1NPl/q7qJoO
	 C7zMk2y/zgvAqKk3jybr21fH4PW9duyXBucYc30yZ8xZ8l0q2fcP9SX8t3CJJBOe6E
	 FcHQlKDGnZ7p7qa3Bj9oo7i1i5WpWCuHFbKuGDeLEjKZtbXEuuiWChQKbQii4tqnqI
	 TvzXQR7qJ6t4iWSL8b/6f5d9Hk4TS3fH2vtf0Eb104G9DcBwHMtUaFenltZVcdY9V6
	 nBbz+d3RbNr8GQQP7xyDaGlrjtUjRcckR90Z9NPnuwt8k6Ub+MvMf+YHLgdpqHvpoY
	 OLb9we90YCq8w==
Date: Wed, 13 May 2026 11:31:58 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/8] mm/bootmem_info: remove call to
 kmemleak_free_part_phys()
Message-ID: <agQ2_upxbT_i7-6S@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-4-3fb0be6fc688@kernel.org>
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
In-Reply-To: <20260511-bootmem_info_prep-v1-4-3fb0be6fc688@kernel.org>

On Mon, May 11, 2026 at 04:05:32PM +0200, David Hildenbrand (Arm) wrote:
> The call to kmemleak_free_part_phys() was added in 2022 in
> commit dd0ff4d12dd2 ("bootmem: remove the vmemmap pages from kmemleak in
> put_page_bootmem").
> 
> In 2025, commit b2aad24b5333 ("mm/memmap: prevent double scanning of memmap
> by kmemleak") started to use MEMBLOCK_ALLOC_NOLEAKTRACE when allocating
> the memmap to skip the kmemleak_alloc_phys() in the buddy.
> 
> So remove the call to kmemleak_free_part_phys(). If this would still
> be required for other purposes, either free_reserved_page() should take
> care of it, or selected users.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/bootmem_info.h | 1 -
>  mm/bootmem_info.c            | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
> index 492ceeb1cdf8..f724340755e5 100644
> --- a/include/linux/bootmem_info.h
> +++ b/include/linux/bootmem_info.h
> @@ -82,7 +82,6 @@ static inline void get_page_bootmem(unsigned long info, struct page *page,
>  
>  static inline void free_bootmem_page(struct page *page)
>  {
> -	kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
>  	free_reserved_page(page);
>  }
>  #endif
> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> index 6e2aaab3dca9..74c1116626c8 100644
> --- a/mm/bootmem_info.c
> +++ b/mm/bootmem_info.c
> @@ -32,7 +32,6 @@ void put_page_bootmem(struct page *page)
>  
>  	if (page_ref_dec_return(page) == 1) {
>  		set_page_private(page, 0);
> -		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
>  		free_reserved_page(page);
>  	}
>  }
> 
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

