Return-Path: <linuxppc-dev+bounces-20252-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DEEFF886F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 03:02:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g52Cv2gYsz2ySW;
	Wed, 29 Apr 2026 13:02:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::bd"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777431755;
	cv=none; b=mVFs6CFO2e+kqpPDHIiY5Se4c359WBayihpX+RUKDQ3WeBYPQ3aHRSHIkoG2fliLfa+yRvsvfv4j3iSVww+y8Jqd5Ad574I8Y4dz/OHyki1RYkWkF33RTPvGDcAZSbgoB6N8gVU8RFwlTVEqHD0Wc5Fr47riieI32FhRFGwDslzLVt9nm2J9mZKj30FZ37hPMN2o1rF5spPiezbj7ve1g2Vi60tTdeMuuqnpwu0qcKOCUBzpWJfev9hB8pVxvVtogcInKPpe9yKmfvrMZG+Xjg2unQEyU38KquN35r82cIvpMiIQucse3YM3hLpydmf5MQWy4oZ017KR7z86jTEDdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777431755; c=relaxed/relaxed;
	bh=x/FM019OPNeOk2Zn+soqE+l3vbEFGXrxJeVq00i8YqA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZBF7jWc3uPsDfxla9vBLQarZ3sM3vto6BFnV8VYgTFAGPQrfxdNeUElBYpEZ5sEZvqx61+rLESwKAjkdKbEAcvlgsjEqQ2RQbGixq8nti/QXHqjGIXhLfkR4zOsu2EIFY8r4EZNkqs9ktdhdoizQcoyC8m4UngZh/o6Nvg8XX2yhJVWydjP5VIt57JaSv9MZ5EaskegKYk7RZNtaX3Dx75ZQc6VInDadPX6U9yEDAYzgT7GMR9vS0CyBCB4EvDq/nSRjFMI7+x2mJxWZABdSRai1ButuHJQMSIyMHBJmYEIsaNjMhLNt2xS52egiM74fxpSwVT0/Bf7XTqkvad1UsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oxo6NdW6; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::bd; helo=out-189.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oxo6NdW6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::bd; helo=out-189.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g52Cq6CVYz2xTh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 13:02:30 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777431728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/FM019OPNeOk2Zn+soqE+l3vbEFGXrxJeVq00i8YqA=;
	b=oxo6NdW6M0lAsIZYY3RtZBdCAMu7S1zP9snq5kAiD/XXeKgJgZbX42oUZ/GflFxLq+JPl9
	ohJpjC/s/5lrT4PIUDrOXPb9G6oUSvl07gCyZ1ZCGW9ECdgICTJavHZ2JTifPXQBjZLCxd
	T90uCaJ8pdwRLu71pci2T9gcYmPFyms=
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
Subject: Re: [PATCH 14/49] mm/cma: validate hugetlb CMA range by zone at
 reserve time
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <afBiBUq98Msv7ZFc@kernel.org>
Date: Wed, 29 Apr 2026 11:01:06 +0800
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
 Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <25FDC3CD-2202-4099-8E42-877A68D3E546@linux.dev>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-15-songmuchun@bytedance.com>
 <afBiBUq98Msv7ZFc@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 28, 2026, at 15:30, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Sun, Apr 05, 2026 at 08:52:05PM +0800, Muchun Song wrote:
>> During hugetlb_cma_reserve() we already have access to zone =
information, so we
>> can validate that the reserved CMA range does not span multiple =
zones.
>>=20
>> Doing this check up front allows future hugetlb allocations from CMA =
to assume
>> zone-valid CMA areas, avoiding additional validity checks and =
potential
>> fallback/rollback paths, greatly simplifying the code.
>>=20
>> The pfn_valid() check is removed from cma_validate_zones() because =
mem_section is
>> not initialized at that stage and it can trigger false warnings; keep =
the
>> sanity check in cma_activate_area() instead. This is preparatory work =
for the
>> follow-up simplification.
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> mm/cma.c         | 3 ++-
>> mm/hugetlb_cma.c | 3 ++-
>> 2 files changed, 4 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/mm/cma.c b/mm/cma.c
>> index 15cc0ae76c8e..dd046a23f467 100644
>> --- a/mm/cma.c
>> +++ b/mm/cma.c
>> @@ -125,7 +125,6 @@ bool cma_validate_zones(struct cma *cma)
>>  * to be in the same zone. Simplify by forcing the entire
>>  * CMA resv range to be in the same zone.
>>  */
>> - WARN_ON_ONCE(!pfn_valid(base_pfn));
>> if (pfn_range_intersects_zones(cma->nid, base_pfn, cmr->count)) {
>> set_bit(CMA_ZONES_INVALID, &cma->flags);
>> return false;
>> @@ -164,6 +163,8 @@ static void __init cma_activate_area(struct cma =
*cma)
>> bitmap_set(cmr->bitmap, 0, bitmap_count);
>> }
>>=20
>> + 	WARN_ON_ONCE(!pfn_valid(cmr->base_pfn));
>> +
>> 	for (pfn =3D early_pfn[r]; pfn < cmr->base_pfn + cmr->count;
>>      		pfn +=3D pageblock_nr_pages)
>> 	init_cma_reserved_pageblock(pfn_to_page(pfn));
>> diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
>> index f83ae4998990..b068e9bf6537 100644
>> --- a/mm/hugetlb_cma.c
>> +++ b/mm/hugetlb_cma.c
>> @@ -233,9 +233,10 @@ void __init hugetlb_cma_reserve(void)
>> res =3D cma_declare_contiguous_multi(size, PAGE_SIZE << order,
>> HUGETLB_PAGE_ORDER, name,
>> &hugetlb_cma[nid], nid);
>> - 	if (res) {
>> + 	if (res || !cma_validate_zones(hugetlb_cma[nid])) {
>> 		pr_warn("hugetlb_cma: reservation failed: err %d, node =
%d",
>> 			res, nid);
>=20
> The warning here should be updated as well. Other than that

Make sense.

>=20
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks.

>=20
>> + 		hugetlb_cma[nid] =3D NULL;
>> 		continue;
>> 	}
>>=20
>> --=20
>> 2.20.1
>>=20
>=20
> --=20
> Sincerely yours,
> Mike.



