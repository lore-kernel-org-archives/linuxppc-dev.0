Return-Path: <linuxppc-dev+bounces-28411-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7FEC9833F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 13:50:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htjPY6VHbz2y2B;
	Mon, 28 Sep 2026 23:50:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::5f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790603441;
	cv=none; b=bwtjZe4PPovrUuwZReWXDobMm4W+PFCDpjoLhYNMMfXZmdXpe0a0JU5QSVrt6eil18875gNWjoZnr/pLNJIMCKEQL1pX+HADUc1z//3sVY3DRK9WL7/+51E5tp2STnZ/IWpSnJ9fql7d9LboKvQSxuxJXThO/w5+/zEyBwsJeRx3YKngyE0FZbUaqXS4ugqaBJ4Pfa9f3H3WeqyewSCmLJNWu3ACt+AEPltsEOsWhS7T7KvqHMPRn/WdOs/t9x70kUADbMomskdPT/juF4+vi5efkGW5BVIShLqNoI77rHhGM/F7aDzWiwnW3EEf5RttZdswTyGM9EhM11K90lLiBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790603441; c=relaxed/relaxed;
	bh=kwGEFPYPtNOaPfcKsHGyvboh3/0JIjAHnUCjf3u1ZsI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EcAWdWuOslxDmlWPP880/XB2jt7aHZwnIv9aWAYL3c/baHDXhUlZuqL9ApT3FlYWbAV1ZrS8B4cHtl4c2SxNTDc9kYPBBtErMUthm8z1H+X7kWazPAwP67EyvP2nzS7Gb6hpJ0sK0foQ4HjiwknSBzFXapurHqsP4gd8VUCyqqulClGzCgNTny3+keRbmW17p3cBuTUoDEm9SqxRfL9fkuepjzGGfxgn1DOKO1zNQtudRgvOtpVkLbqEf2umzsXZko2CWTqgv/vs3o5grzA04JkniNVKUPDLbo8SFVJLwLOg5HFVezOsrxmc/DmZA8+vw1d7HR7STWlH9NpZOdLnxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Q8XJ6CNb; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::5f; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Q8XJ6CNb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::5f; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-95.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htjPV45Dgz2y25
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 23:50:37 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=kwGEFPYPtNOaPfcKsHGyvboh3/0JIjAHnUCjf3u1ZsI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790603418; v=1; x=1791208218;
 b=Q8XJ6CNbCMFKzmL8RUg+vJppTHPo2X824pWFNsGGPnYSlEljzBMnGBSNi1/D5JHRuL9rCTYO
 1E6TqHMxyEvvovgL6kj3Cfdrurhwc2MVmMg97jTrXlF1NJ592MRYZemi775QBCAashwKLnYleQ3
 4DGLadlzvb6/1zZfB2qXGm5w=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta11.migadu.com with ESMTPS id e0d00ebac706a868;
	Mon, 28 Sep 2026 13:50:14 +0000
X-Mizu-Trace-ID: e0d00ebac706a868
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH v2 0/6] mm: Unify device DAX and HugeTLB vmemmap
 population paths
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <607759bf-59f2-4ad6-b95b-e780ed2acba3@kernel.org>
Date: Mon, 28 Sep 2026 21:49:55 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
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
Message-Id: <8385F749-0F72-494E-9CA2-2E433A066712@linux.dev>
References: <20260924075259.2013039-1-songmuchun@bytedance.com>
 <607759bf-59f2-4ad6-b95b-e780ed2acba3@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)



> On Sep 28, 2026, at 20:44, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 9/24/26 09:52, Muchun Song wrote:
>> This series is split out from the earlier, larger series "mm: =
Generalize
>> HVO for HugeTLB and device DAX" [1]. While the parent series =
generalizes
>> vmemmap optimization across HugeTLB and device DAX, this subset =
addresses
>> a single, self-contained step: unifying their vmemmap population =
paths.
>>=20
>> After the preceding Device DAX conversion, both HugeTLB and Device =
DAX
>> describe optimized vmemmap mappings through memory-section metadata =
and
>> use per-zone shared tail vmemmap pages. The generic code, however, =
still
>> carries a Device DAX-specific population flag and compound-page =
population
>> path, along with arguments and helpers needed only by that path.
>>=20
>> This series first removes VMEMMAP_POPULATE_DAX and moves selection =
and
>> reference handling for the shared tail page into the common vmemmap
>> population path. It then removes the generic Device DAX-specific
>> compound-page population path and routes section vmemmap population
>> through vmemmap_populate(). The powerpc radix path continues to use =
its
>> architecture-specific compound-page population implementation for
>> optimizable sections.
>>=20
>> The remaining patches remove the unused ptpfn argument, open-code
>> vmemmap_populate_address() now that no caller needs its returned PTE, =
and
>> add a warning for inconsistent zone initialization of shared tail =
vmemmap
>> pages.
>>=20
>> This is the fourth smaller step toward the broader HVO =
generalization.
>> After this series, HugeTLB and Device DAX use the same population =
model
>> instead of parallel generic paths, while powerpc keeps its
>> architecture-specific implementation.
>>=20
>> [1] =
https://lore.kernel.org/all/20260513130542.35604-1-songmuchun@bytedance.co=
m/
>=20
> How does this series relate to
>=20
> =
https://lore.kernel.org/r/20260927025441.741633-1-songmuchun@bytedance.com=


This series is based on the v4 version [1] of the series you pointed =
out. When
I was sending the current series, the v4 version of that series had =
already
been in mm-new for some time, so I sent the v2 version of the current =
series.

However, a couple of days ago the kernel test bot reported an issue, and =
this
issue cannot be easily fixed with a simple fixup. So I updated that =
series to
a v5 version.

Therefore, the current series needs to be rebased on top of the v5 =
version of
the series you pointed out, and then sent as a new v3 version before it =
can be
properly applied or reviewed.

If you're planning to review this series, I'd suggest waiting for my =
rebased
version.

[1] =
https://lore.kernel.org/all/20260916064341.1825793-1-songmuchun@bytedance.=
com/

Thanks,
Muchun

>=20
> ?
>=20
> --=20
> Cheers,
>=20
> David


