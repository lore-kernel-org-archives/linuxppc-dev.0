Return-Path: <linuxppc-dev+bounces-28356-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C378EC9832F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 02:00:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htPdh1rBDz2yFC;
	Mon, 28 Sep 2026 12:00:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::de"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790560808;
	cv=none; b=CAQYcKep+gTvnO9enCLhX+NAFIpwLLoL+Io3ydf0T31BUvsFomJB8abndS410qYzIDXXjZ0QgZNLdan4Zs6St+sjNgpfSe0ZatMt5DNfwgcWC4+qaZ8ow/LnTNGOxIzM9JBaMYnORqY7Rzrkhj10OjazWVhVchKbEZVh2nw2rIZ18cuRH0FJysi24f29ZdoYGRnGE8zXLMxCxQNFxdKnY+iLViqROBUbLxUBoDJWC1LUTuxphpGCqBPrkFX/VP+iFvtVjiJ2z+n5tIEkWaFmSvPdRd8n+8Q3f2X9eVCY7pUQzpveqUh6YdCB3fYLaN52xbj18sBHCAtgRv8oTRsoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790560808; c=relaxed/relaxed;
	bh=wif+2OotdgNoSE2PDumw0Ytb2mptobrggVKd9yP4JUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ggf+qXE+aENAny1JrwwsNUXytB6DmGdq59HPzvGjp/1JynKWi3hh18WKFlWfVqo18vhjTaEk2O/Zt5uHdT1i7VlUeFps3ajHTWK7gLtyBxdktnWFLcFJjNQru5NSULceOfKKL1agDpsqjFnVGIkHI2gfOGFk0597bioCEvYNjgmUwieYSdyGlMD7is8gvYv8oWboqQitDSJUVJbkI9Xtwq3bkp5vQpvjjmslDH9jjavQpxxcPkM7wDk8vTPvNDAm7+LBKfrJN8qqHfSYJRv/KXOgGOyC2EjMT2vZ5fAcozRPT2vrTrqG9BzTzQvk+Ge7leV75rvuEi40pNNspwXodA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uElmx2Qu; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::de; helo=mta1.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uElmx2Qu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::de; helo=mta1.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-222.mta1.migadu.com [IPv6:2001:41d0:203:375::de])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htPdd5FRwz2yr0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 12:00:05 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=BcqFNljILjUCpRPkdS11OgSUczWkfuZ6jLqgRCapH/U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790560786; v=1; x=1791165586;
 b=uElmx2QurfqyOBKvVv01kL0GN9zGPkXnf6SJYkbAl1EmIrE5DScIEK6w8GFWLZB8CFXbXkrY
 sDWlS6JocYM9T976nT3Mc9pvDCu7aM+4NgwIvB+nTy0ugAiogEk96kDKqow7fM6hNj++5I0W2HV
 LqoTNJX7I/WGo9C6SQ93x8aw=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 8140d4f261078bf9;
	Mon, 28 Sep 2026 01:59:46 +0000
X-Mizu-Trace-ID: 8140d4f261078bf9
X-Migadu-Flow: FLOW_OUT
Message-ID: <5b775a0f-322c-45f2-939c-ad508490b4ff@linux.dev>
Date: Mon, 28 Sep 2026 09:59:39 +0800
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
Subject: Re: [PATCH v2 6/6] mm/mm_init: add zone mismatch warning during page
 init
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
 <20260924075259.2013039-7-songmuchun@bytedance.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260924075259.2013039-7-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/24/26 3:52 PM, Muchun Song wrote:
> For vmemmap-optimized sections, tail struct pages may be backed by
> shared vmemmap pages. Those shared pages must carry the same page zone
> ID as the struct pages initialized for the section.
> 
> Warn in __init_single_page() if the shared tail page has a different
> page_zone_id(), which would indicate inconsistent initialization.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> v2:
> - New patch.
> ---
>   mm/mm_init.c | 3 +++
>   1 file changed, 3 insertions(+)

Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks,
Qi

> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 1650d6bc1211..bd02e8d06965 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -609,6 +609,9 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
>   	if (!is_highmem_idx(zone))
>   		set_page_address(page, __va(pfn << PAGE_SHIFT));
>   #endif
> +	VM_WARN_ON_ONCE(vmemmap_optimizable_order(pfn_to_section_compound_order(pfn)) &&
> +			page_zone_id(page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) !=
> +			page_zone_id(page));
>   }
>   
>   #ifdef CONFIG_NUMA


