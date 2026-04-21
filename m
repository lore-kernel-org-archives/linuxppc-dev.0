Return-Path: <linuxppc-dev+bounces-19873-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB52F327CD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 09:32:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0HFn6Xmxz2ytx;
	Tue, 21 Apr 2026 19:32:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::ae"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776763965;
	cv=none; b=Fn27usUU7LDeOAEYlw9pwj2CZd07mXWKwV8hfNY0oYLyT/kpFUn49FmD2Wdn+yLnNlYUXH3e2awemNIgQ9/wUs6l4iYior70v+iccVFZ96h5ksynsQtVMdg+bUSibtQGEqr7ztWChsFIjcb+mkhM4UVoYe2OSJUJu3ZWjmaZaERGJhRrv658XMxQz9SYXpVjLm7JWsEIF1SOQFHi3PBAdahd8VoYWCptECFyO0cTVXUjiNh/ECdJ+a6d1wCyJrj7YNY0Ds09CQM0OiBdAEakrjwBQGVn7PGNu8ecwUchnf2mLVlCuggLBUm3Dy8dJsYC0MIulGpGR8D88JxveGKxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776763965; c=relaxed/relaxed;
	bh=H7VXEbbN0/EFAsyspDHjyOjj9f+YNV767eZ9TvCWrBw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QL9TSwXpcXPSMOTKQNgIperiVv5dP0ICqmvV5/uZmbIp1XGk9zfehzxZC1qFIfU3SdM3jH8nsW4t/eazqfpRJTdwFoxr7YxIgaREsmSJg7OtNsx1eREDeJ3WlYbjWFqqTlRDuDYQGkdzTMzPO4kTPH0fBtMyp7F1kgV/iskB/iEy6u+PZC71RKRLx4Dclu5OxAtzCgbNxPCthuioOQ6TcTksIOKWZ36jDkDHO4KyzCYFs1f1xPWdYWB8dP85YYQV/ngfB+cSEc+XZ12hOxReKEUvUa817/LtsNGHsiGASv1dLj+dxvlOrKONw5w64i08CKUgsnw2GUK9OIsSTEZuzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bF6yocuu; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::ae; helo=out-174.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bF6yocuu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::ae; helo=out-174.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ae])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0HFk2D1tz2ypk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 19:32:41 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776763936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7VXEbbN0/EFAsyspDHjyOjj9f+YNV767eZ9TvCWrBw=;
	b=bF6yocuuZ5+0H8Fj7WvzL919cWKgFPNL8PdSdWurzXEOJq1H1pY/1J/qvHbN+HJ1tcyOns
	0TRyXPw7yhE8WRPiIeS845fY2+SuhVVLrT/9htCQjcZl2S2MUjm4PP27xLcp0mCQOqZcFn
	wLmMzaDq8QJtPO4YC1f8nb4g+n+Pv4E=
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v3 4/4] mm/mm_init: Fix pageblock migratetype for
 ZONE_DEVICE compound pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260421022044.1217503-5-songmuchun@bytedance.com>
Date: Tue, 21 Apr 2026 17:31:36 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mike Rapoport <rppt@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <67CABBD2-FA75-40D0-909D-9B6A523CCC8C@linux.dev>
References: <20260421022044.1217503-1-songmuchun@bytedance.com>
 <20260421022044.1217503-5-songmuchun@bytedance.com>
To: Muchun Song <songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Apr 21, 2026, at 10:20, Muchun Song <songmuchun@bytedance.com> =
wrote:
>=20
> The memmap_init_zone_device() function only initializes the =
migratetype
> of the first pageblock of a compound page. If the compound page size
> exceeds pageblock_nr_pages (e.g., 1GB hugepages with 2MB pageblocks),
> subsequent pageblocks in the compound page remain uninitialized.
>=20
> Move the migratetype initialization out of __init_zone_device_page()
> and into a separate pageblock_migratetype_init_range() function. This
> iterates over the entire PFN range of the memory, ensuring that all
> pageblocks are correctly initialized.
>=20
> Fixes: c4386bd8ee3a ("mm/memremap: add ZONE_DEVICE support for =
compound pages")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
> mm/mm_init.c | 43 ++++++++++++++++++++++++++++---------------
> 1 file changed, 28 insertions(+), 15 deletions(-)
>=20
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index f9f8e1af921c..e2d8eae23aa3 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -674,6 +674,19 @@ static inline void fixup_hashdist(void)
> static inline void fixup_hashdist(void) {}
> #endif /* CONFIG_NUMA */
>=20
> +static __meminit void pageblock_migratetype_init_range(unsigned long =
pfn,
> +       unsigned long nr_pages,
> +       int migratetype)
> +{
> + 	unsigned long end =3D pfn + nr_pages;
> +
> + 	for (pfn =3D pageblock_align(pfn); pfn < end; pfn +=3D =
pageblock_nr_pages) {
> + 		init_pageblock_migratetype(pfn_to_page(pfn), =
migratetype, false);
> + 		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
> + 			cond_resched();
> + 	}
> +}

I found a positive comment from AI review:

This trigger a -Wunused-function warning when CONFIG_ZONE_DEVICE is
disabled.

I'll fix it in the next version.

Thanks.


