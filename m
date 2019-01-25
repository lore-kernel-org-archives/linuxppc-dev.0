Return-Path: <SRS0=E5N6=QB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36B6C282C0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 11:47:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D079D218CD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 11:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ec/DUj+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D079D218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43mHMZ5GyZzDqNV
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 22:47:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="ec/DUj+H"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43mHKH1y3PzDqLj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 22:45:55 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43mHKB0BQTz9tygW;
 Fri, 25 Jan 2019 12:45:50 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=ec/DUj+H; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id eVsHwvvW6JNX; Fri, 25 Jan 2019 12:45:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43mHK95W5Qz9tygV;
 Fri, 25 Jan 2019 12:45:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548416749; bh=eR/4KzOOPIo3lowRf2ruTlp0c1N+AUhgbZKzK0E6dwI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ec/DUj+HPc11Ja2nqOvz26PQQh5+LFnUtuXHYefJvnDg2fXMhTDIQwsq9P+L5rao1
 3Vl/BM3v+fZ1uFUmea/2rV3ApcbGSeEFXvFEeURiNqcE/Xf/rlRRy5kfcgtvCwqIw2
 xOzRmZ+A0WIp4RwRG76qkIno4Iq91cZzYwMtq+no=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DB24E8B876;
 Fri, 25 Jan 2019 12:45:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 6a3X9gznxxq2; Fri, 25 Jan 2019 12:45:50 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 828EB8B761;
 Fri, 25 Jan 2019 12:45:50 +0100 (CET)
Subject: Re: [PATCH v2 2/3] powerpc/lib: Refactor __patch_instruction() to use
 __put_user_asm()
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <20181210070044.27503-1-ruscur@russell.cc>
 <20181210070044.27503-3-ruscur@russell.cc>
 <3b213170-9b93-cb71-b0c2-220ea31dbdea@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5ff8b24e-a748-19d3-8651-b626dd676ea4@c-s.fr>
Date: Fri, 25 Jan 2019 12:45:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3b213170-9b93-cb71-b0c2-220ea31dbdea@c-s.fr>
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

Le 17/12/2018 à 08:09, Christophe Leroy a écrit :
> Hi Russel,
> 
> Le 10/12/2018 à 08:00, Russell Currey a écrit :
>> __patch_instruction() is called in early boot, and uses
>> __put_user_size(), which includes the locks and unlocks for KUAP,
>> which could either be called too early, or in the Radix case, forced to
>> use "early_" versions of functions just to safely handle this one case.
> 
> Looking at x86, I see that __put_user_size() doesn't includes the locks. 
> The lock/unlock is do by callers. I'll do the same.
> 
> 
>>
>> __put_user_asm() does not do this, and thus is safe to use both in early
>> boot, and later on since in this case it should only ever be touching
>> kernel memory.
>>
>> __patch_instruction() was previously refactored to use __put_user_size()
>> in order to be able to return -EFAULT, which would allow the kernel to
>> patch instructions in userspace, which should never happen.  This has
>> the functional change of causing faults on userspace addresses if KUAP
>> is turned on, which should never happen in practice.
>>
>> A future enhancement could be to double check the patch address is
>> definitely allowed to be tampered with by the kernel.
> 
> This makes me realise that we are calling lock_user_access() with kernel 
> addresses. That most likely breaks protection on kernel addresses for 
> book3s/32. I'll have to work around it.
> 
> Another thing I realised also is that get_user() at least is called in 
> some exceptions/trap handlers. Which means it can be called nested with 
> an ongoing user access. It means that get_paca()->user_access_allowed 
> might be modified during those exceptions/traps.

Any comment about that ? Isn't it a problem ?

Christophe

> 
> Christophe
> 
>>
>> Signed-off-by: Russell Currey <ruscur@russell.cc>
>> ---
>>   arch/powerpc/lib/code-patching.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/lib/code-patching.c 
>> b/arch/powerpc/lib/code-patching.c
>> index 89502cbccb1b..15e8c6339960 100644
>> --- a/arch/powerpc/lib/code-patching.c
>> +++ b/arch/powerpc/lib/code-patching.c
>> @@ -26,9 +26,9 @@
>>   static int __patch_instruction(unsigned int *exec_addr, unsigned int 
>> instr,
>>                      unsigned int *patch_addr)
>>   {
>> -    int err;
>> +    int err = 0;
>> -    __put_user_size(instr, patch_addr, 4, err);
>> +    __put_user_asm(instr, patch_addr, err, "stw");
>>       if (err)
>>           return err;
>>
