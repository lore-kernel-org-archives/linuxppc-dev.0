Return-Path: <linuxppc-dev+bounces-21908-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD591CD6E57
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 15:41:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVFS91q4Dz2xLm;
	Wed, 03 Jun 2026 01:41:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780414905;
	cv=none; b=PN1PUQDqeeZm7OD4Co+AqNaz+5IH1RE3lxklb4EjQTrVP9ynbjoRhl5Q22IiX7IASomIEVahiYE+040K/rA23bh1r0dzUgkSrKJ80xg0gnX/N+GbMzk2eVCk1BiD6cP42yLqcTW8aflYsb3x5SgtiYBnz+fGb46Qnv1EbvUPjm2tZIc0M4kIRNAQSlju8o+nGJuPIdIL0gqX8EFXpSczvNKhuKy0AxFGjdKBokkzhMLuO8nRrwoL+m3GkgPmNXnS4YlyECdhcwnfqF4igmySCpYsfCnDNkxh3R4C/n0Al2/ypdOFhJvy59oI/RaTf3UqJK8tscKhmjXtK8Q2ckYrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780414905; c=relaxed/relaxed;
	bh=dDeL5/tHUjTJpeqAIfWOboAboZg65R7Pct0LUws/rMs=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=JKsq5O0/PBvbGApDoIpssOm9R7BwnGSmfFgXGKAYv3rVrdOhV3wIkU7vL6WOQWfHLL37LDQYmiFONvkhbXTyTp+v+tRD+bAiwoOCZGphngO0cnYWYQN2Otijy3Q7aA2jwV/tuiSYlVXsz1c/9VR/47wBB4ZgxnoSx/99psrDnkIRV8M7JjRXkHbDEcaHy8nPZCmVd6ic5kKzew3VKxoPvw5sV5R3hC5LnZITKgS4wkmGkwLgBszs5yExuruwyJMATAhiv+VA0myXPA7gKxYLnbbSpZ4H06lrvSVOuErxM3O1ok8+BN3j/Eu32y73PsoC0NyXpwZA3r/f5QGGn5Tbrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=me0jPRdq; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=me0jPRdq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVFS82nf2z2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 01:41:44 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0A81F402BF;
	Tue,  2 Jun 2026 15:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2291F00893;
	Tue,  2 Jun 2026 15:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780414901;
	bh=dDeL5/tHUjTJpeqAIfWOboAboZg65R7Pct0LUws/rMs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=me0jPRdqnYj5C46x8bmjWHIvOjXoVYz0SkW/4T7z6T7OR2Bev2C7GE8dK8iejFgmX
	 rPPsvKBB7LgVWJW8DY6j8/AmrZff7QYT1Aotq5i0IwgzRdcempoD8jLuVXBN9oUupj
	 A0Jxb0YwYK56EsboskstCYohBV1bXPVbCz+Yt5SXojiGrPoa14eyGkGbZKEFz/PM4j
	 9CB8lvlKt2/S88rPxX4vG/cElRl4bq37AplkPCvLm0HEaiT50q5cXecSKSN2CYg0Nc
	 efCraJAOJgznly00AO4p7vjQ7RnyVdICzv2UwJ3ay4bEPKhhchpLUOBsgXmQhF9SEU
	 FAR9K3i3FeSeA==
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 14/19] mm/hugetlb: Free cross-zone bootmem gigantic
 pages after allocation
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
 linuxppc-dev@lists.ozlabs.org, Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20260602101039.1867613-15-songmuchun@bytedance.com>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
 <20260602101039.1867613-15-songmuchun@bytedance.com>
Date: Tue, 02 Jun 2026 18:41:33 +0300
Message-Id: <178041489395.457517.12727427621570734471.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 02 Jun 2026 18:10:34 +0800, Muchun Song <songmuchun@bytedance.com> wrote:

Hi Muchun,

>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5e557c05d80a..218fb1ca45f4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3073,22 +3076,38 @@ static bool __init alloc_bootmem_huge_page(struct hstate *h, int nid)
> [ ... skip 26 lines ... ]
> +		 * pages belonging to the requested node.
> +		 */
> +		if (WARN_ON_ONCE(nid_request != NUMA_NO_NODE && nid != nid_request))
> +			list_add(&m->list, &huge_boot_pages[nid_request]);
> +		else
> +			list_add(&m->list, &huge_boot_pages[nid]);

Can we just memblock_free() the page that intersects zones here?

Rather than making alloc_bootmem_huge_page() bool (sorry my bad :)) we
can make it return -ENOMEM when memblock_alloc() fails, 0 if the page is
not usable and 1 (i.e. number of allocated gigantic pages) if everything
is fine.

The callers would need a bit of massage, but it still seems simpler to
me than adding them to the list and then walking that list.

-- 
Sincerely yours,
Mike.


