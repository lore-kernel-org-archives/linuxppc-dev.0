Return-Path: <linuxppc-dev+bounces-20215-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFA2FF886F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 07:25:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4X5p1LDVz2ySf;
	Tue, 28 Apr 2026 17:25:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.183
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777361134;
	cv=none; b=F11SiLeJHZb+H5JtfhN0RYApoZ/n0AK+B4uQAY3NE1n+lQAMc6C9yZLAYA39W2+LAm+aErhxLxNdlNP4vSKMSjpE0PG2YX2uKulhulp3KSHWzdv6US9HK+w5IpXjMdiiN3RwYjDQKSUrB+1cS0JKM0z+cLhfGECu4VaB94AS9BcL3z8jzK6XtqY0YlSrePZGdd8tKbE9+S95ni5QX9B17Qly0vxy9kxU2Q4yPeqCMKaQloQj/N4SbdIMcIiL0yLPx4MHzDs/bPniC59QY2DpneuJwJUfW1Tl5CF5s4RVaAbafvmUIRt1cCxPxodewwFvEQcbGqU8nlBR4cIEwzOQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777361134; c=relaxed/relaxed;
	bh=lCxxk2ZWIZ6775Ddt50SCJNnhpMNtd+lmo4iXra99RM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BjgQZJp5t8NRz5m1gcuKXHQzgLbMqCuJ8uau0Rz766X4ee/R7desYlR0wp9ufxa5ecekAkxlvRSjOqbc3V9AQuuL/vO605C5gtau0/B4Ddmjo6iYebOZ2R2Q8SuPNCnuF3/0rYQnT7IZdOqH/Bj92tMP368suY8B75cnHpqdyU2XZwfs2pI7btCImWdr+beTCO4325Pl4eQ+1pEqbk53B9kLZFpSwCs/ryZG93VyxtrcJi+ftY00CKDC/9L3/Q9CdHlwgshcL1dhjbq2qAvOnB6eZ+eqtLQoOq6q9uWJiqhBraejy8xKy1iX6JGMGcjH5MBVvgcmEdW+JzkBDvdiVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BaHKK+yR; dkim-atps=neutral; spf=pass (client-ip=91.218.175.183; helo=out-183.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BaHKK+yR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.183; helo=out-183.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4X5l5cCDz2xld
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 17:25:31 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777361109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCxxk2ZWIZ6775Ddt50SCJNnhpMNtd+lmo4iXra99RM=;
	b=BaHKK+yRKCfLKa5fiwk4B0E+J2WDiD2jnmSw45lRSgk5ed/MjG/OFPve6pztHuJ9C0KSID
	+5qQA4XNDVuHdwjkh5KOvsX7mA8gA54Huo6FjkZazML4r/okshxJ1V9ScLp5Tjo/IZQ4TE
	+eUyfeBvDKqczc0Ur6ShL3ymex8pCnY=
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
Subject: Re: [PATCH v7 4/6] mm/sparse-vmemmap: Fix DAX vmemmap accounting with
 optimization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <5dd84f9c-4ce2-4bc8-b644-e865f0623ba3@kernel.org>
Date: Tue, 28 Apr 2026 15:24:25 +0800
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
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0EC0552F-7394-49B9-91C7-A2E86CC0E541@linux.dev>
References: <20260426092640.375967-1-songmuchun@bytedance.com>
 <20260426092640.375967-5-songmuchun@bytedance.com>
 <09298afa-9a36-4f29-a8e1-d4750c338df2@kernel.org>
 <C2E99AB4-CC47-4D9F-BF56-F971FD5A3C26@linux.dev>
 <5dd84f9c-4ce2-4bc8-b644-e865f0623ba3@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 28, 2026, at 15:00, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 4/28/26 04:21, Muchun Song wrote:
>>=20
>>=20
>>> On Apr 27, 2026, at 18:17, David Hildenbrand (Arm) =
<david@kernel.org> wrote:
>>>=20
>>> On 4/26/26 11:26, Muchun Song wrote:
>>>> When vmemmap optimization is enabled for DAX, the nr_memmap_pages
>>>> counter in /proc/vmstat is incorrect. The current code always =
accounts
>>>> for the full, non-optimized vmemmap size, but vmemmap optimization
>>>> reduces the actual number of vmemmap pages by reusing tail pages. =
This
>>>> causes the system to overcount vmemmap usage, leading to inaccurate
>>>> page statistics in /proc/vmstat.
>>>>=20
>>>> Fix this by introducing section_nr_vmemmap_pages(), which returns =
the exact
>>>> vmemmap page count for a given pfn range based on whether =
optimization
>>>> is in effect.
>>>>=20
>>>> Fixes: 15995a352474 ("mm: report per-page metadata information")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>>> Acked-by: Oscar Salvador <osalvador@suse.de>
>>>> ---
>>>> v6 -> v7:
>>>> - Refine the alignment assertions in section_nr_vmemmap_pages().
>>>> ---
>>>> mm/sparse-vmemmap.c | 34 ++++++++++++++++++++++++++++++----
>>>> 1 file changed, 30 insertions(+), 4 deletions(-)
>>>>=20
>>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>>>> index 3340f6d30b01..01f448607bad 100644
>>>> --- a/mm/sparse-vmemmap.c
>>>> +++ b/mm/sparse-vmemmap.c
>>>> @@ -652,6 +652,31 @@ void offline_mem_sections(unsigned long =
start_pfn, unsigned long end_pfn)
>>>> }
>>>> }
>>>>=20
>>>> +static int __meminit section_nr_vmemmap_pages(unsigned long pfn, =
unsigned long nr_pages,
>>>> +  struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
>>>> +{
>>>> +  const unsigned int order =3D pgmap ? pgmap->vmemmap_shift : 0;
>>>> +  const unsigned long pages_per_compound =3D 1UL << order;
>>>> +
>>>> +  VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, =
PAGES_PER_SUBSECTION));
>>>> +
>>>> +  if (!vmemmap_can_optimize(altmap, pgmap))
>>>> +  return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
>>>> +
>>>> +  if (order < PFN_SECTION_SHIFT) {
>>>> +  VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, =
pages_per_compound));
>>>> +  return VMEMMAP_RESERVE_NR * nr_pages / pages_per_compound;
>>>> +  }
>>>> +
>>>> +  VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
>>>> +  VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
>>>=20
>>> I would just have done that at the very top, as this check applies =
to all cases.
>>=20
>> My initial reasoning was that the current formula holds for compound =
pages smaller
>> than the section size, and we only need to impose limits when the =
page size exceeds
>> it. While the current callers of section_nr_vmemmap_pages() don't =
pass sizes larger
>> than a section, this will change in the future (see [1]).
>=20
> A function that is called *section_* will get a range that exceeds a =
section?
>=20
> That sounds conceptually wrong, no?

It does seem a bit ambiguous. I will rename it to something more =
appropriate if I
expand its functionality in the future. For this series, I will update a =
v8 to move
VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION); to the top of this =
function.

Thanks.

>=20
>=20
> --=20
> Cheers,
>=20
> David



