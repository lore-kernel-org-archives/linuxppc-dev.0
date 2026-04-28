Return-Path: <linuxppc-dev+bounces-20202-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E18FF8867
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 02:22:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4PNd3qC1z2yqt;
	Tue, 28 Apr 2026 12:22:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.177
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777342977;
	cv=none; b=UB17H9v8deLSbKbw8oWEY8jiFmUIRmJSGvdnZzCRmMg1df82QYOuc9cIy0gir0Hez4XOpLUVdyIWNsp+08YZ+hePF1L1VmliCsBIN0klBkKyJx8/kp7fDuh5+NZqgngd+//sINAjNLvqijoNLPnXq/ladBXC52XKAuTYDQSgV68NbJq+vbETo43ELClOasFneNqK/aFxzwJ7MWt3y58XeN495d4xDpMzjOa6MDqd33Yeo5qDfyLIcliXnKAQh3M1i7QENMkOZo/EVJVfWL0WNTIvgMIOrRt+mnczPNOMAtaN2P1b7b9R+JJdaMLgyn4D+sCrRnizUti/byy4U4KPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777342977; c=relaxed/relaxed;
	bh=P8WtTpk4C3bWW2J9TtLvfZiG0OAM5aNmX37Zh2TBXyQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LcnTmiNjm+LghmMojjS0+ZditLKsHiCHnb9roup9FylYGz3Oba6OYh8pF+Hba0rigMh367iTyjYxs4giO726hZKt2dLkI+q6h+lH/LH2+Sv819uWCbkQb50qIlkos5TtlBXDw4wMSEKwxGH5qTrveDxhozoIxu0H3exWPVwMhA9oE1Swhuub/JA/ltC8OiWllvD/r2Tv7prn+9mEjSU7eFCrWaxJoPWkB5En+XLsH6bbkhWkqpdx/GHwiphzz8LmFIuyXxROPxrCr7zGfTg7fhUJaRqEy0uW+tpmZWY9zY2y2D9hAfUjEE7HyDbS2MK/0INWU+xXif/U0KJV8ORiMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DG0Bm5RX; dkim-atps=neutral; spf=pass (client-ip=91.218.175.177; helo=out-177.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DG0Bm5RX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.177; helo=out-177.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4PNY0YZ0z2ySj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 12:22:51 +1000 (AEST)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777342949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8WtTpk4C3bWW2J9TtLvfZiG0OAM5aNmX37Zh2TBXyQ=;
	b=DG0Bm5RXG0phliP9NHTpaSQiK2iNYYaMZjv8TQBv0NlXK+ehAEvDcUdk7LHI76DtXY4HnQ
	HAYjVIC+RR/KyTT84e0oVBYM3KSE2+z7RJHoNOxVzmN3xgqRSdR2k6yS0V3a3uvmt0KN7O
	qC7UG0CAXh1M6qThDTOdenB3pKZWZwM=
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
Subject: Re: [PATCH v7 4/6] mm/sparse-vmemmap: Fix DAX vmemmap accounting with
 optimization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <09298afa-9a36-4f29-a8e1-d4750c338df2@kernel.org>
Date: Tue, 28 Apr 2026 10:21:47 +0800
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
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C2E99AB4-CC47-4D9F-BF56-F971FD5A3C26@linux.dev>
References: <20260426092640.375967-1-songmuchun@bytedance.com>
 <20260426092640.375967-5-songmuchun@bytedance.com>
 <09298afa-9a36-4f29-a8e1-d4750c338df2@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 27, 2026, at 18:17, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 4/26/26 11:26, Muchun Song wrote:
>> When vmemmap optimization is enabled for DAX, the nr_memmap_pages
>> counter in /proc/vmstat is incorrect. The current code always =
accounts
>> for the full, non-optimized vmemmap size, but vmemmap optimization
>> reduces the actual number of vmemmap pages by reusing tail pages. =
This
>> causes the system to overcount vmemmap usage, leading to inaccurate
>> page statistics in /proc/vmstat.
>>=20
>> Fix this by introducing section_nr_vmemmap_pages(), which returns the =
exact
>> vmemmap page count for a given pfn range based on whether =
optimization
>> is in effect.
>>=20
>> Fixes: 15995a352474 ("mm: report per-page metadata information")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> Acked-by: Oscar Salvador <osalvador@suse.de>
>> ---
>> v6 -> v7:
>> - Refine the alignment assertions in section_nr_vmemmap_pages().
>> ---
>> mm/sparse-vmemmap.c | 34 ++++++++++++++++++++++++++++++----
>> 1 file changed, 30 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>> index 3340f6d30b01..01f448607bad 100644
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>> @@ -652,6 +652,31 @@ void offline_mem_sections(unsigned long =
start_pfn, unsigned long end_pfn)
>> }
>> }
>>=20
>> +static int __meminit section_nr_vmemmap_pages(unsigned long pfn, =
unsigned long nr_pages,
>> + 		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
>> +{
>> + 	const unsigned int order =3D pgmap ? pgmap->vmemmap_shift : 0;
>> + 	const unsigned long pages_per_compound =3D 1UL << order;
>> +
>> + 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, =
PAGES_PER_SUBSECTION));
>> +
>> + 	if (!vmemmap_can_optimize(altmap, pgmap))
>> + 		return DIV_ROUND_UP(nr_pages * sizeof(struct page), =
PAGE_SIZE);
>> +
>> + 	if (order < PFN_SECTION_SHIFT) {
>> + 		VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, =
pages_per_compound));
>> + 		return VMEMMAP_RESERVE_NR * nr_pages / =
pages_per_compound;
>> + 	}
>> +
>> + 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
>> + 	VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
>=20
> I would just have done that at the very top, as this check applies to =
all cases.

My initial reasoning was that the current formula holds for compound =
pages smaller
than the section size, and we only need to impose limits when the page =
size exceeds
it. While the current callers of section_nr_vmemmap_pages() don't pass =
sizes larger
than a section, this will change in the future (see [1]).

I might have been overthinking the future-proofing, which led to this =
specific
implementation. However, I=E2=80=99m inclined to keep it as is for now, =
as I'll be updating
that series [1] soon and it will involve further changes to =
section_nr_vmemmap_pages().
That said, I'd love to hear your thoughts before I proceed.

[1] =
https://lore.kernel.org/linux-mm/20260405125240.2558577-43-songmuchun@byte=
dance.com/


>=20
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks.

>=20
> --=20
> Cheers,
>=20
> David



