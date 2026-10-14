Return-Path: <linuxppc-dev+bounces-29492-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C92CC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 16:05:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4bdK26zbz2yqs;
	Thu, 15 Oct 2026 03:05:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::47"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791993909;
	cv=none; b=LWeGRqfMvEGYWlxnU/z6cabCJrNzVXs+gZzbHaDMS7xd4VdXP5aYJDaMDaNAIgiCSrjPhD3qlEd7NrW95NWkh9tYHv0VVCrCbkEikBA+nSivgDIq1a9/3klHs2FBvRD2SkHhWlRisaBnmORcGtICv+bceXuS+GY7WCGZ0fijKZ5Dhpc5ulnpeFVjDPbiKLM+MSKbWn4BKD1TR5FWHNqd/4lw3Zr/wlWEoOjyml+PrM8q4MX/WslsGQrEut4Q4A6pSgUdJ8SLSau5faKCXZNEs7+Gq9UVZzYI8TZcLXser73VsUp8e+UtMMd0FdkUu8GsmB+qewyB5LHUndfi27iVmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791993909; c=relaxed/relaxed;
	bh=IkZZR0p9Vzi9220+twT+gKA4/7OY831iNe+HO/zdAnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bd9SMPk3ARRnGIaI2xMTxlDuIzQ7ipazt+uvaJIbUupBiIQv4NS7VDqKLfvPSKcepckzW/Z6h39mtrmo+HBgnmHW//ePiWif3CYOyhdM9eIymdjlzZQY7eK8AMa5iOZaYrdW57PXK7CEEKv+ybQuBbokKKrWEvKg/kUzH98ceDIuyjBez5zeCyTqEQHZHJ9aIMs+/1esy5xeOy1VnLOewKf8KhX2AdkvdDq6Q8RwwWg+lGgxJ3Nws9J/F+e96VN3IAnsr7ePVHMtp1VgWp2R1DKm2cfcAg9divCRvigbquUCjh4T/2WAow3R9xWnSkwxiEbEwY+EwwWhd5j1PHbhvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FB2ic1WG; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::47; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FB2ic1WG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::47; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-71.mta0.migadu.com [IPv6:2001:41d0:1004:224b::47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4bdB2FgPz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 03:05:01 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=PI0fOAv5zzJ41Ji3Z2QtwoPTiCXvJem5/RFTA0ekY0U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791993881; v=1; x=1792598681;
 b=FB2ic1WGugcHaPbviCEivRkLZWw6rAaFPdy2BZYb5aDlbMVpLQ4QRp/EaFsTU3lA6tRJugoS
 l/P+Y1zD2kd/5w573b/aFKTNx03vEhPg5K6XeQ/2N/QhYiJ3qoDoGXWldnKvH6p88DlRCbbU0h+
 /CIC+skOEpBCvkjLuyFJijRo=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 0ac52b3081cf7048;
	Wed, 14 Oct 2026 16:04:41 +0000
X-Mizu-Trace-ID: 0ac52b3081cf7048
X-Migadu-Flow: FLOW_OUT
Message-ID: <73f0dafd-5b26-42b9-a77b-90c32976942f@linux.dev>
Date: Thu, 15 Oct 2026 00:04:23 +0800
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
Subject: Re: [PATCH v3 0/2] mm/huge_memory: fix the copy of special PMDs at
 fork
Content-Language: en-US
To: Konstantin Khorenko <khorenko@virtuozzo.com>, Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Peter Xu <peterx@redhat.com>,
 Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-0-85eaec8417f6@virtuozzo.com>
 <F6337325-E635-43BB-9E5E-DCD25F4FC951@nvidia.com>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <F6337325-E635-43BB-9E5E-DCD25F4FC951@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/14 23:57, Zi Yan wrote:
> On 14 Oct 2026, at 11:46, Konstantin Khorenko wrote:
> 
> <snip>
> 
>>
>>
>> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
>> ---
>> Changes in v3:
>> - Patch 1: recheck the PMD with pmd_none(), as only a zap can change
>>    it and a zap leaves it none (Lance Yang).
>> - Link to v2: https://patch.msgid.link/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v2-0-e1548488fa68@virtuozzo.com
>>
>> Changes in v2:
>> - Add patch 2, the page table deposit for ppc64 hash, reported by
>>    Sashiko.
>> - Patch 1: name panthor instead of drm_gem_shmem as the driver whose
>>    stale child mapping reaches freed pages: drm_gem_shmem keeps the
>>    pages of a purged object until the last mapping goes away.
>> - Link to v1: https://patch.msgid.link/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com
>>
> 
> Please stop sending new versions of a patchset repeatedly.
> Wait at least a day for others to catch up.

+1

Please slow down a bit. You don't need to respin every few
hours. That just makes everyone start over ...

Post a version, wait for feedback, then revise. Twice a week
is plenty, honestly :)

Cheers, Lance

> Thanks.
> 
>> ---
>> Konstantin Khorenko (2):
>>        mm/huge_memory: recheck a special PMD under the lock in copy_huge_pmd()
>>        mm/huge_memory: deposit a page table for a special PMD copied by fork
>>
>>   mm/huge_memory.c | 34 +++++++++++++++++++++++++++-------
>>   1 file changed, 27 insertions(+), 7 deletions(-)
>> ---
>> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
>> change-id: 20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-bdf7efb612c2
>>
>> Best regards,
>> --
>> Konstantin Khorenko <khorenko@virtuozzo.com>
> 
> 
> Best Regards,
> Yan, Zi


