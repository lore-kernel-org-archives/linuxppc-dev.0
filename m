Return-Path: <linuxppc-dev+bounces-26780-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15011C79F82
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 09:24:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfJRX1lHkz2y8G;
	Tue, 08 Sep 2026 19:24:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::48"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788859464;
	cv=none; b=Ya5ziPcxa3xgEYIwqvECq+0B9gzHL4mFo/YSpj7B640Q9UF2pD+xFfrQaooYrYOZCtruVNd90BcmrIzsmIFQMMfITMK1cKXvVXJZuzNv65RcX4J5L5Ayhu2MijHGQnHcRGcDeq4ejmZikkxH4S8ikWX/z6WX+UXvU0c0qmX3QkqT9c2tkv/LlA6Wz3rjDpqZL6oFAxqRhGZ05k2AEnO/+SiYyCH6/Hnkbk+xjjPix3BazoUPgnBH5TJQMHw+9lm/nxn2DKCcg+Zg9JGAxmue6Fz4rIVgwxgtwDOPwTT1LxOByk0METNhbbp6rHtmZtUzVQZ+J67hmd16o3GnbBl6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788859464; c=relaxed/relaxed;
	bh=IM44ePpO94fxzu9/kZHKicLzbeTfvzqyw+Wr747U33c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQvt+a7U0DuYNatD6CYnN5vGQ+vUR9l6OvVDCUu7GV70sNH7qcIIJUZEdiKlGMmND2jeQZ5oLBogjKpM0GXxO0FpiS8C/mquFVoGDlZOcJndA8GkqWWmsQ7477Ho3QOMFTrtM61JLNXj7r6iOfuaawyVXdcjS3lDzJn9P5zdODUHA+QhI5OAousSaxn9VLlFleFsko5ZEPzYZrvjWChxZFyJ3G1K8/lNHiXqa1WY8cR9f2AEzBK6+XXLzCPuoP5mAT5+qAm9cnnhl9EufguH5vAwD3/JyTqDZrPyPub1BauCvBe6YLCRA/NSFfFO0efGg3dUASrINP7QMBZNriWwEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q1Wlwc1t; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::48; helo=mta1.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q1Wlwc1t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::48; helo=mta1.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 5852 seconds by postgrey-1.37 at boromir; Tue, 08 Sep 2026 19:24:21 AEST
Received: from mta1.migadu.com (out-72.mta1.migadu.com [IPv6:2001:41d0:203:375::48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfJRT10gYz2xlJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 19:24:19 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=Lq4ARpMbanal89TxHuI1tA2YfFgMGpzO1BWcDeL62IM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788859441; v=1; x=1789464241;
 b=q1Wlwc1tM+J8SYWg8S7iejZ2/QZ2aXPSQnppHpP1bMmlnNWxW5wCpgLIG40TPtcw7RIBi7Rj
 LvV+ThsluTG0LBe0G4Spoxikele24s034tqj3W1wtLi+OMSKwfOxPQrmCZcfw7AMk4H/WWmCHw2
 hpglh/bDvK+DiVFYi6ZkgXhU=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 98e59e83dd11dcc5;
	Tue, 08 Sep 2026 09:24:01 +0000
X-Mizu-Trace-ID: 98e59e83dd11dcc5
X-Migadu-Flow: FLOW_OUT
Message-ID: <bb30518c-9046-418e-b190-9f3f1b542cbe@linux.dev>
Date: Tue, 8 Sep 2026 17:23:54 +0800
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
Subject: Re: [PATCH v2 10/11] mm/sparse-vmemmap: drop unused
 section_nr_vmemmap_pages() arguments
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
References: <20260908030335.96549-1-songmuchun@bytedance.com>
 <20260908030335.96549-11-songmuchun@bytedance.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260908030335.96549-11-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/26 11:03 AM, Muchun Song wrote:
> section_nr_vmemmap_pages() no longer uses the altmap or pgmap
> arguments, so drop them from the helper and its callers.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   mm/sparse-vmemmap.c | 10 ++++------
>   mm/sparse.c         |  3 +--
>   mm/sparse.h         |  6 ++----
>   3 files changed, 7 insertions(+), 12 deletions(-)
> 

Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks,
Qi


