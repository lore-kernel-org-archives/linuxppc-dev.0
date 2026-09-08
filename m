Return-Path: <linuxppc-dev+bounces-26778-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A319EC79FA0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 09:12:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfJB26ypqz2yDD;
	Tue, 08 Sep 2026 19:12:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::a9"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788858762;
	cv=none; b=jFNX7WgIZSUGO3jsqzuPbsYtEwH8ikQLmMhJxf+f5Gk988nJtZMIjeOXdCTNF65OnY9dVfNf4ho2iWIe5jGEdEQyOpZ8wtT7DVGyt47Pk0zymTSCP1jsd10pCVTWZ+ghn5USYffIl68sULtzZXcytpkahuvNM5uTB+SRCBglwdHWZ+pB2QDYwt+NDuY3/8hiPsHbyr6OThEal6J5AQuMvXtsBAnurugWiWf3hx/aIe01tOZ+aPw5UdcKwtd4XvbxvFGzCKJbv8lyz5J6BSSgVhdAqmTWgDY981IkyLxQvgxOG6sHmzHCrE/BsTPhABbMcTUlR/Vnx3aDN0mJSeji8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788858762; c=relaxed/relaxed;
	bh=1XZu7aifbvatTgEqnvJnf1R0X/PHnQuQQyNt48EL1Sg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mF4x6nb/2ka9yov2ya20HbVyILK8uAdUNY5PNyTeUmexJSxnchBX/e517o0jZqcT/4DTxQX17U8MBysmiOl9NyT5fHEXYCOGcw2GhgDV2mdUZ5+nxGzMeJiQ7stJISU38jD7SYi+jlHafwpq6FI+9jG410lAI6dMl3wkfJ8cZeyOQoqrbngJqu9TopjzliJMXpYBQzBk1xh2NXPgFuP0Xhs8/68/Uib9ef+0g+LKtGo1uWKcvDgR/PR0jg5E/alIXk008JI2qQ5P5vyhTeKmuethduxqtHiv5GwQRE7YtGnHtv/9ISCuWfxDFH5lG1I2CWcF76JUmbJkUOC67nRKPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=H5b7n2t8; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::a9; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=H5b7n2t8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::a9; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-169.mta0.migadu.com [IPv6:2001:41d0:1004:224b::a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfJB16dQcz2y8d
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 19:12:41 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=kxPh0WuMikjVIxMhGlyVx6DHT10KZS3T52C5dULvHFU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788858743; v=1; x=1789463543;
 b=H5b7n2t8xEX7kB8ah1JxYVFXls5FQ2H1W8P3YqZqEeS1p5LmhzsbDAaSEaUxFa0y5wSwH1C+
 eUTJ6GoDjVhtEoBiBu9Cxf3XlEiZw1fWTV+Zw988vIV98UUZoZrjg5w+qJ9l7XZwZkMHaYpP1VQ
 rWWwPJHjD9AG6CFF7XB2SgQk=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta12.migadu.com with ESMTPS id e6379ba285176541;
	Tue, 08 Sep 2026 09:12:22 +0000
X-Mizu-Trace-ID: e6379ba285176541
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH v2 09/11] mm/sparse-vmemmap: drop the extra tail page from
 device DAX reservation
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <f2f1f7e4-539f-4385-a28b-1fde074cdeca@linux.dev>
Date: Tue, 8 Sep 2026 17:12:07 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
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
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EBFFB66B-86A5-43A2-95B2-37964D7D753C@linux.dev>
References: <20260908030335.96549-1-songmuchun@bytedance.com>
 <20260908030335.96549-10-songmuchun@bytedance.com>
 <f2f1f7e4-539f-4385-a28b-1fde074cdeca@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Sep 8, 2026, at 17:09, Qi Zheng <qi.zheng@linux.dev> wrote:
>=20
>=20
>=20
> On 9/8/26 11:03 AM, Muchun Song wrote:
>> The device DAX vmemmap population still reserves one extra tail =
vmemmap
>> page after the head page.
>> Drop that extra reservation and let the shared tail page cover all =
tail
>> vmemmap pages after the head page, so DAX follows the same =
reservation
>> model as HugeTLB.
>> This reduces the reserved vmemmap pages for optimized DAX mappings to
>> one and removes the now-unneeded first-tail population from the =
generic
>> and powerpc paths to simplify the code as well.
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>  arch/powerpc/mm/book3s64/radix_pgtable.c | 46 =
++----------------------
>>  include/linux/mm.h                       |  3 +-
>>  mm/mm_init.c                             |  2 +-
>>  mm/sparse-vmemmap.c                      | 13 ++-----
>>  4 files changed, 7 insertions(+), 57 deletions(-)
>=20
> Looks like sashiko's response [1] is a false positive.
>=20
> [1]. =
https://sashiko.dev/#/patchset/20260908030335.96549-1-songmuchun%40bytedan=
ce.com
>=20
> __SetPageReserved() in vmemmap_shared_tail_page() marks the struct =
page
> entries stored inside the shared vmemmap backing page, i.e. the =
metadata
> templates that later represent DEV-DAX tail pages. It does not mark =
the
> struct page of the backing page itself.
>=20
> On hot-remove, free_vmemmap_pages() is called with pte_page(*pte), =
which
> is the backing page. That page is not reserved, so the teardown goes
> through __free_pages(), not free_reserved_pages().
>=20
> Right?

Absolutely right.

>=20
> If so:
>=20
> Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks.


