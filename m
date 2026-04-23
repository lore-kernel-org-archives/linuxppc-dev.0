Return-Path: <linuxppc-dev+bounces-19990-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C60FAD3E7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:12:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1LkY6yMMz2yjs;
	Thu, 23 Apr 2026 13:12:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.174
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776913973;
	cv=none; b=aFM//BOE0J7cEAGOeHPpnNXVNP20JMO8jyHCn8A4j4KDDp0Kh8szFobUQXsSkKiJ/IkzZ8mmkrjtjeptZhHKKXpO3Z4+sBm/JthiCc2f85HRqgHJw3t1QD048W2IsRQQg405aOusMjZXir5/rIIWaXijvhWTc/pXPX1V/LuU64cFUhpwermLSXshU4UQF+OVGMJPkR7mJppb8r0R4O2xmxWIXPyT9bb1yYaqbOyfs5vgHM1gjk8A5+eYKFSAcoL8TnwSA18Pz/Vrajb3g33xJbhwkLWLKMikNV9N4oOZM1mN1wy8zKjQoo3K/GluoLQH/tTyHTIGMyFkXkitedChpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776913973; c=relaxed/relaxed;
	bh=5eNb16Y0uJwWAOzByzOeSIHg4jxQlqJ20m2cdPXXu30=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YWLAs8ZwEZN2bGvhk3mFE+NkiFj2UU9PDtIOYIxJ3wMWyaSjV5gwsdOYrcG6iv7DAB1Hvrk43HNIBhBcYTnR1NBRcwn+nCTVfkFTVZIeCzgtJONImgVuT8vmWRF7z+gTUDBRR96lk53Cd23uLIJ/w5WUBwfatw3kXsfrwE67mJ1gAjmkWd2yL9z/AH4GOpiJFQsUPNqlj0oDtAfrM+DI2//g9srCvXGG6jtrd6iT/fgILfOlE1mEF1dkhzlq3NsC6PsMjx28A37BdfiZqw9OTfBHBAdHP3rpFfQkUHJZY4Jvf91SrPuelwndD3dfpldageToMCO+8b/LalYwWZA/Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IGlW4RZv; dkim-atps=neutral; spf=pass (client-ip=95.215.58.174; helo=out-174.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IGlW4RZv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.174; helo=out-174.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1LkW0W6Tz2ygh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 13:12:49 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776913950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5eNb16Y0uJwWAOzByzOeSIHg4jxQlqJ20m2cdPXXu30=;
	b=IGlW4RZvYQzuXJekYe+qqsVATrFv+wW/Be6t5xeDINprC4gd1efrJj+Jp/3gE2ZIq1vsx+
	q/Ji/1RGScCJ7TCRYZ2s6olOYYncU7CobGwX4NiqxURTVbQ+XbUSwA/vg2CbByEb+soAMU
	FW4cfpQnhrDZMM02+y1y9fl2dh6Wb+g=
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
Subject: Re: [PATCH v4 4/5] mm/mm_init: Fix pageblock migratetype for
 ZONE_DEVICE compound pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <95d59eee-a4fe-4d11-b335-07f3b3ef2e66@kernel.org>
Date: Thu, 23 Apr 2026 11:11:39 +0800
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
Message-Id: <FE96D828-7C9F-452B-8EEE-97CA77EF8E25@linux.dev>
References: <20260422081420.4009847-1-songmuchun@bytedance.com>
 <20260422081420.4009847-5-songmuchun@bytedance.com>
 <95d59eee-a4fe-4d11-b335-07f3b3ef2e66@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 23, 2026, at 03:03, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 4/22/26 10:14, Muchun Song wrote:
>> The memmap_init_zone_device() function only initializes the =
migratetype
>> of the first pageblock of a compound page. If the compound page size
>> exceeds pageblock_nr_pages (e.g., 1GB hugepages with 2MB pageblocks),
>> subsequent pageblocks in the compound page remain uninitialized.
>>=20
>> Move the migratetype initialization out of __init_zone_device_page()
>> and into a separate pageblock_migratetype_init_range() function. This
>> iterates over the entire PFN range of the memory, ensuring that all
>> pageblocks are correctly initialized.
>>=20
>> Fixes: c4386bd8ee3a ("mm/memremap: add ZONE_DEVICE support for =
compound pages")
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>> ---
>> mm/mm_init.c | 45 ++++++++++++++++++++++++++++++---------------
>> 1 file changed, 30 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index f9f8e1af921c..9d0fe79a94de 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -674,6 +674,21 @@ static inline void fixup_hashdist(void)
>> static inline void fixup_hashdist(void) {}
>> #endif /* CONFIG_NUMA */
>>=20
>> +#ifdef CONFIG_ZONE_DEVICE
>> +static __meminit void pageblock_migratetype_init_range(unsigned long =
pfn,
>> +        						unsigned long =
nr_pages,
>> +        						int migratetype)
>=20
> Two-tab indent says hi :)

No problem.

>=20
>> +{
>> + 	unsigned long end =3D pfn + nr_pages;
>=20
> Can be const.

Ah, yes.

>=20
>> +
>> + 	for (pfn =3D pageblock_align(pfn); pfn < end; pfn +=3D =
pageblock_nr_pages) {
>> + 		init_pageblock_migratetype(pfn_to_page(pfn), =
migratetype, false);
>> + 		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
>> + 			cond_resched();
>> + 	}
>> +}
>> +#endif
>> +
>> /*
>>  * Initialize a reserved page unconditionally, finding its zone =
first.
>>  */
>> @@ -1011,21 +1026,6 @@ static void __ref =
__init_zone_device_page(struct page *page, unsigned long pfn,
>> 	page_folio(page)->pgmap =3D pgmap;
>> 	page->zone_device_data =3D NULL;
>>=20
>> - 	/*
>> - 	 * Mark the block movable so that blocks are reserved for
>> - 	 * movable at startup. This will force kernel allocations
>> - 	 * to reserve their blocks rather than leaking throughout
>> - 	 * the address space during boot when many long-lived
>> - 	 * kernel allocations are made.
>> - 	 *
>> - 	 * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
>> - 	 * because this is done early in section_activate()
>> - 	 */
>> - 	if (pageblock_aligned(pfn)) {
>> - 		init_pageblock_migratetype(page, MIGRATE_MOVABLE, =
false);
>> - 		cond_resched();
>> - 	}
>> -
>> /*
>>  * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
>>  * directly to the driver page allocator which will set the page =
count
>> @@ -1122,6 +1122,9 @@ void __ref memmap_init_zone_device(struct zone =
*zone,
>>=20
>> 	__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
>>=20
>> + 	if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
>> + 		cond_resched();
>> +
>> 	if (pfns_per_compound =3D=3D 1)
>> 		continue;
>>=20
>> @@ -1129,6 +1132,18 @@ void __ref memmap_init_zone_device(struct zone =
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
>=20
> I am deeply confused about the "memmap" comment here.
>=20
> There is no MEMINIT_HOTPLUG special-casing. Nobody "clears memmap".

Absolutely right. This comment was originally copied from the regular
memory initialization path long ago (commit 966cf44f637e), and it has
become completely outdated and misleading over the years after several
MM hotplug refactorings.

>=20
>=20
> That comment was introduced in
>=20
> commit 966cf44f637e6aeea7e3d01ba004bf8b5beac78f
> Author: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Date:   Fri Oct 26 15:07:52 2018 -0700
>=20
>    mm: defer ZONE_DEVICE page initialization to the point where we =
init pgmap
>=20
> Where we added memmap_init_zone_device().
>=20
>=20
>=20
> Is that commit still valid, and this it actually belong here, above =
the
> migratetype setting?

To be honest, I just blindly moved this comment along with the =
migratetype
initialization code out of __init_zone_device_page() without deeply =
analyzing
its historical context and current validity.

After looking into it, I think this comment is an obsolete relic from =
commit
966cf44f637e and no longer makes sense here.

I will completely remove this confusing comment in v5. Thanks for =
catching this!

Thanks,
Muchun

>=20
>=20
>> + 	pageblock_migratetype_init_range(start_pfn, nr_pages, =
MIGRATE_MOVABLE);
>> +
>> 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
>> 		nr_pages, jiffies_to_msecs(jiffies - start));
>> }
>=20
>=20
> --=20
> Cheers,
>=20
> David



