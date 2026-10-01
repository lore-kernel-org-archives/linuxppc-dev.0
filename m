Return-Path: <linuxppc-dev+bounces-28666-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4FACA5FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 16:08:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwcJx68vBz2xfq;
	Fri, 02 Oct 2026 02:08:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::a7"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790870897;
	cv=none; b=DvvclL34d3H/MVciSZ/2oV1QOfOmTsxMAzkwTNjoag/VoMsjsAieXj9jgrNH4WVTop5GPCLZltY1uTgMkr/3v6IQg4HPaTIkt/c6Wrz/uWisthZg3SaUXr7qLlT1uljLY3yBaP7oHX15atLUtJDCvjXUWaL62P5JBB7eao2bUV7CBRJOgSs73VKgTpewOmtp+NT0MaeT+SpFUHepNWRyGcOpHFHZ/5eKAnyaAbxFz+3xhYhH3NWzjqIC1Moxd6lbwouagkxAWc6m5XjBmZAVVSPE8oSwovOzSqgFOCiuf5IAVWbFNOIh/YvZnGOUavCBKu/gbe51tAvuQOZrHkI+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790870897; c=relaxed/relaxed;
	bh=x+rRTTSo39ujkgMqAmXbsmEGf9WZCcK9Kch9Skm9J2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0PWeUj28UrQG3QulfOovF7Shc7wlNfbMP2nl5atEIyoR2E6s/CXgZuPvWdh9fbvTEvK0XrW++itR3AQFid//n/lc8Bk5Bv2jHvJ3lFRIdDUz4pnIb1hGkhIdwRTGEnZWFGILa+R/zfAzZxXCuvYc1fMxzlw5MaN7WEqymh5PH2ieOYG1MlW9Rhor3aMneMXwJD5kxVpyAa+XF4R6lSlFaN39kY3ZRSKqDA9DyXNKVGfd6VnGEe1b3jV/+wdBUnfuAUKLupAQXg9B6WQuGP3kb0x7zraOjI3qGcSUO0bkFEI5DvWfiZ4ERzexrs51xnLZxM3NQ1CEztBu5ipImicpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rLnx4miu; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::a7; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rLnx4miu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::a7; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-167.mta0.migadu.com [IPv6:2001:41d0:1004:224b::a7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwcJr4Yt3z2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 02:08:08 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=XKakuNwu3Om7gwJbEDCid2bRDqw/CvPpxhwYERhBdAY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790870868; v=1; x=1791475668;
 b=rLnx4miuxqSZqAa89KPYNmCICPUM4ZHMu0+z6jrjyedz9XHedhQXDO67ofThf5Ik/L8VbTnh
 6+tNHwI5PwjsqjDkftNrXdQ5kLA86UXKysX1ByqRLMlsvLaGLnfyy4N1oZpb/OwTIUk919IWKDC
 IWf/DWjE1DQ3TMz4C74sW6DU=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 1d5925f2877bd100;
	Thu, 01 Oct 2026 16:07:47 +0000
X-Mizu-Trace-ID: 1d5925f2877bd100
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: rppt@kernel.org
Cc: songmuchun@bytedance.com,
	maddy@linux.ibm.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	qi.zheng@linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	muchun.song@linux.dev,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v3 6/6] mm/mm_init: add zone mismatch warning during page init
Date: Fri,  2 Oct 2026 00:07:37 +0800
Message-ID: <20261001160737.25348-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <ar5xbQsUpSQZg0wO@kernel.org>
References: <ar5xbQsUpSQZg0wO@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Oct 01, 2026 at 04:42:53PM +0200, Mike Rapoport wrote:
>Hi Muchun,
>
>On Tue, Sep 29, 2026 at 01:32:31PM +0800, Muchun Song wrote:
>> For vmemmap-optimized sections, tail struct pages may be backed by
>> shared vmemmap pages. Those shared pages must carry the same page zone
>> ID as the struct pages initialized for the section.
>> 
>> Warn in __init_single_page() if the shared tail page has a different
>> page_zone_id(), which would indicate inconsistent initialization.
>> 
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Acked-by: Qi Zheng <qi.zheng@linux.dev>
>> ---
>> v3:
>> - Collect Acked-by from Qi Zheng
>> 
>> v2:
>> - New patch.
>> ---
>>  mm/mm_init.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 1650d6bc1211..bd02e8d06965 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -609,6 +609,9 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
>>  	if (!is_highmem_idx(zone))
>>  		set_page_address(page, __va(pfn << PAGE_SHIFT));
>>  #endif
>> +	VM_WARN_ON_ONCE(vmemmap_optimizable_order(pfn_to_section_compound_order(pfn)) &&
>> +			page_zone_id(page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) !=
>> +			page_zone_id(page));
>
>Hmm, page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES is initialized a tad later
>than page so it'll have stale data in the page->flags, won't it?

IIUC, the shared tail struct pages already initialized by
vmemmap_shared_tail_page() during vmemmap population, no? It calls
set_page_node() and set_page_zone() there :)

Cheers, Lance

