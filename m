Return-Path: <linuxppc-dev+bounces-20255-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA0DFF885A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 03:07:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g52KR1TQZz2ySW;
	Wed, 29 Apr 2026 13:07:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b6"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777432043;
	cv=none; b=gm0wEF1+TGGVMafimguP+Ho7+6clZE1My9Qy1HF0PfxMTuA9UdWqVxAqdCp2R+77BvkMbgx195K6rdwVUK1/93bdMw06z0N1tuQSDukag08ek8M1y1R7i8QDq3KpJoiF6GxL6YFqGG9UXzik59iYCY/zCyMXN9Iid5qRjxWE5P/djNW45AJd+LMMpMqk7lghyYr5e06Dv43jq2PgNoKpYeEpWnBHoV/mZiuFVM3SDAI33TfjsctaRO6k/SArh0rxlL5QCYiVpWMMPbsUpYgCZMwCHpkgry+ELC+8YmqQkL8W3CB130gM1W2obSe6+B9+IPQ9ZUjQJc7PFXXVoXSFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777432043; c=relaxed/relaxed;
	bh=NhojB57CLlcZgK90/1HI+G25tK+txX7jWmOanRsdL0M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TV06ZGfVxi/GbfStJ4ywg8Rc6qFhDW3tYh7ZsXsNfcQEU8IucpzyEBcQs+NSzC5SzLnl2Wyje0kzNFdm9Po8AaI7ObXpultyKzDrxB7z9PNKQ+ubCwhG/KrJFqJ1U6XZ4Cr2XSsK347Q7eGMt6KEGL+JfmE5YAwrj5UQM/1fsGhOLIgRoUd5g+KN6L7QWClNlxsJjpvpx9Rm+qZxQeDia2V31zS6aP4OZFc3AEZVDW9hRxMX33zsNU7DoatirgyVjKlIACGJK6MycaNVcXGzOv6l9He4uRAfhCHZgUGWhqrXfvECtdID8RgAWP8n2EWSsoDt4P3EZ50VUYW2LekIsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aL08m9g9; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b6; helo=out-182.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aL08m9g9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b6; helo=out-182.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g52KQ3Zy0z2xTh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 13:07:22 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777432022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhojB57CLlcZgK90/1HI+G25tK+txX7jWmOanRsdL0M=;
	b=aL08m9g9shhLJMe46gCutiIdCVuOgIS44YbIr4/G/lym4ejJlYaBtoK8OFFXojy/meT57h
	XQSPG9BJOku37RiHe/4aPLkzIyCWLUD3d4elxp7qHwkTWbJ5yujze5lnUR0eKglPtLPAoJ
	fSOfc5E92JJcr5+/W7LdWSgyudYnvCU=
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
Subject: Re: [PATCH 10/49] mm: move subsection_map_init() into sparse_init()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <afBcckUTQt-7xPPN@kernel.org>
Date: Wed, 29 Apr 2026 11:06:15 +0800
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
Message-Id: <DFB372BA-A262-4507-9280-7C0072280CC4@linux.dev>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-11-songmuchun@bytedance.com>
 <afBcckUTQt-7xPPN@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 28, 2026, at 15:06, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Sun, Apr 05, 2026 at 08:52:01PM +0800, Muchun Song wrote:
>> Move the initialization of the subsection map from free_area_init()
>> into sparse_init(). This encapsulates the logic within the sparse
>> memory initialization code.
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>=20
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks.

>=20
>> ---
>> mm/internal.h       |  5 ++---
>> mm/mm_init.c        | 10 ++--------
>> mm/sparse-vmemmap.c | 11 ++++++++++-
>> mm/sparse.c         |  1 +
>> 4 files changed, 15 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/mm/internal.h b/mm/internal.h
>> index edb1c04d0617..d70075d0e788 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -1004,10 +1004,9 @@ static inline void sparse_init(void) {}
>>  * mm/sparse-vmemmap.c
>>  */
>> #ifdef CONFIG_SPARSEMEM_VMEMMAP
>> -void sparse_init_subsection_map(unsigned long pfn, unsigned long =
nr_pages);
>> +void sparse_init_subsection_map(void);
>> #else
>> -static inline void sparse_init_subsection_map(unsigned long pfn,
>> - 	unsigned long nr_pages)
>> +static inline void sparse_init_subsection_map(void)
>> {
>> }
>> #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>=20
> I side note: we might want to split out mm/sparse.h and also move some
> declarations from include/linux/mmzone.h there.

I think we can do that in a separate series for cleanup only.

Thanks.


