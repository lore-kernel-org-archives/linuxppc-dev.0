Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19678C4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 14:43:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06646113D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 14:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F06646113D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gr6vX08ntz3cn5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Aug 2021 00:43:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gr6v030GYz3bW7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Aug 2021 00:42:49 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4Gr6tt5j2Wz9sVF;
 Thu, 19 Aug 2021 16:42:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X3JyI59r9yOB; Thu, 19 Aug 2021 16:42:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4Gr6tt4hwPz9sS1;
 Thu, 19 Aug 2021 16:42:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6ECA78B842;
 Thu, 19 Aug 2021 16:42:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id SS_tpCTUXmjA; Thu, 19 Aug 2021 16:42:46 +0200 (CEST)
Received: from [172.25.230.102] (po15451.idsi0.si.c-s.fr [172.25.230.102])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 456328B837;
 Thu, 19 Aug 2021 16:42:46 +0200 (CEST)
Subject: Re: [PATCH 1/6] powerpc/prom: Introduce early_reserve_mem_old()
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
References: <20210819125656.14498-1-clg@kaod.org>
 <20210819125656.14498-2-clg@kaod.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <d79611e0-b42b-e74b-d628-5db718e6ebfa@csgroup.eu>
Date: Thu, 19 Aug 2021 16:42:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210819125656.14498-2-clg@kaod.org>
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 19/08/2021 à 14:56, Cédric Le Goater a écrit :
> and condition its call with IS_ENABLED(CONFIG_PPC32). This fixes a
> compile error with W=1.
> 
> arch/powerpc/kernel/prom.c: In function ‘early_reserve_mem’:
> arch/powerpc/kernel/prom.c:625:10: error: variable ‘reserve_map’ set but not used [-Werror=unused-but-set-variable]
>    __be64 *reserve_map;
>            ^~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
> 
>   Christophe, I think you had comments on this one ? Yes, I am being a bit lazy.


Yeah, my comment was to leave thing almost as is, just drop the #ifdef CONFIG_PPC32 and instead put 
something like:

	if (!IS_ENABLED(CONFIG_PPC32))
		return;

> 
>   arch/powerpc/kernel/prom.c | 37 ++++++++++++++++++++-----------------
>   1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index f620e04dc9bf..52869d12bc1d 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -621,27 +621,14 @@ static void __init early_reserve_mem_dt(void)
>   	}
>   }
>   
> -static void __init early_reserve_mem(void)
> +static void __init early_reserve_mem_old(void)

Why old ? Because ppc32 ?

I think that's more changes than needed.



>   {
>   	__be64 *reserve_map;
>   
>   	reserve_map = (__be64 *)(((unsigned long)initial_boot_params) +
>   			fdt_off_mem_rsvmap(initial_boot_params));
>   
> -	/* Look for the new "reserved-regions" property in the DT */
> -	early_reserve_mem_dt();
> -
> -#ifdef CONFIG_BLK_DEV_INITRD
> -	/* Then reserve the initrd, if any */
> -	if (initrd_start && (initrd_end > initrd_start)) {
> -		memblock_reserve(ALIGN_DOWN(__pa(initrd_start), PAGE_SIZE),
> -			ALIGN(initrd_end, PAGE_SIZE) -
> -			ALIGN_DOWN(initrd_start, PAGE_SIZE));
> -	}
> -#endif /* CONFIG_BLK_DEV_INITRD */
> -
> -#ifdef CONFIG_PPC32
> -	/*
> +	/*
>   	 * Handle the case where we might be booting from an old kexec
>   	 * image that setup the mem_rsvmap as pairs of 32-bit values
>   	 */
> @@ -659,9 +646,25 @@ static void __init early_reserve_mem(void)
>   			DBG("reserving: %x -> %x\n", base_32, size_32);
>   			memblock_reserve(base_32, size_32);
>   		}
> -		return;
>   	}
> -#endif
> +}
> +
> +static void __init early_reserve_mem(void)
> +{
> +	/* Look for the new "reserved-regions" property in the DT */
> +	early_reserve_mem_dt();
> +
> +#ifdef CONFIG_BLK_DEV_INITRD
> +	/* Then reserve the initrd, if any */
> +	if (initrd_start && (initrd_end > initrd_start)) {
> +		memblock_reserve(ALIGN_DOWN(__pa(initrd_start), PAGE_SIZE),
> +			ALIGN(initrd_end, PAGE_SIZE) -
> +			ALIGN_DOWN(initrd_start, PAGE_SIZE));
> +	}
> +#endif /* CONFIG_BLK_DEV_INITRD */
> +
> +	if (IS_ENABLED(CONFIG_PPC32))
> +		early_reserve_mem_old();
>   }
>   
>   #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> 
