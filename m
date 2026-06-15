Return-Path: <linuxppc-dev+bounces-22617-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93ED8CD98C5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 08:45:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf3cQ1lG2z30gJ;
	Mon, 15 Jun 2026 18:45:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.177
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781513158;
	cv=none; b=VHaAOXTUvYaY93dOehUE5fQo6WMo/WQ8OEae+S/HyEJ3X0MZmuvw53aZ41iTdK+Mh35JRDrHuWa6+32jPVqwYWtBKz7flrVtJVUm5qpILm5bbjZDdKKe0EqlYo0pdR+KbCpAfLQIvuINy9gKoq4YiNjVmEf5ZVkCeVmCPlrOXZtNvQWG9fr+HqhvwSmuX9JYpPvrXhGuXrK6oYtGLkaKGLpa7UUaBcyCWs50jIJl1HBd6jUCAqx29Mw1Pz4dxEiZhVCvd42ThmdxmUzeNLkFRZ3wbvov9zTphhT/qAlSm9Bda9aLW0WcUA1hlslulmjmb/RttdBYtAyMsVY2dVnUow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781513158; c=relaxed/relaxed;
	bh=9Jm4k2i1ci/THg4OcVgCv1Y10n2g7/5+J2F//tf0Ado=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Uc7jIF+qAEGfX5aIxDCSbDGRMdqShMTg5o5FIGzkftSPYV5OOzqshdOeo4KrF9jNT3ZqVVztz6Cy2HrS/vNSiuvqajR+eQiNpWY4KrcUlttN5xdOTtmNhbz9LwmMSA1XGk0esXg/Rn89O1lRFtNIf1Cx46mXD2Q8gn1Kmo0IHX4VmiOS6d9MaXbiTDlDYB2VNtZgZc8tPW4IN+CV+Mj4rk0VEl+o0GHpwyJQ4nRb3JPUMn4XR6GLX9+4kcQOPR38ePaFJf5xCiIP7QnKUxSPtsI8A04HncCt4z7mjElUdQSrcGtXzGyaTRmYorlGSc1nNmY508riHI/lwkDuyIQnUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Hkljb8J7; dkim-atps=neutral; spf=pass (client-ip=91.218.175.177; helo=out-177.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Hkljb8J7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.177; helo=out-177.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf3cJ3klXz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 18:45:51 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781513129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Jm4k2i1ci/THg4OcVgCv1Y10n2g7/5+J2F//tf0Ado=;
	b=Hkljb8J7pCiLEUhyQY16gBNRETl0vYvjfj/swktUmFSzMKg8I0fR4+bIC8enNuSbBnZfwh
	3R9UTd1e1xfylTPm/Fiy7Z8JsbGEdq6aGH5xaAPjMyB5kXAIDU8vK5fGefV27Fhm2M7tbv
	MX/zl2wkZoqzXvOYThktd19dkbVpSzo=
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v3 14/19] mm/hugetlb: Free cross-zone bootmem gigantic
 pages after allocation
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ai56f5AxGJQ5SiGp@kernel.org>
Date: Mon, 15 Jun 2026 16:44:48 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <386B96EF-7EBB-44C0-8B83-D4BB8B60D649@linux.dev>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
 <20260602101039.1867613-15-songmuchun@bytedance.com>
 <178041489395.457517.12727427621570734471.b4-review@b4>
 <1ABCD934-CA2C-4541-9B76-32FAEFD398FF@linux.dev>
 <ai56f5AxGJQ5SiGp@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Jun 14, 2026, at 17:55, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Wed, Jun 03, 2026 at 10:53:04AM +0800, Muchun Song wrote:
>>> On Tue, 02 Jun 2026 18:10:34 +0800, Muchun Song =
<songmuchun@bytedance.com> wrote:
>>>>=20
>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>> index 5e557c05d80a..218fb1ca45f4 100644
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -3073,22 +3076,38 @@ static bool __init =
alloc_bootmem_huge_page(struct hstate *h, int nid)
>>>> [ ... skip 26 lines ... ]
>>>> + * pages belonging to the requested node.
>>>> + */
>>>> + if (WARN_ON_ONCE(nid_request !=3D NUMA_NO_NODE && nid !=3D =
nid_request))
>>>> + list_add(&m->list, &huge_boot_pages[nid_request]);
>>>> + else
>>>> + list_add(&m->list, &huge_boot_pages[nid]);
>>>=20
>>> Can we just memblock_free() the page that intersects zones here?
>>=20
>> I had previously considered doing this, but then I realized that if =
we free the
>> allocated cross-zone memory here, memblock is very likely to select =
the exact
>> same block for the next allocation. This means we'd just end up with =
this
>> cross-zone memory again, degrading allocation efficiency. Unless =
there is a way
>> to mark the block so memblock avoids reallocating it, I ultimately =
chose to
>> defer the release to prevent this issue from happening.
>=20
> You are right, there's no simple way to avoid memblock using the same
> range.
>=20
> The comment at hugetlb_hstate_alloc_pages() hints that we might want =
to
> split allocation of gigantic pages to be more explicit as a followup
> rework and then freeing of cross-zone pages would be cleaner as well.

Make sense. A followup rework is better.

Thanks.

>=20
>> Thanks.
>=20
> --=20
> Sincerely yours,
> Mike.


