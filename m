Return-Path: <linuxppc-dev+bounces-19984-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6446AFAD3EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 02:15:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1KSG5ZfGz2ygh;
	Thu, 23 Apr 2026 12:15:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.176
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776910526;
	cv=none; b=BVy59V+ICNV5bTFi9s99snzARxkfTeoC1h6fEJ9nkeTjjBKvMMFrE+j+CITvI7+NdWfSOrM3O6Y7fQ6mqCChM/NlHCDSU5P4wKWcnXzaMhxJByasGcDWcN/xHznSs65Ha6Yt7qL/6mY8a5IGqDRRLJKJ440sSRmlSop4pWp2vJ+GVGA0fg3lFgwPujrlCD0hwbOvUcoHkFJZ7YoHBhTQ2x3l0s45Ap5BBbnAZSIkM0Xw+NaBU+TiLfa7FfT9yIkzYUwjIezIVjohOAp1OywXP33qTJMr9s8FUDMQcGgnKUO/EclbCplS8ZnXt4HK1TxW7tL5tRZnfANjUrX6OplghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776910526; c=relaxed/relaxed;
	bh=n0/01H4xiCJnfs36bIwGAXpJVzm4AGBrMPoyje3Rvz4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=li0vPi4B2UkO4mieMF/YeXYBkhM1+amDA0RCUM8saKbBMPVSqN5IjCmG7/1RBhObJyPVvr3cTRFu+zyrzcx5kYDzfkolYZBjq9nLepw/zbEkYrXmOQyhrMEOwCHHhyhzCYDW6TZH3d1LSvvcLzOTTq9DwepGwkczbx7cdKjeOntraF2rpfrpL9/PWrVpwWr3tuk4T3r5/kmcpK5SQXPidhS2uz8blQDgPIBH/LdvQ29TmSTDLgu32EfdxC+HDDm2/21JN40Wc0uIwIPVw5sjlyBNp4/sRkJGoqvZmB18B2rMXGukKT3YXNeoY97c4B8hR4WrWaZNLV1r/l17bt5R3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ba9Y5yxV; dkim-atps=neutral; spf=pass (client-ip=95.215.58.176; helo=out-176.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ba9Y5yxV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.176; helo=out-176.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1KSD07XNz2xpg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 12:15:22 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776910501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0/01H4xiCJnfs36bIwGAXpJVzm4AGBrMPoyje3Rvz4=;
	b=ba9Y5yxVcom61fXlDbNnPGxckX72Wg1DbZmfHjnu0lMfj/YISK/8hzvjV9zBBmkDvDlXmc
	SbmfdF/oUXqzKRiVmBSDlEqxaH+CHmnwrQ4CWf04UEYAcEGyU3JbHjLzN4e806O8Lolewg
	chajDmzvd9vVnRWQ7EpP9ylApOsyss0=
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
Subject: Re: [PATCH v4 2/5] mm/sparse-vmemmap: Pass @pgmap argument to memory
 deactivation paths
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <fc80afb9-6e97-481f-8136-d684ff3690a7@kernel.org>
Date: Thu, 23 Apr 2026 10:14:16 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
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
 aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3745D308-DF29-477C-A25F-CDA63400D5ED@linux.dev>
References: <20260422081420.4009847-1-songmuchun@bytedance.com>
 <20260422081420.4009847-3-songmuchun@bytedance.com>
 <fc80afb9-6e97-481f-8136-d684ff3690a7@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 23, 2026, at 02:50, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 4/22/26 10:14, Muchun Song wrote:
>> Currently, the memory hot-remove call chain -- arch_remove_memory(),
>> __remove_pages(), sparse_remove_section() and section_deactivate() --
>> does not carry the struct dev_pagemap pointer. This prevents the =
lower
>> levels from knowing whether the section was originally populated with
>> vmemmap optimizations (e.g., DAX with vmemmap optimization enabled).
>>=20
>> Without this information, we cannot call vmemmap_can_optimize() to
>> determine if the vmemmap pages were optimized. As a result, the =
vmemmap
>> page accounting during teardown will mistakenly assume a =
non-optimized
>> allocation, leading to incorrect memmap statistics.
>>=20
>> To lay the groundwork for fixing the vmemmap page accounting, we need
>> to pass the @pgmap pointer down to the deactivation location. Plumb =
the
>> @pgmap argument through the APIs of arch_remove_memory(), =
__remove_pages()
>> and sparse_remove_section(), mirroring the corresponding *_activate()
>> paths.
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>=20
>=20
> [...]
>=20
>> static void depopulate_section_memmap(unsigned long pfn, unsigned =
long nr_pages,
>> - 		struct vmem_altmap *altmap)
>> + 		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
>> {
>> 	unsigned long start =3D (unsigned long) pfn_to_page(pfn);
>> 	unsigned long end =3D start + nr_pages * sizeof(struct page);
>> @@ -746,7 +746,7 @@ static int fill_subsection_map(unsigned long pfn, =
unsigned long nr_pages)
>>  * usage map, but still need to free the vmemmap range.
>>  */
>> static void section_deactivate(unsigned long pfn, unsigned long =
nr_pages,
>> - 		struct vmem_altmap *altmap)
>> + 		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
>> {
>> 	struct mem_section *ms =3D __pfn_to_section(pfn);
>> 	bool section_is_early =3D early_section(ms);
>> @@ -784,7 +784,7 @@ static void section_deactivate(unsigned long pfn, =
unsigned long nr_pages,
>>  * section_activate() and pfn_valid() .
>>  */
>> 	if (!section_is_early)
>> - 		depopulate_section_memmap(pfn, nr_pages, altmap);
>> + 		depopulate_section_memmap(pfn, nr_pages, altmap, pgmap);
>> 	else if (memmap)
>> 		free_map_bootmem(memmap);
>>=20
>> @@ -828,7 +828,7 @@ static struct page * __meminit =
section_activate(int nid, unsigned long pfn,
>>=20
>> 	memmap =3D populate_section_memmap(pfn, nr_pages, nid, altmap, =
pgmap);
>> 	if (!memmap) {
>> - 		section_deactivate(pfn, nr_pages, altmap);
>> + 		section_deactivate(pfn, nr_pages, altmap, pgmap);
>> 		return ERR_PTR(-ENOMEM);
>> 	}
>>=20
>> @@ -889,13 +889,13 @@ int __meminit sparse_add_section(int nid, =
unsigned long start_pfn,
>> }
>>=20
>> void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
>> -    			   struct vmem_altmap *altmap)
>> +    			   struct vmem_altmap *altmap, struct =
dev_pagemap *pgmap)
>=20
> While at it, could switch to two-tab indent here as well.

OK.

>=20
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks.

Muchun.

>=20
> --=20
> Cheers,
>=20
> David



