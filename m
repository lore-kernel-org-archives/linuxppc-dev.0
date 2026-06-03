Return-Path: <linuxppc-dev+bounces-21934-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3FDCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 02:54:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVXN04qtmz2yRF;
	Wed, 03 Jun 2026 12:54:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b7"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780455248;
	cv=none; b=FxTo97YDtq8GJdXW71RIXUs+zTDjOs3+6rjrGCYdexX2uk8mZoL0hI9MP2cbyyVyAedn3hSoL34TgZNqW7N6tNCnRxyn4ytqt8C3P0JvjmXo5k0dZ8L9Zg3ztOy+W3gHmpQbUagurVXjEnjBKIryBfQv8AEDjpmYTO7/1WTWQhtPPfrdJkztO5KzXIf5SG9+ZfInPyLtHkRhcFHAYM2D7Ht9e4y1OQrurBD6/ji/MW+3WKau+36umj9meOUi44C2sApWFmAgo+8r4kAEheFELsuschn89QmSEs3xurr7ZM4YHZTcG6BSLUVo0FWZgJUnoFL8AE1DJP84ArZtePmJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780455248; c=relaxed/relaxed;
	bh=hXR0DDEnySpzbdiRagAYl7c+e0VnGF+jVNLwTxCwhtQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=G0/d/ArVdXeEwiOCJZHGYJyVoS4N4P6vKdDdGCVJv8cF+4kJMXXRjoQYMuM9YEtMd0BFTDvp7d/GInOYUPKmM8DInD+CCnsVV90dsyBgvs+m0iMQXbt79h1kC3roxZjvvUWIs3LUadn3HmON2OFGwJu8BFi57jGFWYGsGzbEiKcC7vk0Qebz7+kZ3hcnJ19ivDmR+ClzBaUFyuM0pudGdoMtvSJw8k2mLEZns+IIitoWZokJ+GSMSavq84f14ZGV5gJdJEzKACmlJTIwg0xKFM+JvICG4cy8QWyl2qC35/eijzaNralqBZvSqXWrVb9TRsvVEOW/qp/BO/9xAs5z2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NxkwUBap; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b7; helo=out-183.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NxkwUBap;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b7; helo=out-183.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVXMy0W6jz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 12:54:04 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780455224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXR0DDEnySpzbdiRagAYl7c+e0VnGF+jVNLwTxCwhtQ=;
	b=NxkwUBapuP1ubsUtM+nqUc6e4oSWGPNe4k31tuYXqiMtmjlN0lcSrZnvD3S1gKNAmwVuGH
	BWAVmV+hhsZHg8TnjTJTi7EcLw5Ltoqml4bZKx0imJFPYB0OSlIrf44wgUtDsgUABdYzSL
	2dSD2TNsXlmQsElmo9BS8yvl/dij+d0=
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
Subject: Re: [PATCH v3 14/19] mm/hugetlb: Free cross-zone bootmem gigantic
 pages after allocation
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <178041489395.457517.12727427621570734471.b4-review@b4>
Date: Wed, 3 Jun 2026 10:53:04 +0800
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
 linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1ABCD934-CA2C-4541-9B76-32FAEFD398FF@linux.dev>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
 <20260602101039.1867613-15-songmuchun@bytedance.com>
 <178041489395.457517.12727427621570734471.b4-review@b4>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Jun 2, 2026, at 23:41, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Tue, 02 Jun 2026 18:10:34 +0800, Muchun Song =
<songmuchun@bytedance.com> wrote:
>=20
> Hi Muchun,

Hi Mike,

>=20
>>=20
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 5e557c05d80a..218fb1ca45f4 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3073,22 +3076,38 @@ static bool __init =
alloc_bootmem_huge_page(struct hstate *h, int nid)
>> [ ... skip 26 lines ... ]
>> + 	* pages belonging to the requested node.
>> + 	*/
>> + 	if (WARN_ON_ONCE(nid_request !=3D NUMA_NO_NODE && nid !=3D =
nid_request))
>> + 		list_add(&m->list, &huge_boot_pages[nid_request]);
>> + 	else
>> + 		list_add(&m->list, &huge_boot_pages[nid]);
>=20
> Can we just memblock_free() the page that intersects zones here?

I had previously considered doing this, but then I realized that if we =
free the
allocated cross-zone memory here, memblock is very likely to select the =
exact
same block for the next allocation. This means we'd just end up with =
this
cross-zone memory again, degrading allocation efficiency. Unless there =
is a way
to mark the block so memblock avoids reallocating it, I ultimately chose =
to
defer the release to prevent this issue from happening.

Thanks.

>=20
> Rather than making alloc_bootmem_huge_page() bool (sorry my bad :)) we
> can make it return -ENOMEM when memblock_alloc() fails, 0 if the page =
is
> not usable and 1 (i.e. number of allocated gigantic pages) if =
everything
> is fine.
>=20
> The callers would need a bit of massage, but it still seems simpler to
> me than adding them to the list and then walking that list.
>=20
> --=20
> Sincerely yours,
> Mike.
>=20


