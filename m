Return-Path: <linuxppc-dev+bounces-19724-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD821F531D0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2026 03:04:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvpyq3gT4z2yrD;
	Tue, 14 Apr 2026 13:04:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.178
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776135859;
	cv=none; b=exi2TmWokA82IUUc1welDgnGFVPQxt5x8fWdXueN2OHpATXWJZgL652UZJUXiuZB7Dev/yfdBye91zOuwlwEcJR3NbW/5Npy99KKrGBMA2oSag8RrOBjZiF28YamHkt7DK+JdBAW+G27wrVPs76FOKANt8QCU6cdvbu/78Hu4zXbEaD3VcA8oW5eDe/gMhGw0JXqxZTbUvPSyowLY+BVYdElV2n7ZJ83ecLrpsP5LmWJPCzUsFsqVYTMB0UvW1j3NkZZE0MV1SMpT0StIN9vz4edy/NGmGyvTbwvTi7/w9QZ54DgJnnrmyhBvLj567BxjRgb5mfpnoJelfFaRrzY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776135859; c=relaxed/relaxed;
	bh=Ciso2AWjvBYztbs3BLR9p/CMgpuF4vlx9bslXu0LY7Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fbUVilEOVWIu9B9InVxkK0q4jgc5WLO3SYGZm1OXS2WRzBt6ttbyJiT+rwJvo3eGge2+tuqrMB5J32I8QB2nRzZkHMoyQKc2ai6aNH5mMfsDBCHk2/aveuATPD+oEPhi66+oagYmoT0GeXDDjlxF6xoKjjV0zVrzwWVfOopaZEise3RkjEcB1wechk38NjEFBxGmzGYk1cRcqpvxQoAVcDGnajM2gfDvmMzz+LeNQcziuy8c7UfFlBDT264wcbVJBp9B4HcHZm0MMON3Md0y/JfHUymEJccHTs8hzoonCv8FThW0YIwXFxCI1JZoqGKZdZKheah4yw/r8rr2vouRIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Tobz5XxS; dkim-atps=neutral; spf=pass (client-ip=95.215.58.178; helo=out-178.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Tobz5XxS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.178; helo=out-178.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvpyp45pCz2ypY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 13:04:18 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776135838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ciso2AWjvBYztbs3BLR9p/CMgpuF4vlx9bslXu0LY7Y=;
	b=Tobz5XxSRsi9ARWqmEcgmiOa3dSNzREEH+4KLg2B8Lwg/NzF7mQwVhrFOQd0ZgZs/xNmvg
	jWz/oQHSJ6TprcZb/Fqxg8G7aVFlThSaj1LmzdAzo/yVyKSqpbpVu8MvjIwtO/5s4LdP+U
	oyegkg75cyXyxBg+99X7Q1AdM6w8rNU=
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
Subject: Re: [PATCH 01/49] mm/sparse: fix vmemmap accounting imbalance on
 memory hotplug error
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <2f092c37-95b3-4206-9866-f844273ed1bd@kernel.org>
Date: Tue, 14 Apr 2026 11:03:08 +0800
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
Message-Id: <B4F03CE5-83B7-40C6-A385-BF3BAD9AE858@linux.dev>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-2-songmuchun@bytedance.com>
 <2f092c37-95b3-4206-9866-f844273ed1bd@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 14, 2026, at 02:35, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 4/5/26 14:51, Muchun Song wrote:
>> In section_activate(), if populate_section_memmap() fails, the error
>> handling path calls section_deactivate() to roll back the state. This
>> approach introduces an accounting imbalance.
>>=20
>> Since the commit c3576889d87b ("mm: fix accounting of memmap pages"),
>> memmap pages are accounted for only after populate_section_memmap()
>> succeeds. However, section_deactivate() unconditionally decrements =
the
>> vmemmap account. Consequently, a failure in populate_section_memmap()
>> leads to a negative offset (underflow) in the system's vmemmap =
tracking.
>>=20
>> We can fix this by ensuring that the vmemmap accounting is =
incremented
>> immediately before checking for the success of =
populate_section_memmap().
>> If populate_section_memmap() fails, the subsequent call to
>> section_deactivate() will decrement the accounting, perfectly =
offsetting
>> the increment and maintaining balance.
>>=20
>> Fixes: c3576889d87b ("mm: fix accounting of memmap pages")
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>=20
> Can you send the revised fix separately, please?

No problem.

Muchun,
Thanks.

>=20
> AI review flagged that recently on one of my series that touched the
> code, thanks for taking it off my todo list :)
>=20
> --=20
> Cheers,
>=20
> David



