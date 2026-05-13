Return-Path: <linuxppc-dev+bounces-20841-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD11ECD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 08:41:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFn4w2YBWz2xpt;
	Wed, 13 May 2026 18:41:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778661712;
	cv=none; b=nrQG+k5N+pQ7evFR+C5nIX498PjhR+D0bxvEq0sPqT4Ut/XU9sEWFBeD3sbXURtWAWiWQIYXQ4M6Qnp6iJcMMwMVDYBbWsq15uxmDWI29IeZXKdystZzO1s8H08PRsr1SA9FNwz65uk42hcDbRkP31zuBzr1S/K6JuaelDUxwO+Chj3BPTr6kQWhax9dydiPOKLX2X6S/napKngj7Kj2oZraMK2Kg9r/WM6fPH40BlulYQa8gkAmj9DHweNKGK+TCZFWoJFRiGq58Gm2cZpEdB7vPbMUJkq4FOTrQQPVmDmHICG7QJ05K4Yta9Ynewv2CChj+AhP82QYXZQ+dQGRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778661712; c=relaxed/relaxed;
	bh=2C3fKVu8ZecWuoJ3nOe6Vz6QaIlyNcNPEBJ1uLO+ojw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cz8V9Ol/SrchNDTvrHbfcTIVIF+qlzvd+fkk+O7DTglnI/TLfPpHbV9O6Xkuua6SvksufegU9vou7OXM38ROMr2oJE1E0LOiApK4zhlMCBufnpPctqPKW4a1n5tNJGS/Whg6cSfKWVqI7r+2B6w12C0eY9N1vH2XpVAWd3Y56vsbbIr8xakfxweCiba2KUL+TqqZloQFtskz4wjspoAG2WZHgIUO2fyzqzMkRDiSHPNSuHOWNpcV5TWZPAaK4WUYvfQCWg7CycG0v3GfmrSBycEZTjmqDAV2mM0IGmXu4AepeqU/ZkDY7W/D8kKCIHkTXMTjGsdsnkhbPnCcfi2cFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gF1ZrZh2; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gF1ZrZh2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFn4v2WR4z2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 18:41:51 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1DE2C600CB;
	Wed, 13 May 2026 08:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B4BC2BCB7;
	Wed, 13 May 2026 08:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778661708;
	bh=G5ge1Ms5w5w/WOlbzkIN+oCsjgnKKihgDEBHNY+4t84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gF1ZrZh2z0PfjXk/JaTiWJN3Zwq9n1yXdLYSwGgtH/UbaPGBeI1PqTFOWu+uw2fmv
	 Lz2BCj9WAqFkC5+okdC8bt8qsrUwRjoGCTtmIVx421M+sYpp/fzlPQ7U3GqhFJxpOL
	 eWQd+iFykyLefV4HtfewUidnx08Bm8oy069QupPbc0Cg/FoRNW1zMl/3q4Yz+fXTYT
	 9aWTDk2zqKWoB77yQ/FdvQ853sm5qE3FID4NnDWBftlpdWIXTHmYe6kyq1pbxwW53C
	 BpnQCY6u/QtkKHB4t28Ckn7ckSQVCqHqbbhViJQ80UnY04G7AA9ybc8FL5okBUdu1l
	 vjNSlJ6SsWKUg==
Date: Wed, 13 May 2026 11:41:37 +0300
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
Subject: Re: [PATCH 8/8] powerpc/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE
Message-ID: <agQ5QVEyMsEcKbxa@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-8-3fb0be6fc688@kernel.org>
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
In-Reply-To: <20260511-bootmem_info_prep-v1-8-3fb0be6fc688@kernel.org>

On Mon, May 11, 2026 at 04:05:36PM +0200, David Hildenbrand (Arm) wrote:
> register_page_bootmem_info_node() essentially only calls
> register_page_bootmem_memmap(). However, on powerpc that function is a
> nop. So there is not benefit in using CONFIG_HAVE_BOOTMEM_INFO_NODE
> anymore, let's just drop it.
> 
> We can stop including bootmem_info.h.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  arch/powerpc/mm/init_64.c | 8 --------
>  mm/Kconfig                | 2 +-
>  2 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index b6f3ae03ca9e..64f0df5bb5cd 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -41,7 +41,6 @@
>  #include <linux/libfdt.h>
>  #include <linux/memremap.h>
>  #include <linux/memory.h>
> -#include <linux/bootmem_info.h>
>  
>  #include <asm/pgalloc.h>
>  #include <asm/page.h>
> @@ -388,13 +387,6 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
>  
>  #endif
>  
> -#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
> -void register_page_bootmem_memmap(unsigned long section_nr,
> -				  struct page *start_page, unsigned long size)
> -{
> -}
> -#endif /* CONFIG_HAVE_BOOTMEM_INFO_NODE */
> -
>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>  
>  #ifdef CONFIG_PPC_BOOK3S_64
> diff --git a/mm/Kconfig b/mm/Kconfig
> index e221fa1dc54d..97b079372325 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -537,7 +537,7 @@ endchoice
>  
>  config MEMORY_HOTREMOVE
>  	bool "Allow for memory hot remove"
> -	select HAVE_BOOTMEM_INFO_NODE if (X86_64 || PPC64)
> +	select HAVE_BOOTMEM_INFO_NODE if X86_64
>  	depends on MEMORY_HOTPLUG
>  	select MIGRATION
>  
> 
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

