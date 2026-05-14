Return-Path: <linuxppc-dev+bounces-20946-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D62CD4F25
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 08:14:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGNR26nCwz2xy8;
	Thu, 14 May 2026 18:14:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.182
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778746478;
	cv=none; b=mmFPAl6C68tBNLs4L1qEMUcvNG5TQIxfkVXT9xYwKVWbu5Bx8udWV96qckj8OycY/lRDA8wlQk7BJT82d9N3c6CZ/ktsPzRiNrMCfyjhpgTwIX4ay3SXGYxECxHm99nEfy629a80pXr2HAdb8wWjE6veSmVe8caDDudiMj3DA9HFzvEI3/pZSCMEroWuLV3OjFvmxMgnjOBLEbQ9xSzhsgTasyjQJR5GNNVTjO288U1po2kKsFKZYqSKl/wLVlTFEx7++D3jQRsyVb0JD5Ney5I9kaM/2oaI8MFPK6GMv9CZIAjuE2HLKtFiIr7NhyVi/sypJy/uFb3OA5MJdiK4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778746478; c=relaxed/relaxed;
	bh=co+PDVFtUfeY9Azvp0wD3jOOEodjcJ+478dVQU/LkoI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iPCawklDJyRIGQJAKxtyjQv+MExaL0ddaWoWjuRzJerYK18b6nBiU46vKSW883XYrUS3KUYwzpez6cw/FAiTqbIPuM8YehMezMjYAop17Zo2m9XI5gqoQ7b+EbVpWjT3TZJ6qPNA0oQGIzKEJ5kGp24W4D59e1i8D7ilH2St2L+deIEkNMGbr4Ka+hYexo3Ug+i3qkbZH4j+f2qhxN7yEWp2hrJAHqMQjHVxbujOrHSUdEkeL0r/p4qDzSmMNWl0WXhbt7yNexc39YQumPJqe+0CXhplospRmDM5tOhZ3NWdO2eYDdky6HSVRx0+yttfPFlBp/ZA9Ii+ZIYDHWi8kA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=j3fsDcx7; dkim-atps=neutral; spf=pass (client-ip=95.215.58.182; helo=out-182.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=j3fsDcx7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.182; helo=out-182.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGNQw4q03z2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 18:14:31 +1000 (AEST)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778746447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=co+PDVFtUfeY9Azvp0wD3jOOEodjcJ+478dVQU/LkoI=;
	b=j3fsDcx7/FSW0gAiMjYPF67lTpafzHKsRZrrN1bIwXHyEJPS1uPVvvuH28QY+dfTux6xmh
	7sKJS7p3MQRsLJDf21qNOWrDPiNOnr+7z97BLGVlh257j83+tRLHMFug09EbLrs8pF/H1R
	2Fx+bM7aYiicP20yCmvvUR9rRb8d1pg=
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
Subject: Re: [PATCH v2 01/69] mm/hugetlb: Fix boot panic with CONFIG_DEBUG_VM
 and HVO bootmem pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <agV-8Ng-E0tZ9G5k@localhost.localdomain>
Date: Thu, 14 May 2026 16:13:15 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
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
 Ackerley Tng <ackerleytng@google.com>,
 Frank van der Linden <fvdl@google.com>,
 aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D282FD33-5A85-40F0-9B4A-3B4414DE5486@linux.dev>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-2-songmuchun@bytedance.com>
 <agV-8Ng-E0tZ9G5k@localhost.localdomain>
To: Oscar Salvador <osalvador@suse.de>
X-Migadu-Flow: FLOW_OUT



> On May 14, 2026, at 15:51, Oscar Salvador <osalvador@suse.de> wrote:
>=20
> On Wed, May 13, 2026 at 09:04:29PM +0800, Muchun Song wrote:
>> Commit 622026e87c40 ("mm/hugetlb: remove fake head pages") switched
>> HVO to reuse per-zone shared tail pages from zone->vmemmap_tails[].
>>=20
>> Those shared tail pages were initialized in hugetlb_vmemmap_init(), =
but
>> bootmem HugeTLB folios are prepared earlier from =
gather_bootmem_prealloc().
>> With hugetlb_free_vmemmap=3Don, prep_and_add_bootmem_folios() can =
access
>> pageblock flags on bootmem HugeTLB pages whose mirrored tail struct =
pages
>> already point to the shared tail page. On CONFIG_DEBUG_VM kernels,
>> get_pfnblock_bitmap_bitidx() then dereferences the =
still-uninitialized
>> shared tail page and can panic during boot.
>>=20
>> Initialize zone->vmemmap_tails[] from gather_bootmem_prealloc(), =
before
>> bootmem HugeTLB folios are processed, and drop the later =
initialization
>> from hugetlb_vmemmap_init().
>>=20
>> This bug only affects CONFIG_DEBUG_VM kernels, where the relevant
>> assertion is evaluated.
>>=20
>> Fixes: 622026e87c40 ("mm/hugetlb: remove fake head pages")
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>=20
> For the correctness of the change
>=20
> Acked-by: Oscar Salvador <osalvador@suse.de>

Thanks.

>=20
> but I have a couple of comments:
>=20
>> ---
>> mm/hugetlb.c         | 19 +++++++++++++++++++
>> mm/hugetlb_vmemmap.c | 17 -----------------
>> 2 files changed, 19 insertions(+), 17 deletions(-)
>>=20
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 31b34ca0f402..d22683ab30a1 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3382,6 +3382,25 @@ static void __init =
gather_bootmem_prealloc(void)
>> .max_threads =3D num_node_state(N_MEMORY),
>> .numa_aware =3D true,
>> };
>> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>> + 	struct zone *zone;
>> +
>> + 	for_each_zone(zone) {
>> + 		for (int i =3D 0; i < NR_VMEMMAP_TAILS; i++) {
>> + 			struct page *tail, *p;
>> + 			unsigned int order;
>> +
>> + 			tail =3D zone->vmemmap_tails[i];
>> + 			if (!tail)
>> + 				continue;
>> +
>> + 			order =3D i + VMEMMAP_TAIL_MIN_ORDER;
>> + 			p =3D page_to_virt(tail);
>> + 			for (int j =3D 0; j < PAGE_SIZE / sizeof(struct =
page); j++)
>> + 				init_compound_tail(p + j, NULL, order, =
zone);
>> + 		}
>> + 	}
>=20
> This deserves a comment why do we need to initialize those pages here, =
no need for
> a fat one but a hint, because everybody else looking at this will =
wonder why do not
> have it in hugetlb_vmemmap_init(), as the name suggests.

Make sense.

>=20
>=20
>> +#endif
>>=20
>> 	padata_do_multithreaded(&job);
>> }
>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>> index 4a077d231d3a..62e61af18c9a 100644
>> --- a/mm/hugetlb_vmemmap.c
>> +++ b/mm/hugetlb_vmemmap.c
>> @@ -870,27 +870,10 @@ static const struct ctl_table =
hugetlb_vmemmap_sysctls[] =3D {
>> static int __init hugetlb_vmemmap_init(void)
>=20
> At this point, hugetlb_vmemmap_init only initialites the sysctls for
> each hstate, should the name reflect that better?

A good point. I can add a new cleanup patch.

>=20
> Also, vmemmap_get_tail() still thinks that tail pages are initialized
> here from this comment:

Good catch. I'll fix it.

>=20
> "/*
>   * Only allocate the page, but do not initialize it.
>   *
>   * Any initialization done here will be overwritten by memmap_init().
>   *
>   * hugetlb_vmemmap_init() will take care of initialization after
>   * memmap_init().
>   */"
>=20
> so we might want to adjust that as well, and I am not sure if we have
> more comments in the tree referencing hugetlb_vmemmap_init() as the =
init
> point for those pages that need correction.

Only this one.

>=20
>=20
> Having said that, and this is just a question, we cannot really make
> gather_bootmem_prealloc() also do the initialization of the sysfs =
right?
> I see that hugetlb sysfs gets initialized from hugetlb_init() a few
> calls after, so.. meh.

hugetlb_vmemmap_init() is introduced by me. I want to hide some symbols
from mm/hugetlb_vmemmap.c at that time. So I used late_initcall() for =
that.

>=20
> Anyway, maybe just convert hugetlb_vmemmap_init to =
hugetlb_vmemmap_sysfs_create
> (pick a better name), so it does not look like having two entry points
> for vmemmap init stuff.

This bug fix is a temporary change, the whole zone initialization will
removed later in patch 30. Then, there will be only one place for =
vmemmap init :)

I=E2=80=99m curious about your thoughts on the practice of minimizing =
external
symbols. Personally, I=E2=80=99d prefer to move these initializations =
into
their respective files:

    - hugetlb_sysfs_init();
    - hugetlb_cgroup_file_init();
    - hugetlb_sysctl_init();

Of course, that=E2=80=99s just my personal preference.

Muchun,
Thanks.


>=20
> --=20
> Oscar Salvador
> SUSE Labs



