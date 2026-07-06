Return-Path: <linuxppc-dev+bounces-23600-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDA3C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 11:05:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv1kB6Y56z2yVZ;
	Mon, 06 Jul 2026 21:05:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.183
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783335954;
	cv=none; b=O7QBM/GlbzFEoQRtH1p++2jtA9y3vc7eL23IeGHJeG++h7YnTHpo3b+k0fE/a6cr2T2xTc2cAj6/nIeXcBXlUW4o01L5ZuRFKgoy7ueavcNxF826mbxhQwzOOdkEyi49uoWDq/q/LVrlSWhKj2gQ132vsnhy/FGr0g/KOgUghnJtZhNZ1zc8XSaAe3Dj1l58v7NVbva7t5rD/bD/Gw2Ga5PYaRQzXkvvlFAbijD6kDyYuSqKDpY+suRxZgdAapdnGyDiKEjsd60rcZQbdcSHeVc2vemSxgdj/TcsNswZKlPmsCDSPqlfisehR0/HbFPVPgwl/pEJd1ZOqBwmGV+Owg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783335954; c=relaxed/relaxed;
	bh=70JWofOLlMgrve9aDAgHG0zmj2dWsVDmKKX/VA1fyUA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=faGMZg19V5PZdhFyXMUM+eAL0jojLGZ1GJct2W4OXOgD5v+Uct81M1A5zBJDe0qXcMDRcEBrNfsmrN/Sa14zSRsVFSVcuyxLxkFbN2Jn6L6A0vWLPDGtR/nNH7fenhD6Y7WOAwrfyJIrS4X8GvYNtKZzU70XnQospv7Zdc0uSrRrd1fHeEjf9OBXC0SGUTpUUhWSX4lqVlQfuV/Nc2mJnamaxgR7IeEwfwKqsgoagpDSaIWp/8HMJvdIYczAty124tkfVCqxeiAtOvOr5y7vq+v3ZsXKziqZ6JEAA7dJPmPAbO+dlncPIKpPFRKgR+anjXFggmdDltJaQt/GFJjz4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VHL9KSSG; dkim-atps=neutral; spf=pass (client-ip=91.218.175.183; helo=out-183.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VHL9KSSG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.183; helo=out-183.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv1k73tCFz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 21:05:50 +1000 (AEST)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783335928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70JWofOLlMgrve9aDAgHG0zmj2dWsVDmKKX/VA1fyUA=;
	b=VHL9KSSGqlxRYaGJQc9uy9oiC4xOSCeQUo/nl+CaMphFOPWNd+lQJukSEIALJfU39/njtD
	8RLuOFpl7fzzo9dgm8IwummIQjaga+zPxFmOc/m/pSGd+HghXQrb6mhFAvSvUvMOFTzAMN
	710fjORCfQjp3SJnNqGIg+QRTJFGbS8=
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v4 01/19] mm/hugetlb: Fix boot panic with CONFIG_DEBUG_VM
 and HVO bootmem pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <b4b200da-f510-4fe2-95ac-c63e4467c4bd@google.com>
Date: Mon, 6 Jul 2026 19:04:50 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mike Rapoport <rppt@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Mike Kravetz <mike.kravetz@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BBE64A39-448D-4235-8090-74C57947FE35@linux.dev>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
 <20260612035903.2468601-2-songmuchun@bytedance.com>
 <b4b200da-f510-4fe2-95ac-c63e4467c4bd@google.com>
To: =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
X-Migadu-Flow: FLOW_OUT



> On Jul 6, 2026, at 18:07, Micha=C5=82 C=C5=82api=C5=84ski =
<mclapinski@google.com> wrote:
>=20
> On 6/12/26 5:58 AM, Muchun Song wrote:
>> Commit 622026e87c40 ("mm/hugetlb: remove fake head pages") switched
>> HVO to reuse per-zone shared tail pages from zone->vmemmap_tails[].
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
>> Initialize zone->vmemmap_tails[] from gather_bootmem_prealloc(), =
before
>> bootmem HugeTLB folios are processed, and drop the later =
initialization
>> from hugetlb_vmemmap_init().
>> This bug only affects CONFIG_DEBUG_VM kernels, where the relevant
>> assertion is evaluated.
>> Fixes: 622026e87c40 ("mm/hugetlb: remove fake head pages")
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Acked-by: Oscar Salvador <osalvador@suse.de>
>> ---
>>  mm/hugetlb.c         | 25 +++++++++++++++++++++++++
>>  mm/hugetlb_vmemmap.c | 17 -----------------
>>  mm/sparse-vmemmap.c  |  2 +-
>>  3 files changed, 26 insertions(+), 18 deletions(-)
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 571212b80835..cd55524c7e30 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3365,6 +3365,31 @@ static void __init =
gather_bootmem_prealloc(void)
>>   .max_threads =3D num_node_state(N_MEMORY),
>>   .numa_aware =3D true,
>>   };
>> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>> + struct zone *zone;
>> +
>> + for_each_zone(zone) {
>> + for (int i =3D 0; i < NR_VMEMMAP_TAILS; i++) {
>> + struct page *tail, *p;
>> + unsigned int order;
>> +
>> + tail =3D zone->vmemmap_tails[i];
>> + if (!tail)
>> + continue;
>> +
>> + order =3D i + VMEMMAP_TAIL_MIN_ORDER;
>> + p =3D page_to_virt(tail);
>> + /*
>> + * prep_and_add_bootmem_folios() can access pageblock
>> + * flags on bootmem HugeTLB pages, so initialize the
>> + * shared tail struct pages here before bootmem folios
>> + * start using them.
>> + */
>> + for (int j =3D 0; j < PAGE_SIZE / sizeof(struct page); j++)
>> + init_compound_tail(p + j, NULL, order, zone);
>> + }
>> + }
>> +#endif
>=20
> I think it would be better if this was located in mm/hugetlb_vmemmap.c =
as a separate function.

This is actually just temporary. I already have another patch [1] that
completely removes this code later on. So, to avoid having to update
the entire patchset unnecessarily, I figured it's best to just leave
it as is for now, as it's not a major issue..

[1] =
https://lore.kernel.org/all/20260702093821.2740183-10-songmuchun@bytedance=
.com/

>=20
>>     padata_do_multithreaded(&job);
>>  }
>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>> index 133b46dfb09f..c713c0d2593a 100644
>> --- a/mm/hugetlb_vmemmap.c
>> +++ b/mm/hugetlb_vmemmap.c
>> @@ -870,27 +870,10 @@ static const struct ctl_table =
hugetlb_vmemmap_sysctls[] =3D {
>>  static int __init hugetlb_vmemmap_init(void)
>>  {
>>   const struct hstate *h;
>> - struct zone *zone;
>>     /* HUGETLB_VMEMMAP_RESERVE_SIZE should cover all used struct =
pages */
>>   BUILD_BUG_ON(__NR_USED_SUBPAGE > HUGETLB_VMEMMAP_RESERVE_PAGES);
>>  - for_each_zone(zone) {
>> - for (int i =3D 0; i < NR_VMEMMAP_TAILS; i++) {
>> - struct page *tail, *p;
>> - unsigned int order;
>> -
>> - tail =3D zone->vmemmap_tails[i];
>> - if (!tail)
>> - continue;
>> -
>> - order =3D i + VMEMMAP_TAIL_MIN_ORDER;
>> - p =3D page_to_virt(tail);
>> - for (int j =3D 0; j < PAGE_SIZE / sizeof(struct page); j++)
>> - init_compound_tail(p + j, NULL, order, zone);
>> - }
>> - }
>> -
>>   for_each_hstate(h) {
>>   if (hugetlb_vmemmap_optimizable(h)) {
>>   register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>> index 99e2be39671b..bb23fb3077a3 100644
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>> @@ -342,7 +342,7 @@ static __meminit struct page =
*vmemmap_get_tail(unsigned int order, struct zone *
>>   *
>>   * Any initialization done here will be overwritten by =
memmap_init().
>>   *
>> - * hugetlb_vmemmap_init() will take care of initialization after
>> + * gather_bootmem_prealloc() will take care of initialization after
>>   * memmap_init().
>>   */
>> =20
>=20
> It gets the job done.
>=20
> Tested-by: Michal Clapinski <mclapinski@google.com>
> Reviewed-by: Michal Clapinski <mclapinski@google.com>

Really thanks for your test.

Muchun,
Thanks.


