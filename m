Return-Path: <linuxppc-dev+bounces-20237-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C01FF885D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 12:14:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4fVv1XTHz2xlt;
	Tue, 28 Apr 2026 22:14:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.176
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777378455;
	cv=none; b=QryRQYJ2Plhq04drFpJMm9VPLv11FM15m+jIpBFgWhBkfssUl7MKZzIrdtTAbYyirlCKdSmMV25FWj5o085mv3B+mjSev1z/xto7H6CFqKmh+1O5xn7szX3urDCPC/rxPk9V1BIBTn+17yCspEYzLv7FLeHHiIasX20A5ITA5Z0cjinXDaP4AeV+5v64x/sR4Z/0JUrT1mf/fgXZrKSyvZAZTBAg0LQQapTCRYx6ekNrC7a7kFbFeqiIdBkmiAQFrurDNXQ0RUp2qybRGXAfnPCIFyN/eH4hC/E2itxtKbkeHdhtsMNvaElL/qZKOaKrjLdKmnP2LTXIQE4R0kJekw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777378455; c=relaxed/relaxed;
	bh=gMW0yphc9+JTsHgjuPXzpOHRe/+uClvfXBtsydm1QXs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Hp7XwR7d22qfraJAB2Pjqu0n7NQfHE8FKKD9bIONvt3GfzPZqmq0oZBlSn7ppKFYy647N9t69wLsXWsxK/9vdAR450ROO5Ze52VVBDblL7JEwi/aXnsdkLUeMHXQzyoygPBIcYh5P9LgDRcMhm00CnLV8hy8S4496xuKsSrSjb+zFptZJU0050jhUow9OS2pa5MUqXLdt4y4jIs7BC/akYc0LGa3FU/cMN1KZePcmAr7/Eb1qC82mLi52Rgi4dZT5X7+FEAgkoHlVUGuArC5tpUS5UrXAs+0HeBu8GaZm02oGyHQK4gubeSkcowfE04jJIbrpcuv6hMyHcuiTewfVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=liGzZ/6l; dkim-atps=neutral; spf=pass (client-ip=95.215.58.176; helo=out-176.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=liGzZ/6l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.176; helo=out-176.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4fVr0sj5z2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 22:14:10 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777378430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMW0yphc9+JTsHgjuPXzpOHRe/+uClvfXBtsydm1QXs=;
	b=liGzZ/6lcet38vVzKBuQrY39X3mLjaXryapTkWCkNSiDT8ppz7dunF9bMsRawPXG5pxkR5
	FhcWht8cZvdRPdpyR1p4MmEuMLHcB8c/dHAcKROxBElmkdgDF2smPjKbTZo6pmhUkCtZar
	glo2vu8yjY+mQkvZGqqftuaAu0NP3vQ=
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
Date: Tue, 28 Apr 2026 20:13:05 +0800
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
Message-Id: <9FD13495-58E8-4183-AAC0-48E50A694ADE@linux.dev>
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

Should we add a new function like memblock_alloc_node_or_panic? Because
we want to allocate vmemmap pages on the same node.

Thanks.



