Return-Path: <linuxppc-dev+bounces-28967-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD299CA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 13:33:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzcdw65jvz30St;
	Wed, 07 Oct 2026 00:33:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::5b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791293604;
	cv=none; b=H6d1AszrJ9J9bmVpYzvFqNSMMbHzHBD8N5Wp3pfC6iQcCvmsTY1OfvmQpc6f1CpJkz51cX+Hjli2G9gRHZXwNt2Int+RjVvSGF5q8ab4BKxuYK22+dlKNXJs7D5+va3Af9yU5M2UdveedRd+4cL5u9KQAOAZ+EQXLQkOKsc0fLRspJYIscSQfUnuYEkE7+5EyWWag4rLHU+eVM4ny3XB+hwTMSVi+BoqYapjMPsSa/3cTzLJL4EKHnCoi4Ll9qTT7KFGY3ROXNOp0IyQgDOwHFfeP2rbMbOxeEwEkTfEkeCLCNnZnZ2yH6MwgghGrWrEM9buXSxRfr1iJuoOwEUtJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791293604; c=relaxed/relaxed;
	bh=smNz1eVU0GPZ0bGB5TxQ5+zWKlDqUlqFk7rJBl1+TLI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Mwee/fPqpiprBzmhx/gsBuy9dA21HoAN+2kMJ3XDijLttIJ4skegjSVgU8MjbMBh8/uoZOe/E5YD4aX89YfEylig6A4iERcfZKppKthXVagPKQ2S/0ctjHvGOaehJY+TkR2wWqmwGGHyqMz/pxwY0/gf6IGMNuzX6Nq2JepEogAd0Q/8svas+PQJF7Ez5f8t+f/fQ7wpoR/s1Dmadq/ChcCZl55XqqAYweLf+8cPx2jAGhs+odPM8GnzlVrQv1QeBwp+ZkOnciqMSIG/BWYTLspAadxjzOfOZPQNh44H1R3vIhxxv4QhYih9r6Afm65LQQ3l9YztcwLBPPt3BPzhYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Jekc39bp; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::5b; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Jekc39bp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::5b; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-91.mta1.migadu.com [IPv6:2001:41d0:203:375::5b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzcds180jz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 00:33:19 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=smNz1eVU0GPZ0bGB5TxQ5+zWKlDqUlqFk7rJBl1+TLI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791293575; v=1; x=1791898375;
 b=Jekc39bpI+ioS9+/6w+urByOeYORvH5fCIWg9NHDTuHFtSIJ4zHHA8DJ8fSensly7uHX/HR/
 107fIDjvmzrDpMlAjWnOOfZClu0j0s7hC1Mj6DPm/mAmZBfuONGQURZ+fMeBqUKxRJL59z83wPU
 Jq8nzS/PSiEN8JYwtO+Vjud0=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 72132319fdfc02e7;
	Tue, 06 Oct 2026 13:32:55 +0000
X-Mizu-Trace-ID: 72132319fdfc02e7
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
In-Reply-To: <asTS6OtxPMVshuIO@kernel.org>
Date: Tue, 6 Oct 2026 15:32:43 +0200
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
Message-Id: <CF8ED1DC-9745-42D3-92F0-424A02385EC1@linux.dev>
References: <20260929053231.66085-1-songmuchun@bytedance.com>
 <20260929053231.66085-7-songmuchun@bytedance.com>
 <ar5xbQsUpSQZg0wO@kernel.org>
 <78D5D6AA-BE36-432C-B0F7-453F93DF18C0@linux.dev>
 <ar9p39Y9SmlxvbA_@kernel.org>
 <85941AA4-7E50-4AAE-BC05-0F443B21BE8B@linux.dev>
 <ar_0GLYM6KsIH6tQ@kernel.org>
 <D91CEA1E-6B79-434D-AF49-16C62C0FD095@linux.dev>
 <asTS6OtxPMVshuIO@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 6, 2026, at 12:52, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Mon, Oct 05, 2026 at 06:27:52PM +0200, Muchun Song wrote:
>>> On Oct 2, 2026, at 20:12, Mike Rapoport <rppt@kernel.org> wrote:
>>>=20
>>> On Fri, Oct 02, 2026 at 05:56:40PM +0800, Muchun Song wrote:
>>>>> On Oct 2, 2026, at 16:22, Mike Rapoport <rppt@kernel.org> wrote:
>>>>=20
>>>>>>>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>>>>>>>> index 1650d6bc1211..bd02e8d06965 100644
>>>>>>>> --- a/mm/mm_init.c
>>>>>>>> +++ b/mm/mm_init.c
>>>>>>>> @@ -609,6 +609,9 @@ void __meminit __init_single_page(struct =
page *page, unsigned long pfn,
>>>>>>>> if (!is_highmem_idx(zone))
>>>>>>>> set_page_address(page, __va(pfn << PAGE_SHIFT));
>>>>>>>> #endif
>>>>>>>> + =
VM_WARN_ON_ONCE(vmemmap_optimizable_order(pfn_to_section_compound_order(pf=
n)) &&
>>>>>>>> + page_zone_id(page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) !=3D
>>>>>>>> + page_zone_id(page));
>>>>>>>=20
>>>>>>> Hmm, page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES is initialized =
a tad later
>>>>>>> than page so it'll have stale data in the page->flags, won't it?
>>>>>>=20
>>>>>> Lance is right. The shared tail struct pages are already =
initialized by
>>>>>> vmemmap_shared_tail_page() during vmemmap population, so they're =
not stale.
>>>>>> The head 64 struct pages are initialized later =E2=80=94 right =
here, after vmemmap
>>>>>> population.
>>>>>=20
>>>>> Still it looks out of place here, can this check be done in =
sparse-vmemmap
>>>>> somehow?
>>>>=20
>>>> The struct page entries of a vmemmap-optimizable compound page
>>>> are currently initialized in two stages. During vmemmap
>>>> population, the shared tail entries are initialized first. The
>>>> retained head area=E2=80=94normally 64=E2=80=94is initialized later =
through
>>>> __init_single_page().
>>>>=20
>>>> This warning connects the two stages: while initializing the
>>>> retained entries in the second stage, it verifies that their zone
>>>> information is consistent with the shared entries initialized in
>>>> the first stage. Therefore, the same check cannot be performed
>>>> during vmemmap population.
>>>>=20
>>>> I am planning to first unify the HugeTLB and Device DAX
>>>> compound-page initialization through a common helper [1]. Once that
>>>> work is complete, maybe it will be easy to move the initialization
>>>> of the retained head area into vmemmap population. With both the
>>>> retained and shared entries initialized in the same stage, there
>>>> will be no cross-stage inconsistency to check, and this warning
>>>> can be removed.
>>>>=20
>>>> Would keeping the check here for now and removing it as part of
>>>> that follow-up sound reasonable to you?
>>>=20
>>> While it feels really out of place in __init_single_page(), but =
having it
>>> memmap_init_range() close to the if that skips shared tail pages =
makes
>>> sense.
>>>=20
>>> What do you say?
>>=20
>> Sorry for the late reply because of traveling to LPC.
>>=20
>> Putting the check in memmap_init_range() would validate the
>> invariant for the shared-tail range skipped there. It would
>> not, however, cover all vmemmap-optimized initialization
>> paths: optimized Device DAX bypasses memmap_init_range()
>> when there is no altmap, and deferred boot-time HugeTLB
>> initialization may also initialize retained entries
>> elsewhere.
>>=20
>> If the intention is to validate only the skip in
>> memmap_init_range(), moving it there makes sense. If we want
>> the warning to cover both HugeTLB and Device DAX generally,
>> it still needs to remain in __init_single_page() or be
>> called from the individual initialization paths.
>=20
> Yeah, putting this into all the callers sucks too :(
>=20
> With all the callers,__init_single_page() is the right place for this
> check, but I think we can add a static inline in sparse.h, like e.g.
>=20
> vmemmap_optimization_verify_zone(page, pfn)
>=20
> to make it a bit nicer.

Yeah, factoring this into a helper makes sense.

Since it currently has only one caller, how about keeping it as a local
static inline in mm_init.c instead of putting it in sparse.h?

Thanks,
Muchun

>=20
>> Thanks,
>> Muchun
>>=20
>>>=20
>>>> [1] =
https://lore.kernel.org/20260513132044.41690-18-songmuchun@bytedance.com/
>>>>=20
>>>> Thanks,
>>>> Muchun
>>>=20
>>> --=20
>>> Sincerely yours,
>>> Mike.
>>=20
>=20
> --=20
> Sincerely yours,
> Mike.



