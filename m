Return-Path: <linuxppc-dev+bounces-19677-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89966EBFD2F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 10:14:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvNZ71jktz2yfl;
	Mon, 13 Apr 2026 20:14:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.177
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776075295;
	cv=none; b=oS4GIkb0aazWpb+CohEBxv/Vbg56mzw6mvql7a2YKBF5AA16Lywm3IIKG7D2dcOmbYDjMGNRKLt/gItxmA7g+qV000wMaYZ6MgT0h3cggNpqL6VQOAUf6rImFbZyfrKCdcyhJa8eRbv24/InLkHISx1Uod2oA27uLHLuqGcVJTRhOvrNFA8m55mmhX2A0pCDNYdXztrb925hKrInIIpsLeWoBaIbDHwK9Ay8coM/Vc2WerQMAM6Jh++KIxzG1uTIa8fg+XUOs3gAONeWoEvqCjuLzoiVb40uj8iA1FOxmSw2u8W9hEmBu0MQlEXp9/m5isCL0TGZGFyrCnJUtu2B0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776075295; c=relaxed/relaxed;
	bh=Sps84VvkM9WL1pZA/XR4z7lJiIfi6BTmHDf8JsPgXUg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JzmaCkoM3JhVYcaZaKLIeKXRLveq2dyqJMF72StG2ECoLwwRkTU+k0nbhyyg2Jn5/ejdIwrkZr6fTlypfMqRsGoRWLO+xx0eDu/OdA56/y1GXDib9j63TD22Uw0e0NTGmrrQF0pd1W0+xYUKHWeF4jQBdiVTSLYTLYBMiXVkWjgNZpnVdrdkN8kRx3T6eVp/DbeUPblLoRBOhVmk/SP1Quj7SVFCG4OfJ5cIpFhe3+iRjA0xFZDSa+quFM/LoESj/xqbw4hEqTJqLcl0OAjr5FYhA/WBtsOBX3lyg8fcSEJKyCUnI+i/v7kp4B5RJb/JkV7szzYv+Ykqi0sJ3x80HQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WLiyyOCr; dkim-atps=neutral; spf=pass (client-ip=91.218.175.177; helo=out-177.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WLiyyOCr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.177; helo=out-177.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 361 seconds by postgrey-1.37 at boromir; Mon, 13 Apr 2026 20:14:52 AEST
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvNZ42977z2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 20:14:52 +1000 (AEST)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776074903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sps84VvkM9WL1pZA/XR4z7lJiIfi6BTmHDf8JsPgXUg=;
	b=WLiyyOCrQpSqlbf5UlYg0hO4AvDZM7uLPrY9tN+xx3bzTm461ZlsVNwtJ7ZMOa1fUZjx8d
	HK9WKtvgaGuxhxHBe+aUoDbvaQkHBZDJKQK6zfA8TVEk51y6TF+9wIyya+RmrY/kG6bzAz
	qufQTDe3llLJJmWr78ZKyTufEHL3yoY=
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
Subject: Re: [PATCH 06/49] mm/mm_init: fix uninitialized pageblock migratetype
 for ZONE_DEVICE compound pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ady4LBppz-na5lM5@kernel.org>
Date: Mon, 13 Apr 2026 18:07:44 +0800
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
Message-Id: <5910791C-9893-4710-9002-76534DBFBFBD@linux.dev>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-7-songmuchun@bytedance.com>
 <ady4LBppz-na5lM5@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 13, 2026, at 17:32, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Sun, Apr 05, 2026 at 08:51:57PM +0800, Muchun Song wrote:
>> Previously, memmap_init_zone_device() only initialized the =
migratetype
>> of the first pageblock of a compound page. If the compound page size
>> exceeds pageblock_nr_pages (e.g., 1GB hugepages with 2MB pageblocks),
>> subsequent pageblocks in the compound page would remain =
uninitialized.
>>=20
>> This patch moves the migratetype initialization out of
>> __init_zone_device_page() and into a separate function
>> pageblock_migratetype_init_range(). This function iterates over the
>> entire PFN range of the memory, ensuring that all pageblocks are =
correctly
>> initialized.
>>=20
>> Fixes: c4386bd8ee3a ("mm/memremap: add ZONE_DEVICE support for =
compound pages")
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> mm/mm_init.c | 41 ++++++++++++++++++++++++++---------------
>> 1 file changed, 26 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 9a44e8458fed..4936ca78966c 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -674,6 +674,18 @@ static inline void fixup_hashdist(void)
>> static inline void fixup_hashdist(void) {}
>> #endif /* CONFIG_NUMA */
>>=20
>> +static __meminit void pageblock_migratetype_init_range(unsigned long =
pfn,
>> +        unsigned long nr_pages,
>> +        int migratetype)
>> +{
>> + unsigned long end =3D pfn + nr_pages;
>> +
>> + for (pfn =3D pageblock_align(pfn); pfn < end; pfn +=3D =
pageblock_nr_pages) {
>> + init_pageblock_migratetype(pfn_to_page(pfn), migratetype, false);
>> + cond_resched();
>=20
> Do we need to call cond_resched() every iteration here?

Of course not.

>=20
>> + }
>> +}
>> +
>> /*
>>  * Initialize a reserved page unconditionally, finding its zone =
first.
>>  */
>> @@ -1011,21 +1023,6 @@ static void __ref =
__init_zone_device_page(struct page *page, unsigned long pfn,
>> page_folio(page)->pgmap =3D pgmap;
>> page->zone_device_data =3D NULL;
>>=20
>> - /*
>> -  * Mark the block movable so that blocks are reserved for
>> -  * movable at startup. This will force kernel allocations
>> -  * to reserve their blocks rather than leaking throughout
>> -  * the address space during boot when many long-lived
>> -  * kernel allocations are made.
>> -  *
>> -  * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
>> -  * because this is done early in section_activate()
>> -  */
>> - if (pageblock_aligned(pfn)) {
>> - init_pageblock_migratetype(page, MIGRATE_MOVABLE, false);
>> - cond_resched();
>> - }
>> -
>> /*
>>  * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
>>  * directly to the driver page allocator which will set the page =
count
>> @@ -1122,6 +1119,8 @@ void __ref memmap_init_zone_device(struct zone =
*zone,
>>=20
>> __init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
>>=20
>> + cond_resched();
>=20
> Originally we called cond_resched() once per pageblock, now it's =
called
> once per page plus for every pageblock in the tight loop that sets the
> migrate type. Isn't it too much?

There are indeed many more cond_resched() than before, but I don=E2=80=99t=
 have a
concise way to write it, so I took the easy way out.

How about:

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 2d680636b67a..d13a2577c4c3 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -683,7 +683,8 @@ static __meminit void =
pageblock_migratetype_init_range(unsigned long pfn,

        for (pfn =3D pageblock_align(pfn); pfn < end; pfn +=3D =
pageblock_nr_pages) {
                init_pageblock_migratetype(pfn_to_page(pfn), =
migratetype, isolate);
-               cond_resched();
+               if ((pfn & (pageblock_nr_pages * 512 - 1)) =3D=3D 0)
+                       cond_resched();
        }
 }

>=20
>> +
>> if (pfns_per_compound =3D=3D 1)
>> continue;
>>=20
>> @@ -1129,6 +1128,18 @@ void __ref memmap_init_zone_device(struct zone =
*zone,
>>      compound_nr_pages(altmap, pgmap));
>> }
>>=20
>> + /*
>> +  * Mark the block movable so that blocks are reserved for
>> +  * movable at startup. This will force kernel allocations
>> +  * to reserve their blocks rather than leaking throughout
>> +  * the address space during boot when many long-lived
>> +  * kernel allocations are made.
>> +  *
>> +  * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
>> +  * because this is done early in section_activate()
>> +  */
>> + pageblock_migratetype_init_range(start_pfn, nr_pages, =
MIGRATE_MOVABLE);
>> +
>> pr_debug("%s initialised %lu pages in %ums\n", __func__,
>> nr_pages, jiffies_to_msecs(jiffies - start));
>> }
>> --=20
>> 2.20.1
>>=20
>=20
> --=20
> Sincerely yours,
> Mike.



