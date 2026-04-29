Return-Path: <linuxppc-dev+bounces-20253-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878DEFF885A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 03:02:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g52D91hRSz2ySW;
	Wed, 29 Apr 2026 13:02:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777431769;
	cv=none; b=EtcRRXoBYip0w8uIRO/KVXnr29lq2t62MkYPnwvN//qeo3hq55xljz3UkTyrnKsgomEg+OKmtF/QsyUamZxpFFeik+KqLjQJ33tQmJMIgi9Ev6SNA5vza4b0PBKqjejgbmYOinkuqKxn8iHXD+lqYaiwjVdanB3i0hfkpI3Ye7hYxe2ui15oCsWtIHSuzE+3llIPiWoOcrW5Paa9n1b9/AM/bDWkvCuqHPSvURMSv1nlwWa3qfQAR2BoXjOY9G5uh8Quz0m1BlPtsabniAtuhUoUaJAUaTBuE9EnBwts8cdn+KzV9Irds0wOe3bxxen/OhxH85u6329QjLSqmJt+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777431769; c=relaxed/relaxed;
	bh=xAptSnBmp9h9N12mhZQEdxJex9G2kRMi+UwodffAKNw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=arYQprGVC22LoMyf7MVcykHuvSjZpwafb7I7y3iVQHP4TZf7l6zVBL/W9jD5xMZyNFp2kwZmvMAAoVmfyF8Qx/hjx57QTQxIDS9RjQb0VEK6d3zOE8wWfgcV8YlQomC2CssUJ0cbAPz6jFUBldWeKAETQCCEiNi0tfUUm13fwYdG1XfNiU2o/aIL0n6PuIuJQXxHE6pJaSOzipYF47s1DokAGSZ37KSAidR4RZ78CBdBvBpLnGCUDQtjvFpfhUBx1gXAgD0qdBXaxOQ4fvisj+rF0qySh9emGFGdlB5WlEKJ69IFhhiYdQvmcE0zUTb9p4bsO7QGWtl3GhcQ5z5QFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nUKX6miB; dkim-atps=neutral; spf=pass (client-ip=91.218.175.188; helo=out-188.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nUKX6miB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.188; helo=out-188.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g52D83ybKz2xTh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 13:02:48 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777431748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xAptSnBmp9h9N12mhZQEdxJex9G2kRMi+UwodffAKNw=;
	b=nUKX6miBABkPqJTWDSe3nzmfIfQo2Vwx4KnKafK/tN9cODk7otB5prJfru7ieBqJdxxlRV
	8z0o0dwhC7ungjhgBrC8noRgvfZ/g4DM7YVbaKB0AQyBNgeDDmuX9Cg/avGVnCjQE3aiPX
	NFUPD7RRWZxRYLlyVhPJShq70PfUdZI=
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 12/49] mm: make set_pageblock_order() static
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <afBe_CQ0RtmT3xhK@kernel.org>
Date: Wed, 29 Apr 2026 11:01:39 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2DE2FBA9-6D7E-4DDA-8B11-E844EB42E574@linux.dev>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-13-songmuchun@bytedance.com>
 <afBe_CQ0RtmT3xhK@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 28, 2026, at 15:17, Mike Rapoport <rppt@kernel.org> wrote:
> 
> On Sun, Apr 05, 2026 at 08:52:03PM +0800, Muchun Song wrote:
>> Since set_pageblock_order() is only used in mm/mm_init.c now, make it
>> static and remove its declaration from mm/internal.h.
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> The removal of set_pageblock_order() from sparse.c should be moved here as
> well :)

Will do.

> With that
> 
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks.

> 
>> ---
>> mm/internal.h | 1 -
>> mm/mm_init.c  | 4 ++--
>> 2 files changed, 2 insertions(+), 3 deletions(-)
> 
> -- 
> Sincerely yours,
> Mike.


