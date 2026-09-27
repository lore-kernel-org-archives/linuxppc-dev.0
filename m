Return-Path: <linuxppc-dev+bounces-28308-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A64C98324
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 10:52:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ht1Ts4nSqz2yPq;
	Sun, 27 Sep 2026 20:52:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790506321;
	cv=none; b=B1wVp5zU09Ro6mcepFaqzqcIWSvWdSLoNnAN666lI9VXk7mXxmDI8gupGKHIuDK45aWnxt1Qs3/qblXvyJM+svKCZyclEzQqD7DjfPfk+9lbcth3sUOBrXfhOV9V60V9mX9ujzEZ0IE2LfJTSwFdC9R9GwWqrgPDaI4MYe3MEQq3wPZorfD1wGUZ5+O3l+TzzKgDCRKe5mJj8FSKCj1BlUncprKSsus/+d1/9nr27gZJNjDpVRDidmVgesmzx6qFWI5wAM7qLVSi7grOX8k80hRY9i3OQ8totZ8Gar/Wbw2hhWZt0PibQC2YORiZ2cqQrpI+hX0i1tJBsoMUBIoJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790506321; c=relaxed/relaxed;
	bh=1vTYwK/wvoIR3O8GrBIjGhV9ooIB1stkGBEkt4hT5EY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BXN6Zpl/8wo/NIixAWfsO0RpgkVVj54YfvxW7JWybizv75dAsUoAu+FVo5GS7lTfsFefEIcii3v67n5vwFiJtYJJhxmO80y7SzTDcO3Jt1Fw/wnr7XCdLNVNC76UGbAE7xtBPXGLGnQajf8uPAEpMJxYsHtvgV4fM6B9S9h46qkyvCFvlcYMtDutYHwiAbR3GkSNMYNljcF3HcCbrfVKKktDcIdTUSgKqv+Bq4eaKx4Q5WXz87p5rrHNJD9ulowVedzkjWBFld8vPSQ4Vip7ESdi3a5C4WbrjurFReozKGO+oNbhN5hPKzricVVOA9SsjX+rYVPYDEpPzu2BPBys2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ciswzDue; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::25; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ciswzDue;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::25; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-37.mta1.migadu.com [IPv6:2001:41d0:203:375::25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht1Tn36bdz2xy3
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 20:51:55 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=1vTYwK/wvoIR3O8GrBIjGhV9ooIB1stkGBEkt4hT5EY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790506296; v=1; x=1791111096;
 b=ciswzDueemh8rjXHHjaJYuW0s/7zQnwe8VjQH0oWizJMzR600+tCZQ0w2JZsi4rNMOvjtfx3
 1LU7t/8EEcWogUuO7wMhwYMh3JlTLNV2Tu/AOgAaWXAdhmGoczl3h7dSVohBS9omlk9rYv6p7iJ
 TWF/3u3msU8mlqcVRxkBx1iI=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta12.migadu.com with ESMTPS id 5500dc4e2682cac7;
	Sun, 27 Sep 2026 10:51:35 +0000
X-Mizu-Trace-ID: 5500dc4e2682cac7
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
Subject: Re: [PATCH v5 00/12] mm: Switch device DAX to section-based vmemmap
 optimization
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260926225105.a56f29d76b2f496c8dc2dac0@linux-foundation.org>
Date: Sun, 27 Sep 2026 18:51:15 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
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
 Qi Zheng <qi.zheng@linux.dev>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Lance Yang <lance.yang@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FB00943F-8DB1-4BEE-BF37-701785DE2DDE@linux.dev>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
 <20260926225105.a56f29d76b2f496c8dc2dac0@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)



> On Sep 27, 2026, at 13:51, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Sun, 27 Sep 2026 10:54:29 +0800 Muchun Song =
<songmuchun@bytedance.com> wrote:
>=20
>> After the HugeTLB conversion, optimized vmemmap state is described by
>> the memory section and the sparse-vmemmap population path can =
allocate or
>> reuse shared tail vmemmap pages based on that metadata. Device DAX =
still
>> uses the older DAX-specific population model, including a separate =
tail
>> vmemmap page reservation and architecture-specific logic to locate or
>> populate reusable tail pages.
>>=20
>> This series makes device DAX use the same section-based model. Device =
DAX
>> records the compound page order from pgmap->vmemmap_shift in section
>> metadata before vmemmap population, uses the common per-zone shared =
tail
>> vmemmap page, and drops the extra reserved tail page. The powerpc =
radix
>> path is updated to use the same shared tail-page helper, so the =
generic
>> and powerpc DAX paths follow the same reservation model.
>=20
> Thanks, I've updated mm-unstable to this version.

Thanks.

>=20
> Sashiko asked a thing:
> =
https://sashiko.dev/#/patchset/20260927025441.741633-1-songmuchun@bytedanc=
e.com

Sashiko said page->refcount can overflow by incrementing it over 2.14 =
billion
times when mapping more than **524 TB** of DEV-DAX memory on a single =
NUMA
node, where the pages share the same node, order, and zone.

I am not aware of any practical hardware configuration approaching this
topology today.

Handling that theoretical limit would add non-trivial lifetime or
architecture-specific teardown complexity. Without a concrete hardware
requirement, I prefer not to over-engineer the current series. We can =
revisit
it when such a system or use case becomes realistic.

Thanks.


