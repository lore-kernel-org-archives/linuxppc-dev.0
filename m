Return-Path: <linuxppc-dev+bounces-19698-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9AFF34C49
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 13:57:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvTWN6Tnlz2ydn;
	Mon, 13 Apr 2026 23:57:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.183
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776088672;
	cv=none; b=nI/uBTq1Eh0qSua9N6c4Iqc7xFcBvdu07KW/tYxilWmbN9o7yaS36MD5g5gUqOhynNsoy75upr98WaNMKwP/KPEDxDxV2nEDhlfNd+NdZKdCWqkZwnLhO884cWBZ5gctpXhHNCLXkGBVi/jxgl3JRzUprLf7I4jf3qDPiCDQLd2O8wcZWDxyU8mTHhpC5HZOu5ERHLWJvTO0fKU5ef6vBPuPZ4njVpapQy/FFH6rVUZASWe3nFgw+Zk/EKvT1UeUqYV1VGLnSn5frZMRTpe9gJxpHe+keQJz5pc5U2m1fZSlcGPn3kWePMFble638GXXmgo5OsCLRENs5NZlMwrogg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776088672; c=relaxed/relaxed;
	bh=WB6X/KB4lcgoxaXTVldx7yfC+K++jG31ztfaBdye/0o=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=VoyAb8v8MLVo4iNLjy0wBL1Dg3MLeLKe4NcuhRZ+7lSMh4Io2icSG2Ogb8BUEhQLNSpF3sYIZC/zrbzqraEf3zX+60Rq6l0pMAq49an+6IB8yp/K/8oBoYVdojAbZKyncqRLwjJVn39rEX9oT112EeaaHNNmEilebvKJ4aOwtfQ+I09X9s22EIEqEcsozh991+dZ+aHpRV0aPofwgMm5a7HjWO5ZiTnD7lXKk6ktMKdIdxTrohShZ7h99r6ivpwH/26+tyM7+lF+xaR7uG0VGoVuqYhJsDjNVjj0wyF8qJ62ee56GkNPnYuMxeGxD5vHDgsNqxNWbTCIrEs+UO4wBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DmYoUD9o; dkim-atps=neutral; spf=pass (client-ip=91.218.175.183; helo=out-183.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DmYoUD9o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.183; helo=out-183.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvTWK742Hz2yS9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 23:57:48 +1000 (AEST)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776088647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WB6X/KB4lcgoxaXTVldx7yfC+K++jG31ztfaBdye/0o=;
	b=DmYoUD9oKqdfKivm9z9TwfbKLHD13LH/gu6nFBQGBPzDBoPrHIIJnqbsGdaBjyp/HzmHN5
	mVQMvqextCEEWtEWK81D/y4Sja1/VSwcgDqDjhNY8hYIm10O6g8QQmcjc0z05CcPpQLLRS
	8dTHIkivv52rRR/NBQD14jzk00a+lW0=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
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
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 06/49] mm/mm_init: fix uninitialized pageblock migratetype for ZONE_DEVICE compound pages
Date: Mon, 13 Apr 2026 21:57:00 +0800
Message-Id: <ADC5EFE8-454D-4B9D-8BB0-39FF671290F0@linux.dev>
References: <adzvdRPrK55TutT6@kernel.org>
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Liam R Howlett <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 aneesh.kumar@linux.ibm.com, joao.m.martins@oracle.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <adzvdRPrK55TutT6@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 13, 2026, at 21:28, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> =EF=BB=BFOn Mon, Apr 13, 2026 at 06:07:44PM +0800, Muchun Song wrote:
>>=20
>>=20
>>>> On Apr 13, 2026, at 17:32, Mike Rapoport <rppt@kernel.org> wrote:
>>>=20
>>> On Sun, Apr 05, 2026 at 08:51:57PM +0800, Muchun Song wrote:
>>>> Previously, memmap_init_zone_device() only initialized the migratetype
>>>> of the first pageblock of a compound page. If the compound page size
>>>> exceeds pageblock_nr_pages (e.g., 1GB hugepages with 2MB pageblocks),
>>>> subsequent pageblocks in the compound page would remain uninitialized.
>>>>=20
>>>> This patch moves the migratetype initialization out of
>>>> __init_zone_device_page() and into a separate function
>>>> pageblock_migratetype_init_range(). This function iterates over the
>>>> entire PFN range of the memory, ensuring that all pageblocks are correc=
tly
>>>> initialized.
>>>>=20
>>>> Fixes: c4386bd8ee3a ("mm/memremap: add ZONE_DEVICE support for compound=
 pages")
>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>> ---
>>>> mm/mm_init.c | 41 ++++++++++++++++++++++++++---------------
>>>> 1 file changed, 26 insertions(+), 15 deletions(-)
>>>>=20
>>>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>>>> index 9a44e8458fed..4936ca78966c 100644
>>>> --- a/mm/mm_init.c
>>>> +++ b/mm/mm_init.c
>>>> @@ -674,6 +674,18 @@ static inline void fixup_hashdist(void)
>>>> static inline void fixup_hashdist(void) {}
>>>> #endif /* CONFIG_NUMA */
>>>>=20
>>>> +static __meminit void pageblock_migratetype_init_range(unsigned long p=
fn,
>>>> +        unsigned long nr_pages,
>>>> +        int migratetype)
>>>> +{
>>>> + unsigned long end =3D pfn + nr_pages;
>>>> +
>>>> + for (pfn =3D pageblock_align(pfn); pfn < end; pfn +=3D pageblock_nr_p=
ages) {
>>>> + init_pageblock_migratetype(pfn_to_page(pfn), migratetype, false);
>>>> + cond_resched();
>>>=20
>>> Do we need to call cond_resched() every iteration here?
>>=20
>> Of course not.
>>=20
>>>=20
>>>> + }
>>>> +}
>>>> +
>>>> /*
>>>> * Initialize a reserved page unconditionally, finding its zone first.
>>>> */
>>>> @@ -1011,21 +1023,6 @@ static void __ref __init_zone_device_page(struct=
 page *page, unsigned long pfn,
>>>> page_folio(page)->pgmap =3D pgmap;
>>>> page->zone_device_data =3D NULL;
>>>>=20
>>>> - /*
>>>> -  * Mark the block movable so that blocks are reserved for
>>>> -  * movable at startup. This will force kernel allocations
>>>> -  * to reserve their blocks rather than leaking throughout
>>>> -  * the address space during boot when many long-lived
>>>> -  * kernel allocations are made.
>>>> -  *
>>>> -  * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
>>>> -  * because this is done early in section_activate()
>>>> -  */
>>>> - if (pageblock_aligned(pfn)) {
>>>> - init_pageblock_migratetype(page, MIGRATE_MOVABLE, false);
>>>> - cond_resched();
>>>> - }
>>>> -
>>>> /*
>>>> * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
>>>> * directly to the driver page allocator which will set the page count
>>>> @@ -1122,6 +1119,8 @@ void __ref memmap_init_zone_device(struct zone *z=
one,
>>>>=20
>>>> __init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
>>>>=20
>>>> + cond_resched();
>>>=20
>>> Originally we called cond_resched() once per pageblock, now it's called
>>> once per page plus for every pageblock in the tight loop that sets the
>>> migrate type. Isn't it too much?
>>=20
>> There are indeed many more cond_resched() than before, but I don=E2=80=99=
t have a
>> concise way to write it, so I took the easy way out.
>>=20
>> How about:
>>=20
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 2d680636b67a..d13a2577c4c3 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -683,7 +683,8 @@ static __meminit void pageblock_migratetype_init_rang=
e(unsigned long pfn,
>>=20
>>        for (pfn =3D pageblock_align(pfn); pfn < end; pfn +=3D pageblock_n=
r_pages) {
>>                init_pageblock_migratetype(pfn_to_page(pfn), migratetype, i=
solate);
>> -               cond_resched();
>> +               if ((pfn & (pageblock_nr_pages * 512 - 1)) =3D=3D 0)
>> +                       cond_resched();
>=20
> TBH, I don't know if 512 is the right number :)

I picked this number out of thin air. I=E2=80=99m not sure as well.

>=20
> pageblock boundary was a convenient point to have cond_resched() along wit=
h
> setting the migrate type.
>=20
> Here we might be able to squeeze more iterations between subsequent
> cond_resched() calls.

Choosing an appropriate number is indeed difficult. We need to consider
both unnecessary cond_resched() calls and scheduling latency, and the
specific value also depends on the current CPU performance. At the very leas=
t,
I find it hard to choose a correct value. Since we all agree it should be la=
rger
than 512, why not just pick 1024? I can't think of a good evaluation criteri=
on
or selection method either.

Thanks.

>=20
> --
> Sincerely yours,
> Mike.

