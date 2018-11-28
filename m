Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F36DC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 10:05:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9718C2081C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 10:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9718C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434brP4SH2zDqjH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 21:05:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434bQ84l7wzDqM9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 20:46:24 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 434bQ42WL3z9vBmK;
 Wed, 28 Nov 2018 10:46:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id OFTozA-0L65h; Wed, 28 Nov 2018 10:46:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 434bQ41q5Dz9vBmJ;
 Wed, 28 Nov 2018 10:46:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 316298B85D;
 Wed, 28 Nov 2018 10:46:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Be2a1pSxcfe1; Wed, 28 Nov 2018 10:46:21 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 04ECB8B853;
 Wed, 28 Nov 2018 10:46:21 +0100 (CET)
Subject: Re: [RFC PATCH v2 07/11] powerpc/mm/radix: Use KUEP API for Radix MMU
To: Russell Currey <ruscur@russell.cc>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <76d777b36e54e7b8d4c196405decc712fc5eaf45.1543356926.git.christophe.leroy@c-s.fr>
 <312a6ca863fb46569b705d0dc5f5e38dfcd64889.1543356926.git.christophe.leroy@c-s.fr>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <cbd84ca9-4337-658e-d834-25943f5f3753@c-s.fr>
Date: Wed, 28 Nov 2018 10:46:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <312a6ca863fb46569b705d0dc5f5e38dfcd64889.1543356926.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Sorry, I forgot to reset the author so the patch appears as coming from 
yourself.

Le 28/11/2018 à 10:27, Russell Currey a écrit :
> Execution protection already exists on radix, this just refactors
> the radix init to provide the KUEP setup function instead.
> 
> Thus, the only functional change is that it can now be disabled.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/mm/pgtable-radix.c        | 9 ++++++---
>   arch/powerpc/platforms/Kconfig.cputype | 1 +
>   2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 931156069a81..45aa9e501e76 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -535,8 +535,13 @@ static void radix_init_amor(void)
>   	mtspr(SPRN_AMOR, (3ul << 62));
>   }
>   
> -static void radix_init_iamr(void)
> +void setup_kuep(bool disabled)
>   {
> +	if (disabled)
> +		return;
> +
> +	pr_info("Activating Kernel Userspace Execution Prevention\n");
> +
>   	/*
>   	 * Radix always uses key0 of the IAMR to determine if an access is
>   	 * allowed. We set bit 0 (IBM bit 1) of key0, to prevent instruction
> @@ -605,7 +610,6 @@ void __init radix__early_init_mmu(void)
>   
>   	memblock_set_current_limit(MEMBLOCK_ALLOC_ANYWHERE);
>   
> -	radix_init_iamr();
>   	radix_init_pgtable();
>   	/* Switch to the guard PID before turning on MMU */
>   	radix__switch_mmu_context(NULL, &init_mm);
> @@ -627,7 +631,6 @@ void radix__early_init_mmu_secondary(void)
>   		      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
>   		radix_init_amor();
>   	}
> -	radix_init_iamr();
>   
>   	radix__switch_mmu_context(NULL, &init_mm);
>   	if (cpu_has_feature(CPU_FTR_HVMODE))
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index a20669a9ec13..e6831d0ec159 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -334,6 +334,7 @@ config PPC_RADIX_MMU
>   	bool "Radix MMU Support"
>   	depends on PPC_BOOK3S_64
>   	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
> +	select PPC_HAVE_KUEP
>   	default y
>   	help
>   	  Enable support for the Power ISA 3.0 Radix style MMU. Currently this
> 
