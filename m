Return-Path: <linuxppc-dev+bounces-20835-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95B0CD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 08:27:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFmmp2s1Mz2xn3;
	Wed, 13 May 2026 18:27:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778660874;
	cv=none; b=oU31WhmA8UJfTd0fBMNGAOe32W5Zq/lSBbLRxIrpiiF2NSsK67DbkT8Nkxdrz539rbnNkWLOo1puj3hJxkAIzPiW7FxGujoTr6o91ZjWfZWXXYgn4qIPZsxMH6QYMzjYSAIqAdWYdrhR0pSrg/ElHNB9FBDau+GXtpgwkunS0M0ENTmAkkTrnIgXHhJ/GWSsJEKSAslxsySXc1FAxjVM0ZuzP8TYhyeiwjWtJtu9qjSj65FLT6ltllD6MTzHsfyG0oCrEeFjgPOkDmsDBp684OEjmBzhRPpYIakbpgKK1Rp33sRC21WX7U4IlZTtrl3hYhTk9FIbzb9kCkm+qz/O1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778660874; c=relaxed/relaxed;
	bh=bBxpQgvAzoJYCqFESYm/jq9o9rPQyCc4q8HLNSw0TCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUnjSQg32TuP75JiualxVrlmWOwHICOyQ7Q4qFBTzqelY7W0DGOBtYArZlTExZ0znAmV/hQ8r2TT6T5YntWAGUCGTksgBu6AJt7o0n2o3v2ifpNGnt5BvQgHafDSeC8qcik0seafsRSY3EhzhNv+JfbQ+Lt6XlgpGvXwdhGOi9SxfzdwZh/L/H/BTKBDt5Fpn3QM1V3rxT9StVXMmJsgU3v87B9k1LWlQzme/YBQSrSowSQLYwF9sADcyYXLEDBVIiBPFZirkI+5Ms+4d/MkJBVCoam2xSqLaKZcRzD4vyq44Bw2o3ueqsICp31VFMFFTjwzr3nkMGg1tJMu0jc64w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RDVBvJWx; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RDVBvJWx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFmmn5g0Wz2xlV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 18:27:53 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 618E343AEF;
	Wed, 13 May 2026 08:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1415EC2BCC6;
	Wed, 13 May 2026 08:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778660871;
	bh=BFNiTiF/fmalzC6zsySYqjiBYoFoZn/VA1kMh/SGay4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RDVBvJWx9At9GYymZiTlO41qMOkSSKg3BboX/CVnFiIv0SuGpInRHEAvhGMxiyigy
	 XYxY2QFNHsiM/Kz6qb5NfpYB+1dXscvNM3WsLoOGc6QHMmkIQMh572x12weyGPWoYH
	 vHOryRtbOWtZJ68xh++I/5IQOucJ2dlC2eMdo3MQy9H691yqC0Lj11nXwLpOCAE3aS
	 KhDIBcOu0yW33BDLsOG8B9VSmd3sJ8VVXgKFCHYGt4NsVHGDVW/asy6XiNs4qyNwom
	 OXjzJ7LMX26VkGqcr9MOhhtZsLzcVib+okPrxWlYGMY16gAJAI/YzgvweX2k+RnwnR
	 FkFjWcg1j/ROg==
Date: Wed, 13 May 2026 11:27:40 +0300
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
Subject: Re: [PATCH 2/8] mm/bootmem_info: drop initialization of page->lru
Message-ID: <agQ1_Bl6obF1bpT0@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-2-3fb0be6fc688@kernel.org>
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
In-Reply-To: <20260511-bootmem_info_prep-v1-2-3fb0be6fc688@kernel.org>

On Mon, May 11, 2026 at 04:05:30PM +0200, David Hildenbrand (Arm) wrote:
> In the past, we used to store the type in page->lru.next, introduced by
> commit 5f24ce5fd34c ("thp: remove PG_buddy"). The location changed over
> the years; ever since commit 0386aaa6e9c8 ("bootmem: stop using
> page->index"), we store it alongside the info in page->private.
> 
> Consequently, there is no need to reset page->lru anymore.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/bootmem_info.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> index 3d7675a3ae04..a0a1ecdec8d0 100644
> --- a/mm/bootmem_info.c
> +++ b/mm/bootmem_info.c
> @@ -34,7 +34,6 @@ void put_page_bootmem(struct page *page)
>  	if (page_ref_dec_return(page) == 1) {
>  		ClearPagePrivate(page);
>  		set_page_private(page, 0);
> -		INIT_LIST_HEAD(&page->lru);
>  		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
>  		free_reserved_page(page);
>  	}
> 
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

