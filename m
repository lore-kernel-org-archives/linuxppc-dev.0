Return-Path: <linuxppc-dev+bounces-19721-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59ADAF531E6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2026 02:29:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvpBt2BWDz2ypY;
	Tue, 14 Apr 2026 12:29:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.184
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776133782;
	cv=none; b=dU2nMSamNV1Au+YTzF/IfxZMwc9DczARyNz0BCDRLX9P4emFBQ0Fm/RB6/+kAKTibI6kd/EWXXVqQkEfiy78CCMLcC1pFr/CUY7xonvVMR6xSg0g0DacvQqi16ty/1+2Y++yDHHOr/+ouABRgfSlfw3hJKvxCNq/X/Kbe/LCJg5WVIRVcZywXd1hvaXAtP/YyxO2Yyi4rps8zcxsocQgTc9z25m2HnKLl9MaJ1yhy7WHoK73+x8lpUa/KLiW4LnPZGFyWDuJxCOKf8qNDb0M/+aWI8ZNQrwlOv9phm+HqAjZ4hcCquYrI5EB8jffmEjIJtp4/GKvcMB5Z+58LSxb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776133782; c=relaxed/relaxed;
	bh=V5QX9+pQg1ULyMnKqjfgXchOKAT14re8KJFOLZ7j1Uc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WALxzlG+WX0qqFScz+qHunCrTjhlvno4hgdzDhCfvkVWrkwnQIN6Ts2bz63lqFjwefiPnOFis08Fez7nxPddLmMNtXyM3NwTiIgGLtib/qtJeDA5pWZFow82MGdtVAnHxpAi+tXAbwVOrPNzEOHTrWuTIqQpnFmLgxj660UUJ4//VSMQOZTwZXJ8uxz2aCxopiqKfKaR22CyCBETLZxU8ZOAzqD4EBmcQdsoc3Dme2QLLMyQHyYMS7yWMAgT2jV/R8hm7DwUOT5zbvynmr+xKpzMEML17jbXJH64qpFMs25IgVkNa+FpdFpEf5JMf4TkzdFAfimZEg64m0dL2Msvag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Yd2bGA7z; dkim-atps=neutral; spf=pass (client-ip=91.218.175.184; helo=out-184.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Yd2bGA7z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.184; helo=out-184.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvpBn6lFyz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 12:29:36 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776133755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5QX9+pQg1ULyMnKqjfgXchOKAT14re8KJFOLZ7j1Uc=;
	b=Yd2bGA7z+vMWx2P0hf+Ov1gl4sMFJg6i7OJVdClj6OGD3ec4EqbxCfQ/5VoLn6XgtOKb83
	nP3kyHV5sscI5E+Q1Vp55uKsfQ9jDr0m5aGN3876Obkur4sGjaZwHTpPHVRVlssBSo/Pqd
	gIRpkEbiM6gSw4IOlo+LHzPtvGNrYiE=
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
In-Reply-To: <d44ff75a-a1bd-4a28-8e8b-0b008d24d41b@kernel.org>
Date: Tue, 14 Apr 2026 10:28:24 +0800
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
Message-Id: <AF32475C-3782-4EAE-BFF8-10078AC08052@linux.dev>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-4-songmuchun@bytedance.com>
 <d44ff75a-a1bd-4a28-8e8b-0b008d24d41b@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 14, 2026, at 02:39, David Hildenbrand (Arm) <david@kernel.org> =
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
>=20
> I guess only the accounting in /proc/meminfo is messed up, correct?

No. It is in /proc/vmstat

	cat /proc/vmstat | grep memmap

	nr_memmap_pages 0
	nr_memmap_boot_pages 2097163

>=20
>>=20
>> Fixes: 15995a352474 ("mm: report per-page metadata information")
>=20
> Similarly, please send all fixes out separately.

Will do in next version.

>=20
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
>=20
> No new VM_BUG_ON. Ever. :)
>=20
> VM_WARN_ON_ONCE() is your friend.

Got it.

>=20
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
>> + 	return 0;
>> +}
>> +
>> /*
>>  * To deactivate a memory region, there are 3 cases to handle:
>>  *
>> @@ -775,11 +796,12 @@ static void section_deactivate(unsigned long =
pfn, unsigned long nr_pages,
>>  * section_activate() and pfn_valid() .
>>  */
>> 	if (!section_is_early) {
>> - 		memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * =
sizeof(struct page), PAGE_SIZE)));
>=20
> That's nice to be factored out in any case.
>=20
> --=20
> Cheers,
>=20
> David



