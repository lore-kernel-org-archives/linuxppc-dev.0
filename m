Return-Path: <linuxppc-dev+bounces-20094-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5933FF8850
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2026 03:06:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2ZVT4044z2xMY;
	Sat, 25 Apr 2026 13:06:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::ae"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777086401;
	cv=none; b=Ykprisz7yd/X+Vsk0WEcMf8hYWKKiGTdJ7jOvSNos4xuNidtwQ5jcK3gEYZe2yJwlWYQu/jVZobFZiQmLgkCkVTfanSgcTTpEDsu2LFXH9tyX0h/d0vfq8sQzS9yNo3hTAK9UNG924nrVamnvlICB2TqG2rvjvCgmmr4357YG+f/2C4AiAKoeQ7nCDamWX0rY+3Jp0LWnn+aWzsAXcu8ZBuaDUgc23yzajtekJC3GStvYendvS7IftQo3vpLLCo5vKzfqa0XNt1tdTowx5l1dRtLTnpByLTu/b5D/J0eIQeZhUq86/5q0z/cE9sxX8Ghpoy+jJMR4X+hxSEBIzARWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777086401; c=relaxed/relaxed;
	bh=LS6FCqD8VSXr924Q4YkPV/vRhy4BlRM8EbIWjkTCfxQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=h1aVkwFf7YakzicofiNDdSLJG0Hg1aUxM0mkJV44wWVs4kM7z/OX6Qf2UiwNRr/zW+EidT4ewwgTtAowq3934cIefbGYmnnVmc6R4g+6M6FhI8OZMKMWiAR3LAntRsIw7dp0vNKTM6s9UwdLfxf8U4nkil8JRN40wChQAgPaz1/9v18kqYqDQQDe3tXr9ev+q3qAB4Xg2mXTiU/yxXKCZcpId1UJlM01t0tVlaXqJ+X2eJFlLE/L7vjIkTbhkHDt/sz6/ku4IGW35cY+/RUjx/SIAZxYaOlFPMbnYRK9lPmDZd/cVt0X6jY+XPLbhT0VWuvnoeSpu+WRCd0QzroNOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=B19j9Sh9; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::ae; helo=out-174.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=B19j9Sh9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::ae; helo=out-174.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ae])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g2ZVQ13Qrz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2026 13:06:36 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777086376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LS6FCqD8VSXr924Q4YkPV/vRhy4BlRM8EbIWjkTCfxQ=;
	b=B19j9Sh9uoyXQoT2jp7I4pOlIjQZYabWyU3GKN59qbm6g12VJj3lhVYjDoCrWYP4/xTSij
	gLNZZdLCkzFGTjkwSlTZuOJUQWEfwwmKiZ0zKs6/nksrzMF/ZYksFvgyyNoBbjTnjk9Q+h
	W1DXvgmK08TwKJnZu+cKBozIo3rbYpQ=
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
Subject: Re: [PATCH v6 4/7] mm/sparse-vmemmap: Fix DAX vmemmap accounting with
 optimization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <0fe62163-cdfd-47e4-bc88-df7a69dc5a6d@kernel.org>
Date: Sat, 25 Apr 2026 11:05:38 +0800
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
Message-Id: <4C6CE53F-918C-4D03-9DBD-1745E28A2D9E@linux.dev>
References: <20260424025547.3806072-1-songmuchun@bytedance.com>
 <20260424025547.3806072-5-songmuchun@bytedance.com>
 <0fe62163-cdfd-47e4-bc88-df7a69dc5a6d@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 24, 2026, at 15:33, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 4/24/26 04:55, Muchun Song wrote:
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
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> Acked-by: Oscar Salvador <osalvador@suse.de>
>> ---
>> mm/sparse-vmemmap.c | 31 +++++++++++++++++++++++++++----
>> 1 file changed, 27 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>> index 3340f6d30b01..2e642c5ff3f2 100644
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>> @@ -652,6 +652,28 @@ void offline_mem_sections(unsigned long =
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
>> + 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages,
>> +    			min(pages_per_compound, =
PAGES_PER_SECTION)));
>=20
> FWIW, I though the right thing to do here would be:
>=20
> VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_compound);
> VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION);
>=20
> I don't really see how PAGES_PER_SECTION make sense given that
> PAGES_PER_SUBSECTION are the smallest granularity we allow =
adding/removing.
>=20
> Also, the "min()" implies that there is a connection between both =
properties,
> but there isn't to that degree.
>=20
> If order =3D=3D 0, then you'd only ever check alignment for ... 1, not
> PAGES_PER_SUBSECTION, which already looks weird.
>=20
> So you really want to check "max(pages_per_compound, =
PAGES_PER_SUBSECTION)", but
> just having two statements is clearer.
>=20
> Or am I getting something very wrong here? :)

Hi David,

Sorry, I missed the 1GB hugepage scenario earlier. Given that =
sparse_add_section()
operates on a scale between PAGES_PER_SUBSECTION and PAGES_PER_SECTION, =
the pfn and
nr_pages parameters wouldn't be aligned with the hugepage size =
(pages_per_compound),
but rather with the PAGES_PER_SECTION boundary. Do you think this =
explanation makes
it clearer? In the interest of code clarity, do you think the =
modification below
makes it easier to follow?

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 2e642c5ff3f2..ce675c5fb94d 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -658,15 +658,18 @@ static int __meminit =
section_nr_vmemmap_pages(unsigned long pfn, unsigned long n
        const unsigned int order =3D pgmap ? pgmap->vmemmap_shift : 0;
        const unsigned long pages_per_compound =3D 1UL << order;

-       VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages,
-                                   min(pages_per_compound, =
PAGES_PER_SECTION)));
+       VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, =
PAGES_PER_SUBSECTION));
        VM_WARN_ON_ONCE(pfn_to_section_nr(pfn) !=3D =
pfn_to_section_nr(pfn + nr_pages - 1));

        if (!vmemmap_can_optimize(altmap, pgmap))
                return DIV_ROUND_UP(nr_pages * sizeof(struct page), =
PAGE_SIZE);

-       if (order < PFN_SECTION_SHIFT)
+       if (order < PFN_SECTION_SHIFT) {
+               VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, =
pages_per_compound));
                return VMEMMAP_RESERVE_NR * nr_pages / =
pages_per_compound;
+       }
+
+       VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));

        if (IS_ALIGNED(pfn, pages_per_compound))
                return VMEMMAP_RESERVE_NR;

Thanks.

>=20
>=20
> --=20
> Cheers,
>=20
> David


