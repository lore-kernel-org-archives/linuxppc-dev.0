Return-Path: <linuxppc-dev+bounces-26350-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96120C61DFD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 03:06:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYrN76044z2yCv;
	Tue, 01 Sep 2026 13:05:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::20"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788231959;
	cv=none; b=TI9AKy3EmbR4uiYysdmJxNsXJiG07WWzUsWBIp9E2hu6UeAjOpIQAqCFVZe06iT6f/Sd1GcGcYeVTv+D+vXNW7G3YsdgUgdRyTZzlEefnt4ARPKSgYwrZkCDbJnzXFlZwrBa2/qw4NzV332HvojMf/U2vO9m8HL5kcbmnXCXnti44Q1LKt9++KvPwF5qekBX/XKXcGuLBD1JH90DXsdVyU8vNW6VqLCKmlcLrcCnQBHzHVkF+PYN/WiK1+Bu+yDHrWkhICk6fh1+UTe+tOMA4vO0eum/VItvdLBb81PHCYLsrqpg0lqBbW1DTgUTiaY3bZ9iOT6JeiBfkxkovVgS+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788231959; c=relaxed/relaxed;
	bh=h5BxyLRLxa8TYSgP2v0wqtE7VNxwkDSM7heKgfXMMiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8VK5UH4JEu8Hqxti7yaN23lY0QjAUi8i7ZTHOcApe+rw5av3qrvpTDfHkkQcyMEdTByixACP9eUPMNbMUdu7TrnkBnMDGrFIDH3wEKqsBdec/v3ldxk3SNdofqql7k/QQBCLMkaAv77pd+HD7LgG3x9QwsQKlojWdZe73zo0AsDh4Vnj9rRlT/Af5EgT+3+E0stH4HSZD2+JkoCeos3T+SDyBrkuVRF/J6QXfjFhr6W4KShcHWOQ6HW1aZs8IPZLWa2H+xDtURjZ6Ql1Xa55k01XZw6tyF49sO4GSvkNJ/UjQ5YXfnU7jQF9GdcxNQRS2037ebOOpiwU9nbYwiuaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RzCg2EyL; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::20; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RzCg2EyL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::20; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-32.mta0.migadu.com [IPv6:2001:41d0:1004:224b::20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYrN44gFlz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 13:05:54 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=om/9bGBfkYvM+IJmkkqUPDFd/PD2WvlDipw0cZRTGNE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788231935; v=1; x=1788836735;
 b=RzCg2EyLX+DLkWdT5WwAUtyG2TSekpBJmYi40rJg2sjLfJcqww9e3QBg8c5Cw8UhjU6CLPgO
 lwUTqHb3tHJPHRAzJKi7/uMXWZvcESuAZ0Fj2Mzkzgvg7xOHH3kOgikMZ6PfyRMGj8hB+4dSqhH
 Y3yyds94CFHfvZGaiiPNDRsU=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 83324dd7b0a9859a;
	Tue, 01 Sep 2026 03:05:35 +0000
X-Mizu-Trace-ID: 83324dd7b0a9859a
X-Migadu-Flow: FLOW_OUT
Message-ID: <b59449c6-d2b5-4b0b-ada4-7630e060ee7a@linux.dev>
Date: Tue, 1 Sep 2026 11:05:24 +0800
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
Subject: Re: [PATCH 02/11] mm/sparse-vmemmap: factor out shared vmemmap tail
 page allocation
To: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
References: <20260831075342.57563-1-songmuchun@bytedance.com>
 <20260831075342.57563-3-songmuchun@bytedance.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260831075342.57563-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/31/26 3:53 PM, Muchun Song wrote:
> HugeTLB and sparse-vmemmap each have their own helper to allocate the
> shared vmemmap tail page used by vmemmap optimization.
> 
> Factor that logic into a common vmemmap_shared_tail_page() helper. It
> allocates the page through vmemmap_alloc_block(), and uses cmpxchg()
> to install the per-zone shared page.
> 
> Expose zone->vmemmap_tails under CONFIG_SPARSEMEM_VMEMMAP to match the
> shared helper's build condition. This avoids a
> !CONFIG_SPARSEMEM_VMEMMAP_OPTIMIZATION stub; when optimization is
> disabled, the array has no entries and the compiler folds away the unused
> paths, so no storage or runtime overhead is added.
> 
> This removes duplicate allocation logic while still handling both the
> early boot and runtime paths through the same helper.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   include/linux/mmzone.h |  2 +-
>   mm/hugetlb_vmemmap.c   | 28 +---------------
>   mm/sparse-vmemmap.c    | 74 +++++++++++++++++-------------------------
>   mm/sparse.h            |  1 +
>   4 files changed, 33 insertions(+), 72 deletions(-)
> 

Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks,
Qi



