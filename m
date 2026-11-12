Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C27606A321
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXSfiJSW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQJXm18Z6z2xLs;
	Thu, 12 Nov 2026 22:47:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794484056;
	cv=none; b=oMRrpBNBjZ97a/wLoyp1+yH9pr6mqKQZ+6J9OXG6Fhfl0mSw+Rv+pX7jjeyIDJvsA29GOkSGnY+SIYwdQlqf7WbrDr3W82XruLbKEL1KEMTCpygbA4WZM2srCKrrbg1pkM353Hv9gLskPD7I9RbNE0EvyWkNO5aAb2LbaP6F9iSDV3QOuoRd2MTQAiWzmKEQZuIm+PX5xwrNkqn6pWEYIrP9OoQadcrgY8zFiMBZnTVZs/LsHq49nKKhg/I5fx81KPAMYV1l7OeCMa/E/OUbRhSrDI0IeuBCkH5y+WGT6B4o67fO4dL8fTCoz5t4ZykZl5VNx7HEdYdsV2iYTyjj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794484056; c=relaxed/relaxed;
	bh=vM+TmZTTVlgAseJteA04V2b5gZJJ/nPwoEE1QOkg22k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3QYn+qk/e+gQrckqDtJMYmZ99wp+BEFH/f8XnYEp6nnvdSx2AOayc1nYpFOzV2U01V8dN+soFij4yQWiQ3UlIiBPWnAAq8aEgHZxkMapSo5ghSyiGr5LoPOD+NLpDRNIndzzxwCAVS+J8IItvrpZ54zyFUgxI5DwI1rr2RWbpV+7RrcRI100XmbkjcS7ju2ZaDijBnfq6QPCrAH0ZyRJRH1JmW0csG2LwquWvuGNbcZq4A72KTsSY1czwCmh9rbCvPHs2mWeL+SCTvn7Kh+8WNt0ffHjrmeAPOWochFdSRpRQUXi4QPrDi2Ve4gPNFCEniX+1qOCI15vP13co9/zA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXSfiJSW; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXSfiJSW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQJXk6XDtz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 22:47:34 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 80E236121E;
	Thu, 12 Nov 2026 11:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D011A1F00A05;
	Thu, 12 Nov 2026 11:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484052;
	bh=vM+TmZTTVlgAseJteA04V2b5gZJJ/nPwoEE1QOkg22k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QXSfiJSWVRJXBEP0SekW5iZErSus3IhESAmYYSoJ6gFHXzQa0SEJVUdZvq5ukRZDB
	 zIPjxW4etzEDjGqnuJfKbNVNZxoFMvzhZDS9m81YSp76lOMl2N4adQE3QXfqhBMfvA
	 9l5NsWktPRODSt3io3E2kVXyTOFCfLLIH6vAn1opAIncFXGuHBQ6cxmjLB2/4yrd/K
	 8UPGjOH77gUkh2AZC4I0bJ+fOkkAs2wHOmfKqa1zHKPt6SB7Ec0zuKXHtEtOnpQS1O
	 7Akv52un3uHhlY5kipQTVVs4WyWo7GPo7w0EOGpELT6Sn1Y9ieNLHwwZ5DbqObaFtC
	 55nWb1rCIF09g==
Date: Thu, 12 Nov 2026 13:47:23 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Malin Jonsson <malin.jonsson@est.tech>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 3/6] ARM: drop CONFIG_HIGHPTE support
Message-ID: <avWnS7MLyPaJLaLR@kernel.org>
References: <20261112112528.1116405-1-arnd@kernel.org>
 <20261112112528.1116405-4-arnd@kernel.org>
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
In-Reply-To: <20261112112528.1116405-4-arnd@kernel.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 12:25:25PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> CONFIG_HIGHPTE was added in linux-2.6.32, a few years before 64-bit
> support. At the time it made sense, as the CONFIG_ARM_LPAE option allowed
> systems with 16GB of memory that made lowmem a particularly scarce
> resource, and the HIGHPTE implementation gave feature parity with 32-bit
> x86 and frv machines.
> 
> Since Arm is the last architecture remaining that uses this, and almost
> no 32-bit machines support more than 4GB of RAM, the cost of continuing
> to maintain HIGHPTE seems unjustified, so remove it here to allow
> simplifying the generic page table handling.
> 
> Link: https://lore.kernel.org/lkml/20241204103042.1904639-8-arnd@kernel.org/T/#u
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I sent a patch to drop HIGHPTE support on x86 today, see
> https://lore.kernel.org/lkml/20241210144945.2325330-9-arnd@kernel.org/T/#u
> 
> If that one gets merged, we can merge this one instead of the one
> that makes HIGHPTE depend on !PREEMPT_RT, but if we decide against
> the x86 change, then we probably don't want this one either.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig               | 11 -----------
>  arch/arm/include/asm/pgalloc.h |  8 +-------
>  2 files changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index fd01ccab9c12..fc66d52d847e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1225,17 +1225,6 @@ config HIGHMEM
>  
>  	  If unsure, say n.
>  
> -config HIGHPTE
> -	bool "Allocate 2nd-level pagetables from highmem" if EXPERT
> -	depends on HIGHMEM && !PREEMPT_RT
> -	default y
> -	help
> -	  The VM uses one page of physical memory for each page table.
> -	  For systems with a lot of processes, this can use a lot of
> -	  precious low memory, eventually leading to low memory being
> -	  consumed by page tables.  Setting this option will allow
> -	  user-space 2nd level page tables to reside in high memory.
> -
>  config ARM_PAN
>  	bool "Enable privileged no-access"
>  	depends on MMU
> diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
> index a17f01235c29..ef6cb3e6d179 100644
> --- a/arch/arm/include/asm/pgalloc.h
> +++ b/arch/arm/include/asm/pgalloc.h
> @@ -85,18 +85,12 @@ pte_alloc_one_kernel(struct mm_struct *mm)
>  	return pte;
>  }
>  
> -#ifdef CONFIG_HIGHPTE
> -#define PGTABLE_HIGHMEM __GFP_HIGHMEM
> -#else
> -#define PGTABLE_HIGHMEM 0
> -#endif
> -
>  static inline pgtable_t
>  pte_alloc_one(struct mm_struct *mm)
>  {
>  	struct page *pte;
>  
> -	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM);
> +	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER);
>  	if (!pte)
>  		return NULL;
>  	if (!PageHighMem(pte))

With HIGHPTE out this can be 

	if (pte)
		clean_pte_table(pte);

	return pte;

Otherwise

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>


> -- 
> 2.53.0
> 

-- 
Sincerely yours,
Mike.

