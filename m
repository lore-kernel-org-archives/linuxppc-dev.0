Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A23C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 12:07:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB283222AE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 12:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="TNwPDy4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB283222AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zyvd46CfzDqKK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 23:07:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="TNwPDy4S"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zysG4vHYzDqSp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 23:05:38 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43zys93WrJzB09ZX;
 Wed, 13 Feb 2019 13:05:33 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=TNwPDy4S; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ZbLmOWCOCZra; Wed, 13 Feb 2019 13:05:33 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43zys9259fzB09ZW;
 Wed, 13 Feb 2019 13:05:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550059533; bh=grvD19QaJWyGmbCdlmHOR5r0KmCNxQi1h8MV/TdbXDY=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=TNwPDy4S1ZVq+wEMgiE3kEyD2XWQu0az5qXx86caaXNC/OAWprVvTsu3gZvfP2BGW
 R0KibYz14rau7dIHrhbUs+B3omqdRdT6Fdi3+Jfer8Aa/d1dMh6s1J7X3rhARbPtYd
 1Zalznu7omKVoYJUWjHc+bazEzrr6a1J626+8Adk=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 861CE8B85B;
 Wed, 13 Feb 2019 13:05:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id RIWoOjI91Dwm; Wed, 13 Feb 2019 13:05:34 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D10C8B756;
 Wed, 13 Feb 2019 13:05:34 +0100 (CET)
Subject: Re: [PATCH v2 2/2] powerpc/8xx: Map a second 8M text page at startup
 when needed.
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <6658dcb02424fbd5e19be3c3c9abb1a20253db46.1547801451.git.christophe.leroy@c-s.fr>
 <c53f0e44ea783306e72e51e1f33a2bb5aea6f800.1547801451.git.christophe.leroy@c-s.fr>
Message-ID: <7fb43bee-7926-35be-f54f-601b8b05b066@c-s.fr>
Date: Wed, 13 Feb 2019 13:05:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <c53f0e44ea783306e72e51e1f33a2bb5aea6f800.1547801451.git.christophe.leroy@c-s.fr>
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


Le 21/01/2019 à 12:34, Christophe Leroy a écrit :
> Some debug setup like CONFIG_KASAN generate huge
> kernels with text size over the 8M limit.
> 
> This patch maps a second 8M page when _einittext is over 8M.

This is not enough for CONFIG_KASAN_INLINE. I'll send a v3 which maps up 
to 32M based on _einittext.


> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   v2: Using IS_ENABLED() instead of #ifdef in 8xx_mmu.c
> 
>   arch/powerpc/kernel/head_8xx.S | 27 +++++++++++++++++++++++++--
>   arch/powerpc/mm/8xx_mmu.c      |  3 +++
>   2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
> index 20cc816b3508..3b3b7846247f 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -337,8 +337,8 @@ InstructionTLBMiss:
>   	rlwinm	r10, r10, 16, 0xfff8
>   	cmpli	cr0, r10, PAGE_OFFSET@h
>   #ifndef CONFIG_PIN_TLB_TEXT
> -	/* It is assumed that kernel code fits into the first 8M page */
> -0:	cmpli	cr7, r10, (PAGE_OFFSET + 0x0800000)@h
> +	/* It is assumed that kernel code fits into the two first 8M pages */
> +0:	cmpli	cr7, r10, (PAGE_OFFSET + 0x1000000)@h
>   	patch_site	0b, patch__itlbmiss_linmem_top
>   #endif
>   #endif
> @@ -908,6 +908,29 @@ initial_mmu:
>   	li	r8, MI_BOOTINIT		/* Create RPN for address 0 */
>   	mtspr	SPRN_MI_RPN, r8		/* Store TLB entry */
>   
> +	/* Map a second 8M page if needed */
> +	lis	r9, _einittext@h
> +	oris	r9, r9, _einittext@l
> +	cmpli	cr0, r9, (PAGE_OFFSET + 0x8000000)@h

Should be 0x800000 here

Christophe

> +	blt	1f
> +
> +#ifdef CONFIG_PIN_TLB_TEXT
> +	lis	r8, MI_RSV4I@h
> +	ori	r8, r8, 0x1d00
> +
> +	mtspr	SPRN_MI_CTR, r8	/* Set instruction MMU control */
> +#endif
> +
> +	lis	r8, (KERNELBASE + 0x800000)@h	/* Create vaddr for TLB */
> +	ori	r8, r8, MI_EVALID	/* Mark it valid */
> +	mtspr	SPRN_MI_EPN, r8
> +	li	r8, MI_PS8MEG /* Set 8M byte page */
> +	ori	r8, r8, MI_SVALID	/* Make it valid */
> +	mtspr	SPRN_MI_TWC, r8
> +	li	r8, MI_BOOTINIT		/* Create RPN for address 0 */
> +	addis	r8, r8, 0x80
> +	mtspr	SPRN_MI_RPN, r8		/* Store TLB entry */
> +1:
>   	lis	r8, MI_APG_INIT@h	/* Set protection modes */
>   	ori	r8, r8, MI_APG_INIT@l
>   	mtspr	SPRN_MI_AP, r8
> diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
> index 92b677faea8c..b5f6d794281d 100644
> --- a/arch/powerpc/mm/8xx_mmu.c
> +++ b/arch/powerpc/mm/8xx_mmu.c
> @@ -112,6 +112,9 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
>   			mmu_patch_cmp_limit(&patch__itlbmiss_linmem_top, 0);
>   	} else {
>   		mapped = top & ~(LARGE_PAGE_SIZE_8M - 1);
> +		if (!IS_ENABLED(CONFIG_PIN_TLB_TEXT))
> +			mmu_patch_cmp_limit(&patch__itlbmiss_linmem_top,
> +					    _ALIGN(__pa(_einittext), 8 << 20));
>   	}
>   
>   	mmu_patch_cmp_limit(&patch__dtlbmiss_linmem_top, mapped);
> 
