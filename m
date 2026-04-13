Return-Path: <linuxppc-dev+bounces-19701-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A39BF34C59
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 14:26:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvTxz1nygz2yjV;
	Tue, 14 Apr 2026 00:17:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.181
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776089847;
	cv=none; b=hdF/cwFyb+kU0s+ocqx55CUFIKal68p2I8J2ImSL6hAhXjjY42qWoarB+8iu4ZdfLcig9PwNI/m/SaGpYqexwa98DQUVj8BAKS2/01u9Gi2+tEvGHgbuUeCDPEvdtA1Pi4P4mRU9/qBHsnhVq1ZVW0WD8IOD5oI88Gemcvz/xTaF9BittoA/1NdNLrR3biGQRTXX7gxSzG3ab8JiuUUu3ccB50pYr701YeuZmejAFsBAHo3yO9km+t4u8oG2qIVK1y4+vqVJsx7+tQfXTE0tSYyKPh8PHS84t/og4GJPp4r49Ji7Ya/GxgNq6kf5bgrI/VdE3gnqk4bg5urtEeFKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776089847; c=relaxed/relaxed;
	bh=5Kzkhn3LFWO3+QSE/fQj/hH3qJPFehnDOa4OjhTu82w=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Sx2Wt82fBVxYl18FJkE6KmIbyjvqEoWafi/BeA1rgq/FuuUoK2mPs2IZNwAvKk3giCpU+DpH0dp3ZpJqa0o+eXj4NRFIHBdUD0Fp2v2Ad9z+wwcojgp+bL3jedFuA+tVPM0ZVyXgyapJsGrbE4DqJ916CG1VUtTS/AUrVh41QAD0afnyDw8Rj3P+syIdArsA4h+tOmVrk4AUgFi8fxSh+sHTkeWn5Ec9VmGmTIB/mV0ZUKXTsbSsXjfUj1VhQ2PlwDRG+vP6Mp/oiz8KqYQsNfJEi+U8HiTwwP12wula4IHZK29hnvlzx8rbIj/3V1HxoFN7JCqjpxIT2lbj+8m0tA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Tat+hmEl; dkim-atps=neutral; spf=pass (client-ip=91.218.175.181; helo=out-181.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Tat+hmEl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.181; helo=out-181.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvTxt21Jmz2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 00:17:16 +1000 (AEST)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776089811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Kzkhn3LFWO3+QSE/fQj/hH3qJPFehnDOa4OjhTu82w=;
	b=Tat+hmEl4LkYQIHCK1EKoRWrUNb7DtBDa9KMzVcByj1HdimbvKHuSURjjlcj/voNVEuEJu
	17NRVMv2anbHCIs+VBh9J0mCkoI+wiTqWkYKSat0cu6ljmDFzRXwLJdVwBPFJUkJ1yTj83
	hm/N7D4bqI1p4sipyGvCWKX/p/tPtMI=
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
Date: Mon, 13 Apr 2026 22:16:20 +0800
Message-Id: <48CF5603-D8E1-4C86-8554-E8BA03D195FB@linux.dev>
References: <9642F4D9-8F1B-47A4-90BE-C72BB8DE9A11@linux.dev>
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
In-Reply-To: <9642F4D9-8F1B-47A4-90BE-C72BB8DE9A11@linux.dev>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 13, 2026, at 22:05, Muchun Song <muchun.song@linux.dev> wrote:
>=20
> =EF=BB=BF
>=20
>> On Apr 13, 2026, at 21:36, Mike Rapoport <rppt@kernel.org> wrote:
>>=20
>> =EF=BB=BFHi Muchun,
>=20
> Hi,
>=20
>>=20
>> On Mon, Apr 13, 2026 at 08:47:45PM +0800, Muchun Song wrote:
>>>>>> On Apr 13, 2026, at 20:05, Mike Rapoport <rppt@kernel.org> wrote:
>>>>>>>>>>=20
>>>>>>>>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>>>>>>>>>> index 6eadb9d116e4..ee27d0c0efe2 100644
>>>>>>>>>> --- a/mm/sparse-vmemmap.c
>>>>>>>>>> +++ b/mm/sparse-vmemmap.c
>>>>>>>>>> @@ -822,11 +822,11 @@ static struct page * __meminit section_acti=
vate(int nid, unsigned long pfn,
>>>>>>>>>> return pfn_to_page(pfn);
>>>>>>>>>>=20
>>>>>>>>>> memmap =3D populate_section_memmap(pfn, nr_pages, nid, altmap, pg=
map);
>>>>>>>>>> + memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), P=
AGE_SIZE));
>>>>>>>>>=20
>>>>>>>>> This logically belongs to success path in populate_section_memmap(=
). If we
>>>>>>>>> update the counter there, we won't need to temporarily increase it=
 at all.
>>>>>>>>=20
>>>>>>>> Not strictly related to this patchset, but it seems, we can have a s=
ingle
>>>>>>>> memmap_boot_pages_add() in memmap_alloc() rather than to update the=
 counter
>>>>>>>> in memmap_alloc() callers.
>>>>>>>=20
>>>>>>> It will indeed become simpler and is a good cleanup direction, but t=
here
>>>>>>> is a slight change in semantics: the page tables used for vmemmap pa=
ge
>>>>>>> mapping will also be counted in memmap_boot_pages_add(). This might n=
ot
>>>>>>> be an issue (after all, the size of the page tables is very small co=
mpared
>>>>>>> to struct pages, right?).
>>>>>>>=20
>>>>>>> Additionally, I still lean toward making no changes to this patch, b=
ecause
>>>>>>> this is a pure bugfix patch =E2=80=94 of course, it is meant to faci=
litate backporting
>>>>>>> for those who need it. The cleanup would involve many more changes, s=
o I
>>>>>>> prefer to do that in a separate patch. What do you think?
>>>>>=20
>>>>> For this patch and easy backporting I still think that cleaner to have=
 the
>>>>> counter incremented in populate_section_memmap() rather immediately af=
ter
>>>>> it.
>>>=20
>>> Hi Mike,
>>>=20
>>> Alright, let=E2=80=99s revisit your solution. After we=E2=80=99ve moved t=
he counter into the
>>> populate_section_memmap(), we still need to increase the counter tempora=
rily
>>> (but in populate_section_memmap()) even if we fail to populate. That=E2=80=
=99s
>>> because section_deactivate() reduces the counter without exception, isn=E2=
=80=99t it?
>>> Just want to make sure we are on the same page on the meaning of =E2=80=9C=
temporarily
>>> increase=E2=80=9D.  Maybe you do not mean =E2=80=9Ctemporarily=E2=80=9D i=
n this case.
>>=20
>> I suggest to increase the counter only if we succeeded to populate:
>>=20
>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>> index 6eadb9d116e4..247fd54f1003 100644
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>> @@ -656,7 +656,13 @@ static struct page * __meminit populate_section_memm=
ap(unsigned long pfn,
>>       unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
>>       struct dev_pagemap *pgmap)
>> {
>> -    return __populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);=

>> +    struct page *p =3D __populate_section_memmap(pfn, nr_pages, nid, alt=
map,
>> +                           pgmap);
>> +
>> +    if (p)
>> +        memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PA=
GE_SIZE));
>=20
> We don=E2=80=99t increase the counter on failure, then
>=20
>> +
>> +    return p;
>> }
>>=20
>> static void depopulate_section_memmap(unsigned long pfn, unsigned long nr=
_pages,
>> @@ -826,7 +832,6 @@ static struct page * __meminit section_activate(int n=
id, unsigned long pfn,
>>       section_deactivate(pfn, nr_pages, altmap);
>=20
> here section_deactivate() is called, which decrease the counter unconditio=
nally,
> the issue still exists. We didn't fix anything.
>=20
> Thanks.
>=20
>>       return ERR_PTR(-ENOMEM);
>>   }
>> -    memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_S=
IZE));
>>=20
>>   return memmap;
>> }
>>=20
>>=20
>> Then we'll better follow "all or nothing" principle and won't have
>> exceptional cases in section_deactivate().

To follow  "all or nothing" principle here, I think we should not call
section_deactivate() to do the cleanup in section_activate().

After all, if section_activate() didn't succeed, how can we use
section_deactivate() to release the resources? What do you think?

Thanks.

>>=20
>>> Thanks,
>>> Muchun.
>>=20
>> --
>> Sincerely yours,
>> Mike.

