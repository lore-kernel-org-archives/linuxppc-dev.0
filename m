Return-Path: <linuxppc-dev+bounces-20839-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E60ECD4F24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 08:39:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFn1n2hXqz2xpt;
	Wed, 13 May 2026 18:39:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778661549;
	cv=none; b=blT08mNR/7Vg5QVH0T4Y6Gme/HLYHzxKwba9ao+3dl46HCOBUSYwBuuB+uFQ5bA4UrOFNDusqRgLBz6ImOBN2fkSeu8hn9YntjWlIwcStnZksngFxvpZzCJ77eBjz3wye6za35KDQngNQqfXQ08rkp9PIUeEtcVAHxxEWU3pStIqGke04+g50VlxMfUWgjfudiN2OuXn6DBKxB1hVYVL3bg5FWGTHCZ3QW14PZVywxdzV7Ahfg6eaw66fSevgP4HedTJPEqzEy7eC3ylRckcmXgKh8PULch5oujLYMNwQBbmbhYjXFpN6VutIjmV/xs2Xnuy4T58sGxhhkQmvUJHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778661549; c=relaxed/relaxed;
	bh=9fVaLKvJlkGuL0KZ6ciDHgUX0KlxSF3IahtcRNvgMz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJqGiA8QixAgsgnkLE18CqdNEsPag9nWM80VU7AFV+fobd6K6qkEMMN3mnagFnUefLE/kD6ASsD7oEgc1x4cN2jYM2uOqoWKO/3iqha7IwL1kJl9iDSS+Isi9uGE70ZPhxEQO26RgwzQh/ltbnF56+QzeIw3ZfeCYXgf7LXt3XJDQwtHNlN32QKatK56x/7Lpx9dOiQcm9mKJRpIqnN9BF1fF0vlTQdXZTwN8FthtBb7Uf33rMq75+K6YInoiXl3qFhAOAVJH9v2k7IzqVyMPcRXmJ7WMO9XRFgkxd+6pmqTkCjaRt/19ms9wmZE4sHMLfoB0AOYqm3YJYeWizr5mw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=i5o2b94C; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=i5o2b94C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFn1m4DqYz2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 18:39:08 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B13DF40545;
	Wed, 13 May 2026 08:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C496EC2BCB7;
	Wed, 13 May 2026 08:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778661546;
	bh=A+alEkVbDEYYLkoEGrsz9cm8DsNiefv/WIMetnJZ4aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5o2b94CuXzH2xo1vE/DUzE4IguK5/np+Jsb57LZ3NB3zL8hSI80f7ACMbgEeHtAP
	 qV9dcRBrrPGWTvrCfK3ozf6Q/Nh4quN4g1L//ckWLJ5IZBF9wcexyyeHeoSRxNtPFH
	 5N9yNX4d6ez9CMAHkKOf9Q8JiXvXQhoxZZdpf8TvK+Byg36ZnOCAuDu9QuNuCfrEwH
	 Qm78NZa6NaXCcHKglUgtQMONd4VPk8qQQ87YzAm64xITK4kwsanSFW8xhr76ovDxnp
	 r4CIUxQc9Mt49yJ2jK7gSCRV3umP23VsjLZA5UF5Ta5xnIWTZ1tKagj3rn4mhxaYzQ
	 HWhG0Vzd8dUdQ==
Date: Wed, 13 May 2026 11:38:56 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 6/8] mm/bootmem_info: stop marking mem_section_usage as
 MIX_SECTION_INFO
Message-ID: <agQ4oL4pKP0D51gn@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-6-3fb0be6fc688@kernel.org>
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
In-Reply-To: <20260511-bootmem_info_prep-v1-6-3fb0be6fc688@kernel.org>

On Mon, May 11, 2026 at 04:05:34PM +0200, David Hildenbrand (Arm) wrote:
> We never free the ms->usage data for boot memory sections (see
> section_deactivate()). And to identify whether ms->usage was allocated
> from memblock, we simply identify it by looking at PG_reserved.
> 
> Consequently, there is no need to mark ms->usage as MIX_SECTION_INFO.
> Let's just stop doing that.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/bootmem_info.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> index cce1d560f094..0fa78db7fbc0 100644
> --- a/mm/bootmem_info.c
> +++ b/mm/bootmem_info.c
> @@ -38,10 +38,8 @@ void put_page_bootmem(struct page *page)
>  
>  static void __init register_page_bootmem_info_section(unsigned long start_pfn)
>  {
> -	unsigned long mapsize, section_nr, i;
> +	unsigned long section_nr;
>  	struct mem_section *ms;
> -	struct mem_section_usage *usage;
> -	struct page *page;
>  
>  	start_pfn = SECTION_ALIGN_DOWN(start_pfn);
>  	section_nr = pfn_to_section_nr(start_pfn);
> @@ -50,14 +48,6 @@ static void __init register_page_bootmem_info_section(unsigned long start_pfn)
>  	if (!preinited_vmemmap_section(ms))
>  		register_page_bootmem_memmap(section_nr, pfn_to_page(start_pfn),
>  					     PAGES_PER_SECTION);
> -
> -	usage = ms->usage;
> -	page = virt_to_page(usage);
> -
> -	mapsize = PAGE_ALIGN(mem_section_usage_size()) >> PAGE_SHIFT;
> -
> -	for (i = 0; i < mapsize; i++, page++)
> -		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);
>  }
>  
>  void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
> 
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

