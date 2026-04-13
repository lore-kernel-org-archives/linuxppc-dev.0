Return-Path: <linuxppc-dev+bounces-19713-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B1CF34C78
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 17:20:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvZ162BdPz2yvS;
	Tue, 14 Apr 2026 03:20:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776100826;
	cv=none; b=BYktH2fqCqCHJkP7DTtPUTksU/S/0MuEy2QdkiBQ0E/VBtYHf53BTmIs0jNtiEYqOsDZT4Oascy5nzC5y9zTt2ZooS+xo8whG0Tq6tJ7M2YT0ZnY7dadxyLALgWP+U9GK0FR2BKbeN866JRENtcHmoXizgZ8X6HVnDLfLjHhVwUAZcnZ5jlxGn3gwq6TgmHo8Ibu88sytydSLrLGEaE/hnMpDtOM37PhETrojbD0igv1NikDHNUSTM5FGZZTKaxtJ7LyDt9EExEny0w1Yg/pZkRXeivX7KNuF4/l/YiH93W08KGF7cELtMNb1YmYOlXnbizvc1G6ekL6EFoVpe+9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776100826; c=relaxed/relaxed;
	bh=6xzqNTZU5rW5X/KJ7dZ0k/+iqwPV8kTHwUdRhXs2I3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0GPUF5/kCqoErQJnohty2MW00iTcMJzxMTFi8UORajfkpOFJW+VXTjZsyAHZXovXhPziUCSnFqtRVPp2qcf6sThR63/WJLpaTmqwP75HrNq/4zqQTgO/i2IdFDTewic5wi/+n/wXk6+4USt3OszBTXZIWEoTDFqNj3SKwhPf9Mx+8TN9XC6yPbozG0V+MLMkQ8MQr4lb6Jir5n4gop1FYMGdIYIoHmsk6oDpzS/+QsGNmAVCqRpDfla3MpVC2SK72UMkmXTFciuo2PNTpQtNiLNUJ8heeLIomtbWB/w72NynWh5WDv+zx480RIHOV+g4znWKBoS1YO+WiCIxhmOHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EF338F78; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EF338F78;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvZ152Bpbz2yv4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 03:20:25 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 726016183B;
	Mon, 13 Apr 2026 17:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD74C2BCB0;
	Mon, 13 Apr 2026 17:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776100817;
	bh=8c7V38SjK4hMjN4VLoVwMlqjL2MnquDxEbG/Q9cUQfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EF338F78QTuHgoJy8BYFIqHIHuMOS7IvI+KpVJdIq5DJt08ZKKW5ojcKBSqziV0LO
	 7odSFMS3yPcPUZpqvCVxvWTxuKuOs8q1B+/yCUbOl+HGWkNiJEITAtyK57z+sDLxIa
	 2HS5VaBo0FO/vMGzM7ipr7diKa0CG9ei7DVD/mCwPaEBTknm0NPA3gpUe91TY02eUH
	 fet15Ow7PqmtN0VT6hQ04ed0RK8KfT+U7BikPEX9ivE8Q1QwQdGkx+Qf5cwpwi4Ng/
	 xK/1oCPstSEbYi/NOFu+HI+lMho0VU3/YQnYwzBPoal+G1JXSlEQbv+0u8Dc1JkYE7
	 S8n1mTyfgsBtA==
Date: Mon, 13 Apr 2026 20:20:07 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Liam R Howlett <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/49] mm/sparse: fix vmemmap accounting imbalance on
 memory hotplug error
Message-ID: <ad0lx4jI0E2OZoAX@kernel.org>
References: <9642F4D9-8F1B-47A4-90BE-C72BB8DE9A11@linux.dev>
 <48CF5603-D8E1-4C86-8554-E8BA03D195FB@linux.dev>
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
In-Reply-To: <48CF5603-D8E1-4C86-8554-E8BA03D195FB@linux.dev>

On Mon, Apr 13, 2026 at 10:16:20PM +0800, Muchun Song wrote:
> >> +++ b/mm/sparse-vmemmap.c
> >> @@ -656,7 +656,13 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
> >>       unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
> >>       struct dev_pagemap *pgmap)
> >> {
> >> -    return __populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
> >> +    struct page *p = __populate_section_memmap(pfn, nr_pages, nid, altmap,
> >> +                           pgmap);
> >> +
> >> +    if (p)
> >> +        memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
> > 
> > We don’t increase the counter on failure, then
> > 
> >> +
> >> +    return p;
> >> }
> >> 
> >> static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
> >> @@ -826,7 +832,6 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
> >>       section_deactivate(pfn, nr_pages, altmap);
> > 
> > here section_deactivate() is called, which decrease the counter unconditionally,
> > the issue still exists. We didn't fix anything.

You are right, I missed it :/

> >>       return ERR_PTR(-ENOMEM);
> >>   }
> >> -    memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
> >> 
> >>   return memmap;
> >> }
> >> 
> >> 
> >> Then we'll better follow "all or nothing" principle and won't have
> >> exceptional cases in section_deactivate().
> 
> To follow  "all or nothing" principle here, I think we should not call
> section_deactivate() to do the cleanup in section_activate().
> 
> After all, if section_activate() didn't succeed, how can we use
> section_deactivate() to release the resources? What do you think?

Yeah, if we could pull "upopulate" from section_deactivate() that would be
great.
 
> Thanks.

-- 
Sincerely yours,
Mike.

