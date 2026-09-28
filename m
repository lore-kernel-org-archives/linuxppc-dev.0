Return-Path: <linuxppc-dev+bounces-28359-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4FFC9832F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 04:26:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htSv42HwZz2yqx;
	Mon, 28 Sep 2026 14:26:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::a5"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790569616;
	cv=none; b=PyjoSGNZldKv5VDizIEifkJJE60c+UJSCpiqjyvrIZDjVpGPSlUhG+tKsSpTba/o0PIY1oo5QF908QgNuqx/Iq041BRB1D0KZhXtApWYgtGKf6CXIUaQZtivf+2Wsvl+iPjSYNCsXlQ6MwjSQKSwZox4ADclFpxTkAaOsMBrqm7wzAvQAtaywU6CmUVqRI2W9C8ieK0o/CxSp6QfJcVljNM4J/XvO3vyjlU838FDPW45TqgfQZxgWs9r7ClOQnDIZb6RSS/T3r1GpaFipjseC3FGkyIgeKfhj+jMc/2wFt0aKK9fJmrYYnwvRUkklReyB9lqkIUB3mb0HdgU7OdWlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790569616; c=relaxed/relaxed;
	bh=lvrrRB8+u1GpJmkKNNkjZdTcO/STjIHCexl1gUK1au0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kUv3hDGwajYzeYC121cT3Xk2cx97f5o24ASuZBqA7hlNBq/OaNLfR1t/xw6X8L0deuqHKXvyl3yaJxaIXE5DPLZLXlfAQuA5Px421VwGJ+gOOX7Oc6KYRgCn72YmCh9qZ7RIEQ4IAHj+Bwc7P51LlWW80yPQfEFjs8EkCp77QJOkTOGcozbe2iaV6jm7wX6lJi35ELRGiCgR79iefjgC1GL4UcsSL82J6ozc0NT2i1PubceskWO2823XznOJBFjkZ35jBMY15Vm+zVOVT73qHIm6cu2qV7plj5UlmeNxe9Owpiok7zW13MvqKKts3pnXc5VMb9yl5Q+r3yWifVKOLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=B99SxaK2; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::a5; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=B99SxaK2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::a5; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-165.mta0.migadu.com [IPv6:2001:41d0:1004:224b::a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htSv11s29z2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 14:26:51 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=Glpk8JbMYBC+fNyg6t+G4JCTtagtnxJN0ZLKBOnTQTs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790569588; v=1; x=1791174388;
 b=B99SxaK2rbJ0LDYrSl88XUMRGq97iyFTgAv/t83ER66td1R3ZF4YE1ihwFp1yP4H14jKvL4V
 DF52CBbo59AAudiYR8oksVptVgQfRcO+QyhIz3lVLdI+kHwqBrDl9LlHuaZAog7jOuF5bt/wqhV
 UKHduW3nH1V/c7ZrYM8etP3c=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta10.migadu.com with ESMTPS id 061b4c85c7534b56;
	Mon, 28 Sep 2026 04:26:18 +0000
X-Mizu-Trace-ID: 061b4c85c7534b56
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=utf-8
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
In-Reply-To: <20260927125452.0c1ec382905482841a4faef7@linux-foundation.org>
Date: Mon, 28 Sep 2026 12:25:58 +0800
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
Message-Id: <0E16642B-8180-4047-B846-40E3CC52E7D8@linux.dev>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
 <20260926225105.a56f29d76b2f496c8dc2dac0@linux-foundation.org>
 <FB00943F-8DB1-4BEE-BF37-701785DE2DDE@linux.dev>
 <20260927125452.0c1ec382905482841a4faef7@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)



> On Sep 28, 2026, at 03:54, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Sun, 27 Sep 2026 18:51:15 +0800 Muchun Song <muchun.song@linux.dev> =
wrote:
>=20
>>=20
>>=20
>>> On Sep 27, 2026, at 13:51, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>>>=20
>>> On Sun, 27 Sep 2026 10:54:29 +0800 Muchun Song =
<songmuchun@bytedance.com> wrote:
>>>=20
>>>> After the HugeTLB conversion, optimized vmemmap state is described =
by
>>>> the memory section and the sparse-vmemmap population path can =
allocate or
>>>> reuse shared tail vmemmap pages based on that metadata. Device DAX =
still
>>>> uses the older DAX-specific population model, including a separate =
tail
>>>> vmemmap page reservation and architecture-specific logic to locate =
or
>>>> populate reusable tail pages.
>>>>=20
>>>> This series makes device DAX use the same section-based model. =
Device DAX
>>>> records the compound page order from pgmap->vmemmap_shift in =
section
>>>> metadata before vmemmap population, uses the common per-zone shared =
tail
>>>> vmemmap page, and drops the extra reserved tail page. The powerpc =
radix
>>>> path is updated to use the same shared tail-page helper, so the =
generic
>>>> and powerpc DAX paths follow the same reservation model.
>>>=20
>>> Thanks, I've updated mm-unstable to this version.
>>=20
>> Thanks.
>>=20
>>>=20
>>> Sashiko asked a thing:
>>> =
https://sashiko.dev/#/patchset/20260927025441.741633-1-songmuchun@bytedanc=
e.com
>>=20
>> Sashiko said page->refcount can overflow by incrementing it over 2.14 =
billion
>> times when mapping more than **524 TB** of DEV-DAX memory on a single =
NUMA
>> node, where the pages share the same node, order, and zone.
>>=20
>> I am not aware of any practical hardware configuration approaching =
this
>> topology today.
>>=20
>> Handling that theoretical limit would add non-trivial lifetime or
>> architecture-specific teardown complexity. Without a concrete =
hardware
>> requirement, I prefer not to over-engineer the current series. We can =
revisit
>> it when such a system or use case becomes realistic.
>=20
> OK.  Presumably it would be cheap to add a check for this craziness =
and
> return ENOSOMETHING?


Sounds right =E2=80=94 I'll send a follow-up fixup patch shortly.

Muchun,
Thanks.


