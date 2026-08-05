Return-Path: <linuxppc-dev+bounces-25427-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E15C56201
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 10:43:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFRny2JcDz2y1Y;
	Wed, 05 Aug 2026 20:43:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785926582;
	cv=none; b=oHfUcWOUNQ5Sig63XIH4eDaD+iYZu0cc81Ugn8uFIyzyTADabydS/nSicdS/WrD+jwsTYGYi3l51ggc0v8EQVsZ87A+hAmnEmUjXMgzFVG9G8jBM/WaaxGYG05uAz6jyINx+xL4ju3VTeN+8TSVmOw8EslQI+J79Jxqf4nvTz3/NJdlJRgABa5VpjXWSnhUWCysv6IklW9strRP5+k5aHJVuD5pKSsslSJzdBrqe3x6kObkkX4/sjqrtKkbtYem0oko+dyu5NXV+EN3ZTMy4Oe4Tm2hsTdWuU7Vy/+bCm21tnJXGJZpkxP2kX24A0DNr0JtjWOF9xf8cdC4AicIcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785926582; c=relaxed/relaxed;
	bh=Q4K8KezGj1uNtUBla4Um/QhzlQ9Qk/rg7DVPoMDL72Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFv3GtUPMl3aOVBOgFY0Nfbw2C/hMyB6S462MIlNEPnEGDTu4Em0ggVU4VYwXtRlGpvMY4xgmnwYIBbJS1fsuDWomTBtopaPakv9B0x7NT1B0f5V1sQaVyM0x2zjKTy1V34QuGoxknD/V53pBxHUbafF3Fijr8FWzCj2kFTlcnuwXLPS8s2rRvvCFcpeWQATJhUinzoGZF6Bih68/5/m+KwTLCaa36STdkfQwSMhDmwql01UKNWkR+4vu7yqJcHOd4iCQTOCFrvAxK45EVp5et5oo3IB3lDq23jrlSr2j0UIBI9Es7Yed8zmfxLcu1gdyn49HP9DALnM5E2tNv4t/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ai1MPx4+; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ai1MPx4+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFRnv3D8Jz2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 20:42:57 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA2D2153B;
	Wed,  5 Aug 2026 03:42:20 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E9F63F632;
	Wed,  5 Aug 2026 03:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785926544; bh=dLnCHFABrcZb/4lMb8OKip2XrApMrTNt9jLEKjSti1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ai1MPx4+Ir9VhFeH2HWxjevL9kszGJ6grspTTZUKC4wtSs46+DRMHe7SevW8UESlp
	 nEm2r4W4I9DKOG0PZ90sfhgLuvCLZGB6e8v5MNNQqPMOIVLQnZJ/pyE+ZB356so1Ga
	 R5xoG9ECl/ieCh3WindUP/tPTEQ7Blav4otAFLv8=
Date: Wed, 5 Aug 2026 16:12:21 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] mm: add basic PTE const type-safety
Message-ID: <a5afofuxhzwkeb76jdheottyxt4mms3arg2iucunztczbmd3lf@wiqp7yccjzlt>
References: <20260803164400.531199-1-pfalcato@suse.de>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803164400.531199-1-pfalcato@suse.de>

On Mon, Aug 03, 2026 at 05:43:54PM +0100, Pedro Falcato wrote:
> Since forever, MM code has thrown pte_t * around with no concern for const
> safety, or typesafety of any kind. This is confusing. Attempt to address it
> by:
> 1) Making sure pte_get*() helpers can cope with const pte_t * arguments
> 2) Constifying the pte_offset_map_ro_nolock() return type, which by definition
> already pledges that users will not write to it.
> 
> These two simple steps were already able to uncover code smell from
> khugepaged + do_swap_page().
> 
> Separate steps could include introducing pte_offset_map_ro_lock() for more
> widespread usage of this.
> 
> Benefits of this include less confusion and better type-safety. It could also
> futurely aid in efforts such as [0] which may want semantic annotation of these
> accesses.
> 
> Based on mm-unstable and compile-tested on a handful of architectures.
> 
> No functional changes intended.

Even though the pte accesses should always be type-safe, this series does
not really address the problem completely and instead changes things only
for a small set of pte access sites. So just wondering how much beneficial
this series really is ?

> 
> [CC list editorially trimmed for brevity reasons; apologies if you're not on it]
> 
> Link: https://lore.kernel.org/linux-mm/20260526-kpkeys-v8-0-eaaacdacc67c@arm.com/#t [0]
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: "Liam R. Howlett" <liam@infradead.org>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Usama Arif <usama.arif@linux.dev>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Muhammad Usama Anjum <usama.anjum@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> 
> v2:
>  - Small fixups on the arm64 side
>  - Re-order patches in a way such that bisection is preserved
>  - Pick up Helge's patch dropping parisc ptep_get()
>  - Constify s390's ptep_get() as well
> 
> Helge Deller (1):
>   parisc: Drop own implementations for ptep_get() and
>     ptep_test_and_clear_young()
> 
> Pedro Falcato (5):
>   mm/arm64: constify pte_get*() and contpte get logic
>   mm/powerpc/8xx: constify ptep_get() argument
>   mm/s390: constify ptep_get() argument
>   mm: constify generic pte_get*()
>   mm: constify the pte_offset_map_ro_nolock() return value
> 
>  arch/arm64/include/asm/pgtable.h             | 10 +++++-----
>  arch/arm64/mm/contpte.c                      | 11 ++++++++---
>  arch/parisc/include/asm/pgtable.h            | 20 --------------------
>  arch/powerpc/include/asm/nohash/32/pte-8xx.h |  2 +-
>  arch/powerpc/mm/pgtable.c                    |  2 +-
>  arch/s390/include/asm/pgtable.h              |  2 +-
>  include/linux/mm.h                           |  4 ++--
>  include/linux/pgtable.h                      |  8 ++++----
>  mm/filemap.c                                 |  2 +-
>  mm/khugepaged.c                              |  2 +-
>  mm/pgtable-generic.c                         |  4 ++--
>  11 files changed, 26 insertions(+), 41 deletions(-)
> 
> -- 
> 2.55.0
> 

