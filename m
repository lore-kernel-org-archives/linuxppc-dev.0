Return-Path: <SRS0=BvUY=PG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB97C433EF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Oct 2021 17:10:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB8060FC3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Oct 2021 17:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EEB8060FC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HY3KN1867z3bXY
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Oct 2021 04:10:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HY3Jr12g7z2yLV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Oct 2021 04:09:45 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HY3Jf082wz9sSD;
 Mon, 18 Oct 2021 19:09:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hl-EVecaSNSY; Mon, 18 Oct 2021 19:09:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HY3Jd6Jt3z9sS3;
 Mon, 18 Oct 2021 19:09:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C457A8B76C;
 Mon, 18 Oct 2021 19:09:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ymXwxBPiHsrN; Mon, 18 Oct 2021 19:09:37 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.67])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 777B68B763;
 Mon, 18 Oct 2021 19:09:37 +0200 (CEST)
Subject: Re: [PATCH v1 04/11] powerpc/64s: Move and rename do_bad_slb_fault as
 it is not hash specific
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20211015154624.922960-1-npiggin@gmail.com>
 <20211015154624.922960-5-npiggin@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <80ea8862-0843-02ae-791c-5c921c19803f@csgroup.eu>
Date: Mon, 18 Oct 2021 19:09:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211015154624.922960-5-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 15/10/2021 à 17:46, Nicholas Piggin a écrit :
> slb.c is hash-specific SLB management, but do_bad_slb_fault deals with
> segment interrupts that occur with radix MMU as well.
> ---
>   arch/powerpc/include/asm/interrupt.h |  2 +-
>   arch/powerpc/kernel/exceptions-64s.S |  4 ++--
>   arch/powerpc/mm/book3s64/slb.c       | 16 ----------------
>   arch/powerpc/mm/fault.c              | 17 +++++++++++++++++
>   4 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
> index a1d238255f07..3487aab12229 100644
> --- a/arch/powerpc/include/asm/interrupt.h
> +++ b/arch/powerpc/include/asm/interrupt.h
> @@ -564,7 +564,7 @@ DECLARE_INTERRUPT_HANDLER(kernel_bad_stack);
>   
>   /* slb.c */
>   DECLARE_INTERRUPT_HANDLER_RAW(do_slb_fault);
> -DECLARE_INTERRUPT_HANDLER(do_bad_slb_fault);
> +DECLARE_INTERRUPT_HANDLER(do_bad_segment_interrupt);
>   
>   /* hash_utils.c */
>   DECLARE_INTERRUPT_HANDLER_RAW(do_hash_fault);
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index eaf1f72131a1..046c99e31d01 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1430,7 +1430,7 @@ MMU_FTR_SECTION_ELSE
>   ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
>   	std	r3,RESULT(r1)
>   	addi	r3,r1,STACK_FRAME_OVERHEAD
> -	bl	do_bad_slb_fault
> +	bl	do_bad_segment_interrupt
>   	b	interrupt_return_srr
>   
>   
> @@ -1510,7 +1510,7 @@ MMU_FTR_SECTION_ELSE
>   ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
>   	std	r3,RESULT(r1)
>   	addi	r3,r1,STACK_FRAME_OVERHEAD
> -	bl	do_bad_slb_fault
> +	bl	do_bad_segment_interrupt
>   	b	interrupt_return_srr
>   
>   
> diff --git a/arch/powerpc/mm/book3s64/slb.c b/arch/powerpc/mm/book3s64/slb.c
> index f0037bcc47a0..31f4cef3adac 100644
> --- a/arch/powerpc/mm/book3s64/slb.c
> +++ b/arch/powerpc/mm/book3s64/slb.c
> @@ -868,19 +868,3 @@ DEFINE_INTERRUPT_HANDLER_RAW(do_slb_fault)
>   		return err;
>   	}
>   }
> -
> -DEFINE_INTERRUPT_HANDLER(do_bad_slb_fault)
> -{
> -	int err = regs->result;
> -
> -	if (err == -EFAULT) {
> -		if (user_mode(regs))
> -			_exception(SIGSEGV, regs, SEGV_BNDERR, regs->dar);
> -		else
> -			bad_page_fault(regs, SIGSEGV);
> -	} else if (err == -EINVAL) {
> -		unrecoverable_exception(regs);
> -	} else {
> -		BUG();
> -	}
> -}
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index a8d0ce85d39a..53ddcae0ac9e 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -35,6 +35,7 @@
>   #include <linux/kfence.h>
>   #include <linux/pkeys.h>
>   
> +#include <asm/asm-prototypes.h>
>   #include <asm/firmware.h>
>   #include <asm/interrupt.h>
>   #include <asm/page.h>
> @@ -620,4 +621,20 @@ DEFINE_INTERRUPT_HANDLER(do_bad_page_fault_segv)
>   {
>   	bad_page_fault(regs, SIGSEGV);
>   }
> +
> +DEFINE_INTERRUPT_HANDLER(do_bad_segment_interrupt)
> +{
> +	int err = regs->result;
> +
> +	if (err == -EFAULT) {
> +		if (user_mode(regs))
> +			_exception(SIGSEGV, regs, SEGV_BNDERR, regs->dar);
> +		else
> +			bad_page_fault(regs, SIGSEGV);
> +	} else if (err == -EINVAL) {
> +		unrecoverable_exception(regs);
> +	} else {
> +		BUG();
> +	}
> +}
>   #endif
> 

You could do something more flat:

	if (err == -EINVAL)
		unrecoverable_exception(regs);

	BUG_ON(err != -EFAULT);

	if (user_mode(regs))
		_exception(SIGSEGV, regs, SEGV_BNDERR, regs->dar);
	else
		bad_page_fault(regs, SIGSEGV);

I know you are just moving existing code but moving code is always an 
opportunity to clean it without additional churn.
