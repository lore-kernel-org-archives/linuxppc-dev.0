Return-Path: <SRS0=I4jZ=RL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC8FC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 08:33:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B027420811
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 08:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="f5C7MJcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B027420811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44G13w33r7zDqJt
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 19:33:32 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44G12G6J4vzDqHV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2019 19:32:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="f5C7MJcu"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44G12G2Dj4z8tKg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2019 19:32:06 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44G12G1s7pz9s9T; Fri,  8 Mar 2019 19:32:06 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="f5C7MJcu"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44G12F2fhZz9s4Y
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Mar 2019 19:32:05 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44G1284HbgzB09b7;
 Fri,  8 Mar 2019 09:32:00 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=f5C7MJcu; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id OG5B7FJJdpdh; Fri,  8 Mar 2019 09:32:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44G1283CydzB09b5;
 Fri,  8 Mar 2019 09:32:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552033920; bh=tB+OMrKm1K0NyGKfJ+oFpPhBIgQidEgrAHbr7r+GGMI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=f5C7MJcuCm5hMS7knAbO9DatC6BlwOLL/xYwxCetasy1zcb7ud6q51ydm+chtfgDt
 935BHVHHXVaQf9Xcu4muxLJ1UlRyA01mVIqIvAmj6zPLfNQev5rLqGE0LVxwocYuiK
 c9O2x4Zdo6SCZ48mKoPrTp1I9FRCKfN14Lz5hT2c=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D6608BF85;
 Fri,  8 Mar 2019 09:32:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id oHZr5RBGPHIm; Fri,  8 Mar 2019 09:32:01 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4B7C88BF76;
 Fri,  8 Mar 2019 09:32:01 +0100 (CET)
Subject: Re: [PATCH v5 08/10] powerpc/lib: Refactor __patch_instruction() to
 use __put_user_asm()
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20190308011619.22402-1-mpe@ellerman.id.au>
 <20190308011619.22402-8-mpe@ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1ad2df2a-55de-3016-089a-0a4e23ae7c4a@c-s.fr>
Date: Fri, 8 Mar 2019 09:32:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308011619.22402-8-mpe@ellerman.id.au>
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 08/03/2019 à 02:16, Michael Ellerman a écrit :
> From: Russell Currey <ruscur@russell.cc>
> 
> __patch_instruction() is called in early boot, and uses
> __put_user_size(), which includes the allow/prevent calls to enforce
> KUAP, which could either be called too early, or in the Radix case,
> forced to use "early_" versions of functions just to safely handle
> this one case.
> 
> __put_user_asm() does not do this, and thus is safe to use both in
> early boot, and later on since in this case it should only ever be
> touching kernel memory.
> 
> __patch_instruction() was previously refactored to use
> __put_user_size() in order to be able to return -EFAULT, which would
> allow the kernel to patch instructions in userspace, which should
> never happen. This has the functional change of causing faults on
> userspace addresses if KUAP is turned on, which should never happen in
> practice.

What about modules patching, is there no risk of -EFAULT on module 
memory, as it is in vm area ?

Christophe

> 
> A future enhancement could be to double check the patch address is
> definitely allowed to be tampered with by the kernel.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
> v5: Unchanged.
> 
>   arch/powerpc/lib/code-patching.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index 506413a2c25e..42fdadac6587 100644
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
