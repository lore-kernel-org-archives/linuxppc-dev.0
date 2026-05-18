Return-Path: <linuxppc-dev+bounces-21071-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C17BCD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 07:33:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJqL15v4Xz3c6c;
	Mon, 18 May 2026 17:33:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779085987;
	cv=none; b=KCbNnQsLDRbAekjIkDNOvgtCPpwNdLIwfZItls5hwRrmUlpAO/qgmDA5NPWprkvS/KE481DevNF2EhnhTrW9AUSdyK3EvyuG8g5/hmPrRpYmvLnMv5iraa9u7Q4vCnefetO1m+XsOz58n163K8lrSgV2oai3nTnqos6Ci0/KdqcecVsbf5w/t2cAvP80Z4zfjuvTRbInZ/pmiyIpeTs5bi3LsAJ7Ve4LkMeDYOUGNFpqoz+k5luXzffguszCWLh3a2rZ5tLlyya14iFtrsTXSkXs1FOAI4fTSuJHr3jqjHuuPE601up8FjKoao/esiZxAJRCBujDIg6mZd6oyLiurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779085987; c=relaxed/relaxed;
	bh=8hoVVQX5GGfVZM3bJC5rTA6C0DO6UtYhorjVBYvKY9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJhorju2+YCrzOWjXChNsZ2x7gcn5NpmKX3K1HQJzkqZ0D9YY+uxh0MDcU1nQRtY7AK0WlZeGtfhcTztFiEPWq0X9j93+Z/Hwk7NzJ43521p4RsAvNGjUvOnd2dg/YrIRJoOXN9nQRKBLgJ1MUqEO3zQ2H7DAfG+B9tA2ypgokziF2uRNWOT/NP0ngLth3FjgfVn7GxMqpR0Y9/X6R6eTmcxr+sBqlk8IGsZDKxglbTy0NRRAemdjVyOlW3lIbrbojC8cysk3rOPrwC6flLtbfKOX8OB0njRMK9QhULQU6HPmOYUyZ6Cpa0zZij116Tetv7QGsqj7IBz6xWnezxgjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=A3vbnwtY; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=A3vbnwtY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJp025j1Vz2xd2
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 16:33:06 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 73A3C60125;
	Mon, 18 May 2026 06:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D55C2BCB7;
	Mon, 18 May 2026 06:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779085984;
	bh=S2sClfE94ut5IkvWCJnZ59x+EGHZ68WYDg9Kv6DqmJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A3vbnwtY1jjob8OB+9vfc+m48DDecf8TZJhaI+N4f3RrrLwJHp/4Tug1PFa+XpC5F
	 pm2bqTF26qb+29HPgfCbtfimbDEpQ810OrtiD2Ic0aRdx2T+HgPhUZELfT/ucfCXbC
	 0F5Jig/3OUfsNIff63F1zc0Gq0kwYCUK+E+5X7N7eOfZmxW8oRULsyn56z40rP0xLO
	 SKN+6oE2IOuh1dWyBzSx/ULcbvNfyz0hXDpXbs2MNBXKxWKkiD/yIzkfgf9eW+6xi7
	 L7xR4PUvkcTl8FGh/hrjI3nJrsXrUuXalZ9bkPlN+LTFscIRfEaDPDJsn8gmRGCHRy
	 T64q9br6Bv4Fg==
Date: Mon, 18 May 2026 08:32:53 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
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
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/69] mm/mm_init: Defer sparse_init() until after
 zone initialization
Message-ID: <agqylYzVJIz-81GL@localhost.localdomain>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-9-songmuchun@bytedance.com>
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
In-Reply-To: <20260513130542.35604-9-songmuchun@bytedance.com>

On Wed, May 13, 2026 at 09:04:36PM +0800, Muchun Song wrote:
> free_area_init() is responsible for initializing pgdat and zone state.
> Calling sparse_init() from there mixes in later vmemmap and struct page
> setup, which makes the initialization flow less clear.
> 
> Defer sparse_init(), sparse_vmemmap_init_nid_late(), and memmap_init()
> until after free_area_init() completes, when zone initialization is fully
> done. This keeps free_area_init() focused on zone setup and ensures that
> sparse_init() runs with the relevant zone state already available.
> 
> This is also a prerequisite for later hugetlb vmemmap changes that need
> zone information during early sparse vmemmap setup.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

> ---
> v1->v2:
> - Restore the set_pageblock_order() change suggested by Mike Rapoport
> - Add Mike Rapoport's Reviewed-by
> ---
>  mm/mm_init.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 12fe21c4e26c..c14491c2dad3 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1826,7 +1826,6 @@ static void __init free_area_init(void)
>  	bool descending;
>  
>  	arch_zone_limits_init(max_zone_pfn);
> -	sparse_init();
>  
>  	start_pfn = PHYS_PFN(memblock_start_of_DRAM());
>  	descending = arch_has_descending_max_zone_pfns();
> @@ -1915,11 +1914,7 @@ static void __init free_area_init(void)
>  		}
>  	}
>  
> -	for_each_node_state(nid, N_MEMORY)
> -		sparse_vmemmap_init_nid_late(nid);
> -
>  	calc_nr_kernel_pages();
> -	memmap_init();
>  
>  	/* disable hash distribution for systems with a single node */
>  	fixup_hashdist();
> @@ -2691,10 +2686,17 @@ void __init __weak mem_init(void)
>  
>  void __init mm_core_init_early(void)
>  {
> +	int nid;
> +
>  	hugetlb_cma_reserve();
>  	hugetlb_bootmem_alloc();
>  
>  	free_area_init();
> +
> +	sparse_init();
> +	for_each_node_state(nid, N_MEMORY)
> +		sparse_vmemmap_init_nid_late(nid);
> +	memmap_init();
>  }
>  
>  /*
> -- 
> 2.54.0
> 

-- 
Oscar Salvador
SUSE Labs

