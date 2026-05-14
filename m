Return-Path: <linuxppc-dev+bounces-20948-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2391CD4851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 08:17:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGNVH3xYCz2xy8;
	Thu, 14 May 2026 18:17:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.176
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778746647;
	cv=none; b=iIv7xT34NFyP2pk2lJkokp6Q4NGgKsW716Wg2YFGL1wEFgl4nJnEgKwResI/t994aRwMn8xkeFVNhiSZZNJXtUns6sObCY67TpfPRm/AgYhDD8QkH3evkpkLvi+ZgPz7XDW2B7ScXlmym5z0Qd8QqqBt37T3RpKkyurqGY7mBQLc+kn0YpdJzCe+BuciOAaTGrV3Ymv3i9I2rRDHk2axlV9flFnC1x9Y4T9QZBZZ6f4GZUDraMRVRPLeJl6F/uFMuvcl1kcgeBiqKowF7wo4H7PrkybeEFY9ta0Zpil70s03ZodJn6sv8ebjq3plS/ykg+OkMbspzbL6fRg0mwkOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778746647; c=relaxed/relaxed;
	bh=zLrAoOEPFxwptypqmQTS2ICcy/5N9VlSvuD2zj/07tA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=L0Fj/H/EKxp2mfGVPHVANCrgia4yH4lC/TvQgTZTJzYfRHEOhbhta1CGtoHqXEfpl3xQdFed/6LM/N6NzL9YgULRLqyVueYYnxs/B+pY+lPwIRMuXBHHWHJCcLmF67glOjhNYmRnCbbOOXSkgIxW5aU6lMaNsA93OOeOmKeQwQbSyYqCClaEJBQle2NsMjxfv4IkzFokNGPJHGFZy129XaIuOko5Cdlp3WsYOes21l7+5EZksZOAsrGhXJ+X+P1JQ1jGI1utroyg6wI7xlOuuWP9jZzkk/nXySI5SFSuEeOVZyexauPhCNnashWEMBnxH2+SwSDmRWwpInaxxQhz0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=v0lPPCkg; dkim-atps=neutral; spf=pass (client-ip=95.215.58.176; helo=out-176.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=v0lPPCkg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.176; helo=out-176.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGNVC1vhwz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 18:17:22 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778746622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zLrAoOEPFxwptypqmQTS2ICcy/5N9VlSvuD2zj/07tA=;
	b=v0lPPCkgev1849GW+OiWliI9YXN1+EVzWIId60Z+uglBAigKo0XkAOcmg4+zbfwEM9ovUe
	n1ZirusYynvEENdn/xkIkli/HW42I5RUhrEPLZLmywQg6fAgjw1rhGfykOgf1TM6A6ToKH
	i0ViW3SEoN+yW3QoELP2RdXU0u9VCtU=
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
Subject: Re: [PATCH v2 04/69] mm/hugetlb: Initialize gigantic bootmem hugepage
 struct pages earlier
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <agWCVeywSo5lk1Vs@localhost.localdomain>
Date: Thu, 14 May 2026 16:16:05 +0800
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
Message-Id: <19B1C90F-B268-4FA8-BF9E-4B7B6188B908@linux.dev>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-5-songmuchun@bytedance.com>
 <agWCVeywSo5lk1Vs@localhost.localdomain>
To: Oscar Salvador <osalvador@suse.de>
X-Migadu-Flow: FLOW_OUT



> On May 14, 2026, at 16:05, Oscar Salvador <osalvador@suse.de> wrote:
>=20
> On Wed, May 13, 2026 at 09:04:32PM +0800, Muchun Song wrote:
>> Gigantic bootmem HugeTLB pages are currently initialized from =
hugetlb_init(),
>> but page_alloc_init_late() runs earlier and walks pageblocks to =
determine
>> zone contiguity.
>>=20
>> If a bootmem HugeTLB region is marked noinit, set_zone_contiguous() =
can
>> observe still-uninitialized struct pages through =
__pageblock_pfn_to_page().
>> This may not trigger an immediate failure, but it can make
>> set_zone_contiguous() compute the wrong zone contiguity state. If =
extra
>> poisoned-page checks are added in this path, such as =
PF_POISONED_CHECK()
>> in page_zone_id(), it can also trigger an early boot panic.
>>=20
>> Initialize gigantic bootmem HugeTLB struct pages from =
page_alloc_init_late(),
>> before zone contiguity is evaluated, so later page allocator setup =
only
>> sees valid struct page state. This also makes the initialization =
order
>> more natural, as struct pages should be initialized before later code
>> inspects them.
>>=20
>> Fixes: fde1c4ecf916 ("mm: hugetlb: skip initialization of gigantic =
tail struct pages if freed by HVO")
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>=20
> Acked-by: Oscar Salvador <osalvador@suse.de>
>=20

Thanks.

> but
>=20
>> ---
>> include/linux/hugetlb.h | 5 +++++
>> mm/hugetlb.c            | 3 +--
>> mm/mm_init.c            | 1 +
>> 3 files changed, 7 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 93418625d3c5..52a2c30f866c 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -173,6 +173,7 @@ extern int movable_gigantic_pages __read_mostly;
>> extern int sysctl_hugetlb_shm_group __read_mostly;
>> extern struct list_head huge_boot_pages[MAX_NUMNODES];
>>=20
>> +void hugetlb_struct_page_init(void);
>=20
> we lost the hint that this only takes care of bootmem pages.

Right.

> So I think hugetlb_bootmem_struct_page_init or something like that =
would make
> it more clear?

Yes. Make sense.

Thanks,
Muchun

>=20
>=20
> --=20
> Oscar Salvador
> SUSE Labs



