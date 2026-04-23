Return-Path: <linuxppc-dev+bounces-19985-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BEBFAD3EE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 02:18:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1KWb74xYz2ygh;
	Thu, 23 Apr 2026 12:18:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.184
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776910699;
	cv=none; b=SzJtB8J2Ak/ViKtdVKOdt91fRWxvCUNtAF3/NbuCJhwbJ8HsGCC25WcRRgFCvyLI9xuqSx/a+Rj3zNJjOwzT4Uhofre3h7cVdnvaMkOtD43IMEobdB4gA0wRze99jfB1JdAywSXd3P9D3cUpfVVdcMnIAVpCQ0rpI70uSt1HgKXtRYc9JIWWsFhRnVkEdHlx9HEW2890Ymb7UWCXAZ77Xmy+iOcTvfSGZ0cpFuwLn+sIyjnPHvuih1rg7cJ4L5XD3+rtbFJWnuYcnliLDCg5UB6RyL9/iA2GKJ1WaRXguGJ9ZYEx74spnP2pfJy2kkNA24UoT5WfAAivWa0RbjsfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776910699; c=relaxed/relaxed;
	bh=3Yl5gpUQ0/kTVgZbIhUE9Yavdt5ZXUQjjozCVUL0yP0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=c3wgtn03+vtNjW0Joln4SFmxgbKeOugE8oBQ1GX39nGAfCU8hHZNx4PmX2ag4U64Z1tQ7CsEk4wOANHzfgDv56eTQvclWu+8RbhV1+bncdH3jERqZj7tEho/yS6Wlww8kGkH95SZMtzZU8KgvO6klYCSH2NcPHLdPcelIdavaIFGPIDvILxnEqQ9rk2Z8Lf/R+gjivYZvsKgS9HwEjCiZBrOb2ZpqTch2m2/T5kgfICttwVxOlkQSlIMAgvGH+ddiLNccMdjoBLbiyFQ15Pt7uj7iY0REsJSq7zAQGwzpBbNXj6xKmbtJ8Y9w+Xbdve7y8xXM+OxjbS9F0DiQRPuUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=b/EJECuf; dkim-atps=neutral; spf=pass (client-ip=91.218.175.184; helo=out-184.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=b/EJECuf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.184; helo=out-184.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1KWZ1Qlhz2xpg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 12:18:17 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776910673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Yl5gpUQ0/kTVgZbIhUE9Yavdt5ZXUQjjozCVUL0yP0=;
	b=b/EJECufayhtxajGQW4PznJfjd7sYzCSDHtMjXb2b8xNQSB1pU5qntYRvYaX0WZNC63JrE
	O+KFyPV20HrCEnMWvxGFL+u8VCcDINItPeNU7rqIl7g4xlnosoVzWu7KsxjBRGlYxtxrJk
	l/rl3vDAnT0rDM96adD7Mwz440krZ24=
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
Subject: Re: [PATCH v4 3/5] mm/sparse-vmemmap: Fix DAX vmemmap accounting with
 optimization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <168f3ddd-de39-4896-a334-23a6fb8959e8@kernel.org>
Date: Thu, 23 Apr 2026 10:17:08 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
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
Message-Id: <454BB596-DC35-4773-844C-4B32ABEEF423@linux.dev>
References: <20260422081420.4009847-1-songmuchun@bytedance.com>
 <20260422081420.4009847-4-songmuchun@bytedance.com>
 <168f3ddd-de39-4896-a334-23a6fb8959e8@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 23, 2026, at 02:53, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 4/22/26 10:14, Muchun Song wrote:
>> When vmemmap optimization is enabled for DAX, the nr_memmap_pages
>> counter in /proc/vmstat is incorrect. The current code always =
accounts
>> for the full, non-optimized vmemmap size, but vmemmap optimization
>> reduces the actual number of vmemmap pages by reusing tail pages. =
This
>> causes the system to overcount vmemmap usage, leading to inaccurate
>> page statistics in /proc/vmstat.
>>=20
>> Fix this by introducing section_vmemmap_pages(), which returns the =
exact
>> vmemmap page count for a given pfn range based on whether =
optimization
>> is in effect.
>>=20
>> Fixes: 15995a352474 ("mm: report per-page metadata information")
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> Acked-by: Oscar Salvador <osalvador@suse.de>
>> ---
>> mm/sparse-vmemmap.c | 32 ++++++++++++++++++++++++++++----
>> 1 file changed, 28 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>> index c208187a4b00..fcc5e0eda9e7 100644
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>> @@ -652,6 +652,29 @@ void offline_mem_sections(unsigned long =
start_pfn, unsigned long end_pfn)
>> }
>> }
>>=20
>> +static int __meminit section_vmemmap_pages(unsigned long pfn, =
unsigned long nr_pages,
>=20
> I'd have called this "section_nr_vmemmap_pages"

No problem.

>=20
>> +    struct vmem_altmap *altmap,
>> +    struct dev_pagemap *pgmap)
>=20
> Two-tab indent.

OK.

>=20
>> +{
>> + unsigned int order =3D pgmap ? pgmap->vmemmap_shift : 0;
>> + unsigned long pages_per_compound =3D 1L << order;
>=20
> 1UL
>=20
> Both can be const.

Right.

>=20
>> +
>> + VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, min(pages_per_compound,
>> + PAGES_PER_SECTION)));
>=20
> Maybe simply
>=20
> VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_compound));
> VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
>=20
> Which is more readable?

That's also quite good.

>=20
>=20
>> + 	VM_WARN_ON_ONCE(pfn_to_section_nr(pfn) !=3D =
pfn_to_section_nr(pfn + nr_pages - 1));
>> +
>> + 	if (!vmemmap_can_optimize(altmap, pgmap))
>> + 		return DIV_ROUND_UP(nr_pages * sizeof(struct page), =
PAGE_SIZE);
>> +
>> + 	if (order < PFN_SECTION_SHIFT)
>> + 		return VMEMMAP_RESERVE_NR * nr_pages / =
pages_per_compound;
>> +
>> + 	if (IS_ALIGNED(pfn, pages_per_compound))
>> + 		return VMEMMAP_RESERVE_NR;
>> +
>=20
> I'll have to trust you on these ones :)

Thanks for your trust.

Thanks,
Muchun.

>=20
>> + return 0;
>> +}
>=20
> --=20
> Cheers,
>=20
> David



