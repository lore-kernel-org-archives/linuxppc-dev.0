Return-Path: <linuxppc-dev+bounces-19783-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EFDF433D6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 02:07:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fx1c970s1z2yrm;
	Thu, 16 Apr 2026 12:07:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.186
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776305241;
	cv=none; b=CHkkin2hiMHaSPIuVVeBipouk5b/a+n7fK8WsqrZWvQvpjgt9siUvqyunzhLIRkR9JUVhb16fiWBIwy7UtM5ZGaYbdA4tJPXBeKQW7v91E/t+03lYSFl5eP7tF5ME/dwHvzYn1fBNpOHV34B8xzJatcIz6WqYb/dp/WnAYUO2lPkdXo9e5I5Ke+0MiCmf5N4cskIjW+SPHwU3n01EIvm1a0ZIJ5EOPgejTfyM0IGYk1F+EkyTPXqVx1j53iIBmxlbergspB2TimEIRaZ8z+woixVl3VPmD0R5QSPGmFbtfii3TrzhxJy/LXwvgAw/mTWhU5a+Eu93+X/okrS5hfYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776305241; c=relaxed/relaxed;
	bh=TaDtlDhvpSN1DHQ/+o47EJco+lcgV052hZ9XtkHXQBM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iDMjAuEWOJPQVX7XKZaldOttgK2cFhgk4qVynb4lx24kqgQcaeU9mQHIu1UUuC2q/pgGFtzigkFg16JJu4Joce2FEgS0BLb0K3CBpDzJSUIz+JDcwFHPeGTgcbwigaIUT8GrfP8UMlGNt+bAoU/p0ooL3FBT8g44gWMjZ/qbQsEIx0c0AjL11S7OyEMDeQRjkMkhTT87psSInA3ulMng3WyTkznW2Tu06nknYyDW0nn5H1XwMDx0BgvTFb9eU3TLCHHwYwPUbpLhknCvlwDdR7WLo2P++mkhUyX9LbqQCoakUzBoeHthc64pn7JTxnWJ8tiQl2H+3FY9LkC3phQYWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=J0zA0c7P; dkim-atps=neutral; spf=pass (client-ip=91.218.175.186; helo=out-186.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=J0zA0c7P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.186; helo=out-186.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fx1c34X36z2ynP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2026 12:07:12 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776305207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaDtlDhvpSN1DHQ/+o47EJco+lcgV052hZ9XtkHXQBM=;
	b=J0zA0c7PNrU1/2K6DsccDATXvjS/5EjTLM92uaQLPBY5Bs2V4BcyO2VeGwXmN8w1IQpL8E
	uiKGZopweljMF01lnCABOKA5JDUkCf3P60EkZYOn4tKQ6HjXEmbJ+l9Aq0NcG3edWqIxxp
	eVPIu6DatuMk04EV+TM9SasWJSra1zs=
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
Subject: Re: [PATCH v2 6/6] mm/mm_init: Fix pageblock migratetype for
 ZONE_DEVICE compound pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ad_EygHWDi19SS9y@kernel.org>
Date: Thu, 16 Apr 2026 10:06:03 +0800
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
Message-Id: <86523791-2C69-4A43-BD32-3713840A6640@linux.dev>
References: <20260415111412.1003526-1-songmuchun@bytedance.com>
 <20260415111412.1003526-7-songmuchun@bytedance.com>
 <ad_EygHWDi19SS9y@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 16, 2026, at 01:03, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> Hi Muchun,
>=20
> On Wed, Apr 15, 2026 at 07:14:12PM +0800, Muchun Song wrote:
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
>> ---
>> mm/mm_init.c | 42 +++++++++++++++++++++++++++---------------
>> 1 file changed, 27 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index f9f8e1af921c..30528c4206c1 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -674,6 +674,19 @@ static inline void fixup_hashdist(void)
>> static inline void fixup_hashdist(void) {}
>> #endif /* CONFIG_NUMA */
>>=20
>> +static __meminit void pageblock_migratetype_init_range(unsigned long =
pfn,
>> +        unsigned long nr_pages,
>> +        int migratetype)
>> +{
>> + 	unsigned long end =3D pfn + nr_pages;
>> +
>> + 	for (pfn =3D pageblock_align(pfn); pfn < end; pfn +=3D =
pageblock_nr_pages) {
>> + 		init_pageblock_migratetype(pfn_to_page(pfn), =
migratetype, false);
>> + 		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
>> + 			cond_resched();
>> + 	}
>> +}
>> +
>> /*
>>  * Initialize a reserved page unconditionally, finding its zone =
first.
>>  */
>> @@ -1011,21 +1024,6 @@ static void __ref =
__init_zone_device_page(struct page *page, unsigned long pfn,
>> page_folio(page)->pgmap =3D pgmap;
>> page->zone_device_data =3D NULL;
>>=20
>> - 	 /*
>> -  	 * Mark the block movable so that blocks are reserved for
>> -  	 * movable at startup. This will force kernel allocations
>> -  	 * to reserve their blocks rather than leaking throughout
>> - 	 * the address space during boot when many long-lived
>> -  	 * kernel allocations are made.
>> - 	 *
>> -  	 * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
>> -  	 * because this is done early in section_activate()
>> -  	 */
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
>> @@ -1122,6 +1120,8 @@ void __ref memmap_init_zone_device(struct zone =
*zone,
>>=20
>> 	__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
>>=20
>> + 	cond_resched();
>> +
>=20
> I don't think we want cond_resched() for every page here too, even =
it's a
> compound page :)

I'll update it to every PAGES_PER_SECTION, does this make sense for you?

Thanks,
Muchun

>=20
> Otherwise
>=20
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>=20
>> if (pfns_per_compound =3D=3D 1)
>> continue;
>>=20
>> @@ -1129,6 +1129,18 @@ void __ref memmap_init_zone_device(struct zone =
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
>> + 	pageblock_migratetype_init_range(start_pfn, nr_pages, =
MIGRATE_MOVABLE);
>> +
>> 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
>> 	nr_pages, jiffies_to_msecs(jiffies - start));
>> }
>> --=20
>> 2.20.1
>>=20
>=20
> --=20
> Sincerely yours,
> Mike.



