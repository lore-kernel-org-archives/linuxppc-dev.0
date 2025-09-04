Return-Path: <linuxppc-dev+bounces-11723-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F3ECA1015
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Sep 2025 11:51:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHd9K6vYQz2xnM;
	Thu,  4 Sep 2025 21:51:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756986677;
	cv=none; b=Ety7wQgZ7/Q6iCXo/VMzpdISkcNpQ/yGNhCpNvZPPDp0HZZQutQMCgdrVT0w01RAiaYa5K6gC4YN++aWZgdZI0fKumxiTCKJPcqp2UCOo7bYsuU5bQzpxv55HAKIBMLfyCAR5iypZLQLUT+Qf0WCv2m9zJbTRRSwfGd59l1PGZ5JbBwfvoe+8EW2QUm6Dkl+tD/C0nyW4rJoov5zjn5eqs6BkJHck6sY9ZcJ9iBXwD4cZr9GFJ4V+YtSAjS8KSlA0b6Z5UQjTg5LHE6QIpgMCqbWUsQm0kpPEIYp0oeU8B7U1+4mvDgsShgRsBz/iq1v0PosgRvb19NEr8SGWf5Osg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756986677; c=relaxed/relaxed;
	bh=PaUu8yXIfUVX4+XiuOu2bdl7lNOKQ5Py35yboYhpyqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pb8HwP4LHyp+i9HMKSQsoOmI9p63WDN3g9i92LzUqlnt6Qg4r9NPESYI5wU2yCow3ekEIhpZZXfw7H+RxuN27Q2T3zxE8UdUOzaIdMLlxDizi0uFrY7RN06gqTcdC7gK8WM4jKp90CdnUCdbqY5BnWeDljXHA54xYcaPpFN2sAyZZ2Vk1yGdUeE68ZYZUqPjysisK24ezX8B3kbiqliFUpA6nqlMwwufGbvIohg+ZAqu8MYZxL6ZxYJhEP5k/wC/cmzg4mIsuGow1t8sJyPVzV7rZojQh19ngJzPC6bCQ264NP7bjad2v2+Kj9+kbwNCaCZka890ZayOKeR68nXaEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ONZrZBBC; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ONZrZBBC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cHd9K2XcDz2xlM
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2025 21:51:17 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B905860212;
	Thu,  4 Sep 2025 11:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620D2C4CEF0;
	Thu,  4 Sep 2025 11:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756986674;
	bh=ayu+VFEFtlDXiKEZkYUc99UQyXAFV18iajSKbdBa3uI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ONZrZBBCpuGwxh7arUAFmUebG80sJLxBC4MYYjuLVToYlzCW6RgNeQ07liMrV5F0N
	 s/GiABu8diRs9Wt/8jy4v4GdTRk7UaVeB2bU3bZzobOKQryEy6GqMFzq3t2S1nPhmy
	 MYYXXmjZa+R/jKyVAYEHCunJx2vEG8gVEeWMRqTlPy2r3VPODqu98SYt3INH8q6udv
	 shoDQchLJ25xZPDhxEmUrOQCrsuE8Ft+HRhKOkDAURhrzQw8cQ9kMaWmoI2beur7nq
	 TLvA7seUnmO3BltYWiXoiXISFP+iXNO3ejHGJ8SKbLXn7BVURmvpmM9/uaf0fTxflh
	 /lCPuv3tqRbcA==
Date: Thu, 4 Sep 2025 14:51:06 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org, virtualization@lists.linux.dev,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/7] x86: Stop calling page_address() in free_pages()
Message-ID: <aLl9KneqOYTujcCh@kernel.org>
References: <20250903185921.1785167-1-vishal.moola@gmail.com>
 <20250903185921.1785167-4-vishal.moola@gmail.com>
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
In-Reply-To: <20250903185921.1785167-4-vishal.moola@gmail.com>

On Wed, Sep 03, 2025 at 11:59:17AM -0700, Vishal Moola (Oracle) wrote:
> free_pages() should be used when we only have a virtual address. We
> should call __free_pages() directly on our page instead.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>  arch/x86/mm/init_64.c          | 2 +-
>  arch/x86/platform/efi/memmap.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index b9426fce5f3e..0e4270e20fad 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1031,7 +1031,7 @@ static void __meminit free_pagetable(struct page *page, int order)
>  		free_reserved_pages(page, nr_pages);
>  #endif
>  	} else {
> -		free_pages((unsigned long)page_address(page), order);
> +		__free_pages(page, order);
>  	}
>  }
>  
> diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
> index 061b8ecc71a1..023697c88910 100644
> --- a/arch/x86/platform/efi/memmap.c
> +++ b/arch/x86/platform/efi/memmap.c
> @@ -42,7 +42,7 @@ void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
>  		struct page *p = pfn_to_page(PHYS_PFN(phys));
>  		unsigned int order = get_order(size);
>  
> -		free_pages((unsigned long) page_address(p), order);

Could be just free_pages((unsigned long)phys_to_virt(phys), order), then
the page is not needed at all.

> +		__free_pages(p, order);
>  	}
>  }
>  
> -- 
> 2.51.0
> 
> 

-- 
Sincerely yours,
Mike.

