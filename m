Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD10606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHJ2BmO0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZTJ03bVHz2xwP;
	Thu, 26 Nov 2026 05:49:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795632592;
	cv=none; b=Ejfk7NSci/LdqxYleLfMHLktayD16BSig38VU2moLQnBHKxD1+1No80IMfvVGrejJ+Ll1uOUM9NslHPeyYwBJDDZ4lhur+LkJ7UPZ3Dtdmh0cickFMCWDrcaeIJzBOOJcL3M7eEhFoeKWTjP7QNfvKRJ1geILuAKa2u6vNis09uGAae8xdWQiLSTUKxFFWUW2onhpcT9voa9mdUtRGdwn4veHsulTkmrxPtn6yUXFgGqRpvqH+oq1fY5q4ZZRYkg2gHTeQgk+HoAFwE8eh8ripdU4QERk/Aey/fbLll6s6K3Y861vFedTDtlhUQVc0i2vtez0pdqx47kMdNtaULw4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795632592; c=relaxed/relaxed;
	bh=PM8SzO2FNT5QYTl7e2L6CPSCvxzNzPmQG5xnJtLl3nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHeS4RSxx49SamQiNoTquBJpKBqHc3FaJbPCQwBA/MRLU/DxqOsnbrtbWNIHDeE1eAmVfiJwWbskNHsGqSP0sqaDDb64dpQVoAFLOx4WohaexiutyO/M6IJj6qCe+zMbcAIagXnwsk0Lw3Bg5OqMVmYJmx7Hw6ZS7sgCQW54QUepIcXG/tkQEPfwSP8iXbOfOLJsfhISp9/U0rudOgtLEWFelSXsqPCZVyAQhf8+WddV7O1Rg/AyCAoxafeP5/uxXsI9ztGYdOJmJ41+EwQT9uGLvJqg6sF6mQnrcDHMErURxEv5z6AlV9ItUHuLWL0mAY9liH21thwAFaKNGlqoHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHJ2BmO0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHJ2BmO0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZTHz5KsJz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 05:49:51 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 20BE5435CC;
	Wed, 25 Nov 2026 18:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155C11F000C4;
	Wed, 25 Nov 2026 18:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795632590;
	bh=PM8SzO2FNT5QYTl7e2L6CPSCvxzNzPmQG5xnJtLl3nA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OHJ2BmO0t26BbIkdocGQD9nE3A3OnHYcLXXVl3aaKYh+ftS4n0BE66Ac1a8LInUBI
	 FdMbdKSxEl5b/l+MrQ48QNJYD1pbeCzOcYo0xW37AXVOAjJ759443kXbYTgs1xDoTS
	 SYElSvDFlmmnNnvyi6WKrSdrXmdvTh270kn0RN4RVcR7wyiNKLKmsF/vKh/dOcpHUZ
	 jmBs+uJpdaNHb3ngBn/j65iiGdvZWzQ3XzdjXL+6g1W+Xr6IGVd+qh/3k/v7eK2cmz
	 yJ3kZpF3U3fmtkq+vCMzzm3MkdCyDmCQ46RpCoxRUa95UlZMC32Wnm/egUjwXqJYmG
	 JGzQpF3KxjK6A==
Message-ID: <777b808e-19e3-4dc1-80f7-6d75cb0362af@kernel.org>
Date: Wed, 25 Nov 2026 19:49:45 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 4/4] powerpc/mm: Drop PAGE_KERNEL_EXEC
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
References: <cover.1795625038.git.ritesh.list@gmail.com>
 <96692b22febc2c4ee366de072cebb57abd8ffb18.1795625038.git.ritesh.list@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <96692b22febc2c4ee366de072cebb57abd8ffb18.1795625038.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 25/11/2026 à 17:52, Ritesh Harjani (IBM) a écrit :
> On powerpc PAGE_KERNEL_EXEC is just an alias to PAGE_KERNEL_X.
> 
> The comment above it's definition saying
> 	("Make modules code happy. We don't set RO yet"), is stale.
> Since commit 4fcc636615b1 ("powerpc/modules: Make module_alloc() Strict Module
> RWX aware") module text is allocated with PAGE_KERNEL when STRICT_MODULE_RWX is
> enabled and only made executable later, so there is no longer a reason for
> a separate name.
> 
> Convert the remaining users to PAGE_KERNEL_X and remove the definition.
> 
> No functional change intended.
> 
> Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/include/asm/pgtable.h | 3 ---
>   arch/powerpc/mm/mem.c              | 4 ++--
>   2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index d20ff2ae02f5..ea06a85f0fa8 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -20,9 +20,6 @@ struct mm_struct;
>   #include <asm/nohash/pgtable.h>
>   #endif /* !CONFIG_PPC_BOOK3S */
> 
> -/* Make modules code happy. We don't set RO yet */
> -#define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
> -
>   /* Advertise special mapping type for AGP */
>   #define PAGE_AGP		(PAGE_KERNEL_NC)
>   #define HAVE_PAGE_AGP
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 8a0fdfd028dd..bc83e45b7ae9 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -388,8 +388,8 @@ static void prealloc_execmem_pgtable(void) { }
> 
>   struct execmem_info __init *execmem_arch_setup(void)
>   {
> -	pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
> -	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
> +	pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_X;
> +	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_X;
>   	unsigned long fallback_start = 0, fallback_end = 0;
>   	unsigned long kprobes_start, kprobes_end;
>   	unsigned long start, end;
> --
> 2.39.5
> 


