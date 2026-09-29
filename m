Return-Path: <linuxppc-dev+bounces-28465-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36741CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 08:01:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv9c64CpPz2yDD;
	Tue, 29 Sep 2026 18:01:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.200
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790668886;
	cv=none; b=GKmuKn8vVbk5QJiLRnnK9X1R+ffTd3BX6T8xbugYo+1RhXRzGJMD2lJeEKf694LvzQtTX1+eSj3I4UzHcxcMZI6ARcFhf63cUDInXZJiDppNjYaCCts/S8ae/OOstao/qacjx8q2wSTm9b8tQMB9WGxuQI794QzvTpYBXMNjUg9XTL481wShOvLhckuZNlkIgf22QNdULw/z9xnpLXhzRZ7vqggmI36+ySJCgvaJ98UcNJXm9rldUERrdXlsa6NE6liISnEXmNbutvGgnr0yPRAycXNBqTP08fVO9sYitWT/2HeOKJHO6RQWISft4MwNFaUcqkirypvrGXqC8Gbv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790668886; c=relaxed/relaxed;
	bh=1IwuMSJacXuO5iuVtr1QHu3zZ5caPuzPzh2uVWiE6/U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KlZg1yYrRPQeSYn1W3ZNQ4SXIlaZMdm43RrsnEdrKMY2+nmZdhOL8gAnJa4i919igV35l5mTOAKaImLbk7NuzQ0F1V28Cmjp87Mwje9Hd1XMFjLD5uDvm5ueo4XKWnt0+jeqtHitcEQ5Xui7vI8j1in9CjMFFN2yrATgzh+4Jl1oKjDYH2DgOqrvydgntPq2yP2tEKKZ0/FktJDaRp44HoC8THv1naSlJcFf5B6QrU64VSNpUdpNtv37/ruCPG0nSoP5/pUJblwFHaZeZuishG8LAMfGSEL9AjeWzQjteNq2UCUh+K1EPnBmspjTsFb1qwNFw3kBI4k+2fyr54FqMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uwkw+xlU; dkim-atps=neutral; spf=pass (client-ip=95.215.58.200; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uwkw+xlU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.200; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-200.mta1.migadu.com [95.215.58.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv9c41ZTLz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 18:01:23 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=MD9qZpr2p5t9FhYsovu1Jono6fdj3Cfdqpkd+cOqNz0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790668865; v=1; x=1791273665;
 b=uwkw+xlUVWQ2sgOn7jzpFAYwfkWbYfy9enm1gQfMh/5pjq0Y2gGxrAEBUOZbR6KXKrOaGHf9
 jARK7fAnWoUsdM9iJWvFgzFlHRoRzy+qHJoPHLtLiMC+hA3B84hOq1ifN0p/NTLmZQZJh2Jyutn
 mSUiU9tHWXM8ddBhVjGxZmjk=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta11.migadu.com with ESMTPS id 737886a2c9b58270;
	Tue, 29 Sep 2026 08:01:05 +0000
X-Mizu-Trace-ID: 737886a2c9b58270
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
Subject: Re: [PATCH v5 02/12] mm/sparse-vmemmap: allocate shared tail page
 array dynamically
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <36a93f95-2fb4-4310-bef2-88c12dbe7971@kernel.org>
Date: Tue, 29 Sep 2026 16:00:42 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org,
 Lorenzo Stoakes <ljs@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Lance Yang <lance.yang@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <78618F09-296E-4632-A890-53351739024D@linux.dev>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
 <20260927025441.741633-3-songmuchun@bytedance.com>
 <36a93f95-2fb4-4310-bef2-88c12dbe7971@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)



> On Sep 29, 2026, at 15:21, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 9/27/26 04:54, Muchun Song wrote:
>> Commit 622026e87c40 ("mm/hugetlb: remove fake head pages") added the
>> per-zone vmemmap_tails array. Its size depends on MAX_FOLIO_ORDER, =
which
>> had been moved to mmzone.h in preparation for the array.
>>=20
>> PUD_ORDER is defined by linux/pgtable.h, which cannot be included =
from
>> mmzone.h without creating an include cycle. It was therefore =
open-coded
>> as PUD_SHIFT - PAGE_SHIFT.
>>=20
>> This removed the dependency on PUD_ORDER, but not the underlying
>> dependency on architecture page-table definitions. PUD_SHIFT is
>> generally provided by architecture page-table headers, which are not
>> guaranteed to have been included when mmzone.h is parsed.
>>=20
>> The dependency remained hidden because vmemmap_tails was originally
>> guarded by CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP. Under that =
condition,
>> MAX_FOLIO_ORDER resolves to either MAX_PAGE_ORDER or the fixed =
HugeTLB
>> limit, rather than the PUD_SHIFT-based definition.
>>=20
>> Device DAX, however, does not require CONFIG_HUGETLB_PAGE. When it is
>> converted to use section-based vmemmap optimization, MAX_FOLIO_ORDER =
can
>> resolve to PUD_SHIFT - PAGE_SHIFT while it is being used to size
>> vmemmap_tails. This would make struct zone depend on architecture
>> page-table definitions being available when mmzone.h is parsed.
>>=20
>> Replace the embedded array with a pointer and allocate it on first =
use.
>> This moves the order-count evaluation into sparse-vmemmap.c, after =
the
>> architecture page-table definitions are available, and removes the
>> dependency from mmzone.h.
>>=20
>> Removing the compile-time array also removes the original reason for
>> keeping MAX_FOLIO_ORDER and the vmemmap optimization sizing =
definitions
>> in mmzone.h. Follow-up cleanups can place each definition in the =
header
>> owned by its respective subsystem.
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> v5:
>> - Add this patch to fix the RISC-V build failure under the =
configuration
>>  reported by the kernel test robot
>> ---
>> include/linux/mmzone.h |  7 +------
>> mm/sparse-vmemmap.c    | 35 +++++++++++++++++++++++++++++++----
>> 2 files changed, 32 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index acd94cecc0d3..68807ff7f946 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -113,11 +113,6 @@
>> (VMEMMAP_OPTIMIZATION_PAGES * PAGE_SIZE / sizeof(struct page))
>> #define VMEMMAP_OPTIMIZATION_MIN_ORDER =
(ilog2(VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) + 1)
>>=20
>> -#define __VMEMMAP_OPTIMIZATION_NR_ORDERS \
>> - 	(MAX_FOLIO_ORDER - VMEMMAP_OPTIMIZATION_MIN_ORDER + 1)
>> -#define VMEMMAP_OPTIMIZATION_NR_ORDERS \
>> - 	(__VMEMMAP_OPTIMIZATION_NR_ORDERS > 0 ? =
__VMEMMAP_OPTIMIZATION_NR_ORDERS : 0)
>> -
>> enum migratetype {
>> MIGRATE_UNMOVABLE,
>> MIGRATE_MOVABLE,
>> @@ -1156,7 +1151,7 @@ struct zone {
>> atomic_long_t vm_stat[NR_VM_ZONE_STAT_ITEMS];
>> atomic_long_t vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
>> #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>> - 	struct page *vmemmap_tails[VMEMMAP_OPTIMIZATION_NR_ORDERS];
>> + 	struct page **vmemmap_tails;
>> #endif
>> } ____cacheline_internodealigned_in_smp;
>>=20
>=20
>=20
> [...]
>=20
>> struct page __ref *vmemmap_shared_tail_page(unsigned int order, =
struct zone *zone)
>> {
>> 	void *addr;
>> - 	struct page *page;
>> + 	struct page *page, **pages;
>> 	const unsigned int idx =3D order - =
VMEMMAP_OPTIMIZATION_MIN_ORDER;
>>=20
>> 	 (WARN_ON_ONCE(idx >=3D VMEMMAP_OPTIMIZATION_NR_ORDERS))
>> 		return NULL;
>>=20
>> - 	page =3D READ_ONCE(zone->vmemmap_tails[idx]);
>> + 	pages =3D READ_ONCE(zone->vmemmap_tails) ? : =
vmemmap_tails_alloc(zone);
>=20
> This reads much nicer if you handle the  =
READ_ONCE(zone->vmemmap_tails) inside
> the function.
>=20
> pages =3D vmemmap_tails(zone);

Sounds good.

>=20
> So just place the entire logic of obtaining the array in there.

No problem.

Thanks,
Muchun

>=20
>=20
> Apart from that LGTM.
>=20
> --=20
> Cheers,
>=20
> David



