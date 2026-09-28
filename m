Return-Path: <linuxppc-dev+bounces-28355-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50803C9830E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 01:50:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htPQf3LKdz2y2f;
	Mon, 28 Sep 2026 11:50:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::12"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790560234;
	cv=none; b=eClkRw/H8NdLA/TMXfijd5wjRRY3kGVyiS23e+tv85XvR9yY7KKIDThxEDLCkOIfVnOb2kifinccLsrE4ML3Hq9EXrjGmfjB0GPpHqnwJo5cFZII8PQ9gScwKcrEMCJPZvG6b1R2s5cMIiBhwX3FDyZ8AT5I3QojtdTGuVlQ67/d7gQ22YKXIBGL7qRdmKLBEQ3c2utl+z/zetXCn9ywlmjE3Ji3xSwzUEhSb5eKB4cXSgFGmSJYvJlhvbI05tAdzXIntbhiY1WiQW/2J9Ot+q5HJlnBTFnUYDg9ou1llSOzbs3GgqCB4qwvk9EIbT/scovzZ+HnsnG6sGrvb34sRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790560234; c=relaxed/relaxed;
	bh=h3nRgSDQzHRceNINJ0CmgoIAJgoR/3hhS49F+G/qdCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNNrg1FQcruK5bOlSdpSwKn86IHHHwsbUtbBj2WG6Mw0yJlL0ZK7+YSlU2L/K+ZESqQhYdEzzBEBFWueaIBXcK8GLEfQyqfx1yXv6ESNtJuW7WUGAAw0HSF7CgX8w1cWsc8gdW8nZoj52ieOsjLFqbQ7KC9mkpRUpHhqsaGv1qCKfECLZkekmXMvqfzUQ3d3ikeo78Eh8SZJKmdFza3KUbFNOYnrCSGci6RtzQGBCkGDJU0Cdo5ACn1m+DrP1zev/VYauEOKw6iqcTo7+s2sjx1FFDooflUWnpIqxUBBgTtTbjTmD/16lO54BXI3wf9FQDr7bMySALrNZY8ARQbjOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i642vPZ6; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::12; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i642vPZ6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::12; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-18.mta0.migadu.com [IPv6:2001:41d0:1004:224b::12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htPQZ3SnYz2y24
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 11:50:28 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=RAi6LaQaIERnguNa75CIILKwcfJnHB40JrzKtoc+ARQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790560205; v=1; x=1791165005;
 b=i642vPZ6AAFEMsfq6Yf1PfwOeeahFco14EV8Avqv9HTqhooaA2j0gfOA2QJG2ehTPfshwSez
 DxNTAJZgTXcZiON6+hVgi9VPWLxcNsjHcCenEcJaFQSe9zmWQ2PzWXhqP/mTJqyDyTfZJmFWO7b
 /zI8ptKsDVXsSm7as7JtU6EA=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id b6a582d4e49657da;
	Mon, 28 Sep 2026 01:50:02 +0000
X-Mizu-Trace-ID: b6a582d4e49657da
X-Migadu-Flow: FLOW_OUT
Message-ID: <99cdc0cd-3af1-4d61-af28-47fad8657c62@linux.dev>
Date: Mon, 28 Sep 2026 09:49:56 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] mm/sparse-vmemmap: support device DAX in common
 vmemmap path
To: Muchun Song <songmuchun@bytedance.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev
References: <20260924075259.2013039-1-songmuchun@bytedance.com>
 <20260924075259.2013039-3-songmuchun@bytedance.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260924075259.2013039-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/24/26 3:52 PM, Muchun Song wrote:
> The common vmemmap population path cannot yet handle optimized Device DAX
> mappings on its own. It uses pfn_to_zone() to find the shared tail page,
> but Device DAX populates its vmemmap at runtime before the ZONE_DEVICE span
> is initialized.
> 
> Teach the common path to use device_zone() for runtime optimized vmemmap
> population while retaining pfn_to_zone() for early boot. This allows the
> same path to support both early boot mappings and Device DAX.
> 
> The backing PFN supplied by the Device DAX-specific population path is no
> longer used, allowing the redundant lookup and population code to be
> removed later.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> v2:
> - Expand comments around slab initialization to explain zone lookup and
>    page refcounting (suggested by Qi Zheng)
> ---
>   mm/sparse-vmemmap.c | 56 +++++++++++++++++++++++++--------------------
>   1 file changed, 31 insertions(+), 25 deletions(-)

Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks,
Qi




