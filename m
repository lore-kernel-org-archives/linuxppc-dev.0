Return-Path: <linuxppc-dev+bounces-20006-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50688F9937D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 12:05:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1ZYC5q6nz2yGX;
	Thu, 23 Apr 2026 22:05:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.177
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776945935;
	cv=none; b=cWWsbT/GlJ46ytxvQ4fDnnNVXDdLxlySHzUw/gCURzhn/j8xGxjZvxhmhh8fQ2BROYPJSVTKCByhIi+evNuEpx1Awh1e9lol8wAv5UlKJxcVpbtxKJ/vC3TbVH8JKk4hzveM8BlOdxDXMpJ/WAheOXIbS2oR/GPoX4+vGpr0C0v0z8Alm5un/S8iCdV2ZawTJ5LEQlJLOxp5PoUobeBh0QuyqBz77xcjANDG+CUPVO8T7Vo+XueSeVARacXUDhq459dS1jqj7I/ybGt+1AjCEsvmKBaez4QX30HkFPYp+sGnOGyPviTDK23bBjV9vf4QBYJu2cMTeqFDGwVIvbx1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776945935; c=relaxed/relaxed;
	bh=r2ijiexG6FD3eVhJKFQEv8cSP6rYZ0EZ6ENNdT32YGY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fQGJm6Gz2NI5ailiMeDtezqyspcduZBWan6zZ71Eo7NiK5lIBfd65DYBhpvsH9sDtPXDgzNoltLObyFgBP2JI2I2819reCFs0CwEvTMxItMMBHw9vDlv7gRGXSVkUoh98tbFSuksOZpF9hTnwXOzlQSv0KDNs9ViQo9xm80x3MMt0t+sL9mhZBjSapDrmHp/4hEWY5JUs9G9abX6FaIjWETagvvnM65AaZa7zGz+VuWEGJNZAb9dk9MljVKNJZAcrkb/yIYgPgVLwWcwf5DJJEBmPiIZwM1P2l4nW+PjHGM/Kp2LeFgjXm7mnAnKQSNB/wZ7RaBvN2cE6Q2PIEHouQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=loE9WOAK; dkim-atps=neutral; spf=pass (client-ip=91.218.175.177; helo=out-177.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=loE9WOAK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.177; helo=out-177.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1ZY45n3qz2yFc
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 22:05:27 +1000 (AEST)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776945907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2ijiexG6FD3eVhJKFQEv8cSP6rYZ0EZ6ENNdT32YGY=;
	b=loE9WOAKvvpSicNxVCnhTWQ4U0StHn5NBmnVSl5HthVRJaAX8DQNdOjl3sOEec+wJmyBYR
	1I3Zw2WfbSOPvDxPo108yOvJgV+wKg5hjlhLbbMfR3YdbIw5ptwEft6Vu75oO/LqQ7QLk6
	GK737O+gWWCesjjYSz+fM9tScT+YnzI=
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
Subject: Re: [PATCH v5 v5 4/6] mm/sparse-vmemmap: Fix DAX vmemmap accounting
 with optimization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <1cbae635-a115-4270-bae2-64145d16f936@kernel.org>
Date: Thu, 23 Apr 2026 20:04:21 +0800
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
Message-Id: <1ADE7CE5-F02D-42B2-B7AC-FE0D6E86042D@linux.dev>
References: <20260423071911.1962859-1-songmuchun@bytedance.com>
 <20260423071911.1962859-5-songmuchun@bytedance.com>
 <1cbae635-a115-4270-bae2-64145d16f936@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 23, 2026, at 18:40, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 4/23/26 09:19, Muchun Song wrote:
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
>> mm/sparse-vmemmap.c | 31 +++++++++++++++++++++++++++----
>> 1 file changed, 27 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>> index 3340f6d30b01..979d71158c9b 100644
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>> @@ -652,6 +652,28 @@ void offline_mem_sections(unsigned long =
start_pfn, unsigned long end_pfn)
>> }
>> }
>>=20
>> +static int __meminit section_nr_vmemmap_pages(unsigned long pfn, =
unsigned long nr_pages,
>> +	struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
>> +{
>> + 	const unsigned int order =3D pgmap ? pgmap->vmemmap_shift : 0;
>> + 	const unsigned long pages_per_compound =3D 1UL << order;
>> +
>> + 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, =
pages_per_compound));
>> + 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
>=20
> Thinking about the PAGES_PER_SECTION, can't we get called for =
sub-sections?

Oh, I see. My apologies=E2=80=94I just remembered why I took the minimum =
of
pages_per_compound and PAGES_PER_SECTION in the previous version v4:
it was specifically to support subsections.

In the last version, when I was addressing your suggestions/questions,
I forgot about this underlying logic and simplified it to two lines.
Of course, that=E2=80=99s on me, not you.

Ah, looks like I need to update the patch to fix this.

Muchun,
Thanks.

>=20
> --=20
> Cheers,
>=20
> David



