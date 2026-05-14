Return-Path: <linuxppc-dev+bounces-20950-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AB0CD4851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 08:21:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGNZZ05CHz2xy8;
	Thu, 14 May 2026 18:21:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::bd"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778746869;
	cv=none; b=CMJmeKyc6rHcNZqbcTdtgAaxO6U4hWDPvS2qEX0XIYQumdbwoARZ3VNyx0teivR+7h8XAWwwol4QFPl6WFpIQP8T4vSQjNIslRTmDymeUc2xvbnu4vkmFVLNfqSuwfWzpNxrKaeE2V6iwjqf1Oa627gAGYMxKGsN6baEttM35DCxKMvmvcAQq4xgOSRs+5jdPYlmc/tV01uyBSUpdI9+np571hfDkZp+BmeWsqxCEeFEDDvqBDGPRLSQMpZXXrUowBFL+nz+Eu3CrOqZSfDNF3RGpMUv32L18RcEoYQuhWiAmHLMNwhQakRz14Kn1KDHovHq587vxXu4rVKkatZysg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778746869; c=relaxed/relaxed;
	bh=eF9zsW7xnXvYZrz7iQ2MKx+MqvnRKTtP5O8YBI2NE3c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aiMwD7ngEBdy7hegSz7mzFrkIAJypPO1KU+2rDeFlbx69xbvLtLcFGtZ3x9VKPLFU1fWZc4zKU5G8j2YZikrVhx7ZH7Qaj2OKcLT7i+PdSh0VBrD4xkgzAViubYxQCDUQJXzetsnNaAPt/08DDy3QGvP8XXv57twADSZYnJL7jdS3vP1FVAbjHge1f2G9Bgg52v2T6eyywhwEgAjE0Tm1apwY5D9GhhnFi/EbXFakuAUPV3zDBIAx2gjn1/sK3zu33vQQE2bJ/t5Jx2UZqt7xocTJjI31PpTjzRdS1vdC4cDUlBTRrf2TBxJ59i+9NZW9gVh+yKcRvGzv2QjA+lWTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KDwxvaKg; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::bd; helo=out-189.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KDwxvaKg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::bd; helo=out-189.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGNZT5Kyvz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 18:21:05 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778746844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eF9zsW7xnXvYZrz7iQ2MKx+MqvnRKTtP5O8YBI2NE3c=;
	b=KDwxvaKgh9l7mgpFBVZ+HTHG5TDMhl79lW7K3ZfMryQ5xm+gJinvCPr43E41bc7FSO4UAU
	xg27y1DxfnLCU6Y5XwSgd/HiNCx2W+k3aOiQfCwlb22XLvPX1xKbHpaPTswYw7yqpDHi4i
	Qy7K2XvZmO+OLALVUA8mkSffbYKzz3c=
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
Subject: Re: [PATCH v2 02/69] mm/hugetlb_vmemmap: Fix
 __hugetlb_vmemmap_optimize_folios()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <agWANe6i5gsfXFgP@localhost.localdomain>
Date: Thu, 14 May 2026 16:19:58 +0800
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
Message-Id: <76D9FAE1-7830-495F-A98D-B3F5FC26F9CC@linux.dev>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-3-songmuchun@bytedance.com>
 <agWANe6i5gsfXFgP@localhost.localdomain>
To: Oscar Salvador <osalvador@suse.de>
X-Migadu-Flow: FLOW_OUT



> On May 14, 2026, at 15:56, Oscar Salvador <osalvador@suse.de> wrote:
>=20
> On Wed, May 13, 2026 at 09:04:30PM +0800, Muchun Song wrote:
>> __hugetlb_vmemmap_optimize_folios() uses incorrect arguments when =
handling
>> bootmem HugeTLB folios.
>>=20
>> The section number passed to register_page_bootmem_memmap() is =
derived from
>> the vmemmap virtual address of folio->page instead of the folio PFN, =
so the
>> bootmem memmap metadata can be registered against the wrong section. =
The
>> helper is also given HUGETLB_VMEMMAP_RESERVE_SIZE even though it =
expects a
>> page count, not a size in bytes. In addition, the write-protect range =
is
>> based on pages_per_huge_page(h), which does not cover the full =
HugeTLB
>> vmemmap area and can leave part of the shared tail vmemmap mapping =
writable.
>>=20
>> Fix the section lookup to use folio_pfn(folio), use
>> HUGETLB_VMEMMAP_RESERVE_PAGES when registering the reserved memmap =
pages, and
>> use hugetlb_vmemmap_size(h) for the write-protect range.
>>=20
>> Fixes: 752fe17af693 ("mm/hugetlb: add pre-HVO framework")
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>=20
> Acked-by: Oscar Salvador <osalvador@suse.de>

Thanks.

>=20
> did you observe any Ooops or malfunctioning or was just code =
reviewing?

Found by LLM (Gemini Pro).

When I touched the code here, LLM will report the bug as well, even it =
is
not introduced by me :)

Thanks,
Muchun

>=20
>=20
>=20
> --=20
> Oscar Salvador
> SUSE Labs



