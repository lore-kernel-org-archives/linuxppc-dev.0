Return-Path: <linuxppc-dev+bounces-19723-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932E1F531E3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2026 03:01:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvpv90dZMz2yrD;
	Tue, 14 Apr 2026 13:01:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b7"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776135669;
	cv=none; b=D0TreC1vNqwux7KsJJaQf/2UibROf6hmpOtgAKFDTJqSWDS2SPPBzT+e2sb6gxGcwvq+3gS+E4U86rQUlNSMeBZbfpLHBrSignVmifLADjFxDFyF+5X7ngNcrA9KijgWTCQv4vgViUHhe/OeIH8w9Q/v1wxRsz1rMYRczpQBbcaUnlZ5AUAwdzohT7jeCDU4UluaWaQ+smTMSeuT8ICIB1sQy8hr/zGn29du7I6fBVjaX2xm/AfZVQ3DgV6IPZtMEkpTjZ/1AjkTE4+ou7Y67qNgPVitTXeX/oKMT9Jz+nBybQoMXBewpSMmYDKNYJx4kI3mr/D9TerGRQu8U0MCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776135669; c=relaxed/relaxed;
	bh=4PlymUBRhoew3U1NTZK8jxRqafzc24WW3+boeDt4A/A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=G0fCL2D9dbkmChygiexLL2MeeZ8KXuH8DeChJCI+GXkI7kKU5EdifOIkvLWjI2p5FCtPCBWZJlGDm7K4r+FHht5DF1+oAKlYIcZirvJKjVfvqkgwVF/ZMYISgj4SP/9+pkgopzgXA6NURbYLzaxKDdOqZqrwzTO/eLyNYvQKhXU0nVRHkRY2mQHZEdHLS2jAmNSI+5j7mnDnnX07JcdFWYqkwygV0YI+KRlMk8Q/TFqM+apRp9QA9bAAg39CEqfz9RiC+rvg1j8GQEObEeMWrIGau4dMMgZZgr1UR/psnd87YjuBfmqwLekQqE3SHsS7TL76dccICN5JJgxPxVhnNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iRwDPzSZ; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b7; helo=out-183.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iRwDPzSZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b7; helo=out-183.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvpv61Gcqz2ypY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 13:01:04 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776135645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PlymUBRhoew3U1NTZK8jxRqafzc24WW3+boeDt4A/A=;
	b=iRwDPzSZORBKkVc+qfAjdg/8sbprXX/S91NOZEjG9sY6nLhmM/7OkcH+FVVdFyPabDclFz
	MyQpXLhsvkEGbaqai+jaUp2+HVQNmnygABaq8U07zcHezNt3L9GnLd10HMAFhExFPzc9PE
	rVlGd2hYbvT3N41tMq1mKLtf4kVK3BE=
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
Subject: Re: [PATCH 07/49] mm/mm_init: use pageblock_migratetype_init_range()
 in deferred_free_pages()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <08a82aa4-f556-4e0f-9e50-b9fe0a5fb4c1@kernel.org>
Date: Tue, 14 Apr 2026 11:00:00 +0800
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
Message-Id: <3FDA057D-EBFA-4016-8555-E046FA161984@linux.dev>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-8-songmuchun@bytedance.com>
 <08a82aa4-f556-4e0f-9e50-b9fe0a5fb4c1@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 14, 2026, at 02:54, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 4/5/26 14:51, Muchun Song wrote:
>> Simplify deferred_free_pages by replacing the duplicate loops for
>> initializing pageblock migratetype with a call to
>> pageblock_migratetype_init_range to simplify the code.
>=20
> "Simplify ... to simplify the code."
>=20
> Likely you can drop the last part.

OK. I'll rewrite the message.

>=20
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> mm/mm_init.c | 13 ++++---------
>> 1 file changed, 4 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 4936ca78966c..a92c5053f63d 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -1974,13 +1974,12 @@ static void __init =
deferred_free_pages(unsigned long pfn,
>> if (!nr_pages)
>> return;
>>=20
>> + pageblock_migratetype_init_range(pfn, nr_pages, MIGRATE_MOVABLE);
>=20
>=20
> pageblock_migratetype_init_range() will align the PFN up to the next
> pageblock.

IIUC, pageblock_align(pfn) is to **round up** PFN to the next multiple =
of
pageblock_nr_pages.

>=20
> Are we sure the range we are getting called with is always aligned to
> pageblocks, such that we won't miss to initialize the first pageblock?

That means if pageblock_aligned(pfn) =3D=3D 1, then the result of
pageblock_align(pfn) is the pfn itself.

So there is no problem as you said.

Thanks,
Muchun.

>=20
> --=20
> Cheers,
>=20
> David



