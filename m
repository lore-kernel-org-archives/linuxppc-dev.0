Return-Path: <linuxppc-dev+bounces-19722-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29137F531E7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2026 02:34:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvpJP3zhYz2ypY;
	Tue, 14 Apr 2026 12:34:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776134069;
	cv=none; b=M5nq69wn8XLAk4T8rVT08b0CM5UZCTAzvffIKtQpL4b+HzFq5GNg53z6B8Xyp6+vSYD8Tka/+uL+4Wq7UVstrOG6NN/QCxNll8D0GSPdminsU+B7ib0WiH9Tsts8goC6Y4/4dVJi8w8s8K9UY2SreaRqxJK9taWotXpuPQmTRc0gbcWwV5I5c2mO3bMCE1U+Xnct522pUrifthrdBo+2zEaZO80Ta4D+hbOr1Co4r8v2Ett+5Exjzp7w6i0Q84dbUHI55WJ8LP+TZZdXwTN6RU+IgCOLc34fEtHcdr/axy8qynn+TuH+WwdtdS63z6rBAID+5+LvDigZCprHSg3YQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776134069; c=relaxed/relaxed;
	bh=vw6s/HiBgFDsTXtMvscroT4fKbZCyCeW0iTze1OcKV8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nTKkSFFGw78P4rq7JGA5VmNlNaEKRKVTGQe3UQcz39DgAmvnDylZqTWeNDChgfL1gBhcZFhX0P14Tf8k9hOWCQGBh6009O2n0RN0CI3kXw33gth8qvMl94zRVUXKmV4M5lZMRDMgCc6bGxNPwtBwmLAP1luXS6ncLVSNaCsqjGxB2TKRClbJsUSusKeJqFJkNlmnyu71zscXBp0SqQAYdz45uOufoblOdAObDN4G4bBStIEIfj+YmsMxdND+wuhnOkpDqd4XyPb0Re3onFpvdIIHA6DlKhZ/GWHJqG3zAAXfznuw6+tZv8V311hwtV5qRbgDaRhgmCM94SbjjgCtnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YMSIsHOb; dkim-atps=neutral; spf=pass (client-ip=95.215.58.179; helo=out-179.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YMSIsHOb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.179; helo=out-179.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvpJN5tp2z2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 12:34:28 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776134048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vw6s/HiBgFDsTXtMvscroT4fKbZCyCeW0iTze1OcKV8=;
	b=YMSIsHObqjSgUKpGmW7VPicOKfXENbGzne3HXT8+8KeT1nH3cFGRtcU90fcbhRJ37dfUUd
	DCkmYS6TlpRbNe3kRUHce9SLxBoEsRBGNMEcjUgoWQfhm//49hI7CoBuBLi+jMnwFj92jV
	cGZXASiaDO0RoydpvGcPc8QexRtGP3Y=
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
Subject: Re: [PATCH 03/49] mm/sparse: fix vmemmap page accounting for HVOed
 DAX
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <2b51659e-5527-4e15-a0a8-41f30f589d07@kernel.org>
Date: Tue, 14 Apr 2026 10:33:18 +0800
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
Message-Id: <65E94431-F4A3-4C8B-B7B9-2ED3EF431DA7@linux.dev>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-4-songmuchun@bytedance.com>
 <2b51659e-5527-4e15-a0a8-41f30f589d07@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 14, 2026, at 02:41, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 4/5/26 14:51, Muchun Song wrote:
>> When HVO is enabled for DAX, the vmemmap page accounting is wrong =
since
>> it only accounts for non-HVO case.
>>=20
>> Fix the accounting by introducing section_vmemmap_pages() that =
returns
>> the exact number of vmemmap pages needed for the given pfn range.
>>=20
>> Fixes: 15995a352474 ("mm: report per-page metadata information")
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> mm/sparse-vmemmap.c | 30 ++++++++++++++++++++++++++----
>> 1 file changed, 26 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>> index 7aa9a97498eb..0ef96b1afbcc 100644
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>> @@ -724,6 +724,27 @@ static int fill_subsection_map(unsigned long =
pfn, unsigned long nr_pages)
>> return rc;
>> }
>>=20
>> +static int __meminit section_vmemmap_pages(unsigned long pfn, =
unsigned long nr_pages,
>> +    	struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
>> +{
>> + 	unsigned int order =3D pgmap ? pgmap->vmemmap_shift : 0;
>> + 	unsigned long pages_per_compound =3D 1L << order;
>> +
>> + 	VM_BUG_ON(!IS_ALIGNED(pfn | nr_pages, min(pages_per_compound, =
PAGES_PER_SECTION)));
>> + 	VM_BUG_ON(pfn_to_section_nr(pfn) !=3D pfn_to_section_nr(pfn + =
nr_pages - 1));
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
>=20
> This makes me wonder whether that is really the right place to update
> the counter. Can't we update the counter where we actually =
allocate/free
> the pages, so we don't have to re-calculate that?

The vmemmap pages are allocated via vmemmap_populate(). Different
architectures may implement their own versions of vmemmap_populate()
(though this is relatively rare), leading to the accounting being
scattered across various locations. As for vmemmap_free(), there is
no generic implementation; since each architecture implements its
own version, the accounting would be dispersed across different
architectures, making the implementation appear quite complex.

Thanks,
Muhcun

>=20
> --=20
> Cheers,
>=20
> David



