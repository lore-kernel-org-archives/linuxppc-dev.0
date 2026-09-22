Return-Path: <linuxppc-dev+bounces-27901-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93CBC982FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 08:14:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hptDs1W1gz2yjw;
	Tue, 22 Sep 2026 18:14:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::61"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790064893;
	cv=none; b=dAuwFo5KZHuSqtwy/DgGd+XZHenfB54r3oGNYMwXcS7TGhR+7+5ZoYKTqRpErJdh3h1UgAQrGNoc7nh7lYoe2eASISuQq01ARB+sUoj3Zl8LKSjN6CyQpsg6CN9dfogNR8WvfD6/LhuM4wvkkY74bZagRUcqPdjxOFo2Vl68ny1FvRAag0xHrC1oxdJdesPudsePR5hCT+yFEaOjbNBO9wU3hpnqHUJGmeQRBfO0QAiYzoDQ/RMPsZne6Nz0Kf3hi4oCr3HU8Oen5RaXhFfP+eonR7DnDzVd+zCZbjdVjpZw83K5ZYm1BpdMlJOcoXLIH/JvcxjIJjxtBrisYOezfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790064893; c=relaxed/relaxed;
	bh=05lGqeR+0ZF0CP4Fq9knoYUiG/+6t0CLA1xk1HKeOK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMUPxej3Wthr9nWeyZtW+LvyV90+0onQTAT366d2z5NkZJ7obLUcFU+G7sS2Ykazxn5WvkXWhn56Bavieyu+7PzeVlxTL9SIq3pVPolfPiwB28DHsBGLkqXwLsoNLN47elWpgUp8CC7GqoQw0nS6B7nn3tXuO5QVTHAfIqoAoGHXeooPhvc4sX+umcOIyOOsGvaAqT+9Lni5FkQGSR25elpCSChKzdpHy8rNIXK7g3fOZS6WiSLNSUCS4CjW2wlOaEIWHAsVdXK00jUcjfQdnCmActcLhiIPuw2VV0XYBghqSgLhlwy5AEwzLihw3Onm1hbfz4ix3rcJMBkhNMID1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BdpNALhd; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::61; helo=mta1.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BdpNALhd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::61; helo=mta1.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-97.mta1.migadu.com [IPv6:2001:41d0:203:375::61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hptDr0yhtz2yn2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 18:14:51 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=J2i5GvjJ+wUOBpbMeil8dkAVf6eHV4FfangEdsKlF5o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790064873; v=1; x=1790669673;
 b=BdpNALhd4Xq72H0U13xGDLE2o4tCZFTlNFxRZ0RV+Y3w6reTkOcOxBJcuW8xV5K/M7OfmtDj
 359+6dseT0n9OgrcsJtw3C7MUkz2TmJCJFIcWBdFPwSkadiw/q8BirBltj+HGJWDS3/usPc9RvN
 d+jh8sl+IQiz9S/FbFA0o+ow=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id ac6469190cc15d1a;
	Tue, 22 Sep 2026 08:14:32 +0000
X-Mizu-Trace-ID: ac6469190cc15d1a
X-Migadu-Flow: FLOW_OUT
Message-ID: <4f419e8d-de07-48be-a69c-7b7b9d4a1cb7@linux.dev>
Date: Tue, 22 Sep 2026 16:14:23 +0800
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
Subject: Re: [PATCH 5/6] powerpc/mm: make vmemmap_populate_compound_pages()
 static
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
References: <20260913083734.86802-1-songmuchun@bytedance.com>
 <20260913083734.86802-6-songmuchun@bytedance.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260913083734.86802-6-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/13/26 4:37 PM, Muchun Song wrote:
> vmemmap_populate_compound_pages() is no longer used outside
> radix_pgtable.c.
> 
> Make it static and drop the unused dev_pagemap argument from
> its only remaining caller to simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   arch/powerpc/include/asm/book3s/64/radix.h |  6 ------
>   arch/powerpc/mm/book3s64/radix_pgtable.c   | 13 +++++++------
>   2 files changed, 7 insertions(+), 12 deletions(-)

Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks,
Qi


