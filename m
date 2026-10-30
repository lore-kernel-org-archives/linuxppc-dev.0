Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF97606A320
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1GRqgVU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGKsd3rg7z30Vd;
	Fri, 30 Oct 2026 23:19:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793362773;
	cv=none; b=fH1STZ+YulKhQw+IKeDOyPecg2gv4o5RdABptOYSnDRLALWU4jU626wJR1NhV1PYlzxGWtGDSww9eHxQwTQhwQrlOac6Kmf4+2Up5GtQuE2Q5TqD6CUA3LcFWbKZYhB95rOJsVdwPheYc/u0AEZ2k5fx5k6TqDXHPC4t1ddHgLtJsXlTggP7MKwSIS6gUUgtglO7FmiqrzmR7RYjBWXu/i8YbYHvSNDMXbIUxEdDVAEIAkVZze7S3vrhOH2K4byWnOJBIxvGBWB2FORgxux0Fv/JtWHJEfW1nKdsC8eEjpOWIsEHa1ChVSPJfyS1LBs7sXuN9wJw9wup8La40hxx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793362773; c=relaxed/relaxed;
	bh=pEOu/AQvgU0OKb5AZqRCUfaOk8gDp8NvYhcCjCvB5JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gs5fbeRoOJU+hsQzLv6Pr73Uwq6Xk3SDphvJuOMLWyGYOXLL/sFDzFdHvC5bZBxbV0LKXW4R8cEJ5oRTt0EHXgxRQ+iTb132RvNH8RX+4D11wFnkzrnIht7J1IOlwkFzyM9QI0gTi4sSFFO4Wnahdp0fuaodtDsWJmlpI9+GtIfW8rAVIxXhx2nIGpY9Quf/5O4NBjKwvZo72vsddw+Yfh0NBocjAEy5rDi+9WO7QOF0IP8Xf75bvUIxJCDLeMZQGYn73mtADt1qg001LehRebXohMRJKL3/c0/4mzEYcDG2Vx9vY1MyASfMx33Rv2wtyECZGPRNgcgjKgEtP68g8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1GRqgVU; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1GRqgVU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGKsc4kPBz30C6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 23:19:32 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3DDE7601EE;
	Fri, 30 Oct 2026 12:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBC11F000C1;
	Fri, 30 Oct 2026 12:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793362768;
	bh=pEOu/AQvgU0OKb5AZqRCUfaOk8gDp8NvYhcCjCvB5JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z1GRqgVU4WIj2ovDw33wHVQ50+wcmPd8/iVAG4of6NAt3Rr/AR7PDuT4d8fAQTMtU
	 wXSiDpUBRzGwYOqpuW+G8+Owc6KG88nWoM0t0B9s2tP9+OeTyS8Peqtp9md0yYQYvP
	 d7Q0dFsYSX/Wu1Gd0vyfD8cIc4sNL96m2fr8q7Tr6vc2TlNNvgMPQVwhPnAPZ2qgNy
	 9GdRSJFsFof5PtAPP8aa93iHTxTmUTpJT5ygcEksnW7AFb+PSD7rnPpu9om4ZLsKKj
	 bUNOC/W6HS4UoE600ZsgdUDzGm0y+xdV/sXbDBY2EmdQW1XOZ93Cn2O45iEB5tNixz
	 aN1QY4oHSWwlw==
Date: Fri, 30 Oct 2026 14:19:20 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Pavithra <pavrampu@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/mm: fix uninitialized ZONE_DEVICE struct
 pages with PMDs
Message-ID: <auSLSIwUi2xNIYua@kernel.org>
References: <20261030115326.1005755-1-songmuchun@bytedance.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030115326.1005755-1-songmuchun@bytedance.com>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 07:53:25PM +0800, Muchun Song wrote:
> PowerPC radix vmemmap population can reuse an existing PMD mapping for
> a device DAX range marked HVO-enabled. The reused mapping is ordinary:
> its tail struct pages are not remapped to the shared tail page.
> 
> Leaving the section marked HVO-enabled makes memmap_init_zone_device()
> treat the range as optimized and skip initializing real tail struct pages
> that remain in use. This first triggers a zone mismatch warning, then
> faults while initializing the pageblock flags:
> 
>   WARNING: mm/mm_init.c:600 at __init_single_page+0xd0/0xf4
>   Call Trace:
>     memmap_init_zone_device+0x164/0x430
>     memremap_pages+0x43c/0x93c
>     devm_memremap_pages+0x3c/0xa4
>     dev_dax_probe+0x264/0x3d0
>     dax_bus_probe+0x140/0x1c8
> 
>   BUG: Kernel NULL pointer dereference on read at 0x00001400
>     __set_pfnblock_flags_mask.constprop.0+0x34/0x160
>     memmap_init_zone_device+0x358/0x430
> 
> Without these diagnostics, the uninitialized metadata remains latent until
> userspace accesses the device DAX range and triggers a later panic.
> 
> Mark the section non-HVO when reusing a PMD mapping so its state matches
> the actual vmemmap layout and core ZONE_DEVICE code initializes all real
> struct pages.
> 
> The Fixes target predates the section-based vmemmap optimization
> infrastructure, so this patch cannot be applied directly to some older
> kernels. Older kernels instead need to pass the vmemmap bounds to a
> range-aware vmemmap_can_optimize() and reject optimization on PowerPC if
> a PMD leaf overlaps the range. This reuses the existing mapping normally
> and makes core ZONE_DEVICE code initialize all real tail entries.
> 
> Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
> Cc: <stable@vger.kernel.org> # see patch description, needs a different fix for <= 7.3
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reported-by: Pavithra <pavrampu@linux.ibm.com>
> Closes: https://lore.kernel.org/r/97f85592bb78a273be8519e6897e7f9b9bd31469.1793070429.git.ritesh.list@gmail.com
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Tested-by: Pavithra Prakash <pavrampu@linux.ibm.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> v2:
> - Rewrite the commit message.
> - Describe the range-aware vmemmap_can_optimize() fix for older kernels
> - Note that kernels through v7.3 require a different stable fix
>   (suggested by Ritesh Harjani)
> - Collect Tested-by from Pavithra Prakash
> ---
>  arch/powerpc/mm/book3s64/radix_pgtable.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
> index 44868b62b14e..4f75f10ed68f 100644
> --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> @@ -1261,7 +1261,16 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
>  			return -ENOMEM;
>  
>  		if (pmd_leaf(READ_ONCE(*pmd))) {
> -			/* existing huge mapping. Skip the range */
> +			unsigned long addr_pfn = page_to_pfn((struct page *)addr);
> +			struct mem_section *ms = __pfn_to_section(addr_pfn);
> +
> +			/*
> +			 * Existing PMD mappings can cover the edges of a valid
> +			 * HVO populate range. They are ordinary vmemmap mappings,
> +			 * so the current section must not be treated as HVO-backed
> +			 * when its struct pages are initialized later.
> +			 */
> +			section_set_compound_order(ms, 0);
>  			next = pmd_addr_end(addr, end);
>  			continue;
>  		}
> 
> base-commit: d865f2677c44cb2171b833d6775cf692756fa8be
> -- 
> 2.54.0
> 

-- 
Sincerely yours,
Mike.

