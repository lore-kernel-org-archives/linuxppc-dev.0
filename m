Return-Path: <linuxppc-dev+bounces-20247-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534F7FF8875
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 00:25:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4ykn0J74z2yTH;
	Wed, 29 Apr 2026 10:25:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777386156;
	cv=none; b=OK5SjM3mTXBjwQuU7VBdNwPClqZp/m7RcRl9d9suwIeI4uesYFOe1tQS4RsrdZ4MqJLDfR+Qqbd8EyuoOQx7jHMaTmnR5tYsy/qlebXU6zUXrPhmo8VyTTbMjbuv8EwCybzT/qy4jMVqi+llRulZnguaRIbWavFXXPpHpbY7BXJGxKwoSjvZOdOg5NmYH7LUTSgSTtkPayASeII0HhCum4biQuTV1wN4Zqncn48ftNdSeVhpIpsXOruct0JWTjJh4vhycBtSRj0AyBnoThX7b7dr+Z5NjS5EryH2gzSn+ITnoniAozJdJrK3+pJaoTd3O+E+yc6qER29KBLEaO4JrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777386156; c=relaxed/relaxed;
	bh=W0Te1SqwkV5UqcpbbzTNHO6gbbaHS7L3dF8jXDrZ4q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouMMpARKZvH4ksrcF6ZQsT5+ZyG8tQmQx7cgvRyuwnUKnM8SD33SroN2c91OTLtJV/xWcgfdpwwdQQQdX+WXzB2Vstxzm4MmAUyMkEdPGwHcwhY2i4iScey7n11Bbtk7KzNGcc6w18BXjeEEkIaH9e0yfBfmLHBnPwj+5i8RfigCqHRnqFgQQX01AxQnXgJ38ASYHfBWwowgtOKXdpCut0ThIpnpmD+SGkenxIZMjViNpoGWli8xCkxyK394N4WwFT9G+MMOeVbZ8iEz++Qzzn5ppiS/mBmafLwPyFvAQO0x2MkiFS9tGdz+0mBekO7wLHVDhgPXZD4smOGNXJl6Fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=infradead.org; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=liam@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=liam@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4jLq3WQqz2xTh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 00:22:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W0Te1SqwkV5UqcpbbzTNHO6gbbaHS7L3dF8jXDrZ4q4=; b=kkTKQMnKwtrXqCNKc0z1+J1ku5
	Ms8qXs30K3/sdRV7uij5DXh0HTcXn9L9KT4sPPzRw/gsCgl00XoeLU77f+Nu/s2Nlde0dc/O+kmYN
	LgNhv27w1UFREraZJOEsjQ+VlDjYcXRo7tzlBvzY2y1s5VjOqobTOrpHYZh7c3TGPSQDMBB6KHqu1
	Kd4KJhznO7F35fQpihg4H4pQXFoDr+/6HKC6UNbelBYV+pFJANHJLZdqWoXQMN/gjd4vPLbxhyd2I
	W2No7s7hRvN36oog2fI0qb290Nkw71zvIEs5Oqsm2CGwt7cshYriElYDM9O3I5kmeHBgDZ/dtpdCP
	T2CELHZw==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHjKB-00000001dTc-28ed;
	Tue, 28 Apr 2026 14:22:07 +0000
Date: Tue, 28 Apr 2026 10:22:00 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com, joao.m.martins@oracle.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/6] mm: Fix vmemmap optimization accounting and
 initialization
Message-ID: <2sdehw5xhmw6fufvdhztlfbm2zgjycj74jstxhqkmxwtyu4unc@nxrx77iwmep4>
References: <20260428081855.1249045-1-songmuchun@bytedance.com>
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
In-Reply-To: <20260428081855.1249045-1-songmuchun@bytedance.com>

On 26/04/28 04:18PM, Muchun Song wrote:
> The series fixes several bugs in vmemmap optimization, mainly around
> incorrect page accounting and memmap initialization in DAX and memory
> hotplug paths. It also fixes pageblock migratetype initialization and
> struct page initialization for ZONE_DEVICE compound pages.
> 
> Patches 1-4 fix vmemmap accounting issues. Patch 1 fixes an accounting
> underflow in the section activation failure path by moving vmemmap page
> accounting into the lower-level allocation and freeing helpers. Patch 2
> fixes incorrect altmap passing in the memory hotplug error path. Patch 3
> passes pgmap through memory deactivation paths so the teardown side can
> determine whether vmemmap optimization was in effect. Patch 4 uses that
> information to account the optimized DAX vmemmap size correctly.
> 
> Patches 5-6 fix initialization issues in mm/mm_init. One makes sure all
> pageblocks in ZONE_DEVICE compound pages get their migratetype
> initialized. The other fixes a case where DAX memory hotplug reuses an
> unoptimized early-section memmap while compound_nr_pages() still assumes
> vmemmap optimization, leaving tail struct pages uninitialized.
> 
> Changes in v8:
> - In patch 4, move VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION) to the
>   top of section_nr_vmemmap_pages().
> - In patch 4, add Acked-by from David Hildenbrand.

Thanks!

Acked-by: Liam R. Howlett <liam@infradead.org>

> 
> Muchun Song (6):
>   mm/sparse-vmemmap: Fix vmemmap accounting underflow
>   mm/memory_hotplug: Fix incorrect altmap passing in error path
>   mm/sparse-vmemmap: Pass @pgmap argument to memory deactivation paths
>   mm/sparse-vmemmap: Fix DAX vmemmap accounting with optimization
>   mm/mm_init: Fix pageblock migratetype for ZONE_DEVICE compound pages
>   mm/mm_init: Fix uninitialized struct pages for ZONE_DEVICE
> 
>  arch/arm64/mm/mmu.c            |  5 +--
>  arch/loongarch/mm/init.c       |  5 +--
>  arch/powerpc/mm/mem.c          |  5 +--
>  arch/riscv/mm/init.c           |  5 +--
>  arch/s390/mm/init.c            |  5 +--
>  arch/x86/mm/init_64.c          |  5 +--
>  include/linux/memory_hotplug.h |  8 +++--
>  mm/memory_hotplug.c            | 13 ++++----
>  mm/memremap.c                  |  4 +--
>  mm/mm_init.c                   | 47 ++++++++++++++++-----------
>  mm/sparse-vmemmap.c            | 58 ++++++++++++++++++++++++++--------
>  11 files changed, 105 insertions(+), 55 deletions(-)
> 
> 
> base-commit: 39704f00f747aba3144289870b5fd8ac230a9aaf
> -- 
> 2.20.1
> 
> 

