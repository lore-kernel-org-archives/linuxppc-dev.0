Return-Path: <linuxppc-dev+bounces-19674-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAB8EBFD25
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 09:41:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvMqB6s2lz2yrZ;
	Mon, 13 Apr 2026 19:41:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776073270;
	cv=none; b=edelUmhH3gCcZnkHPsPjCw89SFeIphEfsUk5cipIyRZIbvoZvk0ak7iLwkgwO+KnZwUMFIHmXFS6Wf2xDco+4F5UBu+W5L9JUf87/lKmFPhrGCdUXg0uq3JtfiUM8lpIlPVj40FQdUXu/HM+ANOzjQRQF2w2iRalVTC7oTVEkQ0B+n2DQTjPKRpiSJkxUI615V7QFtnmsQ5wEJdBYnkHHBslLNaHAKQEKpDnXEF/x/FNa/cblEmxwbDp0es6GujmtoIucjutaOnPyblwv1AevcXLtazLNS1EVIEB59rHOkfiUis+JsRLluQpiNgEyTQb22AR5jAM91MnKB7gU2D4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776073270; c=relaxed/relaxed;
	bh=HcO6/QfKAu0DTmfugiYQtRwzqYA++77qyzPrn2G+5T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaFNXENFPgbIb27qlBHbNeYcNlVWSxYaE7E7WzwOJfNiNCtM1iqXoFLZ5Q4UAi3hT7C1rnG2hEQIUcv6oqKRq5MkAAngw/riMK4/rptlCFhDTSAyR9UghnAptfqItc1tRJhhnq711n90LhA4c1lD5ZxUEXD1Gh417K1W3TrzfAgYXsB/zSF0Cq9qHr88eWfO4nkC70j3kEVMnG/lFzB26DT9b/z1hmucRXfldAX5FTJTnDWzhzDdhZYklu5C5jn/BNaabiqrhiLpvDnu97IjtR6+ixOWnUYJhNK7wWhHBe0+Uc9cFTN5aD1uuAWjR+URR8QoQCfZwmxwGdYWEVs/xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qWKsep3y; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qWKsep3y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvMqB1yJKz2ypk
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 19:41:10 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DBCA860172;
	Mon, 13 Apr 2026 09:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33759C116C6;
	Mon, 13 Apr 2026 09:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776073267;
	bh=15mXvkUYQgJAvkQm0f6FRT2CeMc/vq5I5XkJLJOtNHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWKsep3yhyC5OZY4c+RkYC2c5tuujLQjp+iqv9tAR1BDW2etraJf4G/6+SD0kF6+/
	 wF4e/Z853fweqHX5i56rpeYAybM5oiNC4WLkKDyReRbLOh/3QVb6o4pYvE9/n4kNFk
	 ELmY8lYuK2RhnRYx6ehVcKIeIaCaGstHQks5waLkEdoS5iN1v125zdK+hWIJKPtnU9
	 pJbObV7BirRct5NzbkJay22gMBz7Yl3UnTCVXkVihr3OlGMf/S6jdXtMZw48ofMphH
	 SsKPoysQZ+NhyjZR2uPr9mhKCsC8pyJ2WVepL8YSW7hZgZryYWr/HDwjIy19pO2VQU
	 W87h6zbr84q7w==
Date: Mon, 13 Apr 2026 12:40:58 +0300
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
Subject: Re: [PATCH 07/49] mm/mm_init: use pageblock_migratetype_init_range()
 in deferred_free_pages()
Message-ID: <ady6Ktxok_I73nun@kernel.org>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-8-songmuchun@bytedance.com>
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
In-Reply-To: <20260405125240.2558577-8-songmuchun@bytedance.com>

On Sun, Apr 05, 2026 at 08:51:58PM +0800, Muchun Song wrote:
> Simplify deferred_free_pages by replacing the duplicate loops for
> initializing pageblock migratetype with a call to
> pageblock_migratetype_init_range to simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/mm_init.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
 
-- 
Sincerely yours,
Mike.

