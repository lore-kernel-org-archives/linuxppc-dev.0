Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083DFC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 07:11:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E552084D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 07:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E552084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JC4l0G7mzDqSh
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 18:11:35 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JC2K4YZ8zDqSh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 18:09:29 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43JC2G055jz9v04n;
 Mon, 17 Dec 2018 08:09:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Ubn8Xvl2dJhm; Mon, 17 Dec 2018 08:09:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43JC2F6bgZz9v04m;
 Mon, 17 Dec 2018 08:09:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4400E8B7B5;
 Mon, 17 Dec 2018 08:09:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id PeU9_6U6hM81; Mon, 17 Dec 2018 08:09:26 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 201F88B74B;
 Mon, 17 Dec 2018 08:09:26 +0100 (CET)
Subject: Re: [PATCH v2 2/3] powerpc/lib: Refactor __patch_instruction() to use
 __put_user_asm()
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <20181210070044.27503-1-ruscur@russell.cc>
 <20181210070044.27503-3-ruscur@russell.cc>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <3b213170-9b93-cb71-b0c2-220ea31dbdea@c-s.fr>
Date: Mon, 17 Dec 2018 08:09:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181210070044.27503-3-ruscur@russell.cc>
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
Cc: mikey@neuling.org, kernel-hardening@lists.openwall.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Russel,

Le 10/12/2018 à 08:00, Russell Currey a écrit :
> __patch_instruction() is called in early boot, and uses
> __put_user_size(), which includes the locks and unlocks for KUAP,
> which could either be called too early, or in the Radix case, forced to
> use "early_" versions of functions just to safely handle this one case.

Looking at x86, I see that __put_user_size() doesn't includes the locks. 
The lock/unlock is do by callers. I'll do the same.


> 
> __put_user_asm() does not do this, and thus is safe to use both in early
> boot, and later on since in this case it should only ever be touching
> kernel memory.
> 
> __patch_instruction() was previously refactored to use __put_user_size()
> in order to be able to return -EFAULT, which would allow the kernel to
> patch instructions in userspace, which should never happen.  This has
> the functional change of causing faults on userspace addresses if KUAP
> is turned on, which should never happen in practice.
> 
> A future enhancement could be to double check the patch address is
> definitely allowed to be tampered with by the kernel.

This makes me realise that we are calling lock_user_access() with kernel 
addresses. That most likely breaks protection on kernel addresses for 
book3s/32. I'll have to work around it.

Another thing I realised also is that get_user() at least is called in 
some exceptions/trap handlers. Which means it can be called nested with 
an ongoing user access. It means that get_paca()->user_access_allowed 
might be modified during those exceptions/traps.

Christophe

> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
>   arch/powerpc/lib/code-patching.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index 89502cbccb1b..15e8c6339960 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -26,9 +26,9 @@
>   static int __patch_instruction(unsigned int *exec_addr, unsigned int instr,
>   			       unsigned int *patch_addr)
>   {
> -	int err;
> +	int err = 0;
>   
> -	__put_user_size(instr, patch_addr, 4, err);
> +	__put_user_asm(instr, patch_addr, err, "stw");
>   	if (err)
>   		return err;
>   
> 
