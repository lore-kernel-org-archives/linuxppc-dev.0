Return-Path: <linuxppc-dev+bounces-19380-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC23F3D5E2
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 13:35:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpYNq0g3Rz2ybQ;
	Sun, 05 Apr 2026 23:35:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775396107;
	cv=none; b=f9HL7oCC8W2We+rJinqslAh4kPzk3RpWttbZAjSzudoqap68vwPFa47KyLnhVDDoWlfBC1r+ShnmAD+dyqt1/AkodqZDBn29wpN/CshZIxKQuU5OfIV5KlppeBY+8agbeUmz8NyWTKT+6M5ritFL+EF/B0cdC7Tr1eP1/emyb9ONLEKQwrhIxN8pNWv4IPsZpIaacfAgiGC8j7Zx3ubQVYaiUgf1eWsswx4/GwlgmS2CEgotjUmz0FXxcYH6FatR4HGPC2WA5JvrFkU1fOSClwrjkS+nqN1gdf+Q0ZGNYLQhKk0EC97U9SxIgVuW+lravxvzYc7gbA1JOibRUoRHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775396107; c=relaxed/relaxed;
	bh=OZnLqiy0PDzfsPBn4zElMS+mzPT4ewPLQH6Ie9yANQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAwF3nVRS4Fp2wSMXfRqxzDX3DxMc/oKu8TPc5Uh+zxIZawpVPHIHkbusiKoIZl/+xlPPdFgRwb5DSvF0OSe8Tpabr/XC4Ao2IeuVSvaAg/D1nJswfDf5jaRKcrQU+rkGcXmHVLhM7sBe2LSEW7fdhtMZMLObZo4Fz4Etimm8+wxJCDun0q9159k9/EuhjCHUeXWD0DDnIYnwPKA7eLxYQUfk7j9WOsicpDN0EJHOWX+7wTGiuCHDYw7FHMvbjOf/gwbAVr56ETJhow9vXB4NSvJkMvTumaRey7Em6Mx38Lqe8LIEusnfhKNREzVLCKejMG597y8l4N4BW1usl7t2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JsuR22bB; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JsuR22bB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpYNn6hv0z2xSG
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 23:35:05 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B24FF6001A;
	Sun,  5 Apr 2026 13:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01887C116C6;
	Sun,  5 Apr 2026 13:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775396102;
	bh=WWuKH7V5NGGgAcGyGGVsYW3h6302QQpGr0/S5xsirPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JsuR22bBOjH3ft1M/WUeMEYQAF6hTu5hn2tzOUD3fMIgLiO98o1NHa9qvmyC0jTqW
	 sbe+mCcRvf+TA5onjzDvEDuf50nLBngm414f0zKX+a8LOQt0ODkU1gsw3Ocz0QRZ7h
	 7w3BsUG3WcylXg33DrqbyD0s94LPdvyCHXIsNddWSFPDM8WQqOKwwZBqpd6yI/1pVo
	 d4Trlon650nrHqNIoA+M9we70iiCUab6u+0TayT8VqdgXNAs33scs5kHK5as06c2CL
	 eJPPYetGQNp+OsrDK9Q3fQj5DZ7OK2esPexzi1MFaTcenmV438ealYjg5I5AWH9h5M
	 7cOqG8pKzar4Q==
Date: Sun, 5 Apr 2026 16:34:53 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/49] mm: Generalize vmemmap optimization for DAX and
 HugeTLB
Message-ID: <adJk_W5dA5YRcxOA@kernel.org>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
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
In-Reply-To: <20260405125240.2558577-1-songmuchun@bytedance.com>

Hi Muchun,

On Sun, Apr 05, 2026 at 08:51:51PM +0800, Muchun Song wrote:
> Overview:
> This patch series generalizes the HugeTLB Vmemmap Optimization (HVO)
> into a generic vmemmap optimization framework that can be used by both
> HugeTLB and DAX.
> 
> Background:
> Currently, the vmemmap optimization feature is highly coupled with
> HugeTLB. However, DAX also has similar requirements for optimizing vmemmap
> pages to save memory. The current implementation has separate vmemmap
> optimization paths for HugeTLB and DAX, leading to duplicated logic,
> complex initialization sequences, and architecture-specific flags.
> 
> Implementation:
> This series breaks down the optimization into a generic framework:
> - Patch 1-6: Fix bugs related to sparse vmemmap initialization and DAX.
> - Patch 7-13: Refactor the existing sparse vmemmap initialization.
> - Patch 14-26: Decouple the vmemmap optimization from HugeTLB and
>   introduce generic optimization macros and functions.
> - Patch 27-39: Switch HugeTLB and DAX to use the generic framework.
> - Patch 40-49: Clean up the old HVO-specific code and simplify it.
> 
> Benifit:
> - When CONFIG_DEFERRED_STRUCT_PAGE_INIT is disabled, all struct pages
>   utilizing HVO (HugeTLB Vmemmap Optimization) skip initialization in
>   memmap_init, significantly accelerating boot times.
> - All architectures supporting HVO benefit from the optimizations 
>   provided by SPARSEMEM_VMEMMAP_PREINIT without requiring 
>   architecture-specific adaptations.
> - Device DAX struct page savings are further improved, saving an 
>   additional 4KB of struct page memory for every 2MB huge page.
> - Vmemmap tail pages used for Device DAX shared mappings are changed 
>   from read-write to read-only, enhancing system security.
> - HugeTLB and Device DAX now share a unified vmemmap optimization 
>   framework, reducing long-term maintenance overhead.

This looks very interesting ...
 
>  32 files changed, 513 insertions(+), 1197 deletions(-)

... and nicely cleaning up things.

This series is high on my TODO list, but most likely I won't have time for
proper review until after -rc1.

-- 
Sincerely yours,
Mike.

