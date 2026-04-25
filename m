Return-Path: <linuxppc-dev+bounces-20097-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB875FF885A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2026 06:21:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2fqT2LB2z2ynh;
	Sat, 25 Apr 2026 16:21:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777098101;
	cv=none; b=KAC5ckoI9sTIjX5jU42u+XPA9uwfCcU3+DW2C8X6KbHI002pkV4dE4IXQlyQbIoWBkxZ0U/Ac266L8e0+ajxIXyQfPsMGrg5NmZ3amWvuKtJLl3XYl1NRbPQ2RNGkfi7+OUdRykQi199dk4m/Df6qQVY8NrlIGf8tmMmVggVFc2pI7D0/FuTFTUUQKOmLoUCb09oY5qXxughSuyowSd4QUohhc7atOxSP9KdxQYhehOlJkZUbOBlPUJeImHwdz+TM+U9agAdh4NKMa5qzwENdnQpHlmi9ITNYIgqvRBOLE4U7y91voNcHa+WDHgPznad2ETATnP0tUHIrU4jcUemvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777098101; c=relaxed/relaxed;
	bh=DHZLJC5B5fmgRAOtQknXGM+s5bBWV7trEmZX8TH0Pyk=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Cka/W+Uub7axCQm2YFnYmJr7R5vuMck4cdxL4eJPmjdutFwkp7+uPMr2Ywxh7CiQDfbx0ARjDVScM6rOancti3edefdMd8wxLBqzaSFtnEgcEgoPzoSX4yVc1vCGdhW8Iv0BZEjBMO0wpGzHtUUEFk+ygEggmATDC7vT1Ddy/PVlHi0Y9BfQUDpLEnwDEcDAFF5FurQzmEyprZyM9nTjnAdEg5d4JL8yC6I+MHEJnuE58KZWKTDSoCQfgldDK1axHyedv/i40YWdNXgkBOq9NSA5QAmpCqGIr/u8n5PUonNRXdUcSQOafjubLkR/QSKbpe18FBQ8vMGHfn4jWCCf8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZCQSa0xM; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b2; helo=out-178.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZCQSa0xM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b2; helo=out-178.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g2fqQ2ddPz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2026 16:21:36 +1000 (AEST)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777098076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DHZLJC5B5fmgRAOtQknXGM+s5bBWV7trEmZX8TH0Pyk=;
	b=ZCQSa0xMAWeLz4zqajISETfXw0jpqKglaKesdUOywfIFOqHdjirtt+ma6LodskeBqPJfos
	2sHx8WiBaja3NZLDcHxvFAt1HvSgu28BujosBA5ALe9pIqvU8pMspNe8EEj4HliRx0V/0y
	I+S/2Px5CbIdsYh0eu/l0FH2uqJGXlQ=
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
Subject: Re: [PATCH v6 4/7] mm/sparse-vmemmap: Fix DAX vmemmap accounting with optimization
Date: Sat, 25 Apr 2026 14:20:39 +0800
Message-Id: <17902B08-7487-4FC8-8EBC-268CE5F3E1B9@linux.dev>
References: <02e35414-8c30-4753-9403-432d90263f39@kernel.org>
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Liam R Howlett <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 aneesh.kumar@linux.ibm.com, joao.m.martins@oracle.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
In-Reply-To: <02e35414-8c30-4753-9403-432d90263f39@kernel.org>
To: David Hildenbrand <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 25, 2026, at 13:48, David Hildenbrand (Arm) <david@kernel.org> wrot=
e:
>=20
> =EF=BB=BF
>>=20
>>=20
>> Hi David,
>>=20
>> Sorry, I missed the 1GB hugepage scenario earlier. Given that sparse_add_=
section()
>> operates on a scale between PAGES_PER_SUBSECTION and PAGES_PER_SECTION, t=
he pfn and
>> nr_pages parameters wouldn't be aligned with the hugepage size (pages_per=
_compound),
>> but rather with the PAGES_PER_SECTION boundary. Do you think this explana=
tion makes
>> it clearer? In the interest of code clarity, do you think the modificatio=
n below
>> makes it easier to follow?
>>=20
>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>> index 2e642c5ff3f2..ce675c5fb94d 100644
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>> @@ -658,15 +658,18 @@ static int __meminit section_nr_vmemmap_pages(unsig=
ned long pfn, unsigned long n
>>        const unsigned int order =3D pgmap ? pgmap->vmemmap_shift : 0;
>>        const unsigned long pages_per_compound =3D 1UL << order;
>>=20
>> -       VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages,
>> -                                   min(pages_per_compound, PAGES_PER_SEC=
TION)));
>> +       VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION)=
);
>=20
> That here makes sense. We can only add/remove in multiples of PAGES_PER_SE=
CTION.
> I think what we are saying is that we want that check in addition to the
> existing min() check.

Right.

>=20
>>        VM_WARN_ON_ONCE(pfn_to_section_nr(pfn) !=3D pfn_to_section_nr(pfn +=
 nr_pages - 1));
>>=20
>>        if (!vmemmap_can_optimize(altmap, pgmap))
>>                return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_S=
IZE);
>>=20
>> -       if (order < PFN_SECTION_SHIFT)
>> +       if (order < PFN_SECTION_SHIFT) {
>> +               VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_com=
pound));
>>                return VMEMMAP_RESERVE_NR * nr_pages / pages_per_compound;=

>=20
> That makes sense as well, within a section, we expect that we always add/r=
emove
> entire "compound"-managed chunks.
>=20
>> +       }
>> +
>> +       VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
>=20
> And this is then for the case where a 1G page spans multiple sections, whe=
re we
> expect to add/remove an entire section.
>=20
> So here, indeed the "min" makes sense. I guess we also assume:
>=20
>    VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);

Yes. But this one we do not need to explicit it to
assert it since at the front of this function we have

VM_WARN_ON_ONCE(pfn_to_section_nr(pfn) !=3D pfn_to_section_nr(pfn + nr_pages=
 - 1));

to make sure the passing range belongs to one section.

Thanks.

>=20
> Looks better to me!
>=20
> --
> Cheers,
>=20
> David

