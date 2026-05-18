Return-Path: <linuxppc-dev+bounces-21064-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE44CD343F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 06:38:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJp654t5zz2yQH;
	Mon, 18 May 2026 16:38:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779085761;
	cv=none; b=EpHU3foQPFobG6XTF/v6opa8DlPShnspXtuP71ofErRE8CkXaYITiIsIz303M6QGnh89a1wNvKg5nFtOtcVTkYzl/1fa65ssXl2mZU8j+UXx3c6tJxHtN939o6qK/ii2hYFv5S+TrCssAS0LvLV5aNHLrUZSBIC3WGBXPRYnOleADzdDn1GlIXwLxmyhK1Zwx/x92zWXH0FMyMwEn0HwB9IJve6BhdzL4vcGDzKzAwkonYKIA/5AJwcph/Aj6ulyfK7izh08HGOWDyW/+JBQbsYig1rh+8ejV/1+RVb+CSriX1mnsWz+LpkkieFCtY/UybZFDmHtkIghVNjEf/o7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779085761; c=relaxed/relaxed;
	bh=aash4ERkFY1Gt3LoUbMhPm2eq1KEhu8LqF+7BxthrWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsWiw1/ft6zhr7e6RjC95OYkOPOJKVtGa8zKqjrO3Ih2EKO6eB14vGL/bNBpTbGQbhpkJ3a7LkaIf6udzLyJ6R0l1/1sn93Hwh30vpFd59Lg03amLKGfTqQuCN2n+Q/aqLwTcqTtQ0jc1UyY+9GylvjClxHXBaOo1Tn2E1EIAvsotWwh2kHmuWC1QmDH4jiFJYyTAAdR2wDdltrSnudDUX2CtvBMdsm8KE58w+AIqqNQj/NAP/rAv4eHZ2sUvFTmJbHdK88ksHKJP2iEow6FK5iI8rdb9MVQEzmquzKujESm2oRF21BO+J9iLdMKjy03ystVNUGFF/uEYeBKC/Df9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hX9L/8rq; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hX9L/8rq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJnvj1yMMz2xd2
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 16:29:21 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5CF6443376;
	Mon, 18 May 2026 06:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E447FC2BCB7;
	Mon, 18 May 2026 06:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779085758;
	bh=I/XS70rALR6MwZ5SM6q/C17Gn2ByJj0otYaz4sWXm2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hX9L/8rquXn48G5XFv9DP46PUROid7yK9Oysd2Zo4UMpN/4d4QKBzRgMPZtjwufTc
	 fmK1ZqrLN/XLDZ+/e9ZgON2hy26aOfYKk4RqkjqkX8norpOpooJye2aAw2HiDqS/bT
	 MrAY0+DGMJGzGzQwuTk70hFHq3OBD/sA4J770ZdoHd08yUXmMjjqkwA0PysJWJ78QY
	 EOaNXk8xZ7sTeC8mTNqyyjgdL+CfLjLtKaspea5fpf9zgJteTl7/zhC3rXCPqtT8cl
	 lTd2AMkgG/pHPTOgPwPbNxdGaFMXbitTvvLp39TQLdG4Tsh9GTJQqD4yQMT9XxfCH7
	 byTmYwMD6YDbA==
Date: Mon, 18 May 2026 08:29:07 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
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
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/69] mm/mm_init: Defer sparse_init() until after
 zone initialization
Message-ID: <agqxs2-EQ06mFKun@localhost.localdomain>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-9-songmuchun@bytedance.com>
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
In-Reply-To: <20260513130542.35604-9-songmuchun@bytedance.com>

On Wed, May 13, 2026 at 09:04:36PM +0800, Muchun Song wrote:
>  void __init mm_core_init_early(void)
>  {
> +	int nid;
> +
>  	hugetlb_cma_reserve();
>  	hugetlb_bootmem_alloc();
>  
>  	free_area_init();
> +
> +	sparse_init();
> +	for_each_node_state(nid, N_MEMORY)
> +		sparse_vmemmap_init_nid_late(nid);

Would it not make more sense to hide sparse_vmemmap_init_nid_late()
within sparse_init() and have it called at the end of the function?

The flow would be:

 sparse_init()
  sparse_init_nid
   sparse_vmemmap_init_nid_early
   ...
  sparse_vmemmap_init_nid_late

I think it is better to have sparse stuff all together in one place instead of scattered.

 

-- 
Oscar Salvador
SUSE Labs

