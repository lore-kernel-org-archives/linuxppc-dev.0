Return-Path: <linuxppc-dev+bounces-27801-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52777C982DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 03:50:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hp8Pw3Qfvz2yDc;
	Mon, 21 Sep 2026 13:50:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::6b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789962612;
	cv=none; b=FMj7KFxrTiIBHn7Rol72WCd6cgktJ30MVrVxQ3DkOJC+ZNSjHrcviSanXYmoR2+CFthmJtd17zO5flbkaub1Q6uXhEDnuyOv6eQHIfsF/0UAiB2GsUGQR6yx9qTGD46EGU6pjo1IqGFd2zPIdK0JHB1iTbO+XnPbi1ZnJHXxRXvy6frhgNibiJ/tu7eBN0Mjqf7PT0aplBJHmpggwOla96LEE97wcA31LlToD9P17F8pOspyqVPXBpvUrYod3/B1xUgyaVnyvfOTbn38jy1xlPSyXERLpyYCVil6Ev/+5mK9w84OcYTFGyfPivYeTpqmrAqo5roQTqdvmgEXBfFQkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789962612; c=relaxed/relaxed;
	bh=28SAODsjBVAdEFNL/DREIySi6dVovlUoxUjNe7E0v7k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gj+sx/A5bbB5WiM9QUwbIOJXwseYFzObD6aGr4gILYdHmXZyr3fi05y+ZXs2gaFjkTLz+EWJw8mbvMsS2hS2wX/Q4wFVb/sH16tuUFSkrsVxyZF6OiNcv8vsDE7PMdRhTtclBMKA9LvrchdF3NNHAGNCtor8gBCmOVWBS+fiVi0C21IBQIrSZMbnDzXSPFhifutoAqbW24bAWuD2zPc/zGfP5uK3j0nhMSucgCNvPAQR8hr6QrA1lR/pFOItrMkGBnTLB0fl3D2gGDquFR+xaN0ajLHJLQtTQ2pwhK81nDN76HNeCq0WLlcGOsR/lfgNmlXVK9swuuEKinmjeGFlHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Vq0c48j3; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::6b; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Vq0c48j3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::6b; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-107.mta0.migadu.com [IPv6:2001:41d0:1004:224b::6b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hp8Pv3C3mz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 13:50:09 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=28SAODsjBVAdEFNL/DREIySi6dVovlUoxUjNe7E0v7k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789962589; v=1; x=1790567389;
 b=Vq0c48j3x6l440klKBhYEx5MB9eGlIvRRV6hjQczLSoxcZrziHNrY+dQdvlWuwQSzTwh5RLS
 h5dEbTrK5ltcUXZN3iyJBuQiIzfAjwu98lTfvoo93Z+kApT3GklVFSBs5xBj59JV16ciP1Z8qmC
 1FhbydavMSUvVIzLCSYlwnV8=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta10.migadu.com with ESMTPS id e91057e5e69ad459;
	Mon, 21 Sep 2026 03:49:39 +0000
X-Mizu-Trace-ID: e91057e5e69ad459
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
Subject: Re: [PATCH 1/6] mm/sparse-vmemmap: drop VMEMMAP_POPULATE_DAX
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <95d326cb-ebb4-492c-9062-5d373609e18b@linux.dev>
Date: Mon, 21 Sep 2026 11:49:23 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6479325A-E6FA-45BD-9392-262E71467EDB@linux.dev>
References: <20260913083734.86802-1-songmuchun@bytedance.com>
 <20260913083734.86802-2-songmuchun@bytedance.com>
 <186ee2ba-daf3-4120-a3e3-101cac1ff5a1@linux.dev>
 <4AA6C66B-0FD8-49F3-8447-959A3E438FC2@linux.dev>
 <95d326cb-ebb4-492c-9062-5d373609e18b@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Sep 21, 2026, at 11:43, Qi Zheng <qi.zheng@linux.dev> wrote:
> On 9/19/26 10:07 PM, Muchun Song wrote:
>>> On Sep 19, 2026, at 22:01, Qi Zheng <qi.zheng@linux.dev> wrote:
>>> On 9/13/26 4:37 PM, Muchun Song wrote:
>>>> VMEMMAP_POPULATE_DAX currently distinguishes DAX vmemmap population =
in two
>>>> places: it keeps allocations on the normal path and takes a =
reference when
>>>> a backing page is supplied for reuse.
>>>> After Device DAX switched to the common per-zone shared tail page, =
both
>>>> conditions can be determined locally. DAX supplies ptpfn for every =
shared
>>>> tail mapping and requests an allocation only for compound head =
mappings,
>>>> whose PFNs are not optimizable. Therefore, =
vmemmap_optimizable_pfn() alone
>>>> selects the correct allocation path.
>>>> When ptpfn is supplied, the caller is reusing an existing backing =
page.
>>>> Once the slab allocator is available, take a reference for each =
reused
>>>=20
>>> Does the availability of slab mean the buddy allocator is already =
being
>>> used? Could there be a window where the buddy allocator is =
functional
>>> but slab hasn't become available yet?
>> Yes, because the slab allocator is based on buddy allocator. But I =
want to know
>> what's your concern here?
>=20
> The goal here is to check if the buddy allocator is ready, but the =
code
> actually checks for slab.
>=20
> I'm concerned there could be a gap between these two:
>=20
> buddy is ready <-- gap --> slab is ready

There is no vmemmap population during the gap. We don't need to concern =
the gap.

Thanks.

>=20
> Thanks,
> Qi
>=20
>=20


