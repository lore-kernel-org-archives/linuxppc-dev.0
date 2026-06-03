Return-Path: <linuxppc-dev+bounces-21933-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07951CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 02:43:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVX7k54Qyz2yRF;
	Wed, 03 Jun 2026 12:43:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780454610;
	cv=none; b=g98Fhu6Oms3wtIzzEil7FRk2zChr1wD9qFrb1ucUMedgGg/prU/Kt5N9rhwjfnYr04U+eZ8XB2hgP4qyfyYChSRBqiLNspUMn9cdzHGW3g6PH1naFJzOCJVHnrimGGGCsrM2UBvgiHNAtu36Vb7gnwP9tdcSeCu2dftzeWujv8rjZw5iU/Et3fk7sr232dMz67EUEsHIaHbY+pX6iqhRxgZRZ58lvjwzFqxrGbQ93teZG9pOE+7OsrC6ILH97keYlQcXwCKHZCNZbHMckoe8jdanqqswhnA06MptKTzSP0KseSbNiVPAnufQyneLIVVZZd7qEME/mh+Dvn/UcjnWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780454610; c=relaxed/relaxed;
	bh=yjBalMusC7z1Xgp8V8aGUlWtzrk4A/s6uSiB5E9g3wc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=C4UqBgbzGE/ZNjjHYxez9lzSTFaWzEDfBL0mMf/g6SnHI+NkHOO3LUC+MTAn7kMcyfxg5ku9qDXKZ9nDArQNY2P4D/U3tAU0PK+LpGe+GYzgOm5fG6aqI5p1nITi2rl25ZnfiSrLHxuBUs1/eBxGfubJIw+DsXBiOg7/kDk2Y1S3xgKWl7L43JXklAggkwIQDbOoo0ERFvjU+gba14DCCly08jq0tYnRwjIwVz+vM9l5kNjTpViDShWRfVncuvEDewD8LK+MH+/juYmdVdHrL28X9PkDkUJb2Pr2lE7t2dSTaYW3ME7JuS8+b5PxZZdKT1jOiWAO3ZjChCfHaKUiCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qIUk5At9; dkim-atps=neutral; spf=pass (client-ip=95.215.58.188; helo=out-188.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qIUk5At9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.188; helo=out-188.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVX7j5K4Nz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 12:43:29 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780454590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjBalMusC7z1Xgp8V8aGUlWtzrk4A/s6uSiB5E9g3wc=;
	b=qIUk5At9ThYG7PFryHkApvEi2uFBSRGP7kCANZeq+Zx1eZ8RHEIp0MA+9o9KGotnS18ict
	S56mHDOSvW+4opHm9v8BoZpxPrJvGyqtnJSx9644wWoLU9qpzkagJCGIvwtMyFwc6HQtk4
	3YiFbZnN5zIKFoJcAc5lWpVLDBM4lp8=
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v3 15/19] mm/hugetlb_vmemmap: Move bootmem HVO setup to
 early init
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <178041489396.457517.6730523256790632908.b4-review@b4>
Date: Wed, 3 Jun 2026 10:42:33 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Mike Kravetz <mike.kravetz@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <646C6366-B450-4A28-BE78-97D05562551B@linux.dev>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
 <20260602101039.1867613-16-songmuchun@bytedance.com>
 <178041489396.457517.6730523256790632908.b4-review@b4>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Jun 2, 2026, at 23:41, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Tue, 02 Jun 2026 18:10:35 +0800, Muchun Song =
<songmuchun@bytedance.com> wrote:
>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>> index ea6af85bfec1..464578ee246e 100644
>> --- a/mm/hugetlb_vmemmap.c
>> +++ b/mm/hugetlb_vmemmap.c
>> @@ -745,6 +745,8 @@ static bool =
vmemmap_should_optimize_bootmem_page(struct huge_bootmem_page *m)
>> 	return true;
>> }
>>=20
>> +static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn);
>> +
>=20
> Can we please move the entire function rather than add a forward
> declaration?

Yes. Will update next version.

>=20
> Other than that
>=20
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks.

>=20
> --=20
> Sincerely yours,
> Mike.
>=20


