Return-Path: <linuxppc-dev+bounces-20219-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF46FF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 07:58:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4XqW1czdz2ySf;
	Tue, 28 Apr 2026 17:58:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.178
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777363095;
	cv=none; b=gBuwR6IFCtrxPeS/J1JNTMfS3HVFwPr8jyLnLEE1OHIGdOiv7SSqBgpu5IJTl2w1syWjWjsV20GbalBo10qNkL4RKEj/gsTxmkBGNQdnjpacMK08WLUmTNJt1R2X96YNIsHsaaWs4CxUQQWxrvFNYH8EHR9mBLpDy4kS1fmld86/qOLkcyrrvjpAZUQa1hdIS1G0d1ly67L/C/0YS1Fjf636jNaXGhin3GFXH3A4925H1CLx+hTZ7laWzCa9qHGy2aiB0LuIodAPUoWUlHmQuMhUEJgQGJrA1C58kRfi4lakMhRH4EFoIvFfGs65Ul5QZDCmrq07ZQctwwRHPeAjQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777363095; c=relaxed/relaxed;
	bh=UMRaGncdlPYxN1RUUBUZsd/r+eI8zgEI90AUf2jmcXs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=K6JwCW4iglnTzlSFLXyudjT1B/z8OrbTAXMEvJXrLhELkir+0Ho9f1itqYeL31CxA5R3iN3nLLLwbp71CIMPez4EMnxSpV/qKDvHkpbGCKtvnzRcVqoB7mysGbbZjWa+VzphIreqpnTpw3+3OBfKSwyyBPgdRfbJ1jfZuJvvO0/DhgnlazT2Y1It3dLb46bFmleYHKq9zv+e4vyOnyKFPW5tDMjYsCaTr4Pe+nWqrUirugHY8YPJNoPt88Bvm5rM8/3SZvfYwHM0KT19cXQIkltyfa1ZrILOeec4/NLWkvxMJdfSpuAJvZ2KTdtED7sUi7ufJPby9F6TvuQfxmyuTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=I67jg08K; dkim-atps=neutral; spf=pass (client-ip=95.215.58.178; helo=out-178.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=I67jg08K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.178; helo=out-178.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4XqR2rrYz2xld
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 17:58:09 +1000 (AEST)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777363069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMRaGncdlPYxN1RUUBUZsd/r+eI8zgEI90AUf2jmcXs=;
	b=I67jg08K9MTWM+Rp0bC6VtfePNqxPPzYzJsPNEI3p5ur2b9K7XYdnKpkBR9fRfkr25oVEB
	n7JBacRYfngy9IR6h1JqBxK5g8RyaKSpCCjzpueX4BqCLTDPbfnWzDTLB54qC7dANsXAcZ
	zy96Z+6MjUTC8/9l1AerSvNuUO+cALA=
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
Subject: Re: [PATCH 09/49] mm: panic on memory allocation failure in
 sparse_init_nid()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <afBilACQByFLa-hi@kernel.org>
Date: Tue, 28 Apr 2026 15:57:23 +0800
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
Message-Id: <0C4BACC0-0BEF-4F38-BC8D-1B2A8584AEC8@linux.dev>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-10-songmuchun@bytedance.com>
 <afBaMEBoR_35Fblc@kernel.org>
 <96DB49C7-A7C2-4F53-8321-FF4A4ECDFF95@linux.dev>
 <afBilACQByFLa-hi@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 28, 2026, at 15:32, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> Hi Muchun,
>=20
> On Tue, Apr 28, 2026 at 03:02:14PM +0800, Muchun Song wrote:
>>=20
>>>> diff --git a/mm/sparse.c b/mm/sparse.c
>>>> index effdac6b0ab1..5c12b979a618 100644
>>>> --- a/mm/sparse.c
>>>> +++ b/mm/sparse.c
>>>> @@ -354,19 +354,15 @@ static void __init sparse_init_nid(int nid, =
unsigned long pnum_begin,
>>>>   unsigned long map_count)
>>>> {
>>>> unsigned long pnum;
>>>> -  struct page *map;
>>>> -  struct mem_section *ms;
>>>> -
>>>> -  if (sparse_usage_init(nid, map_count)) {
>>>> -  pr_err("%s: node[%d] usemap allocation failed", __func__, nid);
>>>> -  goto failed;
>>>> -  }
>>>>=20
>>>> +  if (sparse_usage_init(nid, map_count))
>>>> +  panic("The node[%d] usemap allocation failed\n", nid);
>>>=20
>>> Please consider using memblock_alloc_or_panic() in =
sparse_usage_init(), it
>>> would simplify the code even more.
>>=20
>> Hi Mike,
>>=20
>> Yes. I have several more updates for v2. Please hold off on reviewing
>> the current version to avoid wasting your time; I=E2=80=99ll send the =
new one
>> over shortly.
>=20
> Thanks for the heads up!
> I'll stop for now :)

Thanks for the quick response!

To clarify, the first few patches didn't change much, so your feedback
on those is still very relevant and much appreciated. The major updates
are in the later parts of the series, so I'm glad I caught you before
you spent time on those.

I=E2=80=99ll get the new version shortly.

Thanks again!

>=20
>> Thanks.
>=20
> --=20
> Sincerely yours,
> Mike.



