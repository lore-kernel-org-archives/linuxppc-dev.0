Return-Path: <linuxppc-dev+bounces-28740-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB50CA5FE0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:57:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx42X1jbNz2yDs;
	Fri, 02 Oct 2026 19:57:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.166
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790935044;
	cv=none; b=C4RdJaIuqn4AyId21SjNomRLJGdUa6XrUs+DyWowRYaPN0JyotTeRxwApqCe++wy2n0X+yjFD0cTWQnnIIsR0v6Q4EihrWvB4yY3Iktg+T/HyHOhn5Asw/4YhI9TKSAQvHeFBOwlKMEvT/8uHVnr4z6VbBEjiNVLB7DIXbgQdKq60y8XNawrDLFx5bfKRTJ+fNfYp+NqkITHZgUNsgt93i0SMRdSkE1NQmRWxskF1ELPMUS+GLZ2ujumiAqDv1Yif8tE6SX8/8qOfDTAGxJv999rWqombtxZVJXwAlG+UKPjWr97yMy6vY+DmNAUE9/1IYhqWmNaOnk7tymjQE05BA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790935044; c=relaxed/relaxed;
	bh=roAk5SWvCfO6tRD7usWMkoWmhkjxdhsqx8L4kRhcClI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BJS2bk8A0TnNceWkhsnLn49jDMioOdGTgthvOJEnmRpLzeupp8Pnvqy6PJ9epNMqN3HzHpcSyNK5DBTT1C6e0uuUknvjm4xrlD5Q+EUnvFEeujSM/+t/+k4B8UBIXuW2SeYLBjoljc110ej5dgPwNrAOF7nbegCdVgMOz5g+ecsBO896z9gwHUaIZDm9TcsyfK+/R6PMsn/UEeYPPY2/TqLd5SCdUnDnMdGUFoPVq8tBZxqrE6u525Abau27yAAcAQIepkPFtZlXkF+hgeLHrAWXXF6+mHAhYrJUXi7oPsLfHnkfA/mj7LnH73zO9c9fc8E4kcf3Rn18Mn9CVdKSDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nlTAQEKg; dkim-atps=neutral; spf=pass (client-ip=95.215.58.166; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nlTAQEKg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.166; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-166.mta1.migadu.com [95.215.58.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx42S6TDQz2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 19:57:19 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=roAk5SWvCfO6tRD7usWMkoWmhkjxdhsqx8L4kRhcClI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790935021; v=1; x=1791539821;
 b=nlTAQEKgfBTJ7beIvEZL1nlOX9yQBup7rkvDhDPQDEea763f1MOHHC2Yd87TRkN9nS7D09aY
 U6E7ts/3WBktQzF1GXnyYfUF+B+t/l6cN+GnL9NiG50MyBEScAtEwxt+SYUY2yToAtyxl0ItJj+
 blBTN1dUBGX7UdkAHu9KHf28=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 12c54f5d308feb20;
	Fri, 02 Oct 2026 09:57:00 +0000
X-Mizu-Trace-ID: 12c54f5d308feb20
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
In-Reply-To: <ar9p39Y9SmlxvbA_@kernel.org>
Date: Fri, 2 Oct 2026 17:56:40 +0800
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
Message-Id: <85941AA4-7E50-4AAE-BC05-0F443B21BE8B@linux.dev>
References: <20260929053231.66085-1-songmuchun@bytedance.com>
 <20260929053231.66085-7-songmuchun@bytedance.com>
 <ar5xbQsUpSQZg0wO@kernel.org>
 <78D5D6AA-BE36-432C-B0F7-453F93DF18C0@linux.dev>
 <ar9p39Y9SmlxvbA_@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 2, 2026, at 16:22, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Fri, Oct 02, 2026 at 09:48:42AM +0800, Muchun Song wrote:
>>=20
>>=20
>>> On Oct 1, 2026, at 22:42, Mike Rapoport <rppt@kernel.org> wrote:
>>>=20
>>> Hi Muchun,
>>=20
>> Hi,
>>=20
>>>=20
>>> On Tue, Sep 29, 2026 at 01:32:31PM +0800, Muchun Song wrote:
>>>> For vmemmap-optimized sections, tail struct pages may be backed by
>>>> shared vmemmap pages. Those shared pages must carry the same page =
zone
>>>> ID as the struct pages initialized for the section.
>>>>=20
>>>> Warn in __init_single_page() if the shared tail page has a =
different
>>>> page_zone_id(), which would indicate inconsistent initialization.
>>>>=20
>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>> Acked-by: Qi Zheng <qi.zheng@linux.dev>
>>>> ---
>>>> v3:
>>>> - Collect Acked-by from Qi Zheng
>>>>=20
>>>> v2:
>>>> - New patch.
>>>> ---
>>>> mm/mm_init.c | 3 +++
>>>> 1 file changed, 3 insertions(+)
>>>>=20
>>>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>>>> index 1650d6bc1211..bd02e8d06965 100644
>>>> --- a/mm/mm_init.c
>>>> +++ b/mm/mm_init.c
>>>> @@ -609,6 +609,9 @@ void __meminit __init_single_page(struct page =
*page, unsigned long pfn,
>>>> if (!is_highmem_idx(zone))
>>>> set_page_address(page, __va(pfn << PAGE_SHIFT));
>>>> #endif
>>>> + =
VM_WARN_ON_ONCE(vmemmap_optimizable_order(pfn_to_section_compound_order(pf=
n)) &&
>>>> + page_zone_id(page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) !=3D
>>>> + page_zone_id(page));
>>>=20
>>> Hmm, page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES is initialized a =
tad later
>>> than page so it'll have stale data in the page->flags, won't it?
>>=20
>> Lance is right. The shared tail struct pages are already initialized =
by
>> vmemmap_shared_tail_page() during vmemmap population, so they're not =
stale.
>> The head 64 struct pages are initialized later =E2=80=94 right here, =
after vmemmap
>> population.
>=20
> Still it looks out of place here, can this check be done in =
sparse-vmemmap
> somehow?

The struct page entries of a vmemmap-optimizable compound page
are currently initialized in two stages. During vmemmap
population, the shared tail entries are initialized first. The
retained head area=E2=80=94normally 64=E2=80=94is initialized later =
through
__init_single_page().

This warning connects the two stages: while initializing the
retained entries in the second stage, it verifies that their zone
information is consistent with the shared entries initialized in
the first stage. Therefore, the same check cannot be performed
during vmemmap population.

I am planning to first unify the HugeTLB and Device DAX
compound-page initialization through a common helper [1]. Once that
work is complete, maybe it will be easy to move the initialization
of the retained head area into vmemmap population. With both the
retained and shared entries initialized in the same stage, there
will be no cross-stage inconsistency to check, and this warning
can be removed.

Would keeping the check here for now and removing it as part of
that follow-up sound reasonable to you?

[1] =
https://lore.kernel.org/20260513132044.41690-18-songmuchun@bytedance.com/

Thanks,
Muchun

>=20
>> Thanks,
>> Muchun
>>=20
>>>=20
>>>> }
>>>>=20
>>>> #ifdef CONFIG_NUMA
>>>> --=20
>>>> 2.54.0
>>>>=20
>>>=20
>>> --=20
>>> Sincerely yours,
>>> Mike.
>>=20
>>=20
>=20
> --=20
> Sincerely yours,
> Mike.


