Return-Path: <linuxppc-dev+bounces-19700-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31559F34C54
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 14:06:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvTjR3DYTz2ydn;
	Tue, 14 Apr 2026 00:06:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776089195;
	cv=none; b=aEDeNj0j/aCKIbbTIjw1Fn6LKBrpIkFk+Yd0eDJXTbKu69gZsmjWExzELF8OINyt0rj4P/Wqa/UXAew/dNp9IFgME5/3IGk20eUqjiFjAKhOhSQJ2vYmBnkwR4ie+QKeQUzrkaGOslL1rBFExtDcyLZPdodUPihfh+maFPPrUhypq4fSQ5oFigMeCM2b0g1HgL1lhGue873yL92kmGE+CV7Naudsqq5UtYJqwuSPkxKwQivc7TKBEB/XKsdb1I2+UL0760kD2kkiiFSW9LTRUgM+d6ov430K6dglwWNx/eK/An7MfWs5jI2SQbuz8a1tOiVe+Jlpq2Trt7OFxTT8gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776089195; c=relaxed/relaxed;
	bh=LUfrQZBP/ZyxZwE2DiN7BB9ru8IXfCgKr+W6yEpjREU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=h2ol4v8aTl2VoVqKh4uSl4SJZlsLsve1AwSSsQy3wA7k+q2pOCDoGYdA8oDcYvNmfZPVkBh6QF/yeyG2y2dX15SgO3vF2G9AD4CWHbcYA/l84QqlLCe6cM/A/Bpo0gUF3WnoD43pf0A3kcO+y5O0u6TVXGWf542INWnMKu/FjFVoojV5hcEPQcod6rhvhN1/JfjANO6dzmG3GfNdZkEDaWJ+HxZk7OwxFCJYmWOzkrYOZ8ZL5V5JQWD9/GOcc0VA8fKeYXx5qWQwcxLfFLzqsi93a8VqAnMXDq3bgdgORUYTHj3sktU/HSpeZbuo3xz+SSHnqjOIJWZyQyKxVTHnvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=K0xst7Ry; dkim-atps=neutral; spf=pass (client-ip=95.215.58.187; helo=out-187.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=K0xst7Ry;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.187; helo=out-187.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvTjQ011Vz2yS9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 00:06:33 +1000 (AEST)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776089168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUfrQZBP/ZyxZwE2DiN7BB9ru8IXfCgKr+W6yEpjREU=;
	b=K0xst7RydEesK7u/I0oErZaYxbMcx5zzyAsnS8H6GKxD9Ov5nuyoHtuE9XB5fGt4bZHMD0
	p2LcX5tCqoEK0KvpClSKLPtcK+QYnapEe/SKzlBMfyIDgptXBNEvufSuDbVkGcOjB3oEau
	nqdpsWfAeywtCPt8EBRTdgheme5+qTI=
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
Subject: Re: [PATCH 01/49] mm/sparse: fix vmemmap accounting imbalance on memory hotplug error
Date: Mon, 13 Apr 2026 22:05:34 +0800
Message-Id: <9642F4D9-8F1B-47A4-90BE-C72BB8DE9A11@linux.dev>
References: <adzxNAa7RnUDrykW@kernel.org>
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
In-Reply-To: <adzxNAa7RnUDrykW@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 13, 2026, at 21:36, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> =EF=BB=BFHi Muchun,

Hi,

>=20
> On Mon, Apr 13, 2026 at 08:47:45PM +0800, Muchun Song wrote:
>>>> On Apr 13, 2026, at 20:05, Mike Rapoport <rppt@kernel.org> wrote:
>>>>>>>>=20
>>>>>>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>>>>>>>> index 6eadb9d116e4..ee27d0c0efe2 100644
>>>>>>>> --- a/mm/sparse-vmemmap.c
>>>>>>>> +++ b/mm/sparse-vmemmap.c
>>>>>>>> @@ -822,11 +822,11 @@ static struct page * __meminit section_activa=
te(int nid, unsigned long pfn,
>>>>>>>> return pfn_to_page(pfn);
>>>>>>>>=20
>>>>>>>> memmap =3D populate_section_memmap(pfn, nr_pages, nid, altmap, pgma=
p);
>>>>>>>> + memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAG=
E_SIZE));
>>>>>>>=20
>>>>>>> This logically belongs to success path in populate_section_memmap().=
 If we
>>>>>>> update the counter there, we won't need to temporarily increase it a=
t all.
>>>>>>=20
>>>>>> Not strictly related to this patchset, but it seems, we can have a si=
ngle
>>>>>> memmap_boot_pages_add() in memmap_alloc() rather than to update the c=
ounter
>>>>>> in memmap_alloc() callers.
>>>>>=20
>>>>> It will indeed become simpler and is a good cleanup direction, but the=
re
>>>>> is a slight change in semantics: the page tables used for vmemmap page=

>>>>> mapping will also be counted in memmap_boot_pages_add(). This might no=
t
>>>>> be an issue (after all, the size of the page tables is very small comp=
ared
>>>>> to struct pages, right?).
>>>>>=20
>>>>> Additionally, I still lean toward making no changes to this patch, bec=
ause
>>>>> this is a pure bugfix patch =E2=80=94 of course, it is meant to facili=
tate backporting
>>>>> for those who need it. The cleanup would involve many more changes, so=
 I
>>>>> prefer to do that in a separate patch. What do you think?
>>>=20
>>> For this patch and easy backporting I still think that cleaner to have t=
he
>>> counter incremented in populate_section_memmap() rather immediately afte=
r
>>> it.
>>=20
>> Hi Mike,
>>=20
>> Alright, let=E2=80=99s revisit your solution. After we=E2=80=99ve moved t=
he counter into the
>> populate_section_memmap(), we still need to increase the counter temporar=
ily
>> (but in populate_section_memmap()) even if we fail to populate. That=E2=80=
=99s
>> because section_deactivate() reduces the counter without exception, isn=E2=
=80=99t it?
>> Just want to make sure we are on the same page on the meaning of =E2=80=9C=
temporarily
>> increase=E2=80=9D.  Maybe you do not mean =E2=80=9Ctemporarily=E2=80=9D i=
n this case.
>=20
> I suggest to increase the counter only if we succeeded to populate:
>=20
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 6eadb9d116e4..247fd54f1003 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -656,7 +656,13 @@ static struct page * __meminit populate_section_memma=
p(unsigned long pfn,
>        unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
>        struct dev_pagemap *pgmap)
> {
> -    return __populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
> +    struct page *p =3D __populate_section_memmap(pfn, nr_pages, nid, altm=
ap,
> +                           pgmap);
> +
> +    if (p)
> +        memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAG=
E_SIZE));

We don=E2=80=99t increase the counter on failure, then

> +
> +    return p;
> }
>=20
> static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_=
pages,
> @@ -826,7 +832,6 @@ static struct page * __meminit section_activate(int ni=
d, unsigned long pfn,
>        section_deactivate(pfn, nr_pages, altmap);

here section_deactivate() is called, which decrease the counter unconditiona=
lly,
the issue still exists. We didn't fix anything.

Thanks.

>        return ERR_PTR(-ENOMEM);
>    }
> -    memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SI=
ZE));
>=20
>    return memmap;
> }
>=20
>=20
> Then we'll better follow "all or nothing" principle and won't have
> exceptional cases in section_deactivate().
>=20
>> Thanks,
>> Muchun.
>=20
> --
> Sincerely yours,
> Mike.

