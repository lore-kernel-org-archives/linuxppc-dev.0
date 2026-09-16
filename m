Return-Path: <linuxppc-dev+bounces-27474-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BF7C982C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 08:46:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlCDS2Kmvz2yYf;
	Wed, 16 Sep 2026 18:46:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::c1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789548408;
	cv=none; b=e9le+8vvw39lfaZ6kTNMnR7kLdEYT0FwWlkGw7xoXXdmVVl/mytm9tbrj07tm2FowOt9OGiizflIgFJXJPm+SUlXN3TbuRISp2zqMJDV97JYNnNbNrusmDN6+UmwhK5zSxKlkOEQgTcyvSOqkbzFDJOOGumj1hBnS8SD288XObrM0W+qDrt2d4NkVY3i/Jmw+lhnFJPr1G/9T8S1Bx4EMyo4HmY7uchvtVlih4WjofClT5ppAkYaMt5MdySNwjhZquL9QkeDcNm9yxvGeDY3Aia0DFVnpgcTwaREBNWmOwyDZldXN3zgMuuax9FpA7OoucPa40/mFifwQpVu+HdFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789548408; c=relaxed/relaxed;
	bh=TVDGxY7b9X8J5O6v3/wXzGtnmgPSWcVewApf2YI2SYM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BiSJblvfVCjj8AtLQs/CZtYiiozbo53tyalYOGQ5gVKWTXREiN0sQkLvk922pV18gYRquB7scyBMHASGOMPZCrZi3boW36kAiCb41dXnccLYJX/AJnkmHWhNXvZ/kSU6IXzXMCv/CKTZmflBy5kcMbHyX40zarZ5Ky+yvudJENfCCIkdOGHBgtCI4TuM6UzpYQ7UtmXBHP62lqgsfZz1vXpax/J2rmDqcO+AQydStPeWlQuvWsTihrrzi3FzjIH3sBG0MFtZ7sqsFyTxp4oNIYoK+MRhlM79kL0/aTXgz04JrFVfnuNDjbI8B0+X2N9Rq8qyVxH/BfwXcSxHwQ2avQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JUUdEWfW; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::c1; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JUUdEWfW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::c1; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-193.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlCDM6YrPz2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 18:46:42 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=TVDGxY7b9X8J5O6v3/wXzGtnmgPSWcVewApf2YI2SYM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789548379; v=1; x=1790153179;
 b=JUUdEWfW23EfHdz2R4C8Vu1w2tDUhNtLR+9LqMGFnEsF0CIiHffYdaljdrABaOleFVIGhBtY
 OKEQQlkcerBLNxOkLcY9KtOsT9mw8g0pHGcIEGdvZ9VL7uRowQRWRVi0K901UX9lwJzWkpugtmO
 Gf8lLeC8D4inkpO8CnjiVj8w=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta12.migadu.com with ESMTPS id 93c2e6536672d7bf;
	Wed, 16 Sep 2026 08:46:19 +0000
X-Mizu-Trace-ID: 93c2e6536672d7bf
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
Subject: Re: [PATCH] fixup! mm/sparse-vmemmap: introduce
 CONFIG_VMEMMAP_OPTIMIZATION
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260916083627.2145779-1-songmuchun@bytedance.com>
Date: Wed, 16 Sep 2026 16:45:57 +0800
Cc: David Hildenbrand <david@kernel.org>,
 Muchun Song <songmuchun@bytedance.com>,
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
 Randy Dunlap <rdunlap@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A2BDF6D-96D2-4771-AB3F-7E702B01FFF2@linux.dev>
References: <20260916064341.1825793-2-songmuchun@bytedance.com>
 <20260916083627.2145779-1-songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Sep 16, 2026, at 16:36, Muchun Song <songmuchun@bytedance.com> =
wrote:
>=20
> The section-based vmemmap optimization infrastructure is guarded by
> CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP, but it can also be used by
> ZONE_DEVICE users that set dev_pagemap::vmemmap_shift. Introduce
> CONFIG_VMEMMAP_OPTIMIZATION as a common config for the shared
> infrastructure.
>=20
> Select the new option from HUGETLB_PAGE_OPTIMIZE_VMEMMAP and from
> ZONE_DEVICE when the architecture opts in to DAX vmemmap optimization,
> and use it to guard the generic sparse-vmemmap state and helpers.
>=20
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Qi Zheng <qi.zheng@linux.dev>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
> Note: When folding this fix into
> "mm/sparse-vmemmap: introduce CONFIG_VMEMMAP_OPTIMIZATION",
> please use this commit message for the resulting patch.

Hi Andrew,

Sashiko found a configuration issue in patch 1 [1].

MSHV_VTL sets a non-zero dev_pagemap::vmemmap_shift for VTL0
memory. However, VMEMMAP_OPTIMIZATION is currently selected only by
DEV_DAX or HUGETLB_PAGE_OPTIMIZE_VMEMMAP.

With ZONE_DEVICE=3Dy and MSHV_VTL=3Dy, but DEV_DAX=3Dn and
HUGETLB_PAGE=3Dn, VMEMMAP_OPTIMIZATION is therefore disabled.
__vmemmap_can_optimize() always returns false in this configuration,
so VTL0 memory uses an unoptimized vmemmap despite its non-zero
vmemmap_shift. On common x86-64 configurations, this can consume up
to about 1.5% of the mapped VTL0 memory for vmemmap metadata.

The report is correct. The fixup in the parent message moves the
conditional selection of VMEMMAP_OPTIMIZATION from DEV_DAX to
ZONE_DEVICE. This covers every ZONE_DEVICE user that sets
dev_pagemap::vmemmap_shift while retaining the architecture opt-in
through ARCH_WANT_OPTIMIZE_DAX_VMEMMAP.

It also removes the DEV_DAX dependency on ZONE_DEVICE that patch 1
added solely to satisfy the Kconfig dependency of
VMEMMAP_OPTIMIZATION.

Andrew, could you please fold this fixup into patch 1,

"mm/sparse-vmemmap: introduce CONFIG_VMEMMAP_OPTIMIZATION"?

[1] =
https://sashiko.dev/#/patchset/20260916064341.1825793-1-songmuchun%40byted=
ance.com

Thanks,
Muchun=

