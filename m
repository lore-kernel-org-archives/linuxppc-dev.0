Return-Path: <SRS0=6/er=KP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17758C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 10:18:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F0661074
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 10:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F0661074
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fm5Ks1zZ5z3082
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 20:18:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fm5KM4cc2z3bw0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2021 20:17:56 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4Fm5KG1BwLz9sVl;
 Thu, 20 May 2021 12:17:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V02iu2pkl3v1; Thu, 20 May 2021 12:17:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4Fm5KG07tTz9sVj;
 Thu, 20 May 2021 12:17:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CAED28B80D;
 Thu, 20 May 2021 12:17:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id OTfgYiBQ5XPk; Thu, 20 May 2021 12:17:53 +0200 (CEST)
Received: from [172.25.230.105] (po15451.idsi0.si.c-s.fr [172.25.230.105])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8BA468B767;
 Thu, 20 May 2021 12:17:53 +0200 (CEST)
Subject: Re: [PATCH] powerpc/kprobes: Pass ppc_inst as a pointer to
 emulate_step() on ppc32
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20210520072909.2901326-1-naveen.n.rao@linux.vnet.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <8a0cfd88-a98d-711c-b80b-916a99ada2c8@csgroup.eu>
Date: Thu, 20 May 2021 12:17:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210520072909.2901326-1-naveen.n.rao@linux.vnet.ibm.com>
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



Le 20/05/2021 à 09:29, Naveen N. Rao a écrit :
> Trying to use a kprobe on ppc32 results in the below splat:
>      BUG: Unable to handle kernel data access on read at 0x7c0802a6
>      Faulting instruction address: 0xc002e9f0
>      Oops: Kernel access of bad area, sig: 11 [#1]
>      BE PAGE_SIZE=4K PowerPC 44x Platform
>      Modules linked in:
>      CPU: 0 PID: 89 Comm: sh Not tainted 5.13.0-rc1-01824-g3a81c0495fdb #7
>      NIP:  c002e9f0 LR: c0011858 CTR: 00008a47
>      REGS: c292fd50 TRAP: 0300   Not tainted  (5.13.0-rc1-01824-g3a81c0495fdb)
>      MSR:  00009000 <EE,ME>  CR: 24002002  XER: 20000000
>      DEAR: 7c0802a6 ESR: 00000000
>      <snip>
>      NIP [c002e9f0] emulate_step+0x28/0x324
>      LR [c0011858] optinsn_slot+0x128/0x10000
>      Call Trace:
>       opt_pre_handler+0x7c/0xb4 (unreliable)
>       optinsn_slot+0x128/0x10000
>       ret_from_syscall+0x0/0x28

I remember running some kprobe tests before submitting the patch, how did I miss that ?
Is there anything special to do to activate the use of optprobes and/or to hit this bug ?

> 
> The offending instruction is:
>      81 24 00 00     lwz     r9,0(r4)
> 
> Here, we are trying to load the second argument to emulate_step():
> struct ppc_inst, which is the instruction to be emulated. On ppc64,
> structures are passed in registers when passed by value. However, per
> the ppc32 ABI, structures are always passed to functions as pointers.

Yes, and that was one of the reasons I was reluctant to that new 'struct ppc_inst', as it means 
stack frames, copies, etc ... whereas we could have just changed it from 'unsigned int' to 'unsigned 
long'.
Ok, now we have it, so let's use it, but use it correctly, see my clean-up series 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=244719&state=* (v2 on the way).

> This isn't being adhered to when setting up the call to emulate_step()
> in the optprobe trampoline. Fix the same.
> 
> Fixes: eacf4c0202654a ("powerpc: Enable OPTPROBES on PPC32")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>   arch/powerpc/kernel/optprobes.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
> index cdf87086fa33a0..2bc53fa48a1b33 100644
> --- a/arch/powerpc/kernel/optprobes.c
> +++ b/arch/powerpc/kernel/optprobes.c
> @@ -281,8 +281,12 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
>   	/*
>   	 * 3. load instruction to be emulated into relevant register, and
>   	 */
> -	temp = ppc_inst_read((struct ppc_inst *)p->ainsn.insn);
> -	patch_imm_load_insns(ppc_inst_as_ulong(temp), 4, buff + TMPL_INSN_IDX);
> +	if (IS_ENABLED(CONFIG_PPC64)) {
> +		temp = ppc_inst_read((struct ppc_inst *)p->ainsn.insn);
> +		patch_imm_load_insns(ppc_inst_as_ulong(temp), 4, buff + TMPL_INSN_IDX);
> +	} else {
> +		patch_imm_load_insns((unsigned long)p->ainsn.insn, 4, buff + TMPL_INSN_IDX);
> +	}

It means commit https://github.com/linuxppc/linux/commit/693557ebf407a85ea400a0b501bb97687d8f4856 
was not necessary and may be reverted.

Christophe
