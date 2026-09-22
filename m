Return-Path: <linuxppc-dev+bounces-27896-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2871CC982F1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 07:55:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpsny1nSQz2ygK;
	Tue, 22 Sep 2026 17:55:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::33"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790063702;
	cv=none; b=LCD5PP0VQcQ8XsAit1Z/ThHZpYFG4So0k77eJJ2y1anVWn39gqJ0Z+BQRbTkapXIFNXcXKguDy+h+Hyzf6HG+MVJlNcfV2WuSANSkv6EJx/96WhXmoCGiDPjxF2NJadVQCjyZQ+I/ZjwUnEHnffta3ML2GvrBiGRuuC7cVtY57pdE9qMpep/zK5y2MtSuOs9/AzGmACkFFZgaZavWtFND8MZ+y1chMLn0meZ2aibGgIi2nKHTQRG5yF1OngimN/3ol9mD3WG1btztYAtKhO+d8b+9b9nL+DR5efjPpNwkQKzmTbIwtlyviMR1soh23/M0KtzkW0+Otu/OChk3JTbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790063702; c=relaxed/relaxed;
	bh=TP8hP/DR2YONPSF2v1CC1+QNgDBOk54Or3SAgzas86o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJtRX1ANRQaBUHRS89z+xPDagOeFrfIpdWW4lQ0USclVCoiaF2VTYp+eS35EqVvG9K2ftgJ6tjz0ZVKbiA2kl7xA3yrP67WHvamog3oYCy5fe7oCHw3A/VYJXzUOYiHumsd8ZsvbqPdXaNmR+W0M2haDY+hHl8DOYCTberOgo0uv1wuYFssxLhfjluCfzDx2jnFpzAuuiNoRTfBNFIImOZ0m2JFDNGdbSj2T9vEXy0AvegGKxRDWzq+xQequjeWlu1n9Ti+SS3OiXDcRx8U8A6rtDIedYLUtz/j6Ox60Xc1Lu3V/Z5tjWQdQrgsJAfDNHCHn6K4wn9dXdHAVtcFUEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tGB5EvHd; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::33; helo=mta1.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tGB5EvHd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::33; helo=mta1.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-51.mta1.migadu.com [IPv6:2001:41d0:203:375::33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpsns5bZ7z2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 17:54:55 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=0TJo2ZSluV7GOtUR+gK4tKoCDniJGIYoMCtvZ+NvpCE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790063672; v=1; x=1790668472;
 b=tGB5EvHd07V3TRZMw3nlxhs4aBNVlsx9LjWONbG45hiYxCmkXpi1+InKeO+o5RER8f1Q0RNp
 YIO7kc+oY9gkGrf5WxWAB1KwqWnpMeNUX9h0Y7ftfm9Chl7NGjuKMGxLmLNGKWn8EuT3o/ZXnO4
 NxjusKf1p68ZfxMuFgFYMbAs=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 994fcd1d9a4dc67b;
	Tue, 22 Sep 2026 07:54:32 +0000
X-Mizu-Trace-ID: 994fcd1d9a4dc67b
X-Migadu-Flow: FLOW_OUT
Message-ID: <47038cfd-59a7-4dab-891c-0469cbeb37c8@linux.dev>
Date: Tue, 22 Sep 2026 15:54:26 +0800
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
 <95d326cb-ebb4-492c-9062-5d373609e18b@linux.dev>
 <6479325A-E6FA-45BD-9392-262E71467EDB@linux.dev>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <6479325A-E6FA-45BD-9392-262E71467EDB@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/26 11:49 AM, Muchun Song wrote:
> 
> 
>> On Sep 21, 2026, at 11:43, Qi Zheng <qi.zheng@linux.dev> wrote:
>> On 9/19/26 10:07 PM, Muchun Song wrote:
>>>> On Sep 19, 2026, at 22:01, Qi Zheng <qi.zheng@linux.dev> wrote:
>>>> On 9/13/26 4:37 PM, Muchun Song wrote:
>>>>> VMEMMAP_POPULATE_DAX currently distinguishes DAX vmemmap population in two
>>>>> places: it keeps allocations on the normal path and takes a reference when
>>>>> a backing page is supplied for reuse.
>>>>> After Device DAX switched to the common per-zone shared tail page, both
>>>>> conditions can be determined locally. DAX supplies ptpfn for every shared
>>>>> tail mapping and requests an allocation only for compound head mappings,
>>>>> whose PFNs are not optimizable. Therefore, vmemmap_optimizable_pfn() alone
>>>>> selects the correct allocation path.
>>>>> When ptpfn is supplied, the caller is reusing an existing backing page.
>>>>> Once the slab allocator is available, take a reference for each reused
>>>>
>>>> Does the availability of slab mean the buddy allocator is already being
>>>> used? Could there be a window where the buddy allocator is functional
>>>> but slab hasn't become available yet?
>>> Yes, because the slab allocator is based on buddy allocator. But I want to know
>>> what's your concern here?
>>
>> The goal here is to check if the buddy allocator is ready, but the code
>> actually checks for slab.
>>
>> I'm concerned there could be a gap between these two:
>>
>> buddy is ready <-- gap --> slab is ready
> 
> There is no vmemmap population during the gap. We don't need to concern the gap.

Okay, perhaps we could add more explanation in the commit message.

With this, LGTM, so:

Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks,
Qi

> 
> Thanks.
> 
>>
>> Thanks,
>> Qi
>>
>>
> 


