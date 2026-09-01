Return-Path: <linuxppc-dev+bounces-26351-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD689C624A4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 03:18:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYrfr0Jjqz2yD3;
	Tue, 01 Sep 2026 13:18:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::15"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788232723;
	cv=none; b=Kr4P8qXNp2wyfC5xmXhPZkoX2BCc7JOWMFrvs6elyqHJ8Mdc14LYgAQw/Na9oJ+08RLuRE2vxoeyQ8NR3cTQxj1BpY8vXJB2vxaLz95xJtVoE2Mdw8+W6CvhjVZKyycv2YGU8bW7AEebNfKkl8KDsHDhsch3e2all+KBt6b6AZHZfDHgEwa8VXWCfSJMCrmVnoqhYoRPRkBXFqPvxc0NDpNt1drOqqlwIM0C8Wfpc7r9wBZxCzTPcSPwIZj5Csk0t1HxSaqS06Vy7B7TiyC88LbMQt8MIp94ONn6562xv4hDcBZHzvXztkA3j74gGOBe5jDEfaCDhR8/X7v+1jFO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788232723; c=relaxed/relaxed;
	bh=+uXxSLnSYb27jssXKT5e6hDQG31Ju9yhWfa0Ltirbfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ob6HR3QrcryqOTMtKqguso/D3UkUfgZsMToeTceng1/SreRXAtFI4AK6OkJlcYOo4aKIxtewLPUl6MSpN3erFdjdjNOT1gV4+peciM6S0udLiqZE4HKS9jepcCDOmytLCoTUicJcrkr+yLDD6ufwRI/PLrgTkgOPvnM6oJCG0uf+eV5xHaRcwpUkHR4f9GV27Qdo3HXLXenfJtN1oc4BjSGExwcmLno9uN2qI7AhuKk4kyKqosfXHpUCyP9TWQLhaGxPHzPbxdubJQc+GM2hcCtseUhYqWowplJ5LTpnk6fysF/Hi+OlgxH//gQdnFGZ3rQtj8eEio/14PNqFLH4Pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iQbqfgik; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::15; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iQbqfgik;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::15; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-21.mta0.migadu.com [IPv6:2001:41d0:1004:224b::15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYrfm3DKJz2yCv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 13:18:38 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=+yvmAaiXJSQhUiY43hR2AcbPXHGoUIEk5aWBZqakNg0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788232699; v=1; x=1788837499;
 b=iQbqfgikHpVpyMUUAMrHyUTlOaqZLRJR77DceWjUfb8vdHqANraDf/0tu3DdPGi8ibjxO5PH
 ZBY8IevQGiEhRdzi43/7Dl7dQ7HElvS6FHE63AoRFdOmr4mdBdaDh5Bq5pXKhI0PkBDG3xUQcC8
 DDGCKvrhqABzi1za8Zqf6tQE=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 5a2cff3d3a7044ca;
	Tue, 01 Sep 2026 03:18:19 +0000
X-Mizu-Trace-ID: 5a2cff3d3a7044ca
X-Migadu-Flow: FLOW_OUT
Message-ID: <56119ff9-26f2-450c-bff9-8a4169027ba9@linux.dev>
Date: Tue, 1 Sep 2026 11:18:09 +0800
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
Subject: Re: [PATCH 03/11] mm/sparse-vmemmap: open-code init_compound_tail()
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
 <20260831075342.57563-4-songmuchun@bytedance.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260831075342.57563-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/31/26 3:53 PM, Muchun Song wrote:
> init_compound_tail() is only used by vmemmap_shared_tail_page(), where
> the shared tail page setup intentionally passes NULL as the compound head.
> 
> Keeping this helper in mm/internal.h exposes that special case to the rest
> of the MM code and can make the NULL head argument look generally valid.
> Open-code the initialization at the only call site so the special-case use
> stays local to sparse vmemmap optimization.
> 
> No functional change intended.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   mm/internal.h       | 9 ---------
>   mm/sparse-vmemmap.c | 5 ++++-
>   2 files changed, 4 insertions(+), 10 deletions(-)
> 

Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks,
Qi



