Return-Path: <linuxppc-dev+bounces-26602-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA2AC624DB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 08:22:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcRCD0G6kz2ygW;
	Sat, 05 Sep 2026 18:22:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788596535;
	cv=none; b=nmgHhO5LYFCRHcxQduPyx7vgUQRk0089780IcKfwgyrfCZwcBmkRX9cKSbyX3p905yG8X0Jy1YMpbb/ajbKFAtsXE2peDislq0Sa3r5s88qWb4IwAU6aqnNI0+fBcFV6CgqqWXRciJyNtTxyxyo/k8V6U3Sj3BqpG1wzo6SrX6DY8Kb+cMDfm8XDuO2T6KfVHMNAQQjT4KBuF2L/W239zrtQXJtMCBPiup8ivd5z0Qas7fx+M9kBbZyvt5G9kuf6AqNJidwOX5u9J5qQV4q3OOPkz9DfJgSz3wEbqlyfVFGRInbQIYcxn+DZF9xG7ha7aU4yhqtSB7P6Nve6gQsSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788596535; c=relaxed/relaxed;
	bh=RP0mewtQAGjElsgzWQyDMeAFMgZ/vTm011baf6TDx3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2NCvMSze41Tp3qD3CBVd/sJPjBPJObCbS24s7cCAay1bhR+EX3kvJWSdTNx04uEILdeEOkNHdHrEefMI2FhdeM3mVis7iBG2Xbu0X/BDkc4CwAHb0xPkTJqMDX0QA78BOM45e04AANkM8MTKfgOqjF6JvIJcw9dtgn/QnMEL/zAIsLeYAKoFRntn6ZBKTdFhQr1c4tDcqSDwD8OB412Mg2XygbPEXxZsxVn42hUkAzxT7wc9ikQYf6kWN37+/bQ3d4yJiNpFOc+Pv2SbdYRjlKGsIwR+OBdtuH+kiIdZt9dMOyPsJ7+3tQNHKfZb9AG7M4osiMUqjZPxicA7IRj8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vKts9Mu3; dkim-atps=neutral; spf=pass (client-ip=95.215.58.217; helo=mta1.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vKts9Mu3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.217; helo=mta1.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 79 seconds by postgrey-1.37 at boromir; Sat, 05 Sep 2026 18:22:11 AEST
Received: from mta1.migadu.com (out-217.mta1.migadu.com [95.215.58.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcRC765JQz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 18:22:11 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=cWv2OsYaUjRAleYfGIeSk6xvjxd4wSnUJO1edGPXAD0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788596512; v=1; x=1789201312;
 b=vKts9Mu3+1WidBpOrwtsVqD107Ss/hConnByWK4Fw1LKOCd3uArjPFORL4xUXl1NB4zwsI4T
 mNEtTOY4roiFuuct8hj7XH0r8IUX7NUHD7Z71DIK4606MjnMRVDsMBW9QoGEcCunwsca+TdiUuh
 Z54NUKaMH9BYYe2QBYjxATlQ=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 1b4d3cf39591adcd;
	Sat, 05 Sep 2026 08:20:25 +0000
X-Mizu-Trace-ID: 1b4d3cf39591adcd
X-Migadu-Flow: FLOW_OUT
Message-ID: <1143901c-5036-4b79-8135-21ce57075136@linux.dev>
Date: Sat, 5 Sep 2026 16:20:16 +0800
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
Subject: Re: [PATCH 05/11] mm/sparse-vmemmap: set section order for device DAX
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
 <20260831075342.57563-6-songmuchun@bytedance.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260831075342.57563-6-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Muchun,

On 8/31/26 3:53 PM, Muchun Song wrote:
> Device DAX can use vmemmap optimization only when a full section is
> populated with a compound-page geometry. Record that geometry in the
> section order before populating the section, so later vmemmap accounting
> and population decisions can use the section state directly.
> 
> Clear the section order when the section becomes empty again. Also reject
> partial additions to a section that already has optimized vmemmap mappings,
> because a section cannot safely mix optimized and ordinary vmemmap layouts.

Perhaps we should explain why they cannot be safely mixed.

> 
> Partial additions continue to use ordinary vmemmap population, so they do
> not save vmemmap memory. Such additions are uncommon, and the lost saving
> is negligible.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   mm/mm_init.c        | 13 ++++---------
>   mm/sparse-vmemmap.c | 16 ++++++++++++----
>   2 files changed, 16 insertions(+), 13 deletions(-)
> 

Also, the issue sashiko reported looks like it was pre-existing, not
introduced by this patch. So:

Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks,
Qi


