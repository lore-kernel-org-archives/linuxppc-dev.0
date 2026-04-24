Return-Path: <linuxppc-dev+bounces-20044-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B333BFB44C4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 07:51:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g24t01tpXz2xwH;
	Fri, 24 Apr 2026 17:51:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.170
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777017112;
	cv=none; b=I1uy7KPhJekxv3kfBJ2M3YWNO4QBFpZwthlsmNWZtPqhK385A6q7b9XDm0ocJz+BnxJH3ADg62e4LIolXVDtDn6AhuTTAkawHUv9K88hugFYQKYe5fSifd2ABN34yYf0bOPBxs5eC5RLNd1tzQNKX3xrnqoO/Klr9WzGJNyJwOETvj5hVXL/Dk80FoWUo990s/b+72b/2oGLvbDwJbPbyNN5Cv3n3jPzmoPr1HL8iTzyvm7bhf3FhTsQAVPiHmVZeXaWhXUXya3KdG+ecXiiT1R7hZGOcfBjOCj/jpij0Hq16UmlHiLBCg6/aDSD3G7N92X1SDPnw3+KyXkeEDfTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777017112; c=relaxed/relaxed;
	bh=/ORSaWnko0V3NhVqidFGTv7S6AWqSkqSLorMuOfpODA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jrebVs8vOhHcH5l4eDJ1R72dUCQ4UK/qpiaXG2Fb80RFzPcLoITd6or/kMk/Esj2a3j8TTaKMRA5xOjgf6Q80MLdmUu2NQr6aGajlLGppNXz+rZ4CSnWBgEt/xdwhqRTODvi6Y/XVk34FIvE4KBIW9e8VG1hLdZzijh93q8Zku1n/QQBNE4Tczwkra4PU63vJAJDI0bAslKNE1bHRHppEryj+9sPagZv1xCB1VQPG9sd8zcZbgp4PHypPiUa4Qml/iBlUfVCHjuZRlCtPLerf3z80XyDISSaUFViKfzgSPfcALuP/KmjkN/q+iVoAEOy3ktLfLxKl9avJ5jDYGriXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=f5sWadWI; dkim-atps=neutral; spf=pass (client-ip=95.215.58.170; helo=out-170.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=f5sWadWI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.170; helo=out-170.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g24sw3HZdz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 17:51:46 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777017086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ORSaWnko0V3NhVqidFGTv7S6AWqSkqSLorMuOfpODA=;
	b=f5sWadWIcXFWMoPuLXqfAVQq8XtQDNfCfsvXrl+tyhRViG3SQIamnGMCotuewbABJ9cFH4
	PYhz/HibwXyamvirz+mWtj2C3RPJ/RNlVHmjxhhppl13+g7APOW6R5fSkAUQgJxqYQ7tdZ
	DvCm6GbEn5PGd64kYmFnP3vBYTawe0o=
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
Date: Fri, 24 Apr 2026 15:48:44 +0800
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
Message-Id: <5A4644D9-B64E-4AD9-9D9A-B3DAB84CB827@linux.dev>
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
>> +     				    min(pages_per_compound, =
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
>=20

You are absolutely right. I misread it earlier. I mistakenly read
PAGES_PER_SUBSECTION as PAGES_PER_SECTION, which is why I still used
PAGES_PER_SECTION in v5. That was my mistake and obviously not what
you originally meant.

I completely agree with your suggestion to use two statements here,
as it makes the alignment requirements much clearer. I'll fix this in
the next version. Thanks for pointing this out!

Muchun,
Thanks.

>=20
> --=20
> Cheers,
>=20
> David



