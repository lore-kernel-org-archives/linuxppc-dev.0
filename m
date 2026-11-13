Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929B9606A880
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZKwDank
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR5xV6KhTz2xP9;
	Sat, 14 Nov 2026 05:53:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794595998;
	cv=none; b=eHOyqpF43lAcLwDUGfaQsZk+PI0aq2r2FKb5wqEkvosD/gQCL8w1ZLEFPiarD0nLP5jN04LB/1KPFRkbkURm+yp0jSMPrJU7Hi2ADyP5vxM5uJN/x2Nbl681kSladAtkNByb8kS4PAnG27gEDertbJR/cO+tdqLXvoVoQOPII5tQrgydpE52HpOnWbe3ZLmDSunN6/PPBwb9Qus8nKrIQSJxhArfSGNefplJ8q8mxl64djjkTTmntAEvDFc3nfGX/+JWmC0hdDQym7bcMRdr05zp4lwTCeI35MEnycl0eWRLj7KmiTjHFcubGxypRdPHiV9R0ZLSbXfZfQGOabIGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794595998; c=relaxed/relaxed;
	bh=6DABqvPmRZQ9oUhOgSWnNOl71UnHng1Nk40a2Wv2ZOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7ni9UI4skpvnKEizIS4NyPl0cPodSyWCe4YDtKAKdy/Lhg2e1QMpx0T1uevPTbh0Wk1hBz5uuS/r19Sl/t5Q35pKLaCeEYOL2kIkUNnlNacXfE5tVMKbRFUUw5NZFA9nRIcz4AOfIfL2u6fnXZvV74S41B4784q0fMhp60sW8O+7SmlkdphZLos+Gw7KBimj2Xxl8IAvjWEezhiUQvwL5GmiSFlWWyAzUQJTQuqn8F8E1RfsjYK9AZxTVZd7TqPjw3qP8un7cjP+GpkK7K3G5Ko5ff3yTphyTvsAFCjYDjPnWe2R/7QUxKfIPWSXZ52O2MHAWCwLJSVGXGoNFFu6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZKwDank; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZKwDank;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR5xV0Clhz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 05:53:17 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4674140822;
	Fri, 13 Nov 2026 18:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62B11F000C4;
	Fri, 13 Nov 2026 18:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794595996;
	bh=6DABqvPmRZQ9oUhOgSWnNOl71UnHng1Nk40a2Wv2ZOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VZKwDankvfuzex2kRsuuyuqHtFOBDmCaX+0WDxsKL/ouO87kgLIB3xb7y6yOm/l4j
	 S2Hzsy3SFJbSAfPNpN5/WCPjXE7lb2e5myi9k1xiqxrHzc763+i64zEJqAuEDsEm7w
	 uMkCEgAbD+8ekgjG4FklqyNU/1b5rvooVJAA1POv4y6HUtbiYHEgQgYDgPoAc+m9Hh
	 ToYoOlC742wO+lulBmOy7vDZnkmacJKxLOREhis/Tt2axILXyzJPa3zG9ixS/CXFAV
	 XBAzB3tDKbseqSfaR/otntCp+rYZDrvbMx/fIiAxtDqSI8W93FtHmyJCo6VYd9sBQy
	 zC+gw78C8+jvw==
Date: Fri, 13 Nov 2026 18:53:09 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Andreas Larsson <andreas@gaisler.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Matthew Wilcox <willy@infradead.org>, 
	Malin Jonsson <malin.jonsson@est.tech>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 4/6] mm: drop HIGHPTE support altogether
Message-ID: <avdciuic3FAy6evm@gremlin>
References: <20261112112528.1116405-1-arnd@kernel.org>
 <20261112112528.1116405-5-arnd@kernel.org>
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
In-Reply-To: <20261112112528.1116405-5-arnd@kernel.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 12:25:26PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> With both x86 and arm having dropped CONFIG_HIGHPTE support, no
> architecture is left using it, so remove the remnants in common code.
>
> It is likely that further cleanups are possible in the page table
> code but those are not obvious from the config options.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

LGTM assuming Mike's changes :)

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/hugetlb.h | 5 +----
>  include/linux/mm.h      | 1 -
>  include/linux/pgtable.h | 9 ---------
>  3 files changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 58f755e70e96..7c6d191fdf50 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -178,7 +178,6 @@ void hugetlb_bootmem_set_nodes(void);
>
>  /* arch callbacks */
>
> -#ifndef CONFIG_HIGHPTE
>  /*
>   * pte_offset_huge() and pte_alloc_huge() are helpers for those architectures
>   * which may go down to the lowest PTE level in their huge_pte_offset() and
> @@ -193,7 +192,6 @@ static inline pte_t *pte_alloc_huge(struct mm_struct *mm, pmd_t *pmd,
>  {
>  	return pte_alloc(mm, pmd) ? NULL : pte_offset_huge(pmd, address);
>  }
> -#endif
>
>  pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unsigned long addr, unsigned long sz);
> @@ -1047,9 +1045,8 @@ static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
>  	 */
>  	if (size >= PUD_SIZE)
>  		return pud_lockptr(mm, (pud_t *) pte);
> -	else if (size >= PMD_SIZE || IS_ENABLED(CONFIG_HIGHPTE))
> +	else if (size >= PMD_SIZE)
>  		return pmd_lockptr(mm, (pmd_t *) pte);
> -	/* pte_alloc_huge() only applies with !CONFIG_HIGHPTE */
>  	return ptep_lockptr(mm, pte);
>  }
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6af3b7008f1a..019de55bd796 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4025,7 +4025,6 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
>
>  static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
>  {
> -	BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
>  	BUILD_BUG_ON(MAX_PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE);
>  	return ptlock_ptr(virt_to_ptdesc(pte));
>  }
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 780fe849ff8b..1352b4cee7ae 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -100,14 +100,6 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
>  #define pte_offset_kernel pte_offset_kernel
>  #endif
>
> -#ifdef CONFIG_HIGHPTE
> -#define __pte_map(pmd, address) \
> -	((pte_t *)kmap_local_page(pmd_page(*(pmd))) + pte_index((address)))
> -#define pte_unmap(pte)	do {	\
> -	kunmap_local((pte));	\
> -	rcu_read_unlock();	\
> -} while (0)
> -#else
>  static inline pte_t *__pte_map(pmd_t *pmd, unsigned long address)
>  {
>  	return pte_offset_kernel(pmd, address);
> @@ -116,7 +108,6 @@ static inline void pte_unmap(pte_t *pte)
>  {
>  	rcu_read_unlock();
>  }
> -#endif
>
>  void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
>
> --
> 2.53.0
>

--
Cheers, Lorenzo

