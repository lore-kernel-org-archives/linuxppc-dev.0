Return-Path: <SRS0=pFgb=LF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CF5C4743D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 07:33:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A1561364
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 07:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A1561364
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G1XdG1d5Rz3c46
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 17:33:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G1Xct1Qbtz2ymQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jun 2021 17:32:57 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4G1Xcj3X0kzBCKV;
 Fri, 11 Jun 2021 09:32:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Abx6pCoT2VHK; Fri, 11 Jun 2021 09:32:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4G1Xcj2bcbzBCGX;
 Fri, 11 Jun 2021 09:32:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 454F28B82C;
 Fri, 11 Jun 2021 09:32:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id TdhyzBPXXzeN; Fri, 11 Jun 2021 09:32:53 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B5F448B765;
 Fri, 11 Jun 2021 09:32:52 +0200 (CEST)
Subject: Re: [PATCH 1/2] powerpc/tm: Move tm_enable definition
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
References: <1538423270-17527-1-git-send-email-leitao@debian.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <6e352830-12a2-a731-c290-e9b5be19ad03@csgroup.eu>
Date: Fri, 11 Jun 2021 09:32:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1538423270-17527-1-git-send-email-leitao@debian.org>
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
Cc: mikey@neuling.org, gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 01/10/2018 à 21:47, Breno Leitao a écrit :
> The goal of this patch is to move function tm_enabled() to tm.h in order
> to allow this function to be used by other files as an inline function.
> 
> This patch also removes the double inclusion of tm.h in the traps.c
> source code. One inclusion is inside a CONFIG_PPC64 ifdef block, and
> another one is in the generic part. This double inclusion causes a
> redefinition of tm_enable(), that is why it is being fixed here.
> 
> There is generic code (non CONFIG_PPC64, thus, non
> CONFIG_PPC_TRANSACTIONAL_MEM also) using some TM definitions, which
> explains why tm.h is being imported in the generic code. This is
> not correct, and this code is now surrounded by a
> CONFIG_PPC_TRANSACTIONAL_MEM ifdef block.

You should leave the generic inclusion and remove the second one.

Don't use #ifdef blocks when not necessary, see 
https://www.kernel.org/doc/html/latest/process/coding-style.html#conditional-compilation

> 
> These ifdef inclusion will avoid calling tm_abort_check() completely,
> but it is not a problem since this function is just returning 'false' if
> CONFIG_PPC_TRANSACTIONAL_MEM is not defined.

As tm_abort_check() always returns false, gcc will see it and will optimise-out the check by itself, 
no worry.


> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   arch/powerpc/include/asm/tm.h | 5 +++++
>   arch/powerpc/kernel/process.c | 5 -----
>   arch/powerpc/kernel/traps.c   | 5 ++++-
>   3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/tm.h b/arch/powerpc/include/asm/tm.h
> index e94f6db5e367..646d45a2aaae 100644
> --- a/arch/powerpc/include/asm/tm.h
> +++ b/arch/powerpc/include/asm/tm.h
> @@ -19,4 +19,9 @@ extern void tm_restore_sprs(struct thread_struct *thread);
>   
>   extern bool tm_suspend_disabled;
>   
> +static inline bool tm_enabled(struct task_struct *tsk)
> +{
> +	return tsk && tsk->thread.regs && (tsk->thread.regs->msr & MSR_TM);
> +}
> +
>   #endif /* __ASSEMBLY__ */
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 913c5725cdb2..c1ca2451fa3b 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -862,11 +862,6 @@ static inline bool hw_brk_match(struct arch_hw_breakpoint *a,
>   
>   #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>   
> -static inline bool tm_enabled(struct task_struct *tsk)
> -{
> -	return tsk && tsk->thread.regs && (tsk->thread.regs->msr & MSR_TM);
> -}
> -
>   static void tm_reclaim_thread(struct thread_struct *thr, uint8_t cause)
>   {
>   	/*
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index c85adb858271..a3d6298b8074 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -64,7 +64,6 @@
>   #include <asm/rio.h>
>   #include <asm/fadump.h>
>   #include <asm/switch_to.h>
> -#include <asm/tm.h>
>   #include <asm/debug.h>
>   #include <asm/asm-prototypes.h>
>   #include <asm/hmi.h>
> @@ -1276,9 +1275,11 @@ static int emulate_instruction(struct pt_regs *regs)
>   
>   	/* Emulate load/store string insn. */
>   	if ((instword & PPC_INST_STRING_GEN_MASK) == PPC_INST_STRING) {
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM

This ifdef is not needed, tm_abort_check() returns false when CONFIG_PPC_TRANSACTIONAL_MEM is not 
defined.

>   		if (tm_abort_check(regs,
>   				   TM_CAUSE_EMULATE | TM_CAUSE_PERSISTENT))
>   			return -EINVAL;
> +#endif
>   		PPC_WARN_EMULATED(string, regs);
>   		return emulate_string_inst(regs, instword);
>   	}
> @@ -1508,8 +1509,10 @@ void alignment_exception(struct pt_regs *regs)
>   	if (!arch_irq_disabled_regs(regs))
>   		local_irq_enable();
>   
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM

Same here.

>   	if (tm_abort_check(regs, TM_CAUSE_ALIGNMENT | TM_CAUSE_PERSISTENT))
>   		goto bail;
> +#endif
>   
>   	/* we don't implement logging of alignment exceptions */
>   	if (!(current->thread.align_ctl & PR_UNALIGN_SIGBUS))
> 
