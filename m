Return-Path: <linuxppc-dev+bounces-20210-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07069FF886F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 07:03:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4Wch3wk6z2xld;
	Tue, 28 Apr 2026 17:03:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.183
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777359828;
	cv=none; b=KGxbrZgUXP0FA5OiTV6wi39Z8upCe9r/dP6vxFP6/wEIM7vUt1F/oXEwd+q1mmWrRjoYa+ut2+ZmUpdVDwoADT7FQLsdfR7IjGBqeXKDGlPiK2JJmxSOA9H7PJvjJF0pW3Hm67f5DLhe5gEmDQJYb8nq2mi+SSpjfwA4YGN+dArclkDmMRpR3J3HCRrDi1WGDt1vhG+rTagCZARqUrQPxqGOLXdKk2rDHEaiQzFdfMl/MpFkt1O3cTuKk5HkYJaRX3UYVoSpKzNtKUdc7TSDRXi6NVIrHMvnYChB1+wT0wC0eJwSKkQfP96nhXbllwjGCZOoEw9VZGXy0WR6/rHxgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777359828; c=relaxed/relaxed;
	bh=m65F23/62CDX/gfV+DJ/SyWW1JLoAdNRr+rVnoGxkFY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LSSucKnmwZU9XkT/PpSw9ngmnuMzaDE+V3nFMxphIjJIHn6ruHZaU5r4kS+/apcgd8Hu1i+C6/4oE6IEQSrZgo/La1U9mxPcz1iOj8NUit5LaBBg4gC25xg7oG7KxfU7EAetgPk+k9/91ZMWc64YcW9XKGbot2/npHbgQzoJUPE/bBuDYXxyOr42GrUfePc7p0l49G0nnkmyQmpU1WnrO/lv3TfS76K75LIP/o5meXMfYNUPrIzd3znzeppVySQpkvnzFzvKMZu6VzbKv61gFCgL++hMIRMZ0y+ueuMlG+YOHyBpI555ADKmih5+cftW/ZlIRke7lhdfQIxWZLcUbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uEMowhdT; dkim-atps=neutral; spf=pass (client-ip=95.215.58.183; helo=out-183.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uEMowhdT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.183; helo=out-183.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4Wcc5NJTz2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 17:03:44 +1000 (AEST)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777359803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m65F23/62CDX/gfV+DJ/SyWW1JLoAdNRr+rVnoGxkFY=;
	b=uEMowhdTmYivW6Yp0mQBkEN0edND6tucf0nNvmJCZ/QVuvXHHewn1r5qXw5/JMu/dqG6wm
	rcH7y0jjypRkLS5LeeLRPQgyO9AbGnuES3UYZh2lh89R74LUQunJaKdHqwlXmG9noWSCD2
	UQh11NwUPbATYpKCGFyHnHOvZRRzuK8=
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
In-Reply-To: <afBaMEBoR_35Fblc@kernel.org>
Date: Tue, 28 Apr 2026 15:02:14 +0800
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
Message-Id: <96DB49C7-A7C2-4F53-8321-FF4A4ECDFF95@linux.dev>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-10-songmuchun@bytedance.com>
 <afBaMEBoR_35Fblc@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 28, 2026, at 14:56, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Sun, Apr 05, 2026 at 08:52:00PM +0800, Muchun Song wrote:
>> When vmemmap pages allocation or usemap allocation fails, =
sparse_init_nid()
>> currently only marks the corresponding section as non-present. =
However,
>> subsequent code like memmap_init() iterating over PFNs does not check =
for
>> non-present sections, leading to invalid memory access (additional,
>> subsection_map_init() accessing the unallocated usemap as well).
>>=20
>> It is complex to audit and fix all boot-time PFN iterators to handle =
these
>> partially initialized sections correctly. Since vmemmap and usemap =
allocation
>> failures are extremely rare during early boot, the more appropriate =
approach
>> is to expose the problem as early as possible.
>>=20
>> Therefore, use BUG_ON() to panic immediately if allocation fails, =
instead of
>> attempting a partial recovery that leads to obscure crashes later.
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>=20
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks.

>=20
>> ---
>> mm/sparse.c | 37 ++++++++-----------------------------
>> 1 file changed, 8 insertions(+), 29 deletions(-)
>>=20
>> diff --git a/mm/sparse.c b/mm/sparse.c
>> index effdac6b0ab1..5c12b979a618 100644
>> --- a/mm/sparse.c
>> +++ b/mm/sparse.c
>> @@ -354,19 +354,15 @@ static void __init sparse_init_nid(int nid, =
unsigned long pnum_begin,
>>    unsigned long map_count)
>> {
>> 	unsigned long pnum;
>> - 	struct page *map;
>> - 	struct mem_section *ms;
>> -
>> - 	if (sparse_usage_init(nid, map_count)) {
>> - 		pr_err("%s: node[%d] usemap allocation failed", =
__func__, nid);
>> - 		goto failed;
>> - 	}
>>=20
>> + 	if (sparse_usage_init(nid, map_count))
>> + 		panic("The node[%d] usemap allocation failed\n", nid);
>=20
> Please consider using memblock_alloc_or_panic() in =
sparse_usage_init(), it
> would simplify the code even more.

Hi Mike,

Yes. I have several more updates for v2. Please hold off on reviewing
the current version to avoid wasting your time; I=E2=80=99ll send the =
new one
over shortly.

Thanks.=

