Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A7EC65C20
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 16:19:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F7F2089D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 16:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F7F2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TQYW5sfPzF3FB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 03:19:43 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TQWR4s2QzF3BS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 03:17:55 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42TQW95s7qz9ttBZ;
 Mon,  8 Oct 2018 18:17:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id jzJwmQuxMRkR; Mon,  8 Oct 2018 18:17:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42TQW95Kfpz9ttBY;
 Mon,  8 Oct 2018 18:17:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BD8178B7D0;
 Mon,  8 Oct 2018 18:17:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id IysNyAM1mikM; Mon,  8 Oct 2018 18:17:51 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D1FAC8B7BD;
 Mon,  8 Oct 2018 18:17:50 +0200 (CEST)
Subject: Re: [PATCH v2 3/3] powerpc: machine check interrupt is a non-maskable
 interrupt
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170719065912.19183-1-npiggin@gmail.com>
 <20170719065912.19183-4-npiggin@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <30487984-752a-960d-6aae-6571c55c7ba5@c-s.fr>
Date: Mon, 8 Oct 2018 17:39:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20170719065912.19183-4-npiggin@gmail.com>
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
Cc: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Nick,

Le 19/07/2017 à 08:59, Nicholas Piggin a écrit :
> Use nmi_enter similarly to system reset interrupts. This uses NMI
> printk NMI buffers and turns off various debugging facilities that
> helps avoid tripping on ourselves or other CPUs.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   arch/powerpc/kernel/traps.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 2849c4f50324..6d31f9d7c333 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -789,8 +789,10 @@ int machine_check_generic(struct pt_regs *regs)
>   
>   void machine_check_exception(struct pt_regs *regs)
>   {
> -	enum ctx_state prev_state = exception_enter();
>   	int recover = 0;
> +	bool nested = in_nmi();
> +	if (!nested)
> +		nmi_enter();

This alters preempt_count, then when die() is called
in_interrupt() returns true allthough the trap didn't happen in 
interrupt, so oops_end() panics for "fatal exception in interrupt" 
instead of gently sending SIGBUS the faulting app.

Any idea on how to fix this ?

Christophe

>   
>   	__this_cpu_inc(irq_stat.mce_exceptions);
>   
> @@ -820,10 +822,11 @@ void machine_check_exception(struct pt_regs *regs)
>   
>   	/* Must die if the interrupt is not recoverable */
>   	if (!(regs->msr & MSR_RI))
> -		panic("Unrecoverable Machine check");
> +		nmi_panic(regs, "Unrecoverable Machine check");
>   
>   bail:
> -	exception_exit(prev_state);
> +	if (!nested)
> +		nmi_exit();
>   }
>   
>   void SMIException(struct pt_regs *regs)
> 
