Return-Path: <linuxppc-dev+bounces-19675-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179F2EBFD22
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 09:52:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvN3r4lQyz2yYs;
	Mon, 13 Apr 2026 19:52:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776073928;
	cv=none; b=CArAFEOh4FGC7fj7WXa716VXVDoNto+xlYHbco0WdAL/0guJmYZTKia3H3bQcnS60m59dGPbBWdXgz3hdaMGmCKi3QqU7eEt/EK2tVDM1isP3BOsZo/hzElk4YR1jcDpPNzHEqH0IxnzaSI3ODsIJfJ9M3zizDmVJfbLbn0dgZ9ARP4FVVdfnbrtSHgMHpccpwcWqggQXGbJDYJ0Z/paB567Xm5DhPee5ZzbsxVPLCf//7eqbgLF4LgSmR7Y/038yVUqRAUUH0NBGpYTW13nYDyUIwS1xzFzLlmt8bMjqvP994T9wB43ghVp8ge2oxylepRjo8s0cO7goM/8NGvIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776073928; c=relaxed/relaxed;
	bh=QPYOp4SQxJnwqDa7dtThbAGyQONRoG1+/Tuu6VpyDD4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cPozJpjypX9te6BjQNG0TN0mxi8ABQr1sh+9+TVdAC/2pCwRs+RSFALDDli2bFXWJ+PlvGjxSctKIsiV4IfnS7hnHDPw35e+5bGMsVNbjrRzRFREuXQOPcnC7jhref20WVO9j13pXup3vZ0+vZ9Rsa3TR4BMXphocO5t4s5mCxGsMankx6ifv08cRMEwJUGoF+zXZepcnhq7APj6b1iRXbgMUlrNRi2w7voY0ndB/WTqKdwMocJwp2nc4a4BScRSe6y+8VxUYQrJBQtvQcaVwKK6xwL0Go1AG45G9UrmweM/nuPHpr4w7Oo0w2Ggj9Gl2+OIJ+WWsL+2dm07oHDpbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gpzednZO; dkim-atps=neutral; spf=pass (client-ip=95.215.58.188; helo=out-188.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gpzednZO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.188; helo=out-188.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 90 seconds by postgrey-1.37 at boromir; Mon, 13 Apr 2026 19:52:05 AEST
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvN3n4C2qz2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 19:52:05 +1000 (AEST)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776073813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPYOp4SQxJnwqDa7dtThbAGyQONRoG1+/Tuu6VpyDD4=;
	b=gpzednZOE7T4VRbmaNwl/0LR5EKOY7DV6qB8eeeTSzNFlQ8kEWHKOXH1Ftf8s64zXzdrEW
	GG1v4unDi5PvSisJIE+sPNXmm7uXoyv7CY5HGJ5qRQYR0917YaeGHqzhFRFwHqRWrNXpWL
	J7ZXICa5XaP1N13mEBFAZZS+be30RtE=
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
Subject: Re: [PATCH 01/49] mm/sparse: fix vmemmap accounting imbalance on
 memory hotplug error
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ady40BWw5WgQHf3z@kernel.org>
Date: Mon, 13 Apr 2026 17:49:17 +0800
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
Message-Id: <35454ADD-C983-4577-997E-884266C56FB6@linux.dev>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-2-songmuchun@bytedance.com>
 <ady1LQMN1xhPGcuT@kernel.org> <ady40BWw5WgQHf3z@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 13, 2026, at 17:35, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Mon, Apr 13, 2026 at 12:19:50PM +0300, Mike Rapoport wrote:
>> On Sun, Apr 05, 2026 at 08:51:52PM +0800, Muchun Song wrote:
>>> In section_activate(), if populate_section_memmap() fails, the error
>>> handling path calls section_deactivate() to roll back the state. =
This
>>> approach introduces an accounting imbalance.
>>>=20
>>> Since the commit c3576889d87b ("mm: fix accounting of memmap =
pages"),
>>> memmap pages are accounted for only after populate_section_memmap()
>>> succeeds. However, section_deactivate() unconditionally decrements =
the
>>> vmemmap account. Consequently, a failure in =
populate_section_memmap()
>>> leads to a negative offset (underflow) in the system's vmemmap =
tracking.
>>>=20
>>> We can fix this by ensuring that the vmemmap accounting is =
incremented
>>> immediately before checking for the success of =
populate_section_memmap().
>>> If populate_section_memmap() fails, the subsequent call to
>>> section_deactivate() will decrement the accounting, perfectly =
offsetting
>>> the increment and maintaining balance.
>>>=20
>>> Fixes: c3576889d87b ("mm: fix accounting of memmap pages")
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> ---
>>> mm/sparse-vmemmap.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>>> index 6eadb9d116e4..ee27d0c0efe2 100644
>>> --- a/mm/sparse-vmemmap.c
>>> +++ b/mm/sparse-vmemmap.c
>>> @@ -822,11 +822,11 @@ static struct page * __meminit =
section_activate(int nid, unsigned long pfn,
>>> return pfn_to_page(pfn);
>>>=20
>>> memmap =3D populate_section_memmap(pfn, nr_pages, nid, altmap, =
pgmap);
>>> + memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), =
PAGE_SIZE));
>>=20
>> This logically belongs to success path in populate_section_memmap(). =
If we
>> update the counter there, we won't need to temporarily increase it at =
all.
>=20
> Not strictly related to this patchset, but it seems, we can have a =
single
> memmap_boot_pages_add() in memmap_alloc() rather than to update the =
counter
> in memmap_alloc() callers.

It will indeed become simpler and is a good cleanup direction, but there
is a slight change in semantics: the page tables used for vmemmap page
mapping will also be counted in memmap_boot_pages_add(). This might not
be an issue (after all, the size of the page tables is very small =
compared
to struct pages, right?).

Additionally, I still lean toward making no changes to this patch, =
because
this is a pure bugfix patch =E2=80=94 of course, it is meant to =
facilitate backporting
for those who need it. The cleanup would involve many more changes, so I
prefer to do that in a separate patch. What do you think?

Thanks,
Muchun.

>=20
>>> if (!memmap) {
>>> section_deactivate(pfn, nr_pages, altmap);
>>> return ERR_PTR(-ENOMEM);
>>> }
>>> - memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), =
PAGE_SIZE));
>>>=20
>>> return memmap;
>>> }
>>> --=20
>>> 2.20.1
>>>=20
>>=20
>> --=20
>> Sincerely yours,
>> Mike.
>=20
> --=20
> Sincerely yours,
> Mike.



