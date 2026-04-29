Return-Path: <linuxppc-dev+bounces-20256-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314B6FF885A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 03:15:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g52W23JQvz2ySW;
	Wed, 29 Apr 2026 13:15:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777432542;
	cv=none; b=fORrIjv17nBXVyJvbqgHvkcnHAtg0JjBvXvim69JN47LHVAFbF1+H6EA0pMkrrpccXpqWtGiEyANOlhqj+u2+HRoLubxCAS7HgTXNXZ4jp/TwsQbEPRXwtRZXanWQclcEkS4K7gJZVPiPX9UATjZfdUjyy700LyE5fQzCMHOGwb22vGOnGZ137aOPevR7ilYcRoC3PQo5C6QuND1cRes/pV35lfVCTTgTKSw2vcR6qg0tTQk2mhNCrGB/7jhysn8Ya2UcmmF/yqyoKXRh0zSbypnZP9pOxKEtJd/K/e3ACjBIIFwy/wMODZ9JNCczeSGn6f8O+Rtjn80G/aJz7LemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777432542; c=relaxed/relaxed;
	bh=qU5tmzrS1IaHJYw4tCQ3LolTQkEkhN4AGDqa8zVsBOY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LaHZ1x58X8+U3jMGjWTqWba9Ty/3Z8Cy948tHzEsn36Cl+WL+nx6YQgdB7clhCGhWR9dTWe15iZPCQGhNzmTSjnocXAdfMb53Cw3nknXs1iaP2HMJnANV1LpnFr+jkFRKVIXj4LTU/eoR10H7KL8uUfmmxcA7P4pVTzdhvSUoOeDwhiajWoBylOcIYOIiuoap86zgPG1jU9sVqQgw+pjalrMj3qMGjZsyDD3eCwUQBrrdHvE8E+EBAFzRxn/w7P54NsMrxc7AIfbMZBgW6JcSefCOIzCNj85Of2YaOsnM1jjNLquDrc7AWPryRaA/Uq1F9XKigf0o8sd7VzhXb+Ntg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G5pTeOpl; dkim-atps=neutral; spf=pass (client-ip=95.215.58.173; helo=out-173.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G5pTeOpl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.173; helo=out-173.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g52Vy57sJz2xTh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 13:15:37 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777432517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qU5tmzrS1IaHJYw4tCQ3LolTQkEkhN4AGDqa8zVsBOY=;
	b=G5pTeOpltJII7tZbmqmbXcd2mxNQW+oQBat6cBWM+NlWV218lDA++quyRMXu+eAmQF5aQp
	FlPTaucRkiYHiUnqppywHZevYmAx7s0qfE7hjjWhHt5+KUXS54L3k96qPoRzNHqZOf/kjY
	FvOukquIXnh4VKoapeLovcgSmMrPJoQ=
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
In-Reply-To: <afCxZ5vYDeAlzTK2@kernel.org>
Date: Wed, 29 Apr 2026 11:14:14 +0800
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
Message-Id: <408EDCB4-7F65-4595-BE44-E23300FBD397@linux.dev>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-10-songmuchun@bytedance.com>
 <afBaMEBoR_35Fblc@kernel.org>
 <9FD13495-58E8-4183-AAC0-48E50A694ADE@linux.dev>
 <afCxZ5vYDeAlzTK2@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 28, 2026, at 21:08, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> Hi Muchun,
>=20
> On Tue, Apr 28, 2026 at 08:13:05PM +0800, Muchun Song wrote:
>>=20
>>> On Apr 28, 2026, at 14:56, Mike Rapoport <rppt@kernel.org> wrote:
>>>=20
>>> On Sun, Apr 05, 2026 at 08:52:00PM +0800, Muchun Song wrote:
>>>> When vmemmap pages allocation or usemap allocation fails, =
sparse_init_nid()
>>>> currently only marks the corresponding section as non-present. =
However,
>>>> subsequent code like memmap_init() iterating over PFNs does not =
check for
>>>> non-present sections, leading to invalid memory access (additional,
>>>> subsection_map_init() accessing the unallocated usemap as well).
>>>>=20
>>>> It is complex to audit and fix all boot-time PFN iterators to =
handle these
>>>> partially initialized sections correctly. Since vmemmap and usemap =
allocation
>>>> failures are extremely rare during early boot, the more appropriate =
approach
>>>> is to expose the problem as early as possible.
>>>>=20
>>>> Therefore, use BUG_ON() to panic immediately if allocation fails, =
instead of
>>>> attempting a partial recovery that leads to obscure crashes later.
>>>>=20
>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>=20
>>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>>=20
>>>> ---
>>>> mm/sparse.c | 37 ++++++++-----------------------------
>>>> 1 file changed, 8 insertions(+), 29 deletions(-)
>>>>=20
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
>> Should we add a new function like memblock_alloc_node_or_panic? =
Because
>> we want to allocate vmemmap pages on the same node.
>=20
> Heh, I missed the nid part :)=20
> There are a few _node_ or _nid_ allocation helpers in memblock, =
starting to
> add _nopanic for them would be overkill. Let's keep panic()s at call =
sites.

We can add a panic inside memmap_alloc() because it is used specifically =
for
memmap allocation. To some extent, this also reduces the number of =
places where
callers need to add a panic. What do you think?

Thanks.

>=20
>> Thanks.
>>=20
>>=20
>=20
> --=20
> Sincerely yours,
> Mike.



