Return-Path: <linuxppc-dev+bounces-26603-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BACEC624DB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 08:36:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcRWS58Ppz2ygW;
	Sat, 05 Sep 2026 18:36:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::dc"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788597380;
	cv=none; b=JjR/7jZcUHEI9POh4PdFUvWyruhRB1bjDGO2GQZSpL4WPhug9k5gRx8pMlQABHTasaDZeFoNpK0iC9T4V+RpReQoj4EGvZ0/dHEEw4dTJNhr31kMAJaR6rLDnqAZL2pb0Zup9ZCuFTtgJBQTEGKOz+IoVGSPdlICcwDfAOSrX/bjkuR4t4rMG/amDksS0rzCzXxebA5SqZ1rFf8BcJyhLknaMq/AoI3gwlXmfaWxPjST+NapxJCH8oye1idk9JaXEygw4HTTgkffyO9LseVbQFB91SQYOME1IUtI573yQwUJx1CCT88M/xmQUQ6ORR9LgOr7eMJIEFj6+MoHJaG6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788597380; c=relaxed/relaxed;
	bh=ZKdcalzFfHCkzaUSjtWFIOytWPP0NothcG56Z+sOaGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhl0ZEHL0i8k1Yglk+BiVC/O1JZZnreR4hW8SppCLZLaCobm49ziYR4Xk8hM/gDuS49NTUjeDgpUgn6znhirQrHVx4VO5WvAOYYlNGoQqKBZDOWn+QUCOqLiPPp/zeCNiLic5rtZzr6592aHoqzbW0VIloPVJ2wQdHhTaghlmYl38/rW/C2kL59NC4PWCqJxJRlZnYWym11zas4nDj5so6DG8TMdk4LYN0a1IDshVTvo+43OItVusHoJJ6EP+V0PsxKhgtXoaJObKzF+8b+xoLyViMlCdCeqRbHLXdpNOEg2+DDHbFmgTMKu+Eit/A/YbwPjhF0ze/smcyZQrnbNcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LoAZgjW9; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::dc; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LoAZgjW9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::dc; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-220.mta0.migadu.com [IPv6:2001:41d0:1004:224b::dc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcRWP4rGrz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 18:36:15 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=LhEf2lmvz3lHfnrYNvIqdGOINaYOzsSsBbuAUaDK0d4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788597353; v=1; x=1789202153;
 b=LoAZgjW9eTsAU3sYux3iSDpm37PYZQJ9V9SZ8rpDaXIIEopob8BJCt5B+NVpxfZ/CTiLmU7I
 qX8hgUoDhJWrpj9uFblu4qZJPE2mY649obJhSiyiTdQT/BWIMiyvG3RTKfqzUioAu/4agaJppgi
 d6CVlIvUaJr88PD81EE5/DXE=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 41100b57e1186b92;
	Sat, 05 Sep 2026 08:35:42 +0000
X-Mizu-Trace-ID: 41100b57e1186b92
X-Migadu-Flow: FLOW_OUT
Message-ID: <e3d0eaf8-a85f-48ff-96c2-dced4945b085@linux.dev>
Date: Sat, 5 Sep 2026 16:35:31 +0800
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
Subject: Re: [PATCH 06/11] mm/sparse-vmemmap: switch device DAX to shared tail
 vmemmap pages
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
 <20260831075342.57563-7-songmuchun@bytedance.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260831075342.57563-7-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/31/26 3:53 PM, Muchun Song wrote:
> HugeTLB vmemmap optimization now uses per-zone shared tail vmemmap pages.
> Device DAX has not been switched to that mechanism yet.
> 
> Switch device DAX to vmemmap_shared_tail_page() as well. This aligns DAX
> with HugeTLB by using the common per-zone shared tail vmemmap page.
> 
> Since the shared tail page can now back ZONE_DEVICE vmemmap mappings,

Could you explain this in more detail?

As sashiko pointed out [1], it looks like this assumption is
problematic: dax_folio_reset_order() may end up modifying all shared
tail pages?

[1]. 
https://sashiko.dev/#/patchset/20260831075342.57563-1-songmuchun%40bytedance.com

> initialize its entries with PG_reserved for device zones. Also skip
> poisoning vmemmap-optimizable sections while their struct pages may be
> shared.
> 

