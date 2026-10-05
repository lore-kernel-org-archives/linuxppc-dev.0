Return-Path: <linuxppc-dev+bounces-28937-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D80FCA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:28:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hz4ZV4dpdz2yTP;
	Tue, 06 Oct 2026 03:28:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::2e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791217714;
	cv=none; b=NKpwd0HLOS5IVzi0Ur/ihvXvQIItBEh6yoOLlxXZ/1bnMUTI81Ap9s1ofOwx3a3tTqx2gNWFQjLX5C7a6fqPYDKnYNnmE8P10bOtdsDTT9Ehjp2hrKBmw22FM1RoVXK3deM4Jc/Un3kL9GG2QoyQS4+m4I8wNLbQ7//DNkmg9T1LArnnDqqersZncBg/Fhkg4vQpXi3OumuFjHM15aPrzRTY9MYqzpu0Fi16kwrc01tx8QU3waD4zYcIsJbZrfgMkckE99PpBO5hF5HXX4wuHpDSPEWlyzI/YAc1SQBNIu2D4I+65d6lLaiLXqxfJIXAnCjsb4ut0r2rhBYeaC+Cpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791217714; c=relaxed/relaxed;
	bh=9+Tmnole7q0+tJ56UU4LkJKNC6EUiAUTbjpFGb9K7q4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mOdoOeuy1HsvOgN/GXirXKt8H+TddI4P+R32xmxZ7m9O8zL/+ynYWRAzFl05XsGrU7jSJWt9+N5R+HtX1SE5g3+QJTcJT+rc5R8Gp0Ctvdt1ogVWoEOhWZ/H2qG86N4IRLop8nk7s0eX2UEduvvY7+B8vqSaPvB1G1adhDdoJt3TdS6z+b9gVL6XzBjJ/4yqqNQtEeBaKYnTV2X6e3ZWY+ZFg7GHOHRwb+kYbW24b9q/9K6HVs27YFrAB36jy8mHAilSM12q3b6zO6u03OWFf7YVxR6lpj6vABDU5B5RyS10G9nuE2uMp9WdFkU9byxewPGw9pyg6bMl/xpSX/RFEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kl5Mb8yq; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::2e; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kl5Mb8yq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::2e; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-46.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hz4ZQ4rqZz2y8G
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 03:28:29 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=9+Tmnole7q0+tJ56UU4LkJKNC6EUiAUTbjpFGb9K7q4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791217685; v=1; x=1791822485;
 b=kl5Mb8yqAuBa1ysN4KRQ/JRXmdxeVWgpzqucHYaDFiWSuE1w7xoNqVIahcjpYYtcpmdvXvuQ
 z35vK9O03ciH2ppTch+uh8c6aUlBdcdWtI4eKsFBFDBA+lwCvzrfVvnJLg7jd5IIVVxrDw0T4hs
 FHVSGsQ3NMaX0drJVlCzGlfQ=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id fa22e0d45fa7ff67;
	Mon, 05 Oct 2026 16:28:04 +0000
X-Mizu-Trace-ID: fa22e0d45fa7ff67
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=utf-8
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH v3 6/6] mm/mm_init: add zone mismatch warning during page
 init
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ar_0GLYM6KsIH6tQ@kernel.org>
Date: Mon, 5 Oct 2026 18:27:52 +0200
Cc: Muchun Song <songmuchun@bytedance.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Qi Zheng <qi.zheng@linux.dev>,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D91CEA1E-6B79-434D-AF49-16C62C0FD095@linux.dev>
References: <20260929053231.66085-1-songmuchun@bytedance.com>
 <20260929053231.66085-7-songmuchun@bytedance.com>
 <ar5xbQsUpSQZg0wO@kernel.org>
 <78D5D6AA-BE36-432C-B0F7-453F93DF18C0@linux.dev>
 <ar9p39Y9SmlxvbA_@kernel.org>
 <85941AA4-7E50-4AAE-BC05-0F443B21BE8B@linux.dev>
 <ar_0GLYM6KsIH6tQ@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 2, 2026, at 20:12, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Fri, Oct 02, 2026 at 05:56:40PM +0800, Muchun Song wrote:
>>> On Oct 2, 2026, at 16:22, Mike Rapoport <rppt@kernel.org> wrote:
>>=20
>>>>>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>>>>>> index 1650d6bc1211..bd02e8d06965 100644
>>>>>> --- a/mm/mm_init.c
>>>>>> +++ b/mm/mm_init.c
>>>>>> @@ -609,6 +609,9 @@ void __meminit __init_single_page(struct page =
*page, unsigned long pfn,
>>>>>> if (!is_highmem_idx(zone))
>>>>>> set_page_address(page, __va(pfn << PAGE_SHIFT));
>>>>>> #endif
>>>>>> + =
VM_WARN_ON_ONCE(vmemmap_optimizable_order(pfn_to_section_compound_order(pf=
n)) &&
>>>>>> + page_zone_id(page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) !=3D
>>>>>> + page_zone_id(page));
>>>>>=20
>>>>> Hmm, page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES is initialized a =
tad later
>>>>> than page so it'll have stale data in the page->flags, won't it?
>>>>=20
>>>> Lance is right. The shared tail struct pages are already =
initialized by
>>>> vmemmap_shared_tail_page() during vmemmap population, so they're =
not stale.
>>>> The head 64 struct pages are initialized later =E2=80=94 right =
here, after vmemmap
>>>> population.
>>>=20
>>> Still it looks out of place here, can this check be done in =
sparse-vmemmap
>>> somehow?
>>=20
>> The struct page entries of a vmemmap-optimizable compound page
>> are currently initialized in two stages. During vmemmap
>> population, the shared tail entries are initialized first. The
>> retained head area=E2=80=94normally 64=E2=80=94is initialized later =
through
>> __init_single_page().
>>=20
>> This warning connects the two stages: while initializing the
>> retained entries in the second stage, it verifies that their zone
>> information is consistent with the shared entries initialized in
>> the first stage. Therefore, the same check cannot be performed
>> during vmemmap population.
>>=20
>> I am planning to first unify the HugeTLB and Device DAX
>> compound-page initialization through a common helper [1]. Once that
>> work is complete, maybe it will be easy to move the initialization
>> of the retained head area into vmemmap population. With both the
>> retained and shared entries initialized in the same stage, there
>> will be no cross-stage inconsistency to check, and this warning
>> can be removed.
>>=20
>> Would keeping the check here for now and removing it as part of
>> that follow-up sound reasonable to you?
>=20
> While it feels really out of place in __init_single_page(), but having =
it
> memmap_init_range() close to the if that skips shared tail pages makes
> sense.
>=20
> What do you say?

Sorry for the late reply because of traveling to LPC.

Putting the check in memmap_init_range() would validate the
invariant for the shared-tail range skipped there. It would
not, however, cover all vmemmap-optimized initialization
paths: optimized Device DAX bypasses memmap_init_range()
when there is no altmap, and deferred boot-time HugeTLB
initialization may also initialize retained entries
elsewhere.

If the intention is to validate only the skip in
memmap_init_range(), moving it there makes sense. If we want
the warning to cover both HugeTLB and Device DAX generally,
it still needs to remain in __init_single_page() or be
called from the individual initialization paths.

Thanks,
Muchun

>=20
>> [1] =
https://lore.kernel.org/20260513132044.41690-18-songmuchun@bytedance.com/
>>=20
>> Thanks,
>> Muchun
>=20
> --=20
> Sincerely yours,
> Mike.


