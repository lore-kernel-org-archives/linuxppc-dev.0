Return-Path: <linuxppc-dev+bounces-21223-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520C5CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 09:36:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL5z66cP0z2xqv;
	Wed, 20 May 2026 19:36:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779269810;
	cv=none; b=WtVbMoGnxOlwUfh98PktirThLrlRFelcfjP1Ib1tSYZzUiek1eqJBonEfFA5zbcfrItI2AiYSMlnau/538H8WySWSp9M6ubFmFcOci2kA9206L9Dd6/AxDE/Q8JCwVj10VXK1h/x6hjAkeOd45Lv1U2+C+h5BkAnuRH/Ret2ZzmSeZk2kbBsi4oAtgOHt0DdZBjNpOOgOA2JXFJ4yrWxZwjsCFVzqic2la+zOH/snEaLWufd3RIArvkSVpDqQjIFk2Dn5SPwYodL7owYNejPgycjmycFH5NhVV5L/xO9WhdYhXS1VuHalVREaFzM9NFpG9OwnPp0+B85Bbq8BKQa4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779269810; c=relaxed/relaxed;
	bh=fMtzTISckk4frZhnqv4yzfKDkGU+WS2PRBu0g7m4RhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvqA35bZ51eIaeMwg3fNRsryJc4CD3MydDnxT8uutUHJcMDDTZJ/XkufAX3fQIbxQY8ymVghtWGhTJoCY7JOzkWJQyvhZgzIXOaUFb14Kc745DgoofDjCP6KTBSau241yOj3hcnKW6lZgeSU9dqm+I2Sl3DJbLV2mJ3Laz1sfb6u1pquqtCULASONFGHqVrJL7iBwwELK8bq2RxPH/NdC5yvs4JSOxTc5K+j+GvARxCndGE1rest0SjVa2NWK0DnM18spTNmy3ZpYhE2sxHzH7ZeUrAF5h48VGWWnPh87vNyxhJm2FiJXSkmfLzISOWG9cKFBzJx49DNohJH9wIMUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANtnDr3Z; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANtnDr3Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL5z60cYTz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 19:36:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7D287600CB;
	Wed, 20 May 2026 09:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDCF1F000E9;
	Wed, 20 May 2026 09:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779269807;
	bh=fMtzTISckk4frZhnqv4yzfKDkGU+WS2PRBu0g7m4RhA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ANtnDr3Zg5yAOEEsfnp56emf8E04XvChmbg4ZReeljPlFzfKh9fnZE3c/lDiBJ813
	 EQQIUH49gsNUaMvHXFT46IAYiWKerGGEVVCrSPgejwTu6N/KFEgvxDkIt8E61U/fNq
	 AF6xLJJkTQueTFsNGqFJtsuYitoqVQMC/niWXbrx4DBNv08OtCh4Xe3q12XQjIwa7g
	 6maMb2KeUR5qZfKEcZqp3rAY6Oh1wmTCGo0lBJ5sO37GYgGCPJl/nuKETIGwePLR7r
	 T+lUzxlE7Wh68S8k4QJJ7l3KDIipeMTwcgZ+QOZ8AFjNIww72J9jI/j2cifJ3Z+eXX
	 TNZYFfPRBTlHw==
Message-ID: <d4690d12-77d5-4575-9a79-484a919d3203@kernel.org>
Date: Wed, 20 May 2026 11:36:44 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH resend] powerpc/code-patching: Avoid r/w mapping of the
 zero page
To: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
References: <20260520085423.485402-1-ardb@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260520085423.485402-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 20/05/2026 à 10:54, Ard Biesheuvel a écrit :
> The only remaining use of map_patch_area() is mapping the zero page, and
> immediately unmapping it again so that the intermediate page table
> levels are all guaranteed to be populated.
> 
> The use of the zero page here is completely arbitrary, and not harmful
> per se, but currently, it creates a writable mapping, and does so in a
> manner that requires that the empty_zero_page[] symbol is not
> const-qualified.
> 
> Given that this is about to change, and that map_patch_area() now never
> maps anything other than the zero page, let's simplify the code and
> - take the PA of empty_zero_page directly
> - create a read-only temporary mapping.
> 
> This allows empty_zero_page[] to be repainted as const u8[] in a
> subsequent patch, without making substantial changes to this code
> patching logic.
> 
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> Build tested only (Clang)
> 
> Resending from my non-Google email. Apologies if you are receiving this
> twice.
> 
>   arch/powerpc/lib/code-patching.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index f84e0337cc02..13a8acf851f1 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -60,7 +60,7 @@ struct patch_context {
>   
>   static DEFINE_PER_CPU(struct patch_context, cpu_patching_context);
>   
> -static int map_patch_area(void *addr, unsigned long text_poke_addr);
> +static int map_patch_area(unsigned long text_poke_addr);
>   static void unmap_patch_area(unsigned long addr);
>   
>   static bool mm_patch_enabled(void)
> @@ -117,7 +117,7 @@ static int text_area_cpu_up(unsigned int cpu)
>   
>   	// Map/unmap the area to ensure all page tables are pre-allocated
>   	addr = (unsigned long)area->addr;
> -	err = map_patch_area(empty_zero_page, addr);
> +	err = map_patch_area(addr);

I would get rid of map_patch_area() completely and just do:

	err = map_kernel_page(addr, __pa_symbol(empty_zero_page), PAGE_KERNEL_RO);


By the way I don't know how vital it is to map in read-only but in case 
it is see commit da3a3b0a0e38 ("powerpc/32s: map kasan zero shadow with 
PAGE_READONLY instead of PAGE_KERNEL_RO")

>   	if (err)
>   		return err;
>   
> @@ -236,11 +236,10 @@ static unsigned long get_patch_pfn(void *addr)
>   /*
>    * This can be called for kernel text or a module.
>    */
> -static int map_patch_area(void *addr, unsigned long text_poke_addr)
> +static int map_patch_area(unsigned long text_poke_addr)
>   {
> -	unsigned long pfn = get_patch_pfn(addr);
> -
> -	return map_kernel_page(text_poke_addr, (pfn << PAGE_SHIFT), PAGE_KERNEL);
> +	return map_kernel_page(text_poke_addr, __pa_symbol(empty_zero_page),
> +			       PAGE_KERNEL_RO);
>   }
>   
>   static void unmap_patch_area(unsigned long addr)


