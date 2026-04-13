Return-Path: <linuxppc-dev+bounces-19690-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C983F34C49
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 12:48:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvRzZ58Qnz2ydn;
	Mon, 13 Apr 2026 22:48:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776084522;
	cv=none; b=UIrPLEoyJrCXaX2o4D0HMMLzFREuNN/bv1s9M1t/fgxacjykAi9Qm4eHUsBkVJkcxPjG7UWj6olPOR/u4U4HPmUCShzeFFBibpXtRIo38J1my0GqSdrDVpwtvWfH4k1QBi/uPtggQkqKTmWqikZ7/vv/FPrSEjn4PDjkgqY3rAfou92VOrKCl38qsVA3f27i54CiR9O3rwtfcUjRUw42m45EUW2HSU9I+9R9+RyLWO71HSptR5Zhpt4ix4UAWhFS5XYkn77/sZ/XBvP5k1Zyhr52sCYs9S6YJak05SNUTb4rOtIsWYIxERj12kU0QFexm9DAGFKdQGZvs9nT13UGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776084522; c=relaxed/relaxed;
	bh=zdfAjxhRsl2+AREvfePGH23u3lRiFYRNi2DHKhHln2k=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=OJJnquQS7I1RdD/nsKXySOGJNIWmfrmMAFTW0qKvs2Sw57WtQJOygccMAli/lEXHZy6TyHNygQffvpfa1acfd+eNIZg7V11Tw8Zh/vq1aWuT3CLaOY69JLd/kg1VJa8k1iPP7694w7/z14W1t37Lvhv0aCQFRIEGbsXwZBuHh6imjBq1/r6S8Wu5qf9LP1387Xc0oq2eW9Iv3fIFK9hQj7d+oQ/5bwkzXt8n5Gz7dL16w1CGX9UVjLM89T2rlrT/tdGTJRSdWB8S1EoOUd5XtjEXP2aW/R4d7pf4EY5tKTAxV3QCC3rzDdJNMYWhU9whO7FxZoA4l4aue9Xld9775g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nE5VYNAw; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b1; helo=out-177.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nE5VYNAw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b1; helo=out-177.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 9592 seconds by postgrey-1.37 at boromir; Mon, 13 Apr 2026 22:48:39 AEST
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvRzW1bkyz2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 22:48:37 +1000 (AEST)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776084492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdfAjxhRsl2+AREvfePGH23u3lRiFYRNi2DHKhHln2k=;
	b=nE5VYNAwk/69hYOoOByq/8wh/JZBJg16bR2vH8D/XiuneHiHEafQ/FFFrao5O/GxJPSdv1
	0/soNVIqBY9ziLV6FXp9cYu6u64On/Asc235Aazy8XEamU408vuxPmoSSxPdkhcsqXYf4+
	9zBfORBJFl+gW2g0jIAnGHjOPH3i/mc=
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
Date: Mon, 13 Apr 2026 20:47:45 +0800
Message-Id: <8AEA6BCE-570F-4095-ADCF-9699BDE0DD64@linux.dev>
References: <adzb5o9aWxFWphRK@kernel.org>
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
In-Reply-To: <adzb5o9aWxFWphRK@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT


Sent from my iPad

> On Apr 13, 2026, at 20:05, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> =EF=BB=BFOn Mon, Apr 13, 2026 at 05:49:17PM +0800, Muchun Song wrote:
>>=20
>>=20
>>>> On Apr 13, 2026, at 17:35, Mike Rapoport <rppt@kernel.org> wrote:
>>>=20
>>> On Mon, Apr 13, 2026 at 12:19:50PM +0300, Mike Rapoport wrote:
>>>> On Sun, Apr 05, 2026 at 08:51:52PM +0800, Muchun Song wrote:
>>>>> In section_activate(), if populate_section_memmap() fails, the error
>>>>> handling path calls section_deactivate() to roll back the state. This
>>>>> approach introduces an accounting imbalance.
>>>>>=20
>>>>> Since the commit c3576889d87b ("mm: fix accounting of memmap pages"),
>>>>> memmap pages are accounted for only after populate_section_memmap()
>>>>> succeeds. However, section_deactivate() unconditionally decrements the=

>>>>> vmemmap account. Consequently, a failure in populate_section_memmap()
>>>>> leads to a negative offset (underflow) in the system's vmemmap trackin=
g.
>>>>>=20
>>>>> We can fix this by ensuring that the vmemmap accounting is incremented=

>>>>> immediately before checking for the success of populate_section_memmap=
().
>>>>> If populate_section_memmap() fails, the subsequent call to
>>>>> section_deactivate() will decrement the accounting, perfectly offsetti=
ng
>>>>> the increment and maintaining balance.
>>>>>=20
>>>>> Fixes: c3576889d87b ("mm: fix accounting of memmap pages")
>>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>>> ---
>>>>> mm/sparse-vmemmap.c | 2 +-
>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>=20
>>>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>>>>> index 6eadb9d116e4..ee27d0c0efe2 100644
>>>>> --- a/mm/sparse-vmemmap.c
>>>>> +++ b/mm/sparse-vmemmap.c
>>>>> @@ -822,11 +822,11 @@ static struct page * __meminit section_activate(=
int nid, unsigned long pfn,
>>>>> return pfn_to_page(pfn);
>>>>>=20
>>>>> memmap =3D populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);=

>>>>> + memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_S=
IZE));
>>>>=20
>>>> This logically belongs to success path in populate_section_memmap(). If=
 we
>>>> update the counter there, we won't need to temporarily increase it at a=
ll.
>>>=20
>>> Not strictly related to this patchset, but it seems, we can have a singl=
e
>>> memmap_boot_pages_add() in memmap_alloc() rather than to update the coun=
ter
>>> in memmap_alloc() callers.
>>=20
>> It will indeed become simpler and is a good cleanup direction, but there
>> is a slight change in semantics: the page tables used for vmemmap page
>> mapping will also be counted in memmap_boot_pages_add(). This might not
>> be an issue (after all, the size of the page tables is very small compare=
d
>> to struct pages, right?).
>>=20
>> Additionally, I still lean toward making no changes to this patch, becaus=
e
>> this is a pure bugfix patch =E2=80=94 of course, it is meant to facilitat=
e backporting
>> for those who need it. The cleanup would involve many more changes, so I
>> prefer to do that in a separate patch. What do you think?
>=20
> For this patch and easy backporting I still think that cleaner to have the=

> counter incremented in populate_section_memmap() rather immediately after
> it.

Hi Mike,

Alright, let=E2=80=99s revisit your solution. After we=E2=80=99ve moved the c=
ounter into the=20
populate_section_memmap(), we still need to increase the counter temporarily=

(but in populate_section_memmap()) even if we fail to populate. That=E2=80=99=
s
because section_deactivate() reduces the counter without exception, isn=E2=80=
=99t it?
Just want to make sure we are on the same page on the meaning of =E2=80=9Cte=
mporarily
increase=E2=80=9D.  Maybe you do not mean =E2=80=9Ctemporarily=E2=80=9D in t=
his case.

Thanks,
Muchun.

>=20
>> Thanks,
>> Muchun.
>>=20
>>>=20
>>>>> if (!memmap) {
>>>>> section_deactivate(pfn, nr_pages, altmap);
>>>>> return ERR_PTR(-ENOMEM);
>>>>> }
>>>>> - memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_S=
IZE));
>>>>>=20
>>>>> return memmap;
>>>>> }
>>>>> --
>>>>> 2.20.1
>>>>>=20
>>>>=20
>>>> --
>>>> Sincerely yours,
>>>> Mike.
>>>=20
>>> --
>>> Sincerely yours,
>>> Mike.
>>=20
>>=20
>>=20
>=20
> --
> Sincerely yours,
> Mike.

