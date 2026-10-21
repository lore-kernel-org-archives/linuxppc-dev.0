Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CDD606A319
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2026 05:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=luoyeHPH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8dM402RLz2xLf;
	Wed, 21 Oct 2026 16:36:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::22"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792561007;
	cv=none; b=XguO5zZB4pbKUxNFmPj9HO5NNUuuBpMccyUrZ7JrhidFE4rucxOlnFYUG3/SO2m4AcOGeWqaW1RHjZ9N2yUrOLjMYvCNkrIv+glCfhVZIkyvZ1bqQXDuoNTimipRgGZx0KUCxEYkIWELJ11kJpqkD7B6xWzaCTEOyX0OChGVCZQUlWy7WdbBgb9dSc5VjAyBh9Jg315NhJ71O+9kAftSsywqSongEMU3gN8fxY39WHxKEx33p8sMYGuDxRxqL0iXIyaelVqJ4V33TdGKbqPTpSDv6wjNR86/rMig2xoWEF/5MGQEG0riwd67B+VG9AMlHM2Qm/DGcrVj52xkvU/J6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792561007; c=relaxed/relaxed;
	bh=o3QDH4GHZKZklfz0YvP98XXlcOQ9C0e/UzN3/wc5PoU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FR4fkOpTPwyYQWxbBqdnSBf+juiT7298RByoweUSR6lvX1FO/gi6g/lAyy4aA2mdP20O07LBcsbs1yrFBWP+VHs5LLHqiwhU+5KIMsWO3bBNqZVqtuDJBw24svlicrxnV1SNbbHBRdxhpy20FpU6873Cn/I9mSAzeDh0DUSjtz+whpnRs2BBW8arPD3lRjGPsiiri0NZ4jyneJo/Gk7WbBcEe5352uL5i+N1hKTQL3GqRH1DArdnqIbt9HJ90gm8ZwkIctY59LhJNaPAGXhkxNWi+lPRG+AXg/l2+JylQmYelhnVppXnzkc+G6wfXymZAM6w3gIxbornz/tEewM4DQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=luoyeHPH; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::22; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=luoyeHPH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::22; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-34.mta0.migadu.com [IPv6:2001:41d0:1004:224b::22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8dLz6vVvz2x9c
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 16:36:41 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=WRus9dGBDYjUeT/LwFm/stq6NmRjNXUQhGme5JxIkOY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792560982; v=1; x=1793165782;
 b=luoyeHPH6x3yhOyE2QrOEiKTsuLBH2bb4PQiEdYqtGEvh0MnnaAj9tJrZ1HAb9qYsR/qASIa
 5/u3IENo3j1lgFPUZgjyzZXsf8dzM+USSkRXGxSHBywXQcifyHvlfirzE0YNM/BfclNUKNi3lAs
 zpgrmirXOdkoONjWDJweCQ/k=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta12.migadu.com with ESMTPS id 3d92309cb2c66050;
	Wed, 21 Oct 2026 05:36:22 +0000
X-Mizu-Trace-ID: 3d92309cb2c66050
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 1/4] mm/sparse-vmemmap: map shared vmemmap tail pages as
 read-only
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261021045744.93554-1-lance.yang@linux.dev>
Date: Wed, 21 Oct 2026 13:36:00 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 akpm@linux-foundation.org,
 david@kernel.org,
 osalvador@suse.de,
 maddy@linux.ibm.com,
 corbet@lwn.net,
 ljs@kernel.org,
 liam@infradead.org,
 vbabka@kernel.org,
 rppt@kernel.org,
 surenb@google.com,
 mhocko@suse.com,
 mpe@ellerman.id.au,
 npiggin@gmail.com,
 chleroy@kernel.org,
 ritesh.list@gmail.com,
 sshegde@linux.ibm.com,
 skhan@linuxfoundation.org,
 rdunlap@infradead.org,
 qi.zheng@linux.dev,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F19AE41A-8150-4444-B18D-824BB0CECB82@linux.dev>
References: <20261019090830.1917657-2-songmuchun@bytedance.com>
 <20261021045744.93554-1-lance.yang@linux.dev>
To: Lance Yang <lance.yang@linux.dev>
X-Mailer: Apple Mail (2.3901.100.1.1.12)
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On Oct 21, 2026, at 12:57, Lance Yang <lance.yang@linux.dev> wrote:
>=20
>=20
> On Mon, Oct 19, 2026 at 05:08:27PM +0800, Muchun Song wrote:
>> Both early HugeTLB HVO and device DAX use the common vmemmap =
population
>> path for shared tail mappings. Map these pages read-only so that =
illegal
>> writes fault instead of corrupting metadata shared by multiple tail
>> pages.
>>=20
>> For early HugeTLB, this moves existing write protection into initial
>> population without changing the final mapping. Device DAX gains the =
same
>> protection.
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> Documentation/mm/vmemmap_dedup.rst | 3 +--
>> mm/sparse-vmemmap.c                | 3 +++
>> 2 files changed, 4 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/Documentation/mm/vmemmap_dedup.rst =
b/Documentation/mm/vmemmap_dedup.rst
>> index 8c287ae3f86c..76f903975a40 100644
>> --- a/Documentation/mm/vmemmap_dedup.rst
>> +++ b/Documentation/mm/vmemmap_dedup.rst
>> @@ -193,5 +193,4 @@ There's no remapping of vmemmap given that =
device-dax memory is not part of
>> System RAM ranges initialized at boot. Thus the tail page =
deduplication
>> happens at a later stage when we populate the sections.
>>=20
>> -Deduplicated tail pages are not mapped read-only. The mapping layout =
is the same
>> -as HugeTLB.
>> +The mapping layout is the same as HugeTLB.
>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>> index 40eba70c0048..ba0496daf4de 100644
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>> @@ -295,6 +295,9 @@ static pte_t * __meminit =
vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
>> return NULL;
>>=20
>> 	entry =3D pfn_pte(PHYS_PFN(__pa(p)), PAGE_KERNEL);
>> + 	/* Map the shared tail page as read-only to catch illegal =
writes. */
>> + 	if (vmemmap_optimizable_pfn(pfn))
>> + 		entry =3D pte_wrprotect(entry);
>=20
> LLM pointed out that an AO MCE before bootmem gather could still reach
> TestSetPageHWPoison() on a shared tail, since the head isn't marked
> hugetlb yet.

Compared with the RO problem, a more serious issue may be
that the struct page has not yet been initialized, and the
MCE preprocessing flow may all be problematic, performing
various operations based on an uninitialized struct page.
However, this problem is not specific to hugetlb; the same
problem exists when CONFIG_DEFERRED_STRUCT_PAGE_INIT is
enabled.

>=20
> Wouldn't that trigger an Oops ... Anyway, I wouldn't expect to hit =
that
> during boot.

Therefore, I do not think this kind of problem during the boot
stage is a problem, because we have no way to prevent it.

>=20
> Reviewed-by: Lance Yang <lance.yang@linux.dev>

THanks.

>=20
> [...]
>=20
> Cheers, Lance



