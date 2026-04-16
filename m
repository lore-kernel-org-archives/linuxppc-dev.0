Return-Path: <linuxppc-dev+bounces-19790-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECB7F8D762
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 17:20:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxPsv2vjrz2yvR;
	Fri, 17 Apr 2026 03:20:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776360035;
	cv=none; b=bJunThPpz8VGxv81r6hK1TxaXt0KEJR7ByAQZDwe1E+XrxzViP7vMjGZrEO8j74EPvnVNb/d1MWZpxkiOGj2DEGcg4zirCOJuPZF7J8ifGXrZ8N67kgGbe013MSJYAIPxOx2p9OKQtunEpFY+hbqxyfHOhD82hwcUzV/de+bgq6dP/sQ1KCMUO02AJiT6pAzjeXoGar+2n4emR3eDgOhT8Ctvg2eZlZdkRZ6JjUjllPIOqLkFRpGr80qmr2Mg0L/OQDtESleS1qLlYkO5AdvkCqUvN+aYSqC+s+g6qTE73VV0SdJXTWCz0gC6j62A0aT9LHR1LLSA7wdaOMdjColFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776360035; c=relaxed/relaxed;
	bh=3Cchl2ciG8ibgB1rPnlhkHS4vZaPAV43vVXtK0kPCJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2ZlRIKGQkxKHKasfiJbc6gQANLWBP5uVg0BnvXvgxeEDDaTgEo6gVijIQfNHRHCg1iapF2EVn6Vjyh/xR7a8NIxWKDHi9wbCStiV2B7an+cA5DniYGLNxiUQDF2orJQ0xjcKhp5/kmdM9aOZpmswRdd4T0EVqArfbDtbuNgiWaVCCwQ5cGxcOp7Ks+G+oR+vSFy/KTH/Xh1gvLG3+mVlmJo/tGOeQvg6kwYfb4fbZmh3R/drMGKVQDo0Q0bv3hMZZL5np+8UBkHhDxaPBsDSRYoSO+jd/yWyWin9/dnaLCOynxB8YCEijAo8m38hZ+2yJkx2A3f0zXOddnqm0Px3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=M3ecFB82; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=M3ecFB82;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxPst3sY4z2ynP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 03:20:34 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2106E60126;
	Thu, 16 Apr 2026 17:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806B7C2BCAF;
	Thu, 16 Apr 2026 17:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360030;
	bh=OCe7lQtFBAOv6teYJrmVIk6YfRVI3M+lrX8dmNsXNaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3ecFB82gH2AD5sMovebRC3/MsJtyGt5ffGOEzSVt0ApVCTqDJHHxoWWexdFXUxcZ
	 MlcLb8i9c0jJtxIX4XSssFspPvdO2YQer4T/HHxU53xQGQTGYmf5MMOcQF+nwU2ax2
	 7VPr+k9B0NcrcPTj5dkhLf3MPw0Bg2lbSbtwTf22LrOipWXU6yKCDdP/TGkdO6Mdf2
	 AOqD1s2/QRzALtpxZx1sJh3KYHlenSO29NWleZ0I0ZVb8MD4otN1AOORvXT3kI55jC
	 gaby8PGuyOg4LMOqUCMsQosx9E3K93gvMw9J2JiaUqZysC1kGOu2XsFoIydtYz28XE
	 fMCw1ezVdYcwg==
Date: Thu, 16 Apr 2026 20:20:20 +0300
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
Subject: Re: [PATCH v2 6/6] mm/mm_init: Fix pageblock migratetype for
 ZONE_DEVICE compound pages
Message-ID: <aeEaVAfI-3mgJBgw@kernel.org>
References: <20260415111412.1003526-1-songmuchun@bytedance.com>
 <20260415111412.1003526-7-songmuchun@bytedance.com>
 <ad_EygHWDi19SS9y@kernel.org>
 <86523791-2C69-4A43-BD32-3713840A6640@linux.dev>
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
In-Reply-To: <86523791-2C69-4A43-BD32-3713840A6640@linux.dev>

On Thu, Apr 16, 2026 at 10:06:03AM +0800, Muchun Song wrote:
> 
> > On Apr 16, 2026, at 01:03, Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > Hi Muchun,
> > 
> > On Wed, Apr 15, 2026 at 07:14:12PM +0800, Muchun Song wrote:
> >> /*
> >>  * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
> >>  * directly to the driver page allocator which will set the page count
> >> @@ -1122,6 +1120,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
> >> 
> >> 	__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
> >> 
> >> + 	cond_resched();
> >> +
> > 
> > I don't think we want cond_resched() for every page here too, even it's a
> > compound page :)
> 
> I'll update it to every PAGES_PER_SECTION, does this make sense for you?
 
Sounds fine.

> Thanks,
> Muchun

-- 
Sincerely yours,
Mike.

