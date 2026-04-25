Return-Path: <linuxppc-dev+bounces-20099-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDFFFF885C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2026 06:57:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2gcf3JCYz2ydj;
	Sat, 25 Apr 2026 16:57:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.177
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777100242;
	cv=none; b=XjzRlNc4pww6BMD6aoa6Ak3wizLCDpidnNmrrUz/v+XkqfJkwDfjgogePhCI/KarwBH8wNGAX6ORiiVwrgnPXvgGwyv3AtEtDLEAOK40o3FOPRA0z5trMpXROtozeS8sKUl3utWlHdZ2b+hGbj3MS7R5z1aVnReIccviwYQV5Lwk92lhhHRmhqjeHxn3wIglzKUuXa9uqCABlP8IcNe/ehJE8rted5wNEj1zA5vKbJj/HHsCLR3CtSOT7PY5wImqZKLNrxlLZt1h1fL4/jCGUcZtA/NlxoDTLHq9yfjV5SrnzZsa/vXYIaPLEwC9ARp64tNvkuMlYcYvMChG4LQXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777100242; c=relaxed/relaxed;
	bh=zYW2ifPKRCyV2PZsOeVHbuMLyGxnS6SER91CdDGNAFY=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=JiNqJhEJ8nWCh53DuVdwJhSrqjGHN3f/mpU+lWXBchQIe/e6aAYvaRROGzSz+02hhTMNeOArGUF9AbK8/10p66cXY0S5HDg9gergNuY3yCqKhtlcEkVyCCjp+hbx7V37zKrGFYsZUJmNaNtXR6BjsiGBZ7FU6csoqWPNVAmMhW38FLCquLaczh/lT9tXLrL6cRH0qwzb1NXOz5U2HgK56nUWV43doKpjc+B3qlApA1U8WNySWXyijBuM6KGIZK0jVZV5XDqbc0a9rYbCsmN+Is2l71fLvbf+L3y2FnVZF7GUQ7nQWhN4bzS0yxHRgTXm0E+en6tx7xkfdz3dA/e5NQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AylBSejQ; dkim-atps=neutral; spf=pass (client-ip=95.215.58.177; helo=out-177.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AylBSejQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.177; helo=out-177.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g2gcY3wbYz2yC9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2026 16:57:15 +1000 (AEST)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777100215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zYW2ifPKRCyV2PZsOeVHbuMLyGxnS6SER91CdDGNAFY=;
	b=AylBSejQND587ibmfjqlB+qxK/iMR3t6ePfxNQ/RCPD5Bn1YQY3gQxZPjp6uA1fwooxo0r
	MFccirkxba+ZFLzmxT0TETdP1wZKBks/Kn/wJycgtRE1uukvpHOZLMK3RN8kZX+h6D+f8A
	VUjicK463RCC1H+5n817ZUiXvfh8Ftc=
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
Date: Sat, 25 Apr 2026 14:56:14 +0800
Message-Id: <7B037C2B-A0DE-4C49-9BFF-4B4D999A218D@linux.dev>
References: <2e664019-f161-44d9-a3fa-74c4d8290345@kernel.org>
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
In-Reply-To: <2e664019-f161-44d9-a3fa-74c4d8290345@kernel.org>
To: David Hildenbrand <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 25, 2026, at 14:47, David Hildenbrand (Arm) <david@kernel.org> wrot=
e:
>=20
> =EF=BB=BFOn 4/25/26 08:20, Muchun Song wrote:
>>=20
>>=20
>>>> On Apr 25, 2026, at 13:48, David Hildenbrand (Arm) <david@kernel.org> w=
rote:
>>>=20
>>> =EF=BB=BF
>>>>=20
>>>>=20
>>>> Hi David,
>>>>=20
>>>> Sorry, I missed the 1GB hugepage scenario earlier. Given that sparse_ad=
d_section()
>>>> operates on a scale between PAGES_PER_SUBSECTION and PAGES_PER_SECTION,=
 the pfn and
>>>> nr_pages parameters wouldn't be aligned with the hugepage size (pages_p=
er_compound),
>>>> but rather with the PAGES_PER_SECTION boundary. Do you think this expla=
nation makes
>>>> it clearer? In the interest of code clarity, do you think the modificat=
ion below
>>>> makes it easier to follow?
>>>>=20
>>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>>>> index 2e642c5ff3f2..ce675c5fb94d 100644
>>>> --- a/mm/sparse-vmemmap.c
>>>> +++ b/mm/sparse-vmemmap.c
>>>> @@ -658,15 +658,18 @@ static int __meminit section_nr_vmemmap_pages(uns=
igned long pfn, unsigned long n
>>>>       const unsigned int order =3D pgmap ? pgmap->vmemmap_shift : 0;
>>>>       const unsigned long pages_per_compound =3D 1UL << order;
>>>>=20
>>>> -       VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages,
>>>> -                                   min(pages_per_compound, PAGES_PER_S=
ECTION)));
>>>> +       VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTIO=
N));
>>>=20
>>> That here makes sense. We can only add/remove in multiples of PAGES_PER_=
SECTION.
>>> I think what we are saying is that we want that check in addition to the=

>>> existing min() check.
>>=20
>> Right.
>>=20
>>>=20
>>>>       VM_WARN_ON_ONCE(pfn_to_section_nr(pfn) !=3D pfn_to_section_nr(pfn=
 + nr_pages - 1));
>>>>=20
>>>>       if (!vmemmap_can_optimize(altmap, pgmap))
>>>>               return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_=
SIZE);
>>>>=20
>>>> -       if (order < PFN_SECTION_SHIFT)
>>>> +       if (order < PFN_SECTION_SHIFT) {
>>>> +               VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_c=
ompound));
>>>>               return VMEMMAP_RESERVE_NR * nr_pages / pages_per_compound=
;
>>>=20
>>> That makes sense as well, within a section, we expect that we always add=
/remove
>>> entire "compound"-managed chunks.
>>>=20
>>>> +       }
>>>> +
>>>> +       VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION))=
;
>>>=20
>>> And this is then for the case where a 1G page spans multiple sections, w=
here we
>>> expect to add/remove an entire section.
>>>=20
>>> So here, indeed the "min" makes sense. I guess we also assume:
>>>=20
>>>   VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
>>=20
>> Yes. But this one we do not need to explicit it to
>> assert it since at the front of this function we have
>>=20
>> VM_WARN_ON_ONCE(pfn_to_section_nr(pfn) !=3D pfn_to_section_nr(pfn + nr_pa=
ges - 1));
>=20
> Ah, yes. The alignment checks + VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTI=
ON);
> however imply that.
>=20
> So you could simplify by using that check instead of the pfn_to_section_nr=
() check.
>=20
> But it's still early here ... so whatever you prefer :)

Thanks for the suggestion. I think your approach is also
good =E2=80=94 at least it looks shorter and cleaner. I'll switch to
using VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION) instead.

Thanks.

>=20
> --
> Cheers,
>=20
> David

