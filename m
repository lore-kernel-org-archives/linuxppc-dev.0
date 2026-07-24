Return-Path: <linuxppc-dev+bounces-24779-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD1EC531C9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 13:43:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h68Ms1M0dz2yPR;
	Fri, 24 Jul 2026 23:43:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b5"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784900617;
	cv=none; b=LWfUSKjQqj7skjuIBnfIs9bLbiiv9JE801ZfoTTDJRjwtBkv5dkT9e3A3l05N7/pKhpZ7BXiiu5+r2d1ACUtUqkHLHgmz5K5v9Eo8naraeoTj76T5OwHv7nPf/ebwD+yED7MKUf3OakxrC2Gjbk69NiUcHnoh8OIexPnyQ5VlPdc9XA/eM0ER53okQh3TAo/VqFW1CS4un7n9ftasoIEAZajjd7aoc3hueteOmooFdM2jvh0O+sDXe8LAYQ3QpeIwUtLWd1U1KmXl57rXQ6WQ0fC/JV3gMjiCan1dm4GZv8F4zpXOsBbfP0PBqUWch5QJDopcggcZMHT7g3wuh4yHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784900617; c=relaxed/relaxed;
	bh=6/FxFds0ZblJiTDVn0Zh6YSzNFtgG6KSsc6BX2Vp7N0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5dum+xH+EsY96MqZbBCrVTtZG0E0CpOK7NG5Yo4ajbMZBnDFXugQAeuj38mZESLaMXHYW6C19CWiYgD9pTRItHsGXnSt7EO/tgkQ3TRGZfxp8Waf4nqwJAKijz2fyGoyWFZN98O78AQbyU3qRaZyddx+BSEj5gx12/CtvcBDvPZDos56X313b2jrRd6MJA5sFMHe8v/a+y7/iJ+SnW1a0bsXr88b8zBiM4G2qHxzY7j4R/admkH2ahn0nFV5w665qZY1YY8HRjZu/l/qQqYyKcodlulPy5TA1rKVCeXEhdKnYucLfK7IyDY5kEfxTwSJm/QmxVDRwM/iRqcVz5xGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UvQ7Evnd; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b5; helo=out-181.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UvQ7Evnd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b5; helo=out-181.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h68Mr0BvJz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 23:43:35 +1000 (AEST)
Message-ID: <0fd713a8-e4ab-4c07-b36e-79dd138b4a86@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784900227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/FxFds0ZblJiTDVn0Zh6YSzNFtgG6KSsc6BX2Vp7N0=;
	b=UvQ7Evndl12aryBj5Gzh/4Kx4IFxjvJ4rQR7z7ZeZ02IkJcBysdcs4RGKKa4/VtIk/MUN4
	kFv0UzKogYSnjvY8paSxOYiT0jsEqzPaZPtCX7Fha6cYM3qT2NMr9omxqoVR6rqLt06FcV
	aqyG0djpQWd5Myh9Rdt5ZWa+1GWgLE8=
Date: Fri, 24 Jul 2026 14:36:59 +0100
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
Subject: Re: [PATCH 3/5] mm/parisc: constify ptep_get() argument
To: Pedro Falcato <pfalcato@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Muhammad Usama Anjum <usama.anjum@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20260724102017.141532-1-pfalcato@suse.de>
 <20260724102017.141532-4-pfalcato@suse.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260724102017.141532-4-pfalcato@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 24/07/2026 11:20, Pedro Falcato wrote:
> ptep_get() does not need write access to the PTE.
> 
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> ---
>  arch/parisc/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
hmm I think you might break build bisectibility if
you separate out the patches, you should squash patch 3 and 4,
with patch 1.

