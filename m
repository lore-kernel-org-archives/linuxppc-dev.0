Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2311C5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 09:30:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E672098A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 09:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E672098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bP0M50SfzF3Nd
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 20:30:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bNyC5c3hzF3CP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 20:28:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42bNyC4wVBz8tP6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 20:28:19 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42bNyC4lZnz9sBn; Thu, 18 Oct 2018 20:28:19 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42bNyC1h8Lz9sB5
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2018 20:28:19 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42bNy80YsFz9ttBx;
 Thu, 18 Oct 2018 11:28:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id jJoSxD6bzVrq; Thu, 18 Oct 2018 11:28:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42bNy774PMz9ttBS;
 Thu, 18 Oct 2018 11:28:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BE79C8B8B0;
 Thu, 18 Oct 2018 11:28:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id xFVsRuv6GDK0; Thu, 18 Oct 2018 11:28:15 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DBE288B8AB;
 Thu, 18 Oct 2018 11:28:14 +0200 (CEST)
Subject: Re: [PATCH] powerpc: Don't print kernel instructions in
 show_user_instructions()
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20181005132123.6038-1-mpe@ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <6b3b54e5-cbe3-c693-23ea-26928e7597c8@c-s.fr>
Date: Thu, 18 Oct 2018 11:28:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005132123.6038-1-mpe@ellerman.id.au>
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
Cc: jannh@google.com, muriloo@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 05/10/2018 à 15:21, Michael Ellerman a écrit :
> Recently we implemented show_user_instructions() which dumps the code
> around the NIP when a user space process dies with an unhandled
> signal. This was modelled on the x86 code, and we even went so far as
> to implement the exact same bug, namely that if the user process
> crashed with its NIP pointing into the kernel we will dump kernel text
> to dmesg. eg:
> 
>    bad-bctr[2996]: segfault (11) at c000000000010000 nip c000000000010000 lr 12d0b0894 code 1
>    bad-bctr[2996]: code: fbe10068 7cbe2b78 7c7f1b78 fb610048 38a10028 38810020 fb810050 7f8802a6
>    bad-bctr[2996]: code: 3860001c f8010080 48242371 60000000 <7c7b1b79> 4082002c e8010080 eb610048
> 
> This was discovered on x86 by Jann Horn and fixed in commit
> 342db04ae712 ("x86/dumpstack: Don't dump kernel memory based on usermode RIP").
> 
> Fix it by checking the adjusted NIP value (pc) and number of
> instructions against USER_DS, and bail if we fail the check, eg:
> 
>    bad-bctr[2969]: segfault (11) at c000000000010000 nip c000000000010000 lr 107930894 code 1
>    bad-bctr[2969]: Bad NIP, not dumping instructions.
> 
> Fixes: 88b0fe175735 ("powerpc: Add show_user_instructions()")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   arch/powerpc/kernel/process.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 913c5725cdb2..bb6ac471a784 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1306,6 +1306,16 @@ void show_user_instructions(struct pt_regs *regs)
>   
>   	pc = regs->nip - (instructions_to_print * 3 / 4 * sizeof(int));
>   
> +	/*
> +	 * Make sure the NIP points at userspace, not kernel text/data or
> +	 * elsewhere.
> +	 */
> +	if (!__access_ok(pc, instructions_to_print * sizeof(int), USER_DS)) {
> +		pr_info("%s[%d]: Bad NIP, not dumping instructions.\n",
> +			current->comm, current->pid);
> +		return;
> +	}
> +

Is there any reason for not using access_ok() here ?

Christophe

>   	pr_info("%s[%d]: code: ", current->comm, current->pid);
>   
>   	for (i = 0; i < instructions_to_print; i++) {
> 
