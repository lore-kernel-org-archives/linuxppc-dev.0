Return-Path: <linuxppc-dev+bounces-27799-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5D7C982DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 03:44:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hp8HG23TGz2yDc;
	Mon, 21 Sep 2026 13:44:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.87
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789962266;
	cv=none; b=YDkwamMHvFO43pksduy9LMAMCEGsLdHHU5ATO6tQDQwNx8Nkar7qWe9ghAN+ZvNILl5+qpQuR92tH6Px9U3qr2jcFDtIF05HJ3M4FtX6sUD9hfnMAjUakm/fi/+M2KweSd95wi24mAaqgoDir19OrnCN1F9/ePyrpjDZaHbmUgbxauwxBit1jnoAU6G7XMtwIYAD5qDYwdn88xDXccdOWhJyxqFkAZxs92SS4xNZULIxNIId+LAz4NtkTsGgIRvBv5My0UvuvAKh4FvqPSVA4mvpi28cVWte4HLFo0Jr4/jea2ohokxf1Jr9k0W3VAzjwekkoQBxtJ5oCve09Kebjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789962266; c=relaxed/relaxed;
	bh=obiZyFjcOobmTwuln0nMYhDvmRZvXT8/bzvIQjQRQIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPdGjkcLRzPvifKTDWT3/AkuuLGYqLY1HQTnwtOTmo98phSe4EjYJcZoGCn/5SznrVS35L2elYRh61X5ECrdfKq5a08/lckbW778gV4AajXcGykaj964B+ZxvdKWskR8VYj+NC5hGxDbZYZOu14s0CS+0Qf2DhNiE4A66ai5MMuQUW+kiVj9mwpBjVmMcuIg2rSXupTve9SbXyaPyf0r/g+tJKabTxPRhJ2So+g6BelvcNc7X1VVSBSCLOiqxU2udZ5ID6OWakzvoChnBiRgoQGBDQxfNbpR4dUR9f+OUhXtKljt6KZ+us0s6zRzLjxOHQj7aG8WPS5eY5FPHBGJeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q6i3Cc4v; dkim-atps=neutral; spf=pass (client-ip=95.215.58.87; helo=mta1.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q6i3Cc4v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.87; helo=mta1.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-87.mta1.migadu.com [95.215.58.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hp8HB6HgQz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 13:44:21 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=OGERyTp5CrbGXz3u1lwBm+Mkoof0KEPSvGD6/69fiBc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789962241; v=1; x=1790567041;
 b=q6i3Cc4vPqW2HACNC1Kbcz5AWkNrBAYd+5bKQYabHMNoOlMMuY3LgSJDfb1uNhWzk0yXNWQ/
 H6nBlVUvtNQacO2ypx/6s3g+F0Qqoq+o8ycUPanwPWEII6LLiBx6wFzMsVCccjETiUbB0bUqndW
 gxfcR9gm2LW9kj92Cy41XQnA=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id f06bd7d5875bb714;
	Mon, 21 Sep 2026 03:44:01 +0000
X-Mizu-Trace-ID: f06bd7d5875bb714
X-Migadu-Flow: FLOW_OUT
Message-ID: <95d326cb-ebb4-492c-9062-5d373609e18b@linux.dev>
Date: Mon, 21 Sep 2026 11:43:51 +0800
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
Subject: Re: [PATCH 1/6] mm/sparse-vmemmap: drop VMEMMAP_POPULATE_DAX
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260913083734.86802-1-songmuchun@bytedance.com>
 <20260913083734.86802-2-songmuchun@bytedance.com>
 <186ee2ba-daf3-4120-a3e3-101cac1ff5a1@linux.dev>
 <4AA6C66B-0FD8-49F3-8447-959A3E438FC2@linux.dev>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <4AA6C66B-0FD8-49F3-8447-959A3E438FC2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/19/26 10:07 PM, Muchun Song wrote:
> 
> 
>> On Sep 19, 2026, at 22:01, Qi Zheng <qi.zheng@linux.dev> wrote:
>> On 9/13/26 4:37 PM, Muchun Song wrote:
>>> VMEMMAP_POPULATE_DAX currently distinguishes DAX vmemmap population in two
>>> places: it keeps allocations on the normal path and takes a reference when
>>> a backing page is supplied for reuse.
>>> After Device DAX switched to the common per-zone shared tail page, both
>>> conditions can be determined locally. DAX supplies ptpfn for every shared
>>> tail mapping and requests an allocation only for compound head mappings,
>>> whose PFNs are not optimizable. Therefore, vmemmap_optimizable_pfn() alone
>>> selects the correct allocation path.
>>> When ptpfn is supplied, the caller is reusing an existing backing page.
>>> Once the slab allocator is available, take a reference for each reused
>>
>> Does the availability of slab mean the buddy allocator is already being
>> used? Could there be a window where the buddy allocator is functional
>> but slab hasn't become available yet?
> 
> Yes, because the slab allocator is based on buddy allocator. But I want to know
> what's your concern here?

The goal here is to check if the buddy allocator is ready, but the code
actually checks for slab.

I'm concerned there could be a gap between these two:

buddy is ready <-- gap --> slab is ready

Thanks,
Qi



