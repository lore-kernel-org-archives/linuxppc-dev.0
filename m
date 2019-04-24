Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64530C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 12:56:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 983D1218B0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 12:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="nJqxCCiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983D1218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q0gL1H4tzDqW4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 22:56:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="nJqxCCiq"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q0d75m6QzDqT9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 22:54:16 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44q0cy47qxz9v1LR;
 Wed, 24 Apr 2019 14:54:10 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=nJqxCCiq; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id C76UBafuaR2B; Wed, 24 Apr 2019 14:54:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44q0cy33gGz9v1LQ;
 Wed, 24 Apr 2019 14:54:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556110450; bh=DIkcyAeFAEvkJmAkuos9r+M7SLSefzeDnMMTQ4Tk39k=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=nJqxCCiqmr+WR59ncU4P5ODmB3HKad4qTdCkdJQ1jP+y/gHubVei2IITAlsnJAsHb
 9R8U7rmxLjXyjOtDewyZLO1iIcDIQqZKjtrXQtwu4xMtvVdZwd9WOU3KOZSgbR7GYQ
 C4D9aRqlsR5PWru9dZTGYtVRsNdaOql5eCKfLig0=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D229A8B909;
 Wed, 24 Apr 2019 14:54:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id xVlPFz52TA-L; Wed, 24 Apr 2019 14:54:11 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A7D998B8FB;
 Wed, 24 Apr 2019 14:54:11 +0200 (CEST)
Subject: Re: [PATCH v3 5/6] powerpc/mm: Reduce memory usage for mm_context_t
 for radix
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 paulus@samba.org, mpe@ellerman.id.au
References: <20190417130351.3805-1-aneesh.kumar@linux.ibm.com>
 <20190417130351.3805-6-aneesh.kumar@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <76af2dbb-96bb-d5e6-fe65-a8ca87e2e268@c-s.fr>
Date: Wed, 24 Apr 2019 14:54:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417130351.3805-6-aneesh.kumar@linux.ibm.com>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 17/04/2019 à 15:03, Aneesh Kumar K.V a écrit :
> Currently, our mm_context_t on book3s64 include all hash specific
> context details like slice mask and subpage protection details. We
> can skip allocating these with radix translation. This will help us to save
> 8K per mm_context with radix translation.
> 
> With the patch applied we have
> 
> sizeof(mm_context_t)  = 136
> sizeof(struct hash_mm_context)  = 8288
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/book3s/64/mmu-hash.h | 33 ++++++++++++-
>   arch/powerpc/include/asm/book3s/64/mmu.h      | 49 +++++--------------
>   arch/powerpc/kernel/setup-common.c            |  6 +++
>   arch/powerpc/mm/hash_utils_64.c               |  4 +-
>   arch/powerpc/mm/mmu_context_book3s64.c        | 16 +++++-
>   5 files changed, 68 insertions(+), 40 deletions(-)
> 

[...]

> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index a07de8608484..21b1ce200b22 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -947,6 +947,12 @@ void __init setup_arch(char **cmdline_p)
>   	init_mm.end_data = (unsigned long) _edata;
>   	init_mm.brk = klimit;
>   
> +#ifdef CONFIG_PPC_MM_SLICES
> +#if defined(CONFIG_PPC_8xx)
> +	init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW;
> +#endif
> +#endif
> +

In the previous patch, you moved the above into early_init_mmu(). Why 
bringing it back here ?

Christophe

>   #ifdef CONFIG_SPAPR_TCE_IOMMU
>   	mm_iommu_init(&init_mm);
>   #endif
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 2cb3a456f5b5..04ac7c36d380 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -968,6 +968,7 @@ void __init hash__early_init_devtree(void)
>   	htab_scan_page_sizes();
>   }
>   
> +struct hash_mm_context init_hash_mm_context;
>   void __init hash__early_init_mmu(void)
>   {
>   #ifndef CONFIG_PPC_64K_PAGES
> @@ -1041,7 +1042,8 @@ void __init hash__early_init_mmu(void)
>   	 */
>   	htab_initialize();
>   
> -	init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
> +	init_mm.context.hash_context = &init_hash_mm_context;
> +	init_mm.context.hash_context->slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
>   
>   	pr_info("Initializing hash mmu with SLB\n");
>   	/* Initialize SLB management */
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> index f720c5cc0b5e..6eef5a36b2e9 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -63,6 +63,12 @@ static int hash__init_new_context(struct mm_struct *mm)
>   	if (index < 0)
>   		return index;
>   
> +	mm->context.hash_context = kmalloc(sizeof(struct hash_mm_context), GFP_KERNEL);
> +	if (!mm->context.hash_context) {
> +		ida_free(&mmu_context_ida, index);
> +		return -ENOMEM;
> +	}
> +
>   	/*
>   	 * The old code would re-promote on fork, we don't do that when using
>   	 * slices as it could cause problem promoting slices that have been
> @@ -77,8 +83,14 @@ static int hash__init_new_context(struct mm_struct *mm)
>   	 * We should not be calling init_new_context() on init_mm. Hence a
>   	 * check against 0 is OK.
>   	 */
> -	if (mm->context.id == 0)
> +	if (mm->context.id == 0) {
> +		memset(mm->context.hash_context, 0, sizeof(struct hash_mm_context));
>   		slice_init_new_context_exec(mm);
> +	} else {
> +		/* This is fork. Copy hash_context details from current->mm */
> +		memcpy(mm->context.hash_context, current->mm->context.hash_context, sizeof(struct hash_mm_context));
> +
> +	}
>   
>   	subpage_prot_init_new_context(mm);
>   
> @@ -118,6 +130,7 @@ static int radix__init_new_context(struct mm_struct *mm)
>   	asm volatile("ptesync;isync" : : : "memory");
>   
>   	mm->context.npu_context = NULL;
> +	mm->context.hash_context = NULL;
>   
>   	return index;
>   }
> @@ -162,6 +175,7 @@ static void destroy_contexts(mm_context_t *ctx)
>   		if (context_id)
>   			ida_free(&mmu_context_ida, context_id);
>   	}
> +	kfree(ctx->hash_context);
>   }
>   
>   static void pmd_frag_destroy(void *pmd_frag)
> 
