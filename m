Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F9FC282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 13:26:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA27214DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 13:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="OMC9mDd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA27214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zNhl3x3qzDqP1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 00:26:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="OMC9mDd2"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zNfG4hFTzDqKK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 00:24:05 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43zNf83L7sz9vBGW;
 Tue, 12 Feb 2019 14:24:00 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=OMC9mDd2; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id R6-zuh5ph3Pa; Tue, 12 Feb 2019 14:24:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43zNf82GSdz9vBGV;
 Tue, 12 Feb 2019 14:24:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1549977840; bh=G0jidUg5d6gJlIq+oKUNqVQmqODA+FqVgSEbsJIj7Mc=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=OMC9mDd2V9IQqv0XUY/Gzph638uMO2n2HMxuqVhLfgXzQobMosX8/iet0cyriUXmR
 I4H5fJJLL1Bcj0FKPRsxrIZ1nCddAlCwfJp2G0EhrMIqWEQGxuylzxhIdI0tc1e6ef
 UgxP1yjMgwAppYh8Aj2D7lmJ956NrwPIQMg7Jw+k=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A418B8B7F7;
 Tue, 12 Feb 2019 14:24:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id BodTgny8Iun2; Tue, 12 Feb 2019 14:24:01 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1E2978B7EB;
 Tue, 12 Feb 2019 14:24:01 +0100 (CET)
Subject: Re: [RFC PATCH] powerpc/6xx: Don't set back MSR_RI before reenabling
 MMU
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <9f9dd859d571e324c7412ed9db9da8cfba678257.1548956511.git.christophe.leroy@c-s.fr>
 <87lg2zojbt.fsf@concordia.ellerman.id.au>
 <17b00097-a807-e9b9-3dce-198df4a3153f@c-s.fr>
Message-ID: <b8c1836e-1172-285d-4935-5a4dcced4b3d@c-s.fr>
Date: Tue, 12 Feb 2019 14:24:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <17b00097-a807-e9b9-3dce-198df4a3153f@c-s.fr>
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



Le 01/02/2019 à 12:51, Christophe Leroy a écrit :
> 
> 
> Le 01/02/2019 à 12:10, Michael Ellerman a écrit :
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>
>>> By delaying the setting of MSR_RI, a 1% improvment is optained on
>>> null_syscall selftest on an mpc8321.
>>>
>>> Without this patch:
>>>
>>> root@vgoippro:~# ./null_syscall
>>>     1134.33 ns     378.11 cycles
>>>
>>> With this patch:
>>>
>>> root@vgoippro:~# ./null_syscall
>>>     1121.85 ns     373.95 cycles
>>>
>>> The drawback is that a machine check during that period
>>> would be unrecoverable, but as only main memory is accessed
>>> during that period, it shouldn't be a concern.
>>
>> On 64-bit server CPUs accessing main memory can cause a UE
>> (Uncorrectable Error) which can trigger a machine check.
>>
>> So it may still be a concern, it depends how paranoid you are.
>>
>>> diff --git a/arch/powerpc/kernel/head_32.S 
>>> b/arch/powerpc/kernel/head_32.S
>>> index 146385b1c2da..ea28a6ab56ec 100644
>>> --- a/arch/powerpc/kernel/head_32.S
>>> +++ b/arch/powerpc/kernel/head_32.S
>>> @@ -282,8 +282,6 @@ __secondary_hold_acknowledge:
>>>       stw    r1,GPR1(r11);    \
>>>       stw    r1,0(r11);    \
>>>       tovirt(r1,r11);            /* set new kernel sp */    \
>>> -    li    r10,MSR_KERNEL & ~(MSR_IR|MSR_DR); /* can take exceptions 
>>> */ \
>>> -    MTMSRD(r10);            /* (except for mach check in rtas) */ \
>>>       stw    r0,GPR0(r11);    \
>>>       lis    r10,STACK_FRAME_REGS_MARKER@ha; /* exception frame 
>>> marker */ \
>>>       addi    r10,r10,STACK_FRAME_REGS_MARKER@l; \
>>
>> Where does RI get enabled? I don't see it anywhere obvious.
> 
> MSR_RI is part of MSR_KERNEL, it gets then enabled when reenabling MMU 
> when calling the exception handler.
> 
> #define EXC_XFER_TEMPLATE(n, hdlr, trap, copyee, tfer, ret)    \
>      li    r10,trap;                    \
>      stw    r10,_TRAP(r11);                    \
>      li    r10,MSR_KERNEL;                    \
>      copyee(r10, r9);                    \
>      bl    tfer;                        \
> i##n:                                \
>      .long    hdlr;                        \
>      .long    ret
> 
> where tfer = transfer_to_handler.
> 
> In transfer_to_handler (kernel/entry_32.S) you have:
> 
> transfer_to_handler_cont:
> 3:
>      mflr    r9
>      lwz    r11,0(r9)        /* virtual address of handler */
>      lwz    r9,4(r9)        /* where to go when done */
> [...]
>      mtspr    SPRN_SRR0,r11
>      mtspr    SPRN_SRR1,r10
>      mtlr    r9
>      SYNC
>      RFI                /* jump to handler, enable MMU */
> 
> So MSR_RI is restored above as r10 contains MSR_KERNEL [ | MSR_EE ]
> 

Looks like fast_exception_return, which is called by hash page handlers 
at least, expects MSR_RI to be set. Allthough it works well on 603 
(because it doesn't hash), I would most likely not work on others.

This 1% improvment is not worth it, I give up for now.
