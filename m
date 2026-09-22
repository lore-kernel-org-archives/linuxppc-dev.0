Return-Path: <linuxppc-dev+bounces-27902-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F845C982F1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 08:18:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hptKV0Pqzz2yhD;
	Tue, 22 Sep 2026 18:18:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::83"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790065133;
	cv=none; b=FA3zeP2/Z9GuFO8d2ONrWYrCVhaXL3sLObqPYtoKLJq4F2z90RuCtdjtkBmyJPy+STkuYKLhhdwaxzFLbrUJsKS4WhK/odmTFzyJUtdUxzL8bVGwDW5lwyjzgy9KT1jRImKyXqq/aQ6Dlwok+JFo9WK5x+/Z0h3Y7syQMAhSpUAd70MYDQxRgrRyY5V1StmYVdlkRohxVID8A2nlPmj/pOYKEuqRsl+hj7aQcg/hbQ/NLt9obRLKAu/KashPWctd83jdfTg4dYX+K0sq2Dzv+wvXKV+5XFlDwPYZjxOsd7U9RtHFM50r1KvnK55cXFwSJjq5azpuNU+dhTwD09foaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790065133; c=relaxed/relaxed;
	bh=P+XGnBzqs7O2W4lk2MRSsmNS7PIMyk+FriX30BhA4JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YvE1ebF8FL6ZBimAt+5iPRgtML2P4m1iJBSOutRYpGAIdhGe4fJUqYLOKoHFIcQ6g/Ex9g5N/yU/JIiNpt9H1ghh8shJJOixFZ9N+iSfyFWv1WA7lefBYM/uRYwPcOUDT/2iGOWAblGzvvbzQ4zD2IgHaexpgiHqSWaqD/gBgSfSb9KmqrKFAOZ6ny9ckPRko7ABIXB8o3les8OW6e1aps3TtCHoy+yksUU3B2Fk2/v30RKaQQifZlrGmDBQNSnNf+/vaAhragkNb6kpT/eExpn3mJAbuvp+iTMFOBQaeVF40BDrLdu5dEj0RMeHAdLvsW9rgNGtP228mL+gUAG+fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=olw5uo/x; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::83; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=olw5uo/x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::83; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-131.mta0.migadu.com [IPv6:2001:41d0:1004:224b::83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hptKR1LDQz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 18:18:49 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=ktrAUhwI64L505wDOUN7xl4hGLDxMuKT/wuyW3WOSV0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790065111; v=1; x=1790669911;
 b=olw5uo/xTuL790U0/Ix6xE0wzHpk+VQfuSsgTd/1mtedkVS1AVWgJL5mCLlsiXq6kjiYXe62
 0V3wS+Derk4bcykMysUPCq64KNLTu1vxWwkK2P2CPxOD4iM9hXvDg/4oJyXAJpbtCGPzXEqg+JG
 Kop9OnLTFuNWkgpVdJqppNuw=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 9f6078236310b3ef;
	Tue, 22 Sep 2026 08:18:31 +0000
X-Mizu-Trace-ID: 9f6078236310b3ef
X-Migadu-Flow: FLOW_OUT
Message-ID: <b7932a94-32cb-4717-bcb3-d1982fc4f270@linux.dev>
Date: Tue, 22 Sep 2026 16:18:24 +0800
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
Subject: Re: [PATCH 6/6] mm/sparse-vmemmap: open-code
 vmemmap_populate_address()
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
 <20260913083734.86802-7-songmuchun@bytedance.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260913083734.86802-7-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/13/26 4:37 PM, Muchun Song wrote:
> vmemmap_populate_address() no longer has any callers that need the
> returned PTE.  Its only remaining user, vmemmap_populate_range(), only
> checks whether population succeeded.
> 
> Open-code vmemmap_populate_address() directly in
> vmemmap_populate_basepages(), remove the now-redundant range helper,
> and return -ENOMEM directly on failure.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   mm/sparse-vmemmap.c | 54 ++++++++++++++-------------------------------
>   1 file changed, 17 insertions(+), 37 deletions(-)
> 

Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks,
Qi


